# MatPrint.jl
A simple package to write matrices using Format.jl. It's kinda hacky and really quite simple, so don't judge me. I just wanted something to work similar to DelimitedFiles, but with a few more options. Since it uses Format.jl, it can accept either C formatting strings, or Python formatting strings. 


Here's an example of using the package: 

```julia
using MatPrint

file = "../data/testlinefile.txt"

testmat = [1 0 0; 0 2 0; 0 0 3]
testformat = "%i"
        
writemat(file, testmat; format=testformat)
```

Here are some handy websites that have formatting strings: 
https://cplusplus.com/reference/cstdio/printf/
https://docs.python.org/2/library/string.html#format-string-syntax


I don't know why, but the C formatting takes less time and memory, even though Format.jl says that it's slower in their package. Here is a benchmark writing a 100x100 matrix. 

2.676 ms (40011 allocations: 4.65 MiB) #C formatting
12.180 ms (190012 allocations: 12.74 MiB)  #Python formatting