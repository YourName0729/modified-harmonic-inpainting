%{
function V = inpainting(U, Msk, diffusion, max_iter, lam, tol, dt)
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
        V(:, :, cc) = inpainting_one(U(:, :, cc), Msk, diffusion, max_iter, lam, tol, dt);
    end
end
%}

function U2 = inpainting_harm(U, Msk, max_iter, lam, tol, dt)
    U1 = U;
    for iter=1:max_iter
       L = diffusion_heat(U1, dt);
       U2 = L + lam * dt * Msk .* (U - U1);
       dif = norm(U2 - U1) / norm(U1);
       if dif < tol
           break
       end
       U1 = U2;
    end
end

function B = diffusion_heat(A, gamma)
    [N, M] = size(A);
    B = zeros(N, M);
    B(1:N-1,:) = B(1:N-1,:) + A(2:N,:) - A(1:N-1,:);
    B(2:N,:) = B(2:N,:) + A(1:N-1,:) - A(2:N,:);
    B(:,1:M-1) = B(:,1:M-1) + A(:,2:M) - A(:,1:M-1);
    B(:,2:M) = B(:,2:M) + A(:,1:M-1) - A(:,2:M);
    B = A + gamma * B;
end