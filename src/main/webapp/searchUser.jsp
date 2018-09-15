<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="parts/header.jsp" %>
<main class="container mt-4">
    <h2>搜索结果</h2>
    <div id="searchList" class="list-group">
    </div>
    <div id="userTemplate" hidden>
        <a href="#" class="list-group-item list-group-item-action rounded-0">
            <div class="media">
                <img class="mr-3" src="http://cdn.v2ex.co/gravatar/{ProfilePic}?s=300&d=retro"
                     style="height: 5rem;">
                <div class="media-body">
                    <div class="card-title mb-2">
                        <span class="h5">{Nickname}</span>
                        <small {followhidden}>
                            <button class="btn btn-sm btn-primary rounded-0 float-right" type="button"
                                    onclick="Follow('{Nickname}');">关注
                            </button>
                        </small>
                        <small {disfollowhidden}>
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
    async function SearchUser(keywords) {
        const data = {
            "Keyword": keywords,
        };
        const res = await JsonRequest("POST", "/searchuser", data);
        console.log(res);
        if (res.State !== "Success") {
            return;
        }
        const userTemplate = document.getElementById("userTemplate").innerHTML;
        const searchList = document.getElementById("searchList");
        for (let user of res.Users) {
            if (user.Following === true) {
                user.followhidden = "hidden";
                user.disfollowhidden = "";
            } else {
                user.followhidden = "";
                user.disfollowhidden = "hidden";
            }
            searchList.innerHTML += userTemplate.format(user);
        }
    }

    window.onload = () => {
        SearchUser(localStorage.getItem(`skw`));
    };

    async function Follow(nickname) {
        const data = {
            "Nickname": nickname,
        };
        const res = await JsonRequest("POST", "/follow", data);
        if (res.State === "Success") {
            window.location.reload();
        } else {
            if (res.Msg === "User Not Login") {
                window.location.href = "/signin";
                return;
            }
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
</script>
<%@ include file="parts/footer.jsp" %>