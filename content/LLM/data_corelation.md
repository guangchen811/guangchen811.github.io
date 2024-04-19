---
title: "LLM based Data Correlation Discovery"
date: 2024-04-15
draft: True
tags: 
- LLMs
---
# Task Definition
The column names of a table often contain valuable information about the schema of the table. With the develop of Large Language Models (LLMs), we can use LLMs to discover the correlation between the column names of a table. The potential applications of this technique include *data profiling*, *data quality assessment*, and *data schema understanding*. In this article, we will introduce how to use LLMs to discover the correlation between the column names of a table.

Traditional data correlation discovery methods requires comparing data in different columns, which is really expensive. To explain, if we have a table with 100 columns, we need to compare 100*99/2 = 4950 pairs of columns. However, with LLMs, we can use the column names to discover the correlation between the columns. The basic idea is that if two columns have similar names, they are more likely to be correlated.

The relation between the column names of a table can be represented as a graph, where the nodes are the column names and the edges are the correlation between the column names. However, the correlation between columns are often sparse. Thing would be more complicated if there are multiple tables.

# Setting

There are two way to measure the performance of the LLM based data correlation discovery method. The first way is to use the correlation between the column names of a table as the ground truth all other column pairs are considered as negative samples. Then treat the problem as a recommendation problem which means find as much as possible the positive samples. The input is the schema of the table, and the output is the list of pairs of column names that are correlated.

The second way is to select some column pairs as the positive samples and select the uncorrelated column pairs as the negative samples, then treat the problem as a binary classification problem. The input is the schema and two column names, and the output is the correlation between the two columns.

# Methods

# PLM based

The dataset mentioned in (Trummer, Immanuel) is very small. As shown in the Table 2, Number of data sets is 3952 and the Number of column pairs are 119384. Which means the average columns of each dataset is less than 6. This paper uses the second way to measure the performance of the Language Model. The input is the schema of the table and two column names, and the output is the correlation between the two columns.

# LLM Prompting based

Sui, Yuan, Mengyu Zhou, Mingjie Zhou, Shi Han, and Dongmei Zhang. “Table Meets LLM: Can Large Language Models Understand Structured Table Data? A Benchmark and Empirical Study.” In Proceedings of the 17th ACM International Conference on Web Search and Data Mining, 645–54. Merida Mexico: ACM, 2024. https://doi.org/10.1145/3616855.3635752.

# Predicted relation types

**I should read the survey (Abedjan, Ziawasch)** and features in schemapile.



# References

Trummer, Immanuel. “Can Large Language Models Predict Data Correlations from Column Names?” Proceedings of the VLDB Endowment 16, no. 13 (September 2023): 4310–23. https://doi.org/10.14778/3625054.3625066.

Abedjan, Ziawasch, Lukasz Golab, and Felix Naumann. “Profiling Relational Data: A Survey.” The VLDB Journal 24, no. 4 (August 1, 2015): 557–81. https://doi.org/10.1007/s00778-015-0389-y.
