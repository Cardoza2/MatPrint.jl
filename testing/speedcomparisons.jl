using BenchmarkTools, Format, MatPrint

path = dirname(@__FILE__)
cd(path)



testmat = reshape(collect(1.0:1.0:10000), 100, :)

@btime writemat("../data/testfile.txt", testmat) #C formatting
@btime writemat("../data/testfile.txt", testmat; format="{:E}") #Python formatting