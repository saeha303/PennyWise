<!-- <%@ page import="java.util.*" %>
  <%@ page import="org.register.signin" %> -->
<!DOCTYPE html>
<html lang="en">

<!-- <% request.setAttribute("tab_var", "Dashboard" ); %>
      <jsp:include page="header.jsp">
        <jsp:param name="tab_var" value="Dashboard" />
      </jsp:include> -->
<%@ include file="header.jsp" %>

  <body>

    <%@ include file="navbar.jsp" %>
      <%@ include file="sidebar.jsp" %>

        <main id="main" class="main">

          <div class="pagetitle">
            <h1>Profile</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item">Users</li>
                <li class="breadcrumb-item active">Profile</li>
              </ol>
            </nav>
          </div><!-- End Page Title -->

          <section class="section profile">
            <div class="row">
              <div class="col-xl-4">

                <div class="card">
                  <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

                    <img src="assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
                    <h2>John Doe</h2>
                  </div>
                </div>

              </div>

              <div class="col-xl-8">

                <div class="card">
                  <div class="card-body pt-3">
                    <!-- Bordered Tabs -->
                    <ul class="nav nav-tabs nav-tabs-bordered">

                      <li class="nav-item">
                        <button class="nav-link active" data-bs-toggle="tab"
                          data-bs-target="#profile-overview">Overview</button>
                      </li>

                      <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit
                          Profile</button>
                      </li>

                      <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change
                          Password</button>
                      </li>

                    </ul>
                    <div class="tab-content pt-2">

                      <div class="tab-pane fade show active profile-overview" id="profile-overview">
                        <h5 class="card-title">About</h5>
                        <p class="small fst-italic">Sunt est soluta temporibus accusantium neque nam maiores cumque
                          temporibus. Tempora libero non est unde veniam est qui dolor. Ut sunt iure rerum quae quisquam
                          autem eveniet perspiciatis odit. Fuga sequi sed ea saepe at unde.</p>

                        <h5 class="card-title">Profile Details</h5>

                        <div class="row">
                          <div class="col-lg-3 col-md-4 label ">Full Name</div>
                          <div class="col-lg-9 col-md-8">John Doe</div>
                        </div>

                        <div class="row">
                          <div class="col-lg-3 col-md-4 label">Phone</div>
                          <div class="col-lg-9 col-md-8">(436) 486-3538 x29071</div>
                        </div>

                        <div class="row">
                          <div class="col-lg-3 col-md-4 label">Email</div>
                          <div class="col-lg-9 col-md-8">john_doe@example.com</div>
                        </div>

                      </div>

                      <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                        <!-- Profile Edit Form -->
                        <form>
                          <div class="row mb-3">
                            <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
                            <div class="col-md-8 col-lg-9">
                              <img src="assets/img/profile-img.jpg" alt="Profile">
                              <div class="pt-2">
                                <a href="#" class="btn btn-primary btn-sm" title="Upload new profile image"><i
                                    class="bi bi-upload"></i></a>
                                <a href="#" class="btn btn-danger btn-sm" title="Remove my profile image"><i
                                    class="bi bi-trash"></i></a>
                              </div>
                            </div>
                          </div>

                          <div class="row mb-3">
                            <label for="fullName" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                            <div class="col-md-8 col-lg-9">
                              <input name="fullName" type="text" class="form-control" id="fullName"
                                value="John Doe">
                            </div>
                          </div>

                          <div class="row mb-3">
                            <label for="Phone" class="col-md-4 col-lg-3 col-form-label">Phone</label>
                            <div class="col-md-8 col-lg-9">
                              <input name="phone" type="text" class="form-control" id="Phone"
                                value="(436) 486-3538 x29071">
                            </div>
                          </div>

                          <div class="row mb-3">
                            <label for="Email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                            <div class="col-md-8 col-lg-9">
                              <input name="email" type="email" class="form-control" id="Email"
                                value="john_doe@example.com">
                            </div>
                          </div>

                          <div class="text-center">
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                          </div>
                        </form><!-- End Profile Edit Form -->

                      </div>

                      <div class="tab-pane fade pt-3" id="profile-change-password">
                        <!-- Change Password Form -->
                        <form>

                          <div class="row mb-3">
                            <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current
                              Password</label>
                            <div class="col-md-8 col-lg-9">
                              <input name="password" type="password" class="form-control" id="currentPassword">
                            </div>
                          </div>

                          <div class="row mb-3">
                            <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                            <div class="col-md-8 col-lg-9">
                              <input name="newpassword" type="password" class="form-control" id="newPassword">
                            </div>
                          </div>

                          <div class="row mb-3">
                            <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New
                              Password</label>
                            <div class="col-md-8 col-lg-9">
                              <input name="renewpassword" type="password" class="form-control" id="renewPassword">
                            </div>
                          </div>

                          <div class="text-center">
                            <button type="submit" class="btn btn-primary" onClick="changePasswd(event)">Change
                              Password</button>
                          </div>
                        </form><!-- End Change Password Form -->

                      </div>

                    </div><!-- End Bordered Tabs -->

                  </div>
                </div>

              </div>
            </div>
          </section>

        </main><!-- End #main -->

        <%@ include file="footer.jsp" %>
  </body>
  <script type="text/javascript">
    function changePasswd(event) {
      event.preventDefault(); // Prevent form from submitting
      var currentPassword = document.getElementById('currentPassword').value;
      var newPassword = document.getElementById('newPassword').value;
      var renewPassword = document.getElementById('renewPassword').value;

      var xhr = new XMLHttpRequest();
      xhr.open("POST", "changePassword.jsp", true); // Posting to the same JSP page
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          var response = xhr.responseText.trim();
          console.log(response)
          if (response === "1") {
            console.log("1")
            alert("Password changed successfully.");
            // Switch to the "Overview" tab
            var overviewTab = document.querySelector('button[data-bs-target="#profile-overview"]');
            var changePasswordTab = document.querySelector('button[data-bs-target="#profile-change-password"]');

            // Handle Bootstrap tab activation
            var tabButtons = document.querySelectorAll('.nav-link');
            tabButtons.forEach(function (button) {
              button.classList.remove('active');
            });

            overviewTab.classList.add('active');
            document.querySelector('#profile-overview').classList.add('show', 'active');

            changePasswordTab.classList.remove('active');
            document.querySelector('#profile-change-password').classList.remove('show', 'active');
          } else if (response === "2") {
            console.log("2")
            alert("Current password does not match.");
          } else if (response === "5") {
            console.log("5")
            alert("New passwords do not match.");
          } else {
            // console.log(response)
            alert("Error occurred. Response was " + response);
          }
        }
      };

      xhr.send("action=changePassword" +
        "&currentPassword=" + encodeURIComponent(currentPassword) +
        "&newPassword=" + encodeURIComponent(newPassword) +
        "&renewPassword=" + encodeURIComponent(renewPassword));
    }
  </script>

</html>