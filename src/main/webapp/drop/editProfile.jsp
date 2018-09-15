<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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

        <div class="input-group mb-3 w-auto my-auto">
            <div class="input-group-prepend">
                <button class="btn btn-outline-secondary dropdown-toggle text-light" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">微博</button>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="#">微博</a>
                    <a class="dropdown-item" href="#">用户</a>
                </div>
            </div>
            <input type="text" class="form-control" placeholder="搜索">
        </div>

        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">热门微博</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#">我的主页</a>
            </li>
        </ul>
        <a class="btn btn-outline-success text-white mr-2" href="#">张楷</a>
        <a class="btn btn-outline-info text-white" href="#">我的消息 <span class="badge badge-info">9</span></a>
    </div>
</nav>
<main class="container mt-4">
    <div class="row">
        <div class="col-3">
            <div class="nav flex-column bg-light nav-pills shadow rounded-0" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                <a class="nav-link active rounded-0" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">基本信息</a>
                <a class="nav-link rounded-0" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">我的账户</a>
                <a class="nav-link rounded-0" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">统计信息</a>
            </div>
        </div>
        <div class="col-9">
            <div class="tab-content" id="v-pills-tabContent">
                <div class="tab-pane fade shadow card rounded-0 show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                    <div class="card-body">
                        <label for="images">
                            <img class="rounded-0" src="/static/image/8499E7D9D3C81B2499327ED102952501.png" style="width: 10rem; height: 10rem;" alt="Card image cap">
                        </label>
                        <input name="imgs" type="file" id="images" accept="image/png, image/jpeg" style="display: none;">
                        <br>
                        <input type="text" class="mb-0 mt-2 w-auto form-control rounded-0 border-top-0 border-right-0 border-left-0" value="张楷">
                        <hr class="invisible">
                        <textarea class="rounded-0 w-50 border-0 form-control" style="height: 10rem;">一些简介，一些简介，一些简介，一些简介</textarea>
                    </div>
                </div>
                <div class="tab-pane fade shadow card rounded-0" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                    <div class="card-body">
                        <h4>密码</h4>
                        <button class="btn btn-primary rounded-0" type="button">更改密码</button>
                        <hr>
                        <h4>账户</h4>
                        <button class="btn btn-danger rounded-0" type="button">删除账户</button>
                    </div>
                </div>
                <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">...</div>
            </div>
        </div>
    </div>
</main>
<script src="/static/js/jquery-3.3.1.min.js"></script>
<script src="/static/js/bootstrap.bundle.min.js"></script>
</body>
</html>