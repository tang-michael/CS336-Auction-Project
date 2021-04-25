DROP DATABASE IF EXISTS auction; 

CREATE DATABASE auction;

USE auction;

CREATE TABLE users
( fname varchar(20),
  lname varchar(20),
  login_id varchar(50) NOT NULL,
  pwd varchar(20) NOT NULL,
  primary key(login_id));

CREATE TABLE end_user
  ( email varchar(20) NOT NULL,
   login_id varchar(50) NOT NULL,
  primary key (login_id),
  foreign key(login_id) references users(login_id)
  );
  
  CREATE TABLE auctions
( auction_id int NOT NULL,
  history_of_bids varchar(100),
  primary key(auction_id ));

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
  
CREATE TABLE item
  (item_id int NOT NULL AUTO_INCREMENT,
  login_id varchar(50) NOT NULL,
  item_name varchar(200),
  item_type varchar(200),
  brand varchar(25),
  current_bid float NOT NULL,
  initial_price float NOT NULL,
  bid_increment float NOT NULL,
  min_price float NOT NULL,
  closing_date date,
  closing_time time,
  user_increment float,
  upper_limit float,
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

INSERT INTO users
VALUES  ('maharshi', 'patel', 'maharshi', 'patel'),
        ('michael', 'tang', 'michael', 'tang'),
        ('francis', 'adu', 'francis', 'adu'),
        ('camila', 'mata', 'camila', 'mata'),
        ('John', 'Smith', 'Admin_01', 'root'),
        ('Sam', 'Christian', 'Customer_Support', 'root');
        
        
INSERT INTO end_user
VALUES ('maharshi@abcd.com', 'maharshi');    

INSERT INTO end_user
VALUES ('francis@abcd.com', 'francis');

INSERT INTO end_user
VALUES ('michael@abcd.com', 'michael');    

INSERT INTO end_user
VALUES ('camila@abcd.com', 'camila');

INSERT INTO end_user
VALUES ('annon@abcd.com', 'annonymous');

INSERT INTO users
VALUES ('annonymous', 'annonymous', 'annonymous', 'annonymous');
      

INSERT INTO admins 
VALUES ('2021-03-23', 'Admin_01');

INSERT INTO customer_representatives
VALUES ('2021-03-23', 'Customer_Support');

INSERT INTO item (item_id, login_id, item_name,item_type, brand, initial_price, current_bid, bid_increment, min_price, closing_date, closing_time, user_increment, upper_limit)
VALUES (1, 'maharshi', 'Macbook Pro','Computers', 'Apple', 10000, 0, 100, 5000, '2021-05-25', '11:59:00', 0, 0),
       (2, 'francis', 'Macbook Pro', 'Computers', 'Apple', 10000, 0, 100, 5000, '2021-05-25', '11:59:00', 0, 0),
       (3, 'michael', 'Macbook Pro', 'Computers', 'Apple', 10000, 0, 100, 5000, '2021-05-25', '11:59:00', 0, 0),
       (4, 'camila', 'Macbook Pro', 'Computers', 'Apple', 10000, 0, 100, 5000, '2021-05-25', '11:59:00', 0, 0),
       (5, 'maharshi', 'Keyboard', 'Computer Accessories', 'Dell', 100, 0, 100, 50, '2021-05-25', '11:59:00', 0, 0),
       (6, 'francis', 'Mouse', 'Computer Accessories', 'Dell', 100, 0, 100, 50, '2021-05-25', '11:59:00', 0, 0),
       (7, 'michael', 'Mouse', 'Computer Accessories', 'Dell', 100, 0, 100, 50, '2021-05-25', '11:59:00', 0, 0),
       (8, 'camila', 'Keyboard', 'Computer Accessories', 'Dell', 100, 0, 100, 50, '2021-05-25', '11:59:00', 0, 0),
       (9, 'maharshi', 'Iphone 12', 'Phones', 'Apple', 1000, 0, 100, 500, '2021-05-25', '11:59:00', 0, 0),
       (10, 'francis', 'Iphone 11', 'Phones', 'Apple', 1000, 0, 100, 500, '2021-05-25', '11:59:00', 0, 0),
       (11, 'michael', 'Iphone 12', 'Phones', 'Apple', 1000, 0, 100, 500, '2021-05-25', '11:59:00', 0, 0),
       (12, 'camila', 'Iphone 11', 'Phones', 'Apple', 1000, 0, 100, 500, '2021-05-25', '11:59:00', 0, 0),
       (13, 'maharshi', 'EOS 12', 'Cameras', 'Apple', 1000, 0, 100, 500, '2021-05-25', '11:59:00', 0, 0),
       (14, 'francis', 'EOS 11', 'Cameras', 'Apple', 1000, 0, 100, 500, '2021-05-25', '11:59:00', 0, 0),
       (15, 'michael', 'EOS 12', 'Cameras', 'Apple', 1000, 0, 100, 500, '2021-05-25', '11:59:00', 0, 0),
       (16, 'camila', 'EOS 11', 'Cameras', 'Apple', 1000, 0, 100, 500, '2021-05-25', '11:59:00', 0, 0);
       
INSERT INTO computers (item_id, screen_size, processor, ram)
VALUES (1, '15.6 inches', 'Intel Core i5', '8 GB RAM'),
       (2, '13 inches', 'Intel Core i5', '8 GB RAM'),
       (3, '14 inches', 'Intel Core i5', '8 GB RAM'),
       (4, '15.6 inches', 'Intel Core i5', '12 GB RAM');
       
INSERT INTO computer_accessories (item_id, connectivity, color, battery)
VALUES (5, 'Wired', 'Grey', 'AA Batteries Required'),
       (6, 'Wireless', 'Grey', 'AA Batteries Required'),
       (7, 'Wired', 'Black', 'AA Batteries Required'),
       (8, 'Wired', 'Grey', 'Chargable');
       
INSERT INTO phones (item_id, wireless_connectivity, storage_size, camera_features)
VALUES (9, '5G', '128 GB', 'Telephoto Camera'),
       (10, '4G', '128 GB', 'Telephoto Camera'),
       (11, '5G', '128 GB', 'Telephoto Camera'),
       (12, '4G', '128 GB', 'Ultra Wide Camera');
       
INSERT INTO cameras (item_id, pixels, zoom, lenses)
VALUES (13, '64 Mega Pixel', '40X Zoom', '25 mm Lense'),
       (14, '32 Mega Pixel', '20X Zoom', '25 mm Lense'),
       (15, '64 Mega Pixel', '40X Zoom', '35 mm Lense'),
       (16, '64 Mega Pixel', '40X Zoom', '50 mm Lense');
       
INSERT INTO auctions (auction_id, history_of_bids) VALUES (1, 'Test History 1'),
                                                          (2, 'Test History 2'),
                                                          (3, 'Test History 3'),
                                                          (4, 'Test History 4');
                                                          
INSERT INTO sellers VALUES ('michael'), ('maharshi'), ('camila'), ('francis');
INSERT INTO buyer VALUES ('', 'michael'), ('', 'maharshi'), ('', 'camila'), ('', 'francis');
INSERT INTO admins VALUES ('2021-03-23', 'Admin_01');
INSERT INTO customer_representatives VALUES ('2021-03-23', 'Customer_Support');

INSERT INTO bid (bid_id, login_id, amount, item_id) VALUES (2, 'francis', 110, 4);
INSERT INTO has_item (item_id, bid_id) VALUES (4, 2);
INSERT INTO bids (login_id, bid_id, bid_offer, increment) VALUES ('francis', 2, 110, 20);
INSERT INTO legal_bid (bid_id, login_id) VALUES (2, 'francis');

INSERT INTO bid (bid_id, login_id, amount, item_id) VALUES (3, 'francis', 174, 10);
INSERT INTO has_item (item_id, bid_id) VALUES (10, 3);
INSERT INTO bids (login_id, bid_id, bid_offer, increment) VALUES ('francis', 3, 174, 10);
INSERT INTO legal_bid (bid_id, login_id) VALUES (3, 'francis');

INSERT INTO bid (bid_id, login_id, amount, item_id) VALUES (4, 'maharshi', 200, 8);
INSERT INTO has_item (item_id, bid_id) VALUES (8, 4);
INSERT INTO bids (login_id, bid_id, bid_offer, increment) VALUES ('maharshi', 4, 200, 15);
INSERT INTO legal_bid (bid_id, login_id) VALUES (4, 'maharshi');

INSERT INTO bid (bid_id, login_id, amount, item_id) VALUES (5, 'francis', 6, 13);
INSERT INTO has_item (item_id, bid_id) VALUES (13, 5);
INSERT INTO bids (login_id, bid_id, bid_offer, increment) VALUES ('francis', 5, 6, 1);
INSERT INTO illegal_bid (bid_id, login_id) VALUES (5, 'francis');


INSERT INTO bid (bid_id, login_id, amount, item_id) VALUES (6, 'francis', 100, 7);
INSERT INTO has_item (item_id, bid_id) VALUES (7, 6);
INSERT INTO bids (login_id, bid_id, bid_offer, increment) VALUES ('francis', 6, 100, 5);
INSERT INTO illegal_bid (bid_id, login_id) VALUES (6, 'francis');

INSERT INTO bid (bid_id, login_id, amount, item_id) VALUES (7, 'camila', 50, 2);
INSERT INTO has_item (item_id, bid_id) VALUES (2, 7);
INSERT INTO bids (login_id, bid_id, bid_offer, increment) VALUES ('camila', 7, 50, 0);
INSERT INTO illegal_bid (bid_id, login_id) VALUES (7, 'camila');


INSERT INTO sells(item_id, login_id, close_date_time) VALUES
                    (4, 'michael', '2021-02-01 08:30:00'),
                    (10, 'camila', '2021-02-01 08:30:00'),
                    (8, 'francis', '2021-02-01 08:30:00');
       

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
-- DROP TABLE auctions;
-- DROP TABLE manages;
-- DROP TABLE views;
-- DROP TABLE support;
-- DROP TABLE legal_bid;
-- DROP TABLE illegal_bid;

-- SELECT * FROM admins;

-- SELECT * FROM users; 

-- SELECT * FROM end_user;

-- SELECT * FROM item;

-- SELECT * FROM computer_accessories;

-- SELECT * FROM computers;

-- SELECT * FROM auctions;

-- SELECT * FROM alerts;

-- SELECT * FROM winner_alerts; 

-- SELECT * FROM sellers;

-- SELECT * FROM buyer;

-- SELECT * FROM bid;
