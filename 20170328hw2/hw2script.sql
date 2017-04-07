#1
SELECT COUNT(*) as allPlayersRecorded
FROM Master;
#2
SELECT COUNT(DISTINCT birthCountry)
FROM Master;
#3
SELECT yearID,playerID
FROM Pitching p
WHERE (p.HR>=50 AND p.HR<=60);
#4
select count(distinct `park.name`) as ParkName_withStadium_cnt
from Parks p
where p.`park.name` like '%Stadium%';
#5
select avg(datediff(finalGame,debut)) as days_diff
from Master;
#6
select name_full as School_fullName
from Schools s,Master m,CollegePlaying c
where m.debut like '%2000%' and (m.playerID=c.playerID) and (c.schoolID=s.schoolID);
#7
select avg(salary) as avgSalary ,max(salary) as maxSalary ,yearID as years
from Salaries s
group by s.yearID;
#8
select s.yearID,s.playerID
from (select max(s2.salary) as s2maxsalary , s2.yearID from Salaries s2 group by s2.yearID)as s3, Salaries s
where s.yearID = s3.yearID and s.salary =  s3.s2maxsalary; #the upper is condensed and aliased as s3# 
#curse during 1920~2004
#9-1 the highest paid Gameplayer during these days
select nameFirst,nameLast
from Master m,Salaries s,Teams t,Pitching p,Batting b
where 
(m.playerID=s.playerID)
and (m.playerID=b.playerID or m.playerID=p.playerID)
and (b.teamID=t.teamID or p.teamID=t.teamID)
and (t.LgWin='Y')
and (m.debut >'1920-01-01') 
and (m.finalGame <'2004-12-31')
and (s.salary in (select max(salary)from Salaries s2 where s2.yearID<='2004')  #nested query
);


