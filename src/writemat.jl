export writemat

function writeline(io::IO, line, format, delimiter::String; newline::Bool=true)
    n = length(line)

    for i in eachindex(line)
        @eval @printf($io, $format, $line[$i])
        if i<n
            @eval @printf($io, $"%s", $delimiter)
        end
    end
    if newline
        @eval @printf($io, $"%s", $"\n")
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
function writemat(filename::String, mat::Matrix; delimiter::Union{String, Char}=", ", format::String="%E")
    file = open(filename, "w")
    n, _ = size(mat)
    for i = 1:n-1
        writeline(file, mat[i,:], format, delimiter, newline=true)
    end
    writeline(file, mat[n,:], format, delimiter, newline=false)

    close(file)
end

function writemat(io::IO, mat::Matrix; delimiter::Union{String, Char})
end