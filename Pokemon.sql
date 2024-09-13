/***we are going to import the data therefore need to create a table with the correct fields***/

/*CREATE TABLE pokemon(poke_id INTEGER , poke_name TEXT, poke_type1 TEXT, poke_type2 TEXT, total_cp INTEGER, total_hp INTEGER,
b_attack INTEGER, b_defense INTEGER,sp_attack INTEGER, sp_defense INTEGER, speed INTEGER,gen INTEGER, legendary TEXT);*/

/*DELETE FROM pokemon WHERE poke_name = 'name';*//***have to delete the header***/

/***Player wants a pokemon that is a grass type, from gen 4 that is not a legendary***/

/***I like to provide all the info just to double check but it can provide just the name of the pokemon as well
in this query we had to use a sub query to check for type since some pokemons can have twp types
and if i just added it in the where as an 'AND' or 'OR' it would not return the correct results***/

SELECT poke_name, poke_type1, gen, legendary
FROM pokemon
WHERE gen = 4 AND legendary = 'FALSE' AND poke_id IN (SELECT poke_id
FROM pokemon 
WHERE poke_type1 = 'Grass' OR poke_type2 = 'Grass'
);

/***Player wants to know the legendary pokemon with the highest speed***/

/***this query is a simple one using the MAX function***/

SELECT poke_name, MAX(speed)
FROM pokemon
WHERE legendary = 'TRUE';

/***Player wants a non legendary pokemon from gen 1 or 2 that has a cp higher than 500 and a speed greater than 80***/

SELECT poke_name, legendary, gen, total_cp, speed
FROM pokemon
WHERE legendary = 'FALSE' AND total_cp > 500 AND speed > 80 AND poke_id IN (SELECT poke_id
FROM pokemon
WHERE gen = 1 OR gen = 2
);

/***Player wants a pokemon that is of a single type and whose special attack is greater than its attack***/

/***WE only check type2 because every pokemon has to have one type and we were not able to use 
poke_type2 IS NULL because the way the data was imported saved the empty slots as ""***/

SELECT poke_name, poke_type1, poke_type2, sp_attack, b_attack
FROM pokemon 
WHERE poke_type2 = "" AND sp_attack > b_attack;

/***To fix the above situation we can always update the table if we really wanted to***/

/*UPDATE pokemon SET poke_type2 = NULL WHERE poke_type2 = "";*/

/***How many pokemon have a defense lower than 50, have two types, and a speed less than 100***/

SELECT COUNT(poke_name)/* b_defense, poke_type1, poke_type2, speed */
FROM pokemon
WHERE b_defense < 50 AND poke_type2 != "" AND speed < 100;

/***Wwhat pokemon have more than one alternate form (so its essentially still considered the same)***/

/***in the data pokemon with alternate forms still use the same poke_id so i did a query where we cound how many
times the same poke_id appears and if it is more than one that means it has an altername form
since we are using an aggregate outside of the select we have to use 'HAVING' instead of 'WHERE'***/
SELECT poke_name
FROM pokemon
GROUP BY poke_id
HAVING COUNT(poke_id) > 1;
