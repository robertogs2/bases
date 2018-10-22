package com.TEC.Bases;

import com.TEC.Resources.Strings;
import com.TEC.Tools.XMLManager;
import javafx.util.Pair;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.phantomjs.PhantomJSDriver;

import javax.management.StringValueExp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

public class Main {

    private static WebDriver webDriver;
    private static XMLManager xmlManager;
    private static int numOfParks = 0;
    private static int numOfCities = 0;
    private static HashMap<String, HashMap<String, List<String>>> countryData;
    private static Random rnd;

    private static void init() {
        System.setProperty("phantomjs.binary.path", "webDrivers/phantomjs.exe");
        webDriver = new PhantomJSDriver();
        xmlManager = new XMLManager();
        rnd = new Random();
    }

    private static HashMap<String, List<String>> getCountryData(String url) {
        webDriver.get(url);
        List<WebElement> divList = webDriver.findElements(By.xpath(Strings.WIKI_TBL_CLASS1))
                .get(0).findElements(By.tagName(Strings.TR));
        HashMap<String, List<String>> stateCityData = new HashMap<>();
        for (int i = 1; i < divList.size() - 1; ++i) {
            List<WebElement> divList2 = divList.get(i).findElements(By.tagName(Strings.TD));
            if (divList2.size() > 3) {
                if (!stateCityData.keySet().contains(divList2.get(2).getText()))
                    stateCityData.put(divList2.get(2).getText().replace(Strings.SPACE, Strings.EMPTY_STRING), new ArrayList<>());
                stateCityData.get(divList2.get(2).getText().replace(Strings.SPACE, Strings.EMPTY_STRING)).add(divList2.get(1).getText().replace(Strings.SPACE, Strings.EMPTY_STRING));
            }
        }
        return stateCityData;
    }

    private static void genLocationData() {
        countryData = new HashMap<>();
        countryData.put(Strings.COSTA_RICA, getCountryData("https://es.wikipedia.org/wiki/Anexo:Cantones_de_Costa_Rica_por_superficie"));
        countryData.put(Strings.USA, getCountryData("https://en.wikipedia.org/wiki/List_of_United_States_cities_by_population"));
        countryData.put(Strings.GERMANY, getCountryData("https://en.wikipedia.org/wiki/List_of_cities_in_Germany_by_population"));

        HashMap<String, List<String>> countryTableMap = new HashMap<>();
        countryTableMap.put(Strings.COUNTRY_ID, new ArrayList<>());
        countryTableMap.put(Strings.NAME, new ArrayList<>());


        HashMap<String, List<String>> stateTableMap = new HashMap<>();
        stateTableMap.put(Strings.STATE_ID, new ArrayList<>());
        stateTableMap.put(Strings.NAME, new ArrayList<>());
        stateTableMap.put(Strings.COUNTRY_ID, new ArrayList<>());

        HashMap<String, List<String>> cityTableMap = new HashMap<>();
        cityTableMap.put(Strings.CITY_ID, new ArrayList<>());
        cityTableMap.put(Strings.NAME, new ArrayList<>());
        cityTableMap.put(Strings.STATE_ID, new ArrayList<>());

        int i = 1, j = 1, c = 1;
        for (String k : countryData.keySet()) {
            countryTableMap.get(Strings.NAME).add(k);
            countryTableMap.get(Strings.COUNTRY_ID).add(String.valueOf(i));

            for (String k2 : countryData.get(k).keySet()) {
                stateTableMap.get(Strings.NAME).add(k2);
                stateTableMap.get(Strings.STATE_ID).add(String.valueOf(j));
                stateTableMap.get(Strings.COUNTRY_ID).add(String.valueOf(i));

                for (String city : countryData.get(k).get(k2)) {
                    cityTableMap.get(Strings.NAME).add(city);
                    cityTableMap.get(Strings.CITY_ID).add(String.valueOf(c++));
                    cityTableMap.get(Strings.STATE_ID).add(String.valueOf(j));
                }
                ++j;
            }
            ++i;
        }
        numOfCities = c;
        xmlManager.addTableToDBDoc(Strings.COUNTRIES, Strings.COUNTRY, countryTableMap);
        xmlManager.addTableToDBDoc(Strings.STATES, Strings.STATE, stateTableMap);
        xmlManager.addTableToDBDoc(Strings.CITIES, Strings.CITY, cityTableMap);
    }

