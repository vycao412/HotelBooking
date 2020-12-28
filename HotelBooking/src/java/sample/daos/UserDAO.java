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
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;
import sample.dtos.UserDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class UserDAO implements Serializable {
    
    private static final Logger LOG = Logger.getLogger(UserDAO.class);
    
    public UserDTO checkLogin(String userID, String password) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        UserDTO result = null;

        LOG.info("checkLogin of UserDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT uID,uName,uPassword,uPhone,uAddress,uCreateDate,uStatus,uRole FROM tblUsers" +
                        " WHERE uID=? AND uPassword=? AND uStatus=1";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, userID);
                String encryptedPass = DigestUtils.sha256Hex(password);
                stm.setString(2, encryptedPass);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("uName");
                    String phone = rs.getString("uPhone");
                    String address = rs.getString("uAddress");
                    Date createDate = rs.getDate("uCreateDate");
                    int status = rs.getInt("uStatus");
                    int role = rs.getInt("uRole");
                    result = new UserDTO(userID, name, password, phone, address, createDate, status, role);
                }
            }
        } catch (Exception e) {
            LOG.error("Error at checkLogin of UserDAO: " + e.toString());
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
    
    public boolean checkID(String userID) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean result = true;

        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "SELECT uName FROM tblUsers WHERE uID=? AND uStatus=1";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    result = false;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at checkID of UserDAO: " + e.toString());
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
    
    public void create(UserDTO dto) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;

        LOG.info("create of UserDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "INSERT INTO tblUsers(uID,uName,uPassword,uPhone,uAddress,uCreateDate,uStatus,uRole) VALUES(?,?,?,?,?,?,?,?)";
                stm = cnn.prepareStatement(sql);
                String encryptedPass = DigestUtils.sha256Hex(dto.getPassword());
                stm.setString(1, dto.getUserID());
                stm.setString(2, dto.getName());
                stm.setString(3, encryptedPass);
                stm.setString(4, dto.getPhone());               
                stm.setString(5, dto.getAddress());
                stm.setDate(6, dto.getCreateDate());
                stm.setInt(7, dto.getStatus());
                stm.setInt(8, dto.getRoleID());
                stm.executeUpdate();
            }
        } catch (Exception e) {
            LOG.error("Error at create of UserDAO: " + e.toString());
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
    }
    
    public List<String> getAllUser() throws SQLException {
        Connection cnn = null;
        Statement stm = null;
        ResultSet rs = null;
        List<String> result = new ArrayList<String>();
        
        LOG.info("getAllUser of UserDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                stm = cnn.createStatement();
                String sql = "SELECR uID FROM tblUsers";
                rs = stm.executeQuery(sql);
                
                while (rs.next()) {
                    String userID = rs.getString("uID");
                    result.add(userID);
                }
            }
        } catch (Exception e) {
            LOG.error("Error at getAllUser of UserDAO: " + e.toString());
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
    
    public boolean updatePass(String userID, String password) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        boolean result = false;

        LOG.info("updatePass of UserDAO");
        
        try {
            cnn = DBUtils.getConnection();
            if (cnn != null) {
                String sql = "UPDATE tblUsers SET uPassword=? WHERE uID=?";
                stm = cnn.prepareStatement(sql);
                String encryptedPass = DigestUtils.sha256Hex(password);
                stm.setString(1, encryptedPass);
                stm.setString(2, userID);
                
                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at updatePass of UserDAO: " + e.toString());
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
    
}
