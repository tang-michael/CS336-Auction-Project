CREATE TABLE `question` (
    `question_id` INT(100) AUTO_INCREMENT,
    `question` VARCHAR(100),
    `login_id` VARCHAR(100),
    `created` date,
    primary key (`question_id`),
    foreign key (`login_id`) references `end_user`(`login_id`)
);


CREATE TABLE `answer` (
    `answer_id` INT(100) AUTO_INCREMENT,
    `answer` VARCHAR(255),
    `question_id` INT (100),
    `login_id` VARCHAR (50),
    `created` date,
    primary key (`answer_id`),
    foreign key (`question_id`) references `question`(`question_id`),
    foreign key (`login_id`) references `customer_representatives`(`login_id`)
);

CREATE TABLE `sales_reports` (
    `sales_report_id` INT(100) AUTO_INCREMENT,
    `earnings_per_item` TEXT,
    `earnings_per_buyer` TEXT,
    `generated_date` DATE,
    primary key (`sales_report_id`)
);

INSERT INTO `auctions` (`auction_id`, `history_of_bids`) VALUES (1, 'Test History 1'),
                                                                (2, 'Test History 2'),
                                                                (3, 'Test History 3'),
                                                                (4, 'Test History 4');
INSERT INTO users
VALUES ('Anonymous', 'User', 'anonymous', 'anonym'),
       ('maharshi', 'patel', 'maharshi', 'patel'),
          ('michael', 'tang', 'michael', 'tang'),
          ('francis', 'adu', 'francis', 'adu'),
          ('camila', 'mata', 'camila', 'mata'),
          ('John', 'Smith', 'Admin_01', 'root'),
          ('Sam', 'Christian', 'Customer_Support', 'root');


INSERT INTO sellers VALUES ('michael'), ('maharshi'), ('camila'), ('francis'), ('anonymous');
INSERT INTO buyer VALUES ('', 'michael'), ('', 'maharshi'), ('', 'camila'), ('', 'francis');
INSERT INTO admins VALUES ('2021-03-23', 'Admin_01');
INSERT INTO customer_representatives VALUES ('2021-03-23', 'Customer_Support');

INSERT INTO end_user VALUES ('mah@gmail.com', 'maharshi'),
                            ('mic@me.com', 'michael'),
                            ('franc@me.com', 'francis'),
                            ('camil@me.com', 'camila'),
                            ('anonym@me.com', 'anonymous');


INSERT INTO `item`(`item_id`, `login_id`, `item_type`, `brand`, `closing_date`, `closing_time`, `current_bid`, `initial_price`, `min_price`, `characteristics`)
 VALUES (1, 'michael', 'iphone X', 'Apple', '2021-02-01','08:30:00', 857.99, 654.23, 223, ''),
        (2, 'maharshi', 'iPad Mini', 'Apple', '2021-02-01','08:30:00', 423.99, 321.99, 110.99, ''),
        (3, 'camila', 'Macbook Pro 2021', 'Apple', '2021-02-01','08:30:00', 1023.99, 821.99, 710.99, ''),
        (4, 'michael', 'Razer Keyboard', 'Razer', '2021-02-01','08:30:00', 89.99, 54.99, 34.99, ''),
        (5, 'michael', 'Bluesnowball Microphone', 'Bluesnowball', '2021-02-01','08:30:00', 54.99, 43.99, 40.99, ''),
        (6, 'maharshi', 'Apple Airpods', 'Apple', '2021-02-01','08:30:00', 69.99, 59.99, 55.99, ''),
        (7, 'camila', 'HP Spectre Laptop', 'HP', '2021-02-01','08:30:00', 1022.99, 812.99, 712.99, ''),
        (8, 'francis', 'Samsung 27" Monitor', 'Samsung', '2021-02-01','08:30:00', 219.99, 210.99, 199.99, ''),
        (9, 'maharshi', 'College Rule Notebook', 'College Rule', '2021-02-01','08:30:00', 9.99, 8.99, 7.99, ''),
        (10, 'camila', 'HP Officejet Pro 8620', 'HP', '2021-02-01','08:30:00', 213.99, 199.99, 154.99, ''),
        (11, 'francis', 'Reddragon Lite Mouse', 'Apple', '2021-02-01','08:30:00', 423.99, 321.99, 110.99, ''),
        (12, 'camila', 'Cyberpower PC Desktop', 'Cyberpower', '2021-02-01','08:30:00', 1299.99, 1019.99, 999.99, ''),
        (13, 'michael', 'Nike Sneakers', 'Nike', '2021-02-01','08:30:00', 129.99, 99.99, 89.99, ''),
        (14, 'maharshi', 'Addidas Sneakers', 'Addidas', '2021-02-01','08:30:00', 199.99, 159.99, 129.99, ''),
        (15, 'camila', 'iMac 2020', 'Apple', '2021-02-01','08:30:00', 2099.99, 1999.99, 1499.99, '');


