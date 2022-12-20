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

	public void closeAll() throws Exception {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs4 = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			conn = null;
		}

	}

	public int insertPanchayat(DataSource dataSource, String dcode, String mcode, String pcode, String pname)	throws Exception {
		String query = "";
		int rcount = 0;
		try {
			conn = RwsOffices.getConn();			
			query = "update rws_panchayat_tbl set pname=? where dcode=? and mcode=? and pcode=?";	
			ps = conn.prepareStatement(query);
			ps.setString(1, pname.toUpperCase());
			ps.setString(2, dcode);
			ps.setString(3, mcode);
			ps.setString(4, pcode);
			rcount = ps.executeUpdate();
		} catch (Exception e) {
			Debug.println("The Exception at insertPanchayat In RwsHabStatusData=" + e);
		} finally {
			closeAll();
		}
		return rcount;
	}

	public boolean insertHabContamination(DataSource dataSource, RwsMaster rwsMaster) throws Exception {

		String query = "";
		int rcount = 0;
		String habCode = rwsMaster.getHabCode();
		boolean insertedAll = true;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			boolean flourideConaminationDetailsExists = false;
			boolean brakishConaminationDetailsExists = false;
			boolean ironConaminationDetailsExists = false;
			boolean aresenicConaminationDetailsExists = false;
			boolean nitrateConaminationDetailsExists = false;

			query = "select * from rws_hab_contamination_tbl where hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			rs = ps.executeQuery();
			while (rs.next()) {
				if (rs.getString("CONT_TYPE").equals("01")) {
					flourideConaminationDetailsExists = true;
				} else if (rs.getString("CONT_TYPE").equals("02")) {
					brakishConaminationDetailsExists = true;
				} else if (rs.getString("CONT_TYPE").equals("03")) {
					ironConaminationDetailsExists = true;
				} else if (rs.getString("CONT_TYPE").equals("04")) {
					aresenicConaminationDetailsExists = true;
				} else if (rs.getString("CONT_TYPE").equals("05")) {
					nitrateConaminationDetailsExists = true;
				}
			}
			stmt=conn.createStatement();
			if (!flourideConaminationDetailsExists)
				query = "";
			else
				query = "update rws_hab_contamination_tbl " + "set   " + "cont_perc='"
						+ rwsMaster.getFlourideContamination() + "', status_date=to_date('" + rwsMaster.getStatusDate()
						+ "','dd/mm/yyyy') where hab_code='" + habCode + "' and cont_type='01'";

			if (!query.equals(""))
				stmt.addBatch(query);
			if (!brakishConaminationDetailsExists)
				query = "";
			else
				query = "update rws_hab_contamination_tbl " + "set   " + "cont_perc='"
						+ rwsMaster.getBrakishContamination() + "', status_date=to_date('" + rwsMaster.getStatusDate()
						+ "','dd/mm/yyyy') where hab_code='" + habCode + "'  and cont_type='02'";

			if (!query.equals(""))
				stmt.addBatch(query);

			if (!ironConaminationDetailsExists)
				query = "";
			else
				query = "update rws_hab_contamination_tbl " + "set  " + "cont_perc='" + rwsMaster.getIronContamination()
						+ "', status_date=to_date('" + rwsMaster.getStatusDate() + "','dd/mm/yyyy') where hab_code='"
						+ habCode + "'  and cont_type='03'";
			if (!query.equals(""))
				stmt.addBatch(query);

			if (!aresenicConaminationDetailsExists)
				query = "";
			else
				query = "update rws_hab_contamination_tbl " + "set  " + "cont_perc='"
						+ rwsMaster.getAresenicContamination() + "', status_date=to_date('" + rwsMaster.getStatusDate()
						+ "','dd/mm/yyyy') where hab_code='" + habCode + "'  and cont_type='04'";
			if (!query.equals(""))
				stmt.addBatch(query);

			if (!nitrateConaminationDetailsExists)
				query = "";
			else
				query = "update rws_hab_contamination_tbl " + "set  " + "cont_perc='"
						+ rwsMaster.getNitrateContamination() + "', status_date=to_date('" + rwsMaster.getStatusDate()
						+ "','dd/mm/yyyy') where hab_code='" + habCode + "'  and cont_type='05'";
			if (!query.equals(""))
				stmt.addBatch(query);			// end of code added
			int rcounts[] = stmt.executeBatch();
			for (int i = 0; i < rcounts.length; i++) {
				if (rcounts[0] == 0)
					insertedAll = false;
			}
			if (insertedAll)
				conn.commit();
		} catch (Exception e) {
			Debug.println("The Exception in insertHabContamination= RwsHabStatusData" + e);
			insertedAll = false;
		} finally {
			conn.setAutoCommit(true);
			closeAll();
		}
		return insertedAll;
	}
	public  int insertHabitation(DataSource dataSource,String habCode,String habName) throws Exception {   
		RwsMaster rwsMaster = null;		
		String query="";
		int rcount=0;
		try {	
			conn = RwsOffices.getConn();
			query = "update rws_panchayat_raj_tbl set panch_name= ? where panch_code= ? ";		
			ps = conn.prepareStatement(query);
			ps.setString(1, habName);
			ps.setString(2, habCode);
			rcount = ps.executeUpdate();		
		} catch (Exception e) {
			System.out.println("The Exception is in RwsHabStatusData insertHabitation : " + e.getMessage());
		} finally {
			closeAll();
		}
		return rcount;
	}

	
	public int insertVillage(DataSource dataSource, String dcode, String mcode, String pcode, String vcode,
			String vname) throws Exception {
		String query = "";
		int rcount = 0;
		try {
			conn = RwsOffices.getConn();			
			query = " update rws_village_tbl set vname=? where dcode=? and mcode=? and pcode=? and vcode=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, vname.toUpperCase());
			ps.setString(2, dcode);
			ps.setString(3, mcode);
			ps.setString(4, pcode);
			ps.setString(5, vcode);
			rcount = ps.executeUpdate();
		} catch (Exception e) {
			Debug.println("The Exception in insertVillage In RwsHabStatusData=" + e);
		} finally {
			closeAll();
		}
		return rcount;
	}

	public String deletePanchayat(DataSource dataSource, String dcode, String mcode, String pcode) throws Exception {
		RwsMaster rwsMaster = null;

		String query = "";
		String msg = "";
		int rcount = 0;
		boolean childRecordExists = false;

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " select * from rws_village_tbl where dcode='" + dcode + "' and mcode='" + mcode + "' and pcode='"
					+ pcode + "'";
			// Debug.println("query is "+query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				childRecordExists = true;
				msg = "Record Cannot be Deleted As Villages For This Code Exists";
			}
			if (!childRecordExists) {
				query = " delete  from rws_panchayat_tbl  where dcode='" + dcode + "' and mcode='" + mcode
						+ "' and pcode='" + pcode + "'";

				// end of code added
				// Debug.println("query is "+query);
				rcount = stmt.executeUpdate(query);
				if (rcount > 0)
					msg = "Record Deleted Successfully";
			}

		} catch (Exception e) {
			msg = "Record Cannot be Deleted";
			// Debug.println("The error in insertPanchayat=" + e);
		} finally {

			closeAll();
		}
		return msg;
	}

	public String deleteContaminationDetails(DataSource dataSource, String habCode) throws Exception {
		String query = "";
		String msg = "";
		int rcount = 0;
		try {
			conn = RwsOffices.getConn();
			query = " delete  from rws_hab_contamination_tbl  where hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			rcount = ps.executeUpdate();
			if (rcount > 0)
				msg = "Record Deleted Successfully";
			else
				msg = "Record Cannot be Deleted";

		} catch (Exception e) {
			msg = "Record Cannot be Deleted";
			Debug.println("The Exception in deleteContaminationDetails= RwsHabStatusData " + e);
		} finally {
			closeAll();
		}
		return msg;
	}

	public  int[] deleteHabitation(String habCode, DataSource dataSource) throws Exception {   
		int[] updateCounts=null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			String query="DELETE  FROM RWS_HAB_INSTITUTE_TBL WHERE HAB_CODE='"+ habCode + "'";
			stmt.addBatch(query);
			query="DELETE  FROM RWS_HAB_COMPONENT_TBL WHERE HAB_CODE='" + habCode + "'";
			stmt.addBatch(query);
			query="DELETE  FROM RWS_HAB_CONTAMINATION_TBL WHERE HAB_CODE='"+ habCode + "'";
			stmt.addBatch(query);
			query="DELETE  FROM RWS_HAB_SUPPLY_STATUS_TBL WHERE HAB_CODE='"+ habCode + "'";
			stmt.addBatch(query);
			query="DELETE  FROM RWS_PANCHAYAT_RAJ_TBL WHERE PANCH_CODE='"+ habCode + "'";
			stmt.addBatch(query);
			query="DELETE  FROM rws_habitation_dir_dyna_tbl WHERE HAB_CODE='"+ habCode + "'";
			stmt.addBatch(query);
			query="DELETE  FROM RWS_HABMAST_TBL WHERE PRHAB='"+ habCode + "'";
			stmt.addBatch(query);
			updateCounts = stmt.executeBatch();
			conn.commit();
		} catch (Exception e) {
			System.out.println("The Exception is in RwsHabStatusData deleteHabitation : " + e.getMessage());
		} finally {
			conn.setAutoCommit(true);
			closeAll();
		}
		return updateCounts;
	}

	public String deleteVillage(DataSource dataSource, String dcode, String mcode, String pcode, String vcode)
			throws Exception {
		RwsMaster rwsMaster = null;

		String query = "";
		String msg = "";
		int rcount = 0;

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			query = " delete  from rws_village_tbl  where dcode='" + dcode + "' and mcode='" + mcode + "' and pcode='"
					+ pcode + "' and vcode='" + vcode + "'";

			// end of code added
			// Debug.println("query is "+query);
			rcount = stmt.executeUpdate(query);
			if (rcount > 0)
				msg = "Record Deleted Successfully";
			else
				msg = "Record Cannot be deleted";

		} catch (Exception e) {
			msg = "Record Cannot be Deleted";
			Debug.println("The Exception in deleteVillage=" + e);
		} finally {

			closeAll();
		}
		return msg;
	}

	public String insertNewPanchayat(DataSource dataSource, String dcode, String mcode, String pcode, String pname)	throws Exception {
		String query = "";
		String msg = "";
		boolean codeAlreadyExists = false;
		int rcount = 0;
		try {
			conn = RwsOffices.getConn();
			query = " select * from rws_panchayat_tbl where dcode=? and mcode=? and pcode=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rs = ps.executeQuery();
			if(rs.next()) {
				msg = "Duplicate Code: Code Already  assigned to " + rs.getString("pname") + ". Try Again";
				codeAlreadyExists = true;
			}
			if (!codeAlreadyExists) {
				query = " insert into rws_panchayat_tbl(dcode,mcode,pcode,pname) values(?,?,?,?)";
				ps = conn.prepareStatement(query);
				ps.setString(1, dcode);
				ps.setString(2, mcode);
				ps.setString(3, pcode);
				ps.setString(4, pname);
				rcount = ps.executeUpdate();
				if (rcount > 0)
					msg = "Record Inserted Successfully";
				else
					msg = "Record Cannot be inserted";
			}
		} catch (Exception e) {
			Debug.println("The Exception in insertNewPanchayat = RwsHabStatusData" + e);
			msg = "Record Cannot be Inserted";
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
			query= " select * from rws_panchayat_raj_tbl where panch_code= ? ";
			ps = conn.prepareStatement(query);	
			ps.setString(1, habCode);
			rs = ps.executeQuery();
			while(rs.next()){
				msg="Duplicate Code: Code Already  assigned to "+rs.getString("panch_name")+". Try Again";
				codeAlreadyExists=true;
			}			
			if(!codeAlreadyExists){
				String dname="",conName="",mname="",pname="",vname="";
				query = "select d.dcode,d.dname,con.constituency_code," +
						" con.constituency_name,m.mcode,m.mname,p.pcode," +
						" p.pname,v.vcode,v.vname from rws_district_tbl d," +
						" rws_constituency_tbl con,rws_mandal_tbl m," +
						" rws_panchayat_tbl p,rws_village_tbl v " +
						" where d.dcode= ? and con.dcode=d.dcode " +
						" and con.constituency_code= ? and m.dcode=d.dcode " +
						" and m.mcode= ? and p.dcode=d.dcode and p.mcode=m.mcode " +
						" and p.pcode= ? and v.dcode=d.dcode and v.mcode=m.mcode" +
						" and v.pcode=p.pcode and v.vcode= ? ";
				ps = conn.prepareStatement(query);	
				ps.setString(1, dcode);
				ps.setString(2, acode);
				ps.setString(3, mcode);
				ps.setString(4, pcode);
				ps.setString(5, vcode);
				rs = ps.executeQuery();
				while(rs.next())
				{
					dname=rs.getString("dname");
					conName=rs.getString("constituency_name");
					mname=rs.getString("mname");
					pname=rs.getString("pname");
					vname=rs.getString("vname");
				}
				query = " insert into rws_habmast_tbl(dcode,acode,aname,mcode,pcode,pname,vcode,vname,hcode,hname,prc,hab_code,prhab) values('"+dcode+"','"+acode+"','"+conName+"','"+mcode+"','"+pcode+"','"+pname+"','"+vcode+"','"+vname+"','"+hcode+"','"+prHabName+"','"+prcode+"','"+habCode.substring(0,14)+"','"+habCode.substring(0,16)+"')";
				stmt.addBatch(query);
				
				query = " insert into rws_habitation_dir_dyna_tbl(CIRCLE_OFFICE_CODE,HAB_CODE) values('"+dcode+"','"+habCode+"')";
				stmt.addBatch(query);
				
				query = " insert into rws_habitation_directory_tbl(CIRCLE_OFFICE_CODE,HAB_CODE,COVERAGE_STATUS) values('"+dcode+"','"+habCode+"','NW')";
				stmt.addBatch(query); 
				
				query = " insert into rws_panchayat_raj_tbl(HAB_CODE,PANCH_CODE,PANCH_NAME) values('"+habCode.substring(0,14)+"','"+habCode+"','"+prHabName+"')";
			
				stmt.addBatch(query);
				rcounts=stmt.executeBatch();
			boolean inserted=true;
			for(int i=0;i<rcounts.length;i++){
				if(rcounts[i]==0)
					inserted=false;				
			}
			if(inserted){
				msg="Record Inserted Successfully";
				conn.commit();
			}
			else
				msg="Record Cannot be inserted";
			}
			conn.setAutoCommit(true);
	} catch (Exception e) {		
		System.out.println("The Exception is in RwsHabStatusData insertNewHabitation : " + e.getMessage());
		msg="Record Cannot be Inserted";		
	} finally {		
		closeAll();
	}
	return msg;
}

	public String insertNewVillage(DataSource dataSource, String dcode, String mcode, String pcode, String vcode,
			String vname) throws Exception {
		String query = "";
		String msg = "";
		boolean codeAlreadyExists = false;
		int rcount = 0;
		try {
			conn = RwsOffices.getConn();			
			query = " select * from rws_village_tbl where dcode=? and mcode=? and pcode=? and vcode=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			// Debug.println("query is "+query);
			rs = ps.executeQuery();
			while (rs.next()) {
				msg = "Duplicate Code: Code Already  assigned to " + rs.getString("vname") + ". Try Again";
				codeAlreadyExists = true;
			}
			if (!codeAlreadyExists) {
				query = " insert into rws_village_tbl(dcode,mcode,pcode,vcode,vname) values(?,?,?,?,?)";
				ps = conn.prepareStatement(query);
				ps.setString(1, dcode);
				ps.setString(2, mcode);
				ps.setString(3, pcode);
				ps.setString(4, vcode);
				ps.setString(5, vname.toUpperCase());			
				rcount = ps.executeUpdate();
				if (rcount > 0)
					msg = "Record Inserted Successfully";
				else
					msg = "Record Cannot be inserted";
			}

		} catch (Exception e) {
			Debug.println("The Exception in insertNewVillage In RwsHabStatusData" + e);
			msg = "Record Cannot be Inserted";
		} finally {

			closeAll();
		}
		return msg;
	}

	public ArrayList getPanchayatDetails(String dcode, String mcode, DataSource dataSource) throws Exception {
		RwsMaster rwsMaster = null;
		ArrayList panchayatDetails = new ArrayList();
		String query = "";
		try {
			conn = RwsOffices.getConn();
			query = " SELECT D.DCODE,D.DNAME,M.MCODE,M.MNAME,P.PCODE,P.PNAME FROM RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_PANCHAYAT_TBL P "
					+ " WHERE D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE=P.MCODE AND D.DCODE =? AND M.MCODE =? ORDER BY d.dcode,m.mcode,p.pcode ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rs = ps.executeQuery();
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
			Debug.println("The Exception at getPanchayatDetails In RwsHabStatusData" + e);
		} finally {
			closeAll();
		}
		return panchayatDetails;
	}

	public RwsMaster getHabContaminationDetails(DataSource dataSource, String habCode) throws Exception {
		RwsMaster rwsMaster = null;
		ArrayList contaminationDetails = new ArrayList();
		String query = "";

		try {
			conn = RwsOffices.getConn();
			
			query = "select HAB_CODE,CONT_TYPE,CONT_PERC,to_char(STATUS_DATE,'dd/mm/yyyy')as status_date,to_char(sysdate,'dd/mm/yyyy')as sys_date from rws_hab_contamination_tbl  where hab_code= ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			rs = ps.executeQuery();
			rwsMaster = new RwsMaster();
			rwsMaster.setContTypes1("N");
			rwsMaster.setContTypes2("N");
			rwsMaster.setContTypes3("N");
			rwsMaster.setContTypes4("N");
			rwsMaster.setContTypes5("N");

			while (rs.next()) {
				rwsMaster.setStatusDate(rs.getString("status_date"));
				if (rs.getString("CONT_TYPE").equals("01")) {
					rwsMaster.setFlourideContamination(rs.getString("CONT_PERC"));
					rwsMaster.setContTypes1("Y");
				} else if (rs.getString("CONT_TYPE").equals("02")) {
					rwsMaster.setBrakishContamination(rs.getString("CONT_PERC"));
					rwsMaster.setContTypes2("Y");
				} else if (rs.getString("CONT_TYPE").equals("03")) {
					rwsMaster.setIronContamination(rs.getString("CONT_PERC"));
					rwsMaster.setContTypes3("Y");
				} else if (rs.getString("CONT_TYPE").equals("04")) {
					rwsMaster.setAresenicContamination(rs.getString("CONT_PERC"));
					rwsMaster.setContTypes4("Y");
				} else if (rs.getString("CONT_TYPE").equals("05")) {
					rwsMaster.setNitrateContamination(rs.getString("CONT_PERC"));
					rwsMaster.setContTypes5("Y");
				}
				rwsMaster.setSysDate(rs.getString("sys_date"));
			}

		} catch (Exception e) {
			Debug.println("The Exception in getHabContaminationDetails= RwsHabStatusData" + e);
		} finally {

			closeAll();
		}
		return rwsMaster;
	}

	public  ArrayList getHabitationDetails(String dcode,String mcode,String mandalName,String constituencyCode,String constituencyName,String pcode,String pname,String vcode,String vname,DataSource dataSource) throws Exception {   
		RwsMaster rwsMaster = null;
		ArrayList habitaitonDetails = new ArrayList();
		String query="";
		if(!dcode.equals("")&&!mcode.equals("")&&pcode.equals("")){
			query="select p.pcode,p.pname,v.vcode,v.vname, " +
					"h.hab_code,h.hname,pr.panch_code,pr.panch_name" +
					" from rws_panchayat_tbl p,rws_village_tbl v," +
					"rws_habmast_tbl h," +
					"rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl hd where substr(h.hab_code,1,2)='"+dcode+"'" +
					"and substr(h.hab_code,6,2)='"+mcode+"' and " +
					"(p.dcode=substr(h.hab_code,1,2)and " +
					"p.mcode=substr(h.hab_code,6,2) and " +
					"p.pcode=substr(h.hab_code,13,2)) " +
					"and(v.dcode=substr(h.hab_code,1,2)and " +
					"v.mcode=substr(h.hab_code,6,2) and " +
					"v.pcode=substr(h.hab_code,13,2) and " +
					"v.vcode=substr(h.hab_code,8,3))and " +
					"(h.prhab=pr.panch_code) and pr.panch_code=hd.hab_code order by hd.hab_code";					
		}		
		else if(!dcode.equals("")&&!mcode.equals("")&&!pcode.equals("")&&vcode.equals("")){
			query="select v.vcode,v.vname,h.hab_code,h.hname," +
			"pr.panch_code,pr.panch_name from rws_village_tbl v," +
			" rws_habmast_tbl h,rws_panchayat_raj_tbl pr,rws_habitation_directory_Tbl hd " +
			" where substr(h.hab_code,1,2)='"+dcode+"'and " +
			"substr(h.hab_code,6,2)='"+mcode+"' and " +
			"substr(h.hab_code,13,2)='"+pcode+"'" +
			" and(v.dcode=substr(h.hab_code,1,2)" +
			" and v.mcode=substr(h.hab_code,6,2) " +
			" and v.pcode=substr(h.hab_code,13,2) " +
			" and v.vcode=substr(h.hab_code,8,3))" +
			" and (h.prhab=pr.panch_code) and  pr.panch_code=hd.hab_code";
		}
		else if(!dcode.equals("")&&!mcode.equals("")&&!pcode.equals("")&&!vcode.equals("")){
			query="select h.hab_code,h.hname,pr.panch_code," +
					"pr.panch_name from rws_habmast_tbl h,rws_habitation_directory_tbl hd," +
					"rws_panchayat_raj_tbl pr " +
					"where substr(h.hab_code,1,2)='"+dcode+"'" +
					"and substr(h.hab_code,6,2)='"+mcode+"' " +
					"and substr(h.hab_code,13,2)='"+pcode+"'" +
					" and substr(h.hab_Code,8,3)='"+vcode+"' " +
					"and (h.prhab=pr.panch_code) and pr.panch_code=hd.hab_code";  

		}
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();			
			rs = stmt.executeQuery(query);
			while (rs.next()) {
					rwsMaster = new RwsMaster();		
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
			System.out.println("The Exception is in RwsHabStatusData getHabitationDetails = " + e.getMessage());
		} finally {		
			closeAll();
		}
	return habitaitonDetails;
}

	public ArrayList getContaminationDetails(String dcode, DataSource dataSource) throws Exception {
		RwsMaster rwsMaster = null;
		ArrayList contaminationDetails = new ArrayList();
		String query = "";

		try {
			conn = RwsOffices.getConn();
			
			query = "select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,"
					+ "rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and "
					+ "m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and "
					+ "substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and "
					+ "hd.coverage_status is not null and hd.coverage_status =? and d.dcode=? order by d.dcode,m.mcode,p.pcode,v.vcode,h.panch_code";
			// Debug.println("getting nss habs:"+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, "NSS");
			ps.setString(2, dcode);
			rs = ps.executeQuery();
			String query1 = "";
			
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
				query1 = "select CONT_TYPE,CONT_PERC,to_char(status_date,'dd/mm/yyyy') as status_date from rws_hab_contamination_tbl where hab_code=?";
				ps=conn.prepareStatement(query1);
				ps.setString(1, rs.getString("panch_code"));
				rs1 = ps.executeQuery();
				while (rs1.next()) {
					if (rs1.getString(1).equals("01")) {
						rwsMaster.setFlourideContamination(rs1.getString(2));
					} else if (rs1.getString(1).equals("02")) {
						rwsMaster.setBrakishContamination(rs1.getString(2));
					} else if (rs1.getString(1).equals("03")) {
						rwsMaster.setIronContamination(rs1.getString(2));
					} else if (rs1.getString(1).equals("04")) {
						rwsMaster.setAresenicContamination(rs1.getString(2));
					} else if (rs1.getString(1).equals("05")) {
						rwsMaster.setNitrateContamination(rs1.getString(2));
					}
					rwsMaster.setStatusDate(rs1.getString(3));
				}
				contaminationDetails.add(rwsMaster);
			}

		} catch (Exception e) {
			Debug.println("The Exception in getContaminationDetails= RwsHabStatusData " + e);
		} finally {

			closeAll();
		}
		return contaminationDetails;
	}

	public ArrayList getVillageDetails(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		RwsMaster rwsMaster = null;
		ArrayList villageDetails = new ArrayList();
		String query = "";

		try {
			conn = RwsOffices.getConn();			
			query= " SELECT D.DCODE,D.DNAME,M.MCODE,M.MNAME,P.PCODE,P.PNAME,V.VCODE,V.VNAME FROM RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_PANCHAYAT_TBL P,RWS_VILLAGE_TBL V "
					+ " WHERE D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE=P.MCODE AND P.DCODE=V.DCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE  AND D.DCODE=? AND M.MCODE=? AND V.PCODE=?"
					+ " ORDER BY d.dcode,m.mcode,p.pcode,V.VCODE ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			// end of code added
			// Debug.println(query);
			rs = ps.executeQuery();
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
			Debug.println("The Exception at getVillageDetails In RwsHabStatusData=" + e);
		} finally {

			closeAll();
		}
		return villageDetails;
	}

	public ArrayList getHabStatuss(String coc, String doc, String sdoc, String dcode, String mcode, String pcode,
			String vcode, DataSource dataSource, String userId) throws Exception {
		RwsMaster rwsMaster = null;

		ArrayList habstatuss = new ArrayList();
		try {
			Statement st = null;
			String query2 = "";
			conn = RwsOffices.getConn();
			
			String query = "", query1 = "";
			if ((coc != null && !coc.equals("")) && (dcode != null && !dcode.equals(""))
					&& (mcode != null && !mcode.equals(""))) {
				if (userId.equals("admin") || userId.equals("100000"))
					query = "select distinct hd.*,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_dir_dyna_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status <> 'UI' and d.dcode=?"
							+ "  and m.mcode=?";
				else
					query = "select distinct hd.*,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_dir_dyna_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status <> 'UI' and d.dcode=?"
							+ "  and m.mcode=?";
				
				
				query1 = "select distinct hd.*,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_dir_dyna_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hd.coverage_status is null and d.dcode='"
						+ dcode + "'  and m.mcode='" + mcode + "'";
			}
			if ((pcode != null && !pcode.equals(""))) {
				query += " and p.pcode='" + pcode + "'";
				query1 += " and p.pcode='" + pcode + "'";
			}
			if ((vcode != null && !vcode.equals(""))) {
				query += " v.vcode='" + vcode + "'";
				query1 += " v.vcode='" + vcode + "'";
			}
			query1 += " order by dname,mname,pname,vname,panch_name";
			query += " union " + query1;
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rs = ps.executeQuery();
			while (rs.next()) {
				rwsMaster = new RwsMaster();
				query2 = "select * from rws_panchayat_raj_tbl where panch_code=?";
				ps = conn.prepareStatement(query2);
				ps.setString(1,  rs.getString("panch_code") );
				rs2 = ps.executeQuery();
				while (rs2.next()) {
					rwsMaster.setLatitude(rs2.getString("latitude"));
					rwsMaster.setLongitude(rs2.getString("longitude"));
					rwsMaster.setElevation(rs2.getString("elevation"));
					rwsMaster.setWaypoint(rs2.getString("way_point"));
					rwsMaster.setLandmark(rs2.getString("landmark"));
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
				rwsMaster.setTotalPop(rs.getInt(6) + rs.getInt(7) + rs.getInt(8));
				rwsMaster.setFloatPop(rs.getInt(9));
				rwsMaster.setNetPop(rs.getInt(6) + rs.getInt(7) + rs.getInt(8) + rs.getInt(9));
				rwsMaster.setFloatReason(rs.getString(10));
				if (rs.getDate(11) != null) {
					rwsMaster.setHabYear(df.format(rs.getDate(11)));
				}
				rwsMaster.setPopCovered(rs.getInt(12));
				rwsMaster.setScCovered(rs.getInt(13));
				rwsMaster.setStCovered(rs.getInt(14));
				rwsMaster.setMinorityCovered(rs.getInt("MINORITY_POP_COVERED"));
				rwsMaster.setTotalCovered(rs.getInt(12) + rs.getInt(13) + rs.getInt(14) + rs.getInt("MINORITY_POP_COVERED"));
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
			Debug.println("Exception at  getHabStatuss in RwsHabStatusData :  " + e);
		} finally {
			closeAll();
		}
		return habstatuss;
	}

	public String getHabName(String habCode, Connection conn) throws Exception {

		String name = null;
		Statement stmt1 = null;
		ResultSet rs1 = null;
		try {
			stmt1 = conn.createStatement();
			rs1 = stmt1
					.executeQuery("SELECT PANCH_NAME FROM rws_panchayat_raj_tbl WHERE panch_code ='" + habCode + "'");
			while (rs1.next()) {
				name = rs1.getString(1);

			}
		} catch (Exception e) {
			Debug.println("The Exception in getHabName=" + e);
		} finally {
			stmt1.close();
			rs1.close();
		}
		return name;
	}

	public String getDistName(DataSource dataSource, String dcode) throws Exception {
		String distname = "";

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select DNAME from rws_district_tbl where DCODE='" + dcode + "'");
			if (rs.next())
				distname = rs.getString(1);
		}

		catch (Exception e) {
			Debug.println("The Exception in getDistName=" + e);
		} finally {
			closeAll();
		}

		return distname;
	}

	public RwsMaster getHabSupplyStatus(String habCode, DataSource dataSource) throws Exception {
		RwsMaster rwsMaster = null;
		HabInstitute habInstitute = null;
		ContaminationTypes contaminationTypes = null;
		HabWaterSupply habWS = null;
		ArrayList institutes = new ArrayList();
		ArrayList waterSupply = new ArrayList();
		ArrayList contaminations = new ArrayList();
		
		int pwsCount = 0;
		int mpwsCount = 0;
		int cpwsCount = 0;
		int shpCount = 0;
		int hpCount = 0;
		int pondsCount = 0;
		int openwellCount = 0;
		int totOthersSupply = 0;
		int totOthersNo = 0;
		int shCount = 0;
		String habcode = null;
		PreparedStatement stmtpanch = null;
		ResultSet rspanch = null;
		String panchquery = "";
		try {
			conn = RwsOffices.getConn();
			String query = "select ";

			query +=  "(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s"
					+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '6%'"
					+ " and substr(s.scheme_code,1,16)=?)as pwsCount,";

			query += "(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s"
					+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '4%'"
					+ " and substr(s.scheme_code,1,16)=?)as mpwsCount,";

			query+= "(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_HP_SUBCOMP_PARAM_TBL h"
					+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '0%'"
					+ " and h.asset_code=a.asset_code and substr(s.scheme_code,1,16)=?)as hpCount,";

			query += " (select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_SHALLOWHANDPUMPS_TBL subcompTbl "
					+ "where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '3%'"
					+ " and substr(s.scheme_code,1,16)=? and subcompTbl.asset_code=a.asset_code)as shpCount,";

			query += "(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s, RWS_OPEN_WELL_MAST_TBL subcompTbl"
					+ " where a.asset_code=subcompTbl.asset_code and a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '2%'"
					+ " and substr(s.scheme_code,1,16)=?)as openWellCount,";

			query += "(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_OPENWELL_POND_TBL SUBCOMPTBL"
					+ " where a.asset_code=subcompTbl.asset_code and a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '7%'"
					+ " and substr(s.scheme_code,1,16)=?)as pondsCount,";

			query += "(select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s"
					+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '8%'"
					+ " and substr(s.scheme_code,1,16)=?)as cpwsCount,";

			query += "(SELECT count(*) from RWS_SHALLOWHANDPUMPS_TBL   p,rws_habitation_dir_dyna_tbl h,   RWS_ASSET_MAST_TBL A, rws_asset_scheme_tbl S "
					+ "where a.asset_code=s.asset_code and a.asset_code=p.asset_code and  h.hab_code=p.hab_code AND substr(s.scheme_code,1,16) = ?) as shpump";

			query += " from dual";
			
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			ps.setString(2, habCode);
			ps.setString(3, habCode);
			ps.setString(4, habCode);
			ps.setString(5, habCode);
			ps.setString(6, habCode);
			ps.setString(7, habCode);
			ps.setString(8, habCode);
			rs2=ps.executeQuery();
			if (rs2 != null && rs2.next()) {
				pwsCount = rs2.getInt("pwsCount");
				mpwsCount = rs2.getInt("mpwsCount");
				hpCount = rs2.getInt("hpCount");
				shpCount = rs2.getInt("shpCount");
				openwellCount = rs2.getInt("openWellCount");
				pondsCount = rs2.getInt("pondsCount");
				cpwsCount = rs2.getInt("cpwsCount");
				shCount = rs2.getInt("shpump");
			}
		
			query = "SELECT * FROM RWS_HABITATION_DIR_DYNA_TBL WHERE HAB_CODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			rs = ps.executeQuery();
			int netPop = 0;
			double presentEstimatedpop = 0;
			int csyear = 0;
			if (rs.next()) {
				rwsMaster = new RwsMaster();
				habcode = rs.getString(4);
				try {
					rwsMaster.setCoc(rs.getString(1));
					rwsMaster.setDoc(rs.getString(2));
					rwsMaster.setSdoc(rs.getString(3));
					rwsMaster.setCon(getCircleOfficeName("1", rs.getString(1), conn));
				} catch (Exception e) {
					Debug.println("Exception in getting coc or doc or sdoc is " + e);
				}
				rwsMaster.setDcode(habcode.substring(0, 2));
				rwsMaster.setDistrict(getDistrictName(habcode.substring(0, 2), conn));
				rwsMaster.setMandal(habcode.substring(5, 7));
				rwsMaster.setMandalName(getMandalName(habcode.substring(0, 2), habcode.substring(5, 7), conn));
				rwsMaster.setPCode(habcode.substring(12, 14));
				rwsMaster.setVCode(habcode.substring(7, 10));
				rwsMaster.setPName(getPanchayatName(habcode.substring(0, 2), habcode.substring(5, 7),
						habcode.substring(12, 14), conn));
				rwsMaster.setVName(getVillageName(habcode.substring(0, 2), habcode.substring(5, 7),
						habcode.substring(12, 14), habcode.substring(7, 10), conn));
				rwsMaster.setHabCode(format(rs.getString(4)));
				rwsMaster.setHabName(format(getHabName(rs.getString(4), conn)));
				rwsMaster.setCensusYear(format(rs.getString(5)));
				try {
					csyear = rs.getInt(5);
					rwsMaster.setActTotPop(rs.getInt("ACT_TOT_POPU"));
					rwsMaster.setActPlainPop(rs.getInt("ACT_PLAIN_POPU"));
					rwsMaster.setActScPop(rs.getInt("ACT_SC_POPU"));
					rwsMaster.setActStPop(rs.getInt("ACT_ST_POPU"));
					//
					rwsMaster.setActHouseHold(rs.getInt("ACT_HOUSE_HOLD"));
					rwsMaster.setActHouseConn(rs.getInt("ACT_HOUSE_CONN"));
					rwsMaster.setCensusPop(rs.getInt(6));
					rwsMaster.setCensusSc(rs.getInt(7));
					rwsMaster.setCensusSt(rs.getInt(8));
					rwsMaster.setCensusMinority(rs.getInt("CENSUS_MINORITY_POPU"));
					rwsMaster.setTotalPop(
							rs.getInt(6) + rs.getInt(7) + rs.getInt(8) + rs.getInt("CENSUS_MINORITY_POPU"));
					rwsMaster.setFloatPop(rs.getInt(9));
					netPop = rs.getInt(6) + rs.getInt(7) + rs.getInt(8) + rs.getInt(9)
							+ rs.getInt("CENSUS_MINORITY_POPU");
					rwsMaster.setNetPop(netPop);
				} catch (Exception e) {
					Debug.println("Exception in getting population details " + e);
				}
				rwsMaster.setFloatReason(rs.getString(10));
				rwsMaster.setHabYear(df.format(rs.getDate(11)));
				rwsMaster.setPopCovered(rs.getInt(12));
				rwsMaster.setScCovered(rs.getInt(13));
				rwsMaster.setStCovered(rs.getInt(14));
				rwsMaster.setMinorityCovered(rs.getInt("MINORITY_POP_COVERED"));
				rwsMaster.setTotalCovered(
						rs.getInt(12) + rs.getInt(13) + rs.getInt(14) + rs.getInt("MINORITY_POP_COVERED"));
				rwsMaster.setTotalWaterSupply(rs.getInt(15));
				rwsMaster.setExistWaterLevel(rs.getInt(16));
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
				rwsMaster.setPrevYrStatus(format(rs.getString("PREVIOUS_YR_STATUS")));
				rwsMaster.setPresentvYrStatus(rs.getString("COVERAGE_STATUS"));
				rwsMaster.setProposedFcYr(rs.getString(25));
				rwsMaster.setProposedFCAmt(rs.getFloat(26));
				rwsMaster.setHabType(rs.getString("HABITATION_TYPE"));
				rwsMaster.setHabSubType(rs.getString("HABITATION_SUB_TYPE"));
				rwsMaster.setHouseHold(rs.getInt("HOUSEHOLD_NO"));
				rwsMaster.setHouseConn(rs.getInt("NO_OF_HOUSECONN_GIVEN"));
				rwsMaster.setPlainHCon(rs.getInt("con_plain"));
				rwsMaster.setScHCon(rs.getInt("con_sc"));
				rwsMaster.setStHCon(rs.getInt("con_st"));
				rwsMaster.setPlainHHold(rs.getInt("Households_plain"));
				rwsMaster.setScHHold(rs.getInt("Households_sc"));
				rwsMaster.setStHHold(rs.getInt("Households_st"));
				rwsMaster.setMinorityHHold(rs.getInt("HOUSEHOLDS_MINORITY"));
				rwsMaster.setMinorityHCon(rs.getInt("CON_MINORITY"));

				rwsMaster.setHabCat(rs.getString("HABITATION_CATEGORY"));
				rwsMaster.setExistSource(rs.getInt("EXISTING_SOURCES_NO"));
				rwsMaster.setSafeSource(rs.getInt("SAFE_SOURCES_NO"));

				rwsMaster.setPublicTap(rs.getInt("NO_OF_PUBLIC_TAPS"));
				rwsMaster.setPublicStandpost(rs.getInt("NO_OF_TAPS_WITH_STANDPOSTS"));

				rwsMaster.setExistCheckDams(rs.getInt("NO_CHECKDAMS_EXIST"));
				rwsMaster.setReqCheckDams(rs.getInt("NO_CHECKDAMS_REQ"));

				rwsMaster.setCattles(rs.getInt("NO_OF_CATTLE"));
				if (rs.getString("MINORITY_DOMINATED") != null && rs.getString("MINORITY_DOMINATED").equals("Y"))
					rwsMaster.setIsMinorityHab("on");
				if (rs.getString("LWE") != null && rs.getString("LWE").equals("Y"))
					rwsMaster.setIsLwe("on");
				if (rs.getString("IS_ITDA") != null && rs.getString("IS_ITDA").equals("Y"))
					rwsMaster.setIsItda("on");
				rwsMaster.setLevelOfWaterSupply(rs.getString("EXIST_WATER_LEVEL"));
				rwsMaster.setLevelOfWaterSupplySafeOnly(rs.getString("SAFE_LPCD"));
				rwsMaster.setUnsafeLpcd(rs.getString("UNSAFE_LPCD"));
				rwsMaster.setGlsrno(rs.getInt("GLSR_NO"));
				rwsMaster.setGlsrqty(rs.getInt("GLSR_QTY"));
				rwsMaster.setOhsrno(rs.getInt("OHSR_NO"));
				rwsMaster.setOhsrqty(rs.getInt("OHSR_QTY"));

				rwsMaster.setSchemesource(rs.getString("SCHEMESOURCE"));
				
				panchquery = "SELECT * FROM RWS_PANCHAYAT_RAJ_TBL WHERE panch_CODE=?";
				stmtpanch = conn.prepareStatement(panchquery);
				stmtpanch.setString(1, habCode);
				rspanch = stmtpanch.executeQuery();
				while (rspanch.next()) {
					rwsMaster.setLatitude(rspanch.getString(4));
					rwsMaster.setLongitude(rspanch.getString(5));
					rwsMaster.setElevation(rspanch.getString(6));
					rwsMaster.setWaypoint(rspanch.getString(7));
					rwsMaster.setLandmark(rspanch.getString(8));
				}
				query = "select a.inst_code,a.inst_name," + "b.p_inst_no,b.p_inst_covered,"
						+ "b.P_INST_WORKING ,b.P_INST_NOTWORKING_NO "
						+ "from rws_public_institute_tbl a,rws_hab_institute_tbl b " + "where b.hab_code=? and a.inst_code=b.p_inst_code " + "union select pi.inst_code,pi.inst_name,"
						+ "'' as P_INST_NO,'' as P_INST_COVERED , to_number('') as P_INST_WORKING ,"
						+ "to_number('') as P_INST_NOTWORKING_NO  " + "from rws_public_institute_tbl pi where "
						+ "inst_code not in(select p_inst_code from rws_hab_institute_tbl " + "where hab_code=?)";
				ps = conn.prepareStatement(query);
				ps.setString(1, habCode);
				ps.setString(2, habCode);
				
				rs1 = ps.executeQuery();
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
				rwsMaster.setHabInsts(institutes);
				
				String q = null;
				q = " SELECT NVL(shp_dk_supply,0)as shp_dk_supply, NVL(shp_no,0)as shp_no, cisterns_dk_supply, cisterns_no, glsrs_dk_supply, glsrs_no,"
						+ " ohsrs_dk_supply, ohsrs_no, "
						+ "(NVL(shp_dk_supply,0) "
						+ " + NVL(cisterns_dk_supply,0) + NVL(glsrs_dk_supply,0) + NVL(ohsrs_dk_supply,0))as tot_dk_supply, "
						+ " ( NVL(shp_no,0) + NVL(cisterns_no,0) + NVL(glsrs_no,0) + NVL(ohsrs_no,0) ), "
						+ " NVL(hps_oth_supply,0)as hps_oth_supply, NVL(hps_no,0)hps_no, ows_oth_supply, NVL(ows_no,0)ows_no, NVL(ponds_oth_supply,0)ponds_oth_supply,"
						+ "NVL(ponds_no,0)ponds_no, shwell_oth_supply, shwell_no, "
						+ "(NVL(hps_oth_supply,0) + NVL(ows_oth_supply,0) + NVL(ponds_oth_supply,0)  "
						+ " + NVL(shwell_oth_supply,0))as tot_oth_supply, "
						+ "(NVL(hps_no,0) + NVL(ows_no,0) + NVL(ponds_no,0) + NVL(shwell_no,0)), "
						+ " pcpd_drink, pcpd_others, " + " (NVL(pcpd_drink,0) +NVL(pcpd_others,0)), stat_of_hab, "
						+ "NVL(PWS_NO,0)pws_no,NVL(PWS_SUPPLY,0)pws_supply,NVL(MPWS_NO,0)mpws_no,NVL(MPWS_SUPPLY,0)mpws_supply,"
						+ "NVL(CPWS_NO,0)as cpws_no,NVL(CPWS_SUPPLY,0)as cpws_supply,NVL(HPS_NO_UNSAFE,0)as HPS_NO_UNSAFE,"
						+ "NVL(HPS_OTH_SUPPLY_UNSAFE,0)as HPS_OTH_SUPPLY_UNSAFE,NVL(DW_TANKS_NO,0)as dw_tanks_no,"
						+ "NVL(DW_TANKS_SUPPLY,0)dw_tanks_supply,NVL(CATTLE_NO,0)as cattle_no,NVL(CATTLE_SUPPLY,0)as cattle_supply"
						+ ",nvl(others_no,0)as others_no,nvl(others_supply,0)as others_supply,nvl(others_no_safe,0)as others_no_safe,nvl(others_supply_safe,0)as others_supply_safe,"
						+ "nvl(PWS_UNSAFE_NO ,0)as PWS_UNSAFE_NO ,nvl(PWS_UNSAFE_SUPPLY ,0)as PWS_UNSAFE_SUPPLY,"
						+ "nvl(MPWS_UNSAFE_NO ,0)as MPWS_UNSAFE_NO ,nvl(MPWS_UNSAFE_SUPPLY ,0)as MPWS_UNSAFE_SUPPLY,"
						+ "nvl(SHP_NO_SAFE ,0)as SHP_NO_SAFE,nvl(SHP_DK_SUPPLY_SAFE,0)as SHP_DK_SUPPLY_SAFE,"
						+ "nvl(CPWS_HAB_SUPPLY,0)+nvl(PWS_HAB_SUPPLY,0)+nvl(MPWS_HAB_SUPPLY,0)+nvl(DP_HAB_SUPPLY,0) as linkHabSupply FROM "
						+ "rws_hab_supply_status_tbl WHERE hab_code=?";
				ps = conn.prepareStatement(q);
				ps.setString(1, habCode);
				rs3 = ps.executeQuery();
				while (rs3.next()) {
					habWS = new HabWaterSupply();
					rwsMaster.setLinkageHabSupply(rs3.getString("linkHabSupply"));
					rwsMaster.setShpSupply(rs3.getString("shp_dk_supply"));
					rwsMaster.setShpNo(rs3.getString("shp_no"));
					rwsMaster.setCisternsSupply(rs3.getString("cisterns_dk_supply"));
					rwsMaster.setCisternsNo(rs3.getString("cisterns_no"));
					rwsMaster.setGlsrSupply(rs3.getString("glsrs_dk_supply"));
					rwsMaster.setGlsrNo(rs3.getString("glsrs_no"));
					rwsMaster.setOhsrSupply(rs3.getString("ohsrs_dk_supply"));
					rwsMaster.setOhsrNo(rs3.getString("ohsrs_no"));
					double drinkTotalSupply = rs3.getDouble("tot_dk_supply");
					rwsMaster.setOthersSupply(rs3.getString("others_supply"));
					rwsMaster.setOthersNo(rs3.getString("others_no"));
					rwsMaster.setOthersSafeeNo(rs3.getString("OTHERS_NO_SAFE"));
					rwsMaster.setOthersSafeSupply(rs3.getString("OTHERS_SUPPLY_SAFE"));
					rwsMaster.setPwsUnsafeNo(rs3.getString("PWS_UNSAFE_NO"));
					rwsMaster.setPwsUnsafeSupply(rs3.getString("PWS_UNSAFE_SUPPLY"));
					rwsMaster.setMpwsUnsafeNo(rs3.getString("MPWS_UNSAFE_NO"));
					rwsMaster.setMpwsUnsafeSupply(rs3.getString("MPWS_UNSAFE_SUPPLY"));
					rwsMaster.setDrinkTotalSupply(String.valueOf(drinkTotalSupply));
					rwsMaster.setDrinkTotalNo(rs3.getString(10));
					rwsMaster.setHpSupply(rs3.getString("hps_oth_supply"));
					rwsMaster.setHpNo(rs3.getString("hps_no"));

					rwsMaster.setOwsSupply(rs3.getString("ows_oth_supply"));
					rwsMaster.setOwsNo(rs3.getString("ows_no"));
					rwsMaster.setPondsSupply(rs3.getString("ponds_oth_supply"));
					rwsMaster.setPondsNo(rs3.getString("ponds_no"));

					rwsMaster.setShwSupply(rs3.getString("shwell_oth_supply"));
					rwsMaster.setShwNo(rs3.getString("shwell_no"));
					double otherTotalSupply = rs3.getDouble("tot_oth_supply");
					rwsMaster.setOtherTotalSupply(String.valueOf(otherTotalSupply));
					rwsMaster.setOtherTotalNo(rs3.getString(20));

					rwsMaster.setPcpdDrink(rs3.getString(21));
					rwsMaster.setPcpdOthers(rs3.getString(22));
					rwsMaster.setPcpdTotal(rs3.getString(23));
					rwsMaster.setStatus(rs3.getString(24));
					rwsMaster.setPwsNo(rs3.getString("pws_no"));
					rwsMaster.setPwsSupply(rs3.getString("pws_supply"));
					rwsMaster.setMpwsNo(rs3.getString("mpws_no"));
					rwsMaster.setMpwsSupply(rs3.getString("mpws_supply"));
					rwsMaster.setCpwsNo(rs3.getString("cpws_no"));
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

					double totalWaterSupply = rs3.getInt("hps_oth_supply") + rs3.getInt("pws_supply")
							+ rs3.getInt("mpws_supply") + rs3.getInt("cpws_supply") + rs3.getInt("ows_oth_supply")
							+ rs3.getInt("ponds_oth_supply") + rs3.getInt("shp_dk_supply") + rs3.getInt("others_supply")
							+ rs3.getInt("HPS_OTH_SUPPLY_UNSAFE") + rs3.getInt("SHP_DK_SUPPLY_SAFE");
					double totalWaterSupplySafe = rs3.getInt("hps_oth_supply") + rs3.getInt("pws_supply")
							+ rs3.getInt("mpws_supply") + rs3.getInt("cpws_supply") + rs3.getInt("OTHERS_SUPPLY_SAFE")
							+ rs3.getInt("SHP_DK_SUPPLY_SAFE");
					double totalWaterSupplyUnsafe = rs3.getInt("ows_oth_supply") + rs3.getInt("ponds_oth_supply")
							+ rs3.getInt("shp_dk_supply") + rs3.getInt("others_supply")
							+ rs3.getInt("HPS_OTH_SUPPLY_UNSAFE") + rs3.getInt("PWS_UNSAFE_SUPPLY")
							+ rs3.getInt("MPWS_UNSAFE_SUPPLY");


					rwsMaster.setTotalWaterSupply((int) (totalWaterSupply));
					rwsMaster.setTotalWaterSupplySafe((int) (totalWaterSupplySafe));
					rwsMaster.setTotalWaterSupplyUnsafe((int) (totalWaterSupplyUnsafe));
					Calendar rightNow = Calendar.getInstance();
					int year = rightNow.get(Calendar.YEAR);
					presentEstimatedpop = Double.parseDouble("" + netPop);
					presentEstimatedpop = presentEstimatedpop
							* Math.pow(1.02, Double.parseDouble("" + (year - csyear)));

					rwsMaster.setLevelOfWaterSupply(String.valueOf(totalWaterSupplySafe / presentEstimatedpop));
					rwsMaster.setLpcdCooking(rs.getString("LPCD_COOKING"));
					waterSupply.add(rwsMaster);
				}
				rwsMaster.setHabWaterSupply(waterSupply);
				query = " SELECT NVL(cont_type,''), NVL(cont_perc,0.0) " + " FROM rws_hab_contamination_tbl"						
						+ " WHERE hab_code =?";
				ps = conn.prepareStatement(query);
				ps.setString(1, habCode);
				rs3 = ps.executeQuery();
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
					if (rs3.getString(1).equals("01")) {
						rwsMaster.setFlouride(Double.parseDouble(rs3.getString(2)));
						rwsMaster.setContTypes1("1");
					} else if (rs3.getString(1).equals("02")) {
						rwsMaster.setBrakish(Double.parseDouble(rs3.getString(2)));
						rwsMaster.setContTypes2("2");
					} else if (rs3.getString(1).equals("03")) {
						rwsMaster.setIron(Double.parseDouble(rs3.getString(2)));
						rwsMaster.setContTypes3("3");
					} else if (rs3.getString(1).equals("04")) {
						rwsMaster.setAresenic(Double.parseDouble(rs3.getString(2)));
						rwsMaster.setContTypes4("4");
					} else if (rs3.getString(1).equals("05")) {
						rwsMaster.setNitrate(Double.parseDouble(rs3.getString(2)));
						rwsMaster.setContTypes5("5");
					}
				}
				rwsMaster.setContaminations(contaminations);
			}
		} catch (Exception e) {
			Debug.println("The exception in getHabSupplyStatus = " + e);
		//	e.printStackTrace();
		} finally {
			closeAll();
		}
		return rwsMaster;
	}

	public String getCircleOfficeName(String hoc, String coc, Connection conn) throws Exception {
		String name = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			stmt1 = conn.prepareStatement("SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE HEAD_OFFICE_CODE=? and CIRCLE_OFFICE_CODE=?");
			stmt1.setString(1, hoc);
			stmt1.setString(2, coc);
			rs1 = stmt1.executeQuery();
			rs1.next();
			name = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Exception at getCircleOfficeName in RwsHabStatus : " + e);
		} finally {
			if (stmt1 != null)
				stmt1.close();
			if (rs1 != null)
				rs1.close();
		}
		return name;
	}

	public String getDivisionOfficeName(String hoc, String coc, String doc, Connection conn) throws Exception {

		String name = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			if (doc != null || !(doc.equals("0"))) {
				stmt1 = conn.prepareStatement("SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE=?"
						+ " and CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=?");
				stmt1.setString(1, hoc);
				stmt1.setString(2, coc);
				stmt1.setString(3, doc);
				rs1 = stmt1.executeQuery();
				rs1.next();
				name = rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Exception at getDivisionOfficeName in RwsHabStatus : " + e);
		} finally {
			if (stmt1 != null)
				stmt1.close();
			if (rs1 != null)
				rs1.close();
		}
		return name;
	}

	public String getSubDivisionOfficeName(String hoc, String coc, String doc, String sdoc, Connection conn)
			throws Exception {
		String name = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			if (doc != null || !(doc.equals("0"))) {
				stmt1 = conn.prepareStatement("SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE=?"
						+ " and CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=? and SUBDIVISION_OFFICE_CODE=?");
				stmt1.setString(1, hoc);
				stmt1.setString(2, coc);
				stmt1.setString(3, doc);
				stmt1.setString(4, sdoc);
				rs1 = stmt1.executeQuery();
				rs1.next();
				name = rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Exception at getSubDivisionOfficeName in RwsHabStatus : " + e);
		} finally {
			if (stmt1 != null)
				stmt1.close();
			if (rs1 != null)
				rs1.close();
		}
		return name;
	}

	public String getDistrictName(String dcode, Connection conn) throws Exception {
		String name = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			stmt1 = conn.prepareStatement("SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE=?");
			stmt1.setString(1, dcode);
			rs1 = stmt1.executeQuery();
			rs1.next();
			name = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Exception at getDistrictName in RwsHabStatusData : " + e);
		} finally {
			if (stmt1 != null)
				stmt1.close();
			if (rs1 != null)
				rs1.close();
		}
		return name;
	}

	public String getMandalName(String dcode, String mcode, Connection conn) throws Exception {
		String name = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			stmt1 = conn.prepareStatement("select MNAME from RWS_MANDAL_TBL where DCODE=? and mcode=?");
			stmt1.setString(1, dcode);
			stmt1.setString(2, mcode);
			rs1 = stmt1.executeQuery();
			rs1.next();
			name = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Exception at getMandalName in RwsHabStatusData : " + e);
		} finally {
			if (stmt1 != null)
				stmt1.close();
			if (rs1 != null)
				rs1.close();
		}
		return name;
	}

	public String getPanchayatName(String dcode, String mcode, String pcode, Connection conn) throws Exception {
		String name = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			stmt1 = conn.prepareStatement("select PNAME from RWS_PANCHAYAT_TBL where DCODE=? and mcode=? and PCODE=?");
			stmt1.setString(1, dcode);
			stmt1.setString(2, mcode);
			stmt1.setString(3, pcode);
			rs1 = stmt1.executeQuery();
			rs1.next();
			name = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Exception at getPanchayatName in RwsHabStatusData : " + e);
		} finally {
			if (stmt1 != null)
				stmt1.close();
			if (rs1 != null)
				rs1.close();
		}
		return name;
	}

	public String getVillageName(String dcode, String mcode, String pcode, String vcode, Connection conn)
			throws Exception {
		String name = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			stmt1 = conn.prepareStatement("select VNAME from RWS_VILLAGE_TBL where DCODE=? and mcode=? and PCODE=? and vcode=?");
			stmt1.setString(1, dcode);
			stmt1.setString(2, mcode);
			stmt1.setString(3, pcode);
			stmt1.setString(4, vcode);
			rs1 = stmt1.executeQuery();
			rs1.next();
			name = rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Exception at getVillageName in RwsHabStatusData : " + e);
		} finally {
			if (stmt1 != null)
				stmt1.close();
			if (rs1 != null)
				rs1.close();
		}
		return name;
	}

	public ArrayList getInstitutes(DataSource dataSource) throws Exception {
		RwsMaster rwsMaster = null;
		ArrayList institutes = new ArrayList();

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(
					"select inst_code,inst_name from RWS_PUBLIC_INSTITUTE_TBL order by to_number(INST_CODE)");
			while (rs.next()) {
				// Debug.println("in while");
				rwsMaster = new RwsMaster();

				rwsMaster.setInstituteCode(rs.getString(1));
				rwsMaster.setInstituteName(rs.getString(2));
				rwsMaster.setInsDisplay(rs.getString(1) + "-" + rs.getString(2));
				institutes.add(rwsMaster);
			}
		} catch (Exception e) {
			Debug.println("The Exception in getInstitutes=" + e);
		} finally {
			closeAll();

		}
		return institutes;
	}

	public ArrayList getContamNames(DataSource dataSource) throws Exception {
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
			Debug.println("The Exception in getContaminations=" + e);
		} finally {
			closeAll();
		}
		return contaminations;
	}

	public int[] insertHabStatus(RwsMaster rwsMaster, ArrayList insts, ArrayList waterSupply, DataSource dataSource,
			String divStatus) throws Exception {
		HabInstitute habInstitute = new HabInstitute();
		int[] updateCounts = new int[insts.size()];
		String habCode = rwsMaster.getHabCode();
		boolean recordNotExistsInHabitationDirectoryTbl = true, exists = false;
		boolean insUpdate = false, flag = false;
		String query = "", querypanchayat = "";
		String slipCode = "";
		if (divStatus.equals("1"))
			slipCode = rwsMaster.getSlipReasonCode();
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			recordNotExistsInHabitationDirectoryTbl = true;
			query = "select * from rws_habitation_dir_dyna_tbl where hab_code=?";
			ps=conn.prepareStatement(query);
			ps.setString(1, habCode);
			rs = ps.executeQuery();
			if (rs.next()) {
				recordNotExistsInHabitationDirectoryTbl = false;
			}

			String finyr = rwsMaster.getHabYear();
			String finyrMon = finyr.substring(3, 5);
			finyr = finyr.substring(6, 10);
			int fyr = Integer.parseInt(finyr);
			int fyrMon = Integer.parseInt(finyrMon);
			if (fyrMon > 4) {
				fyr = fyr + 1;
				finyr = finyr + "-" + fyr;
			} else {
				fyr = fyr - 1;
				finyr = fyr + "-" + finyr;
			}
			Statement stmt=conn.createStatement();
			Statement stmt1=conn.createStatement();
			if (recordNotExistsInHabitationDirectoryTbl) {
				query = "insert into rws_habitation_dir_dyna_tbl values(" + "'" + rwsMaster.getCircleOfficeCode() + "',"
						
						+ rwsMaster.getDivisionOfficeCode() + "," + "'" + rwsMaster.getSubdivisionOfficeCode() + "','"
						+ rwsMaster.getHabCode() + "'," + "'" + rwsMaster.getCensusYear() + "',"
						+ rwsMaster.getCensusPop() + "," + "" + rwsMaster.getCensusSc() + "," + rwsMaster.getCensusSt()
						+ "," + "" + rwsMaster.getFloatPop() + ",'" + rwsMaster.getFloatReason() + "'," + "TO_DATE('"
						+ rwsMaster.getHabYear() + "','dd/mm/yyyy')," + "" + rwsMaster.getPopCovered() + ","
						+ rwsMaster.getScCovered() + "," + "" + rwsMaster.getStCovered() + ","
						+ rwsMaster.getTotalWaterSupply() + ",nvl('" + "" + rwsMaster.getLevelOfWaterSupply() + "',0),"
						+ "'" + rwsMaster.getCoveredStatus() + "'," + "" + rwsMaster.getNearWaterSource() + "," + ""
						+ rwsMaster.getNearWaterGroundSource() + "," + "'" + rwsMaster.getRemarks() + "','"
						+ rwsMaster.getQualityAffected() + "'," + "TO_DATE('" + rwsMaster.getUpdateDate()
						+ "','dd/mm/yyyy'),'" + rwsMaster.getPrevYrStatus() + "','" + rwsMaster.getPresentvYrStatus()
						+ "','" + rwsMaster.getProposedFcYr() + "'," + rwsMaster.getProposedFCAmt() + ",'"
						+ rwsMaster.getHabType() + "','" + rwsMaster.getHouseHold() + "','" + rwsMaster.getHabCat()
						+ "','" + rwsMaster.getExistSource() + "','" + rwsMaster.getSafeSource() + "','" + slipCode
						+ "','" + rwsMaster.getCattles() + "','" + rwsMaster.getHabSubType() + "','"
						+ rwsMaster.getNcSourceType() + "','" + rwsMaster.getSourceDistance() + "','"
						+ rwsMaster.getLpcdCooking() + "','','" + rwsMaster.getIsMinorityHab() + "','"
						+ rwsMaster.getIsLwe() + "','" + rwsMaster.getUnsafeLpcd() + "','"
						+ rwsMaster.getLevelOfWaterSupplySafeOnly() + "','" + rwsMaster.getHouseConn() + "'," + "'"
						+ rwsMaster.getIsItda() + "','" + rwsMaster.getScHCon() + "','" + rwsMaster.getStHCon() + "','"
						+ rwsMaster.getPlainHCon() + "','" + rwsMaster.getScHHold() + "','" + rwsMaster.getStHHold()
						+ "','" + rwsMaster.getPlainHHold() + "','" + rwsMaster.getMinorityHHold() + "','"
						+ rwsMaster.getMinorityHCon() + "','" + rwsMaster.getMinorityCovered() + "','"
						+ rwsMaster.getCensusMinority() + "','" + rwsMaster.getPublicTap() + "','"
						+ rwsMaster.getPublicStandpost() + "','" + rwsMaster.getExistCheckDams() + "','"
						+ rwsMaster.getReqCheckDams() + "','" + rwsMaster.getGlsrno() + "','" + rwsMaster.getGlsrqty()
						+ "','" + rwsMaster.getOhsrno() + "','" + rwsMaster.getOhsrqty() + "','"
						+ rwsMaster.getSchemesource() +"','"+ rwsMaster.getActPlainPop() +
						"','"+ rwsMaster.getActScPop() +
						"','"+ rwsMaster.getActStPop() +
						"','"+ rwsMaster.getActHouseHold() +
						"','"+ rwsMaster.getActTotPop() +
						"','"+ rwsMaster.getActHouseConn() +"')";

				stmt.addBatch(query);
				querypanchayat = "insert into rws_panchayat_raj_tbl(latitude,longitude,elevation,way_point,landmark)values('"
						+ rwsMaster.getLatitude() + "','" + rwsMaster.getLongitude() + "','" + rwsMaster.getElevation()
						+ "','" + rwsMaster.getWaypoint() + "','" + rwsMaster.getLandmark() + "' where panch_code='"
						+ rwsMaster.getHabCode() + "')";
				stmt.addBatch(querypanchayat);
				for (int i = 0; i < insts.size(); i++) {
					habInstitute = (HabInstitute) insts.get(i);
					insUpdate = false;
					query = " SELECT count(*) FROM rws_hab_institute_tbl  WHERE P_INST_CODE = ? and  hab_code=? ";
					ps=conn.prepareStatement(query);
					ps.setString(1,  habInstitute.getInstituteCode() );
					ps.setString(2, habCode);
					rs = ps.executeQuery();
					if (rs.next()) {
						if (rs.getInt(1) > 0)
							insUpdate = true;
					}
					if (habInstitute.getInstituteNo().length() != 0) {
						if (!insUpdate) {
							if (!habInstitute.getInstituteNo().equals("")
									|| !habInstitute.getInstituteCovered().equals("")
									|| !habInstitute.getInstituteWorking().equals("")
									|| !habInstitute.getInstituteNotWorking().equals("")) {
								query = "insert into rws_hab_institute_tbl values(" + "'" + rwsMaster.getHabCode()
										+ "'," + "'" + habInstitute.getInstituteCode() + "'," + "'"
										+ habInstitute.getInstituteNo() + "'," + "'"
										+ habInstitute.getInstituteCovered() + "','"
										+ habInstitute.getInstituteWorking() + "','"
										+ habInstitute.getInstituteNotWorking() + "')";
								stmt.addBatch(query);
							} else {
							}
						}

						if (insUpdate) {

							query = " UPDATE RWS_HAB_INSTITUTE_TBL " + " SET P_INST_NO='"
									+ habInstitute.getInstituteNo() + "'," + " P_INST_COVERED='"
									+ habInstitute.getInstituteCovered() + "'," + " P_INST_WORKING ='"
									+ habInstitute.getInstituteWorking() + "'," + " P_INST_NOTWORKING_NO='"
									+ habInstitute.getInstituteNotWorking() + "'" + " WHERE P_INST_CODE = '"
									+ habInstitute.getInstituteCode() + "'" + " AND HAB_CODE='" + rwsMaster.getHabCode()
									+ "'";
							stmt.addBatch(query);
						}
					}
				}
				if (rwsMaster.getQualityAffected().equals("Y") || rwsMaster.getStatus().equals("NSS")) {
					boolean contStatus = false;
					String type = "", conttypevalue = "";
					if ((rwsMaster.getContTypes1() != null && rwsMaster.getContTypes1().equals("1"))
							|| (rwsMaster.getContTypes2() != null && rwsMaster.getContTypes2().equals("2")
									|| (rwsMaster.getContTypes3() != null && rwsMaster.getContTypes3().equals("3"))
									|| (rwsMaster.getContTypes4() != null && rwsMaster.getContTypes4().equals("4"))
									|| (rwsMaster.getContTypes5() != null && rwsMaster.getContTypes5().equals("5")))) {
						for (int i = 0, j = 1; i < 5; i++, j++) {
							if (i == 0) {
								type = "01";
								conttypevalue = rwsMaster.getContTypes1();
							} else if (i == 1) {
								type = "02";
								conttypevalue = rwsMaster.getContTypes2();
							} else if (i == 2) {
								type = "03";
								conttypevalue = rwsMaster.getContTypes3();
							} else if (i == 3) {
								type = "04";
								conttypevalue = rwsMaster.getContTypes4();
							} else if (i == 4) {
								type = "05";
								conttypevalue = rwsMaster.getContTypes5();
							}
							contStatus = getContaminationStatus(type, dataSource, rwsMaster.getHabCode());
							// Debug.println("status for "+type+" :"+contStatus);
							if (contStatus) {
								if (conttypevalue != null && conttypevalue.equals("" + j)) {
									// Nothing to do
								} else {
									deleteContHab(type, stmt, rwsMaster.getHabCode());
								}
							} else {
								if (conttypevalue != null && conttypevalue.equals("" + j)) {
									addContHab(type, stmt, rwsMaster.getHabCode());
								} else {
								}
							}
						}
					} else {
						deleteContHabEntire(stmt, rwsMaster.getHabCode());
					}
				} else if (!rwsMaster.getStatus().equals("NSS")) {
					deleteContHabEntire(stmt, rwsMaster.getHabCode());
				}
				String q1 = "select * from rws_hab_supply_status_tbl where hab_code='" + habCode + "'";

				rs = stmt1.executeQuery(q1);
				if (rs.next()) {
					exists = true;

				}
				if (!exists) {

					query = "insert into rws_hab_supply_status_tbl(hab_code,SHP_DK_SUPPLY,SHP_NO,HPS_OTH_SUPPLY,HPS_NO,PWS_SUPPLY,PWS_NO,CPWS_SUPPLY,CPWS_NO,MPWS_SUPPLY,MPWS_NO,HPS_OTH_SUPPLY_UNSAFE,HPS_NO_UNSAFE,OWS_OTH_SUPPLY,OWS_NO,PONDS_OTH_SUPPLY,PONDS_NO,DW_TANKS_SUPPLY,DW_TANKS_NO,STAT_OF_HAB,OTHERS_SUPPLY,OTHERS_NO,OTHERS_SUPPLY_SAFE,OTHERS_NO_SAFE,PWS_UNSAFE_SUPPLY,PWS_UNSAFE_NO,MPWS_UNSAFE_SUPPLY,MPWS_UNSAFE_NO,SHP_NO_SAFE,SHP_DK_SUPPLY_SAFE) "
							+ "values('" + rwsMaster.getHabCode() + "','" + rwsMaster.getShpSupply() + "','"
							+ rwsMaster.getShpNo() + "','" + rwsMaster.getHpSupply() + "','" + rwsMaster.getHpNo()
							+ "','" + rwsMaster.getPwsSupply() + "','" + rwsMaster.getPwsNo() + "','"
							+ rwsMaster.getCpwsSupply() + "','" + rwsMaster.getCpwsNo() + "'," + "'"
							+ rwsMaster.getMpwsSupply() + "','" + rwsMaster.getMpwsNo() + "','"
							+ rwsMaster.getDpSupply() + "','" + rwsMaster.getDpNo() + "','" + rwsMaster.getOwsSupply()
							+ "','" + rwsMaster.getOwsNo() + "','" + rwsMaster.getPondsSupply() + "','"
							+ rwsMaster.getPondsNo() + "','" + rwsMaster.getDwSupply() + "'," + "'"
							+ rwsMaster.getDwNo() + "','" + rwsMaster.getStatus() + "',nvl('"
							+ rwsMaster.getOthersSupply() + "',0),nvl('" + rwsMaster.getOthersNo() + "',0),nvl('"
							+ rwsMaster.getOthersSafeSupply() + "',0),nvl('" + rwsMaster.getOthersSafeeNo()
							+ "',0),nvl('" + rwsMaster.getPwsUnsafeSupply() + "',0),nvl('" + rwsMaster.getPwsUnsafeNo()
							+ "',0),nvl('" + rwsMaster.getMpwsUnsafeSupply() + "',0),nvl('"
							+ rwsMaster.getMpwsUnsafeNo() + "',0),nvl('" + rwsMaster.getSafeSHPNo() + "',0),nvl('"
							+ rwsMaster.getSafeSHPSupply() + "',0))";
					stmt.addBatch(query);
				}
			} else {
				conn.setAutoCommit(false);
				try {
					boolean contStatus = false;
					String type = "", conttypevalue = "";
					if (!rwsMaster.getStatus().equals("NSS")) {
						deleteContHabEntire(stmt, rwsMaster.getHabCode());
					} else if (rwsMaster.getStatus().equals("NSS")) {
						if ((rwsMaster.getContTypes1() != null && rwsMaster.getContTypes1().equals("1"))
								|| (rwsMaster.getContTypes2() != null && rwsMaster.getContTypes2().equals("2")
										|| (rwsMaster.getContTypes3() != null && rwsMaster.getContTypes3().equals("3"))
										|| (rwsMaster.getContTypes4() != null && rwsMaster.getContTypes4().equals("4"))
										|| (rwsMaster.getContTypes5() != null
												&& rwsMaster.getContTypes5().equals("5")))) {
							for (int i = 0, j = 1; i < 5; i++, j++) {
								if (i == 0) {
									type = "01";
									conttypevalue = rwsMaster.getContTypes1();
								} else if (i == 1) {
									type = "02";
									conttypevalue = rwsMaster.getContTypes2();
								} else if (i == 2) {
									type = "03";
									conttypevalue = rwsMaster.getContTypes3();
								} else if (i == 3) {
									type = "04";
									conttypevalue = rwsMaster.getContTypes4();
								} else if (i == 4) {
									type = "05";
									conttypevalue = rwsMaster.getContTypes5();
								}
								contStatus = getContaminationStatus(type, dataSource, rwsMaster.getHabCode());
								if (contStatus) {
									if (conttypevalue != null && conttypevalue.equals("" + j)) {
									} else {
										deleteContHab(type, stmt, rwsMaster.getHabCode());
									}
								} else {
									if (conttypevalue != null && conttypevalue.equals("" + j)) {
										addContHab(type, stmt, rwsMaster.getHabCode());
									} else {
									}
								}
							}
						} else {
							deleteContHabEntire(stmt, rwsMaster.getHabCode());
						}
					}
				} catch (Exception e) {
					Debug.println("ERROR OCCURED IN UPDATE CONTAMINATION VALUES:" + e.getMessage());
				}

				query = " UPDATE rws_habitation_dir_dyna_tbl " + " SET CENSUS_YEAR='" + rwsMaster.getCensusYear() + "',"+
						" ACT_TOT_POPU='" + rwsMaster.getActTotPop() + "',"+
						" ACT_PLAIN_POPU='" + rwsMaster.getActPlainPop() + "',"+
						" ACT_SC_POPU='" + rwsMaster.getActScPop()+ "',"+
						" ACT_ST_POPU='" + rwsMaster.getActStPop() + "',"+
						" ACT_HOUSE_HOLD='" + rwsMaster.getActHouseHold() + "',"+
						" ACT_HOUSE_CONN='" + rwsMaster.getActHouseConn() + "',"+
 						" CENSUS_PLAIN_POPU='" + rwsMaster.getCensusPop() + "'," + " CENSUS_SC_POPU='"
						+ rwsMaster.getCensusSc() + "'," + " CENSUS_ST_POPU='" + rwsMaster.getCensusSt() + "',"
						+ " FLOAT_POP='" + rwsMaster.getFloatPop() + "', FLOAT_POP_REASONS='"
						+ rwsMaster.getFloatReason() + "'," + " STATUS_DATE=TO_DATE('" + rwsMaster.getHabYear()
						+ "','dd/mm/yyyy')," + " PLAIN_POPU_COVERED='" + rwsMaster.getPopCovered() + "',"
						+ " SC_POP_COVERED='" + rwsMaster.getScCovered() + "'," + " ST_POP_COVERED='"
						+ rwsMaster.getStCovered() + "'," + " TOTAL_WATER_SUPPLY='" + rwsMaster.getTotalWaterSupply()
						+ "'," + " EXIST_WATER_LEVEL='" + rwsMaster.getLevelOfWaterSupply() + "',"
						+ " COVERAGE_STATUS='" + rwsMaster.getStatus() + "'," + " NEAR_SURFACE_SOURCE='"
						+ rwsMaster.getNearWaterSource() + "'," + " NEAR_GROUND_SOURCE='"
						+ rwsMaster.getNearWaterGroundSource() + "'," + " REMARKS='" + rwsMaster.getRemarks() + "',"
						+ " quality_affected='" + rwsMaster.getQualityAffected() + "',UPDATE_DATE=TO_DATE('"
						+ rwsMaster.getUpdateDate() + "','dd/mm/yyyy')," + "PRESENT_YR_STATUS='"
						+ rwsMaster.getPresentvYrStatus() + "', PROPOSED_FC_YEAR = '" + rwsMaster.getProposedFcYr()
						+ "', PROPOSED_FC_EST_AMT =" + "nvl('" + rwsMaster.getProposedFCAmt() + "','0'), "
						+ "HABITATION_TYPE='" + rwsMaster.getHabType() + "'," + "HABITATION_SUB_TYPE='"
						+ rwsMaster.getHabSubType() + "'," + " HOUSEHOLD_NO='" + rwsMaster.getHouseHold() + "',"
						+ "HABITATION_CATEGORY='" + rwsMaster.getHabCat() + "'," + "EXISTING_SOURCES_NO='"
						+ rwsMaster.getExistSource() + "'," + "SAFE_SOURCES_NO='" + rwsMaster.getSafeSource() + "',"
						+ "NO_OF_PUBLIC_TAPS ='" + rwsMaster.getPublicTap() + "'," + "NO_OF_TAPS_WITH_STANDPOSTS ='"
						+ rwsMaster.getPublicStandpost() + "'," + "SLIPPAGE_CODE='" + slipCode + "'," + "NO_OF_CATTLE='"
						+ rwsMaster.getCattles() + "',nc_source_type='" + rwsMaster.getNcSourceType()
						+ "',source_distance='" + rwsMaster.getSourceDistance() + "',LPCD_COOKING ='"
						+ rwsMaster.getLpcdCooking() + "',MINORITY_DOMINATED='" + rwsMaster.getIsMinorityHab()
						+ "',LWE='" + rwsMaster.getIsLwe() + "',IS_ITDA='" + rwsMaster.getIsItda() + "',UNSAFE_LPCD='"
						+ rwsMaster.getUnsafeLpcd() + "',SAFE_LPCD='" + rwsMaster.getLevelOfWaterSupplySafeOnly()
						+ "',NO_OF_HOUSECONN_GIVEN =" + rwsMaster.getHouseConn() + "" + ",CON_SC ='"
						+ rwsMaster.getScHCon() + "', CON_ST ='" + rwsMaster.getStHCon() + "', CON_PLAIN ='"
						+ rwsMaster.getPlainHCon() + "'," + " HOUSEHOLDS_SC='" + rwsMaster.getScHHold()
						+ "', HOUSEHOLDS_ST ='" + rwsMaster.getStHHold() + "',HOUSEHOLDS_PLAIN ='"
						+ rwsMaster.getPlainHHold() + "',HOUSEHOLDS_MINORITY ='" + rwsMaster.getMinorityHHold()
						+ "',CON_MINORITY ='" + rwsMaster.getMinorityHCon() + "',MINORITY_POP_COVERED ='"
						+ rwsMaster.getMinorityCovered() + "',CENSUS_MINORITY_POPU='" + rwsMaster.getCensusMinority()
						+ "',GLSR_NO='" + rwsMaster.getGlsrno() + "',GLSR_QTY='" + rwsMaster.getGlsrqty()
						+ "',OHSR_NO='" + rwsMaster.getOhsrno() + "',OHSR_QTY='" + rwsMaster.getOhsrqty()
						+ "',SCHEMESOURCE='" + rwsMaster.getSchemesource() + "'" + " WHERE HAB_CODE='"
						+ rwsMaster.getHabCode() + "'";
				stmt.addBatch(query);
				String prajquery = " UPDATE RWS_PANCHAYAT_RAJ_TBL " + " SET  LATITUDE='" + rwsMaster.getLatitude()
						+ "'," + "LONGITUDE='" + rwsMaster.getLongitude() + "'," + "ELEVATION='"
						+ rwsMaster.getElevation() + "'," + "WAY_POINT='" + rwsMaster.getWaypoint() + "',"
						+ "landmark='" + rwsMaster.getLandmark() + "' " + " WHERE panch_CODE='" + rwsMaster.getHabCode()
						+ "'";

				stmt.addBatch(prajquery);
				for (int i = 0; i < insts.size(); i++) {
					habInstitute = (HabInstitute) insts.get(i);
					insUpdate = false;
					query = " SELECT count(*) FROM rws_hab_institute_tbl  WHERE P_INST_CODE = '"
							+ habInstitute.getInstituteCode() + "'and  hab_code='" + habCode + "'";

					rs = stmt1.executeQuery(query);
					if (rs.next()) {
						if (rs.getInt(1) > 0)
							insUpdate = true;
					}

					if (insUpdate) {
						query = " UPDATE RWS_HAB_INSTITUTE_TBL " + " SET P_INST_NO='" + habInstitute.getInstituteNo()
								+ "'," + " P_INST_COVERED='" + habInstitute.getInstituteCovered() + "',"
								+ " P_INST_WORKING ='" + habInstitute.getInstituteWorking() + "',"
								+ " P_INST_NOTWORKING_NO='" + habInstitute.getInstituteNotWorking() + "'"
								+ " WHERE P_INST_CODE = '" + habInstitute.getInstituteCode() + "'" + " AND HAB_CODE='"
								+ rwsMaster.getHabCode() + "'";
						stmt.addBatch(query);
						// }
					} else {
						if (!habInstitute.getInstituteNo().equals("") || !habInstitute.getInstituteCovered().equals("")
								|| !habInstitute.getInstituteWorking().equals("")
								|| !habInstitute.getInstituteNotWorking().equals("")) {
							query = " INSERT INTO rws_hab_institute_tbl(" + "HAB_CODE,P_INST_CODE,P_INST_NO ,"
									+ "P_INST_WORKING ,P_INST_NOTWORKING_NO,P_INST_COVERED) VALUES('" + habCode + "', "
									+ " '" + habInstitute.getInstituteCode() + "', '" + habInstitute.getInstituteNo()
									+ "', " + " '" + habInstitute.getInstituteWorking() + "', " + " '"
									+ habInstitute.getInstituteNotWorking() + "', " + " '"
									+ habInstitute.getInstituteCovered() + "') ";
							stmt.addBatch(query);
						}
					}

				}

				String q1 = "select * from rws_hab_supply_status_tbl where hab_code='" + habCode + "'";
				rs = stmt1.executeQuery(q1);
				if (rs.next()) {
					exists = true;

				}
				if (exists) {
					query = " UPDATE rws_hab_supply_status_tbl SET " + " hps_oth_supply = '" + rwsMaster.getHpSupply()
							+ "', " + " hps_no = '" + rwsMaster.getHpNo() + "', " + " shp_dk_supply = '"
							+ rwsMaster.getShpSupply() + "', " + " shp_no = '" + rwsMaster.getShpNo() + "', "
							+ " pws_supply = '" + rwsMaster.getPwsSupply() + "', " + " pws_no = '"
							+ rwsMaster.getPwsNo() + "', " + " cpws_supply = '" + rwsMaster.getCpwsSupply() + "', "
							+ " cpws_no = '" + rwsMaster.getCpwsNo() + "', " + " mpws_supply = '"
							+ rwsMaster.getMpwsSupply() + "', " + " mpws_no = '" + rwsMaster.getMpwsNo() + "', "
							+ " HPS_OTH_SUPPLY_UNSAFE = '" + rwsMaster.getDpSupply() + "', " + " HPS_NO_UNSAFE = '"
							+ rwsMaster.getDpNo() + "', " + " ows_oth_supply = '" + rwsMaster.getOwsSupply() + "', "
							+ " ows_no = '" + rwsMaster.getOwsNo() + "', " + " ponds_oth_supply = '"
							+ rwsMaster.getPondsSupply() + "', " + " ponds_no = '" + rwsMaster.getPondsNo() + "', "
							+ " DW_TANKS_SUPPLY = '" + rwsMaster.getDwSupply() + "', " + " DW_TANKS_NO = '"
							+ rwsMaster.getDwNo() + "', " + " stat_of_hab = '" + rwsMaster.getStatus()
							+ "', OTHERS_SUPPLY = '" + rwsMaster.getOthersSupply() + "', OTHERS_No= '"
							+ rwsMaster.getOthersNo() + "', OTHERS_SUPPLY_SAFE = '" + rwsMaster.getOthersSafeSupply()
							+ "', OTHERS_NO_SAFE= '" + rwsMaster.getOthersSafeeNo() + "' , PWS_UNSAFE_SUPPLY = '"
							+ rwsMaster.getPwsUnsafeSupply() + "', PWS_UNSAFE_NO = '" + rwsMaster.getPwsUnsafeNo()
							+ "', MPWS_UNSAFE_SUPPLY = '" + rwsMaster.getMpwsUnsafeSupply() + "', MPWS_UNSAFE_NO = '"
							+ rwsMaster.getMpwsUnsafeNo() + "' , SHP_NO_SAFE = '" + rwsMaster.getSafeSHPNo()
							+ "' , SHP_DK_SUPPLY_SAFE= '" + rwsMaster.getSafeSHPSupply() + "' WHERE hab_code='"
							+ rwsMaster.getHabCode() + "'";

					stmt.addBatch(query);
				} else {
					query = " insert into rws_hab_supply_status_tbl(hps_oth_supply,hps_no,shp_dk_supply,shp_no,pws_supply,pws_no,cpws_supply,cpws_no,mpws_supply,mpws_no,HPS_OTH_SUPPLY_UNSAFE,HPS_NO_UNSAFE,ows_oth_supply,ows_no,ponds_oth_supply,ponds_no,DW_TANKS_SUPPLY,DW_TANKS_NO,stat_of_hab,OTHERS_SUPPLY,OTHERS_No,hab_code,OTHERS_SUPPLY_SAFE,OTHERS_NO_SAFE,PWS_UNSAFE_SUPPLY,PWS_UNSAFE_NO,MPWS_UNSAFE_SUPPLY,MPWS_UNSAFE_NO,SHP_DK_SUPPLY_SAFE,SHP_NO_SAFE) values( "
							+ "nvl('" + rwsMaster.getHpSupply() + "',0),nvl('" + rwsMaster.getHpNo() + "',0),nvl('"
							+ rwsMaster.getShpSupply() + "',0),nvl('" + rwsMaster.getShpNo() + "',0),nvl('"
							+ rwsMaster.getPwsSupply() + "',0),nvl('" + rwsMaster.getPwsNo() + "',0),nvl('"
							+ rwsMaster.getCpwsSupply() + "',0),nvl('" + rwsMaster.getCpwsNo()

							+ "',0),nvl('" + rwsMaster.getMpwsSupply() + "',0),nvl('" + rwsMaster.getMpwsNo()

							+ "',0),nvl('" + rwsMaster.getDpSupply() + "',0),nvl('" + rwsMaster.getDpNo()

							+ "',0),nvl('" + rwsMaster.getOwsSupply() + "',0),nvl('" + rwsMaster.getOwsNo()
							+ "',0),nvl('" + rwsMaster.getPondsSupply() + "',0),nvl('" + rwsMaster.getPondsNo()

							+ "',0),nvl('" + rwsMaster.getDwSupply() + "',0),nvl('" + rwsMaster.getDwNo() + "',0),nvl('"
							+ rwsMaster.getStatus() + "',0),nvl('" + rwsMaster.getOthersSupply() + "',0),nvl('"
							+ rwsMaster.getOthersNo() + "',0),'" + rwsMaster.getHabCode() + "',nvl('"
							+ rwsMaster.getOthersSafeSupply() + "',0),nvl('" + rwsMaster.getOthersSafeeNo()
							+ "',0),nvl('" + rwsMaster.getPwsUnsafeSupply() + "',0),nvl('" + rwsMaster.getPwsUnsafeNo()
							+ "',0),nvl('" + rwsMaster.getMpwsUnsafeSupply() + "',0),nvl('"
							+ rwsMaster.getMpwsUnsafeNo() + "',0),nvl('" + rwsMaster.getSafeSHPSupply() + "',0),nvl('"
							+ rwsMaster.getSafeSHPNo() + "',0)" + ")";

					stmt.addBatch(query);

				}

			}
			updateCounts = stmt.executeBatch();
			flag = true;
			for (int i = 0; i < updateCounts.length; i++) {
				if (updateCounts[i] == 0) {
					flag = false;
				}
			}
			for (int i = 0; i < updateCounts.length; i++) {
				Debug.println("update Count=" + i + "count[i]=" + updateCounts[i]);

			}
			// Debug.println("flag=" + flag);
			if (flag) {
				// Debug.println("conn object:"+conn);
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

		} catch (BatchUpdateException b) {
			if (recordNotExistsInHabitationDirectoryTbl)
				errorMessage = "Record cannot be inserted.";
			else
				errorMessage = "Record cannot be updated";
			System.err.println("Update counts of successful commands: " + b);
		} catch (Exception e) {
			Debug.println("The Exception in insertHabStatus " + e);
		} finally {
			closeAll();
		}
		return updateCounts;
	}

