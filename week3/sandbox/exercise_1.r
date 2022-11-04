pop1<-list(species='Cancer magister',
           latitude=48.3,longitude=-123.1,
           startyr=1980,endyr=1985,
           pop=c(303,402,101,607,802,35))
pop1

pop1<-list(lat=19,long=57,
           pop=c(100,101,99))
pop2<-list(lat=56,long=-120,
           pop=c(1,4,7,7,2,1,2))
pop3<-list(lat=32,long=-10,
           pop=c(12,11,2,1,14))
pops<-list(sp1=pop1,sp2=pop2,sp3=pop3)
pops



pops[[3]]$pop[3] <-102
pops

MyMat <- matrix(1:8, 4, 4)
MyMat

MyDF <- as.data.frame(MyMat)
MyDF

object.size(MyMat)
object.size(MyDF)

seq(1,10,0.5)
?seq

seq(from=1,to=10, by=0.5) 

MyVar <- c( 'a' , 'b' , 'c' , 'd' , 'e' )
MyVar[c(1,2,3)]
MyVar[c(3,2,1)]
MyVar[c(3,2,4)]
MyVar[c(3,2,4,4)]

v <- c(0, 1, 2, 3, 4) 
v[-3]
v <- v[-3]
v
v[c(1,4)]

mat1 <- matrix(1:25, 5, 5, byrow=TRUE) #create a matrix
mat1
mat1[1,2]
mat1[1,2:4]
mat1[2:4,2:4]
mat1[1,]
mat[,1]


b <- c(1,5) + 2
b
a <- c(5,2) + 2
a

x <- c(1,2); y <- c(5,3,9)
x;y

x + y

x + c(y,1)

v <- c(0,1,2,3,4)
v2 <- v*2
v2

t(v)

v %*% t(v) 

v3 <-1:7
v3
v4 <- c(v3,v2)
v4

paste("Quercus", "robur",sep = ",")

paste('Year is:',1990:2000)


strsplit("cat;dog",';')

log(v3)
exp(5)
floor(5)

floor(6)
ceiling(7)

var(v3)
range(v3)
quantile(v3, 0.05)
summary(v3)

k <- c(1,2,3,4)
i <- c(4,5,6)

union(k,i)
intersect(k,i)
setdiff(k,i)

h <- c(1,2,3,3)
m <- c(1,2,2,3)
setequal(h,m)
is.element(3,h)

set.seed(1234567)
rnorm(1)

rnorm(10)

set.seed(1234567)
rnorm(11)

rnorm(15)
rnorm(15)

getwd()

MyData <- read.csv("../../week3/data/trees.csv")
ls(pattern = "My*")

head(MyData)
str(MyData)
write.csv(MyData, "../../week3/results/trees.csv")
dir("../../week3/results/") 