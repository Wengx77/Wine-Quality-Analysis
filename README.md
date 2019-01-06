# Wine-Quality-Analysis
This dataset is taken from UC Irvine's treasure trove of datasets. Source:http://archive.ics.uci.edu/ml/datasets/Wine+Quality,

## Models
Linear Regression
Random Forest
KNN

## Analysis Report
1.Exploration
red wine dataset contains 1,599 obs with 12 variables and wine quality ranges from 3 to 8
white wine dataset contains 4,898 obs with 12 variables and wine quality ranges from 3 to 9

compared with red wine, the white wine has higher amount of residual sugar and sulfur dioxide and similar pH value

Based on the distribution of wine quality, I create a new variable – rating which classify the quality into three categories, bad for quality lower than 5, good for quality higher than 7 and average is between those two. What I find is that rating in red wine is 63 for bad, 1319 for average and 217 for good, while in white wine is 183 for bad, 4080 for average and 635 for good. Thus, 82% of wine are in average quality. Therefore, it is possible that the provided data might have some influence on further prediction due to lacking enough samples on edge quality. 

