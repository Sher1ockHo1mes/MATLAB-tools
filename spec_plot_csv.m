 tic
 clc 
 clear all;
 close all;
%% ѡ��Ҫ���ĸ��ļ�
% [fname,fpath] = uigetfile( ...
% {'*.txt','MAT-files (*.mat)'; ...
% '*.mdl','Models (*.mdl)'; ...
% '*.*', 'All Files (*.*)'}, ...
% 'Pick a file');
% filename=[fpath,fname];         %ѡ��һ���ļ�����ȡ�ļ���·��
%% �Զ���ȡ��ǰ�ļ���·����CSV
fullpath = mfilename('fullpath');
[path,name]=fileparts(fullpath)
fpath = [path,'\'];
File=dir(fullfile(fpath,'*.CSV'));   %��ȡ·�������е�*.txt�ļ�
%% �����ļ�������
allname={File.name}';%���ļ����������ļ����浽һά������
file_count=size(allname,1);  %��ȡ�ļ����е��ļ�����
z{1,2} (1:file_count,1)=allname;
figure();
for k=1:file_count
file_path=strcat(fpath,allname(k,1)); %��ȡÿ���ļ�������·��
X = csvread((file_path{1,1}),0,0); 
expr = ['data_' num2str(k) '=X;']; %ÿ���ļ����ݴ浽����
eval(expr);
% figure()
h = plot(X(:,1),X(:,2), 'LineWidth',2,'LineStyle','-');    
g = get(h,'parent');
set(g,'Linewidth',3);
% hold on 
% plot(X(:,3),X(:,4), 'LineWidth',1,'LineStyle','-');
% hold on 
% plot(X(:,5),X(:,6), 'LineWidth',1,'LineStyle','-');
% �������������ж������ݿɲ���
set(0,'defaultfigurecolor','w'); %��Ϊ�׵�               
% axis([31.912, 31.918, -120 -25])
% xlim([31.912 31.918]);ylim ([-120 -25]);   %�������귶Χ
xlabel('������nm��','FontWeight','bold');ylabel('����(dBm)','FontWeight','bold'); %�����ǩ,�Ӵ�
set(gca,'FontSize',20,'Linewidth',3,'Fontweight','bold');%������̶����� % �������ִ�С��ͬʱӰ���������ע��ͼ��������ȡ�
% legend('�������');
%% ����������Ĳ����Ȳ���
X1 = X;
X1 = X1(:,1:2);
X1_1 = X1(:,1);
X1_1(X1_1==0) = [];
X1_2 = X1(:,2);
X1_2(X1_2==0) = [];
X1 = [X1_1,X1_2];
[max_amp,i] = max(X1(:,2));
central_wavelength = X1(i,1)
epsilon = 0.02;  %%�޸����ﾫ�ȣ�����Χ��С
range = find(((max_amp-X1(:,2)-3)<epsilon)&((max_amp-X1(:,2)-3)>-epsilon));
wavelength_width = abs(X1(max(range),1)-X1(min(range),1))
set(0,'defaultfigurecolor','W');
set(gcf,'color','white');
hold on
end
toc
disp(['����ʱ��: ',num2str(toc)]);
set(0,'defaultfigurecolor','W');