    private static void genPeopleData(int numOfPeople) {
        webDriver.get("https://www.randomlists.com/random-names?qty=" + numOfPeople + "#");

        WebElement randomNamesResult = webDriver.findElement(By.xpath(Strings.WIKI_DIV_CLASS));
        List<WebElement> names = randomNamesResult.findElements(By.tagName("li"));
        List<String> genIds = new ArrayList<>();

        HashMap<String, List<String>> personTableMap = new HashMap<>();
        personTableMap.put(Strings.PERSON_ID, new ArrayList<>());
        personTableMap.put(Strings.ID_NUMBER, new ArrayList<>());
        personTableMap.put(Strings.NAME, new ArrayList<>());
        personTableMap.put(Strings.SURNAME, new ArrayList<>());
        personTableMap.put(Strings.LOCATION_ID, new ArrayList<>());
        personTableMap.put(Strings.PHONE_NUMBER, new ArrayList<>());

        HashMap<String, List<String>> locationTableMap = new HashMap<>();
        locationTableMap.put(Strings.LOCATION_ID, new ArrayList<>());
        locationTableMap.put(Strings.CITY_ID, new ArrayList<>());
        locationTableMap.put(Strings.DESCRIPTION, new ArrayList<>());

        int i = 1;
        for (WebElement we : names) {
            personTableMap.get(Strings.PERSON_ID).add(String.valueOf(i));
            String[] fullname = we.getText().split(Strings.SPACE);
            personTableMap.get(Strings.NAME).add(fullname[0]);
            fullname[1].replace("undefined", Strings.EMPTY_STRING);
            personTableMap.get(Strings.SURNAME).add(fullname[1]);
            personTableMap.get(Strings.LOCATION_ID).add(String.valueOf(i));
            personTableMap.get(Strings.PHONE_NUMBER).add(Strings.EMPTY_STRING + (10000000 + rnd.nextInt(90000000)));

            String rndId = "1" + (10000000 + rnd.nextInt(90000000));
            while (genIds.contains(rndId)) rndId = "1" + (10000000 + rnd.nextInt(90000000));
            genIds.add(rndId);
            personTableMap.get(Strings.ID_NUMBER).add(rndId);

            locationTableMap.get(Strings.LOCATION_ID).add(String.valueOf(i));
            int rndCity = 1 + rnd.nextInt(numOfCities - 1);
            locationTableMap.get(Strings.CITY_ID).add(String.valueOf(rndCity));
            locationTableMap.get(Strings.DESCRIPTION).add("");

            ++i;
        }
        xmlManager.addTableToDBDoc("Locations", "Location", locationTableMap);
        xmlManager.addTableToDBDoc("People", "Person", personTableMap);
    }

