package org.controller;

import java.util.Collections;
import java.util.List;

import org.expense.expense;
import org.services.FuzzySearchService;
import org.services.AiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:8080")
@RestController
@RequestMapping("/api")
public class SearchController {

    @Autowired
    private FuzzySearchService fuzzySearchService=new FuzzySearchService();

    @Autowired
    private AiService aiService=new AiService();

    @GetMapping("/search")
    public String searchExpenses(@RequestParam String query) {
        // return aiService.processQuery(query);
        return "None";
    }
//    public List<expense> searchExpenses(@RequestParam String query) {
//        // try {
//        //     String date = nlpService.extractDate(query);
//        //     if (date != null) {
//        //         // Handle date-based search if necessary
//        //         System.out.println(date);
//        //     }
//        //     return fuzzySearchService.search(query);
//        // } catch (Exception e) {
//        //     e.printStackTrace();
//        //     return Collections.emptyList();
//        // }
//        return nlpService.processQuery(query);
//    }
}

