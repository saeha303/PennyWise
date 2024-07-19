
  
<label class="col-form-label"><%= tab_var1 %></label>
<div class="fields">
  <div class="field">
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example">
          <option selected>Open this select menu</option>
          <option value="1">One</option>
          <option value="2">Two</option>
          <option value="3">Three</option>
        </select>
      </div>
    </div>
  </div>
  <div class="field">
    <div class="input-group mb-3">
      <input type="number" class="form-control" value="0">
      <select class="form-select" aria-label="Default select example">
        <option selected>TK</option>
        <option value="1">USD</option>
        <option value="2">EURO</option>
        <option value="3">JPY</option>
        <option value="4">WON</option>
      </select>
    </div>
  </div>
</div>
<!-- tags and date -->
<label class="col-form-label">Category</label>
<div class="fields">
  <div class="field">
    <div class="row mb-3">
      <div>
        <select class="form-select" aria-label="Default select example">
          <option disabled selected>--Select Category--</option>
          <% for (int i = 0; i < cat_list.size(); i++) { %>
            <option name="category_options" value="<%= i+1 %>"><%= cat_list.get(i) %><% } %></option>
        </select>
      </div>
    </div>
  </div>
  <div class="field">
    <div class="input-group mb-3">
      <input type="date" class="form-control">
    </div>
  </div>
</div>
<!-- end of tags and data -->
<div class="fields">
  <div class="field">
    <div class="row mb-3">
      <div>
        <div class="form-floating mb-3">
          <input type="email" class="form-control" id="floatingInput" placeholder="Note">
          <label for="floatingInput">Note</label>
        </div>
      </div>
    </div>
  </div>
  <div class="field">
    <div class="input-group mb-3">
      <button type="submit" class="btn btn-primary"><%= btn_txt %></button>
    </div>
  </div>
</div>