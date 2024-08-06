<%@ page import="java.util.*" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="org.category.*" %>
      <%@ page import="org.expense.*" %>
        <%@ page import="com.google.gson.*" %>
          <!DOCTYPE html>
          <html lang="en">
          <%@ include file="header.jsp" %>
            <% expense e=new expense(); session.setAttribute("User","john_doe"); String tab_var1="" ,tab_var2="" ;
              String btn_txt="" ; String filter_txt="" ; String str="text-danger" ; category cat=new category();
              List<category>
              cat_list=cat.getCategories();
              wallet w=new wallet();
              String user=(String)session.getAttribute("User");
              List<wallet> w_list=w.getWallets(user);
                List<expense> expenseList=new expense().getExpenses(user);
                  List<wallet> filtered_wal_list=new ArrayList<>();
                      %>

                      <body>

                        <%@ include file="navbar.jsp" %>
                          <%@ include file="sidebar.jsp" %>


                            <main id="main" class="main">

                              <div class="pagetitle">
                                <h1>Reports</h1>
                                <nav>
                                  <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                    <li class="breadcrumb-item active">Reports</li>
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
                                            <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill"
                                              data-bs-target="#pills-contact" type="button" role="tab"
                                              aria-controls="pills-contact" aria-selected="false" tabindex="-1"><i
                                                class="ri-filter-2-line"></i></button>
                                          </li>
                                          <li class="nav-item" role="presentation">
                                            <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill"
                                              data-bs-target="#pills-profile" type="button" role="tab"
                                              aria-controls="pills-profile" aria-selected="false" tabindex="-1"><i
                                                class="bi bi-calendar"></i></button>
                                          </li>
                                          <li>
                                            <button class="nav-link" data-bs-toggle="pill" type="button"
                                              aria-selected="false"><i class="ri-refresh-line"></i></button>
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
                                                  <%@ include file="expenseTransaction.jsp" %>
                                              </div>
                                              <div class="tab-pane fade" id="contact-justified" role="tabpanel"
                                                aria-labelledby="contact-tab">
                                                <% tab_var1="From" ; tab_var2="To" ; btn_txt="Add Transfer" ; %>
                                                  <%@ include file="transferTransactionCard.jsp" %>
                                              </div>
                                              <div class="tab-pane fade" id="profile-justified" role="tabpanel"
                                                aria-labelledby="profile-tab">
                                                <% tab_var1="To" ; btn_txt="Add Income" ; %>
                                                  <%@ include file="incomeTransaction.jsp" %>
                                              </div>

                                            </div>
                                          </div>
                                          <div class="tab-pane fade" id="pills-contact" role="tabpanel"
                                            aria-labelledby="contact-tab">
                                            <div class="field">
                                              <div class="row mb-3">
                                                <label for="inputText" class="col-sm-2 col-form-label">Wallet
                                                  name</label>
                                                <div class="col-sm-10">
                                                  <select class="form-select" id="walletSelect5"
                                                    onchange="updateGroupOptions(5)"
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
                                                <label class="col-sm-2 col-form-label">Group</label>
                                                <div class="col-sm-10">
                                                  <select class="form-select" aria-label="Default select example"
                                                    id="groupSelect5" onchange="applyFilter()">
                                                    <option disabled selected value="">--Select Group--</option>
                                                    <!-- <option value="Cash">Cash</option>
                                                  <option value="Card">Card</option>
                                                  <option value="Account">Accout</option>
                                                  <option value="Mobile Money">Mobile Money</option> -->
                                                  </select>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="field">
                                              <div class="input-group mb-3">
                                                <button type="reset" class="btn btn-secondary"
                                                  onclick="reset1()">Reset</button>
                                              </div>
                                            </div>
                                          </div>
                                          <div class="tab-pane fade" id="pills-profile" role="tabpanel"
                                            aria-labelledby="profile-tab">
                                            <div class="fields">
                                              <div class="field datesets">
                                                <h6>Start date</h6><input type="date" id="startDate"
                                                  style="padding: 10px;" onchange="filterByDate()">
                                                <h6> - </h6>
                                                <h6>End date</h6><input type="date" id="endDate" style="padding: 10px;"
                                                  onchange="filterByDate()">
                                              </div>
                                            </div>
                                            <div class="field">
                                              <div class="input-group mb-3" style="padding: 10px;">
                                                <button type="reset" class="btn btn-secondary"
                                                  onclick="reset2()">Reset</button>
                                              </div>
                                            </div>
                                          </div>

                                        </div><!-- End Pills Tabs -->
                                      </div>
                                      <div class="field">
                                        <h5 class="card-title">Filtered Transactions</h5>
                                        <div id="applied-filters">

                                        </div>
                                        <ul class="list-group list-group-flush scrollable-ul"
                                          id="filtered-transactions">
                                          <!-- <% if(filtered_wal_list.size()==0){%> -->
                                          <li class="list-group-item d-flex justify-content-between align-items-start">
                                            <div class="ms-2 me-auto">
                                              <div class="fw-bold">No Transactions Found</div>
                                            </div>
                                          </li>
                                          <!-- <%} else{ for (int i=0; i < filtered_wal_list.size(); i++) { wallet
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
                                            <% }} %> -->
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
                        const nothing = `<li class="list-group-item d-flex justify-content-between align-items-start">
                                            <div class="ms-2 me-auto">
                                              <div class="fw-bold">No Transactions Found</div>
                                            </div>
                                          </li>`;
                        const container = document.getElementById('filtered-transactions');
                        var walletObjects = <%= new Gson().toJson(w_list) %>;
                        var expenseObjects = <%= new Gson().toJson(expenseList) %>;
                        let selectedWalletObjects;
                        let filtered_by_wg = [];
                        let filter_wg = false;
                        let filter_date = false;
                        function getDatetime() {
                          // const s_date=document.getElementById("startDate")
                          // const e_date=document.getElementById("endDate")
                          // Get current date and time
                          let now = new Date();

                          // Extract date components
                          let year = now.getFullYear();
                          let month = ('0' + (now.getMonth() + 1)).slice(-2); // Months are zero-indexed
                          let day = ('0' + now.getDate()).slice(-2);

                          // Format the date and time
                          let formattedDateTime = year + "-" + month + "-" + day
                          // s_date.value=formattedDateTime
                          // e_date.value=formattedDateTime
                          // console.log(s_date)
                          // console.log(e_date)
                          return formattedDateTime
                        }
                        function updateGroupOptions(setNumber) {
                          var walletSelect = document.getElementById("walletSelect" + setNumber);
                          var selectedName = walletSelect.value;
                          var groupSelect = document.getElementById("groupSelect" + setNumber);
                          groupSelect.innerHTML = '<option disabled selected>--Select Group--</option>';

                          selectedWalletObjects = walletObjects.filter(function (wallet) {
                            return wallet.name === selectedName;
                          });

                          let prev = '';
                          selectedWalletObjects.forEach(function (wallet) {
                            if (wallet.type !== prev) {
                              var option = document.createElement("option");
                              option.value = wallet.type;
                              option.text = wallet.type;
                              groupSelect.appendChild(option);
                              prev = wallet.type;
                            }
                          });
                        }
                        function applyFilter() {
                          const applied = document.getElementById("applied-filters");
                          applied.innerHTML += `<span class="badge rounded-pill bg-light text-dark">` + document.getElementById("walletSelect5").value + `</span>` + `<span class="badge rounded-pill bg-light text-dark">` + document.getElementById("groupSelect5").value + `</span>`
                          filter_wg = true;
                          var groupSelect = document.getElementById("groupSelect5");
                          var selectedGroup = groupSelect.value;
                          selectedWalletObjects = selectedWalletObjects.filter(function (wallet) {
                            return wallet.type === selectedGroup;
                          });
                          if (selectedWalletObjects.length === 0) {
                            selectedWalletObjects = walletObjects.filter(function (wallet) {
                              return wallet.type === selectedGroup;
                            });
                          }
                          if (expenseObjects.length === 0) {
                            console.log(1)
                            container.innerHTML = nothing;
                          } else {
                            console.log(2)
                            console.log(selectedWalletObjects)
                            selectedWalletObjects.forEach(function (wallet) {
                              filtered_by_wg = filtered_by_wg.filter(function (expense) {
                                return expense.wallet === wallet.id;
                              });
                              console.log(filtered_by_wg)
                            });
                            if (filtered_by_wg.length === 0 && filter_date !== true) {
                              selectedWalletObjects.forEach(function (wallet) {
                                filtered_by_wg = expenseObjects.filter(function (expense) {
                                  return expense.wallet === wallet.id;
                                });
                                console.log(filtered_by_wg)
                              });
                            }

                            if (selectedWalletObjects.length === 0) {
                              filtered_by_wg = []
                            }
                            if (filtered_by_wg.length === 0) {
                              console.log(3)
                              container.innerHTML = nothing;
                            } else {
                              console.log(4)
                              update();
                            }

                          }
                        }
                        function update() {
                          let html = '';
                          const part1 = `<li
                                          class="list-group-item d-flex justify-content-between align-items-start">
                                          <div class="ms-2 me-auto">
                                            <div class="fw-bold">`
                          filtered_by_wg.forEach(function (expense) {
                            html += part1 +
                              expense.category +
                              `</div>` +
                              expense.note + `<br />` +
                              expense.spent_on +
                              `</div>
                                  <span class="badge bg-primary rounded-pill">`+
                              expense.amount + ` Tk
                                  </span>
                                </li>`;
                          });

                          container.innerHTML = html;
                        }
                        function reset1() {
                          const walletSelect = document.getElementById('walletSelect5');
                          walletSelect.selectedIndex = 0;
                          const groupSelect = document.getElementById('groupSelect5');
                          groupSelect.innerHTML = `<option disabled selected value="">--Select Group--</option>`;
                          filtered_by_wg = []
                          document.getElementById('filtered-transactions').innerHTML = nothing;
                          document.getElementById('applied-filters').innerHTML = '';
                          filter_wg = false;
                        }
                        function filterByDate() {
                          console.log("came to date JOSHUA")
                          console.log(document.getElementById("startDate").value)
                          console.log(document.getElementById("endDate").value)
                          const startDate = document.getElementById("startDate").value === '' ? getDatetime() : document.getElementById("startDate").value;
                          const endDate = document.getElementById("endDate").value === '' ? getDatetime() : document.getElementById("endDate").value;
                          console.log(startDate)
                          console.log(endDate)
                          const start = new Date(startDate);
                          const end = new Date(endDate);
                          if (start > end) {
                            alert("The start date is later than the end date")
                          }
                          const applied = document.getElementById("applied-filters");
                          applied.innerHTML += `<span class="badge rounded-pill bg-light text-dark">` + startDate + ` to ` + endDate + `</span>`
                          filter_date = true;
                          filtered_by_wg = filtered_by_wg.filter(expense => {
                            const spentOn = new Date(expense.spent_on.split(' ')[0]);
                            return spentOn >= start && spentOn <= end;
                          });
                          if (filtered_by_wg.length === 0 && filter_wg !== true) {
                            filtered_by_wg = expenseObjects.filter(expense => {
                              const spentOn = new Date(expense.spent_on.split(' ')[0]);
                              return spentOn >= start && spentOn <= end;
                            });
                          }
                          if (filtered_by_wg.length === 0) {
                            container.innerHTML = nothing;
                          }
                          else {
                            update();
                          }
                        }
                        function reset2() {
                          document.getElementById('startDate').value = ''
                          document.getElementById('endDate').value = ''
                          filtered_by_wg = []
                          document.getElementById('filtered-transactions').innerHTML = nothing;
                          document.getElementById('applied-filters').innerHTML = '';
                          filter_date = false;
                        }
                      </script>

          </html>