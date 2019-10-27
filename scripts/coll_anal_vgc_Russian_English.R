#co-varying collostructional analysis, attested observations only, Fisher exact test (run twice for the Russian and English data)
source("http://www.linguistics.ucsb.edu/faculty/stgries/teaching/groningen/coll.analysis.r")
coll.analysis()

""""""""""""""""""""""""""""""""""""""""""""""""""
#modelling GVC for the Russian data
""""""""""""""""""""""""""""""""""""""""""""""""""
#constructing iterpolated and extrapolated GVC (potential productivity)
install.packages("languageR"); library(languageR)
install.packages("zipfR"); library(zipfR)
my_df <- read.csv("D:/Russian files/Russian.csv", sep = "\t") #specify your directory with Russian.csv
my_adj<-as.character(my_df$WORD_SLOT1)
my_np<-as.character(my_df$WORD_SLOT2)

#VGC for adj
my_df.growth = growth.fnc(text = my_adj, size=89, nchunks = 29) #growth.fnc devided the text (vector in our case) into 29 chunks with 89 adjectives each
str(my_df.growth)
my_df.vgc.a = growth2vgc.fnc(my_df.growth) #empirical growth curve
my_df.table = table(table(my_adj))
my_df.spc = spc(m = as.numeric(names(my_df.table)), Vm = as.numeric(my_df.table)) #convert the data into a frequency spectrum thanks to spc()
sum(my_df.spc$Vm) # number of A types
sum(my_df.spc$m * my_df.spc$Vm) # number of tokens

#fitting an lnre model.the spectrum object as its second argument. The 1st argument
#is a type of lnre models: the finite Zipf-Mandelbrot model(fzm), the Zipf-Mandelbrot
#model (zm) or the Generalized Inverse Gauss-Poisson model (gigp).The goodness of
#fit of the model to the empirical distribution of each configuration is evaluated
#with a multivariate χ2 test. "For a good fit, the χ2 calue should be low, and the
#corresponding p-value large and preferebly well above 0.05" (Bayyen 2008).

my_df.lnre.fzm.a = lnre("fzm", my_df.spc); my_df.lnre.fzm.a #fzm model, the best fit
my_df.lnre.zm.a = lnre("zm", my_df.spc); my_df.lnre.zm.a #zm model
my_df.lnre.gigp.a = lnre("gigp", my_df.spc); my_df.lnre.gigp.a #gigp model

#modelling interpolated and three times extrapolated expected values
my_df.int.fzm.a = lnre.vgc(my_df.lnre.fzm.a, seq(0, N(my_df.lnre.fzm.a), length = 29), m.max=3) #expected values for the observed data (interpolation)
my_df.ext.fzm.a = lnre.vgc(my_df.lnre.fzm.a, seq(N(my_df.lnre.fzm.a), N(my_df.lnre.fzm.a)*3, length = 29), m.max = 3) #expected values for the data at a 3 times larger sample (extrapolation)

#plotting the VGC for adj, based on the observed  values. add.m=1 allows to plot the VGC for hapax legomena
plot(my_df.vgc.a, add.m=1, col=c("red"), lty=c(3,3), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep=""))
title(ylab=ylab_name)
text(2350, 280, expression("V"[A]))
text(2350, 110, expression("V1"[A]))

