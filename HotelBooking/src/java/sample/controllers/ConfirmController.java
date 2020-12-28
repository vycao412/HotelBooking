/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.sql.Date;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.dtos.CartDTO;

/**
 *
 * @author VYCAO
 */
public class ConfirmController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(ConfirmController.class);

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

        LOG.info("ConfirmController");
        String url = ERROR;

        try {
            String btnAction = request.getParameter("btnAction");
            if (btnAction.equals("Update")) {
                request.getRequestDispatcher("UpdateCartController").forward(request, response);
            } 
            if (btnAction.equals("Confirm")) {
                HttpSession session = request.getSession();
                String dateFrom_Str = request.getParameter("txtDateFrom");
                Date dateFrom = Date.valueOf(dateFrom_Str);
                String dateTo_Str = request.getParameter("txtDateTo");
                Date dateTo = Date.valueOf(dateTo_Str);
                CartDTO dto = (CartDTO) session.getAttribute("CART");

                if (dateFrom.before(dateTo)) {
                    float gap = ChronoUnit.DAYS.between(dateFrom.toLocalDate(), dateTo.toLocalDate());
                    dto.setArriveDate(dateFrom);
                    dto.setReturnDate(dateTo);

                    session.setAttribute("DATE_FROM", dateFrom);
                    session.setAttribute("DATE_TO", dateTo);
                    session.setAttribute("GAP", gap);
                    
                    dto.setTotal(dto.getTotal() * gap);
                    dto.setFinalTotal(dto.getTotal());
                    
//                    RoomDAO roomDao = new RoomDAO();
//                    List<String> message = roomDao.checkValid(dto);
//                    if (message.size() == 0 || message == null) {
//                        url = SUCCESS;
//                    }
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at ConfirmController: " + e.toString());
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
