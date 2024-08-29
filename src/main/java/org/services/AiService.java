package org.services;

import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class AiService {

    // private NameFinderME nameFinder;
    // private Tokenizer tokenizer;
    // public NlpService() {
    //     try  {

    //         InputStream modelIn1 = new FileInputStream("C:\\Users\\hp\\Desktop\\javafest\\PennyWiseJF\\src\\main\\java\\org\\models\\en-ner-time.bin");
    //         InputStream modelIn2 = new FileInputStream("C:\\Users\\hp\\Desktop\\javafest\\PennyWiseJF\\src\\main\\java\\org\\models\\en-token.bin");
    //         TokenizerModel model2 = new TokenizerModel(modelIn2);
    //         TokenNameFinderModel model1 = new TokenNameFinderModel(modelIn1);
    //         this.tokenizer = new TokenizerME(model2);
    //         this.nameFinder = new NameFinderME(model1);

    //     } catch (Exception e) {
    //         e.printStackTrace();
    //     }
    // }

    // public String extractDate(String query) {
    //     String[] tokens = tokenizer.tokenize("July is a famous book by Colin Hoover");
    //     for(String s:tokens){
    //         System.out.println(s);
    //     }
    //     Span[] spans = nameFinder.find(tokens);
    //     System.out.println(spans.length);
    //     for (Span span : spans) {
    //         return tokens[span.getStart()];
    //     }
    //     String[] array=Span.spansToStrings(spans,tokens);

    //     for(String s:array){
    //         System.out.println(s);
    //     }
    //     return null;
    // }
    private final RestTemplate restTemplate = new RestTemplate();
    private final String flaskUrl = "http://localhost:5000/predict-budget";

    public String processQuery(String query) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");

        JSONObject json = new JSONObject();
        json.put("query", query);

        HttpEntity<String> request = new HttpEntity<>(json.toString(), headers);
        ResponseEntity<String> response = restTemplate.exchange(flaskUrl, HttpMethod.POST, request, String.class);

        return response.getBody();
    }
}

