<div class="fields">
  <div class="field">
    <label class="col-form-label">
      <%= tab_var1 %>
    </label>
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example" id="walletSelect"
          onchange="updateGroupOptions()">
          <option disabled selected>--Select Wallet--</option>
          <% for (int i=0; i < w_list.size(); i++) { %>
            <% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %>
              <option name="wallet_options" value="<%= w_list.get(i).name %>">
                <%= w.getName(w_list.get(i).name) %>
                  <% } %>
              </option>
              <% } %>
        </select>
      </div>
    </div>
  </div>
  <div class="field">
    <label class="col-form-label">Group</label>
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example" id="groupSelect"
          onchange="updateGroupDescOptions()">
          <option disabled selected>--Select Group--</option>
          <!-- <% for (int i = 0; i < w_list.size(); i++) { %>
            <option name="wallet_options" value="<%= i+1 %>"><% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %><%= w.getName(w_list.get(i).name) %><% } %></option><% } %> -->
        </select>
      </div>
    </div>
  </div>
</div>
<div class="fields">
  <div class="field">
    <label class="col-form-label">Group Description</label>
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example" id="groupDescSelect"
          onchange="updateGroupNumberOptions()">
          <option disabled selected>--Select Group Description--</option>
          <!-- <% for (int i = 0; i < w_list.size(); i++) { %>
            <option name="wallet_options" value="<%= i+1 %>"><% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %><%= w.getName(w_list.get(i).name) %><% } %></option><% } %> -->
        </select>
      </div>
    </div>
  </div>
  <div class="field">
    <label class="col-form-label">Group Number</label>
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example" id="groupNumSelect" onchange="updateWalletID()">
          <option disabled selected>--Select Group Number--</option>
          <!-- <% for (int i = 0; i < w_list.size(); i++) { %>
            <option name="wallet_options" value="<%= i+1 %>"><% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %><%= w.getName(w_list.get(i).name) %><% } %></option><% } %> -->
        </select>
      </div>
    </div>
  </div>
