module MatPrint

using Format

#Todo: Add capability to write to io.  
#Todo: Potentially add reading capabilities, but DelimitedFiles should suffice.
#Todo: I should probably check to see how it behaves when writing negative values and how it formats. -> It just interjects a negative (Kind of ruins the pretty formatting.)
#Todo: I should probably add capability to write an array. 
# println(pwd())
# println(readdir())

include("writemat.jl")

end # module MatPrint
