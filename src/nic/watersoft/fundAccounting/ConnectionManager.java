/*
 * Created on Aug 6, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import java.sql.Connection;
import javax.sql.DataSource;
//import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;


//import nic.watersoft.commons.Debug;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class ConnectionManager {
	DataSource dataSource;
	public Connection conn;
	public Statement stmt;
	public Statement stmt2;
	public Statement stmt3;
	public PreparedStatement pstmt;
	public ResultSet rs;
	public ResultSet rs1;
	public ResultSet rs2;
	public ResultSet rs3;
	public ResultSet rs4;
	
	public ConnectionManager(DataSource dataSource)
	{
		this.dataSource=dataSource;
	}
	public Connection getConnection() throws SQLException
	{
		Connection connTemp=null;
		if(conn==null)
		{
			conn=dataSource.getConnection();
			connTemp=conn;
			
		}
		else
		{
			//System.out.println("Connections in ConnectionManager Exhausted");
		}
		return connTemp;
	}
	
	/*
	public Statement getStatement() throws Exception
	{
		Statement stmtTemp=null;
		if(stmt==null)
		{
		stmt=conn.createStatement();
		stmtTemp=stmt;
		}
		else if(stmt2==null)
		{
			stmt2=conn.createStatement();
			stmtTemp=stmt2;
		}
		else if(stmt3==null)
		{
			stmt3=conn.createStatement();
			stmtTemp=stmt3;
		}
		else
		{
			//System.out.println("Statements in Connection Manager exhausted");
		}
		return stmtTemp;
	}
	
	public Statement getPreparedStatement(String query) throws Exception
	{
		PreparedStatement stmtTemp=null;
		if(pstmt==null)
		{
			pstmt=conn.prepareStatement(query);
			stmtTemp=pstmt;
		}
		else
		{
			//System.out.println("PreparedStatements in Connection Manager exhausted");
		}
		return stmtTemp;
	}
	public ResultSet executeQuery(Statement stmt,String query) throws Exception
	{
		ResultSet rsTemp=null;
		if(this.stmt==stmt)
		{
			rs=stmt.executeQuery(query);
			rsTemp=rs;
		}
		else if(this.stmt2==stmt)
		{
			rs2=stmt.executeQuery(query);
			rsTemp=rs;
		}
		else if(this.stmt3==stmt)
		{
			rs3=stmt.executeQuery(query);
			rsTemp=rs;
		}
		return rsTemp;
	}
	public ResultSet executeQuery(PreparedStatement pstmt,String query) throws Exception
	{
		ResultSet rsTemp=null;
		if(this.pstmt==pstmt)
		{
			rs=pstmt.executeQuery();
			rsTemp=rs;
		}
		return rsTemp;
	}
	public ResultSet executeQuery(String query) throws Exception
	{
		Statement stmtTemp=null;
		ResultSet rsTemp=null;
		if(stmt==null)
		{
		stmt=conn.createStatement();
		stmtTemp=stmt;
		rs=stmt.executeQuery(query);
		rsTemp=rs;
		}
		else if(stmt2==null)
		{
			stmt2=conn.createStatement();
			stmtTemp=stmt2;
			rs2=stmt.executeQuery(query);
			rsTemp=rs2;
		}
		else if(stmt3==null)
		{
			stmt3=conn.createStatement();
			stmtTemp=stmt3;
			rs3=stmt.executeQuery(query);
			rsTemp=rs3;
		}
		else
		{
			//System.out.println("Statements in Connection Manager exhausted");
		}
		return rsTemp;
	}
	public ResultSet executePreparedQuery(String query) throws Exception
	{
		PreparedStatement stmtTemp=null;
		ResultSet rsTemp=null;
		if(pstmt==null)
		{
		pstmt=conn.prepareStatement(query);
		stmtTemp=pstmt;
		rs4=pstmt.executeQuery();
		rsTemp=rs4;
		}
		
		else
		{
			//System.out.println("Statements in Connection Manager exhausted");
		}
		return rsTemp;
	}
	*/
	public  void closeAll() 
	{
		
		if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					//System.out.println("The error in rwsMasterData" + e);
				}
				rs = null;
			}
			if (rs1 != null) {
				try {
					rs1.close();
				} catch (Exception e) {
					//System.out.println("The error in rwsMasterData" + e);
				}
				rs1 = null;
			}
			if (rs2 != null) {
				try {
					rs2.close();
				} catch (Exception e) {
					//System.out.println("The error in rwsMasterData" + e);
				}
				rs2 = null;
			}
			if (rs3 != null) {
				try {
					rs3.close();
				} catch (Exception e) {
					//System.out.println("The error in rwsMasterData" + e);
				}
				rs3 = null;
			}
			if (rs4 != null) {
				try {
					rs4.close();
				} catch (Exception e) {
					//System.out.println("The error in rwsMasterData" + e);
				}
				rs4 = null;
			}
			
			if (stmt != null) {
				try {
					stmt.close();
				} catch (Exception e) {
					//System.out.println("The error in closeAll=" + e);
				}
				stmt = null;
			}
			
			if (stmt2 != null) {
				try {
					stmt2.close();
				} catch (Exception e) {
					//System.out.println("The error in closeAll=" + e);
				}
				stmt2 = null;
			}
			if (stmt3 != null) {
				try {
					stmt3.close();
				} catch (Exception e) {
					//System.out.println("The error in closeAll=" + e);
				}
				stmt3 = null;
			}
			
			if (pstmt != null) 
			{
				try
				{	
					pstmt.close();
				}
				catch(Exception e)
				{
					//System.out.println("The error in closeAll=" + e);
				}
				pstmt = null;	
			}
				
			if (conn != null) {
				try 
				{
					conn.close();
				} catch (Exception e) 
				{
					//System.out.println("The error in closeAll=" + e);
				}
				conn = null;
			}
			
		}
		
	}

	


