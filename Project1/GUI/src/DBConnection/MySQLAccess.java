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

    public void readDataBase() throws Exception {
        try {
            // This will load the MySQL driver, each DB has its own driver
            Class.forName("com.mysql.jdbc.Driver");
            // Setup the connection with the DB
            connect = DriverManager
                    .getConnection("jdbc:mysql://"+this.localhost+"/p1?"
                            + "user="+this.user+"&password="+this.password);
            // Statements allow to issue SQL queries to the database
            //statement = connect.createStatement();
            // Result set get the result of the SQL query
            String query = "{call ObtenerInfoCarro(?)}";
            statement = connect.prepareCall(query);
            statement.setInt(1,1);
            resultSet = statement.executeQuery();
            /*while(resultSet.next()) {
                String nombre = resultSet.getString("Matricula");
                System.out.println(nombre);
            }*/



        } catch (Exception e) {
            throw e;
        } finally {
            close();
        }

    }

    public List<HashMap<String,String>> selectData(String sp){
        List<HashMap<String,String>> data = new ArrayList<>();

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

    private HashMap<String,String> getResultSetData(ResultSet resultSet) throws Exception{
        HashMap<String, String> data = new HashMap<>();
        ResultSetMetaData metaData = resultSet.getMetaData();
        for(int i = 0; i < metaData.getColumnCount(); ++i){
            String columnName = metaData.getColumnName(i);
            data.put(columnName,resultSet.getString(columnName));
        }
        return data;
    }

    private HashMap<String,String> getResultSetData(ResultSet resultSet, String... requestedData) throws Exception{
        HashMap<String, String> data = new HashMap<>();
        for(int i = 0; i < requestedData.length; ++i){
            data.put(requestedData[i],resultSet.getString(requestedData[i]));
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