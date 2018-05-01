function [coeff] = poly_build(nr_samples)
    % model is a function handle that evaluates the model output
    % para_range = [min(p1) max(p1); min(p2) max(p2); ...]
    % coeff is a vector of the coefficients for the polynomial fit, using a
    %       Legendre basis

    global para_range d combs phi np

    A = para_range;
    m = nchoosek(np+d,np); % number of basis polynomials required
    
    % Sample data
    for i = 1:nr_samples
        r(i,:) = -1+2*rand(np,1); % Generate random sample
        para = (A(:,1)+A(:,2))/2 + (A(:,2)-A(:,1))/2.*r(i,:)'; % map to parameter range
        y(i) = model_eval(para); % evaluate model
    end
    y = y';
    
    % Build matrix
    X = zeros(nr_samples,m);
    for j = 1:m
        c = combs(j,:)+1;
        X(:,j) = 1;
        for k = 1:np
            X(:,j) = X(:,j).*phi{c(k)}(r(:,k));
        end
    end
    
    if nr_samples >= m
        % Solve least squares problem for polynomial coefficients
        coeff = (X'*X)\(X'*y); 
    else
        % Solve for coefficients via l1 minimization using l1-MAGIC 
        x0 = zeros(m,1); % initial guess
        epsilon = 5*1e-2; % error bound

        Afun = @(z) X*z;
        Atfun = @(z) X'*z;
        coeff = l1qc_logbarrier(x0, Afun, Atfun, y, epsilon, 1e-3, 50, 1e-8, 500);
    end
    
end