    private static void genEmployeeData() {

        HashMap<String, List<String>> employeeTableMap = new HashMap<>();
        employeeTableMap.put(Strings.EMPLOYEE_ID, new ArrayList<>());
        employeeTableMap.put(Strings.PERSON_ID, new ArrayList<>());
        employeeTableMap.put(Strings.PARK_ID, new ArrayList<>());
        employeeTableMap.put(Strings.PROFESSION_ID, new ArrayList<>());
        employeeTableMap.put(Strings.ASSIGNED_AREA, new ArrayList<>());
        employeeTableMap.put(Strings.SPECIALITY_ID, new ArrayList<>());

        HashMap<String, List<String>> professionTableMap = new HashMap<>();
        professionTableMap.put(Strings.NAME, Arrays.asList("Receptionist", "Security Guard", "Researcher", "Conservationist","Cleaner", "Doctor", "Dentist", "Tailor", "Archaeologist", "Teacher", "Gamekeeper", "Economist",
                "Paramedic", "Auditor", "Manager", "Stockbroker", "Maid", "Engineer", "Clockmaker", "Builder"));

        HashMap<String, List<String>> assignedAreaTableMap = new HashMap<>();
        assignedAreaTableMap.put(Strings.NAME, Arrays.asList("1", "2", "3", "4", "5", "Alpha", "Bravo", "Charlie", "Delta", "Echo"));

        HashMap<String, List<String>> specialityTableMap = new HashMap<>();
        specialityTableMap.put(Strings.NAME, Arrays.asList("Associate", "Bachelor", "First professional", "Master", "Intermediate graduate",
                "Research doctorate", "Animalia Kingdom", "Plantae Kingdom", "Protista Kingdom", "Monera Kingdom", "Fungi Kingdom"));

        HashMap<String, List<String>> vehicleTableMap = new HashMap<>();
        vehicleTableMap.put(Strings.VEHICLE_ID, new ArrayList<>());
        vehicleTableMap.put(Strings.EMPLOYEE_ID, new ArrayList<>());

        int j = 1, k = 1, v = 1;
        for (int i = 1001; i <= 1000 + numOfParks * 4; ) {
            // Creation of receptionist
            employeeTableMap.get(Strings.EMPLOYEE_ID).add(String.valueOf(j++));
            employeeTableMap.get(Strings.PERSON_ID).add(String.valueOf(i++));
            employeeTableMap.get(Strings.PARK_ID).add(String.valueOf(k));
            employeeTableMap.get(Strings.PROFESSION_ID).add("1");
            employeeTableMap.get(Strings.ASSIGNED_AREA).add(String.valueOf(ThreadLocalRandom.current().nextInt(1, 6)));
            employeeTableMap.get(Strings.SPECIALITY_ID).add("");

            // Creation of security guard
            employeeTableMap.get(Strings.EMPLOYEE_ID).add(String.valueOf(j));
            employeeTableMap.get(Strings.PERSON_ID).add(String.valueOf(i++));
            employeeTableMap.get(Strings.PARK_ID).add(String.valueOf(k));
            employeeTableMap.get(Strings.PROFESSION_ID).add("2");
            employeeTableMap.get(Strings.ASSIGNED_AREA).add(String.valueOf(ThreadLocalRandom.current().nextInt(6, 11)));
            employeeTableMap.get(Strings.SPECIALITY_ID).add("");
            vehicleTableMap.get(Strings.VEHICLE_ID).add(String.valueOf(v++));
            vehicleTableMap.get(Strings.EMPLOYEE_ID).add(String.valueOf(j++));

            // Creation of researcher
            employeeTableMap.get(Strings.EMPLOYEE_ID).add(String.valueOf(j++));
            employeeTableMap.get(Strings.PERSON_ID).add(String.valueOf(i++));
            employeeTableMap.get(Strings.PARK_ID).add(String.valueOf(k));
            employeeTableMap.get(Strings.PROFESSION_ID).add("3");
            employeeTableMap.get(Strings.ASSIGNED_AREA).add("");
            employeeTableMap.get(Strings.SPECIALITY_ID).add(String.valueOf(ThreadLocalRandom.current().nextInt(1, 7)));

            // Create conservationist
            employeeTableMap.get(Strings.EMPLOYEE_ID).add(String.valueOf(j++));
            employeeTableMap.get(Strings.PERSON_ID).add(String.valueOf(i++));
            employeeTableMap.get(Strings.PARK_ID).add(String.valueOf(k++));
            employeeTableMap.get(Strings.PROFESSION_ID).add("4");
            employeeTableMap.get(Strings.ASSIGNED_AREA).add("");
            employeeTableMap.get(Strings.SPECIALITY_ID).add(String.valueOf(ThreadLocalRandom.current().nextInt(7, 12)));
        }

        xmlManager.addTableToDBDoc("Professions", "Profession", professionTableMap);
        xmlManager.addTableToDBDoc("AssignedAreas", "AssginedArea", assignedAreaTableMap);
        xmlManager.addTableToDBDoc("Specialities", "Speciality", specialityTableMap);
        xmlManager.addTableToDBDoc("Employees", "Employee", employeeTableMap);
    }

