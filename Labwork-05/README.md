# Labwork 05 - DB Design

## Requirements

### Part 1: Magazine Database Design

- A good, close-to-real-world exercise.
- Design a database based on the following requirements:
  - You need a database to manage information about the magazines that you buy habitually.
  - For each magazine, its title, the ISSN (code that identifies the publication), number and year are stored.
  - You need also data about the articles, including its title, page of beginning and page of ending. It is assumed that there are no two articles with the same title.
  - Every article can be written by several authors, whose name, e-mail address and ascription are stored. Besides, a number that indicates the order of authors has to be stored.
- Write a report on:
  - How you made up the structure (those conceptual/logical/physical models)
  - SQL commands to create the database
  - `DESCRIBE` commands and their outputs for all of your tables
  - Name it `Report.10.DB.Design.Magazine.txt` (or `.tex`)
  - Push to your Github repository

---

### Part 2: NGO Database Design

- A good, close-to-real-world exercise.
- Design a database based on the following requirements:
  - A Non-Government Organization (NGO) wants to prepare a database for all its projects. It has diverse head offices in several countries which manage and coordinate the projects of that country.
  - On head offices, an identifier, the city and country where it is located, its address, a phone number and the name of the director are stored.
  - Every head office manages a set of projects, with a code, a title, dates of beginning and end, the assigned budget and the name of the person in charge.
  - One project is formed by a set of actions that can affect several cities.
  - We want to know what actions are realised in each city, storing its name, country and number of inhabitants. We also need an identifier to differentiate them. Also there is wished the investment of the project that corresponds to the city and a small description of the action.
- Write a report on:
  - How you made up the structure (those conceptual/logical/physical models)
  - SQL commands to create the database
  - `DESCRIBE` commands and their outputs for all of your tables
  - Name it `Report.11.DB.Design.NGO.txt` (or `.tex`)
  - Push to your Github repository
