SELECT COUNT(*) 
FROM Master;

SELECT COUNT(DISTINCT birthCountry)
FROM Master;

SELECT yearID,playerID
FROM Pitching p
WHERE (p.HR>=50 AND p.HR<=60);

select count(distinct `park.name`)
from Parks p
where p.`park.name` like '%Stadium%';

