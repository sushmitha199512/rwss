/*
 * Created on Dec 11, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;

import java.sql.Connection;
import java.sql.DriverManager;
import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

/**
 * @author nic
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Admn_Sanc_Graph_Data {
	Connection conn;
	ResultSet rset;
	Statement stat;
	PreparedStatement ps;
	DataSource dataSource;
	
	public  Admn_Sanc_Graph_Data()
	{
	try
	{
		conn = RwsOffices.getConn();
	}
	catch(Exception e)
	{	//System.out.println("IN CommonLists constructor " + e);
	}
}
	
	
	
public ArrayList  getfin_year() throws Exception
{
	ArrayList fin_year = new ArrayList();		
	try
	{
			
		stat = conn.createStatement();
	   
		String query = "SELECT distinct to_char(ADMIN_DATE,'yyyy')as fin_year FROM RWS_WORK_ADMN_TBL where admin_date is not null";
	    //System.out.println("SELECT distinct to_char(ADMIN_DATE,'yyyy')as fin_year FROM RWS_WORK_ADMN_TBL where admin_date is not null");
		LabelValueBean label=null;
		rset = stat.executeQuery(query);
		//System.out.println("in financial year");
		while (rset.next())
		{
		//System.out.println("in financial year");
		label=new LabelValueBean();
		label.setLabelValue(rset.getString("fin_year"))	;
		label.setLabel(rset.getString("fin_year"));
		label.setValue(rset.getString("fin_year"));
		fin_year.add(label);
		//System.out.println("IN FIN-YEAR"+rset.getString("fin_year"));
		////System.out.println("In Fin Year"+fin_year.add(label));
		}
	}
	catch(Exception e){
		//System.out.println("error is "+ e);}
	}
	finally
	{	
		closeAll();
	}
	return fin_year;
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


