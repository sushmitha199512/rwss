package nic.watersoft.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBUtil {

	public static Connection getDbConnection() throws Exception
	{
		Connection conn;
		
//		Class.forName("org.postgresql.Driver");
//		conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres","postgres","admin");
		
		Class.forName("oracle.jdbc.OracleDriver");
		/*conn = DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.140:1521:wsoft", "aprwssuser", "aprwssuser");*/
		conn = DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.83:1521:wsoft", "aprwssuser", "aprwssuser");
		
		return conn;
	}
	
	public static void closeConnection(Connection con) throws Exception
	{
		con.close();
	}
	
	public static PreparedStatement getPreparedStatement(Connection con, String sql) throws Exception
	{
		return con.prepareStatement(sql);
	}
	
	public static Statement getStatement(Connection con) throws Exception
	{
		return con.createStatement();
	}
	
	public static ResultSet getResultSet(Statement stmt, String sql) throws Exception
	{
		return stmt.executeQuery(sql);
	}
	
	public static ResultSet getResultSet(PreparedStatement pst) throws Exception
	{
		return pst.executeQuery();
	}
	
	public static void closeStatement(Statement stmt) throws Exception
	{
		stmt.close();
	}
	
	public static void closePreparedStatement(PreparedStatement pst) throws Exception
	{
		pst.close();
	}
	
	public static void closeResultSet(ResultSet rs) throws Exception
	{
		rs.close();
	}
	
	
}
