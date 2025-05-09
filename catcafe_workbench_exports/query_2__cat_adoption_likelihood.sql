WITH
  cat_attrs AS (SELECT c.cat_id, c.energy_level, c.breed, c.gender AS sex FROM cat c),
  medical AS (SELECT mr.cat_id,
    MAX(CASE WHEN mr.vaccinations IS NOT NULL AND mr.vaccinations <> '' THEN 1 ELSE 0 END) AS vaccinated,
    MAX(CASE WHEN LOWER(mr.notes) REGEXP 'spay|neuter' THEN 1 ELSE 0 END) AS spay_neuter
    FROM medical_record mr GROUP BY mr.cat_id),
  visits AS (SELECT v.cat_id,
      SUM(v.duration_minutes) AS duration_minutes,
      COUNT(*) AS num_visits,
      DATEDIFF(CURDATE(), MAX(v.visit_datetime)) AS days_since_last_visit
      FROM visit v GROUP BY v.cat_id),
  
  interactions AS (SELECT tv.cat_id,
     COUNT(*) AS num_interactions,
     SUM(t.amount) AS spend_after_interaction
     FROM transaction_visit tv
     JOIN transaction t ON t.transaction_id = tv.transaction_id
     GROUP BY tv.cat_id),

  adoption AS (SELECT ar.cat_id,
     MAX(CASE WHEN ar.adoption_status = 'APPROVED' THEN 1 ELSE 0 END) AS adopted
     FROM adoption_request ar
     GROUP BY ar.cat_id)
  
  SELECT ca.cat_id, ca.energy_level, ca.breed, ca.sex,
  COALESCE(m.vaccinated,0) AS vaccinated,
  COALESCE(m.spay_neuter,0) AS spay_neuter,
  COALESCE(v.duration_minutes,0)AS duration_minutes,
  COALESCE(v.num_visits,0) AS num_visits,
  v.days_since_last_visit,
  COALESCE(i.num_interactions,0) AS num_interactions,
  COALESCE(i.spend_after_interaction,0) AS spend_after_interaction,
  COALESCE(a.adopted,0) AS adopted
FROM cat_attrs ca
LEFT JOIN medical m ON m.cat_id = ca.cat_id
LEFT JOIN visits v ON v.cat_id = ca.cat_id
LEFT JOIN interactions i ON i.cat_id = ca.cat_id
LEFT JOIN adoption a ON a.cat_id = ca.cat_id
ORDER BY ca.cat_id;
