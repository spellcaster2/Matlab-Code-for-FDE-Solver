function [H, X] = get_h_column(i, k)

    f=@(x,j,k) ((x<((0.5+k)/2^j))&&(x>=(k/2^j)))-(x<((1+k)/2^j)&&(x>=((0.5+k)/2^j)));
    [J, K] = get_j_k_pairs(k-1);
    H = zeros(k, 1);
    H(1) = 1;  % h0(t) = 1
    X=(2*i-1)/(2*k);
    for p = 1: k-1
        H(p+1) = 2^(J(p)/2) * f(X, J(p), K(p)); 
    end
    
end