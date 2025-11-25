package com.finance.servlet;
import com.finance.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class CategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String name = req.getParameter("name");
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO categories (name) VALUES (?)");
            ps.setString(1, name);
            ps.executeUpdate();
            res.sendRedirect("categories.jsp");
        } catch (SQLException e) {
            req.setAttribute("error", "Category error.");
            req.getRequestDispatcher("categories.jsp").forward(req, res);
        }
    }
}

