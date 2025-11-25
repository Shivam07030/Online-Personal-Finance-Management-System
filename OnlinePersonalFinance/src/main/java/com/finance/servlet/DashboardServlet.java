package com.finance.servlet;

import com.finance.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        if(userId == null) {
            res.sendRedirect("login.jsp");
            return;
        }
        double income = 0.0, expense = 0.0;
        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement psIncome = con.prepareStatement(
                "SELECT SUM(amount) FROM transactions WHERE user_id=? AND type='income'");
            psIncome.setInt(1, userId);
            ResultSet rsIncome = psIncome.executeQuery();
            if(rsIncome.next()) income = rsIncome.getDouble(1);

            PreparedStatement psExpense = con.prepareStatement(
                "SELECT SUM(amount) FROM transactions WHERE user_id=? AND type='expense'");
            psExpense.setInt(1, userId);
            ResultSet rsExpense = psExpense.executeQuery();
            if(rsExpense.next()) expense = rsExpense.getDouble(1);
        } catch(Exception e) {
            req.setAttribute("error", "Database Error");
        }
        double balance = income - expense;
        req.setAttribute("income", income);
        req.setAttribute("expense", expense);
        req.setAttribute("balance", balance);
        req.getRequestDispatcher("dashboard.jsp").forward(req, res);
    }
}
