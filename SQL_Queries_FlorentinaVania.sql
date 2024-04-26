
#Question 1 List the trip name of each trip that has the season Late Spring.
SELECT TripName
FROM Trip
WHERE Season = 'Late Spring';

#Question 2  List the trip name of each trip that is in the state of Vermont (VT) or that has a maximum group size greater than 10.
SELECT TripName
FROM Trip
WHERE State = 'VT' OR MaxGrpSize > 10;


#Question 3 List the trip name of each trip that has the season Early Fall or Late Fall.
 SELECT TripName
 FROM Trip
 WHERE Season = 'Early Fall' OR Season = 'Late Fall';

#Question 4 How many trips are in the states of Vermont (VT) or Connecticut (CT)?
SELECT COUNT(*)
FROM Trip
WHERE State IN ('VT', 'CT');

#Question 5 List the name of each trip that does not start in New Hampshire (NH).
SELECT TripName
FROM Trip
WHERE startlocation <> 'New Hampshire';

#Question 6 List the name and start location for each trip that has the type Biking.
SELECT TripName, StartLocation
FROM Trip
WHERE Type = 'Biking';


#Question 7 List the name of each trip that has the type Hiking and that has a distance of greater than six miles. Sort the results by the name of the trip.
SELECT TripName
FROM Trip
WHERE Type = 'Hiking' AND Distance > 6
ORDER BY TripName;


#Question 8 List the name of each trip that has the type Paddling or that is located in Vermont (VT).
SELECT TripName
FROM Trip
WHERE Type = 'Paddling' OR State = 'VT';

#Question 9 How many trips have a type of Hiking or Biking?
SELECT COUNT(*)
FROM Trip
WHERE TYPE IN ('Hiking', 'Biking');

#Question 10 List the trip name and state for each trip that occurs during the Summer season. Sort the results by trip name within state.
SELECT TripName, State
FROM Trip
WHERE Season = 'Summer'
ORDER BY State, TripName;


#Question 11 List the trip name of each trip that has Miles Abrams as a guide.
SELECT t.TripName
FROM trip t
JOIN tripguides tg ON t.TripID = tg.TripID
JOIN guide g ON tg.GuideNum = g.GuideNum 
WHERE g.FirstName = 'Miles' AND g.LastName = 'Abrams';



#Question 12 List the trip name of each trip that has the type Biking and that has Rita Boyers as a guide.
SELECT t.TripName
FROM Trip t
JOIN tripguides tg ON t.TripID = tg.TripID
JOIN guide g ON tg.GuideNum = g.GuideNum 
WHERE t.Type = 'Biking' AND g.FirstName = 'Rita' AND g.LastName ='Boyers';

#Question 13 For each reservation that has a trip date of July 23, 2018, list the customer’s last name, the trip name, and the start location.
SELECT c.LastName, t.TripName, t.StartLocation
FROM Reservation r
JOIN Customer c  ON r.CustomerNum= c.Customernum
JOIN Trip t ON r. TripID = t. TripID
WHERE TripDate = '2018-07-23';


#Question 14 How many reservations have a trip price that is greater than $50.00 but less than $100.00?
SELECT COUNT(*)
FROM Reservation
WHERE TripPrice  > 50.00 AND TripPrice < 100.00;



#Question 15 For each reservation with a trip price of greater than $100.00, list the customer’s last name, the trip name, and the trip type.
SELECT c.LastName, t.TripName, t.Type
FROM Reservation r
JOIN Customer c  ON r.CustomerNum= c.Customernum
JOIN Trip t ON r. TripID = t. TripID
WHERE r.TripPrice > 100.00;


#Question 16 List the last name of each customer who has a reservation for a trip in Maine (ME).
SELECT DISTINCT c.LastName
FROM Reservation r
JOIN Customer c ON r.CustomerNum = c.CustomerNum
JOIN Trip t ON r.TripID = t.TripID
WHERE t.State = 'ME';


#Question 17 How many trips originate in each state? Order the results by the state.
SELECT State, COUNT(TripID) AS NumberOFTrip
FROM Trip
GROUP BY State
ORDER BY State;


#Question 18 List the reservation ID, customer last name, and the trip name for all reservations where the number of persons included in the reservation is greater than four.
SELECT r.ReservationID, c.LastName, t.TripName
FROM Reservation r
JOIN Customer c ON r.CustomerNum = c.CustomerNum
JOIN Trip t ON r.TripID = t.TripID
WHERE r.NumPersons > 4;


