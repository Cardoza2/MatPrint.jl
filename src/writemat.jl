export writemat



function cprint(file, mat, format, delimiter)
    n, m = size(mat)

    for i = 1:n
        for j = 1:m
            print(file, cfmt(format, mat[i,j]))

            if j<m
                print(file, delimiter)
            else
                print(file, "\n")
            end
        end
    end
end


function fprint(file, mat, format, delimiter)
    n, m = size(mat)

    for i = 1:n
        for j = 1:m
            printfmt(file, format, mat[i,j])

            if j<m
                print(file, delimiter)
            else
                print(file, "\n")
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
        print(file, "\n")
    else
        file = open(filename, "w")
    end

    if contains(format, "{")
        fprint(file, mat, format, delimiter)
        
    else
        cprint(file, mat, format, delimiter)
    end


    close(file)
end



