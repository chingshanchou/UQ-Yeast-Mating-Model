function get_coeffs()
global L T coeffs nr_samples

Tvec = [10 30 60 120 210 300 450 600]; % time points for time course data
Lvec = [1 2 5 10 20 50 100]; % alpha-factor concentrations for dose-response data

% Build polynomials for time-course 
L = 1000;
for j = 1:length(Tvec)
    T = Tvec(j);
    coeff = poly_build(nr_samples); % compute polynomial coefficients
    
    % save coefficients to file 
    filename = ['coeff',num2str(Tvec(j))];
    fid = fopen(filename,'w');
    fprintf(fid,'%g\n', coeff);
    fclose(fid)
    coeffs(:,j) = coeff;
end

% Build polynomials for dose-response
T = 60;
for j = 1:length(Lvec)
    L = Lvec(j);
    coeff = poly_build(nr_samples); % compute polynomial coefficients
    
    % save coefficients to file 
    filename = ['coeff',num2str(Lvec(j)),'_L'];
    fid = fopen(filename,'w');
    fprintf(fid,'%g\n', coeff);
    fclose(fid)
    coeffs(:,length(Tvec)+j) = coeff;
end

end