#Question 19 List the trip name, the guide’s first name, and the guide’s last name for all trips that originate in New Hampshire (NH). Sort the results by guide’s last name within trip name.
SELECT t.TripName, g.FirstName,g.LastName
FROM Trip t
JOIN TripGuides tg ON t.TripID = tg.TripID
JOIN Guide g ON tg.GuideNum = g.GuideNum 
WHERE t.State = 'NH'
ORDER BY t.TripName, g.LastName;


#Question 20 List the reservation ID, customer number, customer last name, and customer first name for all trips that occur in July 2018.
SELECT r.ReservationID, c.CustomerNum , c.LastName, c.FirstName
FROM Reservation r
JOIN Customer c ON c.CustomerNum = r.CustomerNum
WHERE r.TripDate BETWEEN '2018-06-30' AND '2018-08-01';


#Question 21 Colonial Adventure Tours calculates the total price of a trip by adding the trip price plus other fees and multiplying the result by the number of persons included in the reservation. List the reservation ID, trip name, customer’s last name, customer’s first name, and total cost for all reservations where the number of persons is greater than four. Use the column name TotalCost for the calculated field.
SELECT r.ReservationID, t.TripName, c.LastName, (TripPrice + OtherFees)*NumPersons as TotalCost
FROM Reservation r
JOIN Trip t ON t.TripID = r.TripID
JOIN Customer c ON c.CustomerNum = r.CustomerNum
WHERE NumPersons > 4;


#Question 22 List all customers whose first name starts with L or S. Sort the results by FirstName.
SELECT *
FROM customer
WHERE FirstName LIKE 'L%' OR FirstName LIKE 'S%'
ORDER BY FirstName;


#Question 23 List all the trip names whose prices are between $30 and $50.
SELECT DISTINCT t.TripName
FROM Trip t
JOIN Reservation r ON r.TripID= t.TripID
WHERE r.TripPrice BETWEEN 30.00 AND 50.00;

#Question 24 Write a query to determine how many trips have prices between $30 and $50. (Please note that this question is different from number 23 above.)
SELECT COUNT(*)
FROM Trip t
JOIN Reservation r ON r.TripID= t.TripID
WHERE r.TripPrice BETWEEN 30.00 AND 50.00;

#Question 25 Display the trip ID, trip name, and reservation ID for all trips that do not yet have the reservations.
SELECT t.TripID, t.TripName, r.ReservationID
FROM Trip t
LEFT JOIN Reservation r ON r.TripID = t.TripID
WHERE r.ReservationID is NULL;



#Question 26 List the trip information for each pair of trips that have the same start location.
SELECT t1.*, t2.*
FROM Trip t1
JOIN Trip t2 ON t1.StartLocation = t2. StartLocation AND t1.TripID != t2.TripID;


#Question 27 List information for each customer that either lives in the state of New Jersey (NJ), or that currently has a reservation, or both.
SELECT *
FROM customer c
WHERE c.State = 'NJ' OR EXISTS (SELECT 1 FROM reservation r WHERE r.CustomerNum = c.CustomerNum);


#Question 28 Display all guides who are not currently assigned to any trips.
SELECT *
FROM Guide g 
WHERE NOT EXISTS (SELECT * FROM TripGuides tg WHERE tg.GuideNum = g.GuideNum);


#Question 29 Display the guide information for each pair of guides that come from the same state.
SELECT g1.*, g2.*
FROM guide g1
JOIN guide g2 ON g1.State = g2.State AND g1.GuideNum != g2.GuideNum;

#Question 30 Display the guide information for each pair of guides that come from the same city.
SELECT g1.*, g2.*
FROM guide g1
JOIN guide g2 ON g1.City = g2.City AND g1.GuideNum != g2.GuideNum;

# Entertainment Database
#Question 1 List the names and phone numbers of all our agents, and list them in last name/first name order.
SELECT AgtFirstName, AgtLastName, AgtPhoneNumber
FROM AGENTS
ORDER BY AgtLastName, AgtFirstName;

#Question 2 List all engagements and their associated start dates. Sort the records by date in descending order and by engagement in ascending order.
SELECT EngagementNumber, StartDate
FROM Engagements
ORDER BY StartDate DESC, EngagementNumber ASC;

#Question 3 Show the agent name, date hired, and the date of each agent’s first six-month performance review.
SELECT AgtFirstName, AgtLastName, DATE_ADD(DateHired, INTERVAL 6 MONTH) AS SixMonthReview
FROM Agents;

#Question 4 Create a list of all engagements that occurred during October 2017.
SELECT *
FROM ENGAGEMENTS
WHERE StartDate BETWEEN '2017-09-30' AND '2017-11-01';

#Question 5 List any engagements in October 2017 that start between noon and 5 p.m.
SELECT *
FROM ENGAGEMENTS
WHERE StartDate BETWEEN '2017-09-30' AND '2017-11-01'
AND StartTime BETWEEN '12:00:00' AND '17:00:00';

