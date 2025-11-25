package com.finance.servlet;

import com.finance.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int userId = (int) req.getSession().getAttribute("userId");
        String range = req.getParameter("range");
        Map<String, Double> income = new LinkedHashMap<>();
        Map<String, Double> expense = new LinkedHashMap<>();
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps;
            if ("weekly".equals(range)) {
                ps = con.prepareStatement(
                    "SELECT WEEK(date) as period, SUM(CASE WHEN type='income' THEN amount ELSE 0 END) as income, SUM(CASE WHEN type='expense' THEN amount ELSE 0 END) as expense FROM transactions WHERE user_id=? GROUP BY WEEK(date)");
            } else {
                ps = con.prepareStatement(
                    "SELECT MONTH(date) as period, SUM(CASE WHEN type='income' THEN amount ELSE 0 END) as income, SUM(CASE WHEN type='expense' THEN amount ELSE 0 END) as expense FROM transactions WHERE user_id=? GROUP BY MONTH(date)");
            }
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String period = rs.getString("period");
                income.put(period, rs.getDouble("income"));
                expense.put(period, rs.getDouble("expense"));
            }
            req.setAttribute("incomeData", income);
            req.setAttribute("expenseData", expense);
            req.getRequestDispatcher("reports.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Report error");
            req.getRequestDispatcher("reports.jsp").forward(req, res);
        }
    }
}

