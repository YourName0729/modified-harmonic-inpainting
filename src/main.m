s = 'sea';
s_noise = strcat('../assets/', s, '_noise.png');
s_mask = strcat('../assets/', s, '_mask.png');
s_org = strcat('../assets/', s, '.png');

s_qt = strcat('../assets/', s, '_qt.png');
s_harm = strcat('../assets/', s, '_harm.png');

W = ya_imread(s_org);
U = ya_imread(s_noise);
Msk = ya_imread(s_mask);
Msk = Msk(:, :, 1);

clf

%{
x = [0.02 0.03 0.035 0.04 0.045 0.05 0.1 0.2];  
y = x;

for it=1:length(x)
    y(it) = psnr(W, inpainting_qt(U, Msk, 1, x(it)));
end
plot(x, y)
hold on

for it=1:length(x)
    y(it) = psnr(W, inpainting_qt(U, Msk, 2, x(it)));
end
plot(x, y)
hold on

for it=1:length(x)
    y(it) = psnr(W, inpainting_qt(U, Msk, 3, x(it)));
end
plot(x, y)
hold on

disp('123')

for it=1:length(x)
    y(it) = psnr(W, inpainting_qt(U, Msk, 4, x(it)));
end
plot(x, y)
hold on

disp('456')

for it=1:length(x)
    y(it) = psnr(W, inpainting_qt(U, Msk, 5, x(it)));
end
plot(x, y)
hold on

disp('789')

for it=1:length(x)
    y(it) = psnr(W, inpainting_qt(U, Msk, 6, x(it)));
end
plot(x, y)
hold on

%for it = 1:length(x)
%    y(it) = psnr(W, inpainting_qt(U, Msk, 9, x(it)));
%end
%plot(x, y)
%hold on

legend('N=1', 'N=2', 'N=3', 'N=4', 'N=5', 'N=6')
%title('c=1/(1+(x/\lambda)^2)')
title('c=e^{(-|\nabla u|^2/(2\kappa^2))}')
xlabel('\kappa')
ylabel('PSNR')
%}