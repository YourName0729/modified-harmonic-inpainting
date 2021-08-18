function V = inpainting_qt(U, Msk, step, kap)
    [~, ~, C] = size(U);
    V = U;
    for it = 1:C
        V(:, :, it) = inpainting_qt_one(U(:, :, it), Msk, step, kap);
    end
end

function V = inpainting_qt_one(U, Msk, step, kap)
    lam = 10;
    tol = 1e-4;
    dt = 0.1;
    max_iter = 1e3;
    
    [N, M] = size(U);
    V = inpainting(U, Msk, @diffusion_heat);

    tVN = V([2:N N], :);
    tVS = V([1 1:N-1], :);
    tVW = V(:, [2:M M]);
    tVE = V(:, [1 1:M-1]);
    
    vx = (tVN - tVS) / 2;
    vy = (tVW - tVE) / 2;
    
    Q = c(vx .^ 2 + vy .^ 2, kap);
    if step == 1
        Q = inpainting(Q, Msk, @diffusion_heat);
    else
        Q = inpainting_qt(Q, Msk, step - 1, kap);
    end
    
    V = inpainting_nonlinear(U, Q, Msk, lam, tol, max_iter, dt);
end

function y = c(x, kap)
    y = exp(- x .^ 2 / (2 * kap ^ 2));
    %y = 1 ./ (1 + (x / kap) .^ 2);
end