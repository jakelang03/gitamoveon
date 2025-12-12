##Load packages
install.packages("librarian")
librarian::shelf(here)
librarian::shelf(openxlsx)

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
