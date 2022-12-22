package nic.watersoft.masters;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.sql.DataSource;
import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.ResultSet;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

public class RwsHabStatusData {
	String errorMessage;
	static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
	Connection conn = null;
	
	Statement stmt = null;

	Statement stmt1 = null;
	
	Statement stmt2 = null;
	
	Statement stmt3 = null;
	
	Statement stmt4 = null;

	ResultSet rs = null;
	
	ResultSetMetaData rsm = null;

	ResultSet rs1 = null;
	
	ResultSet rs2 = null;
	
	ResultSet rs3 = null;
	
	ResultSet rs4 = null;
	
	PreparedStatement ps = null;

	
	public  void closeAll() throws Exception {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
			}
			rs4 = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}
		
	}
	

	public  int insertPanchayat(DataSource dataSource,String dcode, String mcode,String pcode,String pname) throws Exception {   
		RwsMaster rwsMaster = null;
		
		String query="";
		int rcount=0;

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " update rws_panchayat_tbl set pname=? where dcode=? and mcode=? and pcode=?";
	PreparedStatement ps=conn.prepareStatement(query);
	ps.setString(1, pname);
	ps.setString(2, dcode);
	ps.setString(3, mcode);
	ps.setString(4, pcode);
	//end of code added
	Debug.println("query is "+query);
	rcount = ps.executeUpdate();
	
			
		
	} catch (Exception e) {
		Debug.println("The error in insertPanchayat=" + e);
	} finally {
		
		closeAll();
	}
	Debug.println("count in panchayat:::"+rcount);
	return rcount;
}
	
	public  boolean insertHabContamination(DataSource dataSource,RwsMaster rwsMaster) throws Exception {   
		
		
		String query="";
		int rcount=0;
		String habCode=rwsMaster.getHabCode();
		boolean insertedAll=true;
		try 
		{
			
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			
			boolean flourideConaminationDetailsExists=false;
			boolean brakishConaminationDetailsExists=false;
			boolean ironConaminationDetailsExists=false;
			boolean aresenicConaminationDetailsExists=false;
			boolean nitrateConaminationDetailsExists=false;
			
			query="select * from rws_hab_contamination_tbl where hab_code='"+habCode+"'";
			Debug.println("cccc::"+query);
			rs = stmt.executeQuery(query);
			while (rs.next()) 
			{
				
				if(rs.getString("CONT_TYPE").equals("01"))
				{
					flourideConaminationDetailsExists=true;
				}
				else if(rs.getString("CONT_TYPE").equals("02"))
				{
					brakishConaminationDetailsExists=true;
				}
				else if(rs.getString("CONT_TYPE").equals("03"))
				{
					ironConaminationDetailsExists=true;
				}	
				else if(rs.getString("CONT_TYPE").equals("04"))
				{
					aresenicConaminationDetailsExists=true;
				}
				else if(rs.getString("CONT_TYPE").equals("05"))
				{
					nitrateConaminationDetailsExists=true;
				}	
			}
			
			if(!flourideConaminationDetailsExists)
				//query="insert into rws_hab_contamination_tbl(HAB_CODE,CONT_TYPE,CONT_PERC,STATUS_DATE) " +
						//"values('"+habCode+"','01','"+rwsMaster.getFlourideContamination()+"',to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy'))";
				query="";
			else
				query="update rws_hab_contamination_tbl " +
				"set   " +
				"cont_perc='"+rwsMaster.getFlourideContamination()
				+"', status_date=to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy') where hab_code='"+habCode+"' and cont_type='01'";
			
			Debug.println("query is "+query);
			if(!query.equals(""))stmt.addBatch(query);
			if(!brakishConaminationDetailsExists)
				//query="insert into rws_hab_contamination_tbl(HAB_CODE,CONT_TYPE,CONT_PERC,STATUS_DATE) " +
						//"values('"+habCode+"','02','"+rwsMaster.getBrakishContamination()+"',to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy'))";
				query="";
			else
				query="update rws_hab_contamination_tbl " +
				"set   " +
				"cont_perc='"+rwsMaster.getBrakishContamination()
				+"', status_date=to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy') where hab_code='"+habCode+"'  and cont_type='02'";
			
			Debug.println("query is "+query);
			if(!query.equals(""))stmt.addBatch(query);
			
			if(!ironConaminationDetailsExists)
				//query="insert into rws_hab_contamination_tbl(HAB_CODE,CONT_TYPE,CONT_PERC,STATUS_DATE) " +
					//	"values('"+habCode+"','03','"+rwsMaster.getIronContamination()+"',to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy'))";
				query="";
			else
				query="update rws_hab_contamination_tbl " +
				"set  " +
				"cont_perc='"+rwsMaster.getIronContamination()
				+"', status_date=to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy') where hab_code='"+habCode+"'  and cont_type='03'";
		//	Debug.println("query is "+query);
			if(!query.equals(""))stmt.addBatch(query);
			
			if(!aresenicConaminationDetailsExists)
				//query="insert into rws_hab_contamination_tbl(HAB_CODE,CONT_TYPE,CONT_PERC,STATUS_DATE) " +
					//	"values('"+habCode+"','04','"+rwsMaster.getAresenicContamination()+"',to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy'))";
				query="";
			else
				query="update rws_hab_contamination_tbl " +
				"set  " +
				"cont_perc='"+rwsMaster.getAresenicContamination()
				+"', status_date=to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy') where hab_code='"+habCode+"'  and cont_type='04'";
			//Debug.println("query is "+query);
			if(!query.equals(""))stmt.addBatch(query);
			
			if(!nitrateConaminationDetailsExists)
				//query="insert into rws_hab_contamination_tbl(HAB_CODE,CONT_TYPE,CONT_PERC,STATUS_DATE) " +
						//"values('"+habCode+"','05','"+rwsMaster.getNitrateContamination()+"',to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy'))";
				query="";
			else
				query="update rws_hab_contamination_tbl " +
				"set  " +
				"cont_perc='"+rwsMaster.getNitrateContamination()
				+"', status_date=to_date('"+rwsMaster.getStatusDate()+"','dd/mm/yyyy') where hab_code='"+habCode+"'  and cont_type='05'";
			//Debug.println("query is "+query);
			if(!query.equals(""))stmt.addBatch(query);
			
	//end of code added
	
	int rcounts[] = stmt.executeBatch();
	for(int i=0;i<rcounts.length;i++)
	{
		Debug.println("rcounts["+i+"]="+rcounts[i]);
		if(rcounts[0]==0)
			insertedAll=false;
	}
	
	if(insertedAll)		
	conn.commit();	
	} catch (Exception e) {
		Debug.println("The error in insertHabContamination=" + e);
		insertedAll=false;
	} finally {
		conn.setAutoCommit(true);
		closeAll();
	}
	Debug.println("insertedAll"+insertedAll);
	return insertedAll;
}
	
	public  int insertHabitation(DataSource dataSource,String habCode,String habName) throws Exception {   
		RwsMaster rwsMaster = null;
		
		String query="";
		int rcount=0;

	try 
	{
	
	conn = RwsOffices.getConn();
	stmt = conn.createStatement();
	query = " update rws_panchayat_raj_tbl set panch_name=? where panch_code=?";
	PreparedStatement ps=conn.prepareStatement(query);
	ps.setString(1,habName);
	ps.setString(2, habCode);
	//end of code added
	//Debug.println("query is "+query);
	rcount = ps.executeUpdate();
	
	} catch (Exception e) {
		Debug.println("The error in insertPanchayat=" + e);
	} finally {
		closeAll();
	}
	return rcount;
}
	
	/*
	public  int ReplaceHabitationCode(DataSource dataSource,String habCode,String habName) throws Exception {   
		RwsMaster rwsMaster = null;
		
		String query="";
		int rcount=0;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			stmt2= conn.createStatement();
			query = " SELECT D.DCODE,D.DNAME,CON.CONSTITUENCY_CODE,CON.CONSTITUENCY_NAME,M.MCODE,M.MNAME,P.PCODE,P.PNAME,V.VCODE,V.VNAME FROM RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_PANCHAYAT_TBL P,RWS_VILLAGE_TBL V,RWS_CONSTITUENCY_TBL CON "
				+ " WHERE D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND P.DCODE=V.DCODE AND M.MCODE=P.MCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE AND CON.DCODE=V.DCODE AND CON.CONSTITUENCY_TYPE ='A' AND D.DCODE = '" + habCode.substring(0,2) + "'"
				+ " and  M.MCODE = '" + habCode.substring(5,7) + "' ANC CON.CONSTITUENCY_CODE='"+habCode.substring(2,5)+"' P.PCODE='"+habCode.substring(12,14)+"' and v.vcode='"+habCode.substring(7,10)+"'"
				+ " ORDER BY d.dcode,m.mcode,p.pcode,V.VCODE,hab_code ";
			Debug.println("query is "+query);
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
			query = " insert into rws_habmast_tbl(dcode,acode,aname,mcode,pcode," 
					+"pname,vcode,vname,hcode,hname,prc,hab_code,prhab)" 
					+" values('"+rs.getString("dcode")+"','"+rs.getString("acode")+"','"
					+rs.getString("aname")+"','"+rs.getString("mcode")+"','"
					+rs.getString("pcode")+"','"+rs.getString("pname")+"','"
					+rs.getString("vcode")+"','"+rs.getString("vname")+"','"
					+habCode.substring(10,12)+"','"+habName+"','"
					+habCode.substring(14,16)+"','"+habCode.substring(0,14)
					+"','"+habCode+"')";
					
			}
			stmt2.addBatch(query);
			query="select * from rws_habitation_directory_tbl where hab_code='"+existingHabCode+"'";
			rs=stmt.executeQuery(query);
			while(rs.next())
			{
				query = "insert into RWS_HABITATION_DIRECTORY_TBL values("
					+ "'" + rwsMaster.getCircleOfficeCode() + "'," + rwsMaster.getDivisionOfficeCode()
					+ "," + "'" + rwsMaster.getSubdivisionOfficeCode() + "','"
					+ rs.getString("hab_code") + "'," + "'"
					+ rs.getString("CENSUS_YEAR") + "',"
					+ rs.getString("CENSUS_PLAIN_POPU") + "," + ""
					+ rs.getString("CENSUS_SC_POPU") + ","
					+ rs.getString("CENSUS_ST_POPU") + "," + ""
					+ rs.getString("FLOAT_POP") + ",'"
					+ rs.getString("FLOAT_POP_REASONS") + "'," + "TO_DATE('"
					+ rs.getString("STATUS_DATE") + "','dd/mm/yyyy')," + ""
					+ rs.getString("PLAIN_POPU_COVERED") + ","
					+ rs.getString("SC_POP_COVERED") + "," + ""
					+ rs.getString("ST_POP_COVERED") + ","
					+ rs.getString("TOTAL_WATER_SUPPLY") + "," + ""
					+ rs.getString("EXIST_WATER_LEVEL") + "," + "'"
					+ rs.getString("COVERAGE_STATUS") + "'," + ""
					+ rs.getString("NEAR_SURFACE_SOURCE") + "," + ""
					+ rs.getString("NEAR_GROUND_SOURCE") + "," + "'"
					+ rs.getString("REMARKS") + "','"
					+ rs.getString("QUALITY_AFFECTED") + "'," + "TO_DATE('"
					+ rs.getString("UPDATE_DATE") + "','dd/mm/yyyy'),'"
					+ rs.getString("PREVIOUS_YR_STATUS") + "','"
					+ rs.getString("PRESENT_YR_STATUS") + "','"
					+ rs.getString("PROPOSED_FC_YEAR") + "',"
					+ rs.getString("PROPOSED_FC_EST_AMT") + ")";
					
			}
			stmt2.addBatch(query);
			query="insert into rws_panchayat_raj_tbl(hab_code,panch_code,panch_name) values('"+habCode.substring(0,14)+"','"+habCode+"','"+habName+"')";
			stmt2.addBatch(query);
			int rcounts[]=stmt2.executeBatch();
	//end of code added
	Debug.println("query is "+query);
	rcount = stmt.executeUpdate(query);
	
			
		
	} catch (Exception e) {
		Debug.println("The error in insertPanchayat=" + e);
	} finally {
		
		closeAll();
	}
	return rcount;
}
	*/
	public  int insertVillage(DataSource dataSource,String dcode, String mcode,String pcode,String vcode,String vname) throws Exception {   
		RwsMaster rwsMaster = null;
		
		String query="";
		int rcount=0;

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " update rws_village_tbl set vname=? where dcode=? and mcode=? and pcode=? and vcode=?";
	PreparedStatement ps=conn.prepareStatement(query);
	ps.setString(1, vname);
	ps.setString(2, dcode);
	ps.setString(3,mcode);
	ps.setString(4, pcode);
	ps.setString(5, vcode);
	//end of code added
	//Debug.println("query is "+query);
	rcount = ps.executeUpdate();
	
			
		
	} catch (Exception e) {
		Debug.println("The error in insertVillage=" + e);
	} finally {
		
		closeAll();
	}
	return rcount;
}
	public  String deletePanchayat(DataSource dataSource,String dcode, String mcode,String pcode) throws Exception {   
		RwsMaster rwsMaster = null;
		
		String query="";
		String msg="";
		int rcount=0;
		boolean childRecordExists=false;

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " select * from rws_village_tbl where dcode=? and mcode=? and pcode=?";
			PreparedStatement ps= conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2,mcode);
			ps.setString(3, pcode);
			//Debug.println("query is "+query);
			rs = ps.executeQuery();
			while(rs.next())
			{
				childRecordExists=true;
				msg="Record Cannot be Deleted As Villages For This Code Exists";
			}
			if(!childRecordExists)
			{
			query = " delete  from rws_panchayat_tbl  where dcode=? and mcode=? and pcode=?;
	
			//end of code added
		//	Debug.println("query is "+query);
			ps=conn.prepareStatement(query);
			Ps.setString(1,dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rcount = ps.executeUpdate();
			if(rcount>0)
				msg="Record Deleted Successfully";
			}
			
		
	} catch (Exception e) {
		msg="Record Cannot be Deleted";
		Debug.println("The error in insertPanchayat=" + e);
	} finally {
		
		closeAll();
	}
	return msg;
}
	
	public  String deleteContaminationDetails(DataSource dataSource,String habCode) throws Exception {   
		
		
		String query="";
		String msg="";
		int rcount=0;
		

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			
			query = " delete  from rws_hab_contamination_tbl  where hab_code=?";
            PreparedStatement ps=conn.prepareStatement(query); 
		    ps.setString(1,habCode);
		//	Debug.println("query is "+query);
			rcount = ps.executeUpdate();
			if(rcount>0)
				msg="Record Deleted Successfully";
			else
				msg="Record Cannot be Deleted";
			
		
	} catch (Exception e) {
		msg="Record Cannot be Deleted";
		Debug.println("The error in deleteContaminationDetails=" + e);
	} finally {
		
		closeAll();
	}
	return msg;
}
	public  int[] deleteHabitation(String habCode, DataSource dataSource)
	throws Exception {   
	int[] updateCounts=null;
	try {
	conn = RwsOffices.getConn();
	conn.setAutoCommit(false);
	stmt = conn.createStatement();
	String query="DELETE  FROM RWS_HAB_INSTITUTE_TBL WHERE HAB_CODE='"
		+ habCode + "'";
	//Debug.println("query is "+query);
	stmt.addBatch(query);
	query="DELETE  FROM RWS_HAB_COMPONENT_TBL WHERE HAB_CODE='"
		+ habCode + "'";
	//Debug.println("query is "+query);
	stmt.addBatch(query);
	query="DELETE  FROM RWS_HAB_CONTAMINATION_TBL WHERE HAB_CODE='"
		+ habCode + "'";
	//Debug.println("query is "+query);
	stmt.addBatch(query);
	query="DELETE  FROM RWS_HAB_SUPPLY_STATUS_TBL WHERE HAB_CODE='"
		+ habCode + "'";
	stmt.addBatch(query);
	//Debug.println("query is "+query);
	query="DELETE  FROM RWS_PANCHAYAT_RAJ_TBL WHERE PANCH_CODE='"
		+ habCode + "'";
	stmt.addBatch(query);
	//Debug.println("query is "+query);
	query="DELETE  FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE='"
		+ habCode + "'";
	stmt.addBatch(query);
	//Debug.println("query is "+query);
	query="DELETE  FROM RWS_HABMAST_TBL WHERE PRHAB='"
		+ habCode + "'";
	stmt.addBatch(query);
	//Debug.println("query is "+query);
	updateCounts = stmt.executeBatch();
	conn.commit();
	} catch (Exception e) {
	Debug.println("The error in deleteHabitation= " + e);
	} finally {
	conn.setAutoCommit(true);
	closeAll();
	}
	return updateCounts;
	}
	public  String deleteVillage(DataSource dataSource,String dcode, String mcode,String pcode,String vcode) throws Exception {   
		RwsMaster rwsMaster = null;
		
		String query="";
		String msg="";
		int rcount=0;
		

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			
			
			query = " delete  from rws_village_tbl  where dcode=? and mcode=? and pcode=? and vcode=?";
	        PreparedStatement ps=conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
	        //end of code added
			//Debug.println("query is "+query);
			rcount = ps.executeUpdate();
			if(rcount>0)
				msg="Record Deleted Successfully";
			else
				msg="Record Cannot be deleted";
			
			
		
	} catch (Exception e) {
		msg="Record Cannot be Deleted";
		Debug.println("The error in deleteVillage=" + e);
	} finally {
		
		closeAll();
	}
	return msg;
}
	public  String insertNewPanchayat(DataSource dataSource,String dcode, String mcode,String pcode,String pname) throws Exception {   
		RwsMaster rwsMaster = null;
		
		String query="";
		String msg="";
		boolean codeAlreadyExists=false;
		int rcount=0;

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query= " select * from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"'";
			Debug.println("query is "+query);
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
				msg="Duplicate Code: Code Already  assigned to "+rs.getString("pname")+". Try Again";
				codeAlreadyExists=true;
				
			}
			
			if(!codeAlreadyExists)
			{
			query = " insert into rws_panchayat_tbl(dcode,mcode,pcode,pname) values(?,?,?,?)";
	         Ps=conn.conn.prepareStatement(query);
	         ps.setString(1, dcode);
	         ps.setString(2, mcode);
	         ps.setString(3,pcode);
	         ps.setString(4, pname);
			//end of code added
			Debug.println("query is "+query);
			rcount = ps.executeUpdate();
			if(rcount>0)
			msg="Record Inserted Successfully";
			else
			msg="Record Cannot be inserted";
			}
		
	} catch (Exception e) {
		
		Debug.println("The error in insertPanchayat=" + e);
		msg="Record Cannot be Inserted";
		
	} finally {
		
		closeAll();
	}
	return msg;
}
	
	public  String insertNewHabitation(DataSource dataSource,String dcode,String acode,String mcode,String pcode,String vcode,String hcode,String prcode,String prHabName) throws Exception{   
		RwsMaster rwsMaster = null;
		String habCode=dcode+acode+mcode+vcode+hcode+pcode+prcode;
		String query="";
		String msg="";
		boolean codeAlreadyExists=false;
		int rcounts[];

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			
			query= " select * from rws_panchayat_raj_tbl where panch_code='"+habCode+"'";
			Debug.println("query is "+query);
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
				msg="Duplicate Code: Code Already  assigned to "+rs.getString("panch_name")+". Try Again";
				codeAlreadyExists=true;
			}
			
			if(!codeAlreadyExists)
			{
				String dname="",conName="",mname="",pname="",vname="";
				query = "select d.dcode,d.dname,con.constituency_code," +
						" con.constituency_name,m.mcode,m.mname,p.pcode," +
						" p.pname,v.vcode,v.vname from rws_district_tbl d," +
						" rws_constituency_tbl con,rws_mandal_tbl m," +
						" rws_panchayat_tbl p,rws_village_tbl v " +
						" where d.dcode='"+dcode+"' and con.dcode=d.dcode " +
						" and con.constituency_code='"+acode+"' and m.dcode=d.dcode " +
						" and m.mcode='"+mcode+"' and p.dcode=d.dcode and p.mcode=m.mcode " +
						" and p.pcode='"+pcode+"' and v.dcode=d.dcode and v.mcode=m.mcode" +
						" and v.pcode=p.pcode and v.vcode='" +vcode+"' ";
				Debug.println("query is "+query);
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					dname=rs.getString("dname");
					conName=rs.getString("constituency_name");
					mname=rs.getString("mname");
					pname=rs.getString("pname");
					vname=rs.getString("vname");
				}
				query = " insert into rws_habmast_tbl(dcode,acode,aname,mcode,pcode,pname,vcode,vname,hcode,hname,prc,hab_code,prhab) values('"+dcode+"','"+acode+"','"+conName+"','"+mcode+"','"+pcode+"','"+pname+"','"+vcode+"','"+vname+"','"+hcode+"','"+prHabName+"','"+prcode+"','"+habCode.substring(0,14)+"','"+habCode.substring(0,16)+"')";
	
				//Debug.println("query is "+query);
				stmt.addBatch(query);
				query = " insert into rws_habitation_directory_tbl(CIRCLE_OFFICE_CODE,HAB_CODE) values('"+dcode+"','"+habCode+"')";
				
				//Debug.println("query is "+query);
				stmt.addBatch(query);
				query = " insert into rws_panchayat_raj_tbl(HAB_CODE,PANCH_CODE,PANCH_NAME) values('"+habCode.substring(0,14)+"','"+habCode+"','"+prHabName+"')";
			
			//	Debug.println("query is "+query);
				stmt.addBatch(query);
				rcounts=stmt.executeBatch();
			boolean inserted=true;
			for(int i=0;i<rcounts.length;i++)
			{
				if(rcounts[i]==0)
					inserted=false;
				
			}
			if(inserted)
			{
			msg="Record Inserted Successfully";
			conn.commit();
			}
			else
			msg="Record Cannot be inserted";
			}
			conn.setAutoCommit(true);
	} catch (Exception e) {
		
		Debug.println("The error in insertNewPanchayat=" + e);
		msg="Record Cannot be Inserted";
		
	} finally {
		
		closeAll();
	}
	return msg;
}

	public  String insertNewVillage(DataSource dataSource,String dcode, String mcode,String pcode,String vcode,String vname) throws Exception {   
		RwsMaster rwsMaster = null;
		
		String query="";
		String msg="";
		boolean codeAlreadyExists=false;
		int rcount=0;

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query= " select * from rws_village_tbl where dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"' and vcode='"+vcode+"'";
			Debug.println("query is "+query);
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
				msg="Duplicate Code: Code Already  assigned to "+rs.getString("vname")+". Try Again";
				codeAlreadyExists=true;
				
			}
			
			if(!codeAlreadyExists)
			{
			query = " insert into rws_village_tbl(dcode,mcode,pcode,vcode,vname) values(?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4,vcode);
			ps.setString(4,vname);
			//end of code added
			Debug.println("query is "+query);
			rcount = stmt.executeUpdate();
			if(rcount>0)
			msg="Record Inserted Successfully";
			else
			msg="Record Cannot be inserted";
			}
		
	} catch (Exception e) {
		
		Debug.println("The error in insertNewVillage=" + e);
		msg="Record Cannot be Inserted";
		
	} finally {
		
		closeAll();
	}
	return msg;
}
	
	public  ArrayList getPanchayatDetails(String dcode, String mcode,DataSource dataSource) throws Exception {   
		RwsMaster rwsMaster = null;
		ArrayList panchayatDetails = new ArrayList();
		String query="";
		

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT D.DCODE,D.DNAME,M.MCODE,M.MNAME,P.PCODE,P.PNAME FROM RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_PANCHAYAT_TBL P "
				+ " WHERE D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE=P.MCODE AND D.DCODE = '" + dcode + "'"
				+ " AND M.MCODE = '" + mcode + "'"
				
				+ " ORDER BY d.dcode,m.mcode,p.pcode ";
	
	//end of code added
	Debug.println(query);
	rs = stmt.executeQuery(query);
	while (rs.next()) {
		rwsMaster = new RwsMaster();

		rwsMaster.setDcode(rs.getString("DCODE"));
		rwsMaster.setDname(rs.getString("DNAME"));
		rwsMaster.setMcode(rs.getString("MCODE"));
		rwsMaster.setMname(rs.getString("MNAME"));
		rwsMaster.setPcode(rs.getString("PCODE"));
		rwsMaster.setPname(rs.getString("PNAME"));
		panchayatDetails.add(rwsMaster);
	}
			
		
	} catch (Exception e) {
		Debug.println("The error in getHabStatuss=" + e);
	} finally {
		
		closeAll();
	}
	return panchayatDetails;
}
	
	public  RwsMaster getHabContaminationDetails(DataSource dataSource,String habCode) throws Exception {   
		RwsMaster rwsMaster = null;
		ArrayList contaminationDetails = new ArrayList();
		String query="";
		

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select HAB_CODE,CONT_TYPE,CONT_PERC,to_char(STATUS_DATE,'dd/mm/yyyy')as status_date,to_char(sysdate,'dd/mm/yyyy')as sys_date from rws_hab_contamination_tbl  where hab_code='"+habCode+"'";
	
	//end of code added
	Debug.println(query);
	rs = stmt.executeQuery(query);
	Debug.println("executedQuery");
	rwsMaster = new RwsMaster();
	rwsMaster.setContTypes1("N");
	rwsMaster.setContTypes2("N");
	rwsMaster.setContTypes3("N");
	rwsMaster.setContTypes4("N");
	rwsMaster.setContTypes5("N");
	
	while (rs.next()) {
		rwsMaster.setStatusDate(rs.getString("status_date"));
		if(rs.getString("CONT_TYPE").equals("01"))
		{
			rwsMaster.setFlourideContamination(rs.getString("CONT_PERC"));
			rwsMaster.setContTypes1("Y");
		}
		else if(rs.getString("CONT_TYPE").equals("02"))
		{
			rwsMaster.setBrakishContamination(rs.getString("CONT_PERC"));
			rwsMaster.setContTypes2("Y");
		}
		else if(rs.getString("CONT_TYPE").equals("03"))
		{
			rwsMaster.setIronContamination(rs.getString("CONT_PERC"));
			rwsMaster.setContTypes3("Y");
		}
		else if(rs.getString("CONT_TYPE").equals("04"))
		{
			rwsMaster.setAresenicContamination(rs.getString("CONT_PERC"));
			rwsMaster.setContTypes4("Y");
		}
		else if(rs.getString("CONT_TYPE").equals("05"))
		{
			rwsMaster.setNitrateContamination(rs.getString("CONT_PERC"));
			rwsMaster.setContTypes5("Y");
		}
		
		rwsMaster.setSysDate(rs.getString("sys_date"));	
	}
		Debug.println("flouride:"+rwsMaster.getFlourideContamination());
		Debug.println("Brakish:"+rwsMaster.getBrakishContamination());
		Debug.println("Iron:"+rwsMaster.getIronContamination());
		Debug.println("Aresenic:"+rwsMaster.getAresenicContamination());
		Debug.println("Nitrate:"+rwsMaster.getNitrateContamination());
		
	} catch (Exception e) {
		Debug.println("The error in getHabContaminationDetails=" + e);
	} finally {
		
		closeAll();
	}
	return rwsMaster;
}
	
	public  ArrayList getHabitationDetails(String dcode,String mcode,String mandalName,String constituencyCode,String constituencyName,String pcode,String pname,String vcode,String vname,DataSource dataSource) throws Exception {   
		Debug.println("in getHabitationDetails");
		RwsMaster rwsMaster = null;
		ArrayList habitaitonDetails = new ArrayList();
		String query="";
		Debug.println("dao1");
		//if(!dcode.equals("")&&!mcode.equals("")&&!constituencyCode.equals("")&&pcode.equals(""))
		if(!dcode.equals("")&&!mcode.equals("")&&pcode.equals(""))
		{
			Debug.println("in if 1");
			query="select p.pcode,p.pname,v.vcode,v.vname, " +
					"h.hab_code,h.hname,pr.panch_code,pr.panch_name" +
					" from rws_panchayat_tbl p,rws_village_tbl v," +
					"rws_habmast_tbl h," +
					"rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl hd where substr(h.hab_code,1,2)='"+dcode+"'" +
					"and substr(h.hab_code,6,2)='"+mcode+"' and " +
					//"substr(h.hab_code,3,3)='"+constituencyCode+"' and " +
					"(p.dcode=substr(h.hab_code,1,2)and " +
					"p.mcode=substr(h.hab_code,6,2) and " +
					"p.pcode=substr(h.hab_code,13,2)) " +
					"and(v.dcode=substr(h.hab_code,1,2)and " +
					"v.mcode=substr(h.hab_code,6,2) and " +
					"v.pcode=substr(h.hab_code,13,2) and " +
					"v.vcode=substr(h.hab_code,8,3))and " +
					"(h.prhab=pr.panch_code) and pr.panch_code=hd.hab_code order by hd.hab_code";					
		}
		
		else if(!dcode.equals("")&&!mcode.equals("")&&!pcode.equals("")&&vcode.equals(""))
		{
			Debug.println("in if 2");
			query="select v.vcode,v.vname,h.hab_code,h.hname," +
			"pr.panch_code,pr.panch_name from rws_village_tbl v," +
			" rws_habmast_tbl h,rws_panchayat_raj_tbl pr,rws_habitation_directory_Tbl hd " +
			" where substr(h.hab_code,1,2)='"+dcode+"'and " +
			"substr(h.hab_code,6,2)='"+mcode+"' and " +
			//"substr(h.hab_code,3,3)='"+constituencyCode+"' and " +
			"substr(h.hab_code,13,2)='"+pcode+"'" +
			" and(v.dcode=substr(h.hab_code,1,2)" +
			" and v.mcode=substr(h.hab_code,6,2) " +
			" and v.pcode=substr(h.hab_code,13,2) " +
			" and v.vcode=substr(h.hab_code,8,3))" +
			" and (h.prhab=pr.panch_code) and  pr.panch_code=hd.hab_code";
		}
		else if(!dcode.equals("")&&!mcode.equals("")&&!pcode.equals("")&&!vcode.equals(""))
		{
			Debug.println("in if 3");
			query="select h.hab_code,h.hname,pr.panch_code," +
					"pr.panch_name from rws_habmast_tbl h,rws_habitation_directory_tbl hd," +
					"rws_panchayat_raj_tbl pr " +
					"where substr(h.hab_code,1,2)='"+dcode+"'" +
					"and substr(h.hab_code,6,2)='"+mcode+"' " +
					//"and substr(h.hab_code,3,3)='"+constituencyCode+"' " +
					"and substr(h.hab_code,13,2)='"+pcode+"'" +
					" and substr(h.hab_Code,8,3)='"+vcode+"' " +
					"and (h.prhab=pr.panch_code) and pr.panch_code=hd.hab_code";  

		}
		Debug.println("dao2");
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			/*
			query = " SELECT HD.HAB_CODE,PR.PANCH_NAME,D.DCODE,D.DNAME,CON.CONSTITUENCY_CODE,CON.CONSTITUENCY_NAME,M.MCODE,M.MNAME,P.PCODE,P.PNAME,V.VCODE,V.VNAME FROM RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_PANCHAYAT_TBL P,RWS_VILLAGE_TBL V,RWS_CONSTITUENCY_TBL CON,RWS_HABMAST_TBL HM,RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR "
				+ " WHERE D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND P.DCODE=V.DCODE AND M.MCODE=P.MCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE AND CON.DCODE=V.DCODE AND CON.CONSTITUENCY_TYPE ='A' AND D.DCODE = '" + dcode + "'"
				+ " AND HM.PRHAB=HD.HAB_CODE AND HD.HAB_CODE=PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2)=D.DCODE AND SUBSTR(HD.HAB_CODE,6,2)=M.MCODE AND SUBSTR(HD.HAB_CODE,13,2)=P.PCODE AND   SUBSTR(HD.HAB_CODE,3,3)=CON.CONSTITUENCY_CODE AND SUBSTR(HD.HAB_CODE,1,2)=V.DCODE AND SUBSTR(HD.HAB_CODE,6,2)=V.MCODE AND SUBSTR(HD.HAB_CODE,13,2)=V.PCODE AND SUBSTR(HD.HAB_CODE,8,3)=V.VCODE AND M.MCODE = '" + mcode + "'"
				
				+ " ORDER BY d.dcode,m.mcode,p.pcode,V.VCODE,hab_code ";
				*/
	
	//end of code added
	Debug.println(query);
	rs = stmt.executeQuery(query);
	while (rs.next()) {
		rwsMaster = new RwsMaster();

		/*
		rwsMaster.setDcode(rs.getString("DCODE"));
		rwsMaster.setDname(rs.getString("DNAME"));
		rwsMaster.setConstituencyCode(rs.getString("CONSTITUENCY_CODE"));
		rwsMaster.setConstituencyName(rs.getString("CONSTITUENCY_NAME"));
		rwsMaster.setMcode(rs.getString("MCODE"));
		rwsMaster.setMname(rs.getString("MNAME"));
		*/
		if(pcode.equals(""))
		{
		rwsMaster.setPcode(rs.getString("PCODE"));
		rwsMaster.setPname(rs.getString("PNAME"));
		}
		if(vcode.equals(""))
		{
		rwsMaster.setVcode(rs.getString("VCODE"));
		rwsMaster.setVname(rs.getString("VNAME"));
		}
		rwsMaster.setHabCode(rs.getString("panch_CODE"));
		rwsMaster.setHabName(rs.getString("PANCH_NAME"));
		habitaitonDetails.add(rwsMaster);
	}
			
		
	} catch (Exception e) {
		Debug.println("The error in getHabitationDetails=" + e);
	} finally {
		
		closeAll();
	}
	Debug.println("returning");
	return habitaitonDetails;
}
	
	
	public  ArrayList getContaminationDetails(String dcode,DataSource dataSource) throws Exception {   
		RwsMaster rwsMaster = null;
		ArrayList contaminationDetails = new ArrayList();
		String query="";
		

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			
			/*
			query=" select contaminationDetails.*,pr.panch_name from rws_panchayat_raj_tbl pr,(";
			
			query+= " select cont01_hab_code,cont01_cont_type," +
					" cont01_contamination_name,cont01_cont_perc,conttype01.status_date," +
					" cont02_cont_type,cont02_contamination_name," +
					" cont02_cont_perc,cont03_cont_type," +
					" cont03_contamination_name,cont03_cont_perc from ";
			
			query+=	" (select hab_code as cont01_hab_code,habcont.cont_Type as cont01_cont_type,cont.contamination_name as cont01_contamination_name," +
					" cont_perc as cont01_cont_perc,to_char(habcont.status_date,'dd/mm/yyyy')as status_date from rws_hab_contamination_tbl habcont," +
					" rws_contamination_tbl cont where substr(hab_code,1,2)='"+dcode+"' " +
					" and cont_type='01' and habcont.cont_type=cont.contamination_code)conttype01,";

			query +=" (select hab_code as cont02_hab_code,habcont.cont_Type as cont02_cont_type,cont.contamination_name as cont02_contamination_name," +
					" cont_perc as cont02_cont_perc from rws_hab_contamination_tbl habcont," +
					" rws_contamination_tbl cont where substr(hab_code,1,2)='"+dcode+"' " +
					" and cont_type='02' and habcont.cont_type=cont.contamination_code)conttype02,";

			query+= " (select hab_code as cont03_hab_code,habcont.cont_Type as cont03_cont_type,cont.contamination_name as cont03_contamination_name," +
					" cont_perc as cont03_cont_perc  from rws_hab_contamination_tbl habcont," +
					" rws_contamination_tbl cont where substr(hab_code,1,2)='"+dcode+"' " +
					" and cont_type='03' and habcont.cont_type=cont.contamination_code)conttype03";

			query+=" where conttype01.cont01_hab_code=conttype02.cont02_hab_code(+) and conttype02.cont02_hab_code=conttype03.cont03_hab_code(+)";
				
			query+=" )contaminationDetails where contaminationDetails.cont01_hab_code=pr.panch_code ORDER BY PANCH_NAME";
			
	
			query=" select contaminationDetails.*,pr.panch_name,d.dcode,d.dname,m.mcode,m.mname from rws_panchayat_raj_tbl pr,rws_district_tbl d,rws_mandal_tbl m,(";
			
			query+= " select cont01_hab_code,cont01_cont_type," +
					" cont01_contamination_name,cont01_cont_perc,conttype01.status_date," +
					" cont02_cont_type,cont02_contamination_name," +
					" cont02_cont_perc,cont03_cont_type," +
					" cont03_contamination_name,cont03_cont_perc from ";
			
			query+=	" (select hab_code as cont01_hab_code,habcont.cont_Type as cont01_cont_type,cont.contamination_name as cont01_contamination_name," +
					" cont_perc as cont01_cont_perc,to_char(habcont.status_date,'dd/mm/yyyy')as status_date from rws_hab_contamination_tbl habcont," +
					" rws_contamination_tbl cont where substr(hab_code,1,2)='"+dcode+"' " +
					" and cont_type='01' and habcont.cont_type=cont.contamination_code)conttype01,";

			query +=" (select hab_code as cont02_hab_code,habcont.cont_Type as cont02_cont_type,cont.contamination_name as cont02_contamination_name," +
					" cont_perc as cont02_cont_perc from rws_hab_contamination_tbl habcont," +
					" rws_contamination_tbl cont where substr(hab_code,1,2)='"+dcode+"' " +
					" and cont_type='02' and habcont.cont_type=cont.contamination_code)conttype02,";

			query+= " (select hab_code as cont03_hab_code,habcont.cont_Type as cont03_cont_type,cont.contamination_name as cont03_contamination_name," +
					" cont_perc as cont03_cont_perc  from rws_hab_contamination_tbl habcont," +
					" rws_contamination_tbl cont where substr(hab_code,1,2)='"+dcode+"' " +
					" and cont_type='03' and habcont.cont_type=cont.contamination_code)conttype03";

			query+=" where conttype01.cont01_hab_code=conttype02.cont02_hab_code(+) and conttype02.cont02_hab_code=conttype03.cont03_hab_code(+)";
				
			query+=" )contaminationDetails where contaminationDetails.cont01_hab_code=pr.panch_code and substr(pr.panch_code,1,2)=d.dcode and substr(pr.panch_code,1,2)=m.dcode and substr(pr.panch_code,6,2)=m.mcode";
			
			query+=" union ";
			
			query+="(select panch_code,'','',to_number(''),'','','',to_number(''),'',''," +
					"to_number(''),panch_name,d.dcode,d.dname,m.mcode,m.mname from rws_panchayat_raj_tbl pr,rws_district_tbl d,rws_mandal_tbl m," +
					"rws_habitation_directory_tbl hd where substr(pr.panch_code,1,2)='"+dcode+"'" +
					" and hd.hab_code=pr.panch_code and hd.coverage_status='NSS'" +
					" and d.dcode=substr(hd.hab_code,1,2) and m.dcode=substr(hd.hab_code,1,2) and m.mcode=substr(hd.hab_code,6,2) and pr.panch_code  not in(select hab_code from rws_hab_contamination_tbl" +
					" where substr(hab_code,1,2)='"+dcode+"'))  order by dcode,mcode,panch_name";
	//end of code added*/	
	query = "select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status = 'NSS' and d.dcode='"+dcode+"' order by d.dcode,m.mcode,p.pcode,v.vcode,h.panch_code";
	Debug.println("getting nss habs:"+query);
	rs = stmt.executeQuery(query);
	String query1= "";Statement contst = conn.createStatement();
	ResultSet contrs = null;
	while (rs.next()) {
		rwsMaster = new RwsMaster();

		rwsMaster.setDcode(rs.getString("dcode"));
		rwsMaster.setDname(rs.getString("dname"));
		rwsMaster.setMcode(rs.getString("mcode"));
		rwsMaster.setMname(rs.getString("mname"));
		rwsMaster.setPcode(rs.getString("pcode"));
		rwsMaster.setPname(rs.getString("pname"));
		rwsMaster.setVcode(rs.getString("vcode"));
		rwsMaster.setVname(rs.getString("vname"));
		rwsMaster.setHabCode(rs.getString("panch_code"));
		rwsMaster.setHabName(rs.getString("panch_name"));
		query1 = "select CONT_TYPE,CONT_PERC,to_char(status_date,'dd/mm/yyyy') as status_date from rws_hab_contamination_tbl where hab_code='"+rs.getString("panch_code")+"'";
		contrs = contst.executeQuery(query1);
		while(contrs.next())
		{
			if(contrs.getString(1).equals("01"))
			{
				rwsMaster.setFlourideContamination(contrs.getString(2));	
			}
			else if(contrs.getString(1).equals("02"))
			{
				rwsMaster.setBrakishContamination(contrs.getString(2));	
			}
			else if(contrs.getString(1).equals("03"))
			{
				rwsMaster.setIronContamination(contrs.getString(2));	
			}
			else if(contrs.getString(1).equals("04"))
			{
				rwsMaster.setAresenicContamination(contrs.getString(2));	
			}
			else if(contrs.getString(1).equals("05"))
			{
				rwsMaster.setNitrateContamination(contrs.getString(2));	
			}
			rwsMaster.setStatusDate(contrs.getString(3));
		}
		
		contaminationDetails.add(rwsMaster);
	}
			
		
	} catch (Exception e) {
		Debug.println("The error in getContaminationDetails=" + e);
	} finally {
		
		closeAll();
	}
	return contaminationDetails;
}
	
	public  ArrayList getVillageDetails(String dcode, String mcode,String pcode,DataSource dataSource) throws Exception {   
		RwsMaster rwsMaster = null;
		ArrayList villageDetails = new ArrayList();
		String query="";
		

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT D.DCODE,D.DNAME,M.MCODE,M.MNAME,P.PCODE,P.PNAME,V.VCODE,V.VNAME FROM RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_PANCHAYAT_TBL P,RWS_VILLAGE_TBL V "
				+ " WHERE D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE=P.MCODE AND P.DCODE=V.DCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE  AND D.DCODE = '" + dcode + "' "
				+ " AND M.MCODE = '" + mcode + "' AND V.PCODE='"+pcode+"'"
				
				+ " ORDER BY d.dcode,m.mcode,p.pcode,V.VCODE ";
	
	//end of code added
	Debug.println(query);
	rs = stmt.executeQuery(query);
	while (rs.next()) {
		rwsMaster = new RwsMaster();

		rwsMaster.setDcode(rs.getString("DCODE"));
		rwsMaster.setDname(rs.getString("DNAME"));
		rwsMaster.setMcode(rs.getString("MCODE"));
		rwsMaster.setMname(rs.getString("MNAME"));
		rwsMaster.setPcode(rs.getString("PCODE"));
		rwsMaster.setPname(rs.getString("PNAME"));
		rwsMaster.setVcode(rs.getString("VCODE"));
		rwsMaster.setVname(rs.getString("VNAME"));
		villageDetails.add(rwsMaster);
	}
			
		
	} catch (Exception e) {
		Debug.println("The error in getHabStatuss=" + e);
	} finally {
		
		closeAll();
	}
	return villageDetails;
}
	
	public  ArrayList getHabStatuss(String coc, String doc, String sdoc,
			String dcode, String mcode, String pcode, String vcode,
			DataSource dataSource,String userId) throws Exception {   
		RwsMaster rwsMaster = null;

		ArrayList habstatuss = new ArrayList();
		try {
			ResultSet rs2=null;
			Statement st=null;
			String query2="";
			//Debug.println("in unknown data getting <><><><><><><****************&&&&&&&&&");
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Debug.println("coc=" + coc + "doc=" + doc + "sdoc=" + sdoc
					+ "dcode=" + dcode + "mcode=" + mcode + "pcode=" + pcode
					+ "vcode=" + vcode);
			String query = "",query1 = "";
			//code modified
			if ((coc != null && !coc.equals(""))
					&& (dcode != null && !dcode.equals(""))&& (mcode != null && !mcode.equals("")))
			{
				if(userId.equals("admin") || userId.equals("100000"))
					query = "select distinct hd.*,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status <> 'UI' and d.dcode='" + dcode + "'  and m.mcode='" + mcode + "'";
				else
					query = "select distinct hd.*,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status <> 'UI' and d.dcode='" + dcode + "'  and m.mcode='" + mcode + "'";
				query1 = "select distinct hd.*,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hd.coverage_status is null and d.dcode='" + dcode + "'  and m.mcode='" + mcode + "'";
				
			}
			if((pcode != null && !pcode.equals("")))
			{
				query += " and p.pcode='"+pcode+"'";
				query1 += " and p.pcode='"+pcode+"'";
			}
			if((vcode != null && !vcode.equals("")))
			{
				query += " v.vcode='"+vcode+"'";
				query1 += " v.vcode='"+vcode+"'";
			}
			query1 +=" order by dname,mname,pname,vname,panch_name";
			query +=" union "+ query1;
			//query +="  union" + query2;
			//Debug.println("unnnnnnnnnnnnn*****:"+query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				rwsMaster = new RwsMaster();
				st = conn.createStatement();
				//added by swapna 0n 12-01-2012
				query2 = "select * from rws_panchayat_raj_tbl where panch_code='"+rs.getString("panch_code")+"'";
				Debug.println("unppppnn anuuu**:"+query2);
				rs2 = st.executeQuery(query2);
				while(rs2.next())
				{//Debug.println("in rs::");

					rwsMaster.setLatitude(rs2.getString("latitude"));
					//Debug.println("unppppppppnnn*****:"+rs2.getString("latitude"));
					rwsMaster.setLongitude(rs2.getString("longitude"));
					//Debug.println("unnppppppppnnnn*****:"+rs2.getString("longitude"));
					rwsMaster.setElevation(rs2.getString("elevation"));
					//Debug.println("unppppppppnnn*****:"+rs2.getString("elevation"));
					rwsMaster.setWaypoint(rs2.getString("way_point"));
					//added by swapna on 23-01-2012 for gis data entry
					rwsMaster.setLandmark(rs2.getString("landmark"));
					//
				}
				rwsMaster.setCoc(rs.getString(1));
				rwsMaster.setDoc(rs.getString(2));
				rwsMaster.setSdoc(rs.getString(3));
				rwsMaster.setHabCode(rs.getString(4));
				rwsMaster.setMandalName(rs.getString("mname"));
				rwsMaster.setPanchayat(rs.getString("pname"));
				rwsMaster.setVillName(rs.getString("vname"));
				rwsMaster.setHabName(rs.getString("PANCH_NAME"));
				rwsMaster.setCensusYear(rs.getString(5));
				rwsMaster.setCensusPop(rs.getInt(6));
				rwsMaster.setCensusSc(rs.getInt(7));
				rwsMaster.setCensusSt(rs.getInt(8));
				rwsMaster.setTotalPop(rs.getInt(6) + rs.getInt(7)
						+ rs.getInt(8));
				rwsMaster.setFloatPop(rs.getInt(9));
				rwsMaster.setNetPop(rs.getInt(6) + rs.getInt(7) + rs.getInt(8)
						+ rs.getInt(9));
				rwsMaster.setFloatReason(rs.getString(10));
				if (rs.getDate(11) != null) {
					rwsMaster.setHabYear(df.format(rs.getDate(11)));
				}
				rwsMaster.setPopCovered(rs.getInt(12));
				rwsMaster.setScCovered(rs.getInt(13));
				rwsMaster.setStCovered(rs.getInt(14));
				//added by swapna on 01-02-2012 for minority pop entry for gis
				rwsMaster.setMinorityCovered(rs.getInt("MINORITY_POP_COVERED"));
				//
				rwsMaster.setTotalCovered(rs.getInt(12) + rs.getInt(13)	+ rs.getInt(14)+ rs.getInt("MINORITY_POP_COVERED"));
				rwsMaster.setTotalWaterSupply(rs.getInt(15));
				rwsMaster.setExistWaterLevel(rs.getInt(16));
				rwsMaster.setCoveredStatus(rs.getString(17));
				rwsMaster.setNearWaterSource(rs.getInt(18));
				rwsMaster.setNearWaterGroundSource(rs.getInt(19));
				rwsMaster.setNcSourceType(rs.getString("nc_source_type"));
				rwsMaster.setSourceDistance(rs.getString("source_distance"));
			
				rwsMaster.setRemarks(rs.getString(20));

				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				if (rs.getString(22) == null)
					rwsMaster.setUpdateDate("");
				else
					rwsMaster.setUpdateDate(sdf.format(rs.getDate(22)));
				rwsMaster.setProposedFcYr(rs.getString(25));
				rwsMaster.setProposedFCAmt(rs.getInt(26));
				rwsMaster.setPrevYrStatus(rs.getString("PREVIOUS_YR_STATUS"));
				rwsMaster.setGlsrno(rs.getInt("GLSR_NO"));
				rwsMaster.setGlsrqty(rs.getInt("GLSR_QTY"));
				rwsMaster.setOhsrno(rs.getInt("OHSR_NO"));
				rwsMaster.setOhsrqty(rs.getInt("OHSR_QTY"));
				rwsMaster.setSchemesource(rs.getString("SCHEMESOURCE"));
				
				
				
				habstatuss.add(rwsMaster);
				}
		} catch (Exception e) {
			Debug.println("The error in getHabStatuss=" + e);
		} finally {
			
			closeAll();
		}
		Debug.println("end*****:"+rwsMaster.getLatitude());
		Debug.println("end*****:"+rwsMaster.getLongitude());
		return habstatuss;
	}





