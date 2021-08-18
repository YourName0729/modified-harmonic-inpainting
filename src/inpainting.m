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

function U2 = inpainting_one(U, Msk, diffusion, max_iter, ~, tol, dt)
    U1 = U;
    for iter=1:max_iter
       L = diffusion(U1, dt);
       U2 = L + Msk .* (U - U1);
       dif = norm(U2 - U1) / norm(U1);
       if dif < tol
           %fprintf('break %d\n', iter);
           break
       end
       U1 = U2;
    end
end