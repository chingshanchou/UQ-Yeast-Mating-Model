dat = csvread('norm_cell_input_101217.csv');
dat_old = csvread('norm_cell_input_032317.csv');
C42a_meandat = load('C42a_mean_updated');
C42a_SAdat = load('C42a_SA_updated');
x = linspace(1,400,361);
% figure(1)
% hold on
% for i = 1:size(dat,1)
%     plot(x,dat(i,:))
% end
% plot(C42a_meandat,'k','Linewidth',2)
% set(gca,'fontsize',14)
% ylabel('C42a')
% hold off

figure(2)
hold on
    plot(x,mean(dat)/5)
%    plot(x,mean(dat_old))
plot(C42a_meandat,'k','Linewidth',2)
plot(C42a_SAdat,'--k','Linewidth',2)
set(gca,'fontsize',16)
ylabel('C42a')
%ylim([0 500])
legend('data','MCMC','SA')
set(gca,'XTick',[0,100,200,300,400])
set(gca,'XTickLabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
xlabel('Angle from front of cell')
hold off


N = size(dat,1);
n = 360;
SA = 50.27;
for k = 1:N
    %c42t = para(k,21);
    m = 0;
    A = dat(k,:);
    C42t = sum(A);
    amt = A(n/2);
    Sp = 0;
    while (amt < C42t/2)
        m = m + 1;
        amt = sum(A(n/2-m:n/2+m));
    end
    PF(k) = 1 - 2*((2*m+1)/n);
    
%     C42av = c42t/SA;
%     [Cmax,I] = max(A);
%     x = Cmax;
%     a = 2*(1/C42av);
%     y(k) = PF(k)*((a*x)^5/(1+(a*x)^5));
end
% 
% fid = fopen('PF_C42a_updated','w');
% for i = 1:N
%     %fprintf(fid,'%s\t',names(i,:));
%     fprintf(fid,'%g\n', PF(i));
% end