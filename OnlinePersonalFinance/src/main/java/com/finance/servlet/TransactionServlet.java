package com.finance.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class TransactionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        int userId = (int) req.getSession().getAttribute("userId");

        // Handle delete action
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            try (Connection con = com.finance.util.DBUtil.getConnection()) {
                PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM transactions WHERE id=? AND user_id=?");
                ps.setInt(1, id);
                ps.setInt(2, userId);
                ps.executeUpdate();
            } catch (SQLException e) {
                req.setAttribute("error", "Failed to delete transaction.");
            }
            // Do not return here, still show updated table
        }

        List<com.finance.model.Category> categories = new ArrayList<>();
        List<com.finance.model.Transaction> transactions = new ArrayList<>();
        try (Connection con = com.finance.util.DBUtil.getConnection()) {
            // Fetch categories
            PreparedStatement psCat = con.prepareStatement("SELECT id, name FROM categories");
            ResultSet rsCat = psCat.executeQuery();
            while (rsCat.next()) {
                com.finance.model.Category cat = new com.finance.model.Category();
                cat.setId(rsCat.getInt("id"));
                cat.setName(rsCat.getString("name"));
                categories.add(cat);
            }
            // Fetch transactions for current user
            PreparedStatement psTrans = con.prepareStatement(
                "SELECT id, type, amount, description, category_id, date FROM transactions WHERE user_id = ?");
            psTrans.setInt(1, userId);
            ResultSet rsTrans = psTrans.executeQuery();
            while (rsTrans.next()) {
                com.finance.model.Transaction t = new com.finance.model.Transaction();
                t.setId(rsTrans.getInt("id"));
                t.setType(rsTrans.getString("type"));
                t.setAmount(rsTrans.getDouble("amount"));
                t.setDescription(rsTrans.getString("description"));
                t.setCategoryId(rsTrans.getInt("category_id"));
                t.setDate(rsTrans.getDate("date")); // Pass java.sql.Date, not String
                transactions.add(t);
            }
            req.setAttribute("categories", categories);
            req.setAttribute("transactions", transactions);
        } catch (SQLException e) {
            req.setAttribute("error", "Failed to load categories or transactions.");
        }
        req.getRequestDispatcher("transactions.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String type = req.getParameter("type");
        double amount = Double.parseDouble(req.getParameter("amount"));
        String description = req.getParameter("description");
        int categoryId = Integer.parseInt(req.getParameter("category_id"));
        String date = req.getParameter("date");
        int userId = (int) req.getSession().getAttribute("userId");

        try (Connection con = com.finance.util.DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO transactions (user_id, type, amount, description, category_id, date) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setInt(1, userId);
            ps.setString(2, type);
            ps.setDouble(3, amount);
            ps.setString(4, description);
            ps.setInt(5, categoryId);
            ps.setDate(6, java.sql.Date.valueOf(date)); // expects yyyy-MM-dd
            ps.executeUpdate();
        } catch (Exception e) {
            req.setAttribute("error", "Failed to add transaction.");
        }
        // After insert, refresh table
        doGet(req, res);
    }
}
