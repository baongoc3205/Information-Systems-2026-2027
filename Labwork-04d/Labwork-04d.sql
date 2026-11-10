-- Labwork 04d - Review (Sakila)

-- Question 1
USE sakila;

SELECT name
FROM language
ORDER BY name;

-- Question 2
USE sakila;

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%GER%'
ORDER BY first_name;

-- Question 3
USE sakila;

SELECT address, postal_code
FROM address
WHERE postal_code LIKE '57%'
ORDER BY address;

-- Question 4
USE sakila;

SELECT COUNT(*) AS nb_films
FROM film
WHERE title LIKE '%DWARF%';

-- Question 5
USE sakila;

SELECT a.first_name, a.last_name, f.title, f.length, f.release_year
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title LIKE '%WAR%'
  AND f.length > 150
ORDER BY a.last_name, a.first_name;

-- Question 6
USE sakila;

SELECT c.name, COUNT(fc.film_id) AS nb_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
HAVING COUNT(fc.film_id) BETWEEN 55 AND 65
ORDER BY nb_films DESC;

-- Question 7
USE sakila;

SELECT COUNT(*) AS nb_categories
FROM (
    SELECT fc.category_id
    FROM film_category fc
    JOIN film f ON fc.film_id = f.film_id
    GROUP BY fc.category_id
    HAVING AVG(f.replacement_cost - f.rental_rate) > 17
) AS t;

-- Question 8
USE sakila;

SELECT district, MIN(postal_code) AS min_postal_code
FROM address
WHERE postal_code <> '' AND district <> ''
GROUP BY district
HAVING MIN(postal_code) = (
    SELECT MAX(min_pc)
    FROM (
        SELECT MIN(postal_code) AS min_pc
        FROM address
        WHERE postal_code <> '' AND district <> ''
        GROUP BY district
    ) AS t
);

-- Question 9
USE sakila;

SELECT first_name, last_name, 'actor' AS type
FROM actor
WHERE first_name = (SELECT first_name FROM actor WHERE actor_id = 101)
  AND actor_id <> 101
UNION
SELECT first_name, last_name, 'customer' AS type
FROM customer
WHERE first_name = (SELECT first_name FROM actor WHERE actor_id = 101);
