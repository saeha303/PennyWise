package org.example;

import java.beans.XMLEncoder;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import java.math.BigDecimal;
import java.net.URI;
import java.net.http.*;
import com.sun.net.httpserver.HttpsExchange;
import org.expense.*;
import java.util.*;
public class Main {
    public static void main(String[] args) throws IOException {
        System.out.println("Hello world!");
        expense e=new expense();
        e.updateFau();
    }
}