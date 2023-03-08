export writemat

function writeline(io::IO, line, format, delimiter::String; newline::Bool=true)
    n = length(line)

    for i in eachindex(line)
        @eval @printf($io, $format, $line[$i])
        if i<n
            @eval @printf($io, $"%s", $delimiter)
        end
    end

    # string = "" #Todo: I need a vector of any, because the delimiter and the entries require different formatting strings... I wonder if I could format the entries, then stick them in one long string, then print that. 
    # for i in eachindex(line)
    #     string *= string(line[i])
    #     if i<n
    #         string *= string(delimiter)
    #     end
    # end
    # @eval @printf()

    if newline
        @eval @printf($io, $"%s", $"\n")
    end
end

function printformat(file, mat, format, delimiter) #TODO: Probably put writeline into this function. No need to have it twice. 
    n, _ = size(mat)

    if n==1
        writeline(file, mat[1,:], format, delimiter, newline=false)
    else
        for i = 1:n-1
            writeline(file, mat[i,:], format, delimiter, newline=true)
        end
        writeline(file, mat[n,:], format, delimiter, newline=false)
    end
end


function fprint(file, mat, format, delimiter)
    n, m = size(mat)

    for i = 1:n
        for j = 1:m
            if j<m
                printfmt(file, format, mat[i,j])
                printfmt(file, "{:s}", delimiter)
            else
                printfmt(file, format, mat[i,j])
                printfmt(file, "{:s}", "\n")
            end
        end
    end
end

"""
writemat(filename, mat; delimiter=", ", format="%E")

### Inputs
- filename::String - A String containing the path and filename. 
- mat::Matrix - The matrix of values to be written to file. 
- delimiter::Union{String, Char} - The delimiter. 
- format::String - the C++ Printf string. 

### Outputs
- A file is written. 
"""
function writemat(filename::String, mat::Matrix; delimiter::Union{String, Char}=", ", format::String="%E", append::Bool=false)
    if append
        #TODO: I don't know if I'll need to check if the file exists or not. 
        file = open(filename, "a")
        @eval @printf($file, $"%s", $"\n")
    else
        file = open(filename, "w")
    end

    if contains(format, "{")
        fprint(file, mat, format, delimiter)
        
    else
        cprint(file, mat, format, delimiter)
    end
    
    formatprint(file, mat, format, delimiter)

    close(file)
end

function writemat(io::IO, mat::Matrix; delimiter::Union{String, Char})
end


#= I got this from discourse. 
julia> x = rand(100_000);

julia> foo(x) = open("/tmp/test.csv", "w") do f 
           for v in x
               @printf(f, "%16.8f\n",v)
           end
       end
foo (generic function with 1 method)

julia> goo(x) = open("/tmp/test2.csv", "w") do f 
           fspec = FormatExpr("{:16.8f}")
           for v in x
               printfmtln(f, fspec, v)
           end
       end
goo (generic function with 1 method)

julia> @btime foo($x)
  36.167 ms (11 allocations: 688 bytes)

julia> @btime goo($x)
  52.566 ms (500032 allocations: 9.92 MiB)




  Also: https://github.com/JuliaString/Format.jl
  =#