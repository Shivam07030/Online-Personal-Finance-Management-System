<%@ page import="java.util.List,com.finance.model.Category" %>
<html>
<head>
    <title>Categories</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>Manage Categories</h2>
    <form action="CategoryServlet" method="post">
        <input type="text" name="name" class="form-control" placeholder="Category Name" required>
        <button type="submit" class="btn btn-success mt-2">Add Category</button>
    </form>
    <ul class="mt-4">
        <%
          List<Category> categories = (List<Category>) request.getAttribute("categories");
          if (categories != null) {
            for (Category c : categories) {
                out.println("<li>" + c.getName() + "</li>");
            }
          }
        %>
    </ul>
    <p style="color:red;"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
</div>
</body>
</html>