#VGC for NPs (based on observed values)
my_df.growth.np = growth.fnc(text = my_np, size=89, nchunks = 29)
my_df.vgc.np = growth2vgc.fnc(my_df.growth.np)
my_df.table.np = table(table(my_np))
my_df.spc.np = spc(m = as.numeric(names(my_df.table.np)), Vm = as.numeric(my_df.table.np))
sum(my_df.spc.np$Vm) # number of NP types
my_df.lnre.fzm.np = lnre("fzm", my_df.spc.np); my_df.lnre.fzm.np #fmz model(best fit)
my_df.lnre.zm.np = lnre("zm", my_df.spc.np); my_df.lnre.zm.np #mz model
my_df.lnre.gigp.np = lnre("fzm", my_df.spc.np); my_df.lnre.gigp.np #gigp model
my_df.int.fzm.np = lnre.vgc(my_df.lnre.fzm.np, seq(0, N(my_df.lnre.fzm.np), length=29), m.max=3) #expected values for the observed data (interpolation)
my_df.ext.fzm.np = lnre.vgc(my_df.lnre.fzm.np, seq(N(my_df.lnre.fzm.np), N(my_df.lnre.fzm.np)*3, length = 29), m.max = 3) #expected values for the observed data (interpolation)

#plotting observed values for V and V1
plot(my_df.vgc.np, add.m=1, col=c("red"), lty=c(3,3), lwd=c(3,3), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep="")) # label of y axis
title(ylab=ylab_name) # plot the label of y axis
text(2400, 250, expression("V1"[NP])) # plot annotations
text(2400, 460, expression("V"[NP])) # plot annotations

#plotting observed values for both adj and NPs together
plot(my_df.vgc.np, my_df.vgc.a, add.m=1, col=c("red", "blue"), lty=c(3,3),
     lwd=c(3,3), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep=""))
title(ylab=ylab_name)
text(2450, 470, expression("V"[NP]), cex=0.8)
text(2450, 270, expression("V1"[NP]), cex=0.8)
text(2450, 330, expression("V"[A]), cex=0.8)
text(2450, 110, expression("V1"[A]), cex=0.8)
legend<-legend("topleft", inset=.025,c("NP slot (empirical)", "A slot (empirical)"),
               lty=c(3,3), lwd=c(3,3), col=c("red", "blue"),
               bg="white", cex=0.6)

#plotting empirical (observed values) and interpolated (expected values) VGCs for adj and np
plot(my_df.int.fzm.np, my_df.vgc.np, my_df.int.fzm.a, my_df.vgc.a, add.m=1,
     col=c("black","red", "black", "blue"), lty=c(1,3,2,3),
     lwd=c(2,2,2,2), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep=""))
title(ylab=ylab_name)
text(2450, 470, expression("V"[NP]), cex=0.8)
text(2450, 270, expression("V1"[NP]), cex=0.8)
text(2450, 330, expression("V"[A]), cex=0.8)
text(2450, 110, expression("V1"[A]), cex=0.8)
legend<-legend(0, 500, inset=.025,c("NP slot (interpolated)", "NP slot (empirical)",
                                       "A slot (interpolated)","A slot (empirical)"),
               lty=c(1,3,2,3), lwd=c(2,2,2,2),
               col=c("black","red","black","blue"), cex=0.8)

#plotting interpolated and extrapolated VGCs for adj and NPs
plot(my_df.int.fzm.np, my_df.ext.fzm.np, my_df.vgc.np, my_df.int.fzm.a, my_df.ext.fzm.a, my_df.vgc.a,
     add.m=1, col=c("black", "grey60","red", "black", "grey60","blue"),
     lty=c(1,1,3,2,2,3), lwd=c(2,2,2,2,2,2), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep=""))
title(ylab=ylab_name)
abline=abline(v=2586, lty=5,lwd=0.5, col="grey60") #adding the vertical line to signal the limit of the sample
text(2000, 620, "N(C)=2586", cex=0.8, col="grey60")
text(7300, 890, expression("V"[NP]), cex=0.8)
text(7300, 540, expression("V1"[NP]), cex=0.8)
text(7300, 420, expression("V"[A]), cex=0.8)
text(7300, 100, expression("V1"[A]), cex=0.8)
legend<-legend("topleft", inset=.025,c("NP slot (interpolated)","NP slot (extrapolated)",
                                       "NP slot (empirical)", "A slot (interpolated)",
                                       "A slot (extrapolated)","A slot (empirical)"),
               lty=c(1,1,3,2,2,3), lwd=c(2,2,2,2,2,2),
               col=c("black", "grey40","red","black", "grey60","blue"), cex=0.7)

