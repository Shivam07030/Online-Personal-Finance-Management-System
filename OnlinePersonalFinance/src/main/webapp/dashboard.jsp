<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dashboard</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/style.css">
  <style>
    .navbar-sci-fi {
      background: rgba(12, 24, 32, 0.97);
      box-shadow: 0 0 24px 3px #00fff9;
      border-bottom: 1px solid #08f0ff44;
      padding: 0 0 7px 0;
    }
    .navbar-sci-fi .navbar-brand {
      color: #08f0ff;
      font-weight: bold;
      text-shadow: 0 0 8px #08f0ff;
      letter-spacing: 1px;
    }
    .navbar-sci-fi .nav-btn {
      background: linear-gradient(90deg, #00ffd0 40%, #0040ff 100%);
      color: #fff !important;
      border-radius: 8px;
      font-weight: 500;
      font-size: 17px;
      margin-right: 18px;
      margin-top: 9px;
      margin-bottom: 4px;
      padding: 8px 28px;
      border: none;
      box-shadow: 0 0 13px 3px #00fff9bb;
      text-shadow: 0 0 6px #00fff9;
      transition: box-shadow 0.2s, background 0.2s, color 0.2s;
      display: inline-block;
      text-decoration: none !important;
    }
    .navbar-sci-fi .nav-btn:hover,
    .navbar-sci-fi .nav-btn.active {
      background: linear-gradient(90deg, #00fff9 10%, #0040ff 90%);
      box-shadow: 0 0 24px 6px #00fdffcc;
      color: #fff !important;
      text-shadow: 0 0 16px #00fff9, 0 0 9px #191b2a;
    }
    .back-btn {
      background: linear-gradient(90deg, #00ffd0 40%, #0040ff 100%);
      color: #fff !important;
      border-radius: 8px;
      font-weight: 600;
      font-size: 17px;
      margin: 44px auto 0 auto;
      padding: 11px 41px;
      border: none;
      box-shadow: 0 0 20px 6px #00fff9ab;
      text-shadow: 0 0 7px #00fff9;
      display: block;
      width: fit-content;
      transition: background 0.18s, box-shadow 0.18s, color 0.18s;
      text-align: center;
      text-decoration: none !important;
    }
    .back-btn:hover {
      background: linear-gradient(90deg, #00fff9 10%, #0040ff 90%);
      box-shadow: 0 0 36px 11px #00fdffda;
      color: #fff;
      text-shadow: 0 0 23px #00fff9, 0 0 12px #191b2a;
    }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-sci-fi">
    <div class="container-fluid">
      <a class="navbar-brand" href="DashboardServlet">Personal Finance</a>
      <div class="d-flex" style="margin-left:auto;">
        <a class="nav-btn active" href="DashboardServlet">Dashboard</a>
        <a class="nav-btn" href="TransactionServlet">Transactions</a>
        <a class="nav-btn" href="ReportServlet">Reports</a>
      </div>
    </div>
  </nav>

  <!-- Neon Sci-Fi Background -->
  <div class="background"></div>
  <div class="grid-lines"></div>
  <div class="glow-circles">
    <div></div>
    <div></div>
    <div></div>
  </div>

  <div class="dashboard-panel">
    <h2>Dashboard</h2>
    <div class="dashboard-stats">
      <p>Total Income: <%= request.getAttribute("income") %></p>
      <p>Total Expenses: <%= request.getAttribute("expense") %></p>
      <p>Balance: <%= request.getAttribute("balance") %></p>
    </div>
    <div style="max-width:400px; margin: 0 auto;">
      <canvas id="pieChart"></canvas>
    </div>
    <script src="js/chart.min.js"></script>
    <script>
      var ctx = document.getElementById('pieChart').getContext('2d');
      var pieChart = new Chart(ctx, {
        type: 'pie',
        data: {
          labels: ['Income', 'Expenses'],
          datasets: [{
            data: [
              <%= request.getAttribute("income") == null ? 0 : request.getAttribute("income") %>,
              <%= request.getAttribute("expense") == null ? 0 : request.getAttribute("expense") %>
            ],
            backgroundColor: ['#08F0FF', '#FF4388']
          }]
        },
        options: {
          plugins: {
            legend: {
              labels: { color: "#b2edfd", font: { size: 15 } }
            }
          }
        }
      });
    </script>
    <!-- Back To Login BUTTON INSIDE PANEL! -->
    <a class="back-btn" href="login.jsp">Back To Login</a>
  </div>
</body>
</html>
