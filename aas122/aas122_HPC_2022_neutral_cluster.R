# CMEE 2022 HPC exercises R code pro forma
# For neutral model cluster run


# Clear workspace and turn off graphics
rm(list=ls()) 
#graphics.off() 
dev.off

# Source the function file we need
#source("/rds/general/user/aas122/home/HPC_input/aas122_HPC_2022_main.R")
source("aas122_HPC_2022_main.R")

iter <- 165 ### local testing
#iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX")) ### cluster testing
set.seed(iter)

if (iter  %% 4 == 0){
  size = 500
} else if (iter %% 4 == 1){
  size = 1000
} else if (iter %% 4 == 2){
  size = 2500
} else {
  size = 5000 }

neutral_cluster_run(0.27,
                    size,
                    wall_time = 2,
                    1, 
                    size/10, 
                    8*size, 
                    output_file_name = paste("output_",iter,".rda",sep=""))


rm(size,iter)


  
