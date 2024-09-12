/***Going to import a csv file so need to get table ready***/

/*CREATE TABLE Walmart (store_id INTEGER, date_ DATE, weekly_sales INTEGER, holiday BOOLEAN, temp INTEGER, fuel_price INTEGER,
cpi INTEGER, u_rate INTEGER);*/

/***Provide the Stores  with their Average weekly Sales***/


/***this will display the store with the highest avg sale then continue with it decreasing to show the store 
with the lowest weekly average sales***/

SELECT store_id, AVG(Weekly_sales)
FROM Walmart
GROUP BY store_id
ORDER BY AVG(weekly_sales) DESC;

/***Is there correlation between temperatures, and fuel prices with the weekly sales?***/

/***With this table we can compare the temperature during each week and their sales for that week
it is displayed with desc sales to see if there is a correlation with temperature***/

SELECT store_id, ROUND(temp,0), ROUND(weekly_sales) AS ws
FROM Walmart
ORDER BY store_id ASC, ws DESC;

/***This one does the same as the top except with fuel_price as one of the columns to see its correlation***/

SELECT store_id, ROUND(fuel_price,2), ROUND(weekly_sales) AS ws
FROM Walmart
ORDER BY store_id ASC, ws DESC;

/***We can provide a table where it shows the max temp and the temp of the week with the lowest sales to see if there
is some kind of correlation***/

SELECT store_id, MIN(weekly_sales),temp
FROM Walmart
WHERE store_id BETWEEN 1 AND 4
GROUP BY store_id;

SELECT store_id, ROUND(MAX(temp),1)
FROM Walmart
WHERE store_id BETWEEN 1 AND 4
GROUP BY store_id;

/***here we can actually make the max temp one of the columns to make the values easier to compare***/

SELECT Walmart.store_id, MIN(Walmart.weekly_sales),Walmart.temp,(SELECT ROUND(MAX(walmart1.temp),1)
FROM Walmart AS walmart1
WHERE Walmart.store_id = Walmart1.store_id
GROUP BY Walmart1.store_id)
FROM Walmart
WHERE Walmart.store_id BETWEEN 1 AND 4
GROUP BY Walmart.store_id;

/***Wanna see how holidays affect sales for the week for the first 10 stores ***/


SELECT store_id, weekly_sales
FROM Walmart
WHERE holiday = 1;/*** 0 = no 1 = yes ***/

/***With this query we are able to compare avg sales from holidays and without holidays and we had to rename the table because
we want to make sure the ids align in each row***/

SELECT walmart.store_id, ROUND(AVG(walmart.weekly_sales),0), (SELECT ROUND(AVG(walmart1.weekly_sales)) 
FROM Walmart AS walmart1 
WHERE walmart1.store_id = walmart.store_id AND walmart1.holiday = 0
GROUP BY walmart1.store_id)
FROM Walmart 
WHERE walmart.holiday = 1 AND walmart.store_id BETWEEN 1 AND 10
GROUP BY walmart.store_id;

/***Another option: The next two queries can be used to compare the average sales between weeks with holidays and
weeks without however it is important to notice that the average for weeks with out holidays will be higher because
there are more weeks without holidays ***/

SELECT store_id,ROUND(AVG(weekly_sales),0)
FROM Walmart
WHERE holiday = 1 AND store_id BETWEEN 1 AND 10
GROUP BY store_id;

SELECT store_id, ROUND(AVG(weekly_sales),2)
FROM Walmart
WHERE holiday = 0 AND store_id BETWEEN 1 AND 10
GROUP BY store_id;

/***Unemployment rate in relation to sales***/

SELECT store_id, ROUND(AVG(weekly_sales),0) AS avg_sales, ROUND(AVG(u_rate),0)
FROM Walmart
GROUP BY store_id
ORDER BY avg_sales DESC;