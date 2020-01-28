function [J, K] = get_j_k_pairs(n)
    J = zeros(1, n); K = zeros(1, n); broken_flag=false;
    for j = 0: floor(log2(n))
        for k = 0: 2^j - 1
           idx = 2^j + k;
           if idx == n + 1
               broken_flag=true;
               break
           end
           J(idx) = j;
           K(idx) = k;
        end
        if broken_flag==true
            break
        end
    end
end