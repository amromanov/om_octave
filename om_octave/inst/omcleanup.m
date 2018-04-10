
function omcleanup (modelname,clean_all) 
%
% Clean up all the compilation stuff...
% clean_all parameters deletes even model and all xml
%
% Feedback/problems: Christian Schaad, ingenieurbuero@christian-schaad.de
% Updated for Vmodel toolbox : Alexey Romanov, AlexRomashka@yandex.ru, 2018

if nargin<2
  clean_all = 0;
end

dirlist = dir;
for i=1:length(dirlist)
  if(strcmp(dirlist(i).name,'simo.mos'))
    delete(dirlist(i).name);
    continue
  end
  if(strcmp(dirlist(i).name,[modelname,'.log']))
    delete(dirlist(i).name);
    continue
  end
  if(strcmp(dirlist(i).name,[modelname,'.makefile']))
    delete(dirlist(i).name);
    continue
  end
  if(strcmp(dirlist(i).name,[modelname,'.cpp']))
    delete(dirlist(i).name);
    continue
  end
  if(strcmp(dirlist(i).name,[modelname,'.c']))
    delete(dirlist(i).name);
    continue
  end
  if(strcmp(dirlist(i).name,[modelname,'.o']))
    delete(dirlist(i).name);
    continue
  end
  if(strcmp(dirlist(i).name,[modelname,'.libs']))
    delete(dirlist(i).name);
    continue
  end
  
  if(clean_all)
    if(strcmp(dirlist(i).name,[modelname]))
      delete(dirlist(i).name);
      continue
    end  
    if(strcmp(dirlist(i).name,[modelname ".exe"]))
      delete(dirlist(i).name);
      continue
    end  
  end
  if(strfind(dirlist(i).name,[modelname '_'])==1)
    if(strcmp(dirlist(i).name(end-1:end),'.c'))
      delete(dirlist(i).name);
      continue
    end
    if(strcmp(dirlist(i).name(end-1:end),'.o'))
      delete(dirlist(i).name);
      continue
    end
    if(strcmp(dirlist(i).name(end-1:end),'.h'))
      delete(dirlist(i).name);
      continue
    end
    if(strcmp(dirlist(i).name(end-3:end),'.mat'))
      delete(dirlist(i).name);
      continue
    end
    if(strcmp(dirlist(i).name(end-4:end),'.json'))
      delete(dirlist(i).name);
      continue
    end
    if(clean_all)
      if(strcmp(dirlist(i).name(end-3:end),'.xml'))
        delete(dirlist(i).name);
        continue
      end
    end
  end
end


