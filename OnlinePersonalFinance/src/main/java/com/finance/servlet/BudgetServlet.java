package com.finance.servlet;

import com.finance.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class BudgetServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int userId = (int) req.getSession().getAttribute("userId");
        double budget = Double.parseDouble(req.getParameter("budget"));
        int year = java.time.LocalDate.now().getYear();
        try (Connection con = DBUtil.getConnection()) {
            // Upsert budget
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO budgets (user_id, month, amount) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE amount=?");
            ps.setInt(1, userId);
            ps.setInt(2, year);
            ps.setDouble(3, budget);
            ps.setDouble(4, budget);
            ps.executeUpdate();
            req.setAttribute("message", "Budget saved.");
            req.getRequestDispatcher("budget.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Database error");
            req.getRequestDispatcher("budget.jsp").forward(req, res);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int userId = (int) req.getSession().getAttribute("userId");
        int year = java.time.LocalDate.now().getYear();
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement getBudget = con.prepareStatement("SELECT amount FROM budgets WHERE user_id=? AND month=?");
            getBudget.setInt(1, userId);
            getBudget.setInt(2, year);
            ResultSet rsBudget = getBudget.executeQuery();

            double budget = rsBudget.next() ? rsBudget.getDouble("amount") : 0.0;
            req.setAttribute("budget", budget);

            PreparedStatement getExpenses = con.prepareStatement(
                "SELECT SUM(amount) FROM transactions WHERE user_id=? AND type='expense' AND YEAR(date)=?");
            getExpenses.setInt(1, userId);
            getExpenses.setInt(2, year);
            ResultSet rsExp = getExpenses.executeQuery();
            double expenses = rsExp.next() ? rsExp.getDouble(1) : 0.0;

            if (budget > 0 && expenses > 0.8 * budget) {
                req.setAttribute("alert", "Warning: You have exceeded 80% of your monthly budget!");
            }
            req.getRequestDispatcher("budget.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Error loading budget.");
            req.getRequestDispatcher("budget.jsp").forward(req, res);
        }
    }
}

