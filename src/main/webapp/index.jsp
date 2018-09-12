<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="parts/header.jsp" %>
<main class="container w-50 my-4">
    <!--微博发布栏-->
    <div class="shadow card p-1 mb-3 bg-light rounded-0">
        <div class="card-body p-2">
            <div class="media-body">
                <form id="publishWeibo-Form">
                    <textarea name="Content" class="form-control mb-2 rounded-0"></textarea>
                    <input type="number" name="Forward" value="0" hidden>
                    <button class="btn btn-primary rounded-0 float-right" id="pubishWeibo-Button" type="button"
                            onclick="PublishWeibo(this)">发布
                    </button>
                    <label class="btn btn-primary rounded-0 my-auto float-right mx-2" for="images">上传图片</label>
                    <input name="Imgs" type="file" id="images" accept="image/png, image/jpeg" multiple
                           onchange="preview(this)" style="display: none;">
                    <div class="container mt-5 mb-3" id="preview">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="weiboList">

    </div>

    <!--转发模板-->
    <div id="forwardTemplate" hidden>
        <div class="media mt-1 p-2" style="background-color: #e7e9ea;">
            <a class="pr-3" href="#">
                <img src="http://cdn.v2ex.co/gravatar/{ProfilePic}?s=300&d=retro" style="width: 48px; height: 48px;">
            </a>
            <div class="media-body">
                <h6 class="mt-0">{Nickname}</h6>
                <p class="mb-0">
                    <small>{Content}</small>
                </p>
                <small>
                    <small class="text-muted">{Time}</small>
                </small>
            </div>
        </div>
    </div>

    <!--微博模板-->
    <div id="weiboTemplate" hidden>
        <div id="Weibo-{WeiboID}" class="shadow card p-1 mb-3 bg-light rounded-0">
            <div class="card-body p-2">
                <div class="media pb-3 border-bottom border-dark">
                    <img class="mr-3" src="http://cdn.v2ex.co/gravatar/{ProfilePic}?s=300&d=retro"
                         style="width: 64px; height: 64px;">
                    <div class="media-body">
                        <h5 class="mt-0 mr-auto">{Nickname}</h5>
                        <p class="my-0">{Content}</p>
                        {Forward}
                        <small class="text-muted">{Time}</small>
                    </div>
                </div>
                <div class="btn-group btn-group-toggle mt-0 float-right" data-toggle="buttons">
                    <button class="btn btn-secondary btn-sm text-light rounded-0" type="button" data-toggle="collapse"
                            href="#Weibo-{WeiboID}-Comment">
                        <!--评论--><i class="iconfont icon-pinglun"></i>
                    </button>
                    <a class="btn btn-sm btn-secondary text-light rounded-0" onclick="DeleteWeibo({WeiboID});"
                       {WeiboDeleteHidden}>
                        <!--删除--><i class="iconfont icon-guanbi"></i>
                    </a>
                </div>
                <div class="collapse mt-5 pl-5" id="Weibo-{WeiboID}-Comment">
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
                                        <i class="iconfont icon-guanbi"></i>
                                    </button>
                                </div>
                            </h6>
                            <small>对 <kbd>评论1</kbd> 说: 一条评论，一条评论，一条评论一条评论，一条评论</small>
                        </div>
                    </div>
                    <!-- 评论翻页 -->
                    <div class="btn-toolbar justify-content-center mt-3" role="toolbar">
                        <button id="Weibo-{WeiboID}-LoadComment" value="0" type="button"
                                class="btn btn-secondary btn-lg btn-block rounded-0"
                                onclick="LoadComment({WeiboID},this);">加载更多
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <button id="loadWeibo" value="0" type="button" class="btn btn-secondary btn-lg btn-block rounded-0"
            onclick="LoadWeibo();">加载更多
    </button>
</main>

<!--用户信息展示modal-->
<div class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog rounded-0" role="document">

        <h5>张楷</h5>
        <p>北京邮电大学学生</p>
        <button type="button" class="btn btn-primary rounded-0" onclick="this.innerHTML='取消关注';">关注</button>
    </div>
</div>
</div>

<script type="text/javascript">
    async function preview(file) {
        if (file.files.length > 9) {
            //TODO: 完善提醒
            alert("Too much img! max 9 imgs in one time");
            return;
        }
        const prevDiv = document.getElementById('preview');
        prevDiv.innerHTML = "";
        let count = 0;
        let reader = new FileReader();
        reader.onload = function (evt) {
            prevDiv.innerHTML += '<img src="' + evt.target.result +
                '" class="rounded-0 md-2 mt-2 ml-3 img-thumbnail w-25" />'; //w-25, style="width:100%"
        };
        reader.onloadend = function () {
            if (++count < file.files.length) {
                reader.readAsDataURL(file.files[count]);
            }
        };
        reader.readAsDataURL(file.files[count]);
    }

    async function DeleteWeibo(weiboid) {
        const data = {
            "WeiboID": weiboid,
        };
        console.log(weiboid);
        const res = await JsonRequest("DELETE", "/weibo", data);
        if (res.State === "Success") {
            window.location.reload();
        } else {
            alert("该条微博不属于你");
        }
    }

    async function PublishWeibo(button) {
        const B = new AnimeButton(button);
        const formData = new FormData(document.getElementById("publishWeibo-Form"));
        let data = formData.ToArray();
        if (data.Content.length > 255) {
            B.Alert("btn btn-danger rounded-0 float-right disabled", "字数过多", 1000);
        } else if (data.Content.length < 5) {
            B.Alert("btn btn-danger rounded-0 float-right disabled", "字数过少", 1000);
        }
        data.Imgs = [];
        const Closer = B.OnLoding("disabled", "发布中...");
        const res = await JsonRequest("POST", "/weibo", data);
        console.log(res);
        Closer();
        if (res.State === "Success") {
            B.Alert("btn btn-success rounded-0 float-right", res.Msg, 1000);
            window.location.reload();
        } else {
            B.Alert("btn btn-danger rounded-0 float-right disabled", res.Msg, 1000);
        }
    }

    async function LoadWeibo() {
        const offset = document.getElementById("loadWeibo").value;
        const res = await JsonRequest("GET", "/weibo?Num=5&Offset=" + offset, undefined);
        document.getElementById("loadWeibo").value += 5;
        console.log(res);
        if (res.State !== "Success") {
            return;
        }
        const nickname = document.getElementById("nickname").innerHTML;
        const forwardTemplate = document.getElementById("forwardTemplate").innerHTML;
        const weiboTemplate = document.getElementById("weiboTemplate").innerHTML;
        let weiboList = document.getElementById("weiboList");
        for (let weibo of res.WeiboList) {
            console.log(weibo);
            if (weibo.hasOwnProperty("Forward")) {
                weibo.Forward.Time = FormatTime(new Date(weibo.Forward.Time).toLocaleString());
                weibo.Forward = forwardTemplate.format(weibo.Forward);
            } else {
                weibo.Forward = "";
            }
            if (weibo.Nickname === nickname) {
                weibo.WeiboDeleteHidden = "";
            } else {
                weibo.WeiboDeleteHidden = "hidden";
            }
            weibo.Time = FormatTime(new Date(weibo.Time).toLocaleString());
            weiboList.innerHTML += weiboTemplate.format(weibo);
        }
    }
    window.onload = () => LoadWeibo();
</script>
<%@ include file="parts/footer.jsp" %>