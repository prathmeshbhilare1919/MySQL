-- 1. List all books available in the library
select bk_title from books
where available_copies > 0;

-- 2. Get the names and emails of all customers.
select cname,cemail from customers;

-- 3. Find all the borrow records where the book has not been returned yet (returned_date IS NULL).
select * from borrow_records
where returned_date is null;

-- 4. Count how many books each customer has borrowed
select c.cname, count(br.borrow_id)
from borrow_records br inner join customers c
on br.cust_id = c.cust_id
group by c.cname
order by count(br.borrow_id) desc;


-- 5. Display all books written by a specific author (e.g., 'J.K. Rowling')
select * from books
where author = "J.K. Rowling";

-- 6. List the book title and the name of the customer who borrowed it
select br.borrow_id,b.bk_title, c.cname 
from borrow_records br inner join customers c 
on c.cust_id = br.cust_id
inner join books b on b.book_id = br.book_id;


 -- 7. Get a list of customers who have never borrowed a book
/*select c.cname from customers c inner join borrow_records br
on br.cust_id = c.cust_id
where br.borrow_date is null;

SELECT * FROM customers
WHERE cust_id NOT IN (SELECT DISTINCT cust_id FROM borrow_records);  */

-- 8. Show the total number of books borrowed (including returned and not returned).
select bk_status , count(bk_status) from borrow_records
group by bk_status with rollup;

-- 9. Find the most recently borrowed book along with the customer's name.
SELECT br.borrow_date, b.bk_title, c.cname
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
JOIN customers c ON br.cust_id = c.cust_id
ORDER BY br.borrow_date DESC
LIMIT 1;


-- List all customers who have borrowed more than 2 books. (show book name)
select c.cname, count(br.borrow_id),b.bk_title
from borrow_records br inner join customers c
on br.cust_id = c.cust_id
inner join books b
on b.book_id = br.book_id
group by c.cname,b.bk_title
having count( br.borrow_id) > 2 
order by count( br.borrow_id) desc;

SELECT c.cname,t.total_books_borrowed,b.bk_title
FROM customers c
JOIN (
    SELECT cust_id, COUNT(*) AS total_books_borrowed
    FROM borrow_records
    GROUP BY cust_id
    HAVING COUNT(*) > 2
) t ON c.cust_id = t.cust_id
JOIN borrow_records br ON c.cust_id = br.cust_id
JOIN books b ON br.book_id = b.book_id;















-- 🔹 Advanced Level (11–15)
-- Show the book(s) that are currently borrowed and not yet returned.
select b.bk_title,br.bk_status,b.bk_title
from borrow_records br inner join books b
on br.book_id = b.book_id
where bk_status =  "Issued"
or bk_status = "Not Returned";

-- Find which book has been borrowed the most.
select b.bk_title, count(br.borrow_id) from borrow_records br inner join books b
on b.book_id = br.book_id
group by b.bk_title
order by count(br.borrow_id) desc
 limit 4;
 
-- Calculate how many books are currently out (borrowed but not returned).
select count(bk_status) from borrow_records
where bk_status = "Not returned";


-- List books with no available copies (i.e., all copies are borrowed).
select bk_title , count(available_copies) from books
group by bk_title
order by count(available_copies) ;



-- Show each customer's name, total books borrowed, and the number of books they haven't returned.







 


