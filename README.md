
# 📋 Kultra Mega Stores Inventory Analysis

**Business Intelligence Case Study**  
**Time Period Analyzed:** 2009 – 2012  
**Region Focus:** Abuja Division, Nigeria  
**Tool Used:** Excel for previewof dataset, SQL Server Management Studio (SSMS 21), Notepad++ for entry and StackEdit (For markdown editing).

---

## 📦 Case Scenario I

### 🔹 1. Which Product Category Had the Highest Sales?

```sql
SELECT Product_Category, SUM(Sales) AS Total_Sales
FROM KMS_Case_Study
GROUP BY Product_Category
ORDER BY Total_Sales DESC;
```

| Product_Category   | Total_Sales        |
|--------------------|--------------------|
| Technology         | ₦5,984,248.18      |
| Furniture          | ₦5,178,590.54      |
| Office Supplies    | ₦3,752,762.10      |

✅ **Insight:**  
Technology products generated the highest revenue and should be prioritized for upselling and bulk offers.

---

### 🔹 2. What Are the Top 3 and Bottom 3 Regions in Terms of Sales?

#### 🏆 Top 3 Regions

```sql
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM KMS_Case_Study
GROUP BY Region
ORDER BY Total_Sales DESC;
```

| Region     | Total_Sales      |
|------------|------------------|
| West       | ₦3,597,549.28    |
| Ontario    | ₦3,063,212.48    |
| Prarie     | ₦2,837,304.60    |

#### 🚩 Bottom 3 Regions

```sql
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM KMS_Case_Study
GROUP BY Region
ORDER BY Total_Sales ASC;
```

| Region               | Total_Sales       |
|----------------------|-------------------|
| Nunavut              | ₦116,376.48       |
| Northwest Territories| ₦800,847.33       |
| Yukon                | ₦975,867.37       |

✅ **Insight:**  
Sales efforts could be ramped up in underperforming regions like Nunavut using local campaigns or improved delivery coverage.

---

### 🔹 3. Total Sales of Appliances in Ontario?

```sql
SELECT
    SUM(Sales) AS Total_Sales_Appliances_Ontario
FROM
    KMS_Case_Study
WHERE
    Product_Category = 'Appliances'
    AND ('Ontario' IN (Province, Region));
```

| Total_Sales_Appliances_Ontario |
|--------------------------------|
| NULL                           |

⚠️ **Insight:**  
There were **no appliance sales** recorded for Ontario — either due to lack of demand, missing data or supply chain issues.

---

### 🔹 4. How to Increase Revenue from Bottom 10 Customers

```sql
SELECT TOP 10 Customer_Name, SUM(Sales) AS Total_Sales
FROM KMS_Case_Study
GROUP BY Customer_Name
ORDER BY Total_Sales ASC;
```

| Customer_Name        | Total_Sales |
|----------------------|-------------|
| Jeremy Farry         | ₦85.72     |
| Natalie DeCherney    | ₦125.90    |
| Nicole Fjeld         | ₦153.03    |
| Katrina Edelman      | ₦180.76    |
| Dorothy Dickinson    | ₦198.08    |
| Christine Kargatis   | ₦293.22    |
| Eric Murdock         | ₦343.33    |
| Chris McAfee         | ₦350.18    |
| Rick Huthwaite       | ₦415.82    |
| Mark Hamilton        | ₦450.99    |

Checked their buying habits to make informed recommendations.

```sql
SELECT
    Customer_Name,
    Product_Category,
    Product_Sub_Category,
    SUM(Sales) AS Total_Spent
FROM KMS_Case_Study
WHERE Customer_Name IN (
    SELECT TOP 10 Customer_Name
    FROM KMS_Case_Study
    GROUP BY Customer_Name
    ORDER BY SUM(Sales) ASC
)
GROUP BY Customer_Name, Product_Category, Product_Sub_Category
ORDER BY Customer_Name, Total_Spent DESC;
```

✅ **Insight:**  
These customers contribute very little to overall revenue. KMS should:
- Offer personalized promotions to these customers
- Recommend high-margin complementary products
- Use loyalty programs or email campaigns targeting their interests

---

### 🔹 5. Which Shipping Method Incurred the Highest Cost?

```sql
SELECT
    Ship_Mode,
    SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM
    KMS_Case_Study
GROUP BY
    Ship_Mode
ORDER BY
    Total_Shipping_Cost DESC;
```

