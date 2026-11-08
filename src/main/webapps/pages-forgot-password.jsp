<!DOCTYPE html>
<html lang="en">

<%@ include file="header.jsp" %>
<body>

  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="indexGuest.jsp" class="logo d-flex align-items-center w-auto">
                  <img src="assets/img/logo.png" alt="">
                  <span class="d-none d-lg-block">PennyWise</span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Reset Your Password</h5>
                    <p class="text-center small">Enter your username and the email on your account, then choose a new password</p>
                  </div>

                  <form class="row g-3 needs-validation" novalidate onsubmit="resetPassword(event)">

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">Username</label>
                      <div class="input-group has-validation">
                        <span class="input-group-text">@</span>
                        <input type="text" name="username" class="form-control" id="yourUsername" required>
                        <div class="invalid-feedback">Please enter your username.</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourEmail" class="form-label">Email</label>
                      <input type="email" name="email" class="form-control" id="yourEmail" required>
                      <div class="invalid-feedback">Please enter the email on your account.</div>
                    </div>

                    <div class="col-12">
                      <label for="newPassword" class="form-label">New Password</label>
                      <input type="password" name="newPassword" class="form-control" id="newPassword" required>
                      <div class="invalid-feedback">Please enter a new password.</div>
                    </div>

                    <div class="col-12">
                      <label for="renewPassword" class="form-label">Re-enter New Password</label>
                      <input type="password" name="renewPassword" class="form-control" id="renewPassword" required>
                      <div class="invalid-feedback">Please re-enter the new password.</div>
                    </div>

                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">Reset Password</button>
                    </div>
                    <div class="col-12">
                      <p class="small mb-0">Remembered it? <a href="pages-login.jsp">Back to login</a></p>
                    </div>
                  </form>

                </div>
              </div>

            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- End #main -->

  <!-- Vendor JS Files -->
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>
<script type="text/javascript">
  function resetPassword(event) {
    event.preventDefault();
    var form = event.target;
    if (!form.checkValidity()) {
      form.classList.add('was-validated');
      return;
    }
    var username = document.getElementById('yourUsername').value.trim();
    var email = document.getElementById('yourEmail').value.trim();
    var newPassword = document.getElementById('newPassword').value;
    var renewPassword = document.getElementById('renewPassword').value;
    if (newPassword !== renewPassword) {
      alert("New passwords do not match");
      return;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "changePassword.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4 && xhr.status === 200) {
        var response = xhr.responseText.trim();
        if (response === "1") {
          alert("Password reset successfully. Please log in with your new password.");
          window.location = "pages-login.jsp";
        } else if (response === "4") {
          alert("No account matches that username and email.");
        } else if (response === "5") {
          alert("New passwords do not match");
        } else if (response === "6") {
          alert("Please enter a new password.");
        } else {
          alert("Error occurred. Response was " + response);
        }
      }
    };

    xhr.send("action=resetPassword" +
      "&username=" + encodeURIComponent(username) +
      "&email=" + encodeURIComponent(email) +
      "&newPassword=" + encodeURIComponent(newPassword) +
      "&renewPassword=" + encodeURIComponent(renewPassword));
  }
</script>
</html>
