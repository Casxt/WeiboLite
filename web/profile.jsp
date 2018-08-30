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
<main class="container mt-4 w-75">
    <div class="row">
        <!--用户信息展示区-->
        <div class="col-4">
            <div class="card shadow bg-light rounded-0" style="width: 18rem;">
                <img class="card-img-top rounded-0" src="/static/image/8499E7D9D3C81B2499327ED102952501.png" style="width: 100%; height: 100%;" alt="Card image cap">
                <div class="card-body">
                    <h5 class="card-title">张楷</h5>
                    <p class="card-text">一些简介，一些简介，一些简介，一些简介</p>
                    <a href="#" class="btn btn-primary float-right rounded-0">关注</a>
                </div>
            </div>
        </div>
        <!--微博展示区-->
        <div class="col-8">
            <!--微博-->
            <div class="shadow card p-1 mb-3 bg-light rounded-0">
                <div class="card-body p-2">
                    <div class="media pb-3 border-bottom border-dark">
                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                             style="width: 64px; height: 64px;" alt="Generic placeholder image">
                        <div class="media-body">
                            <h5 class="mt-0 mr-auto">张楷</h5>
                            <p class="my-0">这是一条微博，这是一条微博这是一条微博，这是一条微博，这是一条微博，这是一条微博，这是一条微博
                                这是一条微博</p>
                            <small class="text-muted">Last updated 5 mins ago</small>
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
                                <h6 class="my-0">
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
                                <small>一条评论，一条评论，一条评论一条评论，一条评论,一条评论，一条评论，一条评论一条评论，一条评论
                                    一条评论，一条评论，一条评论一条评论，一条评论一条评论，一条评论，一条评论一条评论，一条评论一条评论，一条评论，一条评论一条评论，一条评论一条评论，一条评论，一条评论一条评论，一条评论</small>
                                <small class="float-right"><small class="text-muted">Last updated 5 mins ago</small></small>
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
                                <small class="float-right"><small class="text-muted">Last updated 5 mins ago</small></small>
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
                                <small class="float-right"><small class="text-muted">Last updated 5 mins ago</small></small>
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

            <!--微博转发-->
            <div class="shadow card p-1 mb-3 bg-light rounded-0">
                <div class="card-body p-2">
                    <div class="media pb-3 border-bottom border-dark">
                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                             style="width: 64px; height: 64px;" alt="Generic placeholder image">
                        <div class="media-body">
                            <h5 class="mt-0 mr-auto">张楷</h5>
                            <p class="my-0">这是一条转发微博，这是一条转发微博这是一条转发微博，这是一条转发微博这是一条转发微博这是一条转发微博</p>
                            <!--转发源-->
                            <div class="media mt-1 p-2" style="background-color: #e7e9ea;">
                                <a class="pr-3" href="#">
                                    <img src="/static/image/8499E7D9D3C81B2499327ED102952501.png" style="width: 48px; height: 48px;" alt="Generic placeholder image">
                                </a>
                                <div class="media-body">
                                    <h6 class="mt-0">张楷</h6>
                                    <p class="mb-0"><small>这是一条微博，这是一条微博这是一条微博，这是一条微博，这是一条微博，这是一条微博，这是一条微博</small></p>
                                    <small><small class="text-muted">Last updated 3 mins ago</small></small>
                                </div>
                            </div>
                            <small class="text-muted">Last updated 3 mins ago</small>
                        </div>
                    </div>
                    <div class="btn-group btn-group-toggle mt-0 float-right" data-toggle="buttons">
                        <button class="btn btn-secondary btn-sm text-light rounded-0" type="button" data-toggle="collapse"
                                href="#CommentField2" aria-expanded="false" aria-controls="CommentField2">
                            <!--评论--><i class="iconfont icon-pinglun"></i>
                        </button>
                        <button class="btn btn-secondary btn-sm text-light rounded-0" type="button" data-toggle="collapse"
                                href="#ForwardField2" aria-expanded="false" aria-controls="ForwardField2">
                            <!--转发--><i class="iconfont icon-zhuanfa"></i>
                        </button>
                        <a class="btn btn-sm btn-secondary text-light rounded-0">
                            <!--删除--><i class="iconfont icon-guanbi"></i>
                        </a>
                    </div>
                    <div class="collapse mt-5 pl-5" id="CommentField2">
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
                    <div class="collapse mt-5 pl-5" id="ForwardField2">
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

            <!--评论转发-->
            <div class="shadow card p-1 mb-3 bg-light rounded-0">
                <div class="card-body p-2">
                    <div class="media pb-3 border-bottom border-dark">
                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                             style="width: 64px; height: 64px;" alt="Generic placeholder image">
                        <div class="media-body">
                            <h5 class="mt-0 mr-auto">张楷</h5>
                            这是一条转发微博，这是一条转发微博这是一条转发微博，这是一条转发微博这是一条转发微博这是一条转发微博
                            <!--转发源-->
                            <div class="media mt-1 p-2" style="background-color: #e7e9ea;">
                                <div class="media-body">
                                    <h6 class="mt-0">张楷 的评论:</h6>
                                    <p class="my-0"><small>这是一条评论，这是一条评论，这是一条评论，这是一条评论，这是一条评论，这是一条评论，</small></p>
                                    <small><small class="text-muted">Last updated 10 mins ago</small></small>
                                </div>
                            </div>
                            <small class="text-muted">Last updated 5 mins ago</small>
                        </div>
                    </div>
                    <div class="btn-group btn-group-toggle mt-0 float-right" data-toggle="buttons">
                        <button class="btn btn-secondary btn-sm text-light rounded-0" type="button" data-toggle="collapse"
                                href="#CommentField3" aria-expanded="false" aria-controls="CommentField3">
                            <!--评论--><i class="iconfont icon-pinglun"></i>
                        </button>
                        <button class="btn btn-secondary btn-sm text-light rounded-0" type="button" data-toggle="collapse"
                                href="#ForwardField3" aria-expanded="false" aria-controls="ForwardField3">
                            <!--转发--><i class="iconfont icon-zhuanfa"></i>
                        </button>
                        <a class="btn btn-sm btn-secondary text-light rounded-0">
                            <!--删除--><i class="iconfont icon-guanbi"></i>
                        </a>
                    </div>
                    <div class="collapse mt-5 pl-5" id="CommentField3">
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
                    <div class="collapse mt-5 pl-5" id="ForwardField3">
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

            <!--图片-->
            <div class="shadow card p-1 mb-3 bg-light rounded-0">
                <div class="card-body p-2">
                    <div class="media pb-3 border-bottom border-dark">
                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                             style="width: 64px; height: 64px;" alt="Generic placeholder image">
                        <div class="media-body">
                            <h5 class="mt-0 mr-auto">张楷</h5>
                            这是一条转发微博，这是一条转发微博这是一条转发微博，这是一条转发微博这是一条转发微博这是一条转发微博
                            <!--图片-->
                            <div class="container w-50">
                                <div class="row">
                                    <div class="col p-1">
                                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                                             style="width: 100%; height: 100%;" alt="Generic placeholder image">
                                    </div>
                                    <div class="col p-1">
                                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                                             style="width: 100%; height: 100%;" alt="Generic placeholder image">
                                    </div>
                                    <div class="col p-1">
                                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                                             style="width: 100%; height: 100%;" alt="Generic placeholder image">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col p-1">
                                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                                             style="width: 100%; height: 100%;" alt="Generic placeholder image">
                                    </div>
                                    <div class="col p-1">
                                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                                             style="width: 100%; height: 100%;" alt="Generic placeholder image">
                                    </div>
                                    <div class="col p-1">
                                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                                             style="width: 100%; height: 100%;" alt="Generic placeholder image">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col p-1">
                                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                                             style="width: 100%; height: 100%;" alt="Generic placeholder image">
                                    </div>
                                    <div class="col p-1">
                                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                                             style="width: 100%; height: 100%;" alt="Generic placeholder image">
                                    </div>
                                    <div class="col p-1">
                                        <img class="mr-3" src="/static/image/8499E7D9D3C81B2499327ED102952501.png"
                                             style="width: 100%; height: 100%;" alt="Generic placeholder image">
                                    </div>
                                </div>
                            </div>
                            <small class="text-muted">Last updated 5 mins ago</small>
                        </div>
                    </div>
                    <div class="btn-group btn-group-toggle mt-0 float-right" data-toggle="buttons">
                        <button class="btn btn-secondary btn-sm text-light rounded-0" type="button" data-toggle="collapse"
                                href="#CommentField4" aria-expanded="false" aria-controls="CommentField4">
                            <!--评论--><i class="iconfont icon-pinglun"></i>
                        </button>
                        <button class="btn btn-secondary btn-sm text-light rounded-0" type="button" data-toggle="collapse"
                                href="#ForwardField4" aria-expanded="false" aria-controls="ForwardField4">
                            <!--转发--><i class="iconfont icon-zhuanfa"></i>
                        </button>
                        <a class="btn btn-sm btn-secondary text-light rounded-0">
                            <!--删除--><i class="iconfont icon-guanbi"></i>
                        </a>
                    </div>
                    <div class="collapse mt-5 pl-5" id="CommentField4">
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
                    <div class="collapse mt-5 pl-5" id="ForwardField4">
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
        </div>
    </div>
</main>
<script type="application/javascript">

</script>
<script src="/static/js/jquery-3.3.1.min.js"></script>
<script src="/static/js/bootstrap.bundle.min.js"></script>
</body>
</html>
