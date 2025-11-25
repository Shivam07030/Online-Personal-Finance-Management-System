<%@ page import="java.util.List,com.finance.model.Transaction" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Transactions</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
      .navbar-sci-fi {
        background: rgba(12, 24, 32, 0.97);
        box-shadow: 0 0 24px 3px #00fff9;
        border-bottom: 1px solid #08f0ff44;
        padding-bottom: 8px;
      }
      .navbar-sci-fi .navbar-brand {
        color: #08f0ff;
        font-weight: bold;
        text-shadow: 0 0 8px #08f0ff;
        letter-spacing: 1px;
      }
      .navbar-sci-fi .nav-btn {
        background: linear-gradient(90deg, #00ffd0, #0040ff);
        color: #fff !important;
        border-radius: 10px;
        font-weight: 500;
        font-size: 17px;
        margin-right: 24px;
        margin-top: 8px;
        padding: 10px 32px;
        border: none;
        box-shadow: 0 0 16px 3px #00fff9bb;
        text-shadow: 0 0 6px #00fff9;
        transition: box-shadow 0.18s, background 0.22s, color 0.22s;
        display: inline-block;
        text-decoration: none !important;
      }
      .navbar-sci-fi .nav-btn:last-child {
        margin-right: 0;
      }
      .navbar-sci-fi .nav-btn:hover,
      .navbar-sci-fi .nav-btn.active {
        background: linear-gradient(90deg, #00fff9 20%, #0040ff 80%);
        box-shadow: 0 0 22px 7px #00fdffcc;
        color: #fff !important;
        text-shadow: 0 0 16px #00fff9, 0 0 9px #191b2a;
      }
      .edit-btn, .delete-btn {
        width: 90px;
        height: 36px;
        font-size: 14px;
        border: none;
        border-radius: 8px;
        color: #fff !important;
        cursor: pointer;
        margin: 2px auto;
        text-align: center;
        font-weight: bold;
        display: inline-block;
        text-decoration: none !important;
        letter-spacing: 1px;
        box-shadow: 0 0 12px 2px #00fff9aa;
        transition: box-shadow 0.15s, background 0.15s;
        vertical-align: middle;
        line-height: 36px; /* IMPORTANT for perfect vertical centering */
        padding: 0;        /* Remove padding so line-height works */
      }
      .edit-btn {
        background: linear-gradient(90deg, #28a745, #218838);
        text-shadow: 0 0 7px #fff2;
      }
      .edit-btn:hover {
        box-shadow: 0 0 16px 5px #28a745cc;
        background: linear-gradient(90deg, #34d058, #207f3b);
        color: #fff !important;
      }
      .delete-btn {
        background: linear-gradient(90deg, #ff3b3b, #960909);
        text-shadow: 0 0 7px #fff2;
        box-shadow: 0 0 13px 3px #ff3b3b88;
      }
      .delete-btn:hover {
        box-shadow: 0 0 19px 8px #ff3b3bdd;
        background: linear-gradient(90deg, #ff5151, #b50101);
        color: #fff !important;
      }
      /* Center Edit and Delete columns content */
      .transactions-table th:nth-child(6),
      .transactions-table th:nth-child(7),
      .transactions-table td:nth-child(6),
      .transactions-table td:nth-child(7) {
        text-align: center;
        vertical-align: middle;
      }
    </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-sci-fi">
    <div class="container-fluid">
      <a class="navbar-brand" href="DashboardServlet">Personal Finance</a>
      <div class="d-flex" style="margin-left:auto;">
        <a class="nav-btn" href="DashboardServlet">Dashboard</a>
        <a class="nav-btn active" href="TransactionServlet">Transactions</a>
        <a class="nav-btn" href="ReportServlet">Reports</a>
      </div>
    </div>
  </nav>

  <div class="background"></div>
  <div class="grid-lines"></div>
  <div class="glow-circles">
    <div></div>
    <div></div>
    <div></div>
  </div>
  <div class="transactions-panel">
    <h2>Your Transactions</h2>
    <form action="TransactionServlet" method="post" class="transactions-form">
        <select name="type" required>
            <option value="income">Income</option>
            <option value="expense">Expense</option>
        </select>
        <input type="number" name="amount" placeholder="Amount" required>
        <input type="text" name="description" placeholder="Description">
        <select name="category_id" required>
            <%
              List<com.finance.model.Category> categories = (List<com.finance.model.Category>) request.getAttribute("categories");
              if(categories != null){
                for(com.finance.model.Category cat : categories){
                  out.println("<option value='"+cat.getId()+"'>"+cat.getName()+"</option>");
                }
              }
            %>
        </select>
        <input type="date" name="date" required>
        <button type="submit">Add Transaction</button>
    </form>
    <table class="transactions-table">
        <thead>
          <tr>
            <th>Type</th><th>Amount</th><th>Category</th><th>Date</th><th>Description</th><th>Edit</th><th>Delete</th>
          </tr>
        </thead>
        <tbody>
          <%
            List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
            if (transactions != null) {
              for (Transaction t : transactions) {
                  out.println("<tr>");
                  out.println("<td>" + t.getType() + "</td>");
                  out.println("<td>" + t.getAmount() + "</td>");
                  out.println("<td>" + t.getCategoryId() + "</td>");
                  out.println("<td>" + t.getDate() + "</td>");
                  out.println("<td>" + t.getDescription() + "</td>");
                  out.println("<td><a href='TransactionServlet?action=edit&id=" + t.getId() + "' class=\"edit-btn\">EDIT</a></td>");
                  out.println("<td><a href='TransactionServlet?action=delete&id=" + t.getId() + "' class=\"delete-btn\">DELETE</a></td>");
                  out.println("</tr>");
              }
            }
          %>
        </tbody>
    </table>
    <p style="color:#ff3d7f;"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
  </div>
</body>
</html>