#accessig the extrapolated values of the VGCs of V and V1 of adj and NPs:
my_df.ext.fzm.a #extrapolated values of the adj slot
my_df.ext.fzm.a$V1[29] #V1 measure of the adj slot in the last chunk of the 3x sample
my_df.ext.fzm.np #extrapolated values of the NP slot


""""""""""""""""""""""""""""""""""""""""""""""""""
#modelling GVC for the English data
""""""""""""""""""""""""""""""""""""""""""""""""""
#constructing iterpolated and extrapolated GVC (potential productivity)
install.packages("languageR"); library(languageR)
install.packages("zipfR"); library(zipfR)
en_df <- read.csv("D:/English files/English.csv", sep = "\t") #specify your directory with English.csv
en_adj<-as.character(en_df$WORD_SLOT1)
en_np<-as.character(en_df$WORD_SLOT2)

#VGC for adj
en_df.growth = growth.fnc(text = en_adj, size=56, nchunks = 16) #growth.fnc devided the text (vector in our case) into 16 chunks with 56 adjectives each
str(en_df.growth)
en_df.vgc.a = growth2vgc.fnc(en_df.growth) #empirical growth curve
en_df.table = table(table(en_adj))
en_df.spc = spc(m = as.numeric(names(en_df.table)), Vm = as.numeric(en_df.table)) #convert the data into a frequency spectrum
sum(en_df.spc$Vm) # number of A types
sum(en_df.spc$m * en_df.spc$Vm) # number of tokens

en_df.lnre.fzm.a = lnre("fzm", en_df.spc); en_df.lnre.fzm.a #fzm model
en_df.lnre.zm.a = lnre("zm", en_df.spc); en_df.lnre.zm.a #zm model
en_df.lnre.gigp.a = lnre("gigp", en_df.spc); en_df.lnre.gigp.a #gigp model, a better fit

#modelling interpolated and eight times extrapolated expected values
en_df.int.gigp.a = lnre.vgc(en_df.lnre.gigp.a, seq(0, N(en_df.lnre.gigp.a), length = 16), m.max=3) #expected values for the observed data (interpolation)
en_df.ext.gigp.a = lnre.vgc(en_df.lnre.gigp.a, seq(N(en_df.lnre.gigp.a), N(en_df.lnre.gigp.a)*8, length = 16), m.max = 3) #expected values for the data at an 8 times larger sample (extrapolation)

#plotting the VGC for adj, based on the observed  values. add.m=1 allows to plot the VGC for hapax legomena
plot(en_df.vgc.a, add.m=1, col=c("red"), lty=c(3,3), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep=""))
title(ylab=ylab_name)
text(830, 255, expression("V"[A]))
text(830, 160, expression("V1"[A]))

#VGC for NPs (based on observed values)
en_df.growth.np = growth.fnc(text = en_np, size=56, nchunks = 16)
en_df.vgc.np = growth2vgc.fnc(en_df.growth.np)
en_df.table.np = table(table(en_np))
en_df.spc.np = spc(m = as.numeric(names(en_df.table.np)), Vm = as.numeric(en_df.table.np))
sum(en_df.spc.np$Vm) # number of NP types
en_df.lnre.fzm.np = lnre("fzm", en_df.spc.np); en_df.lnre.fzm.np #fmz model
en_df.lnre.zm.np = lnre("zm", en_df.spc.np); en_df.lnre.zm.np #mz model
en_df.lnre.gigp.np = lnre("fzm", en_df.spc.np); en_df.lnre.gigp.np #gigp model (a better fit)
en_df.int.gigp.np = lnre.vgc(en_df.lnre.gigp.np, seq(0, N(my_df.lnre.gigp.np), length=16), m.max=3) #expected values for the observed data (interpolation)
en_df.ext.gigp.np = lnre.vgc(en_df.lnre.gigp.np, seq(N(en_df.lnre.gigp.np), N(my_df.lnre.gigp.np)*8, length = 16), m.max = 3) #expected values for the observed data (interpolation)

