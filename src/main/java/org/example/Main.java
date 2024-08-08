package org.example;

import java.io.IOException;
import java.util.List;

import org.expense.*;

public class Main {
    public static void main(String[] args) throws IOException {
        System.out.println("Hello world!");
        List<recurring> result=new recurring().getRecurExpenses("john_doe");
        System.out.println(result);
    }
}