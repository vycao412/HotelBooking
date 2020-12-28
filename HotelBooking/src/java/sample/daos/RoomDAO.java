/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.daos;

import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import sample.dtos.CartDTO;
import sample.dtos.RoomDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class RoomDAO implements Serializable {

    private static final Logger LOG = Logger.getLogger(RoomDAO.class);

    public List<RoomDTO> getListRoom(String hotelID) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<RoomDTO> result = new ArrayList<RoomDTO>();

        LOG.info("getListRoom of RoomDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT rtID, H.hName, C.cName, rtPrice "
                        + "FROM tblRoomTypes R, tblHotels H, tblCategories C "
                        + "WHERE R.rtHotel = H.hID AND R.rtCategory = C.cID AND R.rtHotel = ? ORDER BY rtPrice ASC";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, hotelID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("rtID");
                    String hotelName = rs.getString("hName");
                    String categoryName = rs.getString("cName");
                    float price = rs.getFloat("rtPrice");
                    result.add(new RoomDTO(id, hotelName, categoryName, price));
                }
            }
        } catch (Exception e) {
            LOG.error("Error at getListRoom of RoomDAO: " + e.toString());
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

    public List<String> checkValid(CartDTO cart) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        CallableStatement cstm = null;
        ResultSet rs = null;
        List<String> list = new ArrayList<String>();

        LOG.info("checkValid of RoomDAO");

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                cstm = cnn.prepareCall("{call findAvailableRoom(?)}", ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                cstm.setDate("Date", cart.getArriveDate());
                cstm.execute();

                for (String roomID : cart.getCart().keySet()) {
                    String sql = "SELECT rtQuantity - rtBooking AS available FROM tblRoomTypes WHERE rtID=?";
                    stm = cnn.prepareStatement(sql);
                    stm.setString(1, roomID);
                    rs = stm.executeQuery();
                    if (rs.next()) {
                        int available = rs.getInt("available");
                        String hotelName = cart.getCart().get(roomID).getHotelID();
                        String categoryName = cart.getCart().get(roomID).getCategoryID();
                        if (available == 0) {
                            list.add(hotelName + " - " + categoryName + " has no room!");
                        } else {
                            if (available < cart.getCart().get(roomID).getQuantity()) {
                                list.add(hotelName + " - " + categoryName + " has " + available + " only!");
                            }
                        }
                    }
                }
            }

        } catch (Exception e) {
            LOG.error("Error at checkValid of RoomDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (cstm != null) {
                cstm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return list;
    }

    public boolean updateQuanBooking(RoomDTO dto) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean result = false;

        LOG.info("updateQuanBooking of RoomDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "UPDATE tblRoomTypes SET rtBooking = rtBooking + ? WHERE rtID = ?";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, dto.getQuantity());
                stm.setString(2, dto.getRoomID());

                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at updateQuanBooking of RoomDAO: " + e.toString());
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

    public boolean updateQuanCancel(RoomDTO dto) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean result = false;

        LOG.info("updateQuanCancel of RoomDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "UPDATE tblRoomTypes SET rtBooking = rtBooking - ? WHERE rtID = ?";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, dto.getQuantity());
                stm.setString(2, dto.getRoomID());

                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at updateQuanCancel of RoomDAO: " + e.toString());
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

}
