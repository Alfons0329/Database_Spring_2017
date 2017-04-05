SELECT COUNT(*) as allPlayersRecorded
FROM Master;

SELECT COUNT(DISTINCT birthCountry)
FROM Master;

SELECT yearID,playerID
FROM Pitching p
WHERE (p.HR>=50 AND p.HR<=60);

select count(distinct `park.name`) as ParkName_withStadium_cnt
from Parks p
where p.`park.name` like '%Stadium%';

select avg(datediff(finalGame,debut)) as days_diff
from Master;

select name_full as School_fullName
from Schools s,Master m,CollegePlaying c
where m.debut like '%2000%' and (m.playerID=c.playerID) and (c.schoolID=s.schoolID);

select avg(salary) as avgSalary ,max(salary) as maxSalary
from Salaries s;

select nameFirst,nameLast
from Master m,Salaries s
where (m.playerID=s.playerID) and (s.salary in (
select max(salary)
from Salaries)  #nested query
);

select nameFirst,nameLast
from Master m,Salaries s
where (m.playerID=s.playerID) and (s.salary=33000000); #same procedure

#curse during 1920~2004
#9-1 the highest paid Gameplayer during these days
select nameFirst,nameLast
from Master m,Salaries s,Teams t,Pitching p,Batting b
where 
(m.playerID=s.playerID)
and (m.playerID=b.playerID or m.playerID=p.playerID)
and (b.teamID=t.teamID or p.teamID=t.teamID)
and (t.LgWin='Y')
and (m.debut between '1920-01-01' and '2004-12-31') 
and (m.finalGame between '1920-01-01' and '2004-12-31')
and (s.salary in (select max(salary)from Salaries)  #nested query
);

#9-2 the hightest paid Redsock player during these days

