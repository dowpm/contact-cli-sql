# Contact CLI (Database version)
 ## Mac Dowell and Clifford
## Project Description
The CLI Contact App is an app that allows you to:
- Create a contact and save it to an SQL Database
- Read or display these contacts as a whole or separately (with more details).
- Update a contact in the the database.
- Delete a contact in the database.

A contact should be defined at least with this:
- name
- phone number
- address
- email

## Requirements
1. The App should be Object Oriented Programing (OOP) instead of Procedural
2. The contacts should be saved in a SQLite database (instead of a local file)
3. Using Git/Github for version control
4. Using TDD (Test Driven Development) to test each feature.

## Acceptation Criteria
- The project should communicate effectively with the database (no inconsistency in the data)
- Git/Github
  - Git should be used effectively for team collaboration:
    It means that each programmer on the project can work on separate branches and merge them 
    to create the final work.
  - Each branch should have many commits
  - The project should be pushed to remote at each feature completion.
- Unit Test
  Each of these features (CREATE,READ,UPDATE,DELETE) should have tests associated with them.
  These tests should demonstrate effective communication with the database. For Example:
  For the Create section (where you save a contact to your contact dabase) you should test that: 
    -the contact is really created in the database (using a select query inside your spec file)
      After being saved the database will return the id of the created contact. Then, the programmer
      can use this id to query the database to confirm the creation of the saved contact.
  
  ## Instructions
  To start working on your project you need to:
  - fork this repo
  - clone it on your machine
  - Define your depencencies in the Gemfile
    - SQLite3
    - Terminal Table (optional)
    - Rspec
    - ...