| Ship_Mode      | Total_Shipping_Cost |
|----------------|---------------------|
| Delivery Truck | ₦51,971.94        |
| Regular Air    | ₦48,008.19        |
| Express Air    | ₦7,850.91         |

✅ **Insight:**  
Despite being positioned as the most economical, **Delivery Truck** incurred the highest shipping cost. A shipping cost audit is recommended.

---

### 🔹 6. Who Are the Most Valuable Customers, and What Products or Services Do They Typically Purchase?

Checked the top 10 customers with highest sales:

```sql
SELECT TOP 10 Customer_Name, SUM(Sales) AS Total_Sales
FROM KMS_Case_Study
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;
```

| Customer_Name      | Total_Sales         |
|--------------------|---------------------|
| Emily Phan         | ₦117,124.44         |
| Deborah Brumfield  | ₦97,433.14          |
| Roy Skaria         | ₦92,542.15          |
| Sylvia Foulston    | ₦88,875.76          |
| Grant Carroll      | ₦88,417.00          |
| Alejandro Grove    | ₦83,561.93          |
| Darren Budd        | ₦81,577.34          |
| Julia Barnett      | ₦80,044.45          |
| John Lucas         | ₦79,696.19          |
| Liz MacKendrick    | ₦76,306.43          |

Then, checked their buying habits:

```sql
SELECT 
    Customer_Name,
    Product_Category,
    Product_Sub_Category,
    COUNT(*) AS Times_Purchased,
    SUM(Sales) AS Total_Spent
FROM 
    KMS_Case_Study
WHERE 
    Customer_Name IN (
        'Emily Phan',
        'Deborah Brumfield',
        'Roy Skaria',
        'Sylvia Foulston',
        'Grant Carroll',
        'Alejandro Grove',
        'Darren Budd',
        'Julia Barnett',
        'John Lucas',
        'Liz MacKendrick'
    )
GROUP BY 
    Customer_Name, Product_Category, Product_Sub_Category
ORDER BY 
    Customer_Name, Total_Spent DESC;
```
| Customer_Name       | Product_Category   | Product_Sub_Category           |   Times_Purchased |   Total_Spent |
|:----------------    |:-------------------|:-------------------------------|------------------|---------------:|
| Alejandro Grove     | Office Supplies    | Binders and Binder Accessories | 2                | 41199.12       |
| Alejandro Grove     | Furniture          | Tables                         | 2                | 17638.56       |
| Alejandro Grove     | Furniture          | Chairs & Chairmats             | 2                | 13552.24       |
| Alejandro Grove     | Office Supplies    | Appliances                     | 1                | 9081.98        |
| Alejandro Grove     | Office Supplies    | Envelopes                      | 1                | 806.08         |
| Alejandro Grove     | Furniture          | Office Furnishings             | 2                | 675.11         |
| Alejandro Grove     | Office Supplies    | Paper                          | 1                | 306.30         |
| Alejandro Grove     | Office Supplies    | Pens & Art Supplies            | 1                | 163.98         |
| Alejandro Grove     | Office Supplies    | Storage & Organization         | 1                | 70.02          |
| Alejandro Grove     | Office Supplies    | Labels                         | 1                | 68.54          |
| Darren Budd         | Technology         | Copiers and Fax                | 1                | 23949.51       |
| Darren Budd         | Furniture          | Office Furnishings             | 16               | 20155.74       |
| Darren Budd         | Furniture          | Chairs & Chairmats             | 8                | 14176.35       |
| Darren Budd         | Technology         | Office Machines                | 1                | 7235.83        |
| Darren Budd         | Furniture          | Bookcases                      | 4                | 6650.21        |
| Darren Budd         | Technology         | Telephones and Communication   | 2                | 4028.75        |
| Darren Budd         | Technology         | Computer Peripherals           | 5                | 2996.04        |
| Darren Budd         | Furniture          | Tables                         | 4                | 2384.91        |
| Deborah Brumfield   | Technology         | Copiers and Fax                | 1                | 28664.52       |
| Deborah Brumfield   | Technology         | Office Machines                | 1                | 25312.00       |
| Deborah Brumfield   | Furniture          | Chairs & Chairmats             | 3                | 12486.36       |
| Deborah Brumfield   | Technology         | Computer Peripherals           | 2                | 12420.86       |
| Deborah Brumfield   | Technology         | Telephones and Communication   | 4                | 10398.42       |
| Deborah Brumfield   | Office Supplies    | Storage & Organization         | 3                | 6936.89        |
| Deborah Brumfield   | Furniture          | Office Furnishings             | 1                | 323.26         |
| Deborah Brumfield   | Office Supplies    | Scissors, Rulers and Trimmers  | 1                | 257.34         |
| Deborah Brumfield   | Office Supplies    | Pens & Art Supplies            | 1                | 238.77         |
| Deborah Brumfield   | Office Supplies    | Labels                         | 1                | 175.76         |
| Deborah Brumfield   | Office Supplies    | Appliances                     | 1                | 128.97         |
| Deborah Brumfield   | Office Supplies    | Binders and Binder Accessories | 1                | 89.99          |
| Emily Phan          | Technology         | Office Machines                | 2                | 103652.49      |
| Emily Phan          | Technology         | Telephones and Communication   | 2                | 6829.48        |
| Emily Phan          | Furniture          | Bookcases                      | 1                | 4011.65        |
| Emily Phan          | Office Supplies    | Binders and Binder Accessories | 2                | 1444.66        |
| Emily Phan          | Office Supplies    | Storage & Organization         | 1                | 487.70         |
| Emily Phan          | Office Supplies    | Appliances                     | 1                | 362.17         |
| Emily Phan          | Office Supplies    | Pens & Art Supplies            | 1                | 336.29         |
| Deborah Brumfield   | Technology         | Copiers and Fax                | 1                | 28664.52       |
| Deborah Brumfield   | Technology         | Office Machines                | 1                | 25312.00       |
| Deborah Brumfield   | Furniture          | Chairs & Chairmats             | 3                | 12486.36       |
| Deborah Brumfield   | Technology         | Computer Peripherals           | 2                | 12420.86       |
| Deborah Brumfield   | Technology         | Telephones and Communication   | 4                | 10398.42       |
| Deborah Brumfield   | Office Supplies    | Storage & Organization         | 3                | 6936.89        |
| Deborah Brumfield   | Furniture          | Office Furnishings             | 1                | 323.26         |
| Deborah Brumfield   | Office Supplies    | Scissors, Rulers and Trimmers  | 1                | 257.34         |
| Deborah Brumfield   | Office Supplies    | Pens & Art Supplies            | 1                | 238.77         |
| Deborah Brumfield   | Office Supplies    | Labels                         | 1                | 175.76         |
| Deborah Brumfield   | Office Supplies    | Appliances                     | 1                | 128.97         |
| Deborah Brumfield   | Office Supplies    | Binders and Binder Accessories | 1                | 89.99          |
| Emily Phan          | Technology         | Office Machines                | 2                | 103652.49      |
| Emily Phan          | Technology         | Telephones and Communication   | 2                | 6829.48        |
| Emily Phan          | Furniture          | Bookcases                      | 1                | 4011.65        |
| Emily Phan          | Office Supplies    | Binders and Binder Accessories | 2                | 1444.66        |
| Emily Phan          | Office Supplies    | Storage & Organization         | 1                | 487.70         |
| Emily Phan          | Office Supplies    | Appliances                     | 1                | 362.17         |
| Emily Phan          | Office Supplies    | Pens & Art Supplies            | 1                | 336.29         |
| Grant Carroll       | Office Supplies    | Binders and Binder Accessories | 4                | 45025.21       |
| Grant Carroll       | Furniture          | Chairs & Chairmats             | 2                | 16483.80       |
| Grant Carroll       | Furniture          | Bookcases                      | 2                | 13035.29       |
| Grant Carroll       | Technology         | Computer Peripherals           | 4                | 5477.22        |
| Grant Carroll       | Office Supplies    | Appliances                     | 1                | 3548.67        |
| Grant Carroll       | Technology         | Telephones and Communication   | 3                | 2275.66        |
| Grant Carroll       | Office Supplies    | Paper                          | 5                | 1077.94        |
| Grant Carroll       | Office Supplies    | Pens & Art Supplies            | 3                | 537.83         |
| Grant Carroll       | Office Supplies    | Storage & Organization         | 1                | 460.68         |
| Grant Carroll       | Furniture          | Office Furnishings             | 1                | 307.76         |
| Grant Carroll       | Office Supplies    | Labels                         | 1                | 186.94         |
| John Lucas          | Furniture          | Tables                         | 2                | 26016.61       |
| John Lucas          | Office Supplies    | Storage & Organization         | 3                | 19846.88       |
| John Lucas          | Furniture          | Chairs & Chairmats             | 1                | 17560.95       |
| John Lucas          | Technology         | Telephones and Communication   | 4                | 9224.94        |
| John Lucas          | Office Supplies    | Appliances                     | 1                | 3725.53        |
| John Lucas          | Office Supplies    | Paper                          | 4                | 2233.54        |
| John Lucas          | Technology         | Computer Peripherals           | 1                | 561.92         |
| John Lucas          | Furniture          | Office Furnishings             | 1                | 512.78         |
| John Lucas          | Office Supplies    | Pens & Art Supplies            | 1                | 13.04          |
| Roy Skaria          | Furniture          | Bookcases                      | 4                | 38092.34       |
| Roy Skaria          | Technology         | Copiers and Fax                | 2                | 27222.45       |
| Roy Skaria          | Furniture          | Tables                         | 1                | 11036.16       |
| Roy Skaria          | Office Supplies    | Storage & Organization         | 1                | 7156.56        |
| Roy Skaria          | Office Supplies    | Binders and Binder Accessories | 3                | 3029.47        |
| Roy Skaria          | Technology         | Computer Peripherals           | 2                | 2607.95        |
| Roy Skaria          | Furniture          | Office Furnishings             | 3                | 1048.74        |
| Roy Skaria          | Office Supplies    | Appliances                     | 1                | 724.13         |
| Roy Skaria          | Office Supplies    | Paper                          | 3                | 698.60         |
| Roy Skaria          | Technology         | Telephones and Communication   | 2                | 518.99         |
| Roy Skaria          | Office Supplies    | Pens & Art Supplies            | 4                | 406.76         |
| Sylvia Foulston     | Furniture          | Chairs & Chairmats             | 6                | 33206.11       |
| Sylvia Foulston     | Technology         | Office Machines                | 1                | 22079.47       |
| Sylvia Foulston     | Furniture          | Tables                         | 2                | 10166.52       |
| Sylvia Foulston     | Technology         | Telephones and Communication   | 3                | 7499.51        |
| Sylvia Foulston     | Office Supplies    | Binders and Binder Accessories | 3                | 5301.01        |
| Sylvia Foulston     | Office Supplies    | Appliances                     | 3                | 4937.98        |
| Sylvia Foulston     | Furniture          | Bookcases                      | 1                | 4462.23        |
| Sylvia Foulston     | Office Supplies    | Envelopes                      | 1                | 683.46         |
| Sylvia Foulston     | Furniture          | Office Furnishings             | 1                | 338.52         |
| Sylvia Foulston     | Technology         | Computer Peripherals           | 1                | 90.06          |
| Sylvia Foulston     | Office Supplies    | Rubber Bands                   | 1                | 78.49          |
| Sylvia Foulston     | Office Supplies    | Labels                         | 1                | 32.40          |