#Question 6 List all the engagements that start and end on the same day.
SELECT *
FROM Engagements
WHERE DATE(StartDate) = DATE(EndDate);


#Question 7 Display agents and the engagement dates they booked, sorted by booking start date.
SELECT AgtFirstName, AgtLastName, StartDate
FROM AGENTS
JOIN ENGAGEMENTS ON AGENTS.AgentID = ENGAGEMENTS.AgentID
ORDER BY StartDate;


#Question 8 List customers and the entertainers they booked.
SELECT DISTINCT c.CustFirstName, c.CustLastName, r.EntStageName
FROM CUSTOMERS c
JOIN ENGAGEMENTS e ON e.CustomerID = c.CustomerID
JOIN ENTERTAINERS r ON r.EntertainerID = e.EntertainerID;

#Question 9 Find the agents and entertainers who live in the same postal code.
SELECT AgtFirstName, AgtLastName, EntStageName
FROM AGENTS
JOIN ENTERTAINERS ON AGENTS.AgtZipCode = ENTERTAINERS.EntZipCode;

#Question 10 Display an alphabetical list of entertainers (Stage name, phone numbers, and city) based in Bellevue, Redmond, or Woodinville.
SELECT EntStageName, EntPhoneNumber,EntCity
FROM Entertainers
WHERE EntCity IN ('Bellevue','Redmond','Woodinville')
ORDER BY EntStageName;

#Question 11 Display all the engagements that run for four days.
SELECT *
FROM ENGAGEMENTS
WHERE DATEDIFF(EndDate,StartDate) = 3;

#Question 12 Display the entertainers, the start and end dates of their contracts, and the contract price.
SELECT e.EntStageName, g.StartDate, g.EndDate, g.ContractPrice
FROM Engagements g
JOIN Entertainers e ON e.EntertainerID = g.EntertainerID;

#Question 13 Display the entertainers, the start and end dates of their contracts, and the contract price.
SELECT e.EntStageName, g.StartDate, g.EndDate, g.ContractPrice
FROM Engagements g
JOIN Entertainers e ON e.EntertainerID = g.EntertainerID;

#Question 14 Display all the entertainers who played engagements for customers Berg or Hallmark.
SELECT EntStageName
FROM ENTERTAINERS
JOIN ENGAGEMENTS ON ENTERTAINERS.EntertainerID = ENGAGEMENTS.EntertainerID
JOIN CUSTOMERS ON ENGAGEMENTS.CustomerID = CUSTOMERS.CustomerID
WHERE CustLastName IN ('Berg', 'Hallmark');


#Question 15 Display agents and the engagement dates they booked, sorted by booking start date.
SELECT DISTINCT AgtFirstName, AgtLastName, StartDate
FROM AGENTS
JOIN ENGAGEMENTS ON AGENTS.AgentID = ENGAGEMENTS.AgentID
ORDER BY StartDate;

#Question 16 List customers and the entertainers they booked.
SELECT DISTINCT c.CustFirstName, c.CustLastName, r.EntStageName
FROM CUSTOMERS c
JOIN ENGAGEMENTS e ON e.CustomerID = c.CustomerID
JOIN ENTERTAINERS r ON r.EntertainerID = e.EntertainerID;

#Question 17 List the agents and entertainers who live in the same postal code.
SELECT DISTINCT AgtFirstName, AgtLastName, EntStageName
FROM AGENTS
JOIN ENTERTAINERS ON AGENTS.AgtZipCode = ENTERTAINERS.EntZipCode;

#Question 18 List entertainers who have never been booked.
SELECT EntStageName
FROM Entertainers
WHERE EntertainerID NOT IN (SELECT EntertainerID FROM ENGAGEMENTS);

#Question 19 Display all musical styles and the customers who prefer those styles. Include also styles not preferred by customers.
SELECT ms.StyleName, c.CustFirstName, c.CustLastName
FROM Musical_Styles ms
LEFT JOIN Musical_Preferences mp ON mp.StyleID = ms.StyleID
LEFT JOIN CUSTOMERS c ON c.CustomerID = mp.CustomerID;


#Question 20 Display agents who have never booked an entertainer.
SELECT AgtFirstName, AgtLastName
FROM AGENTS
WHERE AgentID NOT IN (SELECT AgentID FROM Engagements);

#Question 21 List customers with no bookings.
SELECT CustFirstName,CustLastName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Engagements);


#Question 22 List all entertainers and any engagements they have booked.
SELECT DISTINCT e.EntertainerID, e.EntStageName, g.EngagementNumber
FROM Entertainers e
LEFT JOIN Engagements g ON g.EntertainerID = e.EntertainerID;

