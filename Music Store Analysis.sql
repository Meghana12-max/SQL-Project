create database music;
use music;

select * from track;
select * from invoice;
select * from invoice1;
select * from employee;
select * from customer;
select * from genre;
select * from artist;
select * from album2;



-- who is senior most employee from job title
SELECT 
    first_name, last_name, title, levels
FROM
    employee
ORDER BY levels DESC
LIMIT 1;

-- which country has the most invoive
SELECT 
    COUNT(*), billing_country
FROM
    invoice1
GROUP BY billing_country
ORDER BY COUNT(*) DESC;

-- what is the top 3 values of total invoice
SELECT 
    *
FROM
    invoice1
ORDER BY total DESC
LIMIT 3;

-- Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals.

SELECT 
    ROUND(SUM(total), 2) AS invoice_total, billing_city
FROM
    invoice1
GROUP BY billing_city
ORDER BY invoice_total DESC;

-- Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money.

SELECT 
    c.customer_id, c.first_name, sum(i.total)  as total_Spent
FROM
    customer c
        JOIN
    invoice1 i ON c.customer_id = i.customer_id
GROUP BY c.customer_id,c.first_name    
ORDER BY total_spent DESC
LIMIT 1;

-- Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A.
SELECT 
    c.first_name, c.last_name, c.email
FROM
    customer c 
        JOIN
    invoice1 i ON c.customer_id = i.customer_id
        JOIN
    invoice invoice ON i.invoice_id = invoice.invoice_id
WHERE
    track_id IN (SELECT 
            t.track_id
        FROM
            track t
                JOIN
            genre g ON t.genre_id = g.genre_id
        WHERE
            g.name = 'Rock')
ORDER BY email ASC;

-- invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock band
SELECT 
    a.name, a.artist_id, COUNT(a.artist_id) as artist_count
FROM
    track t
        JOIN
    album2 album ON t.album_id = album.album_id
        JOIN
    artist a ON album.artist_id = album.artist_id
        JOIN
    genre g ON t.genre_id = g.genre_id
WHERE
    g.name = 'Rock'
GROUP BY a.artist_id,a.name
ORDER BY artist_count desc
LIMIT 10;

--- Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. 
--- Order by the song length with the longest songs listed first.

SELECT 
    name, milliseconds
FROM
    track
WHERE
    milliseconds > (SELECT 
            AVG(milliseconds)
        FROM
            track)
ORDER BY milliseconds DESC;
