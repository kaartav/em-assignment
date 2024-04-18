library(readxl)
library(writexl)

dummy_dataset <- read_excel("data/regression_data_final_dummies_combined.xlsx")[, c(8, 20:42)]

write_xlsx(dummy_dataset, "data/final_processed_data.xlsx", col_names=TRUE)