clc
clear all

%%%%%%%%% Set the name of the excel file to be read (input)

fprintf('Please, insert the name of the spreadsheet without quotes (" ") or (''). \n')
prompt = 'The expected extentions are .xlsx, xls, or .csv: ';

name_file = input(prompt, 's');


%%%%%%%%%%% Set the name of the file where the information will be saved. 
prompt = 'Please, insert a name for the output file with the desired extension (.xlsx, xls, or .csv): ';
output_name = input(prompt, 's');
f = fopen(output_name,'w');

%%%%%%%%%%% decide about the assigment routine

%prompt = 'Please insert 1 to analyse myelinated axons. For unmyelinated axons insert 0: ';
prompt = 'For analysing all the data points insert 0. For matching inner and outer contours insert 1: ';
assigment_variable = input(prompt);


if assigment_variable == 0
table = readtable(name_file);


%%%%%%%% Set the name of the variable to be read in the input file
table_results = table(:,{'Area', 'Perimeter', 'FeretMax', 'FeretMin','Name', 'CentroidX','CentroidY'});

[a,~] = size(table_results);
Axon = [];
table_results = table2cell(table_results);
Fiber = [];
area_Axon = [];
perimeter_Axon = [];
tic
%x= table_results(:,6);
%y = table_results(:,7);    
%feret_Axon = [];
%feret_MinAxon = [];
unmyelinated = 'Unmyelinated Axon'; 
fprintf(f, 'Name; CenterX; CenterY; Area; Perimeter; MinFeret; CircleAreaDiameter; CirclePerimeterDiameter; SAEDiameter; PerimeterError; AreaError \n');
count = 0;

for i=1:a    
%     if  strcmp(unmyelinated,table_results(i,1))
%       area_Axon = [area_Axon cell2mat(table_results(i,1))];
%       perimeter_Axon = [perimeter_Axon cell2mat(table_results(i,2))];        
%       feret_Axon = [feret_Axon cell2mat(table_results(i,3))];
%       feret_MinAxon = [feret_Axon cell2mat(table_results(i,4))];
%     end
     % if  strcmp(unmyelinated,table_results(i,1))
      %display(" Entrei aqui" )
%       area_Axon = [area_Axon sscanf(sprintf("%s", table_results{i,1}), '%f*')];
%       perimeter_Axon = [perimeter_Axon sscanf(sprintf("%s", table_results{i,2}), '%f*')];        
%       feret_Axon = [feret_Axon sscanf(sprintf("%s", table_results{:,3}), '%f*')];
%       %feret_MinAxon = [feret_MinAxon sscanf(sprintf("%s", table_results{:,4}), '%f*')];
%       feret_MinAxon = [feret_MinAxon table_results{:,4}];
%       Axon = [Axon; x{i}(1) y{i}(1)];
% i
 %   end
%end
area_Axon = cell2mat(table_results(i,1));
if (ischar(area_Axon))
    area_Axon = sscanf(sprintf("%s", area_Axon), '%f*');
end
%for i =1:length(area_Axon)   
if (area_Axon > 0.005)
     perimeter_Axon =  cell2mat(table_results(i,2));   
    if (ischar(perimeter_Axon))
    perimeter_Axon = sscanf(sprintf("%s", perimeter_Axon), '%f*');
    end
    
   feret_MinAxon = cell2mat(table_results(i,4));
   if (ischar(feret_MinAxon))
   feret_MinAxon = sscanf(sprintf("%s", table_results{i,4}), '%f*');
   end
   
   feret_Axon = cell2mat(table_results(i,3));
   if (ischar(feret_Axon))
   feret_Axon = sscanf(sprintf("%s", table_results{i,3}), '%f*');
   end
   
   Axon = [  cell2mat(table_results(i,6))  cell2mat(table_results(i,7))];
    %%%%%%%%%%%%%%%%%%%%%%%%%%% CIRCLE
    circle_Axon = 2*sqrt(area_Axon/3.14);
    perimeter_Axon2 = perimeter_Axon/3.14;
    perimeter = perimeter_Axon;
    area =  area_Axon;
    fun = @(x)(-perimeter + 4*(area*pi^2*x^2 + area^2 -2*area*x^2*pi +pi^2*x^4)/(area*pi*x+pi^2*x^3));

    %fun = @(x) (-perimeter*pi^1.456*x^1.912 + 4*x +2*area^1.456);
    %fun = @(x)(4*pi^2*x^4 - pi^2*perimeter*x^3 -(18+2*pi)*area*pi*x^2 - pi*area*perimeter*x + 4*area^2 );

    x = fzero(fun, feret_MinAxon/2);

    diameter_max_Axon = 2*x;
    if abs(diameter_max_Axon) < 10^5 && diameter_max_Axon > 0.005
        count = count +1;
    else
       diameter_max_Axon = feret_Axon;
    end
      
    diameter_min_Axon = 2*(2*area/(3.14*diameter_max_Axon));

    if diameter_min_Axon > diameter_max_Axon
        aux_max = diameter_min_Axon;
        diameter_min_Axon = diameter_max_Axon;
        diameter_max_Axon = aux_max;
    end
    h = ((diameter_max_Axon-diameter_min_Axon)/(diameter_max_Axon+diameter_min_Axon))^2;
    perimeter_error = perimeter - pi*(diameter_max_Axon/2 + diameter_min_Axon/2)*(3072-1280*h-252*h^2+33*h^3)/(3072-2048*h+212*h^2);
    area_error = area - pi*diameter_max_Axon*diameter_min_Axon*0.25 ;
    %%%%%%%%%%%%%% print the information
