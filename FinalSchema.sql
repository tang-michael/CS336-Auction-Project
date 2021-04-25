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
( auction_id int NOT NULL AUTO_INCREMENT,
  closing_date date,
  closing_time time,
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
  amount float NOT NULL,
  item_id int NOT NULL,
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
  current_bid float NOT NULL,
  initial_price float NOT NULL,
  bid_increment float NOT NULL,
  min_price float NOT NULL,
  closing_date date,
  closing_time time,
  primary key (item_id),
  foreign key(login_id) references users(login_id)
  );
  
CREATE TABLE computer_accessories
  (item_id int NOT NULL,
  primary key (item_id),
  connectivity varchar(50),
  color varchar(50),
  battery varchar(50),
  foreign key(item_id) references item(item_id)
  );
  
CREATE TABLE phones
  (item_id int NOT NULL,
  primary key (item_id),
  wireless_connectivity varchar(50),
  storage_size varchar(50),
  camera_features varchar(50),
  foreign key(item_id) references item(item_id)
  );
  
CREATE TABLE computers
  (item_id int NOT NULL,
  primary key (item_id),
  screen_size varchar(50),
  processor varchar(50),
  ram varchar(50),
  foreign key(item_id) references item(item_id)
  );
   
CREATE TABLE cameras
  (item_id int NOT NULL,
  primary key (item_id),
  pixels varchar(50),
  zoom varchar(50),
  lenses varchar(50),
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
  
  CREATE TABLE alerts
( login_id varchar(50) NOT NULL,
  item_id int NOT NULL,
  current_bid float NOT NULL,
  primary key(login_id, item_id),
  foreign key(login_id) references users(login_id),
  foreign key(item_id) references item(item_id)
  );
  
  CREATE TABLE winner_alerts
  ( login_id varchar(50) NOT NULL,
  item_id int NOT NULL,
  current_bid float NOT NULL,
  primary key(login_id, item_id),
  foreign key(login_id) references users(login_id),
  foreign key(item_id) references item(item_id)
  );
  
  CREATE TABLE question (
    question_id INT(100) AUTO_INCREMENT,
    question VARCHAR(100),
    login_id VARCHAR(100),
    created date,
    primary key (question_id),
    foreign key (login_id) references end_user(login_id)
);


CREATE TABLE answer (
    answer_id INT(100) AUTO_INCREMENT,
    answer VARCHAR(255),
    question_id INT (100),
    login_id VARCHAR (50),
    created date,
    primary key (answer_id),
    foreign key (question_id) references question(question_id),
    foreign key (login_id) references customer_representatives(login_id)
);

CREATE TABLE sales_reports (
    sales_report_id INT(100) AUTO_INCREMENT,
    earnings_per_item TEXT,
    earnings_per_buyer TEXT,
    generated_date DATE,
    primary key (sales_report_id)
);

INSERT INTO users
VALUES	('maharshi', 'patel', 'maharshi', 'patel'),
		('michael', 'tang', 'michael', 'tang'),
        ('francis', 'adu', 'francis', 'adu'),
        ('camila', 'mata', 'camila', 'mata'),
        ('John', 'Smith', 'Admin_01', 'root'),
        ('Sam', 'Christian', 'Customer_Support', 'root');
        
        
INSERT INTO end_user
VALUES ('maharshi@abcd.com', 'maharshi');    

INSERT INTO end_user
VALUES ('francis@abcd.com', 'francis');    
      

INSERT INTO admins 
VALUES ('2021-03-23', 'Admin_01');

INSERT INTO customer_representatives
VALUES ('2021-03-23', 'Customer_Support');

INSERT INTO item
VALUES (1, 1,'maharshi', 'Computer', 'Apple', 0, 10000, 5000, 'Intel Core i5');
					 
INSERT INTO `item` (`item_id`, `login_id`, `item_type`, `brand`, `closing_date`, `closing_time`, `current_bid`, `initial_price`, `min_price`, `bid_increment`, `upper_limit`)
 VALUES (1, 'michael', 'iphone X', 'Apple', '2021-02-01','08:30:00', 857.99, 654.23, 223, 50, 0),
        (2, 'maharshi', 'iPad Mini', 'Apple', '2021-02-01','08:30:00', 423.99, 321.99, 110.99, 50, 0),
        (3, 'camila', 'Macbook Pro 2021', 'Apple', '2021-02-01','08:30:00', 1023.99, 821.99, 710.99, 20, 0),
        (4, 'michael', 'Razer Keyboard', 'Razer', '2021-02-01','08:30:00', 89.99, 54.99, 34.99, 50, 0),
        (5, 'michael', 'Bluesnowball Microphone', 'Bluesnowball', '2021-02-01','08:30:00', 54.99, 43.99, 40.99,  50, 0),
        (6, 'maharshi', 'Apple Airpods', 'Apple', '2021-02-01','08:30:00', 69.99, 59.99, 55.99, 50, 0),
        (7, 'camila', 'HP Spectre Laptop', 'HP', '2021-02-01','08:30:00', 1022.99, 812.99, 712.99,50, 0),
        (8, 'francis', 'Samsung 27" Monitor', 'Samsung', '2021-02-01','08:30:00', 219.99, 210.99, 199.99, 50, 0),
        (9, 'maharshi', 'College Rule Notebook', 'College Rule', '2021-02-01','08:30:00', 9.99, 8.99, 7.99,50, 0),
        (10, 'camila', 'HP Officejet Pro 8620', 'HP', '2021-02-01','08:30:00', 213.99, 199.99, 154.99, 50, 0),
        (11, 'francis', 'Reddragon Lite Mouse', 'Apple', '2021-02-01','08:30:00', 423.99, 321.99, 110.99, 50, 0),
        (12, 'camila', 'Cyberpower PC Desktop', 'Cyberpower', '2021-02-01','08:30:00', 1299.99, 1019.99, 999.99, 50,0),
        (13, 'michael', 'Nike Sneakers', 'Nike', '2021-02-01','08:30:00', 129.99, 99.99, 89.99, 50, 0),
        (14, 'maharshi', 'Addidas Sneakers', 'Addidas', '2021-02-01','08:30:00', 199.99, 159.99, 129.99, 50, 0),
        (15, 'camila', 'iMac 2020', 'Apple', '2021-02-01','08:30:00', 2099.99, 1999.99, 1499.99, 50, 0);


-- DROP TABLE item;
-- DROP TABLE computer_accessories;
-- DROP TABLE phones;
-- DROP TABLE computers;
-- DROP TABLE cameras;
-- DROP TABLE sells;
-- DROP TABLE has_item;
-- DROP TABLE auctions;
-- DROP TABLE views;
-- DROP TABLE bid;
-- DROP TABLE auto_bids;
-- DROP TABLE bids;
-- DROP TABLE removes;
-- DROP TABLE has_item
-- DROP TABLE alerts;
-- DROP TABLE winner_alerts;
-- SELECT * FROM admins;

-- SELECT * FROM users; 

-- SELECT * FROM item;

-- SELECT * FROM computer_accessories;

-- SELECT * FROM computers;

-- SELECT * FROM auctions;

-- SELECT * FROM alerts;

-- SELECT * FROM winner_alerts; 

-- 

