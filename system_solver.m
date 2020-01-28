% Example 3 from the paper
alpha=1; k=2;
f1=@(x,u1,u2,u3) 2*u2^2;
f2=@(x,u1,u2,u3) x*u1;
f3=@(x,u1,u2,u3) u2*u3;

% alpha=1.3; k=2;
% f1=@(x,u1,u2,u3) u1*u2^2;
% f2=@(x,u1,u2,u3) u1*5*u2;

A=sym('a',[1 k]);
B=sym('b',[1 k]);
C=sym('c',[1 k]);

P = get_P_matrix(alpha, k);

LHS = sym('x', [3*k 1]); % Initialise 3k x 1 sym

for i = 1 : k
    LHS(i)     = A * get_h_column(i,k);
    LHS(2 + i) = B * get_h_column(i,k) + 1;
    LHS(4 + i) = C * get_h_column(i,k) + 1;
end

RHS = sym('x', [3*k 1]); % Initialise RHS as vector of symbols

for i=1:k
    JB = A * P *get_h_column(i,k);
    JC = B * P *get_h_column(i,k);
    JD = C * P *get_h_column(i,k);

    RHS(i) = f1((2*i-1)/(2*k),JB,JC,JD);
    RHS(2+i) = f2((2*i-1)/(2*k),JB,JC,JD);
    RHS(4+i) = f3((2*i-1)/(2*k),JB,JC,JD);
end

Eqn = sym('x', [1 6]); % pre-allocation for speed, value overwritten in loop
for i = 1: 3*k
    Eqn(i) = LHS(i)==RHS(i);
end

Var = [A,B,C];

% [a1,a2,a3,a4, b1,b2,b3,b4, c1,c2,c3,c4] = solve(EQN, VAR);  % for k = 4
S = solve(Eqn, Var);
[wl,x] = wpfun('db1',k);
PK = wl(1,:)*S.a1(1) +  wl(2,:)*S.a2(1); % + wl(3,:)*S.a3(1) + wl(4,:)*S.a4(0);
plot(x, PK);

figure;
[wl,x] = wpfun('db1',k);
PK2 = wl(1,:)*S.b1(1) +  wl(2,:)*S.b2(1); % + wl(3,:)*S.a3(1) + wl(4,:)*S.a4(0);
plot(x, PK2);

figure;
[wl,x] = wpfun('db1',k);
PK3 = wl(1,:)*S.c1(1) +  wl(2,:)*S.c2(1); % + wl(3,:)*S.a3(1) + wl(4,:)*S.a4(0);
plot(x, PK3);
