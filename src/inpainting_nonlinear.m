%{
function V = inpainting_nonlinear(U, Q, Msk, lam, tol, max_iter, dt)
    if nargin <= 4
        lam = 10;
        tol = 1e-4;
        dt = 0.1;
    end
    
    if nargin <= 3
        max_iter = 1e3;
    end
    
    [~, ~, C] = size(U);
    V = U;
    for cc=1:C
        V(:, :, cc) = inpainting_one(U(:, :, cc), Msk, Q, max_iter, lam, tol, dt);
    end
end
%}

function U2 = inpainting_nonlinear(U, Msk, Q, max_iter, lam, tol, dt)
    U1 = U;
    for iter=1:max_iter
       L = diffusion_nonlinear(U1, Q, dt);
       U2 = L + lam * dt * Msk .* (U - U1);
       dif = norm(U2 - U1) / norm(U1);
       if dif < tol
           break
       end
       U1 = U2;
    end
end

function V = diffusion_nonlinear(U, Q, dt)
    [N, M] = size(U);
    
    tN = U([2:N N], :);
    tS = U([1 1:N-1], :);
    tW = U(:, [2:M M]);
    tE = U(:, [1 1:M-1]);
    
    tQN = Q([2:N N], :);
    tQS = Q([1 1:N-1], :);
    tQW = Q(:, [2:M M]);
    tQE = Q(:, [1 1:M-1]);
    
    L = ((tQN + Q) .* (tN - U) + (tQS + Q) .* (tS - U) ...
       + (tQW + Q) .* (tW - U) + (tQE + Q) .* (tE - U)) / 4;
    V = U + dt * L;
end