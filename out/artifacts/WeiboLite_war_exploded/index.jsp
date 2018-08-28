<!DOCTYPE html>
<html lang="en">
<head>
    <%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <title>Title</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css" crossorigin="anonymous" type="text/css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand mr-4" href="#">WeiboLite</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
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
            <li class="nav-item active">
                <a class="nav-link" href="#">我的主页</a>
            </li>
        </ul>
        <a class="btn btn-outline-success text-white mr-2" href="#">张楷</a>
        <a class="btn btn-outline-info text-white" href="#">我的消息 <span class="badge badge-info">9</span></a>
    </div>
</nav>
<main class="container w-50 mt-4">
    <div class="shadow card p-1 mb-3 bg-white rounded-0">
        <div class="card-body">
            <div class="media pb-3 border-bottom border-dark">
                <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png" style="width: 64px; height: 64px;" alt="Generic placeholder image">
                <div class="media-body">
                    <h5 class="mt-0 mr-auto">张楷</h5>
                    这是一条微博，这是一条微博这是一条微博，这是一条微博，这是一条微博，这是一条微博，这是一条微博
                    这是一条微博
                </div>
            </div>
            <div class="btn-group btn-group-toggle mt-0 float-right" data-toggle="buttons">
                <label class="btn btn-secondary btn-sm active rounded-0">
                    <input type="radio" name="options" id="option1" autocomplete="off" checked> 评论
                </label>
                <label class="btn btn-sm btn-secondary rounded-0">
                    <input type="radio" name="options" id="option2" autocomplete="off"> 转发
                </label>
                <label class="btn btn-sm btn-secondary rounded-0">
                    <input type="radio" name="options" id="option3" autocomplete="off"> 删除
                </label>
            </div>
            <!-- 提交评论 -->
            <div class="media mt-5 ml-5">
                <div class="media-body container px-0">
                    <form class="form-inline m-0 container px-0">
                        <div class="form-group w-75">
                            <input type="text" class="form-control w-100 ml-0" id="inputPassword2" placeholder="评论">
                        </div>
                        <button type="submit" class="btn btn-primary mx-1">评论</button>
                    </form>
                </div>
            </div>
            <!-- 评论 -->
            <div class="media mt-3 ml-5 border-bottom border-dark">
                <div class="media-body">
                    <h6 class="mt-0">
                        评论者
                        <div class="btn-group btn-group-toggle mt-0" data-toggle="buttons">
                            <small class="bg-secondary text-white mr-1 p-1">
                                转发
                            </small>
                            <small class="bg-secondary text-white p-1">
                                删除
                            </small>
                        </div>
                    </h6>
                    <small>一条评论，一条评论，一条评论一条评论，一条评论</small>
                </div>
            </div>
            <div class="media mt-3 ml-5 border-bottom border-dark">
                <div class="media-body">
                    <h6 class="mt-0">
                        评论者
                        <div class="btn-group btn-group-toggle mt-0" data-toggle="buttons">
                            <small class="bg-secondary text-white mr-1 p-1">
                                转发
                            </small>
                            <small class="bg-secondary text-white p-1">
                                删除
                            </small>
                        </div>
                    </h6>
                    <small>一条评论，一条评论，一条评论一条评论，一条评论</small>
                </div>
            </div>
        </div>
    </div>
</main>
<script type="text/javascript">
    $(".review-typeSelect").button('toggle')
</script>
<script src="/static/js/jquery-3.3.1.min.js"></script>
<script src="/statiinfoc/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>