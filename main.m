% % Example 1
% alpha = 1/3; k = 32;
% a = @(x) x^(1/3);
% f = @(x) (3/(2*gamma(2/3)))*x^(2/3) + x^(4/3);

% Example 2
alpha = 1/4; k = 32;
a = @(x) 1;
f = @(x) x^4 - (1/2)*x^3 - 3/gamma(4-alpha) * x^(3-alpha) + 24/gamma(5-alpha) * x^(4-alpha);

A = get_A_matrix(a, k);  
ff = get_f_vector(f, k);
H = get_H_matrix(k);
F = get_F_matrix(alpha, k);
P = (H*F)/H;

C = ff/(P*H*A + H);

Y = zeros(1, k); X = zeros(1, k);
for i = 1: k
    [h, x] = get_h_column(i, k);
    y = C*P*h;
    X(i) = x;
    Y(i) = y;
end
% stem(X, Y); hold on;

% q = 0: .005: 1;
% plot(q, interp1(X, Y, q));
pr = 1000;

q = 0: 1/(k*pr): 1-1/(k*pr);
wave = zeros(1, k*pr);
for i = 1: k
    for j = 1: pr
       wave(pr*(i-1)+j) = Y(i);
    end
end
plot(q, wave, '-r');

hold on;

% % Example 1: Exact solution
% xx = 0:.05:1;
% yy = xx;
% plot(xx, yy);

% Example 2: Exact solution
xx = 0:.05:1;
yy = xx.^4 - 1/2 * xx.^3;
plot(xx, yy, '-b');


