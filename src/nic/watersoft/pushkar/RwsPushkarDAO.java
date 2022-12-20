package nic.watersoft.pushkar;

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
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.*;

public class RwsPushkarDAO {
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

	private LabelValueBean labelValueBean = null;
	public  void closeAll() throws Exception {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in RwsPushkarDAO" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in RwsPushkarDAO" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in RwsPushkarDAO" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in RwsPushkarDAO" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in RwsPushkarDAO" + e);
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
	

public  int insertPushkar(DataSource dataSource,String dcode, String mcode,String pcode,String PUSHKAR_CODE,String PUSHKAR_NAME,String pushkartype) throws Exception {   
		
	
		String query="";
		int rcount=0;

		try {
			conn = RwsOffices.getConn();
			
			query = " update RWS_PUSHKAR_GHAT_TBL set PUSHKAR_NAME=? where dcode=? and mcode=? and pcode=? and PUSHKAR_CODE =? and GHAT_TYPE =? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, PUSHKAR_NAME);
			ps.setString(2, dcode);
			ps.setString(3, mcode);
			ps.setString(4, pcode);
			ps.setString(5, PUSHKAR_CODE);
			ps.setString(6, pushkartype);
			
			rcount = ps.executeUpdate();
	
			
		
	} catch (Exception e) {
		e.printStackTrace();
		Debug.println("The error in insertPUSHKAR=" + e);
	} finally {
		
		closeAll();
	}
	return rcount;
}
	
	
public ArrayList getDistricts() throws Exception {
		ArrayList dists = new ArrayList();
		Connection conn=null;
		String query=null;
		ResultSet rset=null;
		try {
			
			conn = RwsOffices.getConn();
			query = " SELECT dcode, dname " + " FROM rws_district_tbl " + "  "
					+ " where dcode in('04','05','06','07','13') ORDER BY dcode,dname";

			
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();
			

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in pushkar getDistricts is "+e);
		} finally {
			closeAll();
		}

		return dists;
	}	
	
		
	
public String getContamCode(DataSource dataSource,String dcode,String mcode,String pcode ) throws Exception {
	
		String code = null;
			
		
		try {
			
			
			conn = RwsOffices.getConn();
			
			
			
			String query="SELECT MAX(to_number(pushkar_code))+1 FROM RWS_PUSHKAR_GHAT_TBL where dcode=? and mcode=? and pcode=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			
			rs = ps.executeQuery();
			rs.next();
			code = rs.getString(1);
			if (code == null) {
				code = "001";
			} else if (code.length() == 1) {
				code = "00" + code;
			}
			else if(code.length()==2)
			{
				code = "0" + code;
				
			}
		} catch (Exception e) {
			Debug.println("The error in getContamCode=" + e);
		} finally {
			closeAll();
		}
		return code;
	}
	
	
	
	public  String deletePushkar(DataSource dataSource,String dcode, String mcode,String pcode,String vcode,String ghattype) throws Exception {   
		
		String query="";
		String msg="";
		int rcount=0;
		

		try {
			conn = RwsOffices.getConn();
			
			query = " delete  from RWS_PUSHKAR_GHAT_TBL   where dcode=? and mcode=? and pcode=? and PUSHKAR_CODE=? AND GHAT_TYPE =?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			ps.setString(5, ghattype);			
			
			rcount = ps.executeUpdate();
			
			if(rcount>0)
				msg="Record Deleted Successfully";
			else
				msg="Record Cannot be deleted";
			
			
		
	} catch (Exception e) {
		msg="Record Cannot be Deleted";
		Debug.println("The error in deletePushkar=" + e);
	} finally {
		
		closeAll();
	}
	return msg;
}
	
public  String insertNewPushkar(DataSource dataSource,String dcode, String mcode,String pcode,String PUSHKAR_CODE,String PUSHKAR_NAME,String pushkartype) throws Exception {   
		
		
		String query="";
		String msg="";
		boolean codeAlreadyExists=false;
		int rcount=0;

		try {
			conn = RwsOffices.getConn();
			
			query= " select * from RWS_PUSHKAR_GHAT_TBL  where dcode=? and mcode=? and pcode=? and PUSHKAR_CODE=? and GHAT_TYPE =?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, PUSHKAR_CODE);
			ps.setString(5, pushkartype);
			
			rs = ps.executeQuery();
			while(rs.next())
			{
				msg="Duplicate Code: Code Already  assigned to "+rs.getString("PUSHKAR_NAME")+" for GhatType "+rs.getString("GHAT_TYPE")+". Try Again";
				codeAlreadyExists=true;				
			}
			ps.close();
			
			if(!codeAlreadyExists)
			{
			query = " insert into RWS_PUSHKAR_GHAT_TBL(dcode,mcode,pcode,PUSHKAR_CODE,PUSHKAR_NAME,GHAT_TYPE) values(?,?,?,?,?,?)";
			ps = conn.prepareStatement(query);					
			
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, PUSHKAR_CODE);
			ps.setString(5, PUSHKAR_NAME);
			ps.setString(6, pushkartype);
			
			rcount = ps.executeUpdate();
			
			if(rcount>0)
			msg="Record Inserted Successfully";
			else
			msg="Record Cannot be inserted";
			}
		
	} catch (Exception e) {
		
		Debug.println("The error in insertPUSHKARdetailss=" + e);
		msg="Record Cannot be Inserted";
		
	} finally {
		
		closeAll();
	}
	return msg;
}
	
public  ArrayList getpushkarDetails(String dcode, String mcode,String pcode,String pushkartype,DataSource dataSource) throws Exception {   
		PushkarGhatForm rwsMaster = null;
		ArrayList villageDetails = new ArrayList();
		String query="";
		

		try {
			conn = RwsOffices.getConn();
			
			query = " SELECT D.DCODE,D.DNAME,M.MCODE,M.MNAME,P.PCODE,P.PNAME,V.PUSHKAR_CODE,V.PUSHKAR_NAME,GHAT_TYPE  FROM RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_PANCHAYAT_TBL P,RWS_PUSHKAR_GHAT_TBL V "
				+ " WHERE D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE=P.MCODE AND P.DCODE=V.DCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE  AND D.DCODE = ? "
				+ " AND M.MCODE = ? AND V.PCODE=?"
				+ " ORDER BY d.dcode,m.mcode,p.pcode,V.PUSHKAR_CODE ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
	
			rs = ps.executeQuery();
			
	while (rs.next()) {
		rwsMaster = new PushkarGhatForm();

		rwsMaster.setDcode(rs.getString("DCODE"));
		rwsMaster.setDname(rs.getString("DNAME"));
		rwsMaster.setMcode(rs.getString("MCODE"));
		rwsMaster.setMname(rs.getString("MNAME"));
		rwsMaster.setPcode(rs.getString("PCODE"));
		rwsMaster.setPname(rs.getString("PNAME"));
		rwsMaster.setVcode(rs.getString("PUSHKAR_CODE"));
		rwsMaster.setVname(rs.getString("PUSHKAR_NAME"));
		rwsMaster.setPushkartype(rs.getString("GHAT_TYPE"));
		villageDetails.add(rwsMaster);
	}
			
		
	} catch (Exception e) {
		Debug.println("The error in getpushkarDetails=" + e);
	} finally {
		
		closeAll();
	}
	return villageDetails;
}
	
public  String getpushkarName(DataSource request,String dcode, String mcode,
		String pcode, String vcode ,String vname,String pushkartype ) throws Exception {   
		
	
	
		String name = null;
	
	try {
		conn = RwsOffices.getConn();
		String query="select PUSHKAR_NAME  from RWS_PUSHKAR_GHAT_TBL  where DCODE=? and mcode=? and PCODE=? and PUSHKAR_CODE =? ";
		ps = conn.prepareStatement(query);
		ps.setString(1, dcode);
		ps.setString(2, mcode);
		ps.setString(3, pcode);
		ps.setString(4, vcode);
		rs1 = ps.executeQuery();
		rs1.next();
		name = rs1.getString(1);
	} catch (Exception e) {
		
		Debug.println("Ther error in getpushkarName=" + e);
	} finally {
		closeAll();
	}
	return name;
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

}
