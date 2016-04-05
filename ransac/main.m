close all;clear;clc;

%��ʵ������
mu=[0 0];  %��ֵ
S=[1 2.5;2.5 8];  %Э����
data1=mvnrnd(mu,S,200);   %����200����˹�ֲ�����

%��������
mu=[2 2];
S=[8 0;0 8];
data2=mvnrnd(mu,S,100);     %����100����������

data=[data1;data2];
plot(data(:,1),data(:,2),'ro');     %��ʾȫ������

K=100;          %��������������
sigma=1;        %�������ֱ�������ݾ����ƫ��
pretotal=0;     %�������ģ�͵����ݵĸ���
k=1;
while pretotal < size(data,1)*2/3 &&  k<K      %��2/3�����ݷ������ģ�ͻ�ﵽ�����������Ϳ����˳���
    SampIndex=floor(1+(size(data,1)-1)*rand(2,1));  %������������������������ã�floor����ȡ��
    
    samp1=data(SampIndex(1),:);     %��ԭ�������������������
    samp2=data(SampIndex(2),:);
    
    line=Mytls([samp1;samp2]);      %������������ϳ�ֱ�ߣ�������������Ϸ���
    mask=abs(line*[data ones(size(data,1),1)]');    %��ÿ�����ݵ����ֱ�ߵľ���
    total=sum(mask<sigma);              %�������ݾ���ֱ��С��һ����ֵ�����ݵĸ���
    
    if total>pretotal            %�ҵ��������ֱ�������������ֱ��
        pretotal=total;
        bestline=line;          %�ҵ���õ����ֱ��
    end  
    k=k+1;
end

%��ʾ���������ϵ�����
mask=abs(bestline*[data ones(size(data,1),1)]')<sigma;    
hold on;
for i=1:length(mask)
    if mask(i)
        plot(data(i,1),data(i,2),'b.');
    end
end