#plotting observed values for V and V1
plot(en_df.vgc.np, add.m=1, col=c("red"), lty=c(3,3), lwd=c(3,3), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep=""))
title(ylab=ylab_name)
text(830, 140, expression("V1"[NP]))
text(830, 200, expression("V"[NP]))

#plotting observed values for both adj and NPs together
plot(en_df.vgc.np, en_df.vgc.a, add.m=1, col=c("red", "blue"), lty=c(3,3),
     lwd=c(3,3), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep=""))
title(ylab=ylab_name)
text(830, 200, expression("V"[NP]), cex=0.9)
text(830, 140, expression("V1"[NP]), cex=0.9)
text(830, 260, expression("V"[A]), cex=0.9)
text(830, 164, expression("V1"[A]), cex=0.9)
legend<-legend("topleft", inset=.025,c("NP slot (empirical)", "A slot (empirical)"),
               lty=c(3,3), lwd=c(3,3), col=c("red", "blue"),
               bg="white", cex=0.8)

#plotting empirical (observed values) and interpolated (expected values) VGCs for adj and np
plot(en_df.int.gigp.np, en_df.vgc.np, en_df.int.gigp.a, en_df.vgc.a, add.m=1,
     col=c("black","red", "black", "blue"), lty=c(1,3,2,3),
     lwd=c(2,2,2,2), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep=""))
title(ylab=ylab_name)
text(830, 195, expression("V"[NP]), cex=0.9)
text(830, 137, expression("V1"[NP]), cex=0.9)
text(830, 255, expression("V"[A]), cex=0.9)
text(830, 159, expression("V1"[A]), cex=0.9)
legend<-legend("topleft", inset=.025,c("NP slot (interpolated)", "NP slot (empirical)",
                                       "A slot (interpolated)","A slot (empirical)"),
               lty=c(1,3,2,3), lwd=c(2,2,2,2),
               col=c("black","red","black","blue"), cex=0.8)

#plotting interpolated and extrapolated VGCs for adj and NPs
plot(en_df.int.gigp.np, en_df.ext.gigp.np, en_df.vgc.np, en_df.int.gigp.a, en_df.ext.gigp.a, en_df.vgc.a,
     add.m=1, col=c("black", "grey60","red", "black", "grey60","blue"),
     lty=c(1,1,3,2,2,3), lwd=c(2,2,2,2,2,2), main="", ylab="")
ylab_name=expression(paste("V"," and"," V"[1],sep=""))
title(ylab=ylab_name)
abline=abline(v=904, lty=5,lwd=0.5, col="grey60") #adding the vertical line to signal the limit of the sample
text(1500, 600, "N(C)=904", cex=0.8, col="grey60")
text(6500, 880, expression("V"[NP]), cex=0.8)
text(6800, 570, expression("V1"[NP]), cex=0.8)
text(6800, 820, expression("V"[A]), cex=0.8)
text(6800, 370, expression("V1"[A]), cex=0.8)
legend<-legend("topleft", inset=.025,c("NP slot (interpolated)","NP slot (extrapolated)",
                                       "NP slot (empirical)", "A slot (interpolated)",
                                       "A slot (extrapolated)","A slot (empirical)"),
               lty=c(1,1,3,2,2,3), lwd=c(2,2,2,2,2,2),
               col=c("black", "grey40","red","black", "grey60","blue"), cex=0.7)

#accessig the extrapolated values of the VGCs of V and V1 of adj and NPs:
en_df.ext.gigp.a #extrapolated values of the adj slot
en_df.ext.gigp.a$V1[29] #V1 measure of the adj slot in the last chunk of the 3x sample
en_df.ext.gigp.np #extrapolated values of the NP slot