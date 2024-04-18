library("readxl")
library("Rchoice")

dataset <- as.data.frame(read_excel("data/final_processed_data.xlsx"))
names(dataset) <- c("CM", "pregcomplication", "hasmoneyforownuse", "motherAge", "PC", "LivingStdLow", "LivingStdMed",
    "LivingStdHigh", "allowedtogo", "ReligionHindu", "ReligionMuslim", "ReligionChristian", "ReligionOther", "PartnerOcc_agri_household_domes",
    "PartnerOcc_prof_cler_sales_service", "PartnerOcc_manual", "MotherOcc_agri_household_domes", "MotherOcc_prof_cler_sales_service",
    "MotherOcc_manual", "Residence_urban", "Residence_rural", "MotherEduPrimary", "MotherEduSecondary", 
    "PartnerEduPrimary", "PartnerEduSecondary", "PartnerEduHigh", "HD")

dataset <- drop_na(dataset)
str(dataset)

PC_probit <- 
glm(PC ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh, 
    data=dataset)

HD_probit <-
glm(HD ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC,
    data=dataset)

CM_probit <- 
glm(CM ~ Residence_urban + motherAge + ReligionMuslim + ReligionChristian + ReligionOther +
    LivingStdMed + LivingStdHigh + PartnerOcc_manual + PartnerOcc_agri_household_domes +
    PartnerOcc_prof_cler_sales_service + allowedtogo + hasmoneyforownuse + pregcomplication +
    MotherEduPrimary + MotherEduSecondary + PartnerEduPrimary + PartnerEduSecondary + PartnerEduHigh + PC + HD,
    data=dataset)