% 格子玻尔兹曼方法 D2Q9 顶盖驱动方腔流动 Hou1995 复现
% 修正点:
%   1) 静止壁反弹改为正确的本地 fullway bounce-back，且只设未知方向
%   2) 顶盖 feq 使用迁移后重算的 rho
%   3) streamline 不再转置 u, v
clear; clc; close all;

%% 1. 初始参数设置
Nx = 256;
Ny = 256;
U0 = 0.1;
Re = 1000;
nu  = (U0 * Nx) / Re;
tau = (6*nu + 1)/2;
rho0 = 1.0;

% D2Q9 方向编号
% 1静止 2右 3上 4左 5下 6右上 7左上 8左下 9右下
cx = [0,  1, 0, -1, 0,  1, -1, -1, 1];
cy = [0,  0, 1,  0,-1,  1,  1, -1,-1];
w  = [4/9, 1/9, 1/9, 1/9, 1/9, 1/36, 1/36, 1/36, 1/36];

%% 2. 场变量初始化
rho = ones(Ny, Nx) * rho0;
u   = zeros(Ny, Nx);
v   = zeros(Ny, Nx);
f   = zeros(Ny, Nx, 9);
feq = zeros(Ny, Nx, 9);

% 顶部节点初始 u = U0
u(Ny, :) = U0;

% 初始分布以平衡态填充
for k = 1:9
    eu = cx(k)*u + cy(k)*v;
    f(:,:,k) = w(k) .* rho .* (1 + 3*eu + 4.5*eu.^2 - 1.5*(u.^2 + v.^2));
end

%% 3. 收敛控制
maxStep   = 100000;
conv_tol  = 1e-6;
checkStep = 1000;
psi_old   = 0;
converged = false;

%% 4. 主迭代循环
for step = 1:maxStep
    % ===== 1. 宏观量 =====
    rho = sum(f, 3);
    u = (f(:,:,2)-f(:,:,4)+f(:,:,6)-f(:,:,7)-f(:,:,8)+f(:,:,9))./rho;
    v = (f(:,:,3)-f(:,:,5)+f(:,:,6)+f(:,:,7)-f(:,:,8)-f(:,:,9))./rho;

    % 顶盖速度强制赋为 (U0, 0)
    u(Ny,:) = U0;
    v(Ny,:) = 0;

    % ===== 2. 碰撞 =====
    for k = 1:9
        eu = cx(k)*u + cy(k)*v;
        feq(:,:,k) = w(k) .* rho .* (1 + 3*eu + 4.5*eu.^2 - 1.5*(u.^2 + v.^2));
    end
    f = f - (f - feq)/tau;

    % ===== 3. 迁移 (streaming) =====
    fn = f;
    fn(:, 2:Nx,        2) = f(:, 1:Nx-1,      2);   % 右
    fn(:, 1:Nx-1,      4) = f(:, 2:Nx,        4);   % 左
    fn(2:Ny, :,        3) = f(1:Ny-1, :,      3);   % 上
    fn(1:Ny-1, :,      5) = f(2:Ny, :,        5);   % 下
    fn(2:Ny, 2:Nx,     6) = f(1:Ny-1, 1:Nx-1, 6);   % 右上
    fn(1:Ny-1, 1:Nx-1, 8) = f(2:Ny, 2:Nx,     8);   % 左下
    fn(2:Ny, 1:Nx-1,   7) = f(1:Ny-1, 2:Nx,   7);   % 左上
    fn(1:Ny-1, 2:Nx,   9) = f(2:Ny, 1:Nx-1,   9);   % 右下
    f = fn;

    % ===== 4. 边界条件 =====
    % 4a) 三个静止壁: fullway bounce-back, 只对真正未知的方向赋值
    % 下壁 y=1，未知方向: 3 (上), 6 (右上), 7 (左上)
    f(1,:,3) = f(1,:,5);
    f(1,:,6) = f(1,:,8);
    f(1,:,7) = f(1,:,9);

    % 左壁 x=1，未知方向: 2 (右), 6 (右上), 9 (右下)
    f(:,1,2) = f(:,1,4);
    f(:,1,6) = f(:,1,8);
    f(:,1,9) = f(:,1,7);

    % 右壁 x=Nx，未知方向: 4 (左), 7 (左上), 8 (左下)
    f(:,Nx,4) = f(:,Nx,2);
    f(:,Nx,7) = f(:,Nx,9);
    f(:,Nx,8) = f(:,Nx,6);

    % 4b) 顶盖: 用迁移后的相邻行密度计算 feq, 全方向覆盖
    rho_top = sum(f(Ny-1,:,:), 3);   % 1xNx, 取相邻流体行密度
    for k = 1:9
        eu = cx(k)*U0 + cy(k)*0;
        f(Ny,:,k) = w(k) .* rho_top .* (1 + 3*eu + 4.5*eu.^2 - 1.5*U0^2);
    end

    % ===== 5. 收敛监测 =====
    if mod(step, checkStep) == 0
        rho = sum(f, 3);
        u = (f(:,:,2)-f(:,:,4)+f(:,:,6)-f(:,:,7)-f(:,:,8)+f(:,:,9))./rho;
        v = (f(:,:,3)-f(:,:,5)+f(:,:,6)+f(:,:,7)-f(:,:,8)-f(:,:,9))./rho;

        psi = compute_streamfunction(u, v, Ny, Nx);
        psi_new = max(abs(psi(:)));
        err = abs(psi_new - psi_old);
        fprintf('迭代: %6d | |psi|max = %.5e | 误差: %.2e\n', step, psi_new, err);

        if err < conv_tol && step > 5*checkStep
            converged = true;
            break;
        end
        psi_old = psi_new;
    end
