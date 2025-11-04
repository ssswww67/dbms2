CREATE database Worker_DB;
USE Worker_db;

CREATE Table Worker (
	Worker_ID INT NOT NULL PRIMARY KEY,
    First_name VARCHAR(50),
    last_name VARCHAR(50),
    salary INT,
    Joining_Date Datetime,
    Department VARCHAR(25)
    );
    
INSERT INTO Worker(Worker_ID,First_name,last_name,
salary,Joining_Date,Department)
 VALUES (001,'Monika','Arora',100000,'2021-02-20 09:00:00','HR'),
		(002,'Niharika','Verma',80000,'2021-06-11 09:00:00','ADMIN'),
		(003,'Vishal','Singhal',300000,'2021-02-20 09:00:00','HR'),
		(004,'Amitabh','Singh',500000,'2021-02-20 09:00:00','ADMIN'),
		(005,'Vivek','Bhati',500000,'2021-06-11 09:00:00','ADMIN'),
		(006,'Vipul','Diwan',200000,'2021-06-11 09:00:00','ACCOUNT'),
		(007,'Satish','Kumar',75000,'2021-01-20 09:00:00','ACCOUNT'),
		(008,'Geetika','Chauhan',90000,'2021-04-11 09:00:00','ADMIN');
        
	CREATE TABLE Bonus (
		WORKER_REF_ID INT,
		BONUS_AMOUNT INT,
		BONUS_DATE DATETIME,
		FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID) ON DELETE CASCADE
);

INSERT INTO Bonus (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
    (1, 5000, '2023-02-20'),
    (2, 3000, '2023-06-11'),
    (3, 4000, '2023-02-20'),
    (1, 4500, '2023-02-20'),
    (2, 3500, '2023-06-11');

CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID) ON DELETE CASCADE
);

INSERT INTO Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
    (1, 'Manager', '2023-02-20 00:00:00'),
    (2, 'Executive', '2023-06-11 00:00:00'),
    (8, 'Executive', '2023-06-11 00:00:00'),
    (5, 'Manager', '2023-06-11 00:00:00'),
    (4, 'Asst. Manager', '2023-06-11 00:00:00'),
    (7, 'Executive', '2023-06-11 00:00:00'),
    (6, 'Lead', '2023-06-11 00:00:00'),
    (3, 'Lead', '2023-06-11 00:00:00');
    
    -- EXP 3
		-- Viewing tables and databases
		SHOW databases;
		SHOW tables;
        
        -- Viewing Table records
		SELECT * FROM Worker;
		SELECT * FROM bonus;
		SELECT * FROM title;
        
        -- Updating records
        UPDATE Worker
        SET Salary=120000
        WHERE Worker_ID = 2;
        
        -- Deleting records
        Delete FROM Worker
        WHERE Worker_ID =8;
        
        
	-- Exp 4
		-- Altering Table
			-- Adding column
				Alter TABLE Worker
                ADD Email VARCHAR(50);
			-- Updating columns's data type
				Alter TABLE Worker
                MODIFY Salary DECIMAL(10,2);
			-- Renaming a column
				Alter TABLE Worker
                CHANGE last_name Last_name VARCHAR(50);
			-- Deleting a column
				Alter TABLE Worker 
                DROP column Email;
                
		-- Truncate Table
			TRUNCATE TABLE title;
            
		-- Renaming Table
			RENAME TABLE Worker TO Employee;
            RENAME TABLE Employee TO Worker; 
            
		-- Backup and Restore
			-- mysqldump -u root -p Worker_DB > Worker_DB_Backup.sql
			-- mysql -u root -p Worker_DB < Worker_DB_Backup.sql


	-- Exp5
		-- 1️.Count total number of workers
			SELECT COUNT(*) AS Total_Workers FROM Worker;

		-- 2️.Count workers in each department
			SELECT Department, COUNT(*) AS Num_Of_Workers FROM Worker
			GROUP BY Department;

		-- 3. Display current date and time
			SELECT NOW() AS Current_Date_Time;

		-- 4.Combine first and last name
			SELECT CONCAT(First_name, ' ', Last_name) AS Full_Name FROM Worker;

		-- 5️.Raise salary to the power of 2 (for demonstration)
			SELECT First_name, POWER(Salary, 2) AS Salary_Squared FROM Worker;
            
            
	-- Exp6
		SELECT W.Worker_ID, W.First_name, W.Department, B.BONUS_AMOUNT, B.BONUS_DATE
		FROM Worker W
		INNER JOIN Bonus B
		ON W.Worker_ID = B.WORKER_REF_ID;

		SELECT W.Worker_ID, W.First_name, B.BONUS_AMOUNT, B.BONUS_DATE
		FROM Worker W
		LEFT JOIN Bonus B
		ON W.Worker_ID = B.WORKER_REF_ID;

		SELECT W.Worker_ID, W.First_name, B.BONUS_AMOUNT, B.BONUS_DATE
		FROM Worker W
		RIGHT JOIN Bonus B
		ON W.Worker_ID = B.WORKER_REF_ID;

	-- Exp7
		SELECT Department, COUNT(*) AS Total_Workers
		FROM Worker
		GROUP BY Department;

		SELECT First_name, Last_name
		FROM Worker
		WHERE Worker_ID IN (SELECT WORKER_REF_ID FROM Bonus);

		SELECT W.First_name, W.Last_name
		FROM Worker W
		WHERE EXISTS (
			SELECT * FROM Title T
			WHERE T.WORKER_REF_ID = W.Worker_ID
		);

	
	-- Exp8
		SELECT First_Name AS Info FROM Worker
		UNION
		SELECT Worker_Title AS Info FROM Title;
        
	-- Exp9
		START TRANSACTION;
		INSERT INTO Worker (Worker_ID, First_Name, Last_Name, Salary, Joining_Date, Department)
		VALUES (009, 'Rohit', 'Sharma', 120000, '2023-07-01 09:00:00', 'HR');
		-- Check the data temporarily
		SELECT * FROM Worker;
		-- Now undo the insert
		ROLLBACK;
		-- Check again (worker 009 should be gone)
		SELECT * FROM Worker;

		START TRANSACTION;
		INSERT INTO Worker (Worker_ID, First_Name, Last_Name, Salary, Joining_Date, Department)
		VALUES (010, 'Priya', 'Verma', 95000, '2023-07-02 09:00:00', 'ADMIN');
		-- Save permanently
		COMMIT;
		-- Check again
		SELECT * FROM Worker;
        
        
	-- Exp10
		CREATE VIEW Worker_View AS
		SELECT Worker_ID, First_Name, Last_Name, Department, Salary FROM Worker;
		SELECT * FROM Worker_View;
        DROP VIEW Worker_View;

        
		CREATE INDEX idx_department
		ON Worker(Department);
		SELECT * FROM Worker 
        WHERE Department = 'HR';
		DROP INDEX idx_department ON Worker;





    