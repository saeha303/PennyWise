
<ul class="list-group list-group-flush">
  <li class="list-group-item justify-content-between align-items-start">
    <div class="fields">
      <div class="field">
        <label class="col-form-label">
          <%= tab_var1 %>
        </label>
        <div class="row mb-3">
          <div>
            <select class="form-select" aria-label="Default select example" id="walletSelect1"
              onchange="updateGroupOptions1()">
              <option disabled selected>--Select Wallet--</option>
              <% for (int i=0; i < w_list.size(); i++) { %>
                <% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %>
                  <option name="wallet_options" value="<%= w_list.get(i).name %>">
                    <%= w.getName(w_list.get(i).name) %>
                  </option>
                  <% } %>
              <% } %>
            </select>
          </div>
        </div>
      </div>
      <div class="field">
        <label class="col-form-label">Group</label>
        <div class="row mb-3">
          <div>
            <select class="form-select" aria-label="Default select example" id="groupSelect1"
              onchange="updateGroupDescOptions1()">
              <option disabled selected>--Select Group--</option>
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
            <select class="form-select" aria-label="Default select example" id="groupDescSelect1"
              onchange="updateGroupNumberOptions1()">
              <option disabled selected>--Select Group Description--</option>
            </select>
          </div>
        </div>
      </div>
      <div class="field">
        <label class="col-form-label">Group Number</label>
        <div class="row mb-3">
          <div>
            <select class="form-select" aria-label="Default select example" id="groupNumSelect1" onchange="updateWalletID1()">
              <option disabled selected>--Select Group Number--</option>
            </select>
          </div>
        </div>
      </div>
    </div>
    <input type="hidden" id="selectedWalletID1" value="">
</li>
<li class="list-group-item justify-content-between align-items-start">
  <div class="fields">
    <div class="field">
      <label class="col-form-label">
        <%= tab_var2 %>
      </label>
      <div class="row mb-3">
        <div>
          <select class="form-select" aria-label="Default select example" id="walletSelect2"
            onchange="updateGroupOptions2()">
            <option disabled selected>--Select Wallet--</option>
            <% for (int i=0; i < w_list.size(); i++) { %>
              <% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %>
                <option name="wallet_options" value="<%= w_list.get(i).name %>">
                  <%= w.getName(w_list.get(i).name) %>
                </option>
                <% } %>
            <% } %>
          </select>
        </div>
      </div>
    </div>
    <div class="field">
      <label class="col-form-label">Group</label>
      <div class="row mb-3">
        <div>
          <select class="form-select" aria-label="Default select example" id="groupSelect2"
            onchange="updateGroupDescOptions2()">
            <option disabled selected>--Select Group--</option>
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
          <select class="form-select" aria-label="Default select example" id="groupDescSelect2"
            onchange="updateGroupNumberOptions2()">
            <option disabled selected>--Select Group Description--</option>
          </select>
        </div>
      </div>
    </div>
    <div class="field">
      <label class="col-form-label">Group Number</label>
      <div class="row mb-3">
        <div>
          <select class="form-select" aria-label="Default select example" id="groupNumSelect2" onchange="updateWalletID2()">
            <option disabled selected>--Select Group Number--</option>
          </select>
        </div>
      </div>
    </div>
  </div>
  <input type="hidden" id="selectedWalletID2" value="">
</li>
<li class="list-group-item justify-content-between align-items-start">
<div class="fields">
  <div class="field">
    <label class="col-form-label">Amount</label>
    <div class="input-group mb-3">
      <input type="number" class="form-control" value="0" id="amount1">
      <span class="input-group-text" id="inputGroupPrepend">Tk</span>
    </div>
  </div>
  <div class="field">
    <label class="col-form-label" style="color: transparent;">Bro</label>
    <div class="input-group mb-3">
      <button type="submit" class="btn btn-primary"><%= btn_txt %></button>
    </div>
  </div>
