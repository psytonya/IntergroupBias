clear all;
clc;

path=pwd; %
load('Design57.mat');

[par,~,~]=xlsread('57sub_m3_parameters.xlsx');
subs=par(:,1);%第一列
par=par(:,2:size(par,2));%第二列到最后一列
for n=1:length(subs)
    design57_sub=Design57(find(Design57(:,1)==subs(n)),:);%找到对应n的那一行
    if n==1
        sim57_data=simu57_fit_m102(par(n,:),design57_sub);
    else
        sim57_data=[sim57_data;simu57_fit_m102(par(n,:),design57_sub)];
    end
end

save 57sub_sim_m3.mat sim57_data
