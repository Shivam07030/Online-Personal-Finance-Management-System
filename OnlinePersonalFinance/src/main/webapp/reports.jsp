<%@ page import="java.util.Map" %>
<html>
<head>
    <title>Reports</title>
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
      .reports-panel {
        background: rgba(12, 24, 32, 0.95);
        border-radius: 22px;
        box-shadow: 0 0 40px 6px #56fff8, 0 0 10px 3px #008cff;
        padding: 38px 28px 48px 28px;
        max-width: 600px;
        margin: 120px auto 0 auto;
        text-align: center;
        z-index: 50;
        position: relative;
      }
      body, html {
        height: 100%;
        margin: 0;
        overflow-x: hidden;
        background: #181b2a;
        font-family: 'Orbitron', 'Audiowide', 'Arial', sans-serif;
      }
      /* Neon form styles for dropdown and button */
      .report-form {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 32px;
        gap: 16px;
      }
      .neon-select {
        background: #222c38;
        color: #08f0ff;
        border: 2px solid #08f0ff99;
        border-radius: 8px;
        padding: 8px 22px;
        font-size: 16px;
        font-weight: 500;
        box-shadow: 0 0 14px 3px #08f0ff33;
        outline: none;
        transition: box-shadow 0.18s, border 0.18s, color 0.18s;
        letter-spacing: 1px;
      }
      .neon-select:focus {
        box-shadow: 0 0 16px 6px #08f0ffcc;
        border: 2px solid #08f0ff;
        color: #fff;
      }
      .neon-btn {
        background: linear-gradient(90deg, #00ffd0, #0040ff);
        color: #fff !important;
        border-radius: 10px;
        font-weight: 500;
        font-size: 17px;
        padding: 10px 32px;
        border: none;
        box-shadow: 0 0 16px 3px #00fff9bb;
        text-shadow: 0 0 6px #00fff9;
        transition: box-shadow 0.18s, background 0.22s, color 0.22s;
        cursor: pointer;
        text-decoration: none !important;
      }
      .neon-btn:hover {
        background: linear-gradient(90deg, #00fff9 20%, #0040ff 80%);
        box-shadow: 0 0 22px 7px #00fdffcc;
        color: #fff !important;
        text-shadow: 0 0 16px #00fff9, 0 0 9px #191b2a;
      }
    </style>
</head>
<body>
  <!-- Neon Navbar -->
  <nav class="navbar navbar-expand-lg navbar-sci-fi">
    <div class="container-fluid">
      <a class="navbar-brand" href="DashboardServlet">Personal Finance</a>
      <div class="d-flex" style="margin-left:auto;">
        <a class="nav-btn" href="DashboardServlet">Dashboard</a>
        <a class="nav-btn" href="TransactionServlet">Transactions</a>
        <a class="nav-btn active" href="ReportServlet">Reports</a>
      </div>
    </div>
  </nav>
  <!-- Neon Background --> 
  <div class="background"></div>
  <div class="grid-lines"></div>
  <div class="glow-circles">
    <div></div>
    <div></div>
    <div></div>
  </div>

  <div class="container reports-panel">
    <h2>Financial Reports</h2>
    <div class="report-form">
      <form method="get" action="ReportServlet" style="display: flex; align-items: center; gap: 12px;">
        <select name="range" class="neon-select" required>
          <option value="monthly">Monthly</option>
          <option value="weekly">Weekly</option>
        </select>
        <button type="submit" class="neon-btn">Generate Report</button>
      </form>
    </div>
    <canvas id="reportChart" class="mt-4"></canvas>
    <script src="js/chart.min.js"></script>
    <script>
      var ctx = document.getElementById('reportChart').getContext('2d');
      var labels = [];
      var incomeData = [];
      var expenseData = [];
      <% 
        Map<String, Double> incomeDataMap = (Map<String,Double>)request.getAttribute("incomeData");
        Map<String, Double> expenseDataMap = (Map<String,Double>)request.getAttribute("expenseData");
        if (incomeDataMap != null) {
            for (String key : incomeDataMap.keySet()) {
                out.println("labels.push('"+key+"');");
                out.println("incomeData.push("+incomeDataMap.get(key)+");");
            }
        }
        if (expenseDataMap != null) {
            for (Double val : expenseDataMap.values()) {
                out.println("expenseData.push("+val+");");
            }
        }
      %>
      var chart = new Chart(ctx, {
        type: 'line',
        data: {
          labels: labels,
          datasets: [
            { label: 'Income', data: incomeData, borderColor:'#36A2EB', fill:false },
            { label: 'Expense', data: expenseData, borderColor:'#FF6384', fill:false }
          ]
        }
      });
    </script>
    <p style="color:red;"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
  </div>
</body>
</html>
