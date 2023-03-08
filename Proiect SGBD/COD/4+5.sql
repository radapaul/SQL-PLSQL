REM   Script: DATABASE CREATION
REM   create database

DROP SEQUENCE company_seq;

DROP TABLE tLocation CASCADE CONSTRAINTS;

DROP TABLE tProduct CASCADE CONSTRAINTS;

DROP TABLE tClient CASCADE CONSTRAINTS;

DROP TABLE tInvestor CASCADE CONSTRAINTS;

DROP TABLE tStore CASCADE CONSTRAINTS;

DROP TABLE tJobHistory CASCADE CONSTRAINTS;

DROP TABLE tJob CASCADE CONSTRAINTS;

DROP TABLE tEmployee CASCADE CONSTRAINTS;

DROP TABLE tCompany CASCADE CONSTRAINTS;

DROP TABLE tSupplierContract CASCADE CONSTRAINTS;

DROP TABLE tTransactionHistory CASCADE CONSTRAINTS;

DROP TABLE tProductStoreRelation CASCADE CONSTRAINTS;

DROP TABLE tCompanyInvestorRelation CASCADE CONSTRAINTS;

CREATE TABLE tCompany ( 
    id                  INT             NOT NULL, 
    name                VARCHAR(50)     NOT NULL, 
    ceo                 VARCHAR(50)     NOT NULL, 
    cr_date             DATE                    , 
    value               DECIMAL(18,2)           , 
    PRIMARY KEY (id)                 
);

CREATE TABLE tStore ( 
    id                  INT             NOT NULL, 
    id_location         INT             NOT NULL, 
    type                VARCHAR(10)     NOT NULL, 
    id_company          INT             NOT NULL, 
    PRIMARY KEY (id) 
);

CREATE TABLE tSupplierContract( 
    id                  INT             NOT NULL, 
    name                VARCHAR(50)     NOT NULL, 
    price               DECIMAL(9,2)    NOT NULL, 
    duration_months     INT             NOT NULL, 
    sign_date           DATE            NOT NULL, 
    id_store            INT             NOT NULL, 
    PRIMARY KEY (id)   
);

CREATE TABLE tLocation( 
    id                  INT             NOT NULL, 
    county              VARCHAR(50)     NOT NULL, 
    city                VARCHAR(50)     NOT NULL, 
    street              VARCHAR(50)     NOT NULL, 
    postal_code         INT                     , 
    PRIMARY KEY (id)   
);

CREATE TABLE tClient( 
    id                  INT             NOT NULL, 
    id_store            INT             NOT NULL, 
    type                VARCHAR(50)             , 
    first_name          VARCHAR(50)     NOT NULL, 
    last_name           VARCHAR(50)     NOT NULL, 
    email               VARCHAR(50)             , 
    phone_number        VARCHAR(50)     NOT NULL, 
    PRIMARY KEY (id)      
);

CREATE TABLE tTransactionHistory( 
    id                  INT             NOT NULL, 
    id_client           INT             NOT NULL, 
    sum                 DECIMAL(9,2)    NOT NULL, 
    cr_date             TIMESTAMP       NOT NULL, 
    PRIMARY KEY (id) 
);

CREATE TABLE tEmployee ( 
    id                  INT             NOT NULL, 
    id_store            INT 	        NOT NULL, 
    id_job_history      INT             NOT NULL, 
    salary              DECIMAL(11,2)   NOT NULL, 
    surname             VARCHAR(50)             , 
    name                VARCHAR(50)             , 
    id_manager          INT                     , 
    email               VARCHAR(100)            , 
    phone_number        VARCHAR(10)             , 
    PRIMARY KEY (id) 
);

CREATE TABLE tJobHistory( 
    id                  INT             NOT NULL, 
    id_job              INT             NOT NULL, 
    start_date          DATE            NOT NULL, 
    end_date            DATE                    , 
    PRIMARY KEY (id)  
);

CREATE TABLE tJob( 
    id                  INT             NOT NULL, 
    title               VARCHAR(50)     NOT NULL, 
    min_salary          INT             NOT NULL, 
    max_salary          INT             NOT NULL, 
    PRIMARY KEY (id)   
);

CREATE TABLE tProduct ( 
    id                  INT             NOT NULL, 
    name                VARCHAR(20)     NOT NULL, 
    price               DECIMAL(9,2)    NOT NULL, 
    PRIMARY KEY (id) 
);

CREATE TABLE tProductStoreRelation ( 
    id                  INT             NOT NULL, 
    id_product          INT             NOT NULL, 
    id_store            INT             NOT NULL, 
    PRIMARY KEY (id) 
);

