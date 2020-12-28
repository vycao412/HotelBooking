/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.CouponDAO;
import sample.dtos.CouponDTO;

/**
 *
 * @author VYCAO
 */
public class CreateCouponController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(CreateCouponController.class);

    private static final String SUCCESS = "homepage.jsp";
    private static final String ERROR = "createCoupon.jsp";
    
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
        
        LOG.info("CreateCouponController");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            String code = request.getParameter("code");
            String name = request.getParameter("name");
            String value_Str = request.getParameter("value");
            int value = Integer.parseInt(value_Str);
            String expiredDate_Str = request.getParameter("expiredDate");
            Date expiredDate = Date.valueOf(expiredDate_Str);
            
            boolean check = true;
            CouponDAO dao = new CouponDAO();
            if (dao.search(code)) {
                session.setAttribute("DUPLICATE_COUPON", "Coupon ID have already existed!");
                check = false;
            }
            
            if (check) {
                CouponDTO dto = new CouponDTO(code, name, value, expiredDate);
                dao.create(dto);
                url = SUCCESS;
            }
            else {
                session.setAttribute("DISCOUNT_FAIL", "Can not create coupon!");
            }

        } catch (Exception e) {
            LOG.error("Error at CreateCouponController: " + e.toString());
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
