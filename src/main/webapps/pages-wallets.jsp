<%@ page import="java.util.*" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="org.category.*" %>
      <%@ page import="org.expense.*" %>
        <!DOCTYPE html>
        <html lang="en">
        <%@ include file="header.jsp" %>
          <% String user=(String)session.getAttribute("User"); wallet wal=new wallet(); List<wallet>
            w_list=wal.getWallets(user);
            System.out.println("pages-transaction "+user);
            System.out.println(w_list);
            %>

            <body>

              <%@ include file="navbar.jsp" %>
                <%@ include file="sidebar.jsp" %>


                  <main id="main" class="main">

                    <div class="pagetitle">
                      <h1>Wallets</h1>
                      <nav>
                        <ol class="breadcrumb">
                          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                          <li class="breadcrumb-item active">Wallets</li>
                        </ol>
                      </nav>
                    </div><!-- End Page Title -->

                    <section class="section dashboard">
                      <div class="row">
                        <!-- starts================================================ -->
                        <div class="card">
                          <div class="card-body">
                            <h5 class="card-title"><button class="btn btn-primary" type="button" data-bs-toggle="modal"
                                data-bs-target="#verticalycentered">
                                <i class="bi bi-plus-lg"></i>
                                New</button></h5>
                            <form id="wallet-form" class="needs-validation" novalidate onsubmit="addWallet(event)">
                              <div class="modal fade " id="verticalycentered" tabindex="-1" style="display: none;"
                                aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                  <div class="modal-content">
                                    <div class="modal-header">
                                      <h5 class="modal-title">New Wallet</h5>
                                      <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                    </div>

                                    <div class="modal-body">
                                      <!-- popup content -->

                                      <div class="field">
                                        <div class="row mb-3">
                                          <label for="inputText" class="col-sm-2 col-form-label">Wallet name</label>
                                          <div class="col-sm-10">
                                            <input type="text" id="wallet_name" class="form-control" value="My Wallet"
                                              required>
                                          </div>
                                        </div>
                                      </div>
                                      <div class="field">
                                        <div class="row mb-3">
                                          <label class="col-sm-2 col-form-label">Group</label>
                                          <div class="col-sm-10">
                                            <select class="form-select" id="group" aria-label="Default select example"
                                              onchange="edit(event)">
                                              <option selected="Cash">Cash</option>
                                              <option value="Card">Card</option>
                                              <option value="Account">Accout</option>
                                              <option value="Mobile Money">Mobile Money</option>
                                            </select>
                                          </div>
                                        </div>
                                      </div>
                                      <div class="field">
                                        <div class="row mb-3">
                                          <label for="inputText" class="col-sm-2 col-form-label">Group
                                            Description</label>
                                          <div class="col-sm-10">
                                            <input type="text" id="grp_desc" class="form-control" required disabled>
                                            <div class="invalid-feedback">Please enter Group Description!</div>
                                          </div>
                                        </div>
                                      </div>
                                      <div class="field">
                                        <div class="row mb-3">
                                          <label for="inputText" class="col-sm-2 col-form-label">Group Number</label>
                                          <div class="col-sm-10">
                                            <input type="text" id="grp_no" class="form-control" required disabled>
                                            <div class="invalid-feedback">Please enter Group Number!</div>
                                          </div>
                                        </div>
                                      </div>
                                      <div class="field">
                                        <div class="input-group mb-3">
                                          <label for="inputText" class="col-sm-2 col-form-label">Amount</label>
                                          <input type="number" id="amount" class="form-control" value="0" required>
                                          <span class="input-group-text" id="inputGroupPrepend">Tk</span>
                                        </div>
                                      </div>

                                      <!-- end popup content -->
                                    </div>

                                    <div class="modal-footer">
                                      <button type="reset" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Close</button>
                                      <button type="submit" class="btn btn-primary">Save
                                        changes</button>
                                    </div>
                                  </div>
                                </div>
                              </div><!-- End Vertically centered Modal-->
                            </form>
                            <!-- List group with custom content -->
                            <ul class="list-group list-group-flush">
                              <% for (int i=0; i < w_list.size(); i++) { wallet w=w_list.get(i); %>

                                <li class="list-group-item d-flex justify-content-between align-items-start">
                                  <div class="ms-2 me-auto">
                                    <div class="fw-bold">
                                      <%= w.name %>
                                    </div>
                                    <%= w.type %><br />
                                      <%= w.type_unique_name %><br />
                                        <%= w.type_unique_number %>
                                  </div>
                                  <span class="badge bg-primary rounded-pill">
                                    <%= w.amount %> Tk
                                  </span>
                                </li>
                                <% } %>
                            </ul><!-- End with custom content -->

                          </div>
                        </div>

                        <!-- ends -->
                      </div>

                    </section>

                  </main><!-- End #main -->

                  <%@ include file="footer.jsp" %>
            </body>
            <script type="text/javascript">
              function addWallet(event) {
                console.log('lalali')
                event.preventDefault(); // Prevent form from submitting
                var wallet_name = document.getElementById('wallet_name').value;
                var group = document.getElementById('group').value;
                var group_description = document.getElementById('grp_desc').value;
                var group_number = document.getElementById('grp_no').value;
                var amount = document.getElementById('amount').value;
                console.log(wallet_name + " " + group + " " + group_description + " " + group_number + " " + amount)
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "changePassword.jsp", true); // Posting to the same JSP page
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                  if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = xhr.responseText.trim();
                    if (response === "1") {
                      alert("Successfully created wallet");
                    } else if (response === "0") {
                      alert("Group description or Group number already exist!!!!");
                    } else {
                      // console.log(response)
                      alert("Error occurred. Response was " + response);

                    }
                    
                    document.getElementById('wallet_name').value='My Wallet'
                    document.getElementById('group').value = 'Cash'
                    document.getElementById('grp_desc').value = ''
                    document.getElementById('grp_no').value = ''
                    document.getElementById('amount').value = '0'
                    console.log(document.getElementById('grp_desc').attributes)
                  }
                };

                xhr.send("action=addWallet" +
                  "&wallet_name=" + encodeURIComponent(wallet_name) +
                  "&group=" + encodeURIComponent(group) +
                  "&group_description=" + encodeURIComponent(group_description) +
                  "&group_number=" + encodeURIComponent(group_number) +
                  "&amount=" + encodeURIComponent(amount));
              }
              function edit(event) {
                if (document.getElementById('group').value !== 'Cash') {
                  document.getElementById('grp_desc').removeAttribute('disabled');
                  document.getElementById('grp_no').removeAttribute('disabled');
                  document.getElementById('grp_desc').setAttribute('required', "true");
                  document.getElementById('grp_no').setAttribute('required', "true");
                }
                else if (document.getElementById('group').value === 'Cash') {

                  document.getElementById('grp_desc').setAttribute('disabled', "true");
                  document.getElementById('grp_no').setAttribute('disabled', "true");
                  document.getElementById('grp_desc').setAttribute('required', "false");
                  document.getElementById('grp_no').setAttribute('required', "false");
                }
              }
              function close(event) {
                console.log("fun")
                document.getElementById("wallet-form")
              }
            </script>

        </html>