#Question 23 Display a complete list of customers and entertainers.
SELECT CustFirstName AS FirstName, CustLastName AS LastName, 'Customer' AS Type
FROM Customers
UNION ALL
SELECT EntStageName AS FirstName, ' ' AS LastName, 'Entertainer' AS Type
FROM Entertainers;




#Question 24 Display a list of customers who like contemporary music together with a list of entertainers who play contemporary music.
SELECT concat(custfirstname,' ',custlastname) as Name,'customer' as type from customers c 
JOIN Musical_Preferences mp on c.customerid=mp.customerid
JOIN musical_styles ms on ms.styleid= mp.styleid
union
SELECT entstagename,'entertainer' as type from entertainers ent 
JOIN entertainer_styles es on ent.entertainerid = es.entertainerid
JOIN musical_styles ms on ms.styleid= es.styleid where ms.stylename='Contemporary';

#Question 25 Display a combined list of agents and entertainers.
SELECT AgtFirstName AS FirstName, AgtLastName AS LastName, 'Agent' AS Type
FROM AGENTS
UNION ALL
SELECT EntStageName AS FirstName, NULL AS LastName, 'Entertainer' AS Type
FROM ENTERTAINERS;


#ACCOUNT PAYABLE DATABASE

#Question 1 Select all data from the Invoices table.
SELECT *
FROM invoices;

#Question 2 Display the Invoice number, Invoice date, and the Invoice total. Sort in de- scending sequence by Invoice Total.
SELECT invoice_number, invoice_date, invoice_total
FROM invoices
ORDER BY invoice_total DESC; 

#Question 3 Display all invoices from the month of June.
SELECT *
FROM invoices
WHERE MONTH (invoice_date) = 6;

#Question 4 Write a query to show all vendors. Then sort the result set by last name and then first name, both in ascending sequence.
SELECT *
FROM vendors
ORDER BY vendor_contact_last_name, vendor_contact_first_name ASC;

#Question 5 Write a query that returns vendor’s last name and first name. Sort the result set by last name and then first name in ascending sequence. Return only the contacts whose last name begins with the letter A, B, C, E.
SELECT vendor_contact_last_name, vendor_contact_first_name
FROM vendors
WHERE vendor_contact_last_name LIKE 'A%' OR vendor_contact_last_name LIKE 'B%'
OR vendor_contact_last_name LIKE 'C%' OR vendor_contact_last_name LIKE 'E%'
ORDER BY vendor_contact_last_name, vendor_contact_first_name ASC;

#Question 6 Display the invoice due date and the invoice amounts increased by 10%. Return only the rows with an invoice total that is greater than or equal to 500 and less than or equal to 1000. Sort the result set in descending sequence by the invoice due date.
SELECT invoice_due_date, invoice_total*1.1 AS invoice_total_increased
FROM invoices
WHERE invoice_total >= 500 AND invoice_total <= 1000
ORDER BY invoice_due_date DESC;


#Question 7 Write a query that displays the invoice number, invoice total, payment credit total, and balance due. Return only invoices that have a balance due greater that is than $50. Sort the result set by balance due in descending sequence. Limit the result set to show only the results with the 5 largest balances.
SELECT invoice_number, invoice_total, payment_total, credit_total, (invoice_total - (payment_total + credit_total)) AS balance_due
FROM invoices
HAVING balance_due > 50
ORDER BY balance_due DESC
LIMIT 5;

#Question 8 Display the invoices which have balance due.
SELECT *
FROM invoices
WHERE invoice_total > (payment_total + credit_total);

#Question 9 Display the names of the vendors who have balance due.
SELECT v.vendor_name
FROM vendors v
JOIN invoices i ON v.vendor_id = i.vendor_id
WHERE i.invoice_total > (i.payment_total + i.credit_total);

#Question 10 Write a query to display information about the vendors and the default account description for each vendor.
SELECT v.vendor_name, g.account_description
FROM vendors v
JOIN general_ledger_accounts g ON g.account_number = v.default_account_number;

#Question 11 Write a query to display all invoices for each vendor. So for example, if a vendor has 2 invoices, then display all line item information for both invoices. Just an example to give you an idea.
SELECT DISTINCT v.vendor_name, i.*, il.*
FROM vendors v
JOIN invoices i ON v.vendor_id = i.vendor_id
JOIN invoice_line_items il ON i.invoice_id = il.invoice_id;

#Question 12 Write a query to return one row for each vendor whose contact has the same last name as another vendor’s contact.
SELECT DISTINCT v1.vendor_id, v1.vendor_contact_last_name, v1.vendor_contact_first_name
FROM vendors v1
JOIN vendors v2 ON v1.vendor_contact_last_name = v2.vendor_contact_last_name AND v1.vendor_id != v2.vendor_id;


