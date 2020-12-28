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
public class HotelDTO implements Serializable {
    private String hotelID;
    private String name;
    private String address;
    private String phone;
    private String image;

    public HotelDTO() {
    }

    public HotelDTO(String hotelID, String name, String address, String phone, String image) {
        this.hotelID = hotelID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.image = image;
    }

    public String getHotelID() {
        return hotelID;
    }

    public void setHotelID(String hotelID) {
        this.hotelID = hotelID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
}
