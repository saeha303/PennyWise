<%@ page import="java.util.*" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="org.category.*" %>
      <%@ page import="org.expense.*" %>
        <!DOCTYPE html>
        <html lang="en">
        <%@ include file="header.jsp" %>
          <% expense e=new expense(); session.setAttribute("User","john_doe"); String tab_var1="" ,tab_var2="" ; String
            btn_txt="" ; String filter_txt="" ; String str="text-danger" ; category cat=new category(); List<category>
            cat_list=cat.getCategories();
            wallet w=new wallet();
            String user=(String)session.getAttribute("User");
            List<wallet> w_list=w.getWallets(user);
                List<wallet> filtered_wal_list=new ArrayList<>();
                    System.out.println("pages-transaction "+user);
                    System.out.println(w_list);
                    %>

                    <body>

                      <%@ include file="navbar.jsp" %>
                        <%@ include file="sidebar.jsp" %>


                          <main id="main" class="main">

                            <div class="pagetitle">
                              <h1>Transactions</h1>
                              <nav>
                                <ol class="breadcrumb">
                                  <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                  <li class="breadcrumb-item active">Transactions</li>
                                </ol>
                              </nav>
                            </div><!-- End Page Title -->
                            <section class="section dashboard">
                              <!-- <div class="card">
                                                        <div class="card-body">
                                                            <h5 class="card-title"></h5>
                                                            <div class="d-flex align-items-start">
                                                                <div class="nav flex-column nav-pills me-3 fields"
                                                                    id="v-pills-tab" role="tablist"
                                                                    aria-orientation="vertical">
                                                                    <button class="nav-link" id="v-pills-home-tab"
                                                                        data-bs-toggle="pill"
                                                                        data-bs-target="#v-pills-home" type="button"
                                                                        role="tab" aria-controls="v-pills-home"
                                                                        aria-selected="true"><i
                                                                            class="bi bi-plus-lg"></i> New</button>
                                                                    <button class="nav-link" id="v-pills-profile-tab"
                                                                        data-bs-toggle="pill"
                                                                        data-bs-target="#v-pills-profile" type="button"
                                                                        role="tab" aria-controls="v-pills-profile"
                                                                        aria-selected="false" tabindex="-1"><i
                                                                            class="bi bi-calendar"></i> Range</button>
                                                                    <button class="nav-link" id="v-pills-messages-tab"
                                                                        data-bs-toggle="pill"
                                                                        data-bs-target="#v-pills-messages" type="button"
                                                                        role="tab" aria-controls="v-pills-messages"
                                                                        aria-selected="false" tabindex="-1"><i
                                                                            class="ri-filter-2-line"></i>
                                                                        Filter</button>
                                                                </div>
                                                                <span class="input-group-text" id="inputGroupPrepend">
                                                                <div class="tab-content" id="v-pills-tabContent">
                                                                    <div class="tab-pane fade show active"
                                                                        id="v-pills-home" role="tabpanel"
                                                                        aria-labelledby="v-pills-home-tab" >
                                                                        No transactions found
                                                                    </div>
                                                                    <div class="tab-pane fade" id="v-pills-profile"
                                                                        role="tabpanel"
                                                                        aria-labelledby="v-pills-profile-tab">


                                                                    </div>
                                                                    <div class="tab-pane fade" id="v-pills-messages"
                                                                        role="tabpanel"
                                                                        aria-labelledby="v-pills-messages-tab">


                                                                    </div>
                                                                </div>
                                                                </span>
                                                            </div>

                                                        </div>
                                                    </div> -->
                              <div class="card">
                                <div class="card-body">
                                  <div class="fields">
                                    <div class="field">
                                      <!-- Pills Tabs -->
                                      <h5 class="card-title"> </h5>
                                      <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                                        <li class="nav-item" role="presentation">
                                          <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill"
                                            data-bs-target="#pills-home" type="button" role="tab"
                                            aria-controls="pills-home" aria-selected="true"><i
                                              class="bi bi-plus-lg"></i></button>
                                        </li>
                                        <li class="nav-item" role="presentation">
                                          <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill"
                                            data-bs-target="#pills-profile" type="button" role="tab"
                                            aria-controls="pills-profile" aria-selected="false" tabindex="-1"><i
                                              class="bi bi-calendar"></i></button>
                                        </li>
                                        <li class="nav-item" role="presentation">
                                          <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill"
                                            data-bs-target="#pills-contact" type="button" role="tab"
                                            aria-controls="pills-contact" aria-selected="false" tabindex="-1"><i
                                              class="ri-filter-2-line"></i></button>
                                        </li>
                                      </ul>
                                      <div class="tab-content pt-2" id="myTabContent">
                                        <div class="tab-pane fade show active" id="pills-home" role="tabpanel"
                                          aria-labelledby="home-tab">
                                          <ul class="nav nav-tabs d-flex" id="myTabjustified" role="tablist">
                                            <li class="nav-item flex-fill" role="presentation">
                                              <button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab"
                                                data-bs-target="#home-justified" type="button" role="tab"
                                                aria-controls="home" aria-selected="true">Expense</button>
                                            </li>
                                            <li class="nav-item flex-fill" role="presentation">
                                              <button class="nav-link w-100" id="profile-tab" data-bs-toggle="tab"
                                                data-bs-target="#profile-justified" type="button" role="tab"
                                                aria-controls="profile" aria-selected="false"
                                                tabindex="-1">Income</button>
                                            </li>
                                            <li class="nav-item flex-fill" role="presentation">
                                              <button class="nav-link w-100" id="contact-tab" data-bs-toggle="tab"
                                                data-bs-target="#contact-justified" type="button" role="tab"
                                                aria-controls="contact" aria-selected="false"
                                                tabindex="-1">Transfer</button>
                                            </li>
                                          </ul>
                                          <div class="tab-content pt-2" id="myTabjustifiedContent">
                                            <div class="tab-pane fade show active" id="home-justified" role="tabpanel"
                                              aria-labelledby="home-tab">
                                              <% tab_var1="From" ; btn_txt="Add Expense" ; %>
                                                <%@ include file="transactionCard.jsp" %>
                                            </div>
                                            <div class="tab-pane fade" id="profile-justified" role="tabpanel"
                                              aria-labelledby="profile-tab">
                                              <% tab_var1="To" ; btn_txt="Add Income" ; %>
                                                <%@ include file="transactionCard.jsp" %>
                                            </div>
                                            <div class="tab-pane fade" id="contact-justified" role="tabpanel"
                                              aria-labelledby="contact-tab">
                                              <% tab_var1="From" ; tab_var2="To" ; btn_txt="Add Transfer" ; %>
                                                <%@ include file="transferTransactionCard.jsp" %>
                                            </div>
                                          </div>
                                        </div>
                                        <div class="tab-pane fade" id="pills-profile" role="tabpanel"
                                          aria-labelledby="profile-tab">
                                          <div class="fields">
                                            <div class="field">
                                              <h6>Start date</h6><input type="date">
                                              <h6> </h6>
                                              <h6>End date</h6><input type="date">
                                            </div>
                                          </div>

                                        </div>
                                        <div class="tab-pane fade" id="pills-contact" role="tabpanel"
                                          aria-labelledby="contact-tab">
                                          <div class="field">
                                            <div class="row mb-3">
                                              <label for="inputText" class="col-sm-2 col-form-label">Wallet name</label>
                                              <div class="col-sm-10">
                                                <select class="form-select" id="wallet"
                                                  aria-label="Default select example">
                                                  <option disabled selected value="">--Select Wallet--</option>
                                                  <% for (int i=0; i < w_list.size(); i++) { %>
                                                    <option name="wallet_options" value="<%= w_list.get(i).name %>">
                                                      <%= w.getName(w_list.get(i).name) %>
                                                        <% } %>
                                                    </option>
                                                </select>
                                              </div>
                                            </div>
                                          </div>
                                          <div class="field">
                                            <div class="row mb-3">
                                              <label class="col-sm-2 col-form-label">Group</label>
                                              <div class="col-sm-10">
                                                <select class="form-select" id="group"
                                                  aria-label="Default select example">
                                                  <option disabled selected value="">--Select Group--</option>
                                                  <option value="Cash">Cash</option>
                                                  <option value="Card">Card</option>
                                                  <option value="Account">Accout</option>
                                                  <option value="Mobile Money">Mobile Money</option>
                                                </select>
                                              </div>
                                            </div>
                                          </div>
                                          <div class="field">
                                            <div class="input-group mb-3">
                                              <button type="submit" class="btn btn-primary"
                                                onclick="applyFilter(event)">Apply</button>
                                            </div>
                                          </div>
                                        </div>
                                      </div><!-- End Pills Tabs -->
                                    </div>
                                    <div class="field">
                                      <h5 class="card-title">Filtered Transactions</h5>
                                      <ul class="list-group list-group-flush">
                                        <% if(filtered_wal_list.size()==0){%>
                                          <li class="list-group-item d-flex justify-content-between align-items-start">
                                            <div class="ms-2 me-auto">
                                              <div class="fw-bold">No Transactions Found</div>
                                            </div>
                                          </li>
                                          <%} else{ for (int i=0; i < filtered_wal_list.size(); i++) { wallet
                                            tw=filtered_wal_list.get(i); %>

                                            <li
                                              class="list-group-item d-flex justify-content-between align-items-start">
                                              <div class="ms-2 me-auto">
                                                <div class="fw-bold">
                                                  <%= tw.name %>
                                                </div>
                                                <%= tw.type %><br />
                                                  <%= tw.type_unique_name %><br />
                                                    <%= tw.type_unique_number %>
                                              </div>
                                              <span class="badge bg-primary rounded-pill">
                                                <%= tw.amount %> Tk
                                              </span>
                                            </li>
                                            <% }} %>
                                      </ul><!-- End with custom content -->
                                    </div>
                                  </div>

                                </div>
                              </div>
                            </section>

                          </main><!-- End #main -->

                          <%@ include file="footer.jsp" %>

                    </body>
                    <script>
                      function applyFilter(event) {
                        event.preventDefault(); // Prevent form from submitting
                        var wallet = document.getElementById('wallet').value;
                        var group = document.getElementById('group').value;
                        var xhr = new XMLHttpRequest();
                        xhr.open("POST", "changePassword.jsp", true); // Posting to the same JSP page
                        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        xhr.onreadystatechange = function () {
                          if (xhr.readyState === 4 && xhr.status === 200) {
                            var response = xhr.responseText.trim();
                            var var_1 = response.split('//')
                            const var_2 = var_1.map((req) => {
                              console.log(req)
                            });
                            console.log(var_1)
                          }
                        };

                        xhr.send("action=applyFilter" +
                          "&wallet=" + encodeURIComponent(wallet) +
                          "&group=" + encodeURIComponent(group));
                      }

                    </script>

        </html>