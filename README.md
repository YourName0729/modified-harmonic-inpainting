# modified-harmonic-inpainting

[TOC]

## Image Inpainting

## Harmonic Inpainting
Let $\Omega$ be the domain of the image, $D$ be the part to inpaint, *harmonic inpainting* follows the differential equation,

$$
\begin{cases}
\Delta u=0&\mbox{in}&D,\\
u=g&\mbox{in}&\Omega\setminus D,
\end{cases}
$$

If we add parameter $t$ into account $du/dt=\Delta u$, then it is *heat diffusion equation* taking $t\to\infty$. Thus we have iterative way to find the solution.

That is, define $u_0=g$ and iteratively compute

$$
u_{n+1}=u_n+\Delta t(\Delta u_n + \lambda(g-u_n))
$$

until some tolerence condition, i.e. $\lVert u_{n+1}-u_n\lVert<\epsilon$.

## Modified Harmonic Inpainting

Observing that the loss of steep slope is the most significant disadvantage, the first modification is

$$
\begin{cases}
\nabla\cdot(q\nabla u)=0&\mbox{in}&D,\\
u=g&\mbox{in}&\Omega\setminus D,
\end{cases}
$$

for some $q:\Omega\to(0,1]$. That is, the *diffusion coefficient* varies from place to place, satisfying

- if we want to preserve steep slope, we require lower $q$
- otherwise, $q$ can be higher

This modeling is called *Perona–Malik Diffusion*, and a common way to define $q$ is by
$$
q(x,y)=\exp\left(-\frac{|\nabla u(x,y)|^2}{2\kappa^2}\right)
$$

The value of $q$ in $\Omega\setminus D$ can be computed directly, but it is still unknown in $D$, which is another inpainting problem. Thus, we can solve $q$ by harmonic inainting first, and then solve $u$ by Perona–Malik diffusion.

If we also solve $q$ by Perona–Malik diffusion, we can further find the multi-level scheme. That is, specify how many layers do we want to solve by Perona–Malik diffusion.

### Full Scheme

Define $u^{(0)}=g$ and compute

$$
u^{(n+1)}=\exp\left(-\frac{|\nabla u^{(n)}(x,y)|^2}{2\kappa^2}\right),\quad n+1\leq N
$$

After that, we solve $u^{(N)}$ by harmonic inpainting, then we solve $u^{(n)}$ by $\nabla\cdot(u^{(n+1)}\nabla u^{(n)})=0$ for $n\geq 0$.

## Peak-Signal-To-Noise Ratio

The *peak-signal-to-noise ratio(PSNR)* between the original image $I$ and the inpainted image $J$ is

$$
PSNR(I, J)=10\log_{10}\left(\frac{1}{\lVert I-J\lVert^2}\right)
$$

which is larger, better.

## Results



| Original | Damaged | Harmonic | Modified |
|:--------:|:--------:|:--------:|:--------:|
| ![](https://i.imgur.com/C6EXLCv.png) | ![](https://i.imgur.com/JSgyfOf.png) | ![](https://i.imgur.com/zHcVvkP.png) | ![](https://i.imgur.com/PchCkTX.png)

![](https://i.imgur.com/chT3wm5.png)


| Original | Damaged | Harmonic | Modified |
|:--------:|:--------:|:--------:|:--------:|
| ![](https://i.imgur.com/PYruuYa.png) | ![](https://i.imgur.com/hokuNRE.png) | ![](https://i.imgur.com/S4LaEYI.png) | ![](https://i.imgur.com/aetNkkb.png)

![](https://i.imgur.com/PElynHj.png)