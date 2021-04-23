package persistence.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Class to create the database connection.
 */
public class DbConnectionManager {
    // The database connection.
    private static Connection connection;
    
    public DbConnectionManager() {
        
    }


    // The database connection details
    private static final String dbName = "auction";
    private static final String dbPort = "3306";
    private static final String dbHost = "localhost";
    private static final String user = "root";
    private static final String password = "root";

    // Function returns the connection to the database. Creates it if it
    // did not exist.
    public static synchronized Connection getConnection() throws Exception {
        if(connection == null){
            connection = loadConnection();
        }
        return connection;
    }
    
    public Connection getDbConnection(){
        
        //Create a connection string
        String connectionUrl = "jdbc:mysql://localhost:3306/auction";
        Connection connection = null;
        
        try {
            //Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (InstantiationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            //Create a connection to your DB
            connection = DriverManager.getConnection(connectionUrl,"root", "root");
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return connection;
        
    }
    
    public void closeConnection(Connection connection){
        try {
            connection.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    // Create a database connection
    private static Connection loadConnection() throws Exception {
        String jdbcUrl = String.format("jdbc:mysql://%s:%s/%s", dbHost, dbPort, dbName);
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection(jdbcUrl, user, password);
    }
}
