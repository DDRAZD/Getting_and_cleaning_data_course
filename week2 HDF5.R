##week2 HDF5 files
##we will create and manipulate locally

library(rhdf5)
if(!file.exists("example2.h5")) {
        created = h5createFile("example2.h5")## notice thus is = and not <- 
}
created

##we are creating hirarchies within the file just like a tree. Again notice 
##the use of = 

##the groups are now empty, just creating the hirarchy

created = h5createGroup(file = "example2.h5", group = "foo")
created = h5createGroup(file = "example2.h5", group = "baa")
created = h5createGroup(file = "example2.h5", group = "foo/foobaa")

##see what the hirarchy or groups is, the hdf5 ls function
h5ls("example2.h5")

A <- matrix(1:10,nr=5,nc=2)
h5write(A, "example2.h5","foo/A")
B <- array(seq(0.1,2.0,by=0.1), dim = c(5,2,2))
attr(B,"scale")<-"liter"
h5write(B,"example2.h5", "foo/foobaa/B")
h5ls("example2.h5")

df <- data.frame(1L:5L, seq(0,1, length.out = 5), c("ab","cde","fghi","a","s"),stringsAsFactors = FALSE)
##writing directly to the top group in hdf5
h5write(df,"example2.h5","df")

readA<- h5read("example2.h5","foo/A")
readB<- h5read("example2.h5", "foo/foobaa/B")
readdf<- h5read("example2.h5","df")
                 