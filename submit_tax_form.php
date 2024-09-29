<?php
// Database connection details
$host = "localhost";
$user = "root";  // Change if necessary
$pass = "";      // Change if necessary
$db = "Tax_filling";

// Create connection
$conn = new mysqli($host, $user, $pass, $db);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Collect form data
    $name = $_POST['name'];
    $age = $_POST['age'];
    $employment_status = $_POST['employment-status'];
    $revenues = $_POST['revenues'];
    $expenses = $_POST['expenses'];
    $home_loan_interest = $_POST['home-loan-interest'];
    $education_loan = $_POST['education-loan'];
    $donations = $_POST['donations'];
    $insurance_premiums = $_POST['insurance-premiums'];

    // Insert user information into User table
    $insert_user = "INSERT INTO User (name, age, filing_status) 
                    VALUES ('$name', $age, '$employment_status')";

    if ($conn->query($insert_user) === TRUE) {
        $user_id = $conn->insert_id; // Get the last inserted user ID

        // Calculate total deductions
        $deductions = $home_loan_interest + $education_loan + $donations + $insurance_premiums;

        // Insert financial info into Financial_Info table
        $insert_financial_info = "INSERT INTO Financial_Info (user_id, income, expenses, deductions) 
                                  VALUES ($user_id, $revenues, $expenses, $deductions)";

        if ($conn->query($insert_financial_info) === TRUE) {
            echo "Data successfully inserted!";
        } else {
            echo "Error inserting financial info: " . $conn->error;
        }

    } else {
        echo "Error inserting user: " . $conn->error;
    }
}
$conn->close();
?>
