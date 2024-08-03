<%@ page import="java.util.*" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="org.category.*" %>
      <%@ page import="org.expense.*" %>
        <%@ page import="com.google.gson.*" %>

          <!DOCTYPE html>
          <html lang="en">
          <!-- <% request.setAttribute("tab_var", "Dashboard" ); %>
      <jsp:include page="header.jsp">
        <jsp:param name="tab_var" value="Dashboard" />
      </jsp:include> -->
          <%@ include file="header.jsp" %>
            <% session.setAttribute("User","john_doe"); String user=(String)session.getAttribute("User"); String
              tab_var1="" ,tab_var2="" ; String btn_txt="" ; String filter_txt="" ; String progress_str="text-danger" ;
              category cat=new category(); wallet w=new wallet(); expense exp=new expense(); List<category>
              cat_list=cat.getCategories();
              List<wallet> w_list=w.getWallets(user);
                List<expense> dailyReport=exp.getDailyDonutChart(user,"My Wallet");
                  List<expense> recentActivity=exp.getRecentActivity(user);
                    budget b=new budget().getBudget(user,"My Wallet");
                    List<budget> actualSpending=new budget().getActualSpending(user,"My Wallet");
                      List<Integer> netWorth=exp.getNetWorth(user,"My Wallet");
                        %>

                        <body>

                          <%@ include file="navbar.jsp" %>
                            <%@ include file="sidebar.jsp" %>


                              <main id="main" class="main">

                                <div class="pagetitle">
                                  <h1>Dashboard</h1>
                                  <nav>
                                    <ol class="breadcrumb">
                                      <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                                      <li class="breadcrumb-item active">Dashboard</li>
                                    </ol>
                                  </nav>
                                </div><!-- End Page Title -->

                                <section class="section dashboard">
                                  <div class="row">

                                    <!-- Left side columns -->
                                    <div class="col-lg-8">
                                      <div class="row">
                                        <!-- Our code starts -->
                                        <!-- budget progress  -->
                                        <%@ include file="progress.jsp" %>
                                          <!-- end budget progress -->
                                          <div class="card">
                                            <div class="card-body">
                                              <h5 class="card-title">New Transaction</h5>
                                              <!-- Default Tabs -->
                                              <ul class="nav nav-tabs d-flex" id="myTabjustified" role="tablist">
                                                <li class="nav-item flex-fill" role="presentation">
                                                  <button class="nav-link w-100 active" id="home-tab"
                                                    data-bs-toggle="tab" data-bs-target="#home-justified" type="button"
                                                    role="tab" aria-controls="home"
                                                    aria-selected="true">Expense</button>
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
                                                <div class="tab-pane fade show active" id="home-justified"
                                                  role="tabpanel" aria-labelledby="home-tab">
                                                  <% tab_var1="From" ; btn_txt="Add Expense" ; %>
                                                    <%@ include file="expenseTransaction.jsp" %>
                                                </div>
                                                <div class="tab-pane fade" id="profile-justified" role="tabpanel"
                                                  aria-labelledby="profile-tab">
                                                  <% tab_var1="To" ; btn_txt="Add Income" ; %>
                                                    <%@ include file="incomeTransaction.jsp" %>
                                                </div>
                                                <div class="tab-pane fade" id="contact-justified" role="tabpanel"
                                                  aria-labelledby="contact-tab">
                                                  <% tab_var1="From" ; tab_var2="To" ; btn_txt="Add Transfer" ; %>
                                                    <%@ include file="transferTransactionCard.jsp" %>
                                                </div>
                                              </div><!-- End Default Tabs -->

                                            </div>
                                          </div>

                                          <!-- Top expense Card -->
                                          <div class="col-xxl-4 col-xl-12">

                                            <div class="card info-card customers-card">

                                              <div class="filter">
                                                <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                                    class="ri-filter-2-line"></i><i class="bi bi-three-dots"></i></a>
                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow"
                                                  id="top-expense-filter" aria-valuenow="">
                                                  <li class="dropdown-header text-start" value="filter"
                                                    aria-selected="true">
                                                    <h6>Choose wallet</h6>
                                                  </li>
                                                  <% for(int i=0; i<w_list.size(); i++) { %>
                                                    <% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %>
                                                      <li value="<%= w_list.get(i).name %>">
                                                        <a class="dropdown-item"
                                                          onclick="document.getElementById('top-expense-filter').value='<%= w_list.get(i).name %>'">

                                                          <%= w.getName(w_list.get(i).name) %>
                                                            <% } %>
                                                        </a>
                                                      </li>
                                                      <% } %>
                                                </ul>
                                              </div>
                                              <div class="card-body">
                                                <h5 class="card-title" id="te_filter_holder">Top Expense <span
                                                    aria-labelledby="today">|My Wallet</span>
                                                </h5>
                                                <div class="fields" id="top-expense-card">
                                                  <% for(int i=0; i<dailyReport.size()&&i<3; i++) { %>
                                                    <div class="field d-flex align-items-center mb-3">
                                                      <div
                                                        class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                        <i class="bi bi-people"></i>
                                                      </div>
                                                      <div class="ps-3">
                                                        <h6>
                                                          <%= dailyReport.get(i).amount %>
                                                        </h6>
                                                        <span class="text-muted small pt-1 fw-bold">
                                                          <%= dailyReport.get(i).category %>
                                                        </span></br>
                                                        <span class="text-danger small pt-1 fw-bold">
                                                          <%= Math.abs(dailyReport.get(i).wallet) %>%
                                                        </span> <span class="text-muted small pt-2 ps-1">
                                                          <% if (dailyReport.get(i).wallet>=0) {%>
                                                            increase than last month
                                                            <% } else{%>
                                                              decrease than last month
                                                              <% } %>
                                                        </span>
                                                      </div>
                                                    </div>
                                                    <% } if(dailyReport.size()==0){ %>
                                                      <h6 class="text-muted">
                                                        No Expenses
                                                      </h6>
                                                      <% } %>

                                                </div>
                                              </div>
                                            </div>

                                          </div><!-- End Customers Card -->

                                          <!-- Reports -->
                                          <div class="col-12">
                                            <!-- <div class="card"> -->
                                            <div class="card">

                                              <div class="filter">
                                                <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                                    class="ri-filter-2-line"></i><i class="bi bi-three-dots"></i></a>
                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow"
                                                  id="report-expense-filter" aria-valuenow="">
                                                  <li class="dropdown-header text-start" value="filter"
                                                    aria-selected="true">
                                                    <h6>Choose wallet</h6>
                                                  </li>
                                                  <% for(int i=0; i<w_list.size(); i++) { %>
                                                    <% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %>
                                                      <li value="<%= w_list.get(i).name %>">
                                                        <a class="dropdown-item"
                                                          onclick="document.getElementById('report-expense-filter').value='<%= w_list.get(i).name %>'">

                                                          <%= w.getName(w_list.get(i).name) %>
                                                            <% } %>
                                                        </a>
                                                      </li>
                                                      <% } %>
                                                </ul>
                                              </div>

                                              <div class="card-body">
                                                <h5 class="card-title" id="re_filter_holder">Report<span> |My
                                                    Wallet</span></h5>

                                                <!-- Doughnut Chart -->
                                                <canvas id="doughnutChart"
                                                  style="max-height: 400px; display: block; box-sizing: border-box; height: 400px; width: 642px;"
                                                  width="964" height="600"></canvas>
                                                <script>
                                                  const reportExpenseFilter = document.getElementById('report-expense-filter');
                                                  document.addEventListener("DOMContentLoaded", () => {
                                                    donutChart()
                                                  });
                                                  reportExpenseFilter.addEventListener('click', () => {
                                                    donutChart()
                                                  });
                                                  let doughnutChart;
                                                  function donutChart() {

                                                    let wallet = reportExpenseFilter.value === undefined ? 'My Wallet' : reportExpenseFilter.value
                                                    let data;
                                                    let label_list = []
                                                    let data_list = []
                                                    let color_list = []
                                                    // reportExpenseFilter.addEventListener('click', () => {
                                                    const user = '<%= (String)session.getAttribute("User") %>';
                                                    console.log(wallet)
                                                    const text = document.getElementById("re_filter_holder");
                                                    text.innerHTML = `Report <span>|` + wallet + `</span>`;
                                                    const xhr = new XMLHttpRequest();
                                                    console.log(user);
                                                    const url = "http://localhost:9090/api/report-expense?user=" + user + "&wallet=" + encodeURIComponent(wallet);
                                                    console.log(url)
                                                    xhr.open('GET', url, true);
                                                    xhr.setRequestHeader('Content-Type', 'application/json');

                                                    xhr.onreadystatechange = function () {
                                                      if (xhr.readyState === XMLHttpRequest.DONE) {
                                                        if (xhr.status === 200) {
                                                          data = JSON.parse(xhr.responseText);
                                                          // if (data.length > 0) {
                                                            label_list = data.map(expense => expense.category)
                                                            data_list = data.map(expense => expense.amount)
                                                            color_list = data.map(expense => expense.note)
                                                            if (doughnutChart) {
                                                              doughnutChart.destroy();
                                                            }
                                                            doughnutChart = new Chart(document.querySelector('#doughnutChart'), {
                                                              type: 'doughnut',
                                                              data: {
                                                                labels: label_list,
                                                                datasets: [{
                                                                  label: 'Spent',
                                                                  data: data_list,
                                                                  backgroundColor: color_list,
                                                                  hoverOffset: 4
                                                                }]
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
                                                <!-- End Doughnut CHart -->

                                              </div>
                                            </div>

                                            <!-- </div> -->
                                          </div><!-- End Reports -->

                                      </div>
                                    </div><!-- End Left side columns -->

                                    <!-- Right side columns -->
                                    <div class="col-lg-4">


                                      <!-- Recent Activity -->
                                      <div class="card">

                                        <div class="card-body">
                                          <h5 class="card-title">Recent Activity</h5>

                                          <div class="activity">

                                            <% for (int i=recentActivity.size()-1; i>= 0; i--) { %>
                                              <div class="activity-item d-flex">
                                                <div class="activite-label">
                                                  <%= recentActivity.get(i).spent_on %>
                                                </div>
                                                <i
                                                  class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>
                                                <div class="activity-content">
                                                  <%= recentActivity.get(i).note %></br> <a href="#"
                                                      class="fw-bold text-dark">
                                                      <%= recentActivity.get(i).category %>
                                                    </a></br>
                                                    <%= recentActivity.get(i).amount %>
                                                </div>
                                              </div>
                                              <% } %>
                                                <!-- <div class="activity-item d-flex">
                                    <div class="activite-label">1 day</div>
                                    <i class='bi bi-circle-fill activity-badge text-info align-self-start'></i>
                                    <div class="activity-content">
                                      Tempore autem saepe <a href="#" class="fw-bold text-dark">occaecati voluptatem</a>
                                      tempore
                                    </div>
                                  </div> -->

                                          </div>

                                        </div>
                                      </div><!-- End Recent Activity -->

                                      <!-- Budget Report -->
                                      <div class="card">
                                        <div class="filter">
                                          <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                              class="bi bi-three-dots"></i></a>
                                          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                            <li class="dropdown-header text-start">
                                              <h6>Filter</h6>
                                            </li>

                                            <li><a class="dropdown-item" href="#">Today</a></li>
                                            <li><a class="dropdown-item" href="#">This Month</a></li>
                                            <li><a class="dropdown-item" href="#">This Year</a></li>
                                          </ul>
                                        </div>

                                        <div class="card-body pb-0">
                                          <h5 class="card-title">Budget Report <span>| This Month</span></h5>

                                          <div id="budgetChart" style="min-height: 400px;" class="echart"></div>

                                          <script>
                                            document.addEventListener("DOMContentLoaded", () => {
                                              var budgetChart = echarts.init(document.querySelector("#budgetChart")).setOption({
                                                legend: {
                                                  data: ['Allocated Budget', 'Actual Spending']
                                                },
                                                radar: {
                                                  // shape: 'circle',
                                                  indicator: [{
                                                    name: 'Clothing and Accessories',
                                                    max: <%= (int)b.amount * 0.20 %>
                                          
                                        },
                                        {
                                                  name: 'Food',
                                                  max: <%= (int)b.amount * 0.75 %>
                                        },
                                              {
                                                name: 'Medical',
                                                max: <%= (int)b.amount * 0.35 %>
                                          
                                        },
                                              {
                                                name: 'Pleasure and others',
                                                max:<%= (int)b.amount * 0.13 %>
                                          
                                        },
                                              {
                                                name: 'Residence',
                                                max: <%= (int)b.amount * 0.36 %>
                                        },
                                              {
                                                name: 'Workplace',
                                                max: <%= (int)b.amount * 0.17 %>
                                          
                                        }
                                        ]
                                      },
                                              series: [{
                                                name: 'Budget vs spending',
                                                type: 'radar',
                                                data: [{
                                                  value: [<%= (int)b.amount * 0.12 %>, <%= (int)b.amount * 0.35 %>, <%= (int)b.amount * 0.15 %>, <%= (int)b.amount * 0.08 %>, <%= (int)b.amount * 0.20 %>, <%= (int)b.amount * 0.10 %>],
                                                  name: 'Allocated Budget'
                                                },
                                                {
                                                  value: [<%
                                                    char[] arr = { 'C', 'F', 'M', 'P', 'R', 'W'};
                                                  int j=0;
                                                  for(int i = 0;i<arr.length; i++){
                                              if (actualSpending.get(j).startDate.charAt(0) != arr[i]) {%>
                                                <%= 0 %>,
                                              <%continue;
                                              }%>
                                            <%= (int)actualSpending.get(j).wallet %>,
                                          <% j++;
                                            }%>],
                                            name: 'Actual Spending'
                                        }
                                        ]
                                      }]
                                    });
                                  });
                                          </script>

                                        </div>
                                      </div>
                                      <!-- End Budget Report -->

                                    </div><!-- End Right side columns -->

                                  </div>
                                </section>

                              </main><!-- End #main -->

                              <%@ include file="footer.jsp" %>
                                <script>
                                  document.addEventListener('DOMContentLoaded', () => {
                                    const topExpenseFilter = document.getElementById('top-expense-filter');
                                    topExpenseFilter.addEventListener('click', () => {
                                      const user = '<%= (String)session.getAttribute("User") %>';
                                      const wallet = topExpenseFilter.value;
                                      console.log(wallet)
                                      const text = document.getElementById("te_filter_holder");
                                      text.innerHTML = `Top Expense <span>|` + wallet + `</span>`;
                                      const xhr = new XMLHttpRequest();
                                      console.log(user);
                                      const url = "http://localhost:9090/api/top-expense?user=" + user + "&wallet=" + encodeURIComponent(wallet);
                                      console.log(url)
                                      xhr.open('GET', url, true);
                                      xhr.setRequestHeader('Content-Type', 'application/json');

                                      xhr.onreadystatechange = function () {
                                        if (xhr.readyState === XMLHttpRequest.DONE) {
                                          if (xhr.status === 200) {
                                            const data = JSON.parse(xhr.responseText);
                                            updateTopExpense(data);
                                          } else {
                                            console.error('Error:', xhr.statusText);
                                          }
                                        }
                                      };

                                      xhr.send();

                                    });

                                    function updateTopExpense(topExpense) {
                                      const container = document.getElementById("top-expense-card");
                                      let html = ''
                                      const part1 = `<div class="field d-flex align-items-center mb-3">
                                                    <div
                                                      class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                      <i class="bi bi-people"></i>
                                                    </div>
                                                    <div class="ps-3">
                                                    <h6>`;
                                      for (let i = 0; i < topExpense.length; i++) {
                                        const str = topExpense[i].wallet >= 0 ? `increase than last month` : `decrease than last month`;
                                        html += part1 + topExpense[i].amount +
                                          `</h6>` + `<span class="text-muted small pt-1 fw-bold">` + topExpense[i].category + `</span></br>
                                              <span class="text-danger small pt-2 fw-bold">`+ Math.abs(topExpense[i].wallet) + `%</span> <span
                                                        class="text-muted small pt-3 ps-1">`+ str + ` </span>
                                                    </div>
                                                  </div>`;
                                      }
                                      if (topExpense.length === 0) {
                                        html += ` <h5 class="text-muted">
                                                No Expenses
                                              </h5>`
                                      }
                                      container.innerHTML = html;

                                    }
                                  });
                                </script>
                        </body>


          </html>