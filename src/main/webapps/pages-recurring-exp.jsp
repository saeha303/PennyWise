<%@ page import="java.util.*" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="org.category.*" %>
      <%@ page import="org.expense.*" %>
        <%@ page import="com.google.gson.*" %>
          <!DOCTYPE html>
          <html lang="en">
          <%@ include file="header.jsp" %>
            <% String user=(String)session.getAttribute("User"); wallet wal=new wallet(); List<wallet>
              w_list=wal.getWallets(user);
              category cat=new category(); wallet w=new wallet();
              List<category>
                cat_list=cat.getCategories();
                List<recurring> recur_list=new recurring().getRecurExpenses(user);
                  String tab_var1="" ; String btn_txt="" ;
                  %>

                  <body>
                    <%@ include file="navbar.jsp" %>
                      <%@ include file="sidebar.jsp" %>
                        <main id="main" class="main">
                          <div class="pagetitle">
                            <h1>Recurring Expenses</h1>
                            <nav>
                              <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                <li class="breadcrumb-item active">Recurring Expenses</li>
                              </ol>
                            </nav>
                          </div><!-- End Page Title -->

                          <section class="section dashboard">
                            <div class="row">
                              <!-- starts================================================ -->
                              <div class="card">
                                <div class="card-body">
                                  <h5 class="card-title"><button class="btn btn-primary" type="button"
                                      data-bs-toggle="modal" data-bs-target="#verticalycentered">
                                      <i class="bi bi-plus-lg"></i>
                                      New</button>
                                    <!-- <a class="button-link btn btn-primary" href="#pay-recur-exp">
                                  <i class="bi bi-wallet2"></i>
                                  Pay</a> -->
                                  </h5>
                                  <form id="expense-form" class="needs-validation" novalidate
                                    onsubmit="addRecurExpense(event)">
                                    <div class="modal fade " id="verticalycentered" tabindex="-1" style="display: none;"
                                      aria-hidden="true">
                                      <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                          <div class="modal-header">
                                            <h5 class="modal-title">New Recurring Expenses</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                              aria-label="Close"></button>
                                          </div>

                                          <div class="modal-body">
                                            <!-- popup content -->

                                            <div class="field">
                                              <div class="row mb-3">
                                                <label for="inputText" class="col-sm-2 col-form-label">Wallet
                                                  name</label>
                                                <div class="col-sm-10">
                                                  <select class="form-select" id="walletSelect5""
                                                    aria-label="Default select example">
                                                    <option disabled selected value="">--Select Wallet--</option>
                                                    <% for (int i=0; i < w_list.size(); i++) { %>
                                                      <% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){
                                                        %>
                                                        <option name="wallet_options" value="<%= w_list.get(i).name %>">
                                                          <%= w.getName(w_list.get(i).name) %>
                                                            <% } %>
                                                              <% } %>
                                                        </option>
                                                  </select>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="field">
                                              <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label">Category</label>
                                                <div class="col-sm-10">
                                                  <select class="form-select" aria-label="Default select example"
                                                    id="category">
                                                    <option disabled selected>--Select Category--</option>
                                                    <% for (int i=0; i < cat_list.size(); i++) { %>
                                                      <option name="category_options"
                                                        value="<%= cat_list.get(i).name %>">
                                                        <%= cat_list.get(i).name %>
                                                          <% } %>
                                                      </option>
                                                  </select>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="field">
                                              <div class="row mb-3">
                                                <label for="inputText" class="col-sm-2 col-form-label">Frequency</label>
                                                <div class="col-sm-10">
                                                  <select class="form-select" aria-label="Default select example"
                                                    id="frequency">
                                                    <option selected>--Select Frequency--</option>
                                                    <option value="Daily">Daily</option>
                                                    <option value="Weekly">Weekly</option>
                                                    <option value="Monthly">Monthly</option>
                                                    <option value="Yearly">Yearly</option>
                                                  </select>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="field">
                                              <div class="row mb-3">
                                                <label for="inputText" class="col-sm-2 col-form-label">Start
                                                  Date</label>
                                                <div class="col-sm-10">
                                                  <div class="input-group mb-3">
                                                    <input type="date" class="form-control" id="start_date">
                                                  </div>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="field">
                                              <div class="row mb-3">
                                                <label for="inputText" class="col-sm-2 col-form-label">End Date</label>
                                                <div class="col-sm-10">
                                                  <div class="input-group mb-3">
                                                    <input type="date" class="form-control" id="end_date">
                                                  </div>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="field">
                                              <div class="row mb-3">
                                                <label for="inputText" class="col-sm-2 col-form-label">Time of
                                                  Remainder</label>
                                                <div class="col-sm-10">
                                                  <div class="input-group mb-3">
                                                    <input type="time" class="form-control" id="time">
                                                  </div>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="field">
                                              <div class="row mb-3">
                                                <label for="inputText" class="col-sm-2 col-form-label">Note</label>
                                                <div class="col-sm-10">
                                                  <div class="input-group mb-3">
                                                    <input type="text" class="form-control" id="note">
                                                  </div>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="field">
                                              <div class="input-group mb-3">
                                                <label for="inputText" class="col-sm-2 col-form-label">Amount</label>
                                                <input type="number" id="amount" class="form-control" value="0"
                                                  required>
                                                <span class="input-group-text" id="inputGroupPrepend">Tk</span>
                                              </div>
                                            </div>

                                            <!-- end popup content -->
                                          </div>

                                          <div class="modal-footer">
                                            <button type="reset" class="btn btn-secondary"
                                              data-bs-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary" onclick="close(event)">Save
                                              changes</button>
                                          </div>
                                        </div>
                                      </div>
                                    </div><!-- End Vertically centered Modal-->
                                  </form>
                                  <section id="remaining_recur_exp" class="values section">
                                    <!-- Section Title -->
                                    <div class="container section-title" data-aos="fade-up">
                                      <p>Enlisted Expenses<br></p>
                                      <!-- List group with custom content -->
                                      <ul class="list-group list-group-flush">
                                        <% for (int i=0; i < recur_list.size(); i++) { recurring r=recur_list.get(i); %>

                                          <li class="list-group-item d-flex justify-content-between align-items-start">
                                            <div class="ms-2 me-auto">
                                              <div class="fw-bold">
                                                <%= r.details %>
                                              </div>
                                              <%= r.category %><br />
                                                <%= r.start_date %><br />
                                                  <%= r.time %> <i class="bi bi-bell-fill"></i><br />
                                                    <a class="btn-link btn" href="#pay-recur-exp"
                                                      onclick="document.getElementById('vernon').value='<%= r.wallet %>';document.getElementById('joshua').value=<%= i %>;updateGroupOptions(6)">
                                                      <i class="bi bi-wallet2"></i>
                                                      Pay</a>
                                            </div>
                                            <input type="hidden" id="vernon" value="">
                                            <input type="hidden" id="joshua" value="">
                                            <span class="badge bg-primary rounded-pill">
                                              <%= r.amount %> Tk</br>
                                            </span>
                                          </li>
                                          <% } %>
                                      </ul><!-- End with custom content -->
                                    </div><!-- End Section Title -->
                                  </section>
                                  <section id="pay-recur-exp" class="values section" style="padding-top: 30px;">
                                    <!-- Section Title -->
                                    <div class="container section-title" data-aos="fade-up">
                                      <p>Pay Expenses<br></p>
                                      <% tab_var1="From" ; btn_txt="Add Expense" ; %>
                                        <%@ include file="recurExpenseTransaction.jsp" %>
                                    </div><!-- End Section Title -->
                                  </section>
                                </div>
                              </div>

                              <!-- ends -->
                            </div>

                          </section>

                        </main><!-- End #main -->

                        <%@ include file="footer.jsp" %>
                  </body>
                  <script type="text/javascript">
                    function addRecurExpense(event) {
                      console.log('lalali')
                      event.preventDefault(); // Prevent form from submitting
                      const username = '<%= (String)session.getAttribute("User") %>'
                      var wallet_name = document.getElementById('walletSelect5').value;
                      var category = document.getElementById('category').value;
                      var frequency = document.getElementById('frequency').value;
                      var start_date = document.getElementById('start_date').value;
                      var end_date = document.getElementById('end_date').value;
                      var time = document.getElementById('time').value;
                      var note = document.getElementById('note').value;
                      var amount = document.getElementById('amount').value;
                      const newExpense = {
                        username: username,
                        details: note,
                        category: category,
                        wallet: wallet_name,
                        amount: amount,
                        frequency: frequency,
                        start_date:start_date,
                        end_date:end_date,
                        time:time
                      };
                      console.log(newExpense)
                      const xhr = new XMLHttpRequest();
                      const url = "http://localhost:9090/api/addRecurExpense";
                      console.log(url)
                      xhr.open('POST', url, true);
                      xhr.setRequestHeader('Content-Type', 'application/json');

                      xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                          if (xhr.status === 200) {
                            alert('Recurring expense successfully added')
                          } else {
                            console.error('Error:', xhr.statusText);
                          }
                        }
                      };

                      xhr.send(JSON.stringify(newExpense));

                    //   document.getElementById('wallet_name').value='My Wallet'
                    // document.getElementById('group').value = 'Cash'
                    // document.getElementById('grp_desc').value = ''
                    // document.getElementById('grp_no').value = ''
                    // document.getElementById('amount').value = '0'
                    }
                    function close(event) {
                      console.log("fun")
                      document.getElementById("expense-form").reset();
                      edit(event);
                    }

                  </script>

          </html>