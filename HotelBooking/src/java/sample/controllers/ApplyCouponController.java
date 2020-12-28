/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.text.DecimalFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.CouponDAO;
import sample.dtos.CartDTO;
import sample.dtos.CouponDTO;

/**
 *
 * @author VYCAO
 */
public class ApplyCouponController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(CheckoutController.class);

    private static final String SUCCESS = "confirm.jsp";
    private static final String ERROR = "cart.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        LOG.info("CheckoutController");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            String coupon = request.getParameter("txtCouponCode");
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            CouponDAO dao = new CouponDAO();
            CouponDTO dto = dao.checkValid(coupon);

            if (dto != null) {
                cart.setDiscountID(coupon);
                float finalTotal = cart.getTotal() * (1 - (float) dto.getValue()/ 100);
                cart.setFinalTotal(Float.parseFloat(new DecimalFormat("#########.##").format(finalTotal)));
            } else {
                session.setAttribute("DISCOUNT_FAIL", "Discount code is incorrect or expiry!");
            }

            url = SUCCESS;
        } catch (Exception e) {
            LOG.error("Error at CheckoutController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
