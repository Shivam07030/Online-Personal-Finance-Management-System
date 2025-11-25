<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Neon Sci-Fi Login</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    .login-panel form button,
    .login-panel .register-btn {
      padding: 10px 32px;
      border-radius: 8px;
      background: linear-gradient(90deg, #00ffd0, #0040ff);
      color: #fff;
      font-size: 18px;
      font-weight: 600;
      box-shadow: 0 0 16px 3px #00fff9bb;
      border: none;
      margin-bottom: 14px;
      margin-top: 14px;
      text-shadow: 0 0 7px #00fff9;
      cursor: pointer;
      display: inline-block;
      text-align: center;
      text-decoration: none !important;
      transition: box-shadow 0.18s, background 0.22s, color 0.22s;
    }
    .login-panel .register-btn:hover,
    .login-panel form button:hover {
      background: linear-gradient(90deg, #00fff9 10%, #0040ff 90%);
      box-shadow: 0 0 26px 8px #00fdffcc;
      color: #fff;
      text-shadow: 0 0 20px #00fff9, 0 0 12px #191b2a;
    }
    .login-panel form input[type="text"],
    .login-panel form input[type="password"] {
      width: 75%;
      min-width: 120px;
      margin-bottom: 10px;
      border-radius: 8px;
      border: none;
      background: #262648;
      color: #a0f0ff;
      font-size: 15px;
      padding: 10px 14px;
      box-shadow: 0 0 10px 2px #00fff988;
      outline: none;
    }
    .login-panel{
      text-align: center;
    }
  </style>
</head>
<body>
  <!-- Neon Sci-Fi Animated Background -->
  <div class="background"></div>
  <div class="grid-lines"></div>
  <div class="glow-circles">
    <div></div>
    <div></div>
    <div></div>
  </div>

  <!-- Futuristic Login Panel -->
  <div class="login-panel">
    <h2>Login</h2>
    <form action="LoginServlet" method="post">
      <input type="text" name="username" placeholder="Username" required><br>
      <input type="password" name="password" placeholder="Password" required><br>
      <button type="submit">Login</button>
    </form>
    <a class="register-btn" href="register.jsp">Register</a>
    <%
      String error = (String)request.getAttribute("error");
      if (error != null) {
    %>
      <div style="color:#ff3c6d;margin-top:15px;"><%= error %></div>
    <%
      }
    %>
  </div>
</body>
</html>
