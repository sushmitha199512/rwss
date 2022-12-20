/*
 * Created on Aug 6, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;

/**
 * @author vikas
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */


import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import java.sql.SQLException;
import java.sql.Statement;
import java.sql.DriverManager;
//import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import javax.servlet.http.HttpSession;


import javax.sql.DataSource;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.DAOMessage;
import nic.watersoft.commons.RwsOffices;

public class ReportsMasterData
{

	public static int connCount=0;
	Connection conn = null;
	
	Statement stmt = null;

	Statement stmt1 = null;
	
	Statement stmt2 = null;
	
	Statement stmt3 = null;
	
	Statement stmt4 = null;

	ResultSet rs = null;

	static ResultSetMetaData rsm = null;

	ResultSet rs1 = null;
	
	ResultSet rs2 = null;
	
	ResultSet rs3 = null;
	
	ResultSet rs4 = null;

	static PreparedStatement ps = null;

	static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	public static String errorMessage;

	//static HttpSession session;

	public ReportsMasterData()
	{
		connCount++;
		//Debug.println("RwsMasterData Object Created");
		//Debug.println("connCount from RwsMasterData() is"+connCount);
		
		
	}
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
				if(conn.isClosed())
				connCount--;
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}
		
	}
	
	
	public  static int getState(DataSource dataSource,HttpSession session)throws Exception
	{
		ArrayList state=new ArrayList();
		ArrayList state1=new ArrayList();
		ReportsMasterData reportsMasterData=new ReportsMasterData();
		String query=null;
		String query1=null;
		String query11=null;
		String query12=null;
			
		ArrayList statenames=new ArrayList();
		String total;
		String total1;		
		
		try
		{
			reportsMasterData.conn=dataSource.getConnection();
			reportsMasterData.stmt=reportsMasterData.conn.createStatement();
			//reportsMasterData.stmt1=reportsMasterData.conn.createStatement();
			
			query="CREATE OR REPLACE VIEW COVERAGE_PRESENT_YEAR AS SELECT sum(case when h.coverage_status='FC' then 1 else 0 end) as FC, " +
					"sum(case when h.coverage_status='PC1' then 1 else 0 end) as PC1,"+
					"sum(case when h.coverage_status='PC2' then 1 else 0 end) as PC2,"+
					"sum(case when h.coverage_status='PC3' then 1 else 0 end) as PC3,"+
					"sum(case when h.coverage_status='PC4' then 1 else 0 end) as PC4,"+
					"sum(case when h.coverage_status='NC' then 1 else 0 end) as NC," +
					"sum(case when h.coverage_status='NSS' then 1 else 0 end) as NSS," +
					"count(*) as total from rws_habitation_directory_tbl h,rws_panchayat_raj_tbl raj,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where h.hab_code=raj.panch_code and h.coverage_status is not null and h.coverage_status<>'UI' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and substr(h.hab_code,1,2)=d.dcode and substr(h.hab_code,6,2)=m.mcode and substr (h.hab_code,13,2)=p.pcode and substr(h.hab_code,8,3)=v.vcode  ";
		//query for previous year data to be displayed i.e:2007 YEAR
			/*query1="CREATE OR REPLACE VIEW COVERAGE_PREVIOUS_YEAR AS SELECT sum(case when h.coverage_status='PC1' then 1 else 0 end) as PC1,"+
					"sum(case when h.coverage_status='PC2' then 1 else 0 end ) as PC2,"+
					"sum(case when h.coverage_status='PC3' then 1 else 0 end ) as PC3,"+
					"sum(case when h.coverage_status='PC4' then 1 else 0 end ) as PC4,"+
					"sum(case when h.coverage_status='NC' then 1 else 0 end) as NC,"+
					"sum(case when h.coverage_status='NSS' then 1 else 0 end) as NSS,"+
					"sum(case when h.coverage_status='FC' then 1 else 0 end) as FC,count(*) as total from RWS_HABITATION_DIR_HIS_TBL h where h.coverage_status is not null and  h.coverage_status<>'UI' and status_date='"+prevYear+"' ";*/
			
			Debug.println("ALL Districts "+query);
			reportsMasterData.stmt.executeUpdate(query);
			//reportsMasterData.stmt1.executeUpdate(query1);
			query11="SELECT * FROM COVERAGE_PRESENT_YEAR";
			/*query12="SELECT * FROM COVERAGE_PREVIOUS_YEAR";*/
			reportsMasterData.rs=reportsMasterData.stmt.executeQuery(query11);
			/*reportsMasterData.rs1=reportsMasterData.stmt1.executeQuery(query12);*/
			while(reportsMasterData.rs.next())// && reportsMasterData.rs1.next())
			{
				for(int i=0,j=1;i<=7;i++,j++)
				{
					statenames.add(i,reportsMasterData.rs.getMetaData().getColumnName(j));
					state.add(i,reportsMasterData.rs.getString(j));
					/*state1.add(i,reportsMasterData.rs1.getString(j));*/
				}
			}
			session.setAttribute("statenames",statenames);
			session.setAttribute("state",state);
			//session.setAttribute("state1",state1);
			query11="drop view COVERAGE_PRESENT_YEAR";
			/*query12="drop view COVERAGE_PREVIOUS_YEAR";*/
			reportsMasterData.stmt.executeUpdate(query11);
			/*reportsMasterData.stmt1.executeUpdate(query12);*/
		}catch(Exception e)
		{
			System.out.println("Exception in getState"+e);
		} finally {
			reportsMasterData.closeAll();
			//Debug.println("connCount after closing is "+connCount);
		}
		
		return 1;
	}
	
	
	public static ArrayList getDistricts(DataSource dataSource,HttpSession session) throws Exception 
	{
				
		String dist=(String)session.getAttribute("districtsrep");
		String mand=(String)session.getAttribute("mandalsrep");
	
		ReportsMasterData reportsMasterData=new ReportsMasterData();
		ReportsForm reportsForm=null;
		String query=null;
		String query1=null;
		
		ArrayList state=new ArrayList();
		ArrayList state1=new ArrayList();
		ArrayList total=new ArrayList();
		int totfc=0,totpc1=0,totpc2=0,totpc3=0,totnc=0,totnss=0,totpc4=0;
		try
		{
			reportsMasterData.conn=dataSource.getConnection();
			reportsMasterData.stmt=reportsMasterData.conn.createStatement();
			//reportsMasterData.stmt1=reportsMasterData.conn.createStatement();
			
			if(dist.equals("ALL") && mand.equals("ALL"))
			{
				query="CREATE OR REPLACE VIEW COVERAGE_PRESENT_YEAR AS SELECT DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1, SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2, SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3, SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC, SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) as TOTAL from rws_habitation_directory_tbl HD,rws_panchayat_raj_tbl raj,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where HD.hab_code=raj.panch_code and HD.coverage_status is not null and HD.coverage_status<>'UI' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and substr(HD.hab_code,1,2)=d.dcode and substr (HD.hab_code,6,2)=m.mcode and substr (HD.hab_code,13,2)=p.pcode and substr (HD.hab_code,8,3)=v.vcode  group by d.dcode,d.dname ";
				//query="CREATE OR REPLACE VIEW COVERAGE_PRESENT_YEAR AS SELECT DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) as TOTAL from rws_district_tbl d,rws_habitation_directory_tbl HD,rws_panchayat_raj_tbl raj where hd.hab_code=raj.panch_code and d.dcode=substr(HD.hab_code,1,2) and hd.coverage_status is not null and hd.coverage_status <> 'UI' and hd.status_date ='01-APR-"+currentYear+"'  group by d.dcode,d.dname ";
				//query for previous year Habitaitons to be displayed i.e :2007 year
				//query1="CREATE OR REPLACE VIEW COVERAGE_PREVIOUS_YEAR AS SELECT DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS from rws_district_tbl d,rws_habitation_dir_his_tbl HD where  d.dcode=substr(HD.hab_code,1,2) and  hd.coverage_status is not null and hd.coverage_status <> 'UI' and hd.status_date ='"+prevYear+"'  group by d.dcode,d.dname ";
			}
			/*
			if(!dist.equals("ALL") && mand.equals("ALL"))
			{
				System.out.println("in !dist==null");
				query="SELECT DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS from rws_district_tbl d,rws_habitation_directory_tbl HD where  d.dcode=substr(HD.hab_code,1,2) and hd.coverage_status is not null and hd.coverage_status <> 'UI' and hd.status_date ='01-APR-"+currentYear+"' and d.dcode='"+dist+"' group by d.dcode,d.dname";
				query1="SELECT DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS from rws_district_tbl d,rws_habitation_dir_his_tbl HD where  d.dcode=substr(HD.hab_code,1,2) and  hd.coverage_status is not null and hd.coverage_status <> 'UI' and hd.status_date ='"+prevYear+"' and d.dcode='"+dist+"' group by d.dcode,d.dname";

			}
			*/
						
			reportsMasterData.stmt.executeUpdate(query);
			//reportsMasterData.stmt1.executeUpdate(query1);
			Debug.println("ALL Districts "+query);
			query="SELECT * FROM COVERAGE_PRESENT_YEAR";
			//query1="SELECT * FROM COVERAGE_PREVIOUS_YEAR";
			
			reportsMasterData.rs=reportsMasterData.stmt.executeQuery(query);
			//reportsMasterData.rs1=reportsMasterData.stmt1.executeQuery(query1);
			
			
			while(reportsMasterData.rs.next())//&& reportsMasterData.rs1.next())
			{
				reportsForm=new ReportsForm();
				/*for(int i=0,j=1;i<=8;i++,j++)
				{
					state.add(i,reportsMasterData.rs.getString(j));
					state1.add(i,reportsMasterData.rs1.getString(j));
					rwsMaster.setEmpcode(rwsMasterData.rs.getString("EMPLOYEE_CODE"));
				}*/
				reportsForm.setDistcode(reportsMasterData.rs.getString(1));
				reportsForm.setDistname(reportsMasterData.rs.getString(2));
				reportsForm.setFC(reportsMasterData.rs.getString(3));
				totfc+=reportsMasterData.rs.getInt(3);//code added to retrieve the total of all columns
				reportsForm.setPC1(reportsMasterData.rs.getString(4));
				totpc1+=reportsMasterData.rs.getInt(4);
				reportsForm.setPC2(reportsMasterData.rs.getString(5));
				totpc2+=reportsMasterData.rs.getInt(5);
				reportsForm.setPC3(reportsMasterData.rs.getString(6));
				totpc3+=reportsMasterData.rs.getInt(6);
				reportsForm.setPC4(reportsMasterData.rs.getString(7));
				totpc4+=reportsMasterData.rs.getInt(7);
				reportsForm.setNC(reportsMasterData.rs.getString(8));
				totnc+=reportsMasterData.rs.getInt(8);
				reportsForm.setNSS(reportsMasterData.rs.getString(9));
				totnss+=reportsMasterData.rs.getInt(9);
				reportsForm.setTotal(reportsMasterData.rs.getString(10));
					
				/*
				reportsForm.setDistcode1(reportsMasterData.rs1.getString(1));
				reportsForm.setDistname1(reportsMasterData.rs1.getString(2));
				reportsForm.setFC1(reportsMasterData.rs1.getString(3));
				reportsForm.setPC11(reportsMasterData.rs1.getString(4));
				reportsForm.setPC21(reportsMasterData.rs1.getString(5));
				reportsForm.setPC31(reportsMasterData.rs1.getString(6));
				reportsForm.setPC41(reportsMasterData.rs1.getString(7));
				reportsForm.setNC1(reportsMasterData.rs1.getString(8));
				reportsForm.setNSS1(reportsMasterData.rs1.getString(9));
				*/
				
				state.add(reportsForm);
			}
			ArrayList totals=new ArrayList();
			int tot=totfc+totpc1+totpc2+totpc3+totpc4+totnc+totnss;
			
			totals.add(0,""+totfc);
			totals.add(1,""+totpc1);
			totals.add(2,""+totpc2);
			totals.add(3,""+totpc3);
			totals.add(4,""+totpc4);
			totals.add(5,""+totnc);
			totals.add(6,""+totnss);
			totals.add(7,""+tot);
		session.setAttribute("totalsD",totals);
		session.setAttribute("stateDist",state);
		//session.setAttribute("stateDist1",state1);
		
		query="DROP VIEW COVERAGE_PRESENT_YEAR";
		//query1="DROP VIEW COVERAGE_PREVIOUS_YEAR";
		
		reportsMasterData.stmt.executeUpdate(query);
		//reportsMasterData.stmt1.executeUpdate(query1);
	
		}catch(Exception e)
		{
			System.out.println("Exception in getDistrictsRep"+e.getMessage());
		}finally {
			reportsMasterData.closeAll();
		}
		return state;
	}
	
	public static ArrayList getMandals(DataSource dataSource,HttpSession session) throws Exception 
	{
		String dist=(String)session.getAttribute("districtsrep");
		String mand=(String)session.getAttribute("mandalsrep");
	
		ReportsMasterData reportsMasterData=new ReportsMasterData();
		ReportsForm reportsForm=null;
		String query=null;
		String query1=null;
		ArrayList state=new ArrayList();
		ArrayList state1=new ArrayList();
		int totfc=0,totpc1=0,totpc2=0,totpc3=0,totnc=0,totnss=0,totpc4=0;
		
		try
		{	
			reportsMasterData.conn=dataSource.getConnection();
			reportsMasterData.stmt=reportsMasterData.conn.createStatement();
			//reportsMasterData.stmt1=reportsMasterData.conn.createStatement();
			
			if(!dist.equals("ALL") && mand.equals("ALL"))
			{
				query="CREATE OR REPLACE VIEW COVERAGE_PRESENT_YEAR AS SELECT DISTINCT d.dcode,d.dname,m.mcode,m.mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) as TOTAL from rws_habitation_directory_tbl HD,rws_panchayat_raj_tbl raj,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where HD.hab_code=raj.panch_code and HD.coverage_status is not null and HD.coverage_status<>'UI' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and substr(HD.hab_code,1,2)=d.dcode and substr (HD.hab_code,6,2)=m.mcode and substr (HD.hab_code,13,2)=p.pcode and substr (HD.hab_code,8,3)=v.vcode  and d.dcode='"+dist+"' group by d.dcode,d.dname,m.mcode,m.mname ";
				//query="CREATE OR REPLACE VIEW COVERAGE_PRESENT_YEAR AS SELECT DISTINCT d.dcode,d.dname,m.mcode,m.mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) as TOTAL from rws_district_tbl d,rws_habitation_directory_tbl HD ,rws_mandal_tbl m,rws_panchayat_raj_tbl raj where  hd.hab_code=raj.panch_code and d.dcode=substr (HD.hab_code,1,2) and d.dcode=m.dcode and substr(hd.hab_code,6,2)=m.mcode and hd.coverage_status is not null and coverage_status <> 'UI' and status_date ='01-APR-"+currentYear+"' and d.dcode='"+dist+"' group by d.dcode,d.dname,m.mcode,m.mname";
				
//				query for previous year Habitaitons to be displayed i.e :2007 year
				//query1="CREATE OR REPLACE VIEW COVERAGE_PREVIOUS_YEAR AS SELECT DISTINCT d.dcode,d.dname,m.mcode,m.mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS from rws_district_tbl d,rws_habitation_dir_his_tbl HD,rws_mandal_tbl m where d.dcode=substr (HD.hab_code,1,2) and d.dcode=m.dcode and substr(hd.hab_code,6,2)=m.mcode and hd.coverage_status is not null and coverage_status <> 'UI' and hd.status_date ='"+prevYear+"' and d.dcode='"+dist+"' group by d.dcode,d.dname,m.mcode,m.mname";
			}	
			if(!dist.equals("ALL") && !mand.equals("ALL"))
			{
				query="CREATE OR REPLACE VIEW COVERAGE_PRESENT_YEAR AS SELECT DISTINCT d.dcode,d.dname,m.mcode,m.mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) as TOTAL from rws_habitation_directory_tbl HD,rws_panchayat_raj_tbl raj,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where HD.hab_code=raj.panch_code and HD.coverage_status is not null and HD.coverage_status<>'UI' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and substr(HD.hab_code,1,2)=d.dcode and substr (HD.hab_code,6,2)=m.mcode and substr (HD.hab_code,13,2)=p.pcode and substr (HD.hab_code,8,3)=v.vcode and  d.dcode='"+dist+"' and m.mcode='"+mand+"' group by d.dcode,d.dname,m.mcode,m.mname ";
//				query="CREATE OR REPLACE VIEW COVERAGE_PRESENT_YEAR AS SELECT DISTINCT d.dcode,d.dname,m.mcode,m.mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) as TOTAL from rws_district_tbl d,rws_habitation_directory_tbl HD,rws_mandal_tbl m,rws_panchayat_raj_tbl raj where hd.hab_code=raj.panch_code and d.dcode=substr (HD.hab_code,1,2) and d.dcode=m.dcode and substr(hd.hab_code,6,2)=m.mcode and hd.coverage_status is not null and coverage_status <> 'UI' and status_date ='01-APR-"+currentYear+"' and d.dcode='"+dist+"' and m.mcode='"+mand+"' group by d.dcode,d.dname,m.mcode,m.mname";
//				query for previous year Habitaitons to be displayed i.e :2007 year
				//query1="CREATE OR REPLACE VIEW COVERAGE_PREVIOUS_YEAR AS SELECT DISTINCT d.dcode,d.dname,m.mcode,m.mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS from rws_district_tbl d,rws_habitation_dir_his_tbl HD,rws_mandal_tbl m where d.dcode=substr (HD.hab_code,1,2) and d.dcode=m.dcode and substr(hd.hab_code,6,2)=m.mcode and hd.coverage_status is not null and coverage_status <> 'UI' and hd.status_date ='"+prevYear+"' and d.dcode='"+dist+"' and m.mcode='"+mand+"' group by d.dcode,d.dname,m.mcode,m.mname";
			}
			reportsMasterData.stmt.executeUpdate(query);
			//reportsMasterData.stmt1.executeUpdate(query1);
			
			query="SELECT * FROM COVERAGE_PRESENT_YEAR";
			//query1="SELECT * FROM COVERAGE_PREVIOUS_YEAR";
			
			reportsMasterData.rs=reportsMasterData.stmt.executeQuery(query);
			//reportsMasterData.rs1=reportsMasterData.stmt1.executeQuery(query1);

			while(reportsMasterData.rs.next())// && reportsMasterData.rs1.next())
			{
				reportsForm=new ReportsForm();
				/*
			
				for(int i=0,j=1;i<=10;i++,j++)
				{
					state.add(i,reportsMasterData.rs.getString(j));
					state1.add(i,reportsMasterData.rs1.getString(j));
				}*/
				
				reportsForm.setDistcode(reportsMasterData.rs.getString(1));
				reportsForm.setDistname(reportsMasterData.rs.getString(2));
				reportsForm.setMandcode(reportsMasterData.rs.getString(3));
				reportsForm.setMandname(reportsMasterData.rs.getString(4));
				reportsForm.setFC(reportsMasterData.rs.getString(5));
				totfc+=reportsMasterData.rs.getInt(5);//code added to retrieve the total of all columns
				reportsForm.setPC1(reportsMasterData.rs.getString(6));
				totpc1+=reportsMasterData.rs.getInt(6);
				reportsForm.setPC2(reportsMasterData.rs.getString(7));
				totpc2+=reportsMasterData.rs.getInt(7);
				reportsForm.setPC3(reportsMasterData.rs.getString(8));
				totpc3+=reportsMasterData.rs.getInt(8);
				reportsForm.setPC4(reportsMasterData.rs.getString(9));
				totpc4+=reportsMasterData.rs.getInt(9);
				reportsForm.setNC(reportsMasterData.rs.getString(10));
				totnc+=reportsMasterData.rs.getInt(10);
				reportsForm.setNSS(reportsMasterData.rs.getString(11));
				totnss+=reportsMasterData.rs.getInt(11);
				reportsForm.setTotal(reportsMasterData.rs.getString(12));
				
			/*	reportsForm.setDistcode1(reportsMasterData.rs1.getString(1));
				reportsForm.setDistname1(reportsMasterData.rs1.getString(2));
				reportsForm.setMandcode1(reportsMasterData.rs1.getString(3));
				reportsForm.setMandname1(reportsMasterData.rs1.getString(4));
				reportsForm.setFC1(reportsMasterData.rs1.getString(5));
				reportsForm.setPC11(reportsMasterData.rs1.getString(6));
				reportsForm.setPC21(reportsMasterData.rs1.getString(7));
				reportsForm.setPC31(reportsMasterData.rs1.getString(8));
				reportsForm.setPC41(reportsMasterData.rs1.getString(9));
				reportsForm.setNC1(reportsMasterData.rs1.getString(10));
				reportsForm.setNSS1(reportsMasterData.rs1.getString(11));*/
				
				state.add(reportsForm);
				
				
			}
			
			ArrayList totals=new ArrayList();
			int tot=totfc+totpc1+totpc2+totpc3+totpc4+totnc+totnss;
			totals.add(0,""+totfc);
			totals.add(1,""+totpc1);
			totals.add(2,""+totpc2);
			totals.add(3,""+totpc3);
			totals.add(4,""+totpc4);
			totals.add(5,""+totnc);
			totals.add(6,""+totnss);
			totals.add(7,""+tot);
			session.setAttribute("totalsM",totals);
			
			session.setAttribute("stateDistm",state);
		//	session.setAttribute("stateDistm1",state1);
			
			query="DROP VIEW COVERAGE_PRESENT_YEAR";
			//query1="DROP VIEW COVERAGE_PREVIOUS_YEAR";
			
			reportsMasterData.stmt.executeUpdate(query);
			//reportsMasterData.stmt1.executeUpdate(query1);
										
		}catch(Exception e)
		{
			System.out.println("Exception in getDistrictsRepMand"+e.getMessage());
		}finally {
			reportsMasterData.closeAll();
		}
		return state;
	}

	public static int  getAssetDistricts(DataSource dataSource,HttpSession session) throws Exception 
	{
		ArrayList state=new ArrayList();
		ArrayList state1=new ArrayList();		
		ReportsMasterData reportsMasterData=new ReportsMasterData();
		String query=null;
		String query1=null;
		String q=null;
		int total=0;
		ArrayList statenames=new ArrayList();
		
		try
		{
			reportsMasterData.conn=dataSource.getConnection();
			reportsMasterData.stmt1=reportsMasterData.conn.createStatement();
			reportsMasterData.stmt2=reportsMasterData.conn.createStatement();
			q="select distinct type_of_asset_code from rws_asset_type_tbl order by type_of_asset_code ";
			reportsMasterData.rs2=reportsMasterData.stmt2.executeQuery(q);	
			String scode="";
			int i = 0;
			while(reportsMasterData.rs2.next())
			{			
				String scheme=reportsMasterData.rs2.getString(1);
				if(scheme.equals("01"))
				{
					scode="6%";
				}
				else if(scheme.equals("02"))
				{
					scode="4%";
				}
				if(scheme.equals("03"))
				{
					scode="8%";
				}
				else if(scheme.equals("04"))
				{
					scode="0%";
				}
				else if(scheme.equals("05"))
				{
					scode="3%";
				}
				else if(scheme.equals("06"))
				{
					scode="5%";
				}
				else if(scheme.equals("07"))
				{
					scode="7%";
				}
				else if(scheme.equals("08"))
				{
					scode="9%";
				}
			
			query="select distinct type.type_of_asset_code as AssetCode,type.type_of_asset_name as AssetName,count(*) as total from rws_asset_mast_tbl mast,rws_asset_type_tbl type,rws_asset_scheme_tbl sc where mast.asset_code=sc.asset_code and mast.type_of_asset_code=type.type_of_asset_code and mast.type_of_asset_code='"+scheme+"' and substr(sc.scheme_code,17,3) like '"+scode+"' group by type.type_of_asset_code,type.type_of_asset_name order by type.type_of_asset_code";
			reportsMasterData.rs1=reportsMasterData.stmt1.executeQuery(query);
			
			while(reportsMasterData.rs1.next())
			{
				state.add(i,reportsMasterData.rs1.getString(2));
				state1.add(i,reportsMasterData.rs1.getString(3));
				total=total+reportsMasterData.rs1.getInt(3);
				i++;
			}
			}
			session.setAttribute("stateAssets",state);
			session.setAttribute("stateAssets1",state1);
			session.setAttribute("totalAssets",total+"");				
			}catch(Exception e)
			{
				System.out.println("Exception in getStateAssests"+e);
			} finally {
				reportsMasterData.closeAll();
			}
			
			return 1;
		}
		
		
		
	
	
	
}
