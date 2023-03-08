using Test, MatPrint, DelimitedFiles

path = dirname(@__FILE__)
cd(path)

mp = MatPrint

@testset "Writing" begin

    @testset "writemat" begin
        #Test writing a basic matrix
        file = "../data/testlinefile.txt"
        testmat = [1 0 0; 0 2 0; 0 0 3]
        testformat = "%i"
        writemat(file, testmat; format=testformat)
        test2 = readdlm("../data/testlinefile.txt", ',', Int)
        @test test2==testmat

        #Test writing a one line matrix. 
        testmat = [1 2 3]
        writemat(file, testmat; format=testformat)
        test3 = readdlm("../data/testlinefile.txt", ',', Int)
        @test test3==testmat

        #Test appending a matrix to a file. 
        testmat = [3 3]
        writemat(file, testmat; format=testformat)
        testmat = [1 2 3; 4 5 6; 7 8 9]
        writemat(file, testmat; format=testformat, append=true)
        test4 = readdlm("../data/testlinefile.txt", ',', Int, skipstart=1)
        @test test4==testmat #Todo: Add a test to make sure that it actually appended the values I expect. 

        #Test writing negative values to file. 
        testmat[2,1] *= -1
        writemat(file, testmat; format=testformat)
        test5 = readdlm("../data/testlinefile.txt", ',', Int)
        @test test5==testmat

    end #End writemat() test set
end #End Writing test set

