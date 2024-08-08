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
                                        </ul>
                                        <div class="tab-content pt-2" id="myTabContent">
                                          <div class="tab-pane fade show active" id="pills-home" role="tabpanel"
                                            aria-labelledby="home-tab">
                                            A
                                          </div>
                                          <div class="tab-pane fade" id="pills-contact" role="tabpanel"
                                            aria-labelledby="contact-tab">
                                            B
                                          </div>
                                          <div class="tab-pane fade" id="pills-profile" role="tabpanel"
                                            aria-labelledby="profile-tab">
                                            C
                                          </div>

                                        </div><!-- End Pills Tabs -->
                                      </div>
                                    </div>

                                  </div>
                                </div>
                              </section>

                            </main><!-- End #main -->

                            <%@ include file="footer.jsp" %>

                      </body>

          </html>