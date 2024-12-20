<header id="header" class="header d-flex align-items-center fixed-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center">

      <a href="indexGuest.jsp" class="logo d-flex align-items-center me-auto">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <img src="assets/img/logo.png" alt="">
        <h1 class="sitename">PennyWise</h1>
      </a>

      <nav id="navmenu" class="navmenu">
        <ul>
          <li><a href="#hero" class="active">Home<br></a></li>
          <li><a href="#services">What We Offer</a></li>
          <li><a href="#advantage">What's The Catch</a></li>
          <li><a href="#demo">How To</a></li>
          <li><a href="#team">Our Team</a></li>
          <li><a href="#contact">Contact Us</a></li>
        </ul>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>

      <a class="btn-getstarted flex-md-shrink-0" href="javascript:void(0);" onclick="loadEndpoint('pages-login')">Get Started</a>

    </div>
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
  </header>