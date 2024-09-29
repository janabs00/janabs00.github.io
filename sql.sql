create database Tax_filling;
use Tax_filling;
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    age INT,
    filing_status ENUM('individual', 'business_owner', 'joint', 'other'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Financial_Info (
    financial_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    income DECIMAL(15, 2),
    expenses DECIMAL(15, 2),
    deductions DECIMAL(15, 2),
    investment_income DECIMAL(15, 2),
    rental_income DECIMAL(15, 2),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Tax_Form (
    form_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    form_type VARCHAR(255),
    form_status ENUM('draft', 'submitted', 'error'),
    auto_filled_fields JSON,
    submission_date DATE,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Tax_Saving_Suggestions (
    suggestion_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    suggestion_type ENUM('investment', 'deduction'),
    suggestion_detail VARCHAR(255),
    amount DECIMAL(15, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Tax_Advisory (
    advisory_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    advisory_type VARCHAR(255),
    advisory_detail TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Filing_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    form_id INT,
    year INT,
    filing_status ENUM('completed', 'pending', 'amended'),
    tax_refund DECIMAL(15, 2),
    tax_paid DECIMAL(15, 2),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (form_id) REFERENCES Tax_Form(form_id)
);
CREATE TABLE User_Audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    audit_reason TEXT,
    risk_flagged BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Payment_Plan (
    payment_plan_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    total_tax_due DECIMAL(15, 2),
    installment_amount DECIMAL(15, 2),
    due_date DATE,
    paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Tax_Law_Changes (
    law_id INT PRIMARY KEY AUTO_INCREMENT,
    law_detail TEXT,
    affected_users JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
