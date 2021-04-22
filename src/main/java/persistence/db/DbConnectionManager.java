package persistence.db;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Class to create the database connection.
 */
public class DbConnectionManager {
    // The database connection.
    private static Connection connection;


    // The database connection details
    private static final String dbName = "auction";
    private static final String dbPort = "3306";
    private static final String dbHost = "localhost";
    private static final String user = "online_auction";
    private static final String password = "p%ass&word";

    // Function returns the connection to the database. Creates it if it
    // did not exist.
    public static synchronized Connection getConnection() throws Exception {
        if(connection == null){
            connection = loadConnection();
        }
        return connection;
    }


    // Create a database connection
    private static Connection loadConnection() throws Exception {
        String jdbcUrl = String.format("jdbc:mysql://%s:%s/%s", dbHost, dbPort, dbName);
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection(jdbcUrl, user, password);
    }
}
