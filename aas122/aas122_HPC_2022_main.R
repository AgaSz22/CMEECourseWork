# CMEE 2022 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Agnieszka Szwarczynska"
preferred_name <- "Agnes"
email <- "agnes.szwarczynska@imperial.ac.uk"
username <- "aas122"

# Please remember *not* to clear the workspace here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Question 1
species_richness <- function(community){
  unique_ind <- unique(community)
  number_of_ind <- length(unique_ind)
  
  return(number_of_ind)
}

# Question 2
init_community_max <- function(size){
  
 return(seq(1,size, by = 1))
}

# Question 3
init_community_min <- function(size){
  
  return(rep(size,size))
}


# Question 4
choose_two <- function(max_value){
  outcome <- sample(seq(1,max_value), 2, replace = FALSE)
  
  return(outcome)
}


# Question 5
neutral_step <- function(community){
  a <- choose_two(length(community)) #choosing two individuals
  community[a[1]] <- community[a[2]] #swapping individuals
  
  return(community)
}

# Question 6
neutral_generation <- function(community){ 
  steps <- round(jitter(length(community)/2)) #generating the number of steps within a generation according to the rules
  for (i in 1:steps){
    community <- neutral_step(community)
  }
  return(community)
}

# Question 7

neutral_time_series <- function(community,duration)  {
  a <- species_richness(community) #initial value of community species richness
  for (i in 1:duration){
    community <- neutral_generation(community)
    d <- species_richness(community)
    a <- c(a,d) #appending new values to the vector
  }
  return(a)
}

