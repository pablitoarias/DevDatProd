---
title: "README"
author: "Pablo Arias"
date: "Wednesday, January 14, 2015"
output: html_document
---

#### Description

This Shiny App is part of the Developing Data Products Course. It is an application that allows to train different linear prediction models based on a subset of features from the Motor Trend magazine dataset *mtcars* available with R. The outcome of the predictors is Miles per Gallon. 

This dataset is a collection of 32 automobiles (1973-1974 models). Once a prediction model has been generated, different values for the selected features can be used to make a prediction.

#### Model generation

The **Model** tab has a **Features** section where all the possible features (Number of cylinders, Engine Displacement, Gross horsepower, Rear axle ratio, Weight, Quarter Mile Time, “V” or “S”traight" Engine, Number of forward gears and Number of carburetors) can be selected.

Once the desired features are selected the **Calculate Model** button can be pressed to generate the new linear model. The model will not be calculated until the button has been pressed. 

The **Summary** section shows the R summary printout for the model.

The **Residuals Plot** section shows a plot of the generated model, with all the pertinent residual plots.

#### Predictor

The **Predictor** tab will allow to make predictions based on the features selected. Note that you will not be allowed to predict after the **Features** have been changed and a new model has not be calculated. So, if you change the **Features** remember to press **Calculate Model**

Also, to generate a model, at least one feature needs to be selected. If all features are de-selected the App will select one feature at least.

Under this tab you will see a **Predictors** section, showing slide bars and selectors for the features you have selected for your model. This will dynamically change depending on the features available to the model. 

When any of the **Predictors** are changed, the prediction is calculated immediately and shown in the **Prediction** section, below the **Values** section, showing the values you have selected for the prediction.

#### Help

The help tab shows this text.
