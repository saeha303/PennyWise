package org.services;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import opennlp.tools.tokenize.Tokenizer;
import opennlp.tools.tokenize.TokenizerME;
import opennlp.tools.tokenize.TokenizerModel;
import org.springframework.stereotype.Service;

import opennlp.tools.namefind.NameFinderME;
import opennlp.tools.namefind.TokenNameFinderModel;
import opennlp.tools.tokenize.SimpleTokenizer;
import opennlp.tools.util.Span;

@Service
public class NlpService {

    private NameFinderME nameFinder;
    private Tokenizer tokenizer;
    public NlpService() {
        try  {

            InputStream modelIn1 = new FileInputStream("C:\\Users\\hp\\Desktop\\javafest\\PennyWiseJF\\src\\main\\java\\org\\models\\en-ner-date.bin");
            InputStream modelIn2 = new FileInputStream("C:\\Users\\hp\\Desktop\\javafest\\PennyWiseJF\\src\\main\\java\\org\\models\\en-token.bin");
            TokenizerModel model2 = new TokenizerModel(modelIn2);
            TokenNameFinderModel model1 = new TokenNameFinderModel(modelIn1);
            this.tokenizer = new TokenizerME(model2);
            this.nameFinder = new NameFinderME(model1);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String extractDate(String query) {
        String[] tokens = tokenizer.tokenize("12:18 is a famous book by Colin Hoover");
        for(String s:tokens){
            System.out.println(s);
        }
        Span[] spans = nameFinder.find(tokens);
        System.out.println(spans.length);
        for (Span span : spans) {
            return tokens[span.getStart()];
        }
        String[] array=Span.spansToStrings(spans,tokens);
        
        for(String s:array){
            System.out.println(s);
        }
        return null;
    }
}

