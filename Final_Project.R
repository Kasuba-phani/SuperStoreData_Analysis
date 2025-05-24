library(readxl)
library(dplyr)

#Importing Data-set.
SS <- read_excel("D:/Data Science/Python/Dataset/Superstore.xlsx")
#Checking the dimensions
dim(SS)
#cross checking rows and columns
nrow(SS)
ncol(SS)
#Having a look at first and last few rows of the data-frame.
head(SS)
tail(SS)
str(SS)

# Checking summary of Data-sets
summary(SS)

#EDA
library(ggplot2)
library(gplots)
library(treemapify)
library(GGally)
library(dplyr)
library(cowplot)

plot(SS)
# Create a pair plot using GGally
ggpairs(data = SS, 
        columns = c("Sales", "Quantity", "Discount", "Profit"),
        title = "Pair Plot of Sales, Quantity, Discount, Profit and more",
        cardinality_threshold = 75)

# Create a grid of box plots
plot_grid(
  SS %>%
    ggplot(aes(x = Category, y = Profit)) +
    geom_boxplot() +
    labs(title = "Profit by Category"),
  
  SS %>%
    ggplot(aes(x = Region, y = Profit)) +
    geom_boxplot() +
    labs(title = "Profit by Region"),
  
  SS %>%
    ggplot(aes(x = Segment, y = Profit)) +
    geom_boxplot() +
    labs(title = "Profit by Segment"),
  
  SS %>%
    ggplot(aes(x = Discount, y = Profit)) +
    geom_boxplot() +
    labs(title = "Profit by Discount Level"),
  
  SS %>%
    ggplot(aes(x = `Ship Mode`, y = Profit)) +
    geom_boxplot() +
    labs(title = "Profit by Ship Mode"),
  
  SS %>%
    ggplot(aes(x = `Sub-Category`, y = Profit)) +
    geom_boxplot() +
    labs(title = "Profit by Sub-Category"),
  
  ncol = 2  # Number of columns in the grid
)

#Count plot
ggplot(SS, aes(x = Sales, y = `Sub-Category`)) + geom_col()

# Scatter plot
ggplot(SS, aes(x = Sales , y = Profit)) +
  geom_point(size = 1.5)

# Create a pie chart
# Calculate total profit by category
total_profit_by_category <- SS %>%
  group_by(Category) %>%
  summarise(TotalProfit = sum(Profit)) %>%
  arrange(desc(TotalProfit))

# Select the top 3 categories
top_3_categories <- total_profit_by_category %>%
  slice_head(n = 3)

# Calculate the percentage
top_3_categories$Percentage <- prop.table(top_3_categories$TotalProfit) * 100