%    fprintf(f, '%f; %f; %f; %f; %f; %f \n', area_Axon(i),  perimeter_Axon(i), feret_MinAxon(i), circle_Axon, perimeter_Axon, diameter_min_Axon);
    fprintf(f, '%s;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f \n',table_results{i,5}, Axon(1), Axon(2), area_Axon,  perimeter_Axon, feret_MinAxon, circle_Axon, perimeter_Axon2, diameter_min_Axon, perimeter_error, area_error);
    end
end
toc
fclose(f);
else
%prompt = 'Please, insert the label for the inner structure: ';
%inner = input(prompt,'s');
inner = 'Axon';

%prompt = 'Please, insert the label for the outer structure: ';
%outer = input(prompt,'s');
outer = 'Fiber';

table = readtable(name_file);

%%%%%%%% Set the name of the variable to be read
table_results = table(:,{'Name', 'CentroidX','CentroidY', 'Area', 'Perimeter', 'FeretMin', 'FeretMax'});

[aa,~] = size(table_results);
Axon = [];
table_results = table2cell(table_results);
Fiber = [];
area_Axon = [];
area_Fiber = [];   
perimeter_Axon = [];
perimeter_Fiber = [];

feret_Axon = [];
feret_Fiber = [];
x= table_results(:,2);
y = table_results(:,3);    
area = table_results(:,4);
for i=1:aa
    if strcmp(inner,table_results(i,1))
      Axon = [Axon; x{i}(1) y{i}(1)];
      area_Axon = [area_Axon area{i}(1)];
      feret_Axon = [feret_Axon cell2mat(table_results(i,6))];
      perimeter_Axon = [perimeter_Axon cell2mat(table_results(i,5))];
   else
       if strcmp(outer,table_results(i,1))
           Fiber = [Fiber; x{i}(1) y{i}(1)];
           area_Fiber = [area_Fiber area{i}(1)];
           feret_Fiber = [feret_Fiber cell2mat(table_results(i,6))];
           perimeter_Fiber = [perimeter_Fiber cell2mat(table_results(i,5))];
       end
   end
      
end
[a,b] = size(Fiber);
[c,d]= size(Axon);

if a ~=c
   fprintf('The number of Axon and Fiber axons is different') 
   return
else
    distance = ones(a,c);
    for i=1:a
        for j = 1: c
            if area_Axon(j) > area_Fiber(i)
                distance(i,j) = sqrt((Fiber(i,1)- Axon(j,1))^2+(Fiber(i,2)- Axon(j,2))^2)+ (area_Fiber(i)-area_Axon(j))^2;
            else
                 distance(i,j) = sqrt((Fiber(i,1)- Axon(j,1))^2+(Fiber(i,2)- Axon(j,2))^2);
            end
        end
    end
end


%%%%%%%%%%% Set the name of the file where the information will be saved
f = fopen(output_name,'w');
fprintf(f, 'Area_Axon;Area_Fiber;CentroidX;CentroidY;Perimeter_Fiber;Perimeter_Axon;Fiber_MinFeretdistance;Axon_MinFeretdistance;MyelinThickness_MinFeretdistance;MinFeretdistance_gratio;Fiber_circleArea_diameter;Axon_circleArea_diameter;MyelinThickness_CircleArea;CircleArea_gratio;Fiber_circlePerimeter_diameter;Axon_circlePerimeter_diameter;MyelinThickness_CirclePerimeter;CirclePerimeter_gratio;ShapeAdjustedEllipse_Fiber;ShapeAdjustedEllipse_Axon;MyelinThickness_ShapeAdjustedEllipse;ShapeAdjustedEllipse_gratio \n');


