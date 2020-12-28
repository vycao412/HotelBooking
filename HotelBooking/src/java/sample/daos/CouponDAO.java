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
import org.apache.log4j.Logger;
import sample.dtos.CouponDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class CouponDAO implements Serializable {
    
    private static final Logger LOG = Logger.getLogger(CouponDAO.class);

    public boolean search(String couponID) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean result = false;

        LOG.info("search of CouponDAO");

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "SELECT cID FROM tblCoupons WHERE cID = ?";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, couponID);

                if (rs.next()) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at search of CouponDAO: " + e.toString());
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
    
    public boolean create(CouponDTO dto) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        boolean result = false;

        LOG.info("create of CouponDAO");

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "INSERT INTO tblCoupons(cID, cName, cValue, cExpiredDate) VALUES(?,?,?,?)";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, dto.getCouponID());
                stm.setString(2, dto.getName());
                stm.setInt(3, dto.getValue());
                stm.setDate(4, dto.getExpiredDate());

                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at create of CouponDAO: " + e.toString());
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
    
     public CouponDTO checkValid(String couponID) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        CouponDTO discount = null;
        
        LOG.info("checkValid of CouponDAO");
        
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT cID, cName, cValue, cCreateDate, cExpiredDate FROM tblCoupons WHERE cID = ? AND cExpiredDate > CAST(GETDATE() AS DATE)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, couponID);
                
                rs = stm.executeQuery();
                if(rs.next()){
                    String name = rs.getString("cName");
                    int value = rs.getInt("cValue");
                    Date createDate = rs.getDate("cCreateDate");
                    Date expirateDate = rs.getDate("cExpiredDate");
                    
                    discount = new CouponDTO(couponID, name, value, createDate, expirateDate);
                }
            }
        } catch (Exception e) {
            LOG.error("Error at checkValid of CouponDAO: " + e.toString());
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
        return discount;
    }
    
}
