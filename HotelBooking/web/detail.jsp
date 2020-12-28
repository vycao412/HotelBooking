<%-- 
    Document   : detail
    Created on : Dec 20, 2020, 8:21:57 AM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
        
        <title>Detail Page</title>
        
        <style>
            body{
                background-color: whitesmoke;
            }
            h2{
                text-align: center;
            }
            .container{
                margin-top: 8%;
            }
            .navbar{
                overflow: hidden;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 100;
            }
            #expirateDate{
                padding-left: 15%;
            }
            .pagination{
                margin-top: 2%;
            }
            .card{
                height: 55vh;
            }
            .feedback{
                margin-top: 2%;
            }
        </style>
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
            <div class="row">
                <div class="col-7">
                    <div class="card">
                        <img src="img/${sessionScope.HOTEL.image}" class="card-img-top" style="height: 530px; width: auto">  
                    </div>
                </div>
                <div class="col-5">
                    <form action="addToCart" method="POST">
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <h3>${sessionScope.HOTEL.name}</h3>
                                <p>${sessionScope.HOTEL.address}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="cc-name">Number of rooms</label>
                                <input type="number" min="1" class="form-control" name="txtQuan" value="1" required="true">
                            </div>
                        </div>
                        <h4 class="mb-3">Prices</h4>

                        <div class="d-block my-3">
                            <c:if test="${not empty sessionScope.SINGLE_ROOM}">
                                <div class="custom-control custom-radio">
                                    <input id="credit" name="roomType" type="radio" class="custom-control-input" value="0" checked="" required="true"> 
                                    <label class="custom-control-label" for="credit">Single Room &emsp;&emsp; ${sessionScope.SINGLE_ROOM}$</label>
                                </div>
                            </c:if>
                            <c:remove var="SINGLE_ROOM" scope="session"></c:remove>
                            
                            <c:if test="${not empty sessionScope.DOUBLE_ROOM}">
                                <div class="custom-control custom-radio">
                                    <input id="debit" name="roomType" type="radio" class="custom-control-input" value="1">
                                    <label class="custom-control-label" for="debit">Double Room &emsp;&nbsp;&nbsp; ${sessionScope.DOUBLE_ROOM}$</label>
                                </div>
                            </c:if>
                            <c:remove var="DOUBLE_ROOM" scope="session"></c:remove>
                            
                            <c:if test="${not empty sessionScope.FAMILY_ROOM}">
                                <div class="custom-control custom-radio">
                                    <input id="paypal" name="roomType" type="radio" class="custom-control-input" value="2">
                                    <label class="custom-control-label" for="paypal">Family Room &emsp;&emsp; ${sessionScope.FAMILY_ROOM}$</label>
                                </div>
                            </c:if>
                            <c:remove var="FAMILY_ROOM" scope="session"></c:remove>
                        </div>

                        <c:if test="${sessionScope.USER.roleID eq 2 }">
                            <hr class="mb-4">
                            <button class="btn btn-primary btn-lg btn-block" type="submit">Book</button>
                        </c:if>                        
                    </form>
                </div>
            </div>
                        
            <div class="feedback">
                <c:if test="${sessionScope.FEEDBACK != null}">
                    <c:forEach var="feedback" items="${sessionScope.FEEDBACK}">
                        <div class="alert alert-secondary" role="alert">
                            <div class="row">
                                <div class="col-10">
                                    <h5 class="alert-heading">${feedback.userName}</h5>
                                    <p>${feedback.feedback}</p>
                                </div>
                                <div class="col-2">
                                    <c:forEach var="count" begin="1" end="5">
                                        <c:choose>
                                            <c:when test="${not empty feedback.star && feedback.star >= count}">
                                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-star-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.283.95l-3.523 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                                </svg>
                                            </c:when>
                                            <c:when test="${not empty feedback.star && feedback.star < count}">
                                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-star" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.523-3.356c.329-.314.158-.888-.283-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767l-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288l1.847-3.658 1.846 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.564.564 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
                                                </svg>
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </c:if>                    
            </div>
        </div>
    </body>
</html>
