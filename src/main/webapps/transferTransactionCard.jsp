<ul class="list-group list-group-flush">
  <li class="list-group-item justify-content-between align-items-start">
    <div class="fields">
      <div class="field">
        <label class="col-form-label">
          <%= tab_var1 %>
        </label>
        <div class="row mb-3">
          <div>
            <select class="form-select" aria-label="Default select example" id="walletSelect3"
              onchange="updateGroupOptions(3)">
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
            <select class="form-select" aria-label="Default select example" id="groupSelect3"
              onchange="updateGroupDescOptions(3)">
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
            <select class="form-select" aria-label="Default select example" id="groupDescSelect3"
              onchange="updateGroupNumberOptions(3)">
              <option disabled selected>--Select Group Description--</option>
            </select>
          </div>
        </div>
      </div>
      <div class="field">
        <label class="col-form-label">Group Number</label>
        <div class="row mb-3">
          <div>
            <select class="form-select" aria-label="Default select example" id="groupNumSelect3"
              onchange="updateWalletID(3)">
              <option disabled selected>--Select Group Number--</option>
            </select>
          </div>
        </div>
      </div>
    </div>
    <input type="hidden" id="selectedWalletID3" value="">
  </li>
  <li class="list-group-item justify-content-between align-items-start">
    <div class="fields">
      <div class="field">
        <label class="col-form-label">
          <%= tab_var2 %>
        </label>
        <div class="row mb-3">
          <div>
            <select class="form-select" aria-label="Default select example" id="walletSelect4"
              onchange="updateGroupOptions(4)">
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
            <select class="form-select" aria-label="Default select example" id="groupSelect4"
              onchange="updateGroupDescOptions(4)">
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
            <select class="form-select" aria-label="Default select example" id="groupDescSelect4"
              onchange="updateGroupNumberOptions(4)">
              <option disabled selected>--Select Group Description--</option>
            </select>
          </div>
        </div>
      </div>
      <div class="field">
        <label class="col-form-label">Group Number</label>
        <div class="row mb-3">
          <div>
            <select class="form-select" aria-label="Default select example" id="groupNumSelect4"
              onchange="updateWalletID(4)">
              <option disabled selected>--Select Group Number--</option>
            </select>
          </div>
        </div>
      </div>
    </div>
    <input type="hidden" id="selectedWalletID4" value="">
  </li>
  <li class="list-group-item justify-content-between align-items-start">
    <div class="fields">
      <div class="field">
        <label class="col-form-label">Amount</label>
        <div class="input-group mb-3">
          <input type="number" class="form-control" value="0" id="amount3">
          <span class="input-group-text" id="inputGroupPrepend">Tk</span>
        </div>
      </div>
      <div class="field">
        <label class="col-form-label" style="color: transparent;">Bro</label>
        <div class="input-group mb-3">
          <button type="submit" class="btn btn-primary" onclick="addTransfer(event)">
            <%= btn_txt %>
          </button>
        </div>
      </div>
    </div>
  </li>
</ul>
<script>
  function getDatetime() {
    // Get current date and time
    let now = new Date();

    // Extract date components
    let year = now.getFullYear();
    let month = ('0' + (now.getMonth() + 1)).slice(-2); // Months are zero-indexed
    let day = ('0' + now.getDate()).slice(-2);

    // Extract time components
    let hours = ('0' + now.getHours()).slice(-2);
    let minutes = ('0' + now.getMinutes()).slice(-2);
    let seconds = ('0' + now.getSeconds()).slice(-2);

    // Format the date and time
    let formattedDateTime = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds
    return formattedDateTime
  }
  function addTransfer(event) {
    event.preventDefault();

    if (document.getElementById("groupSelect3").value === 'Cash') {
        var id = document.getElementById("selectedWalletID3");
        var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
            return wallet.type === 'Cash';
        });
        selectedGrpNumObjects.forEach(function (wallet) {
            id.value = wallet.id;
        });
        console.log("id: " + id.value);
    }

    const username = '<%= (String)session.getAttribute("User") %>';
    const category = 'Transfer';
    const walletFrom = document.getElementById("selectedWalletID3").value;
    const walletTo = document.getElementById("selectedWalletID4").value;
    const note = 'Transfer from ' + document.getElementById("walletSelect3").value + ' to ' + document.getElementById("walletSelect4").value;
    const amount = document.getElementById("amount3").value;
    const spent_on = getDatetime();

    // Create a JSON object from form data
    const newExpense = {
        username: username,
        note: note,
        category: category,
        wallet: walletFrom,
        amount: amount,
        spent_on: spent_on
    };
    console.log(spent_on);

    const xhr = new XMLHttpRequest();
    let url = "http://localhost:9090/api/addExpense";
    console.log(url);
    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-Type', 'application/json');

    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log("done")
            console.log(xhr.response)
            if (xhr.status === 200) {
                console.log("and dusted")
                console.log('Expense successfully added');

                if (document.getElementById("groupSelect4").value === 'Cash') {
                    var id = document.getElementById("selectedWalletID4");
                    var selectedGrpNumObjects = walletObjects.filter(function (wallet) {
                        return wallet.type === 'Cash';
                    });
                    selectedGrpNumObjects.forEach(function (wallet) {
                        id.value = wallet.id;
                    });
                    console.log("id: " + id.value);
                }

                const newIncome = {
                    username: username,
                    note: note,
                    wallet: walletTo,
                    amount: amount
                };
                url = "http://localhost:9090/api/addIncome";
                console.log(url);
                xhr.open('POST', url, true);
                xhr.setRequestHeader('Content-Type', 'application/json');

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            alert('Transfer successfully done');
                        } else {
                            console.error('Error:', xhr.statusText);
                        }
                    }
                };

                xhr.send(JSON.stringify(newIncome));

            } else {
                console.error('Error:', xhr.statusText);
            }
        }
    };

    xhr.send(JSON.stringify(newExpense));
}

</script>