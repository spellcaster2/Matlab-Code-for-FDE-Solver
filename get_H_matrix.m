function H = get_H_matrix(k)
    H = [];
    f = @(x,j,k) ( (x < ((0.5 + k)/2^j)) && (x >= (k/2^j)) ) - (x < ((1+k)/2^j) && (x>=((0.5+k)/2^j)));
    [J, K] = get_j_k_pairs(k-1);
    for i = 1: k
        h=ones(k, 1);
        for p = 1: k-1
            h(p+1) = (2^(J(p)/2))*f(((2*i-1)/(2*(k))),J(p),K(p));
        end
        H = [H, h];
    end
end
