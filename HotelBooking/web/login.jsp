<%-- 
    Document   : login
    Created on : Dec 19, 2020, 1:49:21 PM
    Author     : VYCAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">       
        <link href="https://getbootstrap.com/docs/4.5/examples/sign-in/signin.css" rel="stylesheet">

    </head>
    <body class="text-center">
        <form class="form-signin" action="login" method="POST">
            <img class="mb-4" src="https://www.parisinfo.com/var/otcp/sites/images/media/1.-photos/03.-hebergement-630-x-405/hotel-enseigne-neon-630x405-c-thinkstock/31513-1-fre-FR/Hotel-enseigne-neon-630x405-C-Thinkstock.jpg" alt="" width="180" height="180">
            <h1 class="h3 mb-3 font-weight-normal">HOTEL BOOKING</h1>

            <div class="checkbox mb-3">
                <c:if test="${not empty requestScope.LOGIN_FAIL}">
                    <font style="color: red">${requestScope.LOGIN_FAIL}</font>
                </c:if>
            </div>

            <input type="text" id="inputEmail" class="form-control" name="txtUserID" placeholder="User ID" required autofocus>
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" class="form-control" name="txtPassword" placeholder="Password" required>

            <div class="checkbox mb-3">
                <a href="homePage">Home Page</a>
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit" name="btnAction">Sign in</button>
            <br><div class="checkbox mb-3">
                Do not have an account? <a href="register.jsp">Sign up</a>
            </div>
        </form>

    </body>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

</body>
</html>