#Question 13 Write a query to return one row for each account number that has never been used. Sort the result set by Account Number.
SELECT account_number
FROM general_ledger_accounts
WHERE account_number NOT IN (SELECT DISTINCT account_number FROM invoice_line_items)
ORDER BY account_number;

#Question 14 Generate the result set containing the following columns: Vendor Name Vendor State. If the vendor is in California, the value in the Vendor State column should be “CA”; otherwise, the value should be “Outside CA.” Sort the final result set by Vendor Name.
SELECT vendor_name,
CASE WHEN vendor_state = 'CA' THEN 'CA' ELSE 'Outside CA' END AS Vendor_State
FROM vendors
ORDER BY vendor_name;

#PRESTIGE CAR DATABASE

#Question 1 Display the country name and the sales region for the countries in the database.
SELECT CountryName, SalesRegion
FROM country;


#Question 2 Create a complete list of every vehicle purchased and the amount paid (cost) to purchase it.
SELECT m.ModelName, s.Cost
FROM model m
JOIN stock s ON m.ModelID = s.ModelID;


#Question 3 The CEO of Prestige Cars needs to obtain a list of the countries where the company’s customers can be found. Write a query to display such a list of country names (not ISO codes.)
SELECT DISTINCT Country
FROM customer;


#Question 4 The CEO firmly believes that effective cost control is vital for the company’s survival. She wants a list of all the cars that have ever been bought since Prestige Cars started trading. Write a query to display a list of the purchase cost for every make and model ever held in stock.
SELECT m.ModelID, m.ModelName, e.MakeName, s.cost
FROM make e
JOIN model m ON m.MakeID = e.MakeID
JOIN stock s ON s.ModelID = m.ModelID;



#Question 5 The CEO has requested a list of all vehicles sold along with the selling price and any discounts that have been applied. Write a query to generate such a list.
SELECT m.ModelName, d.SalePrice, d.LineItemDiscount
FROM model m
JOIN stock s ON s.ModelID = m.ModelID
JOIN salesdetails d ON d.StockID = s.StockCode;


#Question 6 The IT director is convinced that the database needs some cleanup. He is certain that there are makes of vehicles stored in the Make table for which there are no corresponding models. Write a query to generate a list of such makes of vehicles with no corresponding models.
SELECT m.MakeID, m.MakeName
FROM make m
LEFT JOIN model d ON d.MakeID = m.MakeID
WHERE ModelID IS NULL;

#Question 7 The CEO has requested a quick list of staff so that she can produce an org chart for the next board meeting. There is a table named Staff in the database. Use this table to create a report of all staff members, their department, and their manager’s name.
SELECT s.StaffName, s.Department, m.StaffName AS ManagerName
FROM staff s
LEFT JOIN staff m ON s.ManagerID = m.StaffID;

#Question 8 The SalesCategory table in the database is a small table that contains the reference information that allows the sales manager to categorize each car sold according to the sale price. The sales manager wants to use the data in this table to display the specific sales category of each vehicle sold. Your result set should include the make, model, sale price, and the category description of each vehiccle sold. Write a query to generate such a list.
SELECT m.MakeName, o.ModelName, s.SalePrice, sc.CategoryDescription
FROM salesdetails s
JOIN stock t ON t.StockCode = s.StockID
JOIN model o ON o.ModelID = t.ModelID
JOIN make m ON m.MakeID = o.ModelID
JOIN salescategory sc ON s.SalePrice BETWEEN sc.LowerThreshold AND sc.UpperThreshold;

SELECT *
FROM customer;
SELECT *
FROM country;

#Question 9 The CEO wants a list of all countries that Prestige Cars sells to, with a list of all makes that the company has ever stocked. When you ask for more details, she says that she also wants to see every make appear for every country because this allows her to galvanize the sales teams to sell every make in every country. Write a query to generate such a list.
SELECT DISTINCT c.CountryName, m.MakeName
FROM country c
JOIN make m ON m.MakeCountry = c.CountryISO3;

#Question 10 The finance director needs to know the makes and models the company has bought and stocked. Write a query to generate a list.
SELECT DISTINCT m.MakeName, o.ModelName
FROM make m
JOIN model o ON o.MakeID = m.MakeID
JOIN stock s ON o.ModelID = s.ModelID;

#Question 11 The CEO wants a list of all models that Prestige Cars has ever sold and when they were sold. Write a query to create such a list.
SELECT DISTINCT o.ModelName, s.SaleDate
FROM model o
JOIN stock t ON t.ModelID = o.ModelID
JOIN salesdetails sd ON sd.StockID = t.StockCode
JOIN sales s ON s.SalesID = sd.SalesID;


