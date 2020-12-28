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
import sample.daos.HotelDAO;
import sample.dtos.HotelDTO;

/**
 *
 * @author VYCAO
 */
public class SearchController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(SearchController.class);

    private static final String SUCCESS = "search.jsp";
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
        
        LOG.info("SearchController");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            String nameOrArea = request.getParameter("txtNameOrArea");
            String dateFrom_Str = request.getParameter("txtDateFrom");
            Date dateFrom = Date.valueOf(dateFrom_Str);
            String dateTo_Str = request.getParameter("txtDateTo");
            Date dateTo = Date.valueOf(dateTo_Str);
            String numRoom_Str = request.getParameter("txtRooms");
            int numRoom = Integer.parseInt(numRoom_Str);
            
            HotelDAO hotelDao = new HotelDAO();
            List<HotelDTO> listHotel = hotelDao.getListSearch(nameOrArea, dateFrom, numRoom);
            
            if (listHotel != null) {
                session.setAttribute("SEARCH_HOTEL", listHotel);
            }
            else {
                session.setAttribute("SEARCH_HOTEL_EMPTY", "There is no hotel!");
            }
            
            url = SUCCESS;

        } catch (Exception e) {
            LOG.error("Error at SearchController: " + e.toString());
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
