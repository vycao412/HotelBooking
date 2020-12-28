<%-- 
    Document   : search
    Created on : Dec 20, 2020, 2:04:54 PM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Page</title>

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
                            <a class="nav-link" href="history.jsp">Booking History</a>
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
        
        <!-- welcome -->
        <section class="jumbotron text-center" style="position: relative; height: 60px">
            <div class="container">
                <h1 class="jumbotron-heading" style="top: 10px; position: absolute; text-align: center; left: 600px">HOTEL BOOKING</h1>
                <c:if test="${sessionScope.USER != null}">
                    <c:if test="${not empty sessionScope.USER}">
                        <h3>Welcome: ${sessionScope.USER.name}</h3>
                    </c:if>
                </c:if>
            </div>
        </section>
        <!-- end welcome -->

        <!-- carousel -->
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100" src="https://media-cdn.tripadvisor.com/media/photo-s/16/1a/ea/54/hotel-presidente-4s.jpg" alt="First slide"
                         style="height: 400px; background: transparent no-repeat center; background-size: cover">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg" alt="Second slide"
                         style="height: 400px; background: transparent no-repeat center; background-size: cover">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="https://thumbnails.expedia.com/IFJbQiqdh-uSZmMGQoPq04RZVJY=/500x333/smart/filters:quality(60)/exp.cdn-hotels.com/hotels/6000000/5310000/5309300/5309247/d035df98_y.jpg" alt="Third slide"
                         style="height: 400px; background: transparent no-repeat center; background-size: cover">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <!-- end carousel -->

        <div class="album py-5 bg-light">
            <div class="container">
                <form action="search">
                    <div class="row">
                        <div class="form-group col-3">
                            <input type="text" class="form-control" name="txtNameOrArea" placeholder="Enter hotel name or area" style="border: 1px solid;">
                        </div>

                        <div class="form-group col-3">
                            <input id="dateFrom" type="date" class="form-control" name="txtDateFrom" required="true" style="border: 1px solid;">
                        </div>
                        <div class="form-group col-3">
                            <input id="dateTo" type="date" class="form-control" name="txtDateTo" required="true" onchange="testDate()" style="border: 1px solid;">
                        </div>
                        <div class="form-group col-2">
                            <select name="txtRooms" class="form-control" style="border: 1px solid;">
                                <option value="1">1 Room(s)</option>
                                <option value="2">2 Room(s)</option>
                                <option value="3">3 Room(s)</option>
                                <option value="4">4 Room(s)</option>
                                <option value="5">5 Room(s)</option>
                            </select>
                        </div>
                        <div class="col-1">
                            <input type="submit" value="Search" class="btn btn-primary"/>
                        </div>
                    </div>
                </form>
                <c:if test="${sessionScope.CHECKOUT_SUCCESS != null}">
                    <div class="alert alert-primary" role="alert">              
                        ${sessionScope.CHECKOUT_SUCCESS}  
                    </div>
                </c:if>
                <c:remove var="CHECKOUT_SUCCESS" scope="session"></c:remove>
                
                <c:if test="${sessionScope.FEEDBACK_SUCCESS != null}">
                    <div class="alert alert-primary" role="alert">              
                        ${sessionScope.FEEDBACK_SUCCESS}  
                    </div>
                </c:if>
                <c:remove var="FEEDBACK_SUCCESS" scope="session"></c:remove>
                
                    <div class="row">
                    <c:if test="${sessionScope.SEARCH_HOTEL.size() != 0}">
                        <c:forEach var="hotel" items="${sessionScope.SEARCH_HOTEL}">
                            <div class="col-md-4">
                                <div class="card mb-4 shadow-sm">
                                    <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><image href="img/${hotel.image}" height="100%" width="100%"/></svg>

                                    <div class="card-body">
                                        <a href="detail?hotelID=${hotel.hotelID}"><b>${hotel.name}</b></a>
                                        <p class="card-text"><b>Address:</b> ${hotel.address}</p>
                                        <p class="card-text"><b>Phone:</b> ${hotel.phone}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>         
                </div>
                <c:remove var="SEARCH_HOTEL" scope="request"></c:remove>

                    <div class="row">
                    <c:if test="${not empty requestScope.SEARCH_HOTEL_EMPTY}">
                        <font>${requestScope.SEARCH_HOTEL_EMPTY}</font>
                    </c:if>
                </div>                   
                <c:remove var="SEARCH_HOTEL_EMPTY" scope="request"></c:remove>

            </div>

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
