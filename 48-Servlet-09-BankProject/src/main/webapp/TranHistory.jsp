<%@page import="com.ay.bean.CustomerBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ay.bean.TransactionBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Banking Dashboard</title>
    
    <link href="css/TransactionHistory.css" rel="stylesheet">
</head>
<body>
    <%
    HttpSession hs = request.getSession(false);
    CustomerBean cb = (CustomerBean) hs.getAttribute("bean");
    if (cb == null) {
        request.setAttribute("msg", "Session Expired");
        request.getRequestDispatcher("SignIn.jsp").include(request, response);
    } else {
        ArrayList<TransactionBean> transactions = (ArrayList<TransactionBean>) hs.getAttribute("transactions");
        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd"); // Date format
    %>
    <div class="container">
        <header>
            <h1>Welcome to the <span>Banking</span> Dashboard</h1>
            <h2>Hello, <%= cb.getCustName() %>!</h2>
        </header>

        <table class="transaction-table">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Sender Account Number</th>
                    <th>Sender Name</th>
                    <th>Receiver Account Number</th>
                    <th>Receiver Name</th>
                    <th>Transaction Amount</th>
                    <th>Transaction Date</th> <!-- Added header for transaction date -->
                </tr>
            </thead>
            <tbody>
                <% 
                if (transactions != null && !transactions.isEmpty()) {
                    for (TransactionBean transaction : transactions) {
                        String formattedDate = dateFormatter.format(transaction.getTransactionDate()); // Format the date
                %>
                <tr>
                    <td><%= transaction.getId() %></td>
                    <td><%= transaction.getSenderAccNumber() %></td>
                    <td><%= transaction.getSenderName() %></td>
                    <td><%= transaction.getReceiverAccNumber() %></td>
                    <td><%= transaction.getReceiverName() %></td>
                    <td>$ <%= transaction.getTransactionAmount() %></td>
                    <td><%= formattedDate %></td> <!-- Display the formatted date -->
                </tr>
                <% 
                    }
                } else {
                %>
                <tr>
                    <td colspan="7">No transactions found.</td> <!-- Updated colspan to include new column -->
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <a href="Welcome.jsp" class="back-link">Back to Dashboard</a>
    </div>

    <script src="scripts/dashboard.js"></script>
    <%
    }
    %>
</body>
</html>
