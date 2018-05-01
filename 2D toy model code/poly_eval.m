function y = poly_eval(coeff,para)
global combs phi d np

    for i = 1:d+1
        phix(i,:) = phi{i}(para);
    end
    
    m = nchoosek(np+d,np); % number of basis polynomials required
    
    X = ones(1,m);
    for k = 1:np
        c = combs(:,k)+1;
        X = X.*phix(c,k)';
    end
    
    y = X*coeff;

end