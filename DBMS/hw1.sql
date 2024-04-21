create database hw1;
use hw1;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    customer_address VARCHAR(100) NOT NULL,
    customer_email VARCHAR(50) NOT NULL
);

INSERT INTO Customers (customer_id, customer_name, customer_address, customer_email) VALUES
(1, 'John Doe', '123 Main St', 'john.doe@email.com'),
(2, 'Jane Doe', '456 Elm St', 'jane.doe@email.com'),
(3, 'Bob Smith', '789 Oak St', 'bob.smith@email.com'),
(4, 'Alice Johnson', '246 Maple Ave', 'alice.johnson@email.com'),
(5, 'Tim Cook', '135 Pine St', 'tim.cook@email.com');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_id INT NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_name),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1, 1, '2021-01-01'),
(2, 2, '2021-02-01'),
(3, 3, '2021-03-01'),
(4, 4, '2021-04-01'),
(5, 5, '2021-05-01');

INSERT INTO Order_Details (order_id, product_name, quantity) VALUES
(1, 'Product A', 10),
(2, 'Product B', 5),
(3, 'Product C', 15),
(4, 'Product D', 20),
(5, 'Product E', 25),
(5, 'Product F', 30);

CREATE TABLE Suppliers (
    supplier_id INT,
    supplier_name VARCHAR(50) NOT NULL,
    supplier_address VARCHAR(100) NOT NULL,
    supplier_email VARCHAR(50) NOT NULL
);

INSERT INTO Suppliers (supplier_id, supplier_name, supplier_address, supplier_email) VALUES
(1, 'Supplier 1', '555 Main St', 'supplier1@email.com'),
(2, 'Supplier 2', '666 Elm St', 'supplier2@email.com'),
(3, 'Supplier 3', '777 Oak St', 'supplier3@email.com'),
(4, 'Supplier 4', '888 Maple Ave', 'supplier4@email.com'),
(5, 'Supplier 5', '999 Pine St', 'supplier5@email.com');

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Order_Details;
SELECT * FROM Suppliers;

select * from customers where customer_email like '%john%'; --1

select * from Order_Details where quantity=(select max(quantity) from Order_Details); --2
select * from Order_Details where quantity=(select min(quantity) from Order_Details);
select * from Order_Details where quantity=(select avg(quantity) from Order_Details);

select * from Order_Details where quantity between 10 and 20; --3

select Customers.customer_name,Customers.customer_address,sum(Order_Details.quantity) as Total_quantity
from Customers,Order_Details,Orders

where Customers.customer_id=Orders.customer_id and Orders.order_id=Order_Details.order_id
GROUP BY Customers.customer_name, Customers.customer_address                                  --4
order by  Customers.customer_name asc; 

select Customers.customer_name,Order_Details.quantity as Quantity_Ordered
from Customers,Order_Details,Orders
where Customers.customer_id=Orders.customer_id and Orders.order_id=Order_Details.order_id and Customers.customer_name like'%Doe' and Order_Details.quantity>10
GROUP BY Customers.customer_name,Order_Details.quantity;  --5

select * from Order_Details 
join Orders on  Orders.order_id=Order_Details.order_id 
order by Orders.order_date desc;   --6

select * from Suppliers 
where supplier_address like'9%'; --7

select supplier_name from Suppliers
where supplier_id=1 or supplier_id=3 or supplier_id=5; --8

select product_name as Product,quantity as Quantity_ordered from Order_Details; --9

select Customers.customer_id,Customers.customer_name, avg(Order_Details.quantity) as average_quantity
from Customers,Order_Details,Orders
where Customers.customer_id=Orders.customer_id and Orders.order_id=Order_Details.order_id
group by Customers.customer_id,Customers.customer_name --10

select Customers.customer_name 
from Customers
where customer_id not in (select customer_id from Orders); --11

select customer_id,customer_name,customer_address 
from Customers
where customer_id in(select customer_id from Orders);  --12

select Customers.customer_id,Customers.customer_name ,Order_Details.product_name,Order_Details.quantity 
from Customers,Order_Details,Orders
where Customers.customer_id=Orders.customer_id and Orders.order_id=Order_Details.order_id 
and Order_Details.product_name='Product A'; --13

select Customers.customer_name,Customers.customer_address,Customers.customer_email
from Customers,Order_Details,Orders  
where Customers.customer_id=Orders.customer_id and Orders.order_id=Order_Details.order_id 
and Orders.order_date>'2021-02-01'; --14

select Customers.customer_name 
from Customers,Order_Details,Orders
where Customers.customer_id=Orders.customer_id and Orders.order_id=Order_Details.order_id 
and Order_Details.quantity>10; --15





