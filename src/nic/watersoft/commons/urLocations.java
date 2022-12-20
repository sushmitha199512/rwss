package nic.watersoft.commons;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.masters.RwsMaster;
//import nic.watersoft.masters.RwsMasterData;

public class urLocations 
{
	private DataSource dataSource = null;
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	private String query = null;
	private PreparedStatement ps;
	private RwsLocationBean rwsLocation = null;
	private String year=null;

	
	public urLocations(DataSource dataSource)
	{
		this.dataSource = dataSource;		
	}
	
	private void closeAll()
	{
		if(rs != null)
		{
			try
			{	rs.close();
			}
			catch(SQLException sqle)
			{	// Ignore this exception
			}
		}
		if(stmt != null)
		{
			try
			{	stmt.close();
			}
			catch(SQLException sqle)
			{	// Ignore this exception
			}
		}
		if(conn != null)
		{
			try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	// Ignore this exception
			}
		}
	}

	public ArrayList getDistricts() throws Exception
	{
		
		ArrayList districts=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs =stmt.executeQuery("SELECT * FROM urban_DISTRICT_TBL ORDER BY DNAME");
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
	
				rwsLocation.setDistrictCode(rs.getString(1));
				rwsLocation.setDistrictName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				districts.add(rwsLocation);
				System.out.println("rs.............."+rs.getString(2));
				System.out.println("rs.............."+rs.getString(1));
				
			}
		System.out.println("in district pf rwslocatiion");
		}
		catch (Exception e)
		{
			//System.out.println("The error in getDistricts()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		return districts;
	}
	
	////Added for to select drought year on 20022015///
	
	
	public ArrayList getyears() throws Exception
	{
		
		ArrayList years=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs =stmt.executeQuery("select  distinct year from RWS_DROUGHT_HABITATION_TBL where year in('2012','2013','2014','2015','2016') order by year desc");
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
	
				rwsLocation.setYear(rs.getString(1));
				rwsLocation.setYear(rs.getString(1));
				rwsLocation.setCodeName(rs.getString(1)+" - "+rs.getString(1));
				years.add(rwsLocation);
			}
		System.out.println("in year pf rwslocatiion");
		}
		catch (Exception e)
		{
			//System.out.println("The error in getDistricts()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		return years;
	}
	
	/////////////ended//////////
	

	public String getDname(String dcode) throws Exception
	{    String dname=null;
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			
			rs =stmt.executeQuery("SELECT DNAME FROM urban_DISTRICT_TBL WHERE" +
					 " DCODE='"+dcode+"'");
			while ( rs.next() ) 
			{
				dname=rs.getString(1);
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in getDname() is"+e);
		}
		finally 
		{
			closeAll();
		}
		return dname;
	}
	
	public String getMname(String dcode,String mcode) throws Exception
	{    String mname=null;
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			
			rs =stmt.executeQuery("SELECT MNAME FROM urban_MANDAL_TBL WHERE" +
					 " DCODE='"+dcode+"' AND MCODE='"+mcode+"'");
			while ( rs.next() ) 
			{
				mname=rs.getString(1);
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in getMandals()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		return mname;
	}
//	added by swapna on 07-04-2011 for labs display
	public ArrayList getDivisions(String dcode) throws Exception
	{
		ArrayList divisions=new ArrayList();
		String query = null;
		try
		{
			conn = RwsOffices.getConn();
			query = "SELECT division_office_code,division_office_name FROM ur_division_office_tbl   where circle_office_code=? order by 2 ";
			//stmt = conn.createStatement();
			//rs =stmt.executeQuery("SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE" + " DCODE=? ORDER BY MNAME");
			//System.out.println("innnnn"+query);
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			Debug.println("divisionsquerysss:"+query);
			rs = ps.executeQuery();
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setDivisionCode(rs.getString(1));
				rwsLocation.setDivisionName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				divisions.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in getMandals()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		Debug.println("divisions size:"+divisions.size());
		return divisions;
	}
	
	public ArrayList getMandals(String dcode) throws Exception
	{
		ArrayList mandals=new ArrayList();
		String query = null;
		try
		{
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM urban_MANDAL_TBL WHERE" +
			 " DCODE=? ORDER BY MNAME";
			//stmt = conn.createStatement();
			//rs =stmt.executeQuery("SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE" + " DCODE=? ORDER BY MNAME");
			//System.out.println("innnnn"+query);
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			rs = ps.executeQuery();
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setDistrictCode(rs.getString(1));
				rwsLocation.setMandalCode(rs.getString(2));
				rwsLocation.setMandalName(rs.getString(3));
				rwsLocation.setCodeName(rs.getString(3)+" - "+rs.getString(2));
				mandals.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in getMandals()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		Debug.println("mandals size:"+mandals.size());
		return mandals;
	}
	public ArrayList getMandalSubdivisions(String coc,String doc,String sdoc) throws Exception
	{
		ArrayList mandalsubdivisions=new ArrayList();
		//System.out.println("coc="+coc+"doc="+doc+"sdoc="+sdoc);
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs =stmt.executeQuery("SELECT MS.DCODE,M.MCODE,M.MNAME FROM ur_SUBDIVISION_OFFICE_TBL SDO,urban_MANDAL_TBL M,urban_MANDAL_SUBDIVISION_TBL MS WHERE MS.CIRCLE_OFFICE_CODE='"+coc+"'AND MS.DIVISION_OFFICE_CODE='"+doc+"' AND SDO.SUBDIVISION_OFFICE_CODE='"+sdoc+"'"+
					" AND MS.SUBDIVISION_OFFICE_CODE='"+sdoc+"' AND SDO.CIRCLE_OFFICE_CODE='"+coc+"' AND SDO.DIVISION_OFFICE_CODE='"+doc+"' and M.DCODE=MS.DCODE and M.MCODE=MS.MCODE");
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setDistrictCode(rs.getString(1));
				rwsLocation.setMandalCode(rs.getString(2));
				rwsLocation.setMandalName(rs.getString(3));
				rwsLocation.setCodeName(rs.getString(3)+" - "+rs.getString(2));
				mandalsubdivisions.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in getMandalsSubdivisions()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		return mandalsubdivisions;
	}
	public ArrayList getPanchayats(String dcode,String mcode) throws Exception
	{
		ArrayList panchyats=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query="SELECT DISTINCT PCODE,PNAME FROM RWS_PANCHAYAT_TBL WHERE" +
			" DCODE='"+dcode+"' and MCODE='"+mcode+"' ORDER BY PNAME";
			//System.out.println("query in getPanchayats is "+query);
			rs =stmt.executeQuery(query);
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setPanchayatCode(rs.getString(1));
				rwsLocation.setPanchayatName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				panchyats.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			closeAll();
		}
		return panchyats;
	}
	public  ArrayList getVillages(String dcode,String mcode,String pcode) throws Exception
	{
		ArrayList villages=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query="SELECT DISTINCT VCODE,VNAME FROM RWS_VILLAGE_TBL WHERE" +
			" DCODE='"+dcode+"' AND MCODE='"+mcode+"' AND PCODE='"+pcode+"' ORDER BY VNAME";
			//System.out.println("query in getVillages is "+query);
			rs =stmt.executeQuery(query);
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setVillageCode(rs.getString(1));
				rwsLocation.setVillageName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				villages.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in getVillageCodes ==in== RwsLocation"+e);
		}
		finally 
		{
			closeAll();
		}
		return villages;
	}

	public  ArrayList getPanchayatHabitations1(String user,String dcode,String mcode,String pcode) throws Exception
	{
		ArrayList habs=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Debug.println("USER IS:"+user);
			String query="";
			if(user.equals("100000"))
			{
			query=" SELECT  H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL H WHERE" +
	              " SUBSTR(P.PANCH_CODE,1,2)='"+dcode+"' AND SUBSTR(P.PANCH_CODE,6,2)='"+mcode+"' AND SUBSTR(P.PANCH_CODE,13,2)='"+pcode+"' AND " +
				  " H.HAB_CODE=P.PANCH_CODE ORDER BY P.PANCH_NAME";
			}
		   else
	       {
		   query="SELECT  H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL H WHERE" +
	             " SUBSTR(P.PANCH_CODE,1,2)='"+dcode+"' AND SUBSTR(P.PANCH_CODE,6,2)='"+mcode+"' AND SUBSTR(P.PANCH_CODE,13,2)='"+pcode+"' AND " +
  				 " H.HAB_CODE=P.PANCH_CODE AND COVERAGE_STATUS <> 'UI' union SELECT  H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL H WHERE" +
	             " SUBSTR(P.PANCH_CODE,1,2)='"+dcode+"' AND SUBSTR(P.PANCH_CODE,6,2)='"+mcode+"' AND SUBSTR(P.PANCH_CODE,13,2)='"+pcode+"' AND " +
  				 " H.HAB_CODE=P.PANCH_CODE AND COVERAGE_STATUS is null ORDER BY 3";
	       }	
			Debug.println("query in getPanchayatHabitations is "+query);
			rs =stmt.executeQuery(query);
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(3)+" - "+rs.getString(2));
				String status=rs.getString(4);
				habs.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	
	
	
	public  ArrayList getPanchayatHabitations(String dcode,String mcode,String pcode) throws Exception
	{
		ArrayList habs=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query=" SELECT  H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL H WHERE" +
                         " SUBSTR(P.PANCH_CODE,1,2)='"+dcode+"' AND SUBSTR(P.PANCH_CODE,6,2)='"+mcode+"' AND SUBSTR(P.PANCH_CODE,13,2)='"+pcode+"' AND " +
				         " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' ORDER BY P.PANCH_NAME";
			query=" SELECT  PANCH_CODE,PANCH_NAME FROM RWS_COMPLETE_HAB_VIEW WHERE DCODE ='"+dcode+"' AND MCODE='"+mcode+"' AND PCODE='"+pcode+"' ORDER BY PANCH_NAME";
			//Debug.println("query in getPanchayatHabitations is "+query);
			rs =stmt.executeQuery(query);
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabCode(rs.getString(1));
				rwsLocation.setHabName(rs.getString(2)+" - "+rs.getString(1));
				habs.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	public  ArrayList getHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception
	{
		ArrayList habs=new ArrayList();
		  
		 String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			query="SELECT HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE" +
			" SUBSTR(HAB_CODE,1,2)='"+dcode+"' AND SUBSTR(HAB_CODE,6,2)='"+mcode+"' AND " +
			"SUBSTR(HAB_CODE,13,2)='"+pcode+"' AND SUBSTR(HAB_CODE,8,3)='"+vcode+"'";
			//System.out.println("query in getHabitations is "+query);
			rs =stmt.executeQuery(query);

			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(3)+" - "+rs.getString(2));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	/*
	 * Added by ramesh on 070510 for Habitation Covertion
	 */
	public  ArrayList getUIHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception
	{
		ArrayList habs=new ArrayList();
		  
		 String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			query="SELECT a.HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL a,rws_habitation_directory_tbl b WHERE a.panch_code=b.hab_code and " +
			" SUBSTR(a.HAB_CODE,1,2)='"+dcode+"' AND SUBSTR(a.HAB_CODE,6,2)='"+mcode+"' AND " +
			"SUBSTR(a.HAB_CODE,13,2)='"+pcode+"' AND SUBSTR(a.HAB_CODE,8,3)='"+vcode+"' and coverage_status='UI'";
			Debug.println("query in getHabitations is "+query);
			rs =stmt.executeQuery(query);

			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(2)+" - "+rs.getString(3));
				rwsLocation.setPanchayatName(rs.getString(3));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in rwsMasterData getPRHabitations="+e);
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	public  ArrayList getNewHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception
	{
		ArrayList habs=new ArrayList();
		  
		 String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			query="SELECT a.HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL a,rws_habitation_directory_tbl b WHERE a.panch_code=b.hab_code and " +
			" SUBSTR(a.HAB_CODE,1,2)='"+dcode+"' AND SUBSTR(a.HAB_CODE,6,2)='"+mcode+"' AND " +
			"SUBSTR(a.HAB_CODE,13,2)='"+pcode+"' AND SUBSTR(a.HAB_CODE,8,3)='"+vcode+"' and coverage_status is null";
			Debug.println("query in getHabitations is "+query);
			rs =stmt.executeQuery(query);

			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(2)+" - "+rs.getString(3));
				rwsLocation.setPanchayatName(rs.getString(3));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in rwsMasterData getPRHabitations="+e);
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	public  ArrayList getMandalHabitations(String dcode,String mcode) throws Exception
	{
		ArrayList habs=new ArrayList();
		  
		 String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			//query="SELECT HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE" +
			//" SUBSTR(HAB_CODE,1,2)='"+dcode+"' AND SUBSTR(HAB_CODE,6,2)='"+mcode+"' order by panch_name";
			 query = "select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.hab_code,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and SUBSTR(hd.HAB_CODE,1,2)='"+dcode+"' AND SUBSTR(hd.HAB_CODE,6,2)='"+mcode+"' order by h.panch_name"; 
			//Debug.println("query is "+query);
			rs =stmt.executeQuery(query);

			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				//Debug.println("1:"+rs.getString(9));
				//Debug.println("2:"+rs.getString(10));
				//Debug.println("3:"+rs.getString(11));
				rwsLocation.setHabitationCode(rs.getString(9));
				rwsLocation.setHabCode(rs.getString(10));
				rwsLocation.setHabName(rs.getString(11)+" - "+rs.getString(10));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e)
		{
			Debug.println("The error in rwsMasterData getPRHabitations="+e.getMessage());
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	
	public  ArrayList getHabs(String dcode,String mcode,String pcode,String vcode) throws Exception
	{
		ArrayList habs=new ArrayList();
		  
		 String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query="SELECT PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE" +
			" SUBSTR(HAB_CODE,1,2)='"+dcode+"' AND SUBSTR(HAB_CODE,6,2)='"+mcode+"' AND " +
			"SUBSTR(HAB_CODE,13,2)='"+pcode+"' AND SUBSTR(HAB_CODE,8,3)='"+vcode+"'";
			 
			rs =stmt.executeQuery(query);

			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabCode(rs.getString(1));
				rwsLocation.setHabName(rs.getString(2));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in rwsMasterData getPRHabitations="+e);
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	
	//this function is only for getting habitations of a mandal in a district 15-11-06
	public  ArrayList getHabs(String dcode,String mcode) throws Exception
	{
		ArrayList habs=new ArrayList();
		  
		 String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			//query="SELECT PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE" +
			//" SUBSTR(HAB_CODE,1,2)='"+dcode+"' AND SUBSTR(HAB_CODE,6,2)='"+mcode+"'";
			 
			query="select H.HAB_CODE,PR.PANCH_CODE,PR.PANCH_NAME, (H.CENSUS_PLAIN_POPU +H.CENSUS_SC_POPU+H.CENSUS_ST_POPU ) TOTAL_POP, H.COVERAGE_STATUS  FROM RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL  H where pr.PANCH_CODE=H.HAB_CODE  and pr.HAB_CODE in (SELECT hab_code FROM RWS_HABMAST_TBL  WHERE DCODE='"+dcode+"' and MCODE='"+mcode+"') order by panch_code";
			query = "select hd.hab_code,h.panch_code,h.panch_name,(Hd.census_plain_popu + Hd.census_sc_popu + Hd.census_st_popu)TOTAL_POP, Hd.coverage_status from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.DCODE='"+dcode+"' and m.MCODE='"+ mcode+"' order by h.panch_name";
			Debug.println("querrry::::::::::::::::::::::::"+query);
			rs =stmt.executeQuery(query);

			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabCode(rs.getString("HAB_CODE"));
				//rwsLocation.setHabName(rs.getString(2));
				rwsLocation.setHabName(rs.getString("PANCH_NAME")+" - "+rs.getString("HAB_CODE"));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in rwsMasterData getPRHabitations="+e);
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	
	public ArrayList getHabitations(String proposalId, String officeCode, String search) 
	throws Exception
	{
		conn = RwsOffices.getConn();
		stmt = conn.createStatement();
		if(officeCode == null)
			officeCode = "000000";
		
		String headOfficeCode = officeCode.substring(0,1);
		String circleOfficeCode = officeCode.substring(1,3);
		String divisionOfficeCode = officeCode.substring(3,4);
		String subdivisionOfficeCode = officeCode.substring(4,6);
		
		if(search != null)
		{
			query = " SELECT P.panch_code, P.panch_name, "
				  +	" (H.census_plain_popu + H.census_sc_popu + H.census_st_popu), "
				  + " H.coverage_status FROM rws_panchayat_raj_tbl P, "
				  + " rws_habitation_directory_tbl H " 
				  +	" WHERE P.panch_code = H.hab_code AND "
				  + " H.circle_office_code = '" + circleOfficeCode + "' AND "
				  + " H.division_office_code = '" + divisionOfficeCode + "' AND "
				  + " H.subdivision_office_code = '" + subdivisionOfficeCode + "' AND "
				  + " LOWER(P.panch_name) LIKE LOWER('%" + search + "%')";
		}
		else
		{
			query = " SELECT P.panch_code, P.panch_name, "
				  +	" (H.census_plain_popu + H.census_sc_popu + H.census_st_popu), "
				  + " H.coverage_status FROM rws_panchayat_raj_tbl P, "
				  + " rws_habitation_directory_tbl H " 
				  +	" WHERE P.panch_code = H.hab_code AND "
				  + " H.circle_office_code = '" + circleOfficeCode + "' AND "
				  + " H.division_office_code = '" + divisionOfficeCode + "' AND "
				  + " H.subdivision_office_code = '" + subdivisionOfficeCode + "'";
		}
		//System.out.println("Select Habitations Query is : ");
		//System.out.println(query);
		rs = stmt.executeQuery(query);
		
		ArrayList habitations = new ArrayList();
		while(rs.next())
		{
			rwsLocation = new RwsLocationBean();
			rwsLocation.setProposalId(proposalId);
			rwsLocation.setHabCode(rs.getString(1));
			rwsLocation.setHabName(rs.getString(2));
			rwsLocation.setPopulation(rs.getString(3));
			rwsLocation.setStatus(rs.getString(4));
			habitations.add(rwsLocation);
		}
		closeAll();
		return habitations;
	}
	
	public ArrayList getAssetHabs(String assetCode) throws Exception
	{
		ArrayList assetHabs = new ArrayList();
		conn = RwsOffices.getConn();
		stmt = conn.createStatement();
		query = " SELECT ";
		
		return assetHabs;
	}
	public  String getHabName(String habCode,Connection conn) throws Exception
	{
		String name=null;
		Statement stmt1=null;
		ResultSet rs1=null;
		Debug.println("habCode="+habCode);
		try
		{	
			stmt1=conn.createStatement();
			if(habCode!=null && !habCode.equals("null")){
			rs1 = stmt1.executeQuery("SELECT PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE PANCH_CODE ='"+habCode+"'");
			rs1.next();
			name=rs1.getString(1);
			}
			else
				name="";
		}
		catch (Exception e)
		{
			//System.out.println("Ther error in getHabName="+e);
		}
		finally 
		{
			if (stmt1 != null) {
			stmt1.close();
			}
			
		}
		//System.out.println("Hab Name="+name);
	     return name;
	}
	/*Added for administrative sanction and revised sanction*/
	public ArrayList getAdminStrativeHabitations(String proposalId, String officeCode, String search,String[] mcodes,String all) 
	throws Exception
	{   ArrayList habitations = new ArrayList(); 
	System.out.println("in getAdminStrativeHabitationsgetAdminStrativeHabitations");
    System.out.println("yes"+all);
	String scheme=proposalId.substring(6,8);
	System.out.println("scheme in getAdminStrativeHabitations"+scheme);
	String qq="";
	if(all.equals("yes"))
	{
	try{
			if(officeCode == null)
				officeCode = "000000";
			//System.out.println("officeCode");
			String headOfficeCode = officeCode.substring(0,1);
			String circleOfficeCode = proposalId.substring(4,6);
		    //System.out.println("*****CircleCOde is**--->"+circleOfficeCode);
			conn = RwsOffices.getConn();
			PreparedStatement pstmt=null;
			if(!(scheme.equals("11")|| scheme.equals("12")))
			{
			 qq="select * from RWS_ADMIN_HABS_PICK_VIEW where circle_office_code = '" + circleOfficeCode + "'";
	        pstmt = conn.prepareStatement(qq);
			}else if(scheme.equals("11"))
			{
			 qq="select a.*,B.SCHOOL_CODE ,SCHOOL_NAME from RWS_ADMIN_HABS_PICK_VIEW A, RWS_SCHOOL_MASTER_TBL B WHERE  A.PANCH_CODE=b.HAB_CODE and CIRCLE_OFFICE_CODe='" + circleOfficeCode + "'";
				pstmt = conn.prepareStatement(qq);
			}
			else if(scheme.equals("12"))
			{
			 qq="SELECT  LAB_CODE,lab_name,location FROM  rws_water_quality_lab_tbl";
				pstmt = conn.prepareStatement(qq);
			}
		rs = pstmt.executeQuery();
		pstmt.setFetchSize(3000);
	 	rs.setFetchSize(300);
	   Debug.println("in get adminstrativehabs addremove11111111"+qq);
		while(rs.next())
		{
			if(!(scheme.equals("11")|| scheme.equals("12")))
			{
		
			rwsLocation = new RwsLocationBean();
			rwsLocation.setProposalId(proposalId);
			rwsLocation.setAssemblyCode(rs.getString(1));
			rwsLocation.setAssemblyName(rs.getString(2));
			rwsLocation.setMandalName(rs.getString(3));
		 	rwsLocation.setHabCode(rs.getString(4));
			rwsLocation.setHabName(rs.getString(5));
			rwsLocation.setPopulation(rs.getString(6));
			rwsLocation.setStatus(rs.getString(7));
			habitations.add(rwsLocation);
			//Debug.println("hab sizeeeeeeeee 1:"+habitations.size());
			}else if(scheme.equals("11"))
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setProposalId(proposalId);
				//rwsLocation.setAssemblyCode(rs.getString(1));
				//rwsLocation.setAssemblyName(rs.getString(2));
				rwsLocation.setMandalName(rs.getString(3));
			 	rwsLocation.setHabCode(rs.getString(4));
				rwsLocation.setHabName(rs.getString(5));
				rwsLocation.setSchoolCode(rs.getString(4)+rs.getString(9));
				rwsLocation.setSchoolName(rs.getString(10));
				rwsLocation.setSchoolLocation(rs.getString(9));
				habitations.add(rwsLocation);
				//Debug.println("hab sizeeeeeeeee:"+habitations.size());
			}
			else if(scheme.equals("12"))
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setProposalId(proposalId);
				rwsLocation.setLabCode(rs.getString(1));
				rwsLocation.setLabName(rs.getString(2));
				rwsLocation.setLocation(rs.getString(3));
				habitations.add(rwsLocation);
				Debug.println("hab sizeeeeeeeee:"+habitations.size());
			}
			
		}
	}
	catch(Exception e)
	{
		//System.out.println("exception "+e);
	}
	closeAll();
	}
	else
	{
	//System.out.println("in else");
	try{
		if(officeCode == null)
			officeCode = "000000";
		String headOfficeCode = officeCode.substring(0,1);
		String circleOfficeCode = proposalId.substring(4,6);
	    conn = RwsOffices.getConn();
	    //System.out.println("connectiong created");
	    if(!(scheme.equals("11")|| scheme.equals("12")))
		{
	    query=" SELECT con.CONSTITUENCY_CODE,con.CONSTITUENCY_NAME,m.mname,panch.pname,v.vname,P.panch_code, P.panch_name, "
			  +	" (H.census_plain_popu + H.census_sc_popu + H.census_st_popu)tot, "
			  + " H.coverage_status ,H.circle_office_code ,m.mcode FROM rws_panchayat_raj_tbl P,rws_constituency_tbl con,rws_mandal_tbl m, rws_panchayat_tbl panch,rws_village_tbl v, "
			  + " rws_habitation_directory_tbl H " 
			  +	" WHERE P.panch_code = H.hab_code AND H.COVERAGE_STATUS <> 'UI' AND  substr(h.hab_code,3,3)=con.CONSTITUENCY_CODE "
			  + " and con.CONSTITUENCY_TYPE ='A' and con.dcode=h.circle_office_code and"  
			  + " m.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2)  and panch.dcode=substr(h.hab_code,1,2) and panch.mcode=substr(h.hab_code,6,2)  and panch.pcode=substr(h.hab_code,13,2) and v.dcode=substr(h.hab_code,1,2) and v.mcode=substr(h.hab_code,6,2)  and v.pcode=substr(h.hab_code,13,2) and v.vcode=substr(h.hab_code,8,3) and h.circle_office_code = ? and m.mcode= ?"
			  + "  order by con.CONSTITUENCY_NAME,m.mname,p.panch_name asc";
	    query = "select distinct m.mname,p.pname,v.vname,h.panch_code,h.panch_name,(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU)tot,hd.coverage_status from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=? and m.mcode=? order by m.mname,p.pname,v.vname,h.panch_name asc";
		}else if(scheme.equals("11"))
		{
			//query="select a.*,B.SCHOOL_CODE ,SCHOOL_NAME from RWS_ADMIN_HABS_PICK_VIEW A, RWS_SCHOOL_MASTER_TBL B  WHERE   A.PANCH_CODE=b.HAB_CODE  and a.circle_office_code = ? and substr(b.hab_code,6,2)= ?";
			query="select hab_code,SCHOOL_CODE ,SCHOOL_NAME,panch_name from  RWS_SCHOOL_MASTER_TBL  a ,rws_complete_hab_view b WHERE   substr(hab_code,1,2)=? and substr(hab_code,6,2)= ? and a.hab_code=b.panch_code";
		}
		else if(scheme.equals("12"))
		{
			query="select lab_code,lab_name,location from  rws_water_quality_lab_tbl  WHERE  substr(office_code,2,2) = ? ";
		}
	 Debug.println("Query is888888888888888888888*******88:"+query);
 	 PreparedStatement  pstmt = conn.prepareStatement(query);
 	Debug.println("aaaaa"+mcodes.length);
 	 for(int i=1;i<mcodes.length;i++)
	{
 	 	Debug.println("value:"+mcodes[i]);
 	 	if(!(scheme.equals("11")|| scheme.equals("12")))
			{
		     Debug.println("aaaaaaaaaaaaddddddddddddddddggggggggggggggggg::"+mcodes[i]); 	
 	 	      pstmt.setString(1,circleOfficeCode);
		 	  pstmt.setString(2,mcodes[i]);
			}
 	 	else if(scheme.equals("11"))
 	 	{
 	 		Debug.println("aaaaaaaaaaaaddddddddddddddddggggggggggggggggg::"+mcodes[i]); 	
 	 	 	pstmt.setString(1,circleOfficeCode);
 			pstmt.setString(2,mcodes[i]);
 	 		}
 	 	else if(scheme.equals("12"))
 	 	{
 	 		Debug.println("aaaaaaaaaaaaddddddddddddddddggggggggggggggggg::"+mcodes[i]); 	
 	 	 	pstmt.setString(1,mcodes[i]);
 	 	}
			rs = pstmt.executeQuery();
			//pstmt.setFetchSize(3000);
	 	    //rs.setFetchSize(300);
	 	    while(rs.next())
			{
	 	    	Debug.println("aaaaaaaaaaaaaaaaa333333333aaaaaaaaaaaaaa");
	 	    	if(!(scheme.equals("11")|| scheme.equals("12")))
	 			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setProposalId(proposalId);
				//rwsLocation.setAssemblyCode(rs.getString(1));
				//rwsLocation.setAssemblyName(rs.getString(2));
				rwsLocation.setMandalName(rs.getString(1));
				rwsLocation.setPanchayatName(rs.getString(2));
				rwsLocation.setVillageName(rs.getString(3));
			 	rwsLocation.setHabCode(rs.getString(4));
				rwsLocation.setHabName(rs.getString(5));
				rwsLocation.setPopulation(rs.getString(6));
				rwsLocation.setStatus(rs.getString(7));
				}else if(scheme.equals("11"))
			{
					rwsLocation = new RwsLocationBean();
					rwsLocation.setProposalId(proposalId);
					//rwsLocation.setMandalName(rs.getString(1));
					//rwsLocation.setPanchayatName(rs.getString(2));
					///rwsLocation.setVillageName(rs.getString(3));
				 	rwsLocation.setHabCode(rs.getString(1));
					rwsLocation.setHabName(rs.getString(4));
					rwsLocation.setSchoolCode(rs.getString(1)+rs.getString(2));
					rwsLocation.setHabitationCode(rs.getString(1)+rs.getString(2));
					rwsLocation.setSchoolName(rs.getString(3));
					rwsLocation.setSchoolLocation(rs.getString(2));
			}
				else if(scheme.equals("12"))
				{
						rwsLocation = new RwsLocationBean();
						rwsLocation.setProposalId(proposalId);
						rwsLocation.setLabCode(rs.getString(1));
						rwsLocation.setLabName(rs.getString(2));
						rwsLocation.setLocation(rs.getString(3));
				}
			
				habitations.add(rwsLocation);
			}
	}
	}
	catch(Exception e)
	{
		System.out.println("exception "+e);
	}
	closeAll();
	}
	return habitations;
}
///////////addd for prajpadam//////////
	 
	public ArrayList getConstituency(String habCode ,DataSource dataSource) throws Exception
		{
			ArrayList list=new ArrayList();
			Connection conn=null;
			//System.out.println("habCode="+habCode);
			try
			{	
			     conn=RwsOffices.getConn();
				Statement stmt1=conn.createStatement();
			  	//System.out.println("SELECT c.CONSTITUENCY_CODE ,c.CONSTITUENCY_NAME ,h.coverage_status  FROM " +
				//		" RWS_CONSTITUENCY_TBL c ,rws_habitation_directory_tbl h WHERE C.DCODE=SUBSTR('"+habCode+"',1,2) AND " +
				//		"C.CONSTITUENCY_CODE =SUBSTR('"+habCode+"',3,3) and h.hab_code='"+habCode+"'");	
				 
				ResultSet rs = stmt1.executeQuery("SELECT c.CONSTITUENCY_CODE ,c.CONSTITUENCY_NAME ,h.coverage_status  FROM " +
						" RWS_CONSTITUENCY_TBL c ,rws_habitation_directory_tbl h WHERE C.DCODE=SUBSTR('"+habCode+"',1,2) AND " +
						"C.CONSTITUENCY_CODE =SUBSTR('"+habCode+"',3,3) and h.hab_code='"+habCode+"'") ;
				//System.out.println("hai"+rs);
				
		 		if(rs.next())
				{
		 			 
					list.add(rs.getString(1));
					list.add(rs.getString(2));
					list.add(rs.getString(3));
					 
				}
		 		 
				 
			}
			catch (Exception e)
			{
				//System.out.println("Ther error in getHabName="+e);
			}
			 finally 
			 {
			 	conn.close();
			 }
			 
		     return list;
		}
	public  ArrayList getHabsForPraja(String dcode,String mcode) throws Exception
	{
		ArrayList habs=new ArrayList();
		  
		 String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			 
			 
			query="select H.HAB_CODE,PR.PANCH_CODE,PR.PANCH_NAME " +
			 		"   FROM RWS_PANCHAYAT_RAJ_TBL PR," +
					" RWS_HABITATION_DIRECTORY_TBL  H where pr.PANCH_CODE=H.HAB_CODE  " +
					"and pr.HAB_CODE in (SELECT hab_code FROM RWS_HABMAST_TBL  WHERE DCODE='"+dcode+"'" +
					" and MCODE='"+mcode+"') order by panch_code";
			
			//System.out.println("query"+query);
			rs =stmt.executeQuery(query);

			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabCode(rs.getString("HAB_CODE"));
		 		rwsLocation.setHabName(rs.getString("PANCH_NAME"));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in rwsMasterData getPRHabitations="+e);
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	
	public  ArrayList getsubdivisionmandals(String coc, String doc,
			String sdoc, DataSource dataSource) throws Exception {   
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		
		RwsMaster rwsMaster = null;
		ArrayList mandalsub = new ArrayList();
		//System.out.println("coc=" + coc + "doc=" + doc + "sdoc=" + sdoc);
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query = "select M.MCODE,M.MNAME FROM RWS_MANDAL_SUBDIVISION_TBL MS,RWS_MANDAL_TBL M WHERE MS.CIRCLE_OFFICE_CODE='"
							+ coc
							+ "' AND MS.DCODE='"
							+ coc
							+ "' AND MS.DIVISION_OFFICE_CODE='"
							+ doc
							+ "' AND MS.SUBDIVISION_OFFICE_CODE='"
							+ sdoc
							+ "' AND M.MCODE=MS.MCODE AND M.DCODE='"
							+ coc
							+ "' ORDER BY M.MNAME";
			//System.out.println("query in getsubdivisionmandals  "+query);
			rs=stmt.executeQuery(query);
			while (rs.next()) {
				rwsMaster = new RwsMaster();
				rwsMaster.setMandalCode(rs.getString(1));
				rwsMaster.setMandalName(rs.getString(2));
				mandalsub.add(rwsMaster);
			}
		} catch (Exception e) {
			//System.out.println("the error is in getsubdivisionmandal="
				//	+ e.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					//System.out.println("The error in rwsMasterData in closing rs " + e);
				}
				rs = null;
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (Exception e) {
					//System.out.println("The error in closing stmt=" + e);
				}
				stmt = null;
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					//System.out.println("The error in closing conn=" + e);
				}
				conn = null;
			}
		}
		return mandalsub;
	}
	
	public  ArrayList getsubdivisionmandals2(String coc, String doc,
			String sdoc, DataSource dataSource) throws Exception {   
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		
		RwsMaster rwsMaster = null;
		ArrayList mandalsub = new ArrayList();
		//System.out.println("coc=" + coc + "doc=" + doc + "sdoc=" + sdoc);
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query = "select M.MCODE,M.MNAME FROM RWS_MANDAL_SUBDIVISION_TBL MS,RWS_MANDAL_TBL M WHERE MS.CIRCLE_OFFICE_CODE='"
							+ coc
							+ "' AND MS.DCODE='"
							+ coc
							+ "' AND MS.DIVISION_OFFICE_CODE='"
							+ doc
							+ "' AND MS.SUBDIVISION_OFFICE_CODE='"
							+ sdoc
							+ "' AND M.MCODE=MS.MCODE AND M.DCODE='"
							+ coc
							+ "' ORDER BY M.MNAME";
			//System.out.println("query in getsubdivisionmandals  "+query);
			rs=stmt.executeQuery(query);
			while (rs.next()) {
				rwsMaster = new RwsMaster();
				rwsMaster.setMandalCode(rs.getString(1));
				rwsMaster.setMandalName(rs.getString(2));
				mandalsub.add(rwsMaster);
			}
		} catch (Exception e) {
			//System.out.println("the error is in getsubdivisionmandal="
		//			+ e.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e) {
					//System.out.println("The error in rwsMasterData in closing rs " + e);
				}
				rs = null;
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (Exception e) {
					//System.out.println("The error in closing stmt=" + e);
				}
				stmt = null;
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					//System.out.println("The error in closing conn=" + e);
				}
				conn = null;
			}
		}
		return mandalsub;
	}