public  String getHabName(String habCode, Connection conn)
throws Exception {  


String name = null;
Statement stmt1 = null;
ResultSet rs1 = null;
try {
stmt1 = conn.createStatement();
rs1 = stmt1
		.executeQuery("SELECT PANCH_NAME FROM rws_panchayat_raj_tbl WHERE panch_code ='"
				+ habCode + "'");
while (rs1.next()) {
	name = rs1.getString(1);

}
} catch (Exception e) {
Debug.println("The error in getHabName=" + e);
} finally {
stmt1.close();
rs1.close();
}
return name;
}

public  String  getDistName(DataSource dataSource, String dcode)
throws Exception {   
String distname = "";


try {
conn = RwsOffices.getConn();
stmt = conn.createStatement();
rs = stmt.executeQuery("select DNAME from rws_district_tbl where DCODE='"
				+ dcode + "'");
if(rs.next())
distname = rs.getString(1);
}

catch (Exception e) {
Debug.println("The error in getDistName=" + e);
} finally {
closeAll();
}

return distname;
}

public RwsMaster getHabSupplyStatus(String habCode,DataSource dataSource) throws Exception {  
	Debug.println("in getHabSupplyStatus");
	RwsMaster rwsMaster = null;
	HabInstitute habInstitute = null;
	ContaminationTypes contaminationTypes = null;
	HabWaterSupply habWS = null;
	ArrayList institutes = new ArrayList();
	ArrayList waterSupply = new ArrayList();
	ArrayList contaminations = new ArrayList();
	Debug.println("1");
	conn=RwsOffices.getConn();
	int pwsCount=0;
	int mpwsCount=0;
	int cpwsCount=0;
	int shpCount=0;
	int hpCount=0;
	int pondsCount=0;
	int openwellCount=0;
	int totOthersSupply=0;
	int totOthersNo=0;
	int shCount=0;
	Debug.println("in getHabSupplyStatus() in rwsmasterdata");
	String habcode = null;
Statement stmtpanch=null;
ResultSet rspanch=null;
String panchquery="";
	try {
		//code to get pwsCount
		Debug.println("1A");
		stmt2=conn.createStatement();
		Debug.println("1B");
		/*
		//code modifed for efficiency
		String countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s" 
			+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '6%'" 
			+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
		Debug.println("countQuery is "+countQuery);
		rs2=stmt2.executeQuery(countQuery);
		Debug.println("*2");
		if(rs2.next())
		{
			pwsCount=rs2.getInt("count");
			Debug.println("pwsCount is "+pwsCount);
		}
		countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s" 
			+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '4%'" 
			+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
		Debug.println("countQuery is "+countQuery);
		rs2=stmt2.executeQuery(countQuery);
		if(rs2.next())
		{
			mpwsCount=rs2.getInt("count");
			Debug.println("mpwsCount is "+mpwsCount);
		}
		Debug.println("*3");
		countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_HP_SUBCOMP_PARAM_TBL h" 
			+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '0%'" 
			+ " and h.asset_code=a.asset_code and substr(s.scheme_code,1,16)='"+habCode+"'";
		Debug.println("countQuery is "+countQuery);
		Debug.println("*4");
		rs2=stmt2.executeQuery(countQuery);
		if(rs2.next())
		{
			hpCount=rs2.getInt("count");
			Debug.println("hpCount is "+hpCount);
		}
	
		
		countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s," 
			+ " RWS_SHALLOWHANDPUMPS_TBL subcompTbl where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '3%'" 
			+ " and substr(s.scheme_code,1,16)='"+habCode+"' and subcompTbl.asset_code=a.asset_code";
		Debug.println("countQuery is "+countQuery);
		Debug.println("*5");
		rs2=stmt2.executeQuery(countQuery);
		if(rs2.next())
		{
			shpCount=rs2.getInt("count");
			Debug.println("shpCount is "+shpCount);
		}
		
		countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s, RWS_OPEN_WELL_MAST_TBL subcompTbl" 
			+ " where a.asset_code=subcompTbl.asset_code and a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '2%'" 
			+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
		Debug.println("countQuery is "+countQuery);
		Debug.println("*6");
		rs2=stmt2.executeQuery(countQuery);
		if(rs2.next())
		{
			openwellCount=rs2.getInt("count");
			Debug.println("openwellCount is "+openwellCount);
		}
		
		countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_OPENWELL_POND_TBL SUBCOMPTBL" 
			+ " where a.asset_code=subcompTbl.asset_code and a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '7%'" 
			+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
		Debug.println("countQuery is "+countQuery);
		Debug.println("*7");
		rs2=stmt2.executeQuery(countQuery);
		if(rs2.next())
		{
			pondsCount=rs2.getInt("count");
			Debug.println("pondsCount is "+pondsCount);
		}
		
		countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s" 
			+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '8%'" 
			+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
		Debug.println("countQuery is "+countQuery);
		Debug.println("*8");
		rs2=stmt2.executeQuery(countQuery);
		if(rs2.next())
		{
			cpwsCount=rs2.getInt("count");
			Debug.println("cpwsCount is "+cpwsCount);
		}
		//end of code
		Debug.println("in getHabSupplyStatus in RwsMasterData.java");
		Debug.println("*9");
		*/
		
		String query="select ";
		
		//pwsCount
		query=query+"(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s" 
		+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '6%'" 
		+ " and substr(s.scheme_code,1,16)='"+habCode+"')as pwsCount,";
		
		//mpwsCount
		query=query+"(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s" 
		+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '4%'" 
		+ " and substr(s.scheme_code,1,16)='"+habCode+"')as mpwsCount,";
		
		//hpCount
		query=query+"(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_HP_SUBCOMP_PARAM_TBL h" 
		+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '0%'" 
		+ " and h.asset_code=a.asset_code and substr(s.scheme_code,1,16)='"+habCode+"')as hpCount,";
		
		//shpCount
		query=query+"(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s," 
		+ " RWS_SHALLOWHANDPUMPS_TBL subcompTbl where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '3%'" 
		+ " and substr(s.scheme_code,1,16)='"+habCode+"' and subcompTbl.asset_code=a.asset_code)as shpCount,";
			
		//openWellCount
		query=query+"(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s, RWS_OPEN_WELL_MAST_TBL subcompTbl" 
		+ " where a.asset_code=subcompTbl.asset_code and a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '2%'" 
		+ " and substr(s.scheme_code,1,16)='"+habCode+"')as openWellCount,";
		
		//pondsCount
		query=query+"(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_OPENWELL_POND_TBL SUBCOMPTBL" 
		+ " where a.asset_code=subcompTbl.asset_code and a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '7%'" 
		+ " and substr(s.scheme_code,1,16)='"+habCode+"')as pondsCount,";
		
		//cpwsCount
		query=query+"(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s" 
		+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '8%'" 
		+ " and substr(s.scheme_code,1,16)='"+habCode+"')as cpwsCount,";
		
		//shallow handpumps
		query=query+"(SELECT count(*) from RWS_SHALLOWHANDPUMPS_TBL   p,RWS_HABITATION_DIRECTORY_TBL h,   RWS_ASSET_MAST_TBL A, rws_asset_scheme_tbl S where a.asset_code=s.asset_code and a.asset_code=p.asset_code and  h.hab_code=p.hab_code AND substr(s.scheme_code,1,16) = '"+habCode+"') as shpump";		
		
		
		query=query+" from dual";
		
		Debug.println("query is "+query);
		Debug.println("2");
		//rs2=stmt2.executeQuery(query);
		Debug.println("query not executed");
		if(rs2!=null && rs2.next())
		{	
			Debug.println("in if counts");
			pwsCount=rs2.getInt("pwsCount");
			Debug.println("pwsCount is "+pwsCount);
			mpwsCount=rs2.getInt("mpwsCount");
			Debug.println("mpwsCount is "+mpwsCount);
			hpCount=rs2.getInt("hpCount");
			Debug.println("hpCount is "+hpCount);
			shpCount=rs2.getInt("shpCount");
			Debug.println("shpCount is "+shpCount);
			openwellCount=rs2.getInt("openWellCount");
			Debug.println("openWellCount is "+openwellCount);
			pondsCount=rs2.getInt("pondsCount");
			Debug.println("pondsCount is "+pondsCount);
			cpwsCount=rs2.getInt("cpwsCount");
			Debug.println("cpwsCount is "+cpwsCount);
			shCount=rs2.getInt("shpump");
			Debug.println("shpump is "+shCount);
			
		}
		Debug.println("After counts");
		
		stmt = conn.createStatement();
		Debug.println("habCode=" + habCode);
		query = "SELECT * FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE='"
				+ habCode + "'";
		Debug.println("query=" + query);
		rs = stmt.executeQuery(query);
		int netPop = 0;
		double presentEstimatedpop = 0;
		int csyear=0;
		if (rs.next()) {
			Debug.println("1");
			rwsMaster = new RwsMaster();
			habcode = rs.getString(4);
			try{
			rwsMaster.setCoc(rs.getString(1));
			rwsMaster.setDoc(rs.getString(2));
			rwsMaster.setSdoc(rs.getString(3));
			rwsMaster.setCon(getCircleOfficeName("1", rs.getString(1), conn));
			Debug.println("2");
			//rwsMaster.setDon(getDivisionOfficeName("1", rs.getString(1), rs.getString(2), conn));
			//rwsMaster.setSdon(getSubDivisionOfficeName("1", rs.getString(1),rs.getString(2), rs.getString(3), conn));
			}
			catch(Exception e){Debug.println("Exception in getting coc or doc or sdoc is "+e);}
			rwsMaster.setDcode(habcode.substring(0, 2));
			Debug.println("3");
			rwsMaster.setDistrict(getDistrictName(habcode.substring(0, 2),conn));
			rwsMaster.setMandal(habcode.substring(5,7));
			rwsMaster.setMandalName(getMandalName(habcode.substring(0, 2),habcode.substring(5, 7), conn));
			Debug.println("4");
			rwsMaster.setPCode(habcode.substring(12, 14));
			rwsMaster.setVCode(habcode.substring(7, 10));
			rwsMaster.setPName(getPanchayatName(habcode.substring(0, 2),habcode.substring(5, 7), habcode.substring(12, 14),conn));
			Debug.println("5");
			rwsMaster.setVName(getVillageName(habcode.substring(0, 2),habcode.substring(5, 7), habcode.substring(12, 14),habcode.substring(7, 10), conn));
			rwsMaster.setHabCode(format(rs.getString(4)));
			Debug.println("6");
			rwsMaster.setHabName(format(getHabName(rs.getString(4), conn)));
			Debug.println("7");
			rwsMaster.setCensusYear(format(rs.getString(5)));
			Debug.println("getting censusYear");
			try{
			csyear = rs.getInt(5);
			rwsMaster.setCensusPop(rs.getInt(6));
			Debug.println("census population is "+rs.getInt(6));
			rwsMaster.setCensusSc(rs.getInt(7));
			Debug.println("census sc population is "+rs.getInt(7));
			rwsMaster.setCensusSt(rs.getInt(8));
			//added by swapna on 02-02-2012 for minority population entry for gis data
			rwsMaster.setCensusMinority(rs.getInt("CENSUS_MINORITY_POPU"));
			Debug.println("census st population is "+rs.getInt(8));
			rwsMaster.setTotalPop(rs.getInt(6) + rs.getInt(7)
					+ rs.getInt(8));
			rwsMaster.setFloatPop(rs.getInt(9));
			netPop = rs.getInt(6) + rs.getInt(7) + rs.getInt(8)
					+ rs.getInt(9)+ rs.getInt("CENSUS_MINORITY_POPU");
			//
			rwsMaster.setNetPop(netPop);
			}catch(Exception e){Debug.println("Exception in getting population details "+e);}
			rwsMaster.setFloatReason(rs.getString(10));
			rwsMaster.setHabYear(df.format(rs.getDate(11)));
			rwsMaster.setPopCovered(rs.getInt(12));
			rwsMaster.setScCovered(rs.getInt(13));
			rwsMaster.setStCovered(rs.getInt(14));
			//added by swapna on 01-02-2012 for minority pop entry for gis
			rwsMaster.setMinorityCovered(rs.getInt("MINORITY_POP_COVERED"));
			//
			rwsMaster.setTotalCovered(rs.getInt(12) + rs.getInt(13)	+ rs.getInt(14)+ rs.getInt("MINORITY_POP_COVERED"));
			rwsMaster.setTotalWaterSupply(rs.getInt(15));
			rwsMaster.setExistWaterLevel(rs.getInt(16));
			Debug.println("coverageStatus in RwsMasterData is "+rs.getString(17));
			rwsMaster.setCoveredStatus(rs.getString(17));
			rwsMaster.setNearWaterSource(rs.getFloat(18));
			rwsMaster.setSlipReasonCode(rs.getString("SLIPPAGE_CODE"));
			rwsMaster.setNearWaterGroundSource(rs.getFloat(19));
			rwsMaster.setNcSourceType(rs.getString("nc_source_type"));
			rwsMaster.setSourceDistance(rs.getString("source_distance"));
			rwsMaster.setRemarks(rs.getString(20));
			rwsMaster.setQualityAffected(rs.getString(21));
			if (rs.getString(22) == null)
				rwsMaster.setUpdateDate("");
			else
				rwsMaster.setUpdateDate(df.format(rs.getDate(22)));
			/*
			if (rs.getString(21) == null)
			{
				rwsMaster.setPrevYrStatus("");
				rwsMaster.setPresentvYrStatus("");
				Debug.println("previous yr status in getHabSupplyStatus() in dao is ''");
			}
			else
			{
				rwsMaster.setPrevYrStatus(rs.getString(23));
				rwsMaster.setPresentvYrStatus(rs.getString(24));
				Debug.println("previous yr status in getHabSupplyStatus() in dao is "+rs.getString(23));
			}
			*/
			//CODE ADDED
			rwsMaster.setPrevYrStatus(format(rs.getString("PREVIOUS_YR_STATUS")));
			rwsMaster.setPresentvYrStatus(rs.getString("COVERAGE_STATUS"));
			//END OF CODE ADDED
			rwsMaster.setProposedFcYr(rs.getString(25));
			rwsMaster.setProposedFCAmt(rs.getFloat(26));
			Debug.println("Habitation Type in rwsmaster is "+rs.getString("HABITATION_TYPE"));
			Debug.println("HOUSE HOLD NO IN rwsmaster is "+rs.getString("HOUSEHOLD_NO"));
			
			rwsMaster.setHabType(rs.getString("HABITATION_TYPE"));
			rwsMaster.setHabSubType(rs.getString("HABITATION_SUB_TYPE"));
			rwsMaster.setHouseHold(rs.getInt("HOUSEHOLD_NO"));
			rwsMaster.setHouseConn(rs.getInt("NO_OF_HOUSECONN_GIVEN"));
			//added by swapna on 19-12-2011 for sc,st,plain clasification of household and houseconnection
			rwsMaster.setPlainHCon(rs.getInt("con_plain"));
			rwsMaster.setScHCon(rs.getInt("con_sc"));
			rwsMaster.setStHCon(rs.getInt("con_st"));
			rwsMaster.setPlainHHold(rs.getInt("Households_plain"));
			rwsMaster.setScHHold(rs.getInt("Households_sc"));
			rwsMaster.setStHHold(rs.getInt("Households_st"));
			//
			//added by swapna on 30-01-2012 for minority entry in habitation entry form
			rwsMaster.setMinorityHHold(rs.getInt("HOUSEHOLDS_MINORITY"));
			rwsMaster.setMinorityHCon(rs.getInt("CON_MINORITY"));
			//
			Debug.println("Habitation CATEGORY in rwsmaster is "+rs.getString("HABITATION_CATEGORY"));
			Debug.println("NO. OF EXIST AND SAFE SOURCES  in rwsmaster R "+rs.getInt("EXISTING_SOURCES_NO")+"_"+rs.getInt("SAFE_SOURCES_NO"));		
			
			rwsMaster.setHabCat(rs.getString("HABITATION_CATEGORY"));
		    rwsMaster.setExistSource(rs.getInt("EXISTING_SOURCES_NO"));
			rwsMaster.setSafeSource(rs.getInt("SAFE_SOURCES_NO"));
			
			//added by jyothi on 24/09/2014
			rwsMaster.setPublicTap(rs.getInt("NO_OF_PUBLIC_TAPS"));
			rwsMaster.setPublicStandpost(rs.getInt("NO_OF_TAPS_WITH_STANDPOSTS"));
			
			
			rwsMaster.setExistCheckDams(rs.getInt("NO_CHECKDAMS_EXIST"));
			rwsMaster.setReqCheckDams(rs.getInt("NO_CHECKDAMS_REQ"));
			
			
			Debug.println(""+rs.getInt("NO_OF_PUBLIC_TAPS")+rs.getInt("NO_OF_TAPS_WITH_STANDPOSTS"));
			//////
			rwsMaster.setCattles(rs.getInt("NO_OF_CATTLE"));
			if(rs.getString("MINORITY_DOMINATED")!=null && rs.getString("MINORITY_DOMINATED").equals("Y"))
				rwsMaster.setIsMinorityHab("on");
			Debug.println("===================:"+rs.getString("LWE"));
			if(rs.getString("LWE")!=null && rs.getString("LWE").equals("Y"))
				rwsMaster.setIsLwe("on");
//			added by swapna02-04-2011
			if(rs.getString("IS_ITDA")!=null && rs.getString("IS_ITDA").equals("Y"))
				rwsMaster.setIsItda("on");
			//
			rwsMaster.setLevelOfWaterSupply(rs.getString("EXIST_WATER_LEVEL"));
			rwsMaster.setLevelOfWaterSupplySafeOnly(rs.getString("SAFE_LPCD"));
			rwsMaster.setUnsafeLpcd(rs.getString("UNSAFE_LPCD"));
			rwsMaster.setGlsrno(rs.getInt("GLSR_NO"));
			rwsMaster.setGlsrqty(rs.getInt("GLSR_QTY"));
			rwsMaster.setOhsrno(rs.getInt("OHSR_NO"));
			rwsMaster.setOhsrqty(rs.getInt("OHSR_QTY"));
			
			rwsMaster.setSchemesource(rs.getString("SCHEMESOURCE"));
			
			System.out.println("glsrno anuuuuu inselect "+rs.getInt("GLSR_NO"));
			
			stmt1 = conn.createStatement();
			/*
			query = "SELECT P_INST_CODE,INST_NAME,P_INST_NO,P_INST_COVERED,P_INST_WORKING,P_INST_NOTWORKING_NO FROM RWS_HAB_INSTITUTE_TBL HI,RWS_PUBLIC_INSTITUTE_TBL I WHERE HI.P_INST_CODE=I.INST_CODE AND HAB_CODE='"
					+ habCode + "'";
					*/
			//added by swapna on 12-01-2012 for getting gis_data from rws_panchayat_raj table
		 stmtpanch = conn.createStatement();
			 panchquery = "SELECT * FROM RWS_PANCHAYAT_RAJ_TBL WHERE panch_CODE='"
		+ habCode + "'";
		Debug.println("panch query=" + panchquery);
		 rspanch = stmtpanch.executeQuery(panchquery);
		while (rspanch.next()) {
			rwsMaster.setLatitude(rspanch.getString(4));
			Debug.println("panch query1=" + rspanch.getString(4));
		rwsMaster.setLongitude(rspanch.getString(5));
		Debug.println("panch query2=" + rspanch.getString(5));
		rwsMaster.setElevation(rspanch.getString(6));
		Debug.println("panch query3=" + rspanch.getString(6));
		rwsMaster.setWaypoint(rspanch.getString(7));
		//added by swapna on 23-01-2012
		rwsMaster.setLandmark(rspanch.getString(8));
		Debug.println("panch query4=" + rspanch.getString(7));

		}
		//
			query="select a.inst_code,a.inst_name," +
					"b.p_inst_no,b.p_inst_covered," +
					"b.P_INST_WORKING ,b.P_INST_NOTWORKING_NO " +
					"from rws_public_institute_tbl a,rws_hab_institute_tbl b " +
					"where b.hab_code='"+habCode+"' and a.inst_code=b.p_inst_code " +
					"union select pi.inst_code,pi.inst_name," +
					"'' as P_INST_NO,'' as P_INST_COVERED , to_number('') as P_INST_WORKING ," +
					"to_number('') as P_INST_NOTWORKING_NO  " +
					"from rws_public_institute_tbl pi where " +
					"inst_code not in(select p_inst_code from rws_hab_institute_tbl " +
					"where hab_code='"+habCode+"')";

			Debug.println("query for inst=" + query);
			rs1 = stmt1.executeQuery(query);
			while (rs1.next()) {
				habInstitute = new HabInstitute();
				habInstitute.setInstituteCode(rs1.getString(1));
				habInstitute.setInstituteName(rs1.getString(2));
				habInstitute.setInstituteNo(rs1.getString(3));
				habInstitute.setInstituteCovered(rs1.getString(4));
				habInstitute.setInstituteWorking(rs1.getString(5));
				habInstitute.setInstituteNotWorking(rs1.getString(6));

				institutes.add(habInstitute);
			}
			Debug.println("*17");
			Debug.println("printing institutes size");
			Debug.println("institutes size is "+institutes.size());
			rwsMaster.setHabInsts(institutes);

			stmt3 = conn.createStatement();

			String q = null;
			q = " SELECT NVL(shp_dk_supply,0)as shp_dk_supply, NVL(shp_no,0)as shp_no, cisterns_dk_supply, cisterns_no, glsrs_dk_supply, glsrs_no,"
					+ " ohsrs_dk_supply, ohsrs_no, "
					
					+"(NVL(shp_dk_supply,0) "
					+ " + NVL(cisterns_dk_supply,0) + NVL(glsrs_dk_supply,0) + NVL(ohsrs_dk_supply,0))as tot_dk_supply, "
					
					+ " ( NVL(shp_no,0) + NVL(cisterns_no,0) + NVL(glsrs_no,0) + NVL(ohsrs_no,0) ), "
					+ " NVL(hps_oth_supply,0)as hps_oth_supply, NVL(hps_no,0)hps_no, ows_oth_supply, NVL(ows_no,0)ows_no, NVL(ponds_oth_supply,0)ponds_oth_supply,NVL(ponds_no,0)ponds_no, shwell_oth_supply,"
					
					+ " shwell_no, "
					
					+ "(NVL(hps_oth_supply,0) + NVL(ows_oth_supply,0) + NVL(ponds_oth_supply,0)  "
					+ " + NVL(shwell_oth_supply,0))as tot_oth_supply, "
					
					
					+ "(NVL(hps_no,0) + NVL(ows_no,0) + NVL(ponds_no,0) + NVL(shwell_no,0)), "
					
					+ " pcpd_drink, pcpd_others, "
					+ " (NVL(pcpd_drink,0) +NVL(pcpd_others,0)), stat_of_hab, "
					+ "NVL(PWS_NO,0)pws_no,NVL(PWS_SUPPLY,0)pws_supply,NVL(MPWS_NO,0)mpws_no,NVL(MPWS_SUPPLY,0)mpws_supply,NVL(CPWS_NO,0)as cpws_no,NVL(CPWS_SUPPLY,0)as cpws_supply,NVL(HPS_NO_UNSAFE,0)as HPS_NO_UNSAFE,NVL(HPS_OTH_SUPPLY_UNSAFE,0)as HPS_OTH_SUPPLY_UNSAFE,NVL(DW_TANKS_NO,0)as dw_tanks_no,NVL(DW_TANKS_SUPPLY,0)dw_tanks_supply,NVL(CATTLE_NO,0)as cattle_no,NVL(CATTLE_SUPPLY,0)as cattle_supply"
					+ ",nvl(others_no,0)as others_no,nvl(others_supply,0)as others_supply,nvl(others_no_safe,0)as others_no_safe,nvl(others_supply_safe,0)as others_supply_safe,nvl(PWS_UNSAFE_NO ,0)as PWS_UNSAFE_NO ,nvl(PWS_UNSAFE_SUPPLY ,0)as PWS_UNSAFE_SUPPLY,nvl(MPWS_UNSAFE_NO ,0)as MPWS_UNSAFE_NO ,nvl(MPWS_UNSAFE_SUPPLY ,0)as MPWS_UNSAFE_SUPPLY,nvl(SHP_NO_SAFE ,0)as SHP_NO_SAFE,nvl(SHP_DK_SUPPLY_SAFE,0)as SHP_DK_SUPPLY_SAFE FROM rws_hab_supply_status_tbl WHERE hab_code='"
					+ habCode + "'";
			Debug.println(" SELECT QUERY is " + q);
			Debug.println("*18");
			rs3 = stmt3.executeQuery(q);
			while (rs3.next()) {
				Debug.println("*19");
				habWS = new HabWaterSupply();
				rwsMaster.setShpSupply(rs3.getString("shp_dk_supply"));
				//rwsMaster.setShpNo(rs3.getString(2));
				//rwsMaster.setShpNo(shpCount+"");
				rwsMaster.setShpNo(rs3.getString("shp_no"));
				rwsMaster.setCisternsSupply(rs3.getString("cisterns_dk_supply"));
				rwsMaster.setCisternsNo(rs3.getString("cisterns_no"));
				rwsMaster.setGlsrSupply(rs3.getString("glsrs_dk_supply"));
				rwsMaster.setGlsrNo(rs3.getString("glsrs_no"));
				rwsMaster.setOhsrSupply(rs3.getString("ohsrs_dk_supply"));
				rwsMaster.setOhsrNo(rs3.getString("ohsrs_no"));
					Debug.println("*1");
				//rwsMaster.setTotOthersSupply((rs3.getInt("cisterns_dk_supply")+rs3.getInt("glsrs_dk_supply")+rs3.getInt("ohsrs_dk_supply"))+(rs.getInt("ows_oth_supply")+rs.getInt("ponds_oth_supply"))+"");
				/*
				totOthersSupply=totOthersSupply+rs3.getInt("cisterns_dk_supply");
				totOthersNo=totOthersNo+rs3.getInt("cisterns_no");
				Debug.println("*1a");
				totOthersSupply=totOthersSupply+rs3.getInt("glsrs_dk_supply");
				totOthersNo=totOthersNo+rs3.getInt("glsrs_no");
				Debug.println("*1b");
				totOthersSupply=totOthersSupply+rs3.getInt("ohsrs_dk_supply");
				totOthersNo=totOthersNo+rs3.getInt("ohsrs_no");
				Debug.println("*1c");
				totOthersSupply=totOthersSupply+rs3.getInt("ows_oth_supply");
				totOthersNo=totOthersNo+rs3.getInt("ows_no");
				Debug.println("*1d");
				totOthersSupply=totOthersSupply+rs3.getInt("ponds_oth_supply");
				totOthersNo=totOthersNo+rs3.getInt("ponds_no");
				*/
				Debug.println("*1e");
				double drinkTotalSupply = rs3.getDouble("tot_dk_supply");
				Debug.println("*3");
				//Debug.println("totOthersSupply="+totOthersSupply);
				//rwsMaster.setTotOthersSupply(totOthersSupply+"");
				rwsMaster.setOthersSupply(rs3.getString("others_supply"));
				rwsMaster.setOthersNo(rs3.getString("others_no"));
				rwsMaster.setOthersSafeeNo(rs3.getString("OTHERS_NO_SAFE"));
				rwsMaster.setOthersSafeSupply(rs3.getString("OTHERS_SUPPLY_SAFE"));
				rwsMaster.setPwsUnsafeNo(rs3.getString("PWS_UNSAFE_NO"));
				rwsMaster.setPwsUnsafeSupply(rs3.getString("PWS_UNSAFE_SUPPLY"));
				rwsMaster.setMpwsUnsafeNo(rs3.getString("MPWS_UNSAFE_NO"));
				rwsMaster.setMpwsUnsafeSupply(rs3.getString("MPWS_UNSAFE_SUPPLY"));
				
				//rwsMaster.setotherss
				Debug.println("4");
				//rwsMaster.setTotOthersNo(totOthersNo+"");
				rwsMaster.setDrinkTotalSupply(String
						.valueOf(drinkTotalSupply));
				rwsMaster.setDrinkTotalNo(rs3.getString(10));
				rwsMaster.setHpSupply(rs3.getString("hps_oth_supply"));
				//rwsMaster.setHpNo(rs3.getString(12));
				//rwsMaster.setHpNo(hpCount+"");
				rwsMaster.setHpNo(rs3.getString("hps_no"));
				//rwsMaster.setHpNo("hps_no");
				
				
				rwsMaster.setOwsSupply(rs3.getString("ows_oth_supply"));
				rwsMaster.setOwsNo(rs3.getString("ows_no"));
				//rwsMaster.setOwsNo(openwellCount+"");
				rwsMaster.setPondsSupply(rs3.getString("ponds_oth_supply"));
				//rwsMaster.setPondsNo(rs3.getString(16));
				
				//this comment should be removed
				//rwsMaster.setPondsNo(pondsCount+"");
				rwsMaster.setPondsNo(rs3.getString("ponds_no"));
				
				//rwsMaster.setPondsNo("");
				rwsMaster.setShwSupply(rs3.getString("shwell_oth_supply"));
				rwsMaster.setShwNo(rs3.getString("shwell_no"));
				Debug.println("*4");
				double otherTotalSupply = rs3.getDouble("tot_oth_supply");
				Debug.println("*4");
				rwsMaster.setOtherTotalSupply(String
						.valueOf(otherTotalSupply));
				rwsMaster.setOtherTotalNo(rs3.getString(20));

				rwsMaster.setPcpdDrink(rs3.getString(21));
				rwsMaster.setPcpdOthers(rs3.getString(22));
				rwsMaster.setPcpdTotal(rs3.getString(23));
				rwsMaster.setStatus(rs3.getString(24));
				//rwsMaster.setPwsNo(rs3.getString(25));
				
				//rwsMaster.setPwsNo(pwsCount+"");
				rwsMaster.setPwsNo(rs3.getString("pws_no"));
				rwsMaster.setPwsSupply(rs3.getString("pws_supply"));
				rwsMaster.setMpwsNo(rs3.getString("mpws_no"));
				//rwsMaster.setMpwsNo(mpwsCount+"");
				rwsMaster.setMpwsSupply(rs3.getString("mpws_supply"));
				rwsMaster.setCpwsNo(rs3.getString("cpws_no"));
				//rwsMaster.setCpwsNo(cpwsCount+"");
				rwsMaster.setCpwsSupply(rs3.getString("cpws_supply"));
				rwsMaster.setDpNo(rs3.getString("HPS_NO_UNSAFE"));
				rwsMaster.setDpSupply(rs3.getString("HPS_OTH_SUPPLY_UNSAFE"));
				rwsMaster.setDwNo(rs3.getString("dw_tanks_no"));
				rwsMaster.setDwSupply(rs3.getString("dw_tanks_supply"));
				rwsMaster.setCattleNo(rs3.getString("cattle_no"));
				rwsMaster.setCattleSupply(rs3.getString("cattle_supply"));
				rwsMaster.setOthersSupply(rs3.getString("others_supply"));
				
				rwsMaster.setSafeSHPNo(rs3.getString("SHP_NO_SAFE"));
				rwsMaster.setSafeSHPSupply(rs3.getString("SHP_DK_SUPPLY_SAFE"));
			
				
				
				/*
				double totalWaterSupply = drinkTotalSupply
						+ otherTotalSupply;
				rwsMaster.setTotalWaterSupply((int)(totalWaterSupply));
				*/
				Debug.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:"+rs3.getInt("hps_oth_supply"));
				Debug.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:"+rs3.getInt("hps_oth_supply")+rs3.getInt("pws_supply")+rs3.getInt("mpws_supply")+rs3.getInt("cpws_supply")+rs3.getInt("ows_oth_supply")+rs3.getInt("ponds_oth_supply")+rs3.getInt("shp_dk_supply")+rs3.getInt("others_supply")+rs3.getInt("HPS_OTH_SUPPLY_UNSAFE"));
				//double totalWaterSupply=rs3.getInt("hps_oth_supply")+rs3.getInt("pws_supply")+rs3.getInt("mpws_supply")+rs3.getInt("cpws_supply")+rs3.getInt("ows_oth_supply")+rs3.getInt("ponds_oth_supply")+rs3.getInt("shp_dk_supply")+rs3.getInt("others_supply")+rs3.getInt("HPS_OTH_SUPPLY_UNSAFE");
				double totalWaterSupply=rs3.getInt("hps_oth_supply")+rs3.getInt("pws_supply")+rs3.getInt("mpws_supply")+rs3.getInt("cpws_supply")+rs3.getInt("ows_oth_supply")+rs3.getInt("ponds_oth_supply")+rs3.getInt("shp_dk_supply")+rs3.getInt("others_supply")+rs3.getInt("HPS_OTH_SUPPLY_UNSAFE")+rs3.getInt("SHP_DK_SUPPLY_SAFE");
				double totalWaterSupplySafe=rs3.getInt("hps_oth_supply")+rs3.getInt("pws_supply")+rs3.getInt("mpws_supply")+rs3.getInt("cpws_supply")+rs3.getInt("OTHERS_SUPPLY_SAFE")+rs3.getInt("SHP_DK_SUPPLY_SAFE");
				double totalWaterSupplyUnsafe=rs3.getInt("ows_oth_supply")+rs3.getInt("ponds_oth_supply")+rs3.getInt("shp_dk_supply")+rs3.getInt("others_supply")+rs3.getInt("HPS_OTH_SUPPLY_UNSAFE")+rs3.getInt("PWS_UNSAFE_SUPPLY")+rs3.getInt("MPWS_UNSAFE_SUPPLY");

				//Debug.println(rs3.getInt("hps_oth_supply")+"  "+rs3.getInt("pws_supply")+" "+rs3.getInt("mpws_supply")+" "+rs3.getInt("cpws_supply")+" "+rs3.getInt("ows_oth_supply")+" "+rs3.getInt("ponds_oth_supply")+" "+rs3.getInt("shp_dk_supply")+" "+ rs3.getInt("others_supply")+" "+rs3.getInt("HPS_OTH_SUPPLY_UNSAFE"));
				
				rwsMaster.setTotalWaterSupply((int)(totalWaterSupply));
				rwsMaster.setTotalWaterSupplySafe((int)(totalWaterSupplySafe));
				rwsMaster.setTotalWaterSupplyUnsafe((int)(totalWaterSupplyUnsafe));
				Calendar rightNow = Calendar.getInstance();
				int year = rightNow.get(Calendar.YEAR);
				Debug.println("year="
						+ year
						+ "csyear="
						+ csyear
						+ "val="
						+ Math.pow(1.02, Double.parseDouble(""
								+ (year - csyear))));
				
				Debug.println("netPopulation is "+netPop);
				presentEstimatedpop = Double.parseDouble("" + netPop);
				presentEstimatedpop = presentEstimatedpop
						* Math.pow(1.02, Double.parseDouble(""
								+ (year - csyear)));
				
				Debug.println("netpop=" + presentEstimatedpop);
				Debug.println("totWaterSupply="+totalWaterSupply);
				Debug.println("levelOfWaterSupply is "+totalWaterSupplySafe+"/"+presentEstimatedpop);
				rwsMaster.setLevelOfWaterSupply(String
						.valueOf(totalWaterSupplySafe / presentEstimatedpop));
				rwsMaster.setLpcdCooking(rs.getString("LPCD_COOKING"));
				waterSupply.add(rwsMaster);
			}
			rwsMaster.setHabWaterSupply(waterSupply);
			stmt3 = conn.createStatement();
			query = " SELECT NVL(cont_type,''), NVL(cont_perc,0.0) "
					+ " FROM rws_hab_contamination_tbl"
					+ " WHERE hab_code = '" + habCode + "'";
			Debug.println("contam query=" + query);
			rs3 = stmt3.executeQuery(query);
			Debug.println("*23");
			rwsMaster.setContTypes1("");
			rwsMaster.setContTypes2("");
			rwsMaster.setContTypes3("");
			rwsMaster.setContTypes4("");
			rwsMaster.setContTypes5("");
			while (rs3.next()) {
				contaminationTypes = new ContaminationTypes();
				contaminationTypes.setContType(rs3.getString(1));
				contaminationTypes.setPercent(rs3.getDouble(2));
				contaminations.add(contaminationTypes);
				rwsMaster.setContamName(rs3.getString(1));
				if (rs3.getString(1).equals("01"))
				{
				rwsMaster.setFlouride(Double.parseDouble(rs3.getString(2)));
				rwsMaster.setContTypes1("1");
				}
				else if (rs3.getString(1).equals("02"))
				{
				rwsMaster.setBrakish(Double.parseDouble(rs3.getString(2)));
				rwsMaster.setContTypes2("2");
				}
				else if (rs3.getString(1).equals("03"))
				{
				rwsMaster.setIron(Double.parseDouble(rs3.getString(2)));
				rwsMaster.setContTypes3("3");
				}
				else if (rs3.getString(1).equals("04"))
				{
				rwsMaster.setAresenic(Double.parseDouble(rs3.getString(2)));
				rwsMaster.setContTypes4("4");
				}
				else if (rs3.getString(1).equals("05"))
				{
				rwsMaster.setNitrate(Double.parseDouble(rs3.getString(2)));
				rwsMaster.setContTypes5("5");
				}
			}
			Debug.println("1:"+rwsMaster.getContTypes1());
			Debug.println("2:"+rwsMaster.getContTypes2());
			Debug.println("3:"+rwsMaster.getContTypes3());
			Debug.println("4:"+rwsMaster.getContTypes4());
			Debug.println("5:"+rwsMaster.getContTypes5());
			rwsMaster.setContaminations(contaminations);
		}
	} catch (Exception e) {
		Debug.println("The error in getHabSupplyStatus = " + e);
	} finally {
		closeAll();
	}
	
	Debug.println("end query1=" + rwsMaster.getLatitude());
	Debug.println("end query2=" + rwsMaster.getLongitude());
	Debug.println("end query3=" + rwsMaster.getElevation());
	return rwsMaster;
}