✅ **Insight:**  
The most valuable customers purchase a wide range of products, predominantly in **Technology**, **Furniture**, and **Office Supplies**. Tailored offers focusing on their preferred categories could further boost sales.

---

### 🔹 7. Who is the Most Valuable Small Business Customer?

```sql
SELECT TOP 10 
    Customer_Name, 
    SUM(Sales) AS Total_Sales
FROM 
    KMS_Case_Study
WHERE 
    Customer_Segment = 'Small Business'
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Sales DESC;
```

| Customer_Name | Total_Sales    |
|---------------|----------------|
| Dennis Kane   | ₦75,967.59     |

✅ **Insight:**  
Dennis Kane leads among small business customers, indicating a strong business relationship worth nurturing with personalized marketing.

---

### 🔹 8. Which Corporate Customer Placed the Most Orders (2009–2012)?

```sql
SELECT TOP 1 
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Number_of_Orders
FROM 
    KMS_Case_Study
WHERE 
    Customer_Segment = 'Corporate'
    AND Order_Date BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY 
    Customer_Name
ORDER BY 
    Number_of_Orders DESC;
```

| Customer_Name | Number_of_Orders |
|---------------|------------------|
| Adam Hart     | 18               |

✅ **Insight:**  
Adam Hart is the most active corporate customer, suggesting opportunities to deepen engagement or offer volume discounts.

