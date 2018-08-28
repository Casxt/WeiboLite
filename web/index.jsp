<!DOCTYPE html>
<html lang="en">
<head>
    <%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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
                <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                     style="width: 64px; height: 64px;" alt="Generic placeholder image">
                <div class="media-body">
                    <h5 class="mt-0 mr-auto">张楷</h5>
                    这是一条微博，这是一条微博这是一条微博，这是一条微博，这是一条微博，这是一条微博，这是一条微博
                    这是一条微博
                </div>
            </div>
            <div class="btn-group btn-group-toggle mt-0 float-right" data-toggle="buttons">
                <button class="btn btn-secondary btn-sm text-light rounded-0" type="button" data-toggle="collapse"
                        href="#CommentField" aria-expanded="false" aria-controls="CommentField">
                    <!--评论--><i class="iconfont icon-pinglun"></i>
                </button>
                <button class="btn btn-secondary btn-sm text-light rounded-0" type="button" data-toggle="collapse"
                        href="#ForwardField" aria-expanded="false" aria-controls="ForwardField">
                    <!--转发--><i class="iconfont icon-zhuanfa"></i>
                </button>
                <a class="btn btn-sm btn-secondary text-light rounded-0">
                    <!--删除--><i class="iconfont icon-guanbi"></i>
                </a>
            </div>
            <div class="collapse mt-5 pl-5" id="CommentField">
                <!-- 评论框 -->
                <div class="media">
                    <div class="media-body container px-0">
                        <form class="form-inline m-0 container px-0">
                            <div class="form-group input-group-sm w-75">
                                <input type="text" class="form-control w-100 ml-0 rounded-0"
                                       placeholder="评论">
                            </div>
                            <button type="button" class="btn btn-sm btn-primary mx-1 rounded-0">评论</button>
                        </form>
                    </div>
                </div>
                <!-- 评论 -->
                <div class="media mt-3 mb-2 pb-1 border-bottom border-dark">
                    <div class="media-body">
                        <h6 class="mt-0">
                            评论者1
                            <div class="btn-group mt-0" data-toggle="buttons">
                                <button class=" btn btn-sm bg-white mx-1 p-0 rounded-0">
                                    <i class="iconfont icon-pinglun"></i>
                                </button>
                                <button class=" btn btn-sm bg-white mx-1 p-0 rounded-0">
                                    <i class="iconfont icon-zhuanfa"></i>
                                </button>
                                <button class=" btn btn-sm bg-white mx-1 p-0 rounded-0">
                                    <i class="iconfont icon-guanbi"></i>
                                </button>
                            </div>
                        </h6>
                        <small>一条评论，一条评论，一条评论一条评论，一条评论</small>
                    </div>
                </div>
                <div class="media mt-3 mb-2 pb-1 border-bottom border-dark">
                    <div class="media-body">
                        <h6 class="mt-0">
                            评论者2
                            <div class="btn-group mt-0" data-toggle="buttons">
                                <button class=" btn btn-sm bg-white mx-1 p-0 rounded-0">
                                    <i class="iconfont icon-pinglun"></i>
                                </button>
                                <button class=" btn btn-sm bg-white mx-1 p-0 rounded-0">
                                    <i class="iconfont icon-zhuanfa"></i>
                                </button>
                                <button class=" btn btn-sm bg-white mx-1 p-0 rounded-0">
                                    <i class="iconfont icon-guanbi"></i>
                                </button>
                            </div>
                        </h6>
                        <small>对 <kbd>评论1</kbd> 说: 一条评论，一条评论，一条评论一条评论，一条评论</small>
                    </div>
                </div>
                <div class="btn-toolbar justify-content-center mt-3" role="toolbar">
                    <div class="btn-group btn-group-sm" role="group" aria-label="First group">
                        <button type="button" class="btn btn-outline-secondary rounded-0">1</button>
                        <button type="button" class="btn btn-outline-secondary rounded-0">2</button>
                        <button type="button" class="btn btn-outline-secondary rounded-0">3</button>
                        <button type="button" class="btn btn-outline-secondary rounded-0">4</button>
                    </div>
                </div>
            </div>
            <div class="collapse mt-5 pl-5" id="ForwardField">
                <!-- 转发框 -->
                <div class="media">
                    <div class="media-body container px-0">
                        <form class="form-inline m-0 container px-0">
                            <div class="form-group input-group-sm w-75">
                                <input type="text" class="form-control w-100 ml-0 rounded-0"
                                       placeholder="转发">
                            </div>
                            <button type="submit" class="btn btn-sm btn-primary mx-1 rounded-0">转发</button>
                        </form>
                    </div>
                </div>
                <div class="media mt-3 pb-1 border-bottom border-dark">
                    <div class="media-body">
                        <h6 class="mt-0">
                            转发者1
                            <div class="btn-group mt-0" data-toggle="buttons">
                                <button class=" btn btn-sm bg-white mx-1 p-0 rounded-0">
                                    <i class="iconfont icon-pinglun"></i>
                                </button>
                                <button class=" btn btn-sm bg-white mx-1 p-0 rounded-0">
                                    <i class="iconfont icon-zhuanfa"></i>
                                </button>
                                <button class=" btn btn-sm bg-white mx-1 p-0 rounded-0">
                                    <i class="iconfont icon-guanbi"></i>
                                </button>
                            </div>
                        </h6>
                        <small>一条转发，一条转发，一条转发一条转发一条转发一条转发</small>
                    </div>
                </div>
                <div class="btn-toolbar justify-content-center mt-3" role="toolbar">
                    <div class="btn-group btn-group-sm" role="group" aria-label="First group">
                        <button type="button" class="btn btn-outline-secondary rounded-0">1</button>
                        <button type="button" class="btn btn-outline-secondary rounded-0">2</button>
                        <button type="button" class="btn btn-outline-secondary rounded-0">3</button>
                        <button type="button" class="btn btn-outline-secondary rounded-0">4</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<script type="text/javascript">
    $(".review-typeSelect").button('toggle')
</script>
<script src="/static/js/jquery-3.3.1.min.js"></script>
<script src="/static/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>