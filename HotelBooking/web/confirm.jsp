<%-- 
    Document   : confirm
    Created on : Dec 21, 2020, 9:48:19 AM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Page</title>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body>

        <!-- navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="collapse navbar-collapse jsustify-content-end" id="navbarTogglerDemo01">

                <ul class="navbar-nav m-auto">

                    <!-- homepage -->
                    <li class="nav-item active">
                        <a class="nav-link" href="homePage">Home<span class="sr-only">(current)</span></a>
                    </li>

                    <!-- cart for member -->
                    <c:if test="${sessionScope.USER.roleID eq 2}">
                        <li class="nav-item">
                            <a class="nav-link" href="cart.jsp">Cart</a>
                        </li>
                    </c:if>

                    <!-- track booking for member -->
                    <c:if test="${sessionScope.USER.roleID eq 2}">
                        <li class="nav-item">
                            <a class="nav-link" href="trackBooking">Booking History</a>
                        </li>
                    </c:if>

                    <!-- create discount for admin -->
                    <c:if test="${sessionScope.USER.roleID eq 1}">
                        <li class="nav-item">
                            <a class="nav-link" href="createCoupon.jsp">Create Discount</a>
                        </li>
                    </c:if>


                    <!-- login -->
                    <c:if test="${sessionScope.USER == null}">
                        <c:if test="${empty sessionScope.USER}">
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp">Login</a>
                            </li>
                        </c:if>
                    </c:if>

                    <!-- logout -->
                    <c:if test="${sessionScope.USER != null}">
                        <c:if test="${not empty sessionScope.USER}">
                            <li class="nav-item">
                                <a class="nav-link" href="logout">Logout</a>
                            </li>
                        </c:if>
                    </c:if>

                </ul>
            </div>
        </nav>
        <!-- end navbar -->

        <div class="container">
            <c:if test="${sessionScope.CART != null && sessionScope.CART.cart.size() != 0}">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label>Check in</label>
                        <input type="date" name="txtDateFrom" class="form-control" value="${sessionScope.DATE_FROM}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Check out</label>
                        <input type="date" name="txtDateTo" class="form-control" onchange="testDate()" value="${sessionScope.DATE_TO}">
                    </div>
                </div>
                <table class="table table-striped">
                    <thead>
                        <tr>               
                            <th>No</th>
                            <th>Hotel</th>
                            <th>Category</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="room" items="${sessionScope.CART.cart.values()}" varStatus="counter">   
                            <tr>
                                <td>${counter.count}</td>
                                <td>${room.hotelID}</td>
                                <td>${room.categoryID}</td>
                                <td>
                                    <input type="number" name="txtQuantity" value="${room.quantity}" min="1"/>        
                                </td>
                                <td>${room.price}</td>
                                <td>${room.price * room.quantity * sessionScope.GAP}</td>
                            </tr>                    
                        </c:forEach>
                    </tbody>
                </table>
                <form action="applyCoupon">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>Discount code</label>
                            <input type="text" class="form-control" name="txtCouponCode" value="${param.txtCouponCode}">
                            <c:if test="${not empty sessionScope.DISCOUNT_FAIL}">
                                <font color="red"><small>${sessionScope.DISCOUNT_FAIL}</small></font> 
                                </c:if>
                            <br/>
                            <c:remove var="DISCOUNT_FAIL" scope="session"></c:remove>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label>&emsp;</label>
                                <input type="submit" class="btn btn-info form-control" value="Apply">
                            </div>
                        </div>
                    </form>

                    <div class="row">
                        <div class="col-6">
                            <h3>Total: ${sessionScope.CART.finalTotal} $</h3>
                    </div>
                    <div class="col-3"></div>
                    <div class="col-3">
                        <a href="checkout" class="btn btn-info btnCheckout" data-toggle="modal" data-target="#email">Checkout</a>
                    </div>
                </div>   

                <div class="modal fade" id="email" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Enter email</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form action="checkout" method="POST">
                                <div class="modal-body">
                                    <input type="text" name="txtEmail" class="form-control">
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>

            </c:if>
            <c:if test="${sessionScope.CART == null || sessionScope.CART.cart.values().size() == 0}">
                <h2>Your cart is empty.</h2>      
            </c:if>
        </div>


        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>

    <script>
                            function testDate() {
                                var dateFrom = document.getElementById("dateFrom").value;
                                var dateTo = document.getElementById("dateTo").value;
                                if (start !== null && end !== null) {
                                    if ((new Date(dateFrom).getTime() >= new Date(dateTo).getTime())) {
                                        alert('Return date must be after arrival date');
                                        document.getElementById("expired_date").value = '';
                                    }
                                }
                            }
    </script>

</html>
