function run_MCMC()

global np MClength coeffs

theta(1,:) = -1+2*rand(1,np); % initial guess for parameters
    
nr_polys = size(coeffs,2);

for i = 1:nr_polys
    y(i) = poly_eval(coeffs(:,i),theta(1,:)'); % evaluate model at initial guess
end
yvec(1,:) = y;

% Experimental data mean and standard deviation
meanD = 0.4*[0.876; 1; 0.92; 0.967; 0.826; 0.605; 0.437; 0.487];
meanD = [meanD; 0.4*[0.15; 0.27; 0.5; 0.76; 1; 1.02; 1.03]];
stdD = 0.05+0.4*[0.02; 0.01; 0.03; 0.037; 0.04; 0.08; 0.06; 0.04];
stdD = [stdD; 0.05+0.4*[0.02; 0.05; 0.07; 0.06; 0.03; 0.01; 0.03]];

chi1 = (meanD-y').^2; % initial sum-of-squares
accept_prob = 0;

a = .05; % step size
for n = 1:MClength
    theta2 = theta(n,:)+a.*randn(1,np); % new parameter candidate
    I = find(theta2 > 1);
    theta2(I) = 1-(theta2(I)-1);
    I = find(theta2 < -1);
    theta2(I) = -1+(-1-theta2(I));
    
    for i = 1:nr_polys
        y(i) = poly_eval(coeffs(:,i),theta2'); % evaluate polynomial at initial guess
    end
    chi2 = (meanD-y').^2; % candidate sum-of-squares
    ratio = min(1,exp((-chi2+chi1)./(2*stdD.^2))); % probability of accepting new candidate
    
    % new iterate of Markov chain:
    if rand(nr_polys,1) < ratio
        theta(n+1,:) = theta2; 
        chi1 = chi2;
        yvec(n+1,:) = y;
        accept_prob = accept_prob + 1/MClength;
    else 
        theta(n+1,:) = theta(n,:); 
        yvec(n+1,:) = yvec(n,:);
    end
    if mod(n,1e4)==0
        disp(['Iteration ', num2str(n)])
        disp(['Acceptance probability = ',num2str(accept_prob)]);
    end
end

disp(['Acceptance probability = ',num2str(accept_prob)]);


% Save to file
fid = fopen('MC','w');
for i = 1:size(theta,1)
    fprintf(fid,'%g\t',theta(i,:));
    fprintf(fid,'\n');
end
fid2 = fopen('MC_dat','w');
for i = 1:size(theta,1)
    fprintf(fid2,'%g\n',yvec(i));
end

end