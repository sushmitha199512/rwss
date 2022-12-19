package nic.watersoft.reports;


import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.sql.DataSource;
import java.sql.ResultSetMetaData;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;

import nic.watersoft.masters.RwsMaster;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.tags.ExpenditureTag;
import nic.watersoft.works.rws_works_factory;
import nic.watersoft.commons.*;

import java.util.*;
/**
 * @author Manoj
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class FlexReportDAO {
	Connection con=null;
	ResultSet rst=null,rs1=null;  
	PreparedStatement pstmt=null;
	Statement stmt=null,stmt1=null;
	DataSource datasource=null;
	ArrayList workwiseexpendituredata;
	private LabelValueBean labelValueBean;
	//RwsOffices office = new RwsOffices()
	FlexReportDAO()
	{
	}
	FlexReportDAO(DataSource datasource)
	{
		this.datasource=datasource;
	}
	
	public void createViews(String dcode)
	{
		
		String query[]=new String[2];
		Connection con=null;
		if(!dcode.equals("ALL"))
		{
			query[0]="CREATE OR REPLACE VIEW habitation_directory_"+dcode+"_view AS "+
			"SELECT * FROM rws_habitation_directory_tbl where substr(hab_code,1,2)='"+dcode+"' and coverage_status <> 'UI' and coverage_status is not null";
			
			query[1]="CREATE OR REPLACE VIEW panchayat_raj_"+dcode+"_view AS "+
			"SELECT * FROM rws_panchayat_raj_tbl where substr(panch_code,1,2)='"+dcode+"'";
		}
		else
		{
			query[0]="CREATE OR REPLACE VIEW habitation_directory_"+dcode+"_view AS "+
			"SELECT * FROM rws_habitation_directory_tbl where coverage_status <> 'UI' and coverage_status is not null";
			
			query[1]="CREATE OR REPLACE VIEW panchayat_raj_"+dcode+"_view AS "+
			"SELECT * FROM rws_panchayat_raj_tbl";
		}
		try
		{	
			con=RwsOffices.getConn();
			stmt=con.createStatement();
			for(int i=0;i<2;i++)
			{
				//System.out.println("query is "+query[i]);
				int res=stmt.executeUpdate(query[i]);
				//System.out.println("res "+res);
				
			}
		}
		catch (SQLException se)
		{
			//System.out.println("Exception in createViews "+se.getMessage());
			
		}
		finally
		{
			try{
				stmt.close();
				con.close();
			}
			catch (Exception e)
			{
				//System.out.println("Exception in createViews in closing connection "+e);
				
			}
		}
		
		
	}
	
	
	public boolean dropViews(String dcode)
	{
		String query[]=new String[2];
		Connection con=null;
		query[0]="drop VIEW  habitation_directory_"+dcode+"_view";
		query[1]="drop VIEW panchayat_raj_"+dcode+"_view";
		//System.out.println("query is "+query[0]);
		//System.out.println("query is "+query[1]);
		int res = 0;
		try
		{	
		con=RwsOffices.getConn();
	 	stmt=con.createStatement();
	 	res=stmt.executeUpdate(query[0]);
	 	res+=stmt.executeUpdate(query[1]);
	 	/*for(int i=0;i<query.length;i++)
	 	{
	 	int res=stmt.executeUpdate(query[i]);
	 	if(res>0)
	 		return true;
	 	else
	 		return false;
		}*/
		}
		catch (SQLException se)
		{
			//System.out.println("Exception in dropViews "+se.getMessage());
			return false;
		}
		finally
		{
		try{
			stmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
								//System.out.println("Exception in dropViews in closing connection "+e);
								return false;
		                   }
		}
		if(res>0)
	 		return true;
	 	else
	 		return false;
	}
	
	
	//creating a view for the query---->which is returned in the methos queryGenerator()
	public void createView2(String qry)
	{
		
		Connection con=null;
		String qry1="CREATE OR REPLACE VIEW qry_gen2_view AS "+qry+"";
		//System.out.println("Query to create view"+qry1);
      try
		{	
			con=RwsOffices.getConn();
			stmt=con.createStatement();
			int res=stmt.executeUpdate(qry1);
			//System.out.println("res "+res);
		}
		catch (SQLException se)
		{
			//System.out.println("Exception in createView2 "+se.getMessage());
		}
		finally
		{
			try{
				stmt.close();
				con.close();
			}
			catch (Exception e)
			{
				//System.out.println("Exception in createView2 in closing connection "+e);
				
			}
		}
	}
	
	public boolean dropView2()
	{
		String qry="";
		Connection con=null;
		qry="drop VIEW qry_gen2_view";
		try
		{	
		con=RwsOffices.getConn();
	 	stmt=con.createStatement();
	 	int res=stmt.executeUpdate(qry);
	 	//System.out.println("View 2 Dropped....");
	 	if(res>0)
	 		return true;
	 	else
	 		return false;
	 	
		}
		catch (SQLException se)
		{
			//System.out.println("Exception in dropView2 "+se.getMessage());
			return false;
		}
		finally
		{
		try{
			stmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
								//System.out.println("Exception in dropViews in closing connection "+e);
								return false;
		                   }
		}
		
	}
	
	//End of createView2
	
	
	
	
	public String getHabDirTabName(String dcode)
	{
		if(dcode.equals(""))
			return "rws_habitation_directory_tbl";
		else
			return "habitation_directory_"+dcode+"_view";
	}
	public String getPanchRajTabName(String dcode)
	{
		if(dcode.equals(""))
			return "rws_panchayat_raj_tbl";
		else
			return "panchayat_raj_"+dcode+"_view";
	}
	public String headerNames(String district)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
			 	pstmt=con.prepareStatement("select d.dname from rws_district_tbl d,rws_mandal_tbl m where d.dcode='"+district+"' and m.dcode='"+district+"' and d.dcode=m.dcode");
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
		}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	}
	
	//code added by sridhar for constituency header names 
	public String constituencyheaderNames(String district,String mandal1)
	{
		String conhead=null;
		try
		{	
				con=RwsOffices.getConn();
				String qry="select constituency_name from rws_mandal_tbl m,rws_constituency_tbl c where  m.dcode=c.dcode and c.mcode=m.mcode and m.mcode='"+mandal1+"' and m.dcode='"+district+"'";
			 	//Debug.println("qry in conheader:"+qry);
				pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 		conhead=rst.getString(1).toUpperCase();
				}
			
			
	 	}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return conhead;
	
	}
	//code end
	public String mheaderNames(String district,String mandal1)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
				String qry="select mname from rws_mandal_tbl  where mcode='"+mandal1+"' and dcode='"+district+"'";
			 	pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
		
	 	}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	
	}
	
	public String mpheaderNames(String district,String mandal1,String panch1)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
				String qry="select pname from rws_panchayat_tbl  where dcode='"+district+"' and mcode='"+mandal1+"' and pcode='"+panch1+"'";
			 	pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
	 	}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	
	}
	public String mpvheaderNames(String district,String mandal1,String panch1,String village1)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
				String qry="select vname from rws_village_tbl  where dcode='"+district+"' and mcode='"+mandal1+"' and pcode='"+panch1+"' and vcode='"+village1+"'";
			 	pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
		
	 	}
		catch (SQLException se)
		{
			//System.out.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	
	}
	//code added by vikas to get the Habitations Name
	public String mpvhheaderNames(String district,String mandal1,String panch1,String village1,String hab1)
	{
		String dhead=null;
		try
		{	
			if(!district.equals("ALL"))
			{
				con=RwsOffices.getConn();
				String qry="select panch_name from rws_panchayat_raj_tbl  where substr(panch_code,1,2)='"+district+"' and substr(panch_code,6,2)='"+mandal1+"' and substr(panch_code,13,2)='"+panch1+"' and substr(panch_code,8,3)='"+village1+"' and hab_code='"+hab1+"' ";
				Debug.println("mpvheadername hab:"+qry);
			 	pstmt=con.prepareStatement(qry);
			 	rst=pstmt.executeQuery();
			 	while(rst.next())
			 	{
			 	dhead=rst.getString(1);
				}
			}
			else
			{
				dhead="ALL";
			}
	 	}
		catch (SQLException se)
		{
			Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dhead;
	
	}
	
	
	public ArrayList defaultData(ArrayList columns,String dist)
	{   RwsMaster rwsMaster = null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	String qry="select d.dcode,d.dname,count(hab_code) ";
 	String ord="";
	boolean added=true;
	boolean ordadded=false;
	if(columns.contains("Census Plain Pop."))
	       {
			  	qry+=",";
		     qry+=" sum(h.census_plain_popu)";
		     if(added)
		     {
		     	ord+="order by ";
		     }
		     if(ordadded)
		     	ord+=",";
		     ord+=" sum(h.census_plain_popu)";
		     ordadded=true;
		     added=false;
		   }
		if(columns.contains("Census SC Pop."))
		   {
			 	qry+=",";
			qry+=" sum(h.census_sc_popu)";
			if(added)
			{
		     	ord+="order by ";
			}
			if(ordadded)
		     	ord+=",";
			ord+=" sum(h.census_sc_popu)";
			ordadded=true;
			added=false;
		   }
		if(columns.contains("Census ST Pop."))
		   {
			qry+=",";
			qry+=" sum(h.census_st_popu)";
			if(added)
			{
		     	ord+="order by ";
			}
			if(ordadded)
		     	ord+=",";
			ord+=" sum(h.census_st_popu)";
			ordadded=true;
			added=false;
		   }
		if(columns.contains("Census Float Pop."))
		   {
			qry+=",";
			qry+=" sum(h.float_pop)";
			if(added)
			{
		     	ord+="order by ";
			}
			if(ordadded)
		     	ord+=",";
			ord+=" sum(h.float_pop)";
			ordadded=true;
			added=false;
		   }
		if(columns.contains("Total Population"))
		   {
			qry+=",";
			qry+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
			if(added)
			{
		     	ord+="order by ";
			}
			if(ordadded)
		     	ord+=",";
			ord+=" sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
			ordadded=true;
			added=false;
		   }
 	qry+="from rws_habitation_directory_tbl h,rws_district_tbl d,rws_complete_hab_view c  where h.hab_code=c.panch_code and d.dcode='"+dist+"' AND H.COVERAGE_STATUS <> 'UI' AND d.dcode=substr(h.hab_code,1,2) group by d.dcode,d.dname "+ord+"";
	//System.out.println(qry);
 	pstmt=con.prepareStatement(qry);
 	rst=pstmt.executeQuery();
 	int i=1;
 	while(rst.next())
 	{
 		rwsMaster = new RwsMaster();
 		if(columns.contains("District Code"))
        {
          rwsMaster.setDistCode(rst.getString(i));
          i++;
        }
 		if(columns.contains("District Name"))
        {
          rwsMaster.setDistName4(rst.getString(i));
          i++;
        }
 		if(columns.contains("No.Of Habitations"))
        {
 			rwsMaster.setNoOfHabs(rst.getInt(i));
          i++;
        }
 		if(columns.contains("Census Plain Pop."))
         {
           //System.out.println("CENSUS PLAIN------->"+rst.getInt(i));
           rwsMaster.setCensusPop(rst.getInt(i));
           i++;
         }
         if(columns.contains("Census SC Pop."))
         {
         	//System.out.println("CENSUS SC------->"+rst.getInt(i));
           rwsMaster.setCensusSc(rst.getInt(i));
           i++;
         }
         if(columns.contains("Census ST Pop."))
         	{
         	//System.out.println("CENSUS ST------->"+rst.getInt(i));
         	rwsMaster.setCensusSt(rst.getInt(i));
         	i++;
         	}
         if(columns.contains("Census Float Pop."))
         {
         	//System.out.println("CENSUS FLOAT------->"+rst.getInt(i));
            rwsMaster.setCensusFloat(""+rst.getInt(i));
           i++;
         }
         if(columns.contains("Total Population"))
         {
         	//System.out.println("CENSUS TOT------->"+rst.getInt(i));
            rwsMaster.setCensusTotal(""+rst.getInt(i));
           i++;
         }
 		dlist.add(rwsMaster);
 	   }
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	
	//CONSOLIDATED REPORT FOR A PARTICULAR DISTRICT
	public ArrayList consolData(ArrayList columns,RwsMaster rwsm,String dist)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		ArrayList al=new ArrayList();
		try 
		   {
			//System.out.println("CONSOLDATA");
			con=RwsOffices.getConn();
			String qry="select d.dcode,d.dname,count(h.hab_code) ";
			String ord="";
			boolean added=true;
			boolean ordadded=false;
			if(columns.contains("Census Plain Pop."))
			       {
					  	qry+=",";
				     qry+="sum(h.census_plain_popu)";
				     if(added)
				     {
				     	ord+="order by ";
				     }
				     if(ordadded)
				     	ord+=",";
				     ord+="sum(h.census_plain_popu)";
				     ordadded=true;
				     added=false;
				   }
				if(columns.contains("Census SC Pop."))
				   {
					 	qry+=",";
					qry+="sum(h.census_sc_popu)";
					if(added)
					{
				     	ord+="order by ";
					}
					if(ordadded)
				     	ord+=",";
					ord+="sum(h.census_sc_popu)";
					ordadded=true;
					added=false;
				   }
				if(columns.contains("Census ST Pop."))
				   {
					qry+=",";
					qry+="sum(h.census_st_popu)";
					if(added)
					{
				     	ord+="order by ";
					}
					if(ordadded)
				     	ord+=",";
					ord+="sum(h.census_st_popu)";
					ordadded=true;
					added=false;
				   }
				if(columns.contains("Census Float Pop."))
				   {
					qry+=",";
					qry+="sum(h.float_pop)";
					if(added)
					{
				     	ord+="order by ";
					}
					if(ordadded)
				     	ord+=",";
					ord+="sum(h.float_pop)";
					ordadded=true;
					added=false;
				   }
				if(columns.contains("Total Population"))
				   {
					qry+=",";
					qry+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
					if(added)
					{
				     	ord+="order by";
					}
					if(ordadded)
				     	ord+=",";
					ord+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
					ordadded=true;
					added=false;
				   }
			qry+="from "+getHabDirTabName(rwsm.getDistCode())+" h,rws_district_tbl d where d.dcode='"+dist+"' and d.dcode=substr(h.hab_code,1,2) ";
			if (rwsm.getCompl_stat().length!=0)
			{
				boolean check=false;
				String arr[]=rwsm.getCompl_stat();
				qry+=" and h.coverage_status IN ('";
				for (int i=0;i<arr.length;i++)
					{
					if (check)
						qry+=",'";
					qry+=arr[i]+"'";
					check=true;
					}
				qry+=")";
					}
			if (rwsm.getPrev_stat1().length!=0)
			{
				boolean check=false;
				String arr[]=rwsm.getPrev_stat1();
				qry+=" and h.previous_yr_status IN ('";
				//System.out.println("Previous yr1");
				for (int i=0;i<arr.length;i++)
					{
					if (check)
						qry+=",'";
					qry+=arr[i]+"'";
					check=true;
					}
				qry+=")";
					}
			if(!(rwsm.getCp().equals("")))
			{
				qry+=" and h.census_plain_popu "+rwsm.getCp_condition()+""+rwsm.getCp()+"";
			}
			if(!(rwsm.getCsc().equals("")))
			{
				qry+=" and h.census_sc_popu "+rwsm.getCsc_condition()+""+rwsm.getCsc()+"";
			}
			if(!(rwsm.getCst().equals("")))
			{
				qry+=" and h.census_st_popu "+rwsm.getCst_condition()+""+rwsm.getCst()+"";
			}
			if(!(rwsm.getCtot().equals("")))
			{
				qry+=" and (h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop) "+rwsm.getCtot_condition()+""+rwsm.getCtot()+"";
			}
			if(!(rwsm.getFlopop1().equals("")))
			{
				qry+=" and h.float_pop "+rwsm.getFlopop_condition()+""+rwsm.getFlopop1()+"";
			}
			if(!((rwsm.getFloreason()).equals("")))
			{
				qry+=" and h.float_pop_reasons ='"+(rwsm.getFloreason()).toUpperCase()+"'";
			}
//			added by swapna
			if(!((rwsm.getHabType()).equals("")))
			{
				qry+=" and h.habitation_type ='"+(rwsm.getHabType()).toUpperCase()+"'";
			}
			if(!((rwsm.getHabSubType()).equals("")))
			{
				qry+=" and h.habitation_sub_type ='"+(rwsm.getHabSubType()).toUpperCase()+"'";
			}
			if(!((rwsm.getHabCat()).equals("")))
			{
				qry+=" and h.habitation_category ='"+(rwsm.getHabCat()).toUpperCase()+"'";
			}
			//
			if(!(rwsm.getTot_wat_supl().equals("")))
			{
				qry+=" and h.total_water_supply "+rwsm.getTot_wat_supl_condition()+""+rwsm.getTot_wat_supl()+"";
			}
			 if(!(rwsm.getExt_wat_lvl().equals("")))
			{
			 	qry+=" and h.exist_water_level "+rwsm.getExt_wat_lvl_condition()+""+rwsm.getExt_wat_lvl()+"";
			}
			 if(!(rwsm.getNear_surf_source().equals("")))
			{
			 	qry+=" and h.near_surface_source "+rwsm.getNear_surf_source_condition()+""+rwsm.getNear_surf_source()+"";
			}
			if(!(rwsm.getNear_ground_source().equals("")))
			{
				qry+=" and h.near_ground_source "+rwsm.getNear_ground_source_condition()+""+rwsm.getNear_ground_source()+"";
			}
			if(!(rwsm.getProp_year1().equals("")))
			{
				qry+=" and h.proposed_fc_year ='"+rwsm.getProp_year1()+"'";
			}
			if(!(rwsm.getAmnt_reqd1().equals("")))
			{
				qry+=" and h.proposed_fc_est_amt "+rwsm.getAmnt_reqd_condition()+""+rwsm.getAmnt_reqd1()+"";
			}
			if ( !(rwsm.getDistCode()==null) && !(rwsm.getDistCode().equals("")))
			{
				qry+=" and substr(h.hab_code,1,2)='"+rwsm.getDistCode()+"' having d.dcode='"+rwsm.getDistCode()+"'";
			}
			qry+=" group by d.dcode,d.dname "+ord+"";
			//System.out.println("QUERY IS:"+qry);
			pstmt=con.prepareStatement(qry);
			createViews(rwsm.getDistCode());//creating view
			rst=pstmt.executeQuery();
			int i=4;
			while(rst.next())
			                { 
				               rwsMaster = new RwsMaster();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		               rwsMaster.setNoOfHabs(rst.getInt(3));
		 		              if(columns.contains("Census Plain Pop."))
		 		              {
		 		              	//System.out.println("CENSUS PLAIN------->"+rst.getInt(i));
		 		                rwsMaster.setCensusPop(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census SC Pop."))
		 		              {
		 		              	//System.out.println("CENSUS SC------->"+rst.getInt(i));
		 		                rwsMaster.setCensusSc(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census ST Pop."))
		 		              	{
		 		              	//System.out.println("CENSUS ST------->"+rst.getInt(i));
		 		              	rwsMaster.setCensusSt(rst.getInt(i));
		 		              	i++;
		 		              	}
		 		              if(columns.contains("Census Float Pop."))
		 		              {
		 		              	//System.out.println("CENSUS FLOAT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusFloat(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Total Population"))
		 		              {
		 		              	//System.out.println("CENSUS TOT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusTotal(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		               dlist.add(rwsMaster);
				             }
			dropViews(rwsm.getDistCode());//droping view
		   }
		catch(Exception e)
		   {
			//System.out.println(e.getMessage());
			}
		finally
		    {
			try {rst.close();
			     pstmt.close();
			     con.close();
				}
			catch(Exception e)
			     {
				 //System.out.println("Error in Closeing Connection...."); 
			     }
			 }
	return dlist;	
	}
	
	//CONSOLIDATED REPORT FOR A PARTIULAR MANDAL,PANCHAYAT,VILLAGE 
	//code modified by sridhar for constituency added   
	public ArrayList consolData1(ArrayList columns,RwsMaster rwsm,String dist)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		try 
		   {
			con=RwsOffices.getConn();
			
			//FOR VILLAGE
			
			if ( !(rwsm.getDistCode()==null) && !(rwsm.getDistCode().equals("")) && !(rwsm.getMandalCode()==null) && !(rwsm.getMandalCode().equals("")) && !(rwsm.getPanchCode()==null) && !(rwsm.getPanchCode().equals("")) && !(rwsm.getVillCode()==null) && !(rwsm.getVillCode().equals("")) )
			{
				//System.out.println("DMPV");
				String qry="select d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,count(h.hab_code) ";
				String ord="";
				boolean added=true;
				boolean ordadded=false;
				if(columns.contains("Census Plain Pop."))
				       {
					     qry+=",";
					     qry+="sum(h.census_plain_popu)";
					     if(added)
					     {
					     	ord+="order by ";
					     }
					     if(ordadded)
					     	ord+=",";
					     ord+="sum(h.census_plain_popu)";
					     ordadded=true;
					     added=false;
					   }
					if(columns.contains("Census SC Pop."))
					   {
						 	qry+=",";
						qry+="sum(h.census_sc_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_sc_popu)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Census ST Pop."))
					   {
						qry+=",";
						qry+="sum(h.census_st_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_st_popu)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Census Float Pop."))
					   {
						qry+=",";
						qry+="sum(h.float_pop)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.float_pop)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Total Population"))
					   {
						qry+=",";
						qry+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
						ordadded=true;
						added=false;
					   }
				//Debug.println("before from:"+qry);
				qry+=" from "+getHabDirTabName(rwsm.getDistCode())+" h,rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where substr(h.hab_code,1,2)='"+rwsm.getDistCode()+"' and d.dcode=c.dcode and c.mcode=m.mcode and d.dcode=m.dcode and substr(h.hab_code,6,2)='"+rwsm.getMandalCode()+"' and p.mcode=m.mcode and p.dcode=d.dcode and substr(h.hab_code,13,2)='"+rwsm.getPanchCode()+"' and v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode and substr(h.hab_code,8,3)='"+rwsm.getVillCode()+"'";
				//Debug.println("after from:"+qry);
				if (rwsm.getCompl_stat().length!=0)
				{
					boolean check=false;
					String arr[]=rwsm.getCompl_stat();
					qry+=" and h.coverage_status IN ('";
					for (int i=0;i<arr.length;i++)
						{
						if (check)
							qry+=",'";
						qry+=arr[i]+"'";
						check=true;
						}
					qry+=")";
						}
				if (rwsm.getPrev_stat1().length!=0)
				{
					boolean check=false;
					String arr[]=rwsm.getPrev_stat1();
					qry+=" and h.previous_yr_status IN ('";
					//System.out.println("Previous Year2");
					for (int i=0;i<arr.length;i++)
						{
						if (check)
							qry+=",'";
						qry+=arr[i]+"'";
						check=true;
						}
					qry+=")";
						}
				if(!(rwsm.getCp().equals("")))
				{
					qry+=" and h.census_plain_popu "+rwsm.getCp_condition()+""+rwsm.getCp()+"";
				}
				if(!(rwsm.getCsc().equals("")))
				{
					qry+=" and h.census_sc_popu "+rwsm.getCsc_condition()+""+rwsm.getCsc()+"";
				}
				if(!(rwsm.getCst().equals("")))
				{
					qry+=" and h.census_st_popu "+rwsm.getCst_condition()+""+rwsm.getCst()+"";
				}
				if(!(rwsm.getCtot().equals("")))
				{
					qry+=" and (h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop) "+rwsm.getCtot_condition()+""+rwsm.getCtot()+"";
				}
				if(!(rwsm.getFlopop1().equals("")))
				{
					qry+=" and h.float_pop "+rwsm.getFlopop_condition()+""+rwsm.getFlopop1()+"";
				}
				if(!((rwsm.getFloreason()).equals("")))
				{
					qry+=" and h.float_pop_reasons ='"+(rwsm.getFloreason()).toUpperCase()+"'";
				}
//				added by swapna
				if(!((rwsm.getHabType()).equals("")))
				{
					qry+=" and h.habitation_type ='"+(rwsm.getHabType()).toUpperCase()+"'";
				}
				if(!((rwsm.getHabSubType()).equals("")))
				{
					qry+=" and h.habitation_sub_type ='"+(rwsm.getHabSubType()).toUpperCase()+"'";
				}
				if(!((rwsm.getHabCat()).equals("")))
				{
					qry+=" and h.habitation_category ='"+(rwsm.getHabCat()).toUpperCase()+"'";
				}
				//
				if(!(rwsm.getTot_wat_supl().equals("")))
				{
					qry+=" and h.total_water_supply "+rwsm.getTot_wat_supl_condition()+""+rwsm.getTot_wat_supl()+"";
				}
				 if(!(rwsm.getExt_wat_lvl().equals("")))
				{
				 	qry+=" and h.exist_water_level "+rwsm.getExt_wat_lvl_condition()+""+rwsm.getExt_wat_lvl()+"";
				}
				 if(!(rwsm.getNear_surf_source().equals("")))
				{
				 	qry+=" and h.near_surface_source "+rwsm.getNear_surf_source_condition()+""+rwsm.getNear_surf_source()+"";
				}
				if(!(rwsm.getNear_ground_source().equals("")))
				{
					qry+=" and h.near_ground_source "+rwsm.getNear_ground_source_condition()+""+rwsm.getNear_ground_source()+"";
				}
				if(!(rwsm.getProp_year1().equals("")))
				{
					qry+=" and h.proposed_fc_year ='"+rwsm.getProp_year1()+"'";
				}
				if(!(rwsm.getAmnt_reqd1().equals("")))
				{
					qry+=" and h.proposed_fc_est_amt "+rwsm.getAmnt_reqd_condition()+""+rwsm.getAmnt_reqd1()+"";
				}
				qry+=" having d.dcode='"+dist+"' and d.dcode='"+rwsm.getDistCode()+"' and m.mcode='"+rwsm.getMandalCode()+"'and p.pcode='"+rwsm.getPanchCode()+"' and v.vcode='"+rwsm.getVillCode()+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vname,v.vcode "+ord+"";
			
			Debug.println("QUERY IS:1--->"+qry);
			pstmt=con.prepareStatement(qry);
			createViews(rwsm.getDistCode());//creating view
			rst=pstmt.executeQuery();
			int i=5;
			while(rst.next()) 
			                { 
				               rwsMaster = new RwsMaster();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		              rwsMaster.setConstituencyCode(rst.getString(3));
		 		               rwsMaster.setConstituencyName(rst.getString(4));
		 		            
		 		              if(columns.contains("Mandal Code"))
		 		              {
		 		              	rwsMaster.setMandalCode(rst.getString(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Mandal Name"))
		 		              {
		 		             	rwsMaster.setMandalName(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Panchayat Code"))
		 		              {
		 		            	rwsMaster.setPanchCode(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Panchayat Name"))
		 		              {
		 		            	rwsMaster.setPanchName(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Village Code"))
		 		              {
		 		                rwsMaster.setVillCode(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Village Name"))
	 		                  {
	 		                  rwsMaster.setVillName(rst.getString(i));
	 		                  i++;
	 		                   }
		 		             //code modified by pranavi
		 		           //  rwsMaster.setNoOfHabs(rst.getInt(i));
		 		            // i++;
		 		             if(columns.contains("No. Of Habitations"))
	 		                  {
		 		               rwsMaster.setNoOfHabs(rst.getInt(i));
	 		                   i++;
	 		                  }
		 		               
		 		              if(columns.contains("Census Plain Pop."))
		 		              {
		 		              	//System.out.println("CENSUS PLAIN------->"+rst.getInt(i));
		 		                rwsMaster.setCensusPop(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census SC Pop."))
		 		              {
		 		              	//System.out.println("CENSUS SC------->"+rst.getInt(i));
		 		                rwsMaster.setCensusSc(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census ST Pop."))
		 		              	{
		 		              	//System.out.println("CENSUS ST------->"+rst.getInt(i));
		 		              	rwsMaster.setCensusSt(rst.getInt(i));
		 		              	i++;
		 		              	}
		 		              if(columns.contains("Census Float Pop."))
		 		              {
		 		              	//System.out.println("CENSUS FLOAT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusFloat(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Total Population"))
		 		              {
		 		              	//System.out.println("CENSUS TOT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusTotal(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		           // Debug.println("No. Of Habitations----->"+rst.getInt(7));
		 		               dlist.add(rwsMaster);
				             }
			dropViews(rwsm.getDistCode());
		   }
			
			//FOR PANCHAYAT
			
			else if ( !(rwsm.getDistCode()==null) && !(rwsm.getDistCode().equals("")) && !(rwsm.getMandalCode()==null) && !(rwsm.getMandalCode().equals("")) && !(rwsm.getPanchCode()==null) && !(rwsm.getPanchCode().equals("")))
			{
				//System.out.println("DMP");
				String qry="select d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,count(h.hab_code) ";
				String ord="";
				boolean added=true;
				boolean ordadded=false;
				if(columns.contains("Census Plain Pop."))
				       {
					     qry+=",";
					     qry+="sum(h.census_plain_popu)";
					     if(added)
					     {
					     	ord+="order by ";
					     }
					     if(ordadded)
					     	ord+=",";
					     ord+="sum(h.census_plain_popu)";
					     ordadded=true;
					     added=false;
					   }
					if(columns.contains("Census SC Pop."))
					   {
						 	qry+=",";
						qry+="sum(h.census_sc_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_sc_popu)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Census ST Pop."))
					   {
						qry+=",";
						qry+="sum(h.census_st_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_st_popu)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Census Float Pop."))
					   {
						qry+=",";
						qry+="sum(h.float_pop)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.float_pop)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Total Population"))
					   {
						qry+=",";
						qry+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
						ordadded=true;
						added=false;
					   }
				
				qry+=" from "+getHabDirTabName(rwsm.getDistCode())+" h,rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_panchayat_tbl p where substr(h.hab_code,1,2)='"+rwsm.getDistCode()+"' and d.dcode=c.dcode and c.mcode=m.mcode and d.dcode=m.dcode and substr(h.hab_code,6,2)='"+rwsm.getMandalCode()+"' and p.mcode=m.mcode and p.dcode=d.dcode and substr(h.hab_code,13,2)='"+rwsm.getPanchCode()+"' ";
				if(rwsm.getCompl_stat().length!=0)
				{
					boolean check=false;
					String arr[]=rwsm.getCompl_stat();
					qry+=" and h.coverage_status IN ('";
					for (int i=0;i<arr.length;i++)
						{
						if (check)
							qry+=",'";
						qry+=arr[i]+"'";
						check=true;
						}
					qry+=")";
						}
				if (rwsm.getPrev_stat1().length!=0)
				{
					boolean check=false;
					String arr[]=rwsm.getPrev_stat1();
					qry+=" and h.previous_yr_status IN ('";
					//System.out.println("Previous Year2");
					for (int i=0;i<arr.length;i++)
						{
						if (check)
							qry+=",'";
						qry+=arr[i]+"'";
						check=true;
						}
					qry+=")";
						}
				if(!(rwsm.getCp().equals("")))
				{
					qry+=" and h.census_plain_popu "+rwsm.getCp_condition()+""+rwsm.getCp()+"";
				}
				if(!(rwsm.getCsc().equals("")))
				{
					qry+=" and h.census_sc_popu "+rwsm.getCsc_condition()+""+rwsm.getCsc()+"";
				}
				if(!(rwsm.getCst().equals("")))
				{
					qry+=" and h.census_st_popu "+rwsm.getCst_condition()+""+rwsm.getCst()+"";
				}
				if(!(rwsm.getCtot().equals("")))
				{
					qry+=" and (h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop) "+rwsm.getCtot_condition()+""+rwsm.getCtot()+"";
				}
				if(!(rwsm.getFlopop1().equals("")))
				{
					qry+=" and h.float_pop "+rwsm.getFlopop_condition()+""+rwsm.getFlopop1()+"";
				}
				if(!((rwsm.getFloreason()).equals("")))
				{
					qry+=" and h.float_pop_reasons ='"+(rwsm.getFloreason()).toUpperCase()+"'";
				}
//				added by swapna
				if(!((rwsm.getHabType()).equals("")))
				{
					qry+=" and h.habitation_type ='"+(rwsm.getHabType()).toUpperCase()+"'";
				}
				if(!((rwsm.getHabSubType()).equals("")))
				{
					qry+=" and h.habitation_sub_type ='"+(rwsm.getHabSubType()).toUpperCase()+"'";
				}
				if(!((rwsm.getHabCat()).equals("")))
				{
					qry+=" and h.habitation_category ='"+(rwsm.getHabCat()).toUpperCase()+"'";
				}
				//
				if(!(rwsm.getTot_wat_supl().equals("")))
				{
					qry+=" and h.total_water_supply "+rwsm.getTot_wat_supl_condition()+""+rwsm.getTot_wat_supl()+"";
				}
				 if(!(rwsm.getExt_wat_lvl().equals("")))
				{
				 	qry+=" and h.exist_water_level "+rwsm.getExt_wat_lvl_condition()+""+rwsm.getExt_wat_lvl()+"";
				}
				 if(!(rwsm.getNear_surf_source().equals("")))
				{
				 	qry+=" and h.near_surface_source "+rwsm.getNear_surf_source_condition()+""+rwsm.getNear_surf_source()+"";
				}
				if(!(rwsm.getNear_ground_source().equals("")))
				{
					qry+=" and h.near_ground_source "+rwsm.getNear_ground_source_condition()+""+rwsm.getNear_ground_source()+"";
				}
				if(!(rwsm.getProp_year1().equals("")))
				{
					qry+=" and h.proposed_fc_year ='"+rwsm.getProp_year1()+"'";
				}
				if(!(rwsm.getAmnt_reqd1().equals("")))
				{
					qry+=" and h.proposed_fc_est_amt "+rwsm.getAmnt_reqd_condition()+""+rwsm.getAmnt_reqd1()+"";
				}
				qry+=" having d.dcode='"+rwsm.getDistCode()+"' and m.mcode='"+rwsm.getMandalCode()+"'and p.pcode='"+rwsm.getPanchCode()+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname "+ord+"";
			
			//Debug.println("QUERY IS:2-->"+qry);
			pstmt=con.prepareStatement(qry);
			createViews(rwsm.getDistCode());//creating view
			rst=pstmt.executeQuery();
			int i=5;
			while(rst.next())
			                { 
				               rwsMaster = new RwsMaster();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		              rwsMaster.setConstituencyCode(rst.getString(3));
		 		               rwsMaster.setConstituencyName(rst.getString(4));
		 		              if(columns.contains("Mandal Code"))
		 		              {
		 		              	rwsMaster.setMandalCode(rst.getString(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Mandal Name"))
		 		              {
		 		             	rwsMaster.setMandalName(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Panchayat Code"))
		 		              {
		 		            	rwsMaster.setPanchCode(rst.getString(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Panchayat Name"))
		 		              {
		 		            	rwsMaster.setPanchName(rst.getString(i));
		 		                i++;
		 		              }
		 		             //code modified by pranavi...
		 		             // rwsMaster.setNoOfHabs(rst.getInt(i));
		 		             // i++;
		 		            //Debug.println("no of habs---------->"+rst.getInt(i));
		 		             if(columns.contains("No. Of Habitations"))
	 		                  {
		 		               rwsMaster.setNoOfHabs(rst.getInt(i));
	 		                   i++;
	 		                  }
		 		            
		 		              if(columns.contains("Census Plain Pop."))
		 		              {
		 		              	//System.out.println("CENSUS PLAIN------->"+rst.getInt(i));
		 		                rwsMaster.setCensusPop(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census SC Pop."))
		 		              {
		 		              	//System.out.println("CENSUS SC------->"+rst.getInt(i));
		 		                rwsMaster.setCensusSc(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census ST Pop."))
		 		              	{
		 		              	//System.out.println("CENSUS ST------->"+rst.getInt(i));
		 		              	rwsMaster.setCensusSt(rst.getInt(i));
		 		              	i++;
		 		              	}
		 		              if(columns.contains("Census Float Pop."))
		 		              {
		 		              	//System.out.println("CENSUS FLOAT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusFloat(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Total Population"))
		 		              {
		 		              	//System.out.println("CENSUS TOT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusTotal(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		               dlist.add(rwsMaster);
				             }
			     dropViews(rwsm.getDistCode());
				/*//System.out.println("DMP");
				String qry="select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,count(h.hab_code) ";
				String ord="";
				boolean added=true;
				boolean ordadded=false;
				if(columns.contains("Census Plain Pop."))
				       {
					     qry+=",";
					     qry+="sum(h.census_plain_popu)";
					     if(added)
					     {
					     	ord+="order by ";
					     }
					     if(ordadded)
					     	ord+=",";
					     ord+="sum(h.census_plain_popu)";
					     ordadded=true;
					     added=false;
					   }
					if(columns.contains("Census SC Pop."))
					   {
						 	qry+=",";
						qry+="sum(h.census_sc_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_sc_popu)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Census ST Pop."))
					   {
						qry+=",";
						qry+="sum(h.census_st_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_st_popu)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Census Float Pop."))
					   {
						qry+=",";
						qry+="sum(h.float_pop)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.float_pop)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Total Population"))
					   {
						qry+=",";
						qry+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop)";
						if(added)
						{
					     	ord+="order by";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop)";
						ordadded=true;
						added=false;
					   }

				qry+="from "+getHabDirTabName(rwsm.getDistCode())+" h,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p where substr(h.hab_code,1,2)='"+rwsm.getDistCode()+"' and d.dcode=m.dcode and substr(h.hab_code,6,2)='"+rwsm.getMandalCode()+"' and p.mcode=m.mcode and p.dcode=d.dcode and substr(h.hab_code,13,2)='"+rwsm.getPanchCode()+"'";
				
				if (rwsm.getCompl_stat().length!=0)
				{
					boolean check=false;
					String arr[]=rwsm.getCompl_stat();
					qry+=" and h.coverage_status IN ('";
					for (int i=0;i<arr.length;i++)
						{
						if (check)
							qry+=",'";
						qry+=arr[i]+"'";
						check=true;
						}
					qry+=")";
						}
				if (rwsm.getPrev_stat1().length!=0)
				{
					boolean check=false;
					String arr[]=rwsm.getPrev_stat1();
					qry+=" and h.previous_yr_status IN ('";
					//System.out.println("previous yr3");
					for (int i=0;i<arr.length;i++)
						{
						if (check)
							qry+=",'";
						qry+=arr[i]+"'";
						check=true;
						}
					qry+=")";
						}
				if(!(rwsm.getCp().equals("")))
				{
					qry+=" and h.census_plain_popu "+rwsm.getCp_condition()+""+rwsm.getCp()+"";
				}
				if(!(rwsm.getCsc().equals("")))
				{
					qry+=" and h.census_sc_popu "+rwsm.getCsc_condition()+""+rwsm.getCsc()+"";
				}
				if(!(rwsm.getCst().equals("")))
				{
					qry+=" and h.census_st_popu "+rwsm.getCst_condition()+""+rwsm.getCst()+"";
				}
				if(!(rwsm.getCtot().equals("")))
				{
					qry+=" and (h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop) "+rwsm.getCtot_condition()+""+rwsm.getCtot()+"";
				}
				if(!(rwsm.getFlopop1().equals("")))
				{
					qry+=" and h.float_pop "+rwsm.getFlopop_condition()+""+rwsm.getFlopop1()+"";
				}
				if(!((rwsm.getFloreason()).equals("")))
				{
					qry+=" and h.float_pop_reasons ='"+(rwsm.getFloreason()).toUpperCase()+"'";
				}
				if(!(rwsm.getTot_wat_supl().equals("")))
				{
					qry+=" and h.total_water_supply "+rwsm.getTot_wat_supl_condition()+""+rwsm.getTot_wat_supl()+"";
				}
				 if(!(rwsm.getExt_wat_lvl().equals("")))
				{
				 	qry+=" and h.exist_water_level "+rwsm.getExt_wat_lvl_condition()+""+rwsm.getExt_wat_lvl()+"";
				}
				 if(!(rwsm.getNear_surf_source().equals("")))
				{
				 	qry+=" and h.near_surface_source "+rwsm.getNear_surf_source_condition()+""+rwsm.getNear_surf_source()+"";
				}
				if(!(rwsm.getNear_ground_source().equals("")))
				{
					qry+=" and h.near_ground_source "+rwsm.getNear_ground_source_condition()+""+rwsm.getNear_ground_source()+"";
				}
				if(!(rwsm.getProp_year1().equals("")))
				{
					qry+=" and h.proposed_fc_year ='"+rwsm.getProp_year1()+"'";
				}
				if(!(rwsm.getAmnt_reqd1().equals("")))
				{
					qry+=" and h.proposed_fc_est_amt "+rwsm.getAmnt_reqd_condition()+""+rwsm.getAmnt_reqd1()+"";
				}
				qry+=" and d.dcode=m.dcode and d.dcode=p.dcode and p.mcode=m.mcode having d.dcode='"+rwsm.getDistCode()+"' and m.mcode='"+rwsm.getMandalCode()+"'and p.pcode='"+rwsm.getPanchCode()+"' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname "+ord+"";
			
			//System.out.println("QUERY IS:"+qry);
			pstmt=con.prepareStatement(qry);
			createViews(rwsm.getDistCode());
			rst=pstmt.executeQuery();
			int i=8;
			while(rst.next())
			                { 
				               rwsMaster = new RwsMaster();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		               rwsMaster.setMandalCode(rst.getString(3));
		 		               rwsMaster.setMandalName(rst.getString(4));
		 		               rwsMaster.setPanchCode(rst.getString(5));
		 		               rwsMaster.setPanchName(rst.getString(6));
		 		               rwsMaster.setNoOfHabs(rst.getInt(7));
		 		              if(columns.contains("Census Plain Pop."))
		 		              {
		 		              	//System.out.println("CENSUS PLAIN------->"+rst.getInt(i));
		 		                rwsMaster.setCensusPop(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census SC Pop."))
		 		              {
		 		              	//System.out.println("CENSUS SC------->"+rst.getInt(i));
		 		                rwsMaster.setCensusSc(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census ST Pop."))
		 		              	{
		 		              	//System.out.println("CENSUS ST------->"+rst.getInt(i));
		 		              	rwsMaster.setCensusSt(rst.getInt(i));
		 		              	i++;
		 		              	}
		 		              if(columns.contains("Census Float Pop."))
		 		              {
		 		              	//System.out.println("CENSUS FLOAT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusFloat(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Total Population"))
		 		              {
		 		              	//System.out.println("CENSUS TOT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusTotal(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		               dlist.add(rwsMaster);

		 		               dlist.add(rwsMaster);
				             }
			dropViews(rwsm.getDistCode());*/
		   }
			
			//FOR MANDAL
			else if (!(rwsm.getDistCode()==null) && !(rwsm.getDistCode().equals("")) && !(rwsm.getMandalCode()==null) && !(rwsm.getMandalCode().equals("")))
			{
				//System.out.println("DM");
				String qry="select d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname,count(h.hab_code) ";
				String ord="";
				boolean added=true;
				boolean ordadded=false;
				if(columns.contains("Census Plain Pop."))
				       {
					     qry+=",";
					     qry+="sum(h.census_plain_popu)";
					     if(added)
					     {
					     	ord+="order by ";
					     }
					     if(ordadded)
					     	ord+=",";
					     ord+="sum(h.census_plain_popu)";
					     ordadded=true;
					     added=false;
					   }
					if(columns.contains("Census SC Pop."))
					   {
						 	qry+=",";
						qry+="sum(h.census_sc_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_sc_popu)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Census ST Pop."))
					   {
						qry+=",";
						qry+="sum(h.census_st_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_st_popu)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Census Float Pop."))
					   {
						qry+=",";
						qry+="sum(h.float_pop)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.float_pop)";
						ordadded=true;
						added=false;
					   }
					if(columns.contains("Total Population"))
					   {
						qry+=",";
						qry+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
						if(added)
						{
					     	ord+="order by ";
						}
						if(ordadded)
					     	ord+=",";
						ord+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu)";
						ordadded=true;
						added=false;
					   }
				qry+="from "+getHabDirTabName(rwsm.getDistCode())+" h,rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_hab_supply_status_tbl hs where substr(h.hab_code,1,2)='"+rwsm.getDistCode()+"' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode=m.dcode and substr(h.hab_code,6,2)='"+rwsm.getMandalCode()+"' and h.hab_code=hs.hab_code(+) ";
				System.out.println("Query For Mandal "+qry);
				if (rwsm.getCompl_stat().length!=0)
				{
					boolean check=false;
					String arr[]=rwsm.getCompl_stat();
					qry+=" and h.coverage_status IN ('";
					for (int i=0;i<arr.length;i++)
						{
						if (check)
							qry+=",'";
						qry+=arr[i]+"'";
						check=true;
						}
					qry+=")";
						}
				if (rwsm.getPrev_stat1().length!=0)
				{
					boolean check=false;
					String arr[]=rwsm.getPrev_stat1();
					qry+=" and h.previous_yr_status IN ('";
					for (int i=0;i<arr.length;i++)
						{
						if (check)
							qry+=",'";
						qry+=arr[i]+"'";
						check=true;
						}
					qry+=")";
						}
				if(!(rwsm.getCp().equals("")))
				{
					qry+=" and h.census_plain_popu "+rwsm.getCp_condition()+""+rwsm.getCp()+"";
				}
				if(!(rwsm.getCsc().equals("")))
				{
					qry+=" and h.census_sc_popu "+rwsm.getCsc_condition()+""+rwsm.getCsc()+"";
				}
				if(!(rwsm.getCst().equals("")))
				{
					qry+=" and h.census_st_popu "+rwsm.getCst_condition()+""+rwsm.getCst()+"";
				}
				if(!(rwsm.getCtot().equals("")))
				{
					qry+=" and (h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop) "+rwsm.getCtot_condition()+""+rwsm.getCtot()+"";
				}
				if(!(rwsm.getFlopop1().equals("")))
				{
					qry+=" and h.float_pop "+rwsm.getFlopop_condition()+""+rwsm.getFlopop1()+"";
				}
				if(!((rwsm.getFloreason()).equals("")))
				{
					qry+=" and h.float_pop_reasons ='"+(rwsm.getFloreason()).toUpperCase()+"'";
				}
//				added by swapna
				if(!((rwsm.getHabType()).equals("")))
				{
					qry+=" and h.habitation_type ='"+(rwsm.getHabType()).toUpperCase()+"'";
				}
				if(!((rwsm.getHabSubType()).equals("")))
				{
					qry+=" and h.habitation_sub_type ='"+(rwsm.getHabSubType()).toUpperCase()+"'";
				}
				if(!((rwsm.getHabCat()).equals("")))
				{
					qry+=" and h.habitation_category ='"+(rwsm.getHabCat()).toUpperCase()+"'";
				}
				//
				if(!(rwsm.getTot_wat_supl().equals("")))
				{
					qry+=" and h.total_water_supply "+rwsm.getTot_wat_supl_condition()+""+rwsm.getTot_wat_supl()+"";
				}
				 if(!(rwsm.getExt_wat_lvl().equals("")))
				{
				 	qry+=" and h.exist_water_level "+rwsm.getExt_wat_lvl_condition()+""+rwsm.getExt_wat_lvl()+"";
				}
				 if(!(rwsm.getNear_surf_source().equals("")))
				{
				 	qry+=" and h.near_surface_source "+rwsm.getNear_surf_source_condition()+""+rwsm.getNear_surf_source()+"";
				}
				if(!(rwsm.getNear_ground_source().equals("")))
				{
					qry+=" and h.near_ground_source "+rwsm.getNear_ground_source_condition()+""+rwsm.getNear_ground_source()+"";
				}
				if(!(rwsm.getProp_year1().equals("")))
				{
					qry+=" and h.proposed_fc_year ='"+rwsm.getProp_year1()+"'";
				}
				if(!(rwsm.getAmnt_reqd1().equals("")))
				{
					qry+=" and h.proposed_fc_est_amt "+rwsm.getAmnt_reqd_condition()+""+rwsm.getAmnt_reqd1()+"";
				}
				qry+=" and d.dcode=m.dcode having d.dcode='"+rwsm.getDistCode()+"' and m.mcode='"+rwsm.getMandalCode()+"' group by d.dcode,d.dname,c.constituency_code,c.constituency_name,m.mcode,m.mname "+ord+"";
			
		Debug.println("Total QUERY IS:3-->"+qry);
			pstmt=con.prepareStatement(qry);
			createViews(rwsm.getDistCode());
			rst=pstmt.executeQuery();
			int i=8;
			while(rst.next())
			                { 
				               rwsMaster = new RwsMaster();
		 		               rwsMaster.setDistCode(rst.getString(1));
		 		               rwsMaster.setDistName4(rst.getString(2));
		 		               rwsMaster.setConstituencyCode(rst.getString(3));
		 		               rwsMaster.setConstituencyName(rst.getString(4).toUpperCase());
		 		               rwsMaster.setMandalCode(rst.getString(5));
		 		               rwsMaster.setMandalName(rst.getString(6));
		 		               rwsMaster.setNoOfHabs(rst.getInt(7));
		 		              if(columns.contains("Census Plain Pop."))
		 		              {
		 		              	//System.out.println("CENSUS PLAIN------->"+rst.getInt(i));
		 		                rwsMaster.setCensusPop(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census SC Pop."))
		 		              {
		 		              	//System.out.println("CENSUS SC------->"+rst.getInt(i));
		 		                rwsMaster.setCensusSc(rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Census ST Pop."))
		 		              	{
		 		              	 //System.out.println("CENSUS ST------->"+rst.getInt(i));
		 		              	rwsMaster.setCensusSt(rst.getInt(i));
		 		              	i++;
		 		              	}
		 		              if(columns.contains("Census Float Pop."))
		 		              {
		 		              	//System.out.println("CENSUS FLOAT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusFloat(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		              if(columns.contains("Total Population"))
		 		              {
		 		              	System.out.println("CENSUS TOT------->"+rst.getInt(i));
		 		                rwsMaster.setCensusTotal(""+rst.getInt(i));
		 		                i++;
		 		              }
		 		             if(columns.contains("Total Water Supply(Unsafe)(Unsafe)"))		 		             		
		 		             {
		 		              	//System.out.println("Total Water Supply(Unsafe) "+rst.getInt(i));
		 		                rwsMaster.setTot_wat_supl(""+rst.getInt(i));
		 		               // System.out.println("rwsMaster.getTot_wat_supl() "+rwsMaster.getTot_wat_supl());
		 		                i++;
		 		              }
		 		              
		 		               dlist.add(rwsMaster);

		 		           }
			dropViews(rwsm.getDistCode());
		   }
		   }
		catch(Exception e)
		   {
			//System.out.println(e.getMessage());
			}
		finally
		    {
			try {rst.close();
			     pstmt.close();
			     con.close();
				}
			catch(Exception e)
			     {
				 //System.out.println("Error in Closeing Connection...."); 
			     }
			 }
	return dlist;	
	}
	// END OF CONSOLIDATED REPORT FOR A PARTICULAR MANDAL,PANCHAYAT,VILLAGE
	

	public ArrayList masterDist()
	{   RwsMaster rwsMaster = null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	//String qry1="select d.dname,h.hab_code,p.panch_name from rws_habitation_directory_tbl h,rws_district_tbl d,rws_panchayat_raj_tbl p where substr(h.hab_code,1,2)='"+district+"' and d.dcode=substr(h.hab_code,1,2) and h.hab_code=p.panch_code";
 	String qry2="select dcode,dname from rws_district_tbl";
	pstmt=con.prepareStatement(qry2);
 	rst=pstmt.executeQuery();
 	while(rst.next())
 	{
 		rwsMaster = new RwsMaster();
 		rwsMaster.setDistCode(rst.getString(1));
 		rwsMaster.setDistName4(rst.getString(2));
 		dlist.add(rwsMaster);
 	} 
 	
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	//Master Mandal Details modifed by sridharConstituency
	public ArrayList masterMandal(String district)
	{   RwsMaster rwsMaster = null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	
 	//String qry3="select mcode,mname from rws_mandal_tbl where dcode='"+district+"'";
	String qry3="select c.constituency_code,c.constituency_name,m.mcode,m.mname from rws_mandal_tbl m,rws_constituency_tbl c where c.dcode=m.dcode and c.mcode=m.mcode and m.dcode='"+district+"' order by m.mcode";
	pstmt=con.prepareStatement(qry3);
	//System.out.println(qry3);
 	rst=pstmt.executeQuery();
 	while(rst.next())
 	{
 		rwsMaster = new RwsMaster();
 		rwsMaster.setConstituencyCode(rst.getString(1));
 		rwsMaster.setConstituencyName(rst.getString(2).toUpperCase());
 		rwsMaster.setMandalCode(rst.getString(3));
 		rwsMaster.setMandalName(rst.getString(4));
 		dlist.add(rwsMaster);
 	}
	}
 	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	//Master Panchayat Details
	public ArrayList masterPanchayat(String district,String mandal1)
	{   RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
 	//String qry1="select d.dname,h.hab_code,p.panch_name from rws_habitation_directory_tbl h,rws_district_tbl d,rws_panchayat_raj_tbl p where substr(h.hab_code,1,2)='"+district+"' and d.dcode=substr(h.hab_code,1,2) and h.hab_code=p.panch_code";
 	String qry3="select p.pcode,p.pname from rws_panchayat_tbl p, rws_mandal_tbl m where p.dcode=m.dcode and m.mcode=p.mcode and p.dcode='"+district+"' and  p.mcode='"+mandal1+"'";
 	pstmt=con.prepareStatement(qry3);
	rst=pstmt.executeQuery();
 	while(rst.next())
 	{
 		rwsMaster = new RwsMaster();
 		rwsMaster.setPanchCode(rst.getString(1));
 		rwsMaster.setPanchName(rst.getString(2));
 		dlist.add(rwsMaster);
 	}
 	
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;  
	}
	//modified by sridhar
	public ArrayList masterPanchayat1(String district,String mandal1)
	{   RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	con=RwsOffices.getConn();
	//String qry3="select m.mcode,m.mname,p.pcode,p.pname from rws_district_tbl d, rws_mandal_tbl m, rws_panchayat_tbl p where p.dcode='"+district+"' and d.dcode=m.dcode and d.dcode=p.dcode and m.dcode=p.dcode and m.mcode=p.mcode order by p.dcode,p.mcode,p.pcode";
	String qry3="select c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname from rws_district_tbl d, rws_constituency_tbl c,rws_mandal_tbl m, rws_panchayat_tbl p where p.dcode='"+district+"' and d.dcode=c.dcode and c.mcode=m.mcode and d.dcode=m.dcode and d.dcode=p.dcode and m.dcode=p.dcode and m.mcode=p.mcode order by p.dcode,p.mcode,p.pcode"; 
	pstmt=con.prepareStatement(qry3);
	rst=pstmt.executeQuery();
 	while(rst.next())
 	{
 		rwsMaster = new RwsMaster();
 		rwsMaster.setConstituencyCode(rst.getString(1));
 		rwsMaster.setConstituencyName(rst.getString(2).toUpperCase());
 		rwsMaster.setMandalCode(rst.getString(3));
 		rwsMaster.setMandalName(rst.getString(4));
 		rwsMaster.setPanchCode(rst.getString(5));
 		rwsMaster.setPanchName(rst.getString(6));
 		dlist.add(rwsMaster);
 	}
 	
	}
	catch (SQLException se)
	{
		//System.out.println(se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
	                   {
	                   }
	}
	return dlist;
	}
	
	
	
	
	
	//Master Village Details
	public ArrayList masterVillage(String district,String mandal1,String panch1)
	{
		RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	        con=RwsOffices.getConn();
			String qry3="select vcode,vname from rws_village_tbl where  dcode='"+district+"' and mcode='"+mandal1+"' and pcode='"+panch1+"'";
			pstmt=con.prepareStatement(qry3);
			rst=pstmt.executeQuery();
		 	while(rst.next())
		 	{
		 		rwsMaster = new RwsMaster();
		 		rwsMaster.setVillCode(rst.getString(1));
		 		rwsMaster.setVillName(rst.getString(2));
		 		dlist.add(rwsMaster);
		 	}
		    }
		catch(Exception e) 
		     {
			  //System.out.println(e.getMessage());
			 }
		finally
		      {
			  try 
			    {
			  	rst.close();
			  	pstmt.close();
			  	con.close();
			  	}
			   catch(Exception e)
			   {}
			  }
		return dlist;
	 }
	
	public ArrayList masterVillage1(String district,String mandal1)
	{
		RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	        con=RwsOffices.getConn();
			String qry3="select vcode,vname from rws_village_tbl where  dcode='"+district+"' and mcode='"+mandal1+"'";
			pstmt=con.prepareStatement(qry3);
			rst=pstmt.executeQuery();
		 	while(rst.next())
		 	{
		 		rwsMaster = new RwsMaster();
		 		rwsMaster.setVillCode(rst.getString(1));
		 		rwsMaster.setVillName(rst.getString(2));
		 		dlist.add(rwsMaster);
		 		
		 	}
		    }
		catch(Exception e) 
		     {
			  //System.out.println(e.getMessage());
			 }
		finally
		      {
			  try 
			    {
			  	rst.close();
			  	pstmt.close();
			  	con.close();
			  	}
			   catch(Exception e)
			   {}
			  }
		return dlist;
	 }
	
	
	//modified by sridhar
	public ArrayList masterVillage2(String district)
	{
		RwsMaster rwsMaster =null;
		ArrayList dlist=new ArrayList();
	try {	
	        con=RwsOffices.getConn();
			//String qry3="select m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where  d.dcode='"+district+"' and d.dcode=m.dcode and d.dcode=p.dcode and d.dcode=v.dcode and m.dcode=p.dcode and p.dcode=v.dcode and m.mcode=p.mcode and m.mcode=v.mcode and v.mcode=p.mcode and p.pcode=v.pcode order by m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname";
			String qry3="select c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname from rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where d.dcode='"+district+"' and d.dcode=m.dcode and d.dcode=p.dcode and d.dcode=v.dcode and m.dcode=p.dcode and p.dcode=v.dcode and m.mcode=p.mcode and m.mcode=v.mcode and v.mcode=p.mcode and p.pcode=v.pcode and d.dcode=c.dcode and c.mcode=m.mcode order by c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname";
	        pstmt=con.prepareStatement(qry3);
			rst=pstmt.executeQuery();
		 	while(rst.next())   
		 	{
		 		rwsMaster = new RwsMaster();
		 		rwsMaster.setConstituencyCode(rst.getString(1));
		 		rwsMaster.setConstituencyName(rst.getString(2).toUpperCase());
		 		rwsMaster.setMandalCode(rst.getString(3));
		 		rwsMaster.setMandalName(rst.getString(4));
		 		rwsMaster.setPanchCode(rst.getString(5));
		 		rwsMaster.setPanchName(rst.getString(6));
		 		rwsMaster.setVillCode(rst.getString(7));
		 		rwsMaster.setVillName(rst.getString(8));
		 		dlist.add(rwsMaster);
		 	}
		    }
		catch(Exception e) 
		     {
			  //System.out.println(e.getMessage());
			 }
		finally
		      {
			  try 
			    {
			  	rst.close();
			  	pstmt.close();
			  	con.close();
			  	}
			   catch(Exception e)
			   {}
			  }
		return dlist;
	 }
	
	
	//Master Habitations Details, Habitations under a village
	public ArrayList masterHabitation(String district,String mandal1,String panch1,String village1)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		try 
		  {
			con=RwsOffices.getConn();
			String qry3="select panch_code,panch_name from "+getPanchRajTabName(district)+" where substr(panch_code,1,2)='"+district+"' and substr(panch_code,6,2)='"+mandal1+"' and substr(panch_code,13,2)='"+panch1+"' and substr(panch_code,8,3)='"+village1+"'";
			pstmt=con.prepareStatement(qry3);
			createViews(district);
			rst=pstmt.executeQuery();
			while (rst.next())
			{
     			rwsMaster=new RwsMaster();
			    rwsMaster.setHabCode(rst.getString(1));
			    rwsMaster.setHabName(rst.getString(2));
			    dlist.add(rwsMaster);
			}
			dropViews(district);
		  }
		catch(Exception e)
		  {
			//System.out.println(e.getMessage());
		   }
		finally
		   {
			try 
			  {
				rst.close();
				pstmt.close();
				con.close();
			  }
			catch(Exception e)
			  {
				//System.out.println("Error In Closing Connection...");
			  }
			}
		return dlist;
	}
	
	//habitations under a panchayat
	public ArrayList masterHabitation1(String district,String mandal1,String panch1)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		try 
		  {
			con=RwsOffices.getConn();
			String qry3="select panch_code,panch_name from "+getPanchRajTabName(district)+" where substr(panch_code,1,2)='"+district+"' and substr(panch_code,6,2)='"+mandal1+"' and substr(panch_code,13,2)='"+panch1+"'";
			pstmt=con.prepareStatement(qry3);
			createViews(district);
			rst=pstmt.executeQuery();
			while (rst.next())
			{
     			rwsMaster=new RwsMaster();
			    rwsMaster.setHabCode(rst.getString(1));
			    rwsMaster.setHabName(rst.getString(2));
			    dlist.add(rwsMaster);
			}
			dropViews(district);
		  }
		catch(Exception e)
		  {
			//System.out.println(e.getMessage());
		   }
		finally
		   {
			try 
			  {
				rst.close();
				pstmt.close();
				con.close();
			  }
			catch(Exception e)
			  {
				//System.out.println("Error In Closing Connection...");
			  }
			}
		return dlist;
	}
	//Habitations under a Mandal
	public ArrayList masterHabitation2(String district,String mandal1)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		try 
		  {
			con=RwsOffices.getConn();
			String qry3="select panch_code,panch_name from "+getPanchRajTabName(district)+" where substr(panch_code,1,2)='"+district+"' and substr(panch_code,6,2)='"+mandal1+"'";
			pstmt=con.prepareStatement(qry3);
			createViews(district);
			rst=pstmt.executeQuery();
			while (rst.next())
			{
     			rwsMaster=new RwsMaster();
			    rwsMaster.setHabCode(rst.getString(1));
			    rwsMaster.setHabName(rst.getString(2));
			    dlist.add(rwsMaster);
			}
			dropViews(district);
		  }
		catch(Exception e)
		  {
			//System.out.println(e.getMessage());
		   }
		finally
		   {
			try 
			  {
				rst.close();
				pstmt.close();
				con.close();
			  }
			catch(Exception e)
			  {
				//System.out.println("Error In Closing Connection...");
			  }
			}
		return dlist;
	}
	//Habitations under a District  modified by sridhar
	public ArrayList masterHabitation3(String district)
	{
		RwsMaster rwsMaster=null;
		ArrayList dlist=new ArrayList();
		try   
		  {
			con=RwsOffices.getConn();
			//String qry3="select m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,praj.panch_code,praj.panch_name from rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,"+getPanchRajTabName(district)+" praj where m.dcode=p.dcode and m.dcode='"+district+"' and m.mcode=p.pcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and v.dcode=substr(praj.panch_code,1,2) and v.mcode=substr(praj.panch_code,6,2) and v.pcode=substr(praj.panch_code,13,2) and v.vcode=substr(praj.panch_code,8,3) order by m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,praj.panch_code,praj.panch_name";
			String qry3="select c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,praj.panch_code,praj.panch_name from rws_constituency_tbl c,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,"+getPanchRajTabName(district)+" praj where m.dcode=c.dcode and c.mcode=m.mcode and m.dcode=p.dcode and m.dcode='"+district+"' and m.mcode=p.pcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and v.dcode=substr(praj.panch_code,1,2) and v.mcode=substr(praj.panch_code,6,2) and v.pcode=substr(praj.panch_code,13,2) and v.vcode=substr(praj.panch_code,8,3) order by c.constituency_code,c.constituency_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,praj.panch_code,praj.panch_name";
			pstmt=con.prepareStatement(qry3);
			createViews(district);
			rst=pstmt.executeQuery();
			while (rst.next())
			{
     			rwsMaster=new RwsMaster();
     			rwsMaster.setConstituencyCode(rst.getString(1));
			    rwsMaster.setConstituencyName(rst.getString(2).toUpperCase());
     			rwsMaster.setMandalCode(rst.getString(3));
			    rwsMaster.setMandalName(rst.getString(4));
			    rwsMaster.setPanchCode(rst.getString(5));
			    rwsMaster.setPanchName(rst.getString(6));
			    rwsMaster.setVillCode(rst.getString(7));
			    rwsMaster.setVillName(rst.getString(8));
			    rwsMaster.setHabCode(rst.getString(9));
			    rwsMaster.setHabName(rst.getString(10));
			    dlist.add(rwsMaster);
			}
			dropViews(district);
		  }
		catch(Exception e)
		  {
			//System.out.println(e.getMessage());
		   }
		finally
		   {
			try 
			  {
				rst.close();
				pstmt.close();
				con.close();
			  }
			catch(Exception e)
			  {
				//System.out.println("Error In Closing Connection...");
			  }
			}
		return dlist;
	}
	
	
	//Detail Report Begins Here.
	public String queryGenerator(ArrayList columns,RwsMaster rwsm)
	{
		RwsMaster rwsMaster = null;
		boolean added_one_element=false;
		boolean after_where_added=false;
		String 	qry3="select distinct ";
		String grp="";
		boolean grp_added=false;
		try {	
		con=RwsOffices.getConn();
		/*if(columns.contains("District"))
		{*///Debug.println("qry gerator 1");
			if (added_one_element)
			qry3+=",";
			qry3+="d.dcode,d.dname";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="d.dcode,d.dname";
			grp_added=true;
			
		//}
			//Debug.println("qry gerator 2");
			if(columns.contains("Constituency"))
			{
				//Debug.println("qry gerator3");
				if (added_one_element)
				qry3+=",";
				qry3+="c.constituency_code,c.constituency_name";
				added_one_element=true;
				if(grp_added==false)
				{
			     	grp+="group by ";
				}
				if(grp_added)
			     	grp+=",";
				grp+="c.constituency_code,c.constituency_name";
				grp_added=true;
			}
		if(columns.contains("Mandal"))
		{
			//Debug.println("qry gerator3.1");
			if (added_one_element)
			qry3+=",";
			qry3+="m.mcode,m.mname";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="m.mcode,m.mname";
			grp_added=true;
		}
		if(columns.contains("Panchayat"))
		{
			//Debug.println("qry gerator 4");
			if (added_one_element)
			qry3+=",";
			qry3+="panch.pcode,panch.pname";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="panch.pcode,panch.pname";
			grp_added=true;
		}
		if(columns.contains("Village"))
		{
			//Debug.println("qry gerator 5");
			if (added_one_element)
			qry3+=",";
			qry3+="v.vcode,v.vname";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="v.vcode,v.vname";
			grp_added=true;
		}	
		if(columns.contains("Habitation"))
		{
			//Debug.println("habitation"+columns.contains("Habitation"));
			//Debug.println("qry gerator 6");
			if (added_one_element)
			qry3+=",";
			qry3+="h.hab_code,p.panch_name";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.hab_code,p.panch_name";
			grp_added=true;
		}
//		code added by pranavi
		if(columns.contains("Habitation Type")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.habitation_type";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.habitation_type";
			grp_added=true;
		}
		if(columns.contains("Habitation Sub Type")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.habitation_sub_type";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.habitation_sub_type";
			grp_added=true;
		}
		if(columns.contains("Habitation Category")){
			if (added_one_element)
				qry3+=",";
			qry3+="h.habitation_category";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.habitation_category";
			grp_added=true;
		}
//		if(columns.contains("Exist Water Level"))
		if(columns.contains("LPCD (Safe Supply)"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.exist_water_level";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.exist_water_level";
			grp_added=true;
		}
		if(columns.contains("Update Date"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="to_char(h.update_date,'dd-mm-yyyy') as udate";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="to_char(h.update_date,'dd-mm-yyyy')";
			grp_added=true;
		}
		if(columns.contains("Prev Yr Status"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.previous_yr_status";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.previous_yr_status";
			grp_added=true;
		}
		if(columns.contains("Present Yr Status"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.coverage_status";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.coverage_status";
			grp_added=true;
		}
		//code for reasons slippage

		if(columns.contains("Reasons for Slippage"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="decode(nvl(h.slippage_code,'0'),'0033','Increase in population-Migration','0035','Drying up of sources','0036','Due to Water Quality problems','0037','Poor Operation and Maintenance','0038','Seasonal slippage (Temporary)','0039','Less Supply (at PWS delivery points)','0043','Age of systems','0045','Shortage of electricity','0','-') as slipage_code";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.slippage_code";
			grp_added=true;
		}
		if(columns.contains("Census Year"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.census_year";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.census_year";
			grp_added=true;
		}
		if(columns.contains("Census Plain Pop."))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.census_plain_popu";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.census_plain_popu";
			grp_added=true;
		}
		if(columns.contains("Census SC Pop"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.census_sc_popu";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.census_sc_popu";
			grp_added=true;
		}
		if(columns.contains("Census ST Pop"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.census_st_popu";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.census_st_popu";
			grp_added=true;
		}
		if(columns.contains("Floationg Pop"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.float_pop";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.float_pop";
			grp_added=true;
		}
		if(columns.contains("Reason for Floating Pop."))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.float_pop_reasons";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.float_pop_reasons";
			grp_added=true;
		}
		if(columns.contains("Status Date"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="to_char(h.status_date,'dd-mm-yyyy') as stdate";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="to_char(h.status_date,'dd-mm-yyyy')";
			grp_added=true;
		}
		if(columns.contains("Plain Pop. Covered"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.plain_popu_covered";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.plain_popu_covered";
			grp_added=true;
		}
		if(columns.contains("SC Pop. Covered"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.sc_pop_covered";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.sc_pop_covered";
			grp_added=true;
		}
		if(columns.contains("ST Pop. Covered"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.st_pop_covered";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.st_pop_covered";
			grp_added=true;
		}
		if(columns.contains("Total Population"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu) as totpop";
			added_one_element=true;
		}
		if(columns.contains("Coverage Status"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.coverage_status";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.coverage_status";
			grp_added=true;
		}
		
		
		if(columns.contains("Near Surface Source"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.near_surface_source";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.near_surface_source";
			grp_added=true;
		}
		if(columns.contains("Near Ground Source"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.near_ground_source";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.near_ground_source";
			grp_added=true;
		}
		//code for no.of households,no of cattles,no of existing sources,no of safe sources
		
		if(columns.contains("No Of HouseHolds"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.household_no";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.household_no";
			grp_added=true;
		}
		
		if(columns.contains("No Of HouseConnections"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.NO_OF_HOUSECONN_GIVEN";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.NO_OF_HOUSECONN_GIVEN";
			grp_added=true;
		}
		
		
		
		
		if(columns.contains("No Of Cattles"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.no_of_cattle";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.no_of_cattle";
			grp_added=true;
		}
		if(columns.contains("No Of Existing Sources"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.existing_sources_no";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.existing_sources_no";
			grp_added=true;
		}
		if(columns.contains("No Of Safe Sources"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.safe_sources_no";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.safe_sources_no";
			grp_added=true;
		}
		if(columns.contains("Remarks"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.remarks";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.remarks";
			grp_added=true;
		}
		if(columns.contains("Quality Affected"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.quality_affected";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.quality_affected";
			grp_added=true;
		}
		//code for nearest avaialble source, distance from households
		if(columns.contains("Nearest Available Source"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="decode(h.nc_source_type,'','-','1','Spring','2','Dug well','3','Ponds','4','River','5','Stream','6','Distant Govt.Source.(any)') as nc_source_type";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.nc_source_type";
			grp_added=true;
		}
		if(columns.contains("Distance From HouseHolds"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="decode(h.source_distance,'','-','1','less than 50','2','50-100','3','101-200','4','201-500','5','500-1600','6','Greater than 1600') as source_distance";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.source_distance";
			grp_added=true;
		}
		if(columns.contains("Prop FC Year"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.proposed_fc_year";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.proposed_fc_year";
			grp_added=true;
		}
		if(columns.contains("Prop FC Amnt"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="h.proposed_fc_est_amt";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="h.proposed_fc_est_amt";
			grp_added=true;
		}
		
		if(columns.contains("Total Water Supply(Unsafe)"))
		{
			if (added_one_element)
			qry3+=",";
			//qry3+="h.total_water_supply";
			//code added for calculating Total Water Supply(Unsafe) by vikas
			//qry3+=" (decode(h.coverage_status,'NSS',HPS_OTH_SUPPLY,'0')+nvl(PWS_UNSAFE_SUPPLY,'0')+nvl(MPWS_UNSAFE_SUPPLY,'0')+nvl(OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl (OTHERS_SUPPLY,'0')) as Unsafe";
			//round((nvl(HPS_OTH_SUPPLY,'0')+ nvl (PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')+nvl (OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl (OTHERS_SUPPLY,'0'))/((nvl (CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl (CENSUS_ST_POPU,'0')+nvl (FLOAT_POP,'0')+.0001)*POWER(1.02,6)),2)
			//query modified by pranavi for pws unsafe ,mpws unsafe
			qry3+=" (nvl(HPS_OTH_SUPPLY_UNSAFE,'0')+nvl(PWS_UNSAFE_SUPPLY,'0')+nvl(MPWS_UNSAFE_SUPPLY,'0')+nvl(OWS_OTH_SUPPLY,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl(OTHERS_SUPPLY,'0')) as Unsafe";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+=" PWS_UNSAFE_SUPPLY,MPWS_UNSAFE_SUPPLY,HPS_OTH_SUPPLY_UNSAFE,OWS_OTH_SUPPLY ,PONDS_OTH_SUPPLY,SHP_DK_SUPPLY,OTHERS_SUPPLY ";
			grp_added=true;
		}
		if(columns.contains("Total Water Supply(Safe)"))
		{
			if (added_one_element)
			qry3+=",";
			//qry3+="h.total_water_supply";
			//code added for calculating Total Water Supply(Unsafe) by vikas
			//qry3+=" (decode(h.coverage_status,'NSS','0',HPS_OTH_SUPPLY)+ nvl(PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')) as Safe";
			//round((nvl(HPS_OTH_SUPPLY,'0')+ nvl (PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')+nvl (OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl (OTHERS_SUPPLY,'0'))/((nvl (CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl (CENSUS_ST_POPU,'0')+nvl (FLOAT_POP,'0')+.0001)*POWER(1.02,6)),2)
			
//			query modified by pranavi for HPS_OTH_SUPPLY,OTHERS_SUPPLY_SAFE
			qry3+=" (nvl(HPS_OTH_SUPPLY,'0')+nvl(PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(cpws_supply,'0')+nvl(OTHERS_SUPPLY_SAFE,'0')) as Safe";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+=" HPS_OTH_SUPPLY,PWS_SUPPLY,MPWS_SUPPLY,CPWS_SUPPLY,OTHERS_SUPPLY_SAFE ";
			grp_added=true;
		}
		if(columns.contains("Minority"))
		{

			if (added_one_element)
			qry3+=",";
			qry3+=" nvl(decode(MINORITY_DOMINATED,'Y','Yes'),'No') as MINORITY_DOMINATED";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+=" MINORITY_DOMINATED";
			grp_added=true;
		
		}
		if(columns.contains("LWE/Naxal"))
		{

			if (added_one_element)
			qry3+=",";
			qry3+=" nvl(decode(LWE,'Y','Yes'),'No') as LWE";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+=" LWE";
			grp_added=true;
		}
		if(columns.contains("LPCD(UnSafe)"))
		{

			if (added_one_element)
			qry3+=",";
			qry3+=" nvl(UNSAFE_LPCD,'0') as UNSAFE_LPCD";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+=" UNSAFE_LPCD";
			grp_added=true;
		}
		if(columns.contains("LPCD(Cooking)"))
		{

			if (added_one_element)
			qry3+=",";
			qry3+=" nvl(LPCD_COOKING,'0') as LPCD_COOKING";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+=" LPCD_COOKING";
			grp_added=true;
		}
		
		if(columns.contains("TSP(ITDA)"))
		{

			if (added_one_element)
			qry3+=",";
			qry3+=" nvl(TSP_NTSP,'-') as TSP_NTSP";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+=" TSP_NTSP";
			grp_added=true;
		}
		//////////////////////////Gis Information/////
		if(columns.contains("LATITUDE"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="g.LATITUDE ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="g.LATITUDE";
			grp_added=true;
		}
		if(columns.contains("LONGITUDE"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="g.LONGITUDE ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="g.LONGITUDE";
			grp_added=true;
		}if(columns.contains("ELEVATION"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="g.ELEVATION ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="g.ELEVATION ";
			grp_added=true;
		}if(columns.contains("WAY_POINT"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="g.WAY_POINT  ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="g.WAY_POINT";
			grp_added=true;
		}if(columns.contains("LANDMARK"))
		{
			if (added_one_element)
				qry3+=",";
			qry3+="g.LANDMARK ";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		     	grp+=",";
			grp+="g.LANDMARK";
			grp_added=true;
		}
			
///////////////added on 08/10/14 by jyothi	///////////////////////////
	if(columns.contains("PUBLICTAP"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.NO_OF_PUBLIC_TAPS";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.NO_OF_PUBLIC_TAPS";
		grp_added=true;
	}
	
	if(columns.contains("PUBLICSTANDPOST"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.NO_OF_TAPS_WITH_STANDPOSTS";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.NO_OF_TAPS_WITH_STANDPOSTS";
		grp_added=true;
	}

	if(columns.contains("EXISTCHECKDAM"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.NO_CHECKDAMS_EXIST";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.NO_CHECKDAMS_EXIST";
		grp_added=true;
	}
	
	
	if(columns.contains("REQCHECKDAM"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.NO_CHECKDAMS_REQ";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.NO_CHECKDAMS_REQ";
		grp_added=true;
	}
	
		//////////////////////////////////////////////////////////////////
		
		
		
		
	/*	if(columns.contains("LPCD"))
		{
			if (added_one_element)
			qry3+=",";
			qry3+=" round((decode(h.coverage_status,'NSS','0',HPS_OTH_SUPPLY)+nvl(PWS_SUPPLY,0)+nvl(MPWS_SUPPLY,0)+nvl(CPWS_SUPPLY,0))/((h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop)*power(1.01,8)),2) as LPCD_safe";
			added_one_element=true;
			if(grp_added==false)
			{
		     	grp+="group by ";
			}
			if(grp_added)
		    grp+=",";
			grp+=" HPS_OTH_SUPPLY,PWS_SUPPLY,MPWS_SUPPLY,CPWS_SUPPLY ";
			grp_added=true;
		}*///	Debug.println("qry gerator 7");
		qry3+=" from "+getHabDirTabName(rwsm.getDistCode())+" h,"+getPanchRajTabName(rwsm.getDistCode())+" p,rws_district_tbl d,rws_constituency_tbl c,rws_mandal_tbl m,rws_village_tbl v,rws_panchayat_tbl panch,rws_hab_supply_status_tbl hp ,rws_panchayat_raj_tbl g where ";
		
		//if(columns.contains("District") || columns.contains("Mandal") || columns.contains("Panchayat") || columns.contains("Village"))
		if(columns.contains("District"))
		{//Debug.println("qry gerator 8");
			if(after_where_added)
				qry3+=" and";
			qry3+=" d.dcode=substr(h.hab_code,1,2) and d.dcode=substr(p.panch_code,1,2) and substr(h.hab_code,1,2)=substr(p.panch_code,1,2) and d.dcode=m.dcode and d.dcode=panch.dcode and d.dcode=v.dcode and m.dcode=panch.dcode and m.dcode=v.dcode and panch.dcode=v.dcode and m.mcode=substr(h.hab_code,6,2) and m.mcode=substr(p.panch_code,6,2) and substr(h.hab_code,6,2)=substr(p.panch_code,6,2) and m.mcode=panch.mcode and m.mcode=v.mcode and panch.mcode=v.mcode and panch.pcode=substr(h.hab_code,13,2) and panch.pcode=substr(p.panch_code,13,2) and substr(h.hab_code,13,2)=substr(p.panch_code,13,2) and panch.pcode=v.pcode and v.vcode=substr(h.hab_code,8,3) and v.vcode=substr(p.panch_code,8,3) and substr(h.hab_code,8,3)=substr(p.panch_code,8,3)  ";
			after_where_added=true;
		}
		if(columns.contains("Constituency"))
		{//Debug.println("qry gerator 8.1");
			if(after_where_added)
				qry3+=" and";
			qry3+=" d.dcode=c.dcode and c.mcode=m.mcode ";
			after_where_added=true;
		}
		if(columns.contains("Habitation"))
		{
			//Debug.println("qry gerator 9");
		//	Debug.println("Coulememe "+columns.contains("Habitation"));
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.hab_code = p.panch_code and hp.hab_code(+)=h.hab_code ";
			after_where_added=true;
		}	
		if(columns.contains("EXISTCHECKDAM") || columns.contains("REQCHECKDAM") || columns.contains("PUBLICTAP") || columns.contains("PUBLICSTANDPOST") || columns.contains("LATITUDE") || columns.contains("LONGITUDE") || columns.contains("ELEVATION")  ||columns.contains("WAY_POINT") ||  columns.contains("LANDMARK") )
		{	//Debug.println("qry gerator 9");
		//	Debug.println("Coulememe "+columns.contains("Habitation"));
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.hab_code = g.panch_code ";
			after_where_added=true;
		}	
		
		if (rwsm.getCompl_stat().length!=0)
		{
			boolean check=false;
			if(after_where_added)
			qry3+=" and";
			String arr[]=rwsm.getCompl_stat();
			qry3+=" h.coverage_status IN ('";
			for (int i=0;i<arr.length;i++)
			{
					if (check)
					qry3+=",'";
					qry3+=arr[i]+"'";
			    	check=true;
				}
				qry3+=")";
			after_where_added=true;
		}
		if (rwsm.getPrev_stat1().length!=0)
		{
			boolean check=false;
			if(after_where_added)
				qry3+=" and";
			String arr[]=rwsm.getPrev_stat1();
			qry3+=" h.previous_yr_status IN ('";
			//System.out.println("previous yr4");
			for (int i=0;i<arr.length;i++)
				{
					if (check)
					qry3+=",'";
					qry3+=arr[i]+"'";
			    	check=true;
				}
				qry3+=")";
			after_where_added=true;
		}
		
		if(!(rwsm.getCp().equals("")))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.census_plain_popu "+rwsm.getCp_condition()+""+rwsm.getCp()+"";
			after_where_added=true;
		}
		if(!(rwsm.getCsc().equals("")))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.census_sc_popu "+rwsm.getCsc_condition()+""+rwsm.getCsc()+"";
			after_where_added=true;
		}
		if(!(rwsm.getCst().equals("")))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.census_st_popu "+rwsm.getCst_condition()+""+rwsm.getCst()+"";
			after_where_added=true;
		}
		if(!(rwsm.getCtot().equals("")))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" (h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop) "+rwsm.getCtot_condition()+""+rwsm.getCtot()+"";
			after_where_added=true;
		}
		if(!(rwsm.getFlopop1().equals("")))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.float_pop "+rwsm.getFlopop_condition()+""+rwsm.getFlopop1()+"";
			after_where_added=true;
		}
		if(!((rwsm.getFloreason()).equals("")))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.float_pop_reasons ='"+(rwsm.getFloreason()).toUpperCase()+"'";
			after_where_added=true;
		}
		if(!(rwsm.getTot_wat_supl().equals("")))
		{
			if(after_where_added)
			qry3+=" and";		
			double lpcdval=0;
			//lpcdval=countLpcd(rwsm.getHab_code());
	        //commented and qry3 is modified  
			//qry3+=" (decode(h.coverage_status,'NSS','0',HPS_OTH_SUPPLY)+nvl(PWS_SUPPLY,0)+nvl(MPWS_SUPPLY,0)+nvl(CPWS_SUPPLY,0)) "+rwsm.getTot_wat_supl_condition()+""+rwsm.getTot_wat_supl()+" ";
			qry3+=" (nvl(HPS_OTH_SUPPLY,'0')+nvl(PWS_SUPPLY,0)+nvl(MPWS_SUPPLY,0)+nvl(CPWS_SUPPLY,0)+nvl(OTHERS_SUPPLY_SAFE,'0')) "+rwsm.getTot_wat_supl_condition()+""+rwsm.getTot_wat_supl()+" ";
			after_where_added=true;
			if(grp_added)
			    grp+=",";
				grp+=" HPS_OTH_SUPPLY,PWS_SUPPLY,MPWS_SUPPLY,CPWS_SUPPLY ";
			grp_added=true;
		}
		 if(!(rwsm.getExt_wat_lvl().equals("")))
		{
		 	if(after_where_added)
				qry3+=" and";
		 	qry3+=" h.exist_water_level "+rwsm.getExt_wat_lvl_condition()+""+rwsm.getExt_wat_lvl()+"";
		 	after_where_added=true;
		}
		 if(!(rwsm.getNear_surf_source().equals("")))
		{
		 	if(after_where_added)
				qry3+=" and";
		 	qry3+=" h.near_surface_source "+rwsm.getNear_surf_source_condition()+""+rwsm.getNear_surf_source()+"";
		 	after_where_added=true;
		}
		if(!(rwsm.getNear_ground_source().equals("")))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.near_ground_source "+rwsm.getNear_ground_source_condition()+""+rwsm.getNear_ground_source()+"";
			after_where_added=true;
		}
		if(!(rwsm.getProp_year1().equals("")))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.proposed_fc_year ='"+rwsm.getProp_year1()+"'";
			after_where_added=true;
		}
		if(!(rwsm.getAmnt_reqd1().equals("")))
		{
			if(after_where_added)
				qry3+=" and";
			qry3+=" h.proposed_fc_est_amt "+rwsm.getAmnt_reqd_condition()+""+rwsm.getAmnt_reqd1()+"";
			after_where_added=true;
		}
		if (!(rwsm.getDistCode().equals("")) && !(rwsm.getDistCode().equals("ALL")))
		{
			if (!(rwsm.getDistCode().equals("")))
			{
				//System.out.println("district added");
				//Debug.println("qry gerator 10");
				if(after_where_added)
					qry3+=" and";
				//qry3+=" d.dcode='"+rwsm.getDistCode()+"' and substr(h.hab_code,1,2)='"+rwsm.getDistCode()+"' and substr(h.hab_code,1,2)=d.dcode and p.panch_code=h.hab_code and m.dcode='"+rwsm.getDistCode()+"' and d.dcode=m.dcode and d.dcode=panch.dcode and d.dcode=v.dcode and m.dcode=d.dcode and m.dcode=panch.dcode and m.dcode=v.dcode and panch.dcode='"+rwsm.getDistCode()+"' and panch.dcode=d.dcode and panch.dcode=m.dcode and panch.dcode=v.dcode and v.dcode='"+rwsm.getDistCode()+"' and v.dcode=d.dcode and v.dcode=m.dcode and v.dcode=panch.dcode";
				qry3+=" d.dcode='"+rwsm.getDistCode()+"'";
				after_where_added=true;
			}
			
			
			if (!(rwsm.getMandalCode().equals("")))
			{
				//Debug.println("qry gerator 11");
				//System.out.println("mandal added");
				if(after_where_added)
					qry3+=" and";
				//qry3+="  m.mcode='"+rwsm.getMandalCode()+"' and substr(h.hab_code,6,2)='"+rwsm.getMandalCode()+"'and substr(h.hab_code,6,2)=m.mcode and p.panch_code=h.hab_code and m.mcode=panch.mcode and m.mcode=v.mcode and panch.mcode='"+rwsm.getMandalCode()+"'and panch.mcode=m.mcode and panch.mcode=v.mcode and v.mcode='"+rwsm.getMandalCode()+"'and v.mcode=m.mcode and v.mcode=panch.mcode";
				qry3+="  m.mcode='"+rwsm.getMandalCode()+"'";
				after_where_added=true;
			}
			
			if (!(rwsm.getPanchCode().equals("")))
			{
				//System.out.println("Panchayat added");
				if(after_where_added)
					qry3+=" and";
			//	qry3+=" panch.pcode='"+rwsm.getPanchCode()+"' and substr(h.hab_code,13,2)='"+rwsm.getPanchCode()+"'and substr(h.hab_code,13,2)=panch.pcode and p.panch_code=h.hab_code and panch.pcode='"+rwsm.getPanchCode()+"'and panch.pcode=v.pcode and v.pcode='"+rwsm.getPanchCode()+"' and v.pcode=panch.pcode";
				qry3+=" panch.pcode='"+rwsm.getPanchCode()+"'";
				after_where_added=true;
			}
			
			if (!(rwsm.getVillCode().equals("")))
			{
				//System.out.println("village added");
				if(after_where_added)
					qry3+=" and";
				//qry3+=" v.vcode='"+rwsm.getVillCode()+"' and substr(h.hab_code,8,3)='"+rwsm.getVillCode()+"' and substr(h.hab_code,8,3)=v.vcode and p.panch_code=h.hab_code and v.vcode='"+rwsm.getVillCode()+"'";
				qry3+=" v.vcode='"+rwsm.getVillCode()+"'";
				after_where_added=true;
			}
			if (!(rwsm.getHabcode().equals("")))
			{
				//System.out.println("Habitation added");
				if(after_where_added)
					qry3+=" and";
				qry3+=" h.hab_code='"+rwsm.getHabcode()+"'";
				after_where_added=true;
			}
		}//Debug.println("qry gerator 13" +qry3);
		qry3+=" and d.dcode=c.dcode and c.mcode=m.mcode and d.dcode=m.dcode and m.dcode=panch.dcode and m.mcode =panch.mcode and panch.dcode=v.dcode and panch.mcode=v.mcode and panch.pcode=v.pcode  and h.hab_code=p.panch_code and substr(p.panch_code,1,2)=v.dcode and substr(p.panch_code,6,2)=v.mcode and substr(p.panch_code,13,2)=v.pcode and substr(p.panch_code,8,3)=v.vcode and (h.coverage_status is not null and h.coverage_status<>'UI') "+grp+" ";
		//qry3+=" and substr(h.hab_code,1,2)=d.dcode and p.panch_code=h.hab_code 	and d.dcode=m.dcode and d.dcode=panch.dcode and d.dcode=v.dcode and m.dcode=d.dcode and m.dcode=panch.dcode and m.dcode=v.dcode and panch.dcode=d.dcode and panch.dcode=m.dcode and panch.dcode=v.dcode and v.dcode=d.dcode and v.dcode=m.dcode and v.dcode=panch.dcode and substr(h.hab_code,6,2)=m.mcode and p.panch_code=h.hab_code and m.mcode=panch.mcode and m.mcode=v.mcode and panch.mcode=m.mcode and panch.mcode=v.mcode and v.mcode=m.mcode and v.mcode=panch.mcode and substr(h.hab_code,13,2)=panch.pcode and p.panch_code=h.hab_code and panch.pcode=v.pcode and v.pcode=panch.pcode and substr(h.hab_code,8,3)=v.vcode and p.panch_code=h.hab_code "+grp+"";
	//	qry3+=" and substr(h.hab_code,1,2)=d.dcode and p.panch_code=h.hab_code and d.dcode=m.dcode and d.dcode=panch.dcode and d.dcode=v.dcode and m.dcode=panch.dcode and m.dcode=v.dcode and panch.dcode=d.dcode and panch.dcode=v.dcode and v.dcode=d.dcode and v.dcode=m.dcode and substr(h.hab_code,6,2)=m.mcode and m.mcode=panch.mcode and m.mcode=v.mcode and panch.mcode=v.mcode and v.mcode=m.mcode and substr(h.hab_code,13,2)=panch.pcode and panch.pcode=v.pcode and substr(h.hab_code,8,3)=v.vcode "+grp+"";	
		Debug.println("qry3-----> "+qry3);
	//Debug.println("habcode is "+rwsm.getHabcode());
}
catch(Exception e)
 {
	//System.out.println("ERROR IN QUERYGENERATOR:"+e.getMessage());
 }
return qry3;
}
	
	
	//Second Query Generator
	
	
	
	public String queryGenerator1(ArrayList columns,RwsMaster rwsm)
	{   RwsMaster rwsMaster = null;
		boolean added_one_element=false;
		boolean after_where_added=false;
		boolean order_by_added=false;
		String ord=" order by ";
		String 	qry3="select distinct ";
		String grp="";
		boolean grp_added=false;
		
	try {	
	con=RwsOffices.getConn();
	
	if(columns.contains("District"))
	{
		if (added_one_element)
		qry3+=",";
		qry3+="d.dcode,d.dname";
		added_one_element=true;
		if(order_by_added)
		ord+=",";
		ord+="d.dcode";
		order_by_added=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="d.dcode,d.dname";
		grp_added=true;
	}
	if(columns.contains("Mandal"))
	{
		if (added_one_element)
		qry3+=",";
		qry3+="m.mcode,m.mname";
		added_one_element=true;
		if(order_by_added)
		ord+=",";
		ord+="m.mcode";
		order_by_added=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="m.mcode,m.mname";
		grp_added=true;
	}
	if(columns.contains("Panchayat"))
	{
		if (added_one_element)
		qry3+=",";
		qry3+="panch.pcode,panch.pname";
		added_one_element=true;
		if(order_by_added)
		ord+=",";
		ord+="panch.pcode";
		order_by_added=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="panch.pcode,panch.pname";
		grp_added=true;
	}
	if(columns.contains("Village"))
	{
		if (added_one_element)
		qry3+=",";
		qry3+="v.vcode,v.vname";
		added_one_element=true;
		if(order_by_added)
		ord+=",";
		ord+="v.vcode";
		order_by_added=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="v.vcode,v.vname";
		grp_added=true;
	}	
	if(columns.contains("Habitation"))
	{
		if (added_one_element)
		qry3+=",";
		qry3+="h.hab_code,p.panch_name";
		added_one_element=true;
		if(order_by_added)
		ord+=",";
		ord+="h.hab_code";
		order_by_added=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.hab_code,p.panch_name";
		grp_added=true;
	}
//	code added by pranavi
	if(columns.contains("Habitation Type")){
		if (added_one_element)
			qry3+=",";
		qry3+="h.habitation_type";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.habitation_type";
		grp_added=true;
	}
	if(columns.contains("Habitation Sub Type")){
		if (added_one_element)
			qry3+=",";
		qry3+="h.habitation_sub_type";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.habitation_sub_type";
		grp_added=true;
	}
	if(columns.contains("Habitation Category")){
		if (added_one_element)
			qry3+=",";
		qry3+="h.habitation_category";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.habitation_category";
		grp_added=true;
	}
	if(columns.contains("Coverage Status"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.coverage_status";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.coverage_status";
		grp_added=true;
	}
//	if(columns.contains("Exist Water Level"))
	if(columns.contains("LPCD (Safe Supply)"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.exist_water_level";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.exist_water_level";
		grp_added=true;
	}
	if(columns.contains("Update Date"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="to_char(h.update_date,'dd-mm-yyyy') as udate";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="to_char(h.update_date,'dd-mm-yyyy')";
		grp_added=true;
	}
	if(columns.contains("Prev Yr Status"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.previous_yr_status";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.previous_yr_status";
		grp_added=true;
	}
	if(columns.contains("Present Yr Status"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.coverage_status";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.coverage_status";
		grp_added=true;
	}
	if(columns.contains("Reasons for Slippage"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="decode(nvl(h.slippage_code,'0'),'0033','Increase in population-Migration','0035','Drying up of sources','0036','Due to Water Quality problems','0037','Poor Operation and Maintenance','0038','Seasonal slippage (Temporary)','0039','Less Supply (at PWS delivery points)','0043','Age of systems','0045','Shortage of electricity','0','-') as slipage_code";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.slippage_code";
		grp_added=true;
	}
	if(columns.contains("Census Year"))
	{
		if (added_one_element)
		   qry3+=",";
		qry3+="h.census_year";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.census_year";
		grp_added=true;
	}
	if(columns.contains("Census Plain Pop."))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.census_plain_popu";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.census_plain_popu";
		grp_added=true;
	}
	if(columns.contains("Census SC Pop"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.census_sc_popu";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.census_sc_popu";
		grp_added=true;
	}
	if(columns.contains("Census ST Pop"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.census_st_popu";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.census_st_popu";
		grp_added=true;
	}
	if(columns.contains("Floationg Pop"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.float_pop";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.float_pop";
		grp_added=true;
	}
	if(columns.contains("Reason for Floating Pop."))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.float_pop_reasons";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.float_pop_reasons";
		grp_added=true;
	}
	if(columns.contains("Status Date"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="to_char(h.status_date,'dd-mm-yyyy') as stdate";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="to_char(h.status_date,'dd-mm-yyyy')";
		grp_added=true;
	}
	if(columns.contains("Plain Pop. Covered"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.plain_popu_covered";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.plain_popu_covered";
		grp_added=true;
	}
	if(columns.contains("SC Pop. Covered"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.sc_pop_covered";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.sc_pop_covered";
		grp_added=true;
	}
	if(columns.contains("ST Pop. Covered"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.st_pop_covered";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.st_pop_covered";
		grp_added=true;
	}
	
	
	
	if(columns.contains("Near Surface Source"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.near_surface_source";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.near_surface_source";
		grp_added=true;
	}
	if(columns.contains("Near Ground Source"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.near_ground_source";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.near_ground_source";
		grp_added=true;
	}
	if(columns.contains("Total Population"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="sum(h.census_plain_popu+h.census_sc_popu+h.census_st_popu) as totpop";
		added_one_element=true;
	}
//	code for no.of households,no of cattles,no of existing sources,no of safe sources
	
	if(columns.contains("No Of HouseHolds"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.household_no";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.household_no";
		grp_added=true;
	}
	
	if(columns.contains("No Of HouseConnections"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.NO_OF_HOUSECONN_GIVEN";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.NO_OF_HOUSECONN_GIVEN";
		grp_added=true;
	}
	
	if(columns.contains("No Of Cattles"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.no_of_cattle";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.no_of_cattle";
		grp_added=true;
	}
	if(columns.contains("No Of Existing Sources"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.existing_sources_no";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.existing_sources_no";
		grp_added=true;
	}
	if(columns.contains("No Of Safe Sources"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.safe_sources_no";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.safe_sources_no";
		grp_added=true;
	}
	if(columns.contains("Remarks"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.remarks";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.remarks";
		grp_added=true;
	}
	if(columns.contains("Quality Affected"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.quality_affected";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.quality_affected";
		grp_added=true;
	}
//	code for nearest avaialble source, distance from households
	if(columns.contains("Nearest Available Source"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="decode(h.nc_source_type,'','-','1','Spring','2','Dug well','3','Ponds','4','River','5','Stream','6','Distant Govt.Source.(any)') as nc_source_type";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.nc_source_type";
		grp_added=true;
	}
	if(columns.contains("Distance From HouseHolds"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="decode(h.source_distance,'','-','1','less than 50','2','50-100','3','101-200','4','201-500','5','500-1600','6','Greater than 1600') as source_distance";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.source_distance";
		grp_added=true;
	}
	
	if(columns.contains("Prop FC Year"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.proposed_fc_year";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.proposed_fc_year";
		grp_added=true;
	}
	if(columns.contains("Prop FC Amnt"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.proposed_fc_est_amt";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.proposed_fc_est_amt";
		grp_added=true;
	}
	
	/*if(columns.contains("Total Water Supply(Unsafe)"))
	{
		if (added_one_element)
			qry3+=",";
		qry3+="h.total_water_supply";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+="h.total_water_supply";
		grp_added=true;

	}*/
	if(columns.contains("Total Water Supply(Unsafe)"))
	{
		if (added_one_element)
		qry3+=",";
		//qry3+="h.total_water_supply";
		//code added for calculating Total Water Supply(Unsafe) by vikas
		//qry3+=" (decode(h.coverage_status,'NSS',HPS_OTH_SUPPLY,'0')+nvl(PWS_UNSAFE_SUPPLY,'0')+nvl(MPWS_UNSAFE_SUPPLY,'0')+nvl(OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl (OTHERS_SUPPLY,'0')) as Unsafe";
		//round((nvl(HPS_OTH_SUPPLY,'0')+ nvl (PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')+nvl (OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl (OTHERS_SUPPLY,'0'))/((nvl (CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl (CENSUS_ST_POPU,'0')+nvl (FLOAT_POP,'0')+.0001)*POWER(1.02,6)),2)
		//query modified by pranavi for pws unsafe ,mpws unsafe
		qry3+=" (nvl(HPS_OTH_SUPPLY_UNSAFE,'0')+nvl(PWS_UNSAFE_SUPPLY,'0')+nvl(MPWS_UNSAFE_SUPPLY,'0')+nvl(OWS_OTH_SUPPLY,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl(OTHERS_SUPPLY,'0')) as Unsafe";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+=" PWS_UNSAFE_SUPPLY,MPWS_UNSAFE_SUPPLY,HPS_OTH_SUPPLY_UNSAFE,OWS_OTH_SUPPLY ,PONDS_OTH_SUPPLY,SHP_DK_SUPPLY,OTHERS_SUPPLY ";
		grp_added=true;
	}
	if(columns.contains("Total Water Supply(Safe)"))
	{
		if (added_one_element)
		qry3+=",";
		//qry3+="h.total_water_supply";
		//code added for calculating Total Water Supply(Unsafe) by vikas
		//qry3+=" (decode(h.coverage_status,'NSS','0',HPS_OTH_SUPPLY)+ nvl(PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')) as Safe";
		//round((nvl(HPS_OTH_SUPPLY,'0')+ nvl (PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(CPWS_SUPPLY,'0')+nvl (OWS_OTH_SUPPLY ,'0')+nvl(PONDS_OTH_SUPPLY,'0')+nvl(SHP_DK_SUPPLY,'0')+nvl (OTHERS_SUPPLY,'0'))/((nvl (CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl (CENSUS_ST_POPU,'0')+nvl (FLOAT_POP,'0')+.0001)*POWER(1.02,6)),2)
		
//		query modified by pranavi for HPS_OTH_SUPPLY,OTHERS_SUPPLY_SAFE
		qry3+=" (nvl(HPS_OTH_SUPPLY,'0')+nvl(PWS_SUPPLY,'0')+nvl(MPWS_SUPPLY,'0')+nvl(cpws_supply,'0')+nvl(OTHERS_SUPPLY_SAFE,'0')) as Safe";
		added_one_element=true;
		if(grp_added==false)
		{
	     	grp+="group by ";
		}
		if(grp_added)
	     	grp+=",";
		grp+=" HPS_OTH_SUPPLY,PWS_SUPPLY,MPWS_SUPPLY,CPWS_SUPPLY,OTHERS_SUPPLY_SAFE ";
		grp_added=true;
	}
	qry3+=" from "+getHabDirTabName(rwsm.getDistCode())+" h,"+getPanchRajTabName(rwsm.getDistCode())+" p,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl panch,rws_village_tbl v where h.hab_code=p.panch_code and ";
	
	if(columns.contains("District"))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" d.dcode=m.dcode and d.dcode=panch.dcode and d.dcode=v.dcode and d.dcode=substr(h.hab_code,1,2) and d.dcode=substr(p.panch_code,1,2) and m.dcode=d.dcode and m.dcode=panch.dcode and m.dcode=v.dcode and m.dcode=substr(h.hab_code,1,2) and m.dcode=substr(p.panch_code,1,2) and panch.dcode=d.dcode and panch.dcode=m.dcode and panch.dcode=v.dcode and panch.dcode=substr(h.hab_code,1,2) and panch.dcode=substr(p.panch_code,1,2) and v.dcode=d.dcode and v.dcode=m.dcode and v.dcode=panch.dcode and v.dcode=substr(h.hab_code,1,2) and v.dcode=substr(p.panch_code,1,2) and substr(h.hab_code,1,2)=substr(p.panch_code,1,2) ";
		after_where_added=true;
	}
	if(columns.contains("Mandal"))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" substr(h.hab_code,6,2)=m.mcode and substr(p.panch_code,6,2)=m.mcode and m.mcode=panch.mcode and m.mcode=v.mcode and panch.mcode=substr(h.hab_code,6,2) and substr(p.panch_code,6,2)=panch.mcode and panch.mcode=m.mcode and panch.mcode=v.mcode and v.mcode=substr(h.hab_code,6,2) and v.mcode=substr(p.panch_code,6,2) and v.mcode=m.mcode and v.mcode=panch.mcode";
		
		after_where_added=true;
	}
	
	if(columns.contains("Panchayat"))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" substr(h.hab_code,13,2)=panch.pcode and substr(p.panch_code,13,2)=panch.pcode and panch.pcode=v.pcode and v.pcode=panch.pcode";
		after_where_added=true;
	}
	if(columns.contains("Village"))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" substr(h.hab_code,8,3)=v.vcode and substr(p.panch_code,8,3)=v.vcode and p.panch_code=h.hab_code ";
		after_where_added=true;
	}
	if(columns.contains("Habitation"))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.hab_code =p.panch_code ";
		after_where_added=true;
	}
	
	if (rwsm.getCompl_stat().length!=0)
	{
		boolean check=false;
		if(after_where_added)
			qry3+=" and";
		String arr[]=rwsm.getCompl_stat();
		qry3+=" h.coverage_status IN ('";
		for (int i=0;i<arr.length;i++)
			{
				if (check)
				qry3+=",'";
				qry3+=arr[i]+"'";
		    	check=true;
			}
			qry3+=")";
		after_where_added=true;
	}
	if (rwsm.getPrev_stat1().length!=0)
	{
		boolean check=false;
		if(after_where_added)
			qry3+=" and";
		String arr[]=rwsm.getPrev_stat1();
		qry3+=" h.previous_yr_status IN ('";
		//System.out.println("previous yr4");
		for (int i=0;i<arr.length;i++)
			{
				if (check)
				qry3+=",'";
				qry3+=arr[i]+"'";
		    	check=true;
			}
			qry3+=")";
		after_where_added=true;
	}
	
   if(!(rwsm.getCp().equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.census_plain_popu "+rwsm.getCp_condition()+""+rwsm.getCp()+"";
		after_where_added=true;
	}
	if(!(rwsm.getCsc().equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.census_sc_popu "+rwsm.getCsc_condition()+""+rwsm.getCsc()+"";
		after_where_added=true;
	}
	if(!(rwsm.getCst().equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.census_st_popu "+rwsm.getCst_condition()+""+rwsm.getCst()+"";
		after_where_added=true;
	}
	if(!(rwsm.getCtot().equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" (h.census_plain_popu+h.census_sc_popu+h.census_st_popu+h.float_pop) "+rwsm.getCtot_condition()+""+rwsm.getCtot()+"";
		after_where_added=true;
	}
	if(!(rwsm.getFlopop1().equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.float_pop "+rwsm.getFlopop_condition()+""+rwsm.getFlopop1()+"";
		after_where_added=true;
	}
	if(!((rwsm.getFloreason()).equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.float_pop_reasons ='"+(rwsm.getFloreason()).toUpperCase()+"'";
		after_where_added=true;
	}
	if(!(rwsm.getTot_wat_supl().equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.total_water_supply "+rwsm.getTot_wat_supl_condition()+""+rwsm.getTot_wat_supl()+"";
		after_where_added=true;
	}
	 if(!(rwsm.getExt_wat_lvl().equals("")))
	{
	 	if(after_where_added)
			qry3+=" and";
	 	qry3+=" h.exist_water_level "+rwsm.getExt_wat_lvl_condition()+""+rwsm.getExt_wat_lvl()+"";
	 	after_where_added=true;
	}
	 if(!(rwsm.getNear_surf_source().equals("")))
	{
	 	if(after_where_added)
			qry3+=" and";
	 	qry3+=" h.near_surface_source "+rwsm.getNear_surf_source_condition()+""+rwsm.getNear_surf_source()+"";
	 	after_where_added=true;
	}
	if(!(rwsm.getNear_ground_source().equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.near_ground_source "+rwsm.getNear_ground_source_condition()+""+rwsm.getNear_ground_source()+"";
		after_where_added=true;
	}
	if(!(rwsm.getProp_year1().equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.proposed_fc_year ='"+rwsm.getProp_year1()+"'";
		after_where_added=true;
	}
	if(!(rwsm.getAmnt_reqd1().equals("")))
	{
		if(after_where_added)
			qry3+=" and";
		qry3+=" h.proposed_fc_est_amt "+rwsm.getAmnt_reqd_condition()+""+rwsm.getAmnt_reqd1()+"";
		after_where_added=true;
	}
	qry3+=" and substr(h.hab_code,1,2)=d.dcode and p.panch_code=h.hab_code 	and d.dcode=m.dcode and d.dcode=panch.dcode and d.dcode=v.dcode and m.dcode=d.dcode and m.dcode=panch.dcode and m.dcode=v.dcode and panch.dcode=d.dcode and panch.dcode=m.dcode and panch.dcode=v.dcode and v.dcode=d.dcode and v.dcode=m.dcode and v.dcode=panch.dcode and substr(h.hab_code,6,2)=m.mcode and p.panch_code=h.hab_code and m.mcode=panch.mcode and m.mcode=v.mcode and panch.mcode=m.mcode and panch.mcode=v.mcode and v.mcode=m.mcode and v.mcode=panch.mcode and substr(h.hab_code,13,2)=panch.pcode and p.panch_code=h.hab_code and panch.pcode=v.pcode and v.pcode=panch.pcode and substr(h.hab_code,8,3)=v.vcode and p.panch_code=h.hab_code "+ord+"";
	System.out.println("querygenerstor 1 "+qry3);
	}
	catch(Exception e)
	 {
		//System.out.println("ERROR IN QUERYGENERATOR:"+e.getMessage());
	 }
	return qry3;
	}
	//End Of Second Query Generator
	
	
	
	public ArrayList detailReport(RwsMaster rwsm,String qry3,String check)
	{
	ArrayList rows=new ArrayList();
	try {
	//pstmt=con.prepareStatement(qry3);
	//System.out.println("query "+qry3);
	createViews(rwsm.getDistCode());
	//Debug.println("view 2 QUERY-------->"+qry3);
	createView2(qry3);//creating view for the query qry3
	//System.out.println("View 2 created...");
	
	pstmt=con.prepareStatement("select * from qry_gen2_view");
	rst=pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rst.getMetaData();	
    int noofcolumns = rsmd.getColumnCount();
	String str="",hab_code="";
	String lpcd1="";
	String query1="",flag="false";
	
	double lpcd=0,safelpcd=0;	
	boolean pp=false;
	int ival=1,a=0;
	ArrayList row=null;
	 while(rst.next())
 	  {
	 	//code changed by Vikas 030409 to add LPCD COLUMN
	 	//if(!(rwsm.getTot_wat_supl().equals("")))
		//{	//if totwatersupply condition is not null then retrive the rows which statisfy the condition with LPCD Formula
		 hab_code=rst.getString("hab_code");
		// Debug.println("inside TOTALWATER SUPPLUYKASDF ");
		// pp=countLpcd1(rwsm,hab_code);
		// ival++;	
		 //Debug.println("PP value "+pp+" hab_code"+hab_code);
		
		//if(pp)
		//{ 
			//Debug.println("inside PP "+pp);
		//	row=new ArrayList();
		//	for (int i=1;i<=noofcolumns;i++) 
		// 	{
			//	str=rst.getString(i);
			//	Debug.println("getString "+rst.getString(i));
		//		if(str==null || str.equals("") || str.equals(" ") || str.equals("null"))
		 	//	str="-";
			//	row.add(str);
			 	//flag="true";
//		 	}
//			if(check.equals("true"))//if LPCD column is checked then insert ROW(called LPCD)
//			{				
//			lpcd=countLpcd(rwsm,hab_code);
//			row.add(""+lpcd);
//			}
		//Debug.println("inserting ROW"+a++);
//		rows.add(row);
//		}		
	// }
//	 else if((rwsm.getTot_wat_supl().equals("")))
//	 {   //
			row=new ArrayList();
			for (int i=1;i<=noofcolumns;i++) 
		 	{
				str=rst.getString(i);
				//Debug.println("rst.getString "+rst.getString(i));
				if(str==null || str.equals("") || str.equals(" ") || str.equals("null"))
		 		str="-";
		 		row.add(str);
		 		flag="true";
		 	}
			if(check.equals("true"))
			{	
			hab_code=rst.getString("hab_code");	
			lpcd=countLpcd(hab_code);
			row.add(""+lpcd);
			}
		rows.add(row);
	  }
					
// 	}
	
	dropViews(rwsm.getDistCode());
	dropView2();
	
	}
 	catch (SQLException se)
	{
		//System.out.println("Exception in detailReport "+se.getMessage());
	}
	finally
	{
	try{
		rst.close();
		pstmt.close();
		con.close();
 	    }
	catch (Exception e)
               {
               }
	}
	return rows;
	}
	/*
	 * 
	 * @author ramesh starts here
	 *
	 */

	public String cheaderNames(String circle)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT circle_office_name FROM rws_circle_office_tbl where circle_office_code='"+circle+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String dheaderNames(String circle,String divison)
	{
		String dohead=null;
		try
		{	
		con=RwsOffices.getConn();
		String qry="SELECT division_office_name FROM rws_division_office_tbl  where circle_office_code='"+circle+"' and division_office_code='"+divison+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	dohead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dohead;
	
	}
	public String sdheaderNames(String circle,String divison,String subdivision)
	{
		String dohead=null;
		try
		{	
		con=RwsOffices.getConn();
		String qry="SELECT subdivision_office_name FROM rws_subdivision_office_tbl  where circle_office_code='"+circle+"' and division_office_code='"+divison+"' and subdivision_office_code='"+subdivision+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	dohead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return dohead;
	}
	public String progheaderNames(String program)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT PROGRAMME_NAME FROM rws_programme_tbl where PROGRAMME_CODE = '"+program+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String subprogheaderNames(String program,String subprogram)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT SUBPROGRAMME_NAME FROM rws_subprogramme_tbl where PROGRAMME_CODE = '"+program+"' and SUBPROGRAMME_CODE = '"+subprogram+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	
	public String wcheaderNames(String wc)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT CATEGORY_NAME FROM rws_work_category_tbl where CATEGORY_CODE  = '"+wc+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
	 	nic.watersoft.commons.Debug.println("work categoey in DAO"+chead);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	/*public String schemeheaderNames(String scheme)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT TYPE_OF_ASSET_NAME  FROM rws_asset_type_tbl where TYPE_OF_ASSET_CODE   = '"+scheme+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}*/
	public String planheaderNames(String plan)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT PLAN_NAME  FROM rws_plan_nonplan_tbl where PLAN_CODE    = '"+plan+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String augnewheaderNames(String augnew)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT AUG_NEW_NAME FROM rws_augumentation_new_tbl where AUG_NEW_CODE    = '"+augnew+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
//	 code added by sridhar for scheme names 
	public String schemeheaderNames(String scheme)
		{
			String chead=null;
			try
			{	
			con=RwsOffices.getConn();
			
			String qry="SELECT TYPE_OF_ASSET_NAME  FROM rws_asset_type_tbl where TYPE_OF_ASSET_CODE   = '"+scheme+"'";
		 	pstmt=con.prepareStatement(qry);
		 	//Debug.println("qruy%%%%^:"+qry);
		 	rst=pstmt.executeQuery();
		 	while(rst.next())
		 	{
		 	chead=rst.getString(1);
			}
		 	}
			catch (SQLException se)
			{
				Debug.println(se.getMessage());
			}
			finally
			{
			try{
				rst.close();
				pstmt.close();
				con.close();
		 	    }
			catch (Exception e)
			                   {
			                   }
			}
			return chead;
		
		}

		
//		code added by sridahr for panchayat name
		public String panchheaderNames(String district,String mandal,String panchayat)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select pname from rws_panchayat_tbl where dcode = '"+district+"' and mcode = '"+mandal+"' and pcode='"+panchayat+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		       {
		        }
		}
		return chead;

	 
	}
//	 code added by sridhar for hab names on 291209
	public String habheaderNames(String district,String mandal,String panchayat,String village,String hab)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select a.panch_name from rws_panchayat_raj_tbl a,rws_complete_hab_view ch  where a.panch_code=ch.panch_code and dcode = '"+district+"' and mcode = '"+mandal+"'" +
				" and pcode='"+panchayat+"' and vcode='"+village+"' and a.panch_code='"+hab+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		       {
		        }
		}
		return chead;


	}


//	 code added by sridhar  for village name 


	public String villheaderNames(String district,String mandal,String panchayat,String village)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select vname from rws_village_tbl where dcode = '"+district+"' and mcode = '"+mandal+"'" +
				" and pcode='"+panchayat+"' and vcode='"+village+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		       {
		        }
		}
		return chead;


	}

		
//	 code added by sridhar for format data
		public static String formatData(int data)
		{
		if(data==0)
			return "--";
		else return data+"";
		}
		
		// code added by sridhar for asset format detail report 
		public ArrayList getAssetFormatDatadetail(String qry1,RwsMaster rwsm,String select,String[] fields,String creport,ArrayList columns1,String selectedFields,String sessionId,boolean check,HttpServletRequest request) throws Exception
		{

		// ArrayList total1=new ArrayList();
		ArrayList rows1 = new ArrayList();
		//Debug.println(" in detail report mode");
		Statement stmt = null, stmt1 = null, stmt2 = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		String[] selFields = selectedFields.split(",");
		ArrayList selfieldlist = new ArrayList(Arrays.asList(selFields));
		String viewname = "";
		String qry = "";

		try {
			conn = RwsOffices.getConn();
			ArrayList fieldlist = new ArrayList(Arrays.asList(fields));
			ArrayList rowss = new ArrayList();
			ArrayList rowsss = new ArrayList();
			ArrayList row = null, source = null, source1 = null, rwc = null, sstank = null, ssfilter = null, rsfilter = null, sump = null, ftp = null, pumphouse = null, watchman = null, cwc = null, mfilter = null, roplants = null, pumpmain = null, gravitymain = null, distri = null, ohsr = null, ohbr = null, glsr = null, glbr = null, bpt = null, cist = null, misl = null, chlorination = null, oandm = null, pumpset = null, hp = null, openwell = null, pond = null, some = null, otherscheck = null, shp = null;
			if ((!fieldlist.contains("subsurface"))
					&& (!fieldlist.contains("surface"))
					&& (!fieldlist.contains("rwc"))
					&& (!fieldlist.contains("sstank"))
					&& (!fieldlist.contains("ssfilter"))
					&& (!fieldlist.contains("rsfilter"))
					&& (!fieldlist.contains("sump"))
					&& (!fieldlist.contains("ftp"))
					&& (!fieldlist.contains("pumphouse"))
					&& (!fieldlist.contains("watchman"))
					&& (!fieldlist.contains("cwc"))
					&& (!fieldlist.contains("mfilter"))
					&& (!fieldlist.contains("roplants"))
					&& (!fieldlist.contains("pumpingmain"))
					&& (!fieldlist.contains("gravitymain"))
					&& (!fieldlist.contains("distribution"))
					&& (!fieldlist.contains("ohsr"))
					&& (!fieldlist.contains("ohbr"))
					&& (!fieldlist.contains("glsr"))
					&& (!fieldlist.contains("glbr"))
					&& (!fieldlist.contains("bpt"))
					&& (!fieldlist.contains("cisterns"))
					&& (!fieldlist.contains("miscellaneous"))
					&& (!fieldlist.contains("chlorination"))
					&& (!fieldlist.contains("oandm"))
					&& (!fieldlist.contains("pumpsets"))
					&& (!fieldlist.contains("borewells"))
					&& (!fieldlist.contains("openwells"))
					&& (!fieldlist.contains("shallowhandpumps"))
					&& (!fieldlist.contains("ponds"))
					&& (!fieldlist.contains("otherscheck"))) {
				some = new ArrayList();
				row = new ArrayList();
				row.add("ALL ASSETS");
				some.add(row);
				row = new ArrayList();
				row.add("SNo");
				row.add("Asset Code");
				row.add("Scheme Code");
				row.add("Asset Name");
				if (request.getParameter("mandal") != null
						&& request.getParameter("mandal").equals(""))
					row.add("Mandal Name");
				if (request.getParameter("panchayat") != null
						&& request.getParameter("panchayat").equals(""))
					row.add("Panchayat Name");
				if (request.getParameter("village") != null
						&& request.getParameter("village").equals(""))
					row.add("Vilage Name");
				if (request.getParameter("habCode") != null
						&& request.getParameter("habCode").equals(""))
					row.add("Hab Code");
					row.add("Hab Name");
				row.add("Asset Location");
				row.add("Date Creation");
				row.add("Asset Status");
				row.add("Asset Cost");
				row.add("No of Habs Benefited");
				row.add("Population Benefited");

				some.add(row);

			} else {
				if (fieldlist.contains("subsurface")) {
					source = new ArrayList();
					row = new ArrayList();
					row.add("SUB SURFACE");
					source.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Source Type");
					row.add("Sub Source Type");
					row.add("Location");
					row.add("Source Condition");
					row.add("Static Water Level from Ground(in mts)");
					row.add("Yield(l.p.m)");
					row.add("Source Depth");
					row.add("Alternative Water Source(k.m s) ");
					row.add("Water Quality");
					source.add(row);
				}

				if (fieldlist.contains("surface")) {
					source1 = new ArrayList();
					row = new ArrayList();
					row.add("SURFACE");
					source1.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Source Type");
					row.add("Sub Source Type");
					row.add("Source Name");
					row.add("Tapping Point Location");
					row.add("Source Condition");
					row.add("Static Water Level from Ground(in mts)");
					row.add("Yield(l.p.m)");
					row.add("Alternative Water Source(k.m s) ");
					row.add("Water Quality");
					source1.add(row);
				}
				if (fieldlist.contains("rwc")) {
					//Debug.println(" in cols of rwc");
					rwc = new ArrayList();
					row = new ArrayList();
					row.add("RAW WATER COLLECTION WELL");
					rwc.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Raw Water Collection Well Code");
					row.add("Location");
					row.add("Capacity(in lts)");
					rwc.add(row);
					//Debug.println("rwc:"+rwc);
				}
				if (fieldlist.contains("sstank")) {
					sstank = new ArrayList();
					row = new ArrayList();
					row.add("SS TANk");
					sstank.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("SS Tank Code");
					row.add("SS Tank Size(LBD)");
					row.add("Depth(mts)");
					row.add("No Of Days Storage");
					row.add("No Of Mcum");
					row.add("Fed By");
					row.add("Location");
					sstank.add(row);
				}
				if (fieldlist.contains("ssfilter")) {
					ssfilter = new ArrayList();
					row = new ArrayList();
					row.add("SS FILTER");
					ssfilter.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Water Treatment Plant Code");
					row.add("Location");
					row.add("Capacity In MLD");
					row.add("NO Of Units");
					row.add("No Of Hours Usage");
					row.add("Size Of Units");
					row.add("No Of Stand By Units");
					row.add("Frequency Of Sand Scrapping");
					row.add("Gerneral Performance");
					row.add("Extension Scope");
					row.add("Sedmentation Tank");
					row.add("HoriZontral Roughing Filter");
					row.add("Vertical Roughing Filter");
					ssfilter.add(row);
				}
				if (fieldlist.contains("rsfilter")) {
					rsfilter = new ArrayList();
					row = new ArrayList();
					row.add("RS FILTER");
					rsfilter.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Water Treatment Plant Code");
					row.add("Location");
					row.add("Capacity In MLD");
					row.add("NO Of Units");
					row.add("No Of Hours Usage");
					row.add("Size Of Units");
					row.add("No Of Stand By Units");
					row.add("Frequency Of Back Wash");
					row.add("Clarifloculator");
					rsfilter.add(row);
				}
				if (fieldlist.contains("sump")) {
					sump = new ArrayList();
					row = new ArrayList();
					row.add("SUMP");
					sump.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Sump Code");
					row.add("Location");
					row.add("Diameter/Length");
					row.add("Sump Depth");
					row.add("Capacity of Sump(lts)");
					row.add("Sump Condition");
					sump.add(row);
				}
				if (fieldlist.contains("ftp")) {
					ftp = new ArrayList();
					row = new ArrayList();
					row.add("FOOT PATH BRIDGE");
					ftp.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Bridge Code");
					row.add("Location");
					ftp.add(row);
				}
				if (fieldlist.contains("pumphouse")) {
					pumphouse = new ArrayList();
					row = new ArrayList();
					row.add("PUMP HOUSE");
					pumphouse.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("PumpHouse Code");
					row.add("Location");
					row.add("Area");
					pumphouse.add(row);
				}
				if (fieldlist.contains("watchman")) {
					watchman = new ArrayList();
					row = new ArrayList();
					row.add("WATCH MAN QUARTER");
					watchman.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Watchman Code");
					row.add("Location");
					watchman.add(row);
				}
				if (fieldlist.contains("cwc")) {
					cwc = new ArrayList();
					row = new ArrayList();
					row.add("CLEAR WATER COLLECTION WELL");
					cwc.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Clear Water Collection Well Code");
					row.add("Location");
					row.add("Capacity(in lts)");
					cwc.add(row);
				}
				if (fieldlist.contains("mfilter")) {
					mfilter = new ArrayList();
					row = new ArrayList();
					row.add("MICRO FILTER");
					mfilter.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Water Treatment Plant Code");
					row.add("Location");
					row.add("Capacity In MLD");
					row.add("NO Of Units");
					row.add("No Of Hours Usage");
					row.add("Size Of Units");
					row.add("No Of Stand By Units");
					row.add("Shelter Existance");
					row.add("Gerneral Performance");
					row.add("Extension Scope");
					row.add("Sedmentation Tank");
					row.add("Horizontal Roughing Filter");
					row.add("Vertical Roughing Filter");
					mfilter.add(row);
				}
				if (fieldlist.contains("roplants")) {
					roplants = new ArrayList();
					row = new ArrayList();
					row.add("RO PLANTS");
					roplants.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Water Treatment Plant Code");
					row.add("Location");
					row.add("Capacity ");
					row.add("NO Of Units");
					row.add("No Of Hours Usage");
					row.add("No Of Stand By Units");
					row.add("Raw Water Storage Tank Existing ");
					row.add("Product Water Storage Tank Existing ");
					row.add("Shelter Existance");
					roplants.add(row);
				}
				if (fieldlist.contains("pumpingmain")) {
					pumpmain = new ArrayList();
					row = new ArrayList();
					row.add("PUMPING MAIN");
					pumpmain.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Pumping Main Code");
					row.add("No of Air Valves");
					row.add("No Of Scour Valves");
					row.add("No Of Reflux Valves");
					row.add("No Of Sluice Valves");
					row.add("Number of Pipes");
					row.add("Zero Velocity Valve");
					row.add("Air Cushion Valve");
					row.add("Non Return Valve");
					pumpmain.add(row);
				}
				if (fieldlist.contains("gravitymain")) {
					gravitymain = new ArrayList();
					row = new ArrayList();
					row.add("GRAVITY MAIN");
					gravitymain.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Gravity Main Code");
					row.add("Length");
					row.add("No of Air Valves");
					row.add("No Of Scour Valves");
					row.add("No Of Reflux Valves");
					row.add("No Of Sluice Valves");
					row.add("Number of Pipes");
					row.add("No Of Zero Velocity Valve");
					row.add("No of Air Cushion Valve");
					row.add("Non Return Valve");
					gravitymain.add(row);
				}
				if (fieldlist.contains("distribution")) {
					distri = new ArrayList();
					row = new ArrayList();
					row.add("DISTRIBUTION");
					distri.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Distribution Code");
					row.add("No Of Pipes Required");
					row.add("No of Air Valves");
					row.add("Total Length Needed");
					row.add("No Of Sluice Valves");
					row.add("Total Length Provided");
					row.add("No Of Scour Valves");
					row.add("Full Villages Covered");
					row.add("No Of Private House Connections");
					row.add("Balance Needed in mts");
					row.add("No Of Standed Posts");
					distri.add(row);
				}
				if (fieldlist.contains("ohsr")) {
					ohsr = new ArrayList();
					row = new ArrayList();
					row.add("OHSR");
					ohsr.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Ohsr Code");
					row.add("Ohsr Location");
					row.add("Capacity");
					row.add("No Of Fillings");
					row.add("Ohsr Statging ");
					row.add("Water Quality");
					ohsr.add(row);
				}
				if (fieldlist.contains("ohbr")) {
					ohbr = new ArrayList();
					row = new ArrayList();
					row.add("OHBR");
					ohbr.add(row);
					row = new ArrayList();

					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Ohbr Code");
					row.add("Ohbr Location");
					row.add("Capacity");
					row.add("Ohbr Statging ");
					ohbr.add(row);
				}
				if (fieldlist.contains("glsr")) {
					glsr = new ArrayList();
					row = new ArrayList();
					row.add("GLSR");
					glsr.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Glsr Code");
					row.add("Glsr Location");
					row.add("Glsr Capacity");
					row.add("No Of Fillings");
					row.add("Glsr Statging ");
					row.add("Water Quality");
					glsr.add(row);
				}
				if (fieldlist.contains("glbr")) {
					glbr = new ArrayList();
					row = new ArrayList();
					row.add("GLBR");
					glbr.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Glbr Code");
					row.add("Glbr Location");
					row.add("Capacity");
					row.add("Lowest Water Level");
					row.add("Maximum Water Level");
					row.add("Glbr Fill in Hrs");
					row.add("Glbr Empty in Hrs");
					glbr.add(row);
				}
				if (fieldlist.contains("bpt")) {
					bpt = new ArrayList();
					row = new ArrayList();
					row.add("BPT");
					bpt.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("No of Habs Benefited");
					row.add("Bpt Code");
					row.add("Location");
					row.add("Capacity");
					row.add("Bpt Staging");
					bpt.add(row);
				}
				if (fieldlist.contains("cisterns")) {
					cist = new ArrayList();
					row = new ArrayList();
					row.add("CISTERNS");
					cist.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Cistern Code");
					row.add(" Location");
					row.add("Capacity");
					row.add(" No Of Fillings/Day");
					row.add("PlatForm Existing");
					row.add("PlatForm Condition");
					row.add("Drain Provided");
					row.add("Water Quality");
					cist.add(row);
				}
				if (fieldlist.contains("miscellaneous")) {
					misl = new ArrayList();
					row = new ArrayList();
					row.add("MISCELLANEOUS");
					misl.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Component Code");
					row.add(" Component Name");
					row.add("Location");
					row.add("Remarks");
					misl.add(row);
				}
				if (fieldlist.contains("chlorination")) {
					chlorination = new ArrayList();
					row = new ArrayList();
					row.add("CHLORINATION");
					chlorination.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Chlorination Code");
					row.add("Chlorination Location");
					row.add("Working");
					row.add("Bleaching Powder");
					row.add("Liquid Chlorine");
					row.add("Gas Chlorine");
					row.add("Online Dosage");
					row.add("Remarks");
					chlorination.add(row);
				}
				if (fieldlist.contains("oandm")) {
					oandm = new ArrayList();
					row = new ArrayList();
					row.add("OANDM");
					oandm.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Agencey");
					row.add("Power Cost");
					row.add("Consumabels");
					row.add("Wages & Others");
					row.add("Total Cost of MTC");
					row.add("Source Of Finding");
					row.add("No of House Connections");
					row.add("Traiff/Month");
					row.add("Total Collection/Anum");
					oandm.add(row);
				}
				if (fieldlist.contains("pumpsets")) {
					pumpset = new ArrayList();
					row = new ArrayList();
					row.add("PUMP SETS");
					pumpset.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Pump Code");
					row.add("Location");
					row.add("Pump Make");
					row.add("Pump Type");
					row.add("Pump Capacity");
					row.add(" Year Of Commisioning ");
					row.add("Hrs Running Per Day");
					row.add("Usage");
					row.add("Designed Head");
					row.add("Designed LPM");
					row.add("Hours Of Power Availability");
					row.add("Low Voltage Problems");
					row.add("Remarks");
					row.add("Feeder");
					row.add("Generator Existing");
					pumpset.add(row);
				}
				if (fieldlist.contains("borewells")) {
					//Debug.println(" in Borewell col name");
					hp = new ArrayList();
					row = new ArrayList();
					row.add("HAND PUMPS");
					hp.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Pump Code");
					row.add("Location");
					row.add("Diameter(mm)");
					row.add("Depth(in mts)");
					row.add("Casing(type)");
					row.add(" No Of GIS Pipes ");
					row.add("Total Pipe Length");
					row.add("General Condition");
					row.add("Static Water Level(mts)");
					row.add("Summer Water Level(from mts to ground)");
					row.add("No of Hours Serving per Day");
					row.add("No of Households Served");
					row.add("HP No Painted");
					row.add("Repairs Per Year");
					row.add("Platform Existing");
					row.add("Platform Condition");
					row.add("Drain");
					row.add("Drain Condition");
					row.add("Drain Connected to side Drains");
					row.add("Leach Pit");
					row.add("Hygiene");
					row.add("Present Yeild(as per local enquiry)");
					row.add("Yeild(l.p.m)");
					row.add("Quality Effected[NSS(Y)/Safe Source(N)]");
					hp.add(row);
				}
				if (fieldlist.contains("openwells")) {
					openwell = new ArrayList();
					row = new ArrayList();
					row.add("OPEN WELLS");
					openwell.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("OpenWell Code");
					row.add("Location");
					row.add("Diameter(mm)");
					row.add("Depth(in mts)");
					row.add("Normal Water Level(mts)");
					row.add(" Minimum Water Level(mts) ");
					row.add("Maximum Water Level(mts)");
					row.add("Platform Existing");
					row.add("Purpose");
					row.add("Quality");
					openwell.add(row);
				}
				if (fieldlist.contains("ponds")) {
					pond = new ArrayList();
					row = new ArrayList();
					row.add("PONDS");
					pond.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Pond Code");
					row.add("Fed By");
					row.add("Hygeinity");
					row.add("Volume of Storage");
					row.add("Pond Name");
					row.add(" Purpose ");
					row.add("Location");
					row.add("Area Size");
					row.add("Water Quality");
					pond.add(row);
				}

				if (fieldlist.contains("shallowhandpumps")) {
					shp = new ArrayList();
					row = new ArrayList();
					row.add("SHALLOW HANDPUMPS");
					shp.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("ShallowHp Code ");
					row.add("Location");
					row.add("Diameter");
					row.add("Depth");
					row.add("Hygiene");
					row.add("Average Hours ");
					row.add("Average Time ");
					row.add("Yeild");
					row.add("Water Quality");
					shp.add(row);
				}
				if (fieldlist.contains("otherscheck")) {
					otherscheck = new ArrayList();
					row = new ArrayList();
					row.add("OTHERS");
					otherscheck.add(row);
					row = new ArrayList();
					row.add("SNo");
					row.add("Asset Code");
					row.add("Scheme Code");
					row.add("Asset Name");
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add("Mandal Name");
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add("Panchayat Name");
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add("Vilage Name");
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add("Hab Code");
						row.add("Hab Name");
					row.add("Asset Location");
					row.add("Date Creation");
					row.add("Asset Status");
					row.add("Asset Cost");
					row.add("No of Habs Benefited");
					row.add("Population Benefited");
					row.add("Others Code");
					row.add("Hab Code");
					row.add("Component Name");
					row.add("Volume of Storage");
					row.add("Location");
					row.add(" Remarks ");
					otherscheck.add(row);
				}

			}
			stmt = conn.createStatement();
			String assetqry = "select a.asset_name,h.mname,h.pname,h.vname,h.panch_name,h.panch_code,a.asset_code,nvl(a.location,'-')as location ,decode(a.asset_status, 1,'WORKING',2,'NOT WORKING',3,'DRIED',4,'SEASONAL',5,'CONDEMED','','-')as asset_status,a.asset_cost,a.POPU_BENEFITED,to_char(a.date_creation,'dd/mm/yyyy')as DATE_CREATION,a.scheme_code  "
					+ " from rws_asset_freeformat_view"
					+ sessionId.substring(0, 5)
					+ " a,rws_complete_hab_view h where a.hab_code=h.panch_code  ";
			Debug.println("asset qry:"+assetqry);
			rs = stmt.executeQuery(assetqry);
			while (rs.next()) {
				String schemeCode="",assetname = "", mname = "", pname = "", vname = "", panchname = "",panchcode="", location = "", datecreation = "", assetstatus = "", assetcost = "", totpop = "", habcount = "";
				schemeCode=rs.getString("SCHEME_CODE");
				assetname = rs.getString("ASSET_NAME");
				mname = rs.getString("mname");
				pname = rs.getString("pname");
				vname = rs.getString("vname");
				panchname = rs.getString("panch_name");
				panchcode=rs.getString("panch_code");
				location = rs.getString("LOCATION");
				if (rs.getString("DATE_CREATION") != null
						&& !rs.getString("DATE_CREATION").equals("")) {
					datecreation = rs.getString("DATE_CREATION");
				} else {
					datecreation = "0";
				}
				//if(rs.getString("ASSET_STATUS")!=null &&
				// !rs.getString("ASSET_STATUS").equals(""))
				//{
				assetstatus = rs.getString("ASSET_STATUS");// }else{assetstatus="-";}
				if (rs.getString("ASSET_COST") != null
						&& !rs.getString("ASSET_COST").equals("")) {
					assetcost = rs.getString("ASSET_COST");
				} else {
					assetcost = "0";
				}
				String acode = rs.getString("asset_code");
				//Debug.println("ssssssssss.2");
				if (rwsm.getAssettype().equals("01")
						|| rwsm.getAssettype().equals("02")
						|| rwsm.getAssettype().equals("03")
						|| rwsm.getAssettype().equals("09")) {
					try {
						//Debug.println("ssssssssss.2");
						String qry3 = "select count(h.hab_code)as pb,Sum(d.census_plain_popu + d.census_st_popu + d.census_st_popu + d.FLOAT_POP)as nhb from rws_asset_mast_tbl a, rws_asset_hab_tbl h, rws_habitation_directory_tbl d where d.hab_code=h.hab_code and h.asset_code= a.asset_code and a.asset_code='"
								+ acode + "'";
						//Debug.println("details of population query "+qry3);
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(qry3);

						if (rs2.next()) {
							if (rs2.getString(2) != null
									&& !rs2.getString(2).equals("")) {
								totpop = rs2.getString(2);
							} else {
								totpop = "0";
							}
							habcount = rs2.getString(1);
						}
					} catch (Exception e) {
						Debug.println("Error in population" + e);
					} finally {
						rs2.close();
						stmt2.close();
					}
				} else {
					//Debug.println("in else");
					if (rs.getString("POPU_BENEFITED") != null
							&& !rs.getString("POPU_BENEFITED").equals("")) {
						totpop = rs.getString("POPU_BENEFITED");
					} else {
						totpop = "0";
					}
					//Debug.println("in sdfdj kjkf gkflkg");
					habcount = "1";
					//Debug.println("habcount"+habcount);
				}
				//Debug.println("fieldlist:"+fieldlist);
				if ((!fieldlist.contains("subsurface"))
						&& (!fieldlist.contains("surface"))
						&& (!fieldlist.contains("rwc"))
						&& (!fieldlist.contains("sstank"))
						&& (!fieldlist.contains("ssfilter"))
						&& (!fieldlist.contains("rsfilter"))
						&& (!fieldlist.contains("sump"))
						&& (!fieldlist.contains("ftp"))
						&& (!fieldlist.contains("pumphouse"))
						&& (!fieldlist.contains("watchman"))
						&& (!fieldlist.contains("cwc"))
						&& (!fieldlist.contains("mfilter"))
						&& (!fieldlist.contains("roplants"))
						&& (!fieldlist.contains("pumpingmain"))
						&& (!fieldlist.contains("gravitymain"))
						&& (!fieldlist.contains("distribution"))
						&& (!fieldlist.contains("ohsr"))
						&& (!fieldlist.contains("ohbr"))
						&& (!fieldlist.contains("glsr"))
						&& (!fieldlist.contains("glbr"))
						&& (!fieldlist.contains("bpt"))
						&& (!fieldlist.contains("cisterns"))
						&& (!fieldlist.contains("miscellaneous"))
						&& (!fieldlist.contains("chlorination"))
						&& (!fieldlist.contains("oandm"))
						&& (!fieldlist.contains("pumpsets"))
						&& (!fieldlist.contains("borewells"))
						&& (!fieldlist.contains("openwells"))
						&& (!fieldlist.contains("shallowhandpumps"))
						&& (!fieldlist.contains("ponds"))
						&& (!fieldlist.contains("otherscheck"))) {
					//Debug.println("in no one selected");
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);

					some.add(row);
					check = true;

				} else {

					String query = "";

					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);

					if (fieldlist.contains("subsurface")) { //Debug.println("2");

						query = " select SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,nvl(SUBCOMPTBL.Location,'-'),nvl(SOURCE_CONDITION,'-'),nvl(STATIC_WATER_LEVEL,'0'),nvl(YIELD,'0'),nvl(DEPTH,'0'),nvl(DIST_NEAR_PRIVATE_SOURCE,'0'),WATER_QUALITY  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL subCompTbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE "
								+ "  and M.asset_code='"
								+ acode
								+ "' and source_type_code='1'";
						//Debug.println("query:"+query);
						//Debug.println("3");
						ps = conn.prepareStatement(query);
						//Debug.println("4");
						rs1 = ps.executeQuery();
						// Debug.println("5");

						if (rs1.next()) {
							//Debug.println("6");

							//row.add(rs1.getString(5));
							//row.add(rs1.getString(6));
							if (rs1.getString("SOURCE_TYPE_CODE") != null
									&& rs1.getString("SOURCE_TYPE_CODE")
											.equals("1")) {
								row.add("Subsurface Source");
							}

							if (rs1.getString("SOURCE_TYPE_CODE").equals("1")
									&& rs1.getString("SUBSOURCE_TYPE_CODE") != null
									&& rs1.getString("SUBSOURCE_TYPE_CODE")
											.equals("1")) {
								row.add("BOREWELL");
							} else if (rs1.getString("SOURCE_TYPE_CODE")
									.equals("1")
									&& rs1.getString("SUBSOURCE_TYPE_CODE") != null
									&& rs1.getString("SUBSOURCE_TYPE_CODE")
											.equals("2")) {
								row.add("FILTER POINT");
							} else if (rs1.getString("SOURCE_TYPE_CODE")
									.equals("1")
									&& rs1.getString("SUBSOURCE_TYPE_CODE") != null
									&& rs1.getString("SUBSOURCE_TYPE_CODE")
											.equals("3")) {
								row.add("INFILTARATION WELL");
							} else if (rs1.getString("SOURCE_TYPE_CODE")
									.equals("1")
									&& rs1.getString("SUBSOURCE_TYPE_CODE") != null
									&& rs1.getString("SUBSOURCE_TYPE_CODE")
											.equals("4")) {
								row.add("OPEN WELL");
							}

							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							if (rs1.getString("WATER_QUALITY") != null
									&& !rs1.getString("WATER_QUALITY").equals(
											"")
									&& rs1.getString("WATER_QUALITY").equals(
											"SS")) {

								row.add("Safe Source");
							} else if (rs1.getString("WATER_QUALITY") != null
									&& !rs1.getString("WATER_QUALITY").equals(
											"")
									&& rs1.getString("WATER_QUALITY").equals(
											"NSS")) {

								row.add("Not Safe Source");
							} else {
								row.add("Safe Source");
							}
							source.add(row);
							check = true;
						}
						rs1.close();
						ps.close();

					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("surface")) {
						//ArrayList source1=new ArrayList();
						query = " select SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,nvl(SOURCE_NAME,'-'),nvl(subCompTbl.location,'-'),nvl(SOURCE_CONDITION,'-'),nvl(STATIC_WATER_LEVEL,'0'),nvl(YIELD,'0'),nvl(DIST_NEAR_PRIVATE_SOURCE,'0'),WATER_QUALITY  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL subCompTbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE "
								+ "  and M.asset_code='"
								+ acode
								+ "' and source_type_code='2'";
						//Debug.println("query:"+query);
						//Debug.println("3");
						ps = conn.prepareStatement(query);
						//Debug.println("4");
						rs1 = ps.executeQuery();
						// Debug.println("5");
						if (rs1.next()) {
							//Debug.println("6");
							if (rs1.getString("SOURCE_TYPE_CODE") != null
									&& rs1.getString("SOURCE_TYPE_CODE")
											.equals("2")) {
								row.add("Surface Source");
							}
							if (rs1.getString("SOURCE_TYPE_CODE").equals("2")
									&& rs1.getString("SUBSOURCE_TYPE_CODE") != null
									&& rs1.getString("SUBSOURCE_TYPE_CODE")
											.equals("1")) {
								row.add("CANAL");
							} else if (rs1.getString("SOURCE_TYPE_CODE")
									.equals("2")
									&& rs1.getString("SUBSOURCE_TYPE_CODE") != null
									&& rs1.getString("SUBSOURCE_TYPE_CODE")
											.equals("2")) {
								row.add("RIVER");
							} else if (rs1.getString("SOURCE_TYPE_CODE")
									.equals("2")
									&& rs1.getString("SUBSOURCE_TYPE_CODE") != null
									&& rs1.getString("SUBSOURCE_TYPE_CODE")
											.equals("3")) {
								row.add("INTAKE WELL");
							} else if (rs1.getString("SOURCE_TYPE_CODE")
									.equals("2")
									&& rs1.getString("SUBSOURCE_TYPE_CODE") != null
									&& rs1.getString("SUBSOURCE_TYPE_CODE")
											.equals("4")) {
								row.add("SPRINGS");
							} else if (rs1.getString("SOURCE_TYPE_CODE")
									.equals("2")
									&& rs1.getString("SUBSOURCE_TYPE_CODE") != null
									&& rs1.getString("SUBSOURCE_TYPE_CODE")
											.equals("5")) {
								row.add("RESERVOIR");
							}
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));

							if (rs1.getString("WATER_QUALITY") != null
									&& !rs1.getString("WATER_QUALITY").equals(
											"")
									&& rs1.getString("WATER_QUALITY").equals(
											"SS")) {
								//Debug.println("11111111111");
								row.add("Safe Source");
							} else if (rs1.getString("WATER_QUALITY") != null
									&& !rs1.getString("WATER_QUALITY").equals(
											"")
									&& rs1.getString("WATER_QUALITY").equals(
											"NSS")) {

								row.add("Not Safe Source");
							} else {
								row.add("Safe Source");
							}
							//row.add(rs1.getString(13));
							//Debug.println("6");
							source1.add(row);
							check = true;
						}

						rs1.close();
						ps.close();

					}

					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("rwc")) {
						//Debug.println("in rwc");
						query = " select RW_COLLWELL_CODE,nvl(subCompTbl.location,'-'),nvl(capacity,'0') from rws_asset_mast_tbl m,rws_asset_scheme_tbl s,  RWS_AST_RW_COLLWELL_PARAM_TBL subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND  M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and M.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();
						//Debug.println("in rwc");
						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							rwc.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("sstank")) {
						query = "select sssc_code,nvl(SS_SIZE,'0'),nvl(DEPTH,'0'),nvl(CAPACITY_DAYS,'0'),nvl(CAPACITY_MCUM,'0'),TANK_ADEQACY,nvl(SUBCOMPTBL.LOCATION,'-') as location1 from  rws_asset_mast_tbl m, rws_asset_scheme_tbl  s,RWS_AST_SS_SC_PARAM_TBL subcomptbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and M.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();
						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));

							if (rs1.getString("TANK_ADEQACY") != null
									&& rs1.getString("TANK_ADEQACY").equals(
											"Urban")) {
								row.add("Canal");
							} else if (rs1.getString("TANK_ADEQACY") != null
									&& rs1.getString("TANK_ADEQACY").equals(
											"Rural")) {
								row.add("River");
							} else if (rs1.getString("TANK_ADEQACY") != null
									&& rs1.getString("TANK_ADEQACY").equals(
											"Dedicated")) {
								row.add("Reserviors");
							}

							else if (rs1.getString("TANK_ADEQACY") != null
									&& rs1.getString("TANK_ADEQACY").equals(
											"Others")) {
								/*if (rs1.getString("OTHERS") != null)
									row.add(rs1.getString("OTHERS"));*/
								row.add("OTHERS");
							}

							row.add(rs1.getString(6));
							//row.add(rs1.getString(11));
							sstank.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("ssfilter")) {
						//Debug.println("in rwc");
						query = " select WTPSC_CODE,nvl(subCompTbl.Location,'-'),nvl(WTP_MLD,'0'),nvl(RATE_OF_FILTRATION,'0'),nvl(UNITS_NO,'0'),nvl(WTP_SIZE,'0'),nvl(UNITS_STANDBY,'0'), "
								+ " nvl(FREQ_SAND_SCRAP,'0'),decode(PERFORMANCE,'G','GOOD','B','BAD','','-'),decode(EXTENTION_SCOPE,'Y','YES','N','NO','','-'),CHK_FILTER from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_WTP_SC_PARAM_TBL subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "' and substr(WTPSC_CODE,20,2)='SS'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							row.add(rs1.getString(9));
							row.add(rs1.getString(10));

							String chkfilter = rs1.getString("CHK_FILTER");

							if (chkfilter != null
									&& chkfilter.substring(0, 2).equals("01")) {
								//Debug.println("22222222"+rs.getString("CHK_FILTER"));
								row.add("YES");
							} else {
								row.add("NO");
							}
							if (chkfilter != null
									&& chkfilter.substring(2, 4).equals("02")) {
								//Debug.println("3333"+rs.getString("CHK_FILTER"));
								row.add("YES");
							} else {
								row.add("NO");
							}
							if (chkfilter != null
									&& chkfilter.substring(4, 6).equals("03")) {
								//Debug.println("4444"+
								// rs.getString("CHK_FILTER"));
								row.add("YES");
							} else {
								row.add("NO");
							}
							ssfilter.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("rsfilter")) {
						//Debug.println("in rwc");
						query = " select WTPSC_CODE,nvl(subCompTbl.Location,'-'),nvl(USE_CAPACITYMLD,'0'),nvl(UNITS_NO,'0'),nvl(RATE_OF_FILTRATION,'0'),nvl(WTP_SIZE,'0'),nvl(UNITS_STANDBY,'0'), "
								+ " nvl(FREQ_SAND_SCRAP,'0'),CHK_FILTER from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_WTP_SC_PARAM_TBL subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "' and substr(WTPSC_CODE,20,2)='RS'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));

							if ((rs1.getString("CHK_FILTER") != null)
									&& (rs1.getString("CHK_FILTER").substring(
											0, 2)).equals("01")) {
								row.add("YES");
							} else {
								row.add("NO");
							}
							rsfilter.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("sump")) {
						query = " select SUMPCODE,nvl(subcomptbl.location,'-'),nvl(SUMP_DIAMETER,'0'),nvl(SUMP_DEPTH,'0'),nvl(SUMP_CAPACITY,'0'), nvl(SUMP_CONDITION,'-')SUMP_CONDITION from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s, RWS_AST_SUMP_M_SC_PARAM_TBL subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));

							sump.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation); 
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("ftp")) {
						query = " select BRIDGE_CODE,nvl(subcomptbl.location,'-') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s, RWS_AST_FP_BRIDGE_PARAM_TBL subcomptbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							ftp.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("pumphouse")) {
						//Debug.println("in rwc");
						query = " select PUMPHOUSE_CODE,nvl(subcomptbl.location,'-'),nvl(area,'0') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s, RWS_AST_PUMPHOUSE_PARAM_TBL subcomptbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							pumphouse.add(row);
							check = true;
						}
						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("watchman")) {

						query = " select WATCHMAN_CODE,nvl(SUBCOMPTBL.Location,'-')  from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s, RWS_AST_WATCHMAN_PARAM_TBL subcomptbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							watchman.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("cwc")) {

						query = " select CW_COLLWELL_CODE,nvl(SUBCOMPTBL.LOCATION,'-'),nvl(CAPACITY,'0') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s, RWS_AST_CW_COLLWELL_PARAM_TBL subcomptbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							cwc.add(row);
							check = true;

						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("mfilter")) {
						//Debug.println("in rwc");
						query = " select WTPSC_CODE,nvl(SUBCOMPTBL.Location,'-'),nvl(WTP_MLD,'0'),nvl(RATE_OF_FILTRATION,'0'),nvl(UNITS_NO,'0'),nvl(WTP_SIZE,'0'),nvl(UNITS_STANDBY,'0'), "
								+ " SHELTER_EXISTING,nvl(PERFORMANCE,'-'),nvl(EXTENTION_SCOPE,'-'),CHK_FILTER from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_WTP_SC_PARAM_TBL subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "' and substr(WTPSC_CODE,20,2)='MS'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							if (rs1.getString("SHELTER_EXISTING") != null
									&& rs1.getInt("SHELTER_EXISTING") == 1) {
								row.add("YES");
							} else {
								row.add("NO");
							}
							row.add(rs1.getString(9));
							row.add(rs1.getString(10));

							String chkfilter = rs1.getString("CHK_FILTER");

							if (chkfilter != null
									&& chkfilter.substring(0, 2).equals("01")) {

								row.add("YES");
							} else {
								row.add("NO");
							}
							if (chkfilter != null
									&& chkfilter.substring(2, 4).equals("02")) {

								row.add("YES");
							} else {
								row.add("NO");
							}
							if (chkfilter != null
									&& chkfilter.substring(4, 6).equals("03")) {

								row.add("YES");
							} else {
								row.add("NO");
							}
							mfilter.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("roplants")) {
						//Debug.println("in rwc");
						query = " select WTPSC_CODE,nvl(SUBCOMPTBL.Location,'-'),nvl(WTP_MLD,'0'),nvl(UNITS_NO,'0'),nvl(RATE_OF_FILTRATION,'0'),nvl(UNITS_STANDBY,'0'), "
								+ "RWS_TANK_EXISTING,PWS_TANK_EXISTING,SHELTER_EXISTING from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_WTP_SC_PARAM_TBL subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "' and substr(WTPSC_CODE,20,2)='RP'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));

							if (rs1.getString("RWS_TANK_EXISTING") != null
									&& rs1.getInt("RWS_TANK_EXISTING") == 1) {
								row.add("YES");
							} else {
								row.add("NO");
							}
							if (rs1.getString("PWS_TANK_EXISTING") != null
									&& rs1.getInt("PWS_TANK_EXISTING") == 1) {
								row.add("YES");
							} else {
								row.add("NO");
							}
							if (rs1.getString("SHELTER_EXISTING") != null
									&& rs1.getInt("SHELTER_EXISTING") == 1) {
								row.add("YES");
							} else {
								row.add("NO");
							}
							roplants.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("pumpingmain")) {
						//Debug.println("in rwc");
						query = " select PUMPINGMAIN_CODE,nvl(AIRVALVE_NO,'0'),nvl(SCOUREVALVE,'0'),nvl(REFLEXVALVE,'0'),nvl(SLUICEVALVE,'0'),nvl(NO_OF_PIPES,'0'),nvl(ZERO_VELOCITY_VALVE,'0'),nvl(AIR_CUSHION_VALVE,'0'),nvl(NON_RETURN_VALVE,'0') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s, RWS_AST_PUMPINGMAIN_TBL  subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {

							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							row.add(rs1.getString(9));
							pumpmain.add(row);
							check = true;

						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("gravitymain")) {
						//Debug.println("in rwc");
						query = " select GRAVITYMAIN_CODE,nvl(LENGTH,'0'),nvl(AIRVALVE_NO,'0'),nvl(SCOUREVALVE,'0'),nvl(REFLEXVALVE,'0'),nvl(SLUICEVALVE,'0'),nvl(NO_OF_PIPES,'0'),nvl(ZERO_VELOCITY_VALVE,'0'),nvl(NON_RETURN_VALVE,'0'),nvl(AIR_CUSHION_VALVE,'0') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_GRAVITYMAIN_TBL  subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							row.add(rs1.getString(9));
							row.add(rs1.getString(10));
							gravitymain.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("distribution")) {
						//Debug.println("in rwc");
						query = " select DISTRISC_CODE ,nvl(NO_OF_PIPES,'0'),nvl(NO_AIRVALVES,'0'),nvl(DIS_LN,'0'),nvl(NO_SLUICEVALVES,'0'),nvl(DIS_TLC,'0') , "
								+ " nvl(NO_SCOURVALVES,'0'),decode(DIS_COVE,'Y','YES','N','NO','','-'),nvl(NO_PR_HC,'0'),nvl(DIS_BN,'0'),nvl(NO_STANDPOSTS,'0') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_DISTRI_SC_PARAM_TBL  subcomptbl WHERE "
								+ "M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							row.add(rs1.getString(9));
							row.add(rs1.getString(10));
							row.add(rs1.getString(11));
							distri.add(row);
							check = true;

						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("ohsr")) {
						//Debug.println("in rwc");
						query = " select OHSR_CODE,nvl(OHSR_LOC,'-'),nvl(OHSR_CAP_LTS,'0'),nvl(OHSR_NO_OF_FILLING,'0'),nvl(OHSR_SATGES,'0'),WATER_QTY from rws_asset_mast_tbl m,rws_asset_scheme_tbl  s, RWS_AST_OHSR_SC_PARAM_TBL  subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							if (rs1.getString("WATER_QTY") != null
									&& rs1.getString("WATER_QTY").equals("")
									&& rs1.getString("WATER_QTY").equals("Y")) {
								row.add("Safe Source");
							} else if (rs1.getString("WATER_QTY") != null
									&& rs1.getString("WATER_QTY").equals("")
									&& rs1.getString("WATER_QTY").equals("N")) {
								row.add("Not Safe Source");
							} else {
								row.add("Safe Source");
							}

							ohsr.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					//Debug.println("check after ohsr:"+check);
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("ohbr")) {
						//Debug.println("in rwc");
						query = " select OHBR_CODE,nvl(OHBR_LOC,'-'),nvl(OHBR_CAP_LTS,'0'),nvl(OHBR_SATGES,'0') from rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_OHBR_SC_PARAM_TBL  subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							ohbr.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					//Debug.println("check after ohbr:"+check);
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("glsr")) {
						//Debug.println("in rwc");
						query = " select GLSR_CODE,nvl(GLSR_LOC,'-'),nvl(GLSR_CAP_LTS,'0'),nvl(GLSR_SATGES,'0'),nvl(GLSR_NO_OF_FILLING,'0'), water_qty from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_GLSR_SC_PARAM_TBL  subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							if (rs1.getString("water_qty") != null
									&& !rs1.getString("water_qty").equals("")
									&& rs1.getString("water_qty").equals("N")) {
								row.add("Safe Source");
							} else if (rs1.getString("water_qty") != null
									&& !rs1.getString("water_qty").equals("")
									&& rs1.getString("water_qty").equals("Y")) {
								row.add("Not Safe Source");
							} else {
								row.add("Safe Source");
							}
							glsr.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("glbr")) {
						//Debug.println("in rwc");
						query = " select GLBR_CODE, nvl(GLBR_LOC,'-'),nvl(GLBR_CAP_LTS,'0'),nvl(GLBR_LWL,'0'),nvl(GLBR_MWL,'0'),nvl(GLBR_FILL_HR,'0'),nvl(GLBR_EMPTY_HR,'0') from rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_GLBR_SC_PARAM_TBL  subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							glbr.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("bpt")) {
						//Debug.println("in rwc");
						query = " select BPT_CODE,nvl(subCompTbl.Location,'-'),nvl(CAPACITY,'0'),nvl(STAGING,'0') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_BPT_PARAM_TBL  subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							bpt.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("cisterns")) {
						//Debug.println("in rwc");
						query = " select CISSC_CODE,nvl(CIS_LOC,'-'),nvl(CIS_CAP_LTS,'0'),nvl(CIS_HR,'0'),decode(CIS_PF,'Y','YES','N','NO','','-'),decode(CIS_PF_CON,'B','BAD','G','GOOD','','-'),decode(CIS_DRAIN,'Y','YES','N','NO','','-'),Water_qty from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_CIS_SC_PARAM_TBL  subcomptbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							if (rs1.getString("Water_qty") != null
									&& rs1.getString("Water_qty").equals("Y")) {
								row.add("Safe Source");
							} else if (rs1.getString("Water_qty") != null
									&& rs1.getString("Water_qty").equals("N")) {
								row.add("Not Safe Source");
							} else {
								row.add("Safe Source");
							}
							cist.add(row);
							check = true;
						}
						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("miscellaneous")) {
						//Debug.println("in rwc");
						query = " select OTHER_COMP_CODE,nvl(COMP_NAME,'-'),nvl(COMP_LOCATION,'-'),nvl(subcomptbl.REMARKS,'-') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl s,RWS_AST_OTHERS_PARAM_TBL  subcomptbl "
								+ "  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));

							misl.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("chlorination")) {
						//Debug.println("in rwc");
						query = " select CL_CODE,nvl(subCompTbl.LOCATION,'-'),decode(WORKING,'Y','YES','N','NO','','-'),decode(BLEACHING_WORKING,'Y','YES','N','NO','','-'),decode(LIQUID_CHILORINE_WORKING,'Y','YES','N','NO','','-'),decode(GAS_CHILORINE_WORKING,'Y','YES','N','NO','','-'),decode(ONLINE_DOSE_WORKING,'Y','YES','N','NO','','-'),nvl(subCompTbl.REMARKS,'-') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_CHLORINATION_TBL subcomptbl  "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							chlorination.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("oandm")) {
						//Debug.println("in rwc");
						query = " select AGENCY_CODE,POWER_COST,CONSUM_ANNUM,WAGES_ANNUM,SOURCES_FUND,HOUSE_CONN, TARIFF_MONTH from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_OANDM_PARAM_TBL  subcomptbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();
						//Debug.println("in oandm");
						if (rs1.next()) {
							//Debug.println("in oandm 1");
							//row.add(rs1.getString(1));

							if (rs1.getString("AGENCY_CODE") != null
									&& rs1.getString("AGENCY_CODE").equals("1")) {
								row.add("ZP");
							}
							// Debug.println("in oandm 2");
							else if (rs1.getString("AGENCY_CODE") != null
									&& rs1.getString("AGENCY_CODE").equals("2")) {
								row.add("Mandal");
							}
							// Debug.println("in oandm 3");
							else if (rs1.getString("AGENCY_CODE") != null
									&& rs1.getString("AGENCY_CODE").equals("3")) {
								row.add("GP");
							}
							//Debug.println("in oandm 4");
							row.add(formatData(rs1.getInt("POWER_COST")));
							//Debug.println("2");
							row.add(formatData(rs1.getInt("CONSUM_ANNUM")));
							//Debug.println("3");
							row.add(formatData(rs1.getInt("WAGES_ANNUM")));
							//Debug.println("4");
							row.add(formatData(rs1.getInt("POWER_COST")
									+ rs1.getInt("CONSUM_ANNUM")
									+ rs1.getInt("WAGES_ANNUM")));
							//Debug.println("5");
							if (rs1.getString("SOURCES_FUND") != null
									&& rs1.getString("SOURCES_FUND")
											.equals("1")) {
								row.add("RWS");
							}
							//Debug.println("6");

							row.add(formatData(rs1.getInt("HOUSE_CONN")));
							//Debug.println("7");
							row.add(formatData(rs1.getInt("TARIFF_MONTH")));
							//Debug.println("8");
							row.add(formatData(rs1.getInt("TARIFF_MONTH")
									* rs1.getInt("HOUSE_CONN") * 12));
							oandm.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("pumpsets")) {
						//Debug.println("in rwc");
						query = " select PUMP_CODE,nvl(subCompTbl.LOCATION,'-'),nvl(PUMP_MAKE,'-'),nvl(PUMP_TYPE,'-'),nvl(PUMP_CPTY,'0'),nvl(YEAR_COMM,'0'),nvl(HR_RUN,'0'),nvl(USAGE,'-'),nvl(DESIGNED_HEAD,'0'),nvl(DESIGNED_LPM,'0'),nvl(POWER_AVAIL_PER_DAY,'0'),decode(LOW_VOLT_PROB,'Y','YES','N','NO','','-'),nvl(SUGGESTIONS,'-'),nvl(FEEDER,'-'),decode(GENERATOR_EXISTING,'Y','YES','N','NO','','-') from  rws_asset_mast_tbl m,rws_asset_scheme_tbl  s,RWS_AST_SUBCOMP_PARAM_TBL  subcomptbl "
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							row.add(rs1.getString(9));
							row.add(rs1.getString(10));
							row.add(rs1.getString(11));
							row.add(rs1.getString(12));
							row.add(rs1.getString(13));
							row.add(rs1.getString(14));
							row.add(rs1.getString(15));
							pumpset.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					// row.add(assetname);
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("borewells")) {
						//Debug.println("in borewells");
						query = " select HP_CODE ,nvl(subCompTbl.LOCATION,'-'),nvl(DIAMETER,'0'),nvl(DEPTH,'0'),nvl(CASING,'0'),nvl(GI_NO,'0'),nvl(PIPE_LENGTH,'0'),DECODE(GEN_CONDITION,'G','GOOD','B','BAD','','-'), nvl(STATIC_WL,'0'),nvl(SUMMER_WL,'0'),nvl(SER_HRS,'0'),nvl(SER_NO,'0'), "
								+ " decode(PAINTED,'Y','YES','N','NO','','-'),nvl(REPAIRS,'-'),DECODE(PLATFORM_EXISTING,'Y','YES','N','NO','','-'), DECODE(PLATFORM_CONDITION,'G','GOOD','B','BAD','','-'),DECODE(DRAIN,'E','EXISTS','N','NOT EXISTIS','','-'), DECODE(DRAIN_CONDITION,'G','GOOD','B','BAD','','-'), "
								+ " DECODE(DRAIN_SD,'Y','YES','N','NO','','-'),DECODE(DRAIN_LP,'E','EXISTS','Y','EXISTS','N','NOT EXISTS','','-'),  DECODE(HYGIENE,'G','GOOD','B','BAD','','-'),nvl(PYEILD_LOCAL,'-'),nvl(P_YEILD,'0'),QUALITY_AFFECTED FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"
								+ acode + "'";
						//Debug.println("Test:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1).substring(0, 19));
							System.out.println("segfgh"+rs1.getString(1).substring(0, 19));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							row.add(rs1.getString(9));
							row.add(rs1.getString(10));
							row.add(rs1.getString(11));
							row.add(rs1.getString(12));
							row.add(rs1.getString(13));
							row.add(rs1.getString(14));
							row.add(rs1.getString(15));
							row.add(rs1.getString(16));
							row.add(rs1.getString(17));
							row.add(rs1.getString(18));
							row.add(rs1.getString(19));
							row.add(rs1.getString(20));
							row.add(rs1.getString(21));
							row.add(rs1.getString(22));
							row.add(rs1.getString(23));
							if (rs1.getString("QUALITY_AFFECTED") != null
									&& !rs1.getString("QUALITY_AFFECTED")
											.equals("")
									&& rs1.getString("QUALITY_AFFECTED")
											.equals("Y")) {
								row.add("NSS");
							} else if (rs1.getString("QUALITY_AFFECTED") != null
									&& !rs1.getString("QUALITY_AFFECTED")
											.equals("")
									&& rs1.getString("QUALITY_AFFECTED")
											.equals("N")) {
								row.add("SAFE SOURCE");
							} else {
								row.add("SAFE SOURCE");
							}
							hp.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("openwells")) {
						//Debug.println("in openwells ");
						query = " select OPENWELL_CODE,subCompTbl.LOCATION,DIAMETER,DEPTH,NORMAL_WATER_LEVEL, MIN_WATER_LEVEL,MAX_WATER_LEVEL,nvl(PLATFORM_EXISTS,'-'),nvl(PURPOSE,'-'),nvl(QUALITY,'-') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							row.add(rs1.getString(9));
							row.add(rs1.getString(10));
							openwell.add(row);
							check = true;
						}
						rs1.close();
						ps.close();
					}
					//Debug.println(" shhahha:"+fieldlist);
					if (fieldlist.contains("shallowhandpumps")) {
						//Debug.println(" shhahha");
						query = " select SHALLOWHP_CODE,subCompTbl.LOCATION,DIAMETER,DEPTH,nvl(HYGIENE,'-'),AVERAGE_HOURS, AVERAGE_TIME, YIELD,nvl(WATER_QUALITY,'-') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL subCompTbl"
								+ " WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							row.add(rs1.getString(9));
							shp.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("ponds")) {
						//Debug.println("in ponds ");
						query = " select POND_CODE,FED_BY,nvl(HYGENITY,'-'),STORAGE_VOL,POND_NAME,USAGE_PURPOSE, POND_LOCATION, SIZE_AREA, WATER_QUALITY FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));
							row.add(rs1.getString(6));
							row.add(rs1.getString(7));
							row.add(rs1.getString(8));
							row.add(rs1.getString(9));
							pond.add(row);
							check = true;
						}
						rs1.close();
						ps.close();
					}
					//Debug.println("before others check");
					row = new ArrayList();
					row.add(acode);
					row.add(schemeCode);
					row.add(assetname);
					if (request.getParameter("mandal") != null
							&& request.getParameter("mandal").equals(""))
						row.add(mname);
					if (request.getParameter("panchayat") != null
							&& request.getParameter("panchayat").equals(""))
						row.add(pname);
					if (request.getParameter("village") != null
							&& request.getParameter("village").equals(""))
						row.add(vname);
					if (request.getParameter("habCode") != null
							&& request.getParameter("habCode").equals(""))
						row.add(panchcode);
						row.add(panchname);
					row.add(location);
					row.add(datecreation);
					row.add(assetstatus);
					row.add(assetcost);
					row.add(habcount);
					row.add(totpop);
					if (fieldlist.contains("otherscheck")) {
						//Debug.println("in others ");
						query = " select OTHER_COMP_CODE,SUBCOMPTBL.HAB_CODE,COMP_NAME,COMP_LOCATION,SUBCOMPTBL.REMARKS  from rws_asset_mast_tbl m,rws_asset_scheme_tbl s,RWS_AST_OTHERS_PARAM_TBL subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"
								+ acode + "'";
						//Debug.println("query:"+query);
						ps = conn.prepareStatement(query);
						rs1 = ps.executeQuery();

						if (rs1.next()) {
							row.add(rs1.getString(1));
							row.add(rs1.getString(2));
							row.add(rs1.getString(3));
							row.add(rs1.getString(4));
							row.add(rs1.getString(5));

							otherscheck.add(row);
							check = true;
						}

						rs1.close();
						ps.close();
					}

				}
			}//Debug.println("some:"+some);
			//

			if (source != null && source.size() > 0)
				rows1.add(source);
			if (source1 != null && source1.size() > 0)
				rows1.add(source1);
			if (rwc != null && rwc.size() > 0)
				rows1.add(rwc);

			if (sstank != null && sstank.size() > 0)
				rows1.add(sstank);
			if (ssfilter != null && ssfilter.size() > 0)
				rows1.add(ssfilter);
			if (rsfilter != null && rsfilter.size() > 0)
				rows1.add(rsfilter);
			if (sump != null && sump.size() > 0)
				rows1.add(sump);
			if (ftp != null && ftp.size() > 0)
				rows1.add(ftp);
			if (watchman != null && watchman.size() > 0)
				rows1.add(watchman);
			if (pumphouse != null && pumphouse.size() > 0)
				rows1.add(pumphouse);
			if (cwc != null && cwc.size() > 0)
				rows1.add(cwc);
			if (mfilter != null && mfilter.size() > 0)
				rows1.add(mfilter);
			if (roplants != null && roplants.size() > 0)
				rows1.add(roplants);
			if (pumpmain != null && pumpmain.size() > 0)
				rows1.add(pumpmain);
			if (gravitymain != null && gravitymain.size() > 0)
				rows1.add(gravitymain);
			if (distri != null && distri.size() > 0)
				rows1.add(distri);
			if (ohsr != null && ohsr.size() > 0)
				rows1.add(ohsr);
			if (ohbr != null && ohbr.size() > 0)
				rows1.add(ohbr);
			if (glsr != null && glsr.size() > 0)
				rows1.add(glsr);
			if (glbr != null && glbr.size() > 0)
				rows1.add(glbr);
			if (bpt != null && bpt.size() > 0)
				rows1.add(bpt);
			if (cist != null && cist.size() > 0)
				rows1.add(cist);
			if (misl != null && misl.size() > 0)
				rows1.add(misl);
			if (chlorination != null && chlorination.size() > 0)
				rows1.add(chlorination);
			if (oandm != null && oandm.size() > 0)
				rows1.add(oandm);
			if (pumpset != null && pumpset.size() > 0)
				rows1.add(pumpset);
			if (hp != null && hp.size() > 0)
				rows1.add(hp);
			if (openwell != null && openwell.size() > 0)
				rows1.add(openwell);
			if (pond != null && pond.size() > 0)
				rows1.add(pond);
			if (shp != null && shp.size() > 0)
				rows1.add(shp);
			if (some != null && some.size() > 0)
				rows1.add(some);
			if (otherscheck != null && otherscheck.size() > 0)
				rows1.add(otherscheck);

			dropAssetview(sessionId);
		} catch (Exception e) {
			e.printStackTrace();
			Debug.println("Exception in Asset Free Format detail Report:" + e);
		} finally {
			rs.close();
		}
		//Debug.println("check after return:"+check);
		request.setAttribute("checkvalue", "" + check);

		return rows1;
	}


//	 code added by sridhar for asset freeformat abstract report

		public ArrayList getAssetFormatData(String qry1,RwsMaster rwsm,String select,String[] fields,String creport,ArrayList columns1,String selectedFields,String sessionId,HttpServletRequest request) throws Exception
		{
			//Debug.println(" qry of circle:"+qry1);
			System.out.println(selectedFields);
			System.out.println(select);
			
			String[] selFields = selectedFields.split(",");
			ArrayList selfieldlist = new ArrayList(Arrays.asList(selFields));
			ArrayList rows1=new ArrayList();
			Statement stmt=null,stmt1=null,stmt2=null; 
			Connection conn=null;
			PreparedStatement ps=null;
			ResultSet rs=null,rs1=null,rs2=null;
			ArrayList fieldlist = new ArrayList(Arrays.asList(fields));
			
			try
			{
				conn=RwsOffices.getConn();
				
		        //Debug.println("111111111111111111111111111111111");
		    	stmt=conn.createStatement();
		    	//String assetqry="select
				// asset_name,asset_code,nvl(location,'-')location,decode(asset_status,
				// 1,'WORKING',2,'NOT
				// WORKING',3,'DRIED',4,'SEASONAL',5,'CONDEMED','','-')asset_status,asset_cost,popu_benefited,to_char(date_creation,'dd/mm/yyyy')as
				// DATE_CREATION from rws_asset_freeformat_view ";
		    	String assetqry="select a.asset_name,h.mname,h.pname,h.vname,h.panch_name,a.asset_code,nvl(a.location,'-')location,decode(a.asset_status, 1,'WORKING',2,'NOT WORKING',3,'DRIED',4,'SEASONAL',5,'CONDEMED','','-')asset_status,a.asset_cost,a.popu_benefited,to_char(a.date_creation,'dd/mm/yyyy')as DATE_CREATION,a.scheme_code from rws_asset_freeformat_view"+sessionId.substring(0,5)+" a,rws_complete_hab_view h where a.hab_code=h.panch_code";
		    	rs=stmt.executeQuery(assetqry);
		    	Debug.println("asset qry1:"+assetqry);
		    		
		    	while(rs.next()) 
		    	{ 
		    		ArrayList row=new ArrayList();  
		    		row.add(rs.getString("asset_code"));
		    		row.add(rs.getString("scheme_code"));
		    		
		    		row.add(rs.getString("ASSET_NAME"));
		    		// Debug.println("mandal:"+request.getParameter("mandal"));
		    		if(request.getParameter("mandal")!=null && request.getParameter("mandal").equals(""))
		    		row.add(rs.getString("mname")); 
		    		if(request.getParameter("panchayat")!=null && request.getParameter("panchayat").equals(""))
		    		row.add(rs.getString("pname")); 
		    		if(request.getParameter("village")!=null && request.getParameter("village").equals(""))
		    		row.add(rs.getString("vname")); 
		    		if(request.getParameter("habCode")!=null && request.getParameter("habCode").equals(""))
		    		row.add(rs.getString("panch_name")); 
		    		//Debug.println("Location on
					// request"+request.getParameter("LOCATION"));
		    		row.add(rs.getString("LOCATION"));
		    		//Debug.println("1");
		    		if(rs.getString("DATE_CREATION")!=null && !rs.getString("DATE_CREATION").equals(""))
		    		{row.add(rs.getString("DATE_CREATION"));}else {row.add("0");}
		    		//Debug.println("2");
		    		row.add(rs.getString("ASSET_STATUS"));
		    		if(rs.getString("ASSET_COST")!=null && !rs.getString("ASSET_COST").equals(""))
		    		{row.add(rs.getString("ASSET_COST"));}else{row.add("0");}
		    		
		    	 	String acode=rs.getString("ASSET_CODE");
		    	 	String totpop="",habcount="";
		    	 	
		    	 	if(rwsm.getAssettype().equals("01") || rwsm.getAssettype().equals("02") || rwsm.getAssettype().equals("03") || rwsm.getAssettype().equals("09"))
					{
						try {
						String qry3 = "select count(h.hab_code),Sum(d.census_plain_popu + d.census_st_popu + d.census_st_popu + d.FLOAT_POP) from rws_asset_mast_tbl a, rws_asset_hab_tbl h, rws_habitation_directory_tbl d where d.hab_code=h.hab_code and h.asset_code= a.asset_code and a.asset_code='"+acode+"'";
						//Debug.println("details of population query "+qry3);
						stmt2=conn.createStatement();
			    	 	rs2=stmt2.executeQuery(qry3); 
						
						if(rs2.next())
						  {
							if(rs2.getString(2)!=null && !rs2.getString(2).equals(""))
							 {totpop=rs2.getString(2);}else{totpop="0";}
							habcount=rs2.getString(1);
							row.add(habcount);
							row.add(totpop);
							
						
						}
						
						} catch (Exception e) {
							Debug.println("Error in population" + e);
						}finally{
							rs2.close();
							stmt2.close();
						}
					}
					else
					{
						 if(rs.getString("POPU_BENEFITED")!=null && !rs.getString("POPU_BENEFITED").equals(""))
						 {
						totpop=rs.getString("POPU_BENEFITED");}else{totpop="0";}
					
						habcount="1";
						row.add(habcount);
						row.add(totpop);
						
			    
					}
		    	 	String query="";
		    	 	if((!fieldlist.contains("borewells"))&&(!fieldlist.contains("openwells"))	&&
		    			(!fieldlist.contains("shallowhandpumps"))&&(!fieldlist.contains("ponds")) && (!fieldlist.contains("otherscheck"))) {
		    	 	query="select (select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"' and subCompTbl. SOURCE_TYPE_CODE ='1')a,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"' and subCompTbl. SOURCE_TYPE_CODE ='2')b,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_RW_COLLWELL_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')c,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_SS_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')d,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"' and substr(subCompTbl.WTPSC_CODE,20,2)='SS') e, (select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"' and substr(subCompTbl.WTPSC_CODE,20,2)='RS')f,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_SUMP_M_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')g,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_FP_BRIDGE_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')h,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_PUMPHOUSE_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')i,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WATCHMAN_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')j,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_CW_COLLWELL_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')k,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"' and substr(subCompTbl.WTPSC_CODE,20,2)='MS')l,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"' and substr(subCompTbl.WTPSC_CODE,20,2)='RP')m,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_PUMPINGMAIN_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')n,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GRAVITYMAIN_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')o,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_DISTRI_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')p,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')q,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OHBR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')r,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')s,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GLBR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')t,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_BPT_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')u,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_CIS_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')v,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OTHERS_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')w,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_CHLORINATION_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')x,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OANDM_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')y,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and SUBCOMPTBL.ASSET_CODE='"+acode+"')z from dual";
		    	 	ps=conn.prepareStatement(query);   
					//Debug.println("query:"+query);
					rs1=ps.executeQuery();
					if(rs1.next()) 
		    	  	{ 			    	  		
						if(fieldlist.contains("subsurface")){row.add(rs1.getString(1));}
						if(fieldlist.contains("surface")){row.add(rs1.getString(2));}
						if(fieldlist.contains("rwc")){ row.add(rs1.getString(3));}
		    			if(fieldlist.contains("sstank")){ row.add(rs1.getString(4));}
		    			if(fieldlist.contains("ssfilter")){ row.add(rs1.getString(5));}
		    			if(fieldlist.contains("rsfilter")){ row.add(rs1.getString(6));}
		    			if(fieldlist.contains("sump")){ row.add(rs1.getString(7));}
		    			if(fieldlist.contains("ftp")){ row.add(rs1.getString(8));}
		    			if(fieldlist.contains("pumphouse")){ row.add(rs1.getString(9));}
		    			if(fieldlist.contains("watchman")){ row.add(rs1.getString(10));}
		    			if(fieldlist.contains("cwc")){ row.add(rs1.getString(11));}
		    			if(fieldlist.contains("mfilter")){ row.add(rs1.getString(12));}
		    			if(fieldlist.contains("roplants")){ row.add(rs1.getString(13));}
		    			if(fieldlist.contains("pumpingmain")){ row.add(rs1.getString(14));}
		    			if(fieldlist.contains("gravitymain")){ row.add(rs1.getString(15));}
		    			if(fieldlist.contains("distribution")){ row.add(rs1.getString(16));}
		    			if(fieldlist.contains("ohsr")){ row.add(rs1.getString(17));}
		    			if(fieldlist.contains("ohbr")){ row.add(rs1.getString(18));}
		    			if(fieldlist.contains("glsr")){ row.add(rs1.getString(19));}
		    			if(fieldlist.contains("glbr")){ row.add(rs1.getString(20));}
		    			if(fieldlist.contains("bpt")){ row.add(rs1.getString(21));}
		    			if(fieldlist.contains("cisterns")){ row.add(rs1.getString(22));}
		    			if(fieldlist.contains("miscellaneous")){ row.add(rs1.getString(22));}
		    			if(fieldlist.contains("chlorination")){ row.add(rs1.getString(24));}
		    			if(fieldlist.contains("oandm")){ row.add(rs1.getString(25));}
		    			if(fieldlist.contains("pumpsets")){ row.add(rs1.getString(26));}
						
		    	  	}
					rs1.close();
		    	  	ps.close();
		    	 	} 
		    	 	 
			    	  // Debug.println("borewells:"+fieldlist.contains("borewells"));
			    	  if(fieldlist.contains("borewells"))
			    	  {
			    	  	//Debug.println(" in bore wells");
			    	  try{// query=" select count(*) from rws_borewells_view where asset_code='"+acode+"'" ;
			    	  	query="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"+acode+"'" ;
			    	  	ps=conn.prepareStatement(query);
				    	rs1=ps.executeQuery();
			    	  	 Debug.println("query:"+query); 
			    	  	 if(rs1.next())
				    	  {
				    	  	row.add(rs1.getString(1));
				    	  }
			    	  	rs1.close();
			    	  	ps.close();
			    	  }catch(Exception e)
					  {
					   Debug.println("Exception in Borewell Abstract Report:"+e);
					  }
			    	  }
			    	 // Debug.println("before shp");shallowhandpumps
			    	  if(fieldlist.contains("shallowhandpumps"))
			    	  {
			    	  	//query=" select count(*) from rws_shaollwhp_view where asset_code='"+acode+"'" ;
			    	  	query="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL subCompTbl" +
		  		    	" WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"+acode+"'" ;
			    	  	ps=conn.prepareStatement(query);
				    	rs1=ps.executeQuery();
			    	  	// Debug.println("query:"+query); 
			    	  	 if(rs1.next())
				    	  {
				    	  	row.add(rs1.getString(1));
				    	  }
			    	  	rs1.close();
			    	  	ps.close();
			    	  }
			    	  //Debug.println("before open");
			    	  if(fieldlist.contains("openwells"))
			    	  {
			    	  	//query=" select count(*) from rws_openwells_view where asset_code='"+acode+"'" ;
			    	  	query="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"+acode+"'" ;
			    	  	ps=conn.prepareStatement(query);
				    	rs1=ps.executeQuery();
			    	  	//Debug.println("query:"+query); 
			    	  	 if(rs1.next())
				    	  {
				    	  	row.add(rs1.getString(1));
				    	  }
			    	  	rs1.close();
			    	  	ps.close();
			    	  }
			    	 // Debug.println("before ponds");
			    	  if(fieldlist.contains("ponds"))
			    	  {
			    	  	//query=" select count(*) from rws_ponds_view where asset_code='"+acode+"'" ;
			    	  	query="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE  and m.asset_code='"+acode+"'" ;
			    	  	ps=conn.prepareStatement(query);
				    	rs1=ps.executeQuery();
			    	  	//Debug.println("query:"+query); 
			    	  	 if(rs1.next())
				    	  {
				    	  	row.add(rs1.getString(1));
				    	  }
			    	  	rs1.close();
			    	  	ps.close();
			    	  }
			    	  //Debug.println("before otherscheck");
			    	  if(fieldlist.contains("otherscheck"))
			    	  {
			    	  	//query=" select count(*) from rws_otherscheck_view where asset_code='"+acode+"'" ;
			    	  	query="select count(*) from rws_asset_mast_tbl m,rws_asset_scheme_tbl s,RWS_AST_OTHERS_PARAM_TBL subcomptbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.asset_code='"+acode+"'" ;
			    	  	ps=conn.prepareStatement(query);
				    	rs1=ps.executeQuery();
			    	  	//Debug.println("query:"+query); 
			    	  	 if(rs1.next())
				    	  {
				    	  	row.add(rs1.getString(1));
				    	  }
			    	  	rs1.close();
			    	  	ps.close();
			    	  }
			    	 // Debug.println("after otherscheck"); 
			     rows1.add(row);
			     //Debug.println("rows1 size:"+rows1.size());
		    	 }
		    	 dropAssetview(sessionId);
		    
		 }catch(Exception e)
		{
		Debug.println("Exception getting in AssetFree Format method:"+e);
		}finally
		{
			rs.close();
			stmt.close();
		 	conn.close();	
		}
		columns1.add("SNo");
		columns1.add("Asset Code");
		columns1.add("Scheme Code");
		columns1.add("Asset Name");
		if(request.getParameter("mandal")!=null && request.getParameter("mandal").equals(""))
		columns1.add("Mandal Name");
		if(request.getParameter("panchayat")!=null && request.getParameter("panchayat").equals(""))
		columns1.add("Panchayat Name");
		if(request.getParameter("village")!=null && request.getParameter("village").equals(""))
		columns1.add("Village Name");
		if(request.getParameter("habCode")!=null && request.getParameter("habCode").equals(""))
		columns1.add("Habitation Name");
		columns1.add("Asset Location");
		columns1.add("Date Creation");
		columns1.add("Asset Status");
		columns1.add("Asset Cost");
		columns1.add("No of Habs Benefited");
		columns1.add("Population Benefited");
		
		for(int i=0;i<fields.length;i++)
		 	{
				
			if(fields[i].equals("subsurface"))
		 		{
		 			columns1.add("Sub Surface");
		 		}
			if(fields[i].equals("surface"))
	 		{
	 			columns1.add("Surface");
	 		}
			if(fields[i].equals("rwc"))
	 		{
	 			columns1.add("Raw Water Collection Well");
	 		}
			if(fields[i].equals("sstank"))
	 		{
	 			columns1.add("SS Tank");
	 		}
			if(fields[i].equals("ssfilter"))
	 		{
	 			columns1.add("SS Filter");
	 		}
			if(fields[i].equals("rsfilter"))
	 		{
	 			columns1.add("RS Filter");
	 		}
			if(fields[i].equals("sump"))
	 		{
	 			columns1.add("Sump");
	 		}
			
			if(fields[i].equals("ftp"))
	 		{
	 			columns1.add("Foot Path Bridge");
	 		}
			if(fields[i].equals("pumphouse"))
	 		{
	 			columns1.add("Pump House");
	 		}
			if(fields[i].equals("watchman"))
	 		{
	 			columns1.add("Watch Man Quarter");
	 		}
			if(fields[i].equals("cwc")) 
	 		{
	 			columns1.add("Clear Water Collection Well");
	 		}
			if(fields[i].equals("mfilter"))
	 		{
	 			columns1.add("Micro Filter");
	 		}
			if(fields[i].equals("roplants"))
	 		{
	 			columns1.add("Ro Plants");
	 		}
			if(fields[i].equals("pumpingmain"))
	 		{
	 			columns1.add("Pumping Main");
	 		}
			if(fields[i].equals("gravitymain"))
	 		{
	 			columns1.add("Gravity Main");
	 		}
			if(fields[i].equals("distribution"))
	 		{
	 			columns1.add("Distribution");
	 		}
			if(fields[i].equals("ohsr"))
	 		{
	 			columns1.add("Ohsr");
	 		}
			if(fields[i].equals("ohbr"))
	 		{
	 			columns1.add("Ohbr");
	 		}
			if(fields[i].equals("glsr"))
	 		{
	 			columns1.add("Glsr");
	 		}
			if(fields[i].equals("glbr"))
	 		{
	 			columns1.add("Glbr");
	 		}
			if(fields[i].equals("bpt"))
	 		{
	 			columns1.add("Bpt");
	 		}
			if(fields[i].equals("cisterns"))
	 		{
	 			columns1.add("Cisterns");
	 		}
			if(fields[i].equals("miscellaneous"))
	 		{
	 			columns1.add("Miscellaneous");
	 		}
			if(fields[i].equals("chlorination"))
	 		{
	 			columns1.add("Chlorination");
	 		}
			if(fields[i].equals("oandm"))
	 		{
	 			columns1.add("OandM");
	 		}
			if(fields[i].equals("pumpsets"))
	 		{
	 			columns1.add("PumpSets");
	 		}
			//
			if(fields[i].equals("borewells"))
	 		{
	 			columns1.add("Bore Wells");
	 		}
			if(fields[i].equals("shallowhandpumps"))
	 		{
	 			columns1.add("Shallow HandPumps");
	 		}
			if(fields[i].equals("openwells"))
	 		{
	 			columns1.add("Open Wells");
	 		}
			if(fields[i].equals("ponds"))
	 		{
	 			columns1.add("Ponds");
	 		}
			if(fields[i].equals("otherscheck"))
	 		{
	 			columns1.add("Others");
	 		}
			
		 	}
	  return rows1;
		}
		
//	 code added  by sridhar creating asset view

	public void createAssetview(String qry,String sessionId)
	{
		
		Connection con=null;
		String qry1="CREATE OR REPLACE VIEW rws_asset_freeformat_view"+sessionId.substring(0,5)+" AS "+qry+"";
		Debug.println("Query to create view:"+qry1);
	  try
		{	
			con=RwsOffices.getConn();
			stmt=con.createStatement();
			int res=stmt.executeUpdate(qry1);
			//Debug.println("qry1 in create asset view:"+qry1);
			Debug.println("View is Created...");
		}
		catch (SQLException se)
		{
			Debug.println("Exception in Asset freeformat view "+se.getMessage());
		}
		finally
		{
			try{
				stmt.close();
				con.close();
			}
			catch (Exception e)
			{
				Debug.println("Exception in Asset freeformat in closing connection "+e);
				
			}
		}
	}

//	 code added by sridhar for drop asset view 

	     
	public boolean dropAssetview(String sessionId)
	{
		String qry=""; 
		Connection con=null;
		qry="drop VIEW rws_asset_freeformat_view"+sessionId.substring(0,5)+"";
		try
		{	
		con=RwsOffices.getConn();
	 	stmt=con.createStatement();
	 	//Debug.println("drop qry:"+qry);
	 	int res=stmt.executeUpdate(qry);
	 	//Debug.println("res "+res);
	    Debug.println("View is Dropped....");
	 	if(res>0)
	 		return true;
	 	else
	 		return false;
	 	
		}
		catch (SQLException se)
		{
			Debug.println("Exception in drop asset view  "+se.getMessage());
			return false;
		}
		finally
		{
		try{ 
			stmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
							Debug.println("Exception in dropViews of asset  in closing connection "+e);
								return false;
		                   }
		}
		
	}
	//

//	 code added by sridhar for asset free fromat report 

	/* public ArrayList getDateofCreation() throws Exception
	 {
	 	RwsMaster rwsMaster = new RwsMaster();
		ArrayList datecreation =new ArrayList();
		String query="";
		ResultSet rs=null;
		
		try{
		con=RwsOffices.getConn();	
		stmt=con.createStatement();
		query="select distinct to_char(date_creation,'YYYY') from rws_asset_mast_tbl where date_creation is not null  group by to_char(date_creation,'YYYY') order by 1 desc ";
		rs=stmt.executeQuery(query);
		//Debug.println("DOC Query:"+query);
		while(rs.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rs.getString(1));
			labelValueBean.setLabel(rs.getString(1));
			labelValueBean.setLabelValue(rs.getString(1));
			
		//rwsMaster.setDateofCreation(rs.getString(1));	
		datecreation.add(labelValueBean); 	
		}
		
		}catch(Exception e)
		  {
			Debug.println("Exception Get DateofCreation method  "+e.getMessage());
		}
		finally
		{
			rs.close();
			stmt.close();
					
			}
	 return datecreation;

	 }*/
	 

	public ArrayList getData(String qry3,RwsMaster rwsm,String qry31,String[] fields,String creport,String creport1,ArrayList columns1,String selectedFields,String sessionId) throws Exception
	{
		Statement stt = null,stt1 = null,sss=null,sss1=null,ssss=null,ast=null;
		Connection conn = null,conn1=null;
		ArrayList rows1=new ArrayList();
		String sanamount = "",explastamount = "",expuptoamount = "",expduramount = "",tendstatus="",aggdate="",compdate="",commdate="",tsdate="",siddate="",sidhanddate="";
		String admnno = "",admndate = "",admnamt = "",revadmnno = "",revadmndate = "",revadmnamt = "";
		String techno = "",techdate = "",techamt = "",revtechno = "",revtechdate = "",revtechamt = "";int  totalexpend =0;
		String scode = "",sname = "",hname = "",sdate = "",shdate = "",sourcename="",subsourcename="";
		String arefno = "",avalue = "",adate="",adur="",aper="",adoc="",pdoc="",updoc="",aconname="",start_date="";
		String expupto="",expdur="",totalexp="",notpaid="",preyearexp="";
		String dateofcomp = "",dateofcomm = "",benhabs = "",remarks="",handoverpri="",houseconn="",standpost="",households="";
		String land_per="",rail_per="",water_per="",road_per1="",road_per2="",forest_per="",other_per="",parta_amt="";
		String cons_name="";
		ResultSet rst1 = null;
		String[] selFields = selectedFields.split(",");
		ArrayList selfieldlist = new ArrayList(Arrays.asList(selFields));
		try 
		{
			conn=RwsOffices.getConn();
			conn1=RwsOffices.getConn();
			//stt = conn.createStatement();
			//stt1 = conn.createStatement();
			//sss = conn.createStatement();
			//ssss = conn.createStatement();
			//sss1 = conn.createStatement();
			//ast = conn.createStatement();
				ArrayList fieldlist = new ArrayList(Arrays.asList(fields));
				java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
				java.util.Date currentDate = new java.util.Date();
				String currentYear= dateFormat.format(currentDate).substring(0,4);
				String currentMonth = dateFormat.format(currentDate).substring(5,7);
				int nextYear = Integer.parseInt(currentYear);
				nextYear++;
				String nextYear1 = ""+nextYear;
				String currentYearPeriod = currentYear + "-" + nextYear1;
				java.util.Date d1 = dateFormat.parse(currentYear+"-03-31");
				String financialYearFrom="";
				String financialYearTo="";
				if(currentDate.after(d1))
				{
					financialYearFrom="01-APR-"+currentYear;
					financialYearTo="31-Mar-"+(Integer.parseInt(currentYear)+1);
				}
				else
				{
					financialYearTo="01-APR-"+(Integer.parseInt(currentYear)-1);
					financialYearFrom="31-Mar-"+currentYear;
				}
				columns1.add("Sl. No.");
				if(rwsm.getTechSancDate().equals("") && rwsm.getTsa().equals("") && rwsm.getSidDate().equals("") && rwsm.getSidhandDate().equals("") && rwsm.getConDate().equals("") && rwsm.getConDur().equals("") && rwsm.getWrkExp().equals("") && rwsm.getWrkcompDate().equals("") && rwsm.getWrkcommDate().equals(""))
				{
					createViewWorks(qry3,sessionId);
				}
				else
				{
					String tables ="";
					boolean and = true;
					String where = "";
					String [] mon = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
					if(!rwsm.getTechSancDate().equals("") || !rwsm.getTsa().equals(""))
					{
						
						tables += ",rws_new_est_tbl e";
						where += " and e.work_id = w.work_id ";
						if(!rwsm.getTechSancDate().equals(""))
						{
							String techdate1 = rwsm.getTechSancDate().substring(0,2)+"-"+mon[Integer.parseInt(rwsm.getTechSancDate().substring(3,5))-1]+"-"+rwsm.getTechSancDate().substring(6,10);
							where += " and e.ts_date "+rwsm.getTsdate_condition()+" '"+techdate1+"' ";
						}
						if(!rwsm.getTsa().equals(""))
						{
							where += " and e.ts_amount "+rwsm.getTsa_condition()+" '"+rwsm.getTsa()+"'";
						}
					}
					if(!rwsm.getSidDate().equals("") || !rwsm.getSidhandDate().equals(""))
					{
						
						tables += ",rws_source_iden_fin_tbl si";
						where += " and si.work_id = w.work_id ";
						if(!rwsm.getSidDate().equals(""))
						{
							String techdate1 = rwsm.getSidDate().substring(0,2)+"-"+mon[Integer.parseInt(rwsm.getSidDate().substring(3,5))-1]+"-"+rwsm.getSidDate().substring(6,10);
							where += " and si.SITE_IDENT_DATE"+rwsm.getSid_condition()+" '"+techdate1+"' ";
						}
						if(!rwsm.getSidhandDate().equals(""))
						{
							String techdate1 = rwsm.getSidhandDate().substring(0,2)+"-"+mon[Integer.parseInt(rwsm.getSidhandDate().substring(3,5))-1]+"-"+rwsm.getSidhandDate().substring(6,10);
							where += " and si.SITE_HAND_OVER_DATE"+rwsm.getSidhand_condition()+" '"+techdate1+"' ";
						}
					}
					if(!rwsm.getConDate().equals("") || !rwsm.getConDur().equals(""))
					{
						tables += ",rws_contractor_selection_tbl c";
						where += " and c.work_id = w.work_id ";
						
						if(!rwsm.getConDate().equals(""))
						{
							String condate = rwsm.getConDate().substring(0,2)+"-"+mon[Integer.parseInt(rwsm.getConDate().substring(3,5))-1]+"-"+rwsm.getConDate().substring(6,10);
							where += " and c.agreement_date "+rwsm.getCondate_condition()+" '"+condate+"' ";
						}
						if(!rwsm.getConDur().equals(""))
						{
							where += " and c.agreement_duration "+rwsm.getCondur_condition()+" '"+rwsm.getConDur()+"' ";	
						}
					}
					if(!rwsm.getWrkExp().equals("")
							)
					{
						tables += ",rws_work_expenditure_tbl we";
						where += " and w.work_id = we.work_id and we.expenditure_upto+we.expenditure_during  "+rwsm.getWrkexp_condition()+" '"+rwsm.getWrkExp()+"'";
					}
					
					if(!rwsm.getWrkcompDate().equals("") || !rwsm.getWrkcommDate().equals(""))
					{
						tables += ",rws_work_completion_tbl wc";
						where += " and wc.work_id = w.work_id ";
						if(!rwsm.getWrkcompDate().equals(""))
						{
							String wrkcompdate = rwsm.getWrkcompDate().substring(0,2)+"-"+mon[Integer.parseInt(rwsm.getWrkcompDate().substring(3,5))-1]+"-"+rwsm.getWrkcompDate().substring(6,10);
							where += " and wc.date_of_completion "+rwsm.getWrkcompdt_condition()+" '"+wrkcompdate+"' ";
						}
						if(!rwsm.getWrkcommDate().equals(""))
						{
							String wrkcommdate = rwsm.getWrkcommDate().substring(0,2)+"-"+mon[Integer.parseInt(rwsm.getWrkcommDate().substring(3,5))-1]+"-"+rwsm.getWrkcommDate().substring(6,10);
							where += "  and wc.date_of_comm "+rwsm.getWrkcommdt_condition()+" '"+wrkcommdate+"' "; 
						}
					}
					String[] qry2 = qry3.split("where");
					//nic.watersoft.commons.Debug.println("qry2");
					
					qry2[0] += tables;
					qry2[1] += where;
					
					String finalqry = qry2[0] + " where " + qry2[1];
				//	nic.watersoft.commons.Debug.println("final qry:"+finalqry);
					ArrayList qry22 = new ArrayList(Arrays.asList(qry2));
					
					createViewWorks(finalqry,sessionId);
					
					
				}
				//nic.watersoft.commons.Debug.println("select * from work_selection_view");
				String selects = "select ";
				boolean comma = true;
				if(fieldlist.contains("WORK_ID"))
				{
					if(comma) {selects +="w.work_id";comma = false;}else selects +=",w.work_id";
				}
				if(fieldlist.contains("WORK_NAME"))
				{
					if(comma) {selects +="w.work_name";comma = false;}else selects +=",w.work_name";
				}
				if(fieldlist.contains("NO_OF_HABS"))
				{
					if(comma) {selects +="w.no_of_habs";comma = false;}else selects +=",w.no_of_habs";
				}
				if(fieldlist.contains("WORK_STATUS"))
				{
					if(comma)
					{
						selects +="CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion < '"+financialYearFrom+"' and date_of_completion is not null) THEN 'Y' ELSE 'N' END AS SPILL";
						comma = false;
					}
					else
					{
							selects +=",CASE WHEN w.ADMIN_DATE < '"+financialYearFrom+"' and w.work_id not in (select work_id from rws_work_completion_tbl where  date_of_completion < '"+financialYearFrom+"' and date_of_completion is not null) THEN 'Y' ELSE 'N' END AS SPILL";
					}
				}
				selects +=" from work_selection_view"+sessionId.substring(0,10)+" w";
				nic.watersoft.commons.Debug.println("my selects qry11111111111:"+selects);
				closeStatement(stt);
				closeResultSet(rst1);
				stt = conn.createStatement();
				closeResultSet(rst);
				rst = stt.executeQuery(selects);
				closeStatement(stt1);
				stt1 = conn.createStatement();
				closeResultSet(rst1);			
				rst1 = stt1.executeQuery("select work_id from work_selection_view"+sessionId.substring(0,10)+"");
				//nic.watersoft.commons.Debug.println("query executed"+fieldlist.size());
				for(int i = 0;i<fields.length;i++)
				{
					//Debug.println(fields[i]);
				}
				ResultSetMetaData rsmd = rst.getMetaData();
			    int noofcolumns = rsmd.getColumnCount();
			    ResultSetMetaData rsmd1 = rst1.getMetaData();
			    int noofcolumns1 = rsmd1.getColumnCount();
				String str="";
				String wc="",scheme="",prog="",sprog="",plan="",aug="",cir_name="",div_name="";
				while(rst.next() && rst1.next())
				   {
						String qry = "select distinct w.work_id,wc.category_name,sch.TYPE_OF_ASSET_NAME ,p.programme_name,sp.subprogramme_name,decode (plan_code,'1','Plan','2','Non Plan') as plan, decode(aug_new_code,'1','Main Scheme','2','Augmentation','3','Maintanance') as aug ,o.circle_office_name,o.division_office_name from rws_work_admn_tbl w,rws_work_category_tbl wc,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_asset_type_tbl sch ,rws_complete_office_view o where substr(w.office_code,2,2)=o.CIRCLE_OFFICE_CODE and substr(w.office_code,4,1)=o.division_OFFICE_CODE and  w.work_id='"+rst1.getString(1)+"' and w.category_code=wc.category_code and w.programme_code=p.programme_code and w.subprogramme_code=sp.subprogramme_code and p.programme_code=sp.programme_code and substr(w.work_id,7,2) =sch.TYPE_OF_ASSET_CODE  AND WORK_CANCEL_DT  IS  NULL order by o.circle_office_name,o.division_office_name,wc.category_name";
						closeStatement(ast);
						ast = conn.createStatement();
						ResultSet ars=null;
						closeResultSet(ars);
						ars=ast.executeQuery(qry);
						//nic.watersoft.commons.Debug.println("qry222222222222222222:"+qry);
						if(ars.next())
						{
							if(fieldlist.contains("WORK_CATEGORY"))
							{
								wc = ars.getString(2);
							}
							if(fieldlist.contains("SCHEME"))
							{
								scheme = ars.getString(3);
							}
							if(fieldlist.contains("PROGRAM"))
							{
								prog = ars.getString(4);
							}
							if(fieldlist.contains("SUBPROGRAM"))
							{
								sprog = ars.getString(5);
							}
							if(fieldlist.contains("BUDGET_TYPE"))
							{
								plan = ars.getString(6);
								//aug = ars.getString(7);
							}
							if(fieldlist.contains("WORK_TYPE"))
							{
								//plan = ars.getString(6);
								aug = ars.getString(7);
							}
							if(fieldlist.contains("CIRCLE"))
							{
								cir_name = ars.getString(8);
							}
							if(fieldlist.contains("DIVISION"))
							{
								div_name = ars.getString(9);
							}
						}
						else
						{
							if(fieldlist.contains("WORK_CATEGORY"))
							{
								wc = "-";
							}
							if(fieldlist.contains("SCHEME"))
							{
								scheme = "-";
							}
							if(fieldlist.contains("PROGRAM"))
							{
								prog = "-";
							}
							if(fieldlist.contains("SUBPROGRAM"))
							{
								sprog = "-";
							}
							if(fieldlist.contains("BUDGET_TYPE"))
							{
								plan = "-";
								//aug = "-";
							}
							if(fieldlist.contains("WORK_TYPE"))
							{
								//plan = "-";
								aug = "-";
							}
							if(fieldlist.contains("CIRCLE"))
							{
								cir_name ="-";
							}
							if(fieldlist.contains("DIVISION"))
							{
								div_name = "-";
							}
						}
					
					if(creport.equals("admin") || selfieldlist.contains("adminfields") || creport.equals("detailed"))
					{
						//<<<<<<<<<<<<Constituency
						if(fieldlist.contains("CONSTITUENCY"))
						{
							
							ResultSet r1 = null;
							Statement s1= null;
								try
								{
									closeStatement(s1);
									s1 = conn.createStatement();
									closeResultSet(r1);
									String dc=rst1.getString(1);
									String dc1=dc.substring(4,6);
									//Debug.println("dcodeinconstituency*****************************"+dc1);
									String q2="";
									
									int nohabs=rst.getInt("no_of_habs");
									//Debug.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"+nohabs);
									if(nohabs==1)
									{
                                    q2="select distinct nvl(a.constituency_name,'-'),hab_code from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_admn_hab_lnk_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"'  and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(hab_code,6,2)=a.mcode and substr(hab_code,1,2)=b.dcode and substr(hab_code,6,2)=b.mcode";
									}
									else if(nohabs==0)
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
									}
									else
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
										
									}
                                    //String code=dc.substring(6,8);
                                    //Debug.println("code<<<<<<<<<<<<<<<<"+code);
                                    
									r1 = s1.executeQuery(q2);
									//Debug.println("constituencyqry<<<<<<<<<<<<<<<<<<<<<<<<********commonfields"+q2);
									if(r1.next())
									{
										cons_name=r1.getString(1);
										
									}
									else
									{
										cons_name="-";
									}
									
									
								}
								catch(Exception e)
								{
									nic.watersoft.commons.Debug.println("Error inhouseconnections:"+e.getMessage());
								}
								finally
								{
									try
									{
										closeStatement(s1);
										closeResultSet(r1);
									}
									catch(Exception e)
									{
										e.printStackTrace();
									}
								}
						}
						
						//
						if(fieldlist.contains("ADMN_NO") || fieldlist.contains("ADMN_DATE") || fieldlist.contains("ADMN_AMT") || fieldlist.contains("REV_ADMN_NO") || fieldlist.contains("REV_ADMN_DATE") || fieldlist.contains("REV_ADMN_AMT"))
						{
							ResultSet san = null;
							ResultSet san1 = null;
							boolean comma1 = true,comma2 = true;
							try
							{
								//sss = conn.createStatement();
								String admnqry = "select ";
								String admnrevqry = "select ";
								if(fieldlist.contains("ADMN_NO"))
								{
									if(!comma1)
										admnqry += ",ADMIN_NO";
									else 
									{
										admnqry += "ADMIN_NO";comma1 = false;
									}
								}
								if(fieldlist.contains("ADMN_DATE"))
								{
									if(!comma1)
										admnqry += ",to_char(ADMIN_DATE,'dd-MON-yyyy') as adate";
									else 
									{
										admnqry += "to_char(ADMIN_DATE,'dd-MON-yyyy') as adate";comma1 = false;
									}
								}
								if(fieldlist.contains("ADMN_AMT"))
								{
									if(!comma1)
										admnqry += ",SANCTION_AMOUNT";
									else 
									{
										admnqry += "SANCTION_AMOUNT";comma1 = false;
									}
								}
								if(fieldlist.contains("REV_ADMN_NO"))
								{
									if(!comma2)
										admnrevqry += ",REV_ADMIN_NO";
									else 
									{
										admnrevqry += "REV_ADMIN_NO";comma2 = false;
									}
								}
								if(fieldlist.contains("REV_ADMN_DATE"))
								{
									if(!comma2)
										admnrevqry += ",to_char(REV_ADMIN_DATE,'dd-MON-yyyy') as revdate";
									else 
									{
										admnrevqry += "to_char(REV_ADMIN_DATE,'dd-MON-yyyy') as revdate";comma2 = false;
									}
								}
								if(fieldlist.contains("REV_ADMN_AMT"))
								{
									if(!comma2)
										admnrevqry += ",REV_SANCTION_AMOUNT";
									else 
									{
										admnrevqry += "REV_SANCTION_AMOUNT";comma2 = false;
									}
								}
								if(fieldlist.contains("ADMN_NO") || fieldlist.contains("ADMN_DATE") || fieldlist.contains("ADMN_AMT"))
								{
									admnqry += " from rws_work_admn_tbl where work_id = '"+rst1.getString(1)+"' AND WORK_CANCEL_DT  IS  NULL";
									closeStatement(sss);
									sss = conn.createStatement();
									closeResultSet(san);
									san = sss.executeQuery(admnqry);
									if(san.next())
									{
										if(fieldlist.contains("ADMN_NO"))
										{
											if(san.getString("ADMIN_NO")!= null)
												admnno = san.getString("ADMIN_NO");
											else 
												admnno = "-";
										}
										else 
											admnno = "-";
										if(fieldlist.contains("ADMN_DATE"))
										{
											if(san.getString("adate")!= null)
													admndate = san.getString("adate");
											else 
												admndate = "-";
										}	
										else 
											admndate = "-";
										if(fieldlist.contains("ADMN_AMT"))
										{
											if(san.getString("SANCTION_AMOUNT")!= null)
												admnamt = san.getString("SANCTION_AMOUNT");
											else 
												admnamt = "-";
										}
										else 
											admnamt = "-";
									}
								else
								{
									admnno = "-";
									admndate = "-";
									admnamt = "-";
								}
								}
								if(fieldlist.contains("REV_ADMN_NO") || fieldlist.contains("REV_ADMN_DATE") || fieldlist.contains("REV_ADMN_AMT"))
								{
									admnrevqry += " from rws_revised_adm_sanc_tbl where work_id = '"+rst1.getString(1)+"'";
									closeStatement(sss1);
									sss1 = conn.createStatement(); 
									closeResultSet(san1);
									san1 = sss1.executeQuery(admnrevqry);
									if(san1.next())
									{
									if(fieldlist.contains("REV_ADMN_NO"))
									{
										if(san1.getString("REV_ADMIN_NO")!= null)
											revadmnno = san1.getString("REV_ADMIN_NO");
										else 
											revadmnno = "-";
									}
									else 
										revadmnno = "-";
									if(fieldlist.contains("REV_ADMN_DATE"))
									{
										if(san1.getString("revdate")!= null)
											revadmndate = san1.getString("revdate");
										else 
											revadmndate = "-";
									}	
									else 
										revadmndate = "-";
									if(fieldlist.contains("REV_ADMN_AMT"))
									{
										if(san1.getString("REV_SANCTION_AMOUNT")!= null)
											revadmnamt = san1.getString("REV_SANCTION_AMOUNT");
										else 
											revadmnamt = "-";
									}
									else 
										revadmnamt = "-";
								}
								else
								{
									revadmnno = "-";
									revadmndate = "-";
									revadmnamt = "-";
								}
								}
							}
							catch(Exception e)
							{
								nic.watersoft.commons.Debug.println("error in admin and revised admin sanction amount:"+e.getMessage());
							}
							finally
							{
								try
								{
									closeResultSet(san);
									closeStatement(sss);
									closeResultSet(san1);
									closeStatement(sss1);
								}
								catch(Exception e)
								{
									
								}
							}
						}
					}
					if(creport.equals("technical") || selfieldlist.contains("techfields")  || creport.equals("detailed"))
					{
						//
						if(fieldlist.contains("CONSTITUENCY"))
						{
							
							ResultSet r1 = null;
							Statement s1= null;
								try
								{
									closeStatement(s1);
									s1 = conn.createStatement();
									closeResultSet(r1);
									String dc=rst1.getString(1);
									String dc1=dc.substring(4,6);
									//Debug.println("dcodeinconstituency*****************************"+dc1);
									String q2="";
									
									int nohabs=rst.getInt("no_of_habs");
									//Debug.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"+nohabs);
									if(nohabs==1)
									{
                                    q2="select distinct nvl(a.constituency_name,'-'),hab_code from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_admn_hab_lnk_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"'  and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(hab_code,6,2)=a.mcode and substr(hab_code,1,2)=b.dcode and substr(hab_code,6,2)=b.mcode";
									}
									else if(nohabs==0)
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
									}
									else
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
										
									}
                                    //String code=dc.substring(6,8);
                                    //Debug.println("code<<<<<<<<<<<<<<<<"+code);
                                    
									r1 = s1.executeQuery(q2);
									//Debug.println("constituencyqry<<<<<<<<<<<<<<<<<<<<<<<<********commonfields"+q2);
									if(r1.next())
									{
										cons_name=r1.getString(1);
										
									}
									else
									{
										cons_name="-";
									}
									
									
								}
								catch(Exception e)
								{
									nic.watersoft.commons.Debug.println("Error inhouseconnections:"+e.getMessage());
								}
								finally
								{
									try
									{
										closeStatement(s1);
										closeResultSet(r1);
									}
									catch(Exception e)
									{
										e.printStackTrace();
									}
								}
						}
					
						//
						if(fieldlist.contains("TECH_NO") || fieldlist.contains("TECH_DATE") || fieldlist.contains("TECH_AMT") || fieldlist.contains("REV_TECH_NO") || fieldlist.contains("REV_TECH_DATE") || fieldlist.contains("REV_TECH_AMT"))
						{
						ResultSet san = null;
						ResultSet san1 = null;
						boolean comma1 = true,comma2 = true;
						try
						{
							String admnqry = "select ";
							String admnrevqry = "select ";
							if(fieldlist.contains("TECH_NO"))
							{
								if(!comma1)
									admnqry += ",TS_NO";
								else 
								{
									admnqry += "TS_NO";comma1 = false;
								}
							}
							if(fieldlist.contains("TECH_DATE"))
							{
								if(!comma1)
									admnqry += ",to_char(TS_DATE,'dd-MON-yyyy') as tdate ";
								else 
								{
									admnqry += "to_char(TS_DATE,'dd-MON-yyyy') as tdate ";comma1 = false;
								}
							}
							if(fieldlist.contains("TECH_AMT"))
							{
								if(!comma1)
									admnqry += ",TS_AMOUNT";
								else 
								{
									admnqry += "TS_AMOUNT";comma1 = false;
								}
							}
							if(fieldlist.contains("REV_TECH_NO"))
							{
								if(!comma2)
									admnrevqry += ",REV_TS_NO";
								else 
								{
									admnrevqry += "REV_TS_NO";comma2 = false;
								}
							}
							if(fieldlist.contains("REV_TECH_DATE"))
							{
								if(!comma2)
									admnrevqry += ",to_char(REV_TS_DATE,'dd-MON-yyyy') as revdate";
								else 
								{
									admnrevqry += "to_char(REV_TS_DATE,'dd-MON-yyyy') as revdate";comma2 = false;
								}
							}
							if(fieldlist.contains("REV_TECH_AMT"))
							{
								if(!comma2)
									admnrevqry += ",TS_AMOUNT";
								else 
								{
									admnrevqry += "TS_AMOUNT";comma2 = false;
								}
							}
							if(fieldlist.contains("TECH_NO") || fieldlist.contains("TECH_DATE") || fieldlist.contains("TECH_AMT"))
							{
								admnqry += " from rws_new_est_tbl where work_id = '"+rst1.getString(1)+"'";
								closeStatement(sss);
								sss = conn.createStatement();
								closeResultSet(san);
								san = sss.executeQuery(admnqry);
								if(san.next())
								{
									if(fieldlist.contains("TECH_NO"))
									{
										if(san.getString("TS_NO")!= null)
											techno = san.getString("TS_NO");
										else 
											techno = "-";
									}
									else 
										techno = "-";
									if(fieldlist.contains("TECH_DATE"))
									{
										if(san.getString("tdate")!= null)
												techdate = san.getString("tdate");
										else 
											techdate = "-";
									}
									else 
										techdate = "-";
									if(fieldlist.contains("TECH_AMT"))
									{
										if(san.getString("TS_AMOUNT")!= null)
											techamt = san.getString("TS_AMOUNT");
										else 
											techamt = "-";
									}
									else 
										techamt = "-";
								}
								else
								{
									techno = "-";
									techdate = "-";
									techamt = "-";
								}
							}
							if(fieldlist.contains("REV_TECH_NO") || fieldlist.contains("REV_TECH_DATE") || fieldlist.contains("REV_TECH_AMT"))
							{
								admnrevqry += " from rws_new_revised_est_tbl where work_id = '"+rst1.getString(1)+"'";
								closeStatement(sss1);
								sss1 = conn.createStatement();
								closeResultSet(san1);
								san1 = sss1.executeQuery(admnrevqry);
								if(san1.next())
								{
									if(fieldlist.contains("REV_TECH_NO"))
									{
										if(san1.getString("REV_TS_NO")!= null)
											revtechno = san1.getString("REV_TS_NO");
										else 
											revtechno = "-";
									}
									else 
										revtechno = "-";
									if(fieldlist.contains("REV_TECH_DATE"))
									{
										if(san1.getString("revdate")!= null)
											revtechdate = san1.getString("revdate");
										else 
											revtechdate = "-";
									}
									else 
										revtechdate = "-";
									if(fieldlist.contains("REV_TECH_AMT"))
									{
										if(san1.getString("TS_AMOUNT")!= null)
											revtechamt = san1.getString("TS_AMOUNT");
										else 
											revtechamt = "-";
									}
									else 
										revtechamt = "-";
								}
								else
								{
									revtechno = "-";
									revtechdate = "-";
									revtechamt = "-";
								}
							}
						}
						catch(Exception e)
						{
							nic.watersoft.commons.Debug.println("error in admin and revised tech sanction amount:"+e.getMessage());
						}
						finally
						{
							try
							{
								closeResultSet(san);
								closeStatement(sss);
								closeResultSet(san1);
								closeStatement(sss1);
							}
							catch(Exception e)
							{
								
							}
						}
					}
					}
					if(creport.equals("source") || creport.equals("detailed"))
					{
						//
						if(fieldlist.contains("CONSTITUENCY"))
						{
							
							ResultSet r1 = null;
							Statement s1= null;
								try
								{
									closeStatement(s1);
									s1 = conn.createStatement();
									closeResultSet(r1);
									String dc=rst1.getString(1);
									String dc1=dc.substring(4,6);
									//Debug.println("dcodeinconstituency*****************************"+dc1);
									String q2="";
									
									int nohabs=rst.getInt("no_of_habs");
									//Debug.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"+nohabs);
									if(nohabs==1)
									{
                                    q2="select distinct nvl(a.constituency_name,'-'),hab_code from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_admn_hab_lnk_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"'  and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(hab_code,6,2)=a.mcode and substr(hab_code,1,2)=b.dcode and substr(hab_code,6,2)=b.mcode";
									}
									else if(nohabs==0)
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
									}
									else
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
										
									}
                                    //String code=dc.substring(6,8);
                                    //Debug.println("code<<<<<<<<<<<<<<<<"+code);
                                    
									r1 = s1.executeQuery(q2);
									//Debug.println("constituencyqry<<<<<<<<<<<<<<<<<<<<<<<<********commonfields"+q2);
									if(r1.next())
									{
										cons_name=r1.getString(1);
										
									}
									else
									{
										cons_name="-";
									}
									
									
								}
								catch(Exception e)
								{
									nic.watersoft.commons.Debug.println("Error inhouseconnections:"+e.getMessage());
								}
								finally
								{
									try
									{
										closeStatement(s1);
										closeResultSet(r1);
									}
									catch(Exception e)
									{
										e.printStackTrace();
									}
								}
						}
					
						//
						if(fieldlist.contains("SOURCE_CODE") || selfieldlist.contains("sourcefields")  || fieldlist.contains("SOURCE_NAME") || fieldlist.contains("HAB_LOCATION") || fieldlist.contains("SID_DATE")  || fieldlist.contains("HAB_LOCATION")|| fieldlist.contains("SOURCE_TYPE")|| fieldlist.contains("SUB_SOURCE_TYPE"))
					{
						ResultSet san = null;
						boolean comma1 = true,comma2 = true;
						try
						{
							String habcode = "";
							String admnqry = "select ";
							if(fieldlist.contains("SOURCE_CODE"))
							{
								if(!comma1)
									admnqry += ",SOURCE_CODE";
								else 
								{
									admnqry += "SOURCE_CODE";comma1 = false;
								}
							}
							if(fieldlist.contains("SOURCE_NAME"))
							{
								if(!comma1)
									admnqry += ",SOURCE_NAME";
								else 
								{
									admnqry += "SOURCE_NAME";comma1 = false;
								}
							}
							if(fieldlist.contains("SID_DATE"))
							{
								if(!comma1)
									admnqry += ",to_char(SITE_IDENT_DATE,'dd-MON-yyyy') as sdate";
								else 
								{
									admnqry += "to_char(SITE_IDENT_DATE,'dd-MON-yyyy') as sdate ";comma1 = false;
								}
							}
							if(fieldlist.contains("SID_HAND_DATE"))
							{
								if(!comma1)
									admnqry += ",to_char(SITE_HAND_OVER_DATE,'dd-MON-yyyy') as shdate";
								else 
								{
									admnqry += "to_char(SITE_HAND_OVER_DATE,'dd-MON-yyyy') as shdate";comma1 = false;
								}
							}
							if(fieldlist.contains("HAB_LOCATION"))
							{
								if(!comma1)
									admnqry += ",HAB_CODE";
								else 
								{
									admnqry += "HAB_CODE";comma1 = false;
								}
							}
							if(fieldlist.contains("SOURCE_TYPE"))
							{
								if(!comma1)
									admnqry += ",SOURCE_TYPE_CODE";
								else 
								{
									admnqry += "SOURCE_TYPE_CODE";comma1 = false;
								}
							}
							if(fieldlist.contains("SUB_SOURCE_TYPE"))
							{
								if(!comma1)
									admnqry += ",SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE";
								else 
								{
									admnqry += "SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE";comma1 = false;
								}
							}
							if(fieldlist.contains("SOURCE_CODE") || fieldlist.contains("SOURCE_NAME") || fieldlist.contains("HAB_LOCATION") || fieldlist.contains("SID_DATE")  || fieldlist.contains(" HAB_LOCATION"))
							{
								admnqry += " from rws_source_iden_fin_tbl where work_id = '"+rst1.getString(1)+"'";
								closeStatement(sss);
								sss = conn.createStatement();
								closeResultSet(san);
								san = sss.executeQuery(admnqry);
								if(san.next())
								{
									if(fieldlist.contains("SOURCE_CODE"))
									{
										if(san.getString("SOURCE_CODE")!= null)
										{
											scode = san.getString("SOURCE_CODE");
										}
										else 
											scode = "-";
									}
									else 
										scode = "-";
									if(fieldlist.contains("SOURCE_NAME"))
									{
										if(san.getString("SOURCE_NAME")!= null)
												sname = san.getString("SOURCE_NAME");
										else 
											sname = "-";
									}
									else 
										sname = "-";
									if(fieldlist.contains("SID_DATE"))
									{
										if(san.getString("sdate")!= null)
											sdate = san.getString("sdate");
										else 
											sdate = "-";
									}
									else 
										sdate = "-";
									if(fieldlist.contains("SID_HAND_DATE"))
									{
										if(san.getString("shdate")!= null)
												shdate = san.getString("shdate");
										else 
											shdate = "-";
									}
									else 
										shdate = "-";
									if(fieldlist.contains("HAB_LOCATION"))
									{
										
										ResultSet sss2 = null;
										if(san.getString("HAB_CODE")!= null)
										{
											habcode = san.getString("HAB_CODE");
											try
											{
												closeStatement(ssss);
												ssss = conn.createStatement();
												closeResultSet(sss2);
												sss2 = ssss.executeQuery("SELECT PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL where PANCH_CODE = '"+habcode+"'");
												if(sss2.next())
												{
													hname = sss2.getString(1);
												}
											}
											catch(Exception e)
											{
												nic.watersoft.commons.Debug.println("Error in getting habname:"+e.getMessage());
											}
											finally
											{
												try
												{
													closeResultSet(sss2);
													closeStatement(ssss);
												}
												catch(Exception e)
												{
													
												}
											}
										}
										else
											hname ="-";
									}
									else
										hname ="-";
									if(fieldlist.contains("SOURCE_TYPE"))
									{
										
										ResultSet sss2 = null;
										if(san.getString("SOURCE_TYPE_CODE")!= null)
										{
											habcode = san.getString("SOURCE_TYPE_CODE");
											try
											{
												closeStatement(ssss);
												ssss = conn.createStatement();
												closeResultSet(sss2);
												sss2 = ssss.executeQuery("SELECT SOURCE_TYPE_NAME FROM rws_source_type_tbl where SOURCE_TYPE_CODE = '"+habcode+"'");
												if(sss2.next())
												{
													sourcename = sss2.getString(1);
												}
											}
											catch(Exception e)
											{
												nic.watersoft.commons.Debug.println("Error in getting SOURCE NAME:"+e.getMessage());
											}
											finally
											{
												try
												{
													closeResultSet(sss2);
													closeStatement(ssss);
												}
												catch(Exception e)
												{
													
												}
											}
										}
										else
											sourcename ="-";
									}
									else
										sourcename ="-";
									if(fieldlist.contains("SUB_SOURCE_TYPE"))
									{
										
										ResultSet sss2 = null;
										if(san.getString("SUBSOURCE_TYPE_CODE")!= null)
										{
											habcode = san.getString("SOURCE_TYPE_CODE");
											String habcode1 = san.getString("SUBSOURCE_TYPE_CODE");
											try
											{
												closeStatement(ssss);
												ssss = conn.createStatement();
												closeResultSet(sss2);
												sss2 = ssss.executeQuery("SELECT SUBSOURCE_TYPE_NAME  FROM rws_subsource_type_tbl where SOURCE_TYPE_CODE = '"+habcode+"' and SUBSOURCE_TYPE_CODE ='"+habcode1+"'");
												if(sss2.next())
												{
													subsourcename = sss2.getString(1);
												}
											}
											catch(Exception e)
											{
												nic.watersoft.commons.Debug.println("Error in getting sub SOURCE NAME:"+e.getMessage());
											}
											finally
											{
												try
												{
													closeResultSet(sss2);
													closeStatement(ssss);
												}
												catch(Exception e)
												{
													
												}
											}
										}
										else
											subsourcename ="-";
									}
									else
										subsourcename ="-";
								}
								else
								{
									scode = "-";
									sname = "-";
									sdate = "-";
									shdate = "-";
									hname = "-";
									sourcename="-";
									subsourcename="-";
								}
							}
							
							
						}
						catch(Exception e)
						{
							nic.watersoft.commons.Debug.println("error in source identification :"+e.getMessage());
						}
						finally
						{
							try
							{
								closeResultSet(san);
								closeStatement(sss);
							}
							catch(Exception e)
							{
								
							}
						}
					}
					}
					if(creport.equals("contractor") || selfieldlist.contains("confields")  || creport.equals("detailed"))
					{
						//
						if(fieldlist.contains("CONSTITUENCY"))
						{
							
							ResultSet r1 = null;
							Statement s1= null;
								try
								{
									closeStatement(s1);
									s1 = conn.createStatement();
									closeResultSet(r1);
									String dc=rst1.getString(1);
									String dc1=dc.substring(4,6);
									//Debug.println("dcodeinconstituency*****************************"+dc1);
									String q2="";
									
									int nohabs=rst.getInt("no_of_habs");
									//Debug.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"+nohabs);
									if(nohabs==1)
									{
                                    q2="select distinct nvl(a.constituency_name,'-'),hab_code from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_admn_hab_lnk_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"'  and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(hab_code,6,2)=a.mcode and substr(hab_code,1,2)=b.dcode and substr(hab_code,6,2)=b.mcode";
									}
									else if(nohabs==0)
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
									}
									else
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
										
									}
                                    //String code=dc.substring(6,8);
                                    //Debug.println("code<<<<<<<<<<<<<<<<"+code);
                                    
									r1 = s1.executeQuery(q2);
								//	Debug.println("constituencyqry<<<<<<<<<<<<<<<<<<<<<<<<********commonfields"+q2);
									if(r1.next())
									{
										cons_name=r1.getString(1);
										
									}
									else
									{
										cons_name="-";
									}
									
									
								}
								catch(Exception e)
								{
									nic.watersoft.commons.Debug.println("Error inhouseconnections:"+e.getMessage());
								}
								finally
								{
									try
									{
										closeStatement(s1);
										closeResultSet(r1);
									}
									catch(Exception e)
									{
										e.printStackTrace();
									}
								}
						}
					
						//
						if(fieldlist.contains("AGREEMENT_REFERENCE_NO") || fieldlist.contains("AGREEMENT_VALUE") || fieldlist.contains("AGREEMENT_DATE") || fieldlist.contains("AGREEMENT_DUR") || fieldlist.contains("TENDER_PER") || fieldlist.contains("EXP_DATE_OF_COMP")|| fieldlist.contains("PROB_DATE_OF_COMP") || fieldlist.contains("CONT_NAME") || fieldlist.contains("REV_PROB_DATE"))
					{
						ResultSet san = null;
						boolean comma1 = true,comma2 = true;
						try
						{
							String admnqry = "select ";
							String admnrevqry = "select ";
							if(fieldlist.contains("AGREEMENT_REFERENCE_NO"))
							{
								if(!comma1)
									admnqry += ",AGREEMENT_REFERENCE_NO";
								else 
								{
									admnqry += "AGREEMENT_REFERENCE_NO";comma1 = false;
								}
							}
							if(fieldlist.contains("AGREEMENT_VALUE"))
							{
								if(!comma1)
									admnqry += ",AGREEMENT_VALUE";
								else 
								{
									admnqry += "AGREEMENT_VALUE";comma1 = false;
								}
							}
							if(fieldlist.contains("AGREEMENT_DATE"))
							{
								if(!comma1)
									admnqry += ",to_char(AGREEMENT_DATE,'dd-MON-yyyy') as adate";
								else 
								{
									admnqry += "to_char(AGREEMENT_DATE,'dd-MON-yyyy') as adate";comma1 = false;
								}
							}
							if(fieldlist.contains("AGREEMENT_DUR"))
							{
								if(!comma1)
									admnqry += ",AGREEMENT_DURATION";
								else 
								{
									admnqry += "AGREEMENT_DURATION";comma1 = false;
								}
							}
							if(fieldlist.contains("TENDER_PER"))
							{
								if(!comma1)
									admnqry += ",TENDER_PERCENT";
								else 
								{
									admnqry += "TENDER_PERCENT";comma1 = false;
								}
							}
							if(fieldlist.contains("EXP_DATE_OF_COMP"))
							{
								if(!comma1)
									admnqry += ",to_char(DATE_OF_COMPLETION,'dd-MON-yyyy') as cdate";
								else 
								{
									admnqry += "to_char(DATE_OF_COMPLETION,'dd-MON-yyyy') as cdate";comma1 = false;
								}
							}
							if(fieldlist.contains("PROB_DATE_OF_COMP"))
							{
								if(!comma1)
									admnqry += ",to_char(probable_date,'dd-MON-yyyy') as pdate";
								else 
								{
									admnqry += "to_char(probable_date,'dd-MON-yyyy') as pdate";comma1 = false;
								}
							}
							if(fieldlist.contains("CONT_NAME"))
							{
								if(!comma1)
									admnqry += ",C.CONTRACTOR_NAME_COMPANY as contname";
								else 
								{
									admnqry += "C.CONTRACTOR_NAME_COMPANY as contname";comma1 = false;
								}
							}
							if(fieldlist.contains("REV_PROB_DATE"))
							{
								if(!comma1)
									admnqry += ",to_char(UPDATE_PROB_DATE,'dd-MON-yyyy') as updates";
								else 
								{
									admnqry += "to_char(UPDATE_PROB_DATE,'dd-MON-yyyy') as updates";comma1 = false;
								}
							}
							if(fieldlist.contains("AGREEMENT_REFERENCE_NO") || fieldlist.contains("AGREEMENT_VALUE") || fieldlist.contains("AGREEMENT_DATE") || fieldlist.contains("AGREEMENT_DUR") || fieldlist.contains("TENDER_PER") || fieldlist.contains("EXP_DATE_OF_COMP") || fieldlist.contains("PROB_DATE_OF_COMP") || fieldlist.contains("CONT_NAME")|| fieldlist.contains("START_DATE")|| fieldlist.contains("REV_PROB_DATE"))
							{
								admnqry += " from rws_contractor_selection_tbl a";
								if(fieldlist.contains("CONT_NAME"))
								{
									admnqry+=",rws_contractor_tbl c";
								}
								admnqry += " where work_id = '"+rst1.getString(1)+"'";
								if(fieldlist.contains("CONT_NAME"))
								{
									admnqry +=" and a.CONTRACTOR_CODE=c.CONTRACTOR_CODE(+)";
								}
								//Debug.println("cont qry:"+admnqry);
								closeStatement(sss);
								sss = conn.createStatement();
								closeResultSet(san);
								san = sss.executeQuery(admnqry);
								if(san.next())
								{
									if(fieldlist.contains("AGREEMENT_REFERENCE_NO"))
									{
										if(san.getString("AGREEMENT_REFERENCE_NO")!= null)
											arefno = san.getString("AGREEMENT_REFERENCE_NO");
										else 
											arefno = "-";
									}
									else 
										arefno = "-";
									if(fieldlist.contains("AGREEMENT_VALUE"))
									{
										if(san.getString("AGREEMENT_VALUE")!= null)
												avalue = san.getString("AGREEMENT_VALUE");
										else 
											avalue = "-";
									}
									else 
										avalue = "-";
									if(fieldlist.contains("AGREEMENT_DATE"))
									{
										if(san.getString("adate")!= null)
											adate = san.getString("adate");
										else 
											adate = "-";
									}
									else 
										adate = "-";
								    if(fieldlist.contains("AGREEMENT_DUR"))
									{
										if(san.getString("AGREEMENT_DURATION")!= null)
											adur = san.getString("AGREEMENT_DURATION");
										else 
											adur = "-";
									}
									else 
										adur = "-";
									if(fieldlist.contains("TENDER_PER"))
									{
										if(san.getString("TENDER_PERCENT")!= null)
											aper = san.getString("TENDER_PERCENT");
										else 
											aper = "-";
									}	
									else 
										aper = "-";
									if(fieldlist.contains("EXP_DATE_OF_COMP"))
									{
										
										if(san.getString("cdate")!= null)
											adoc = san.getString("cdate");
										else 
											adoc = "-";
									}
									else 
										adoc = "-";
									//Debug.println("stip date:"+adoc); 
									if(fieldlist.contains("PROB_DATE_OF_COMP"))
									{
										if(san.getString("pdate")!= null)
											pdoc = san.getString("pdate");
										else 
											pdoc = "-";
									}
									else 
										pdoc = "-";
									if(fieldlist.contains("REV_PROB_DATE"))
									{
										if(san.getString("updates")!= null)
											updoc = san.getString("updates");
										else 
											updoc = "-";
									}
									else 
										updoc = "-";
									if(fieldlist.contains("CONT_NAME"))
									{
										if(san.getString("contname")!= null)
											aconname = san.getString("contname");
										else 
											aconname = "-";
									}
									else 
										aconname = "-";
								}
								else
								{
									arefno = "-";
									avalue = "-";
									adate = "-";
									adur = "-";
									aper = "-";
									adoc = "-";
									pdoc="-";
									aconname = "-";
								}
							}
						}
						catch(Exception e)
						{
							nic.watersoft.commons.Debug.println("error in wrkcompletion identification :"+e.getMessage());
						}
						finally
						{
							try
							{
								closeResultSet(san);
								closeStatement(sss);
							}
							catch(Exception e)
							{
								
							}
						}}
						if(fieldlist.contains("START_DATE"))
						{
							
							ResultSet sss2 = null;
							String aa = "select to_char(grounding_date,'dd/mm/yyyy') from rws_work_commencement_tbl where work_id = '"+rst1.getString(1)+"'";
							try
							{
								closeStatement(ssss);
								ssss = conn.createStatement();
								closeResultSet(sss2);
								sss2 = ssss.executeQuery(aa);
								if(sss2.next())
								{
									start_date = sss2.getString(1);
								}
								else
								{
									start_date = "-";
								}
							}
							catch(Exception e)
							{
								nic.watersoft.commons.Debug.println("Error in getting sub SOURCE NAME:"+e.getMessage());
							}
							finally
							{
								try
								{
									closeResultSet(sss2);
									closeStatement(ssss);
								}
								catch(Exception e)
								{
									
								}
							}
						}
						else
							start_date ="-";
					}
					if(creport.equals("workexp") || selfieldlist.contains("wrkexpfields")  || creport.equals("detailed"))
					{
						//
						if(fieldlist.contains("CONSTITUENCY"))
						{
							
							ResultSet r1 = null;
							Statement s1= null;
								try
								{
									closeStatement(s1);
									s1 = conn.createStatement();
									closeResultSet(r1);
									String dc=rst1.getString(1);
									String dc1=dc.substring(4,6);
									//Debug.println("dcodeinconstituency*****************************"+dc1);
									String q2="";
									
									int nohabs=rst.getInt("no_of_habs");
									//Debug.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"+nohabs);
									if(nohabs==1)
									{
                                    q2="select distinct nvl(a.constituency_name,'-'),hab_code from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_admn_hab_lnk_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"'  and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(hab_code,6,2)=a.mcode and substr(hab_code,1,2)=b.dcode and substr(hab_code,6,2)=b.mcode";
									}
									else if(nohabs==0)
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
									}
									else
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
										
									}
                                    //String code=dc.substring(6,8);
                                    //Debug.println("code<<<<<<<<<<<<<<<<"+code);
                                    
									r1 = s1.executeQuery(q2);
									///Debug.println("constituencyqry<<<<<<<<<<<<<<<<<<<<<<<<********commonfields"+q2);
									if(r1.next())
									{
										cons_name=r1.getString(1);
										
									}
									else
									{
										cons_name="-";
									}
									
									
								}
								catch(Exception e)
								{
									nic.watersoft.commons.Debug.println("Error inhouseconnections:"+e.getMessage());
								}
								finally
								{
									try
									{
										closeStatement(s1);
										closeResultSet(r1);
									}
									catch(Exception e)
									{
										e.printStackTrace();
									}
								}
						}
					
						//
					    float expupto1 = 0,expdur1 = 0,preyearexp1 = 0;
						if(fieldlist.contains("EXPENDITURE_UPTO") || fieldlist.contains("EXPENDITURE_DURING") || fieldlist.contains("TOTAL_EXP") || fieldlist.contains("VALUE_OF_WORK_NOT_PAID") || fieldlist.contains("EXPENDITURE_UPTO_THE_PRE_YEAR"))
					{
						Statement prev=null,curr=null;
						ResultSet san = null,prevrs=null,currrs=null;
						ExpenditureTag workwiseexpenditure;
						boolean comma1 = true,comma2 = true;
						try
						{
							String admnqry = "select ";
							if(fieldlist.contains("EXPENDITURE_UPTO") || fieldlist.contains("EXPENDITURE_DURING") || fieldlist.contains("TOTAL_EXP") || fieldlist.contains("VALUE_OF_WORK_NOT_PAID") || fieldlist.contains("EXPENDITURE_UPTO_THE_PRE_YEAR"))
							{
								//if(fieldlist.contains("TOTAL_EXP") || fieldlist.contains("EXPENDITURE_UPTO_THE_PRE_YEAR"))
								//{
									closeStatement(prev);
									prev = conn.createStatement();
									closeResultSet(prevrs);
									//prevrs = prev.executeQuery("select sum(expenditure_upto_the_pre_year) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id='"+ rst1.getString(1) + "'");
									//if(prevrs.next()){preyearexp1=prevrs.getFloat(1);}
									
									closeStatement(ssss);
									sss = conn.createStatement();
									closeResultSet(san);
									
									san = sss.executeQuery("select SUM(VOUCHER_AMT ) from rws_work_exp_voucher_tbl where work_id='"+rst1.getString(1)+"'");
									//if(san.next()){preyearexp1=san.getFloat(1);expdur1=san.getFloat(2);}
									if(san.next()){totalexpend=san.getInt(1);}
								/*BigDecimal bd = new BigDecimal(Double.toString(preyearexp1));
								bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
								preyearexp1  = Float.parseFloat("" + bd);
									
									preyearexp=""+preyearexp1;
									
									bd = new BigDecimal(Double.toString(expdur1));
								bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
								
								expdur1 = Float.parseFloat("" + bd);
								//Debug.println("2:"+expdur1);
									expdur=""+expdur1;
									
								//}
									
								//if(fieldlist.contains("EXPENDITURE_DURING"))
								//{
									/*closeStatement(curr);
									curr = conn.createStatement();
									closeResultSet(currrs);
									currrs = prev.executeQuery("select sum(total) from rws_exp_view where work_id='"+ rst1.getString(1) + "'  and year='2009-10'");
									if(currrs.next()){expdur1=currrs.getFloat(1);}
									//Debug.println("1:"+expdur1);
									bd = new BigDecimal(Double.toString(expdur1));
								bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
								
								expdur1 = Float.parseFloat("" + bd);
								//Debug.println("2:"+expdur1);
									expdur=""+expdur1;
									*/
									//totalexpend = preyearexp1 + expdur1;
									
									//BigDecimal bd = new BigDecimal(Double.toString(totalexpend));
								//bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
								//totalexpend = Float.parseFloat("" + bd);
								//}

								//workwiseexpenditure=new ExpenditureTag();
								//Debug.println("1");
								 //workwiseexpendituredata=workwiseexpenditure.findExpForOneWork(rst1.getString(1));
								// Debug.println("1:"+workwiseexpendituredata.get(0));
								 //Debug.println("2:"+workwiseexpendituredata.get(1));
								/* if(fieldlist.contains("TOTAL_EXP"))
								{
									//totalexpend = Double.parseDouble(""+workwiseexpendituredata.get(0))+ Double.parseDouble(""+workwiseexpendituredata.get(1));
									totalexpend = preyearexp1 + expdur1;
								}
								 else
								 {
									totalexpend = 0;
								 }
								 expdur=""+expdur1;
								 preyearexp=""+preyearexp1;
								 /*if(fieldlist.contains("EXPENDITURE_DURING"))
								{
								    //expdur1=Double.parseDouble(""+workwiseexpendituredata.get(1));
									expdur=""+expdur1;
								}	
								else 
								{
								expdur = "-";
								expdur1= 0;
								}
								 if(fieldlist.contains("EXPENDITURE_UPTO_THE_PRE_YEAR"))
									{
										try
										{
											//preyearexp1=Double.parseDouble(""+workwiseexpendituredata.get(0));
											//preyearexp=""+preyearexp1;
										}
										catch(Exception e)
										{
											nic.watersoft.commons.Debug.println("Error in getting pre year exp:"+e.getMessage());
										}
										finally
										{
											try
											{
												//closeResultSet(sss2);
												closeStatement(ssss);
											}
											catch(Exception e)
											{
												
											}
										}
									}
									else 
									{
										preyearexp = "-";
										preyearexp1 = 0;
									}
									/*if(fieldlist.contains("VALUE_OF_WORK_NOT_PAID"))
									{
										if(san.getString("VALUE_OF_WORK_NOT_PAID")!= null)
											notpaid = san.getString("VALUE_OF_WORK_NOT_PAID");
										else 
											notpaid = "-";
									}
									else 
										notpaid = "-";*/
							}
						//Debug.println("3");	
						}
						catch(Exception e)
						{
							nic.watersoft.commons.Debug.println("error in work expenditure:"+e.getMessage());
						    e.printStackTrace();
						}
						finally
						{
							try
							{
								closeResultSet(san);
								closeStatement(sss);
								closeResultSet(prevrs);
								closeStatement(prev);
								closeResultSet(currrs);
								closeStatement(curr);
							}
							catch(Exception e)
							{
								
							}
						}
						}
					}
					if(creport.equals("workcomp") || selfieldlist.contains("wrkcompfields")  || creport.equals("detailed"))
					{
						//
						if(fieldlist.contains("CONSTITUENCY"))
						{
							
							ResultSet r1 = null;
							Statement s1= null;
								try
								{
									closeStatement(s1);
									s1 = conn.createStatement();
									closeResultSet(r1);
									String dc=rst1.getString(1);
									String dc1=dc.substring(4,6);
									//Debug.println("dcodeinconstituency*****************************"+dc1);
									String q2="";
									
									int nohabs=rst.getInt("no_of_habs");
									//Debug.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"+nohabs);
									if(nohabs==1)
									{
                                    q2="select distinct nvl(a.constituency_name,'-'),hab_code from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_admn_hab_lnk_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"'  and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(hab_code,6,2)=a.mcode and substr(hab_code,1,2)=b.dcode and substr(hab_code,6,2)=b.mcode";
									}
									else if(nohabs==0)
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
									}
									else
									{
										q2="select distinct nvl(a.constituency_name,'-'),lead_habitation from rws_constituency_tbl a,rws_mandal_subdivision_tbl b,rws_work_admn_tbl p where a.dcode=b.dcode and a.mcode=b.mcode and a.dcode='"+dc1+"' and  substr(p.office_code,2,2)=b.circle_office_code and substr(p.office_code,4,1)=b.division_office_code  and substr(office_code,5,2)=b.subdivision_office_code and p.work_id='"+rst1.getString(1)+"' and substr(p.work_id,5,2)=a.dcode and substr(lead_habitation,6,2)=a.mcode";
										
									}
                                    //String code=dc.substring(6,8);
                                    //Debug.println("code<<<<<<<<<<<<<<<<"+code);
                                    
									r1 = s1.executeQuery(q2);
									//Debug.println("constituencyqry<<<<<<<<<<<<<<<<<<<<<<<<********commonfields"+q2);
									if(r1.next())
									{
										cons_name=r1.getString(1);
										
									}
									else
									{
										cons_name="-";
									}
									
									
								}
								catch(Exception e)
								{
									nic.watersoft.commons.Debug.println("Error inhouseconnections:"+e.getMessage());
								}
								finally
								{
									try
									{
										closeStatement(s1);
										closeResultSet(r1);
									}
									catch(Exception e)
									{
										e.printStackTrace();
									}
								}
						}
					
						//
						if(fieldlist.contains("DATE_OF_COMPLETION") || fieldlist.contains("DATE_OF_COMM") || fieldlist.contains("BENFITTED_HABS")|| fieldlist.contains("PHY_REMARKS") || fieldlist.contains("HAND_OVER_PRI"))
					{
						ResultSet san = null;
						boolean comma1 = true;
						try
						{
							String admnqry = "select ";
							if(fieldlist.contains("DATE_OF_COMPLETION"))
							{
								if(!comma1)
									admnqry += ",to_char(DATE_OF_COMPLETION,'dd-MON-yyyy') as cdate";
								else 
								{
									admnqry += "to_char(DATE_OF_COMPLETION,'dd-MON-yyyy') as cdate";comma1 = false;
								}
							}
							if(fieldlist.contains("DATE_OF_COMM"))
							{
								if(!comma1)
									admnqry += ",to_char(DATE_OF_COMM,'dd-MON-yyyy') as c1date";
								else 
								{
									admnqry += "to_char(DATE_OF_COMM,'dd-MON-yyyy') as c1date";comma1 = false;
								}
							}
							if(fieldlist.contains("BENFITTED_HABS"))
							{
								if(!comma1)
									admnqry += ",work_id";
								else 
								{
									admnqry += "work_id";comma1 = false;
								}
							}
							if(fieldlist.contains("PHY_REMARKS"))
							{
								if(!comma1)
									admnqry += ",REMARKS";
								else 
								{
									admnqry += "REMARKS";comma1 = false;
								}
							}
							if(fieldlist.contains("HAND_OVER_PRI"))
							{
								if(!comma1)
									admnqry += ",decode(HANDOVER_PRI,'Y','Yes','N','No')HANDOVER_PRI";
								else 
								{
									admnqry += "decode(HANDOVER_PRI,'Y','Yes','N','No')HANDOVER_PRI";comma1 = false;
								}
							}
							
							if(fieldlist.contains("DATE_OF_COMPLETION") || fieldlist.contains("DATE_OF_COMM") || fieldlist.contains("BENFITTED_HABS")|| fieldlist.contains("PHY_REMARKS")|| fieldlist.contains("HAND_OVER_PRI"))
							{
								admnqry += " from rws_work_completion_tbl where work_id = '"+rst1.getString(1)+"'";
								//Debug.println("comp query:"+admnqry);
								closeStatement(sss);
								sss = conn.createStatement();
								closeResultSet(san);
								san = sss.executeQuery(admnqry);
								remarks="-";
								if(san.next())
								{
									if(fieldlist.contains("DATE_OF_COMPLETION"))
									{
										if(san.getString("cdate")!= null)
											dateofcomp = san.getString("cdate");
										else 
											dateofcomp = "-";
									}
									else 
										dateofcomp = "-";
									if(fieldlist.contains("DATE_OF_COMM"))
									{
										if(san.getString("c1date")!= null)
												dateofcomm = san.getString("c1date");
										else 
											dateofcomm = "-";
									}	
									else 
										dateofcomm = "-";
									
									if(fieldlist.contains("PHY_REMARKS"))
									{
										if(san.getString("REMARKS")!= null)
												remarks = san.getString("REMARKS");
										else 
											remarks = "-";
									}	
									else 
										remarks = "-";
																		if(fieldlist.contains("HAND_OVER_PRI"))
									{
										if(san.getString("HANDOVER_PRI")!= null)
										  handoverpri = san.getString("HANDOVER_PRI");
										else 
											handoverpri = "-";
										
									}	
									else 
										handoverpri = "-";

									if(fieldlist.contains("BENFITTED_HABS"))
									{
										ResultSet sss2 = null;
											try
											{
												closeStatement(ssss);
												ssss = conn.createStatement();
												closeResultSet(sss2);
											//	sss2 = ssss.executeQuery("select distinct(count(hab_code)) from RWS_EST_NEW_HAB_LNK_TBL where work_id = '"+rst1.getString(1)+"'");
												////updated by jyothi to get competed habs 
												sss2 = ssss.executeQuery("select distinct(count(hab_code)) from  RWS_WORK_COMP_HAB_LNK_TBL  where work_id = '"+rst1.getString(1)+"'");
											
												nic.watersoft.commons.Debug.println("this is jyothi::::::::::::::::::::::::::::::::::::::::::::");
												while(sss2.next())
												{
													benhabs = sss2.getString(1);
												}
												
											}
											catch(Exception e)
											{
												nic.watersoft.commons.Debug.println("Error in benifitted habs:"+e.getMessage());
											}
											finally
											{
												try
												{
													closeStatement(ssss);
													closeResultSet(sss2);
												}
												catch(Exception e)
												{
													
												}
											}
									}
									else 
										benhabs = "0";
								}	
								else
								{
									dateofcomp = "-";
									dateofcomm = "-";
									benhabs = "0";
									handoverpri = "-";
								}
							}
							//added by swapna
							if(fieldlist.contains("HOUSECONNECTIONS") || fieldlist.contains("STANDPOSTS"))
									{
										ResultSet sss3 = null;
										Statement sssss = null;
											try
											{
												closeStatement(sssss);
												sssss = conn.createStatement();
												closeResultSet(sss3);
                                                String q1="select nvl(sum(house_conn),0),nvl(sum(stand_posts),0) from RWS_WORK_COMP_HAB_LNK_TBL where work_id = '"+rst1.getString(1)+"'";
												sss3 = sssss.executeQuery(q1);
												//Debug.println("houseconnections query"+q1);
												if(sss3.next())
												{
													//Debug.println("1:"+sss3.getString(1)+" 2:"+sss3.getString(2));
													if(sss3.getString(1)!=null && sss3.getString(1).equals("0"))
														houseconn = "-";
													else
														houseconn = sss3.getString(1);
													if(sss3.getString(2)!=null && sss3.getString(2).equals("0"))
														standpost = "-";
													else
														standpost = sss3.getString(2);
													//standpost=sss3.getString(2);
												}
												else 
												{
													houseconn ="-";
                                                   standpost ="-";
												}
											}
											catch(Exception e)
											{
												nic.watersoft.commons.Debug.println("Error inhouseconnections:"+e.getMessage());
											}
											finally
											{
												try
												{
													closeStatement(sssss);
													closeResultSet(sss3);
												}
												catch(Exception e)
												{
													
												}
											}
									}
									else 
							{
										houseconn = "-";
                                          standpost = "-";
							}
							
							
							///////////////////////////////////////added by jyothi on 150414 for households display/////////////////////////////////////////////////////////////////////////////
							
							if(fieldlist.contains("HOUSEHOLDS"))
							{
								ResultSet sss2 = null;
									try
									{
										closeStatement(ssss);
										ssss = conn.createStatement();
										closeResultSet(sss2);
										sss2 = ssss.executeQuery("select nvl(sum(HOUSEHOLD_NO),0) from  rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,RWS_habitation_directory_tbl c  where a.work_id=b.work_id and b.hab_code=c.hab_code and a.work_id = '"+rst1.getString(1)+"' group by a.work_id");
									
										//nic.watersoft.commons.Debug.println("this is jyothi: for hoseholds:::::::::::::::::::::::::::::::::::::::::::select nvl(sum(HOUSEHOLD_NO),0) from  rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,RWS_habitation_directory_tbl c  where a.work_id=b.work_id and b.hab_code=c.hab_code and a.work_id group by a.work_id");
										while(sss2.next())
										{
											households = sss2.getString(1);
										}
										
									}
									catch(Exception e)
									{
										nic.watersoft.commons.Debug.println("Error in house holds :"+e.getMessage());
									}
									finally
									{
										try
										{
											closeStatement(ssss);
											closeResultSet(sss2);
										}
										catch(Exception e)
										{
											
										}
									}
							}
							else 
							{
								households = "-";
							}
						
							//////////////////////////////////200514 by jyothi/////part a details //////////////////////////////////////////////////////////////////////////////////////////
							if(fieldlist.contains("LANDAQUISITION") || fieldlist.contains("WATERDRAWLPERMISSION") || fieldlist.contains(" RAILWAYCROSSINGPERMISSION") || fieldlist.contains(" ROADCROSSINGPERMISSIONSTATE") || fieldlist.contains(" ROADCROSSINGPERMISSIONNHAI ") || fieldlist.contains("FORESTCLEARANCE ")|| fieldlist.contains("OTHERS") || fieldlist.contains("PARTA"))
							{
								ResultSet sss3 = null;
								Statement sssss = null;
									try
									{
										sssss = conn.createStatement();
										 String q1="select decode(LANDAQUISITION,'Y','Yes','N','No'),decode(WATERDRAWLPERMISSION,'Y','Yes','N','No') ,decode(RAILWAYCROSSINGPERMISSION,'Y','Yes','N','No'),decode(ROADCROSSINGPERMISSIONSTATE,'Y','Yes','N','No'), decode(ROADCROSSINGPERMISSIONNHAI,'Y','Yes','N','No') , decode(FORESTCLEARANCE,'Y','Yes','N','No'),decode(OTHERS,'Y','Yes','N','No') ,nvl(PARTAAMOUNT,'0') from RWS_NOTGROUNDWORKS_STATUS_TBL  where work_id = '"+rst1.getString(1)+"'";
										sss3 = sssss.executeQuery(q1);
										if(sss3.next())
										{
											
											land_per=sss3.getString(1);
											water_per=sss3.getString(2);
											rail_per=sss3.getString(3);
											road_per1=sss3.getString(4);
											road_per2=sss3.getString(5);
										   forest_per=sss3.getString(6);
										   other_per=sss3.getString(7);
										   parta_amt=sss3.getString(8);
										}
										else
										{
											land_per="-";
											water_per="-";
											rail_per="-";
											road_per1="-";
											road_per2="-";
										   forest_per="-";
										   other_per="-";
										   parta_amt="0";
										}
										
									}
									catch(Exception e)
									{
										nic.watersoft.commons.Debug.println("Error part a clearance:"+e.getMessage());
									}
									finally
									{
										try
										{
											closeStatement(sssss);
											closeResultSet(sss3);
										}
										catch(Exception e)
										{
											
										}
									}
							}
							else 
							{
								land_per="-";
								water_per="-";
								rail_per="-";
								road_per1="-";
								road_per2="-";
							   forest_per="-";
							   other_per="-";
							   parta_amt="0";
							}
							///////////////////////////////////////////////////////////
						}
						catch(Exception e)
						{
							nic.watersoft.commons.Debug.println("error in work completion :"+e.getMessage());
						}
						finally
						{
							try
							{
								closeResultSet(san);
								closeStatement(sss);
							}
							catch(Exception e)
							{
								
							}
						}
					}
					}
					//Debug.println("4");
					ArrayList row=new ArrayList();
					
					if(fieldlist.contains("CIRCLE"))
						row.add(cir_name);
					if(fieldlist.contains("DIVISION"))
						row.add(div_name);
					if(fieldlist.contains("CONSTITUENCY"))
						row.add(cons_name);
					
					
					if(fieldlist.contains("WORK_CATEGORY"))
							row.add(wc);
					if(fieldlist.contains("BUDGET_TYPE"))
					{
						row.add(plan);
						//row.add(aug);
					}
					if(fieldlist.contains("WORK_TYPE"))
					{
						//row.add(plan);
						row.add(aug);
					}
					//Debug.println("5");
					if(fieldlist.contains("SCHEME"))
											row.add(scheme);
					if(fieldlist.contains("PROGRAM"))
											row.add(prog);
					if(fieldlist.contains("SUBPROGRAM"))
											row.add(sprog);
					
					for (int i=1;i<=noofcolumns;i++)
					{
					//	Debug.println("5.1");
					str=rst.getString(i);
					//Debug.println("5.2");
					if(str==null || str.equals("") || str.equals(" ") || str.equals("null"))
					str="-";
					row.add(str);
					}
					if(fieldlist.contains("REMARKS"))
					{
						//Debug.println("111111111");
						
						
					ArrayList status = new ArrayList();
					Statement stmt1 = null,stmt2=null,stmt3=null;
					ResultSet rs = null,rs1 = null,rs2 = null;
						try {
							//Debug.println("2222222222");
								closeStatement(stmt1);	
								stmt1 = conn1.createStatement();
								qry = "select to_char(grounding_date,'dd/mm/yyyy') from rws_work_commencement_tbl where work_id='"+rst1.getString(1)+"'";
								closeResultSet(rs);
								rs = stmt1.executeQuery(qry);
								if(rs.next())
								{
									//Debug.println("33333333");
									String groundDate = rs.getString(1);
									closeStatement(stmt2);	
									stmt2 = conn1.createStatement();
									String qry1 = "select to_char(date_of_completion,'dd/mm/yyyy'),to_char(date_of_comm,'dd/mm/yyyy'),to_char(DT_FIN_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='"+rst1.getString(1)+"'";
									closeResultSet(rs1);
									rs1 = stmt2.executeQuery(qry1);
									if(rs1.next())
									{
										if(rs1.getString(3)!=null && !rs1.getString(3).equals(""))
										{
											status.add(0,"Financially Completed");
											status.add(1,rs1.getString(3));
										}
										else if(rs1.getString(2)!=null && !rs1.getString(2).equals(""))
										{
											status.add(0,"Commissioned");
											status.add(1,rs1.getString(2));
										}
										else if(rs1.getString(1)!=null && !rs1.getString(1).equals("")) 
										{
											status.add(0,"Completed");
											status.add(1,rs1.getString(1));
										}
										else
										{
											status.add(0,"Grounded");
											status.add(1,groundDate);
										}
									}
									else
									{
										status.add(0,"Grounded");
										status.add(1,groundDate);
									}
									
								}
								else
								{  
									status.add(0,"Not Grounded");
									//Debug.println("bbbbbbbb");
									status.add(1,"");
									//Debug.println("ccccccccc");
									closeStatement(stmt3);	
									//Debug.println("ddddddddd");
									stmt3 = conn1.createStatement();
									//Debug.println("eeeeeeeee");
									String qry1 = "select not_ground_remarks from rws_work_admn_tbl where work_id='"+rst1.getString(1)+"' AND WORK_CANCEL_DT  IS  NULL";
									//Debug.println("fffffffff");
									closeResultSet(rs2);
									//Debug.println("ggggggggggg");
									rs2 = stmt3.executeQuery(qry1);
									//Debug.println("hhhhhhh");
									//Debug.println("qry1:"+qry1);
									if(rs2.next())
									{//Debug.println("11111111");
										if(rs2.getString(1)!=null)status.add(1,rs2.getString(1));
										//Debug.println("222222222");
									}
									else 
									{ 
										//Debug.println("333333333");
										status.add(1,"");
									}
									//Debug.println("JJJJJJJJJJJJ");
									
								}
								//Debug.println("KKKKKKKK");
							} catch (Exception e) {
							Debug.println("The error in get sub hab name="+  e);
						} finally {
							try{
								closeResultSet(rs2);
								closeResultSet(rs1);
								closeResultSet(rs);
								closeStatement(stmt1);
								closeStatement(stmt2);
								closeStatement(stmt3);
								closeStatement(stmt);
								
								
						   }
						catch(Exception e)
							{
							Debug.println("getting closing ResultSet"+e);
						}
							}
						row.add(status.get(0));
					}
							
					if(fieldlist.contains("ADMN_NO"))
										row.add(admnno);
					if(fieldlist.contains("ADMN_DATE"))
											row.add(admndate);
					if(fieldlist.contains("ADMN_AMT"))
											row.add(admnamt);
					if(fieldlist.contains("REV_ADMN_NO"))
											row.add(revadmnno);
					if(fieldlist.contains("REV_ADMN_DATE"))
											row.add(revadmndate);
					if(fieldlist.contains("REV_ADMN_AMT"))
											row.add(revadmnamt);
					if(fieldlist.contains("TECH_NO"))
											row.add(techno);
					if(fieldlist.contains("TECH_DATE"))
											row.add(techdate);
					if(fieldlist.contains("TECH_AMT"))
											row.add(techamt);
					if(fieldlist.contains("REV_TECH_NO"))
											row.add(revtechno);
					if(fieldlist.contains("REV_TECH_DATE"))
											row.add(revtechdate);
					if(fieldlist.contains("REV_TECH_AMT"))
											row.add(revtechamt);
					if(fieldlist.contains("SOURCE_CODE"))
											row.add(scode);
					if(fieldlist.contains("SOURCE_NAME"))
											row.add(sname);
					if(fieldlist.contains("SOURCE_TYPE"))
											row.add(sourcename);
					if(fieldlist.contains("SUB_SOURCE_TYPE"))
											row.add(subsourcename);  
					if(fieldlist.contains("HAB_LOCATION"))
											row.add(hname);
					if(fieldlist.contains("SID_DATE"))
											row.add(sdate);
					if(fieldlist.contains("SID_HAND_DATE"))
											row.add(shdate);
					if(fieldlist.contains("AGREEMENT_REFERENCE_NO"))
											row.add(arefno);
					if(fieldlist.contains("AGREEMENT_VALUE"))
											row.add(avalue);
					if(fieldlist.contains("AGREEMENT_DATE"))
											row.add(adate);
					if(fieldlist.contains("AGREEMENT_DUR"))
											row.add(adur);
					if(fieldlist.contains("TENDER_PER"))
											row.add(aper);
					if(fieldlist.contains("EXP_DATE_OF_COMP"))
											row.add(adoc);
					if(fieldlist.contains("PROB_DATE_OF_COMP"))
											row.add(pdoc);
					if(fieldlist.contains("CONT_NAME"))
											row.add(aconname);
					if(fieldlist.contains("START_DATE"))
											row.add(start_date);
					if(fieldlist.contains("REV_PROB_DATE"))
											row.add(updoc);
					if(fieldlist.contains("EXPENDITURE_UPTO_THE_PRE_YEAR"))
											row.add(preyearexp);
					if(fieldlist.contains("EXPENDITURE_UPTO"))
											row.add(expupto);
					if(fieldlist.contains("EXPENDITURE_DURING"))
											row.add(expdur);
					/*nic.watersoft.commons.Debug.println("int :"+totalexpend);
					nic.watersoft.commons.Debug.println("INT:"+new Integer(totalexpend));
					nic.watersoft.commons.Debug.println("double :"+new Double(totalexpend));*/
					if(fieldlist.contains("TOTAL_EXP"))
											//row.add(new Float(Round(totalexpend,2)));
						row.add(new Integer(totalexpend));
					if(fieldlist.contains("VALUE_OF_WORK_NOT_PAID"))
											row.add(notpaid);
					if(fieldlist.contains("DATE_OF_COMPLETION"))
											row.add(dateofcomp);
					if(fieldlist.contains("DATE_OF_COMM"))
											row.add(dateofcomm);
					if(fieldlist.contains("BENFITTED_HABS"))
											row.add(benhabs);
					
					//added by swapna
					if(fieldlist.contains("HAND_OVER_PRI"))
						row.add(handoverpri);
					//rows1.add(row);
					if(fieldlist.contains("HOUSECONNECTIONS"))
						row.add(houseconn);
					
					if(fieldlist.contains("HOUSEHOLDS"))
						row.add(households);
					
					if(fieldlist.contains("STANDPOSTS"))
						row.add(standpost);
					
					if(fieldlist.contains("PHY_REMARKS"))
						row.add(remarks);
					
					if(fieldlist.contains("LANDAQUISITION"))
						row.add(land_per);
					if(fieldlist.contains("WATERDRAWLPERMISSION"))
						row.add(water_per);
					if(fieldlist.contains("RAILWAYCROSSINGPERMISSION"))
						row.add(rail_per);
					if(fieldlist.contains("ROADCROSSINGPERMISSIONSTATE"))
						row.add(road_per1);
					if(fieldlist.contains("ROADCROSSINGPERMISSIONNHAI"))
						row.add(road_per2); 
					if(fieldlist.contains("FORESTCLEARANCE"))
						row.add(forest_per);
					if(fieldlist.contains("OTHERS"))
						row.add(other_per);  
					if(fieldlist.contains("PARTA"))
						row.add(parta_amt);  
					
					
					
					
					
					
					
					/////////////////////////////////////////////////
					
                   //
					rows1.add(row);
				   }
				for(int i=0;i<fields.length;i++)
				{
					if(fields[i].equals("CIRCLE"))
					{
						columns1.add("CircleOffice");
					}
					if(fields[i].equals("DIVISION"))
					{
						columns1.add("DivisionOffice");
					}
					if(fields[i].equals("CONSTITUENCY"))
					{
						columns1.add("Constituency");
					}
					
					if(fields[i].equals("WORK_ID"))
					{
						columns1.add("Work Id");
					}
					if(fields[i].equals("WORK_NAME"))
					{
						columns1.add("Work Name");
					}
					if(fields[i].equals("NO_OF_HABS"))
					{
						columns1.add("No of Habs");
					}
					if(fields[i].equals("REMARKS"))
					{
						columns1.add("Remarks");
					}
					if(fields[i].equals("WORK_CATEGORY"))
					{
						columns1.add("Work Categoy");
					}
					if(fields[i].equals("SCHEME"))
					{
						columns1.add("Scheme");
					}
					if(fields[i].equals("PROGRAM"))
					{
						columns1.add("Program");
					}
					if(fields[i].equals("SUBPROGRAM"))
					{
						columns1.add("Sub Program");
					}
					if(fields[i].equals("BUDGET_TYPE"))
					{
						columns1.add("Plan/Non Plan");
						//columns1.add("MainSch/Aug./Main.");
					}
					if(fields[i].equals("WORK_TYPE"))
					{
						//columns1.add("Plan/Non Plan");
						columns1.add("MainSch/Aug./Main.");
					}
					if(fields[i].equals("WORK_STATUS"))
					{
						columns1.add("Work Status");
					}
					if(fields[i].equals("ADMN_NO"))
											columns1.add("Admin Sanc No.");
					if(fields[i].equals("ADMN_DATE"))
											columns1.add("Admin Sanc Date");
					if(fields[i].equals("ADMN_AMT"))
											columns1.add("Admin Sanc. Amount");
					if(fields[i].equals("REV_ADMN_NO"))
											columns1.add("Rev Admin Sanc No.");
					if(fields[i].equals("REV_ADMN_DATE"))
											columns1.add("Rev Admin Sanc Date");
					if(fields[i].equals("REV_ADMN_AMT"))
											columns1.add("Rev Admin Sanc Amount");
					if(fields[i].equals("TECH_NO"))
											columns1.add("Tech Sanc No.");
					if(fields[i].equals("TECH_DATE"))
											columns1.add("Tech Sanc Date");
					if(fields[i].equals("TECH_AMT"))
											columns1.add("Tech Sanc Amount");
					if(fields[i].equals("REV_TECH_NO"))
											columns1.add("Rev Tech Sanc No.");
					if(fields[i].equals("REV_TECH_DATE"))
											columns1.add("Rev Tech Sanc Date");
					if(fields[i].equals("REV_TECH_AMT"))
											columns1.add("Rev Tech Sanc Amount");
					if(fields[i].equals("SOURCE_CODE"))
											columns1.add("Source Code");
					if(fields[i].equals("SOURCE_NAME"))
											columns1.add("Source Name");
					if(fields[i].equals("HAB_LOCATION"))
											columns1.add("Habitation Location");
					if(fields[i].equals("SOURCE_TYPE"))
											columns1.add("Source Type");
					if(fields[i].equals("SUB_SOURCE_TYPE"))
											columns1.add("Sub Source Type");
					if(fields[i].equals("SID_DATE"))
											columns1.add("Site Iden. Date");
					if(fields[i].equals("SID_HAND_DATE"))
											columns1.add("Site Handover Date");
					if(fields[i].equals("AGREEMENT_REFERENCE_NO"))
											columns1.add("Agmt. Ref. No.");
					if(fields[i].equals("AGREEMENT_VALUE"))
											columns1.add("Agmt. Value");
					if(fields[i].equals("AGREEMENT_DATE"))
											columns1.add("Agmt. Date");
					if(fields[i].equals("AGREEMENT_DUR"))
											columns1.add("Agmt. Duration");
					if(fields[i].equals("TENDER_PER"))
											columns1.add("Tender Percentage");
					if(fields[i].equals("EXP_DATE_OF_COMP"))
											columns1.add("Stipulated Date Of Comp.");
					if(fields[i].equals("PROB_DATE_OF_COMP"))
											columns1.add("Probable Date Of Comp.");
					if(fields[i].equals("CONT_NAME"))
											columns1.add("Contractor Name");
					if(fields[i].equals("START_DATE"))
												columns1.add("Work Start Date");
					if(fields[i].equals("REV_PROB_DATE"))
												columns1.add("Revised Prob. Date of Comp.");
					if(fields[i].equals("EXPENDITURE_UPTO_THE_PRE_YEAR"))
											columns1.add("Exp. Upto Last Year");
					if(fields[i].equals("EXPENDITURE_UPTO"))
											columns1.add("Exp Upto this Month");
					if(fields[i].equals("EXPENDITURE_DURING"))
											columns1.add("Exp. Current Year");
					if(fields[i].equals("TOTAL_EXP"))
											columns1.add("Total Expenditure");
											
					if(fields[i].equals("VALUE_OF_WORK_NOT_PAID"))
											columns1.add("Work Done But Not Paid");
					if(fields[i].equals("DATE_OF_COMPLETION"))
											columns1.add("Date of Comp.");
					if(fields[i].equals("DATE_OF_COMM"))
											columns1.add("Date of Comm.");
					if(fields[i].equals("BENFITTED_HABS"))
											columns1.add("Benfitted Habs");
					//added by swapna
					if(fields[i].equals("HAND_OVER_PRI"))
						columns1.add("Handing Over to PRI");
					if(fields[i].equals("HOUSECONNECTIONS"))
						columns1.add("House Connections");
					if(fields[i].equals("HOUSEHOLDS"))
						columns1.add("House Holds No.");
					if(fields[i].equals("STANDPOSTS"))
						columns1.add("Stand posts");
					if(fields[i].equals("PHY_REMARKS"))
						columns1.add("Physical Stage/Remarks");
					
					if(fields[i].equals("LANDAQUISITION"))
						columns1.add("Land Aquistion");
					if(fields[i].equals("WATERDRAWLPERMISSION"))
						columns1.add("Water Drawl Permissiom");
					if(fields[i].equals("RAILWAYCROSSINGPERMISSION"))
						columns1.add("Railway crossing permission");
					if(fields[i].equals("ROADCROSSINGPERMISSIONSTATE"))
						columns1.add("State Road crossing permision");
					if(fields[i].equals("ROADCROSSINGPERMISSIONNHAI"))
						columns1.add("NHAI  Road crossing permision"); 
					if(fields[i].equals("FORESTCLEARANCE"))
						columns1.add("Forest Clearance");
					if(fields[i].equals("OTHERS"))
						columns1.add("Others");  
					if(fields[i].equals("PARTA"))
						columns1.add("Part-A Amout");  
					
			        //
				}
				/*nic.watersoft.commons.Debug.println("the values are::");
				
				nic.watersoft.commons.Debug.println(admnno);
				nic.watersoft.commons.Debug.println(admndate);
				nic.watersoft.commons.Debug.println(admnamt);
				nic.watersoft.commons.Debug.println(revadmnno);
				nic.watersoft.commons.Debug.println(revadmndate);
				nic.watersoft.commons.Debug.println(revadmnamt);
				nic.watersoft.commons.Debug.println(techno);
				nic.watersoft.commons.Debug.println(techdate);
				nic.watersoft.commons.Debug.println(techamt);
				nic.watersoft.commons.Debug.println(revtechno);
				nic.watersoft.commons.Debug.println(revtechdate);
				nic.watersoft.commons.Debug.println(revtechamt);
				nic.watersoft.commons.Debug.println(scode);
				nic.watersoft.commons.Debug.println(sname);
				nic.watersoft.commons.Debug.println(hname);
				nic.watersoft.commons.Debug.println(sdate);
				nic.watersoft.commons.Debug.println(shdate);
				nic.watersoft.commons.Debug.println(arefno);
				nic.watersoft.commons.Debug.println(avalue);
				nic.watersoft.commons.Debug.println(adate);
				nic.watersoft.commons.Debug.println(adur);
				nic.watersoft.commons.Debug.println(aper);
				nic.watersoft.commons.Debug.println(adoc);
				nic.watersoft.commons.Debug.println(expupto);
				nic.watersoft.commons.Debug.println(expdur);
				nic.watersoft.commons.Debug.println(totalexp);
				nic.watersoft.commons.Debug.println(notpaid);
				nic.watersoft.commons.Debug.println(preyearexp);
				nic.watersoft.commons.Debug.println(dateofcomp);
				nic.watersoft.commons.Debug.println(dateofcomm);
				nic.watersoft.commons.Debug.println(benhabs);*/

				dropViewWork(sessionId);
				
				nic.watersoft.commons.Debug.println("qry31 after:"+qry31);
		}
		catch (SQLException e) 
		{
			Debug.println("in Get Data method:"+e);
		}
		finally
		{
			try {
				closeStatement(stt);
				closeStatement(stt1); 
				closeStatement(sss);
				closeStatement(sss1);
				closeStatement(ssss);
				closeStatement(ast);
				closeResultSet(rst);
				closeResultSet(rst1);
				if(conn1!=null)conn1.close();
				if(conn!=null)conn.close();
				}
			catch (Exception e1) {
				e1.printStackTrace();
			}
		}
		nic.watersoft.commons.Debug.println("row size::"+rows1.size());
		return rows1;
	}
	
	public String distheaderNames(String district)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="SELECT dname FROM rws_district_tbl where dcode='"+district+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String conheaderNames(String district,String constituency)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select CONSTITUENCY_NAME from rws_constituency_tbl where DCODE = '"+district+"' and CONSTITUENCY_CODE = '"+constituency+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public String mandheaderNames(String district,String mandal)
	{
		String chead=null;
		try
		{	
		con=RwsOffices.getConn();
		
		String qry="select mname from rws_mandal_tbl where dcode = '"+district+"' and mcode = '"+mandal+"'";
	 	pstmt=con.prepareStatement(qry);
	 	rst=pstmt.executeQuery();
	 	while(rst.next())
	 	{
	 	chead=rst.getString(1);
		}
	 	}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println(se.getMessage());
		}
		finally
		{
		try{
			rst.close();
			pstmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
		                   }
		}
		return chead;
	
	}
	public void createViewWorks(String qry,String sessionId)
	{
		
		Connection con=null;
		String qry1="CREATE OR REPLACE VIEW work_selection_view"+sessionId.substring(0,10)+" AS "+qry+"";
		nic.watersoft.commons.Debug.println("Query to create view"+qry1);
      try
		{	
			con=RwsOffices.getConn();
			stmt=con.createStatement();
			int res=stmt.executeUpdate(qry1);
			nic.watersoft.commons.Debug.println("res "+res);
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in work selection view "+se.getMessage());
		}
		finally
		{
			try{
				stmt.close();
				con.close();
			}
			catch (Exception e)
			{
				nic.watersoft.commons.Debug.println("Exception in createView2 in closing connection "+e);
				
			}
		}
	}
	public void createViewWorks1(String qry)
	{
		
		Connection con=null;
		String qry1="CREATE OR REPLACE VIEW work_selection_view1 AS "+qry+"";
		nic.watersoft.commons.Debug.println("Query to create view"+qry1);
      try
		{	
			con=RwsOffices.getConn();
			stmt=con.createStatement();
			int res=stmt.executeUpdate(qry1);
			nic.watersoft.commons.Debug.println("res "+res);
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in work selection view "+se.getMessage());
		}
		finally
		{
			try{
				stmt.close();
				con.close();
			}
			catch (Exception e)
			{
				nic.watersoft.commons.Debug.println("Exception in createView2 in closing connection "+e);
				
			}
		}
	}
	public void createViewWorks2(String qry)
	{
		
		Connection con=null;
		String qry1="CREATE OR REPLACE VIEW work_selection_view2 AS "+qry+"";
		nic.watersoft.commons.Debug.println("Query to create view"+qry1);
      try
		{	
			con=RwsOffices.getConn();
			stmt=con.createStatement();
			int res=stmt.executeUpdate(qry1);
			nic.watersoft.commons.Debug.println("res "+res);
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in work selection view2 "+se.getMessage());
		}
		finally
		{
			try{
				stmt.close();
				con.close();
			}
			catch (Exception e)
			{
				nic.watersoft.commons.Debug.println("Exception in createView2 in closing connection "+e);
				
			}
		}
	}
	
	public boolean dropViewWork(String sessionId)
	{
		String qry="";
		Connection con=null;
		qry="drop VIEW work_selection_view"+sessionId.substring(0,10)+"";
		try
		{	
		con=RwsOffices.getConn();
	 	stmt=con.createStatement();
	 	int res=stmt.executeUpdate(qry);
	 	nic.watersoft.commons.Debug.println("View work_selection_view Dropped....");
	 	if(res>0)
	 		return true;
	 	else
	 		return false;
	 	
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in drop work_selection_view "+se.getMessage());
			return false;
		}
		finally
		{
		try{
			stmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
								nic.watersoft.commons.Debug.println("Exception in dropViews in closing connection "+e);
								return false;
		                   }
		}
		
	}
	public boolean dropViewWork1()
	{
		String qry="";
		Connection con=null;
		qry="drop VIEW work_selection_view1";
		try
		{	
		con=RwsOffices.getConn();
	 	stmt=con.createStatement();
	 	int res=stmt.executeUpdate(qry);
	 	nic.watersoft.commons.Debug.println("View work_selection_view1 Dropped....");
	 	if(res>0)
	 		return true;
	 	else
	 		return false;
	 	
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in drop work_selection_view1 "+se.getMessage());
			return false;
		}
		finally
		{
		try{
			stmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
								nic.watersoft.commons.Debug.println("Exception in dropViews in closing connection "+e);
								return false;
		                   }
		}
		
	}
	public boolean dropViewWork2()
	{
		String qry="";
		Connection con=null;
		qry="drop VIEW work_selection_view2";
		try
		{	
		con=RwsOffices.getConn();
	 	stmt=con.createStatement();
	 	int res=stmt.executeUpdate(qry);
	 	nic.watersoft.commons.Debug.println("View work_selection_view2 Dropped....");
	 	if(res>0)
	 		return true;
	 	else
	 		return false;
	 	
		}
		catch (SQLException se)
		{
			nic.watersoft.commons.Debug.println("Exception in drop work_selection_view2 "+se.getMessage());
			return false;
		}
		finally
		{
		try{
			stmt.close();
			con.close();
	 	    }
		catch (Exception e)
		                   {
								nic.watersoft.commons.Debug.println("Exception in dropViews in closing connection "+e);
								return false;
		                   }
		}
		
	}
	public static float Round(float Rval, int Rpl) {
		  float p = (float)Math.pow(10,Rpl);
		  Rval = Rval * p;
		  float tmp = Math.round(Rval);
		  return (float)tmp/p;
		    }
	
	
public double countLpcd(String hcode)
{
	double lpcd=0,popu=0;	
	String query="",query1="",statusDate="",CensusYear="";
	Statement stmt1=null,stmt2=null,stmt3=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	String qview="";
	int calVal=0;
	
	try{
		
	stmt2=con.createStatement();
	qview="select (census_plain_popu+census_sc_popu+census_st_popu) as popu,h.hab_code as hab_code,(to_char(h.status_date,'YYYY')-nvl(h.census_year,'0')) as calVal from rws_habitation_directory_tbl h where h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code='"+hcode+"' ";	//rs2=stmt2.executeQuery(qview);
	stmt=con.createStatement();	
	//query="select popu from lpcdview where hab_code='"+hcode+"' ";
	//Debug.println("POPU Query"+qview);
	rs=stmt.executeQuery(qview);	
	stmt1=con.createStatement();
	if(rs.next())
	{
		popu=rs.getInt(1);
		//Debug.println("TOT POPU VVALIE"+popu);
		calVal=rs.getInt(3);
		//Debug.println("calculated Value"+calVal);
			
		if(popu > 0)
		{
			try{
			query1="select round((decode(h.coverage_status,'NSS','0',HPS_OTH_SUPPLY)+nvl(PWS_SUPPLY,0)+nvl(MPWS_SUPPLY,0)+nvl(CPWS_SUPPLY,0))/('"+rs.getInt(1)+"'*power(1.01,'"+calVal+"')),2) as LPCD from rws_habitation_directory_tbl h,rws_hab_supply_status_tbl hp where h.hab_code=hp.hab_code(+) and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code='"+hcode+"' ";
			//if(!(rwsm.getTot_wat_supl().equals("")))
		//	{
					//query1+=" and round((decode(h.coverage_status,'NSS','0',HPS_OTH_SUPPLY)+nvl(PWS_SUPPLY,0)+nvl(MPWS_SUPPLY,0)+nvl(CPWS_SUPPLY,0))/('"+rs.getInt(1)+"'*power(1.01,'"+calVal+"')),2) "+rwsm.getTot_wat_supl_condition()+"'"+rwsm.getTot_wat_supl()+"' ";
			//}
			rs1=stmt1.executeQuery(query1);
			//Debug.println("LPCD QUEry"+ query1);
		
			if(rs1.next())
			{
				lpcd=rs1.getDouble(1);				
			}
			}catch(Exception e)
			{
				Debug.println("Exception inside "+e.getMessage());
			}
			finally
			{
				try
				{
				rs1.close();
				stmt1.close();
				}catch(Exception e1)
				{
					Debug.println("at close()"+e1.getMessage());
				}
			}
		}
		else 
		{
			lpcd=0;
		}
	}
	
	}catch(Exception e)
	{
		Debug.println("Exception in CountLPCD"+e.getMessage());
	}
	finally
	{
		try
		{
		//	stmt3=con.createStatement();
		//	String qviewd=" drop view lpcdview ";
		//	rs3=stmt3.executeQuery(qviewd);
			
		//	rs3.close();
		//	stmt3.close();
		//	rs2.close();
			stmt2.close();
		rs.close();
		stmt.close();	
		}catch(Exception e)
		{
			Debug.println("at Close() "+e.getMessage());
		}
	}
	
	return lpcd;
}

public boolean countLpcd1(RwsMaster rwsm,String hcode)
{
	double lpcd=0,popu=0;	
	String query="",query1="";
	Statement stmt1=null,stmt2=null,stmt3=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	String qview="";
	boolean lppp=false;
	int calVal=0;
	try{
		
	stmt2=con.createStatement();
	qview="select (census_plain_popu+census_sc_popu+census_st_popu) as popu,h.hab_code as hab_code,(to_char(h.status_date,'YYYY')-nvl(h.census_year,'0')) as calVal from rws_habitation_directory_tbl h where h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code='"+hcode+"' ";
	stmt=con.createStatement();	
	//query="select popu from lpcdview where hab_code='"+hcode+"' ";
	rs=stmt.executeQuery(qview);
	stmt1=con.createStatement();
	 
	if(rs.next())
	{
		popu=rs.getInt(1);	
		Debug.println("POPU VALUE  "+popu);
		calVal=rs.getInt(3);
		Debug.println("calculated Value"+calVal);
		if(popu > 0)
		{ 
			try{
			query1="select decode(count(*),1,'TRUE',0,'FALSE') from rws_habitation_directory_tbl h,rws_hab_supply_status_tbl hp where h.hab_code=hp.hab_code(+) and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code='"+hcode+"' and round((decode(h.coverage_status,'NSS','0',HPS_OTH_SUPPLY)+nvl(PWS_SUPPLY,0)+nvl(MPWS_SUPPLY,0)+nvl(CPWS_SUPPLY,0))/('"+rs.getInt(1)+"'*power(1.01,'"+calVal+"')),2) "+rwsm.getTot_wat_supl_condition()+"'"+rwsm.getTot_wat_supl()+"' ";
			Debug.println("LPCD QUERY"+query1);
			rs1=stmt1.executeQuery(query1);		
			while(rs1.next())
			{
				Debug.println("RETURN VALUE"+rs1.getString(1));
				if(rs1.getString(1).equalsIgnoreCase("true"))
				{
					lppp=true;
				}
				else 
				{
					lppp=false;
				}
				//lpcd=rs1.getDouble(1);				
			}
			}catch(Exception e)
			{
				Debug.println("Exception inside LPCD1 "+e.getMessage());
			}
			finally
			{
				try
				{
				rs1.close();
				stmt1.close();
				}catch(Exception e1)
				{
					Debug.println("at close()"+e1.getMessage());
				}
			}
		}
		else 
		{
			lpcd=0;
			lppp=true;
		}
	}
	
	}catch(Exception e)
	{
		Debug.println("Exception in CountLPCD"+e.getMessage());
	}
	finally
	{
		try
		{
		//	stmt3=con.createStatement();
		//	String qviewd=" drop view lpcdview ";
		//	rs3=stmt3.executeQuery(qviewd);
			
		//	rs3.close();
		//	stmt3.close();
		//	rs2.close();
		stmt2.close();
		rs.close();
		stmt.close();	
		}catch(Exception e)
		{
			Debug.println("at Close() "+e.getMessage());
		}
	}
	//Debug.println("return value of pp::: "+lppp);
	return lppp;//lpcd;
}
 





	/*
	 * 
	 * @author ramesh ends
	 *
	 */

	public static void closeConnection(Connection conn)
	{
		try
		{
			if(conn!=null)conn.close();
			if(!conn.isClosed())conn.close();
			conn=null;
		}
		catch(Exception e)
		{
			Debug.println("Close Connection Method:"+e.getMessage());
		}
		finally
		{
			try
			{
				if(conn!=null)conn.close();
				if(!conn.isClosed())conn.close();
				conn=null;
			}
			catch(Exception e)
			{
				Debug.println("Close Connection Method:"+e.getMessage());
			}
		}
	}
	
	public static void closeStatement(Statement stmt)
	{
		try
		{
			if(stmt!=null)stmt.close();
			stmt = null;
		}
		catch(Exception e)
		{
			Debug.println("Close Statement Method:"+e.getMessage());
		}
		finally
		{
			try
			{
				if(stmt!=null)stmt.close();
				stmt = null;
			}
			catch(Exception e)
			{
				Debug.println("Close Statement Method:"+e.getMessage());
			}
		}
	}
	
	public static void closeResultSet(ResultSet rs)
	{
		try
		{
			if(rs!=null)rs.close();
			rs = null;
		}
		catch(Exception e)
		{
			Debug.println("Close RS Method:"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)rs.close();
				rs = null;
			}
			catch(Exception e)
			{
				Debug.println("Close RS Method:"+e.getMessage());
			}
		}
	}
	
	
}
