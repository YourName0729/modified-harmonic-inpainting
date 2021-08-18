function v = psnr(U, V)
    [N, M, C] = size(U);

    MSE = sum(sum(sum(((U - V) .^ 2)))) / (C * N * M) + 1e-10;
    v = 10 * log10(1 / MSE);
end