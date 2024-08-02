<div class="fields">
  <div class="field">
    <label class="col-form-label">
      <%= tab_var1 %>
    </label>
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example" id="walletSelect2"
          onchange="updateGroupOptions(2)">
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
        <select class="form-select" aria-label="Default select example" id="groupSelect2"
          onchange="updateGroupDescOptions(2)">
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
        <select class="form-select" aria-label="Default select example" id="groupDescSelect2"
          onchange="updateGroupNumberOptions(2)">
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
        <select class="form-select" aria-label="Default select example" id="groupNumSelect2" onchange="updateWalletID(2)">
          <option disabled selected>--Select Group Number--</option>
          <!-- <% for (int i = 0; i < w_list.size(); i++) { %>
            <option name="wallet_options" value="<%= i+1 %>"><% if(i==0 || !w_list.get(i).name.equals(w_list.get(i-1).name)){ %><%= w.getName(w_list.get(i).name) %><% } %></option><% } %> -->
        </select>
      </div>
    </div>
  </div>
</div>
<div class="fields">
  <div class="field">
    <label class="col-form-label">Note</label>
    <div class="row mb-3">
      <div>
        <input type="email" class="form-control" placeholder="Note" id="note2">
      </div>
    </div>
  </div>
  <div class="field">
    <label class="col-form-label">Amount</label>
    <div class="input-group mb-3">
      <input type="number" class="form-control" value="0" id="amount2">
      <span class="input-group-text" id="inputGroupPrepend">Tk</span>
    </div>
  </div>
</div>

<!-- end of tags and data -->
<div class="fields">

  <div class="field">
    <div class="input-group mb-3">
      <button type="submit" class="btn btn-primary" onclick="addIncome(event)">
        <%= btn_txt %>
      </button>
    </div>
  </div>
  <div class="field">

  </div>
</div>
<input type="hidden" id="_selectedWalletID" value="">
<script>
  function addIncome(event) {
    event.preventDefault();

    if (document.getElementById("groupSelect2").value === 'Cash') {
      var id = document.getElementById("selectedWalletID2");
      var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
        return wallet.type === 'Cash';
      });
      selectedGrpNumObjects.forEach(function (wallet) {
        id.value = wallet.id;
      });
      console.log("id: " + id.value);
    }
    const username = '<%= (String)session.getAttribute("User") %>'
    const note = document.getElementById("note2").value
    const wallet = document.getElementById("selectedWalletID2").value
    const amount = document.getElementById("amount2").value
    // Create a JSON object from form data
    const newIncome = {
      username: username,
      note: note,
      wallet: wallet,
      amount: amount,
    };
    const xhr = new XMLHttpRequest();
    const url = "http://localhost:9090/api/addIncome";
    console.log(url)
    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-Type', 'application/json');

    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          alert('Income successfully added')
        } else {
          console.error('Error:', xhr.statusText);
        }
      }
    };

    xhr.send(JSON.stringify(newIncome));
  }
</script>