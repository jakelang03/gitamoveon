##Load packages
install.packages("librarian")
librarian::shelf(here)
librarian::shelf(openxlsx)
librarian::shelf(tidyverse)

##The following code assumes WD is rproj  and data is saved inside the project in a folder called "data."
setwd(here("data"))
A <- read.xlsx("A.xlsx")
B <- read.xlsx("B.xlsx")
P <- read.xlsx("P.xlsx")
southEast <- read.xlsx("SouthEast.xlsx")
manualdata <- read.xlsx("manualdata.xlsx")
POP <- readRDS("Pop.rds")

##Inspect the raw data
View(A)
View(B)
View(P)
View(southEast)
View(manualdata)
View(POP)

total.obs<-nrow(A)+nrow(B)+nrow(P)+nrow(southEast)+nrow(manualdata)

##Data subsetting
##FOR PRIMARY & SECONDARY ANALYSIS: Subsetting & joining together A, B, P, South East, Manual (assuming: entries in manual are
                                      ##independent of other provided datsets)

##Proper order: Age, Region, PH, MH, Smoker, Belief, SES5, Gender

southEast.new <- select(southEast,Age,Region,Phusical,Mental,Smoker,Belief,SES5,Gender)
southEast.new <- rename(southEast.new,
                        "PH"="Phusical",
                        "MH"="Mental")

manualdata$Region <- NA
manualdata$SES5 <- NA
manualdata$Name <-NULL
manualdata <- select(manualdata,Age,Region,Physical, Mental, Smoker, Belief,SES5,Gender)
manualdata <- rename(manualdata,
                     "PH"="Physical",
                     "MH"="Mental")

data.AB <- rbind(A,B)
data.ABP <- rbind(data.AB,P)
data.ABPsouthEast <- rbind (data.ABP,southEast.new)
data.all<- rbind(data.ABPsouthEast,manualdata)
nrow(data.all)==total.obs

xtabs(~Region,data.all) #looks good
xtabs(~PH,data.all) #need to recode
xtabs(~MH,data.all) #need to recode
xtabs(~Smoker,data.all) #need to recode
xtabs(~Belief,data.all) #ok
xtabs(~SES5,data.all) #ok
xtabs(~Gender,data.all) #need to recode

#recode PH
data.all$PH.rec<-data.all$PH
data.all<-data.all %>%
  mutate(PH.rec=recode(PH.rec,
                       "yes"="Y",
                       "no"="N"
                       ))
