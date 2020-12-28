<%-- 
    Document   : history
    Created on : Dec 21, 2020, 1:18:19 PM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Track Order Page</title>

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

        <br>
        <!-- form search history booking -->
        <div class="container">
            <form action="searchBooking" method="POST">
                <div class="row">
                    <div class="col-2"></div>
                    <div class="col-4">
                        <input type="text" class="form-control" name="txtSearchBooking" value="${param.id}" style="border: 1px solid;" required="true">
                    </div>
                    <div class="col-3">
                        <input type="date" class="form-control" name="txtSearchDate" value="${param.date}" style="border: 1px solid;" required="true">
                    </div>
                    <div class="col-1">
                        <input type="submit" value="Search" class="btn btn-primary"/>
                    </div>
                    <div class="col-2"></div>
                </div>
            </form>
            <!-- end form search history booking -->

            <!-- list History -->
            <c:if test="${sessionScope.HISTORY != null}">
                <c:forEach var="cartDTO" items="${sessionScope.HISTORY}">
                    <div class="alert alert-secondary order" role="alert">
                        <div class="row">
                            <div class="col-6">
                                <h5 class="alert-heading">Order ID: ${cartDTO.id}</h5>
                                <h5 class="alert-heading">Check in: ${cartDTO.arriveDate}</h5>
                                <h5 class="alert-heading">Discount code: ${cartDTO.discountID}</h5>
                                <h5 class="alert-heading">Booking date: ${cartDTO.bookingDate}</h5>
                            </div>
                            <div class="col-6">
                                <c:if test="${cartDTO.status == 5}">
                                    <a type="button" class="close" data-toggle="modal" aria-label="Close" data-target="#Remove${cartDTO.id}">
                                        <span aria-hidden="true">&times;</span>
                                    </a>
                                </c:if>
                                <div class="modal fade" id="Remove${cartDTO.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Cancel Booking</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                Do you really want to cancel?
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                <a class="btn btn-primary" href="cancel?id=${cartDTO.id}">Cancel</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <h5>&emsp;</h5>
                                <h5 class="alert-heading">Check out: ${cartDTO.returnDate}</h5>
                            </div>
                        </div>
                        <hr>
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
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="room" items="${cartDTO.cart.values()}" varStatus="count">
                                    <tr>
                                        <td>${count.count}</td>
                                        <td>${room.hotelID}</td>
                                        <td>${room.categoryID}</td>
                                        <td>${room.quantity}</td>
                                        <td>${room.price}</td>
                                        <td>${room.price * room.quantity}</td>  
                                        <td>       
                                            <c:if test="${cartDTO.status == 7}">
                                                <a class="btn btn-secondary" href="feedback.jsp?index=1&id=${room.roomID}">Feedback</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b>Total: </b> </td>
                            <td>${cartDTO.finalTotal} $</td>
                            </tbody>
                        </table>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${sessionScope.HISTORY == null}">
                <h2>You do not have history!</h2>
            </c:if>
            <!-- end list History -->

            <!-- pagination -->
            <div class="text-center">
                <nav aria-label="...">
                    <c:if test="${sessionScope.endPage1 > 1}">
                        <ul class="pagination">
                            <c:forEach begin="1" end="${sessionScope.endPage1}" var="i">
                                <li class="page-item"><a class="page-link" href="trackBooking?index1=${i}">${i}</a></li>
                                </c:forEach>
                        </ul>
                    </c:if>
                </nav>
            </div>
            <!-- end pagination -->

        </div>         

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
