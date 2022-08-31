 tic
 clc 
 clear all;
 close all;
%% 选择要打开哪个文件
% [fname,fpath] = uigetfile( ...
% {'*.txt','MAT-files (*.mat)'; ...
% '*.mdl','Models (*.mdl)'; ...
% '*.*', 'All Files (*.*)'}, ...
% 'Pick a file');
% filename=[fpath,fname];         %选择一个文件来获取文件夹路径
%% 自动读取当前文件夹路径的CSV
fullpath = mfilename('fullpath');
[path,name]=fileparts(fullpath)
fpath = [path,'\'];
File=dir(fullfile(fpath,'*.CSV'));   %获取路径下所有的*.txt文件
%% 保存文件夹内容
allname={File.name}';%将文件夹中所有文件名存到一维数组里
file_count=size(allname,1);  %获取文件夹中的文件个数
z{1,2} (1:file_count,1)=allname;
figure();
for k=1:file_count
file_path=strcat(fpath,allname(k,1)); %获取每个文件的完整路径
X = csvread((file_path{1,1}),0,0); 
expr = ['data_' num2str(k) '=X;']; %每个文件数据存到变量
eval(expr);
% figure()
h = plot(X(:,1),X(:,2), 'LineWidth',2,'LineStyle','-');    
g = get(h,'parent');
set(g,'Linewidth',3);
% hold on 
% plot(X(:,3),X(:,4), 'LineWidth',1,'LineStyle','-');
% hold on 
% plot(X(:,5),X(:,6), 'LineWidth',1,'LineStyle','-');
% ………………有多列数据可补充
set(0,'defaultfigurecolor','w'); %设为白底               
% axis([31.912, 31.918, -120 -25])
% xlim([31.912 31.918]);ylim ([-120 -25]);   %横纵坐标范围
xlabel('波长（nm）','FontWeight','bold');ylabel('功率(dBm)','FontWeight','bold'); %坐标标签,加粗
set(gca,'FontSize',20,'Linewidth',3,'Fontweight','bold');%坐标轴刻度字体 % 设置文字大小，同时影响坐标轴标注、图例、标题等。
% legend('输出光谱');
%% 计算带宽、中心波长等参数
X1 = X;
X1 = X1(:,1:2);
X1_1 = X1(:,1);
X1_1(X1_1==0) = [];
X1_2 = X1(:,2);
X1_2(X1_2==0) = [];
X1 = [X1_1,X1_2];
[max_amp,i] = max(X1(:,2));
central_wavelength = X1(i,1)
epsilon = 0.02;  %%修改这里精度，看范围大小
range = find(((max_amp-X1(:,2)-3)<epsilon)&((max_amp-X1(:,2)-3)>-epsilon));
wavelength_width = abs(X1(max(range),1)-X1(min(range),1))
set(0,'defaultfigurecolor','W');
set(gcf,'color','white');
hold on
end
toc
disp(['运行时间: ',num2str(toc)]);
set(0,'defaultfigurecolor','W');