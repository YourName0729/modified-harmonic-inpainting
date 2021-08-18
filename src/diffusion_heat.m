function B = diffusion_heat(A, gamma)
    [N, M] = size(A);
    B = zeros(N, M);
    B(1:N-1,:) = B(1:N-1,:) + A(2:N,:) - A(1:N-1,:);
    B(2:N,:) = B(2:N,:) + A(1:N-1,:) - A(2:N,:);
    B(:,1:M-1) = B(:,1:M-1) + A(:,2:M) - A(:,1:M-1);
    B(:,2:M) = B(:,2:M) + A(:,1:M-1) - A(:,2:M);
    B = A + gamma * B;
end