end

%% 5. 最终宏观量
rho = sum(f, 3);
u = (f(:,:,2)-f(:,:,4)+f(:,:,6)-f(:,:,7)-f(:,:,8)+f(:,:,9))./rho;
v = (f(:,:,3)-f(:,:,5)+f(:,:,6)+f(:,:,7)-f(:,:,8)-f(:,:,9))./rho;

if converged
    fprintf('已收敛！\n');
else
    fprintf('达到最大迭代步数，未严格收敛。\n');
end

%% 6. 后处理可视化
figure('Color','w');
subplot(2,2,1);
contourf(u, 50, 'LineColor','none'); colormap(jet); colorbar;
title('U 速度场'); axis equal tight;

subplot(2,2,2);
contourf(v, 50, 'LineColor','none'); colormap(jet); colorbar;
title('V 速度场'); axis equal tight;

subplot(2,2,[3,4]);
[X, Y] = meshgrid(1:Nx, 1:Ny);
sx = linspace(2, Nx-1, 25);
sy = linspace(2, Ny-1, 25);
[SX, SY] = meshgrid(sx, sy);
streamline(X, Y, u, v, SX, SY);
axis equal tight;
title('方腔流线');

%% 7. 与 Ghia/Hou 中线速度对比 (可选)
figure('Color','w');
subplot(1,2,1);
yy = (0:Ny-1)/(Ny-1);
plot(u(:, round(Nx/2))/U0, yy, 'b-', 'LineWidth', 1.5); grid on;
xlabel('u/U_0'); ylabel('y/L'); title('竖直中线 u 分布');

subplot(1,2,2);
xx = (0:Nx-1)/(Nx-1);
plot(xx, v(round(Ny/2), :)/U0, 'r-', 'LineWidth', 1.5); grid on;
xlabel('x/L'); ylabel('v/U_0'); title('水平中线 v 分布');

%% --- 流函数计算 (辅助函数) ---
function psi = compute_streamfunction(u, v, Ny, Nx)
    % psi 满足 u = d psi/dy, v = -d psi/dx
    psi = zeros(Ny, Nx);
    % 沿 y 积分 u 得到第一列
    for i = 2:Ny
        psi(i, 1) = psi(i-1, 1) + 0.5*(u(i, 1) + u(i-1, 1));
    end
    % 沿 x 积分 -v
    for j = 2:Nx
        psi(:, j) = psi(:, j-1) - 0.5*(v(:, j) + v(:, j-1));
    end
end
