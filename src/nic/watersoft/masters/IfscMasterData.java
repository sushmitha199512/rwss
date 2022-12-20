package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;


import nic.watersoft.commons.RwsOffices;



public class IfscMasterData {
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

	public IfscMasterData() {
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
				Debug.println("The error in ifscMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs5 = null;
		}
		if (rs6 != null) {
			try {
				rs6.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs6 = null;
		}
		if (rs7 != null) {
			try {
				rs7.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs7 = null;
		}
		if (rs8 != null) {
			try {
				rs8.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs8 = null;
		}
		if (rs9 != null) {
			try {
				rs9.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs9 = null;
		}
		if (rs10 != null) {
			try {
				rs10.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs10 = null;
		}
		if (rs11 != null) {
			try {
				rs11.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs11 = null;
		}
		if (rs12 != null) {
			try {
				rs12.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs12 = null;
		}
		if (rs13 != null) {
			try {
				rs13.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs13 = null;
		}
		if (rs14 != null) {
			try {
				rs14.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs14 = null;
		}
		if (rs15 != null) {
			try {
				rs15.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs15 = null;
		}
		if (rs16 != null) {
			try {
				rs16.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs16 = null;
		}
		if (rs17 != null) {
			try {
				rs17.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs17 = null;
		}
		if (rs18 != null) {
			try {
				rs18.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs18 = null;
		}
		if (rs19 != null) {
			try {
				rs19.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs19 = null;
		}
		if (rs20 != null) {
			try {
				rs20.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs20 = null;
		}
		if (rs21 != null) {
			try {
				rs21.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs21 = null;
		}
		if (rs22 != null) {
			try {
				rs22.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs22 = null;
		}
		if (rs23 != null) {
			try {
				rs23.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs23 = null;
		}
		if (rs24 != null) {
			try {
				rs24.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rs24 = null;
		}
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				Debug.println("The error in ifscMasterData" + e);
			}
			rset = null;
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
		if (stmt5 != null) {
			try {
				stmt5.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt5 = null;
		}
		if (stmt6 != null) {
			try {
				stmt6.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
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
				Debug.println("The error in closeAll=" + e);
			}
			stmt8 = null;
		}
		if (stmt9 != null) {
			try {
				stmt9.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt9 = null;
		}
		if (stmt10 != null) {
			try {
				stmt10.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt10 = null;
		}
		if (stmt11 != null) {
			try {
				stmt11.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt11 = null;
		}
		if (stmt12 != null) {
			try {
				stmt12.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt12 = null;
		}
		if (stmt13 != null) {
			try {
				stmt13.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt13 = null;
		}
		if (stmt14 != null) {
			try {
				stmt14.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt14 = null;
		}
		if (stmt15 != null) {
			try {
				stmt15.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt15 = null;
		}
		if (stmt16 != null) {
			try {
				stmt16.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt16 = null;
		}
		if (stmt17 != null) {
			try {
				stmt17.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt17 = null;
		}
		if (stmt18 != null) {
			try {
				stmt18.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt18 = null;
		}
		if (stmt19 != null) {
			try {
				stmt19.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt19 = null;
		}
		if (stmt20 != null) {
			try {
				stmt20.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt20 = null;
		}
		if (stmt21 != null) {
			try {
				stmt21.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt21 = null;
		}
		if (stmt22 != null) {
			try {
				stmt22.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt22 = null;
		}
		if (stmt23 != null) {
			try {
				stmt23.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt23 = null;
		}
		if (stmt24 != null) {
			try {
				stmt24.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt24 = null;
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
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}
	}
	public static String getBankName(String ifsccode,IfscbankForm frm) {

		IfscMasterData ifscMasterData = new IfscMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			ifscMasterData.conn = RwsOffices.getConn();
			query = "select bank,branch_name,address from RWS_BANK_IFSC_CODE_TBL where ifsc_code='"+ifsccode+"'";
			ifscMasterData.stmt1 = ifscMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			ifscMasterData.rs1 = ifscMasterData.stmt1.executeQuery(query);
			while (ifscMasterData.rs1.next()) {
				frm.setBankName(ifscMasterData.rs1.getString(1));
				frm.setBranchName(ifscMasterData.rs1.getString(2));
				frm.setBankAddress(ifscMasterData.rs1.getString(3));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ifscMasterData.rs1 != null)
					ifscMasterData.rs1.close();
				if (ifscMasterData.stmt1 != null)
					ifscMasterData.stmt1.close();
				if (ifscMasterData.conn != null)
					ifscMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}

/////
	public static String getBranchName(String ifsccode) {

		IfscMasterData ifscMasterData = new IfscMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			ifscMasterData.conn = RwsOffices.getConn();
			query = "select BRANCH_NAME  from RWS_BANK_IFSC_CODE_TBL where ifsc_code='"+ifsccode+"'";
			ifscMasterData.stmt1 = ifscMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			ifscMasterData.rs1 = ifscMasterData.stmt1.executeQuery(query);
			while (ifscMasterData.rs1.next()) {
				name = ifscMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ifscMasterData.rs1 != null)
					ifscMasterData.rs1.close();
				if (ifscMasterData.stmt1 != null)
					ifscMasterData.stmt1.close();
				if (ifscMasterData.conn != null)
					ifscMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}
	//
	public static String getAccountNumber(String ifsccode,IfscbankForm frm) {

		IfscMasterData ifscMasterData = new IfscMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
						ifscMasterData.conn = RwsOffices.getConn();
			query = "select account_number,name,address,person_operating  from rws_remitter_tbl where ifsc_code='"+ifsccode+"'";
			ifscMasterData.stmt1 = ifscMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			ifscMasterData.rs1 = ifscMasterData.stmt1.executeQuery(query);
			while (ifscMasterData.rs1.next()) {
				frm.setAccountNumber(ifscMasterData.rs1.getString(1));
				frm.setAccountholderName(ifscMasterData.rs1.getString(2));
				frm.setPersonAddress(ifscMasterData.rs1.getString(3));
				frm.setPersonAccount(ifscMasterData.rs1.getString(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ifscMasterData.rs1 != null)
					ifscMasterData.rs1.close();
				if (ifscMasterData.stmt1 != null)
					ifscMasterData.stmt1.close();
				if (ifscMasterData.conn != null)
					ifscMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}

	//
	public static String getName(String ifsccode) {

		IfscMasterData ifscMasterData = new IfscMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			ifscMasterData.conn = RwsOffices.getConn();
			query = "select name  from rws_remitter_tbl where ifsc_code='"+ifsccode+"'";
			ifscMasterData.stmt1 = ifscMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			ifscMasterData.rs1 = ifscMasterData.stmt1.executeQuery(query);
			while (ifscMasterData.rs1.next()) {
				name = ifscMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ifscMasterData.rs1 != null)
					ifscMasterData.rs1.close();
				if (ifscMasterData.stmt1 != null)
					ifscMasterData.stmt1.close();
				if (ifscMasterData.conn != null)
					ifscMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}

	//
	public static String getPersonAddress(String ifsccode) {

		IfscMasterData ifscMasterData = new IfscMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			ifscMasterData.conn = RwsOffices.getConn();
			query = "select address  from rws_remitter_tbl where ifsc_code='"+ifsccode+"'";
			ifscMasterData.stmt1 = ifscMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			ifscMasterData.rs1 = ifscMasterData.stmt1.executeQuery(query);
			while (ifscMasterData.rs1.next()) {
				name = ifscMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ifscMasterData.rs1 != null)
					ifscMasterData.rs1.close();
				if (ifscMasterData.stmt1 != null)
					ifscMasterData.stmt1.close();
				if (ifscMasterData.conn != null)
					ifscMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}
	//
	public static String getPersonoperating(String ifsccode) {

		IfscMasterData ifscMasterData = new IfscMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			ifscMasterData.conn = RwsOffices.getConn();
			query = "select person_operating  from rws_remitter_tbl where ifsc_code='"+ifsccode+"'";
			ifscMasterData.stmt1 = ifscMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			ifscMasterData.rs1 = ifscMasterData.stmt1.executeQuery(query);
			while (ifscMasterData.rs1.next()) {
				name = ifscMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ifscMasterData.rs1 != null)
					ifscMasterData.rs1.close();
				if (ifscMasterData.stmt1 != null)
					ifscMasterData.stmt1.close();
				if (ifscMasterData.conn != null)
					ifscMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}


	//
	public static int getExists(String ifsccode) {

		IfscMasterData ifscMasterData = new IfscMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		int i=0;

		try {
			ifscMasterData.conn = RwsOffices.getConn();
			query = "select  count(*)  from rws_remitter_tbl where ifsc_code='"+ifsccode+"'";
			ifscMasterData.stmt1 = ifscMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			ifscMasterData.rs1 = ifscMasterData.stmt1.executeQuery(query);
			if (ifscMasterData.rs1.next()) {
				i = ifscMasterData.rs1.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ifscMasterData.rs1 != null)
					ifscMasterData.rs1.close();
				if (ifscMasterData.stmt1 != null)
					ifscMasterData.stmt1.close();
				if (ifscMasterData.conn != null)
					ifscMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return i;
	}


	//
	public int saveifsc(IfscbankForm dr,String ifsc,String account,String name,String address,String personaccount)
	throws Exception {
	int count = 0;


	try {
	conn = RwsOffices.getConn();

	Statement pstmt = conn.createStatement();
	ResultSet rs1 = null;
	String query="";


		//if (isExists(ifsc)) {
			//
			// query = "update rws_bank_mast_tbl set account_number='"+account+"' where  ifsc_code='"+ifsc+"'";
			

	//System.out.println("updatequery****************************:" +
	//query);

	//count = pstmt.executeUpdate(query);

			//
			

			

		//} 
		// else

		//{
			 query = "insert into  rws_remitter_tbl(ifsc_code,account_number,name,address,person_operating) values ('"
				+ ifsc
				+ "','"
				+ account
				+ "','"+name.toUpperCase()+"','"+address.toUpperCase()+"','"+personaccount.toUpperCase()+"')";
		System.out.println("Query************************:" + query);
		count = pstmt.executeUpdate(query);

					//}
	

	if (count > 0) {

		conn.commit();
	} else
		conn.rollback();
	} catch (Exception e) {
	e.printStackTrace();
	}
	return count;

	}

	//
	private  boolean isExists(String ifsc) {

		try {
			
		conn = RwsOffices.getConn();
		Statement pstmt = conn.createStatement();
		ResultSet rs1 = null;
		String query="";
			// query = "select * from   rws_bank_mast_tbl where ifsc_code='"+ifsc+"' and account_number='"
				//+ account+"'";
				 query = "select * from   rws_bank_mast_tbl where ifsc_code='"+ifsc+"' ";
			

		Debug.println("Query************************:" + query);
		rs1 = pstmt.executeQuery(query);

		if (rs1.next())
			return true;
		else
			return false;
		} catch (Exception e) {
		e.printStackTrace();
		}

		return false;
		}

	public static String getBankAddress(String ifsccode) {

		IfscMasterData ifscMasterData = new IfscMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			ifscMasterData.conn = RwsOffices.getConn();
			query = "select ADDRESS   from RWS_BANK_IFSC_CODE_TBL where ifsc_code='"+ifsccode+"'";
			ifscMasterData.stmt1 = ifscMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			ifscMasterData.rs1 = ifscMasterData.stmt1.executeQuery(query);
			while (ifscMasterData.rs1.next()) {
				name = ifscMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ifscMasterData.rs1 != null)
					ifscMasterData.rs1.close();
				if (ifscMasterData.stmt1 != null)
					ifscMasterData.stmt1.close();
				if (ifscMasterData.conn != null)
					ifscMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}



}
	
///



///





