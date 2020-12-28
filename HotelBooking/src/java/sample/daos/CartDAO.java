/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.apache.log4j.Logger;
import sample.dtos.CartDTO;
import sample.dtos.RoomDTO;
import sample.dtos.UserDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class CartDAO implements Serializable {

    private static final Logger LOG = Logger.getLogger(CartDAO.class);

    public boolean create(UserDTO user, CartDTO cart) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        boolean result = false;

        LOG.info("create of CartDAO");

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "INSERT INTO tblBookings(bUserID, bDateFrom, bDateTo, bTotal, bCouponID, bFinalTotal, bStatus) VALUES(?,?,?,?,?,?,3)";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, user.getUserID());
                stm.setDate(2, cart.getArriveDate());
                stm.setDate(3, cart.getReturnDate());
                stm.setFloat(4, cart.getTotal());
                stm.setString(5, cart.getDiscountID());
                stm.setFloat(6, cart.getFinalTotal());

                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at create of CartDAO: " + e.toString());
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return result;
    }
    
    public boolean createDetail(CartDTO cart) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean result = false;
        
        LOG.info("createDetail of CartDAO");
        
        try {
            conn = DBUtils.getConnection();
            
            if (conn != null) {
                for (RoomDTO room : cart.getCart().values()) {
                    String sql = "INSERT INTO tblBookingDetails(bdBookingID,bRoomType,bdQuantity,bdPrice) VALUES (?,?,?,?)";
                    stm = conn.prepareStatement(sql);
                    stm.setString(1, cart.getId());
                    stm.setString(2, room.getRoomID());
                    stm.setInt(3, room.getQuantity());
                    stm.setFloat(4, room.getPrice());
                    
                    int i = stm.executeUpdate();
                    if (i > 0) {
                        result = true;
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Error at createDetail of CartDAO: " + e.toString());
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public String getLastBooking() throws SQLException {
        Connection cnn = null;
        Statement stm = null;
        ResultSet rs = null;
        String result = "";

        LOG.info("getLastBooking of CartDAO");

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "SELECT TOP 1 bID FROM tblBookings ORDER BY bBookingDate DESC";
                stm = cnn.createStatement();
                rs = stm.executeQuery(sql);

                if (rs.next()) {
                    result = rs.getString("bID");
                }
            }
        } catch (Exception e) {
            LOG.error("Error at getLastBooking of CartDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return result;
    }

    public boolean updateStatus(int status, String bookingID) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        boolean result = false;

        LOG.info("updateStatus of CartDAO");

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "UPDATE tblBookings SET bStatus=? WHERE bID=?";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, status);
                stm.setString(2, bookingID);

                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at updateStatus of CartDAO");
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return result;
    }
    
    public List<CartDTO> getHistory(String userID, int index, int size) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<CartDTO> result = new ArrayList<CartDTO>();

        try {
            conn = DBUtils.getConnection();

            if (conn != null) {
                String sql = "SELECT bID, bBookingDate, bDateFrom, bDateTo, bTotal, bCouponID, bFinalTotal, bStatus"
                        + " FROM tblBookings WHERE bUserID=? AND (bStatus = 4 OR bStatus = 5 OR bStatus = 7) ORDER BY bID DESC"
                        + " OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setInt(2, index);
                stm.setInt(3, size);
                stm.setInt(4, size);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String bookingID = rs.getString("bID");
                    Date bookingDate = rs.getDate("bBookingDate");
                    Date dateFrom = rs.getDate("bDateFrom");
                    Date dateTo = rs.getDate("bDateTo");
                    float total = rs.getFloat("bTotal");
                    String couponID = rs.getString("bCouponID");
                    float finalTotal = rs.getFloat("bFinalTotal");
                    int statusID = rs.getInt("bStatus");

                    HashMap<String, RoomDTO> cart = new HashMap<String, RoomDTO>();
                    CartDTO cartDTO = new CartDTO(bookingID, userID, cart, total, finalTotal, couponID, dateFrom, dateTo, statusID, bookingDate);
                    result.add(cartDTO);
                }

                for (CartDTO cartDTO : result) {
                    sql = "SELECT BD.bRoomType, H.hName, C.cName, BD.bdQuantity, BD.bdPrice\n"
                            + "FROM tblHotels H, tblCategories C, tblRoomTypes RT, tblBookingDetails BD\n"
                            + "WHERE H.hID = RT.rtHotel AND C.cID = RT.rtCategory AND BD.bRoomType = RT.rtID\n"
                            + "AND BD.bdBookingID = ?";
                    stm = conn.prepareStatement(sql);
                    stm.setString(1, cartDTO.getId());
                    rs = stm.executeQuery();
                    while (rs.next()) {
                        String roomID = rs.getString("bRoomType");
                        String hotelName = rs.getString("hName");
                        String categoryName = rs.getString("cName");
                        int amount = rs.getInt("bdQuantity");
                        float price = Float.parseFloat(new DecimalFormat("#").format(rs.getFloat("bdPrice")));
                        cartDTO.getCart().put(roomID, new RoomDTO(roomID, hotelName, categoryName, amount, price));
                    }
                }

            }
        } catch (Exception e) {
            LOG.error("Error at getHistory of CartDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public List<String> search(String bookingID, Date date, String userID, int index, int size) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> result = new ArrayList<String>();

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT bID FROM tblBookings WHERE bUserID = ? AND (bID LIKE ? OR CAST(bBookingDate AS DATE) = ?) AND (bStatus = 4 OR bStatus = 5 OR bStatus = 7)"
                            + " ORDER BY bID DESC OFFSET (? - 1) * ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setString(2, bookingID);
                stm.setDate(3, date);
                stm.setInt(4, index);
                stm.setInt(5, size);
                stm.setInt(6, size);

                rs = stm.executeQuery();
                while (rs.next()) {
                    String bookingID1 = rs.getString("bID");
                    result.add(bookingID1);
                }
            }
        } catch (Exception e) {
            LOG.error("Error at search of CartDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }
    
    public int countSearch(String bookingID, Date date, String userID) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int result = 0;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(bID) AS row FROM tblBookings WHERE bUserID = ? AND (bID LIKE ? OR CAST(bBookingDate AS DATE) = ?) AND (bStatus = 4 OR bStatus = 5 OR bStatus = 7)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setString(2, bookingID);
                stm.setDate(3, date);

                rs = stm.executeQuery();
                while (rs.next()) {
                    result = rs.getInt("row");
                }
            }
        } catch (Exception e) {
            LOG.error("Error at countSearch of CartDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }
    
    public int count(String userID) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int result = 0;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(bID) AS row FROM tblBookings WHERE bUserID = ? AND (bStatus = 4 OR bStatus = 5 OR bStatus = 7)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);

                rs = stm.executeQuery();
                while (rs.next()) {
                    result = rs.getInt("row");
                }
            }
        } catch (Exception e) {
            LOG.error("Error at count of CartDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

}
