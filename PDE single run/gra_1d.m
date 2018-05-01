clear all;
close all;
load da_ind;
load da_cont;
load da_xyp;
% load da_ligand;


n = da_ind(1);
n2 = n/2;
m = length(da_ind)-1;
ntot = n*18;
z = da_xyp(:,2);
r = da_xyp(:,1);
L = da_xyp(:,3);
alpha = da_xyp(:,4);
alpha = alpha - pi;

% subplot(2,1,1)
% plot(z,r)
% xlabel('z (microns)')
% ylabel('r (microns)')
% subplot(2,1,2) 
%for j = 1:n
% L(j) = da_ligand(n*(m-2)+j);
%end
% figure(2)
%  subplot(8,2,15)
%  for j=1:n,
%      kkk = n*(m-2);
%      Ligand(j) = da_ligand(kkk + j,4);
%  end
%  plot(alpha,Ligand), hold on
%  xlabel('\alpha')
%  ylabel('[L] (nM)')

%figure(2)
for i=1:m,
        col = 'b';
        if i==1, col='g-'; end
        if i==m, col='r-'; end
	for k=1:14,
	%for k=7:7,
		for j=1:n
	           kkk = ntot*(i-1) + n*(k-1) ;
                   Rep1(j) = da_cont(kkk + j);

        end
	    subplot(8,2,k)
        if i==m | i==m,
          plot(alpha,Rep1,col,'LineWidth',3), hold on
        end
        xlabel('z (microns)')
if k==1
     ylabel('[R] (mol)')
end
if k==2
     ylabel('[RL] (mol)')
end
if k==3
     ylabel('[G] (mol)')
end
if k==4
     ylabel('[Ga] (mol)')
end
if k==5
     ylabel('[Gbg] (mol)')
end
if k==6
     ylabel('[Gd] (mol)')
end
if k==7
     ylabel('[C24m] (mol)')
end
if k==8
     ylabel('[C42] (mol)')
end
if k==9
     ylabel('[C42a] (mol)')
end
if k==10
     ylabel('[B1m] (mol)')
end
if k==11
     ylabel('[S20m] (mol)')
end
if k==12
     ylabel('[Clara] (mol)')
end
if k==13
     ylabel('[Pol] (mol)')
end
if k==14
     ylabel('[b] (mol)')
end
                   hold on
		   all(1,k,i) = Rep1(1);
		   all(2,k,i) = Rep1(n2);
		   all(3,k,i) = Rep1(n);
         end
        		   
end


figure (3)

for k = 1:14
    subplot(7,2,k)

   for j=1:3
      for i=1:m
        all_0(j,i) = all(j,k,i);
      end
   end

if k==1
     ylabel('[R] (mol)')
end
if k==2
     ylabel('[RL] (mol)')
end
if k==3
     ylabel('[G] (mol)')
end
if k==4
     ylabel('[Ga] (mol)')
end
if k==5
     ylabel('[Gbg] (mol)')
end
if k==6
     ylabel('[Gd] (mol)')
end
if k==7
     ylabel('[C24m] (mol)')
end
if k==8
     ylabel('[C42] (mol)')
end
if k==9
     ylabel('[C42a] (mol)')
end
if k==10
     ylabel('[B1m] (mol)')
end
if k==11
     ylabel('[S20m] (mol)')
end
if k==12
     ylabel('[Clara] (mol)')
end
if k==13
     ylabel('[Pol] (mol)')
end
if k==14
     ylabel('[b] (mol)')
end

hold on     
     plot(da_ind(3:m+1)/60,all_0(1,2:m),'r')
     hold on
     plot(da_ind(3:m+1)/60,all_0(2,2:m),'g')
     hold on
     plot(da_ind(3:m+1)/60,all_0(3,2:m),'b')
     hold on

xlabel ('Time (minutes)')

%legend ('left' , 'middle', 'right')

end


% figure(1)
% for i=m:m,
%     col = 'r';
%     k=14;
% 	for j=1:n
% 	  kkk = ntot*(i-1) + n*(k-1) ;
%       noise(j) = da_cont(kkk + j);
%     end
% end
% subplot(7,2,13)
% plot(z,noise,col)
% ylabel('[L] (mol)')
