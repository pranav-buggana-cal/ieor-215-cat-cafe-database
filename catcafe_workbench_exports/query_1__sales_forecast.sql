/* ==============================================================
   DAILY STORE-LEVEL FEATURE MATRIX + 1-WEEK FORWARD LABEL
   ============================================================== */
WITH
  daily_sales AS (
    SELECT
      DATE(t.txn_datetime) AS sale_date,
      SUM(oi.quantity * oi.unit_price) AS total_spend,
      SUM(
        CASE 
          WHEN p.product_type = 'RETAIL' THEN oi.quantity * oi.unit_price
     ELSE 0
        END
    ) AS retail_spend,
      AVG(oi.unit_price) AS avg_unit_price,
      AVG(p.list_price - oi.unit_price) AS avg_discount_amount,
      AVG(
        (p.list_price - oi.unit_price)/p.list_price
    ) AS avg_discount_pct
    FROM
      transaction AS t
      JOIN `order` AS o ON o.transaction_id = t.transaction_id
      JOIN order_item AS oi ON oi.order_id = o.transaction_id
      JOIN product AS p ON p.product_id = oi.product_id
    GROUP BY
      sale_date
),
  daily_visits AS (
    SELECT
      DATE(t.txn_datetime) AS sale_date,
      COUNT(DISTINCT t.transaction_id) AS total_customer_visits,
      COUNT(DISTINCT tv.transaction_id) AS customer_visits_with_cat
    FROM
      transaction  AS t
      LEFT JOIN transaction_visit AS tv ON tv.transaction_id = t.transaction_id
    GROUP BY
      sale_date
),
  daily_features AS (
    SELECT
      ds.sale_date,
      ds.total_spend,
      CASE
        WHEN ds.total_spend = 0 THEN 0
        ELSE ds.retail_spend/ds.total_spend
      END AS pct_retail_spend,
      dv.total_customer_visits,
      CASE
        WHEN dv.total_customer_visits = 0 THEN 0
        ELSE dv.customer_visits_with_cat/dv.total_customer_visits
      END AS pct_visits_with_cat,
      ds.avg_unit_price,
      ds.avg_discount_amount,
      ds.avg_discount_pct,
	  MONTH(ds.sale_date) AS month_num,      
  /* ----------------------------------------------------------
     US-Federal holidays (observed on calendar date, NOT weekday observed)
     ---------------------------------------------------------- */
  CASE
  /*  Fixed-date holidays  */
  WHEN MONTH(ds.sale_date) =  1 AND DAY(ds.sale_date) =  1 THEN 1  -- New Year’s Day
  WHEN MONTH(ds.sale_date) =  6 AND DAY(ds.sale_date) = 19 THEN 1  -- Juneteenth
  WHEN MONTH(ds.sale_date) =  7 AND DAY(ds.sale_date) =  4 THEN 1  -- Independence Day
  WHEN MONTH(ds.sale_date) = 11 AND DAY(ds.sale_date) = 11 THEN 1  -- Veterans Day
  WHEN MONTH(ds.sale_date) = 12 AND DAY(ds.sale_date) = 25 THEN 1  -- Christmas Day

  /*  Monday-holidays (DAYOFWEEK: Sun=1, Mon=2 … Sat=7)  */
  WHEN MONTH(ds.sale_date) =  1 AND DAYOFWEEK(ds.sale_date) = 2
   AND DAY(ds.sale_date) BETWEEN 15 AND 21  THEN 1  -- MLK Day
  WHEN MONTH(ds.sale_date) =  2 AND DAYOFWEEK(ds.sale_date) = 2
   AND DAY(ds.sale_date) BETWEEN 15 AND 21  THEN 1  -- Washington’s Birthday
  WHEN MONTH(ds.sale_date) =  5 AND DAYOFWEEK(ds.sale_date) = 2
   AND DAY(ds.sale_date) >= 25  THEN 1  -- Memorial Day (last Mon in May)
  WHEN MONTH(ds.sale_date) =  9 AND DAYOFWEEK(ds.sale_date) = 2
   AND DAY(ds.sale_date) BETWEEN  1 AND  7  THEN 1  -- Labor Day (1st Mon Sep)
  WHEN MONTH(ds.sale_date) = 10 AND DAYOFWEEK(ds.sale_date) = 2
   AND DAY(ds.sale_date) BETWEEN  8 AND 14  THEN 1  -- Columbus Day (2nd Mon Oct)

  /*  Thanksgiving – 4th Thursday in Nov  */
  WHEN MONTH(ds.sale_date) = 11 AND DAYOFWEEK(ds.sale_date) = 5
   AND DAY(ds.sale_date) BETWEEN 22 AND 28  THEN 1

  ELSE 0
  END  AS is_holiday
  FROM
  daily_sales   AS ds
  LEFT JOIN daily_visits AS dv USING (sale_date)
)
SELECT
  df.sale_date,
  df.total_spend,
  df.pct_retail_spend,
  df.total_customer_visits,
  df.pct_visits_with_cat,
  df.avg_unit_price,
  df.avg_discount_amount,
  df.avg_discount_pct,
  df.month_num,
  df.is_holiday,
 /* ----------------------------------------------------------
     1-week (7-day) forward spend label
     ---------------------------------------------------------- */
  SUM(df.total_spend) OVER (
   ORDER BY
      df.sale_date
    ROWS BETWEEN 1 FOLLOWING AND 7 FOLLOWING
) AS forward_1w_spend
FROM
  daily_features AS df
ORDER BY
  df.sale_date;
