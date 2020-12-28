/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

import java.io.Serializable;

/**
 *
 * @author VYCAO
 */
public class FeedbackDTO implements Serializable {
    private String feedbackID;
    private String roomID;
    private String content;
    private int star;
    private String userID;

    public FeedbackDTO() {
    }

    public FeedbackDTO(String feedbackID, String roomID, String content, int star, String userID) {
        this.feedbackID = feedbackID;
        this.roomID = roomID;
        this.content = content;
        this.star = star;
        this.userID = userID;
    }

    public FeedbackDTO(String roomID, String content, int star, String userID) {
        this.roomID = roomID;
        this.content = content;
        this.star = star;
        this.userID = userID;
    }

    public String getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(String feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }
    
    
}
