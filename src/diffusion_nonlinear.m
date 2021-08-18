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