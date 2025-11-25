package com.finance.servlet;

import com.finance.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class ExportServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int userId = (int) req.getSession().getAttribute("userId");
        String format = req.getParameter("format");

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM transactions WHERE user_id=?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if ("csv".equals(format)) {
                res.setContentType("text/csv");
                res.setHeader("Content-Disposition", "attachment;filename=transactions.csv");
                PrintWriter out = res.getWriter();
                out.println("Date,Type,Amount,Category,Description");
                while (rs.next()) {
                    out.println(rs.getDate("date") + "," +
                                rs.getString("type") + "," +
                                rs.getDouble("amount") + "," +
                                rs.getInt("category_id") + "," +
                                rs.getString("description"));
                }
                out.flush();
            } else if ("pdf".equals(format)) {
                // For beginner PDF export, write plain text as demo
                res.setContentType("application/pdf");
                res.setHeader("Content-Disposition", "attachment;filename=transactions.pdf");
                OutputStream out = res.getOutputStream();
                out.write("Date\tType\tAmount\tCategory\tDescription\n".getBytes());
                while (rs.next()) {
                    String line = rs.getDate("date") + "\t" +
                                  rs.getString("type") + "\t" +
                                  rs.getDouble("amount") + "\t" +
                                  rs.getInt("category_id") + "\t" +
                                  rs.getString("description") + "\n";
                    out.write(line.getBytes());
                }
                out.flush();
            }
        } catch (Exception e) {
            req.setAttribute("error", "Export error");
            req.getRequestDispatcher("export.jsp").forward(req, res);
        }
    }
}