    private static void genVehicleData() {
        HashMap<String, List<String>> vehicleTableMap = new HashMap<>();
        vehicleTableMap.put(Strings.VEHICLE_ID, new ArrayList<>());
        vehicleTableMap.put(Strings.TYPE, new ArrayList<>());
        vehicleTableMap.put(Strings.REGISTRATION_NUMBER, new ArrayList<>());
        vehicleTableMap.put(Strings.PARK_ID, new ArrayList<>());

        int vId = 1;
        for (int i = 1; i <= numOfParks; ++i) {
            vehicleTableMap.get(Strings.VEHICLE_ID).add(String.valueOf(vId++));
            vehicleTableMap.get(Strings.TYPE).add("4x4");
            vehicleTableMap.get(Strings.REGISTRATION_NUMBER).add(String.valueOf(10000000 + rnd.nextInt(90000000)));
            vehicleTableMap.get(Strings.PARK_ID).add(String.valueOf(i));
        }

        xmlManager.addTableToDBDoc("Vehicles", "Vehicle", vehicleTableMap);
    }

    private static void genParkData() {
        HashMap<String, List<String>> parkTableMap = new HashMap<>();
        parkTableMap.put(Strings.PARK_ID, new ArrayList<>());
        parkTableMap.put(Strings.NAME, new ArrayList<>());
        parkTableMap.put(Strings.FOUNDATION_DATE, new ArrayList<>());

        HashMap<String, List<String>> communityTableMap = new HashMap<>();
        communityTableMap.put(Strings.COMMUNITY_ID, new ArrayList<>());
        communityTableMap.put(Strings.NAME, new ArrayList<>());
        communityTableMap.put(Strings.STATE_ID, new ArrayList<>());
        communityTableMap.put(Strings.NUMBER_OF_PARKS, new ArrayList<>());
        communityTableMap.put(Strings.TOTAL_PROTECTED_AREA, new ArrayList<>());

        HashMap<String, List<String>> communityXParkTableMap = new HashMap<>();
        communityXParkTableMap.put(Strings.COMMUNITY_ID, new ArrayList<>());
        communityXParkTableMap.put(Strings.PARK_ID, new ArrayList<>());

        int i = 1, cId = 1, sId = 0;
        for (String country : countryData.keySet()) {
            int a = -1, b = -1, c = -1, d = -1; // a:Name, b:location, c:foundationDate, d:area
            List<WebElement> listOfNationalParks = new ArrayList<>();
            switch (country) {
                case (Strings.COSTA_RICA): {
                    webDriver.get("https://es.wikipedia.org/wiki/Parques_nacionales_de_Costa_Rica");
                    listOfNationalParks = webDriver.findElements(By.xpath(Strings.WIKI_TBL_STYLE))
                            .get(0).findElements(By.tagName(Strings.TR));
                    listOfNationalParks = listOfNationalParks.subList(1, listOfNationalParks.size());
                    a = 2;
                    b = 4;
                    c = 1;
                    d = 5;
                    break;
                }
                case (Strings.USA): {
                    webDriver.get("https://en.wikipedia.org/wiki/List_of_national_parks_of_the_United_States");
                    listOfNationalParks = webDriver.findElements(By.xpath(Strings.WIKI_TBL_CLASS2))
                            .get(0).findElements(By.tagName(Strings.TR));
                    listOfNationalParks = listOfNationalParks.subList(1, listOfNationalParks.size());
                    a = 0;
                    b = 2;
                    c = 3;
                    d = 4;
                    break;
                }
                case (Strings.GERMANY): {
                    webDriver.get("https://en.wikipedia.org/wiki/List_of_nature_parks_in_Germany");
                    listOfNationalParks = webDriver.findElements(By.xpath(Strings.WIKI_TBL_CLASS1))
                            .get(0).findElements(By.tagName(Strings.TR));
                    listOfNationalParks = listOfNationalParks.subList(1, listOfNationalParks.size());
                    a = 0;
                    b = 1;
                    c = 2;
                    d = 3;
                    break;
                }
            }
            for (WebElement tr : listOfNationalParks) {
                List<WebElement> tdList = tr.findElements(By.tagName(Strings.TH));
                tdList.addAll(tr.findElements(By.tagName(Strings.TD)));
                parkTableMap.get(Strings.PARK_ID).add(String.valueOf(i));
                parkTableMap.get(Strings.NAME).add(tdList.get(a).getText().split(Strings.NEWLINE)[0]);
                parkTableMap.get(Strings.FOUNDATION_DATE).add(tdList.get(c).getText());
                numOfParks = i;

                String[] locations = tdList.get(b).getText().split(Strings.DASH);
                String[] totalAreaString = tdList.get(d).getText().split(" ")[0].replace(Strings.COMMA, Strings.DOT).split(Strings.SP_DOT);
                String totalArea = (totalAreaString.length > 1) ? totalAreaString[0] + Strings.DOT + totalAreaString[1] : totalAreaString[0];
                float totalProtectedArea = Float.valueOf(totalArea) / locations.length;
                for (String location : locations) {
                    location = location.replace(Strings.SPACE, Strings.EMPTY_STRING).split(Strings.NEWLINE)[0];
                    if (!communityTableMap.get(Strings.NAME).contains(location)) {
                        communityTableMap.get(Strings.COMMUNITY_ID).add(String.valueOf(cId++));
                        communityTableMap.get(Strings.NAME).add(location);
                        int deltaSId = 0;
                        for (String s : countryData.get(country).keySet()) {
                            ++deltaSId;
                            if (s.equals(location)) break;
                        }
                        communityTableMap.get(Strings.STATE_ID).add(String.valueOf(sId + deltaSId));
                        communityTableMap.get(Strings.NUMBER_OF_PARKS).add("0");
                        communityTableMap.get(Strings.TOTAL_PROTECTED_AREA).add("0");
                    }
                    int comIndx = communityTableMap.get(Strings.NAME).indexOf(location);
                    communityTableMap.get(Strings.NUMBER_OF_PARKS).set(comIndx,
                            String.valueOf(Integer.valueOf(communityTableMap.get(Strings.NUMBER_OF_PARKS).get(comIndx)) + 1));
                    communityTableMap.get(Strings.TOTAL_PROTECTED_AREA).set(comIndx,
                            String.valueOf(Float.valueOf(communityTableMap.get(Strings.TOTAL_PROTECTED_AREA).get(comIndx)) + totalProtectedArea));
                    communityXParkTableMap.get(Strings.COMMUNITY_ID).add(communityTableMap.get(Strings.COMMUNITY_ID).get(comIndx));
                    communityXParkTableMap.get(Strings.PARK_ID).add(String.valueOf(i));
                }
                ++i;
            }

            sId += countryData.get(country).keySet().size();
        }
        xmlManager.addTableToDBDoc("Communities", "Community", communityTableMap);
        xmlManager.addTableToDBDoc("Parks", "Park", parkTableMap);
        xmlManager.addTableToDBDoc("CommunitiesXParks", "CommunityXPark", communityXParkTableMap);
    }

