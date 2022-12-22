package nic.com.webservices.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DataBase {

	// mysql conn
	public static Connection getConnection() { // Database Connection
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = null;

			con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/waterassets_new", "root",
					"root");

			System.out.println("Successfully Connected to Database");
			return con;
		} catch (Exception ex) {
			System.out.println("Connecting to Database failed : "
					+ ex.getMessage());
		}
		return null;
	}

	// sql server conn
	public static Connection getSQLServerConnection() {
		Connection con = null;
		try {

			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String connectionUrl = "jdbc:sqlserver://192.168.1.54:1433;"
					+ "databaseName=waterassets_new_sql;user=sa;password=krishna1521";
			con = DriverManager.getConnection(connectionUrl);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();

		}

		return con;
	}

	 public static Connection getOracleServerConnection() {
         try  {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             Connection con = DriverManager.getConnection
                     ("jdbc:oracle:thin:@localhost:1521:xe",
                     "scoot","tiger");
             return con;
         }
         catch(Exception ex) {
             System.out.println("Database.getConnection() Error -->" + ex.getMessage());
             return null;
         }
     }

     

	public static void close(Connection con) {
		try {
			con.close();
		} catch (Exception localException) {
		}
	}

}