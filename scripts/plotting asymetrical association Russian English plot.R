""""""""""""""""""""""""""""""""""""""""""""""""""
#modelling GVC for the Russian data
""""""""""""""""""""""""""""""""""""""""""""""""""
#plotting productivity of A- and NP-subschemas
prod_df <- read.csv("D:/Russian files/Russian_coll_anal.csv", sep = "\t") #specify the directory of Russian_coll_anal.csv
attach(prod_df)
sorted_prod_df <- prod_df[order(delta_p),] #sorting delta_p in the ascending order
prod_df1 <- data.frame(Observations = seq(1, 938, by=1),
                       delta_p = as.numeric(sorted_prod_df$delta_p))
with(data = prod_df1,
     expr = {
       plot(x = Observations,
            y = delta_p)
       polygon(x = c(min(Observations), Observations, max(Observations)),
               y = c(0, delta_p, 0),
               col = "gray")
       clip(x1 = min(Observations),
            x2 = max(Observations),
            y1 = min(delta_p),
            y2 = 0)
       polygon(x = c(min(Observations), Observations, max(Observations)),
               y = c(0, delta_p, 0),
               col = "gray")
     })
text(350, -0.8, expression("NP predicts A"))
text(130, -0.4, expression("63%"))
text(600, 0.1, expression("A predicts NP"))
text(850, 0.2, expression("27%"))

""""""""""""""""""""""""""""""""""""""""""""""""""
#modelling GVC for the English data
""""""""""""""""""""""""""""""""""""""""""""""""""
#plotting productivity of A- and NP-subschemas
en_prod_df <- read.csv("D:/English files/English_coll_anal.csv", sep = "\t") #specify the directory of English_coll_anal.csv
attach(en_prod_df)
en_sorted_prod_df <- en_prod_df[order(delta_p),] #sorting delta_p in the ascending order
en_prod_df1 <- data.frame(Observations = seq(1, 494, by=1),
                       delta_p = as.numeric(en_sorted_prod_df$delta_p))
with(data = en_prod_df1,
     expr = {
       plot(x = Observations,
            y = delta_p)
       polygon(x = c(min(Observations), Observations, max(Observations)),
               y = c(0, delta_p, 0),
               col = "gray")
       clip(x1 = min(Observations),
            x2 = max(Observations),
            y1 = min(delta_p),
            y2 = 0)
       polygon(x = c(min(Observations), Observations, max(Observations)),
               y = c(0, delta_p, 0),
               col = "gray")
     })
text(150, -0.8, expression("NP predicts A"))
text(55, -0.4, expression("39%"))
text(350, 0.7, expression("A predicts NP"))
text(420, 0.3, expression("48%"))