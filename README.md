# MatPrint.jl
A simple package to write matrices using Printf.jl. It's really hacky, so don't judge me. I just wanted something to work similar to DelimitedFiles, but with a little more option.


Here's an example of using the package: 

```julia
using MatPrint

file = "../data/testlinefile.txt"

testmat = [1 0 0; 0 2 0; 0 0 3]
testformat = "%i"
        
writemat(file, testmat; format=testformat)
```
