clc
clear all

%%%%%%%%% Set the name of the excel file to be read (input)
prompt = 'Please, insert the name of the spreadsheet with the extention (input): ';

name_file = input(prompt, 's');


%%%%%%%%%%% Set the name of the file where the information will be saved (output)
prompt = 'Please, insert the name of the file where the information will be saved (output): ';
output_name = input(prompt, 's');
f = fopen(output_name,'w');

%%%%%%%%%%% decide about the assigment routine
prompt = 'Do you like to perform the assigment routine? If yes please insert 1, otherwise please insert 0: ';
assigment_variable = input(prompt);


if assigment_variable == 0
table = readtable(name_file);


%%%%%%%% Set the name of the variable to be read in the input file
table_results = table(:,{'Area', 'Perim_', 'Feret', 'MinFeret'});

[a,~] = size(table_results);
Axon = [];
table_results = table2cell(table_results);
Fiber = [];
area_Axon = [];
perimeter_Axon = [];

feret_Axon = [];
feret_MinAxon = [];

for i=1:a    
      area_Axon = [area_Axon cell2mat(table_results(i,1))];
      perimeter_Axon = [perimeter_Axon cell2mat(table_results(i,2))];        
      feret_Axon = [feret_Axon cell2mat(table_results(i,3))];
      feret_MinAxon = [feret_Axon cell2mat(table_results(i,4))];

end





fprintf(f, 'Fiber_area, Fiber_perimeter, Fiber_diameter_MinFeretdistance, Fiber_diameter_Circle, Fiber_diameter_ShapeAdjustedEllipse \n');

for i =1:length(area_Axon)  
    %%%%%%%%%%%%%%%%%%%%%%%%%%% CIRCLE
    circle_Axon = 2*sqrt(area_Axon(i)/3.14);
    perimeter = perimeter_Axon(i);
    area =  area_Axon(i);
    
    fun = @(x) (-perimeter*pi^1.456*x^1.912 + 4*x +2*area^1.456);
   
    x = fzero(fun, feret_MinAxon(i)/2);

    diameter_max_Axon = 2*x;
    if abs(diameter_max_Axon) < 10^4 && diameter_max_Axon > 0.1;
    else
       diameter_max_Axon = feret_Axon(position_axon);
    end
      
    diameter_min_Axon = 2*(2*area/(3.14*diameter_max_Axon));

    if diameter_min_Axon > diameter_max_Axon
        aux_max = diameter_min_Axon;
        diameter_min_Axon = diameter_max_Axon;
        diameter_max_Axon = aux_max;
    end
    %%%%%%%%%%%%%% print the information
    fprintf(f, '%f , %f, %f, %f, %f \n', area_Axon(i),  perimeter_Axon(i), feret_MinAxon(i), circle_Axon, diameter_min_Axon);
end

fclose(f);
else
prompt = 'Please, insert the label for the inner structure: ';
inner = input(prompt,'s');


prompt = 'Please, insert the label for the outer structure: ';
outer = input(prompt,'s');

table = readtable(name_file);

%%%%%%%% Set the name of the variable to be read
table_results = table(:,{'Name', 'Centroid', 'Area__m__', 'Perimeter__m_', 'FeretMin__m_'});

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

for i=1:aa
    centroid =  table_results(i,2);
    area = cell2mat(table_results(i,3));
    TheString = char(centroid);
     fmt1 = '(%f,%f,%f)';
    fmt2 = '[%f %f %f]';
    fmt3 = '[%f]';
    fmt4 = '%f';
    parts = sscanf(TheString, fmt1);
    if isempty(parts)
      parts = sscanf(TheString, fmt2);
    end
    if length(parts) < 2
      error('Sorry, that is not a range I recognize')
    end
    if length(parts) == 2
      range = parts(1) : parts(2);
    else
      x = parts(1) ;
      y = parts(2);
    end
    
    
    if strcmp(inner,table_results(i,1))
      Axon = [Axon; x y];
      area_Axon = [area_Axon area];
      feret_Axon = [feret_Axon cell2mat(table_results(i,5))];
      perimeter_Axon = [perimeter_Axon cell2mat(table_results(i,4))];
   else
       if strcmp(outer,table_results(i,1))
           Fiber = [Fiber; x y];
           area_Fiber = [area_Fiber area];
           feret_Fiber = [feret_Fiber cell2mat(table_results(i,5))];
           perimeter_Fiber = [perimeter_Fiber cell2mat(table_results(i,4))];
       end
   end
       
