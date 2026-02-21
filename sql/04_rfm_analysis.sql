-- =====================================
-- RFM BASE CALCULATION
-- =====================================

WITH rfm_base AS (
    SELECT
        c.customer_key,
        MAX(d.full_date) AS last_purchase_date,
        COUNT(f.sales_key) AS frequency,
        SUM(f.total_sales) AS monetary
    FROM fact_sales f
    JOIN dim_customer c ON f.customer_key = c.customer_key
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY c.customer_key
),

rfm_scores AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY last_purchase_date DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency DESC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary DESC) AS monetary_score
    FROM rfm_base
)

SELECT *,
    CASE
        WHEN recency_score >=4 AND frequency_score >=4 AND monetary_score >=4 THEN 'Champions'
        WHEN recency_score >=3 AND frequency_score >=3 THEN 'Loyal Customers'
        WHEN recency_score >=4 AND frequency_score <=2 THEN 'New Customers'
        WHEN recency_score <=2 AND frequency_score >=4 THEN 'At Risk'
        ELSE 'Regular'
    END AS customer_segment
FROM rfm_scores;