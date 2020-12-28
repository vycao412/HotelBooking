/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import sample.dtos.CartDTO;
import sample.dtos.RoomDTO;

/**
 *
 * @author VYCAO
 */
public class AddToCartController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(AddToCartController.class);

    private static final String SUCCESS = "HomePageController";
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
        
        LOG.info("AddToCartController");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            String numRoom_Str = request.getParameter("txtQuan");
            int numRoom = Integer.parseInt(numRoom_Str);
            String category_Str = request.getParameter("roomType");
            int category = Integer.parseInt(category_Str);
            
            List<RoomDTO> listRoom = (List<RoomDTO>) session.getAttribute("LIST_ROOM");
            RoomDTO room = listRoom.get(category);
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            if (cart == null) {
                cart = new CartDTO();
            }
            cart.add(room, numRoom);
            session.setAttribute("CART", cart);
            
            long currenTime = System.currentTimeMillis();
            Date dateFrom = new Date(currenTime);
            Date dateTo = new Date(currenTime + 24*60*60*1000);
            
            session.setAttribute("DATE_FROM", dateFrom);
            session.setAttribute("DATE_TO", dateTo);
            
            url = SUCCESS;

        } catch (Exception e) {
            LOG.error("Error at AddToCartController: " + e.toString());
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
