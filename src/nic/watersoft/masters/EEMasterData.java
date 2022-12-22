package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import nic.watersoft.works.tenderMemo;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;


import nic.watersoft.commons.RwsOffices;



public class EEMasterData {
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

	public EEMasterData() {
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
				Debug.println("The error in eeMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs5 = null;
		}
		if (rs6 != null) {
			try {
				rs6.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs6 = null;
		}
		if (rs7 != null) {
			try {
				rs7.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs7 = null;
		}
		if (rs8 != null) {
			try {
				rs8.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs8 = null;
		}
		if (rs9 != null) {
			try {
				rs9.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs9 = null;
		}
		if (rs10 != null) {
			try {
				rs10.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs10 = null;
		}
		if (rs11 != null) {
			try {
				rs11.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs11 = null;
		}
		if (rs12 != null) {
			try {
				rs12.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs12 = null;
		}
		if (rs13 != null) {
			try {
				rs13.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs13 = null;
		}
		if (rs14 != null) {
			try {
				rs14.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs14 = null;
		}
		if (rs15 != null) {
			try {
				rs15.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs15 = null;
		}
		if (rs16 != null) {
			try {
				rs16.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs16 = null;
		}
		if (rs17 != null) {
			try {
				rs17.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs17 = null;
		}
		if (rs18 != null) {
			try {
				rs18.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs18 = null;
		}
		if (rs19 != null) {
			try {
				rs19.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs19 = null;
		}
		if (rs20 != null) {
			try {
				rs20.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs20 = null;
		}
		if (rs21 != null) {
			try {
				rs21.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs21 = null;
		}
		if (rs22 != null) {
			try {
				rs22.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs22 = null;
		}
		if (rs23 != null) {
			try {
				rs23.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs23 = null;
		}
		if (rs24 != null) {
			try {
				rs24.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
			}
			rs24 = null;
		}
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				Debug.println("The error in eeMasterData" + e);
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
	//
	public static EEBean getPao1(String circle,String division,String pao,DataSource dataSource)
	throws Exception {   
EEBean eeBean = null;
String query="";
EEMasterData eeMasterData=new EEMasterData();


try {
	
	
	eeMasterData.conn = RwsOffices.getConn();
	
	eeMasterData.stmt = eeMasterData.conn.createStatement();
	query="select distinct circle_office_code,division_office_code,pao_code,ee_name,to_char(doj_in_present_post,'dd/mm/yyyy'),DOR_IN_PRESENT_POTS  from rws_ee_ds_tbl where pao_code='"+pao+"' and circle_office_code='"+circle+"' and division_office_code='"+division+"' ";
	Debug.println("**queryinget***********"+query);
	eeMasterData.rs = eeMasterData.stmt.executeQuery(query);
	if (eeMasterData.rs.next()) {
		
		eeBean = new EEBean();
        
		eeBean.setCircleOffice(eeMasterData.rs.getString(1));
		eeBean.setCircleName(eeMasterData.getCircleName(eeMasterData.rs.getString(1)));
		eeBean.setDivisionName(eeMasterData.getDivisionName(eeMasterData.rs.getString(1),eeMasterData.rs.getString(2)));
		eeBean.setDivisionOffice(eeMasterData.rs.getString(2));
		eeBean.setPaoCode(eeMasterData.rs.getString(3));
		eeBean.setEeName(eeMasterData.rs.getString(4));
		eeBean.setDateofPresent(eeMasterData.rs.getString(5));
		eeBean.setDateofReleaving(eeMasterData.rs.getString(6));
		
		
		
		
	}
} catch (Exception e) {
	Debug.println("The error in getEE=" + e);
} finally {
	eeMasterData.closeAll();
	
}
return eeBean;
}

	//
	public static ArrayList getEngineers()
	throws Exception {   EEMasterData eeMasterData=new EEMasterData();
ExecutiveEForm executiveEForm = null;
ArrayList engineers = new ArrayList();

try {
	
	
	eeMasterData.conn = RwsOffices.getConn();
	eeMasterData.stmt = eeMasterData.conn.createStatement();
	eeMasterData.stmt1=eeMasterData.conn.createStatement();

	String query="";
	String query1="";
	query1="select distinct a.circle_office_name,b.division_office_name,b.circle_office_code,b.division_office_code,PAO_CODE,EE_NAME,to_char(DOJ_IN_PRESENT_POST,'dd/mm/yyyy'),to_char(DOR_IN_PRESENT_POTS,'dd/mm/yyyy') from rws_circle_office_tbl a,rws_division_office_tbl b,rws_ee_ds_tbl c where c.circle_office_code=a.circle_office_code and c.division_office_code=b.division_office_code and a.circle_office_code=b.circle_office_code order by b.circle_office_code,b.division_office_code";
	Debug.println("query1"+query1);
	eeMasterData.rs1=eeMasterData.stmt1.executeQuery(query1);
	while(eeMasterData.rs1.next())
	{executiveEForm = new ExecutiveEForm();
		executiveEForm.setCircleOffice(eeMasterData.rs1.getString(3));
		executiveEForm.setCircleName(eeMasterData.rs1.getString(1));
		executiveEForm.setDivisionOffice(eeMasterData.rs1.getString(4));
		executiveEForm.setDivisionName(eeMasterData.rs1.getString(2));
		executiveEForm.setPaoCode(eeMasterData.rs1.getString(5));
		executiveEForm.setEeName(eeMasterData.rs1.getString(6));
		executiveEForm.setDateofPresent(eeMasterData.rs1.getString(7));
		executiveEForm.setDateofReleaving(eeMasterData.rs1.getString(8));
		engineers.add(executiveEForm);
		
		
	}
	
	
	
} catch (Exception e) {
	Debug.println("The error in getEngineers=" + e);
} finally {
	eeMasterData.closeAll();
	
}
return engineers;
}

	//
	 public String getServerDate()
	 {
	 	Debug.println("in getServerDate methodddddddddddddddddddddd");
		String serverDate = "";
		String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select to_char(sysdate,'dd-MON-yy') from dual";
			Debug.println("qry in get getServerDate:"+query);
			rset = stmt.executeQuery(query);
			tenderMemo tenderMemoBean = null;
			String total = "0";
			if (rset.next())
			{
				serverDate = rset.getString(1);
			}
		}
		catch (Exception e)
		{
			Debug.println("Exception in getNewBillAmount():"+e);
		}
		finally
		{
			try
			  {
				if(rset!=null)rset.close();
				if(stmt!=null)stmt.close();
				if(conn!=null)conn.close();
			  }
			catch(Exception e)
			{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
		}
		return serverDate;
	
	 }
	//
	public static int shiftEE(ExecutiveEForm dr,String circle,String division,String pao,String name,String doj,String dor)
	throws Exception {
	int count = 0;
	Connection conn=null;
	PreparedStatement pst=null;
	try {
	conn = RwsOffices.getConn();
	String serverdate="";
    Statement stmt1=null;
    String query1="";
	Statement pstmt = conn.createStatement();
	stmt1=conn.createStatement();
	ResultSet rs2 = null;
	String query="";
//	Bringing serverdate for inserting date
	EEMasterData eeMasterData=new EEMasterData();
	
	serverdate = eeMasterData.getServerDate();
	
	query1="select circle_office_code,DIVISION_OFFICE_CODE,PAO_CODE,EE_NAME,to_char(DOJ_IN_PRESENT_POST,'dd-MON-yy'),nvl(to_char(DOR_IN_PRESENT_POTS,'dd-MON-yy'),'') from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"' and pao_code='"+pao+"' ";
	Debug.println("query1"+query1);
    rs2=stmt1.executeQuery(query1);
    while(rs2.next())
    {
            String cir=rs2.getString(1);
            Debug.println("cir****"+cir);
            String div=rs2.getString(2);
            Debug.println("cir****"+div);
            String pa=rs2.getString(3);
            Debug.println("cir****"+pa);
            String n=rs2.getString(4);
            Debug.println("cir****"+n);
			String presentdate=rs2.getString(5);
			Debug.println("cir****"+presentdate);
			String releavingdate=rs2.getString(6);
			Debug.println("cir****"+releavingdate);
        try{
		query = "insert into  rws_ee_ds_his_tbl(circle_office_code,DIVISION_OFFICE_CODE,PAO_CODE,EE_NAME,DOJ_IN_PRESENT_POST,DOR_IN_PRESENT_POTS,update_date) values (?,?,?,?,?,?,?)";
		Debug.println("Queryinshift************************:" + query);
		pst=conn.prepareStatement(query);
		pst.setString(1, cir);
		pst.setString(2, div);
		pst.setString(3, pa);
		pst.setString(4, n);
		pst.setString(5, presentdate);
		pst.setString(6, releavingdate);
		pst.setString(7, serverdate);
		count = pst.executeUpdate();
        }catch(Exception e)
		{
        	e.printStackTrace();
		}
		

    }
	

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
	public static int shiftEE1(EEBean dr) throws Exception {
	int count = 0;
	Connection conn=null;
	try {
	conn = RwsOffices.getConn();
	String serverdate="";
    Statement stmt1=null;
    ResultSet rs1=null;
    String query1="";
	Statement pstmt = conn.createStatement();
	stmt1=conn.createStatement();
	ResultSet rs2 = null;
	String query="";
	PreparedStatement pst=null;
//	Bringing serverdate for inserting date
	EEMasterData eeMasterData=new EEMasterData();
	
	serverdate = eeMasterData.getServerDate();
	
	query1="select circle_office_code,DIVISION_OFFICE_CODE,PAO_CODE,EE_NAME,to_char(DOJ_IN_PRESENT_POST,'dd-MON-yy'),to_char(DOR_IN_PRESENT_POTS,'dd-MON-yy') from rws_ee_ds_tbl where circle_office_code=? and division_office_code=? and pao_code=? ";
	Debug.println("query1"+query1);
    pst=conn.prepareStatement(query1);
    pst.setString(1, dr.getCircleOffice());
    pst.setString(2, dr.getCircleOffice());
    pst.setString(3, dr.getDivisionOffice());
    pst.setString(4,dr.getPaoCode());
	rs2=pst.executeQuery(query1);
    while(rs2.next())
    {
            String cir=rs2.getString(1);
            Debug.println("cir****"+cir);
            String div=rs2.getString(2);
            Debug.println("cir****"+div);
            String pa=rs2.getString(3);
            Debug.println("cir****"+pa);
            String n=rs2.getString(4);
            Debug.println("cir****"+n);
			String presentdate=rs2.getString(5);
			Debug.println("cir****"+presentdate);
			String releavingdate=rs2.getString(6);
			Debug.println("cir****"+releavingdate);
        try{
		query = "insert into  rws_ee_ds_his_tbl(circle_office_code,DIVISION_OFFICE_CODE,PAO_CODE,EE_NAME,DOJ_IN_PRESENT_POST,DOR_IN_PRESENT_POTS,update_date) values (?,?,?,?,?,?,?)";
		Debug.println("Queryinshift************************:" + query);
		//count = pstmt.executeUpdate(query);
		pst=conn.prepareStatement(query);
		pst.setString(1, cir);
		pst.setString(2, div);
		pst.setString(3, pa);
		pst.setString(4, n);
		pst.setString(5, presentdate);
		pst.setString(6, releavingdate);
		pst.setString(7, serverdate);
		count = pst.executeUpdate();
        }catch(Exception e)
		{
        	e.printStackTrace();
		}
    }
	

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
	
	public static int saveEE(ExecutiveEForm dr,String circle,String division,String pao,String name,String doj,String dor)
	throws Exception {
	int count = 0;
	Connection conn=null;


	try {
	conn = RwsOffices.getConn();

	Statement pstmt = conn.createStatement();
	ResultSet rs1 = null;
	String query="";
	
	
			 query = "insert into  rws_ee_ds_tbl(circle_office_code,DIVISION_OFFICE_CODE,PAO_CODE,EE_NAME,DOJ_IN_PRESENT_POST) values (?,?,?,?,to_date(?,'dd/mm/yyyy'))";
		Debug.println("Query************************:" + query);
		PreparedStatement ps= conn.prepareStatement(query);
		ps.setString(1, circle);
		ps.setString(2, division);
		ps.setString(3, pao);
		ps.setString(4, name.toUpperCase());
		ps.setString(5, doj);
		count = ps.executeUpdate();
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
	public static int updateEE(ExecutiveEForm dr,String circle,String division,String pao,String name,String doj,String dor)
	throws Exception {
	int count = 0;
	Connection conn=null;
	try {
	conn = RwsOffices.getConn();

	Statement pstmt = conn.createStatement();
	ResultSet rs1 = null;
	String query="";
			 query = "update  rws_ee_ds_tbl set EE_NAME=?,DOJ_IN_PRESENT_POST=to_date(?,'dd/mm/yyyy'),DOR_IN_PRESENT_POTS=to_date(?,'dd/mm/yyyy') where pao_code=? and circle_office_code=? and division_office_code=?";
		Debug.println("Queryinupdatewhendateofreleaving is given************************:" + query);
		PreparedStatement ps=conn.prepareStatement(query);
		ps.setString(1, name.toUpperCase());
		ps.setString(2, doj);
		ps.setString(3, dor);
		ps.setString(4, pao);
		ps.setString(5, circle);
		ps.setString(6, division);
		count = ps.executeUpdate();

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
	public static int updateEE2(EEBean dr)
	throws Exception {
	int count = 0;
	Connection conn=null;

	try {
	conn = RwsOffices.getConn();

	Statement pstmt = conn.createStatement();
	ResultSet rs1 = null;
	String query="";
	query = "update  rws_ee_ds_tbl set EE_NAME=?,DOJ_IN_PRESENT_POST=to_date(?,'dd/mm/yyyy'),DOR_IN_PRESENT_POTS=to_date(?,'dd/mm/yyyy') where pao_code=? and circle_office_code=? and division_office_code=?";
		Debug.println("Query************************:" + query);
		PreparedStatement ps=conn.prepareStatement(query); 
		ps.setString(1, dr.getEeName().toUpperCase());
		ps.setString(2, dr.getDateofPresent());
		ps.setString(3, dr.getDateofReleaving());
		ps.setString(4, dr.getPaoCode());
		ps.setString(5, dr.getCircleOffice());
        ps.setString(6, dr.getDivisionOffice());
		count = ps.executeUpdate();
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
	public static int updateEE1(EEBean dr,DataSource dataSource)
	throws Exception {
	int count = 0;
	Connection conn=null;


	try {
	conn = RwsOffices.getConn();

	Statement pstmt = conn.createStatement();
	ResultSet rs1 = null;
	String query="";
			 query = "update  rws_ee_ds_tbl set EE_NAME=?,DOJ_IN_PRESENT_POST=to_date(?,'dd/mm/yyyy') where pao_code=? and circle_office_code=? and division_office_code=?";
		Debug.println("Queryupdateinedit************************:" + query);
		PreparedStatement pst= conn.prepareStatement(query);
		pst.setString(1,dr.getEeName().toUpperCase());
		pst.setString(2, dr.getDateofPresent());
		pst.setString(3,dr.getPaoCode());
		pst.setString(4, dr.getCircleOffice());
		pst.setString(5, dr.getDivisionOffice());
		count = pst.executeUpdate();
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
	public static int deleteEE(ExecutiveEForm dr,String circle,String division,String pao)
	throws Exception {
	int count = 0;
	Connection conn=null;


	try {
	conn = RwsOffices.getConn();

	Statement pstmt = conn.createStatement();
	ResultSet rs1 = null;
	String query="";
		 query = "delete from  rws_ee_ds_tbl where circle_office_code=? and division_office_code=? and pao_code=?";
		Debug.println("delQuery************************:" + query);
		PreparedStatement ps= conn.prepareStatement(query);
		ps.setString(1, circle);
		ps.setString(2,division);
		ps.setString(3,pao);
		count = ps.executeUpdate();
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
	public static int deleteEE1(EEBean dr)
	throws Exception {
	int count = 0;
	Connection conn=null;


	try {
	conn = RwsOffices.getConn();

	Statement pstmt = conn.createStatement();
	ResultSet rs1 = null;
	String query="";

			 query = "delete from  rws_ee_ds_tbl where circle_office_code=? and division_office_code=? and pao_code=?";
		Debug.println("delQuery************************:" + query);
		PreparedStatement ps= conn.prepareStatement(query);
		ps.setString(1, dr.getCircleOffice());
		ps.setString(2, dr.getDivisionOffice());
		ps.setString(3, dr.getPaoCode());
		count = ps.executeUpdate();
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
	public static String getDateofR(String pao) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select DOR_IN_PRESENT_POTS   from rws_ee_ds_tbl where pao_code='"+pao+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				name = eeMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}
	//
	public static int getPaocodeexits(String circle,String division) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		int i=0;

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select  count(*)    from rws_ee_ds_tbl where  circle_office_code='"+circle+"' and division_office_code='"+division+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				i = eeMasterData.rs1.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return i;
	}

	//
	public static String getCircleName(String circle) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select circle_office_name  from rws_circle_office_tbl where circle_office_code='"+circle+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				name = eeMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}

	//
	public  String getPaoName(String circle,String division, ExecutiveEForm frm) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select PAO_CODE , ee_name, to_char(DOJ_IN_PRESENT_POST,'dd/mm/yyyy'),to_char(DOR_IN_PRESENT_POTS,'dd/mm/yyyy')  from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("setting form***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			
			
			while (eeMasterData.rs1.next()) {
				frm.setPaoCode(eeMasterData.rs1.getString(1));
				frm.setEeName(eeMasterData.rs1.getString(2));
				frm.setDateofPresent(eeMasterData.rs1.getString(3));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}
	//
	public  String getPName(String circle,String division) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select PAO_CODE   from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			
			
			while (eeMasterData.rs1.next()) {
				ExecutiveEForm executiveEForm=new ExecutiveEForm();
				executiveEForm.setPaoCode(eeMasterData.rs1.getString(1));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}

	//
	public static String getPaoComp(String circle,String division) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select PAO_CODE   from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				name = eeMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}

	//
	public static int getPaoCount(String circle,String division) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		int i= 0;

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select count(*)  from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				i = eeMasterData.rs1.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return i;
	}


	//
	public static String getPaoCompDate(String circle,String division,String pao) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select to_char(DOR_IN_PRESENT_POTS,'dd/mm/yyyy')    from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"' and pao_code='"+pao+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				name = eeMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}

	//
	public static String getdateofName(String circle,String division) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select to_char(DOJ_IN_PRESENT_POST,'dd/mm/yyyy')    from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				name = eeMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}


	//
	public static String getdateofPName(String circle,String division) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select to_char(DOR_IN_PRESENT_POTS,'dd/mm/yyyy')     from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				name = eeMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}

	//
	public static String getEEName(String circle,String division) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select EE_NAME    from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				name = eeMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}

	//
	public static String getDivisionName(String circle,String division) {

		EEMasterData eeMasterData = new EEMasterData();
		IfscbankForm ifscbankForm = null;
		String query = "";
		String name= "";

		try {
			eeMasterData.conn = RwsOffices.getConn();
			query = "select division_office_name  from rws_division_office_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"'";
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				name = eeMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (eeMasterData.rs1 != null)
					eeMasterData.rs1.close();
				if (eeMasterData.stmt1 != null)
					eeMasterData.stmt1.close();
				if (eeMasterData.conn != null)
					eeMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return name;
	}
	
	public String paoCodeExists(String circle,String division,String paoCode){
		EEMasterData eeMasterData = new EEMasterData();
		String query="";
		String paoCodeExists="";
		try{
			eeMasterData.conn = RwsOffices.getConn();			
			query="select pao_code from rws_ee_ds_tbl where circle_office_code='"+circle+"' and division_office_code='"+division+"' and pao_code='"+paoCode+"'";			
			eeMasterData.stmt1 = eeMasterData.conn.createStatement();			
			eeMasterData.rs1 = eeMasterData.stmt1.executeQuery(query);
			while (eeMasterData.rs1.next()) {
				paoCodeExists = eeMasterData.rs1.getString(1);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (eeMasterData.rs1 != null)
				eeMasterData.rs1.close();
			if (eeMasterData.stmt1 != null)
				eeMasterData.stmt1.close();
			if (eeMasterData.conn != null)
				eeMasterData.conn.close();
		} catch (Exception e) {
		}
	}
	return paoCodeExists;
	}
	
	public static int deleteEERegDscToken(ExecutiveEForm dr,String circle,String division,String pao)
	throws Exception {
	int count = 0;
	Connection conn=null;
	try {
	conn = RwsOffices.getConn();

	Statement pstmt = conn.createStatement();
	String query="";
		 query = "delete from  rws_ee_ds_reg_tbl where circle_office_code=? and division_office_code=? and pao_code=?";
		PreparedStatement ps=  conn.prepareStatement(query);
		ps.setString(1, circle);
		ps.setString(2, division);
		ps.setString(3,pao);
		 count = ps.executeUpdate();
	if (count > 0) {
		conn.commit();
	} else
		conn.rollback();
	} catch (Exception e) {
	e.printStackTrace();
	}
	return count;

	}
	
	
}
