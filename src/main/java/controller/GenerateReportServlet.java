package controller;

import service.SalesReportService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet to generate the sales report.
 */
@WebServlet({"/admin/generate_report"})
public class GenerateReportServlet extends HttpServlet {

    private final SalesReportService salesReportService = new SalesReportService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // generate the latest sales report
        salesReportService.generateSalesReport();

        // redirect to the admin home page.
        String url = req.getContextPath() + "/admin/index.jsp?info=Generated report successfully!";
        resp.sendRedirect(url);
    }
}
