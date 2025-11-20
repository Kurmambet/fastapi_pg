INSERT INTO workers (username) VALUES 
('Jack'),
('Michael');

-- async def join_cte_subquery_window_func():
WITH helper2 AS (
    SELECT *, compensation-avg_workload_compensation AS compensation_diff
    FROM 
    (SELECT
        w.id,
        w.username,
        r.compensation,
        r.workload,
        avg(r.compensation) OVER (PARTITION BY workload)::int AS avg_workload_compensation
    FROM resumes r
    JOIN workers w ON r.worker_id = w.id) helper1
)   
SELECT * FROM helper2
ORDER BY compensation_diff DESC;





SELECT * FROM helper2
ORDER BY compensation_diff DESC;

WITH helper2 AS
(SELECT helper1.worker_id AS worker_id, 
        helper1.username AS username, 
        helper1.compensation AS compensation, 
        helper1.workload AS workload, 
        helper1.avg_workload_compensation AS avg_workload_compensation, 
        helper1.compensation - helper1.avg_workload_compensation AS compensation_diff
        FROM (SELECT 
                    resumes_1.id AS id, 
                    resumes_1.title AS title,   
                    resumes_1.compensation AS compensation, 
                    resumes_1.workload AS workload, 
                    resumes_1.worker_id AS worker_id, 
                    resumes_1.created_at AS created_at, 
                    resumes_1.updated_at AS updated_at, 
                    workers_1.id AS id_1, 
                    workers_1.username AS username, CAST(avg(resumes_1.compensation) OVER (PARTITION BY resumes_1.workload) AS INTEGER) AS avg_workload_compensation
                    FROM workers AS workers_1 JOIN resumes AS resumes_1 ON resumes_1.worker_id = workers_1.id) 
            AS helper1)
 SELECT helper2.worker_id, 
        helper2.username, 
        helper2.compensation, 
        helper2.workload, 
        helper2.avg_workload_compensation, 
        helper2.compensation_diff
FROM helper2 ORDER BY helper2.compensation_diff DESC







WITH helper2 AS
(SELECT helper1.worker_id AS worker_id, 
        helper1.username AS username, 
        helper1.compensation AS compensation, 
        helper1.workload AS workload, 
        helper1.avg_workload_compensation AS avg_workload_compensation, 
        helper1.compensation - helper1.avg_workload_compensation AS compensation_diff
        FROM (SELECT resumes_1.id AS id, 
                     resumes_1.title AS title, 
                     resumes_1.compensation AS compensation, 
                     resumes_1.workload AS workload, 
                     resumes_1.worker_id AS worker_id, 
                     resumes_1.created_at AS created_at, 
                     resumes_1.updated_at AS updated_at, 
                     workers_1.id AS id_1, 
                     workers_1.username AS username, CAST(avg(resumes_1.compensation) OVER (PARTITION BY resumes_1.workload) AS INTEGER) AS avg_workload_compensation
                FROM workers AS workers_1 JOIN resumes AS resumes_1 ON resumes_1.worker_id = workers_1.id) 
            AS helper1)
 SELECT helper2.worker_id, 
        helper2.username, 
        helper2.compensation, 
        helper2.workload, 
        helper2.avg_workload_compensation, 
        helper2.compensation_diff
FROM helper2 ORDER BY helper2.compensation_diff DESC

2025-11-20 09:14:07,207 INFO sqlalchemy.engine.Engine [generated in 0.00082s] ()
len(result)=9. result=[ (2, 'Michael', 300000, <Workload.fulltime: 'fulltime'>, 125000, 175000), 
                        (2, 'Michael', 250000, <Workload.parttime: 'parttime'>, 133333, 116667), 
                        (1, 'Jack', 150000, <Workload.fulltime: 'fulltime'>, 125000, 25000), 
                        (5, 'Petr', 100000, <Workload.fulltime: 'fulltime'>, 125000, -25000), 
                        (4, 'Roman', 90000, <Workload.fulltime: 'fulltime'>, 125000, -35000), 
                        (4, 'Roman', 80000, <Workload.parttime: 'parttime'>, 133333, -53333), 
                        (3, 'Artem', 70000, <Workload.parttime: 'parttime'>, 133333, -63333), 
                        (3, 'Artem', 60000, <Workload.fulltime: 'fulltime'>, 125000, -65000), 
                        (1, 'Jack', 50000, <Workload.fulltime: 'fulltime'>, 125000, -75000)]
2025-11-20 09:14:07,210 INFO sqlalchemy.engine.Engine ROLLBACK

