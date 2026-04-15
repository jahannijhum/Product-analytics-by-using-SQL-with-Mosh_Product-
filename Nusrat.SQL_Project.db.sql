CREATE TABLE Clients(
      Client_Id INTEGER PRIMARY KEY,
      Name Text,
      Address TEXT,
      City TEXT,
      State TEXT,
      Phone TEXT
  );
 
INSERT INTO Clients VALUES 
(1, 'Vinte', 'Nevada Parkway' , 'Syracuse', 'NY' , '315-252-7305' ),
(2,'Myworks','34267 Glendale Parkway','Huntington','WV','304-659-1170'),
(3,'Yadel','096 Pawling Parkway','San Francisco','CA','415-144-6037'),
(4,'Kwideo','81674 Westerfield Circle','Waco','TX','254-750-0784'),
(5,'Topiclounge','0863 Farmco Road','Portland','OR','971-888-9129');

SELECT * FROM Clients;

--4(i) Unique states from customer table
SELECT DISTINCT state 
from Mosh_customers mc; 

--(ii)Set a new price for products is set as the 1.1times the unit_price. How would the new price look like in ‘products’ table

SELECT unit_price,
unit_price  * 1.1 as New_price 
from Mosh_products mp;

--(iii)Show the invoice_id, client_id, invoice_total, payment_total, invoice_date and due_date from the ‘invoices’ table after the invoice_date June 2019.
SELECT 
invoice_id,
client_id,
invoice_total,
payment_total,
invoice_date,
due_date
FROM Mosh_invoices
where invoice_date > '2019-06';

--(iv)Identify those customers (from ‘customers’ table) who were born after 1990 having points more than 1000.

SELECT *
FROM Mosh_customers mc 
WHERE birth_date >1990
AND points >1000;

--(V)Find out those clients from ‘payments’ table with client_id 5 having amount more than 20.00
SELECT mp.client_id 
fROM Mosh_payments mp
WHERE MP.client_id =5
AND MP.Client_id >20;

--(vi)Identify those products which are less expensive than lettuce from products table

SELECT *
FROM Mosh_products mp 
WHERE unit_price < (
    SELECT unit_price
    FROM Mosh_products mp
    WHERE name = 'Lettuce'
);

--5(a)Show all possible payment_method names in payments table by joining payments and payment_methods tables


SELECT mpm.name as Payment_methods 
FROM Mosh_payments mp  
JOIN Mosh_payment_methods mpm  
ON mp.payment_id = mpm.payment_method_id;

--(b)Show the client_id, name, state, payment_total, due_date, payment_date, phone by joining the tables: clients, invoices


SELECT 
c.client_id,
c.Name, 
c.State, 
c.Phone ,
mi.payment_total, 
mi.due_date ,
mi.payment_date  
FROM Clients c 
JOIN Mosh_invoices mi 
ON C.client_id = mi.client_id; 

--6(a)Find out clients without any invoices and output their names from clients and invoices tables


SELECT c.name 
FROM clients c
LEFT JOIN Mosh_invoices mi
ON c.client_id = mi.client_id 
WHERE mi.invoice_id  IS NULL;

--(b)Find out all information about clients who have invoice_total larger than client 3 from invoices and clients table
SELECT *
FROM clients c
JOIN Mosh_invoices mi  
ON c.client_id = mi.client_id
WHERE mi.invoice_total > (
    SELECT invoice_total
    FROM Mosh_invoices mi 
    WHERE client_id = 3
);

--(C)Group and rank the clients based on their invoice_total from invoices table

SELECT 
    client_id,
    SUM(invoice_total) AS total_invoice,
    RANK() OVER (ORDER BY SUM(invoice_total) DESC) AS client_rank
FROM Mosh_invoices mi 
GROUP BY client_id;

--(d)Find out the name of the clients with at least 2 invoices from clients and invoices tables
SELECT c.name
FROM clients c
JOIN Mosh_invoices mi 
ON c.client_id = mi.client_id
GROUP BY c.client_id, c.name
HAVING COUNT(mi.invoice_id) >= 2;

--(e)Retrieve the number from invoices table who chose payment method-1 in payments table

SELECT COUNT(DISTINCT mi.invoice_id)
AS invoice_count
FROM Mosh_invoices mi 
JOIN Mosh_payments mp 
ON mi.invoice_id = mp.invoice_id
WHERE mp.payment_method = 1;