CREATE TABLE tInvestor ( 
    id                  INT             NOT NULL, 
    name                VARCHAR(50)     NOT NULL, 
    PRIMARY KEY (id)                 
);

CREATE TABLE tCompanyInvestorRelation ( 
    id                  INT             NOT NULL, 
    id_company          INT             NOT NULL, 
    id_investor         INT             NOT NULL, 
    PRIMARY KEY (id) 
);

ALTER TABLE tStore ADD CONSTRAINT fk_id_company FOREIGN KEY (id_company) REFERENCES tCompany(id);

ALTER TABLE tStore ADD CONSTRAINT fk_id_location FOREIGN KEY (id_location) REFERENCES tLocation(id);

ALTER TABLE tSupplierContract ADD CONSTRAINT fk_id_store FOREIGN KEY (id_store) REFERENCES tStore(id);

ALTER TABLE tClient ADD CONSTRAINT fk_id_store_tClient FOREIGN KEY (id_store) REFERENCES tStore(id);

ALTER TABLE tTransactionHistory ADD CONSTRAINT fk_id_client FOREIGN KEY (id_client) REFERENCES tClient(id);

ALTER TABLE tEmployee ADD CONSTRAINT fk_id_store_tEmployee FOREIGN KEY (id_store) REFERENCES tStore(id);

ALTER TABLE tEmployee ADD CONSTRAINT fk_id_job_history FOREIGN KEY (id_job_history) REFERENCES tJobHistory(id);

ALTER TABLE tJobHistory ADD CONSTRAINT fk_id_job FOREIGN KEY (id_job) REFERENCES tJob(id);

ALTER TABLE tProductStoreRelation ADD CONSTRAINT fk_id_product FOREIGN KEY (id_product) REFERENCES tProduct(id);

ALTER TABLE tProductStoreRelation ADD CONSTRAINT fk_id_store_tProductStoreRelation FOREIGN KEY (id_store) REFERENCES tStore(id);

ALTER TABLE tCompanyInvestorRelation ADD CONSTRAINT fk_id_company_tCompanyInvestorRelation FOREIGN KEY (id_company) REFERENCES tCompany(id);

ALTER TABLE tCompanyInvestorRelation ADD CONSTRAINT fk_id_investor FOREIGN KEY (id_investor) REFERENCES tInvestor(id);

ALTER TABLE tStore 
ADD CONSTRAINT tStore_c1  
CHECK ( 
    type in ( 
        'NONSTOP', 
        'EXPRESS', 
        'SUPERSTORE', 
        'NORMAL' 
    ) 
);

ALTER TABLE tClient 
ADD CONSTRAINT tClient_c1  
CHECK ( 
    type in ( 
        'Aur', 
        'Platina', 
        'Argint', 
        'Diamant', 
        'Bronz' 
    ) 
);