</div>
</li>
</ul>
<script>
  function updateGroupOptions1() {
  var walletSelect = document.getElementById("walletSelect1");
  var selectedName = walletSelect.value;
  console.log(selectedName);
  var groupSelect = document.getElementById("groupSelect1");
  groupSelect.innerHTML = '<option disabled selected>--Select Group--</option>';
  var uniqueNames = new Set();
  var selectedWalletObjects = walletObjects.filter(function (wallet) {
    return wallet.name === selectedName;
  });
  console.log(selectedWalletObjects);
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

function updateGroupDescOptions1() {
  var grpSelect = document.getElementById("groupSelect1");
  var selectedGrp = grpSelect.value;
  console.log(selectedGrp);
  var groupDescSelect = document.getElementById("groupDescSelect1");
  groupDescSelect.innerHTML = '<option disabled selected>--Select Group Description--</option>';

  var selectedGrpObjects = walletObjects.filter(function (wallet) {
    return wallet.type === selectedGrp;
  });
  console.log(selectedGrpObjects);
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
}

function updateGroupNumberOptions1() {
  var grpDescSelect = document.getElementById("groupDescSelect1");
  var selectedGrpDesc = grpDescSelect.value;
  console.log(selectedGrpDesc);
  var groupNumSelect = document.getElementById("groupNumSelect1");
  groupNumSelect.innerHTML = '<option disabled selected>--Select Group Number--</option>';

  var selectedGrpDescObjects = walletObjects.filter(function (wallet) {
    return wallet.type_unique_name === selectedGrpDesc;
  });
  console.log(selectedGrpDescObjects);
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

function updateWalletID1() {
  var grpNumSelect = document.getElementById("groupNumSelect1");
  var selectedGrpNum = grpNumSelect.value;
  var id = document.getElementById("selectedWalletID1");
  var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
    return wallet.type_unique_number === selectedGrpNum;
  });
  selectedGrpNumObjects.forEach(function (wallet) {
    id.value = wallet.id;
  });
  console.log("id: " + id.value);
}

function updateGroupOptions2() {
  var walletSelect = document.getElementById("walletSelect2");
  var selectedName = walletSelect.value;
  console.log(selectedName);
  var groupSelect = document.getElementById("groupSelect2");
  groupSelect.innerHTML = '<option disabled selected>--Select Group--</option>';
  var uniqueNames = new Set();
  var selectedWalletObjects = walletObjects.filter(function (wallet) {
    return wallet.name === selectedName;
  });
  console.log(selectedWalletObjects);
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

function updateGroupDescOptions2() {
  var grpSelect = document.getElementById("groupSelect2");
  var selectedGrp = grpSelect.value;
  console.log(selectedGrp);
  var groupDescSelect = document.getElementById("groupDescSelect2");
  groupDescSelect.innerHTML = '<option disabled selected>--Select Group Description--</option>';

  var selectedGrpObjects = walletObjects.filter(function (wallet) {
    return wallet.type === selectedGrp;
  });
  console.log(selectedGrpObjects);
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
}

function updateGroupNumberOptions2() {
  var grpDescSelect = document.getElementById("groupDescSelect2");
  var selectedGrpDesc = grpDescSelect.value;
  console.log(selectedGrpDesc);
  var groupNumSelect = document.getElementById("groupNumSelect2");
  groupNumSelect.innerHTML = '<option disabled selected>--Select Group Number--</option>';

  var selectedGrpDescObjects = walletObjects.filter(function (wallet) {
    return wallet.type_unique_name === selectedGrpDesc;
  });
  console.log(selectedGrpDescObjects);
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

function updateWalletID2() {
  var grpNumSelect = document.getElementById("groupNumSelect2");
  var selectedGrpNum = grpNumSelect.value;
  var id = document.getElementById("selectedWalletID2");
  var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
    return wallet.type_unique_number === selectedGrpNum;
  });
  selectedGrpNumObjects.forEach(function (wallet) {
    id.value = wallet.id;
  });
  console.log("id: " + id.value);
}
</script>