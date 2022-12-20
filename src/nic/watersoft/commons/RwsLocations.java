package nic.watersoft.commons;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.masters.RwsMaster;

public class RwsLocations 
{
	private DataSource dataSource = null;
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	private String query = null;
	private PreparedStatement ps=null;
	private RwsLocationBean rwsLocation = null;
	private String year=null;

	
	public RwsLocations(DataSource dataSource)
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
		if(ps != null)
		{
			try
			{	ps.close();
			}
			catch(SQLException sqle)
			{	// Ignore this exception
			}
		}
	}

	public ArrayList<RwsLocationBean> getDistricts() throws Exception
	{		
		ArrayList<RwsLocationBean> districts=new ArrayList<RwsLocationBean>();
		try
		{
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement("SELECT * FROM RWS_DISTRICT_TBL ORDER BY DNAME");
			rs =ps.executeQuery();
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setDistrictCode(rs.getString(1));
				rwsLocation.setDistrictName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				districts.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			System.out.println("The error at getDistricts in RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		return districts;
	}
	public ArrayList getUrbanDistricts() throws Exception
	{
		
		ArrayList urbandistricts=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement("SELECT DCODE,DNAME FROM URBAN_DISTRICT_TBL  ORDER BY DNAME");
			rs =ps.executeQuery();
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();	
				rwsLocation.setUrbanDistCode(rs.getString(1));
				rwsLocation.setUrbanDistName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				urbandistricts.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			System.out.println("The error in getDistricts()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		return urbandistricts;
	}
	
	public ArrayList getyears() throws Exception
	{
		
		ArrayList years=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement("select  distinct year from RWS_DROUGHT_HABITATION_TBL where year in('2012','2013','2014','2015','2016') order by year desc");
			rs =ps.executeQuery();
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
			System.out.println("The error in getDistricts()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		return years;
	}
	
	public String getDname(String dcode) throws Exception {
		String dname = null;
		try {
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement("SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE= ?");
			ps.setString(1, dcode);
			rs = ps.executeQuery();
			while (rs.next()) {
				dname = rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The error in getDname() is" + e);
		} finally {
			closeAll();
		}
		return dname;
	}
	
	public String getUrbanDname(String dcode) throws Exception
	{    String dname=null;
		try
		{
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement("SELECT DNAME FROM URBAN_DISTRICT_TBL WHERE DCODE= ?");
			ps.setString(1, dcode);
			rs =ps.executeQuery();
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
			ps = conn.prepareStatement("SELECT MNAME FROM RWS_MANDAL_TBL WHERE DCODE= ? AND MCODE= ?");
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rs =ps.executeQuery();
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
	public ArrayList getDivisions(String dcode) throws Exception{
		ArrayList divisions=new ArrayList();
		String query = null;
		try	{
			conn = RwsOffices.getConn();
			query = "SELECT division_office_code,division_office_name FROM RWS_division_office_tbl   where circle_office_code=? order by 2 ";
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			rs = ps.executeQuery();
			while ( rs.next() ) {
				rwsLocation = new RwsLocationBean();
				rwsLocation.setDivisionCode(rs.getString(1));
				rwsLocation.setDivisionName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				divisions.add(rwsLocation);
			}
		}
		catch (Exception e){
			System.out.println("The Exception is in RwsLocations getDivisions : "+e.getMessage());
		}
		finally	{
			closeAll();
		}
		return divisions;
	}
	
	public ArrayList<RwsLocationBean> getMandals(String dcode) throws Exception
	{
		ArrayList<RwsLocationBean> mandals=new ArrayList<RwsLocationBean>();
		String query = null;
		try{
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			rs = ps.executeQuery();
			while ( rs.next() ) {
				rwsLocation = new RwsLocationBean();
				rwsLocation.setDistrictCode(rs.getString(1));
				rwsLocation.setMandalCode(rs.getString(2));
				rwsLocation.setMandalName(rs.getString(3));
				rwsLocation.setCodeName(rs.getString(3)+" - "+rs.getString(2));
				mandals.add(rwsLocation);
			}
		}catch (Exception e){
			System.out.println("The error in getMandals()=== RwsLocations "+e);
		}finally {
			closeAll();
		}
		return mandals;
	}
	
	
	public ArrayList getUrbanMandals(String dcode) throws Exception
	{
		ArrayList urbanmandals=new ArrayList();
		String query = null;
		try
		{
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM URBAN_MANDAL_TBL WHERE DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			rs = ps.executeQuery();
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setUrbanDistCode(rs.getString(1));
				rwsLocation.setUrbanMandCode(rs.getString(2));
				rwsLocation.setUrbanMandName(rs.getString(3));
				rwsLocation.setCodeName(rs.getString(3)+" - "+rs.getString(2));
				urbanmandals.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			System.out.println("The error in getMandals()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		return urbanmandals;
	}
	public ArrayList getMandalSubdivisions(String coc,String doc,String sdoc) throws Exception
	{
		ArrayList mandalsubdivisions=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement("SELECT MS.DCODE,M.MCODE,M.MNAME FROM RWS_SUBDIVISION_OFFICE_TBL SDO,RWS_MANDAL_TBL M,RWS_MANDAL_SUBDIVISION_TBL MS WHERE MS.CIRCLE_OFFICE_CODE= ? AND MS.DIVISION_OFFICE_CODE= ? AND SDO.SUBDIVISION_OFFICE_CODE= ?"
					+" AND MS.SUBDIVISION_OFFICE_CODE= ? AND SDO.CIRCLE_OFFICE_CODE= ? AND SDO.DIVISION_OFFICE_CODE= ? and M.DCODE=MS.DCODE and M.MCODE=MS.MCODE");
			ps.setString(1, coc);
			ps.setString(2, doc);
			ps.setString(3, sdoc);
			ps.setString(4, sdoc);
			ps.setString(5, coc);
			rs =ps.executeQuery();
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
			System.out.println("The error in getMandalsSubdivisions()=== RwsLocations "+e);
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
			String query="SELECT DISTINCT PCODE,PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE= ? and MCODE= ? ORDER BY PNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rs =ps.executeQuery();
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
			System.out.println("The error at getPanchayats() In RwsLocations is "+e);//e.printStackTrace();
		}
		finally 
		{
			closeAll();
		}
		return panchyats;
	}
	public ArrayList getMunicipalities(String dcode,String mcode) throws Exception
	{
		ArrayList municipailties=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			String query="SELECT DISTINCT PCODE,PNAME FROM URBAN_PANCHAYAT_TBL  WHERE DCODE=? and MCODE= ? ORDER BY PNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rs =ps.executeQuery();
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setMunicipalityCode(rs.getString(1));
				rwsLocation.setMunicipalityName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				municipailties.add(rwsLocation);
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
		return municipailties;
	}
	public  ArrayList getVillages(String dcode,String mcode,String pcode) throws Exception
	{
		ArrayList villages=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query="SELECT DISTINCT VCODE,VNAME FROM RWS_VILLAGE_TBL WHERE DCODE= ? AND MCODE= ? AND PCODE= ? ORDER BY VNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rs =ps.executeQuery();
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
			System.out.println("The error in getVillageCodes In RwsLocation"+e);
		}
		finally 
		{
			closeAll();
		}
		return villages;
	}
	public  ArrayList getWards(String dcode,String mcode) throws Exception
	{
		ArrayList wards=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query="SELECT DISTINCT VCODE,VNAME FROM URBAN_VILLAGE_TBL WHERE DCODE= ? AND MCODE= ? ORDER BY VNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rs =ps.executeQuery();
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setWardCode(rs.getString(1));
				rwsLocation.setWardName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				wards.add(rwsLocation);
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
		return wards;
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
			ps = conn.prepareStatement(query);
			rs =ps.executeQuery();
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
			query=" SELECT  H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL H WHERE" +
                         " SUBSTR(P.PANCH_CODE,1,2)= ? AND SUBSTR(P.PANCH_CODE,6,2)= ? AND SUBSTR(P.PANCH_CODE,13,2)= ? AND " +
				         " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' ORDER BY P.PANCH_NAME";
			query=" SELECT  PANCH_CODE,PANCH_NAME FROM RWS_COMPLETE_HAB_VIEW WHERE DCODE = ? AND MCODE= ? AND PCODE= ? ORDER BY PANCH_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rs =ps.executeQuery();
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
	
	public  ArrayList getHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception 	{
		ArrayList habs=new ArrayList();		  
		 String query="";
		try{
			conn = RwsOffices.getConn();
			query="SELECT HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE SUBSTR(HAB_CODE,1,2)= ?  AND SUBSTR(HAB_CODE,6,2)= ? AND " 
			+"SUBSTR(HAB_CODE,13,2)= ? AND SUBSTR(HAB_CODE,8,3)= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rs =ps.executeQuery();
			while (rs.next()) {
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(3)+" - "+rs.getString(2));
				habs.add(rwsLocation);				
			}
		}
		catch (Exception e)
		{
			System.out.println("Exception at getHabitations in RwsLocations   "+e);//e.printStackTrace();
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}
	
	public  ArrayList getLocalities(String dcode,String mcode,String pcode) throws Exception
	{
		ArrayList Localities=new ArrayList();
		  
		 String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			/*query="SELECT HAB_CODE,LOCALITY,LOCALITY  FROM URBAN_LOCALITY  WHERE" +
			" SUBSTR(HAB_CODE,1,2)='"+dcode+"' AND SUBSTR(HAB_CODE,6,2)='"+mcode+"' AND " +
			"SUBSTR(HAB_CODE,13,2)='"+pcode+"' AND SUBSTR(HAB_CODE,8,3)='"+vcode+"'";*/
			
			query="SELECT HAB_CODE,HAB_CODE,LOCALITY  FROM URBAN_LOCALITY  WHERE " +
					"DIST_NO ='"+dcode+"' AND MAND_NO ='"+mcode+"' AND " +
					"VILL_NO ='"+pcode+"'";
			System.out.println("query in getHabitations is "+query);
			rs =stmt.executeQuery(query);

			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setLocalityCode(rs.getString(2));
				rwsLocation.setLocalityName(rs.getString(3)+" - "+rs.getString(2));
				Localities.add(rwsLocation);
				
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
		return Localities;
	}
	
	public  ArrayList getUIHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception {
		ArrayList habs=new ArrayList();		  
		String query="";
		try	{
			conn = RwsOffices.getConn();
			query="SELECT a.HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL a,rws_habitation_dir_dyna_tbl b WHERE a.panch_code=b.hab_code and " +
			" SUBSTR(a.HAB_CODE,1,2)= ? AND SUBSTR(a.HAB_CODE,6,2)= ? AND " +
			"SUBSTR(a.HAB_CODE,13,2)= ? AND SUBSTR(a.HAB_CODE,8,3)= ? and coverage_status='UI'";
			ps = conn.prepareStatement(query);	
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rs =ps.executeQuery();
			while (rs.next()) {
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(2)+" - "+rs.getString(3));
				rwsLocation.setPanchayatName(rs.getString(3));
				habs.add(rwsLocation);				
			}
		}
		catch (Exception e)	{
			System.out.println("The Exception is in RwsLocations getUIHabitations : "+e.getMessage());
		}
		finally {
			closeAll();
		}
		return habs;
	}
	
	public  ArrayList getNewHabitations(String dcode,String mcode,String pcode,String vcode) throws Exception{
		ArrayList habs=new ArrayList();		  
		 String query="";
		try	{
			conn = RwsOffices.getConn();
			query="SELECT a.HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL a,rws_habitation_dir_dyna_tbl b WHERE a.panch_code=b.hab_code and " +
			" SUBSTR(a.HAB_CODE,1,2)= ? AND SUBSTR(a.HAB_CODE,6,2)= ? AND " +
			"SUBSTR(a.HAB_CODE,13,2)= ? AND SUBSTR(a.HAB_CODE,8,3)= ? and coverage_status is null";
			ps = conn.prepareStatement(query);	
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rs =ps.executeQuery();
			while ( rs.next() ) {
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(2)+" - "+rs.getString(3));
				rwsLocation.setPanchayatName(rs.getString(3));
				habs.add(rwsLocation);				
			}
		}
		catch (Exception e)	{
			System.out.println("The Exception is in RwsLocations getNewHabitations : "+e.getMessage());
		}
		finally {
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
			query = "select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.hab_code,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and SUBSTR(hd.HAB_CODE,1,2)= ? AND SUBSTR(hd.HAB_CODE,6,2)= ? order by h.panch_name"; 
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rs =ps.executeQuery();

			while ( rs.next() ) {
				rwsLocation = new RwsLocationBean();
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
			" SUBSTR(HAB_CODE,1,2)= ? AND SUBSTR(HAB_CODE,6,2)= ? AND " +
			"SUBSTR(HAB_CODE,13,2)= ? AND SUBSTR(HAB_CODE,8,3)= ? ";			 
			ps = conn.prepareStatement(query);	
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rs =ps.executeQuery();
			while (rs.next())
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabCode(rs.getString(1));
				rwsLocation.setHabName(rs.getString(2));
				habs.add(rwsLocation);				
			}
		}
		catch (Exception e)
		{
			System.out.println("The error in rwsMasterData getPRHabitations="+e);
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
			query="select H.HAB_CODE,PR.PANCH_CODE,PR.PANCH_NAME, (H.CENSUS_PLAIN_POPU +H.CENSUS_SC_POPU+H.CENSUS_ST_POPU ) TOTAL_POP, H.COVERAGE_STATUS  FROM RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL  H where pr.PANCH_CODE=H.HAB_CODE  and pr.HAB_CODE in (SELECT hab_code FROM RWS_HABMAST_TBL  WHERE DCODE= ? and MCODE= ?) order by panch_code";
			query = "select hd.hab_code,h.panch_code,h.panch_name,(Hd.census_plain_popu + Hd.census_sc_popu + Hd.census_st_popu)TOTAL_POP, Hd.coverage_status from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.DCODE= ? and m.MCODE= ? order by h.panch_name";
			ps = conn.prepareStatement(query);	
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rs =ps.executeQuery();
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
			System.out.println("The error in rwsMasterData getPRHabitations="+e);
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
	     return name;
	}
	public ArrayList getAdminStrativeHabitations(String proposalId, String officeCode, String search,String[] mcodes,String all) throws Exception {  
		ArrayList habitations = new ArrayList(); 
		String scheme=proposalId.substring(6,8);
		String qq="";
		if(all.equals("yes")){
			try {
				if(officeCode == null)
					officeCode = "000000";
					String headOfficeCode = officeCode.substring(0,1);
					String circleOfficeCode = proposalId.substring(4,6);
					conn = RwsOffices.getConn();
					PreparedStatement pstmt=null;
					if(!(scheme.equals("11")|| scheme.equals("12"))){
						qq="select * from RWS_ADMIN_HABS_PICK_VIEW where circle_office_code = '" + circleOfficeCode + "'";
						pstmt = conn.prepareStatement(qq);
					} else if(scheme.equals("11")) {
						qq="select a.*,B.SCHOOL_CODE ,SCHOOL_NAME from RWS_ADMIN_HABS_PICK_VIEW A, RWS_SCHOOL_MASTER_TBL B WHERE  A.PANCH_CODE=b.HAB_CODE and CIRCLE_OFFICE_CODe='" + circleOfficeCode + "'";
						pstmt = conn.prepareStatement(qq);
					}
					else if(scheme.equals("12")){
						qq="SELECT  LAB_CODE,lab_name,location FROM  rws_water_quality_lab_tbl";
						pstmt = conn.prepareStatement(qq);
					}
					rs = pstmt.executeQuery();
					pstmt.setFetchSize(3000);
					rs.setFetchSize(300);
					while(rs.next()) {
						if(!(scheme.equals("11")|| scheme.equals("12"))){		
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
						} else if(scheme.equals("11")){
							rwsLocation = new RwsLocationBean();
							rwsLocation.setProposalId(proposalId);
							rwsLocation.setMandalName(rs.getString(3));
						 	rwsLocation.setHabCode(rs.getString(4));
							rwsLocation.setHabName(rs.getString(5));
							rwsLocation.setSchoolCode(rs.getString(4)+rs.getString(9));
							rwsLocation.setSchoolName(rs.getString(10));
							rwsLocation.setSchoolLocation(rs.getString(9));
							habitations.add(rwsLocation);
						} else if(scheme.equals("12")) {
							rwsLocation = new RwsLocationBean();
							rwsLocation.setProposalId(proposalId);
							rwsLocation.setLabCode(rs.getString(1));
							rwsLocation.setLabName(rs.getString(2));
							rwsLocation.setLocation(rs.getString(3));
							habitations.add(rwsLocation);
						}			
					}
				} catch(Exception e) {
					System.out.println("The Exception is in RwsLocation getAdminStrativeHabitations : "+e.getMessage());
				}
				finally{
					closeAll();					
				}
			} else {
				try{
					if(officeCode == null)
						officeCode = "000000";
						String headOfficeCode = officeCode.substring(0,1);
						String circleOfficeCode = proposalId.substring(4,6);
						conn = RwsOffices.getConn();
						if(!(scheme.equals("11")|| scheme.equals("12"))){
						    query=" SELECT con.CONSTITUENCY_CODE,con.CONSTITUENCY_NAME,m.mname,panch.pname,v.vname,P.panch_code, P.panch_name, "
								  +	" (H.census_plain_popu + H.census_sc_popu + H.census_st_popu)tot, "
								  + " H.coverage_status ,H.circle_office_code ,m.mcode FROM rws_panchayat_raj_tbl P,rws_constituency_tbl con,rws_mandal_tbl m, rws_panchayat_tbl panch,rws_village_tbl v, "
								  + " rws_habitation_directory_tbl H " 
								  +	" WHERE P.panch_code = H.hab_code AND H.COVERAGE_STATUS <> 'UI' AND  substr(h.hab_code,3,3)=con.CONSTITUENCY_CODE "
								  + " and con.CONSTITUENCY_TYPE ='A' and con.dcode=h.circle_office_code and"  
								  + " m.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2)  and panch.dcode=substr(h.hab_code,1,2) and panch.mcode=substr(h.hab_code,6,2)  and panch.pcode=substr(h.hab_code,13,2) and v.dcode=substr(h.hab_code,1,2) and v.mcode=substr(h.hab_code,6,2)  and v.pcode=substr(h.hab_code,13,2) and v.vcode=substr(h.hab_code,8,3) and h.circle_office_code = ? and m.mcode= ?"
								  + "  order by con.CONSTITUENCY_NAME,m.mname,p.panch_name asc";
						    query = "select distinct m.mname,p.pname,v.vname,h.panch_code,h.panch_name,(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU)tot,hd.coverage_status from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=? and m.mcode=? order by m.mname,p.pname,v.vname,h.panch_name asc";
						}else if(scheme.equals("11")) {
							query="select hab_code,SCHOOL_CODE ,SCHOOL_NAME,panch_name from  RWS_SCHOOL_MASTER_TBL  a ,rws_complete_hab_view b WHERE   substr(hab_code,1,2)=? and substr(hab_code,6,2)= ? and a.hab_code=b.panch_code";
						}
						else if(scheme.equals("12")){
							query="select lab_code,lab_name,location from  rws_water_quality_lab_tbl  WHERE  substr(office_code,2,2) = ? ";
						}
						PreparedStatement  pstmt = conn.prepareStatement(query);
						for(int i=1;i<mcodes.length;i++){
							if(!(scheme.equals("11")|| scheme.equals("12"))){
								pstmt.setString(1,circleOfficeCode);
								pstmt.setString(2,mcodes[i]);
							}
							else if(scheme.equals("11")){
								pstmt.setString(1,circleOfficeCode);
								pstmt.setString(2,mcodes[i]);
							}
							else if(scheme.equals("12")){
								pstmt.setString(1,mcodes[i]);
							}
							rs = pstmt.executeQuery();
							while(rs.next()) {
								if(!(scheme.equals("11")|| scheme.equals("12"))){
									rwsLocation = new RwsLocationBean();
									rwsLocation.setProposalId(proposalId);
									rwsLocation.setMandalName(rs.getString(1));
									rwsLocation.setPanchayatName(rs.getString(2));
									rwsLocation.setVillageName(rs.getString(3));
								 	rwsLocation.setHabCode(rs.getString(4));
									rwsLocation.setHabName(rs.getString(5));
									rwsLocation.setPopulation(rs.getString(6));
									rwsLocation.setStatus(rs.getString(7));
								}else if(scheme.equals("11")) {
									rwsLocation = new RwsLocationBean();
									rwsLocation.setProposalId(proposalId);
									rwsLocation.setHabCode(rs.getString(1));
									rwsLocation.setHabName(rs.getString(4));
									rwsLocation.setSchoolCode(rs.getString(1)+rs.getString(2));
									rwsLocation.setHabitationCode(rs.getString(1)+rs.getString(2));
									rwsLocation.setSchoolName(rs.getString(3));
									rwsLocation.setSchoolLocation(rs.getString(2));
								}
								else if(scheme.equals("12")) {
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
					catch(Exception e) {
						System.out.println("The Exception is in RwsLocation getAdminStrativeHabitations : "+e.getMessage());
					}
					finally{
						closeAll();					
					}
			}
			return habitations;
		}
	 
	public ArrayList getConstituency(String habCode ,DataSource dataSource) throws Exception
		{
			ArrayList list=new ArrayList();
			Connection conn=null;
			try
			{	
			     conn=RwsOffices.getConn();
				Statement stmt1=conn.createStatement();
				 
				ResultSet rs = stmt1.executeQuery("SELECT c.CONSTITUENCY_CODE ,c.CONSTITUENCY_NAME ,h.coverage_status  FROM " +
						" RWS_CONSTITUENCY_TBL c ,rws_habitation_directory_tbl h WHERE C.DCODE=SUBSTR('"+habCode+"',1,2) AND " +
						"C.CONSTITUENCY_CODE =SUBSTR('"+habCode+"',3,3) and h.hab_code='"+habCode+"'") ;
				
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
	
	public ArrayList getPanchayat(String sourcecode) throws Exception {
		ArrayList panchyats=new ArrayList();
		try{
			conn = RwsOffices.getConn();
			String query= "SELECT DISTINCT PCODE,PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE= ? and MCODE= ? and pcode= ? ORDER BY PNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, sourcecode.substring(0,2));
			ps.setString(2, sourcecode.substring(5,7));
			ps.setString(3, sourcecode.substring(12,14));
			rs =ps.executeQuery();
			while ( rs.next() ) {
				rwsLocation = new RwsLocationBean();
				rwsLocation.setPanchayatCode(rs.getString(1));
				rwsLocation.setPanchayatName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				panchyats.add(rwsLocation);
			}
		}
		catch (Exception e){
			System.out.println("The exception in RwsLocation getPanchyatCodes : "+e.getMessage());
		}
		finally {
			closeAll();
		}
		return panchyats;
	}


	public  ArrayList getPanchayatHabitations1(String sourcecode) throws Exception {
		ArrayList habs=new ArrayList();
		try	{
			conn = RwsOffices.getConn();
			String query = "SELECT HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE panch_code= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, sourcecode.substring(0,16));
			rs =ps.executeQuery();
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(3)+" - "+rs.getString(2));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e){
			System.out.println("The exception in RwsLocations getPanchayatHabitations1 = "+e.getMessage());
		}
		finally {
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
