/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.daos;

import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import sample.dtos.HotelDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class HotelDAO implements Serializable {

    private static final Logger LOG = Logger.getLogger(HotelDAO.class);

    public List<HotelDTO> getList() throws SQLException {
        Connection cnn = null;
        Statement stm = null;
        CallableStatement cstm = null;
        ResultSet rs = null;
        List<HotelDTO> result = new ArrayList<HotelDTO>();

        LOG.info("getList of HotelDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                cstm = cnn.prepareCall("{call findAvailableRoom(?)}", ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                long currentTime = System.currentTimeMillis();
                Date date = new Date(currentTime);
                cstm.setDate("Date", date);
                cstm.execute();

                stm = cnn.createStatement();
                String sql = "SELECT hID, hName, hAddress, hPhone, hImage FROM tblHotels WHERE hID IN "
                        + "(SELECT rtHotel FROM tblRoomTypes GROUP BY rtHotel "
                        + "HAVING SUM(rtQuantity) > SUM (rtBooking) )";
                rs = stm.executeQuery(sql);

                while (rs.next()) {
                    String hotelID = rs.getString("hID");
                    String name = rs.getString("hName");
                    String address = rs.getString("hAddress");
                    String phone = rs.getString("hPhone");
                    String image = rs.getString("hImage");

                    result.add(new HotelDTO(hotelID, name, address, phone, image));
                }
            }
        } catch (Exception e) {
            LOG.error("Error at getList of HotelDAO: " + e.toString());
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
        return result;
    }

    public List<HotelDTO> getListSearch(String nameOrArea, Date dateTo, int rooms) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        CallableStatement cstm = null;
        ResultSet rs = null;
        List<HotelDTO> result = new ArrayList<HotelDTO>();

        LOG.info("getListSearch of HotelDAO");

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                cstm = cnn.prepareCall("{call findAvailableRoom(?)}", ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_READ_ONLY);
                cstm.setDate("Date", dateTo);
                cstm.execute();

                String sql = "SELECT hID, hName, hAddress, hPhone, hImage FROM tblHotels WHERE hID IN "
                        + "(SELECT rtHotel FROM tblRoomTypes GROUP BY rtHotel "
                        + "HAVING SUM(rtQuantity) >= SUM(rtBooking) + ?)"
                        + " AND (hName LIKE ? OR hAddress LIKE ?)";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, rooms);
                stm.setString(2, "%" + nameOrArea + "%");
                stm.setString(3, "%" + nameOrArea + "%");
                rs = stm.executeQuery();
                while (rs.next()) {
                    String hotelID = rs.getString("hID");
                    String name = rs.getString("hName");
                    String address = rs.getString("hAddress");
                    String phone = rs.getString("hPhone");
                    String image = rs.getString("hImage");

                    result.add(new HotelDTO(hotelID, name, address, phone, image));
                }
            }
        } catch (Exception e) {
            LOG.error("Error at getListSearch of HotelDAO: " + e.toString());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (cstm != null) {
                cstm.close();
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
    
    public HotelDTO getHotelByID(String hotelID) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        HotelDTO result = null;

        LOG.info("getHotelByID of HotelDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT hID, hName, hAddress, hPhone, hImage FROM tblHotels WHERE hID=?";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, hotelID);
                rs = stm.executeQuery();
                
                if (rs.next()) {
                    String name = rs.getString("hName");
                    String address = rs.getString("hAddress");
                    String phone = rs.getString("hPhone");
                    String image = rs.getString("hImage");
                    
                    result = new HotelDTO(hotelID, name, address, phone, image);
                }
            }
        }
        catch (Exception e) {
            LOG.error("Error at getHotelByID of HotelDAO: " + e.toString());
        }
        finally {
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
