# Air-Cargo-Database Management-Project-SQL

**Project Goal:**

Air Cargo, an aviation company, aims to enhance its operational efficiency and customer service by analyzing its database. As a DBA expert, the objective is to identify regular customers, analyze popular routes, and examine ticket sales details. This will enable Air Cargo to improve customer experience and optimize its services.

**Steps to Accomplish the Project:**

**ER Diagram Creation:**

- Develop an Entity-Relationship (ER) diagram for the Air Cargo database illustrating its structure and relationships.
  
**Database Querying:**

- Write SQL queries to perform various operations and analyze the database.
  
**a. Create table 'route_details':**

- Define suitable data types for fields like route_id, flight_num, origin_airport, destination_airport, aircraft_id, and distance_miles.
  
- Implement check constraints for flight number and ensure uniqueness for route_id.
  
- Enforce a constraint to ensure distance_miles is greater than 0.
  
**b. Extract passengers for routes 01 to 25:**

- Retrieve passengers' data from the passengers_on_flights table for routes 01 to 25.

**c. Identify passengers and total revenue in Business class:**

- Calculate the number of passengers and total revenue in the Business class from the ticket_details table.
  
**d. Display full names of customers:**

- Extract and display the full names of customers by combining first name and last name from the customer table.
  
**e. Identify registered customers who booked a ticket:**

- Fetch customers who have registered and booked a ticket using data from the customer and ticket_details tables.
  
**f. Extract customers flying with Emirates in Economy Plus class:**

- Identify customers flying with Emirates in the Economy Plus class using Group By and Having clause.
  
**g. Check if revenue has crossed 10000:**

- Utilize the IF clause to determine if revenue has crossed 10000 in the ticket_details table.
  
**h. Create and grant access to a new user:**

- Create a new user and grant appropriate access to perform operations on the database.
  
**i. Find maximum ticket price for each class:**

- Use window functions to find the maximum ticket price for each class in the ticket_details table.
  
**j. Enhance speed and performance for route ID 4:**

- Optimize performance to extract passengers for route ID 4 from the passengers_on_flights table.
  
**k. View execution plan for route ID 4 query:**

- Analyze the execution plan for the query extracting passengers for route ID 4.
  
**l. Calculate total ticket price by customer across aircraft IDs:**

- Utilize the ROLLUP function to calculate the total ticket price for each customer across different aircraft IDs.
  
**m. Create a view for business class customers:**

- Generate a view containing only business class customers along with the airline brand.
  
# Stored Procedures and Functions:

**Create stored procedures and functions to streamline data retrieval and processing.**

- a. Retrieve passenger details for a range of routes.
  
- b. Extract details from routes where the distance traveled exceeds 2000 miles.
  
- c. Group flight distances into three categories: short, intermediate, and long-distance travel.
  
- d. Determine if complimentary services are provided based on the class of travel.
  

**Output:**
- The output will include insights into regular customers, popular routes, ticket sales details, and other relevant analyses to enhance Air Cargo's operational efficiency and customer service.