# Question 8
question_8 <- function() {
  time <- seq(0:200)
  
  png(filename="question_8.png", width = 600, height = 400)
  
  species_rich <- neutral_time_series(community = init_community_max(100), duration = 200)
  data <- ts(data = species_rich, start = 0, end = 200)
  plot(data,
       xlab = "Time (generations)", ylab = "Species richness",
       main = "Neutral model simulation: 
       changes in species richness over 200 generations")
  
  Sys.sleep(0.1)
  dev.off()
  
  return("The population reaches the state with much lower species richness than initially - at the end of a simulation all individuals belong to the same species. In a system with no random mutations or immigration events species richness can only decrease to the point when community reaches equlibrium. In this case, its the value of 1 beacause towards the end of the simulations we are randomly exchanging two individuals that already belong to the same species.")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {

  x <- runif(1) #randomly picking a probability value from a uniform distribution

  if (x > speciation_rate){
    a <- choose_two(length(community))
    community[a[1]] <- community[a[2]]
    
    return(community)
    
  }else{
    a <- choose_two(length(community))
    community[a[1]] <- (max(community))+1 #generating a new species
    
    return(community) 
  }  
}

# Question 10

neutral_generation_speciation <- function(community,speciation_rate)  {
  
  if (length(community) %% 2 == 1){
    
    steps <- round(jitter(length(community)/2)) #randomly rounding up or down if community length is not an even number
    for (i in 1:steps){
    community <- neutral_step_speciation(community, speciation_rate)
    }
  }else{
    steps <- length(community)/2 #dividing by two if community length is an even number
    for (i in 1:steps){
      community <- neutral_step_speciation(community, speciation_rate)
    }
    }
  return(community)
}

# Question 11

neutral_time_series_speciation <- function(community,speciation_rate,duration) {
  a <- species_richness(community)
  for (i in 1:duration){
    community <- neutral_generation_speciation(community, speciation_rate) #updating community state
    d <- (species_richness(community))
    a <- c(a,d) #generating a vector of changes in population richness over time
  }
  return(a)
}

# Question 12
question_12 <- function()  {
  
  library(ggplot2)
  time <- seq(0:200)  
  
  png(filename="question_12.png", width = 600, height = 400)
  
  species_rich_ab <- neutral_time_series_speciation(community = init_community_max(100),
                                                    speciation_rate = 0.1,  duration = 200)
  species_rich_poor <- neutral_time_series_speciation(community = init_community_min(100),
                                                      speciation_rate = 0.1, duration = 200)
  data_ab <- ts(data = species_rich_ab, start = 0, end = 200)
  data_poor <- ts(data = species_rich_poor, start = 0, end = 200)

  plot(x = time, y = data_ab, col = "blue", type = "l",
       xlab="Time (generations)", ylab="Species richness",
       main = "Neutral simulation with speciation")
  lines(x = time, y = data_poor, col = "red", type = "l")
  legend("topleft", legend=c("Max", "Min"),
         col=c("blue", "red"), lty = 1:1, cex=1.2)
  subtitle <- "Changes in species richness in two population with different initial species compositions"
  mtext(side=3, line=0.5, subtitle)
  
  Sys.sleep(0.1)
  dev.off()
  
  return("If the simulation is run long enough, we will observe that species richness of both communities converge and reach oscillating equilibrium. In a community with maximum initial species richness, species richness will decrease to the point where chances of a random species invading a niche of a different species (replacing it) are similar to chances of a new species arising. Similarily, in a community with minimial initial species richness, species richness can initially only increase. After some time, it will reach a point where new species will start to be replaced by other, 'invading', species.")
}

# Question 13
species_abundance <- function(community)  {
  
order_of_species <- sort(community)
individuals_within_spec <- table(order_of_species)
individuals_within_spec <- as.numeric(individuals_within_spec)
individuals_within_spec <- individuals_within_spec[order(individuals_within_spec,decreasing =T)] #sorting individuals in a right order so that they can be displayed correctly when assigned to octaves

return(individuals_within_spec) 
}

# Question 14
octaves <- function(abundance_vector) {
outcome <- tabulate(floor(log2(abundance_vector))+1)

return(outcome)
}

# Question 15

sum_vect <- function(x, y) {
 
  if (length(x) > length(y)){
    C <- x #creating a temporary variable for swapping x & y values
    x <- y
    y <- C
    rm(C)
    
} else {
    (x <- x)}

  for (i in 1:length(y)){   
    if (length(x) == length(y)){
      outcome = x + y
} else {
      x <- c(x,0)}
  }
  return(outcome)
  }

# Question 16 
question_16 <- function() {
  
  community_a <- init_community_max(100)
  community_b <- init_community_min(100)
  
  
###### initial 200 generation ###### 
  
  for (i in 1:200){
  
    community_max_ind <- neutral_generation_speciation(community_a, 0.1)
    community_a <- community_max_ind
  
    community_min_ind <- neutral_generation_speciation(community_b, 0.1)
    community_b <- community_min_ind}
    
    abundance_com_a <- species_abundance(community_a)
    abundance_com_b <- species_abundance(community_b)
    
    initial_oct_a <- octaves(abundance_com_a)
    initial_oct_b <- octaves(abundance_com_b)
  
###### next 2000 generation ###### 
  overall_vector_a <- initial_oct_a   
  overall_vector_b <- initial_oct_b 
  
  for (i in 1:2000){
    
    community_a <- neutral_generation_speciation(community_a, 0.1)
    community_b <- neutral_generation_speciation(community_b, 0.1)
    
    
    if (i %% 20 == 0){ #recording the species abundance octave vector every 20 generations
      vector_with_octaves_com_a <- octaves(species_abundance(community_a))
      vector_with_octaves_com_b <- octaves(species_abundance(community_b))
      
      overall_vector_a <- sum_vect(overall_vector_a, vector_with_octaves_com_a)
      overall_vector_b <- sum_vect(overall_vector_b, vector_with_octaves_com_b)
    }
  }
  
  mean_com_a <- overall_vector_a/101
  mean_com_b <- overall_vector_b/101

###### bar plot for the max initial population ######  
  names(mean_com_a) <- c(1:length(mean_com_a))   
  
  png(filename = "question_16_max.png", width = 600, height = 400)
  barplot(mean_com_a,
          main = "Octave plot of mean species abundance",
          ylim = c(0,15),
          xlab = "Octave classes",
          ylab = "Number of species",
  )
  
  Sys.sleep(0.1)
  dev.off()

###### bar plot for the min initial population ######   
  
names(mean_com_b) <- c(1:length(mean_com_b)) 
                  
  png(filename = "question_16_min.png", width = 600, height = 400)
  barplot(mean_com_b,
          main = "Octave plot of mean species abundance",
          ylim = c(0,15),
          xlab = "Octave classes",
          ylab = "Number of species",
          )
  
  Sys.sleep(0.1)
  dev.off()

###### Answer ######    
  return("Bar plots for both populations look very similar, regardless of the initial species composition. It is because we are looking at the mean species abundance octaves collected after the 'burn-in' period. It means that we are considering values of species abundance in populations that reached similar species richness values. Additionally, the deviations in the values of species abundance in both populations at different time points have been reduced by the operation of averaging.")
}

# Question 17
neutral_cluster_run <- function(speciation_rate, size, wall_time, 
                                interval_rich, interval_oct, 
                                burn_in_generations, 
                                output_file_name) {
  
### step 1st ### 
  
initial_community <- init_community_min(size)

### step 2nd ### 
start_time <- as.numeric(Sys.time())
community <- initial_community 
time_series <- c()
list_species_abundance <- list()

i <- 1
j <- 1

while (as.numeric(Sys.time()) - start_time < (wall_time*60)){
                        ###make sure which step runs first and correct initial community
#  community <- neutral_generation_speciation(community, speciation_rate)  

### step 3rd ###

  if (i <= burn_in_generations){
    community <- neutral_generation_speciation(community,speciation_rate)    
    if (i %% interval_rich == 0){
  
    time_series <- c(time_series, species_richness(community))
  }
  
  ### step 4th ###
  
  }else if (i > burn_in_generations){
    if ( i%%interval_oct == 0){
    community <- neutral_generation_speciation(community,speciation_rate) 
  list_species_abundance[[j]] <- octaves(species_abundance(community))
  j <- j+1
  
  }
  }
    
  i <- i+1  
  
}


# simulation is finished
end_time = as.numeric(Sys.time())
total_time = (end_time - start_time)/60

#save the output
save(file = output_file_name, 
     time_series,
     list_species_abundance,
     community,
     speciation_rate,
     size,
     interval_rich,
     interval_oct,
     burn_in_generations,
     wall_time,
     total_time)

return(0)
}


# Questions 18 and 19 involve writing code elsewhere to run your simulations on
# the cluster

# Question 20 
process_neutral_cluster_results <- function() {
  
  updated_octaves_size_1 <- c(0)
  updated_octaves_size_2  <- c(0)
  updated_octaves_size_3  <- c(0)
  updated_octaves_size_4  <- c(0)
  
  for (i in 1:100){
    iter <- i
    
    file_name <- paste("output_",iter,".rda",sep="") 
    #path <- "/home/agnes/Documents/CMEECourseWork/HPC/aas122/deterministic/output/HPC_output/" 
    #local testing
    path <- "./"
    path_to_file <- paste(path,file_name,sep="")
    #print(path_to_file)
    
    # "/home/agnes/Documents/CMEECourseWork/HPC/aas122/deterministic/output/HPC_output_stoch/stoch_output_6.rda" local testing
    
    load(file = path_to_file)
    
  if (length(list_species_abundance) != 0){
    
    if (iter %% 4 == 0) {
      for (element in 1:length(list_species_abundance)) {
      updated_octaves_size_1 <- sum_vect(updated_octaves_size_1, list_species_abundance[[element]])} 
      
      updated_octaves_size_1  <- updated_octaves_size_1/length(list_species_abundance)
      print(iter)
      
  } else if (iter %% 4 == 1) {
      
      for (element in 1:length(list_species_abundance)) {
        updated_octaves_size_2 <- sum_vect(updated_octaves_size_2, list_species_abundance[[element]])}
      
      updated_octaves_size_2 <- updated_octaves_size_2/length(list_species_abundance)
        print(iter)
      
  } else if (iter %% 4 == 2) {
      
      for (element in 1:length(list_species_abundance)) {
        updated_octaves_size_3 <- sum_vect(updated_octaves_size_3, list_species_abundance[[element]])}
      
      updated_octaves_size_3 <- updated_octaves_size_3/length(list_species_abundance)
        print(iter)
      
  } else {
      
      for (element in 1:length(list_species_abundance)) {
        updated_octaves_size_4 <- sum_vect(updated_octaves_size_4, list_species_abundance[[element]])}
      
      updated_octaves_size_4 <- updated_octaves_size_4/length(list_species_abundance)
        print(iter)
    }
  } else { (next)}
    
  }

#create your list output here to return
combined_results <- list(updated_octaves_size_1, updated_octaves_size_2, updated_octaves_size_3, updated_octaves_size_4) 

# save results to an .rda file
save(combined_results, file = "./deterministic_list_for_plotting.rda")
return(0)
}

plot_neutral_cluster_results <- function(){

    # load combined_results from your rda file
    load(file = "./deterministic_list_for_plotting.rda")
  
    png(filename="plot_neutral_cluster_results.png", width = 600, height = 400)
    
    bar_1_res <- combined_results[[1]]
    bar_2_res <- combined_results[[2]]
    bar_3_res <- combined_results[[3]]
    bar_4_res <- combined_results[[4]]
    
    par(mfrow = c(2,2))
    
    names_for_barplots <- c("1","2","3","4","5","6")
    names_for_barplot_2 <- c("1","2","3","4","5","6","7")
    
    barplot_1 <- barplot(bar_1_res,
            main = "Population size: 500",
            ylab = "Number of species",
            xlab = "Ocatve classes",
            ylim = c(0, 200),
            names.arg = names_for_barplots) 
    
    barplot_2 <- barplot(bar_2_res,
                        main = "Population size: 1000",
                        ylab = "Number of species",
                        xlab = "Ocatve classes",
                        ylim = c(0, 400),
                        names.arg = names_for_barplot_2)
    
    barplot_3 <- barplot(bar_3_res,
                        main = "Population size: 2500",
                        ylab = "Number of species",
                        xlab = "Ocatve classes",
                        ylim = c(0, 800),
                        names.arg = names_for_barplots)
    
    barplot_4 <- barplot(bar_4_res,
                         main = "Population size: 5000",
                         ylab = "Number of species",
                         xlab = "Ocatve classes",
                         ylim = c(0, 1600),
                         names.arg = names_for_barplots)
    
    mtext("Neutral cluster simulations - mean species abundance octaves", side = 3, line = -1.5, outer = TRUE)
    
    Sys.sleep(0.1)
    dev.off()
    
    return(combined_results)
}


# Question 21
state_initialise_adult <- function(num_stages,initial_size){
  
  vector <- rep(0, num_stages)
  vector[num_stages] <- initial_size
  return(vector)
  
}

# Question 22
state_initialise_spread <- function(num_stages,initial_size){
  
  vector <- rep(0, num_stages)
  
  if (initial_size %% num_stages == 0) {
    vector[seq(num_stages)] <- rep(initial_size/num_stages, num_stages)

 }else { 
    for (i in 1:(initial_size %% num_stages)){
      vector[i] <- (initial_size %/% num_stages)+ 1
    }
    for (i in ((initial_size %% num_stages)+1): num_stages){
      vector[i] <- floor(initial_size/num_stages)

    }
  }
  
  return(vector)  
}

# Question 23
deterministic_step <- function(state,projection_matrix){
  
  new_state <- rep(0, length(state))
  
  for (i in 1:length(state)){
    
    if (i == 1){
    new_state[i] <- projection_matrix[i,i]*state[i] + projection_matrix[i,dim(projection_matrix)[2]]*state[length(state)]
    
    } else {
    new_state[i] <- projection_matrix[i,i]*state[i] + projection_matrix[i,i-1]*state[i-1] 
    }
    
  }
  return(new_state)
  
}

# Question 24
deterministic_simulation <- function(initial_state,projection_matrix,simulation_length){
  
  population <- rep(0,simulation_length)
  population[1] <- sum(initial_state)
  
  for (i in 1:simulation_length){
  
  initial_state <- deterministic_step(initial_state, projection_matrix)
  temp_population <- sum(initial_state)
  population[i+1] <- temp_population 

  }
  return(population)
}

# Question 25
question_25 <- function(){
  
png(filename="question_25.png", width = 600, height = 400)
  
  num_stages <- 4
  simulation_length <- 24
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,0.0, 0.4, 0.4, 
                                0.0,0.0, 0.0, 0.7, 0.25,2.6, 0.0, 
                                0.0, 0.4),nrow=4,ncol=4)
  
  vector_a <- state_initialise_adult(num_stages, 100)
  vector_b <- state_initialise_spread(num_stages, 100)
  
  simulation_a <- deterministic_simulation(vector_a, projection_matrix, simulation_length)
  simulation_b <- deterministic_simulation(vector_b, projection_matrix, simulation_length)
  
  ts_a <- ts(data = simulation_a, start = 1, end = as.numeric((simulation_length)+1))
  ts_b <- ts(data = simulation_b, start = 1, end = as.numeric((simulation_length)+1))

  plot(ts_a, main = "Changes in the number of individuals across deterministic simulations
       in two populations with different age structure",
       xlab = "Time (simulations)",
       ylab = "Population (number of individuals)")
  lines(ts_b, col = "red", type = "l")
  legend("topleft", legend=c("Population of adults", "Mixed population"),
         col=c("black", "red"), lty = 1:1, cex=1.2)


  Sys.sleep(0.1)
  dev.off()

  return("Both populations constantly increase in number with time. However, the population with a higher initial number of adults has also a higher overall number of individuals at any time point compared with the second populations. We can observe this trend because all organisms in this group start producing offspring already during the initial phase of the simulation. In the second population, individuals in their early life stages have to survive and mature before they are capable of reproducing.")
}

