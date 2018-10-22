package com.TEC.Tools;

import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.util.HashMap;
import java.util.List;

public class XMLManager {

    private DocumentBuilderFactory factory;
    private DocumentBuilder builder;
    private Document doc;
    private Element rootElement;

    public XMLManager() {
        try {
            factory = DocumentBuilderFactory.newInstance();
            builder = factory.newDocumentBuilder();

            doc = builder.newDocument();

            // Creation of root element
            rootElement = doc.createElement("DB");
            rootElement.setAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
            doc.appendChild(rootElement);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addTableToDBDoc(String tableName, String rowName, HashMap<String, List<String>> tableData) {
        Element table = doc.createElement(tableName);
        for (int i = 0; i < tableData.get(tableData.keySet().iterator().next()).size(); ++i) {
            Element tableRow = doc.createElement(rowName);
            for (String k : tableData.keySet()) {
                Element attr = doc.createElement(k);
                attr.setTextContent(tableData.get(k).get(i));
                if(tableData.get(k).get(i).equals(""))attr.setAttribute("xsi:nil","true");
                tableRow.appendChild(attr);
            }
            table.appendChild(tableRow);
        }
        rootElement.appendChild(table);
    }

    public void storeXML(String fileName) {
        try {
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File(fileName+".xml"));
            transformer.transform(source, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}