end

[a,b] = size(Fiber);
[c,d]= size(Axon);

if a ~=c
   println('The number of Axon and Fiber axons is different') 
else
    distance = 10^6*ones(a,c);
    for i=1:a
        for j = 1: c
            if area_Axon(j) > area_Fiber(i)
                distance(i,j) = sqrt((Fiber(i,1)- Axon(j,1))^2+(Fiber(i,2)- Axon(j,2))^2)+ (area_Fiber(i)-area_Axon(i))^2;
            else
                 distance(i,j) = sqrt((Fiber(i,1)- Axon(j,1))^2+(Fiber(i,2)- Axon(j,2))^2);
            end
        end
    end
end


%%%%%%%%%%% Set the name of the file where the information will be saved
f = fopen(output_name,'w');
fprintf(f, 'Area_Axon, Area_Fiber, CentroidX, CentroidY, Perimeter_Fiber, Perimeter_Axon, Fiber_MinFeretdistance, Axon_MinFeretdistance, MyelinThickness_MinFeretdistance, MinFeretdistance_gratio, Fiber_circle_diameter, Axon_circle_diameter, MyelinThickness_Circle, Circle_gratio,  ShapeAdjustedEllipse_Fiber, ShapeAdjustedEllipse_Axon, MyelinThickness_ShapeAdjustedEllipse, ShapeAdjustedEllipse_gratio \n');


[enter,out] = linear_sum_assignment(distance);

for i =1:a  
    position_fiber = enter(i);
    position_axon =  out(i);

    %%%%%%%%%%%%%%%%%%%%%%%%%%% CIRCLE
    circle_Axon = 2*sqrt(area_Axon(position_axon)/3.14);
    circle_Fiber = 2*sqrt(area_Fiber(position_fiber)/3.14);
    thickness_circle = (circle_Fiber-circle_Axon) /2;
    circle_gratio = circle_Axon/circle_Fiber;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% FERET
    feret_gratio = feret_Axon(position_axon)/feret_Fiber(position_fiber);
    thickness_feret = (feret_Fiber(position_fiber) - feret_Axon(position_axon))/2;

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% SHAPE ADJUSTED ELLIPSE
    perimeter = perimeter_Axon(position_axon);
    area =  area_Axon(position_axon);
    fun = @(x)(-perimeter + 4*(area*pi^2*x^2 + area^2 -2*area*x^2*pi +pi^2*x^4)/(area*pi*x+pi^2*x^3));
    
    x = fzero(fun, circle_Axon);
  
    diameter_max_Axon = 2*x;
    diameter_min_Axon = 2*area/(3.14*diameter_max_Axon);
    if diameter_min_Axon > diameter_max_Axon
        aux_max = diameter_min_Axon;
        diameter_min_Axon = diameter_max_Axon;
        diameter_max_Axon = aux_max;
    end
    
    
    perimeter = perimeter_Fiber(position_fiber);
    area =  area_Fiber(position_fiber);
   fun = @(x)(-perimeter + 4*(area*pi^2*x^2 + area^2 -2*area*x^2*pi +pi^2*x^4)/(area*pi*x+pi^2*x^3));

    x = fzero(fun, circle_Fiber);
        
    diameter_max_Fiber = 2*x;
    diameter_min_Fiber = 2*area/(3.14*diameter_max_Fiber);
    if diameter_min_Fiber > diameter_max_Fiber
        aux_max = diameter_min_Fiber;
        diameter_min_Fiber = diameter_max_Fiber;
        diameter_max_Fiber = aux_max;
    end
    thickness_shapeadjusted = (diameter_min_Fiber  -diameter_min_Axon) /2;
    shapeadjusted_gratio = diameter_min_Axon/diameter_min_Fiber;
    
    %%%%%%%%%%%%%% print the information
    fprintf(f, '%f, %f, %f, %f, %f, %f, %f,%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f \n', area_Axon(position_axon), area_Fiber(position_axon), Axon(position_axon,1), Axon(position_axon,2), perimeter_Fiber(position_fiber), perimeter_Axon(position_axon), feret_Fiber(position_fiber), feret_Axon(position_axon), thickness_feret, feret_gratio, circle_Fiber, circle_Axon, thickness_circle, circle_gratio, diameter_min_Fiber, diameter_min_Axon, thickness_shapeadjusted, shapeadjusted_gratio);
end

fclose(f);


end