#Question 12 A new marketing director has just arrived at Prestige Cars. The first thing that she wants to know is how the color of cars varies by model purchased. She wants a report displaying all the models Prestige Cars has had in stock in red, green, or blue. Write a query to generate this list.
SELECT m.ModelName, s.Color
FROM stock s
JOIN model m ON m.ModelID = s.ModelID
WHERE s.Color IN ('Red', 'Green', 'Blue');


#Question 13 The marketing director wants a list of all makes that were ever sold except Ferrari. Write a query to create this list.
SELECT DISTINCT m.MakeID, m.MakeName
FROM make m
JOIN model o ON o.MakeID = m.MakeID
JOIN stock s ON s.ModelID = o.ModelID
JOIN salesdetails sd on sd.StockID = s.StockCode
WHERE m.MakeName <> 'Ferrari';


#Question 14 The marketing director wants a list of all makes that were ever sold except Porsche, Aston Martin, and Bentley. Write a query to create this list.
SELECT DISTINCT m.MakeName
FROM make m
JOIN model mo ON mo.MakeID = m.MakeID
JOIN stock s ON mo.ModelID = s.ModelID
JOIN salesdetails sd ON sd.StockID = s.StockCode
WHERE m.MakeName NOT IN ('Porsche', 'Aston Martin', 'Bentley');

#Question 15 The finance director would like to get an idea of the higher-value cars that are in stock or have been sold; more specifically, he wants to see a list of all cars where the purchase price was over £50,000.00. Write a query to generate this list.
SELECT DISTINCT m.MakeName, mo.ModelName
FROM stock s
JOIN model mo ON s.ModelID = mo.ModelID
JOIN make m ON mo.MakeID = m.MakeID
JOIN salesdetails sd ON sd.StockID = s.StockCode
WHERE sd.saleprice > 50000;

#Question 16 The CEO asked for a list of all makes of car that Prestige Cars has stocked where the parts cost is between £1,000 and £2,000. Write a query to generate this list.
SELECT DISTINCT m.MakeID, m.MakeName
FROM make m
JOIN model mo ON mo.MakeID = m.MakeID
JOIN stock s ON mo.ModelID = s.ModelID
WHERE s.PartsCost BETWEEN 1000 AND 2000;

#Question 17 Write a query to display the names of all make and models of the right-hand drive (RHD) models that Prestige Cars has sold.
SELECT DISTINCT mk.MakeName, md.ModelName
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
WHERE st.IsRHD = 1;

#Question 18 Write a query to list all makes except Bentleys where the cars are red, green, or blue.
SELECT DISTINCT m.MakeName
FROM make m
JOIN model mo ON mo.MakeID = m.MakeID
JOIN stock s ON mo.ModelID = s.ModelID
WHERE s.Color IN ('Red', 'Green', 'Blue')
AND m.MakeName <> 'Bentley';

#Question 19 The finance director has requested a list of all red cars ever bought where their repair cost or the cost of spare parts exceeds £1,000.00. Write a query to create this list.
SELECT m.MakeName, mo.ModelName
FROM stock s
JOIN model mo ON s.ModelID = mo.ModelID
JOIN make m ON mo.MakeID = m.MakeID
WHERE s.Color = 'Red' AND (s.RepairsCost > 1000 OR s.PartsCost > 1000);

#Question 20 The finance director says: “I want to see all red, green, and blue Rolls-Royce Phantoms - or failing that any vehicle where both the parts cost and the repair cost are over £5,500.00.” Write a query to create this list.
SELECT m.MakeName, mo.ModelName, s.Color
FROM stock s
JOIN model mo ON s.ModelID = mo.ModelID
JOIN make m ON mo.MakeID = m.MakeID
WHERE (m.MakeName = 'Rolls-Royce' AND mo.ModelName = 'Phantom' AND s.Color hhuIN ('Red', 'Green', 'Blue'))
OR (s.PartsCost > 5500 AND s.RepairsCost > 5500);

#Question 21 Write a query to return the row containing the “Dark purple” vehicle. Note the case for the color. The correct query should return only one row. Hint: You can use the keyword BINARY (not the data type.)
SELECT *
FROM stock
WHERE BINARY Color = 'Dark purple';

#Question 22 You have developed an excellent reputation as a data analyst at Prestige Cars. The receptionist comes to you with a request for help. She knows that Prestige Cars has a customer with Peter (or was that Pete?) somewhere in the name, and you need to find this person in the database. Create a list of all such names by using an SQL query.
SELECT CustomerName
FROM customer
WHERE CustomerName LIKE '%Peter%' OR CustomerName LIKE '%Pete%';

