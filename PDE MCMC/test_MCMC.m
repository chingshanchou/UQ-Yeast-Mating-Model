clear all
close all
global combs coeff

combs = load('combs');
coeff = load('coeff_d5_eps5e-2_npts9000');

p = 35; % number of parameters
theta(1,:) = -1+2*rand(1,p); % initial guess for parameters
%theta(1,:) = zeros(1,p); % initial guess for parameters

tic
y = modeld5(theta(1,:)'); % evaluate model at initial guess
yvec(1) = y;
D = load('PF_C42a_dat'); % load experimental data
D = mean(D)+std(D)*randn(1e3,1);
sig = sqrt(sum((D-mean(D)).^2));
total = 1e5; % length of Markov chain
chi1 = sum((D-y).^2); % initial sum-of-squares
accept_prob = 0;

a = .1; % step size
for n = 1:total
    theta2 = theta(n,:)+a.*randn(1,p); % new parameter candidate
    I = find(theta2 > 1);
    theta2(I) = 1-(theta2(I)-1);
    I = find(theta2 < -1);
    theta2(I) = -1+(-1-theta2(I));
    y = modeld5(theta2'); % evaluate model at candidate
    y = y + 0.15*randn;
    chi2 = sum((D-y).^2); % candidate sum-of-squares
    ratio = min(1,exp((-chi2+chi1)/(2*sig^2))); % probability of accepting new candidate
    
    % new iterate of Markov chain:
    if rand < ratio
        theta(n+1,:) = theta2; 
        chi1 = chi2;
        yvec(n+1) = y;
        accept_prob = accept_prob + 1/total;
    else 
        theta(n+1,:) = theta(n,:); 
        yvec(n+1) = yvec(n);
    end
    if mod(n,1e4)==0
        disp(n)
    end
end
toc

disp(['Acceptance probability = ',num2str(accept_prob)]);

%% Plots

names = ['k_{RL}    '
'k_{RLm}   '
'k_{Rd0}   '
'k_{Rs}    '
'k_{Rd1}   '
'k_{Ga}    '
'k_{G1}    '
'k_{Gd}    '
'k_{24cm0} '
'k_{24cm1} '
'k_{24mc}  '
'k_{24d}   '
'k_{42a}   '
'k_{42d}   '
'k_{B1cm}  '
'k_{B1mc}  '
'k_{Cla4a} '
'k_{Cla4d} '
'C24_t     '
'B1_t      '
'C42_t     '
'G_t       '
'R_t       '
'Gbgnq (q) '
'hpower (h)'
'D_R       '
'D_{RL}    '
'D_G       '
'D_{Ga}    '
'D_{Gbg}   '
'D_{Gd}    '
'D_{c24m}  '
'D_{c42}   '
'D_{c42a}  '
'D_{B1m}   '];


figure(1)
% Plot Markov chains
for i = 1:35
    subplot(7,5,i)
    plot([0:total],theta(:,i))
    xlim([0 total])
    ylim([-1 1])
    title(names(i,:))
end

figure(2)
burn = round(0.2*total); % burn-in, number of iterates to throw away
% Histograms 
for i = 1:35
    subplot(7,5,i)
    histogram(theta(burn:end,i),20,'Normalization','pdf')
    %xlim([-1 1]);
    title(names(i,:))
end

figure(3)
histogram(D,'BinWidth',0.01,'Normalization','pdf');
hold on
histogram(yvec(burn:end),'BinWidth',0.01,'Normalization','pdf');
hold off

% figure(4)
% n = hist3(theta,[20 20]); % default is to 10x10 bins
% n1 = n';
% n1(size(n,1) + 1, size(n,2) + 1) = 0;
% xb = linspace(min(theta(:,1)),max(theta(:,1)),size(n,1)+1);
% yb = linspace(min(theta(:,2)),max(theta(:,2)),size(n,1)+1);
% h = pcolor(xb,yb,n1);
% h.ZData = ones(size(n1)) * -max(max(n));
%colormap(gray) % heat map

fid = fopen('Markov_chain_1e5_err','w');
for i = 1:size(theta,1)
    fprintf(fid,'%g\t',theta(i,:));
    fprintf(fid,'\n');
end
fid2 = fopen('data_MC_1e5_err','w');
for i = 1:size(theta,1)
    fprintf(fid2,'%g\n',yvec(i));
end