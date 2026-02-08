


/* 1. Create table */
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(50) NOT NULL,
    balance INT CHECK (balance >= 0)
);

/* 2. Insert initial data */
INSERT INTO accounts VALUES
(1, 'Ravi', 10000),
(2, 'Sita', 5000);

/* 3. Initial balances */
SELECT * FROM accounts;

/* 4. Start transaction */
START TRANSACTION;

/* 5. Valid money transfer */
UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 2;

/* 6. Create savepoint */
SAVEPOINT after_transfer;

/* 7. Logical mistake simulation (not constraint violation) */
UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

/* 8. Rollback wrong step */
ROLLBACK TO after_transfer;

/* 9. Commit correct transaction */
COMMIT;

/* 10. Final balances */
SELECT * FROM accounts;
