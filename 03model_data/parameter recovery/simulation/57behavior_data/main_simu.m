path=pwd; %
load('design.mat');

[par,~,~]=xlsread('m10_parameters_posterior_mean.xlsx');
subs=par(:,1);
par=par(:,2:size(par,2));
for n=1:length(subs)
    design_sub=design(find(design(:,1)==subs(n)),:);
    if n==1
        sim_data=simu_fit_m102(par(n,:),design_sub);
    else
        sim_data=[sim_data;simu_fit_m102(par(n,:),design_sub)];
    end
end

save sim_data_m102.mat sim_data  %生成了27个假被试，每个被试80个trial