# Question 26
trinomial <- function(pool,probs) {
  
  if (probs[1] == 1){ #fixed outcome
    outcome <- c(pool,0,0)
  } else if (probs[1] + probs[2] == 1) { #individuals only in the first two stages
    outcome <- c(pool,0,0)
    outcome[1] <- rbinom(1, pool, probs[1])
    outcome[2] <- pool - outcome[1]
    outcome[3] <- 0
  } else {
    ind_first_stage <- rbinom(1, pool, probs[1])
    remaining_pool <- pool - ind_first_stage
    prob_event_2 <- probs[2]/(1-probs[1])
    ind_second_stage <- rbinom(1, remaining_pool, prob_event_2)
    ind_third_stage <- pool - (ind_first_stage + ind_second_stage)
    outcome <- c(ind_first_stage, ind_second_stage, ind_third_stage)
  }
  return(outcome)
}

# Question 27
survival_maturation <- function(state, projection_matrix) {
  new_state <- rep(0,length(state))

  for (i in 1:(length(state)-1)){ #all life stages except the final life stage
    ind_in_stage_i <- state[i]
    prob <- c(projection_matrix[i,i], projection_matrix[i+1, i], 
              1 - (projection_matrix[i,i] + projection_matrix[i+1, i])) #appropriate probabilities from the projection matrix
    next_step <- trinomial(ind_in_stage_i, prob) 
    new_state[i] <- new_state[i] + next_step[1]
    new_state[i+1] <- new_state[i+1] + next_step[2]
  }
  ind_in_last_stage <- state[length(state)]
  ind_in_last_stage_survived <- rbinom(1, ind_in_last_stage, 
                                       projection_matrix[length(state),length(state)])
  
  new_state[length(state)] <- ind_in_last_stage_survived + next_step[i-1] #survived + those that matured
  return(new_state)
}

