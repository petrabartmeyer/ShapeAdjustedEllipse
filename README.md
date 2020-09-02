# ShapeAdjustedEllipse
This folder contains implementations for the shape adjusted ellipse method for calculating axon diameter for Julia, Matlab, and Excel.

The subfolder Julia contains the implementation using the Julia language, using the packages Roots.jl. This routine is able to made deliver the Shape Adjusted Analysis and also the Assigment between inner and outer structures.
The subfolder Matlab contains the implementation using the Matlab language.  This routine is able to made deliver the Shape Adjusted Analysis and also the Assigment between inner and outer structures.
The subfolder Excel contains a spreadsheet with an example of how to calculate the Shape Adjusted Analysis in this platform.

Both options available in Julia and Matlab are descrived following:
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
Option 1 - Shape Adjusted Ellipse analysis
The essential INPUT data for the SAE analysis are the area, perimeter, maximum Feret, and minimum Feret. However, there is no need of removing the columns that will not be used in the analysis. Also, the informations about the labelling of the inner and outer structures and the centroid can be skipped.
The OUTPUT of this routine is a .csv file with the area, perimeter, the diameter estimated using the formula for the circle area, the minimum Feret diameter, and the diameter calculated using the shape adjusted ellipse approach.


Option 2 - Assigment + Shape Adjusted Ellipse analysis
The essential INPUT data for the SAE analysis are the area, perimeter, labelling of the outer and inner structures, centroids, maximum Feret, and minimum Feret. However, there is no need of removing the columns that will not be used in the analysis. The OUTPUT of this routine is a .csv file with the centroids, area, perimeter, the diameter estimated using the formula for the circle area, the minimum Feret diameter, and the diameter calculated using the shape adjusted ellipse approach.
The user has to assure that the columns labellings are correct, as well as, the labelling of the inner and outer strucures. 
*** The assigment option is not available in Excel.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------


The ownership of the results and the implementation in these folders are from Petra Bartmeyer, Natalia Biscola, and Leif Havton.
For futher informations about the codes, please contact petra.bartmeyer<at>gmail.com. For informations about the biological data, please contact leif.havton<at>mssm.edu or natalia.biscola<at>mssm.edu
