clear all
close all

%% Define variables
global para_range d combs phi np MClength nr_samples

np = 2; % number of parameters
% Parameter ranges:
para_range = [ -7 -3; % parameter 1
    -3 1]; % parameter 2
d = 10; % degree of polynomial
combs = load('combs10'); % possible combinations

% Legendre polynomials
phi{1} = @(x) ones(size(x));
phi{2} = @(x) x;
for n = 2:d
    phi{n+1} = @(x) 1/(n+1)*((2*n+1)*x.*phi{n}(x) - n*phi{n-1}(x));
end

MClength = 1e5; % length of Markov chain
nr_samples = 1e2; % number of samples to fit polynomial



%% Get polynomial coefficients
disp('Calculating polynomial coefficients...')
if nr_samples < nchoosek(np+d,d) % if undersampling
    path(path, './Optimization'); % add code for compressed sensing from l1-MAGIC (by Emmanuel Cantes)
end
get_coeffs();

%% Sensitivity coefficients
disp('Parameter sensitivities:')
sensitivitycalc();

%% Run Markov Chain Monte Carlo parameter estimation
disp('Running MCMC...')
run_MCMC();
% Plot histograms
para_hists;