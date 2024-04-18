from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, accuracy_score, precision_score, recall_score, f1_score
from sklearn.model_selection import train_test_split
import numpy as np
import pandas as pd
import statsmodels.api as sm

def evaluate_model(y_true, y_pred):
    # Calculate confusion matrix
    cm = confusion_matrix(y_true, y_pred)

    # Calculate evaluation metrics
    accuracy = accuracy_score(y_true, y_pred)
    precision = precision_score(y_true, y_pred, average='weighted')
    recall = recall_score(y_true, y_pred, average='weighted')
    f1 = f1_score(y_true, y_pred, average='weighted')

    evaluation_metrics = {
        'Confusion_Matrix': cm,
        'Accuracy': accuracy,
        'Precision': precision,
        'Recall': recall,
        'F1-Score': f1
    }

    return evaluation_metrics

def logistic_regression_model(df, dep_variable, test_size=0.2, random_state=42):
    X = df.drop(columns=[dep_variable])
    y = df[dep_variable]

    # Perform train-test split
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=test_size, random_state=random_state)

    # Initialize and train the logistic regression model
    logistic_regression_model = LogisticRegression()
    logistic_regression_model.fit(X_train, y_train)
    y_pred = logistic_regression_model.predict(X_test)
    evaluation_metrics = evaluate_model(y_test, y_pred)

    # Get coefficients and variance of coefficients
    coefficients = logistic_regression_model.coef_
    variance_coefficients = logistic_regression_model.coef_variance_

    # Perform t-test for coefficients
    X_train = sm.add_constant(X_train)  # Add constant for intercept
    model = sm.Logit(y_train, X_train)
    result = model.fit(disp=0)  # Fit logistic regression model
    t_test_results = result.t_test()

    return logistic_regression_model, evaluation_metrics, coefficients, variance_coefficients, t_test_results
df=pd.read_csv('data/FINAL_FINAL_data.xlsx')
regression_model_child, evaluation_metrics_child, coefficients_child, variance_coefficients_child, t_test_results_child=logistic_regression_model(df,"Child is alive")
regression_model_PrenatalCare, evaluation_metrics_PrenatalCare, coefficients_PrenatalCare, variance_coefficients_PrenatalCare, t_test_results_PrenatalCare=logistic_regression_model(df,"PrenatalCare")
regression_model_Hospital,evaluation_metrics_Hospital, coefficients_Hospital, variance_coefficients_Hospital, t_test_results_Hospital=logistic_regression_model(df,"Hospital delivery")