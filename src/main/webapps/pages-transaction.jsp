<%@ page import="java.util.*" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="org.category.*" %>
      <%@ page import="org.expense.*" %>
        <!DOCTYPE html>
        <html lang="en">
        <%@ include file="header.jsp" %>
          <% expense e=new expense(); %>

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
                      <div class="row">
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
                            <h5 class="card-title">Bordered Tabs</h5>

                            <!-- Bordered Tabs -->
                            <ul class="nav nav-tabs nav-tabs-bordered" id="borderedTab" role="tablist">
                              <li class="nav-item justify-content-between align-items-center" role="presentation">
                                <button class="nav-link active" id="home-tab" data-bs-toggle="tab"
                                  data-bs-target="#bordered-home" type="button" role="tab" aria-controls="home"
                                  aria-selected="true"><span class="badge square-pill bg-primary p-2 ms-2"><i
                                      class="bi bi-plus-lg"></i></span>
                                  New</button>
                              </li>
                              <li class="nav-item" role="presentation">
                                <button class="nav-link" id="profile-tab" data-bs-toggle="tab"
                                  data-bs-target="#bordered-profile" type="button" role="tab" aria-controls="profile"
                                  aria-selected="false" tabindex="-1"><span
                                    class="badge square-pill bg-primary p-2 ms-2"><i class="bi bi-calendar"></i></span>
                                  <%= e.now() %>
                                </button>
                              </li>
                              <li class="nav-item" role="presentation">
                                <button class="nav-link" id="contact-tab" data-bs-toggle="tab"
                                  data-bs-target="#bordered-contact" type="button" role="tab" aria-controls="contact"
                                  aria-selected="false" tabindex="-1"><span
                                    class="badge square-pill bg-primary p-2 ms-2"><i class="ri-filter-line"></i></span>
                                  Filter</button>
                              </li>

                            </ul>
                            <div class="tab-content pt-2" id="borderedTabContent">
                              <div class="tab-pane fade show active" id="bordered-home" role="tabpanel"
                                aria-labelledby="home-tab">
                                Sunt est soluta temporibus accusantium neque nam maiores
                                cumque temporibus. Tempora libero non est
                                unde veniam est qui dolor. Ut sunt iure rerum quae
                                quisquam autem eveniet perspiciatis odit. Fuga
                                sequi sed ea saepe at unde.
                              </div>
                              <div class="tab-pane fade" id="bordered-profile" role="tabpanel"
                                aria-labelledby="profile-tab">
                                Nesciunt totam et. Consequuntur magnam aliquid eos nulla
                                dolor iure eos quia. Accusantium distinctio
                                omnis et atque fugiat. Itaque doloremque aliquid sint
                                quasi quia distinctio similique. Voluptate nihil
                                recusandae mollitia dolores. Ut laboriosam voluptatum
                                dicta.
                              </div>
                              <div class="tab-pane fade" id="bordered-contact" role="tabpanel"
                                aria-labelledby="contact-tab">
                                Saepe animi et soluta ad odit soluta sunt. Nihil quos
                                omnis animi debitis cumque. Accusantium
                                quibusdam perspiciatis qui qui omnis magnam. Officiis
                                accusamus impedit molestias nostrum veniam. Qui
                                amet ipsum iure. Dignissimos fuga tempore dolor.
                              </div>
                            </div><!-- End Bordered Tabs -->
                          </div>
                        </div>
                      </div>
                    </section>

                  </main><!-- End #main -->

                  <%@ include file="footer.jsp" %>

            </body>

        </html>