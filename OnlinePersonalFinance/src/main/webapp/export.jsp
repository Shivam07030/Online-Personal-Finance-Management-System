<%@ page language="java" %>
<html>
<head>
    <title>Export Data</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>Export Your Data</h2>
    <form action="ExportServlet" method="post">
        <button type="submit" name="format" value="csv" class="btn btn-info">Export as CSV</button>
        <button type="submit" name="format" value="pdf" class="btn btn-info">Export as PDF</button>
    </form>
    <p style="color:red;"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
</div>
</body>
</html>
