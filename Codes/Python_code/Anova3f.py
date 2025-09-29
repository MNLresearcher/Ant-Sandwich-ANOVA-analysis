import pandas as pd
import statsmodels.api as sm
from statsmodels.formula.api import ols
from statsmodels.stats.multicomp import pairwise_tukeyhsd
import matplotlib.pyplot as plt
import seaborn as sns

# read csv-file
df = pd.read_csv('C:\example\path\sandwich.csv')

# Making Anova model

model = ols('antCount ~ C(topping, Sum)*C(bread, Sum)*C(butter, Sum)', data=df).fit()

table = sm.stats.anova_lm(model, typ=2)

print(table)

# Conduct Tukey test

test = pairwise_tukeyhsd(endog=df['antCount'], groups = df['topping'], alpha=0.05)
print(test)