public  String getCircleOfficeName(String hoc, String coc,
		Connection conn) throws Exception {  
		
		String name = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	try {
		stmt1 = conn.createStatement();
		rs1 = stmt1
				.executeQuery("SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE HEAD_OFFICE_CODE='"
						+ hoc + "' and CIRCLE_OFFICE_CODE='" + coc + "'");
		rs1.next();
		name = rs1.getString(1);
	} catch (Exception e) {
		Debug.println("Ther error in getCircleOfficeName=" + e);
	} finally {
		if(stmt1!=null)
		stmt1.close();
		if(rs1!=null)
		rs1.close();
		
	}
	return name;
}

public  String getDivisionOfficeName(String hoc, String coc,
		String doc, Connection conn) throws Exception {   
		
		String name = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	Debug.println("hoc=" + hoc + "  coc=" + coc + "   doc=" + doc);
	try {
		if (doc != null || !(doc.equals("0"))) {
			stmt1 = conn.createStatement();
			rs1 = stmt1
					.executeQuery("SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE='"
							+ hoc
							+ "' and CIRCLE_OFFICE_CODE='"
							+ coc
							+ "' and DIVISION_OFFICE_CODE='" + doc + "'");
			rs1.next();
			name = rs1.getString(1);
		}
	} catch (Exception e) {
		Debug.println("Ther error in getDivisionOfficeName=" + e);
	} finally {
		if(stmt1!=null)
		stmt1.close();
		if(rs1!=null)
		rs1.close();
		}
	return name;
}

