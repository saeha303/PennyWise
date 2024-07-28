package org.controller;
import org.expense.expense;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;
//
@RestController
@RequestMapping("/api")
public class PennyWiseController {

   @Autowired
   public PennyWiseController() {

   }
   @CrossOrigin(origins = "http://localhost:8080")
    @GetMapping("/net-worth")
    public ResponseEntity<List<Integer>> getNetWorth(@RequestParam String user, @RequestParam String wallet) {
        // Replace with your actual logic to retrieve net worth
        List<Integer> netWorth = new expense().getNetWorth(user, wallet);
        return new ResponseEntity<>(netWorth, HttpStatus.OK);
    }
//    @PostMapping("/save")
//    public ResponseEntity<HttpStatus> saveExpense(@RequestBody NewExpense newExpense) {
//        return new ResponseEntity<>(expenseManagementService.addExpense(newExpense) ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
//    }

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
