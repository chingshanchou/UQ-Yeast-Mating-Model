%clear all
%close all

global para_range coeffs np d L T

Tvec = [10 30 60 120 210 300 450 600]; % time points
nr_polys = length(Tvec)+length(Lvec);
m = nchoosek(d+np,d);

A = para_range;

error = zeros(1,nr_polys);
y = zeros(1,nr_polys);
y_poly = zeros(1,nr_polys);
for i = 1:100
    r(i,:) = -1+2*rand(np,1); % Generate random sample
    para = (A(:,1)+A(:,2))/2 + (A(:,2)-A(:,1))/2.*r(i,:)'; % map to parameter range
    L = 1000;
    for j = 1:length(Tvec)
        T = Tvec(j);
        y(i,j) = model_eval(para); % evaluate model
        y_poly(i,j) = poly_eval(coeffs(:,j),r(i,:));
    end
    T = 60;
    for j = length(Tvec)+1:nr_polys
        L = Lvec(j-length(Tvec));
        y(i,j) = model_eval(para); % evaluate model
        y_poly(i,j) = poly_eval(coeffs(:,j),r(i,:));
    end
end
error = y-y_poly;
disp([mean(error)',std(error)'])
error = error(abs(error)<10);
meanvec(k) = mean(error);
stdvec(k) = std(error);
sampvec(k) = nr_samples;

sampvec = sampvec(2:end);
meanvec = meanvec(2:end);
stdvec = stdvec(2:end);
time = time(2:end);

subplot(2,1,1)
errorbar(sampvec,meanvec,stdvec,'k','Linewidth',2)
xlabel('Number of samples')
xlim([30 220])
ylabel('Polynomial error')
title('5th order polynomial errors')
set(gca,'fontsize',14)

subplot(2,1,2)
plot(sampvec,time,'kx','Linewidth',2)
xlabel('Number of samples')
xlim([30 220])
ylabel('CPU time (s)')
title('Cost to compute polynomials')
set(gca,'fontsize',14)

format shortg
disp([sampvec' time'])
