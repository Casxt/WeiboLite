<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="parts/header.jsp" %>
<main class="container mt-4 mb-4">
    <div class="row">
        <div class="col">
            <h2>关注我的</h2>
            <div id="followMeList" class="list-group mb-2">

            </div>
        </div>
        <div id="myFollowList" class="col">
            <h2>我的关注</h2>
            <div class="list-group mb-2">
            </div>

        </div>
    </div>

    <div id="followMeTemplate" hidden>
        <a href="#" class="list-group-item list-group-item-action rounded-0">
            <div class="media">
                <img class="mr-3" src="http://cdn.v2ex.co/gravatar/{ProfilePic}?s=300&d=retro"
                     style="height: 5rem;">
                <div class="media-body">
                    <div class="card-title mb-2">
                        <span class="h5">{Nickname}</span>
                        <small {followuserhidden}>
                            <button class="btn btn-sm btn-primary rounded-0 float-right " type="button"
                                    onclick="Follow('{Nickname}');">关注
                            </button>
                        </small>
                    </div>
                    <small class="my-0"></small>
                </div>
            </div>
        </a>
    </div>

    <div id="myFollowTemplate" hidden>
        <a href="#" class="list-group-item list-group-item-action rounded-0">
            <div class="media">
                <img class="mr-3" src="http://cdn.v2ex.co/gravatar/{ProfilePic}?s=300&d=retro"
                     style="height: 5rem;">
                <div class="media-body">
                    <div class="card-title mb-2">
                        <span class="h5">{Nickname}</span>
                        <small>
                            <button class="btn btn-sm btn-primary rounded-0 float-right" type="button"
                                    onclick="Disfollow('{Nickname}');">取消关注
                            </button>
                        </small>
                    </div>
                    <small class="my-0"></small>
                </div>
            </div>
        </a>
    </div>
</main>
<script type="application/javascript">

    async function Follow(nickname) {
        const data = {
            "Nickname": nickname,
        };
        const res = await JsonRequest("POST", "/follow", data);
        if (res.State === "Success") {
            window.location.reload();
        } else {
            alert(res.Msg);
        }
    }

    async function Disfollow(nickname) {
        const data = {
            "Nickname": nickname,
        };
        const res = await JsonRequest("DELETE", "/follow", data);
        if (res.State === "Success") {
            window.location.reload();
        } else {
            alert(res.Msg);
        }
    }

    async function LoadFollow() {
        const res = await JsonRequest("GET", "/follow", undefined);
        console.log(res);
        if (res.State !== "Success") {
            return;
        }
        //const nickname = document.getElementById("nickname").innerHTML;
        const followMeTemplate = document.getElementById("followMeTemplate").innerHTML;
        const myFollowTemplate = document.getElementById("myFollowTemplate").innerHTML;
        const followMeList = document.getElementById("followMeList");
        const myFollowList = document.getElementById("myFollowList");
        for (let follow of res.Follow) {
            if (follow.Following === true) {
                follow.followuserhidden = "hidden";
            } else {
                follow.followuserhidden = "";
            }

            if (follow.Following === true) {
                myFollowList.innerHTML += myFollowTemplate.format(follow);
            }
            if (follow.FollowMe === true) {
                followMeList.innerHTML += followMeTemplate.format(follow);
            }
        }
    }

    window.onload = () => LoadFollow();
</script>
<%@ include file="parts/footer.jsp" %>