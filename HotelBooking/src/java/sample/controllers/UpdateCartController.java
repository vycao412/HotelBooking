/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.daos.RoomDAO;
import sample.dtos.CartDTO;

/**
 *
 * @author VYCAO
 */
public class UpdateCartController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(UpdateCartController.class);

    private static final String SUCCESS = "cart.jsp";
    private static final String ERROR = "error.jsp";
    
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
        
        LOG.info("UpdateCartController");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            String quantity_Str = request.getParameter("txtQuantity");
            int quantity = Integer.parseInt(quantity_Str);
            String roomID = request.getParameter("txtRoomID");
            CartDTO dto = (CartDTO) session.getAttribute("CART");
            
            if (dto == null) {
                dto = new CartDTO();
            }
            dto.update(roomID, quantity);
            RoomDAO roomDao = new RoomDAO();
            List<String> message = roomDao.checkValid(dto);
            if (message != null) {
                session.setAttribute("MESSAGE_QUAN", message);
            }
            url = SUCCESS;

        } catch (Exception e) {
            LOG.error("Error at UpdateCartController: " + e.toString());
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
