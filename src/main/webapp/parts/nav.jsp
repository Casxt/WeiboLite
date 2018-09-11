<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    String nickname = "";
    boolean SignIn = false;
    if (session.getAttribute("nickname") != null) {
        nickname = (String) session.getAttribute("nickname");
        SignIn = true;
    }
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand mr-4" href="#">WeiboLite</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <!--搜索栏-->
        <div class="input-group mb-3 w-auto my-auto" <% out.print(SignIn ? "" : "hidden");%>>
            <div class="input-group-prepend">
                <button class="btn btn-outline-secondary dropdown-toggle text-light" type="button"
                        data-toggle="dropdown">微博
                </button>
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
                <a class="nav-link" href="/searchUser.jsp" <% out.print(SignIn ? "" : "hidden");%>>推荐用户</a>
            </li>
        </ul>
        <a class="btn btn-outline-success text-white mr-2"
           href="/profile.jsp" <% out.print(SignIn ? "" : "hidden");%>><%out.print(nickname);%></a>
        <a class="btn btn-outline-info text-white" href="/index.jsp" <% out.print(SignIn ? "" : "hidden");%>>主页</a>
        <a class="btn btn-outline-info text-white" href="/signin" <% out.print(SignIn ? "hidden" : "");%>>登陆</a>
    </div>
</nav>