# Question 28
random_draw <- function(probability_distribution) {
  probability <- runif(1)
  cumulative_probability_distribution <- cumsum(probability_distribution)
  
  for (i in 1:length(probability_distribution)){

    if (probability <= cumulative_probability_distribution[i]){
      outcome <- i 
      return(outcome)
    }
  }
  return(length(cumulative_probability_distribution)) #this line helps to generate the correct output when the probability is high - not sure why
}

# Question 29
stochastic_recruitment <- function(projection_matrix,clutch_distribution){
  
mean_clutch_size <- sum(clutch_distribution * c(1:length(clutch_distribution)))
recruitment_probability <- (projection_matrix[1,dim(projection_matrix)[2]])/mean_clutch_size
return(recruitment_probability) 
  
}

# Question 30
offspring_calc <- function(state,clutch_distribution,recruitment_probability){
  
number_of_adults <- state[length(state)]
adults_recruiting <- rbinom(1, number_of_adults, recruitment_probability)


  if (adults_recruiting == 0){
    offspring = 0
    
  } else {
    
    offspring <- rep(0,adults_recruiting)
    
    for (i in 1:adults_recruiting){
        clutch_size <- random_draw(clutch_distribution)
        offspring[i] <- clutch_size
    }
  }

total_offspring <- sum(offspring)

return(total_offspring)
}

