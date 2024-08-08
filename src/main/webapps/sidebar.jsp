<!-- sidebar.jsp -->
<!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link " href="javascript:void(0);" onclick="loadEndpoint('index')">
          <i class="bi bi-house-door"></i>
          <span>Dashboard</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="javascript:void(0);" onclick="loadEndpoint('pages-transaction')">
          <i class="bi bi-cash-stack"></i>
           <span>Transactions</span>
        </a>
      </li><!-- End Transactions Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="javascript:void(0);" onclick="loadEndpoint('pages-recurring-exp')">
          <i class="ri-repeat-one-line"></i>
          <span>Recurring Expenses</span>
        </a>
      </li>
      <!-- End Contact Page Nav -->

        <li class="nav-item">
          <a class="nav-link collapsed" href="javascript:void(0);" onclick="loadEndpoint('pages-wallets')">
            <i class="bi bi-person-vcard"></i>
             <span>Wallets</span>
          </a>
        </li><!-- End Transactions Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="javascript:void(0);" onclick="loadEndpoint('pages-report')">
          <i class="bi bi-newspaper"></i>
           <span>Reports</span>
        </a>
      </li><!-- End Transactions Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="#">
          <i class="bi bi-cash-coin"></i>
           <span>Budget</span>
        </a>
      </li><!-- End Transactions Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="javascript:void(0);" onclick="loadEndpoint('pages-settings')">
          <i class="bi bi-gear"></i>
           <span>Settings</span>
        </a>
      </li><!-- End Transactions Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="javascript:void(0);" onclick="loadEndpoint('users-profile')">
          <i class="bi bi-person"></i>
          <span>Profile</span>
        </a>
      </li><!-- End Profile Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="javascript:void(0);" onclick="loadEndpoint('pages-register')">
          <i class="bi bi-card-list"></i>
          <span>Register</span>
        </a>
      </li><!-- End Register Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="javascript:void(0);" onclick="loadEndpoint('pages-login')">
          <i class="bi bi-box-arrow-in-right"></i>
          <span>Login</span>
        </a>
      </li><!-- End Login Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="javascript:void(0);" onclick="loadEndpoint('pages-special-thanks')">
          <i class="bi bi-tag"></i>
          <span>Special Thanks</span>
        </a>
      </li><!-- End F.A.Q Page Nav -->

    </ul>
    <script>
      function loadEndpoint(str) {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'http://localhost:9090/api/'+str, true);
        xhr.onreadystatechange = function () {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
              window.location.href = 'http://localhost:8080/PennyWiseJF/'+str;
            } else {
              console.error('Error:', xhr.statusText);
            }
          }
        };
        xhr.send();
      }
    </script>
  </aside><!-- End Sidebar-->