
/***the following is set as comments because we have already created and populated tables in our database
so no longer need to do that each time we run the file on sqlite***/

/***stores basic info of the books available***/
/*CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author TEXT,genre TEXT);*/

/***stores books that are checked out id here is the same as the id in books table also after a book is returned
the book is no longer in this table***/
/*CREATE TABLE bk_checked_out (cust_id INTEGER,id INTEGER,check_out_date DATE, return_date DATE , overdue BOOLEAN);*/

/***info on customers***/
/*CREATE TABLE customers (cust_id INTEGER PRIMARY KEY,cust_name TEXT, phone_number VARCHAR(15), City TEXT);*/

/***Populate our Tables***/

/*INSERT INTO books VALUES (1,'Creeper','Jennifer H.','Horror');
INSERT INTO books VALUES (2,'There He Goes Again','Max L.','Comedy');
INSERT INTO books VALUES (3,'Golden Planet','William R.','Adventure');
INSERT INTO books VALUES (4,'The Cat That Ran','Jennifer H.','Comedy');
INSERT INTO books VALUES (5,'What Hides In The Dark','Max L.','Horror');
INSERT INTO books VALUES (6,'Childhood Dreams','Raul Q.','Non-Fiction');
INSERT INTO books VALUES (7,'Struggles In Life','Miriam M.','Non-Fiction');
INSERT INTO books VALUES (8,'100 Jokes To Tell Your Family','Liliana F. M.','Comedy');
INSERT INTO books VALUES (9,'Journey To the End','Max L.','Adventure');*/

/***Just to understand the booleans lets pretend the current date is 2024-02-10***/

/*INSERT INTO bk_checked_out VALUES (3,4,'2024-01-15','2024-02-15',0);
INSERT INTO bk_checked_out VALUES (3,7,'2024-01-15','2024-02-15',0);
INSERT INTO bk_checked_out VALUES (4,2'2023-12-12','2024-01-12',1);
INSERT INTO bk_checked_out VALUES (3,6,'2023-12-01','2024-01-01',1);*/

/*INSERT INTO customers VALUES (1,'Maria M','(123)123-1234','La Verrne');
INSERT INTO customers VALUES (2,'Juliana R.','(234)765-6544','Ontario');
INSERT INTO customers VALUES (3,'Robert W.','(543)345-8743','Hemet');
INSERT INTO customers VALUES (4,'Maximilian R.','(654)525-8087','Temecula');
INSERT INTO customers VALUES (5,'Roberta R','(538)960-3556','Mission Viejo');*/

/***These are simple queries that display everything in each table***/
/*SELECT *
FROM books;

SELECT *
FROM bk_checked_out;

SELECT *
FROM customers;*/

/***Provide books that are not checked out***/

/***This query compares the id from books table with the id from bk_checked_out and if they are the same it will
not return the title of that book***/

SELECT title
FROM books
WHERE id NOT IN 
(SELECT id
FROM bk_checked_out);

/***Provide the customer names that have an overdue book ***/

/***this query uses the id from customers table and checks if it is in bk_checked_out
table to then use that id to provide the name of the customer***/

SELECT cust_fname
FROM customers
WHERE cust_id IN
(SELECT cust_id 
FROM bk_checked_out);

/***Maria M. previosly checked out a book from the author Max L. and would like a list of other books from the same author***/

/***Here we are looking for books from the same author AND checking if the books are available or surrently checked out***/
SELECT title
FROM books
WHERE author_firstname = 'Max' AND id NOT IN
(SELECT id
FROM bk_checked_out);

/***a customer would like a list of books that are horror or comedy***/

/***we are looking for books that are either horror or comedy and are not checked out and
if we had a larger database grouping by author would be good***/
SELECT title
FROM books
WHERE genre = 'Comedy' OR genre = 'Horror' AND id NOT IN
(SELECT id
FROM bk_checked_out) GROUP BY author_lastname;

/***Give the names of the customers whos name start with R***/

SELECT cust_fname
FROM customers
WHERE cust_fname LIKE 'R%';

/***How would you improve the tables above?***/

/***Seperating the first and last name of authors in books table and o
customers in customers table***/

/*ALTER TABLE books RENAME author TO author_firstname;
ALTER TABLE books ADD COLUMN author_lastname TEXT;*/

/*ALTER TABLE customers RENAME cust_name TO cust_fname;
ALTER TABLE customers ADD COLUMN cust_lname TEXT;*/

/*UPDATE books
SET author_firstname = 'Jennifer', author_lastname = 'Haws'
WHERE id = 1;*/

/*UPDATE books
SET author_firstname = 'MAX', author_lastname = 'Long'
WHERE id = 2;

UPDATE books
SET author_firstname = 'William', author_lastname = 'Roberts'
WHERE id = 3;

UPDATE books
SET author_firstname = 'Jennifer', author_lastname = 'Haws'
WHERE id = 4;

UPDATE books
SET author_firstname = 'Max', author_lastname = 'Long'
WHERE id = 5;

UPDATE books
SET author_firstname = 'Raul', author_lastname = 'Quiz'
WHERE id = 6;

UPDATE books
SET author_firstname = 'Miriam', author_lastname = 'Menos'
WHERE id = 7;

UPDATE books
SET author_firstname = 'Liliana', author_lastname = 'Foster'
WHERE id = 8;

UPDATE books
SET author_firstname = 'Max', author_lastname = 'Long'
WHERE id = 9;

UPDATE customers
SET cust_fname = 'Maria', cust_lname = 'Mendoza'
WHERE cust_id = 1;

UPDATE customers
SET cust_fname = 'Juliana', cust_lname = 'Rios'
WHERE cust_id = 2;

UPDATE customers
SET cust_fname = 'Robert', cust_lname = 'Willis'
WHERE cust_id = 3;

UPDATE customers
SET cust_fname = 'Maximilian', cust_lname = 'Rios'
WHERE cust_id = 4;

UPDATE customers
SET cust_fname = 'Roberta', cust_lname = 'Rios'
WHERE cust_id = 5;*/

/***After these changes are made need to adjust previous queries
with correct column names***/

/***provide the customer name and the book name they have checked out
as well as the due date***/


/***When accessing multiple tables we need to make sure
we can make a connection to each one through a common column from
one to another***/ 

SELECT books.title,bk_checked_out.return_date,
customers.cust_fname, customers.cust_lname 
FROM books
JOIN bk_checked_out ON books.id = bk_checked_out.id
JOIN customers ON bk_checked_out.cust_id = customers.cust_id;