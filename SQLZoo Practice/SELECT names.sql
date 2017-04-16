#7
SELECT name FROM world
WHERE name LIKE '%a%a%a%';
#8
SELECT name FROM world
WHERE name LIKE '_t%'
ORDER BY name;
#9
SELECT name FROM world
WHERE name LIKE '%o__o%';
#10
SELECT name FROM world
WHERE name LIKE '____';
#11
SELECT name
FROM world
WHERE world.name = world.capital;
#12

SELECT name FROM world  
WHERE capital = concat(name, ' City');

#13


SELECT capital,name
FROM world  
WHERE capital like concat('%',name,'%');
#14
SELECT name,capital
FROM world  
WHERE capital like concat('%',name, '%')  and capital!=name  ;