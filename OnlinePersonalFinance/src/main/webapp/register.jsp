<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
      body, html {
        background: #181b2a;
        height: 100%;
        margin: 0;
        font-family: 'Orbitron', 'Audiowide', 'Arial', sans-serif;
        overflow-x: hidden;
      }
      .register-panel {
        background: rgba(12, 24, 32, 0.96);
        border-radius: 22px;
        box-shadow: 0 0 40px 6px #56fff8, 0 0 10px 3px #008cff;
        max-width: 520px;
        margin: 120px auto 0 auto;
        padding: 40px 32px 28px 32px;
        text-align: center;
        position: relative;
        z-index: 10;
      }
      .register-title {
        color: #fff;
        font-size: 32px;
        font-weight: bold;
        text-shadow: 0 0 21px #08f0ff, 0 0 4px #fff;
        margin-bottom: 32px;
        letter-spacing: 2px;
      }
      .neon-input {
        background: #182634;
        color: #08f0ff;
        border: 2px solid #08f0ff99;
        border-radius: 9px;
        padding: 9px 14px;
        font-size: 16px;
        font-weight: 500;
        margin: 0 12px 18px 0;
        box-shadow: 0 0 14px 2px #08f0ff33;
        outline: none;
        transition: box-shadow 0.18s, border 0.18s, color 0.18s;
        width: 140px;
        display: inline-block;
      }
      .neon-input:focus {
        box-shadow: 0 0 19px 7px #08f0ffcc;
        border: 2px solid #08f0ff;
        color: #fff;
      }
      .neon-btn {
        background: linear-gradient(90deg, #00ffd0, #0040ff);
        color: #fff !important;
        border-radius: 11px;
        font-weight: 600;
        font-size: 18px;
        padding: 9px 34px;
        border: none;
        box-shadow: 0 0 18px 3px #00fff9b2;
        text-shadow: 0 0 6px #00fff9, 0 0 2px #218838;
        transition: box-shadow 0.18s, background 0.22s, color 0.22s;
        cursor: pointer;
        text-decoration: none !important;
        margin-left: 8px;
        margin-bottom: 15px;
        display: inline-block;
      }
      .neon-btn:hover {
        background: linear-gradient(90deg, #00fff9 20%, #0040ff 80%);
        box-shadow: 0 0 25px 8px #00fdffcc;
        color: #fff !important;
      }
      .back-link-btn {
        background: linear-gradient(90deg, #00ffd0, #0040ff);
        color: #fff !important;
        border-radius: 11px;
        font-weight: 600;
        font-size: 17px;
        padding: 8px 24px;
        border: none;
        box-shadow: 0 0 18px 3px #00fff9b2;
        text-shadow: 0 0 6px #00fff9, 0 0 2px #218838;
        transition: box-shadow 0.18s, background 0.22s, color 0.22s;
        cursor: pointer;
        text-decoration: none !important;
        margin-top: 20px;
        display: inline-block;
      }
      .back-link-btn:hover {
        background: linear-gradient(90deg, #00fff9 20%, #0040ff 80%);
        box-shadow: 0 0 19px 7px #00fdffcc;
        color: #fff !important;
      }
    </style>
</head>
<body>
  <div class="background"></div>
  <div class="grid-lines"></div>
  <div class="glow-circles">
    <div></div><div></div><div></div>
  </div>
  <div class="register-panel">
    <div class="register-title">Register</div>
    <form action="RegisterServlet" method="post" autocomplete="off">
      <input type="text" name="username" class="neon-input" placeholder="Username" required>
      <input type="password" name="password" class="neon-input" placeholder="Password" required>
      <div>
        <input type="email" name="email" class="neon-input" placeholder="Email" required>
        <button type="submit" class="neon-btn">Register</button>
      </div>
    </form>
    <a href="login.jsp" class="back-link-btn">Back to login</a>
    <p style="color:red;"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></p>
  </div>
</body>
</html>