//////////////////////////////////	//
	/*
	 * 
	 * @author ramesh for water quality
	 *
	 */

	public ArrayList getPanchayat(String sourcecode) throws Exception
	{
		ArrayList panchyats=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query="SELECT DISTINCT PCODE,PNAME FROM RWS_PANCHAYAT_TBL WHERE" +
			" DCODE='"+sourcecode.substring(0,2)+"' and MCODE='"+sourcecode.substring(5,7)+"' and pcode='"+sourcecode.substring(12,14)+"' ORDER BY PNAME";
			//System.out.println("query in getPanchayats is "+query);
			rs =stmt.executeQuery(query);
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setPanchayatCode(rs.getString(1));
				rwsLocation.setPanchayatName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				panchyats.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			System.out.println("The error in getPanchyatCodes ==in==  RwsLocation "+e);
		}
		finally 
		{
			closeAll();
		}
		return panchyats;
	}



	public  ArrayList getPanchayatHabitations1(String sourcecode) throws Exception
	{
		ArrayList habs=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			//String query="SELECT  HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE" +
			//" SUBSTR(PANCH_CODE,1,2)='"+sourcecode.substring(0,2)+"' AND SUBSTR(PANCH_CODE,6,2)='"+sourcecode.substring(4,6)+"' AND SUBSTR(PANCH_CODE,13,2)='"+sourcecode.substring(12,14)+"' ORDER BY PANCH_NAME";
			String query = "SELECT HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE panch_code='"+sourcecode.substring(0,16)+"'";
			//System.out.println("query in getPanchayatHabitations1 is "+query);
			rs =stmt.executeQuery(query);
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(3)+" - "+rs.getString(2));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e)
		{
			System.out.println("The error in getVillageCodes ==in== RwsLocation"+e);
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	
	
	//for getting habitaions in duplicates Reports  26-10-08
	public ArrayList getHabitations1(String dCode,String mCode,String pCode,String vCode) throws Exception
	{
		ArrayList habs=new ArrayList();
		String dcode=dCode;
		String mcode=mCode;
		String pcode=pCode;
		String vcode=vCode;
		
		String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			if(dcode!=null)
			{
			query="SELECT RAJ.PANCH_NAME,RAJ.PANCH_CODE FROM RWS_PANCHAYAT_RAJ_TBL RAJ,RWS_HABITATION_DIRECTORY_TBL HD WHERE "+
			      "HD.HAB_CODE=RAJ.PANCH_CODE AND SUBSTR(RAJ.PANCH_CODE,1,2)='"+dcode+"' AND SUBSTR(RAJ.PANCH_CODE,6,2)='"+mcode+"' AND "+
				  "SUBSTR(RAJ.PANCH_CODE,13,2)='"+pcode+"' AND SUBSTR(RAJ.PANCH_CODE,8,3)='"+vcode+"' ";
			rs=stmt.executeQuery(query);
			Debug.println("query habitations"+query);	
			while(rs.next())
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(1));
				habs.add(rwsLocation);
			}			
		 }
		}catch(Exception e)
		{
			Debug.println("Exception in getHabitations1"+e);
		}
		finally 
		{
			closeAll();
		}		
		return habs;		
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getYear() {
		return year;
	}

	
	
	/*
	 * 
	 * @author ramesh ended
	 *
	 * TODO To change the template for this generated type comment go to
	 * Window - Preferences - Java - Code Style - Code Templates
	 */
	}
