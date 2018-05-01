function y = modeld5(x)

    global combs coeff
    
    % Legendre polynomials
    phi{1} = @(x) ones(size(x));
    phi{2} = @(x) x;
    phi{3} = @(x) (1/2)*(3*x.^2-1);
    phi{4} = @(x) (1/2)*(5*x.^3-3*x);
    phi{5} = @(x) (1/8)*(35*x.^4 - 30*x.^2 + 3);
    phi{6} = @(x) (1/8)*(63*x.^5 - 70*x.^3 + 15*x);

    % Determine all combinations of degree up to 5
    d = 5;
    m = nchoosek(35+d,35);
    
    for i = 1:6
        phix(i,:) = phi{i}(x);
    end

    % Build matrix
%     X = zeros(1,m);
%     for j = 1:m
%         c = combs(j,:)+1;
%         X(j) = 1;
%         for k = 1:35
%             X(j) = X(j)*phix(c(k),k);
%         end
%     end
%     
    X = ones(1,m);
    for k = 1:35
        c = combs(:,k)+1;
        X = X.*phix(c,k)';
    end
    y = X*coeff;
    
end