# Create a pie chart
pie_chart <- ggplot(top_3_categories, aes(x = "", y = Percentage, fill = Category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Percentage of Total Profit for Top 3 Categories") +
  theme_void() +
  geom_text(aes(label = sprintf("%s\n%.1f%%", Category, Percentage)),
            position = position_stack(vjust = 0.5),
            size = 3, color = "white", show.legend = FALSE)

print(pie_chart)

#Tree map
dft <- SS %>% group_by(State) %>% summarise(Profit = sum(Profit))
dft

set.seed(123)  # Set seed for reproducibility
custom_colors <- sample(colors(), length(unique(df$State)), replace = FALSE)
custom_colors <- custom_colors[custom_colors != "black"]

# Create a treemap plot without a legend and with random colors
ggplot(dft, aes(area = Profit, fill = State, label = State)) +
  geom_treemap(layout = "squarified") +
  geom_treemap_text(place = "centre", size = 12) +
  labs(title = "Customized Tree Plot using ggplot and treemapify in R") +
  scale_fill_manual(values = custom_colors, guide = FALSE)

#Checking for the missing values
missing_val <- function(x) {
  missing_counts <- sapply(x, function(col) sum(is.na(col)))
  return(missing_counts)
}

missing_val(SS)

## Encoding the Character and Date-time values.
df <- SS %>% select(-one_of('Row ID','Order ID','Customer ID', 'Product ID', 'Product Name',
                            'Postal Code','Ship Date','Customer Name','Country'))

#Date-time
library(lubridate)
df$Year <- year(df$`Order Date`)
df$Month <- month(df$`Order Date`)
df$Day <- day(df$`Order Date`)
df$DayOfWeek <- wday(df$`Order Date`)
str(df)

#changing column-name
df$Sub_Category <- df$`Sub-Category`
df <- df %>% select(-one_of('Order Date','Sub-Category'))
colnames(df)

# Encoding 
df$State <- as.numeric(factor(df$State))
df$Region  <- as.numeric(factor(df$Region))
df$Category  <- as.numeric(factor(df1$Category))
df$`Ship Mode` <- as.numeric(factor(df$`Ship Mode`))
df$Segment <- as.numeric(factor(df$Segment))
df$City <- as.numeric(factor(df$City))
df$Sub_Category <- as.numeric(factor(df$Sub_Category))

str(df)
summary(df)
df

#Check for co-relation.
library(reshape2)
cor_matrix <- cor(df)
cor_matrix

# Create a heatmap of the correlation matrix
set.seed(456)
cor_matrix <- cor(matrix(rnorm(225), ncol = 15))
colnames(cor_matrix) <- colnames(cor(df))
rownames(cor_matrix) <- colnames(cor_matrix)
cor_matrix_melted <- melt(cor_matrix)

# Create a heatmap
ggplot(data = cor_matrix_melted, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient(low = "blue", high = "red", na.value = "white") +
  theme_minimal() +
  labs(title = "Correlation Heatmap", x = "", y = "") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_text(aes(label = round(value, 2)), vjust = 1) +
  coord_fixed(ratio = 1)

#cleaning our data set
df1 <- df %>% select(-one_of("City","State","Quantity","Year","Month"))
str(df1)
df1

#Training my models
library(dplyr)
library(caret)

# Step 1: Split the data into features and target variable
X <- df1 %>%
  select(-Profit)  # Replace 'target_column' with the name of your target variable

y <- df1$Profit

# Step 2: Scale/Normalize the features
X_scaled <- scale(X)  # Standardize the features

# Step 3: Split the data into training and testing sets
set.seed(456)  # for reproducibility
train_indices <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X_scaled[train_indices, ]
y_train <- y[train_indices]
X_test <- X_scaled[-train_indices, ]
y_test <- y[-train_indices]

# Linear regression model
lr <- lm(y_train ~ ., data = as.data.frame(cbind(y_train, X_train)))
#plot(lr)

# Make predictions on the test set
predictions <- predict(lr, newdata = as.data.frame(X_test))
summary(lr)

# Metrics to evaluate the our regression model

mae <- mean(abs(predictions - y_test))
print(paste("Mean Absolute Error (MAE):", mae))

mse <- mean((predictions - y_test)^2)
print(paste("Mean Squared Error (MSE):", mse))

rmse <- sqrt(mse)
print(paste("Root Mean Squared Error (RMSE):", rmse))

r_squared <- cor(predictions, y_test)^2
print(paste("R-squared (R²):", r_squared))

#Training Random Forest Model.
library(randomForest)
rf <- randomForest(y_train ~ ., data = data.frame(X_train, y_train), ntree = 100)
summary(rf)

rfpredictions <- predict(rf, data.frame(X_test))

# MAE
mae <- mean(abs(rfpredictions - y_test))
mae
# MSE
mse <- mean((rfpredictions - y_test)^2)
mse
# RMSE
rmse <- sqrt(mse)
rmse
# R-squared
rsq <- 1 - (sum((y_test - rfpredictions)^2) / sum((y_test - mean(y_train))^2))
rsq

plot(rf)
