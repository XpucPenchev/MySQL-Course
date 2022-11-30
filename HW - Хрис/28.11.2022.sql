-- use books_db;

-- -- Select--  all books (name and year) sorted by pub_date, ascending

-- select book_name, pub_year from books
-- order by pub_year asc;

-- How many are the books published before 1900 year?

-- select * from books
-- Where pub_year < 1900;

-- Select all books (name and year) published in 20th century:

-- select book_name, pub_year from books
-- where pub_year between 1900 and 1999;

-- select book_name, pub_year from books
-- where pub_year > 1900 and pub_year <= 1999;


-- Show how many years each of the authors have lived:

-- select death_year - birth_year as lived, lname from authors;

-- use books_db;

-- select book_name, pub_year from books
-- order by pub_year asc;

-- select count(ID) from books
-- Where pub_year < 1900;

-- select book_name, pub_year from books



-- select id from authors where fname like 'Kurt';

-- select * from books where author_id = (select id from authors where fname like 'Kurt');

-- select * from books where author_id = (select id from authors where fname like 'Kurt') order by pub_year desc limit 3;

 
-- select * from books;
-- -----------------------------------Select with group by-------------------------------
-- Show how many books each of the authors has published?

-- select COUNT(*) as books_count , lname from authors, books
-- where authors.id=books.author_id
-- group by lname
-- order by count(*) DESC;

-- --------------------Rename author 'Charles Dodgson' to 'Lewis Carroll'-----------------
-- select * from authors;

-- update authors set fname = 'Lewis', lname = 'Carroll'
-- where id = 3;


