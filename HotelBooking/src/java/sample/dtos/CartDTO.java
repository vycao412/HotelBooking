/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashMap;

/**
 *
 * @author VYCAO
 */
public class CartDTO implements Serializable {
    private String id, userID;
    private HashMap<String, RoomDTO> cart;
    private float total;
    private float finalTotal;
    private String discountID;
    private Date dateFrom;
    private Date dateTo;
    private int status;
    private Date bookingDate;

    public CartDTO() {
    }

    public CartDTO(String id, String userID, HashMap<String, RoomDTO> cart, float total, float finalTotal, String discountID, Date dateFrom, Date dateTo, int status) {
        this.id = id;
        this.userID = userID;
        this.cart = cart;
        this.total = total;
        this.finalTotal = finalTotal;
        this.discountID = discountID;
        this.dateFrom = dateFrom;
        this.dateTo = dateTo;
        this.status = status;
    }

    public CartDTO(String id, String userID, HashMap<String, RoomDTO> cart, float total, float finalTotal, String discountID, Date dateFrom, Date dateTo, int status, Date bookingDate) {
        this.id = id;
        this.userID = userID;
        this.cart = cart;
        this.total = total;
        this.finalTotal = finalTotal;
        this.discountID = discountID;
        this.dateFrom = dateFrom;
        this.dateTo = dateTo;
        this.status = status;
        this.bookingDate = bookingDate;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public HashMap<String, RoomDTO> getCart() {
        return cart;
    }

    public void setCart(HashMap<String, RoomDTO> cart) {
        this.cart = cart;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public float getFinalTotal() {
        return finalTotal;
    }

    public void setFinalTotal(float finalTotal) {
        this.finalTotal = finalTotal;
    }

    public String getDiscountID() {
        return discountID;
    }

    public void setDiscountID(String discountID) {
        this.discountID = discountID;
    }

    public Date getArriveDate() {
        return dateFrom;
    }

    public void setArriveDate(Date dateFrom) {
        this.dateFrom = dateFrom;
    }

    public Date getReturnDate() {
        return dateTo;
    }

    public void setReturnDate(Date dateTo) {
        this.dateTo = dateTo;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }
    
    public void add(RoomDTO room, int quan) {
        if (cart == null) {
            cart = new HashMap<String, RoomDTO>();
        }
        String roomID = room.getRoomID();
        int quantity = quan;
        if (cart.containsKey(roomID)) {
            quantity += cart.get(roomID).getQuantity();
        }
        this.total += room.getPrice() * quan;
        this.finalTotal = this.total;
        room.setQuantity(quantity);
        cart.put(roomID, room);
    }

    public void update(String roomID, int quantity) {
        if (cart.containsKey(roomID)) {
            this.total -= cart.get(roomID).getPrice() * cart.get(roomID).getQuantity();
            cart.get(roomID).setQuantity(quantity);
            this.total += cart.get(roomID).getPrice() * cart.get(roomID).getQuantity();
        }
        this.finalTotal = this.total;
    }

    public void remove(String roomID) {
        if (cart.containsKey(roomID)) {
            this.total -= cart.get(roomID).getPrice() * cart.get(roomID).getQuantity();
            cart.remove(roomID);
        }
        this.finalTotal = this.total;
    }
    
}
