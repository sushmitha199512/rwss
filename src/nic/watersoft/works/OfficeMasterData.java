package nic.watersoft.works;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class OfficeMasterData {
	
	private String checks="";
	
	Connection conn = null;

	PreparedStatement stmt = null;

	PreparedStatement stmt1 = null;

	PreparedStatement stmt2 = null;

	PreparedStatement stmt3 = null;

	PreparedStatement stmt4 = null;

	PreparedStatement stmt5 = null;

	PreparedStatement stmt6 = null;

	PreparedStatement stmt7 = null;

	PreparedStatement stmt8 = null;

	PreparedStatement stmt9 = null;

	PreparedStatement stmt10 = null;

	PreparedStatement stmt11 = null;

	PreparedStatement stmt12 = null;

	PreparedStatement stmt13 = null;

	PreparedStatement stmt14 = null;

	PreparedStatement stmt15 = null;

	PreparedStatement stmt16 = null;

	PreparedStatement stmt17 = null;

	PreparedStatement stmt18 = null;

	PreparedStatement stmt19 = null;

	PreparedStatement stmt20 = null;

	PreparedStatement stmt21 = null;

	PreparedStatement stmt22 = null;

	PreparedStatement stmt23 = null;

	PreparedStatement stmt24 = null;

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
	
	public OfficeMasterData() {
	}

	public void closeAll() throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		PreparedStatement stmt4 = null;
		PreparedStatement stmt5 = null;
		PreparedStatement stmt6 = null;
		PreparedStatement stmt7 = null;
		PreparedStatement stmt8 = null;
		PreparedStatement stmt9 = null;
		PreparedStatement stmt10 = null;
		PreparedStatement stmt11 = null;
		PreparedStatement stmt12 = null;
		PreparedStatement stmt13 = null;
		PreparedStatement stmt14 = null;
		PreparedStatement stmt15 = null;
		PreparedStatement stmt16 = null;
		PreparedStatement stmt17 = null;
		PreparedStatement stmt18 = null;
		PreparedStatement stmt19 = null;
		PreparedStatement stmt20 = null;
		PreparedStatement stmt21 = null;
		PreparedStatement stmt22 = null;
		PreparedStatement stmt23 = null;
		PreparedStatement stmt24 = null;
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
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs5 = null;
		}
		if (rs6 != null) {
			try {
				rs6.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs6 = null;
		}
		if (rs7 != null) {
			try {
				rs7.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs7 = null;
		}
		if (rs8 != null) {
			try {
				rs8.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs8 = null;
		}
		if (rs9 != null) {
			try {
				rs9.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs9 = null;
		}
		if (rs10 != null) {
			try {
				rs10.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs10 = null;
		}
		if (rs11 != null) {
			try {
				rs11.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs11 = null;
		}
		if (rs12 != null) {
			try {
				rs12.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs12 = null;
		}
		if (rs13 != null) {
			try {
				rs13.close();
			} catch (Exception e) {
				System.out.println("The Exception in complaintMasterData" + e);
			}
			rs13 = null;
		}
		if (rs14 != null) {
			try {
				rs14.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs14 = null;
		}
		if (rs15 != null) {
			try {
				rs15.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs15 = null;
		}
		if (rs16 != null) {
			try {
				rs16.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs16 = null;
		}
		if (rs17 != null) {
			try {
				rs17.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs17 = null;
		}
		if (rs18 != null) {
			try {
				rs18.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs18 = null;
		}
		if (rs19 != null) {
			try {
				rs19.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs19 = null;
		}
		if (rs20 != null) {
			try {
				rs20.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs20 = null;
		}
		if (rs21 != null) {
			try {
				rs21.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs21 = null;
		}
		if (rs22 != null) {
			try {
				rs22.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs22 = null;
		}
		if (rs23 != null) {
			try {
				rs23.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs23 = null;
		}
		if (rs24 != null) {
			try {
				rs24.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rs24 = null;
		}
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				System.out.println("The Exception in officeMasterData" + e);
			}
			rset = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (stmt5 != null) {
			try {
				stmt5.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt5 = null;
		}
		if (stmt6 != null) {
			try {
				stmt6.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt6 = null;
		}
		if (stmt7 != null) {
			try {
				stmt7.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt7 = null;
		}
		if (stmt8 != null) {
			try {
				stmt8.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt8 = null;
		}
		if (stmt9 != null) {
			try {
				stmt9.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt9 = null;
		}
		if (stmt10 != null) {
			try {
				stmt10.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt10 = null;
		}
		if (stmt11 != null) {
			try {
				stmt11.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt11 = null;
		}
		if (stmt12 != null) {
			try {
				stmt12.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt12 = null;
		}
		if (stmt13 != null) {
			try {
				stmt13.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt13 = null;
		}
		if (stmt14 != null) {
			try {
				stmt14.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt14 = null;
		}
		if (stmt15 != null) {
			try {
				stmt15.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt15 = null;
		}
		if (stmt16 != null) {
			try {
				stmt16.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt16 = null;
		}
		if (stmt17 != null) {
			try {
				stmt17.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt17 = null;
		}
		if (stmt18 != null) {
			try {
				stmt18.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt18 = null;
		}
		if (stmt19 != null) {
			try {
				stmt19.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt19 = null;
		}
		if (stmt20 != null) {
			try {
				stmt20.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt20 = null;
		}
		if (stmt21 != null) {
			try {
				stmt21.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt21 = null;
		}
		if (stmt22 != null) {
			try {
				stmt22.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt22 = null;
		}
		if (stmt23 != null) {
			try {
				stmt23.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt23 = null;
		}
		if (stmt24 != null) {
			try {
				stmt24.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			stmt24 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				System.out.println("The Exception in closeAll=" + e);
			}
			conn = null;
		}
		

	}
	
	public static String getOffice(String workid) {
		OfficeMasterData officeMasterData = new OfficeMasterData();		
		String query = "";
		String office = "";
		try {
			officeMasterData.conn = RwsOffices.getConn();
			query = "select office_code from rws_work_admn_tbl where work_id= ? ";
			officeMasterData.ps = officeMasterData.conn.prepareStatement(query);
			officeMasterData.ps.setString(1, workid);
			officeMasterData.rs1 = officeMasterData.ps.executeQuery();
			while (officeMasterData.rs1.next()) {
				office = officeMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The Exception in OfficeMasterData getOffice : " + e.getMessage());
		} finally {
			try {
				if (officeMasterData.rs1 != null)
					officeMasterData.rs1.close();
				if (officeMasterData.stmt1 != null)
					officeMasterData.stmt1.close();
				if (officeMasterData.conn != null)
					officeMasterData.conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in OfficeMasterData getOffice : " + e.getMessage());
			}
		}
		return office;
	}

	public int[] updateOfficeCode(String workid,String division,String subdivision)	throws Exception {
		String circle=workid.substring(4,6);
		String headoffice="1";
		String officecode="";
		WorksData1 worksData1=new WorksData1();
		officecode=headoffice+circle+division+subdivision;
		OfficeMasterData officeMasterData=new OfficeMasterData();
		String office=OfficeMasterData.getOffice(workid);
		String serverdate=worksData1.getServerDate();
		String query1="";
		int[] updateCounts = new int[100];
		try {
			officeMasterData.conn = RwsOffices.getConn();
			String query = "update RWS_work_admn_tbl set office_code= ? where work_id= ? ";
			officeMasterData.stmt22 = officeMasterData.conn.prepareStatement(query);
			officeMasterData.stmt22.setString(1, officecode);
			officeMasterData.stmt22.setString(2, workid);			
			query1="insert into rws_work_office_change_tbl(work_id,office_code_exist,office_code_new,update_date) values( ?, ?, ?,to_date(?,'dd/mm/yyyy'))";
			officeMasterData.stmt23 = officeMasterData.conn.prepareStatement(query1);
			officeMasterData.stmt23.setString(1, workid);
			officeMasterData.stmt23.setString(2, office);
			officeMasterData.stmt23.setString(3, officecode);
			officeMasterData.stmt23.setString(4, serverdate);
		    updateCounts[0] = officeMasterData.stmt22.executeUpdate();
		    updateCounts[1] = officeMasterData.stmt23.executeUpdate();
		   	officeMasterData.conn.commit();
		} catch (Exception e){
			System.out.println("The Exception in OfficeMasterData updateOfficeCode : " + e.getMessage());
		}
		finally	{
			 officeMasterData.closeAll();	
		}
		return updateCounts;
	}

	public ArrayList getWorkdivisions(String workid,String head) throws Exception {
		ArrayList divisions;
		OfficeMasterData officeMasterData = new OfficeMasterData();
		LabelValueBean officeMasterForm = null;
		divisions = new ArrayList();
		String query = "";
		String circle=workid.substring(4,6);
		try {		
			officeMasterData.conn = RwsOffices.getConn();
			query = "select  division_office_code,division_office_name from rws_division_office_tbl where head_office_code='1' and circle_office_code= ? order by division_office_name";
			officeMasterData.ps = officeMasterData.conn.prepareStatement(query);
			officeMasterData.ps.setString(1, circle);
			officeMasterData.rs = officeMasterData.ps.executeQuery();
			while (officeMasterData.rs.next()) {
				officeMasterForm = new LabelValueBean();
				officeMasterForm.setValue(officeMasterData.rs.getString(1));
				officeMasterForm.setLabel(officeMasterData.rs.getString(2));
				officeMasterForm.setLabelValue(officeMasterData.rs.getString(2) + " - " + officeMasterData.rs.getString(1));
				divisions.add(officeMasterForm);
			}
		} catch (Exception e) { 
			System.out.println("The Exception in OfficeMasterData getWorkdivisions : " + e.getMessage());
		} finally {
			officeMasterData.closeAll();
		}
		return divisions;
	}
	
	public ArrayList getWorksdetails(String workid) throws Exception {
		ArrayList works=null;
		OfficeMasterData officeMasterData = new OfficeMasterData();
		works = new ArrayList();	
		OfficeMasterForm officeMasterForm = null;	
		String query = "";
		String w1=workid.substring(4,6);
		try {
			officeMasterData.conn = RwsOffices.getConn();
			query = "select office_code,work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount from rws_work_admn_tbl where work_id= ? ";
			officeMasterData.ps = officeMasterData.conn.prepareStatement(query);
			officeMasterData.ps.setString(1, workid);
			officeMasterData.rs = officeMasterData.ps.executeQuery();
			while (officeMasterData.rs.next()) {
				officeMasterForm = new OfficeMasterForm();
				officeMasterForm.setOfficeEntered(officeMasterData.rs.getString(1));
				officeMasterForm.setWorkId(officeMasterData.rs.getString(2));
				officeMasterForm.setWorkName(officeMasterData.rs.getString(3));
				officeMasterForm.setAdminNo(officeMasterData.rs.getString(4));
				officeMasterForm.setAdminDate(officeMasterData.rs.getString(5));
				officeMasterForm.setSanctionAmount(officeMasterData.rs.getString(6));
				works.add(officeMasterForm);
			}
		} catch (Exception e) {
			System.out.println("The Exception in OfficeMasterData getWorksdetails : " + e.getMessage());
		} finally {
			officeMasterData.closeAll();
		}
		return works;
	}

	public ArrayList getWorkSubdivisions(String workid,String divisions,String head) throws Exception {
		ArrayList subdivisions;
		OfficeMasterData officeMasterData = new OfficeMasterData();
		LabelValueBean officeMasterForm = null;
		subdivisions = new ArrayList();
		String query = "";
		String circle=workid.substring(4,6);	
		try {		
			officeMasterData.conn = RwsOffices.getConn();
			query = "select subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl where head_office_code='1' and  circle_office_code= ? and division_office_code= ? order by subdivision_office_name" ;
			officeMasterData.ps = officeMasterData.conn.prepareStatement(query);
			officeMasterData.ps.setString(1, circle);
			officeMasterData.ps.setString(2, divisions);			
			officeMasterData.rs = officeMasterData.ps.executeQuery();
			while (officeMasterData.rs.next()) {
				officeMasterForm = new LabelValueBean();
				officeMasterForm.setValue(officeMasterData.rs.getString(1));
				officeMasterForm.setLabel(officeMasterData.rs.getString(2));
				officeMasterForm.setLabelValue(officeMasterData.rs.getString(2)	+ " - " + officeMasterData.rs.getString(1));
				subdivisions.add(officeMasterForm);
			}		
		} catch (Exception e) {
			System.out.println("The Exception in OfficeMasterData getWorkSubdivisions : " + e.getMessage());
		} finally {
			officeMasterData.closeAll();		
		}
		return subdivisions;
	}
	
	//Deepak Modified 
	public ArrayList getBlockWorksdetails(String workid) throws Exception {
		ArrayList works=null;
		OfficeMasterData officeMasterData = new OfficeMasterData();
		works = new ArrayList();		
		OfficeMasterForm officeMasterForm = null;		
		String query = "";
		String w1=workid.substring(4,6);
		try {
			officeMasterData.conn = RwsOffices.getConn();
			query = "select distinct office_code,work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,decode(block_payment,'Y','Yes','N','No'),nvl(to_char(block_date,'dd/mm/yyyy'),'-') from rws_work_admn_tbl where work_id= ?  and work_cancel_dt is null";
			officeMasterData.stmt = officeMasterData.conn.prepareStatement(query);
			officeMasterData.stmt.setString(1, workid);
			officeMasterData.rs = officeMasterData.stmt.executeQuery();
			while (officeMasterData.rs.next()) {
				officeMasterForm = new OfficeMasterForm();
				officeMasterForm.setOfficeEntered(officeMasterData.rs.getString(1));
				officeMasterForm.setWorkId(officeMasterData.rs.getString(2));
				officeMasterForm.setWorkName(officeMasterData.rs.getString(3));
				officeMasterForm.setAdminNo(officeMasterData.rs.getString(4));
				officeMasterForm.setAdminDate(officeMasterData.rs.getString(5));
				officeMasterForm.setSanctionAmount(officeMasterData.rs.getString(6));
				officeMasterForm.setBlockPayment(officeMasterData.rs.getString(7));
				officeMasterForm.setBlockDate(officeMasterData.rs.getString(8));
				works.add(officeMasterForm);
			}
		} catch (Exception e) {
			System.out.println("The Exception in OfficeMasterData getBlockWorksdetails : " + e.getMessage());
		} finally {
			officeMasterData.closeAll();
		}
			return works;
	}
		
	public int updateBlockPayment(OfficeMasterBean dr,String workid) throws Exception {
		int count = 0;
		String circle=workid.substring(4,6);
		String headoffice="1";
		String officecode="";
		OfficeMasterData officeMasterData=new OfficeMasterData();
		 try {
		     officeMasterData.conn = RwsOffices.getConn();
		     String query = "update rws_work_admn_tbl set block_payment= ? ,block_date=to_date( ? ,'dd/mm/yyyy')  where work_id= ? ";
		     officeMasterData.stmt = officeMasterData.conn.prepareStatement(query);
		     officeMasterData.stmt.setString(1, dr.getBlockPayment());
		     officeMasterData.stmt.setString(2, dr.getBlockDate());
		     officeMasterData.stmt.setString(3, workid);
			 count = officeMasterData.stmt.executeUpdate();
		   	 officeMasterData.conn.commit();
		} catch (Exception e) {
			System.out.println("The Exception in OfficeMasterData updateBlockPayment : " + e.getMessage());
		}
		finally	{
			officeMasterData.closeAll();
		}
		return count;
	}

		public static String getBlock(String workid) {
			OfficeMasterData officeMasterData = new OfficeMasterData();			
			String query = "";
			String office = "";
			OfficeMasterForm officeMasterForm=null;
			try {
				officeMasterData.conn = RwsOffices.getConn();
				query = "select block_payment from rws_work_admn_tbl where work_id= ? ";	
				officeMasterData.ps = officeMasterData.conn.prepareStatement(query);
				officeMasterData.ps.setString(1, workid);
				officeMasterData.rs1 = officeMasterData.ps.executeQuery();
				if(officeMasterData.rs1.next()) {
					office = officeMasterData.rs1.getString(1);					
				}				
			} catch (Exception e) {
				System.out.println("The Exception in OfficeMasterData getBlock : " + e.getMessage());
			} finally {
				try {
					if (officeMasterData.rs1 != null)
						officeMasterData.rs1.close();
					if (officeMasterData.stmt1 != null)
						officeMasterData.stmt1.close();
					if (officeMasterData.conn != null)
						officeMasterData.conn.close();
				} catch (Exception e) {
					System.out.println("The Exception in OfficeMasterData getBlock : " + e.getMessage());
				}
			}			
			return office;
		}

}





	
	





