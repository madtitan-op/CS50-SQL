-- CREATING TABLES --
CREATE TABLE `banks`(
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(25),
    `address` TEXT,
    PRIMARY KEY(`id`)
);

CREATE TABLE `branches`(
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(25),
    `address` TEXT,
    `bank_code` INT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`bank_code`) REFERENCES `banks`(`id`)
);

CREATE TABLE `accounts`(
    `id` INT AUTO_INCREMENT,
    `account_number` VARCHAR(16),
    `type` ENUM('Savings', 'Current', 'Fixed Deposit'),
    `balance` DECIMAL(10,2),
    `branch_id` INT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`branch_id`) REFERENCES `branches`(`id`)
);

CREATE TABLE `loans`(
    `id` INT AUTO_INCREMENT,
    `type` ENUM('Personal', 'Home', 'Gold', 'Education'),
    `amount` DECIMAL(10,2),
    `branch_id` INT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`branch_id`) REFERENCES `branches`(`id`)
);

CREATE TABLE `customers`(
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(50),
    `phone` VARCHAR(15),
    `address` TEXT,
    PRIMARY KEY(`id`)
);

CREATE TABLE `account_customers`(
    `account_id` INT,
    `customer_id` INT,
    PRIMARY KEY(`account_id`, `customer_id`),
    FOREIGN KEY(`account_id`) REFERENCES `accounts`(`id`),
    FOREIGN KEY(`customer_id`) REFERENCES `customers`(`id`)
);

CREATE TABLE `loan_customers`(
    `loan_id` INT,
    `customer_id` INT,
    PRIMARY KEY(`loan_id`, `customer_id`),
    FOREIGN KEY(`loan_id`) REFERENCES `loans`(`id`),
    FOREIGN KEY(`customer_id`) REFERENCES `customers`(`id`)
);

-- CREATING INDEXES --
CREATE INDEX idx_customer_name ON customers(name);
CREATE INDEX idx_branch_name ON branches(name);
CREATE INDEX idx_account_account_number ON accounts(account_number);
CREATE INDEX idx_account_customer_customer_id ON account_customers(customer_id);
CREATE INDEX idx_loan_customer_customer_id ON loan_customers(customer_id);

-- CREATING A VIEW --
CREATE VIEW customer_details AS
SELECT c.name, a.account_number, l.type AS loan_type, a.balance, l.amount AS loan_amount
FROM customers c
LEFT JOIN account_customers ac ON c.id = ac.customer_id
LEFT JOIN accounts a ON ac.account_id = a.id
LEFT JOIN loan_customers lc ON c.id = lc.customer_id
LEFT JOIN loans l ON lc.loan_id = l.id;
