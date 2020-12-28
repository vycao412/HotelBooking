<%-- 
    Document   : RegisterController
    Created on : Oct 11, 2020, 1:17:52 PM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>

        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <style>    
            .error {
                color: red;
            }

        </style>
    </head>
    <body>

        <div class="container">
            <div class="card bg-light">
                <article class="card-body mx-auto" style="max-width: 400px;">
                    <h4 class="card-title mt-3 text-center">CREATE ACCOUNT</h4>
                    <p class="text-center">Get started with your free account</p>
                    <p class="divider-text">
                        <span class="bg-light">OR</span>
                    </p>
                    <form action="register" method="POST">
                        <c:set var="error" value="${requestScope.ERROR_USER}"/>

                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                            </div>
                            <input name="txtUserID" class="form-control" placeholder="User ID" value="${param.txtUserID}" type="text" required="true">
                            <c:if test="${not empty error.errorUserID}">
                                <div class="error">
                                    <br><font>${error.errorUserID}</font>
                                </div>                  
                            </c:if>
                        </div> <!-- form-group// -->

                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                            </div>
                            <input name="txtName" class="form-control" placeholder="Full name" value="${param.txtName}" type="text" required="true">
                            <c:if test="${not empty error.errorName}">
                                <div class="error">
                                    <br><font>${error.errorName}</font>
                                </div>                  
                            </c:if>
                        </div> <!-- form-group// -->

                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-phone"></i> </span>
                            </div>
                            <input name="txtPhone" class="form-control" placeholder="Phone" value="${param.txtPhone}" type="text" required="true">
                            <c:if test="${not empty error.errorPhone}">
                                <div class="error">
                                    <br><font>${error.errorPhone}</font>
                                </div>                  
                            </c:if>
                        </div> <!-- form-group// -->

                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
                            </div>
                            <input name="txtAddress" class="form-control" placeholder="Address" value="${param.txtAddress}" type="text" required="true">
                            <c:if test="${not empty error.errorAddress}">
                                <div class="error">
                                    <br><font>${error.errorAddress}</font>
                                </div>                  
                            </c:if>
                        </div> <!-- form-group// -->

                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                            </div>
                            <input name="txtPassword" class="form-control" placeholder="Create password" type="password" required="true" minlength="8">
                            <c:if test="${not empty error.errorPassword}">
                                <div class="error">
                                    <br><font>${error.errorPassword}</font>
                                </div>                  
                            </c:if>

                        </div> <!-- form-group// -->

                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                            </div>
                            <input name="txtRePassword" class="form-control" placeholder="Repeat password" type="password" required="true">
                            <c:if test="${not empty error.errorRePassword}">
                                <div class="error">
                                    <br><font>${error.errorRePassword}</font>
                                </div>                  
                            </c:if>
                        </div> <!-- form-group// -->    

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block"> Create Account  </button>
                        </div> <!-- form-group// -->      
                        <p class="text-center">Have an account? <a href="login.jsp">Log In</a> </p>                                                                 
                    </form>
                </article>
            </div> <!-- card.// -->

        </div> 
        <!--container end.//-->


        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    </body>
</html>
