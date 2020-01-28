function fvec = get_f_vector(f, k)
    fvec = zeros(1, k);
    for i = 1:k
        fvec(i) = f(((2*i-1)/(2*k)));
    end
end
