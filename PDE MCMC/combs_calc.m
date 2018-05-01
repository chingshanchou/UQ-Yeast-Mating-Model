d = 5;
m = nchoosek(35+d,35);
c1 = [1 zeros(1,34); 
    1 1 zeros(1,33); 
    1 1 1 zeros(1,32); 
    1 1 1 1 zeros(1,31); 
    1 1 1 1 1 zeros(1,30); 
    2 zeros(1,34); 
    2 1 zeros(1,33); 
    2 1 1 zeros(1,32); 
    2 1 1 1 zeros(1,31); 
    2 2 zeros(1,33); 
    2 2 1 zeros(1,32); 
    3 zeros(1,34);
    3 1 zeros(1,33);
    3 1 1 zeros(1,32);
    3 2 zeros(1,33);
    4 zeros(1,34);
    4 1 zeros(1,33);
    5 zeros(1,34)];
combs = zeros(1,35);
for i = 1:size(c1,1);
    combs = [combs; uperm(c1(i,:))];
end

fid = fopen('combs','w');
for i = 1:m
    fprintf(fid,'%g\t',combs(i,:));
    fprintf(fid,'\n');
end