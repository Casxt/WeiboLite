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
            <input id="searchKeyword" name="Nickname" type="text" class="form-control rounded-0" placeholder="搜索">
            <button class="btn btn-outline-secondary text-light rounded-0" type="button"
                    onclick="localStorage.setItem(`skw`, document.getElementById(`searchKeyword`).value);window.location.href=`/searchuser`">
                搜用户
            </button>
        </div>

        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/hotWeibo.jsp rounded-0">热门微博</a>
            </li>
        </ul>
        <a id="nickname" class="btn btn-outline-success text-white mr-2 rounded-0"
           href="/myFollow.jsp" <% out.print(SignIn ? "" : "hidden");%>><%out.print(nickname);%></a>
        <a class="btn btn-outline-info text-white rounded-0" href="/index.jsp" <% out.print(SignIn ? "" : "hidden");%>>主页</a>
        <a class="btn btn-outline-info text-white rounded-0"
           href="/signin" <% out.print(SignIn ? "hidden" : "");%>>登陆</a>
    </div>
</nav>