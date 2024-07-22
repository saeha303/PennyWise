package org.example;

import java.beans.XMLEncoder;
import java.io.OutputStream;
import org.expense.*;
import java.util.*;
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello world!");
        Calendar now=Calendar.getInstance();
        int month = now.get(Calendar.MONTH);
        List<budget> b=new budget().getActualSpending("john_doe","My Wallet");

        char[] arr={'C','F','M','P','R','W'};
        int j=0;
        for(int i=0;i< arr.length;i++){
            if(b.get(j).startDate.charAt(0)!=arr[i]){
//do print 0
                continue;
            }
//            do print
            j++;
        }
//        int lastDay=now.getMaximum(Calendar.DAY);
    }
}