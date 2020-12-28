<%-- 
    Document   : cart
    Created on : Dec 20, 2020, 2:17:34 PM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Page</title>

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
            <c:if test="${sessionScope.NEXT_FAIL != null}">
                <div class="alert alert-danger" role="alert">              
                    ${sessionScope.NEXT_FAIL}  
                </div>
            </c:if>
            <c:if test="${sessionScope.MESSAGE_QUAN != null}">
                <c:forEach var="msg" items="${sessionScope.MESSAGE_QUAN}">
                    <div class="alert alert-danger" role="alert">              
                        ${msg}  
                    </div>
                </c:forEach>
            </c:if>
            <c:remove var="CHECKOUT_FAIL" scope="session"></c:remove>
            <c:remove var="MESSAGE_QUAN" scope="session"></c:remove>
            <c:if test="${sessionScope.CART != null && sessionScope.CART.cart.size() != 0}">
                <form action="confirm" method="POST">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>Check in</label>
                            <input id="dateFrom" type="date" name="txtDateFrom" class="form-control" value="${sessionScope.DATE_FROM}">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Check out</label>
                            <input id="dateTo" type="date" name="txtDateTo" class="form-control" onchange="testDate()" value="${sessionScope.DATE_TO}">
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
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="room" items="${sessionScope.CART.cart.values()}" varStatus="counter">   
                            <form action="updateCart">
                                <tr>
                                    <td>${counter.count}</td>
                                    <td>${room.hotelID}</td>
                                    <td>${room.categoryID}</td>
                                    <td>
                                        <input type="number" name="txtQuantity" value="${room.quantity}" min="1"/>        
                                    </td>
                                    <td>${room.price}</td>
                                    <td>${room.price * room.quantity}</td>
                                    <td>  
                                        <input type="hidden" name="txtRoomID" value="${room.roomID}"/>
                                        <input class="btn btn-secondary" type="submit" name="btnAction" value="Update"/>
                                    </td>
                                    <td>
                                        <c:url var="delete" value="deleteCart">
                                            <c:param name="txtRoomDel" value="${room.roomID}"></c:param>
                                        </c:url>
                                        <a href="${delete}" onclick="return confirm('Are you sure you want to delete this room?')">Delete</a>

                                    </td>
                                </tr>
                            </form>
                            </c:forEach>
                            </tbody>
                    </table>
                    <div class="row">
                        <div class="col-6">
                            <h3>Total: ${sessionScope.CART.total} $</h3>
                        </div>
                        <div class="col-3"></div>
                        <div class="col-3">
                            <input type="submit" class="btn btn-info btnCheckout" name="btnAction" value="Confirm">
                        </div>
                    </div>   
                </form>

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
