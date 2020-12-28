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
public class RoomDTO implements Serializable {
    private String roomID;
    private String hotelID;
    private String categoryID;
    private int quantity;
    private float price;
    private int booking;

    public RoomDTO() {
    }

    public String getRoomID() {
        return roomID;
    }

    public RoomDTO(String roomID, String hotelID, String categoryID, int quantity, float price, int booking) {
        this.roomID = roomID;
        this.hotelID = hotelID;
        this.categoryID = categoryID;
        this.quantity = quantity;
        this.price = price;
        this.booking = booking;
    }

    public RoomDTO(String roomID, String hotelID, String categoryID, float price) {
        this.roomID = roomID;
        this.hotelID = hotelID;
        this.categoryID = categoryID;
        this.price = price;
    }

    public RoomDTO(String roomID, String hotelID, String categoryID, int quantity, float price) {
        this.roomID = roomID;
        this.hotelID = hotelID;
        this.categoryID = categoryID;
        this.quantity = quantity;
        this.price = price;
    }
    
    

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public String getHotelID() {
        return hotelID;
    }

    public void setHotelID(String hotelID) {
        this.hotelID = hotelID;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getBooking() {
        return booking;
    }

    public void setBooking(int booking) {
        this.booking = booking;
    }
    
}