ALTER TABLE tJob 
ADD CONSTRAINT tJob_c1  
CHECK ( 
    title in ( 
        'Programator', 
        'Vanzator', 
        'Securitate', 
        'Electrician', 
        'Om de serviciu', 
        'Manager', 
        'HR', 
        'Bucatar', 
        'QA', 
        'Lucrator la depozit' 
    ) 
);

    CREATE SEQUENCE company_seq START WITH 0 INCREMENT BY 1 MINVALUE 0;

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'Lorsus', 'Maria Ionescu', DATE '2009-06-24', 19173810);

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'Platinum Home', 'Ioana Ungureanu', DATE '2007-10-31', 7276086171);

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'Xaris', 'Paula Popescu', DATE '2002-03-04', 24140019);

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'Horrisons', 'Daria Moldovan', DATE '2002-03-25', 5546498854);

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'Micro', 'Ada Simon', DATE '1991-01-10', 65636840);

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'KIDL', 'Catalina Rusu', DATE '1998-06-27', 76758296);

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'Rafus', 'Marian Marginean', DATE '1997-04-11', 56217890);

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'AZDA', 'Alexandra Costea', DATE '2009-02-24', 723619940);

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'Aqua', 'Alexandra Popa', DATE '1997-05-10', 39473874);

    INSERT INTO tCompany  
        (id, name, ceo, cr_date, value) 
    VALUES 
        (company_seq.nextval, 'Balors', 'Razvan Tudor', DATE '1994-01-14', 185560072);

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (0, 'Dante');

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (1, 'Play');

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (2, 'Foint');

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (3, 'Emporium');

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (4, 'Bochan');

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (5, 'Erlin');

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (6, 'Jankus');

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (7, 'Helbis');

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (8, 'Nezlo');

    INSERT INTO tInvestor  
        (id, name) 
    VALUES 
        (9, 'Experience');

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (0, 8, 2);

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (1, 5, 9);

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (2, 1, 2);

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (3, 2, 4);

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (4, 8, 7);

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (5, 1, 5);

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (6, 6, 3);

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (7, 6, 8);

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (8, 6, 4);

    INSERT INTO tCompanyInvestorRelation  
        (id, id_investor, id_company) 
    VALUES 
        (9, 5, 7);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (0, 'Dambovita', 'Targoviste', 'Fericirii', 021345);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (1, 'Covasna', 'Sfantu Gheorghe', 'Mantuirii', 054321);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (2, 'Vrancea', 'Focsani', 'Bucuriei', 099772);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (3, 'Dolj', 'Craiova', 'Rusaliilor', 072727);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (4, 'Bihor', 'Oradea', 'Sperantei', 065432);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (5, 'Gorj', 'Targu Jiu', 'Slabiciunii', 010199);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (6, 'Ilfov', 'Bucuresti', 'V.V.Stanciu', 098765);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (7, 'Olt', 'Slatina', 'Vulturului', 013370);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (8, 'Alba', 'Alba Iulia', 'Stefan cel Mare', 087654);

    INSERT INTO tLocation  
        (id, county, city, street, postal_code) 
    VALUES 
        (9, 'Hunedoara', 'Deva', 'Vointei', 088877);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (0, 'Om de serviciu', 75265, 341382);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (1, 'Vanzator', 48492, 659990);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (2, 'HR', 59847, 479696);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (3, 'Programator', 61595, 436980);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (4, 'Bucatar', 75460, 128846);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (5, 'Securitate', 11166, 115100);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (6, 'Lucrator la depozit', 52197, 491538);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (7, 'Electrician', 65410, 829280);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (8, 'QA', 95510, 859832);

    INSERT INTO tJob  
        (id, title, min_salary, max_salary) 
    VALUES 
        (9, 'Manager', 79757, 710392);

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (0, 1, DATE '2016-09-25', DATE '2021-12-08');

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (1, 1, DATE '2015-11-29', DATE '2020-03-21');

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (2, 9, DATE '2015-05-25', DATE '2020-01-09');

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (3, 6, DATE '2015-12-29', DATE '2019-06-09');

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (4, 7, DATE '2016-04-05', DATE '2021-02-12');

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (5, 3, DATE '2016-07-16', DATE '2021-11-05');

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (6, 7, DATE '2014-07-30', DATE '2020-09-10');

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (7, 7, DATE '2016-09-29', DATE '2020-09-16');

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (8, 2, DATE '2014-10-19', DATE '2020-08-10');

    INSERT INTO tJobHistory  
        (id, id_job, start_date, end_date) 
    VALUES 
        (9, 6, DATE '2016-10-10', DATE '2021-10-02');

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (0, 8, 'NONSTOP', 9);

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (1, 8, 'NORMAL', 0);

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (2, 5, 'NONSTOP', 2);

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (3, 3, 'EXPRESS', 9);

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (4, 9, 'EXPRESS', 0);

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (5, 7, 'SUPERSTORE', 8);

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (6, 7, 'NONSTOP', 8);

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (7, 0, 'NORMAL', 1);

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (8, 1, 'NONSTOP', 7);

    INSERT INTO tStore  
        (id, id_location, type, id_company) 
    VALUES 
        (9, 9, 'EXPRESS', 4);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (0, 'Ghiplo', 7672529, 90, DATE '2018-10-06', 1);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (1, 'Morael', 146600, 47, DATE '2019-01-07', 3);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (2, 'Orthos', 6576840, 8, DATE '2015-06-06', 8);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (3, 'The Dollar Follow', 4345720, 3, DATE '2015-07-27', 6);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (4, 'Iartur', 5732887, 81, DATE '2019-07-03', 1);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (5, 'TORA', 969712, 66, DATE '2018-01-10', 6);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (6, 'Saintsburey', 583649, 7, DATE '2021-05-25', 7);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (7, 'Pesco', 539420, 9, DATE '2014-01-23', 8);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (8, 'Golden Roads', 6668022, 9, DATE '2014-09-27', 3);

    INSERT INTO tSupplierContract  
        (id, name, price, duration_months, sign_date, id_store) 
    VALUES 
        (9, 'Cranda', 5964499, 2, DATE '2016-12-12', 3);

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (0, 1, 0, 47589, 'Ungureanu', 'Catalina', 9, 'Catalina.Ungureanu91@protonmail.com', '0702072221');

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (1, 5, 1, 76516, 'Ciobanu', 'Radu', 0, 'Radu.Ciobanu91@aol.com', '0734164410');

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (2, 3, 2, 6637, 'Mocanu', 'Georgiana', 2, 'Georgiana.Mocanu40@outlook.com', '0756388946');

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (3, 7, 3, 88855, 'Munteanu', 'Ada', 8, 'Ada.Munteanu61@yahoo.com', '0790433674');

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (4, 7, 4, 4221, 'Rusu', 'Laura', 6, 'Laura.Rusu93@protonmail.com', '0756315239');

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (5, 9, 5, 44551, 'Popescu', 'Stefania', 7, 'Stefania.Popescu85@aol.com', '0740152915');

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (6, 5, 6, 5604, 'Rusu', 'Paul', 3, 'Paul.Rusu4@gmail.com', '0734128041');

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (7, 8, 7, 9746, 'Stan', 'Ana', 2, 'Ana.Stan44@gmail.com', '0740196308');

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (8, 5, 8, 10800, 'Ungureanu', 'Laur', 9, 'Laur.Ungureanu8@protonmail.com', NULL);

    INSERT INTO tEmployee  
        (id, id_store, id_job_history, salary, surname, name, id_manager, email, phone_number) 
    VALUES 
        (9, 9, 9, 57982, 'Baciu', 'Paul', 1, 'Paul.Baciu25@gmail.com', '0756382891');

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (0, 'Paine', 2);

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (1, 'Tacamuri', 2);

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (2, 'Bauturi alcoolice', 764);

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (3, 'Dulciuri', 4);

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (4, 'Sanitare', 38);

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (5, 'Suc', 283);

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (6, 'Fruct', 492);

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (7, 'Plusuri', 35);

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (8, 'Carne', 5);

    INSERT INTO tProduct  
        (id, name, price) 
    VALUES 
        (9, 'Apa', 80);

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (0, 4, 'Argint', 'George', 'Ciobanu', 'George.Ciobanu66@protonmail.com', '0702079588');

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (1, 1, 'Aur', 'Ioana', 'Ion', 'Ioana.Ion55@protonmail.com', '0702037446');

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (2, 2, 'Bronz', 'Vasile', 'Rotaru', 'Vasile.Rotaru54@gmail.com', '0734190879');

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (3, 0, 'Aur', 'George', 'Dumitru', 'George.Dumitru65@aol.com', '0702058146');

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (4, 2, 'Diamant', 'Maria', 'Munteanu', 'Maria.Munteanu8@yahoo.com', '0702005075');

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (5, 4, 'Bronz', 'Alexandru', 'Mocanu', 'Alexandru.Mocanu67@outlook.com', '0702038587');

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (6, 6, 'Bronz', 'George', 'Ionescu', 'George.Ionescu39@outlook.com', '0790440611');

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (7, 8, 'Platina', 'Stefania', 'Pop', 'Stefania.Pop51@gmail.com', '0756381460');

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (8, 5, 'Platina', 'Maria', 'Baciu', 'Maria.Baciu60@protonmail.com', '0790457601');

    INSERT INTO tClient  
        (id, id_store, type, first_name, last_name, email, phone_number) 
    VALUES 
        (9, 8, 'Aur', 'Alexandru', 'Munteanu', 'Alexandru.Munteanu8@gmail.com', '0734109730');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (0, 5, 76843, TIMESTAMP '2019-03-18 03:56:57');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (1, 3, 4, TIMESTAMP '2017-01-18 06:06:09');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (2, 4, 88830, TIMESTAMP '2019-09-08 12:12:11');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (3, 1, 74, TIMESTAMP '2018-07-22 03:12:36');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (4, 3, 8, TIMESTAMP '2017-07-29 19:52:55');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (5, 2, 83, TIMESTAMP '2018-07-23 14:28:54');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (6, 9, 680, TIMESTAMP '2019-12-14 10:49:25');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (7, 5, 1062, TIMESTAMP '2019-04-19 08:52:44');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (8, 8, 9, TIMESTAMP '2019-12-24 11:30:24');

    INSERT INTO tTransactionHistory  
        (id, id_client, sum, cr_date) 
    VALUES 
        (9, 1, 3, TIMESTAMP '2018-07-19 06:44:19');

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (0, 4, 8);

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (1, 8, 7);

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (2, 6, 9);

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (3, 8, 8);

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (4, 1, 7);

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (5, 0, 0);

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (6, 8, 6);

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (7, 8, 5);

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (8, 9, 9);

    INSERT INTO tProductStoreRelation  
        (id, id_store, id_product) 
    VALUES 
        (9, 6, 0);