# Question 31
stochastic_step <- function(state,projection_matrix,clutch_distribution,recruitment_probability){
  
  new_state <- survival_maturation(state, projection_matrix)
  offspring <- offspring_calc(state, clutch_distribution, recruitment_probability)
  new_state[1] <- new_state[1] + offspring
  
  return(new_state)
}

# Question 32
stochastic_simulation <- function(initial_state,projection_matrix,clutch_distribution,simulation_length){

  recruitment_probability <- stochastic_recruitment(projection_matrix, clutch_distribution)
  population_size_total <- rep(0, (simulation_length+1))
  population_size_total[1] <- sum(initial_state)
  
  for (i in 1:simulation_length){
    initial_state <- stochastic_step(initial_state,projection_matrix,
                                     clutch_distribution,recruitment_probability)
    
    if (sum(initial_state) == 0){
      population_size <- sum(initial_state)  
      population_size_total[i+1] <- population_size
      
      return(population_size_total)
    }
    
    population_size <- sum(initial_state)
    population_size_total[i+1] <- population_size

  }
  return(population_size_total)
}

# Question 33
question_33 <- function(){
  
  png(filename="question_33.png", width = 600, height = 400)

  num_stages <- 4
  simulation_length <- 24
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,0.0, 0.4, 0.4, 
                                0.0,0.0, 0.0, 0.7, 0.25,2.6, 0.0, 
                                0.0, 0.4),nrow=4,ncol=4)
  
  clutch_distribution <-c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)
  
  vector_a <- state_initialise_adult(num_stages, 100)
  vector_b <- state_initialise_spread(num_stages, 100)
  
  simulation_a_sto <- stochastic_simulation(vector_a, projection_matrix, 
                                        clutch_distribution, simulation_length)
  simulation_b_sto <- stochastic_simulation(vector_b, projection_matrix,
                                        clutch_distribution, simulation_length)
  
  ts_a <- ts(data = simulation_a_sto, start = 1, end = as.numeric((simulation_length)+1))
  ts_b <- ts(data = simulation_b_sto, start = 1, end = as.numeric((simulation_length)+1))
  
  plot(ts_a, main = "Changes in the number of individuals across stochastic simulations
       in two populations with different age structure",
       xlab = "Time (simulations)",
       ylab = "Population (number of individuals)")
  lines(ts_b, col = "red", type = "l")
  legend("topleft", legend=c("Population of adults", "Mixed population"),
         col=c("black", "red"), lty = 1:1, cex=1.2)
  

  Sys.sleep(0.1)
  dev.off()
  
  return("In this case, both growth curves are much more 'wobbly', regardless of the seed number of a simulation. It is caused by the introduction of random events, such as sudden death of many individuals or a particularly big clutch size. This approach reflects processes taking place in the natural environment better than deterministic projections.")
}

