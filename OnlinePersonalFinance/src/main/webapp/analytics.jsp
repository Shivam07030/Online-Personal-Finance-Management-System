<%@ page language="java" %>
<html>
<head>
    <title>Analytics</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>Expense Analytics</h2>
    <p>
      <%= request.getAttribute("analyticsMessage") != null ? request.getAttribute("analyticsMessage") : "" %>
    </p>
    <canvas id="analyticsChart"></canvas>
    <script src="js/chart.min.js"></script>
    <script>
    // Placeholder Chart.js logic for trend (replace with dynamic data)
    var ctx = document.getElementById('analyticsChart').getContext('2d');
    var chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Jan', 'Feb', 'Mar'],
        datasets: [{
          label: 'Expenses',
          data: [200, 170, 210],
          backgroundColor: '#FF6384'
        }]
      }
    });
    </script>
    <p style="color:red;"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
</div>
</body>
</html>
