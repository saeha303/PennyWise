<%@ page import="java.util.*" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="org.category.*" %>
      <%@ page import="org.expense.*" %>
        <!DOCTYPE html>
        <html lang="en">
        <!-- <% request.setAttribute("tab_var", "Dashboard" ); %>
      <jsp:include page="header.jsp">
        <jsp:param name="tab_var" value="Dashboard" />
      </jsp:include> -->
        <%@ include file="header.jsp" %>
          <% session.setAttribute("User","john_doe"); String tab_var1="" ,tab_var2="" ; String btn_txt="" ; String
            filter_txt="" ;
             category cat=new category(); List<String> cat_list=cat.getCategories();
            wallet w=new wallet();
            String user=(String)session.getAttribute("User");
            System.out.println(user);
            List<String> w_list=w.getWalletList(user);
              
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
                                        <button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab"
                                          data-bs-target="#home-justified" type="button" role="tab" aria-controls="home"
                                          aria-selected="true">Expense</button>
                                      </li>
                                      <li class="nav-item flex-fill" role="presentation">
                                        <button class="nav-link w-100" id="profile-tab" data-bs-toggle="tab"
                                          data-bs-target="#profile-justified" type="button" role="tab"
                                          aria-controls="profile" aria-selected="false" tabindex="-1">Income</button>
                                      </li>
                                      <li class="nav-item flex-fill" role="presentation">
                                        <button class="nav-link w-100" id="contact-tab" data-bs-toggle="tab"
                                          data-bs-target="#contact-justified" type="button" role="tab"
                                          aria-controls="contact" aria-selected="false" tabindex="-1">Transfer</button>
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
                                    </div><!-- End Default Tabs -->

                                  </div>
                                </div>

                                <!-- Customers Card -->
                                <div class="col-xxl-4 col-xl-12">

                                  <div class="card info-card customers-card">

                                    <div class="filter">
                                      <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                          class="bi bi-three-dots"></i></a>
                                      <ul id="filter_txt" class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                        <li class="dropdown-header text-start">
                                          <h6>Filter</h6>
                                        </li>

                                        <li><a class="dropdown-item">Today</a></li>
                                        <li><a class="dropdown-item">This Month</a></li>
                                        <li><a class="dropdown-item">This Year</a></li>
                                      </ul>
                                    </div>
                                    <div class="card-body">
                                      <h5 class="card-title">Top Expense <span>|Placeholder</span></h5>
                                      <div class="fields">
                                        <div class="field d-flex align-items-center mb-3">
                                          <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="bi bi-people"></i>
                                          </div>
                                          <div class="ps-3">
                                            <h6>1244</h6>
                                            <span class="text-danger small pt-1 fw-bold">12%</span> <span
                                              class="text-muted small pt-2 ps-1">decrease</span>
                                          </div>
                                        </div>

                                        <div class="field d-flex align-items-center mb-3">
                                          <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="bi bi-people"></i>
                                          </div>
                                          <div class="ps-3">
                                            <h6>1244</h6>
                                            <span class="text-danger small pt-1 fw-bold">12%</span> <span
                                              class="text-muted small pt-2 ps-1">decrease</span>
                                          </div>
                                        </div>
                                      </div>

                                      <div class="field d-flex align-items-center mb-3">
                                        <div
                                          class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                          <i class="bi bi-people"></i>
                                        </div>
                                        <div class="ps-3">
                                          <h6>1244</h6>
                                          <span class="text-danger small pt-1 fw-bold">12%</span> <span
                                            class="text-muted small pt-2 ps-1">decrease</span>
                                        </div>
                                      </div>

                                    </div>
                                  </div>

                                </div><!-- End Customers Card -->

                                <!-- Reports -->
                                <div class="col-12">
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

                                    <div class="card-body">
                                      <h5 class="card-title">Reports <span>/Today</span></h5>

                                      <!-- Line Chart -->
                                      <div id="reportsChart"></div>

                                      <script>
                                        document.addEventListener("DOMContentLoaded", () => {
                                          new ApexCharts(document.querySelector("#reportsChart"), {
                                            series: [{
                                              name: 'Sales',
                                              data: [31, 40, 28, 51, 42, 82, 56],
                                            }, {
                                              name: 'Revenue',
                                              data: [11, 32, 45, 32, 34, 52, 41]
                                            }, {
                                              name: 'Customers',
                                              data: [15, 11, 32, 18, 9, 24, 11]
                                            }],
                                            chart: {
                                              height: 350,
                                              type: 'area',
                                              toolbar: {
                                                show: false
                                              },
                                            },
                                            markers: {
                                              size: 4
                                            },
                                            colors: ['#4154f1', '#2eca6a', '#ff771d'],
                                            fill: {
                                              type: "gradient",
                                              gradient: {
                                                shadeIntensity: 1,
                                                opacityFrom: 0.3,
                                                opacityTo: 0.4,
                                                stops: [0, 90, 100]
                                              }
                                            },
                                            dataLabels: {
                                              enabled: false
                                            },
                                            stroke: {
                                              curve: 'smooth',
                                              width: 2
                                            },
                                            xaxis: {
                                              type: 'datetime',
                                              categories: ["2018-09-19T00:00:00.000Z", "2018-09-19T01:30:00.000Z", "2018-09-19T02:30:00.000Z", "2018-09-19T03:30:00.000Z", "2018-09-19T04:30:00.000Z", "2018-09-19T05:30:00.000Z", "2018-09-19T06:30:00.000Z"]
                                            },
                                            tooltip: {
                                              x: {
                                                format: 'dd/MM/yy HH:mm'
                                              },
                                            }
                                          }).render();
                                        });
                                      </script>
                                      <!-- End Line Chart -->

                                    </div>

                                  </div>
                                </div><!-- End Reports -->

                            </div>
                          </div><!-- End Left side columns -->

                          <!-- Right side columns -->
                          <div class="col-lg-4">

                                                        <!-- Budget Report -->
                                                        <div class="card">
                                                          <div class="filter">
                                                            <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
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
                                                                      name: 'Sales',
                                                                      max: 6500
                                                                    },
                                                                    {
                                                                      name: 'Administration',
                                                                      max: 16000
                                                                    },
                                                                    {
                                                                      name: 'Information Technology',
                                                                      max: 30000
                                                                    },
                                                                    {
                                                                      name: 'Customer Support',
                                                                      max: 38000
                                                                    },
                                                                    {
                                                                      name: 'Development',
                                                                      max: 52000
                                                                    },
                                                                    {
                                                                      name: 'Marketing',
                                                                      max: 25000
                                                                    }
                                                                    ]
                                                                  },
                                                                  series: [{
                                                                    name: 'Budget vs spending',
                                                                    type: 'radar',
                                                                    data: [{
                                                                      value: [4200, 3000, 20000, 35000, 50000, 18000],
                                                                      name: 'Allocated Budget'
                                                                    },
                                                                    {
                                                                      value: [5000, 14000, 28000, 26000, 42000, 21000],
                                                                      name: 'Actual Spending'
                                                                    }
                                                                    ]
                                                                  }]
                                                                });
                                                              });
                                                            </script>
                            
                                                          </div>
                                                        </div><!-- End Budget Report -->

                            <!-- Recent Activity -->
                            <div class="card">

                              <div class="card-body">
                                <h5 class="card-title">Recent Activity</h5>

                                <div class="activity">

                                  <div class="activity-item d-flex">
                                    <div class="activite-label">32 min</div>
                                    <i class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
                                    <div class="activity-content">
                                      Quia quae rerum <a href="#" class="fw-bold text-dark">explicabo officiis</a>
                                      beatae
                                    </div>
                                  </div><!-- End activity item-->

                                  <div class="activity-item d-flex">
                                    <div class="activite-label">56 min</div>
                                    <i class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
                                    <div class="activity-content">
                                      Voluptatem blanditiis blanditiis eveniet
                                    </div>
                                  </div><!-- End activity item-->

                                  <div class="activity-item d-flex">
                                    <div class="activite-label">2 hrs</div>
                                    <i class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>
                                    <div class="activity-content">
                                      Voluptates corrupti molestias voluptatem
                                    </div>
                                  </div><!-- End activity item-->

                                  <div class="activity-item d-flex">
                                    <div class="activite-label">1 day</div>
                                    <i class='bi bi-circle-fill activity-badge text-info align-self-start'></i>
                                    <div class="activity-content">
                                      Tempore autem saepe <a href="#" class="fw-bold text-dark">occaecati voluptatem</a>
                                      tempore
                                    </div>
                                  </div><!-- End activity item-->

                                  <div class="activity-item d-flex">
                                    <div class="activite-label">2 days</div>
                                    <i class='bi bi-circle-fill activity-badge text-warning align-self-start'></i>
                                    <div class="activity-content">
                                      Est sit eum reiciendis exercitationem
                                    </div>
                                  </div><!-- End activity item-->

                                  <div class="activity-item d-flex">
                                    <div class="activite-label">4 weeks</div>
                                    <i class='bi bi-circle-fill activity-badge text-muted align-self-start'></i>
                                    <div class="activity-content">
                                      Dicta dolorem harum nulla eius. Ut quidem quidem sit quas
                                    </div>
                                  </div><!-- End activity item-->

                                </div>

                              </div>
                            </div><!-- End Recent Activity -->



                          </div><!-- End Right side columns -->

                        </div>
                      </section>

                    </main><!-- End #main -->

                    <%@ include file="footer.jsp" %>

              </body>

        </html>