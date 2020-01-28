function A = get_A_matrix(f, k)
   A = zeros(k);
   for i = 1:k
       A(i, i) = f((2*i-1)/(2*k));
   end
end