---

### 🔹 9. Which Consumer Customer Was the Most Profitable?

```sql
SELECT TOP 1 
    Customer_Name, 
    SUM(Profit) AS Total_Profit
FROM 
    KMS_Case_Study
WHERE 
    Customer_Segment = 'Consumer'
GROUP BY 
    Customer_Name
ORDER BY 
    Total_Profit DESC;
```

| Customer_Name | Total_Profit   |
|---------------|----------------|
| Emily Phan    | ₦34,005.44     |

✅ **Insight:**  
Emily Phan is the highest profit-generating consumer, highlighting the importance of targeted retention and upselling strategies.


### 🔹  Which customer returned items and what segment do they belong to?

```sql
SELECT DISTINCT 
    Customer_Name, 
    Customer_Segment, 
    Status
FROM 
    KMS_Case_Study
WHERE 
    Status = 'Returned';
```
# This is a brief version of the result gotten as md editor could not handle more
| Customer_Name        | Customer_Segment | Status   |
|---------------------|------------------|----------|
| Aaron Bergman       | Corporate        | Returned |
| Raymond Book        | Consumer         | Returned |
| Resi Polking        | Small Business   | Returned |
| Ricardo Block       | Corporate        | Returned |
| Richard Eichhorn    | Consumer         | Returned |
| Rick Bensley        | Consumer         | Returned |
| Rick Reed           | Consumer         | Returned |
| Rick Wilson         | Consumer         | Returned |
| Ritsa Hightower     | Corporate        | Returned |
| Rob Lucas           | Small Business   | Returned |
| Rob Williams        | Home Office      | Returned |
| Robert Waldorf      | Home Office      | Returned |
| Roger Demir         | Consumer         | Returned |
| Roland Black        | Small Business   | Returned |
| Roland Fjeld        | Corporate        | Returned |
| Roy French          | Consumer         | Returned |
| Roy Phan            | Consumer         | Returned |
| Roy Phan            | Corporate        | Returned |
| Roy Skaria          | Corporate        | Returned |
| Ruben Dartt         | Corporate        | Returned |
| Ryan Crowe          | Small Business   | Returned |
| Sally Hughsby       | Consumer         | Returned |
| Sally Matthias      | Corporate        | Returned |
| Sam Zeldin          | Small Business   | Returned |
| Sandra Glassco      | Home Office      | Returned |
| Sanjit Chand        | Home Office      | Returned |
| Sanjit Jacobs       | Consumer         | Returned |
| Saphhira Shifley    | Corporate        | Returned |
| Sarah Brown         | Consumer         | Returned |
| Sarah Foster        | Corporate        | Returned |
| Sarah Jordon        | Consumer         | Returned |
| Scot Wooten         | Corporate        | Returned |
| Scott Cohen         | Consumer         | Returned |
| Sean Braxton        | Small Business   | Returned |
| Sean Miller         | Small Business   | Returned |
| Sean O'Donnell      | Corporate        | Returned |
| Sean Wendt          | Corporate        | Returned |
| Shahid Hopkins      | Small Business   | Returned |
| Shaun Chance        | Corporate        | Returned |
| Sheri Gordon        | Corporate        | Returned |
| Shirley Daniels     | Corporate        | Returned |
| Sibella Parks       | Small Business   | Returned |
| Sonia Cooley        | Corporate        | Returned |
| Sonia Sunley        | Small Business   | Returned |
| Speros Goranitis    | Corporate        | Returned |
| Stephanie Phelps    | Consumer         | Returned |
| Stephanie Ulpright  | Consumer         | Returned |
| Steve Chapman       | Corporate        | Returned |
| Steve Nguyen        | Consumer         | Returned |
| Steven Cartwright   | Home Office      | Returned |
| Steven Roelle       | Small Business   | Returned |
| Stuart Calhoun      | Consumer         | Returned |
| Sue Ann Reed        | Consumer         | Returned |
| Sung Pak            | Small Business   | Returned |
| Susan MacKendrick   | Corporate        | Returned |
| Susan Vittorini     | Home Office      | Returned |
| Tamara Dahlen       | Corporate        | Returned |
| Tamara Manning      | Corporate        | Returned |
| Tamara Willingham   | Corporate        | Returned |
| Ted Trevino         | Corporate        | Returned |
| Thais Sissman       | Small Business   | Returned |
| Thea Hudgings       | Consumer         | Returned |
| Theresa Swint       | Consumer         | Returned |
| Thomas Boland       | Corporate        | Returned |
| Tim Brockman        | Consumer         | Returned |
| Toby Knight         | Corporate        | Returned |
| Toby Swindell       | Small Business   | Returned |
| Todd Boyes          | Small Business   | Returned |
| Tom Prescott        | Small Business   | Returned |
| Tom Stivers         | Small Business   | Returned |
| Tom Zandusky        | Home Office      | Returned |
| Tonja Turnell       | Consumer         | Returned |
| Tony Chapman        | Consumer         | Returned |
| Tony Molinari       | Corporate        | Returned |
| Tony Sayre          | Home Office      | Returned |
| Tony Sayre          | Small Business   | Returned |
| Tracy Collins       | Consumer         | Returned |
| Troy Blackwell      | Home Office      | Returned |
| Trudy Bell          | Consumer         | Returned |
| Trudy Brown         | Small Business   | Returned |
| Valerie Dominguez   | Corporate        | Returned |
| Valerie Takahito    | Consumer         | Returned |
| Victor Price        | Consumer         | Returned |
| Victoria Pisteka    | Corporate        | Returned |
| Vivek Grady         | Corporate        | Returned |
| Xylona Price        | Corporate        | Returned |