    private static void genVisitors() {
        HashMap<String, List<String>> visitorTableMap = new HashMap<>();
        visitorTableMap.put(Strings.VISITOR_ID, new ArrayList<>());
        visitorTableMap.put(Strings.PERSON_ID, new ArrayList<>());
        visitorTableMap.put(Strings.PROFESSION_ID, new ArrayList<>());

        for (int i = 1; i <= 1000; ++i) {
            visitorTableMap.get(Strings.VISITOR_ID).add(String.valueOf(i));
            visitorTableMap.get(Strings.PERSON_ID).add(String.valueOf(i));
            visitorTableMap.get(Strings.PROFESSION_ID).add(String.valueOf(ThreadLocalRandom.current().nextInt(5, 21)));
        }

        xmlManager.addTableToDBDoc("Visitors", "Visitor", visitorTableMap);
    }

    private static void genVisits() {
        HashMap<String, List<String>> visitTableMap = new HashMap<>();
        visitTableMap.put(Strings.VISIT_ID, new ArrayList<>());
        visitTableMap.put(Strings.VISITOR_ID, new ArrayList<>());
        visitTableMap.put(Strings.PARK_ID, new ArrayList<>());
        visitTableMap.put(Strings.ACCOMMODATION_ID, new ArrayList<>());
        visitTableMap.put(Strings.START_DATE, new ArrayList<>());
        visitTableMap.put(Strings.END_DATE, new ArrayList<>());

        HashMap<String, List<String>> accommodationTableMap = new HashMap<>();
        accommodationTableMap.put(Strings.ACCOMMODATION_ID, new ArrayList<>());
        accommodationTableMap.put(Strings.PARK_ID, new ArrayList<>());
        accommodationTableMap.put(Strings.CATEGORY, new ArrayList<>());
        accommodationTableMap.put(Strings.CAPACITY, new ArrayList<>());

        HashMap<String, List<String>> excursionTableMap = new HashMap<>();
        excursionTableMap.put(Strings.EXCURSION_ID, new ArrayList<>());
        excursionTableMap.put(Strings.NAME, new ArrayList<>());
        excursionTableMap.put(Strings.DESCRIPTION, new ArrayList<>());
        excursionTableMap.put(Strings.PRICE, new ArrayList<>());
        excursionTableMap.put(Strings.CAPACITY, new ArrayList<>());
        excursionTableMap.put(Strings.VEHICLE_ID, new ArrayList<>());

        String[][] eNames = {{"Mountain Walk", "Horseback Ride", "Trail Exploring"}
                , {"Bird Watching", "Kayaking", "Pond Walk"}, {"Mountain biking", "Three exploring", "Rain forest exploration"}};

        HashMap<String, List<String>> accommodationXExcursionTableMap = new HashMap<>();
        accommodationXExcursionTableMap.put(Strings.ACCOMMODATION_ID, new ArrayList<>());
        accommodationXExcursionTableMap.put(Strings.EXCURSION_ID, new ArrayList<>());
        accommodationXExcursionTableMap.put(Strings.DATE, new ArrayList<>());
        accommodationXExcursionTableMap.put(Strings.HOUR, new ArrayList<>());

        String[] categories = {"Bronze", "Silver", "Gold", "Platinum"};


        HashMap<Integer, HashMap<Integer, List<Pair<Date, Date>>>> parkOccupations = new HashMap<>();

        int j = 1, e = 1;
        for (int i = 1; i <= 10000; ++i) {
            LocalDate startDate = LocalDate.of(2012, 1, 1); //start date
            LocalDate endDate = LocalDate.now(); //end date
            Date startdate = asDate(LocalDate.ofEpochDay(ThreadLocalRandom.current().nextLong(startDate.toEpochDay(), endDate.toEpochDay())));
            Calendar cal = Calendar.getInstance();
            cal.setTime(startdate);
            cal.add(Calendar.DATE, ThreadLocalRandom.current().nextInt(1, 30));
            Date enddate = cal.getTime();

            int randPark = ThreadLocalRandom.current().nextInt(1, numOfParks + 1);

            visitTableMap.get(Strings.VISIT_ID).add(String.valueOf(i));
            visitTableMap.get(Strings.VISITOR_ID).add(String.valueOf(ThreadLocalRandom.current().nextInt(1, 1001)));
            visitTableMap.get(Strings.PARK_ID).add(String.valueOf(randPark));
            visitTableMap.get(Strings.START_DATE).add(asLocalDate(startdate).toString());
            visitTableMap.get(Strings.END_DATE).add(asLocalDate(enddate).toString());

            if (!parkOccupations.containsKey(randPark)) parkOccupations.put(randPark, new HashMap<>());
            HashMap<Integer, List<Pair<Date, Date>>> occupationMap = parkOccupations.get(randPark);
            if (occupationMap.keySet().isEmpty()) {
                accommodationTableMap.get(Strings.ACCOMMODATION_ID).add(String.valueOf(j));
                accommodationTableMap.get(Strings.PARK_ID).add(String.valueOf(randPark));
                accommodationTableMap.get(Strings.CATEGORY).add(categories[ThreadLocalRandom.current().nextInt(0, 4)]);
                accommodationTableMap.get(Strings.CAPACITY).add(String.valueOf(ThreadLocalRandom.current().nextInt(1, 5)));
                occupationMap.put(j++, new ArrayList<>());
            }
            boolean f = false;
            for (Integer accId : occupationMap.keySet()) {
                for (Pair<Date, Date> dates : occupationMap.get(accId)) {
                    if ((startdate.after(dates.getKey()) && startdate.before(dates.getValue())) ||
                            (enddate.after(dates.getKey()) && enddate.before(dates.getValue()))) break;
                    f = true;
                }
                if (f) {
                    occupationMap.get(accId).add(new Pair<>(startdate, enddate));
                    visitTableMap.get(Strings.ACCOMMODATION_ID).add(String.valueOf(accId));
                }
            }
            if (!f) {
                accommodationTableMap.get(Strings.ACCOMMODATION_ID).add(String.valueOf(j));
                accommodationTableMap.get(Strings.PARK_ID).add(String.valueOf(randPark));
                accommodationTableMap.get(Strings.CATEGORY).add(categories[ThreadLocalRandom.current().nextInt(0, 4)]);
                accommodationTableMap.get(Strings.CAPACITY).add(String.valueOf(ThreadLocalRandom.current().nextInt(0, 5)));
                occupationMap.put(j, new ArrayList<>());
                occupationMap.get(j).add(new Pair<>(startdate, enddate));
                visitTableMap.get(Strings.ACCOMMODATION_ID).add(String.valueOf(j++));
            }

            String[] es = {String.valueOf(e++), String.valueOf(e++), String.valueOf(e++)};
            excursionTableMap.get(Strings.EXCURSION_ID).addAll(Arrays.asList(es[0], es[1], es[2]));
            excursionTableMap.get(Strings.NAME).addAll(Arrays.asList(eNames[0][ThreadLocalRandom.current().nextInt(0, 3)],
                    eNames[0][ThreadLocalRandom.current().nextInt(1, 3)], eNames[0][ThreadLocalRandom.current().nextInt(2, 3)]));
            excursionTableMap.get(Strings.DESCRIPTION).addAll(Arrays.asList("", "", ""));
            excursionTableMap.get(Strings.PRICE).addAll(Arrays.asList("20", "50", "30"));
            excursionTableMap.get(Strings.CAPACITY).addAll(Arrays.asList("20", "20", "20"));
            excursionTableMap.get(Strings.VEHICLE_ID).addAll(Arrays.asList("", "", ""));

            LocalDate eDate = asLocalDate(new Date(ThreadLocalRandom.current().nextLong(startdate.getTime(), enddate.getTime())));
            accommodationXExcursionTableMap.get(Strings.ACCOMMODATION_ID).addAll(Arrays.asList(String.valueOf(j - 1), String.valueOf(j - 1), String.valueOf(j - 1)));
            accommodationXExcursionTableMap.get(Strings.EXCURSION_ID).addAll(Arrays.asList(es[0], es[1], es[2]));
            accommodationXExcursionTableMap.get(Strings.DATE).addAll(Arrays.asList(eDate.toString(), eDate.toString(), eDate.toString()));
            accommodationXExcursionTableMap.get(Strings.HOUR).addAll(Arrays.asList("07", "13", "15"));
        }

        xmlManager.addTableToDBDoc("Accommodations", "Accommodation", accommodationTableMap);
        xmlManager.addTableToDBDoc("Visits", "Visit", visitTableMap);
        xmlManager.addTableToDBDoc("Excursions", "Excursion", excursionTableMap);
        xmlManager.addTableToDBDoc("AcommodationsXExcursions", "AccomodationXExcursion", accommodationXExcursionTableMap);
    }

    public static void main(String[] args) {
        init();
        System.out.println("[              ] 0%");
        genLocationData();

        System.out.println("[##            ] 15%");
        genParkData();
        genVehicleData();

        System.out.println("[####          ] 30%");
        genPeopleData(1000 + numOfParks * 4);

        System.out.println("[######        ] 45%");
        genEmployeeData();

        System.out.println("[########      ] 60%");
        genVisitors();

        System.out.println("[##########    ] 75%");
        genVisits();

        System.out.println("[############  ] 90%");
        xmlManager.storeXML("DB");

        System.out.println("[##############] 100%");
    }

    private static Date asDate(LocalDate localDate) {
        return Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
    }

    public static LocalDate asLocalDate(Date date) {
        return Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDate();
    }
}