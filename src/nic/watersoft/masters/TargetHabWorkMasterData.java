package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class TargetHabWorkMasterData {
	Connection conn = null;

	Statement stmt = null;

	Statement stmt1 = null;

	Statement stmt2 = null;

	Statement stmt3 = null;

	Statement stmt4 = null;

	Statement stmt5 = null;

	Statement stmt6 = null;

	Statement stmt7 = null;

	Statement stmt8 = null;

	Statement stmt9 = null;

	Statement stmt10 = null;

	Statement stmt11 = null;

	Statement stmt12 = null;

	Statement stmt13 = null;

	Statement stmt14 = null;

	Statement stmt15 = null;

	Statement stmt16 = null;

	Statement stmt17 = null;

	Statement stmt18 = null;

	Statement stmt19 = null;

	Statement stmt20 = null;

	Statement stmt21 = null;

	Statement stmt22 = null;

	Statement stmt23 = null;

	Statement stmt24 = null;

	ResultSet rs = null;

	ResultSet rset = null;

	ResultSet rs1 = null;

	ResultSet rs2 = null;

	ResultSet rs3 = null;

	ResultSet rs4 = null;

	ResultSet rs5 = null;

	ResultSet rs6 = null;

	ResultSet rs7 = null;

	ResultSet rs8 = null;

	ResultSet rs9 = null;

	ResultSet rs10 = null;

	ResultSet rs11 = null;

	ResultSet rs12 = null;

	ResultSet rs13 = null;

	ResultSet rs14 = null;

	ResultSet rs15 = null;

	ResultSet rs16 = null;

	ResultSet rs17 = null;

	ResultSet rs18 = null;

	ResultSet rs19 = null;

	ResultSet rs20 = null;

	ResultSet rs21 = null;

	ResultSet rs22 = null;

	ResultSet rs23 = null;

	ResultSet rs24 = null;

	int connCount = 0;

	PreparedStatement ps = null;

	public TargetHabWorkMasterData() {
	}

	public void closeAll() throws Exception {
		Connection conn = null;
		Statement stmt = null;
		Statement stmt1 = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		Statement stmt4 = null;
		Statement stmt5 = null;
		Statement stmt6 = null;
		Statement stmt7 = null;
		Statement stmt8 = null;
		Statement stmt9 = null;
		Statement stmt10 = null;
		Statement stmt11 = null;
		Statement stmt12 = null;
		Statement stmt13 = null;
		Statement stmt14 = null;
		Statement stmt15 = null;
		Statement stmt16 = null;
		Statement stmt17 = null;
		Statement stmt18 = null;
		Statement stmt19 = null;
		Statement stmt20 = null;
		Statement stmt21 = null;
		Statement stmt22 = null;
		Statement stmt23 = null;
		Statement stmt24 = null;
		ResultSet rs = null;
		ResultSet rset = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rs6 = null;
		ResultSet rs7 = null;
		ResultSet rs8 = null;
		ResultSet rs9 = null;
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		ResultSet rs13 = null;
		ResultSet rs14 = null;
		ResultSet rs15 = null;
		ResultSet rs16 = null;
		ResultSet rs17 = null;
		ResultSet rs18 = null;
		ResultSet rs19 = null;
		ResultSet rs20 = null;
		ResultSet rs21 = null;
		ResultSet rs22 = null;
		ResultSet rs23 = null;
		ResultSet rs24 = null;
		int connCount = 0;
		PreparedStatement ps = null;

		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs5 = null;
		}
		if (rs6 != null) {
			try {
				rs6.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs6 = null;
		}
		if (rs7 != null) {
			try {
				rs7.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs7 = null;
		}
		if (rs8 != null) {
			try {
				rs8.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs8 = null;
		}
		if (rs9 != null) {
			try {
				rs9.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs9 = null;
		}
		if (rs10 != null) {
			try {
				rs10.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs10 = null;
		}
		if (rs11 != null) {
			try {
				rs11.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs11 = null;
		}
		if (rs12 != null) {
			try {
				rs12.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs12 = null;
		}
		if (rs13 != null) {
			try {
				rs13.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs13 = null;
		}
		if (rs14 != null) {
			try {
				rs14.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs14 = null;
		}
		if (rs15 != null) {
			try {
				rs15.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs15 = null;
		}
		if (rs16 != null) {
			try {
				rs16.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs16 = null;
		}
		if (rs17 != null) {
			try {
				rs17.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs17 = null;
		}
		if (rs18 != null) {
			try {
				rs18.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs18 = null;
		}
		if (rs19 != null) {
			try {
				rs19.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs19 = null;
		}
		if (rs20 != null) {
			try {
				rs20.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs20 = null;
		}
		if (rs21 != null) {
			try {
				rs21.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs21 = null;
		}
		if (rs22 != null) {
			try {
				rs22.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs22 = null;
		}
		if (rs23 != null) {
			try {
				rs23.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs23 = null;
		}
		if (rs24 != null) {
			try {
				rs24.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rs24 = null;
		}
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			rset = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt4 = null;
		}
		if (stmt5 != null) {
			try {
				stmt5.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt5 = null;
		}
		if (stmt6 != null) {
			try {
				stmt6.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt6 = null;
		}
		if (stmt7 != null) {
			try {
				stmt7.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt7 = null;
		}
		if (stmt8 != null) {
			try {
				stmt8.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt8 = null;
		}
		if (stmt9 != null) {
			try {
				stmt9.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt9 = null;
		}
		if (stmt10 != null) {
			try {
				stmt10.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt10 = null;
		}
		if (stmt11 != null) {
			try {
				stmt11.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt11 = null;
		}
		if (stmt12 != null) {
			try {
				stmt12.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt12 = null;
		}
		if (stmt13 != null) {
			try {
				stmt13.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt13 = null;
		}
		if (stmt14 != null) {
			try {
				stmt14.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt14 = null;
		}
		if (stmt15 != null) {
			try {
				stmt15.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt15 = null;
		}
		if (stmt16 != null) {
			try {
				stmt16.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt16 = null;
		}
		if (stmt17 != null) {
			try {
				stmt17.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt17 = null;
		}
		if (stmt18 != null) {
			try {
				stmt18.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt18 = null;
		}
		if (stmt19 != null) {
			try {
				stmt19.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt19 = null;
		}
		if (stmt20 != null) {
			try {
				stmt20.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt20 = null;
		}
		if (stmt21 != null) {
			try {
				stmt21.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt21 = null;
		}
		if (stmt22 != null) {
			try {
				stmt22.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt22 = null;
		}
		if (stmt23 != null) {
			try {
				stmt23.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt23 = null;
		}
		if (stmt24 != null) {
			try {
				stmt24.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			stmt24 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData is  = "+e.getMessage());
			}
			conn = null;
		}
	}
	
	//Deepak Modified 	
	public ArrayList getExpYears() throws Exception {
		ArrayList years = new ArrayList();
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
	    java.util.Date currentDate = new java.util.Date();
	    String currentYear= dateFormat.format(currentDate).substring(0,4);
	    int currentYears = Integer.parseInt(currentYear);
		try	{
			for(int i = currentYears;i >= 2012;i--){
	        	int j = i;
	        	j++;
	        	LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(""+i);
				labelValueBean.setLabel(i+" - "+j);
				labelValueBean.setLabelValue(i+" - "+j+" - " + i);
				years.add(labelValueBean);
	        }
		}
		catch(Exception e){
			System.out.println("The Exception in TargetHabWorkMasterData in getExpYears is  = "+e.getMessage());
		}
		finally	{	
			closeAll();
		}		
		return years;
	}
	
	public ArrayList getExpYears1() throws Exception {
		ArrayList years = new ArrayList();
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
	    java.util.Date currentDate = new java.util.Date();
	    String currentYear= dateFormat.format(currentDate).substring(0,4);
	    int currentYears = Integer.parseInt(currentYear);
		try {
			for(int i = currentYears;i >= 2000;i--){
	        	int j = i;
	        	j++;
	        	LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(""+i);
				labelValueBean.setLabel(i+" - "+j);
				labelValueBean.setLabelValue(i+" - "+j+" - " + i);
				years.add(labelValueBean);
	        }
		}
		catch(Exception e){
			System.out.println("The Exception in TargetHabWorkMasterData in getExpYears1 is  = "+e.getMessage());
		}
		finally	{	
			closeAll();
		}		
		return years;
	}
	
	//Deepak Modified 	
	public ArrayList getDistricts(DataSource dataSource) throws Exception {
		ArrayList districts;
		String query="";
		TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();
		LabelValueBean targetForm = null;
		districts = new ArrayList();
		PreparedStatement ps=null;		
		try {		
			targetMasterData.conn = RwsOffices.getConn();			
			query = "select distinct d.dcode,d.dname from rws_district_tbl d where dcode<>'16' order by d.dname";
		    ps=targetMasterData.conn.prepareStatement(query);			
			targetMasterData.rs=ps.executeQuery();			
			while (targetMasterData.rs.next()) {
				targetForm = new LabelValueBean();
				targetForm.setValue(targetMasterData.rs.getString(1));
				targetForm.setLabel(targetMasterData.rs.getString(2));
				targetForm.setLabelValue(targetMasterData.rs.getString(2) + " - " + targetMasterData.rs.getString(1));
				districts.add(targetForm);
			}		
		} catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in getDistricts is  = "+e.getMessage());
		} finally {
			targetMasterData.closeAll();		
		}
		return districts;
	}

	private  boolean isExists(String dist,String year) {
		try {
			PreparedStatement ps=null;			
			conn = RwsOffices.getConn();
			ResultSet rs1 = null;
			String query="select * from rws_work_sch_target_tbl where dcode=? and fin_year=?";
			ps=conn.prepareStatement(query);
			ps.setString(1, dist);
			ps.setString(2, year);
			rs1 = ps.executeQuery();
			if (rs1.next())
				return true;
			else
				return false;
		} catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in isExists is  = "+e.getMessage());
		}	
		return false;
	}
	
	public  String districtName(String dcode) {
		TargetHabWorkMasterData targetMasterData=new TargetHabWorkMasterData();
		String dname="";
		PreparedStatement ps=null;
		String query="";
		try	{
			targetMasterData.conn = RwsOffices.getConn();
			query="select dname from rws_district_tbl where dcode=?";
			ps=conn.prepareStatement(query);
			ps.setString(1,dcode);			
			targetMasterData.rs1=ps.executeQuery();
			while(targetMasterData.rs1.next()){
				dname=targetMasterData.rs1.getString(1);
			}
		}
		catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in districtName is  = "+e.getMessage());
		} finally {
			try	{
				targetMasterData.closeAll();
			}
			catch(Exception p){
				System.out.println("The Exception in TargetHabWorkMasterData in districtName is  = "+p.getMessage());
			}			
		}
		return dname;
	}

	//Deepak Modified 	
	public  int delTarget(String dcode,String finyear){
		TargetHabWorkMasterData targetMasterData=new TargetHabWorkMasterData();
		PreparedStatement ps=null;
		int count=0;		
		try	{			
			targetMasterData.conn = RwsOffices.getConn();
			targetMasterData.conn.setAutoCommit(false);			
			ps=targetMasterData.conn.prepareStatement("delete from rws_work_sch_target_tbl where dcode=? and fin_year=?");
			ps.setString(1, dcode);
			ps.setString(2, finyear);
			count=ps.executeUpdate();
			if (count > 0) {
				targetMasterData.conn.setAutoCommit(true);
				targetMasterData.conn.commit();
			} else {
				targetMasterData.conn.rollback();
			}	
		}
		catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in delTarget is  = "+e.getMessage());
		} finally {
			try	{
				targetMasterData.closeAll();
			}
			catch(Exception p){
				System.out.println("The Exception in TargetHabWorkMasterData in delTarget is  = "+p.getMessage());
			}		
		}
		return count;
	}

	//Deepak Modified 	
	public  int updateTarget(String finyear,TargetHabWorkForm targetBean){
		TargetHabWorkMasterData targetMasterData=new TargetHabWorkMasterData();
		int count=0;
		String query="";
		PreparedStatement ps=null;		
		try{			
			targetMasterData.conn = RwsOffices.getConn();
			targetMasterData.conn.setAutoCommit(false);
			String fiyear=targetBean.getFinYear();
			query="update rws_work_sch_target_tbl set svs_habs=?,svs_exp=?,mvs_habs=?,mvs_exp=?,sch_habs=?,ang_habs=?,NO_OF_VWSC_TRAINED=?,TRAINING_TO_FTK_KITS=?,WQ_FTK_TESTS=?,PC_HABS=?,QA_HABS=?,PWS_HABS=?,HOUSE_CONNECTIONS=?  where fin_year=? and dcode=?";
			ps = targetMasterData.conn.prepareStatement(query);			
			ps.setString(1, targetBean.getSvsHabs());
			ps.setString(2, targetBean.getSvsExp());
			ps.setString(3, targetBean.getMvsHabs());
			ps.setString(4, targetBean.getMvsExp());
			ps.setString(5, targetBean.getSchHabs());
			ps.setString(6, targetBean.getAngHabs());
			ps.setString(7, targetBean.getNoofVwsctrained());
			ps.setString(8, targetBean.getTrtoFtkkits());
			ps.setString(9, targetBean.getWqftkTests());
			ps.setString(10, targetBean.getPcHabs());
			ps.setString(11, targetBean.getQaHabs());
			ps.setString(12, targetBean.getPwsHabitations());
			ps.setString(13, targetBean.getHouseConnections());
			ps.setString(14, fiyear);
			ps.setString(15, targetBean.getDist());
			count = ps.executeUpdate();
			count = ps.executeUpdate();
			if (count > 0) {
				targetMasterData.conn.setAutoCommit(true);
				targetMasterData.conn.commit();
			} else {
				targetMasterData.conn.rollback();
			}				
		}
		catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in updateTarget is  = "+e.getMessage());
		} finally {
			try	{
				targetMasterData.closeAll();
			}
			catch(Exception p){
				System.out.println("The Exception in TargetHabWorkMasterData in updateTarget is  = "+p.getMessage());
			}			
		}
		return count;
	}

	//Deepak Modified 	
	public static ArrayList getTargets(TargetHabWorkForm frm) throws Exception { 
		TargetHabWorkMasterData targetMasterData=new TargetHabWorkMasterData();
        TargetHabWorkForm targetForm = null;
        ArrayList targets = new ArrayList();
        String query1="";
    	String dname="";
    	String finyear="";
    	int syear=0;
    	String year="";
    	PreparedStatement ps=null;
    	if(frm.getFinYear()!=null && !frm.getFinYear().equals("")){
	    	finyear=frm.getFinYear();
	    	syear=Integer.parseInt(finyear);
	    	syear=syear+1;
	    	year=finyear+"-"+syear;
    	}

		try {
			targetMasterData.conn = RwsOffices.getConn();
			query1="select dcode,fin_year,svs_habs,svs_exp,mvs_habs,mvs_exp,sch_habs,ang_habs,NO_OF_VWSC_TRAINED,TRAINING_TO_FTK_KITS,WQ_FTK_TESTS,PC_HABS,QA_HABS,PWS_HABS,HOUSE_CONNECTIONS  from rws_work_sch_target_tbl  where dcode is not null ";
			if(frm.getDist()!=null && !frm.getDist().equals("all"))	{
				query1+=" and dcode='"+frm.getDist()+"'";			
			}
			if(year!=null && !year.equals("00")) {			
				query1+=" and fin_year='"+year+"'";
			}			
			query1+="order by dcode";
			ps=targetMasterData.conn.prepareStatement(query1);
			targetMasterData.rs1=ps.executeQuery();
			while(targetMasterData.rs1.next()){
				targetForm = new TargetHabWorkForm();
				targetForm.setDist(targetMasterData.rs1.getString(1));
				dname=targetMasterData.districtName(targetMasterData.rs1.getString(1));
				targetForm.setDistrictName(dname);
				targetForm.setFinYear(targetMasterData.rs1.getString(2));
				targetForm.setSvsHabs(targetMasterData.rs1.getString(3));
				targetForm.setSvsExp(targetMasterData.rs1.getString(4));
				targetForm.setMvsHabs(targetMasterData.rs1.getString(5));
				targetForm.setMvsExp(targetMasterData.rs1.getString(6));				
				targetForm.setSchHabs(targetMasterData.rs1.getString(7));
				targetForm.setAngHabs(targetMasterData.rs1.getString(8));				
				targetForm.setNoofVwsctrained(targetMasterData.rs1.getString(9));
				targetForm.setTrtoFtkkits(targetMasterData.rs1.getString(10));
				targetForm.setWqftkTests(targetMasterData.rs1.getString(11));
				targetForm.setPcHabs(targetMasterData.rs1.getString(12));
				targetForm.setQaHabs(targetMasterData.rs1.getString(13));
				targetForm.setPwsHabitations(targetMasterData.rs1.getString(14));
				targetForm.setHouseConnections(targetMasterData.rs1.getString(15));		
				targets.add(targetForm);
			}			
		} catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in getTargets is  = "+e.getMessage());
		} finally {
			targetMasterData.closeAll();			
		}
		return targets;
	}
	
	//Deepak Modified 	
	public static String getTargetDetails(TargetHabWorkForm frm) {
		TargetHabWorkMasterData targetMasterData=new TargetHabWorkMasterData();
		IfscbankForm ifscbankForm = null;
		String query1 = "";
		String name= "";
		String finyear="";
    	int syear=0;
    	String year="";
    	PreparedStatement ps=null;
    	if(frm.getFinYear()!=null && !frm.getFinYear().equals("")){
	    	finyear=frm.getFinYear();
	    	syear=Integer.parseInt(finyear);
	    	syear=syear+1;
	    	year=finyear+"-"+syear;
    	}
		try {
			targetMasterData.conn = RwsOffices.getConn();
			query1="select dcode,fin_year,svs_habs,svs_exp,mvs_habs,mvs_exp,sch_habs,ang_habs,NO_OF_VWSC_TRAINED,TRAINING_TO_FTK_KITS,WQ_FTK_TESTS,PC_HABS,QA_HABS,PWS_HABS,HOUSE_CONNECTIONS from rws_work_sch_target_tbl  where   ";
			if(frm.getDist()!=null && !frm.getDist().equals("all")){			
				query1+="   dcode='"+frm.getDist()+"'";
				query1+=" and fin_year='"+year+"'";
			}else{
				query1+=" fin_year='"+year+"'";
			}
			targetMasterData.ps = targetMasterData.conn.prepareStatement(query1);
			targetMasterData.rs1 = targetMasterData.ps.executeQuery();
			while (targetMasterData.rs1.next()) {				
				frm.setSvsHabs(targetMasterData.rs1.getString(3));
				frm.setSvsExp(targetMasterData.rs1.getString(4));
				frm.setMvsHabs(targetMasterData.rs1.getString(5));
				frm.setMvsExp(targetMasterData.rs1.getString(6));				
				frm.setSchHabs(targetMasterData.rs1.getString(7));
				frm.setAngHabs(targetMasterData.rs1.getString(8));				
				frm.setNoofVwsctrained(targetMasterData.rs1.getString(9));
				frm.setTrtoFtkkits(targetMasterData.rs1.getString(10));
				frm.setWqftkTests(targetMasterData.rs1.getString(11));
				frm.setPcHabs(targetMasterData.rs1.getString(12));
				frm.setQaHabs(targetMasterData.rs1.getString(13));
				frm.setPwsHabitations(targetMasterData.rs1.getString(14));
				frm.setHouseConnections(targetMasterData.rs1.getString(15));				
			}
		} catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in getTargetDetails is  = "+e.getMessage());
		} finally {
			try {
				if (targetMasterData.rs1 != null)
					targetMasterData.rs1.close();
				if (targetMasterData.ps != null)
					targetMasterData.ps.close();
				if (targetMasterData.conn != null)
					targetMasterData.conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData in getTargetDetails is  = "+e.getMessage());
			}
		}
		return name;
	}

	//Deepak Modified 
	public static ArrayList getTargets1(TargetBean frm)	throws Exception { 
		TargetHabWorkMasterData targetMasterData=new TargetHabWorkMasterData();
        TargetBean targetForm = null;
        ArrayList targets = new ArrayList();
        String query1="";
    	String dname="";
    	String finyear="";
    	int syear=0;
    	String year="";
    	PreparedStatement ps=null;
    	if(frm.getFinYear()!=null && !frm.getFinYear().equals("")){
	    	finyear=frm.getFinYear();
	    	syear=Integer.parseInt(finyear);
	    	syear=syear+1;
	    	year=finyear+"-"+syear;
    	}
		try {
			targetMasterData.conn = RwsOffices.getConn();
			query1="select dcode,fin_year,svs_habs,svs_exp,mvs_habs,mvs_exp,sch_habs,ang_habs,NO_OF_VWSC_TRAINED,TRAINING_TO_FTK_KITS,WQ_FTK_TESTS,PC_HABS,QA_HABS,PWS_HABS,HOUSE_CONNECTIONS  from rws_work_sch_target_tbl where dcode is not null ";
			if(frm.getDist()!=null && !frm.getDist().equals("")){
				query1+=" and dcode='"+frm.getDist()+"'";
			}
			if(frm.getFinYear()!=null && !frm.getFinYear().equals("")){
				query1+=" and fin_year='"+year+"'";
			}
			query1+="order by dcode";
			ps=targetMasterData.conn.prepareStatement(query1);
			targetMasterData.rs1=ps.executeQuery();
			while(targetMasterData.rs1.next()){
				targetForm = new TargetBean();
				targetForm.setDist(targetMasterData.rs1.getString(1));
				dname=targetMasterData.districtName(targetMasterData.rs1.getString(1));
				targetForm.setDistrictName(dname);
				targetForm.setFinYear(targetMasterData.rs1.getString(2));
				targetForm.setSvsHabs(targetMasterData.rs1.getString(3));
				targetForm.setSvsExp(targetMasterData.rs1.getString(4));
				targetForm.setMvsHabs(targetMasterData.rs1.getString(5));
				targetForm.setMvsExp(targetMasterData.rs1.getString(6));				
				targetForm.setSchHabs(targetMasterData.rs1.getString(7));
				targetForm.setAngHabs(targetMasterData.rs1.getString(8));
				targetForm.setNoofVwsctrained(targetMasterData.rs1.getString(9));
				targetForm.setTrtoFtkkits(targetMasterData.rs1.getString(10));
				targetForm.setWqftkTests(targetMasterData.rs1.getString(11));
				targetForm.setPcHabs(targetMasterData.rs1.getString(12));
				targetForm.setQaHabs(targetMasterData.rs1.getString(13));
				targetForm.setPwsHabitations(targetMasterData.rs1.getString(14));
				targetForm.setHouseConnections(targetMasterData.rs1.getString(15));			
				targets.add(targetForm);
			}			
		} catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in getTargets1 is  = "+e.getMessage());
		} finally {
			targetMasterData.closeAll();			
		}
		return targets;
	}
	
	//Deepak Modified 	
	public static ArrayList getTargetsd(String dist,String finyear)	throws Exception { 
		TargetHabWorkMasterData targetMasterData=new TargetHabWorkMasterData();
        TargetHabWorkForm targetForm = null;
        ArrayList targets = new ArrayList();
        String query1="";
    	String dname="";
    	int syear=Integer.parseInt(finyear);
    	int y=syear+1;
    	String year=finyear+"-"+y;    	
		try {	
			targetMasterData.conn = RwsOffices.getConn();
			query1="select dcode,fin_year,mvs_habs,mvs_exp,svs_habs,svs_exp,sch_habs,ang_habs,NO_OF_VWSC_TRAINED,TRAINING_TO_FTK_KITS,WQ_FTK_TESTS,PC_HABS,QA_HABS,PWS_HABS,HOUSE_CONNECTIONS  from rws_work_sch_target_tbl where dcode= ? and fin_year= ? ";
			targetMasterData.ps = targetMasterData.conn.prepareStatement(query1);
			targetMasterData.ps.setString(1, dist);
			targetMasterData.ps.setString(2, year);
			targetMasterData.rs1=targetMasterData.ps.executeQuery();
			while(targetMasterData.rs1.next())	{
				targetForm = new TargetHabWorkForm();
				targetForm.setDist(targetMasterData.rs1.getString(1));
				dname=targetMasterData.districtName(targetMasterData.rs1.getString(1));
				targetForm.setDistrictName(dname);		
				targetForm.setFinYear(targetMasterData.rs1.getString(2));
				targetForm.setMvsHabs(targetMasterData.rs1.getString(3));
				targetForm.setMvsExp(targetMasterData.rs1.getString(4));
				targetForm.setSvsHabs(targetMasterData.rs1.getString(5));
				targetForm.setSvsExp(targetMasterData.rs1.getString(6));
				targetForm.setSchHabs(targetMasterData.rs1.getString(7));
				targetForm.setAngHabs(targetMasterData.rs1.getString(8));
				targetForm.setNoofVwsctrained(targetMasterData.rs1.getString(9));
				targetForm.setTrtoFtkkits(targetMasterData.rs1.getString(10));
				targetForm.setWqftkTests(targetMasterData.rs1.getString(11));
				targetForm.setPcHabs(targetMasterData.rs1.getString(12));
				targetForm.setQaHabs(targetMasterData.rs1.getString(13));
				targetForm.setPwsHabitations(targetMasterData.rs1.getString(14));
				targetForm.setHouseConnections(targetMasterData.rs1.getString(15));	
				targets.add(targetForm);	
			}	
		} catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in getTargetsd is  = "+e.getMessage());
		} finally {
			targetMasterData.closeAll();	
		}
		return targets;
	}
	
	//Deepak Modified 			
	public static TargetBean getTargetsedit(String dcode,String year) throws Exception {   
		TargetHabWorkMasterData targetMasterData=new TargetHabWorkMasterData();
		TargetBean targetForm = null;
		ArrayList targets = new ArrayList();
		PreparedStatement ps=null;
		try {	
			targetMasterData.conn = RwsOffices.getConn();			
			String query1="";
			String dname="";
			query1="select dcode,fin_year,svs_habs,svs_exp,mvs_habs,mvs_exp,sch_habs,ang_habs,NO_OF_VWSC_TRAINED,TRAINING_TO_FTK_KITS,WQ_FTK_TESTS,PC_HABS,QA_HABS,PWS_HABS,HOUSE_CONNECTIONS  from rws_work_sch_target_tbl where dcode=? and fin_year=?";
			ps=targetMasterData.conn.prepareStatement(query1);
			ps.setString(1,dcode);
			ps.setString(2,year);
			targetMasterData.rs1=ps.executeQuery();		
			while(targetMasterData.rs1.next()){
				targetForm = new TargetBean();
				targetForm.setDist(targetMasterData.rs1.getString(1));
				dname=targetMasterData.districtName(targetMasterData.rs1.getString(1));
				targetForm.setDistrictName(dname);				
				targetForm.setFinYear(targetMasterData.rs1.getString(2));
				targetForm.setSvsHabs(targetMasterData.rs1.getString(3));
				targetForm.setSvsExp(targetMasterData.rs1.getString(4));
				targetForm.setMvsHabs(targetMasterData.rs1.getString(5));
				targetForm.setMvsExp(targetMasterData.rs1.getString(6));				
				targetForm.setSchHabs(targetMasterData.rs1.getString(7));
				targetForm.setAngHabs(targetMasterData.rs1.getString(8));
				targetForm.setNoofVwsctrained(targetMasterData.rs1.getString(9));
				targetForm.setTrtoFtkkits(targetMasterData.rs1.getString(10));
				targetForm.setWqftkTests(targetMasterData.rs1.getString(11));
			    targetForm.setPcHabs(targetMasterData.rs1.getString(12));
			    targetForm.setQaHabs(targetMasterData.rs1.getString(13));
				targetForm.setPwsHabitations(targetMasterData.rs1.getString(14));
				targetForm.setHouseConnections(targetMasterData.rs1.getString(15));				
				targets.add(targetForm);				
			}	
			
		} catch (Exception e) {
			System.out.println("The Exception in TargetHabWorkMasterData in getTargetsedit is  = "+e.getMessage());
		} finally {
			targetMasterData.closeAll();		
		}
		return targetForm;
	}

	//Deepak Modified 	
	public void resetfrm(TargetBean frm) throws Exception {
		try {
			frm.setSvsHabs("");
			frm.setSvsExp("");
			frm.setMvsHabs("");
			frm.setMvsExp("");
			frm.setSchHabs("");
			frm.setAngHabs("");		
			frm.setNoofVwsctrained("");
			frm.setWqftkTests("");
			frm.setTrtoFtkkits("");
			frm.setPcHabs("");
			frm.setQaHabs("");
			frm.setPwsHabitations("");
			frm.setHouseConnections("");		
		}
		catch(Exception e){
			System.out.println("The Exception in TargetHabWorkMasterData in resetfrm is  = "+e.getMessage());
		}	 
	}
	
	//Deepak Modified 	
   	public int saveTarget(TargetHabWorkForm targetBean, String finyear) throws Exception {
		int count = 0;
		try {		
		    TargetHabWorkMasterData targetMasterData=new TargetHabWorkMasterData();
		    targetMasterData.conn = RwsOffices.getConn();
			PreparedStatement ps=null;
			ResultSet rs1 = null;
			int syear=Integer.parseInt(finyear);
			int y=syear+1;
			String year=finyear+"-"+y;
			String query="";
			if (isExists(targetBean.getDist(),year)){			
				query="update rws_work_sch_target_tbl set svs_habs=?,svs_exp=?,mvs_habs=?,mvs_exp=?,sch_habs=?,ang_habs=?,NO_OF_VWSC_TRAINED=?,TRAINING_TO_FTK_KITS=?,WQ_FTK_TESTS=?,PC_HABS=?,QA_HABS=?,PWS_HABS=?,HOUSE_CONNECTIONS=? where fin_year=? and dcode=?";
				ps = targetMasterData.conn.prepareStatement(query);			
				ps.setString(1, targetBean.getSvsHabs());
				ps.setString(2, targetBean.getSvsExp());
				ps.setString(3, targetBean.getMvsHabs());
				ps.setString(4, targetBean.getMvsExp());
				ps.setString(5, targetBean.getSchHabs());
				ps.setString(6, targetBean.getAngHabs());
				ps.setString(7, targetBean.getNoofVwsctrained());
				ps.setString(8, targetBean.getTrtoFtkkits());
				ps.setString(9, targetBean.getWqftkTests());
			    ps.setString(10, targetBean.getPcHabs());
			    ps.setString(11, targetBean.getQaHabs());
				ps.setString(12, targetBean.getPwsHabitations());
				ps.setString(13, targetBean.getHouseConnections());
				ps.setString(14, year);
				ps.setString(15, targetBean.getDist());			
				count = ps.executeUpdate();
			}			
			else{
				query="insert into rws_work_sch_target_tbl values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				ps = targetMasterData.conn.prepareStatement(query);
				ps.setString(1, targetBean.getDist());
				ps.setString(2, year);
				ps.setString(3, targetBean.getSvsHabs());
				ps.setString(4, targetBean.getSvsExp());
				ps.setString(5, targetBean.getMvsHabs());
				ps.setString(6, targetBean.getMvsExp());
				ps.setString(7, targetBean.getSchHabs());
				ps.setString(8, targetBean.getAngHabs());
				ps.setString(9, targetBean.getNoofVwsctrained());
				ps.setString(10, targetBean.getTrtoFtkkits());
				ps.setString(11, targetBean.getWqftkTests());
				ps.setString(12, targetBean.getPcHabs());
				ps.setString(13, targetBean.getQaHabs());
				ps.setString(14, targetBean.getPwsHabitations());
				ps.setString(15, targetBean.getHouseConnections());		
				count = ps.executeUpdate();
			}	
			if (count > 0) {		
				targetMasterData.conn.commit();
			} else
				conn.rollback();
			} catch (Exception e) {
				System.out.println("The Exception in TargetHabWorkMasterData in saveTarget is  = "+e.getMessage());
			}
			return count;	
		}

}




