<div class="card">
  <div class="filter">
    <a class="icon" href="#" data-bs-toggle="dropdown"><i
      class="ri-filter-2-line"></i><i
        class="bi bi-three-dots"></i></a>
    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" id="net-worth-filter" aria-valuenow="">
      <li class="dropdown-header text-start" value="filter"
        aria-selected="true">
        <h6>Choose wallet</h6>
      </li>
      <% for(int i = 0; i<w_list.size(); i++) { %>
      <li value="<%= w_list.get(i).name %>" >
        <a class="dropdown-item" onclick="document.getElementById('net-worth-filter').value='<%= w_list.get(i).name %>'"><%= w.getName(w_list.get(i).name) %></a>
      </li>
      <% } %>
    </ul>
    <script>
      const netWorth=document.getElementById('net-worth-filter');
      netWorth.addEventListener('click',()=>{
        console.log('clicked');
        console.log(netWorth.value);
        

      })
    </script>
  </div>
  <div class="card-body">
    <h5 class="card-title">Net Worth</h5>
    <div class="row">
      <div class="col-lg-2 ps-3">
        <h6>Income</h6>
        <span class="text-info small pt-1 fw-bold"><%= netWorth.get(1) %></span>
      </div>
      <div class="col-lg-8">
        <div class="progress mt-3">
          <div class="progress-bar progress-bar-striped <%if(netWorth.get(2)<70){%><%= "" %><%}else if(netWorth.get(2)>=90){%><%= "bg-danger" %><%}else if(netWorth.get(2)>=70){%><%= "bg-warning" %><%}%> progress-bar-animated" role="progressbar"
            style="width: <%= netWorth.get(3) %>%" aria-valuenow="<%= netWorth.get(3) %>" aria-valuemin="0" aria-valuemax="100"><%= netWorth.get(3) %>%</div>
        </div>
      </div>
      <div class="col-lg-2 ps-3">
        <h6>Expense</h6>
        <span class="text-info small pt-1 fw-bold"><%= netWorth.get(0) %></span>
      </div>

    </div>
  </div>
</div>