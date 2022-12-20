/*
 * Created on Nov 30, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.admin;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.LabelValueBean;

/**
 * @author nic
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Mon_Phy_Fin_data {
	Connection conn;
	ResultSet rset;
	Statement stat;
	PreparedStatement ps;
	public  Mon_Phy_Fin_data()
	{
		try
		{
		}
		catch(Exception e)
		{	//System.out.println("IN CommonLists constructor " + e);
		}
		
	}
	
	public ArrayList getdistrict() throws Exception
	{
		ArrayList district = new ArrayList();		
		try
		{
			stat = conn.createStatement();
			String query = "SELECT distinct dcode,dname FROM rws_district_tbl";//added dcode
			LabelValueBean label=null;
			rset = stat.executeQuery(query);
			while (rset.next())
			{
				//System.out.println(rset.getString("dname"));
				label=new LabelValueBean();
				label.setLabelValue(rset.getString("dname"));
				label.setLabel(rset.getString("dname"));
				label.setValue(rset.getString("dcode"));//added
				district.add(label);
			}
		}
		finally
		{	
			closeAll();
		}
		return district;
	}
	
	
	public ArrayList  getfin_year() throws Exception
	{
		ArrayList fin_year = new ArrayList();		
		try
		{
			stat = conn.createStatement();
			String query = "SELECT distinct fin_year FROM RWS_MON_FIN_PHY_PROGRESS_TBL";
			LabelValueBean label=null;
			rset = stat.executeQuery(query);
			while (rset.next())
			{
				label=new LabelValueBean();
				label.setLabelValue(rset.getString("fin_year"))	;
				label.setLabel(rset.getString("fin_year"));
				label.setValue(rset.getString("fin_year"));
				fin_year.add(label);
				////System.out.println(fin_year.add(label));
			}
		}
		finally
		{	
			closeAll();
		}
		return fin_year;
	}
	public String[][] getstatus(String fin_year) throws Exception
	{
		String[][] status = new String[23][40]    ;		
		try
		{
			stat = conn.createStatement();
			String query = "SELECT distinct a.dcode, month FROM RWS_MON_FIN_PHY_PROGRESS_TBL a ,rws_district_tbl b where fin_year='"+fin_year+"' and a.dcode=b.dcode order by a.dcode,month";
			rset = stat.executeQuery(query);
			int i=0,j=0;
			while (rset.next())
			{
				
				i=Integer.parseInt(rset.getString("dcode"));
				i=i-1;
				j=0;
				status[i][j]=rset.getString("dcode");
				//System.out.println(rset.getString("dcode"));
				
				j=Integer.parseInt(rset.getString("month"));
				if (j>=4 && j <=12){
					j=j-3;	
				}
				else
				{
					j=j+9;
				}
				
				status[i][j]=rset.getString("month");
				//System.out.println(rset.getString("month"));
				
				////System.out.println(fin_year.add(label));
				
				
			}
		}
		catch(Exception e){
			//System.out.println("Exception in getstatus is "+e);
		}
		
		finally
		{	
			closeAll();
		}
		return status;
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


