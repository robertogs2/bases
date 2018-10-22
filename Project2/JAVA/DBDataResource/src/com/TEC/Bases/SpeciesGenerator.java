package com.TEC.Bases;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.phantomjs.PhantomJSDriver;

import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class SpeciesGenerator {

    private static WebDriver webDriver;
    private static WebDriver webDriverPivot;

    private static ArrayList<Species> animals = new ArrayList<>();
    private static ArrayList<Species> vegetals = new ArrayList<>();
    private static int count = 1;
    private static int a = 1;
    private static int k = 0;

    private static FileWriter fw;
    private static FileWriter fw2;

    public static void main(String[] args) throws IOException {
        try {
            fw = new FileWriter("SpeciesScript.txt");
            fw2 = new FileWriter("ChainScript.txt");
        } catch (IOException e) {
            e.printStackTrace();
        }
        init();
        for (; a < 82; a++) {
            String s = String.format("https://www.arkive.org/explore/species/all/all/%d?results=200", a);
            getSpeciesData(s);
        }
        fw.close();
        //getMineralsData("https://en.wikipedia.org/wiki/List_of_minerals");
        String s = "INSERT INTO FoodChainLink(fk_idConsumer, fk_idFood)\nVALUES(%d,%d)\n";
        for (Species animal : animals) {
            int maxFood = ((int) (Math.random() * 100)) % 5 + 1;
            if (animal.characteristicid == 1) {//carnivore
                for (int i = 0; i < maxFood; i++) {
                    String ss = String.format(s, animal.id, animals.get(((int) (Math.random() * 150000)) % animals.size()).id);
                    fw2.write(ss);
                }
            } else if (animal.characteristicid == 2) {//hervibore
                for (int i = 0; i < maxFood; i++) {
                    String ss = String.format(s, animal.id, vegetals.get(((int) (Math.random() * 150000)) % vegetals.size()).id);
                    fw2.write(ss);
                }
            } else {
                for (int i = 0; i < maxFood; i++) {
                    String ss;
                    if (((int) (Math.random() * 1000)) % 2 == 0) {
                        ss = String.format(s, animal.id, animals.get(((int) (Math.random() * 150000)) % animals.size()).id);
                    } else {
                        ss = String.format(s, animal.id, vegetals.get(((int) (Math.random() * 150000)) % vegetals.size()).id);
                    }

                    fw2.write(ss);
                }
            }
        }
        fw2.close();
    }

    private static void init() {
        System.setProperty("phantomjs.binary.path", "webDrivers/phantomjs.exe");
        webDriver = new PhantomJSDriver();
        webDriverPivot = new PhantomJSDriver();
    }

    private static class Species {
        String name;
        String cname;
        int speciestypeid;
        int characteristicid;
        int periodid;
        int id;

        public void printThis() throws IOException {
            String s = String.format("INSERT INTO Species(ScientificName, " +
                    "NonScientificName, fk_idSpeciesType, fk_Characteristic, fk_Period)\n" +
                    "VALUES (%s, %s, %d, %d, %d) \n", name, cname, speciestypeid, characteristicid, periodid);
            fw.write(s);
        }
    }

    private static void getSpeciesData(String url) {
        webDriver.get(url);
        for (k = 0; k < 200; k += 30) {//MAGIC VARIABLE
            String s1 = String.format("//*[@id='results']/ul/li[%d]/h2/a", k);
            try {
                List<WebElement> divList = webDriver.findElements(By.xpath(s1));
                for (WebElement we : divList) {
                    Species sp = new Species();
                    String s = we.getText();
                    String[] ss = s.split("\\(");
                    String name = ss[0].substring(0, ss[0].length() - 1);
                    String cname = ss[1].substring(0, ss[1].length() - 1);
                    int typeid = getSpeciesType(cname);
                    int innertypeid = 0;
                    if (typeid != 0) {
                        if (typeid == 1) {
                            innertypeid = ((int) (Math.random() * 100)) % 3 + 1;
                        } else {
                            innertypeid = ((int) (Math.random() * 100)) % 2 + 4;
                        }
                    } else {
                        typeid = ((int) (Math.random() * 100)) % 2 + 1;
                        if (typeid == 1) {
                            innertypeid = ((int) (Math.random() * 100)) % 3 + 1;
                        } else {
                            innertypeid = ((int) (Math.random() * 100)) % 2 + 4;
                        }
                    }
                    sp.name = name;
                    sp.cname = cname;
                    sp.characteristicid = innertypeid;
                    sp.speciestypeid = typeid;
                    sp.id = count++;
                    sp.periodid = sp.id;
                    sp.printThis();
                    if (sp.speciestypeid == 1) {
                        animals.add(sp);
                    } else {
                        vegetals.add(sp);
                    }
                }
            } catch (Exception e) {
            }
        }
    }

    private static int getSpeciesType(String scientificName) {
        //16200
        int current = ((a - 1) * 200 + k);
        System.out.println("Percentage" + (double) current / (16200) * 100);
        int res = 0;
        String url = "https://en.wikipedia.org/wiki/" + scientificName.toLowerCase().replace(' ', '_');
        webDriverPivot.get(url);
        int i = 5;
        int max = 8;
        for (; i < max; i++) {
            try {
                String s = String.format("//*[@id=\"mw-content-text\"]/div/table[1]/tbody/tr[%d]/td[1]", i);
                WebElement el = webDriverPivot.findElement(
                        By.xpath(s));
                //System.out.println(el.getText());
                if (el.getText().equals("Kingdom:")) {
                    break;
                }
            } catch (Exception e) {
            }
        }
        if (i == max) {
            return 0;
        }
        try {
            //System.out.println("found " + scientificName + " at: " + i);
            String s = String.format("//*[@id=\"mw-content-text\"]/div/table[1]/tbody/tr[%d]/td[2]/a", i);
            List<WebElement> divList = webDriverPivot.findElements(
                    By.xpath(s));
            if (divList.size() == 0) {
                s = String.format("//*[@id=\"mw-content-text\"]/div/table/tbody/tr[%d]/td/a", i);
                divList = webDriverPivot.findElements(
                        By.xpath(s));
            }
            if (divList.size() != 0) {
                String sss = divList.get(0).getText();
                //System.out.println(sss);
                if (sss.equals("Animalia")) {
                    res = 1;
                } else {
                    res = 2;
                }
            }
        } catch (Exception e) {

        }

        return res;
    }

    private static void getMineralsData(String url) {
        webDriver.get(url);
        List<WebElement> list0 = webDriver.findElements(
                By.xpath("//*[@id=\"mw-content-text\"]/div/div"));
        for (int i = 0; i < list0.size(); i++) {
            List<WebElement> list1 = list0.get(i).findElements(By.xpath("ul/li"));
            for (int j = 0; j < list1.size(); j += 3) {
                String s = list1.get(j).getText();
                if (s.split(" ").length < 3) {
                    System.out.println(s.split(" ")[0]);
                }
            }
            System.out.println();
        }
    }
}