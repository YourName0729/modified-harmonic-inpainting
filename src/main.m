s = 'cover';
s_noise = strcat('../assets/', s, '_noise.png');
s_mask = strcat('../assets/', s, '_mask.png');
s_org = strcat('../assets/', s, '.png');

s_harm = strcat('../assets/', s, '_harm.png');
s_q = strcat('../assets/', s, '_q9.png');
s_rev = strcat('../assets/', s, '_rev.png');
s_recon = strcat('../assets/', s, '_recon.png');

W = ya_imread(s_org);
U = ya_imread(s_noise);
Msk = ya_imread(s_mask);
Msk = Msk(:, :, 1);

clf

x = 0.01:0.01:0.1;  
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

for it=1:length(x)
    y(it) = psnr(W, inpainting_qt(U, Msk, 4, x(it)));
end
plot(x, y)
hold on

%for it = 1:length(x)
%    y(it) = psnr(W, inpainting_qt(U, Msk, 9, x(it)));
%end
%plot(x, y)
%hold on

legend('step=1', 'step=2', 'step=3', 'step=4')
%title('c=1/(1+(x/\lambda)^2)')
title('c=e^{(-x^2/(2\lambda^2))}')
xlabel('\lambda')
ylabel('PSNR')

%subplot(2, 2, 1)
%imshow(V)
%subplot(2, 2, 2)
%imshow(VA)
%subplot(2, 2, 3)
%imshow(VB)
%subplot(2, 2, 4)
%imshow(VC)

%imwrite(V, s_harm)
imwrite(V2, s_q)
%imwrite(VB, s_rev)
%imwrite(VC, s_recon)