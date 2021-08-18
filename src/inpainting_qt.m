function V = inpainting_qt(U, Msk, step, kap, lam, dt, max_iter, tol)
    if nargin <= 4
        lam = 10;
        dt = 0.1;
        max_iter = 1e3;
        tol = 1e-4;
    end
    
    if nargin <= 3
        kap = 0.1;
    end

    [~, ~, C] = size(U);
    V = U;
    for it = 1:C
        V(:, :, it) = inpainting_qt_one(U(:, :, it), Msk, step, kap, lam, dt, max_iter, tol);
    end
end

function V = inpainting_qt_one(U, Msk, step, kap, lam, dt, max_iter, tol)
    [N, M] = size(U);
    V = inpainting_harm(U, Msk, max_iter, lam, tol, dt);

    tVN = V([2:N N], :);
    tVS = V([1 1:N-1], :);
    tVW = V(:, [2:M M]);
    tVE = V(:, [1 1:M-1]);
    
    vx = (tVN - tVS) / 2;
    vy = (tVW - tVE) / 2;
    
    Q = c(vx .^ 2 + vy .^ 2, kap);
    if step == 1
        Q = inpainting_harm(Q, Msk, max_iter, lam, tol, dt);
    else
        Q = inpainting_qt_one(Q, Msk, step - 1, kap, lam, dt, max_iter, tol);
    end
    
    V = inpainting_nonlinear(U, Msk, Q, max_iter, lam, tol, dt);
end

function y = c(x, kap)
    y = exp(- x / (2 * kap ^ 2));
    %y = 1 ./ (1 + (x / kap) .^ 2);
end