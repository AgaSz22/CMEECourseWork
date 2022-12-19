# CMEE 2022 HPC exercises R code pro forma
# For neutral model cluster run


# Clear workspace and turn off graphics
rm(list=ls()) 
#graphics.off() 
dev.off

# Source the function file we need
source("/rds/general/user/aas122/home/HPC_input_stoch/aas122_HPC_2022_main.R")
#source("aas122_HPC_2022_main.R")

#iter <- 165 ### local testing
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX")) ### cluster testing
set.seed(iter)

if (iter  %% 4 == 0){
  initial_state <- c(0,0,0,100)
} else if (iter %% 4 == 1){
  initial_state <- c(0,0,0,10)
} else if (iter %% 4 == 2){
  initial_state <- c(25,25,25,25)
} else {
  initial_state <- c(3,3,2,2) }

list_of_populations <- stochastic_simulation(initial_state,
                      projection_matrix = matrix(c(0.1, 0.6, 0.0, 0.0,0.0, 0.4,
                                                    0.4, 0.0,0.0, 0.0, 0.7, 0.25,
                                                    2.6, 0.0, 0.0, 0.4),nrow=4,ncol=4),
                      clutch_distribution = c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03),
                      simulation_length = 120)

output_file_name = paste("stoch_output_",iter,".rda",sep="")

save(file = output_file_name,
     list_of_populations,
     iter)

rm(initial_state,iter)