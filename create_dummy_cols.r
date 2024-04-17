library("fastDummies")
library("readxl")
library("dplyr")
library("tidyr")
library("magrittr")

df_with_dummies <- data.frame()

raw_data <- read_excel("data/regression_data_final.xlsx", sheet=1, col_names=TRUE)

#add Age of Mother col
agecalc <- function(num) {
    return(12+num*5)
}
raw_data <- drop_na(raw_data)
raw_data$"Age of Mother" <- agecalc(raw_data$`Age in 5-year groups`)

#add prenatal care col
raw_data$"PrenatalCare" <- ifelse(
    (raw_data$"Prenatal: doctor"|| raw_data$"Prenatal: ANM/nurse/midwife/LHV"||
    raw_data$"Prenatal: other health personnel"|| raw_data$"Prenatal: anganwadi/ICDS worker"||
    raw_data$"Prenatal: DAI/TBA"), 1, 0
)

#add low, med, high standards of living
raw_data$"Std of Living (Low)" <- ifelse(raw_data$"Standard of Living Index" == 1, 1, 0)
raw_data$"Std of Living (Med)" <- ifelse(raw_data$"Standard of Living Index" == 2, 1, 0)
raw_data$"Std of Living (High)" <- ifelse(raw_data$"Standard of Living Index" == 3, 1, 0)

#add allowed to go
raw_data$"allowed to go" <- ifelse(
    (raw_data$"Allowed to go to: market" == 1 || raw_data$"Allowed to go to: market" == 2),
    1, 0
)

#add religion
raw_data$"Religion (Hindu)" <- ifelse(raw_data$Religion==1, 1, 0)
raw_data$"Religion (Muslim)" <- ifelse(raw_data$Religion==2, 1, 0)
raw_data$"Religion (Christian)" <- ifelse(raw_data$Religion==3, 1, 0)
raw_data$"Religion (Other)" <- ifelse(raw_data$Religion %in% c(1, 2, 3), 1, 0)



str(raw_data)