public  String getSubDivisionOfficeName(String hoc, String coc,
		String doc, String sdoc, Connection conn) throws Exception {   
		
		String name = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	Debug.println("hoc=" + hoc + "  coc=" + coc + "   doc=" + doc
			+ "  sdoc=" + sdoc);
	try {
		if (doc != null || !(doc.equals("0"))) {
			stmt1 = conn.createStatement();
			rs1 = stmt1
					.executeQuery("SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE='"
							+ hoc
							+ "' and CIRCLE_OFFICE_CODE='"
							+ coc
							+ "' and DIVISION_OFFICE_CODE='"
							+ doc
							+ "' and SUBDIVISION_OFFICE_CODE='"
							+ sdoc
							+ "'");
			rs1.next();
			name = rs1.getString(1);
		}
	} catch (Exception e) {
		Debug.println("Ther error in getSubDivisionOfficeName=" + e);
	} finally {
		if(stmt1!=null)
			stmt1.close();
			if(rs1!=null)
			rs1.close();
			}
	return name;
}
public  String getDistrictName(String dcode, Connection conn)
throws Exception {   

String name = null;
Statement stmt1 = null;
ResultSet rs1 = null;
try {
stmt1 = conn.createStatement();
rs1 = stmt1
		.executeQuery("SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE='"
				+ dcode + "'");
rs1.next();
name = rs1.getString(1);
} catch (Exception e) {
Debug.println("Ther error in getDistrictName=" + e);
} finally {
	if(stmt1!=null)
		stmt1.close();
		if(rs1!=null)
		rs1.close();
		}
return name;
}

