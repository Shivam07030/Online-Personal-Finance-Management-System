<%@ page language="java" %>
<html>
<head>
    <title>Budget Planner</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>Budget Planner</h2>
    <form action="BudgetServlet" method="post">
        <input type="number" name="budget" class="form-control" placeholder="Set Monthly Budget" required>
        <button type="submit" class="btn btn-primary mt-2">Save Budget</button>
    </form>
    <% 
      Double budget = (Double) request.getAttribute("budget");
      if(budget != null) {
          out.println("<p>Current Budget: " + budget + "</p>");
      }
      String alert = (String) request.getAttribute("alert");
      if(alert != null) {
          out.println("<div style='color:red;'>" + alert + "</div>");
      }
    %>
    <p style="color:green;"><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></p>
    <p style="color:red;"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
</div>
</body>
</html>
