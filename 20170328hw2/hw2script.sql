#1
SELECT COUNT(*) as allPlayersRecorded
FROM Master;
#2
SELECT COUNT(DISTINCT birthCountry)
FROM Master;
#3
SELECT yearID,playerID
FROM Batting b
WHERE (b.HR>=50 AND b.HR<=60);
#4
select count(distinct `park.name`) as ParkName_withStadium_cnt
from Parks p
where p.`park.name` like '%Stadium%';
#5
select avg(datediff(finalGame,debut))/365 as year_diff
from Master;
#6
select distinct name_full as School_fullName
from Schools s,Master m,CollegePlaying c
where m.debut like '%2000-05%' 
and (m.playerID=c.playerID) 
and (c.schoolID=s.schoolID);
#7
select avg(salary) as avgSalary ,max(salary) as maxSalary ,yearID as years
from Salaries s
group by s.yearID;

#7-2 practice
select s.salary,s.playerID
from Salaries s
where s.salary in(select max(s2.salary) from Salaries s2);

#7-3practice
select max(s.salary),s.yearID
from Salaries s
group by s.yearID
having  (s.salary)>30000000;  /*FOR THE Group qualification*/
#7-3 Compare
select (s.salary),s.yearID
from Salaries s
group by s.yearID,s.salary
having s.salary>30000000;
#7-4 group from different table to find the max salary for each of the name combinations
#wrt the team name
select(s.salary),tf.franchName
from Salaries s,TeamsFranchises tf
group by s.salary,tf.franchName;
#7-5每一個球隊給過得最高薪水
#8
select s.yearID,s.playerID,m.nameFirst,m.nameLast
from (select max(s2.salary) as s2maxsalary , s2.yearID from Salaries s2 group by s2.yearID)as s3, Salaries s , Master m
where s.yearID = s3.yearID 
and s.salary =  s3.s2maxsalary #the upper is condensed and aliased as s3# 	
and m.playerID =  s.playerID;
#10 Why is SuzukiIchiro a good player?
select playerID
from Master m
where m.nameFirst = 'Ichiro' and m.nameLast = 'Suzuki';

select avg(allbat.H),avg(ichirobat.H),avg(allbat.2B),avg(ichirobat.2B),avg(allbat.3B),avg(ichirobat.3B), avg(allbat.HR),avg(ichirobat.HR)
from Batting allbat,Batting ichirobat
where ichirobat.playerID = 'suzukic01';

select avg(alls.salary),avg(ichiros.salary)
from Salaries alls,Salaries ichiros
where ichiros.playerID = 'suzukic01';

#11 Bonus problem
#The statistics for payment of each team
select tf.franchName, max(s.salary) as avgteamsalary
from Salaries s ,Teams t ,TeamsFranchises tf
where (t.teamID = s.teamID 
and t.franchID = tf.franchID)
group by tf.franchName
order by avgteamsalary desc; 

#9-1 the highest paid Gameplayer during these days
#curse during 1920~2004
select distinct p.playerID
from Salaries s,Teams t,Pitching p,(select max(s2.salary),s2.playerID from Salaries s2 group by s2.yearID,s2.playerID) as s2maxsalary_g_year
where 
p.teamID=t.teamID
and t.WSWin='Y'
and t.yearID >=1920 and t.yearID<=2004
and p.playerID=s2maxsalary_g_year.playerID 
union
select distinct b.playerID
from Salaries s,Teams t,Batting b,(select max(s3.salary),s3.playerID,s3.yearID from Salaries s3 group by s3.yearID,s3.playerID) as s3maxsalary_g_year
where 
b.teamID=t.teamID 
and t.WSWin='Y'
and t.yearID >=1920 and t.yearID<=2004
and b.playerID=s3maxsalary_g_year.playerID; 
