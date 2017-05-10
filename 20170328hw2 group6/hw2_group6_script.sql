#1 總共有多少人註冊
select count(*)
from users;
#2 外國選手占多少比例呢
select count(*)/4034
from players
where foreigner=1;
#3 註冊的人裡面那些人學校名稱裡面有"交通"這兩個字
select uid
from users
where school like '%交通%';
#4 羽球第一隊和最後一隊的報名時間
select t.timestamp
from teams t
where t.tid in(select min(t2.tid) from teams t2 where t2.category='bad')
or t.tid in(select max(t3.tid) from teams t3 where t3.category='bad'); #藉由巢狀的查詢來找出第一隊或是最後一隊
#5  2016/11/26~2016/12/09 每天分別有多少隊伍報名?
select date(timestamp) as that_day,count(*) as that_day_registered_team
from teams
where success=1
group by date(timestamp); #as the same form of timestamp , or will not work
#6　每個項目分別有多少成功報名的選手? 
select teams.category,count(*)
from teams inner join players on teams.tid=players.tid
where teams.success=1
group by teams.category;
#7 選手中壽星最多的前 10 個日期,分別有多少壽星
select date_format(birthday,"%m-%d") as bday,count(*) as topten_bday_cnt 
from players 
group by date_format(birthday,"%m-%d") #Just extract the date part from timestamp 
order by topten_bday_cnt desc limit 10; #挑出前十名的出生日期
#8 這個選手(pid=3141)的資料怪怪的,幫我找看看幫他報名的人(隊長或經理)的 email
select users.email
from users inner join teams on(users.uid=teams.uid) inner join players on(teams.tid=players.tid)
where players.pid=3141;
#9 哪些選手成功報名兩個項目
select p.id_num
from players p inner join teams t on(p.tid=t.tid)
where t.success=1
group by p.id_num
having count(*)=2;
#10挑出報名兩項的選手;
#the following are TA's answer
select A.realname,A.id_num,A.teamname,A.category,B.teamname,B.category 
from 
(select teams.tid,teams.category,teams.teamname,players.id_num,players.realname from teams 
join players on teams.tid=players.tid where teams.success=1) A
join 
(select teams.tid,teams.category,teams.teamname,players.id_num,players.realname from teams 
join players on teams.tid=players.tid where teams.success=1) B
on A.id_num=B.id_num
where A.tid!=B.tid;
