select * from employee

---Q.1 Who is the senior most employee based on job title? */
select * from employee
order by levels desc
limit 1

--/* Q2: Which countries have the most Invoices? */
select * from invoice
select billing_country,count(*) as count_
from invoice
group by billing_country
order by count_ desc
limit 10;

/* Q3: What are top 3 values of total invoice? */

SELECT billing_country, total 

FROM invoice
ORDER BY total DESC

LIMIT 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in 
the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select * from invoice
select billing_city,sum(total) as total_invoice
from invoice
group by billing_city
order by total_invoice desc;



/* Q5: Who is the best customer? The customer who has spent the most
money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/
select * from customer

select c.customer_id,c.first_name,c.last_name,sum(i.total) as total_spending
from customer as c
join invoice as i
on c.customer_id=i.customer_id
group by c.customer_id
order by total_spending desc
limit 5;

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */
select * from track

SELECT distinct email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;


SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName , genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select * from track

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name like 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */


select name,milliseconds
from track
where milliseconds >( select round(avg(milliseconds),2) as song_length
                  from track)
order by milliseconds desc

				  
 SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;               
















