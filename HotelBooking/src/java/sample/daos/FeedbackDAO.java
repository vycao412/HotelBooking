/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.apache.log4j.Logger;
import sample.dtos.FeedbackDTO;
import sample.utils.DBUtils;

/**
 *
 * @author VYCAO
 */
public class FeedbackDAO implements Serializable {
    
    private static final Logger LOG = Logger.getLogger(FeedbackDAO.class);

    public boolean create(FeedbackDTO dto) throws SQLException {
        Connection cnn = null;
        PreparedStatement stm = null;
        boolean result = false;

        LOG.info("create of FeedbackDAO");

        try {
            cnn = DBUtils.getConnection();

            if (cnn != null) {
                String sql = "INSERT INTO tblFeedbacks(fRoomType, fContent, fStar, fUserID) VALUES(?,?,?,?)";
                stm = cnn.prepareStatement(sql);
                stm.setString(1, dto.getRoomID());
                stm.setString(2, dto.getContent());
                stm.setInt(3, dto.getStar());
                stm.setString(4, dto.getUserID());

                int i = stm.executeUpdate();
                if (i > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            LOG.error("Error at create of FeedbackDAO: " + e.toString());
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
