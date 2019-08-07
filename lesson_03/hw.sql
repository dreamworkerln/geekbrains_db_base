1. Города

1.1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна

SELECT con.`display_name` AS 'страна', reg.`display_name` AS 'область', dis.`display_name` AS 'район', loc.`display_name` AS 'населенный пункт'
FROM `locality` loc
LEFT JOIN  `district` dis ON loc.`district_id` = dis.`id`
LEFT JOIN  `region` reg ON loc.`region_id` = reg.`id`
LEFT JOIN  `country` con ON reg.`country_id` = con.`id`
WHERE loc.name = 'lisky';

1.2. Выбрать все города из области.

SELECT loc.`display_name` AS 'населенный пункт'
FROM `locality` loc
LEFT JOIN  `region` reg ON loc.`region_id` = reg.`id`
WHERE reg.name = 'voronezh';


2. Сотрудники

2.1. Выбрать среднюю зарплату по отделам.

SELECT AVG(`staff`.salary) 
FROM `staff`
GROUP BY `staff`.dep_id;


2.2. Выбрать максимальную зарплату у сотрудника.
SELECT MAX(`staff`.salary) 
FROM `staff`;


2.3. Удалить одного сотрудника, у которого максимальная зарплата.

DELETE FROM `staff` WHERE st.id = (SELECT st.id FROM `staff` st ORDER BY st.salary DESC LIMIT 1);


2.4. Посчитать количество сотрудников во всех отделах.

SELECT COUNT(*)
FROM `staff` st
GROUP BY st.dep_id;


SELECT COUNT(*)
FROM `staff` st


2.5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.

SELECT SUM(salary)
FROM `staff` st
GROUP BY st.dep_id;