public  String getMandalName(String dcode, String mcode,
		Connection conn) throws Exception {   
		
		String name = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	try {
		stmt1 = conn.createStatement();
		rs1 = stmt1
				.executeQuery("select MNAME from RWS_MANDAL_TBL where DCODE='"
						+ dcode + "' and mcode='" + mcode + "'");
		rs1.next();
		name = rs1.getString(1);
	} catch (Exception e) {
		Debug.println("Ther error in getMandalName=" + e);
	} finally {
		if(stmt1!=null)
			stmt1.close();
			if(rs1!=null)
			rs1.close();
			}
	return name;
}

public  String getPanchayatName(String dcode, String mcode,
		String pcode, Connection conn) throws Exception {   
		
		String name = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	try {
		stmt1 = conn.createStatement();
		rs1 = stmt1
				.executeQuery("select PNAME from RWS_PANCHAYAT_TBL where DCODE='"
						+ dcode
						+ "' and mcode='"
						+ mcode
						+ "' and PCODE='"
						+ pcode + "'");
		rs1.next();
		name = rs1.getString(1);
	} catch (Exception e) {
		Debug.println("Ther error in getPanchayatName=" + e);
	} finally {
		if(stmt1!=null)
			stmt1.close();
			if(rs1!=null)
			rs1.close();
			}
	return name;
}

public  String getVillageName(String dcode, String mcode,
		String pcode, String vcode, Connection conn) throws Exception {   
		
		String name = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	try {
		stmt1 = conn.createStatement();
		rs1 = stmt1
				.executeQuery("select VNAME from RWS_VILLAGE_TBL where DCODE='"
						+ dcode
						+ "' and mcode='"
						+ mcode
						+ "' and PCODE='"
						+ pcode + "' and vcode='" + vcode + "'");
		rs1.next();
		name = rs1.getString(1);
	} catch (Exception e) {
		Debug.println("Ther error in getPanchayatName=" + e);
	} finally {
		if(stmt1!=null)
			stmt1.close();
			if(rs1!=null)
			rs1.close();
			}
	return name;
}

public  ArrayList getInstitutes(DataSource dataSource)
throws Exception {   
RwsMaster rwsMaster = null;
ArrayList institutes = new ArrayList();

try {
conn = RwsOffices.getConn();
stmt = conn.createStatement();
rs = stmt
		.executeQuery("select inst_code,inst_name from RWS_PUBLIC_INSTITUTE_TBL order by to_number(INST_CODE)");
while (rs.next()) {
	Debug.println("in while");
	rwsMaster = new RwsMaster();

	rwsMaster.setInstituteCode(rs.getString(1));
	rwsMaster.setInstituteName(rs.getString(2));
	rwsMaster
			.setInsDisplay(rs.getString(1) + "-" + rs.getString(2));
	institutes.add(rwsMaster);
}
} catch (Exception e) {
Debug.println("The error in getInstitutes=" + e);
} 
finally 
{
	closeAll();
	

}
return institutes;
}


public  ArrayList getContamNames(DataSource dataSource)
throws Exception {   
RwsMaster rwsMaster = null;
ArrayList contaminations = new ArrayList();

try {
conn = RwsOffices.getConn();
stmt = conn.createStatement();
String query = "SELECT CONTAMINATION_NAME FROM RWS_CONTAMINATION_TBL";
rs = stmt.executeQuery(query);
while (rs.next()) {
	rwsMaster = new RwsMaster();

	rwsMaster.setContamName(rs.getString("CONTAMINATION_NAME"));
	contaminations.add(rwsMaster);
}
} catch (Exception e) {
Debug.println("The error in getContaminations=" + e);
} finally {
closeAll();
}
return contaminations;
}

