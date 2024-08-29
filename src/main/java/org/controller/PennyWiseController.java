package org.controller;
import java.util.List;

import org.expense.budget;
import org.expense.expense;
import org.expense.recurring;
import org.income.income;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

//
@CrossOrigin(origins = "http://localhost:8080")
@RestController
@RequestMapping("/api")
public class PennyWiseController {

   @Autowired
   public PennyWiseController() {

   }
   @GetMapping("/pages-report")
    public String pagesReport(){
        return "pages-report";
    }
    @GetMapping("/index")
    public String index(){
        return "index";
    }
    @GetMapping("/pages-transaction")
    public String pagesTransaction(){
        return "pages-transaction";
    }
    @GetMapping("/pages-wallets")
    public String pagesWallets(){
        return "pages-wallets";
    }
    @GetMapping("/pages-settings")
    public String pagesSettings(){
        return "pages-settings";
    }
    @GetMapping("/users-profile")
    public String pagesProfile(){
        return "users-profile";
    }
    @GetMapping("/pages-register")
    public String pagesRegister(){
        return "pages-register";
    }
    @GetMapping("/pages-login")
    public String pagesLogin(){
        return "pages-login";
    }
    @GetMapping("/pages-special-thanks")
    public String pagesST(){
        return "pages-special-thanks";
    }
    @GetMapping("/pages-recurring-exp")
    public String pagesRecurExp(){
        return "pages-recurring-exp";
    }
    @GetMapping("/pages-budget")
    public String pagesBudget(){
        return "pages-budget";
    }

    @GetMapping("/net-worth")
    public ResponseEntity<List<Integer>> getNetWorth(@RequestParam String user, @RequestParam String wallet) {
        // Replace with your actual logic to retrieve net worth
        List<Integer> netWorth = new expense().getNetWorth(user, wallet);
        return new ResponseEntity<>(netWorth, HttpStatus.OK);
    }
    @GetMapping("/budget-report")
    public ResponseEntity<List<Integer>> getBudgetReport(@RequestParam String user, @RequestParam String wallet) {
        // Replace with your actual logic to retrieve net worth
        List<Integer> budget = new budget().budgetPredictReal(user, wallet);
        return new ResponseEntity<>(budget, HttpStatus.OK);
    }
    @GetMapping("/top-expense")
    public ResponseEntity<List<expense>> getTopExpense(@RequestParam String user, @RequestParam String wallet) {
        // Replace with your actual logic to retrieve net worth
        List<expense> topExpense = new expense().getDailyDonutChart(user, wallet);
        topExpense=topExpense.subList(0, Math.min(3, topExpense.size()));
        return new ResponseEntity<>(topExpense, HttpStatus.OK);
    }
    @GetMapping("/report-expense")
    public ResponseEntity<List<expense>> getReportExpense(@RequestParam String user, @RequestParam String wallet) {
        // Replace with your actual logic to retrieve net worth
        List<expense> reportExpense = new expense().getDailyDonutChart(user, wallet);
        return new ResponseEntity<>(reportExpense, HttpStatus.OK);
    }
    @GetMapping("/report-expense-super-bar")
    public ResponseEntity<List<expense>> getReportBar(@RequestParam String user, @RequestParam String wallet, @RequestParam String month) {
        // Replace with your actual logic to retrieve net worth
        List<expense> reportExpense = new expense().getMonthlyBar(user, wallet, month);
        return new ResponseEntity<>(reportExpense, HttpStatus.OK);
    }
    @PostMapping("/addExpense")
    public ResponseEntity<String> addExpense(@RequestBody expense newExpense) {
        int result = new expense().store(newExpense);
        System.out.println("in controller: "+result);
        if (result == 1) {
            System.out.println("case 1");
            // If the store method returns 1 (success), return HTTP 200 OK
            return new ResponseEntity<>("Expense added successfully", HttpStatus.OK);
        } else {
            System.out.println("case 2");
            // If the store method returns 3 (failure), return HTTP 500 Internal Server Error
            return new ResponseEntity<>("Failed to add expense", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @PostMapping("/addRecurExpense")
    public ResponseEntity<String> addRecurExpense(@RequestBody recurring newExpense) {
        int result = new recurring().store(newExpense);
        System.out.println("in controller: "+result);
        if (result == 1) {
            System.out.println("case 1");
            // If the store method returns 1 (success), return HTTP 200 OK
            return new ResponseEntity<>("Recurring expense added successfully", HttpStatus.OK);
        } else {
            System.out.println("case 2");
            // If the store method returns 3 (failure), return HTTP 500 Internal Server Error
            return new ResponseEntity<>("Failed to add recurring expense", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @PostMapping("/addBudget")
    public ResponseEntity<String> addBudget(@RequestBody budget newExpense) {
        int result = new budget().store(newExpense);
        System.out.println("in controller: "+result);
        if (result == 1) {
            System.out.println("case 1");
            // If the store method returns 1 (success), return HTTP 200 OK
            return new ResponseEntity<>("Budget added successfully", HttpStatus.OK);
        } else {
            System.out.println("case 2");
            // If the store method returns 3 (failure), return HTTP 500 Internal Server Error
            return new ResponseEntity<>("Failed to add budget", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @PostMapping("/addIncome")
    public ResponseEntity<String> addIncome(@RequestBody income newIncome) {
        int result = new income().store(newIncome);

        if (result == 1) {
            // If the store method returns 1 (success), return HTTP 200 OK
            return new ResponseEntity<>("Income added successfully", HttpStatus.OK);
        } else {
            // If the store method returns 3 (failure), return HTTP 500 Internal Server Error
            return new ResponseEntity<>("Failed to add income", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
//    @GetMapping("/report")
//    public ResponseEntity<List<MonthlyReport>> getReport(@ModelAttribute ReportRequest reportRequest) {
//        List<MonthlyReport> monthlyReportList = expenseManagementService.getReport(reportRequest);
//        return new ResponseEntity<>(monthlyReportList, HttpStatus.OK);
//    }

//    @GetMapping("/{year}/{month}")
//    public ResponseEntity<List<ExpenseEntity>> getExpenseByMonth(@PathVariable(required = false) Integer year,
//            @PathVariable Month month,
//            @RequestParam(name = "page", required = false) Integer page,
//            @RequestParam(name = "itemsPerPage", required = false) Integer itemsPerPage,
//            @RequestParam(name = "sortField", required = false) String sortField,
//            @RequestParam(name = "sortOrder", required = false) String sortOrder
//    ) {
//        try {
//            // Update the service method to handle new parameters
//            List<ExpenseEntity> expenses = expenseManagementService.getExpensesByMonth(year, month, page, itemsPerPage, sortField, sortOrder);

//            return new ResponseEntity<>(expenses, HttpStatus.OK);
//        } catch (RuntimeException e) {
//            throw e;
//        }
//    }

//    @GetMapping
//    public ResponseEntity<List<ExpenseEntity>> getExpenseByDateRange(
//            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
//            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate
//    ) {
//        return new ResponseEntity<>(expenseManagementService.getExpenseByDateRange(startDate, endDate), HttpStatus.OK);
//    }
}
