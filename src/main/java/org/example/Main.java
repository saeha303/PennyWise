package org.example;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.io.InputStream;

import org.expense.*;

public class Main {
    public static void main(String[] args) throws IOException {
        System.out.println("Hello world!");
        InputStream modelIn = Main.class.getResourceAsStream("C:\\Users\\hp\\Desktop\\javafest\\PennyWiseJF\\src\\main\\java\\org\\models\\en-ner-date.bin");
        System.out.println(modelIn);
    }
}