public  int[] insertHabStatus(RwsMaster rwsMaster, ArrayList insts,
		ArrayList waterSupply, DataSource dataSource,String divStatus) throws Exception {   
	Debug.println("in insertHabStatus in first same RwsHabstatusData.java file");
	HabInstitute habInstitute = new HabInstitute();
	ContaminationTypes contaminationTypes = null;
	HabWaterSupply habWS = new HabWaterSupply();
	int[] updateCounts = new int[insts.size()];
	String habCode = rwsMaster.getHabCode();
	boolean recordNotExistsInHabitationDirectoryTbl = true,exists=false;
	boolean insUpdate = false, cnsUpdate1 = false,cnsUpdate2 = false,cnsUpdate3 = false,cnsUpdate4 = false,cnsUpdate5 = false, flag = false;
	String StatusDate = null,previousCoverageStatus=null;	
	String query="",querypanchayat="";
	conn=RwsOffices.getConn();
	stmt1 = conn.createStatement();
	
	String slipCode = "";
	if(divStatus.equals("1"))slipCode = rwsMaster.getSlipReasonCode();
	try {
		
		conn.setAutoCommit(false);
		stmt = conn.createStatement();
		//Debug.println("habCode=" + habCode);
		recordNotExistsInHabitationDirectoryTbl=true;
		Debug.println("COVERED STATUS IN INSERT HABSATUS METHOD"+rwsMaster.getCoveredStatus());
		query="select * from rws_habitation_directory_tbl where hab_code='"+habCode+"'";
		rs=stmt.executeQuery(query);
		while(rs.next())
		{
			recordNotExistsInHabitationDirectoryTbl = false;
		}
		
		//Debug.println("2");
		Debug.println("qa "+rwsMaster.getQualityAffected()+  "con named"+rwsMaster.getContamName());
		String finyr = rwsMaster.getHabYear();
		//Debug.println("fin yrs 6666666 sliue  "+finyr);
		String finyrMon = finyr.substring(3,5);
		finyr = finyr.substring(6,10);
	//	Debug.println("DT vsliue  "+finyrMon);
	///	Debug.println("fin yrs  sliue  "+finyr);
		int fyr = Integer.parseInt(finyr);
		int fyrMon = Integer.parseInt(finyrMon);
		Debug.println("3");
		if(fyrMon>4)
		{
			fyr = fyr + 1;
			finyr = finyr +"-"+fyr;
			Debug.println("fin yrs  sliue  "+finyr);
		}
		else
		{
			fyr = fyr - 1;
			finyr = fyr +"-"+finyr;
		//	Debug.println("fin yrs  sliue  "+finyr);
		//	Debug.println("circle code "+rwsMaster.getCircleOfficeCode());
		}
		//Debug.println("4");
		//Debug.println("Record Not Exist: "+recordNotExistsInHabitationDirectoryTbl);
		//Debug.println("Quality Affected ="+rwsMaster.getQualityAffected()+"  CoveredStatus ="+rwsMaster.getCoveredStatus());
		if (recordNotExistsInHabitationDirectoryTbl)
		{
			//Debug.println("in if");
		Debug.println("Insert rwsMaster.getExistWaterLevel()"
					+ rwsMaster.getExistWaterLevel());
			//Debug.println("status year in form is "+Integer.parseInt(rwsMaster.getHabYear().substring(6,10))+"");
			
			//Debug.println("5");
			//updated by swapna on 30-01-2012 for minority entry of gis data all insert and update queries
//			added by swapna on 19-12-2011 updated query and added sc,st,plain for connections and house holds
//			added by swapna on 12-1-2012 for adding gis data(latitude ,langitude,elevation,waypoint)in habitation status form
			query = "insert into RWS_HABITATION_DIRECTORY_TBL values("
					+ "'" + rwsMaster.getCircleOfficeCode() + "'," + rwsMaster.getDivisionOfficeCode()
					+ "," + "'" + rwsMaster.getSubdivisionOfficeCode() + "','"
					+ rwsMaster.getHabCode() + "'," + "'"
					+ rwsMaster.getCensusYear() + "',"
					+ rwsMaster.getCensusPop() + "," + ""
					+ rwsMaster.getCensusSc() + ","
					+ rwsMaster.getCensusSt() + "," + ""
					+ rwsMaster.getFloatPop() + ",'"
					+ rwsMaster.getFloatReason() + "'," + "TO_DATE('"
					+ rwsMaster.getHabYear() + "','dd/mm/yyyy')," + ""
					+ rwsMaster.getPopCovered() + ","
					+ rwsMaster.getScCovered() + "," + ""
					+ rwsMaster.getStCovered() + ","
					+ rwsMaster.getTotalWaterSupply() + ",nvl('" + ""
					+ rwsMaster.getLevelOfWaterSupply() + "',0)," + "'"
					+ rwsMaster.getCoveredStatus() + "'," + ""
					+ rwsMaster.getNearWaterSource() + "," + ""
					+ rwsMaster.getNearWaterGroundSource() + "," + "'"
					+ rwsMaster.getRemarks() + "','"
					+ rwsMaster.getQualityAffected() + "'," + "TO_DATE('"
					+ rwsMaster.getUpdateDate() + "','dd/mm/yyyy'),'"
					+ rwsMaster.getPrevYrStatus() + "','"
					+ rwsMaster.getPresentvYrStatus() + "','"
					+ rwsMaster.getProposedFcYr() + "',"
					+ rwsMaster.getProposedFCAmt() + ",'"
					+ rwsMaster.getHabType()+ "','"
					+ rwsMaster.getHouseHold()+"','"
					+ rwsMaster.getHabCat()+"','"
					+ rwsMaster.getExistSource()+"','"
					+ rwsMaster.getSafeSource()+"','"
					+ slipCode+"','"
					+ rwsMaster.getCattles()+"','"
					+ rwsMaster.getHabSubType()+"','"+rwsMaster.getNcSourceType()+"','"+rwsMaster.getSourceDistance()+"','"+rwsMaster.getLpcdCooking()+"','','"+rwsMaster.getIsMinorityHab()+"','"+rwsMaster.getIsLwe()+"','"+rwsMaster.getUnsafeLpcd()+"','"+rwsMaster.getLevelOfWaterSupplySafeOnly()+"','"+rwsMaster.getHouseConn()+"'," +
							"'"+rwsMaster.getIsItda()+"','"+rwsMaster.getScHCon()+"','"+rwsMaster.getStHCon()+"','"+rwsMaster.getPlainHCon()+"','"+rwsMaster.getScHHold()+"','"+rwsMaster.getStHHold()+"','"+rwsMaster.getPlainHHold()+"','"+rwsMaster.getMinorityHHold()+"','"+rwsMaster.getMinorityHCon()+"','"+rwsMaster.getMinorityCovered()+"','"+rwsMaster.getCensusMinority()+"','"+rwsMaster.getPublicTap()+"','"+rwsMaster.getPublicStandpost()+"','"+rwsMaster.getExistCheckDams()+"','"
							+rwsMaster.getReqCheckDams()+"','"+rwsMaster.getGlsrno()+"','"+rwsMaster.getGlsrqty()+"','"+rwsMaster.getOhsrno()+"','"+rwsMaster.getOhsrqty()+"','"+rwsMaster.getSchemesource()+"')";
			Debug.println("Hab Directory Query is(insert query   anuuuu) : \n" + query);
			stmt.addBatch(query);
			//added by swapna on 12-01-2012
			//updated by swapna on 23-01-2012
			querypanchayat="insert into rws_panchayat_raj_tbl(latitude,longitude,elevation,way_point,landmark)values('"+rwsMaster.getLatitude()+"','"+rwsMaster.getLongitude()+"','"+rwsMaster.getElevation()+"','"+rwsMaster.getWaypoint()+"','"+rwsMaster.getLandmark()+"' where panch_code='"+rwsMaster.getHabCode()+"')";
			Debug.println("GIS data entry in panchayatraj table : \n" + querypanchayat);
			stmt.addBatch(querypanchayat);
			for (int i = 0; i < insts.size(); i++) {
				habInstitute = (HabInstitute) insts.get(i);
				Debug.println("habInstitute.getInstituteNo()="
						+ habInstitute.getInstituteNo());
				
				
				////CODE TO CHECK WHETHER INSTITUTE DATA ALREADY EXISTS
				insUpdate = false;
				query = " SELECT count(*) FROM rws_hab_institute_tbl  WHERE P_INST_CODE = '"
						+ habInstitute.getInstituteCode()
						+ "'and  hab_code='" + habCode + "'";
				Debug.println("habInst select query=" + query);
				
				rs = stmt1.executeQuery(query);
				if (rs.next()) {
					if (rs.getInt(1) > 0)
						insUpdate = true;
				}
				//end of code to check institute data
				
				//code to insert institute data
				Debug.println("insUpdate is "+insUpdate);
				if (habInstitute.getInstituteNo().length() != 0) {
					Debug.println("habInstitute.getInstituteNo()="
							+ habInstitute.getInstituteNo());
					
					if(!insUpdate)
					{
						if( !habInstitute.getInstituteNo().equals("") || !habInstitute.getInstituteCovered().equals("") ||!habInstitute.getInstituteWorking().equals("") ||!habInstitute.getInstituteNotWorking().equals(""))
						{
							
							
							query = "insert into rws_hab_institute_tbl values("
									+ "'" + rwsMaster.getHabCode() + "'," + "'"
									+ habInstitute.getInstituteCode() + "'," + "'"
									+ habInstitute.getInstituteNo() + "'," + "'"
									+ habInstitute.getInstituteCovered()+"','"
									+ habInstitute.getInstituteWorking()+"','"
									+ habInstitute.getInstituteNotWorking()+ "')";
							Debug.println("Hab Institute Query is(insert query 123) : \n"
									+ query);
							stmt.addBatch(query);
						}
						else
						{
							Debug.println("institute data not given");
						}
					}
					//end of code to insert institute data 
					
					//code to update institute data 
					if(insUpdate)
					{
						//if( !habInstitute.getInstituteNo().equals("") || !habInstitute.getInstituteCovered().equals("") ||!habInstitute.getInstituteWorking().equals("") ||!habInstitute.getInstituteNotWorking().equals(""))
						//{
							
							
							query = " UPDATE RWS_HAB_INSTITUTE_TBL "
								+ " SET P_INST_NO='"
								+ habInstitute.getInstituteNo() + "',"
								+ " P_INST_COVERED='"
								+ habInstitute.getInstituteCovered() + "',"
								+ " P_INST_WORKING ='"
								+ habInstitute.getInstituteWorking() + "',"
								+ " P_INST_NOTWORKING_NO='"
								+ habInstitute.getInstituteNotWorking() + "'"
								+ " WHERE P_INST_CODE = '"
								+ habInstitute.getInstituteCode() + "'"
								+ " AND HAB_CODE='" + rwsMaster.getHabCode()
								+ "'";
							Debug.println("Hab Institute Query is(update query) : \n"
									+ query);
							stmt.addBatch(query);
						//}
						//else
						//{
							//Debug.println("institute data not given");
						//}
					}
					//end of code to update institute data
				}
			}
			Debug.println("------------------?"+rwsMaster.getStatus());
			if (rwsMaster.getQualityAffected().equals("Y") || rwsMaster.getStatus().equals("NSS"))
			{
				Debug.println("INSERTING CONTAMINATION DETAILS RAMESH");
				boolean contStatus = false;
				String type = "",conttypevalue="";
				if((rwsMaster.getContTypes1()!=null && rwsMaster.getContTypes1().equals("1")) || (rwsMaster.getContTypes2()!=null && rwsMaster.getContTypes2().equals("2") || (rwsMaster.getContTypes3()!=null && rwsMaster.getContTypes3().equals("3")) || (rwsMaster.getContTypes4()!=null && rwsMaster.getContTypes4().equals("4")) ||(rwsMaster.getContTypes5()!=null && rwsMaster.getContTypes5().equals("5"))))
				{
					for(int i=0,j=1;i<5;i++,j++)
					{
						if(i==0){type="01";conttypevalue=rwsMaster.getContTypes1();}
						else if(i==1){type="02";conttypevalue=rwsMaster.getContTypes2();}
						else if(i==2){type="03";conttypevalue=rwsMaster.getContTypes3();}
						else if(i==3){type="04";conttypevalue=rwsMaster.getContTypes4();}
						else if(i==4){type="05";conttypevalue=rwsMaster.getContTypes5();}
						contStatus = getContaminationStatus(type,dataSource,rwsMaster.getHabCode());
						Debug.println("status for "+type+" :"+contStatus);
						if(contStatus)
						{
							if(conttypevalue!=null && conttypevalue.equals(""+j))
							{
								//Nothing to do
							}
							else
							{
								deleteContHab(type,stmt,rwsMaster.getHabCode());
							}
						}
						else
						{
							if(conttypevalue!=null && conttypevalue.equals(""+j))
							{
								addContHab(type,stmt,rwsMaster.getHabCode());
							}
							else
							{
								//Nothing to do
							}
						}
					}
				}
				else
				{
					//Nothing Selected
					deleteContHabEntire(stmt,rwsMaster.getHabCode());
				}
		   }
		   else if(!rwsMaster.getStatus().equals("NSS"))
		   {
		   		deleteContHabEntire(stmt,rwsMaster.getHabCode());
		   }
				String q1 = "select * from rws_hab_supply_status_tbl where hab_code='"
					+ habCode + "'";
				Debug.println("select query is "+query);
			
			
				
					rs = stmt1.executeQuery(q1);
					if (rs.next())
					{
					exists = true;
					
					}
					Debug.println("habsupply data exists is "+exists);
					Debug.println("othersSafeNo in save metod:"+rwsMaster.getOthersSafeeNo());		
			Debug.println("checking !recordNotExistsInHabitationDirectoryTbl");
			if(!exists)
			{
			Debug.println("in !recordNotExistsInHabitationDirectoryTbl");
			
			query = "insert into rws_hab_supply_status_tbl(hab_code,SHP_DK_SUPPLY,SHP_NO,HPS_OTH_SUPPLY,HPS_NO,PWS_SUPPLY,PWS_NO,CPWS_SUPPLY,CPWS_NO,MPWS_SUPPLY,MPWS_NO,HPS_OTH_SUPPLY_UNSAFE,HPS_NO_UNSAFE,OWS_OTH_SUPPLY,OWS_NO,PONDS_OTH_SUPPLY,PONDS_NO,DW_TANKS_SUPPLY,DW_TANKS_NO,STAT_OF_HAB,OTHERS_SUPPLY,OTHERS_NO,OTHERS_SUPPLY_SAFE,OTHERS_NO_SAFE,PWS_UNSAFE_SUPPLY,PWS_UNSAFE_NO,MPWS_UNSAFE_SUPPLY,MPWS_UNSAFE_NO,SHP_NO_SAFE,SHP_DK_SUPPLY_SAFE) "
					+ "values('"
					+ rwsMaster.getHabCode()
					+ "','"
					+ rwsMaster.getShpSupply()
					+ "','"
					+ rwsMaster.getShpNo()
					+ "','"
					+ rwsMaster.getHpSupply()
					+ "','"
					+ rwsMaster.getHpNo()
					+ "','"
					+ rwsMaster.getPwsSupply()
					+ "','"
					+ rwsMaster.getPwsNo()
					+ "','"
					+ rwsMaster.getCpwsSupply()
					+ "','"
					+ rwsMaster.getCpwsNo()
					+ "',"
					+ "'"
					+ rwsMaster.getMpwsSupply()
					+ "','"
					+ rwsMaster.getMpwsNo()
					+ "','"
					+ rwsMaster.getDpSupply()
					+ "','"
					+ rwsMaster.getDpNo()
					+ "','"
					+ rwsMaster.getOwsSupply()
					+ "','"
					+ rwsMaster.getOwsNo()
					+ "','"
					+ rwsMaster.getPondsSupply()
					+ "','"
					+ rwsMaster.getPondsNo()
					+ "','"
					+ rwsMaster.getDwSupply()
					+ "',"
					+ "'"
					+ rwsMaster.getDwNo()
					+ "','"
					+ rwsMaster.getStatus()
					+ "',nvl('"
					+rwsMaster.getOthersSupply()
					+"',0),nvl('"+rwsMaster.getOthersNo()+"',0),nvl('"+rwsMaster.getOthersSafeSupply()+"',0),nvl('"+rwsMaster.getOthersSafeeNo()+"',0),nvl('"+rwsMaster.getPwsUnsafeSupply()+"',0),nvl('"+rwsMaster.getPwsUnsafeNo()+"',0),nvl('"+rwsMaster.getMpwsUnsafeSupply()+"',0),nvl('"+rwsMaster.getMpwsUnsafeNo()+"',0),nvl('"+rwsMaster.getSafeSHPNo()+"',0),nvl('"+rwsMaster.getSafeSHPSupply()+"',0))";
			Debug.println("HabSupply query(insert query)=" + query);
			stmt.addBatch(query);
	      }
		 }
		else {
			conn.setAutoCommit(false);
			Debug.println("Quality Affected ="+rwsMaster.getQualityAffected()+"  CoveredStatus ="+rwsMaster.getCoveredStatus());
			Debug.println("UPDATING CONTAMINATION DETAILS");
			try
			{
				boolean contStatus = false;
				String type = "",conttypevalue="";
				if(!rwsMaster.getStatus().equals("NSS"))
				{
					deleteContHabEntire(stmt,rwsMaster.getHabCode());
				}
				else if(rwsMaster.getStatus().equals("NSS"))
				{
					if((rwsMaster.getContTypes1()!=null && rwsMaster.getContTypes1().equals("1")) || (rwsMaster.getContTypes2()!=null && rwsMaster.getContTypes2().equals("2") || (rwsMaster.getContTypes3()!=null && rwsMaster.getContTypes3().equals("3")) || (rwsMaster.getContTypes4()!=null && rwsMaster.getContTypes4().equals("4")) ||(rwsMaster.getContTypes5()!=null && rwsMaster.getContTypes5().equals("5"))))
					{
						for(int i=0,j=1;i<5;i++,j++)
						{
							if(i==0){type="01";conttypevalue=rwsMaster.getContTypes1();}
							else if(i==1){type="02";conttypevalue=rwsMaster.getContTypes2();}
							else if(i==2){type="03";conttypevalue=rwsMaster.getContTypes3();}
							else if(i==3){type="04";conttypevalue=rwsMaster.getContTypes4();}
							else if(i==4){type="05";conttypevalue=rwsMaster.getContTypes5();}
							contStatus = getContaminationStatus(type,dataSource,rwsMaster.getHabCode());
							Debug.println("status for "+type+" :"+contStatus);
							if(contStatus)
							{
								if(conttypevalue!=null && conttypevalue.equals(""+j))
								{
									//Nothing to do
								}
								else
								{
									deleteContHab(type,stmt,rwsMaster.getHabCode());
								}
							}
							else
							{
								if(conttypevalue!=null && conttypevalue.equals(""+j))
								{
									addContHab(type,stmt,rwsMaster.getHabCode());
								}
								else
								{
									//Nothing to do
								}
							}
						}
					}
					else
					{
						//Nothing Selected
						deleteContHabEntire(stmt,rwsMaster.getHabCode());
					}
				}
			}catch(Exception e)
			{
				Debug.println("ERROR OCCURED IN UPDATE CONTAMINATION VALUES:"+e.getMessage());
			}
			
			Debug.println("6");

			
			//
			query = " UPDATE RWS_HABITATION_DIRECTORY_TBL "
					+ " SET CENSUS_YEAR='" + rwsMaster.getCensusYear()
					+ "'," + " CENSUS_PLAIN_POPU='"
					+ rwsMaster.getCensusPop() + "'," + " CENSUS_SC_POPU='"
					+ rwsMaster.getCensusSc() + "'," + " CENSUS_ST_POPU='"
					+ rwsMaster.getCensusSt() + "'," + " FLOAT_POP='"
					+ rwsMaster.getFloatPop() 
					+ "', FLOAT_POP_REASONS='" + rwsMaster.getFloatReason()
					+ "'," + " STATUS_DATE=TO_DATE('"+ rwsMaster.getHabYear() + "','dd/mm/yyyy'),"
					+ " PLAIN_POPU_COVERED='" + rwsMaster.getPopCovered()
					+ "'," + " SC_POP_COVERED='" + rwsMaster.getScCovered()
					+ "'," + " ST_POP_COVERED='" + rwsMaster.getStCovered()
					+ "'," + " TOTAL_WATER_SUPPLY='"
					+ rwsMaster.getTotalWaterSupply() + "',"
					+ " EXIST_WATER_LEVEL='"
					+ rwsMaster.getLevelOfWaterSupply() + "',"
					+ " COVERAGE_STATUS='" + rwsMaster.getStatus() + "',"
					+ " NEAR_SURFACE_SOURCE='"
					+ rwsMaster.getNearWaterSource() + "',"
					+ " NEAR_GROUND_SOURCE='"
					+ rwsMaster.getNearWaterGroundSource() + "',"
					+ " REMARKS='" + rwsMaster.getRemarks() + "',"
					+ " quality_affected='"
					+ rwsMaster.getQualityAffected()
					+ "',UPDATE_DATE=TO_DATE('" + rwsMaster.getUpdateDate()
					+ "','dd/mm/yyyy'),"
					+ "PRESENT_YR_STATUS='"
					+ rwsMaster.getPresentvYrStatus() + "', PROPOSED_FC_YEAR = '"
					+ rwsMaster.getProposedFcYr() +"', PROPOSED_FC_EST_AMT ="
					+ "nvl('"+ rwsMaster.getProposedFCAmt() + "','0'), " 
					+ "HABITATION_TYPE='"
					+ rwsMaster.getHabType() + "',"
					+ "HABITATION_SUB_TYPE='"
					+ rwsMaster.getHabSubType() + "',"
					+ " HOUSEHOLD_NO='"
					+ rwsMaster.getHouseHold() + "',"  
					+ "HABITATION_CATEGORY='"
					+ rwsMaster.getHabCat()+"',"
					+ "EXISTING_SOURCES_NO='"
					+ rwsMaster.getExistSource()+"',"
					+ "SAFE_SOURCES_NO='"
					+ rwsMaster.getSafeSource()+"',"
					+ "NO_OF_PUBLIC_TAPS ='"
					+ rwsMaster.getPublicTap()+"',"
					+ "NO_OF_TAPS_WITH_STANDPOSTS ='"
					+ rwsMaster.getPublicStandpost()+"',"
					+ "SLIPPAGE_CODE='"
					+ slipCode+"',"
					+ "NO_OF_CATTLE='"
					+ rwsMaster.getCattles()+"',nc_source_type='"+rwsMaster.getNcSourceType()+"',source_distance='"+rwsMaster.getSourceDistance()+"',LPCD_COOKING ='"+rwsMaster.getLpcdCooking()+"',MINORITY_DOMINATED='"+rwsMaster.getIsMinorityHab()+"',LWE='"+rwsMaster.getIsLwe()+"',IS_ITDA='"+rwsMaster.getIsItda()+"',UNSAFE_LPCD='"+rwsMaster.getUnsafeLpcd()+"',SAFE_LPCD='"+rwsMaster.getLevelOfWaterSupplySafeOnly()+"',NO_OF_HOUSECONN_GIVEN ="+rwsMaster.getHouseConn()+""
					+ ",CON_SC ='"+rwsMaster.getScHCon()+"', CON_ST ='"+rwsMaster.getStHCon()+"', CON_PLAIN ='"+rwsMaster.getPlainHCon()+"',"
                  + " HOUSEHOLDS_SC='"+rwsMaster.getScHHold()+"', HOUSEHOLDS_ST ='"+rwsMaster.getStHHold()+"',HOUSEHOLDS_PLAIN ='"+rwsMaster.getPlainHHold()+"',HOUSEHOLDS_MINORITY ='"+rwsMaster.getMinorityHHold()+"',CON_MINORITY ='"+rwsMaster.getMinorityHCon()+"',MINORITY_POP_COVERED ='"+rwsMaster.getMinorityCovered()+"',CENSUS_MINORITY_POPU='"+rwsMaster.getCensusMinority()+"',GLSR_NO='"+rwsMaster.getGlsrno()+"',GLSR_QTY='"+rwsMaster.getGlsrqty()+"',OHSR_NO='"+rwsMaster.getOhsrno()+"',OHSR_QTY='"+rwsMaster.getOhsrqty()+"',SCHEMESOURCE='"+rwsMaster.getSchemesource()+"'"
					+ " WHERE HAB_CODE='" + rwsMaster.getHabCode() + "'";
			Debug.println("Hab Directory query(insert query is anuuu)=" + query);
			stmt.addBatch(query);
//			added by swapna Gis-data update on 12-01-2012
			//		added by swapna Gis-data update on 23-01-2012
			String prajquery = " UPDATE RWS_PANCHAYAT_RAJ_TBL "
				+ " SET  LATITUDE='"+rwsMaster.getLatitude()+"'," +
			"LONGITUDE='"+rwsMaster.getLongitude()+"'," +
			"ELEVATION='"+rwsMaster.getElevation()+"'," +
			"WAY_POINT='"+rwsMaster.getWaypoint()+"'," +
			"landmark='"+rwsMaster.getLandmark()+"' " +
			" WHERE panch_CODE='" + rwsMaster.getHabCode() + "'";

	     Debug.println("query in panchayat updatation of gis data "+prajquery);
		stmt.addBatch(prajquery);
			//
			for (int i = 0; i < insts.size(); i++) {
				habInstitute = (HabInstitute) insts.get(i);
				insUpdate = false;
				query = " SELECT count(*) FROM rws_hab_institute_tbl  WHERE P_INST_CODE = '"
						+ habInstitute.getInstituteCode()
						+ "'and  hab_code='" + habCode + "'";
				Debug.println("habInst select query=" + query);
				
				rs = stmt1.executeQuery(query);
				if (rs.next()) {
					if (rs.getInt(1) > 0)
						insUpdate = true;
				}
					
				if (insUpdate)
				{
					//if( !habInstitute.getInstituteNo().equals("") || !habInstitute.getInstituteCovered().equals("") ||!habInstitute.getInstituteWorking().equals("") ||!habInstitute.getInstituteNotWorking().equals(""))
					//{
					query = " UPDATE RWS_HAB_INSTITUTE_TBL "
							+ " SET P_INST_NO='"
							+ habInstitute.getInstituteNo() + "',"
							+ " P_INST_COVERED='"
							+ habInstitute.getInstituteCovered() + "',"
							+ " P_INST_WORKING ='"
							+ habInstitute.getInstituteWorking() + "',"
							+ " P_INST_NOTWORKING_NO='"
							+ habInstitute.getInstituteNotWorking() + "'"
							+ " WHERE P_INST_CODE = '"
							+ habInstitute.getInstituteCode() + "'"
							+ " AND HAB_CODE='" + rwsMaster.getHabCode()
							+ "'";
					Debug.println("HabInstitute query(insert query)=" + query);
					stmt.addBatch(query);
					//}
				}
				else
				{
					if( !habInstitute.getInstituteNo().equals("") || !habInstitute.getInstituteCovered().equals("") ||!habInstitute.getInstituteWorking().equals("") ||!habInstitute.getInstituteNotWorking().equals(""))
					{
					query = " INSERT INTO rws_hab_institute_tbl("
							+ "HAB_CODE,P_INST_CODE,P_INST_NO ," 
							+ "P_INST_WORKING ,P_INST_NOTWORKING_NO,P_INST_COVERED) VALUES('"
							+ habCode + "', " + " '"
							+ habInstitute.getInstituteCode() + "', '"
							+ habInstitute.getInstituteNo() + "', " + " '"
							+ habInstitute.getInstituteWorking() + "', " + " '"
							+ habInstitute.getInstituteNotWorking() + "', " + " '"
							+ habInstitute.getInstituteCovered() + "') ";
					Debug.println("HabInstitute query(insert query)=" + query);
					stmt.addBatch(query);
					}
				}
				
			}
			
			//code to check whether hab supply status data already exists
			String q1 = "select * from rws_hab_supply_status_tbl where hab_code='"
				+ habCode + "'";
			Debug.println("select query is "+query);
			rs = stmt1.executeQuery(q1);
			if (rs.next())
			{
				exists = true;
				
			}
			Debug.println("habsupply data exists is "+exists);
			//end of code to check whether hab supply status data already exists
			if(exists){
			query = " UPDATE rws_hab_supply_status_tbl SET "
					+ " hps_oth_supply = '" + rwsMaster.getHpSupply()
					+ "', " + " hps_no = '" + rwsMaster.getHpNo() + "', "
					+ " shp_dk_supply = '" + rwsMaster.getShpSupply()
					+ "', " + " shp_no = '" + rwsMaster.getShpNo() + "', "
					+ " pws_supply = '" + rwsMaster.getPwsSupply() + "', "
					+ " pws_no = '" + rwsMaster.getPwsNo() + "', "
					+ " cpws_supply = '" + rwsMaster.getCpwsSupply()
					+ "', " + " cpws_no = '" + rwsMaster.getCpwsNo()
					+ "', " + " mpws_supply = '"
					+ rwsMaster.getMpwsSupply() + "', " + " mpws_no = '"
					+ rwsMaster.getMpwsNo() + "', "
					+ " HPS_OTH_SUPPLY_UNSAFE = '"
					+ rwsMaster.getDpSupply() + "', "
					+ " HPS_NO_UNSAFE = '" + rwsMaster.getDpNo()
					+ "', " + " ows_oth_supply = '"
					+ rwsMaster.getOwsSupply() + "', " + " ows_no = '"
					+ rwsMaster.getOwsNo() + "', "
					+ " ponds_oth_supply = '" + rwsMaster.getPondsSupply()
					+ "', " + " ponds_no = '" + rwsMaster.getPondsNo()
					+ "', " + " DW_TANKS_SUPPLY = '"
					+ rwsMaster.getDwSupply() + "', " + " DW_TANKS_NO = '"
					+ rwsMaster.getDwNo() + "', " + " stat_of_hab = '"
					+ rwsMaster.getStatus() + "', OTHERS_SUPPLY = '"
					+ rwsMaster.getOthersSupply() +"', OTHERS_No= '"
					+ rwsMaster.getOthersNo() + "', OTHERS_SUPPLY_SAFE = '"
					+ rwsMaster.getOthersSafeSupply() +"', OTHERS_NO_SAFE= '"
					+ rwsMaster.getOthersSafeeNo() + "' , PWS_UNSAFE_SUPPLY = '"+ rwsMaster.getPwsUnsafeSupply() +"', PWS_UNSAFE_NO = '"+ rwsMaster.getPwsUnsafeNo() +"', MPWS_UNSAFE_SUPPLY = '"+ rwsMaster.getMpwsUnsafeSupply() +"', MPWS_UNSAFE_NO = '"+ rwsMaster.getMpwsUnsafeNo() +"' , SHP_NO_SAFE = '"+ rwsMaster.getSafeSHPNo() +"' , SHP_DK_SUPPLY_SAFE= '"+ rwsMaster.getSafeSHPSupply() +"' WHERE hab_code='"
					+ rwsMaster.getHabCode() + "'";

			Debug.println(" Update habSuply query is(insert query) " + query);
			stmt.addBatch(query);
			}
			else
			{
				query = " insert into rws_hab_supply_status_tbl(hps_oth_supply,hps_no,shp_dk_supply,shp_no,pws_supply,pws_no,cpws_supply,cpws_no,mpws_supply,mpws_no,HPS_OTH_SUPPLY_UNSAFE,HPS_NO_UNSAFE,ows_oth_supply,ows_no,ponds_oth_supply,ponds_no,DW_TANKS_SUPPLY,DW_TANKS_NO,stat_of_hab,OTHERS_SUPPLY,OTHERS_No,hab_code,OTHERS_SUPPLY_SAFE,OTHERS_NO_SAFE,PWS_UNSAFE_SUPPLY,PWS_UNSAFE_NO,MPWS_UNSAFE_SUPPLY,MPWS_UNSAFE_NO,SHP_DK_SUPPLY_SAFE,SHP_NO_SAFE) values( "
					+ "nvl('" + rwsMaster.getHpSupply()
					+ "',0),nvl('" + rwsMaster.getHpNo()  
					+ "',0),nvl('" + rwsMaster.getShpSupply()
					+ "',0),nvl('" + rwsMaster.getShpNo() 
					+ "',0),nvl('" + rwsMaster.getPwsSupply() 
					+ "',0),nvl('" + rwsMaster.getPwsNo() 
					+ "',0),nvl('" + rwsMaster.getCpwsSupply()
					+ "',0),nvl('" +rwsMaster.getCpwsNo()
					
					+ "',0),nvl('" +rwsMaster.getMpwsSupply() 
					+ "',0),nvl('" + rwsMaster.getMpwsNo() 
					
					+ "',0),nvl('" + rwsMaster.getDpSupply() 
					+ "',0),nvl('" + rwsMaster.getDpNo()
					
					+ "',0),nvl('" +rwsMaster.getOwsSupply() 
					+ "',0),nvl('" + rwsMaster.getOwsNo() 
					+ "',0),nvl('" + rwsMaster.getPondsSupply()
					+ "',0),nvl('" + rwsMaster.getPondsNo()
					
					+ "',0),nvl('" + rwsMaster.getDwSupply() 
					+ "',0),nvl('" + rwsMaster.getDwNo() 
					+ "',0),nvl('" + rwsMaster.getStatus() 
					+ "',0),nvl('" + rwsMaster.getOthersSupply() 
					+ "',0),nvl('" + rwsMaster.getOthersNo() 
					+ "',0),'" + rwsMaster.getHabCode() + "',nvl('"+rwsMaster.getOthersSafeSupply()+"',0),nvl('"+rwsMaster.getOthersSafeeNo()+"',0),nvl('"+rwsMaster.getPwsUnsafeSupply()+"',0),nvl('"+rwsMaster.getPwsUnsafeNo()+"',0),nvl('"+rwsMaster.getMpwsUnsafeSupply()+"',0),nvl('"+rwsMaster.getMpwsUnsafeNo()+"',0),nvl('"+rwsMaster.getSafeSHPSupply()+"',0),nvl('"+rwsMaster.getSafeSHPNo()+"',0)" 
					+")";
				
				Debug.println(" insert habSuply query is(insert query) " + query);
				stmt.addBatch(query);
				
			}
			//Debug.println("rwsMaster.getCoveredStatus()  "+rwsMaster.getCoveredStatus());


		}
		updateCounts = stmt.executeBatch();
		flag = true;
		Debug.println("updateCounts=" + updateCounts.length);
		for (int i = 0; i < updateCounts.length; i++) {
			if (updateCounts[i] == 0) {
				Debug.println("update Count=" + i + "count[i]="
						+ updateCounts[i]);
				flag = false;
			}
		}
		Debug.println("printing updateCounts");
		for (int i = 0; i < updateCounts.length; i++) {
				Debug.println("update Count=" + i + "count[i]="
						+ updateCounts[i]);
				
			
		}
		Debug.println("flag=" + flag);
		if (flag) {
			Debug.println("conn object:"+conn);
			conn.commit();
			if (recordNotExistsInHabitationDirectoryTbl)
				errorMessage = "Record Inserted Successfully";
			else
				errorMessage = "Record Updated Successfully";
		} else if (recordNotExistsInHabitationDirectoryTbl)
			errorMessage = "Record cannot be inserted.";
		else
			errorMessage = "Record cannot be updated";
		conn.setAutoCommit(true);

		}
	catch (BatchUpdateException b) {
		if (recordNotExistsInHabitationDirectoryTbl)
			errorMessage = "Record cannot be inserted.";
		else
			errorMessage = "Record cannot be updated";
	System.err.println("Update counts of successful commands: " + b);
	} catch (Exception e) {
		Debug.println("The error in insertHabStatus " + e);
		e.printStackTrace();
	} finally {
		closeAll();
	}
	return updateCounts;
}


