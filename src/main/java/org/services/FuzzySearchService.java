package org.services;

import org.apache.lucene.index.Term;
import org.expense.expense;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.FuzzyQuery;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class FuzzySearchService {

    private Directory index;

    public FuzzySearchService() {
        this.index = new RAMDirectory();
        try {
            indexExpenses();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Index your expense data for searching
    private void indexExpenses() throws Exception {
        StandardAnalyzer analyzer = new StandardAnalyzer();
        IndexWriterConfig config = new IndexWriterConfig(analyzer);

        try (IndexWriter writer = new IndexWriter(index, config)) {
            // Assuming you have a list of expenses
            for (expense expense : getExpenses()) {
                addExpense(writer, expense);
            }
        }
    }

    private void addExpense(IndexWriter writer, expense expense) throws Exception {
        Document doc = new Document();
        doc.add(new StringField("category", expense.category, Field.Store.YES));
        doc.add(new StringField("description", expense.note, Field.Store.YES));
        doc.add(new StringField("amount", String.valueOf(expense.amount), Field.Store.YES));
        writer.addDocument(doc);
    }

    public List<expense> search(String queryStr) throws Exception {
        StandardAnalyzer analyzer = new StandardAnalyzer();

        // Create a Term from the query string and the field name
        Term term = new Term("description", queryStr);

        // Create a FuzzyQuery using the term
        Query query = new FuzzyQuery(term);

        DirectoryReader reader = DirectoryReader.open(index);
        IndexSearcher searcher = new IndexSearcher(reader);

        // Perform the search
        TopDocs results = searcher.search(query, 10);
        List<expense> matchedExpenses = new ArrayList<>();
        for (ScoreDoc scoreDoc : results.scoreDocs) {
            Document doc = searcher.doc(scoreDoc.doc);
            // Convert the Document back to an expense object
            expense e=new expense();
            e.category=doc.get("category");
            e.note=doc.get("description");
            e.amount=Integer.parseInt(doc.get("amount"));
            matchedExpenses.add(e);
        }
        reader.close();
        return matchedExpenses;
    }

    // Example method to retrieve your list of expenses
    private List<expense> getExpenses() {
        // Replace with actual retrieval logic
        return new ArrayList<>();
    }
}
