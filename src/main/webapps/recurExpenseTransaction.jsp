<div class="fields">
  <div class="field">
    <label class="col-form-label">Group</label>
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example" id="groupSelect6"
          onchange="updateGroupDescOptions(6)">
          <option disabled selected>--Select Group--</option>
          <!-- <% for (int i = 0; i < w_list.size(); i++) { %>
            <option name="wallet_options" value="<%= i+1 %>"><% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %><%= w.getName(w_list.get(i).name) %><% } %></option><% } %> -->
        </select>
      </div>
    </div>
  </div>
  <div class="field">
    <label class="col-form-label">Group Description</label>
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example" id="groupDescSelect6"
          onchange="updateGroupNumberOptions(6)">
          <option disabled selected>--Select Group Description--</option>
          <!-- <% for (int i = 0; i < w_list.size(); i++) { %>
            <option name="wallet_options" value="<%= i+1 %>"><% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %><%= w.getName(w_list.get(i).name) %><% } %></option><% } %> -->
        </select>
      </div>
    </div>
  </div>
</div>
<div class="fields">
  <div class="field">
    <label class="col-form-label">Group Number</label>
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example" id="groupNumSelect6"
          onchange="updateWalletID(6)">
          <option disabled selected>--Select Group Number--</option>
          <!-- <% for (int i = 0; i < w_list.size(); i++) { %>
            <option name="wallet_options" value="<%= i+1 %>"><% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %><%= w.getName(w_list.get(i).name) %><% } %></option><% } %> -->
        </select>
      </div>
    </div>
  </div>
  <div class="field">
    <label class="col-form-label" style="color: transparent;">Bro</label>
    <div class="input-group mb-3">
      <button type="submit" class="btn btn-primary" onclick="addExpense(event)">
        <%= btn_txt %>
      </button>
    </div>
  </div>
</div>
<input type="hidden" id="selectedWalletID6" value="">
<script>
  var walletObjects = <%= new Gson().toJson(w_list) %>;
  var recurObjects = <%= new Gson().toJson(recur_list) %>;
  let selectedWalletObjects;
  function updateGroupOptions(setNumber) {
    var walletId =parseInt(document.getElementById("vernon").value,10) ;
    console.log(walletId)
    var selectedName = walletObjects.filter(function (wallet) {
      return wallet.id === walletId;
    });
    selectedName=selectedName[0].name
    console.log(selectedName)
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
    updateGroupDescOptions(setNumber)
  }
  function updateGroupDescOptions(setNumber) {
    var grpSelect = document.getElementById("groupSelect" + setNumber);
    var selectedGrp = grpSelect.value;
    var groupDescSelect = document.getElementById("groupDescSelect" + setNumber);
    groupDescSelect.innerHTML = '<option disabled selected>--Select Group Description--</option>';

    selectedGrpObjects = selectedWalletObjects.filter(function (wallet) {
      return wallet.type === selectedGrp;
    });

    let prev = '';
    selectedGrpObjects.forEach(function (wallet) {
      if (wallet.type_unique_name !== prev) {
        var option = document.createElement("option");
        option.value = wallet.type_unique_name;
        option.text = wallet.type_unique_name;
        groupDescSelect.appendChild(option);
        prev = wallet.type_unique_name;
      }
    });
    updateGroupNumberOptions(setNumber)
  }
  function updateGroupNumberOptions(setNumber) {
    var grpDescSelect = document.getElementById("groupDescSelect" + setNumber);
    var selectedGrpDesc = grpDescSelect.value;
    var groupNumSelect = document.getElementById("groupNumSelect" + setNumber);
    groupNumSelect.innerHTML = '<option disabled selected>--Select Group Number--</option>';

    var selectedGrpDescObjects = walletObjects.filter(function (wallet) {
      return wallet.type_unique_name === selectedGrpDesc;
    });

    let prev = '';
    selectedGrpDescObjects.forEach(function (wallet) {
      if (wallet.type_unique_number !== prev) {
        var option = document.createElement("option");
        option.value = wallet.type_unique_number;
        option.text = wallet.type_unique_number;
        groupNumSelect.appendChild(option);
        prev = wallet.type_unique_number;
      }
    });
  }
  function updateWalletID(setNumber) {
    var grpNumSelect = document.getElementById("groupNumSelect" + setNumber);
    var selectedGrpNum = grpNumSelect.value;
    var idElement = document.getElementById("selectedWalletID" + setNumber);

    var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
      return wallet.type_unique_number === selectedGrpNum;
    });

    selectedGrpNumObjects.forEach(function (wallet) {
      idElement.value = wallet.id;
    });

    console.log("id: " + idElement.value);
  }
  function addExpense(event) {
    event.preventDefault();

    if (document.getElementById("groupSelect6").value === 'Cash') {
      var id = document.getElementById("selectedWalletID6");
      var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
        return wallet.type === 'Cash';
      });
      selectedGrpNumObjects.forEach(function (wallet) {
        id.value = wallet.id;
      });
      console.log("id: " + id.value);
    }
    const username = '<%= (String)session.getAttribute("User") %>'
    const category =recurObjects[parseInt(document.getElementById("joshua").value)].category 
    const note = recurObjects[parseInt(document.getElementById("joshua").value)].details 
    const wallet = parseInt(document.getElementById("vernon").value)
    const amount = recurObjects[parseInt(document.getElementById("joshua").value)].amount 
    const spent_on = recurObjects[parseInt(document.getElementById("joshua").value)].start_date +' '+recurObjects[parseInt(document.getElementById("joshua").value)].time
    // Create a JSON object from form data
    const newExpense = {
      username: username,
      note: note,
      category: category,
      wallet: wallet,
      amount: amount,
      spent_on: spent_on
    };
    console.log(newExpense)
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