public  int[] updateHabStatus(RwsMaster rwsMaster, ArrayList insts,
		ArrayList waterSupply,DataSource dataSource) throws Exception {   
	Debug.println("in updateHabStatus");
	int[] updateCounts = new int[10];
	HabInstitute habInstitute = new HabInstitute();
	HabWaterSupply habWS = new HabWaterSupply();
	ContaminationTypes habCont = new ContaminationTypes();
	String habCode = rwsMaster.getHabCode();
	boolean insUpdate = false, cnsUpdate = false;
	Debug.println("updateHabstatus() called.");
	try {
		Debug.println("IN TRY BLOCK OF UPDATEHAB STATUS METHOD IN rwsHABSTATUSDATA CLASS");
		conn = RwsOffices.getConn();
		stmt = conn.createStatement();
		String query = " SELECT count(*) FROM rws_hab_institute_tbl WHERE hab_code='"
				+ habCode + "'";
		rs = stmt.executeQuery(query);
		if (rs.next()) {
			if (rs.getInt(1) > 0)
				insUpdate = true;
		}

		query = " SELECT count(*) FROM rws_hab_contamination_tbl WHERE hab_code = '"
				+ habCode + "'";
		rs = stmt.executeQuery(query);
		if (rs.next()) {
			if (rs.getInt(1) > 0)
				cnsUpdate = true;
		}

		conn.setAutoCommit(false);
		stmt = conn.createStatement();
		//add by ali
		String finyr = rwsMaster.getHabYear();
		Debug.println("fin yrs 6666666 sliue  "+finyr);
		String finyrMon = finyr.substring(3,5);
		finyr = finyr.substring(6,10);
		Debug.println("DT vsliue  "+finyrMon);
		Debug.println("fin yrs  sliue  "+finyr);
		int fyr = Integer.parseInt(finyr);
		int fyrMon = Integer.parseInt(finyrMon);
		if(fyrMon>4)
		{
			fyr = fyr + 1;
			finyr = finyr +"-"+fyr;
			Debug.println("fin yrs  sliue  "+finyr);
		}
		else
		{
			fyr = fyr - 1;
			finyr = fyr +"-"+finyr;
			Debug.println("fin yrs  sliue  "+finyr);
		}
		//end
		//updated by swapna on 12-01-2012 for editing hab data and gis data for(house connections and households,gis data
		query = " UPDATE RWS_HABITATION_DIRECTORY_TBL "
				+ " SET CENSUS_YEAR='" + rwsMaster.getCensusYear() + "',"
				+ " CENSUS_PLAIN_POPU='" + rwsMaster.getCensusPop() + "',"
				+ " CENSUS_SC_POPU='" + rwsMaster.getCensusSc() + "',"
				+ " CENSUS_ST_POPU='" + rwsMaster.getCensusSt() + "',"
				+ " FLOAT_POP='" + rwsMaster.getFloatPop() + "',"
				+ " FLOAT_POP_REASONS='" + rwsMaster.getFloatReason()
				+ "'," + " STATUS_DATE=TO_DATE('" + rwsMaster.getHabYear()
				+ "','dd/mm/yyyy')," + " PLAIN_POPU_COVERED='"
				+ rwsMaster.getPopCovered() + "'," + " SC_POP_COVERED='"
				+ rwsMaster.getScCovered() + "'," + " ST_POP_COVERED='"
				+ rwsMaster.getStCovered() + "'," + " TOTAL_WATER_SUPPLY='"
				+ rwsMaster.getTotalWaterSupply() + "',"
				+ " EXIST_WATER_LEVEL='" + rwsMaster.getExistWaterLevel()
				+ "'," + " COVERAGE_STATUS='" + rwsMaster.getStatus()
				+ "'," + " NEAR_SURFACE_SOURCE='"
				+ rwsMaster.getNearWaterSource() + "',"
				+ " NEAR_GROUND_SOURCE='"
				+ rwsMaster.getNearWaterGroundSource() + "',"
				+ " REMARKS='" + rwsMaster.getRemarks() + "',"
				+ " quality_affected='" + rwsMaster.getQualityAffected()
				+ "', PROPOSED_FC_YEAR = '"+ rwsMaster.getProposedFcYr() +"', PROPOSED_FC_EST_AMT ="
				+ rwsMaster.getProposedFCAmt() + ",nc_source_type='"+rwsMaster.getNcSourceType()+"'," +
						"source_distance='"+rwsMaster.getSourceDistance()+"'" +"," +
						//addeed by swapna
								"HOUSEHOLDS_SC ='"+rwsMaster.getScHHold()+"',"+
						"HOUSEHOLDS_ST ='"+rwsMaster.getStHHold()+"'" +
						"HOUSEHOLDS_PLAIN='"+rwsMaster.getPlainHHold()+"'" +
						"CON_SC='"+rwsMaster.getScHCon()+"'" +
						"CON_ST='"+rwsMaster.getStHCon()+"'" +
						"CON_PLAIN='"+rwsMaster.getPlainHCon()+"',HOUSEHOLDS_MINORITY ='"+rwsMaster.getMinorityHHold()+"',CON_MINORITY ='"+rwsMaster.getMinorityHCon()+"', MINORITY_POP_COVERED ='"+rwsMaster.getMinorityCovered()+"',CENSUS_MINORITY_POPU='"+rwsMaster.getCensusMinority()+"',NO_OF_PUBLIC_TAPS='"+rwsMaster.getPublicTap()+"',NO_OF_TAPS_WITH_STANDPOSTS ='"+rwsMaster.getPublicStandpost()+"',no_checkdams_exist ='"+rwsMaster.getExistCheckDams()+"'" +"',no_checkdams_req ='"+rwsMaster.getReqCheckDams()+"'" +
						//
						" WHERE HAB_CODE='" + rwsMaster.getHabCode() + "'";
		Debug.println("query(insert query)=" + query);
		stmt.addBatch(query);
		//added by swapna Gis-data update on 12-01-2012
//		updated by swapna Gis-data update on 23-01-2012
		String prajquery = " UPDATE RWS_PANCHAYAT_RAJ_TBL "
			+ " SET  LATITUDE='"+rwsMaster.getLatitude()+"'," +
		"LONGITUDE='"+rwsMaster.getLongitude()+"'," +
		"ELEVATION='"+rwsMaster.getElevation()+"'," +
		"WAY_POINT='"+rwsMaster.getWaypoint()+"', " +
		"landmark='"+rwsMaster.getLandmark()+"' " +
		" WHERE panch_CODE='" + rwsMaster.getHabCode() + "'";

     Debug.println("query in panchayat updatation of gis data "+prajquery);
	stmt.addBatch(prajquery);
		//

		for (int i = 0; i < insts.size(); i++) {
			habInstitute = (HabInstitute) insts.get(i);
			if (insUpdate)
				query = " UPDATE RWS_HAB_INSTITUTE_TBL "
					+ " SET P_INST_NO='"
					+ habInstitute.getInstituteNo() + "',"
					+ " P_INST_COVERED='"
					+ habInstitute.getInstituteCovered() + "',"
					+ " P_INST_WORKING ='"
					+ habInstitute.getInstituteWorking() + "',"
					+ " P_INST_NOTWORKING_NO='"
					+ habInstitute.getInstituteNotWorking() + "'"
					+ " WHERE P_INST_CODE = '"
					+ habInstitute.getInstituteCode() + "'"
					+ " AND HAB_CODE='" + rwsMaster.getHabCode()
					+ "'";
				
				
			else
				query = " INSERT INTO rws_hab_institute_tbl("
					+ "HAB_CODE,P_INST_CODE,P_INST_NO ," 
					+ "P_INST_WORKING ,P_INST_NOTWORKING_NO,P_INST_COVERED) VALUES('"
					+ habCode + "', " + " '"
					+ habInstitute.getInstituteCode() + "', '"
					+ habInstitute.getInstituteNo() + "', " + " '"
					+ habInstitute.getInstituteWorking() + "', " + " '"
					+ habInstitute.getInstituteNotWorking() + "', " + " '"
					+ habInstitute.getInstituteCovered() + "') ";


			Debug.println("insert query is santosh "+query);
			stmt.addBatch(query);
		}

		query = " UPDATE rws_hab_supply_status_tbl SET "
				+ " shp_dk_supply = '" + rwsMaster.getShpSupply() + "', "
				+ " shp_no = '" + rwsMaster.getShpNo() + "', "
				+ " cisterns_dk_supply = '" + rwsMaster.getCisternsSupply()
				+ "', " + " cisterns_no = '" + rwsMaster.getCisternsNo()
				+ "', " + " glsrs_dk_supply = '"
				+ rwsMaster.getGlsrSupply() + "', " + " glsrs_no = '"
				+ rwsMaster.getGlsrNo() + "', " + " ohsrs_dk_supply = '"
				+ rwsMaster.getOhsrSupply() + "', " + " ohsrs_no = '"
				+ rwsMaster.getOhsrNo() + "', " + " hps_oth_supply = '"
				+ rwsMaster.getHpSupply() + "', " + " hps_no = '"
				+ rwsMaster.getHpNo() + "', " + " ows_oth_supply = '"
				+ rwsMaster.getOwsSupply() + "', " + " ows_no = '"
				+ rwsMaster.getOwsNo() + "', " + " ponds_oth_supply = '"
				+ rwsMaster.getPondsSupply() + "', " + " ponds_no = '"
				+ rwsMaster.getPondsNo() + "', " + " shwell_oth_supply = '"
				+ rwsMaster.getShwSupply() + "', " + " shwell_no = '"
				+ rwsMaster.getShwNo() + "', " + " pcpd_drink = '"
				+ rwsMaster.getPcpdDrink() + "', " + " pcpd_others = '"
				+ rwsMaster.getPcpdOthers() + "', " + " stat_of_hab = '"
				+ rwsMaster.getStatus() + "'" + ", OTHERS_SUPPLY = '"
					+ rwsMaster.getOthersSupply() +"', OTHERS_No= '"
					+ rwsMaster.getOthersNo() + "', OTHERS_SUPPLY_SAFE = '"
					+ rwsMaster.getOthersSafeSupply() +"', OTHERS_NO_SAFE= '"
					+ rwsMaster.getOthersSafeeNo() + "' , PWS_UNSAFE_SUPPLY = '"+ rwsMaster.getPwsUnsafeSupply() +"', PWS_UNSAFE_NO = '"+ rwsMaster.getPwsUnsafeNo() +"', MPWS_UNSAFE_SUPPLY = '"+ rwsMaster.getMpwsUnsafeSupply() +"', MPWS_UNSAFE_NO = '"+ rwsMaster.getMpwsUnsafeNo() +"',SHP_NO_SAFE= '"+ rwsMaster.getSafeSHPNo() +"',SHP_DK_SUPPLY_SAFE = '"+ rwsMaster.getSafeSHPSupply() +"' WHERE hab_code='"
				+ habCode + "'";
		Debug.println(" Update query is(insert query) " + query);
		stmt.addBatch(query);
    Debug.println("cnsUpdate is=="+cnsUpdate);
	if (cnsUpdate)
			{
	            Debug.println("UPDATING CONTMINATION TBL");	
	            Debug.println(rwsMaster.getFlouride()+" f"+rwsMaster.getBrakish()+" b"+rwsMaster.getIron()+" i");
				if (rwsMaster.getFlouride() != 0.0 )
				{
				query = " UPDATE rws_hab_contamination_tbl "
					+ " SET cont_perc = '"+rwsMaster.getFlouride() + "'"
					+ " WHERE cont_type = 01 " 
					+ " AND hab_code='" + rwsMaster.getHabCode()
					+ "'";
				Debug.println("Update contamination query is "+query);
				stmt.addBatch(query);
				}
				
				if (rwsMaster.getBrakish() != 0.0 )
				{
				query = " UPDATE rws_hab_contamination_tbl "
					+ " SET cont_perc = '"+rwsMaster.getBrakish() + "'"
					+ " WHERE cont_type = 02 " 
					+ " AND hab_code='" + rwsMaster.getHabCode()
					+ "'";
				Debug.println("Update query is "+query);
				stmt.addBatch(query);
				}
				
				if (rwsMaster.getIron() != 0.0 )
				{
				query = " UPDATE rws_hab_contamination_tbl "
					+ " SET cont_perc = '"+rwsMaster.getIron() + "'"
					+ " WHERE cont_type = 01 " 
					+ " AND hab_code='" + rwsMaster.getHabCode()
					+ "'";
				Debug.println("Update query is "+query);
				stmt.addBatch(query);
				}
			}
			
			else
			{
				if (rwsMaster.getBrakish() != 0.0 ) 
				{
					Debug.println("INSERTING BRAKISH CONTAMINATION DETAILS");
					query = "insert into RWS_HAB_CONTAMINATION_TBL values("
							+ "'" + rwsMaster.getHabCode() +"',"  
							+"02" 
							+ ","+ rwsMaster.getBrakish() +"','"
							+ finyr +"',"
							+"TO_DATE('"+ rwsMaster.getUpdateDate() + "','dd/mm/yyyy'))";
					Debug.println("Hab Component Query is(insert query) : \n"
							+ query);
					stmt.addBatch(query);
					
				}
				if (rwsMaster.getFlouride() != 0.0 )
				{
					Debug.println("INSERTING FLOURIDE CONTAMINATION DETAILS");
					query = "insert into RWS_HAB_CONTAMINATION_TBL values("
							+ "'" + rwsMaster.getHabCode() + "'," 
							+"01"+"," 
							+ rwsMaster.getFlouride() +"','"
							+ finyr +"',"
							+"TO_DATE('"+ rwsMaster.getUpdateDate() + "','dd/mm/yyyy'))";
					Debug.println("Hab Component Query is(insert query) : \n"
							+ query);
					stmt.addBatch(query);
					
				}
				if (rwsMaster.getIron() != 0.0)
				{
					Debug.println("INSERTING IRON CONTAMINATION DETAILS");
					query = "insert into RWS_HAB_CONTAMINATION_TBL values("
							+ "'" + rwsMaster.getHabCode() + "'," 
							+ "03" + "," 
							+ rwsMaster.getIron() +"','"
							+ finyr +"',"
							+"TO_DATE('"+ rwsMaster.getUpdateDate() + "','dd/mm/yyyy'))";
					Debug.println("Hab Component Query is(insert query) : \n"
							+ query);
					stmt.addBatch(query);
					
				}
			}	
		updateCounts = stmt.executeBatch();
		conn.commit();
	} catch (BatchUpdateException b) {
		System.err
				.println("Update counts of successful commands:updateHabStatus "
						+ b);
	} catch (Exception e) {
		Debug.println("The error in updateHabStatus " + e);
	} finally {
		closeAll();
	}
	return updateCounts;
}

