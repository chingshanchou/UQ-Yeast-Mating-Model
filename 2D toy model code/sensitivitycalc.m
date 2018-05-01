function sensitivitycalc()

global np d phi combs coeffs

M = nchoosek(d+np,d);

% Integration of 1D basis polynomials
for i = 1:d+1
    phiint(i) = integral(phi{i},-1,1,'Arrayvalued',1);
    %phidiffint(i)= integral(phidiff{i},-1,1,'Arrayvalued',1);
    phidiffint(i) = phi{i}(1)-phi{i}(-1);
end

for k = 1:size(coeffs,2)
    % Load data
    coeff = coeffs(:,k); % polynomial coefficients

    % Calculate integrals of partial derivatives of basis polynomials
    % ints(i,m) is the integral of the ith partial derivative of the mth basis
    %   function
    for m = 1:M
        c = combs(m,:)+1;
        for i = 1:np
            ints(i,m) = 1; 
            for j = 1:np
                if (i==j)
                    ints(i,m) = ints(i,m)*(1/2)*phidiffint(c(j));
                else
                    ints(i,m) = ints(i,m)*(1/2)*phiint(c(j));
                end
            end
        end
    end

    % Calculate sensitivity coefficients
    S = zeros(np,1);
    for m = 1:M
        S = S + coeff(m)*ints(:,m);
    end

    % Display sensitivity coefficients
    [Y,I] = sort(abs(S));
    names = ['k_Ga      '
    'k_Gd      '];
    disp(k)
    disp([names(I,:) num2str(S(I))])
    Sens(k,:) = S';
end

end
    