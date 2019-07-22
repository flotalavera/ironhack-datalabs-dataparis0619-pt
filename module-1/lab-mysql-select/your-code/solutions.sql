/*MY SQL SELECT*/
USE publications;
SELECT a.au_id AS Author_ID, a.au_lname AS Last_name, a.au_fname AS First_Name, t.title AS Title, pub.pub_name AS Publishers
FROM authors a
JOIN titleauthor ta
ON a.au_id= ta.au_id
JOIN titles t
ON ta.title_id= t.title_id
JOIN publishers pub
ON pub.pub_id=t.pub_id;


USE publications;
SELECT SUM(TITLES_COUNT) FROM
(SELECT a.au_id AS AUTHOR_ID, a.au_lname AS LAST_NAME, a.au_fname AS FIRST_NAME, pub.pub_name AS PUBLISHERS, COUNT(t.title_id) AS TITLES_COUNT
FROM authors a
JOIN titleauthor ta
ON a.au_id= ta.au_id
JOIN titles t
ON ta.title_id=t.title_id
JOIN publishers pub
ON pub.pub_id=t.pub_id
GROUP BY a.au_id, pub.pub_name, a.au_lname, a.au_fname) BLA;

USE publications;
SELECT authors.au_id AS AUTHOR, authors.au_lname AS LAST_NAME, authors.au_fname AS FIRST_NAME, SUM(sales.qty) AS TOTAL
FROM authors
LEFT JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN sales
ON sales.title_id=titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TOTAL DESC
#LIMIT 3;


USE publications;
SELECT authors.au_id AS AUTHOR, authors.au_lname AS LAST_NAME, authors.au_fname AS FIRST_NAME, (titles.advance + (titles.royalty/100)*price*ytd_sales) AS PROFIT
FROM authors
LEFT JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN sales
ON sales.title_id=titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, PROFIT
ORDER BY PROFIT DESC
LIMIT 3;

/*MYS SQL ADVANCED*/
USE publications;
SELECT authors.au_id AS AUTHOR, authors.au_lname AS LAST_NAME, authors.au_fname AS FIRST_NAME, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM authors
LEFT JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN sales
ON sales.title_id=titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, sales_royalty
ORDER BY sales_royalty DESC
LIMIT 3;

/*LAB MYSQL ADVANCED*/
USE publications;
SELECT authors.au_id AS AUTHOR, authors.au_lname AS LAST_NAME, authors.au_fname AS FIRST_NAME, titles.title_id, sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM authors
LEFT JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN sales
ON sales.title_id=titles.title_id
GROUP BY authors.au_id, titles.title_id
ORDER BY sales_royalty DESC
#LIMIT 3;

/*LAB ADVANCED MYSQL CHALLENGE DEUX*/
SELECT authors.au_id AS AUTHOR, authors.au_lname AS LAST_NAME, authors.au_fname AS FIRST_NAME, titles.title_id, (titles.advance + titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS total_profits
FROM authors
LEFT JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN sales
ON sales.title_id=titles.title_id
GROUP BY authors.au_id, titles.title_id, total_profits
ORDER BY total_profits DESC
#LIMIT 3;

LAB ADVANCED MYSQL CHALLENGE TROIS
USE publications;
create table most_profiting_authors
SELECT authors.au_id AS AUTHOR, (titles.advance + titles.price * sales.qty * titles.royalty / 100 *titleauthor.royaltyper / 100) AS total_profits
FROM authors
LEFT JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN sales
ON sales.title_id=titles.title_id
GROUP BY authors.au_id, total_profits
ORDER BY total_profits DESC;
