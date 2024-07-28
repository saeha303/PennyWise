<!DOCTYPE html>
<html lang="en">

<%@ include file="header.jsp" %>

  <body>

    <%@ include file="navbar.jsp" %>
      <%@ include file="sidebar.jsp" %>

        <main id="main" class="main">

          <div class="pagetitle">
            <h1>Settings</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                <li class="breadcrumb-item active">Settings</li>
              </ol>
            </nav>
          </div><!-- End Page Title -->

          <section class="section">
            <div class="row">
              <div class="col-lg-6">

                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Data Import</h5>
                    

                    <div class="mt-dataImport col-sm-10">
                      <p>Import transactions from a csv file</p>
                      <button class="btn btn-primary" type="button" id="fileButton">
                        <i class="bi bi-file-earmark-plus"></i> Open File
                      </button>
                      <input type="file" accept="text/csv" id="fileInput">

                    </div>
                  </div>
                </div>

              </div>
              <div class="col-lg-6">

                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Data Export</h5>

                    <div class="col-sm-10">
                    <p>Export transactions to a JSON file</p>
                    <button class="btn btn-primary" type="button" id="fileButton">
                                            <i class="bi bi-file-earmark-plus"></i> Export JSON File
                                          </button>
                    </div>
                  </div>
                </div>

              </div>


            </div>
          </section>

        </main><!-- End #main -->

        <%@ include file="footer.jsp" %>

  </body>
  <script>
    document.getElementById('fileButton').addEventListener('click', function() {
      document.getElementById('fileInput').click();
    });
  </script>
</html>