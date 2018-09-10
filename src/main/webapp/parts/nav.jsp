<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand mr-4" href="#">WeiboLite</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">

        <div class="input-group mb-3 w-auto my-auto">
            <div class="input-group-prepend">
                <button class="btn btn-outline-secondary dropdown-toggle text-light" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">微博</button>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="/serachWeibo.jsp">微博</a>
                    <a class="dropdown-item" href="/serachUser.jsp">用户</a>
                </div>
            </div>
            <input type="text" class="form-control" placeholder="搜索">
        </div>

        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/hotWeibo.jsp">热门微博</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/searchUser.jsp">推荐用户</a>
            </li>
        </ul>
        <a class="btn btn-outline-success text-white mr-2" href="/profile.jsp">张楷</a>
        <a class="btn btn-outline-info text-white" href="/index.jsp">主页</a>
    </div>
</nav>