[enter,out] = linear_sum_assignment(distance);

for i =1:a  
    position_fiber = enter(i);
    position_axon =  out(i);
    if (area_Axon(position_axon) > 0.001) && (area_Fiber(position_fiber) >0.0001) && (area_Fiber(position_fiber) > area_Axon(position_axon))
    %%%%%%%%%%%%%%%%%%%%%%%%%%% CIRCLE AREA
    circle_Axon2 = 2*sqrt(area_Axon(position_axon)/3.14);
    circle_Fiber2 = 2*sqrt(area_Fiber(position_fiber)/3.14);
    thickness_circle = (circle_Fiber2-circle_Axon2) /2;
    circle_gratio = circle_Axon2/circle_Fiber2;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% CIRCLE PERIMETER
    perimeter_Axon2 = area_Axon(position_axon)/3.14;
    perimeter_Fiber2 = area_Fiber(position_fiber)/3.14;
    thickness_perimeter = (perimeter_Fiber2-perimeter_Axon2) /2;
    perimeter_gratio = perimeter_Axon2/perimeter_Fiber2;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% FERET
    feret_gratio = feret_Axon(position_axon)/feret_Fiber(position_fiber);
    thickness_feret = (feret_Fiber(position_fiber) - feret_Axon(position_axon))/2;

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% SHAPE ADJUSTED ELLIPSE
    perimeter = perimeter_Axon(position_axon);
    area =  area_Axon(position_axon);
   % fun = @(x)(-perimeter + 4*(area*pi^2*x^2 + area^2 -2*area*x^2*pi +pi^2*x^4)/(area*pi*x+pi^2*x^3));
    %fun = @(x)(4*pi^2*x^4 - pi^2*perimeter*x^3 -(18+2*pi)*area*pi*x^2 - pi*area*perimeter*x + 4*area^2 );
    fun = @(x)(-perimeter + (2/x)*sqrt((area^2+x^4*9.86)/2));

    x = fzero(fun, feret_Axon(position_axon));
    if x <= 0.01
        x = feret_Axon(position_axon)/2;
    end
    diameter_max_Axon = 2*x;
    diameter_min_Axon = 2*area/(3.14*x);
    if diameter_min_Axon > diameter_max_Axon
        aux_max = diameter_min_Axon;
        diameter_min_Axon = diameter_max_Axon;
        diameter_max_Axon = aux_max;
    end
    
    
    perimeter = perimeter_Fiber(position_fiber);
    area =  area_Fiber(position_fiber);
   %fun = @(x)(-perimeter + 4*(area*pi^2*x^2 + area^2 -2*area*x^2*pi +pi^2*x^4)/(area*pi*x+pi^2*x^3));
    fun = @(x)(-perimeter + (2/x)*sqrt((area^2+x^4*9.86)/2));
    x = fzero(fun, feret_Fiber(position_fiber));
        if x<=0.01
            x = feret_Fiber(position_fiber)/2;
        end
    diameter_max_Fiber = 2*x;
    diameter_min_Fiber = 2*area/(3.14*x);
    if diameter_min_Fiber > diameter_max_Fiber
        aux_max = diameter_min_Fiber;
        diameter_min_Fiber = diameter_max_Fiber;
        diameter_max_Fiber = aux_max;
    end
    if (diameter_min_Fiber  -diameter_min_Axon) < 0
        diameter_min_Fiber = feret_Fiber(position_fiber)/2;
        diameter_min_Axon = feret_Axon(position_axon)/2;
    end

    thickness_shapeadjusted = (diameter_min_Fiber  -diameter_min_Axon) /2;
    shapeadjusted_gratio = diameter_min_Axon/diameter_min_Fiber;
    
    %%%%%%%%%%%%%% print the information
    fprintf(f, '%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f;%f \n', area_Axon(position_axon), area_Fiber(position_axon), Axon(position_axon,1), Axon(position_axon,2), perimeter_Fiber(position_fiber), perimeter_Axon(position_axon), feret_Fiber(position_fiber), feret_Axon(position_axon), thickness_feret, feret_gratio, circle_Fiber2, circle_Axon2, thickness_circle, circle_gratio, perimeter_Fiber2, perimeter_Axon2, thickness_perimeter, perimeter_gratio, diameter_min_Fiber, diameter_min_Axon, thickness_shapeadjusted, shapeadjusted_gratio);
    end
end

fclose(f);


end
