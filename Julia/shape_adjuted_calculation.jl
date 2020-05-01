
using Roots

function newton(perimetro, area, x_initial)


f(x) = -perimetro + 3.14*(x + (1/4)*x*((3.14*x^2-area)^2/(3.14*x^2+area)^2) + (1/64)*x*((3.14*x^2-area)^2/(3.14*x^2+area)^2)^2 + (1/256)*x*((3.14*x^2-area)^2/(3.14*x^2+area)^3)  + area/(3.14*x) + (area/(3.14*x))*((3.14*x^2-area)^2/(3.14*x^2+area)^2)/4 + (area/(3.14*x))*(((3.14*x^2-area)^2/(3.14*x^2+area)^2)^2)/64 + (area/(3.14*x))*(((3.14*x^2-area)^2/(3.14*x^2+area)^2)^3)/256)
diameter_max = find_zero(f, 0.52)
diameter_min = area/(3.14*diameter_max)
if diameter_min > diameter_max
aux_max = diameter_min
diameter_min = diameter_max
diameter_max = aux_max

end
return 2*diameter_max, 2*diameter_min

end


function main()
##### T is a mx2 matrix, where the first column is the area and the second column is the perimeter of each axon
T= []

area = T[:,1]
perimeter = T[:,2]
#######Set the name of the file where the information will be saved (output)
f = open("output_filename.csv","w")
for i=1:length(area)

	diam_max, diam_min = newton(perimeter[i],area[i],0.5)
	print(f, diam_min, "\t", diam_max)
	println(f)

end

close(f)

end
