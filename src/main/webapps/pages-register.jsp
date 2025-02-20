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
                  <a href="index.jsp" class="logo d-flex align-items-center w-auto">
                    <img src="assets/img/logo.png" alt="">
                    <span class="d-none d-lg-block">NiceAdmin</span>
                  </a>
                </div><!-- End Logo -->

                <div class="card mb-3">

                  <div class="card-body">

                    <div class="pt-4 pb-2">
                      <h5 class="card-title text-center pb-0 fs-4">Create an Account</h5>
                      <p class="text-center small">Enter your personal details to create account</p>
                    </div>
                    <form class="row g-3 needs-validation" novalidate  onsubmit="register(event)">
                      <div class="col-md-6">
                        <div class="form-floating mb-3">
                          <input type="text" name="name" class="form-control" id="fn" placeholder="First Name">
                          <label for="floatingInput">First Name</label>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-floating mb-3">
                          <input type="text" name="name" class="form-control" id="ln" placeholder="Last Name">
                          <label for="floatingInput">Last Name</label>
                        </div>
                      </div>
                      <div class="col-12">
                        <div class="form-floating mb-3">
                          <input type="email" name="email" class="form-control" id="email" placeholder="Email" required>
                          <label for="floatingInput">Email</label>
                          <div class="invalid-feedback">Please, enter your email!</div>
                        </div>
                      </div>
                      <div class="col-12">
                        <label for="yourUsername" class="form-label">Username</label>
                        <div class="input-group form-floating mb-3">
                          <span class="input-group-text" id="inputGroupPrepend">@</span>
                          <input type="text" name="username" class="form-control" id="un" placeholder="Username"
                            aria-label="Username" aria-describedby="basic-addon1" required>
                          <!-- <label for="floatingInput" >Username</label> -->
                          <div class="invalid-feedback">Please choose a username.</div>
                        </div>
                        
                      </div>

                      <div class="col-12">
                        <div class="form-floating mb-3">
                          <input type="password" name="password" class="form-control" id="pswd" placeholder="Password" required>
                          <label for="floatingInput">Password</label>
                          <div class="invalid-feedback">Please enter your password!</div>
                        </div>
                      </div>
                      <div class="col-12">
                        <div class="form-check">
                          <input class="form-check-input" name="terms" type="checkbox" value="" id="acceptTerms"
                            required>
                          <label class="form-check-label" for="acceptTerms">I agree and accept the <a href="#">terms and
                              conditions</a></label>
                          <div class="invalid-feedback">You must agree before submitting.</div>
                        </div>
                      </div>
                      <div class="col-12">
                        <button class="btn btn-primary w-100" type="submit">Create
                          Account</button>
                      </div>
                      <div class="col-12">
                        <p class="small mb-0">Already have an account? <a href="pages-login.jsp">Log in</a></p>
                      </div>
                    </form>


                  </div>
                </div>

                <div class="credits">
                  <!-- All the links in the footer should remain intact. -->
                  <!-- You can delete the links only if you purchased the pro version. -->
                  <!-- Licensing information: https://bootstrapmade.com/license/ -->
                  <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
                  Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
                </div>

              </div>
            </div>
          </div>

        </section>

      </div>
    </main><!-- End #main -->

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>

    <!-- Vendor JS Files -->
    <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/chart.js/chart.umd.js"></script>
    <script src="assets/vendor/echarts/echarts.min.js"></script>
    <script src="assets/vendor/quill/quill.js"></script>
    <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="assets/vendor/tinymce/tinymce.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>

    <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>

  </body>
  <script type="text/javascript">
    function register(event) {
      event.preventDefault(); // Prevent form from submitting
      var fn = document.getElementById('fn').value;
      var ln = document.getElementById('ln').value;
      var email = document.getElementById('email').value;
      var un = document.getElementById('un').value;
      var pswd = document.getElementById('pswd').value;
      console.log(fn + " " + ln + " " + email + " " + un + " " + pswd)
      var xhr = new XMLHttpRequest();
      xhr.open("POST", "changePassword.jsp", true); // Posting to the same JSP page
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          var response = xhr.responseText.trim();
          if (response === "1") {
            window.alert("Successfully logged in, "+'<%= session.getAttribute("name") %>');
            window.location = "pages-login.jsp"
          } else if (response === "0") {
            alert("Username already exits!!!!");
            window.location = "pages-login.jsp";
          } else {
            // console.log(response)
            alert("Error occurred. Response was " + response);

          }
        }
      };

      xhr.send("action=register" +
        "&fn=" + encodeURIComponent(fn) +
        "&ln=" + encodeURIComponent(ln) +
        "&email=" + encodeURIComponent(email) +
        "&un=" + encodeURIComponent(un) +
        "&ps=" + encodeURIComponent(pswd));
    }

  </script>

</html>