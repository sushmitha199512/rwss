/*
 * Created on Nov 26, 2007
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
public class Mon_Progress_data {
	Connection conn;
	ResultSet rset;
	Statement stat;
	PreparedStatement ps;
	public  Mon_Progress_data()
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
			String query = "SELECT distinct d.dcode,d.dname FROM rws_district_tbl d,RWS_MON_FIN_PHY_PROGRESS_TBL p where d.dcode=p.dcode";//added dcode
		    LabelValueBean label=null;
			rset = stat.executeQuery(query);
			while (rset.next())
			{
			//System.out.println(rset.getString("dname"));
			label=new LabelValueBean();
			label.setLabelValue(rset.getString("dname"))	;
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
	
	
	
public ArrayList getfin_year(String mdistrict) throws Exception
{
	ArrayList fin_year = new ArrayList();		
	try
	{
		stat = conn.createStatement();
		//System.out.println(mdistrict);
		String query = "SELECT distinct fin_year FROM RWS_MON_FIN_PHY_PROGRESS_TBL where dcode=?";
	    LabelValueBean label=null;
	    PreparedStatement pst= conn.prepareStatement(query);
	   pst.setString(1,mdistrict);
	    rset = stat.executeQuery(query);
		//System.out.println("SELECT distinct fin_year FROM RWS_MON_FIN_PHY_PROGRESS_TBL where dcode='"+mdistrict+"'");
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


public ArrayList getmonth(String fin_year,String district) throws Exception
{
	ArrayList month = new ArrayList();		
	try
	{
		stat = conn.createStatement();
		String query = "SELECT distinct month,decode(month,01,'January',02,'February',03,'March',04,'April',05,'May',06,'June',07,'July',08,'August',09,'September',10,'October',11,'November',12,'December')as mname FROM RWS_MON_FIN_PHY_PROGRESS_TBL where fin_year=? AND dcode=?";
	    LabelValueBean label=null;
	    //System.out.println("SELECT distinct month,decode(month,01,'January',02,'February',03,'March',04,'April',05,'May',06,'June',07,'July',08,'August',09,'September',10,'October',11,'November',12,'December')as mname FROM RWS_MON_FIN_PHY_PROGRESS_TBL where fin_year='"+fin_year+"' AND dcode='" + district +"'");
	    PreparedStatement pst= conn.prepareStatement(query);
	    pst.setString(1, fin_year);
	    pst.setString(2, district);
	    rset = stat.executeQuery(query);
		while (rset.next())
		{
		label=new LabelValueBean();
		//System.out.println(rset.getString("mname"));
    	label.setLabelValue(rset.getString("mname"));
		label.setLabel(rset.getString("mname"));
		label.setValue(rset.getString("month"));
		month.add(label);
		}
	}
	finally
	{	
		closeAll();
	}
	return month;
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