INSERT INTO computer_accessories VALUES (4), (5), (6), (8), (10), (11);
INSERT INTO phones VALUES (1), (2);
INSERT INTO computers VALUES (3), (7), (9), (12), (15);

INSERT INTO `bid` (bid_id, login_id) VALUES (1, 'camila');
INSERT INTO `has_item` (item_id, bid_id) VALUES (4, 1);
INSERT INTO `bids` (login_id, bid_id, bid_offer, increment) VALUES ('camila', 1, 100, 30);
INSERT INTO `legal_bid` (bid_id, login_id) VALUES (1, 'camila');

INSERT INTO `bid` (bid_id, login_id) VALUES (2, 'francis');
INSERT INTO `has_item` (item_id, bid_id) VALUES (4, 2);
INSERT INTO `bids` (login_id, bid_id, bid_offer, increment) VALUES ('francis', 2, 110, 20);
INSERT INTO `legal_bid` (bid_id, login_id) VALUES (2, 'francis');

INSERT INTO `bid` (bid_id, login_id) VALUES (3, 'francis');
INSERT INTO `has_item` (item_id, bid_id) VALUES (10, 3);
INSERT INTO `bids` (login_id, bid_id, bid_offer, increment) VALUES ('francis', 3, 174, 10);
INSERT INTO `legal_bid` (bid_id, login_id) VALUES (3, 'francis');

INSERT INTO `bid` (bid_id, login_id) VALUES (4, 'maharshi');
INSERT INTO `has_item` (item_id, bid_id) VALUES (8, 4);
INSERT INTO `bids` (login_id, bid_id, bid_offer, increment) VALUES ('maharshi', 4, 200, 15);
INSERT INTO `legal_bid` (bid_id, login_id) VALUES (4, 'maharshi');

INSERT INTO `bid` (bid_id, login_id) VALUES (5, 'francis');
INSERT INTO `has_item` (item_id, bid_id) VALUES (13, 5);
INSERT INTO `bids` (login_id, bid_id, bid_offer, increment) VALUES ('francis', 5, 6, 1);
INSERT INTO `illegal_bid` (bid_id, login_id) VALUES (5, 'francis');


INSERT INTO `bid` (bid_id, login_id) VALUES (6, 'francis');
INSERT INTO `has_item` (item_id, bid_id) VALUES (7, 6);
INSERT INTO `bids` (login_id, bid_id, bid_offer, increment) VALUES ('francis', 6, 100, 5);
INSERT INTO `illegal_bid` (bid_id, login_id) VALUES (6, 'francis');

INSERT INTO `bid` (bid_id, login_id) VALUES (7, 'camila');
INSERT INTO `has_item` (item_id, bid_id) VALUES (2, 7);
INSERT INTO `bids` (login_id, bid_id, bid_offer, increment) VALUES ('camila', 7, 50, 0);
INSERT INTO `illegal_bid` (bid_id, login_id) VALUES (7, 'camila');


INSERT INTO `sells`(`item_id`, `login_id`, `close_date_time`) VALUES
                    (4, 'michael', '2021-02-01 08:30:00'),
                    (10, 'camila', '2021-02-01 08:30:00'),
                    (8, 'francis', '2021-02-01 08:30:00');




