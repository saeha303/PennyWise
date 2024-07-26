package org.example;

import java.beans.XMLEncoder;
import java.io.OutputStream;
import org.expense.*;
import java.util.*;
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello world!");
        List<wallet> list=new wallet().getWallets("john_doe");
        String str="My wallet";
        StringBuilder stringBuffer=new StringBuilder(str);
        int idx=stringBuffer.indexOf("\\");
        System.out.println(str);
        wallet w=new wallet();
        System.out.println(w.getName(list.get(1).name));
//        String another=str.replaceAll("\'","\\'");
//        System.out.println(another);
    }
}