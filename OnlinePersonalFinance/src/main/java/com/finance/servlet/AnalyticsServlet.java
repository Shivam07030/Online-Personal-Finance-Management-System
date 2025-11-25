package com.finance.servlet;

import com.finance.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

public class AnalyticsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int userId = (int) req.getSession().getAttribute("userId");
        LocalDate now = LocalDate.now();
        int year = now.getYear();
        int month = now.getMonthValue();

        try (Connection con = DBUtil.getConnection()) {
            // This month's expenses
            PreparedStatement psCurrent = con.prepareStatement(
                "SELECT SUM(amount) FROM transactions WHERE user_id=? AND type='expense' AND YEAR(date)=? AND MONTH(date)=?");
            psCurrent.setInt(1, userId);
            psCurrent.setInt(2, year);
            psCurrent.setInt(3, month);
            ResultSet rsCurrent = psCurrent.executeQuery();
            double expensesCurrent = rsCurrent.next() ? rsCurrent.getDouble(1) : 0.0;

            // Last month's expenses
            int lastMonth = (month > 1) ? (month - 1) : 12;
            int lastYear = (month > 1) ? year : year - 1;
            PreparedStatement psLast = con.prepareStatement(
                "SELECT SUM(amount) FROM transactions WHERE user_id=? AND type='expense' AND YEAR(date)=? AND MONTH(date)=?");
            psLast.setInt(1, userId);
            psLast.setInt(2, lastYear);
            psLast.setInt(3, lastMonth);
            ResultSet rsLast = psLast.executeQuery();
            double expensesLast = rsLast.next() ? rsLast.getDouble(1) : 0.0;

            String message;
            if (expensesLast > 0) {
                double percent = ((expensesCurrent - expensesLast) / expensesLast) * 100;
                message = "Your expenses " + (percent > 0 ? "increased" : "decreased") +
                          " " + String.format("%.2f", Math.abs(percent)) +
                          "% this month compared to last month.";
            } else {
                message = "No expenses recorded last month for comparison.";
            }
            req.setAttribute("analyticsMessage", message);
            req.getRequestDispatcher("analytics.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("error", "Analytics error");
            req.getRequestDispatcher("analytics.jsp").forward(req, res);
        }
    }
}

