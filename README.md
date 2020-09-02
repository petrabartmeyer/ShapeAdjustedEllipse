# ShapeAdjustedEllipse
This folder contains implementations for the shape adjusted ellipse method to calculate the axon diameter for Julia, Matlab, and Excel.

The subfolder Julia contains the implementation using the Julia language, using the packages Roots.jl. This routine can made deliver the Shape Adjusted Analysis and also the assignment between inner and outer structures.
The subfolder Matlab contains the implementation using the Matlab language.  This routine can deliver the Shape Adjusted Analysis and the Assignment between inner and outer structures.
The subfolder Excel contains a spreadsheet with an example of calculating the Shape Adjusted Analysis in this platform. *** The assignment option is not available in Excel.


The options available in Matlab are descrived following:
Both folders contain two spreadsheets with examples 'input_assignment.xlsx' and 'input_SAE.csv'. The file 'input_assignment.xlsx' is an instance for the assignment plus the SAE analysis. The file 'input_SAE.csv' is an example of a simple SAE analysis. The difference in the extensions of the files '.xlsx' versus '.csv' is just to illustrate the extensions accepted. 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
Option 0 - Shape Adjusted Ellipse analysis
The essential INPUT data for the SAE analysis are the area, perimeter, maximum Feret, and minimum Feret. However, there is no need to remove the columns that will not be used in the analysis. Also, the information about the labeling of the inner and outer structures and the centroid can be skipped.
The OUTPUT of this routine is a .csv file with the area, perimeter, the diameter estimated using the formula for the circle area, the minimum Feret diameter, and the diameter calculated using the shape adjusted ellipse approach. 

The user has to assure that the columns' labelings are correct, as well as the labeling of the inner and outer structures. The columns labeling should be updated in line 24 of the code.


Option 1 - Assignment + Shape Adjusted Ellipse analysis
This folder contains two Matlab files 'shape_adjusted_calculation.m' and 'linear_sum_assignment.m'. The main file is 'shape_adjusted_calculation.m'; this is the file that should run in Matlab. The file 'linear_sum_assignment.m' is used to calculate the assignment of the inner and outer structures. 
The essential INPUT data for the SAE analysis are the area, perimeter, labeling of the outer and inner structures, centroids, maximum Feret, and minimum Feret. However, there is no need to remove the columns that will not be used in the analysis. The OUTPUT of this routine is a .csv file with the centroids, area, perimeter, the diameter estimated using the formula for the circle area, the minimum Feret diameter, and the diameter calculated using the shape adjusted ellipse approach.
The user has to assure that the columns' labelings are correct, as well as the labeling of the inner and outer structures. The columns labeling should be updated in line 90 of the code.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------


The ownership of the results and the implementation in these folders are from Petra Bartmeyer, Natalia Biscola, and Leif Havton.
For futher informations about the codes, please contact petra.bartmeyer<at>gmail.com. For informations about the biological data, please contact leif.havton<at>mssm.edu or natalia.biscola<at>mssm.edu
