library("readxl")
library("Rchoice")
library("dplyr")
library("tidyr")

dataset <- as.data.frame(read_excel("data/final_processed_data.xlsx"))
names(dataset) <- c("CM", "pregcomplication", "hasmoneyforownuse", "motherAge", "PC", "LivingStdLow", "LivingStdMed",
    "LivingStdHigh", "allowedtogo", "ReligionHindu", "ReligionMuslim", "ReligionChristian", "ReligionOther", "PartnerOcc_agri_household_domes",
    "PartnerOcc_prof_cler_sales_service", "PartnerOcc_manual", "MotherOcc_agri_household_domes", "MotherOcc_prof_cler_sales_service",
    "MotherOcc_manual", "Residence_urban", "Residence_rural", "MotherEduPrimary", "MotherEduSecondary", 
    "PartnerEduPrimary", "PartnerEduSecondary", "PartnerEduHigh", "HD")

dataset <- drop_na(dataset)
#str(dataset)

# fitting binomial regression probit models
PC_probit <- 
glm(PC ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh, 
    data=dataset, family=binomial(link="probit"), x=TRUE)

HD_probit <-
glm(HD ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC,
    data=dataset, family=binomial(link="probit"), x=TRUE)

CM_probit <- 
glm(CM ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC + HD,
    data=dataset, family=binomial(link="probit"), x=TRUE)

#fitting binomial logit models
PC_logit <- 
glm(PC ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh, 
    data=dataset, family=binomial(link="logit"), x=TRUE)

HD_logit <-
glm(HD ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC,
    data=dataset, family=binomial(link="logit"),x=TRUE)

CM_logit <- 
glm(CM ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC + HD,
    data=dataset, family=binomial(link="logit"), x=TRUE)

# fitting heteroskedastic regression models
PC_hetprobit <-
hetprob(PC ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh | 
    Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh, 
    data=dataset, link="probit")

HD_hetprobit <- 
hetprob(HD ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC |
    Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC,
    data=dataset, link="probit")

CM_hetprobit <- 
hetprob(CM ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC + HD |
    Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC + HD, 
    data=dataset, link="probit")