# Questions 34 and 35 involve writing code elsewhere to run your simulations on the cluster

#Question 36
question_36 <- function(){

png(filename="question_36.png", width = 600, height = 400)

list_con_1 <- c()
list_con_2 <- c()
list_con_3 <- c()
list_con_4 <- c()

  for (i in 1:1000){
    iter <- i
    
    file_name <- paste("stoch_output_",iter,".rda",sep="") 
    #path <- "/home/agnes/Documents/CMEECourseWork/HPC/aas122/stochastic/output/HPC_output_stoch/" 
    #local testing
    path <- "./"
    path_to_file <- paste(path,file_name,sep="")
    #print(path_to_file)
    
   # "/home/agnes/Documents/CMEECourseWork/HPC/aas122/stochastic/output/HPC_output_stoch/stoch_output_6.rda"  - local testing
    
    load(file = path_to_file)
    
    if (iter %% 4 == 0) { #initial_state <- c(0,0,0,100)
      conditions_1 <- list_of_populations[length(list_of_populations)]
      list_con_1 <- c(list_con_1,conditions_1)
    } else if (iter %% 4 == 1) { #initial_state <- c(0,0,0,10)
      conditions_2 <- list_of_populations[length(list_of_populations)]
      list_con_2 <- c(list_con_2,conditions_2)
    } else if (iter %% 4 == 2) { #initial_state <- c(25,25,25,25)
      conditions_3 <- list_of_populations[length(list_of_populations)]
      list_con_3 <- c(list_con_3,conditions_3)
    } else { #initial_state <- c(3,3,2,2)
      conditions_4 <- list_of_populations[length(list_of_populations)]
      list_con_4 <- c(list_con_4,conditions_4)
    }
  }

extinct_in_group_1 <- sum(list_con_1 == 0)/250
extinct_in_group_2 <- sum(list_con_2 == 0)/250
extinct_in_group_3 <- sum(list_con_3 == 0)/250
extinct_in_group_4 <- sum(list_con_4 == 0)/250

extinctions_in_all_groups <- c(extinct_in_group_1, extinct_in_group_2, extinct_in_group_3, extinct_in_group_4)

names_for_conditions <- c("100 adults", "10 adults", "equal no. of ind.", "10 ind. spread")

barplot(extinctions_in_all_groups,
        main = "Extinction rate after 250 stochastic simulations 
        run on four populations with different initial compostions",
        ylab = "Proportion of simulations resulting in extinction",
        ylim = c(0, 0.09),
        names.arg = names_for_conditions
        )

   Sys.sleep(0.1)
   dev.off()
  
   return("Populations that were most likely to go extinct consisted of a small number of individuals in the final life stage (up to ten). These populations had lower chances of producing sufficient amounts of offspring to sustain a stable or growing population before they experienced high death rates. Populations with a significant proportion of adults could regenerate even after they were subjected to temporary low survival and maturation rates or small clutch sizes.")
}

