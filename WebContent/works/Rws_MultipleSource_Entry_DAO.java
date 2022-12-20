/*
 * Created on 26-04-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.SubCompMetaData;

/**
 * @author user
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_MultipleSource_Entry_DAO
{
	Connection conn=null; 
	private LabelValueBean labelValueBean = null;
	public ArrayList getWorkDetails(String Workid,HttpServletRequest request)
	{
		ArrayList data=new ArrayList();  
		
		Statement stmt=null,stmt1=null,stmt2=null,stmt3=null;          
		ResultSet rs=null,rs1=null,rs2=null,rs3=null; 
		try{
	         conn=RwsOffices.getConn(); 
	         String qry=" SELECT distinct a.work_id,e.work_name,mname,pname,HAB_CODE, c.SOURCE_TYPE_NAME,d.SUBSOURCE_TYPE_NAME,SOURCE_CODE ,a.SOURCE_NAME from rws_source_iden_fin_tbl a,rws_mandal_tbl b , RWS_SOURCE_type_TBL c, RWS_subSOURCE_type_TBL d ,rws_work_admn_tbl e,rws_panchayat_tbl f  where a.work_id=e.work_id and a.WORK_ID ='"+Workid+"' and b.dcode=substr(a.hab_Code,1,2) and b.mcode=substr(a.hab_Code,6,2) and f.dcode=substr(a.hab_Code,1,2) and f.mcode=substr(a.hab_Code,6,2) and f.pcode=substr(a.hab_Code,13,2) and c. SOURCE_TYPE_CODE= a. SOURCE_TYPE_CODE and c.SOURCE_TYPE_CODE=d.SOURCE_TYPE_CODE  and  d.SUBSOURCE_TYPE_CODE=a.SUBSOURCE_TYPE_CODE";
	    	 stmt=conn.createStatement();
			 Debug.println("qry of wd:"+qry);
			 rs=stmt.executeQuery(qry);
	    	 while(rs.next()) 
	        {
		
	    		 Rws_MultipleSource_Entry_form frm=new Rws_MultipleSource_Entry_form();
	    		 frm.setWorkid(rs.getString(1));
	    		 frm.setWorkname(rs.getString(2));
	    		 frm.setMandal(rs.getString(3));
				 frm.setPanchayat(rs.getString(4));
				 frm.setSourcehab(rs.getString(5));
				 frm.setSourcetype(rs.getString(6));
				 frm.setSubsourcetype(rs.getString(7));
				 frm.setSource(rs.getString(8));
				 frm.setSourcename(rs.getString(9));
		 	 	 data.add(frm);
	        }
	 
			 
	 }
	
	catch(Exception e)
	{
		Debug.println("Exception in getWorkDetails Method:"+e);
		e.printStackTrace();
	}
	finally
	{
		try
		{
			   if(rs!=null)
				rs.close();
			   if(stmt!=null)
			   stmt.close();
		}
		catch(Exception e)
		{
			
		}
	}
	return data;
	}

	
public ArrayList getMandals( String workid)
	throws Exception {
Debug.println("trying to get the mandals.....");
ArrayList mtenderMemo = null;
String query = null;
Statement st=null;
ResultSet rs=null;
try {
	conn = RwsOffices.getConn();
	query = "SELECT distinct mcode,mname from rws_mandal_tbl b,rws_work_admn_tbl e where e.WORK_ID ='"+workid+"' and b.dcode=substr(e.work_id,5,2) order by mname";
	Debug.println("Query:" + query);
	st = conn.prepareStatement(query);
	rs = st.executeQuery(query);
	tenderMemo tendermemo = null;
	mtenderMemo = new ArrayList();
	while (rs.next())
	{
		tendermemo = new tenderMemo();
		tendermemo.setMandalCode(rs.getString(1));
		tendermemo.setMandalName(rs.getString(2));
		mtenderMemo.add(tendermemo);
	}
} catch (Exception e) {
	Debug.println("The error in getMandals()=== Works Data " + e);
	e.printStackTrace();
} finally {
	if (rs != null)
		rs.close();
	if (st != null)
		st.close();
	if (conn != null)
		conn.close();
}
Debug.println("3.5:" + mtenderMemo.size());
return mtenderMemo;
}

public ArrayList getMandalHabs( String workid,String mcode)
throws Exception {
Debug.println("trying to get the habs.....");
ArrayList mtenderMemo = null;
String query = null;
Statement st=null;
ResultSet rs=null;
String dist=workid.substring(4,6);
try {
conn = RwsOffices.getConn();
query = "SELECT  distinct P.panch_code, P.panch_name FROM rws_panchayat_raj_tbl P,  rws_habitation_directory_tbl H,rws_habitation_directory_tbl hd,rws_mandal_tbl m WHERE hd.hab_code=p.panch_code and hd.hab_code=h.hab_code and P.panch_code = H.hab_code AND  H.circle_office_code = '"+dist+"' and substr(p.panch_code,6,2)='"+mcode+"'  and h.circle_office_code=m.dcode and m.mcode='"+mcode+"' and hd.coverage_status <> 'UI' and hd.coverage_status is not null order by P.panch_name";
Debug.println("Query:" + query);
st = conn.prepareStatement(query);
rs = st.executeQuery(query);
tenderMemo tendermemo = null;
mtenderMemo = new ArrayList();
while (rs.next())
{
	tendermemo = new tenderMemo();
	tendermemo.setPanchCode(rs.getString(1));
	tendermemo.setPanchName(rs.getString(2)+" - "+rs.getString(1));
	mtenderMemo.add(tendermemo);
}
} catch (Exception e) {
Debug.println("The error in getMandals()=== Works Data " + e);
e.printStackTrace();
} finally {
if (rs != null)
	rs.close();
if (st != null)
	st.close();
if (conn != null)
	conn.close();
}
Debug.println("3.5:" + mtenderMemo.size());
return mtenderMemo;
}

public ArrayList getSubCompType(String assetCode)
{
	String query = null;
	Statement stmt=null;
	ResultSet rset=null;
	ArrayList mtenderMemo = null;

	try {
		conn = RwsOffices.getConn();
		Debug.println("asset code:" + assetCode);
		query = "SELECT * FROM RWS_SOURCE_TYPE_TBL order by SOURCE_TYPE_CODE";
		Debug.println(query);
		stmt = conn.createStatement();
		rset = stmt.executeQuery(query);
		tenderMemo tendermemo = null;
		mtenderMemo = new ArrayList();
		if (!assetCode.equals("04")) {
			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setSubCompCode(rset.getString(1));
				tendermemo.setSubCompName(rset.getString(2));

				mtenderMemo.add(tendermemo);
			}
		} else {
			tendermemo = new tenderMemo();

			tendermemo.setSubCompCode("1");
			tendermemo.setSubCompName("SUBSURFACE SOURCE");

			mtenderMemo.add(tendermemo);
		}
	} catch (Exception e) {
		Debug.println("Exception SubCompType:" + e);
	} finally {
		try {
			if (rset != null)
				rset.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			Debug.println("EXCEPTION IN CLOSING CONNECTION"
					+ e.getMessage());
			e.printStackTrace();
		}
	}
	return mtenderMemo;
}

//added by ramesh for getting sub source type in source identification
// phase

public ArrayList getSubSourceTypes(	String subSourceCode, String assetCode) 
{
	String query = null;
	Statement stmt=null;
	ResultSet rset=null;
	ArrayList ntenderMemo = null;
	try {
		conn = RwsOffices.getConn();
		query = "SELECT * FROM RWS_SUBSOURCE_TYPE_TBL where source_type_code="+ subSourceCode + " order by SUBSOURCE_TYPE_CODE";
		Debug.println(query);
		stmt = conn.createStatement();
		rset = stmt.executeQuery(query);
		tenderMemo tendermemo = null;
		ntenderMemo = new ArrayList();
		if (!assetCode.equals("04")) {
			while (rset.next()) {
				tendermemo = new tenderMemo();

				tendermemo.setSubCompCode(rset.getString(2));
				tendermemo.setSubCompName(rset.getString(3));

				ntenderMemo.add(tendermemo);
			}
		} else if (assetCode.equals("04")) {
			tendermemo = new tenderMemo();

			tendermemo.setSubCompCode("1");
			tendermemo.setSubCompName("BOREWELL");

			ntenderMemo.add(tendermemo);
		}

	} catch (Exception e) {
		Debug.println("Exception SubCompType:" + e);
		e.printStackTrace();
	} finally {
		try {
			if (rset != null)
				rset.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			Debug.println("EXCEPTION IN CLOSING CONNECTION"
					+ e.getMessage());
		}
	}
	return ntenderMemo;
}

public ArrayList getSourceCodes(String sourceType,String habCode) throws Exception
{
	RwsMaster rwsMaster = null;
	ArrayList sourceCodes = new ArrayList();
	Statement stmt=null;
	ResultSet rset=null;
	
	SubCompMetaData subCompMetaData = new SubCompMetaData(sourceType
			.substring(0, 2), sourceType.substring(4, 5), sourceType
			.substring(5, 6), habCode);
	try {
		conn = RwsOffices.getConn();
		stmt = conn.createStatement();
		String query = "";
		query = "SELECT DISTINCT SOURCE_CODE,SOURCE_NAME FROM RWS_SOURCE_TBL WHERE HAB_CODE='"
				+ habCode
				+ "'  and SOURCE_TYPE_CODE = '"
				+ sourceType.substring(4, 5)
				+ "' and SUBSOURCE_TYPE_CODE ='"
				+ sourceType.substring(5, 6)
				+ "' and source_code not like '%HP%'";
		Debug.println("3:" + sourceType);
		Debug.println("query to get source codes:: " + query);
		rset = stmt.executeQuery(query);
		while (rset.next()) 
		{
			rwsMaster = new RwsMaster();
			String sName = rset.getString(2);
			if (sName == null) {
				sName = "";
			}
			Debug.println("sourceCode in rwsWQualityData is "
					+ rset.getString(1));
			rwsMaster.setSourceCode(rset.getString(1) + "-" + sName);
			rwsMaster.setSourceName(rset.getString(2));
			Debug.println("Source Code:" + rwsMaster.getSourceCode());
			sourceCodes.add(rwsMaster);
		}

	} catch (Exception e) {
		Debug.println("Exception is getSourceCodes:" + e.getMessage());
	} finally {
		try {
			if (rset != null)
				rset.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			Debug.println("EXCEPTION IN CLOSING CONNECTION"
					+ e.getMessage());
			e.printStackTrace();
		}
	}
	return sourceCodes;
}


public String getNewSourceCodes(String sourceType,String habCode, String workId) throws Exception {
	RwsMaster rwsMaster = null;
	String formed_source_code = "";
	Statement stmt=null;
	ResultSet rset=null;
	SubCompMetaData subCompMetaData = new SubCompMetaData(sourceType.substring(0, 2), sourceType.substring(4, 5), sourceType.substring(5, 6), habCode);
	try {
		String compCode = subCompMetaData.getSubCompRep();
		String insertTable = subCompMetaData.getTableName();
		String schemeCodeField = subCompMetaData.getSchemeCodeField();
		
		conn = RwsOffices.getConn();
		stmt = conn.createStatement();
		String query = "select CODE_SERIES from RWS_ASSET_TYPE_TBL where TYPE_OF_ASSET_CODE='"+ sourceType.substring(0, 2) + "'";
		Debug.println("Query :::::" + query);
		ResultSet rs = stmt.executeQuery(query);
		String schemeCode = "";
		if (rs.next())
		{
			schemeCode = rs.getString(1);
		}
		Debug.println("Schemee COde:" + schemeCode);
		Debug.println("Table Name:" + insertTable);
	
		if (stmt != null)
			stmt.close();
		    stmt = conn.createStatement();
		
		query = "select " + schemeCodeField + " from " + insertTable
			+ " where hab_code like '" + habCode
			+ "%' order by substr(" + schemeCodeField + ",22,3)";
		Debug.println("get data:" + query);
		rs = stmt.executeQuery(query);
		String maxCode = "";
		while (rs.next())
		{
			maxCode = rs.getString(1);
		}
		Debug.println("Max Code:" + maxCode);
		int slno = 001;
		if (maxCode != null && maxCode.length() != 0
				&& maxCode.length() == 24)
		{
			slno = Integer.parseInt(maxCode.substring(21, 24));
			slno++;
		}
		String temp = "" + slno;
		String finalSlNo = "";
		if (temp.length() == 1)
        {
			finalSlNo = "00" + temp;
		} else if (temp.length() == 2) 
		{
			finalSlNo = "0" + temp;
		} else if (temp.length() == 3)
		{
			finalSlNo = temp;
		}
		Debug.println("Sl No:" + slno);
		Debug.println("Final Sl No:" + finalSlNo);
		formed_source_code = habCode + schemeCode + compCode + finalSlNo;
		Debug.println("formed_source_code:" + formed_source_code);
	}
	catch (Exception e)
	{
		Debug.println("Exception is getSourceCodes:" + e.getMessage());
		e.printStackTrace();
	} finally {
		try {
			if (rset != null)
				rset.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			Debug.println("EXCEPTION IN CLOSING CONNECTION"
					+ e.getMessage());
		}
	}
	return formed_source_code;
}

public int SourceIdenInsert(Rws_MultipleSource_Entry_form worksBean, String officeCode)
{   
	
	String workCode = worksBean.getNwork();	
	Debug.println("work id:1:" + workCode);
	int count = 0;
	int d1 = 0, d2 = 0;
	Debug.println("in SrcIdenInsert");
	String comp = worksBean.getSpradgroup();
	Debug.println("radio button:" + comp);
	//String status=worksBean.getCodeStatus();
	String srccode = worksBean.getExtSourceCode();
	String qqry1 = "", qry1 = "",query="";
	String insQuery = "";
	Debug.println("srccode" + worksBean.getExtSourceCode());
	Debug.println("comp" + worksBean.getCodeStatus());

	String assetCode = "";
	PreparedStatement pstat=null;
	ResultSet rset=null;
	
	try {
		conn = RwsOffices.getConn();
		conn.setAutoCommit(false);
		assetCode = workCode.substring(6, 8);
		String sourceCode = "", sourceName = "";
		if (comp.equals("existSource")) 
		{
			sourceCode = worksBean.getExtSourceCode().substring(0, 24);
			sourceName = worksBean.getExtSourceName();
		} else if (comp.equals("newSource"))
		{
			sourceCode = worksBean.getNewSourceCode();
			sourceName = worksBean.getNewSourceName();
		}
		/*String qqry = "delete from rws_source_iden_fin_tbl where work_id='"
				+ workCode + "'";
		Statement newst = conn.createStatement();
		d1 = newst.executeUpdate(qqry);
		qry1 = "delete from rws_source_tbl where asset_code='" + workCode
				+ "'";
		d2 = newst.executeUpdate(qry1);*/
		Debug.println("d2:" + d2);
		if (comp.equals("newSource"))
		{
			insQuery = "insert into rws_source_tbl (source_code,source_name,source_type_code,subsource_type_code,hab_code,asset_code) values('"
					+ sourceCode
					+ "','"
					+ sourceName
					+ "','"
					+ worksBean.getSubcompType()
					+ "','"
					+ worksBean.getSubSourceType()
					+ "','"
					+ worksBean.getSitehab() + "','" + workCode + "')";
			Debug.println("insert new source query1:" + insQuery);
			Statement insSt = conn.createStatement();
			insSt.executeUpdate(insQuery);
		}
		query = "insert into rws_source_iden_fin_tbl(HAB_CODE,SOURCE_CODE,SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,SITE_HAND_OVER_DATE,REMARKS,"
				+ " EMPLOYEE_CODE,office_code,work_id,TYPE_OF_ASSET_CODE,SOURCE_NAME,UPDATE_DATE) values('"
				+ worksBean.getSitehab()
				+ "',"
				+ " '"
				+ sourceCode
				+ "','"
				+ worksBean.getSubcompType()
				+ "','"
				+ worksBean.getSubSourceType()
				+ "',to_date('30/04/2013','dd/mm/yyyy'),"
				+ " '"
				+ worksBean.getRecommend()
				+ "','"
				+ worksBean.getSourceIdentby()
				+ "','"
				+ officeCode
				+ "',"
				+ "'"
				+ workCode
				+ "','"
				+ worksBean.getSchemeCode()
				+ "','"
				+ sourceName
				+ "',SYSDATE)";
		Debug.println("insert source identification query:" + query);
		assetCode = worksBean.getSchemeCode();
		//assetCode = workCode.substring(6, 8);
		pstat = conn.prepareStatement(query);
		count = pstat.executeUpdate();
		if (d1 > 0 && d2 > 0) {
			count = 2;
		}
		conn.setAutoCommit(true);
	} catch (Exception e) {
		Debug.println("Exception SrcIdenInsert:" + e);
		e.printStackTrace();
	} finally {
		try {
			if (pstat != null)
				if (pstat != null)
					pstat.close();
			if (conn != null)
				conn.close();
		} catch (Exception e)
		{
			//Debug.println("EXCEPTION IN CLOSING CONNECTION"+ e.getMessage());
			e.printStackTrace();
		}
	}
	return count;

}




}