public int[] updateHabStatus(RwsMaster rwsMaster, ArrayList insts, ArrayList waterSupply, DataSource dataSource)
	throws Exception {
int[] updateCounts = new int[10];
HabInstitute habInstitute = new HabInstitute();
HabWaterSupply habWS = new HabWaterSupply();
ContaminationTypes habCont = new ContaminationTypes();
String habCode = rwsMaster.getHabCode();
boolean insUpdate = false, cnsUpdate = false;
try {
	conn = RwsOffices.getConn();
	stmt = conn.createStatement();
	String query = " SELECT count(*) FROM rws_hab_institute_tbl WHERE hab_code='" + habCode + "'";
	rs = stmt.executeQuery(query);
	if (rs.next()) {
		if (rs.getInt(1) > 0)
			insUpdate = true;
	}

	query = " SELECT count(*) FROM rws_hab_contamination_tbl WHERE hab_code = '" + habCode + "'";
	rs = stmt.executeQuery(query);
	if (rs.next()) {
		if (rs.getInt(1) > 0)
			cnsUpdate = true;
	}

	conn.setAutoCommit(false);
	stmt = conn.createStatement();
	String finyr = rwsMaster.getHabYear();
	String finyrMon = finyr.substring(3, 5);
	finyr = finyr.substring(6, 10);
	int fyr = Integer.parseInt(finyr);
	int fyrMon = Integer.parseInt(finyrMon);
	if (fyrMon > 4) {
		fyr = fyr + 1;
		finyr = finyr + "-" + fyr;
	} else {
		fyr = fyr - 1;
		finyr = fyr + "-" + finyr;
	}
	query = " UPDATE rws_habitation_dir_dyna_tbl " + " SET CENSUS_YEAR='" + rwsMaster.getCensusYear() + "',"
			+ " CENSUS_PLAIN_POPU='" + rwsMaster.getCensusPop() + "'," + " CENSUS_SC_POPU='"
			+ rwsMaster.getCensusSc() + "'," + " CENSUS_ST_POPU='" + rwsMaster.getCensusSt() + "',"
			+ " FLOAT_POP='" + rwsMaster.getFloatPop() + "'," + " FLOAT_POP_REASONS='"
			+ rwsMaster.getFloatReason() + "'," + " STATUS_DATE=TO_DATE('" + rwsMaster.getHabYear()
			+ "','dd/mm/yyyy')," + " PLAIN_POPU_COVERED='" + rwsMaster.getPopCovered() + "',"
			+ " SC_POP_COVERED='" + rwsMaster.getScCovered() + "'," + " ST_POP_COVERED='"
			+ rwsMaster.getStCovered() + "'," + " TOTAL_WATER_SUPPLY='" + rwsMaster.getTotalWaterSupply() + "',"
			+ " EXIST_WATER_LEVEL='" + rwsMaster.getExistWaterLevel() + "'," + " COVERAGE_STATUS='"
			+ rwsMaster.getStatus() + "'," + " NEAR_SURFACE_SOURCE='" + rwsMaster.getNearWaterSource() + "',"
			+ " NEAR_GROUND_SOURCE='" + rwsMaster.getNearWaterGroundSource() + "'," + " REMARKS='"
			+ rwsMaster.getRemarks() + "'," + " quality_affected='" + rwsMaster.getQualityAffected()
			+ "', PROPOSED_FC_YEAR = '" + rwsMaster.getProposedFcYr() + "', PROPOSED_FC_EST_AMT ="
			+ rwsMaster.getProposedFCAmt() + ",nc_source_type='" + rwsMaster.getNcSourceType() + "',"
			+ "source_distance='" + rwsMaster.getSourceDistance() + "'" + "," +
			"HOUSEHOLDS_SC ='" + rwsMaster.getScHHold() + "'," + "HOUSEHOLDS_ST ='" + rwsMaster.getStHHold()
			+ "'" + "HOUSEHOLDS_PLAIN='" + rwsMaster.getPlainHHold() + "'" + "CON_SC='" + rwsMaster.getScHCon()
			+ "'" + "CON_ST='" + rwsMaster.getStHCon() + "'" + "CON_PLAIN='" + rwsMaster.getPlainHCon()
			+ "',HOUSEHOLDS_MINORITY ='" + rwsMaster.getMinorityHHold() + "',CON_MINORITY ='"
			+ rwsMaster.getMinorityHCon() + "', MINORITY_POP_COVERED ='" + rwsMaster.getMinorityCovered()
			+ "',CENSUS_MINORITY_POPU='" + rwsMaster.getCensusMinority() + "',NO_OF_PUBLIC_TAPS='"
			+ rwsMaster.getPublicTap() + "',NO_OF_TAPS_WITH_STANDPOSTS ='" + rwsMaster.getPublicStandpost()
			+ "',no_checkdams_exist ='" + rwsMaster.getExistCheckDams() + "'" + "',no_checkdams_req ='"
			+ rwsMaster.getReqCheckDams() + "'" +
			" WHERE HAB_CODE='" + rwsMaster.getHabCode() + "'";
	stmt.addBatch(query);
	String prajquery = " UPDATE RWS_PANCHAYAT_RAJ_TBL " + " SET  LATITUDE='" + rwsMaster.getLatitude() + "',"
			+ "LONGITUDE='" + rwsMaster.getLongitude() + "'," + "ELEVATION='" + rwsMaster.getElevation() + "',"
			+ "WAY_POINT='" + rwsMaster.getWaypoint() + "', " + "landmark='" + rwsMaster.getLandmark() + "' "
			+ " WHERE panch_CODE='" + rwsMaster.getHabCode() + "'";

	stmt.addBatch(prajquery);
	for (int i = 0; i < insts.size(); i++) {
		habInstitute = (HabInstitute) insts.get(i);
		if (insUpdate)
			query = " UPDATE RWS_HAB_INSTITUTE_TBL " + " SET P_INST_NO='" + habInstitute.getInstituteNo() + "',"
					+ " P_INST_COVERED='" + habInstitute.getInstituteCovered() + "'," + " P_INST_WORKING ='"
					+ habInstitute.getInstituteWorking() + "'," + " P_INST_NOTWORKING_NO='"
					+ habInstitute.getInstituteNotWorking() + "'" + " WHERE P_INST_CODE = '"
					+ habInstitute.getInstituteCode() + "'" + " AND HAB_CODE='" + rwsMaster.getHabCode() + "'";

		else
			query = " INSERT INTO rws_hab_institute_tbl(" + "HAB_CODE,P_INST_CODE,P_INST_NO ,"
					+ "P_INST_WORKING ,P_INST_NOTWORKING_NO,P_INST_COVERED) VALUES('" + habCode + "', " + " '"
					+ habInstitute.getInstituteCode() + "', '" + habInstitute.getInstituteNo() + "', " + " '"
					+ habInstitute.getInstituteWorking() + "', " + " '" + habInstitute.getInstituteNotWorking()
					+ "', " + " '" + habInstitute.getInstituteCovered() + "') ";

		stmt.addBatch(query);
	}

	query = " UPDATE rws_hab_supply_status_tbl SET " + " shp_dk_supply = '" + rwsMaster.getShpSupply() + "', "
			+ " shp_no = '" + rwsMaster.getShpNo() + "', " + " cisterns_dk_supply = '"
			+ rwsMaster.getCisternsSupply() + "', " + " cisterns_no = '" + rwsMaster.getCisternsNo() + "', "
			+ " glsrs_dk_supply = '" + rwsMaster.getGlsrSupply() + "', " + " glsrs_no = '"
			+ rwsMaster.getGlsrNo() + "', " + " ohsrs_dk_supply = '" + rwsMaster.getOhsrSupply() + "', "
			+ " ohsrs_no = '" + rwsMaster.getOhsrNo() + "', " + " hps_oth_supply = '" + rwsMaster.getHpSupply()
			+ "', " + " hps_no = '" + rwsMaster.getHpNo() + "', " + " ows_oth_supply = '"
			+ rwsMaster.getOwsSupply() + "', " + " ows_no = '" + rwsMaster.getOwsNo() + "', "
			+ " ponds_oth_supply = '" + rwsMaster.getPondsSupply() + "', " + " ponds_no = '"
			+ rwsMaster.getPondsNo() + "', " + " shwell_oth_supply = '" + rwsMaster.getShwSupply() + "', "
			+ " shwell_no = '" + rwsMaster.getShwNo() + "', " + " pcpd_drink = '" + rwsMaster.getPcpdDrink()
			+ "', " + " pcpd_others = '" + rwsMaster.getPcpdOthers() + "', " + " stat_of_hab = '"
			+ rwsMaster.getStatus() + "'" + ", OTHERS_SUPPLY = '" + rwsMaster.getOthersSupply()
			+ "', OTHERS_No= '" + rwsMaster.getOthersNo() + "', OTHERS_SUPPLY_SAFE = '"
			+ rwsMaster.getOthersSafeSupply() + "', OTHERS_NO_SAFE= '" + rwsMaster.getOthersSafeeNo()
			+ "' , PWS_UNSAFE_SUPPLY = '" + rwsMaster.getPwsUnsafeSupply() + "', PWS_UNSAFE_NO = '"
			+ rwsMaster.getPwsUnsafeNo() + "', MPWS_UNSAFE_SUPPLY = '" + rwsMaster.getMpwsUnsafeSupply()
			+ "', MPWS_UNSAFE_NO = '" + rwsMaster.getMpwsUnsafeNo() + "',SHP_NO_SAFE= '"
			+ rwsMaster.getSafeSHPNo() + "',SHP_DK_SUPPLY_SAFE = '" + rwsMaster.getSafeSHPSupply()
			+ "' WHERE hab_code='" + habCode + "'";
	stmt.addBatch(query);
	if (cnsUpdate) {
		if (rwsMaster.getFlouride() != 0.0) {
			query = " UPDATE rws_hab_contamination_tbl " + " SET cont_perc = '" + rwsMaster.getFlouride() + "'"
					+ " WHERE cont_type = 01 " + " AND hab_code='" + rwsMaster.getHabCode() + "'";
			stmt.addBatch(query);
		}

		if (rwsMaster.getBrakish() != 0.0) {
			query = " UPDATE rws_hab_contamination_tbl " + " SET cont_perc = '" + rwsMaster.getBrakish() + "'"
					+ " WHERE cont_type = 02 " + " AND hab_code='" + rwsMaster.getHabCode() + "'";
			stmt.addBatch(query);
		}

		if (rwsMaster.getIron() != 0.0) {
			query = " UPDATE rws_hab_contamination_tbl " + " SET cont_perc = '" + rwsMaster.getIron() + "'"
					+ " WHERE cont_type = 01 " + " AND hab_code='" + rwsMaster.getHabCode() + "'";
			stmt.addBatch(query);
		}
	}

	else {
		if (rwsMaster.getBrakish() != 0.0) {
			query = "insert into RWS_HAB_CONTAMINATION_TBL values(" + "'" + rwsMaster.getHabCode() + "'," + "02"
					+ "," + rwsMaster.getBrakish() + "','" + finyr + "'," + "TO_DATE('"
					+ rwsMaster.getUpdateDate() + "','dd/mm/yyyy'))";
			stmt.addBatch(query);

		}
		if (rwsMaster.getFlouride() != 0.0) {
			query = "insert into RWS_HAB_CONTAMINATION_TBL values(" + "'" + rwsMaster.getHabCode() + "'," + "01"
					+ "," + rwsMaster.getFlouride() + "','" + finyr + "'," + "TO_DATE('"
					+ rwsMaster.getUpdateDate() + "','dd/mm/yyyy'))";
			stmt.addBatch(query);

		}
		if (rwsMaster.getIron() != 0.0) {
			query = "insert into RWS_HAB_CONTAMINATION_TBL values(" + "'" + rwsMaster.getHabCode() + "'," + "03"
					+ "," + rwsMaster.getIron() + "','" + finyr + "'," + "TO_DATE('" + rwsMaster.getUpdateDate()
					+ "','dd/mm/yyyy'))";
			stmt.addBatch(query);

		}
	}
	updateCounts = stmt.executeBatch();
	conn.commit();
} catch (BatchUpdateException b) {
	System.err.println("Update counts of successful commands:updateHabStatus " + b);
} catch (Exception e) {
	Debug.println("The Exception in updateHabStatus " + e);
} finally {
	closeAll();
}
return updateCounts;
}

	public int updateHabLatLong(RwsMaster rwsMaster, DataSource dataSource) throws Exception {
		int re = 0;
		String habCode = rwsMaster.getHabCode();
		// Debug.println("Hab COde : " + habCode);
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query12 = " UPDATE RWS_PANCHAYAT_RAJ_TBL SET";
			if (rwsMaster.getLatitude() != null && !rwsMaster.getLatitude().equals("")) {
				double Lat = Double.parseDouble(rwsMaster.getLatitude());
				query12 += " LATITUDE='" + Lat + "' ";
			}
			if (rwsMaster.getLongitude() != null && !rwsMaster.getLongitude().equals("")) {
				double Long = Double.parseDouble(rwsMaster.getLongitude());
				query12 += ", LONGITUDE='" + Long + "'";
			}
			if (rwsMaster.getElevation() != null && !rwsMaster.getElevation().equals("")) {
				double Ele = Double.parseDouble(rwsMaster.getElevation());
				query12 += ", ELEVATION='" + Ele + "'";
			}
			if (rwsMaster.getWaypoint() != null && !rwsMaster.getWaypoint().equals("")) {
				int Way = Integer.parseInt(rwsMaster.getWaypoint());
				query12 += ", WAY_POINT='" + Way + "'";
			}
			if (rwsMaster.getLandmark() != null && !rwsMaster.getLandmark().equals("")) {
				query12 += ", landmark='" + rwsMaster.getLandmark() + "'";
			}
			query12 += " WHERE panch_CODE='" + habCode + "'";
			re = stmt.executeUpdate(query12);
			conn.commit();
		} catch (BatchUpdateException ex1) {
			System.err.println("Update counts of successful commands:updateHabStatus " + ex1);
		} catch (Exception e) {
			 Debug.println("The exception in updateLAT and Long " + e);
			//ke.printStackTrace();
		} finally {
			closeAll();
		}

		return re;
	}

	public int[] removeHabStatus(String habCode, DataSource dataSource) throws Exception {
		int[] updateCounts = new int[3];
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			stmt.addBatch("DELETE  FROM RWS_HAB_INSTITUTE_TBL WHERE HAB_CODE='" + habCode + "'");
			stmt.addBatch("DELETE  FROM RWS_HAB_COMPONENT_TBL WHERE HAB_CODE='" + habCode + "'");
			stmt.addBatch("DELETE  FROM rws_habitation_dir_dyna_tbl WHERE HAB_CODE='" + habCode + "'");
			updateCounts = stmt.executeBatch();
			conn.commit();
		} catch (Exception e) {
			Debug.println("The Exception in removeHabStatus= " + e);
		} finally {
			closeAll();
		}
		return updateCounts;
	}

	public static String format(String val) {
		if (val == null || val.equals("null"))
			val = "";
		return val;
	}

	public static String format(int val) {
		String rValue = "";
		if (val == 0)
			rValue = "";
		else
			rValue = val + "";
		return rValue;
	}

	public static String format(float val) {
		String rValue = "";
		if (val == 0)
			rValue = "";
		else
			rValue = val + "";
		return rValue;
	}

	public boolean getContaminationStatus(String contType, DataSource dataSource, String habCode) {
		boolean status = false;
		ResultSet rrs = null;
		Statement rstmt = null;
		Connection conns = null;
		try {
			conns = RwsOffices.getConn();
			// Debug.println("got conn");
			rstmt = conns.createStatement();
			String query = "select * from RWS_HAB_CONTAMINATION_TBL where hab_code='" + habCode + "' and cont_type='"
					+ contType + "'";
			// Debug.println("qry in getContaminationStatus:"+query);
			rrs = rstmt.executeQuery(query);
			// Debug.println("1");
			if (rrs.next()) {
				// Debug.println("2");
				status = true;
			}
			// Debug.println("3");
		} catch (Exception e) {
			Debug.println("The Exception in getContaminationStatus= " + e);
		} finally {
			try {
				if (rrs != null) {
					try {
						rrs.close();
					} catch (Exception e) {
						Debug.println("The Exception in rwsMasterData" + e);
					}
					rrs = null;
				}
				if (rstmt != null) {
					try {
						rstmt.close();
					} catch (Exception e) {
						Debug.println("The Exception in closeAll=" + e);
					}
					rstmt = null;
				}
				if (conns != null) {
					try {
						conns.close();
					} catch (Exception e) {
						Debug.println("The Exception in closeAll=" + e);
					}
					conns = null;
				}
			} catch (Exception e) {
			}
		}
		return status;
	}

	public void deleteContHab(String contType, Statement stmt, String habCode) {
		boolean status = false;
		try {
			// stmt = conn.createStatement();
			// Debug.println("got stmt");
			String query = "delete from RWS_HAB_CONTAMINATION_TBL where hab_code='" + habCode + "' and cont_type='"
					+ contType + "'";
			// Debug.println("qry in deleteContHab:"+query);
			// stmt.addBatch(query);
			int returnval = stmt.executeUpdate(query);
			// Debug.println("got stmt execute");
		} catch (Exception e) {
			Debug.println("The Exception in deleteContHab= " + e);
		} finally {
			try {// closeAll();
			} catch (Exception e) {
			}
		}
	}

	public void deleteContHabEntire(Statement stmtt, String habCode) {
		boolean status = false;
		try {
			String query = "delete from RWS_HAB_CONTAMINATION_TBL where hab_code='" + habCode + "'";
			int returnval = stmtt.executeUpdate(query);
		} catch (Exception e) {
			Debug.println("The Exception in deleteContHabEntire= " + e);
		} finally {
			try {// closeAll();
			} catch (Exception e) {
			}
		}
	}

	public void addContHab(String contType, Statement stmt, String habCode) {
		boolean status = false;
		try {
			String query = "insert into RWS_HAB_CONTAMINATION_TBL(hab_code,cont_type)values('" + habCode + "','"
					+ contType + "')";
			int returnval = stmt.executeUpdate(query);
		} catch (Exception e) {
			Debug.println("The Exception in addContHab= " + e);
		} finally {
			try {// closeAll();
			} catch (Exception e) {
			}
		}
	}

	public static int insertHabsData(String habcode, String tsp) throws Exception {
		int count = 0;
		String query = "";
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = RwsOffices.getConn();
			query = " update rws_habitation_dir_dyna_tbl set TSP_NTSP=? where HAB_CODE=? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, tsp.toUpperCase());
			ps.setString(2, habcode);
			count = ps.executeUpdate();

		} catch (Exception e) {
			Debug.println("The Exception in insertHabData:" + e);
		} finally {
			if(ps!=null)
			ps.close();
			if(conn!=null)
			conn.close();
		}
		return count;
	}

	public static int insertScData(String habcode, String lccode, String lcname) throws Exception {
		int count = 0;
		String query = "", qry1 = "";
		Connection conn = null;
		PreparedStatement stmt = null, stmt1 = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();
			qry1 = "select hab_code,locality_code,locality_name from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=? and locality_code=? ";
			stmt1 = conn.prepareStatement(qry1);
			stmt1.setString(1, habcode);
			stmt1.setString(2, lccode);
			rs1 = stmt1.executeQuery();
			if (!rs1.next()) {
				query = " insert into RWS_SC_ST_MIN_LOCALITY_TBL(hab_code,locality_code,locality_name)values(?,?,?)";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, habcode);
				stmt.setString(2, lccode);
				stmt.setString(3, lcname);
			} else {
				query = " update RWS_SC_ST_MIN_LOCALITY_TBL set locality_name=? where hab_code=? and locality_code=?";
				stmt = conn.prepareStatement(query);
				stmt.setString(2, habcode);
				stmt.setString(3, lccode);
				stmt.setString(1, lcname);
			}
			count = stmt.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception at insertScData in RwsHabStatus : " + e);
		}
		return count;
	}

	public static int insertAssetData(String habcode, String astcode, String lccode, String popserved)
			throws Exception {
		int count = 0;
		String query = "";
		Connection conn = null;
		PreparedStatement stmt = null, stmt1 = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();
			String qry = "select hab_code,asset_code,locality_code,population_served from RWS_ASSET_LOCALITY_SERVE_TBL where hab_code=? and asset_code=? and locality_code=?";
			stmt1 = conn.prepareStatement(qry);
			stmt1.setString(1, habcode);
			stmt1.setString(2, astcode);
			stmt1.setString(3, lccode);
			rs1 = stmt1.executeQuery();
			if (!rs1.next()) {
				query = " insert into RWS_ASSET_LOCALITY_SERVE_TBL (hab_code,asset_code,locality_code,population_served)values(?,?,?,?)";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, habcode);
				stmt.setString(2, astcode);
				stmt.setString(3, lccode);
				stmt.setString(4, popserved);
			} else {
				query = " update RWS_ASSET_LOCALITY_SERVE_TBL set population_served=? where hab_code=? and asset_code=? and locality_code=?";
				stmt = conn.prepareStatement(query);
				stmt.setString(2, habcode);
				stmt.setString(3, astcode);
				stmt.setString(4, lccode);
				stmt.setString(1, popserved);
			}
			count = stmt.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception at insertAssetData in RwsHabStatus : " + e);
		}

		return count;
	}
	
}