function [success] = omparameter (modelname,name,wert,original);
% Change parameter in *_init.txt file; Returns linenumber replaced if
% succeeded, -1 if not.
% SYNTAX: [linenumber] = omparameter(modelname,parameter,value, original)
% Exmaple: omparameter('package.model','stop value',10,0)
% original = 0 changes original parameterset, 1 - changes, previously changed parameters
%
% Feedback/problems: Christian Schaad, ingenieurbuero@christian-schaad.de
% Updated for Vmodel toolbox : Alexey Romanov, AlexRomashka@yandex.ru, 2018


success=-1;

if(nargin<4)
  original=1;
end
if(original)
  inputfile=[modelname,'_init_original.xml'];
else
  inputfile=[modelname,'_init.xml'];
end
outputfile=[modelname,'_init.xml'];

fid=fopen(inputfile);
i=0;
while 1
    i=i+1;
    tline0 = fgetl(fid);
    if ~ischar(tline0), break, end
    tline= [tline0,char(10)];

    if ~isempty(strfind(tline,['name = "',name,'"',char(10)]))
      while isempty(strfind(tline,'<Real start'))
        dataset(i).string=tline; 
        tline0 = fgetl(fid);
        tline= [tline0,char(10)];
        i=i+1;
      end

      tline=['    <Real start="',wert,'" fixed="true" useNominal="false" />',char(10)	];
      success=i;
    end

    dataset(i).string=tline;
    clear tline tline0;
       
end
fclose(fid);

fid=fopen(outputfile,'w');
for j=1:i-1
  fprintf(fid,[dataset(j).string]);
end
fclose(fid);
switch success
    case -1
        error(['Parameter ',name,' not found!']);
end; 


