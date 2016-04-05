close all;clear;clc;

%真实的数据
mu=[0 0];  %均值
S=[1 2.5;2.5 8];  %协方差
data1=mvnrnd(mu,S,200);   %产生200个高斯分布数据

%噪声数据
mu=[2 2];
S=[8 0;0 8];
data2=mvnrnd(mu,S,100);     %产生100个噪声数据

data=[data1;data2];
plot(data(:,1),data(:,2),'ro');     %显示全部数据

K=100;          %设置最大迭代次数
sigma=1;        %设置拟合直线与数据距离的偏差
pretotal=0;     %符合拟合模型的数据的个数
k=1;
while pretotal < size(data,1)*2/3 &&  k<K      %有2/3的数据符合拟合模型或达到最大迭代次数就可以退出了
    SampIndex=floor(1+(size(data,1)-1)*rand(2,1));  %产生两个随机索引，找样本用，floor向下取整
    
    samp1=data(SampIndex(1),:);     %对原数据随机抽样两个样本
    samp2=data(SampIndex(2),:);
    
    line=Mytls([samp1;samp2]);      %对两个数据拟合出直线，或其他变种拟合方法
    mask=abs(line*[data ones(size(data,1),1)]');    %求每个数据到拟合直线的距离
    total=sum(mask<sigma);              %计算数据距离直线小于一定阈值的数据的个数
    
    if total>pretotal            %找到符合拟合直线数据最多的拟合直线
        pretotal=total;
        bestline=line;          %找到最好的拟合直线
    end  
    k=k+1;
end

%显示符合最佳拟合的数据
mask=abs(bestline*[data ones(size(data,1),1)]')<sigma;    
hold on;
for i=1:length(mask)
    if mask(i)
        plot(data(i,1),data(i,2),'b.');
    end
end