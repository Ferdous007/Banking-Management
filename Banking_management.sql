 --table creation

Drop table borrower;
Drop table loan;
Drop table account;
Drop table vault;
Drop table customer;

create table customer(
customer_id integer CHECK (customer_id>1207001), 
customer_name varchar(20) UNIQUE,
customer_street varchar(20),
customer_city varchar(10),
primary key (customer_id)
);

create table account(
custo_id integer ,
account_num integer CHECK (account_num>12001),
balance integer default 500, 
create_Date DATE,
primary key (account_num),
foreign key (custo_id) references customer(customer_id)
);

create table vault(
cust_id integer,
vault_num integer CHECK (vault_num>700),
item_type varchar(15),
quantity number(5) check (quantity!=0),
primary key(vault_num),
foreign key(cust_id) references customer(customer_id)
);

create table loan(
loan_ID integer CHECK (loan_ID>14001),
amount integer default 500,
primary key(loan_ID)
);

create table borrower(
custo_name varchar(20),
loan_Id integer,
foreign key (custo_name) references customer(customer_name),
foreign key (loan_Id) references loan(loan_ID)
);

--alter and modify table
Alter table loan 
ADD cus_id number(10);  
Alter table loan 
MODIFY cus_id integer;
Alter table loan 
ADD constraint loan_fk foreign key (cus_id) references customer (customer_id);

--insertion into table

insert into customer(customer_id,customer_name,customer_street,customer_city) values(1207005,'Golap','Lalon Shah hall','KUET');
  insert into customer(customer_id,customer_name,customer_street,customer_city) values(1207006,'Kareema','Boyra','Khulna');
     insert into customer(customer_id,customer_name,customer_street,customer_city) values(1207007,'Sharmi','Sher-e-bangla road','Khulna');
	    insert into customer(customer_id,customer_name,customer_street,customer_city) values(1207008,'Muna','Mirpur-2','Dhaka');
		    insert into customer(customer_id,customer_name,customer_street,customer_city) values(1207009,'Shoma','Khan jahan ali road','Khulna');
			
				
insert into account(custo_id,account_num,balance,create_Date) values(1207005,12005,2000,'12-june-2013');
     insert into account(custo_id,account_num,balance,create_Date) values(1207006,12006,1000,'18-april-2014');
		insert into account(custo_id,account_num,balance,create_Date) values (1207007,12007,5000,'24-january-2014');
			insert into account(custo_id,account_num,balance,create_Date) values (1207008,12008,10000,'17-august-2013');
				insert into account(custo_id,account_num,balance,create_Date) values (1207009,12009,15000,'19-nov-2013');

	insert into vault(cust_id,vault_num,item_type,quantity) values(1207005,758,'Result sheet',10);
		insert into vault(cust_id,vault_num,item_type,quantity) values(1207006,898,'Balance sheet',5);
			insert into vault(cust_id,vault_num,item_type,quantity) values(1207007,789,'Prizebond',1000);
				insert into vault(cust_id,vault_num,item_type,quantity) values(1207008,949,'Gold ornaments',5);
					insert into vault(cust_id,vault_num,item_type,quantity) values(1207007,753,'Office files',3);

insert into loan(loan_ID,cus_id,amount) values (14004,1207005,700);
	insert into loan(loan_ID,cus_id,amount) values (14005,1207007,500);
		insert into loan(loan_ID,cus_id,amount) values (14006,1207009,1000);


insert into borrower(custo_name,loan_Id) values('Golap',14004);
	insert into borrower(custo_name,loan_Id) values('Sharmi',14005);
		insert into borrower(custo_name,loan_Id) values('Shoma',14006);

 describe customer;
 describe account;
 describe vault;
 describe loan;
 describe borrower;

	select * from customer;
	select * from account;
	select * from vault;
    select * from loan;
	select * from borrower;
	
SELECT customer_name, customer_street
FROM customer;

SELECT account_num, create_Date
FROM account
WHERE balance BETWEEN 500 AND 10000;

SELECT COUNT(ALL balance) FROM account;

--join op
SELECT c.customer_id, c.customer_name, a.balance
	FROM customer c JOIN account a
	ON c.customer_id = a.custo_id; 

SELECT c.customer_name, c.customer_street, v.item_type
	FROM customer c LEFT OUTER JOIN vault v
	ON c.customer_id = v.cust_id;

SELECT a.custo_id, l.amount
	FROM account a INNER JOIN loan l
	ON a.custo_id = l.cus_id;

--procedure create
SET SERVEROUTPUT ON
DECLARE
   max_balance_num  account.custo_id%type;
BEGIN
   SELECT MAX(balance)  INTO max_balance_num  
   FROM account;
   DBMS_OUTPUT.PUT_LINE('The maximum author is : ' || max_balance_num);
 END;
/
--procedure create
SET  SERVEROUTPUT ON
DECLARE
  Loan_Amount loan.amount%type;
  Customer_loanID  loan.loan_ID%type := '14005';
BEGIN
  SELECT amount INTO Loan_Amount
  FROM loan, customer
  WHERE customer.customer_id = loan.cus_id AND
  loan_ID = Customer_loanID;  
  DBMS_OUTPUT.PUT_LINE('Loan Id : ' || Customer_loanID || ' amount is '|| Loan_Amount);
END;
/
--function create
CREATE OR REPLACE FUNCTION avg_amnt RETURN INTEGER IS
   avg_amnt loan.amount%type;
BEGIN
  SELECT AVG(amount) INTO avg_amnt
  FROM loan;
   RETURN avg_amnt;
END;
/
--function call
SET SERVEROUTPUT ON
BEGIN
dbms_output.put_line('Average Loan Amount: ' || avg_amnt);
END;
/
--rollback
insert into account(custo_id,account_num,balance,create_Date) values(1207011,12009,7000,'25-nov-2014');
savepoint cont_7;
Select * from account;
Rollback to cont_7;

				