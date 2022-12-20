/*
 * Created on Nov 7, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Freeze_status_data implements java.io.Serializable {
	Connection conn;
	ResultSet rset;
	Statement stat;
	PreparedStatement ps;
	
	public Freeze_status_data() 
	{
		
		try
		{
		}
		catch(Exception e)
		{	//System.out.println("IN CommonLists constructor " + e);
		}
	}
	public String  getStatusDt() throws Exception
	{
		String StatusDt="";
		
		try
		{
			stat = conn.createStatement();
			String query = " SELECT distinct to_char(status_date,'dd/mm/yyyy') as statusdt "
				  + " FROM rws_habitation_directory_tbl";
		 
			rset = stat.executeQuery(query);
			if (rset.next())
			StatusDt=rset.getString("statusdt");
		
		}
		finally
		{	
			closeAll();
		}
		return StatusDt;
	}
	
	private void closeAll()
	{
		if(rset != null)
		{
			try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(stat != null)
		{
			try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(ps != null)
		{
			try
			{	ps.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{
			try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}

}
