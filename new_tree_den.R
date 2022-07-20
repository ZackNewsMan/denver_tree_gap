library(tidyverse)

left_join(operations_2020, basa_2020, by = "neighborhood")

  # Left out of some rows, basa_2020 has 68 more rows.

left_join(basa_2020, operations_2020, by = "neighborhood") %>% 
  View()

  # Worked swimmingly

  basa_op_2020 <- left_join(basa_2020, operations_2020, by = "neighborhood") 

    basa_op_2020 %>% 
      mutate(total_trees = tree_count.x + tree_count.y) %>% 
      View()
    
    # Want to tell mutate to ignore blanks in tree_count.y
    
    basa_op_2020 %>% 
      mutate((total_trees = tree_count.x + tree_count.y),
             total_trees = ifelse(is.na(tree_count.y), tree_count.x, total_trees))
      
      # That worked!
        # inspo: https://www.guru99.com/r-replace-missing-values.html 
    
    total_basa_op_2020 <-  basa_op_2020 %>% 
      mutate((total_trees = tree_count.x + tree_count.y),
             total_trees = ifelse(is.na(tree_count.y), tree_count.x, total_trees))
    
    # And to remove columns: 
    
    total_basa_op_2020 %>% 
      select(-c(tree_count.x, tree_count.y,`(total_trees = tree_count.x + tree_count.y)`))
    
      # Worked swimmingly 
    
    trimmed_total_basa_op_2020 <-   total_basa_op_2020 %>% 
      select(-c(tree_count.x, tree_count.y,`(total_trees = tree_count.x + tree_count.y)`))
    
    
    trimmed_total_basa_op_2020 %>% write_csv("trimmed_total_basa_op_2020.csv", na = "")
    
# 2021
    
    left_join(basa_2021, operations_2021, by = "neighborhood") %>% 
      View()
    
    # join worked
    
    basa_op_2021 <- left_join(basa_2021, operations_2021, by = "neighborhood")
    
    # add em up
    
    basa_op_2021 %>% 
      mutate((total_trees = tree_count.x + tree_count.y),
             total_trees = ifelse(is.na(tree_count.y), tree_count.x, total_trees))
    
    
    total_basa_op_2021 <- basa_op_2021 %>% 
      mutate((total_trees = tree_count.x + tree_count.y),
             total_trees = ifelse(is.na(tree_count.y), tree_count.x, total_trees))
    
    # trim
    
    trimmed_total_basa_op_2021 <- total_basa_op_2021 %>% 
      select(-c(tree_count.x, tree_count.y,`(total_trees = tree_count.x + tree_count.y)`))
    
    # export
    
    trimmed_total_basa_op_2021 %>% write_csv("trimmed_total_basa_op_2021.csv", na = "")
    
# compare 2020 to 2021    
    
    left_join(trimmed_total_basa_op_2021, trimmed_total_basa_op_2020, by = "neighborhood") %>% 
      View()
    
    # worked. 2021 is x and 2020 is y
    
    tree_neighborhood_2020_2021 <- left_join(trimmed_total_basa_op_2021, trimmed_total_basa_op_2020, by = "neighborhood") 
    
    tree_neighborhood_2020_2021 %>% write_csv("tree_neighborhood_2020_2021.csv", na = "")
             