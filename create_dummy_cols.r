library("fastDummies")
library("readxl")
library("dplyr")
library("tidyr")
library("magrittr")
library("writexl")

df_with_dummies <- data.frame()

raw_data <- read_excel("data/regression_data_final.xlsx", sheet=1, col_names=TRUE)

#raw_data <- drop_na(raw_data)

#add Age of Mother col
agecalc <- function(num) {
    return(12+num*5)
}

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

# add partner's occu
raw_data$"Partner's Occupation (Agri, household & domestic)" <- ifelse(raw_data$"Partner's occupation" %in% c(4,5,6), 1, 0)
raw_data$"Partner's Occupation (Professional, clerical, sales & service)" <- ifelse(raw_data$"Partner's occupation" %in% c(1,2,3,7), 1, 0)
raw_data$"Partner's Occupation (Agri, household & domestic)" <- ifelse(raw_data$"Partner's occupation" %in% c(8), 1, 0)

# add respondent's occu
raw_data$"Respondent's Occupation (Agri, household & domestic)" <- ifelse(raw_data$"Respondent's occupation" %in% c(4,5,6), 1, 0)
raw_data$"Respondent's Occupation (Professional, clerical, sales & service)" <- ifelse(raw_data$"Respondent's occupation" %in% c(1,2,3,7), 1, 0)
raw_data$"Respondent's Occupation (Agri, household & domestic)" <- ifelse(raw_data$"Respondent's occupation" %in% c(8), 1, 0)

# add place of residence
raw_data$"Place of Residence (Urban)" <- ifelse(raw_data$"Type of place of residence" == 1, 1, 0)
raw_data$"Place of Residence (Rural)" <- ifelse(raw_data$"Type of place of residence" == 2, 1, 0)

# add has money for own use
raw_data$"Has money for her own use" <- if (raw_data$"Has money for her own use" != 1 && raw_data$"Has money for her own use" != 0) {
    raw_data$"Has money for her own use" = 0
}

# add pregnancy complications
raw_data$"Told about pregnancy complications" <- if (raw_data$"Told about pregnancy complications" != 1 && raw_data$"Told about pregnancy complications" != 0) {
    raw_data$"Told about pregnancy complications" = 0
}

# add mother's education level
raw_data$"Mother's Educational level (Primary)" <- ifelse(raw_data$"Educational attainment" %in% c(2,3), 1, 0)
raw_data$"Mother's Educational level (Secondary)" <- ifelse(raw_data$"Educational attainment" %in% c(4,5), 1, 0)

# add partner's education level
raw_data$"Partner's Educational level (Primary)" <- ifelse(raw_data$"Partner's education level" == 1, 1, 0)
raw_data$"Partner's Educational level (Secondary)" <- ifelse(raw_data$"Partner's education level" == 2, 1, 0)
raw_data$"Partner's Education level (High)" <- ifelse(raw_data$"Partner's education level" == 3, 1, 0)

# add hospital delivery
raw_data$"Hospital delivery" <- ifelse(raw_data$"Place of delivery" %in% c(20, 21, 22, 24, 25, 30, 31, 36, 41), 1, 0)

str(raw_data)

write_xlsx(raw_data, "data/regression_data_final_dummies_combined.xlsx", col_names=TRUE)