</div>
<!-- <% if((tab_var1).equals("From")){ %> -->
  <div class="fields">
    <div class="field">
      <label class="col-form-label">Category</label>
      <div class="row mb-3">
        <div>
          <select class="form-select" aria-label="Default select example" id="category">
            <option disabled selected>--Select Category--</option>
            <% for (int i=0; i < cat_list.size(); i++) { %>
              <option name="category_options" value="<%= cat_list.get(i).name %>">
                <%= cat_list.get(i).name %>
                  <% } %>
              </option>
          </select>
        </div>
      </div>
    </div>
    <div class="field">
      <label class="col-form-label">Amount</label>
      <div class="input-group mb-3">
        <input type="number" class="form-control" value="0" id="amount">
        <span class="input-group-text" id="inputGroupPrepend">Tk</span>
      </div>
    </div>
  </div>
  <div class="fields">

    <div class="field">
      <label class="col-form-label">Note</label>
      <div class="row mb-3">
        <div>
          <input type="email" class="form-control" placeholder="Note" id="note">
        </div>
      </div>
    </div>
    <div class="field">
      <label class="col-form-label">Date</label>
      <div class="input-group mb-3">
        <input type="datetime-local" id="calendar" class="form-control">
      </div>
    </div>
  </div>
  <!-- end of tags and data -->
  <div class="fields">

    <div class="field">
      <div class="input-group mb-3">
        <button type="submit" class="btn btn-primary" onclick="addExpense(event)">
          <%= btn_txt %>
        </button>
      </div>
    </div>
    <div class="field">

    </div>
  </div>
  <!-- <% } %> -->
      <input type="hidden" id="selectedWalletID" value="">
      <script>
        var walletObjects = <%= new Gson().toJson(w_list) %>;

        function updateGroupOptions() {
          var walletSelect = document.getElementById("walletSelect");
          var selectedName = walletSelect.value;
          console.log(selectedName)
          var groupSelect = document.getElementById("groupSelect");
          groupSelect.innerHTML = '<option disabled selected>--Select Group--</option>';
          var uniqueNames = new Set();
          var selectedWalletObjects = walletObjects.filter(function (wallet) {
            return wallet.name === selectedName;
          });
          console.log(selectedWalletObjects)
          let prev = ''
          selectedWalletObjects.forEach(function (wallet) {
            if (wallet.type !== prev) {
              var option = document.createElement("option");
              option.value = wallet.type;
              option.text = wallet.type; // Assuming wallet has a 'group' property
              groupSelect.appendChild(option);
              prev = wallet.type;
            }
          });
        }
        function updateGroupDescOptions() {
          var grpSelect = document.getElementById("groupSelect");
          var selectedGrp = grpSelect.value;
          console.log(selectedGrp)
          var groupDescSelect = document.getElementById("groupDescSelect");
          groupDescSelect.innerHTML = '<option disabled selected>--Select Group Description--</option>';

          var selectedGrpObjects = walletObjects.filter(function (wallet) {
            return wallet.type === selectedGrp;
          });
          console.log(selectedGrpObjects)
          let prev = ''
          selectedGrpObjects.forEach(function (wallet) {
            if (wallet.type_unique_name !== prev) {
              var option = document.createElement("option");
              option.value = wallet.type_unique_name;
              option.text = wallet.type_unique_name; // Assuming wallet has a 'group' property
              groupDescSelect.appendChild(option);
              prev = wallet.type_unique_name;
            }
          });
        }
        function updateGroupNumberOptions() {
          var grpDescSelect = document.getElementById("groupDescSelect");
          var selectedGrpDesc = grpDescSelect.value;
          console.log(selectedGrpDesc)
          var groupNumSelect = document.getElementById("groupNumSelect");
          groupNumSelect.innerHTML = '<option disabled selected>--Select Group Number--</option>';

          var selectedGrpDescObjects = walletObjects.filter(function (wallet) {
            return wallet.type_unique_name === selectedGrpDesc;
          });
          console.log(selectedGrpDescObjects)
          let prev = ''
          selectedGrpDescObjects.forEach(function (wallet) {
            if (wallet.type_unique_number !== prev) {
              var option = document.createElement("option");
              option.value = wallet.type_unique_number;
              option.text = wallet.type_unique_number; // Assuming wallet has a 'group' property
              groupNumSelect.appendChild(option);
              prev = wallet.type_unique_number;
            }
          });
        }
        function updateWalletID() {
          var grpNumSelect = document.getElementById("groupNumSelect");
          var selectedGrpNum = grpNumSelect.value;
          var id = document.getElementById("selectedWalletID");
          var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
            return wallet.type_unique_number === selectedGrpNum;
          });
          selectedGrpNumObjects.forEach(function (wallet) {
            id.value = wallet.id;
          });
          console.log("id: " + id.value);
        }
        function convertDatetime(datetimeStr) {
          // Split the input string into date and time parts
          let [date, time] = datetimeStr.split('T');

          // Append seconds to the time part
          time = time + ':00';

          // Combine date and time parts into the desired format
          let formattedDatetime = date + " " + time;

          return formattedDatetime;
        }
        function addExpense(event) {
          event.preventDefault();

          if (document.getElementById("groupSelect").value === 'Cash') {
            var id = document.getElementById("selectedWalletID");
            var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
              return wallet.type === 'Cash';
            });
            selectedGrpNumObjects.forEach(function (wallet) {
              id.value = wallet.id;
            });
            console.log("id: " + id.value);
          }
          const username = '<%= (String)session.getAttribute("User") %>'
          const category = document.getElementById("category").value
          const note = document.getElementById("note").value
          const wallet = document.getElementById("selectedWalletID").value
          const amount = document.getElementById("amount").value
          const spent_on = convertDatetime(document.getElementById("calendar").value)
          // Create a JSON object from form data
          const newExpense = {
            username: username,
            note: note,
            category: category,
            wallet: wallet,
            amount: amount,
            spent_on: spent_on
          };
          console.log(spent_on)
          const xhr = new XMLHttpRequest();
          const url = "http://localhost:9090/api/addExpense";
          console.log(url)
          xhr.open('POST', url, true);
          xhr.setRequestHeader('Content-Type', 'application/json');

          xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
              if (xhr.status === 200) {
                alert('Expense successfully added')
              } else {
                console.error('Error:', xhr.statusText);
              }
            }
          };

          xhr.send(JSON.stringify(newExpense));
        }
        function addIncome(event) {
          event.preventDefault();

          if (document.getElementById("groupSelect").value === 'Cash') {
            var id = document.getElementById("selectedWalletID");
            var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
              return wallet.type === 'Cash';
            });
            selectedGrpNumObjects.forEach(function (wallet) {
              id.value = wallet.id;
            });
            console.log("id: " + id.value);
          }
          const username = '<%= (String)session.getAttribute("User") %>'
          const category = document.getElementById("category").value
          const note = document.getElementById("note").value
          const wallet = document.getElementById("selectedWalletID").value
          const amount = document.getElementById("amount").value
          const spent_on = convertDatetime(document.getElementById("calendar").value)
          // Create a JSON object from form data
          const newExpense = {
            username: username,
            note: note,
            category: category,
            wallet: wallet,
            amount: amount,
            spent_on: spent_on
          };
          console.log(spent_on)
          const xhr = new XMLHttpRequest();
          const url = "http://localhost:9090/api/addExpense";
          console.log(url)
          xhr.open('POST', url, true);
          xhr.setRequestHeader('Content-Type', 'application/json');

          xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
              if (xhr.status === 200) {
                alert('Expense successfully added')
              } else {
                console.error('Error:', xhr.statusText);
              }
            }
          };

          xhr.send(JSON.stringify(newExpense));
        }
      </script>