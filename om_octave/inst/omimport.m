function omimport(modelname,out_name) 
%
% Read OpenModelica Result File into Workspace
%
% SYNTAX: omimport(modelname)
% z.B. omimport('package.model')
%
% All $dummies, der(*) and data(time)=0 are thrown out
% Feedback/problems: Christian Schaad, ingenieurbuero@christian-schaad.de
% Updated for Vmodel toolbox : Alexey Romanov, AlexRomashka@yandex.ru, 2018

if nargin < 2
  out_name = 'om_out.';
else
  if ~isempty(out_name)
    out_name=[out_name '.'];
  else
    out_name='';
  end
end



load ([modelname,'_res.mat']);
%Sort out double times 

deltat0=find(diff(data_2(1,:))<1e-5);
#disp(['Removed same time values: ',num2str(length(deltat0)),'/',num2str(length(data_2(1,:)))])
assignin('base','data_2',data_2);
assignin('base','dataInfo',dataInfo);
assignin('base','name',name);
assignin('base','deltat0',deltat0);
name=name';
%	description=description';
for i=1:size(name,1)%length(data_2(:,1))
    
    if (isempty(strfind(name(i,:),'der(')))&&(isempty(strfind(name(i,:),'[')))&&abs(dataInfo(2,i))<=length(data_2(:,1));
      nonchars=strfind(name(i,:),char(0));
      if dataInfo(2,i)<0
        assignin('base','temp',-data_2(-dataInfo(2,i),:));
      else
        assignin('base','temp',data_2(dataInfo(2,i),:));
      end

      evalin('base',(['temp(deltat0)=[];']));

      if ~isempty(nonchars)
        evalin('base',([out_name num2str(name(i,1:nonchars(1)-1)),'=temp;']));
      end
    end 
end
clear data_1 data_2 Aclass description modelname i dataInfo temp deltat0;
evalin('base',(['clear name data_2 dataInfo nonchars temp deltat0']));