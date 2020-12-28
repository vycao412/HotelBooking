/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author VYCAO
 */
public class CouponDTO implements Serializable {
    private String couponID;
    private String name;
    private int value;
    private Date createDate;
    private Date expiredDate;

    public CouponDTO() {
    }

    public CouponDTO(String couponID, String name, int value, Date createDate, Date expiredDate) {
        this.couponID = couponID;
        this.name = name;
        this.value = value;
        this.createDate = createDate;
        this.expiredDate = expiredDate;
    }

    public CouponDTO(String couponID, String name, int value, Date expiredDate) {
        this.couponID = couponID;
        this.name = name;
        this.value = value;
        this.expiredDate = expiredDate;
    }

    public String getCouponID() {
        return couponID;
    }

    public void setCouponID(String couponID) {
        this.couponID = couponID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }
    
}
