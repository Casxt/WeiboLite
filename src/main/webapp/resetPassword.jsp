<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="parts/header.jsp" %>
<main class="container mt-4">
    <div class="shadow card p-3 mb-3 bg-light rounded-0 mx-auto" style="width: 25rem;">
        <h2 class="card-header rounded-0 border-bottom bg-light text-center">重置密码</h2>
        <div class="card-body">
            <form id="resetPassword-Form">
                <div class="form-group">
                    <label for="resetPassword-Email">旧密码</label>
                    <input name="OldPassword" type="password" class="form-control rounded-0" id="resetPassword-Email"
                           aria-describedby="emailHelp" placeholder="Enter Old Password" required>
                </div>

                <div class="form-group">
                    <label for="resetPassword-Password">新密码</label>
                    <input name="NewPassword" type="password" class="form-control rounded-0" id="resetPassword-Password"
                           placeholder="Password" required>
                </div>

                <div class="form-group">
                    <label for="resetPassword-ConfirmPassword">确认新密码</label>
                    <input name="ConfirmNewPassord" type="password" class="form-control rounded-0"
                           id="resetPassword-ConfirmPassword" placeholder="Password" required>
                </div>

                <button type="button" class="btn btn-primary rounded-0 float-right" onclick="ResetPassword(this);">重置
                </button>
            </form>
        </div>
    </div>
</main>
<script type="text/javascript" src="/static/js/forge.min.js"></script>
<script type="application/javascript">
    async function ResetPassword(button) {
        const B = new AnimeButton(button);
        const formData = new FormData(document.getElementById("resetPassword-Form"));
        let data = formData.ToArray();
        if (formData.get("NewPassword") !== formData.get("ConfirmNewPassord")) {
            B.Alert("btn btn-danger rounded-0 float-right disabled", "密码不符", 1000);
            return;
        }
        console.log(data);
        let md = forge.md.sha256.create();
        md.update(data.OldPassword);
        data.OldPassword = md.digest().toHex();

        md = forge.md.sha256.create();
        md.update(data.NewPassword);
        data.NewPassword = md.digest().toHex();

        delete(data.ConfirmNewPassword);

        const Closer = B.OnLoding("disabled", "重置中...");

        const res = await JsonRequest("POST", "/resetpassword", data);
        console.log(res);
        Closer();
        if (res.State === "Success") {
            B.Alert("btn btn-success rounded-0 float-right disabled", res.Msg, 1000);
        } else {
            B.Alert("btn btn-danger rounded-0 float-right disabled", res.Msg, 1000);
        }
    }
</script>
<%@ include file="parts/footer.jsp" %>
