# 🛒 Superstore Profit Prediction with R

This project analyzes the U.S. subset of the Global Superstore dataset to predict profit using traditional regression models. With over 9,000 records, the dataset includes variables such as product category, region, discount, and sales. Both Linear Regression and Random Forest models were trained and evaluated for predictive performance.


---

## 🧠 Objective

- Understand which features drive profit (sales, discounts, region, etc.)
- Clean, engineer, and visualize the dataset
- Train and evaluate predictive models for business optimization

---

## 📊 Dataset

- **Source:** [Global Super Store Dataset – data.world](https://data.world/vikas-0731/global-super-store)
- **Filtered for:** United States only (~9,996 records)
- **Key Variables:**
  - Sales, Profit, Quantity, Discount
  - Region, State, Category, Sub-Category
  - Date-based variables like Year, Month, Day of Week

---

## 🧪 Models Used

| Model            | MAE     | MSE       | RMSE     | R²     |
|------------------|---------|-----------|----------|--------|
| Linear Regression| 58.50   | 38709.17  | 196.75   | 0.31   |
| Random Forest    | 24.59   | 13075.28  | 114.35   | 0.70   |

> ✅ **Random Forest outperformed all models** with higher accuracy and stronger correlation to actual profit.

---

## 📈 Visualizations & EDA

- Boxplots by Category, Region, Segment, Sub-Category
- Scatter plots (Sales vs. Profit)
- Treemap of Profit by State
- Pie chart for top 3 profitable product categories
- Correlation Heatmap after factor encoding

---

## 🔮 Future Enhancements

- Add polynomial or ensemble models (Gradient Boosting, etc.)
- Create a Streamlit app or dashboard to visualize profit trends
- Automate reporting and KPI alerts

---

## 🎥 Video Presentation

📺 [Watch the full walkthrough (MP4)](https://drive.google.com/file/d/1o7LFo2dzbRUlahEIhJANWun3-1wlWyCe/view?usp=sharing)

---

## 📊 Slide Deck

📂 [Download Presentation (PPTX)](https://docs.google.com/presentation/d/1Ybq63fRh90dfVeuFERJSiSDJreWYr_80/edit?usp=sharing&ouid=117504953909159201245&rtpof=true&sd=true)


## 👨‍💻 Author

**Phanidhar Venkata Naga Kasuba**  
MS in Data Analytics, Webster University  
📫 Email: pkasubavenkatana@webster.edu  
🔗 [LinkedIn](www.linkedin.com/in/phanidhar-kasuba-venkata-naga)

---
