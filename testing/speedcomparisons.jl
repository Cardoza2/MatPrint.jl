using BenchmarkTools, Format, MatPrint

path = dirname(@__FILE__)
cd(path)

file = open("../data/testfile.txt", "w")

printfmt(file, "{:E}", 6000)
print(file, ", ")
print(file, cfmt("%E", 12000))

close(file)

function formatprint(mat)
    n, m = size(mat)
    file = open("../data/testfile.txt", "w")

    for i = 1:n
        for j = 1:m
            if j<m
                printfmt(file, "{:E}", mat[i,j])
                printfmt(file, "{:s}", ", ")
            else
                printfmt(file, "{:E}", mat[i,j])
                printfmt(file, "{:s}", "\n")
            end
        end
    end
    close(file)
end

# testmat = reshape(collect(1.0:1.0:10000), 100, :)

# formatprint(testmat)

# @btime formatprint(testmat)
# @btime writemat("../data/testfile.txt", testmat)