# Question 37
question_37 <- function(){
  
 
  
  
  png(filename="question_37_small", width = 600, height = 400)
  # plot your graph for the small initial population size here
  Sys.sleep(0.1)
  dev.off()
  
  png(filename="question_37_large", width = 600, height = 400)
  # plot your graph for the large initial population size here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}



# # Challenge questions - these are optional, substantially harder, and a maximum
# # of 14% is available for doing them. 
# 
# # Challenge question A
# Challenge_A <- function() {
#   
#   
#   
#   png(filename="Challenge_A_min", width = 600, height = 400)
#   # plot your graph here
#   Sys.sleep(0.1)
#   dev.off()
#   
#   png(filename="Challenge_A_max", width = 600, height = 400)
#   # plot your graph here
#   Sys.sleep(0.1)
#   dev.off()
# 
# }
# 
# # Challenge question B
# Challenge_B <- function() {
#   
#   
#   
#   png(filename="Challenge_B", width = 600, height = 400)
#   # plot your graph here
#   Sys.sleep(0.1)
#   dev.off()
# 
# }
# 
# # Challenge question C
# Challenge_C <- function() {
#   
#   
#   
#   png(filename="Challenge_C", width = 600, height = 400)
#   # plot your graph here
#   Sys.sleep(0.1)
#   dev.off()
# 
# }
# 
# # Challenge question D
# Challenge_D <- function() {
#   
#   
#   
#   png(filename="Challenge_D", width = 600, height = 400)
#   # plot your graph here
#   Sys.sleep(0.1)
#   dev.off()
#   
#   return("type your written answer here")
# }
# 
# # Challenge question E
# Challenge_E <- function(){
#   
#   
#   
#   png(filename="Challenge_E", width = 600, height = 400)
#   # plot your graph here
#   Sys.sleep(0.1)
#   dev.off()
#   
#   return("type your written answer here")
# }

# # Challenge question F
# Challenge_F <- function(){
#   
#   
#   
#   png(filename="Challenge_F", width = 600, height = 400)
#   # plot your graph here
#   Sys.sleep(0.1)
#   dev.off()}
