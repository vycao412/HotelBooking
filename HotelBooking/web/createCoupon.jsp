<%-- 
    Document   : createCoupon
    Created on : Dec 22, 2020, 1:01:25 AM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Discount Page</title>

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
            <form action="createCoupon" method="POST">
                <div class="row">
                    <div class="col-3"></div>
                    <div class="col-6">
                        <div class="form-group">
                            <label>Discount code</label>
                            <input type="text" class="form-control" name="code" required="true">
                            <c:if test="${not empty sessionScope.DUPLICATE_COUPON}">
                                <font color="red"><small>${sessionScope.DUPLICATE_COUPON}</small></font>
                                </c:if>     
                        </div>
                        <div class="form-group">
                            <label>Discount Name</label>
                            <input type="text" class="form-control" name="name" required="true"> 
                        </div>
                        <div class="form-group">
                            <label>Percentage</label>
                            <input type="number" min="1" max="100" class="form-control" name="value" value="1" required="true">
                        </div>
                        <div class="form-group">
                            <label>Expiry date</label>
                            <input id="expiredDate" type="date" class="form-control" name="expiredDate" onchange="testDate()" required="true"> 
                        </div>
                        <input type="submit" class="btn btn-info btnCheckout" value="Submit">
                    </div>
                    <div class="col-3"></div>
                </div>
                <c:if test="${not empty sessionScope.DISCOUNT_FAIL}">
                    <h2>${sessionScope.DISCOUNT_FAIL}</h2>
                </c:if>
                <c:remove var="DISCOUNT_FAIL" scope="session"></c:remove>
                <c:remove var="DUPLICATE_COUPON" scope="session"></c:remove>
            </form>

        </div>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>

    <script>
                                function testDate() {
                                    var today = new Date().getTime();
                                    var expiredDate = document.getElementById("expiredDate").value;
                                    if (expiredDate !== null) {
                                        if ((new Date(today).getTime() >= new Date(end).getTime())) {
                                            alert('Expired date must be after today');
                                            document.getElementById("expiredDate").value = '';
                                        }
                                    }
                                }
    </script>

</html>