public  int[] removeHabStatus(String habCode, DataSource dataSource)
throws Exception {   
int[] updateCounts = new int[3];
try {
conn = RwsOffices.getConn();
conn.setAutoCommit(false);
stmt = conn.createStatement();
stmt.addBatch("DELETE  FROM RWS_HAB_INSTITUTE_TBL WHERE HAB_CODE='"
		+ habCode + "'");
stmt.addBatch("DELETE  FROM RWS_HAB_COMPONENT_TBL WHERE HAB_CODE='"
		+ habCode + "'");
stmt
		.addBatch("DELETE  FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE='"
				+ habCode + "'");
updateCounts = stmt.executeBatch();
conn.commit();
} catch (Exception e) {
Debug.println("The error in removeHabStatus= " + e);
} finally {
closeAll();
}
return updateCounts;
}

public static  String format(String val)
{
	if(val==null||val.equals("null"))
		val="";
	return val;
}
public static  String format(int val)
{
	String rValue="";
	if(val==0)
		rValue="";
	else
		rValue=val+"";
	return rValue;
}
public static  String format(float val)
{
	String rValue="";
	if(val==0)
		rValue="";
	else
		rValue=val+"";
	return rValue;
}
public boolean getContaminationStatus(String contType,DataSource dataSource,String habCode)
{
	boolean status = false;
	ResultSet rrs = null;
	Statement rstmt = null;
	Connection conns = null; 
	try {
		conns=RwsOffices.getConn();
		Debug.println("got conn");
		rstmt = conns.createStatement();
		String query="select * from RWS_HAB_CONTAMINATION_TBL where hab_code='"+habCode+"' and cont_type='"+contType+"'";
		Debug.println("qry in getContaminationStatus:"+query);
		rrs=rstmt.executeQuery(query);
		Debug.println("1");
		if(rrs.next())
		{
			Debug.println("2");
			status = true;
		}
		Debug.println("3");
	} catch (Exception e) {
		Debug.println("The error in getContaminationStatus= " + e);
		} finally {
		try{
			if (rrs != null) {
				try {
					rrs.close();
				} catch (Exception e) {
					Debug.println("The error in rwsMasterData" + e);
				}
				rrs = null;
			}
			if (rstmt != null) {
				try {
					rstmt.close();
				} catch (Exception e) {
					Debug.println("The error in closeAll=" + e);
				}
				rstmt = null;
			}
			if (conns != null) {
				try {
					conns.close();
				} catch (Exception e) {
					Debug.println("The error in closeAll=" + e);
				}
				conns = null;
			}
		}catch(Exception e){}
		}
		return status;
}
public void deleteContHab(String contType,Statement stmt,String habCode)
{
	boolean status = false;
	try {
		//stmt = conn.createStatement();
		Debug.println("got stmt");
		String query="delete from RWS_HAB_CONTAMINATION_TBL where hab_code=? and cont_type=?";
		PreparedStatement ps = RwsOffices.getConn().prepareStatement(query);
		ps.setString(1,habCode);
		ps.setString(2,contType);	
		Debug.println("qry in deleteContHab:"+query);
		//stmt.addBatch(query);
		int returnval = stmt.executeUpdate();
		Debug.println("got stmt execute");
	} catch (Exception e) {
		Debug.println("The error in deleteContHab= " + e);
		} finally {
		try{//closeAll();
			}catch(Exception e){}
		}
}
public void deleteContHabEntire(Statement stmtt,String habCode)
{
	boolean status = false;
	try {
		//stmt = conn.createStatement();
		Debug.println("got stmt");
		String query="delete from RWS_HAB_CONTAMINATION_TBL where hab_code=?";
		PreparedStatement ps=conn.prepareStatement(query);
		ps.setString(1,habCode);
		Debug.println("qry in deleteContHabEntire:"+query);
		int returnval = ps.executeUpdate();
		Debug.println("got stmt exexute");
		
	} catch (Exception e) {
		Debug.println("The error in deleteContHabEntire= " + e);
		} finally {
		try{//closeAll();
			}catch(Exception e){}
		}
}
public void addContHab(String contType,Statement stmt,String habCode)
{
	boolean status = false;
	try {
		//stmt = conn.createStatement();
		Debug.println("got stmt");
		String query="insert into RWS_HAB_CONTAMINATION_TBL(hab_code,cont_type)values(?,?)";
		PreparedStatement ps = RwsOffices.getConn().prepareStatement(query);
		ps.setString(1,habCode);
		ps.setString(2,contType);
		Debug.println("qry in addContHab:"+query);
		int returnval = stmt.executeUpdate();
		//stmt.addBatch(query);
		Debug.println("got stmt execute");
		
	} catch (Exception e) {
		Debug.println("The error in addContHab= " + e);
		} finally {
		try{//closeAll();
		}catch(Exception e){}
		}
}
//Method added by sridhar for TSP/NTSP valyues  
public static int insertHabsData(String habcode,String tsp)throws Exception 
{
	int count = 0;
	String query = "";
	Connection conn=null;
	Statement stmt=null;          
	ResultSet rs=null; 
	try {
		//Debug.println("in insertData");
		conn=RwsOffices.getConn();
		stmt =conn.createStatement();
		
		//query = "update rws_work_admn_tbl set AUG_WORKID ='"+acode+"' where work_id='"+workid+"'";
		query= " update rws_habitation_directory_tbl set TSP_NTSP=? where HAB_CODE=? ";
		
		
		/*boolean comma=false;
		if(sc!=null && !sc.equals(""))
		{
			if(comma)query+=" ,";else query += " set ";
			query+=" NO_OF_SC_LOCALITY='"+sc+"' ";
			comma = true;
		}
		if(st!=null && !st.equals(""))
		{
			if(comma)query += " , "; else  query+=" set ";
		 query+="  NO_OF_ST_LOCALITY='"+st+"' ";comma = true;
		}
		if(mt!=null && !mt.equals(""))
		{
			if(comma)query += " , "; else query+=" set ";
			query+="  NO_OF_MIN_LOCALITY='"+mt+"' ";comma = true;
		}
		if(tsp!=null && !tsp.equals(""))
		{
			if(comma) query += " , "; else  query+=" set ";
		 query+="  TSP_NTSP='"+tsp.toUpperCase()+"' ";comma = true;
		}*/
		//query+= " where HAB_CODE='"+habcode+"' ";
		
		Debug.println("query in insertHabData:" + query);
		PreparedStatement ps = conn.prepareStatement(query);
		ps.setString(1, tsp.toUpperCase());
		ps.setString(2,habcode);
		count = stmt.executeUpdate();
		Debug.println("count in insertdata:"+count);  
        
	} catch (Exception e) {
		Debug.println("The error in insertHabData:" + e);
	} finally {
		//rs.close();
		stmt.close();
		conn.close();
	}

	return count;
}


//code for sc localities of  habitations added by sridhar
public static int insertScData(String habcode,String lccode,String lcname)throws Exception 
{
	int count = 0;
	String query = "",qry1="";
	Connection conn=null;
	Statement stmt=null,stmt1=null;          
	ResultSet rs=null,rs1=null; 
	try {
		conn=RwsOffices.getConn();
		stmt =conn.createStatement();
		stmt1 =conn.createStatement();
		qry1="select hab_code,locality_code,locality_name from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code='"+habcode+"' and locality_code='"+lccode+"' ";
		//Debug.println("qry1:"+qry1); 
		rs1=stmt1.executeQuery(qry1);
		if(!rs1.next()){
			Debug.println("in if");
		query=" insert into RWS_SC_ST_MIN_LOCALITY_TBL(hab_code,locality_code,locality_name)values(?,?,?)";
		PreparedStatement ps = conn.prepareStatement(query);
		ps.setString(1,habcode);
		ps.setString(2, lccode);
		ps.setString(3, lcname);
		}else{
			
			query=" update RWS_SC_ST_MIN_LOCALITY_TBL set locality_name=? where hab_code=? and locality_code=?";
			//Debug.println("aleredy this combination exist");
			//count=stmt.executeUpdate(query);
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,lcname);
			ps.setString(2, habcode);
			ps.setString(3, lccode);
		}
		Debug.println("query:"+query);
		count=ps.executeUpdate();
	}catch(Exception e)   
	{
		Debug.println("Exception in SC localties"+e);
	}
	
	return count;
	}

//code added by sridhar for Isert Habitation sc/st/mionrity status

public static int insertAssetData(String habcode,String astcode,String lccode,String popserved)throws Exception 
{
	int count = 0;
	String query = "";
	Connection conn=null;
	Statement stmt=null,stmt1=null;          
	ResultSet rs=null,rs1=null; 
	try {
		conn=RwsOffices.getConn();
		stmt =conn.createStatement();
		stmt1 =conn.createStatement();
		String qry="select hab_code,asset_code,locality_code,population_served from RWS_ASSET_LOCALITY_SERVE_TBL where hab_code='"+habcode+"' and asset_code='"+astcode+"' and locality_code='"+lccode+"'";
		Debug.println("qry:"+qry);
		rs1=stmt1.executeQuery(qry);
		if(!rs1.next()){
		query=" insert into RWS_ASSET_LOCALITY_SERVE_TBL (hab_code,asset_code,locality_code,population_served)values(?,?,?,?)";
		PreparedStatement ps = rwsMasterData.conn.prepareStatement(query);
		ps.setString(1,habcode);
		ps.setString(2, astcode);
		ps.setString(3, lccode);
		ps.setString(4,popserved);
		}else{
			query=" update RWS_ASSET_LOCALITY_SERVE_TBL set population_served=? where hab_code=? and asset_code=? and locality_code=?";	
			PreparedStatement ps = rwsMasterData.conn.prepareStatement(query);
			ps.setString(1,popserved);
			ps.setString(2, habcode);
			ps.setString(3, astcode);
			ps.setString(4,lccode);
		}
		Debug.println("query I/U:"+query);
		count=ps.executeUpdate();
	}catch(Exception e)
	{
		Debug.println("Exception in insertAsset data "+e);
	}
	
	return count;
	}
}