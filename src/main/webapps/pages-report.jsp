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
                                <div class="card">
                                  <div class="filter nav-item d-flex align-items-center">
                                    <a class="icon" href="#" data-bs-toggle="dropdown" id="current-wallet">
                                      My Wallet
                                      <i class="bi bi-chevron-compact-down"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" aria-valuenow=""
                                      id="wallet-drop">
                                      <% for(int i=0; i<w_list.size(); i++) { %>
                                        <% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %>
                                          <li value="<%= w_list.get(i).name %>">
                                            <a class="dropdown-item"
                                              onclick="document.getElementById('wallet-drop').value='<%= w_list.get(i).name %>';">

                                              <%= w.getName(w_list.get(i).name) %>
                                                <% } %>
                                            </a>
                                          </li>
                                          <% } %>
                                    </ul>

                                    <a class="icon" href="#" data-bs-toggle="dropdown" id="current-month">
                                      <%= java.time.Month.of(java.time.LocalDate.now().getMonthValue()).name() %>
                                        <i class="bi bi-chevron-compact-down"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" aria-valuenow="" id="month-drop">
                                      <% for (int i=1; i <=12; i++) { %>
                                        <li value="<%= java.time.Month.of(i).name() %>">
                                          <a class="dropdown-item"
                                            onclick="document.getElementById('month-drop').value='<%= i-1 %>';">
                                            <%= java.time.Month.of(i).name() %>
                                          </a>
                                        </li>
                                        <% } %>
                                    </ul>

                                    <div class="input-group" style="width: 90px; padding-right: 20px;">
                                      <input type="number" class="form-control" value="2024" style="padding-left: 5px;"
                                        onChange="updateYear(this.value)">
                                    </div>

                                  </div>
                                  <div>
                                    <br />
                                  </div>
                                  <div class="card-body">
                                    <div class="fields">
                                      <div class="field">
                                        <!-- Pills Tabs -->
                                        <h5 class="card-title"> </h5>

                                        <!-- <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                                          <li class="nav-item">
                                            
                                          </li>
                                          <li class="nav-item">
                                            <button class="nav-link" data-bs-toggle="pill"
                                              type="button" role="tab"
                                              aria-controls="pills-contact" aria-selected="false" tabindex="-1"><i
                                                class="ri-filter-2-line"></i></button>
                                          </li>
                                          <li class="nav-item">
                                            <button class="nav-link" data-bs-toggle="pill"
                                              type="button" role="tab"
                                              aria-controls="pills-profile" aria-selected="false" tabindex="-1"><i
                                                class="bi bi-calendar"></i></button>
                                          </li>
                                        </ul> -->
                                      </div>
                                    </div>

                                    <!-- Bar Chart -->
                                    <canvas id="barChart"
                                      style="max-height: 400px; display: block; box-sizing: border-box; height: 321px; width: 642px;"
                                      width="964" height="481"></canvas>
                                    <script>
                                      const walletdrop = document.getElementById('wallet-drop');
                                      const monthdrop = document.getElementById('month-drop');
                                      document.addEventListener("DOMContentLoaded", () => {
                                        barChart()
                                      });
                                      walletdrop.addEventListener('click', () => {
                                        updateWallet(walletdrop.value)
                                        barChart()
                                      });
                                      monthdrop.addEventListener('click', () => {
                                        monthList=['JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER']
                                        console.log(monthdrop.value)
                                        updateMonth(monthList[monthdrop.value])
                                        barChart()
                                      });
                                      let bar_Chart;
                                      function barChart() {
                                        
                                        let wallet = walletdrop.value === undefined ? 'My Wallet' : walletdrop.value
                                        let month= monthdrop.value === undefined ? new Date().getMonth() : monthdrop.value
                                        let data;
                                        let label_list = []
                                        let data_list = []
                                        let color_list = []
                                        // reportExpenseFilter.addEventListener('click', () => {
                                        const user = '<%= (String)session.getAttribute("User") %>';
                                        console.log(wallet)
                                        const xhr = new XMLHttpRequest();
                                        console.log(user);
                                        const url = "http://localhost:9090/api/report-expense-super-bar?user=" + user + "&wallet=" + encodeURIComponent(wallet)+'&month='+month;
                                        xhr.open('GET', url, true);
                                        xhr.setRequestHeader('Content-Type', 'application/json');

                                        xhr.onreadystatechange = function () {
                                          if (xhr.readyState === XMLHttpRequest.DONE) {
                                            if (xhr.status === 200) {
                                              data = JSON.parse(xhr.responseText);
                                              // if (data.length > 0) {
                                              label_list = data.map(expense => expense.category)
                                              data_list = data.map(expense => expense.amount)
                                              if (bar_Chart) {
                                                bar_Chart.destroy();
                                              }
                                              bar_Chart = new Chart(document.querySelector('#barChart'), {
                                                type: 'bar',
                                                data: {
                                                  labels: ['Clothing and Accessories', 'Food', 'Medical', 'Pleasure and others', 'Residence', 'Workplace'],
                                                  datasets: [{
                                                    label: 'Spent',
                                                    data: data_list,
                                                    backgroundColor: [
                                                      'rgba(255, 99, 132, 0.2)',
                                                      'rgba(255, 159, 64, 0.2)',
                                                      'rgba(255, 205, 86, 0.2)',
                                                      'rgba(75, 192, 192, 0.2)',
                                                      'rgba(54, 162, 235, 0.2)',
                                                      'rgba(153, 102, 255, 0.2)',
                                                    ],
                                                    borderColor: [
                                                      'rgb(255, 99, 132)',
                                                      'rgb(255, 159, 64)',
                                                      'rgb(255, 205, 86)',
                                                      'rgb(75, 192, 192)',
                                                      'rgb(54, 162, 235)',
                                                      'rgb(153, 102, 255)',
                                                      'rgb(201, 203, 207)'
                                                    ],
                                                    borderWidth: 1
                                                  }]
                                                },
                                                options: {
                                                  scales: {
                                                    y: {
                                                      beginAtZero: true
                                                    }
                                                  }
                                                }

                                              });
                                              // }else{
                                              //   if (doughnutChart) {
                                              //     doughnutChart.destroy();
                                              //   }
                                              //   document.querySelector('#doughnutChart').innerHTML=`<h5 class='text-muted'>No Expense</h5>`
                                              // }

                                            } else {
                                              console.error('Error:', xhr.statusText);
                                            }
                                          }
                                        };

                                        xhr.send();
                                      }
                                    </script>
                                    <!-- End Bar CHart -->

                                  </div>
                                </div>
                              </section>
                              <script>
                                function updateMonth(monthName) {
                                  document.getElementById('current-month').innerHTML = monthName + ' <i class="bi bi-chevron-compact-down"></i>';
                                }
                                function updateWallet(wallet) {
                                  document.getElementById('current-wallet').innerHTML = wallet + ' <i class="bi bi-chevron-compact-down"></i>';
                                }
                                function updateYear(year) {

                                }
                              </script>
                            </main><!-- End #main -->

                            <%@ include file="footer.jsp" %>

                      </body>

          </html>