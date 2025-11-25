package com.finance.servlet;

import com.finance.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement checkUser = con.prepareStatement("SELECT * FROM users WHERE username = ?");
            checkUser.setString(1, username);
            ResultSet rs = checkUser.executeQuery();
            if (rs.next()) {
                req.setAttribute("error", "Username already exists.");
                req.getRequestDispatcher("register.jsp").forward(req, res);
                return;
            }

            PreparedStatement ps = con.prepareStatement("INSERT INTO users (username, password, email) VALUES (?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, password); // In production, hash your password!
            ps.setString(3, email);
            ps.executeUpdate();

            res.sendRedirect("login.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error.");
            req.getRequestDispatcher("register.jsp").forward(req, res);
        }
    }
}

