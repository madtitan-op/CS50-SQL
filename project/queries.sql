-- INSERTION --

-- Insert data into the `bank` table
INSERT INTO `banks` (`id`, `name`, `address`)
VALUES (1, 'Bank A', '123 Main St'),
    (2, 'Bank B', '456 Elm St');

-- Insert data into the `branch` table
INSERT INTO `branches` (`id`, `name`, `address`, `bank_code`)
VALUES (1, 'Branch X', '789 Oak St', 1),
    (2, 'Branch Y', '321 Pine St', 2);

-- Insert data into the `account` table
INSERT INTO `accounts` (`id`, `account_number`, `type`, `balance`, `branch_id`)
VALUES (1, '1234567890', 'Savings', 1000.00, 1),
    (2, '0987654321', 'Current', 500.00, 2);

-- Insert data into the `loan` table
INSERT INTO `loans` (`id`, `type`, `amount`, `branch_id`)
VALUES (1, 'Personal', 5000.00, 1),
    (2, 'Home', 100000.00, 2);

-- Insert data into the `customer` table
INSERT INTO `customers` (`id`, `name`, `phone`, `address`)
VALUES (1, 'John Doe', '123-456-7890', '456 Maple St'),
    (2, 'Jane Smith', '987-654-3210', '789 Oak St');

-- Insert data into the `account_customer` table
INSERT INTO `account_customers` (`account_id`, `customer_id`)
VALUES (1, 1),
    (2, 2);

-- Insert data into the `loan_customer` table
INSERT INTO `loan_customers` (`loan_id`, `customer_id`)
VALUES (1, 1),
    (2, 2);

-- RETRIEVAL --

-- 1. Retrieve all accounts associated with a specific branch
SELECT * FROM accounts WHERE branch_id = 1;

-- 2. Retrieve all loans associated with a specific branch
SELECT * FROM loans WHERE branch_id = 2;

-- 3. Retrieve all customers associated with a specific account
SELECT c.* FROM customers c
JOIN account_customers ac ON c.id = ac.customer_id
WHERE ac.account_id = 1;

-- 4. Retrieve all customers associated with a specific loan
SELECT c.* FROM customers c
JOIN loan_customers lc ON c.id = lc.customer_id
WHERE lc.loan_id = 2;

-- 5. Retrieve the total balance of all accounts in a specific branch
SELECT SUM(balance) FROM accounts WHERE branch_id = 1;

-- 6. Retrieve the total amount of all loans in a specific branch
SELECT SUM(amount) FROM loans WHERE branch_id = 2;

-- 12. Retrieve the number of accounts associated with a specific customer
SELECT COUNT(*) FROM account_customers WHERE customer_id = 1;

-- 7. Retrieve the number of loans associated with a specific customer
SELECT COUNT(*) FROM loan_customers WHERE customer_id = 2;

-- 8. Retrieve the average balance of all accounts in the database
SELECT AVG(balance) FROM accounts;

-- 9. Retrieve the maximum loan amount in the database
SELECT MAX(amount) FROM loans;

-- 10. Retrieve the view
SELECT * FROM customer_details;

-- Update the balance of a specific account
    UPDATE accounts
    SET balance = 1500.00
    WHERE id = 1;

    -- Update the address of a specific customer
    UPDATE customers
    SET address = '123 Elm St'
    WHERE id = 2;

    -- Delete a specific loan
    DELETE FROM loans
    WHERE id = 1;

    -- Delete all customers associated with a specific branch
    DELETE FROM customers
    WHERE id IN (
        SELECT c.id
        FROM customers c
        JOIN account_customers ac ON c.id = ac.customer_id
        JOIN accounts a ON ac.account_id = a.id
        WHERE a.branch_id = 1
    );