#Question 23 Write a query to return all makes of the cars with capital ”L” in the name of the marque. The correct query should not return models with lowercase ”l” anywhere in the name. For example, Alfa Romeo or Bentley should not be returned. The correct query should return three rows only.
SELECT MakeName
FROM make
WHERE MakeName LIKE BINARY '%L%' AND MakeName NOT LIKE BINARY '%l%';

#Question 24 The finance director informs you that the invoice number field is structured in such a way that you can identify the country of sale from certain characters at a specific point in the field. He wants you to use this to isolate all sales made to French customers showing the model and the invoice number for each sale made. The correct query should return 68 rows.Here is an example of the breakdown of the InvoiceNumber field. GBPGB001Left three characters indicate the currency of sale, in this case GBP. Characters 4 and 5 indicate the destination country, in this case Great Britain. The last three characters provide a sequential invoice number.So, the invoice number GBPGB001 tells you that this sale was made in pounds sterling to a client in the United Kingdom — and is invoice No 001.
SELECT DISTINCT md.ModelName, s.InvoiceNumber
FROM model md
JOIN stock t ON md.ModelID = t.ModelID
JOIN salesdetails sd ON sd.StockID = t.StockCode
JOIN sales s ON s.SalesID = sd.SalesID
WHERE s.InvoiceNumber LIKE '___FR%';

#Question 25 The marketing director has noticed that the corporate database is missing postalcodes (ZIP codes) for some clients. She has asked for a list of all cus- tomers without this vital piece of information. Write a query and create the list for the marketing director.
SELECT DISTINCT CustomerID, CustomerName
FROM customer
WHERE PostCode IS NULL;

#Question 26 The finance director cannot find a spreadsheet that tells him what the exact cost of every car sold is, including the purchase cost along with any repairs, parts, and transport costs. This is called the cost of sales. Using an SQL query display the make name, model name, and the total cost of every car sold.
SELECT DISTINCT sd.SalesID, mk.MakeName, md.ModelName, (st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost) AS TotalCostOfCarSold
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID;



#Question 27 The finance director is pleased with your cost analysis from question 26 above. He now wants you to calculate the net margin. Write a query to display the make name, model name, and the net margin.
SELECT DISTINCT sd.SalesID, mk.MakeName, md.ModelName, (sd.SalePrice - (st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost)) AS NetMargin
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID;

#Question 28 The finance director is getting more and more excited at the thought that SQL can address every question he needs for his analysis. He now wants you to give him a list containing the ratio of cost to sales. Write an SQL query to provide this information to the finance director.
SELECT mk.MakeName, md.ModelName, (st.cost+ st.repairscost+ st.partscost + st.transportincost)/sd.saleprice/ NULLIF(sd.SalePrice, 0) AS CostToSalesRatio
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID;

#Question 29 Imagine that the sales director wants to test the improvement in margins if you increased the sale prices by 5 percent but kept costs the same. Using SQL, display the make name, the model name, and the improved sales margins.
SELECT DISTINCT mk.MakeName,md.ModelName,(sd.SalePrice*1.05 - (st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost)) AS SalesMargin
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID;

#Question 30 Write a SQL query to display the make names of the models which represent 50 most profitable sales in percentage terms. Arrange your list in descending order.
SELECT mk.MakeName
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
ORDER BY ((sd.SalePrice - (st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost))/ NULLIF(st.Cost, 0)) DESC
LIMIT 50;


#Question 31 The CEO of Prestige Cars Ltd. wants to know what the net profit is on sales. She particularly wants to see a list of sales for all vehicles making a profit of more than £5,000.00. Write a query to display this list. The correct query will return 178 rows.
SELECT DISTINCT mk.makename, md.modelname, sd.saleprice
FROM make mk
JOIN model md on md.makeid=mk.makeid
JOIN stock st on st.modelid=md.modelid
JOIN salesdetails sd on sd.stockid=st.stockcode
WHERE (sd.saleprice -(st.cost+st.repairscost + st.partscost + st.transportincost)) > 5000 order by makename, modelname desc;



#Question 32 It is late in the day, and you are thinking of heading home. Just as your eyes drift toward your lunch bag, in rushes the sales director with a request to list all car makes and models sold where the profit exceeds £5,000.00 and the car is red and the discount greater than or equal to £1,000.00 — or both the parts cost and the repairs cost are greater than £500.00. Write a query to generate this list. The correct query will return 63 rows.
SELECT DISTINCT mk.MakeName, md.ModelName
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
WHERE 
  (
    (sd.SalePrice - (st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost)) > 5000
    AND st.Color = 'Red'
    AND sd.LineItemDiscount >= 1000
  )
  OR 
  (
    st.PartsCost > 500
    AND st.RepairsCost > 500
  );

