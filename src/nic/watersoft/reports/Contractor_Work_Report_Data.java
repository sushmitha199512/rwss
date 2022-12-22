package nic.watersoft.reports;

import java.sql.Connection;
import java.sql.DriverManager;
import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import org.apache.struts.action.*;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

/**
 * @author nic
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Contractor_Work_Report_Data extends ActionForm {
	Connection conn;
	ResultSet rset;
	Statement stat;
	PreparedStatement ps;
	DataSource dataSource;
	
	public  Contractor_Work_Report_Data()
	{
	try
	{
		conn = RwsOffices.getConn();
	}
	catch(Exception e)
	{	//System.out.println("IN CommonLists constructor " + e);
	}
}
	
//district
	public ArrayList  getdistrict() throws Exception
	{
		ArrayList district = new ArrayList();		
		try
		{
			stat = conn.createStatement();
		   
			String query = "SELECT distinct dcode,dname from rws_district_tbl a,RWS_TENDER_APPL_TBL b where dcode=substr(work_id,5,2)";
		    //System.out.println("SELECT distinct dcode,dname from rws_district_tbl,RWS_TENDER_APPL_TBL where dcode=substr(work_id,5,2)");
			LabelValueBean label=null;
			rset = stat.executeQuery(query);
			//System.out.println("in district");
			while (rset.next())
			{
			label=new LabelValueBean();
			label.setLabelValue(rset.getString("dname"));
			label.setLabel(rset.getString("dname"));
			label.setValue(rset.getString("dname"));
			label.setValue(rset.getString("dcode"));
			district.add(label);
			//System.out.println("IN District"+rset.getString("dname"));
			////System.out.println("In Fin Year"+fin_year.add(label));
			}
		}
		catch(Exception e){
			//System.out.println("error is "+ e);}
		}
		finally
		{	
			//closeAll();
		}
		return district;
	}
//Contractor Details
	public ArrayList  getcontractor(String mdistrict,String myear) throws Exception
	{
		ArrayList contractor = new ArrayList();	
		String query= null;
		try
		{
			stat = conn.createStatement();
			//System.out.println("district to year is :"+mdistrict);
			
			if (mdistrict.equals("ALL") && myear.equals("ALL"))
			{
				query = "SELECT distinct contractor_name from RWS_contractor_selection_TBL a,RWS_TENDER_APPL_TBL  b where a.work_id=b.work_id" ;
			}
			else if  (mdistrict.equals("ALL") && !myear.equals("ALL"))
			{
				query = "SELECT distinct contractor_name from RWS_contractor_selection_TBL a,RWS_TENDER_APPL_TBL  b where a.work_id=b.work_id and  to_char(a.AGREEMENT_DATE ,'yyyy')='"+myear+"'" ;
			}
			else if  (!mdistrict.equals("ALL") && myear.equals("ALL"))
			{
				query = "SELECT distinct contractor_name from RWS_contractor_selection_TBL a,RWS_TENDER_APPL_TBL  b where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"'" ;
			}
			else if (!mdistrict.equals("ALL") && !myear.equals("ALL"))
			{
				query = "SELECT distinct contractor_name from RWS_contractor_selection_TBL a,RWS_TENDER_APPL_TBL  b where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"' and to_char(a.AGREEMENT_DATE ,'yyyy')='"+myear+"'" ;
			}
			//query = "SELECT distinct contractor_name from RWS_contractor_selection_TBL a,RWS_TENDER_APPL_TBL  b where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"' and to_char(a.AGREEMENT_DATE ,'yyyy')='"+myear+"'" ;
		   
			////System.out.println("SELECT distinct contractor_name from RWS_contractor_selection_TBL a,RWS_TENDER_APPL_TBL  b where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"' and to_char(a.AGREEMENT_DATE ,'yyyy')='"+myear+"'");
			LabelValueBean label=null;
			rset = stat.executeQuery(query);
			//System.out.println("in contractor");
			while (rset.next())
			{
			label=new LabelValueBean();
			label.setLabelValue(rset.getString("contractor_name"));
			label.setLabel(rset.getString("contractor_name"));
			label.setValue(rset.getString("contractor_name"));
			//label.setValue(rset.getString("dcode"));
			contractor.add(label);
			//System.out.println("IN Contractor"+rset.getString("contractor_name"));
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
		return contractor;
	}

	
//
	
public ArrayList  getyear(String mdistrict) throws Exception
{
	ArrayList year = new ArrayList();		
	try
	{
		stat = conn.createStatement();
		//System.out.println("district to year is :"+mdistrict);
		String query;
		if (mdistrict.equals("ALL"))
		{	
		 query = "SELECT distinct to_char(AGREEMENT_DATE ,'yyyy')as fin_year FROM RWS_contractor_selection_TBL a,RWS_TENDER_APPL_TBL b where a.work_id=b.work_id and  AGREEMENT_DATE is not null" ;
		 //System.out.println("SELECT distinct to_char(AGREEMENT_DATE ,'yyyy')as fin_year FROM RWS_contractor_selection_TBL a,RWS_TENDER_APPL_TBL b where a.work_id=b.work_id and  AGREEMENT_DATE is not null") ;
		}
		else 
		{
		 //System.out.println("SELECT distinct to_char(AGREEMENT_DATE ,'yyyy')as fin_year FROM RWS_contractor_selection_TBL a ,RWS_TENDER_APPL_TBL b where a.work_id=b.work_id  and substr(a.work_id,5,2)='"+mdistrict+"' and AGREEMENT_DATE is not null");	
		 query = "SELECT distinct to_char(AGREEMENT_DATE ,'yyyy')as fin_year FROM RWS_contractor_selection_TBL a,RWS_TENDER_APPL_TBL b where a.work_id=b.work_id and substr(a.work_id,5,2)='"+mdistrict+"' and AGREEMENT_DATE is not null" ;
		}

		LabelValueBean label=null;
		rset = stat.executeQuery(query);
		//System.out.println("in year year");
		while (rset.next())
		{
		//System.out.println("in year year");
		label=new LabelValueBean();
		label.setLabelValue(rset.getString("fin_year"))	;
		label.setLabel(rset.getString("fin_year"));
		label.setValue(rset.getString("fin_year"));
		year.add(label);
		//System.out.println("IN FIN-YEAR"+rset.getString("fin_year"));
		////System.out.println("In Fin Year"+fin_year.add(label));
		}
	}
	catch(Exception e){
		//System.out.println("error is "+ e);}
	}
	finally
	{	
		//closeAll();
	}
	return year;
}
//No of Contractor count 
public String getcountrec(String mdistrict,String myear, String mcontractor) throws Exception
{
	
	String  count="";
	String  query = null;
	try
	{   //System.out.println("in the data mode of count");
		stat = conn.createStatement();
		if (mdistrict.equals("ALL") && myear.equals("ALL") && mcontractor.equals("ALL"))
		{	
			query = "SELECT count(distinct(contractor_name)) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and contractor_name is not null"; 	
		}
		else
		if (mdistrict.equals("ALL") && myear.equals("ALL") && !mcontractor.equals("ALL"))
		{
			query = "SELECT count(distinct(contractor_name)) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and contractor_name ='"+mcontractor+"'"; 	
		}
		else
		if (mdistrict.equals("ALL") && !myear.equals("ALL") && mcontractor.equals("ALL"))
		{
			query = "SELECT count(distinct(contractor_name)) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and to_char(b.AGREEMENT_DATE ,'yyyy')='"+myear+"'"; 		
		}
		else
		if (!mdistrict.equals("ALL") && myear.equals("ALL") && mcontractor.equals("ALL"))
		{
			query = "SELECT count(distinct(contractor_name)) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"'"; 						
		}
		else
		if (!mdistrict.equals("ALL") && !myear.equals("ALL") && mcontractor.equals("ALL"))
		{
			query = "SELECT count(distinct(contractor_name)) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"' and to_char(b.AGREEMENT_DATE ,'yyyy')='"+myear+"'"; 								
		}
		else
		if (mdistrict.equals("ALL") && !myear.equals("ALL") && !mcontractor.equals("ALL"))
		{
			query = "SELECT count(distinct(contractor_name)) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and  to_char(b.AGREEMENT_DATE ,'yyyy')='"+myear+"' and contractor_name='"+mcontractor+"'"; 					
		}
		else
		if (!mdistrict.equals("ALL") && myear.equals("ALL") && !mcontractor.equals("ALL"))
		{
			query = "SELECT count(distinct(contractor_name)) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and  substr(b.work_id,5,2)='"+mdistrict+"' and contractor_name='"+mcontractor+"'"; 					
		}
		if (!mdistrict.equals("ALL") && !myear.equals("ALL") && !mcontractor.equals("ALL"))
		{
			query = "SELECT count(distinct(contractor_name)) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"' and to_char(b.AGREEMENT_DATE ,'yyyy')='"+myear+"' and contractor_name='"+mcontractor+"'"; 							
		}
		//query = "SELECT count(distinct(contractor_name)) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and contractor_name is not null"; 
    	//System.out.println("SELECT count(distinct(contractor_name)) as mcount FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and contractor_name is not null");
		
	    rset = stat.executeQuery(query);
		if (rset.next()) {
//        count=Integer.parseInt(rset.getString("mcount"));					
	    count=rset.getString("mcount");
	    
		}
		//System.out.println("mcount is :"+count);
			}
	catch(Exception e){
		//System.out.println("Exception in getstatus is "+e);}
	}
	
		finally
	{	
	//	closeAll();
	}
	return count;
}


//end of count record
	    	
	   
public String[][] getcondata(String mdistrict,String myear, String mcontractor) throws Exception
			{
				
				
				String [][] condata = new String[30][2];
				String query = null;
				try
				{   //System.out.println("in the data mode of count");
					stat = conn.createStatement();
					
					int i=0,j=0;
					if (mdistrict.equals("ALL") && myear.equals("ALL") && mcontractor.equals("ALL"))
					{	
						query = "SELECT contractor_name ,count(*) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and contractor_name is not null group by contractor_name"; 
					}
					else
					if (mdistrict.equals("ALL") && myear.equals("ALL") && !mcontractor.equals("ALL"))
					{
						query = "SELECT contractor_name ,count(*) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and contractor_name ='"+mcontractor+"' group by contractor_name"; 	
					}
					else
					if (mdistrict.equals("ALL") && !myear.equals("ALL") && mcontractor.equals("ALL"))
					{
						query = "SELECT contractor_name ,count(*) as mcount as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and to_char(b.AGREEMENT_DATE ,'yyyy')='"+myear+"' group by contractor_name"; 		
					}
					else
					if (!mdistrict.equals("ALL") && myear.equals("ALL") && mcontractor.equals("ALL"))
					{
						query = "SELECT contractor_name ,count(*) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"' group by contractor_name"; 						
					}
					else
					if (!mdistrict.equals("ALL") && !myear.equals("ALL") && mcontractor.equals("ALL"))
					{
						query = "SELECT contractor_name ,count(*) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"' and to_char(b.AGREEMENT_DATE ,'yyyy')='"+myear+"'group by contractor_name"; 								
					}
					else
					if (mdistrict.equals("ALL") && !myear.equals("ALL") && !mcontractor.equals("ALL"))
					{
						query = "SELECT contractor_name ,count(*) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and  to_char(b.AGREEMENT_DATE ,'yyyy')='"+myear+"' and contractor_name='"+mcontractor+"' group by contractor_name"; 					
					}
					else
					if (!mdistrict.equals("ALL") && myear.equals("ALL") && !mcontractor.equals("ALL"))
					{
						query = "SELECT contractor_name ,count(*) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and  substr(b.work_id,5,2)='"+mdistrict+"' and contractor_name='"+mcontractor+"' group by contractor_name"; 					
					}
					if (!mdistrict.equals("ALL") && !myear.equals("ALL") && !mcontractor.equals("ALL"))
					{
						query = "SELECT contractor_name ,count(*) as mcount  FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and substr(b.work_id,5,2)='"+mdistrict+"' and to_char(b.AGREEMENT_DATE ,'yyyy')='"+myear+"' and contractor_name='"+mcontractor+"' group by contractor_name"; 							
					}


					
					
					query = "SELECT contractor_name ,count(*) as mcount FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and contractor_name is not null group by contractor_name" ;
			    	//System.out.println("SELECT contractor_name, count(*) as mcount   FROM RWS_contractor_selection_TBL b,RWS_TENDER_APPL_TBL a where a.work_id=b.work_id and contractor_name is not null group by contractor_name");
			    	rset = stat.executeQuery(query);
			    	while (rset.next())
					{
			    	j=0;	
			    	condata[i][j]=rset.getString("contractor_name");
					//System.out.println(condata[i][j]);
					j=1;			
					condata[i][j]=rset.getString("mcount");
					//System.out.println(condata[i][j]);
					i++;
					} 
					}
				catch(Exception e){
					//System.out.println("Exception in getstatus is "+e);}
				}
				
					finally
				{	
					closeAll();
				}
				return condata;
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


