-- Task 1
use books_db;

SELECT book_name, pub_year FROM books
WHERE pub_year BETWEEN 1950 AND 1970
ORDER BY book_name ASC;

-- Task 2
use books_db;

SELECT COUNT(*) , lname FROM authors, books
WHERE authors.id=books.author_id
GROUP BY lname
ORDER BY count(*) DESC;


