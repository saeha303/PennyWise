package org.example;

import java.io.IOException;

import org.expense.*;

public class Main {
    public static void main(String[] args) throws IOException {
        System.out.println("Hello world!");
        expense e=new expense();
//        List<expense> expenseList=new expense().getExpenses(user);
//        e.getExpenses("john_doe");
        e.updateFau();
    }
}