#Question 33 The finance director has tasked you to calculate the aggregate sales, cost, and gross profit for all vehicles sold. Write an SQL query to provide this summary.
SELECT SUM(sd.SalePrice) AS TotalSales, SUM(st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost) AS TotalCost, SUM(sd.SalePrice - (st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost)) AS TotalGrossProfit
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode;

#Question 34 The sales manager has emailed you with a request to calculate the aggregate cost for each model of car. Write an SQL query to provide this list to the sales manager.
SELECT m.ModelName, SUM(st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost) AS AggregateCost
FROM stock st 
JOIN model m ON m.ModelID = st.ModelID
GROUP BY m.ModelName;

#Question 35 The finance director wants you to dig deeper into the data and calculate the total purchase cost for every make and model of vehicle bought. Write an SQL query for generating this result.
SELECT mk.MakeName, md.ModelName, SUM(st.Cost) AS TotalPurchaseCost
FROM stock st
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
GROUP BY mk.MakeName, md.ModelName;

#Question 36 An essential business metric is the average cost of goods bought. The finance director would want to see the average purchase price of every make and model of car ever bought. Write an SQL query to generate this list.
SELECT mk.MakeName, md.ModelName, AVG(st.Cost) AS AveragePurchasePrice
FROM stock st
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
GROUP BY mk.MakeName, md.ModelName;

#Question 37 The CEO has stated categorically that any business must be able to see at a glance how many items have been sold per product category. In the case of Prestige Cars Ltd., visualizing (not using Tableau) the number of cars sold by make and model. Write an SQL query to generate this list.
SELECT mk.MakeName, md.ModelName, COUNT(sd.SalesID) AS NumberOfSales
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
GROUP BY mk.MakeName, md.ModelName;

#Question 38 The sales director asked for the number of different countries that Prestige Cars has ever sold vehicles to. Write an SQL query to answer this question.
SELECT COUNT(DISTINCT cu.Country) AS NumberOfCountriesSoldTo
FROM sales s
JOIN customer cu ON s.CustomerID = cu.CustomerID;

#Question 39 The sales manager wants you to identify the largest and smallest sale prices for each model of car sold. Write an SQL query to generate this list. The list should contain the model name, the top sale price, and the bottom sale price for each model.
SELECT DISTINCT m.ModelName, MAX(sd.SalePrice) AS LargestSalePrice, MIN(sd.SalePrice) AS SmallestSalePrice
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model m ON st.ModelID = m.ModelID
GROUP BY m.ModelName;

#Question 40 The sales director asks you ”How many red cars have been sold for each make of the car?” Write an SQL query to create a list in response to the question. The correct query should return 13 rows.
SELECT mk.MakeName, COUNT(*) AS RedCarsSold
FROM salesdetails sd
JOIN stock st ON sd.StockID = st.StockCode
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
WHERE st.Color = 'Red'
GROUP BY mk.MakeName;

#Question 41 As part of the company’s worldwide sales drive, the sales director wants to focus Prestige Cars’ marketing energies on the countries where you are making the most sales. Show the data for countries where more than 50 cars have been sold. The correct query should return only 2 rows.
SELECT cu.Country, COUNT(*) AS NumberOfCarsSold
FROM sales s
JOIN customer cu ON s.CustomerID = cu.CustomerID
GROUP BY cu.Country
HAVING NumberOfCarsSold > 50;

#Question 42 The sales director wants to know who are the clients who have not only bought at least three cars but where each of the three vehicles generated a profit of at least £5,000.00. Write an SQL query to generate a list of such customers and the number of cars sold to such customers. The correct query should return 27 rows.
SELECT cst.customername, COUNT(*) as cnt
FROM customer cst 
JOIN sales sl on cst.customerid = sl.customerid
JOIN salesdetails sd on sd.salesid= sl.salesid
JOIN stock st on st.stockcode= sd.stockid
WHERE (sd.saleprice -(st.cost+st.repairscost + st.partscost + st.transportincost)) >=5000 GROUP BY cst.customername
HAVING cnt>=3 ;

#Question 43 The CEO wants to see what drives the company’s bottom line. To this end, she wants to isolate the three most lucrative makes sold so that she can focus sales efforts around those brands. Write an SQL query to identify these three most lucrative makes.
SELECT mk.MakeName, SUM(sd.SalePrice - (st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost)) AS TotalProfit
FROM make mk
JOIN model md ON mk.MakeID = md.MakeID
JOIN stock st ON md.ModelID = st.ModelID
JOIN salesdetails sd ON st.StockCode = sd.StockID
GROUP BY mk.MakeName
ORDER BY TotalProfit DESC
LIMIT 3;




