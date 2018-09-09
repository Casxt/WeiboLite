<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="utf-8" %>
<html lang="en">
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css" crossorigin="anonymous" type="text/css">
    <link rel="stylesheet" type="text/css" href="/static/css/iconfont.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand mr-4" href="#">WeiboLite</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="搜索用户或微博">
        </form>
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">热门微博</a>
            </li>
        </ul>
        <a class="btn btn-outline-success text-white mr-2" href="#">登陆</a>
    </div>
</nav>
<main class="container mt-4">
    <div class="shadow card p-3 mb-3 bg-light rounded-0 mx-auto" style="width: 25rem;">
        <h2 class="card-header rounded-0 border-bottom bg-light text-center">重置密码</h2>
        <div class="card-body">
            <form id="signUp-Form">
                <div class="form-group">
                    <label for="signUp-Email">邮箱</label>
                    <input type="email" class="form-control rounded-0" id="signUp-Email" aria-describedby="emailHelp" placeholder="Enter email" required>
                </div>

                <div class="form-group">
                    <label for="signUp-Password">密码</label>
                    <input type="password" class="form-control rounded-0" id="signUp-Password" placeholder="Password" required>
                </div>

                <div class="form-group">
                    <label for="signUp-ConfirmPassword">确认密码</label>
                    <input type="password" class="form-control rounded-0" id="signUp-ConfirmPassword" placeholder="Password" required>
                </div>

                <button type="submit" class="btn btn-primary rounded-0 float-right" onclick="this.innerHTML='重置中...';">重置</button>
            </form>
        </div>
    </div>
</main>
<script type="application/javascript">
    function showSignUpForm() {
        document.getElementById("signUp-Email").value = document.getElementById("signIn-Email").value;
        document.getElementById("signUp-Password").value = document.getElementById("signIn-Password").value;
        document.getElementById("signIn-Form").setAttribute("hidden","hidden");
        document.getElementById("signUp-Form").removeAttribute("hidden");
        //$("#signIn-Form").hide();
        //$("#signUp-Form").show();
    }
</script>
<script src="/static/js/jquery-3.3.1.min.js"></script>
<script src="/static/js/bootstrap.bundle.min.js"></script>
</body>
</html>
