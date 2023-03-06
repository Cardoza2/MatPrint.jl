using Test, MatPrint, DelimitedFiles

path = dirname(@__FILE__)
cd(path)

mp = MatPrint

@testset "Writing" begin
    @testset "writeline" begin
        file = open("../data/testlinefile.txt", "w")

        testline = [1 2 3]
        testformat = "%i"
        testdelim = ", "

        mp.writeline(file, testline, testformat, testdelim;newline=false)
        close(file)

        test1 = readdlm("../data/testlinefile.txt", ',', Int)
        @test testline==test1
    end #End writeline() test set

    @testset "writemat" begin
        file = "../data/testlinefile.txt"

        testmat = [1 0 0; 0 2 0; 0 0 3]
        testformat = "%i"
        
        writemat(file, testmat; format=testformat)

        test2 = readdlm("../data/testlinefile.txt", ',', Int)
        @test test2==testmat

    end #End writemat() test set
end #End Writing test set