# Shipping Cost vs. Order Priority and Shipping Mode

```sql
SELECT 
    Order_Priority,
    Ship_Mode,
    COUNT(*) AS Order_Count,
    AVG(Shipping_Cost) AS Avg_Shipping_Cost
FROM 
    KMS_Case_Study
GROUP BY 
    Order_Priority, Ship_Mode
ORDER BY 
    Order_Priority, Avg_Shipping_Cost DESC;
```

| Order_Priority | Ship_Mode       | Order_Count | Avg_Shipping_Cost |
|----------------|-----------------|-------------|-------------------|
| Critical       | Delivery Truck  | 228         | ₦47.30            |
| Critical       | Express Air     | 200         | ₦8.71             |
| Critical       | Regular Air     | 1180        | ₦7.28             |
| High           | Delivery Truck  | 248         | ₦45.19            |
| High           | Regular Air     | 1308        | ₦7.65             |
| High           | Express Air     | 212         | ₦6.86             |
| Low            | Delivery Truck  | 250         | ₦44.53            |
| Low            | Express Air     | 190         | ₦8.17             |
| Low            | Regular Air     | 1280        | ₦8.02             |
| Medium         | Delivery Truck  | 205         | ₦46.15            |
| Medium         | Express Air     | 201         | ₦8.13             |
| Medium         | Regular Air     | 1225        | ₦7.69             |
| Not Specified  | Delivery Truck  | 215         | ₦43.67            |
| Not Specified  | Express Air     | 180         | ₦8.17             |
| Not Specified  | Regular Air     | 1277        | ₦7.62             |

---

## Interpretation

- 🚚 **Delivery Truck** has the highest average shipping cost across *all* order priorities (~₦43–₦47), contrary to the assumption it is the most economical shipping method.
  
- ✈️ **Express Air**, traditionally considered the fastest and most expensive, shows **lower average shipping costs (~₦6.8–₦8.7)** than Delivery Truck in this dataset, which is unexpected.

- The **shipping mode usage does not strongly correlate with order priority**:  
  - Critical orders use Delivery Truck and Express Air fairly evenly.  
  - Low priority orders also use Express Air and Regular Air a lot, which could be unnecessarily expensive/faster than required.

- 📉 **Low priority orders using fast shipping (Express Air, Regular Air) suggest possible overspending** on shipping for orders that do not require urgency.

- 🟡 **Overall, the data suggests the company is not effectively aligning shipping cost and speed with order priority.** There seems to be weak enforcement of priority-based shipping policies.

---

## Conclusion

The company **does not appear to be spending shipping costs appropriately based on Order Priority**, as expensive shipping modes are frequently used for low priority orders and the supposedly economical method (Delivery Truck) is actually the costliest. This indicates opportunities for cost savings by enforcing stricter shipping mode selection based on order priority.
