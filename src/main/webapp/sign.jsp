<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="parts/header.jsp" %>
<main class="container mt-4">
    <div class="shadow card p-3 mb-3 bg-light rounded-0 mx-auto" style="width: 25rem;">
        <h2 class="card-header rounded-0 border-bottom bg-light text-center">登陆或注册</h2>
        <div class="card-body">
            <form id="signIn-Form">
                <div class="form-group">
                    <label for="signIn-NickName">账户</label>
                    <input name="Nickname" type="text" class="form-control rounded-0" id="signIn-NickName"
                           placeholder="Nickname"
                           required>
                </div>

                <div class="form-group">
                    <label for="signIn-Password">密码</label>
                    <input name="Password" type="password" class="form-control rounded-0" id="signIn-Password"
                           placeholder="Password"
                           required>
                </div>

                <button type="button" class="btn btn-outline-success rounded-0" onclick="showSignUpForm();">注册</button>
                <!--
                <button id="SignIn-ResetPassword" type="button" class="btn btn-secondary rounded-0"
                        data-toggle="tooltip" data-placement="top" title="发送重置连接到您的邮箱" hidden="hidden">重置密码
                </button>
                -->
                <button id="SignIn-SignInButton" type="button" class="btn btn-primary rounded-0 float-right"
                        onclick="submitSignIn(this);">
                    登陆
                </button>
            </form>
            <form id="signUp-Form" hidden="hidden">
                <div class="form-group">
                    <label for="signUp-Mail">邮箱</label>
                    <input name="Mail" type="email" class="form-control rounded-0" id="signUp-Mail"
                           placeholder="Enter Mail" required>
                </div>

                <div class="form-group">
                    <label for="signUp-NickName">昵称</label>
                    <input name="Nickname" type="text" class="form-control rounded-0" id="signUp-NickName"
                           placeholder="Enter Nickname" required>
                </div>

                <div class="form-group">
                    <label for="signUp-Password">密码</label>
                    <input name="Password" type="password" class="form-control rounded-0" id="signUp-Password"
                           placeholder="Password" required>
                </div>

                <div class="form-group">
                    <label for="signUp-ConfirmPassword">确认密码</label>
                    <input name="confirmPassword" type="password" class="form-control rounded-0"
                           id="signUp-ConfirmPassword" placeholder="Password" required>
                </div>

                <button id="signUp-button" type="button" class="btn btn-primary rounded-0 float-right"
                        onclick="submitSignUp(this)">注册
                </button>
            </form>
        </div>
    </div>
</main>
<script type="text/javascript" src="/static/js/forge.min.js"></script>
<script type="application/javascript">
    function showSignUpForm() {
        document.getElementById("signUp-NickName").value = document.getElementById("signIn-NickName").value;
        document.getElementById("signUp-Password").value = document.getElementById("signIn-Password").value;
        document.getElementById("signIn-Form").setAttribute("hidden", "hidden");
        document.getElementById("signUp-Form").removeAttribute("hidden");
    }

    async function submitSignUp(button) {
        const B = new AnimeButton(button);

        const formData = new FormData(document.getElementById("signUp-Form"));
        if (formData.get("Password") !== formData.get("confirmPassword")) {
            B.Alert("btn btn-danger rounded-0 float-right disabled", "密码不符", 1000);
            return;
        }
        let data = formData.ToArray();
        delete(data.confirmPassword);

        let md = forge.md.sha256.create();
        md.update(data.Password);
        data.Password = md.digest().toHex();

        const Closer = B.OnLoding("disabled", "注册中...");

        const res = await JsonRequest("POST", "/signup", data);
        console.log(res);
        Closer();
        if (res.State === "Success") {
            window.location.href = "/";
        } else {
            B.Alert("btn btn-danger rounded-0 float-right disabled", res.Msg, 1000);
        }
    }

    async function submitSignIn(button) {
        const B = new AnimeButton(button);
        const formData = new FormData(document.getElementById("signUp-Form"));
        let data = formData.ToArray();

        let md = forge.md.sha256.create();
        md.update(data.Password);
        data.Password = md.digest().toHex();

        const Closer = B.OnLoding("disabled", "登陆中...");

        const res = await JsonRequest("POST", "/signin", data);
        console.log(res);
        Closer();
        if (res.State === "Success") {
            window.location.href = "/";
        } else {
            B.Alert("btn btn-danger rounded-0 float-right disabled", res.Msg, 1000);
        }
    }
</script>
<%@ include file="parts/footer.jsp" %>
