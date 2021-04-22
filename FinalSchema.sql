DROP DATABASE IF EXISTS auction; 

CREATE DATABASE auction;

USE auction;

CREATE TABLE users
( fname varchar(20),
  lname varchar(20),
  login_id varchar(50) NOT NULL,
  pwd varchar(20) NOT NULL,
  primary key(login_id));
  
  
CREATE TABLE auctions
( auction_id int NOT NULL,
  history_of_bids varchar(100),
  primary key(auction_id ));
  

CREATE TABLE end_user
  ( email varchar(20) NOT NULL,
   login_id varchar(50) NOT NULL,
  primary key (login_id),
  foreign key(login_id) references users(login_id)
  );
  


CREATE TABLE buyer
  (alerts varchar(50),
  login_id varchar(50) NOT NULL,
  primary key (login_id),
  foreign key(login_id) references users(login_id)
  );
  
CREATE TABLE sellers
  (login_id varchar(50) NOT NULL,
  primary key (login_id),
  foreign key(login_id) references users(login_id)
  );
  
CREATE TABLE bid
  (bid_id int NOT NULL,
  login_id varchar(50) NOT NULL,
  primary key (bid_id),
  foreign key(login_id) references users(login_id)
  );
   
CREATE TABLE legal_bid
  (bid_id int NOT NULL,
  login_id varchar(50) NOT NULL,
  primary key (bid_id),
  foreign key(login_id) references users(login_id)
  );
   
CREATE TABLE illegal_bid
  (bid_id int NOT NULL,
  login_id varchar(50) NOT NULL,
  primary key (bid_id),
  foreign key(login_id) references users(login_id)
  );
  
CREATE TABLE item
  (item_id int NOT NULL AUTO_INCREMENT,
  login_id varchar(50) NOT NULL,
  item_type varchar(200),
  brand varchar(25),
  closing_date date,
  closing_time time,
  current_bid float NOT NULL,
  initial_price float NOT NULL,
  min_price float NOT NULL,
  characteristics varchar(100),
  primary key (item_id),
  foreign key(login_id) references users(login_id)
  );
  
CREATE TABLE computer_accessories
  (item_id int NOT NULL,
  primary key (item_id),
  foreign key(item_id) references item(item_id)
  );
  
CREATE TABLE phones
  (item_id int NOT NULL,
  primary key (item_id),
  foreign key(item_id) references item(item_id)
  );
  
CREATE TABLE computers
  (item_id int NOT NULL,
  primary key (item_id),
  foreign key(item_id) references item(item_id)
  );
   
CREATE TABLE cameras
  (item_id int NOT NULL,
  primary key (item_id),
  foreign key(item_id) references item(item_id)
  );
  
CREATE TABLE admins
( hire_date date NOT NULL,
  login_id varchar(50) NOT NULL,
  primary key(login_id),
  foreign key(login_id) references users(login_id));
  
CREATE TABLE customer_representatives
( hire_date date NOT NULL,
  login_id varchar(50) NOT NULL,
  primary key(login_id),
  foreign key(login_id) references users(login_id));
  
CREATE TABLE staff
  (login_id varchar(50) NOT NULL,
  pwd varchar(20) NOT NULL,
  primary key (login_id),
  foreign key(login_id) references users(login_id)
  );
  
CREATE TABLE summary_sales_report
  (login_id varchar(50) NOT NULL,
  pwd varchar(20) NOT NULL,
  earnings_per_item_type float,
  best_selling_item varchar(25),
  earnings_per_end_user float,
  earnings_per_item float,
  best_selling_end_user varchar(100),
  primary key (login_id),
  foreign key(login_id) references users(login_id)
  );
   
CREATE TABLE views
  (login_id varchar(50) NOT NULL,
  auction_id int NOT NULL,
  primary key (login_id,auction_id),
  foreign key(login_id) references users(login_id),
  foreign key(auction_id) references auctions(auction_id)
  );
   
CREATE TABLE support
  (end_user_login_id varchar(50) NOT NULL,
  customer_representatives_login_id varchar(50) NOT NULL,
  primary key (end_user_login_id,customer_representatives_login_id),
  foreign key(end_user_login_id) references end_user(login_id),
  foreign key(customer_representatives_login_id) references customer_representatives(login_id)
  );
   
CREATE TABLE manages
  (customer_representatives_login_id varchar(50) NOT NULL,
  admins_login_id varchar(50) NOT NULL,
  primary key (customer_representatives_login_id,admins_login_id),
  foreign key(customer_representatives_login_id) references customer_representatives(login_id),
  foreign key(admins_login_id) references admins(login_id)
  );
 
CREATE TABLE auto_bids
  (login_id varchar(50) NOT NULL,
  bid_id int NOT NULL,
  upper_limit int,
  increment int,
  primary key (login_id,bid_id),
  foreign key(login_id) references buyer(login_id),
  foreign key(bid_id) references bid(bid_id)
  );
  
CREATE TABLE bids
  (login_id varchar(50) NOT NULL,
  bid_id int NOT NULL,
  bid_offer int,
  increment int,
  primary key (login_id,bid_id),
  foreign key(login_id) references buyer(login_id),
  foreign key(bid_id) references bid(bid_id)
  );
    
CREATE TABLE has_item
  (item_id int NOT NULL,
  bid_id int NOT NULL,
  primary key (bid_id),
  foreign key(item_id) references item(item_id),
  foreign key(bid_id) references bid(bid_id)
  );
   
CREATE TABLE sells
  (item_id int NOT NULL,
  login_id varchar(50) NOT NULL,
  close_date_time datetime,
  primary key (item_id),
  foreign key(item_id) references item(item_id),
  foreign key(login_id) references sellers(login_id)
  );
 
CREATE TABLE removes
  (bid_bid_id int NOT NULL,
  illegal_bid_bid_id int NOT NULL,
  customer_representatives_login_id varchar(50) NOT NULL,
  primary key (bid_bid_id, illegal_bid_bid_id, customer_representatives_login_id),
  foreign key(bid_bid_id) references bid(bid_id),
  foreign key(illegal_bid_bid_id) references illegal_bid(bid_id),
  foreign key(customer_representatives_login_id) references customer_representatives(login_id)
  );

INSERT INTO users
VALUES	('maharshi', 'patel', 'maharshi', 'patel'),
		('michael', 'tang', 'michael', 'tang'),
        ('francis', 'adu', 'francis', 'adu'),
        ('camila', 'mata', 'camila', 'mata'),
        ('John', 'Smith', 'Admin_01', 'root'),
        ('Sam', 'Christian', 'Customer_Support', 'root');
      

INSERT INTO admins 
VALUES ('2021-03-23', 'Admin_01');

INSERT INTO customer_representatives
VALUES ('2021-03-23', 'Customer_Support');

-- DROP TABLE item;
-- DROP TABLE computer_accessories;
-- DROP TABLE phones;
-- DROP TABLE computers;
-- DROP TABLE cameras;
-- DROP TABLE sells;
-- DROP TABLE has_item;
--         
-- SELECT * FROM admins;

-- SELECT * FROM users; 

-- SELECT * FROM item;

-- SELECT * FROM computers;

--   