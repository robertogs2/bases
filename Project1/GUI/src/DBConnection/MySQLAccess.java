package DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class MySQLAccess {
    private Connection connect = null;
    private CallableStatement statement = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

    private String localhost;
    private String user;
    private String password;

    public MySQLAccess(){
        this.localhost = "localhost:3306";
        this.user = "root";
        this.password = "2486";
    }

    public MySQLAccess(String localhost, String user, String password){
        this.localhost = localhost;
        this.user = user;
        this.password = password;
    }

    public void connectToDB() throws Exception {
        try {
            // This will load the MySQL driver, each DB has its own driver
            Class.forName("com.mysql.jdbc.Driver");
            // Setup the connection with the DB
            connect = DriverManager
                    .getConnection("jdbc:mysql://"+this.localhost+"/p1?"
                            + "user="+this.user+"&password="+this.password);

        } catch (Exception e) {
            throw e;
        }
    }

    public HashMap<String, List<String>> selectData(String query, Object... params) throws Exception{
        HashMap<String, List<String>> data = new HashMap<>();
        statement = connect.prepareCall(query);
        for(int i = 1; i <= params.length; ++i) {
            statement.setString(i, params[i-1].toString());
        }
        resultSet = statement.executeQuery();

        while(resultSet.next()) {
            if(data.keySet().isEmpty()){
                data = getResultSetData(resultSet);
            }else{
                data = mergeData(data, getResultSetData(resultSet));
            }
        }

        return data;
    }

    public  HashMap<String, List<String>> selectData(String query) throws Exception{
        HashMap<String, List<String>> data = new HashMap<>();
        statement = connect.prepareCall(query);
        resultSet = statement.executeQuery();
        while(resultSet.next()) {
            if(data.keySet().isEmpty()){
                data = getResultSetData(resultSet);
            }else{
                data = mergeData(data, getResultSetData(resultSet));
            }
        }

        return data;
    }

    public void pushData(String query) throws Exception{
        statement = connect.prepareCall(query);
        resultSet = statement.executeQuery();
    }

    public void pushData(String query, Object... params) throws Exception{
        statement = connect.prepareCall(query);
        for(int i = 1; i <= params.length; ++i) {
            statement.setString(i, params[i-1].toString());
        }
        resultSet = statement.executeQuery();
    }

    private HashMap<String, List<String>> mergeData(HashMap<String, List<String>> d1, HashMap<String, List<String>> d2){
        HashMap<String, List<String>> data = d1;
        for(String k : d1.keySet()){
            for(String d : d2.get(k)) {
                d1.get(k).add(d);
            }
        }
        return data;
    }

    private void writeMetaData(ResultSet resultSet) throws SQLException {
        //  Now get some metadata from the database
        // Result set get the result of the SQL query

        System.out.println("The columns in the table are: ");
        System.out.println("Table: " + resultSet.getMetaData().getTableName(1));
        for  (int i = 1; i<= resultSet.getMetaData().getColumnCount(); i++){
            System.out.println("Column " +i  + " "+ resultSet.getMetaData().getColumnName(i));
        }
    }

    private HashMap<String, List<String>> getResultSetData(ResultSet resultSet) throws Exception{
        ResultSetMetaData metaData = resultSet.getMetaData();
        HashMap<String, List<String>> data = new HashMap<>();
        for(int i = 1; i <= metaData.getColumnCount(); ++i){
            String columnName = metaData.getColumnLabel(i);
            if(!data.keySet().contains(columnName))data.put(columnName,new ArrayList<>());
            data.get(columnName).add(resultSet.getString(columnName));
        }
        return data;
    }

    private HashMap<String, List<String>> getResultSetData(ResultSet resultSet, String... requestedData) throws Exception{
        HashMap<String, List<String>> data = new HashMap<>();
        for(int i = 0; i < requestedData.length; ++i) {
            if (!data.keySet().contains(requestedData[i])) data.put(requestedData[i], new ArrayList<>());
            data.get(requestedData[i]).add(resultSet.getString(requestedData[i]));
        }
        return data;
    }

    // You need to close the resultSet
    private void close() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }

            if (statement != null) {
                statement.close();
            }

            if (connect != null) {
                connect.close();
            }
        } catch (Exception e) {

        }
    }

}