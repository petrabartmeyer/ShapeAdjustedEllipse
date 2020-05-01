clc
clear all

%%%%%%%%% Set the name of the excel file to be read (input)
name_file = 'put_the_file_name.xlsx';


%%%%%%%%%%% Set the name of the file where the information will be saved (output)
f = fopen('output_filename.csv','w');

table = readtable(name_file);

%%%%%%%% Set the name of the variable to be read in the input file
table_results = table(:,{'Label', 'Area', 'Perim.', 'MinFeret'});

[a,~] = size(table_results);
Axon = [];
table_results = table2cell(table_results);
Fiber = [];
area_Axon = [];
perimeter_Axon = [];

feret_Axon = [];
feret_Fiber = [];

for i=1:a    
      area_Axon = [area_Axon area];
      feret_Axon = [feret_Axon cell2mat(table_results(i,5))];
      perimeter_Axon = [perimeter_Axon cell2mat(table_results(i,4))];        
end



fprintf(f, 'Area_Axon, Perimeter_Axon, Axon_MinFeretdistance, Axon_circle_diameter, ShapeAdjustedEllipse_Axon \n');

for i =1:length(area_Axon)  
    %%%%%%%%%%%%%%%%%%%%%%%%%%% CIRCLE
    circle_Axon = 2*sqrt(area_Axon(i)/3.14);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% SHAPE ADJUSTED ELLIPSE
    myfun =  @(x, area, perimeter) (-perimeter + 3.14*(x + (1/4)*x*((3.14*x^2-area)^2/(3.14*x^2+area)^2) + (1/64)*x*((3.14*x^2-area)^2/(3.14*x^2+area)^2)^2 + (1/256)*x*((3.14*x^2-area)^2/(3.14*x^2+area)^3))); %compute next iterate 
    perimeter = perimeter_Axon(i);
    area =  area_Axon(i);
    fun = @(x) myfun(x,area,perimeter);
    x = fzero(fun, 1);
  
    diameter_max_Axon = x;
    diameter_min_Axon = 2*area/(3.14*diameter_max_Axon);
    diameter_max_Axon = 2*x;
    if diameter_min_Axon > diameter_max_Axon
        aux_max = diameter_min_Axon;
        diameter_min_Axon = diameter_max_Axon;
        diameter_max_Axon = aux_max;
    end
    %%%%%%%%%%%%%% print the information
    fprintf(f, '%f , %f, %f, %f, %f \n', area_Axon(i),  perimeter_Axon(i), feret_Axon(i), circle_Axon, diameter_min_Axon);
end

fclose(f);
