function data = simu57_fit_m102(param,design)

%% parameters
alpha11   = param(1); %alpha_in
alpha12   = param(2); %alpha_out
theta11   = param(3); %theta_in
theta12   = param(4); %theta_out
beta11    = param(5); %beta_in
beta12    = param(6); %beta_out
tau       = param(7); %temperature

%% design
subs            = design(:,1);
offer_propoer   = design(:,2);
offer_recipt    = design(:,3);
punish          = design(:,4);
condition       = design(:,5);
inoutgroup      = design(:,6);
trial           = design(:,7);


%% initialisation
nt   =length(design); %trial number
data = zeros(nt,8);   %subjid,分配后A的收益,分配后你的收益,施加的惩罚类型,condition,1in/2outgroup,trialnum
c    =zeros(nt,1)-1;  %nt行的列向量，所有元素值为-1
c_r  =zeros(nt,1)-1;  %nt行的列向量，所有元素值为-1

%% generate choices
for t = 1:nt  % trial loop
    % action selection based of softmax transformation
    if inoutgroup(t)==1 %ingroup        
        U(1)= offer_recipt(t)+6-0*beta11-alpha11*max((offer_propoer(t)+6-3*0*beta11)-(offer_recipt(t)+6-0*beta11),0)-theta11*max((offer_recipt(t)+6-0*beta11)-(offer_propoer(t)+6-3*0*beta11),0);
        fenzi(1)=exp(tau*U(1));
        U(2)= offer_recipt(t)+6-2*beta11-alpha11*max((offer_propoer(t)+6-3*2*beta11)-(offer_recipt(t)+6-2*beta11),0)-theta11*max((offer_recipt(t)+6-2*beta11)-(offer_propoer(t)+6-3*2*beta11),0);% if chosing 2
        fenzi(2)=exp(tau*U(2));
        U(3)= offer_recipt(t)+6-4*beta11-alpha11*max((offer_propoer(t)+6-3*4*beta11)-(offer_recipt(t)+6-4*beta11),0)-theta11*max((offer_recipt(t)+6-4*beta11)-(offer_propoer(t)+6-3*4*beta11),0);% if chosing 4
        fenzi(3)=exp(tau*U(3));
        U(4)= offer_recipt(t)+6-6*beta11-alpha11*max((offer_propoer(t)+6-3*6*beta11)-(offer_recipt(t)+6-6*beta11),0)-theta11*max((offer_recipt(t)+6-6*beta11)-(offer_propoer(t)+6-3*6*beta11),0);% if chosing 6
        fenzi(4)=exp(tau*U(4));
        
    else %outgroup
        U(1)= offer_recipt(t)+6-0*beta12-alpha12*max((offer_propoer(t)+6-3*0*beta12)-(offer_recipt(t)+6-0*beta12),0)-theta12*max((offer_recipt(t)+6-0*beta12)-(offer_propoer(t)+6-3*0*beta12),0);
        fenzi(1)=exp(tau*U(1));
        U(2)= offer_recipt(t)+6-2*beta12-alpha12*max((offer_propoer(t)+6-3*2*beta12)-(offer_recipt(t)+6-2*beta12),0)-theta12*max((offer_recipt(t)+6-2*beta12)-(offer_propoer(t)+6-3*2*beta12),0);% if chosing 2
        fenzi(2)=exp(tau*U(2));
        U(3)= offer_recipt(t)+6-4*beta12-alpha12*max((offer_propoer(t)+6-3*4*beta12)-(offer_recipt(t)+6-4*beta12),0)-theta12*max((offer_recipt(t)+6-4*beta12)-(offer_propoer(t)+6-3*4*beta12),0);% if chosing 4
        fenzi(3)=exp(tau*U(3));
        U(4)= offer_recipt(t)+6-6*beta12-alpha12*max((offer_propoer(t)+6-3*6*beta12)-(offer_recipt(t)+6-6*beta12),0)-theta12*max((offer_recipt(t)+6-6*beta12)-(offer_propoer(t)+6-3*6*beta12),0);% if chosing 6
        fenzi(4)=exp(tau*U(4));
    end
    
    fenmu=fenzi(1)+fenzi(2)+ fenzi(3)+fenzi(4);
    
    for i=1:4
        prob(i)=fenzi(i)/fenmu;
    end
    
    
    % generate choice
    c(t) = find(rand < cumsum(prob(:)),1); % 1,2,3,4
      %基于给定的概率向量 prob,通过生成随机数并与概率向量的累积和进行比较,来随机确定一个索引值并将其赋值给c(t)。
      %rand 函数用于生成一个在区间 [0, 1) 内均匀分布的随机数
      %prob(:)  对prob向量进行了重塑操作，将其转换为一个列向量形式
      %cumsum(prob(:))计算重塑后的概率列向量的累积和。如果prob(:)是[0.2; 0.3; 0.5],那么cumsum(prob(:))就是[0.2; 0.5; 1.0]。
      %将随机数rand与累积和列向量cumsum(prob(:))进行比较。逐元素比较—得到逻辑列向量,其中每个元素对应于比较的结果,true表示小于false大于等于
      %找到满足条件的第一个索引为1,将1赋值给c(t)
    if c(t)==1
        c_r(t)=0;
    elseif c(t)==2
        c_r(t)=2;
    elseif c(t)==3
        c_r(t)=4;
    elseif c(t)==4
        c_r(t)=6;
    end
    clear prob U fenzi fenmu
end % nt

%% write c and r into output variable 'data'

data(:,1) = subs;
data(:,2) = offer_propoer;
data(:,3) = offer_recipt;
data(:,4) = c_r;%punish
data(:,5) = condition;
data(:,6) = inoutgroup;%choice
data(:,7) = c;%choice
data(:,8) = trial;










