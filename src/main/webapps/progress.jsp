<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <div class="card">
    <div class="filter">
      <a class="icon" href="#" data-bs-toggle="dropdown"><i class="ri-filter-2-line"></i><i
          class="bi bi-three-dots"></i></a>
      <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" id="net-worth-filter" aria-valuenow="">
        <li class="dropdown-header text-start" value="filter" aria-selected="true">
          <h6>Choose wallet</h6>
        </li>
        <% for(int i=0; i<w_list.size(); i++) { %>
          <% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %>
          <li value="<%= w_list.get(i).name %>">
            <a class="dropdown-item"
              onclick="document.getElementById('net-worth-filter').value='<%= w_list.get(i).name %>'">
              
                <%= w.getName(w_list.get(i).name) %>
                  <% } %>
            </a>
          </li>
          <% } %>
      </ul>
    </div>
    
    <div class="card-body">
      <h5 class="card-title" id="filter_holder">Net Worth <span 
        aria-labelledby="today">|My Wallet</span></h5>
      <div class="row" id="net-worth-card">
        <div class="col-lg-2 ps-3">
          <h6>Income</h6>
          <span class="text-info small pt-1 fw-bold">
            <%= netWorth.get(1) %>
          </span>
        </div>
        <div class="col-lg-8">
        <div class="progress mt-3">
          <div
            class="progress-bar progress-bar-striped <%if(netWorth.get(2)<70){%><%= "" %><%}else if(netWorth.get(2)>=90){%><%= "bg-danger" %>
            <%}else if(netWorth.get(2)>=70){%><%= "bg-warning" %>
                <%}%> progress-bar-animated" role="progressbar"
                  style="width: <%= netWorth.get(3) %>%" aria-valuenow="<%= netWorth.get(3) %>" aria-valuemin="0"
                      aria-valuemax="100"><%= netWorth.get(3) %>%
          </div>
        </div>
      </div>
        <div class="col-lg-2 ps-3">
          <h6>Expense</h6>
          <span class="text-info small pt-1 fw-bold">
            <%= netWorth.get(0) %>
          </span>
        </div>

      </div>
    </div>
  </div>
  <script>
    document.addEventListener('DOMContentLoaded', () => {
      const netWorthFilter = document.getElementById('net-worth-filter');
      netWorthFilter.addEventListener('click', () => {
        const user = '<%= (String)session.getAttribute("User") %>';
        const wallet = netWorthFilter.value;
        const text = document.getElementById("filter_holder");
        text.innerHTML = `Net Worth <span>|` + wallet + `</span>`;
        const xhr = new XMLHttpRequest();
        console.log(user);
        const url = "http://localhost:9090/api/net-worth?user=" + user + "&wallet=" + encodeURIComponent(wallet);
        console.log(url)
        xhr.open('GET', url, true);
        xhr.setRequestHeader('Content-Type', 'application/json');

        xhr.onreadystatechange = function () {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
              const data = JSON.parse(xhr.responseText);
              updateProgressBar(data);
            } else {
              console.error('Error:', xhr.statusText);
            }
          }
        };

        xhr.send();

      });

      function updateProgressBar(netWorth) {
        const container = document.getElementById("net-worth-card");
        const part1 = `<div class="col-lg-2 ps-3">
                        <h6>Income</h6>
                        <span class="text-info small pt-1 fw-bold">`+
                                netWorth[1] +
                                `</span>
                      </div>`;
        const str = netWorth[2] < 70 ? `` : netWorth[2] >= 90 ? `bg-danger` : `bg-warning`
        const part2 = `<div class="col-lg-8">
                        <div class="progress mt-3">
                          <div class="progress-bar progress-bar-striped `+ str + ` progress-bar-animated" role="progressbar"
                            style="width: `+ netWorth[3] + `%" aria-valuenow="` + netWorth[3] + `" aria-valuemin="0"
                            aria-valuemax="100">`+ netWorth[3] + `%
                          </div>
                        </div>
                      </div>`;
        const part3 = `<div class="col-lg-2 ps-3">
                        <h6>Expense</h6>
                        <span class="text-info small pt-1 fw-bold">
                          `+ netWorth[0] + `
                        </span>
                      </div>`;
        container.innerHTML = part1 + part2 + part3;

      }
    });
  </script>