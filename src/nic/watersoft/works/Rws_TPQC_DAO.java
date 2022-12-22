/*
 * Created on 22-03-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.ImageDocumentSanitizerImpl;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.smsmobile.Rws_PrivateSourceForm;

public class Rws_TPQC_DAO {

	/**
	 * @param bean
	 * @param request
	 * @return
	 */
	private LabelValueBean labelValueBean = null;
	
	
	
	
	
	
	
	
	public String getWorkDetails(QualityControlEntryActionBean bean,
			HttpServletRequest request, ActionServlet actionServlet) {
 //System.out.println("AAAAAAAAAAAA"+bean.getWorkId());
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String message = "";
		String query = "";
		message = "Work ID Does Not Exists";

		boolean flag = false;

		try {
			conn = RwsOffices.getConn();

			query = "select work_name ,SANCTION_AMOUNT ,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.programme_name,c.subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl c where substr(a.work_id,1,2)=p.programme_code and p.programme_code=c.programme_code  and substr(a.work_id,3,2)= c.subprogramme_code  and work_id=?";

			ps = conn.prepareStatement(query);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			while (rs.next()) {
				flag = true;
				bean.setWorkName(rs.getString(1));
				bean.setSanctionedAmount(rs.getString(2));
				bean.setSanctionedDate(rs.getString(3));
				bean.setProgramName(rs.getString(4));
				bean.setSubProgName(rs.getString(5));
				bean.setIsAdmnSanction("true");
				//bean.setQcImgAvailble("Y");
				//bean.setTptImgAvailble("Y");
				//bean.setIssueDate("13-01-1992");
				//bean.setCertDate("01-02-1988");
				

			}
			ps.close();
			rs.close();
			
			String habCount = "select count(*) from rws_admn_hab_lnk_tbl where work_id=?";
			ps = conn.prepareStatement(habCount);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				bean.setSanctionedHabs(rs.getString(1));
			}
			
			ps.close();
			rs.close();
			
			//
//			String query =  "select  to_char(INSPECTION_DATE,'dd/mm/yyyy'),to_char(ISSUE_CERTIFICATE_DATE,'dd/mm/yyyy'),OFFICER_ASSIGNED_TO,OFFICER_ASSIGNED_TO1,OFFICER_ASSIGNED_TO2,OFFICER_ASSIGNED_TO3 "
					//+ "from rws_tp_quality_control_tbl  where work_id=? ";
			String datesQuery = "select to_char(INSPECTION_DATE,'dd/mm/yyyy'),to_char(ISSUE_CERTIFICATE_DATE,'dd/mm/yyyy') from rws_tp_quality_control_tbl where work_id=?";
			ps = conn.prepareStatement(datesQuery);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				//bean.setSanctionedHabs(rs.getString(1));

				bean.setIssueDate(rs.getString(1));
				bean.setCertDate(rs.getString(2));
			}
			
			ps.close();
			rs.close();
			//////////
			
			
			String imagePath1=actionServlet.getServletContext().getRealPath("/") ;
			 if(imagePath1 != null && !imagePath1.isEmpty() && imagePath1.contains(File.separator+"webapps"+File.separator)){
				 String sample[]  = imagePath1.split( File.separator+"webapps"+File.separator);
				 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath1 = sample[0];
				 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }else{
				 String sample[]  = imagePath1.split( "webapps");
				// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath1 = sample[0];
				//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }
			 imagePath1 = imagePath1+ File.separator+"TPQCImages"+ File.separator+"TPQCImage";
			File myFilesDir1 = new File(imagePath1);
			if (!myFilesDir1.exists())
				myFilesDir1.mkdirs();
			imagePath1 = imagePath1 + File.separator ;
			File filepath1 = new File(imagePath1);
			//pstmt.setString(15, workId);
			//pstmt.setString(16,tenderMemoBean.getBillSlNo());
			//String billdates=tenderMemoBean.getBillDate().replace("/", "-");
			//				System.out.println("@@@@@@@@@@@@@"+rs.getString(11).replace("/", "-")+"$$$$"+rs.getString("work_id")+"#######"+rs.getString("bill_sl_no"));

			File filepathisExits1 = new File(filepath1+File.separator+bean.getWorkId()+"_"+"tpqc"+".jpg");
			if(filepathisExits1.getAbsoluteFile().exists()){
				//System.out.println("YYYYYYYYYYYYYYYY");
				bean.setQcImgAvailble("Y");
			}
			else
			{
				//System.out.println("NNNNNNNNNNN");
				bean.setQcImgAvailble("N");
			}

			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			//
			
			String imagePath=actionServlet.getServletContext().getRealPath("/") ;
			 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
				 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
				 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath = sample[0];
				 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }else{
				 String sample[]  = imagePath.split( "webapps");
				// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath = sample[0];
				//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }
			 imagePath = imagePath+ File.separator+"TPQCImages"+ File.separator+"TptImage";
			File myFilesDir = new File(imagePath);
			if (!myFilesDir.exists())
				myFilesDir.mkdirs();
			imagePath = imagePath + File.separator ;
			File filepath = new File(imagePath);
			//pstmt.setString(15, workId);
			//pstmt.setString(16,tenderMemoBean.getBillSlNo());
			//String billdates=tenderMemoBean.getBillDate().replace("/", "-");
			//				System.out.println("@@@@@@@@@@@@@"+rs.getString(11).replace("/", "-")+"$$$$"+rs.getString("work_id")+"#######"+rs.getString("bill_sl_no"));

			File filepathisExits = new File(filepath+File.separator+bean.getWorkId()+"_"+"tpt"+".jpg");
			if(filepathisExits.getAbsoluteFile().exists()){
				//System.out.println("__________YYYYYYYYYYYYYYYY");
				bean.setTptImgAvailble("Y");
			}
			else
			{
				//System.out.println("____________NNNNNNNNNNN");
			//	bean.setQcImgAvailble("N");
				bean.setTptImgAvailble("N");
			}
			
			
					
			
			
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getWorkDetails : "
					+ e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e) {
				System.out
						.println("Exception in RwsHabLinkDAO getWorkDetails : "
								+ e.getMessage());

			}
		}
		if (!flag) {
			return message;
		}
		return "";

	}
	
	
	
	
	
	
	

	public WorksMonitoringActionForm getWorkDetails1(WorksMonitoringActionForm bean,
			ActionServlet actionServlet) {
 //System.out.println("AAAAAAAAAAAA"+bean.getWorkId());
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String message = "";
		String query = "";
		//message = "Work ID Does Not Exists";

		boolean flag = false;

		try {
			conn = RwsOffices.getConn();

/*			query = "select work_name ,SANCTION_AMOUNT ,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.programme_name,c.subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl c where substr(a.work_id,1,2)=p.programme_code and p.programme_code=c.programme_code  and substr(a.work_id,3,2)= c.subprogramme_code  and work_id=?";

			ps = conn.prepareStatement(query);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			while (rs.next()) {
				flag = true;
				bean.setWorkName(rs.getString(1));
				bean.setSanctionedAmount(rs.getString(2));
				bean.setSanctionedDate(rs.getString(3));
				bean.setProgramName(rs.getString(4));
				bean.setSubProgName(rs.getString(5));
				bean.setIsAdmnSanction("true");
				//bean.setQcImgAvailble("Y");
				//bean.setTptImgAvailble("Y");
				//bean.setIssueDate("13-01-1992");
				//bean.setCertDate("01-02-1988");
				

			}
			ps.close();
			rs.close();*/
			
/*			String habCount = "select count(*) from rws_admn_hab_lnk_tbl where work_id=?";
			ps = conn.prepareStatement(habCount);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				bean.setSanctionedHabs(rs.getString(1));
			}
			
			ps.close();
			rs.close();
			*/
			//
//			String query =  "select  to_char(INSPECTION_DATE,'dd/mm/yyyy'),to_char(ISSUE_CERTIFICATE_DATE,'dd/mm/yyyy'),OFFICER_ASSIGNED_TO,OFFICER_ASSIGNED_TO1,OFFICER_ASSIGNED_TO2,OFFICER_ASSIGNED_TO3 "
					//+ "from rws_tp_quality_control_tbl  where work_id=? ";
			
			
			//System.out.println("################################");
			
			String datesQuery = "select to_char(INSPECTION_DATE,'dd/mm/yyyy'),to_char(ISSUE_CERTIFICATE_DATE,'dd/mm/yyyy'),AGENCY_CODE from rws_tp_quality_control_tbl where work_id=?";
			ps = conn.prepareStatement(datesQuery);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				//bean.setSanctionedHabs(rs.getString(1));
				///System.out.print(rs.getString(1)+"________"+rs.getString(2));	
				
				bean.setIssueDate(rs.getString(1));
				bean.setCertDate(rs.getString(2));
				//bean.setAgencyName(rs.getString(3));
				bean.setAgency(rs.getString(3));
			}else
			{
				bean.setIssueDate("");
				bean.setCertDate("");
				//bean.setAgencyName("");
				bean.setAgency("");
			}
			
			ps.close();
			rs.close();
			//////////
			
			
			String imagePath1=actionServlet.getServletContext().getRealPath("/") ;
			 if(imagePath1 != null && !imagePath1.isEmpty() && imagePath1.contains(File.separator+"webapps"+File.separator)){
				 String sample[]  = imagePath1.split( File.separator+"webapps"+File.separator);
				 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath1 = sample[0];
				 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }else{
				 String sample[]  = imagePath1.split( "webapps");
				// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath1 = sample[0];
				//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }
			 imagePath1 = imagePath1+ File.separator+"TPQCImages"+ File.separator+"TPQCImage";
			File myFilesDir1 = new File(imagePath1);
			if (!myFilesDir1.exists())
				myFilesDir1.mkdirs();
			imagePath1 = imagePath1 + File.separator ;
			File filepath1 = new File(imagePath1);
			//pstmt.setString(15, workId);
			//pstmt.setString(16,tenderMemoBean.getBillSlNo());
			//String billdates=tenderMemoBean.getBillDate().replace("/", "-");
			//				System.out.println("@@@@@@@@@@@@@"+rs.getString(11).replace("/", "-")+"$$$$"+rs.getString("work_id")+"#######"+rs.getString("bill_sl_no"));
			File filepathisExits1 = null;
			filepathisExits1 = new File(filepath1+File.separator+bean.getWorkId()+"_"+"tpqc"+".jpg");
			if(filepathisExits1.getAbsoluteFile().exists()){
				System.out.println("YYYYYYYYYYYYYYYY");
				bean.setQcImgAvailble("Y");
			}
			else
			{
				System.out.println("NNNNNNNNNNN");
				bean.setQcImgAvailble("N");
			}

			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
/*			//
			
			String imagePath=actionServlet.getServletContext().getRealPath("/") ;
			 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
				 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
				 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath = sample[0];
				 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }else{
				 String sample[]  = imagePath.split( "webapps");
				// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
				 imagePath = sample[0];
				//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
			 }
			 imagePath = imagePath+ File.separator+"QCImages"+ File.separator+"TptImage";
			File myFilesDir = new File(imagePath);
			if (!myFilesDir.exists())
				myFilesDir.mkdirs();
			imagePath = imagePath + File.separator ;
			File filepath = new File(imagePath);
			//pstmt.setString(15, workId);
			//pstmt.setString(16,tenderMemoBean.getBillSlNo());
			//String billdates=tenderMemoBean.getBillDate().replace("/", "-");
			//				System.out.println("@@@@@@@@@@@@@"+rs.getString(11).replace("/", "-")+"$$$$"+rs.getString("work_id")+"#######"+rs.getString("bill_sl_no"));

			File filepathisExits = new File(filepath+File.separator+bean.getWorkId()+"_"+"tpt"+".jpg");
			if(filepathisExits.getAbsoluteFile().exists()){
				System.out.println("__________YYYYYYYYYYYYYYYY");
				bean.setTptImgAvailble("Y");
			}
			else
			{
				System.out.println("____________NNNNNNNNNNN");
			//	bean.setQcImgAvailble("N");
				bean.setTptImgAvailble("N");
			}
			
			*/
					
			
			
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getWorkDetails : "
					+ e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e) {
				System.out
						.println("Exception in RwsHabLinkDAO getWorkDetails : "
								+ e.getMessage());

			}
		}
		if (!flag) {
			return bean;
		}
		return bean;

	}
	
	public ArrayList getEmployees(String dcode, int start, int end) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		String message = "";
		String query = "";
		ArrayList employees = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT EMPLOYEE_CODE,EMPLOYEE_SURNAME||'.'||EMPLOYEE_NAME,designation_acr FROM rws_employee_tbl a,rws_designation_tbl b where a.designation_code=b.designation_code "
					+ " and (a.DESIGNATION_CODE>=? and a.DESIGNATION_CODE<=?) ";
			if (dcode != null && !dcode.equals("all")) {
				query += " and substr(a.office_code,2,2)=? ";
			}
				query += "ORDER BY a.DESIGNATION_CODE";

			ps = conn.prepareStatement(query);
			ps.setInt(1, start);
			ps.setInt(2, end);
			if (dcode != null && !dcode.equals("all")) {
				ps.setString(3, dcode);
			}
			rset = ps.executeQuery();
			LabelValueBean bean = null;
			while (rset.next()) {
				bean = new LabelValueBean();
				bean.setValue(rset.getString(1));
				bean.setLabel(rset.getString(3) + " - " + rset.getString(1)
						+ " - " + rset.getString(2));
				employees.add(bean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getEmployees():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return employees;

	}
	
	
	public ArrayList getAgencies() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		String message = "";
		String query = "";
		ArrayList employees = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT AGENCY_CODE,AGENCY_NAME FROM RWS_QC_AGENCY_TBL R WHERE R.FINANCIAL_YEAR=(SELECT (CASE WHEN TO_NUMBER(TO_CHAR(SYSDATE,'MM'))>3 THEN TO_CHAR(SYSDATE,'YYYY')||'-'||TO_CHAR(ADD_MONTHS(SYSDATE,12),'YYYY') ELSE TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYY')||'-'||TO_CHAR(SYSDATE,'YYYY') END)FINYEAR FROM DUAL) ORDER BY AGENCY_CODE ";
			
			ps = conn.prepareStatement(query);
			//ps.setInt(1, start);
			//ps.setInt(2, end);
			/*if (dcode != null && !dcode.equals("all")) {
				ps.setString(3, dcode);
			}*/
			rset = ps.executeQuery();
			LabelValueBean bean = null;
			while (rset.next()) {
				bean = new LabelValueBean();
				bean.setValue(rset.getString(1));
				bean.setLabel(rset.getString(1) + " - " + rset.getString(2));
				employees.add(bean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getEmployees():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return employees;
	}
	
	public QualityControlEntryActionBean getProgramScheduleDetails(
			DataSource datasource, String workId) throws Exception {
		QualityControlEntryActionBean bean = null;
		Connection conn = null;
		PreparedStatement ps = null;
		//ResultSet rset = null;
		ResultSet rs = null;
		
		try {
			conn = RwsOffices.getConn();
			/*String query =  "select  to_char(a.GROUNDING_DATE,'dd/mm/yyyy'),substr(a.OFFICE_CODE,5,2),a.OFFICER_ASSIGNED_TO,a.OFFICER_ASSIGNED_TO1,a.OFFICER_ASSIGNED_TO2,a.OFFICER_ASSIGNED_TO3,to_char(b.AGREEMENT_DATE,'dd/mm/yyyy') "
					+ "from RWS_WORK_COMMENCEMENT_TBL a,rws_contractor_selection_tbl b where a.work_id=? and a.work_id=b.work_id(+)";
			*/
			String query =  "select  to_char(INSPECTION_DATE,'dd/mm/yyyy'),to_char(ISSUE_CERTIFICATE_DATE,'dd/mm/yyyy'),OFFICER_ASSIGNED_TO,OFFICER_ASSIGNED_TO1,OFFICER_ASSIGNED_TO2,OFFICER_ASSIGNED_TO3 "
					+ "from rws_tp_quality_control_tbl  where work_id=? ";
			
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rs = ps.executeQuery();
			if (rs.next()) {
				bean = new QualityControlEntryActionBean();
				///////////////System.out.println(rs.getString(2)+"((((((("+rs.getString(1));
				
				//bean.setSubDivAssign(rs.getString(2));
				bean.setEngineerAssign(rs.getString(3));
				bean.setEngineerAssign1(rs.getString(4));
				bean.setEngineerAssign2(rs.getString(5));
				bean.setEngineerAssign3(rs.getString(6));
				//bean.setIssueDate(rs.getString(1));
				//bean.setIssueDate("13/01/1992");
				//bean.setCertDate(rs.getString(2));
				//bean.setAgreeDate(rs.getString(7));
			}

		} catch (Exception e) {
			Debug.println("Exception getProgramScheduleDetails:" + e);
		} finally {
			if (ps != null)
				ps.close();
			if (rs != null)
				rs.close();
			if (conn != null)
				conn.close();
		}
		return bean;
	}

	
	public WorksMonitoringActionForm getProgramScheduleDetails1(
			DataSource datasource, String workId) throws Exception {
		WorksMonitoringActionForm bean = null;
		Connection conn = null;
		PreparedStatement ps = null;
		//ResultSet rset = null;
		ResultSet rs = null;
		
		try {
			conn = RwsOffices.getConn();
			/*String query =  "select  to_char(a.GROUNDING_DATE,'dd/mm/yyyy'),substr(a.OFFICE_CODE,5,2),a.OFFICER_ASSIGNED_TO,a.OFFICER_ASSIGNED_TO1,a.OFFICER_ASSIGNED_TO2,a.OFFICER_ASSIGNED_TO3,to_char(b.AGREEMENT_DATE,'dd/mm/yyyy') "
					+ "from RWS_WORK_COMMENCEMENT_TBL a,rws_contractor_selection_tbl b where a.work_id=? and a.work_id=b.work_id(+)";
			*/
			String query =  "select  to_char(INSPECTION_DATE,'dd/mm/yyyy'),to_char(ISSUE_CERTIFICATE_DATE,'dd/mm/yyyy'),OFFICER_ASSIGNED_TO,OFFICER_ASSIGNED_TO1,OFFICER_ASSIGNED_TO2,OFFICER_ASSIGNED_TO3 "
					+ "from rws_tp_quality_control_tbl  where work_id=? ";
			
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rs = ps.executeQuery();
			if (rs.next()) {
				bean = new WorksMonitoringActionForm();
				///////////////System.out.println(rs.getString(2)+"((((((("+rs.getString(1));
				
				//bean.setSubDivAssign(rs.getString(2));
				/*bean.setEngineerAssign(rs.getString(3));
				bean.setEngineerAssign1(rs.getString(4));
				bean.setEngineerAssign2(rs.getString(5));
				bean.setEngineerAssign3(rs.getString(6));*/
				bean.setEngineerAssign(rs.getString(3));
				bean.setEngineerAssignDee(rs.getString(4));
				bean.setEngineerAssignEe(rs.getString(5));
				bean.setEngineerAssignSe(rs.getString(6));
				//bean.setIssueDate(rs.getString(1));
				//bean.setIssueDate("13/01/1992");
				//bean.setCertDate(rs.getString(2));
				//bean.setAgreeDate(rs.getString(7));
			}

		} catch (Exception e) {
			Debug.println("Exception getProgramScheduleDetails:" + e);
		} finally {
			if (ps != null)
				ps.close();
			if (rs != null)
				rs.close();
			if (conn != null)
				conn.close();
		}
		return bean;
	}

	
	
	
	
	
	public String updateDetailsnew(WorksMonitoringActionForm bean, String targetPath, ActionServlet servlet,String user
			) throws Exception {
		//QualityControlEntryActionBean bean = null;
		Connection conn = null;
		PreparedStatement ps = null;
		//ResultSet rset = null;
		ResultSet rs = null;
		int rowCount=0;
		String message="";
		int count=0;
		
		
		
		try {
			conn = RwsOffices.getConn();
			//System.out.println(bean.getIssueDate()+"########3"+bean.getEngineerAssign());
			
			
			String work_count = "select count(*) from rws_tp_quality_control_tbl where work_id=?";
			ps = conn.prepareStatement(work_count);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {
                count=rs.getInt(1);
				//bean.setSanctionedHabs(rs.getString(1));
			}
			
			ps.close();
			rs.close();
			
			
			if(count>=1){
				//message = "work id already existed....";
				System.out.println(bean.getIssueDate()+"####*********####3"+bean.getEngineerAssign());
				String issueDate=bean.getIssueDate().toString();
				String certDate=bean.getCertDate().toString();
				String query = "update rws_tp_quality_control_tbl set INSPECTION_DATE=to_date(?,'dd/mm/yyyy'),ISSUE_CERTIFICATE_DATE=to_date(?,'dd/mm/yyyy'),AGENCY_CODE=?,ENTERED_BY=?  where WORK_ID=?";
				ps = conn.prepareStatement(query);
				//ps.setString(1, bean.getWorkId());
				//ps.setString(1, bean.getAgencyName());
				//ps.setString(2, bean.getEngineerAssign1());
				////ps.setString(3, bean.getEngineerAssign2());
				//////ps.setString(4, bean.getEngineerAssign3());
				//TO_DATE('"+bean.getIssueDate()+"','dd/mm/yyyy')
				//TO_DATE('"+bean.getCertDate()+"','dd/mm/yyyy')
				//ps.setString(6, TO_DATE('"+ABC+"','dd/mm/yyyy"));
				//ps.setString(7, TO_DATE(bean.getCertDate(),"dd/mm/yyyy"));
				/////////////ps.setDate(5, java.sql.Date.valueOf(yearmonthdayformat(bean.getIssueDate())));
				///////////ps.setDate(6, java.sql.Date.valueOf(yearmonthdayformat(bean.getCertDate())));
/*				query = "UPDATE  RWS_WORK_COMMENCEMENT_TBL set "
						+ "GROUNDING_DATE=to_date(?,'dd/mm/yyyy'),OFFICER_ASSIGNED_TO=?,OFFICER_ASSIGNED_TO1=?,OFFICER_ASSIGNED_TO2=?,OFFICER_ASSIGNED_TO3=?,OFFICE_CODE= ?,ENTERED_BY=?,UPDATE_DATE=SYSDATE where work_id=?";
				ps=conn.prepareStatement(query);
				ps.setString(1, bean.getWorkGndDate());*/
				/////////ps.setString(5, bean.getIssueDate());
				//////////////ps.setString(6, bean.getCertDate());
				//ps.setString(5, "13/01/2014");
				//ps.setString(6, "13/01/2014");
				
				ps.setString(1, issueDate);
				ps.setString(2, certDate);
				ps.setString(3, bean.getAgency());//System.out.println("bean.getEngineerAssign() :"+bean.getEngineerAssign());
				
				ps.setString(4, user);
				ps.setString(5, bean.getWorkId());
				//ps.setDate(6, java.sql.Date.valueOf("2013-09-04"));
				//ps.setDate(7, java.sql.Date.valueOf("2013-09-05"));
				/*Commented on 22-04-2022 for Security Audit*/
				String return_msg = updateDetails1( bean,  targetPath,  servlet);
				////updateDetails2( bean,  targetPath,  servlet);
				if(!return_msg.equals("Image File is Corrupted"))
				{
					rowCount = ps.executeUpdate();
				}
				/*Commented on 22-04-2022 for Security Audit*/
				if (rowCount < 1 && (!return_msg.equals("Image File is Corrupted"))) {
					message = "Details cant be updated successfully.";
				}
				else if(return_msg.equals("Image File is Corrupted"))
				{
					message = return_msg;
				}
				else {
					message = "Details  updated successfully.";
				}
				
				
				
				
				
			}else
			{
				System.out.println(bean.getIssueDate()+"3333333####*********####3"+bean.getEngineerAssign());
				String issueDate=bean.getIssueDate().toString();
				String certDate=bean.getCertDate().toString();
				String query = "insert into rws_tp_quality_control_tbl (WORK_ID,INSPECTION_DATE,ISSUE_CERTIFICATE_DATE,AGENCY_CODE,ENTERED_BY) values (?,to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?)";
				ps = conn.prepareStatement(query);
				ps.setString(1, bean.getWorkId());
				//ps.setString(2, bean.getAgencyName());
				/*ps.setString(3, bean.getEngineerAssign1());
				ps.setString(4, bean.getEngineerAssign2());
				ps.setString(5, bean.getEngineerAssign3());*/
				//ps.setString(6, bean.getIssueDate());
				//ps.setString(7, bean.getCertDate());
				/*ps.setString(6, "13/01/2013");
				ps.setString(7, "13/01/2013");*/
				ps.setString(2, issueDate);
				ps.setString(3, certDate);
				ps.setString(4, bean.getAgency());
				ps.setString(5, user);
				//TO_DATE('"+bean.getIssueDate()+"','dd/mm/yyyy')
				//TO_DATE('"+bean.getCertDate()+"','dd/mm/yyyy')
				//ps.setString(6, TO_DATE('"+ABC+"','dd/mm/yyyy"));
				//ps.setString(7, TO_DATE(bean.getCertDate(),"dd/mm/yyyy"));
				/////////ps.setDate(6, java.sql.Date.valueOf(yearmonthdayformat(bean.getIssueDate())));
				//////////ps.setDate(7, java.sql.Date.valueOf(yearmonthdayformat(bean.getCertDate())));
				//ps.setDate(6, java.sql.Date.valueOf("2013-09-04"));
				//ps.setDate(7, java.sql.Date.valueOf("2013-09-05"));
				//////////updateDetails1( bean,  targetPath,  servlet);
				
				String return_msg = updateDetails1( bean,  targetPath,  servlet);
				////////////updateDetails2( bean,  targetPath,  servlet);
				rowCount = ps.executeUpdate();
				if (rowCount < 1 && (!return_msg.equals("Image File is Corrupted"))) {
					message = "Details cant be inserted successfully.";
				} 
				else if(return_msg.equals("Image File is Corrupted"))
				{
					message = return_msg;
				}
				else {
					message = "Details  inserted successfully.";
				}

			}
			
			
			
			
			
		} catch (Exception e) {
			Debug.println("Exception getProgramScheduleDetails:" + e);
		//System.out.println(e.setStackTrace(stackTrace););
			e.printStackTrace();
		} finally {
			if (ps != null)
				ps.close();
			if (rs != null)
				rs.close();
			if (conn != null)
				conn.close();
		}
		
		
		
		
		
		return message;
	}
	
	
	
	
	
	
	
	public ArrayList getWorksforDeletion1(DataSource dataSource, String circle,
			String div, String programmeCode, String subprogrammeCode,
			String plan, String wrkType, String workCat,String SubDiv) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		//ResultSet rset = null;
		ResultSet rs = null;
		String query="";
		ArrayList worksfordeletion = null;
		try {
			conn = RwsOffices.getConn();
			//System.out.println("circle"+circle);
			//System.out.println("div"+div);
			//System.out.println("plan"+plan);
			//System.out.println("wrkType"+wrkType);
			//System.out.println("workCat"+workCat);
			//System.out.println("programmeCode"+programmeCode);
			//System.out.println("subprogrammeCode"+subprogrammeCode);
			
			query = " SELECT WORK_NAME,WORK_ID,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE,SANCTION_AMOUNT,NO_OF_HABS, p.PROGRAMME_NAME,s.SUBPROGRAMME_NAME from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s "
					+ "where substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? and substr(OFFICE_CODE,5,2)=? and PLAN_CODE =? and AUG_NEW_CODE =? and CATEGORY_CODE=? and a.PROGRAMME_CODE=p.PROGRAMME_CODE and  p.PROGRAMME_CODE=s.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=s.SUBPROGRAMME_CODE ";
			if (programmeCode != null && !programmeCode.equals("")) {
				query = query + " and a.PROGRAMME_CODE=?";
			}
			if (subprogrammeCode != null && !subprogrammeCode.equals("")) {
				query = query + " and a.SUBPROGRAMME_CODE=?";
			}
			query = query + " order by plan_code";
			ps = conn.prepareStatement(query);
			ps.setString(1, circle);
			ps.setString(2, div);
			ps.setString(3, SubDiv);System.out.println("SubDiv :"+SubDiv);
			ps.setString(4, plan);
			ps.setString(5, wrkType);
			ps.setString(6, workCat);
			if (programmeCode != null && !programmeCode.equals("")) {
				ps.setString(7, programmeCode);
			}
			if (subprogrammeCode != null && !subprogrammeCode.equals("")) {
				ps.setString(8, subprogrammeCode);
			}
			rs = ps.executeQuery();
			//tenderMemo tendermemo = null;
			worksfordeletion = new ArrayList();
			WorksMonitoringActionForm bean=new WorksMonitoringActionForm();
			while (rs.next()) {
	             	bean=new WorksMonitoringActionForm();
	             	bean.setWorkId(rs.getString("work_id"));
	             	bean.setWorkName(rs.getString("work_id")+" - "+rs.getString("work_Name"));
	             	worksfordeletion.add(bean);
			}

		} catch (Exception e) {
			Debug.println("Exception in getWorksforDeletion(datasource):" + e);
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksfordeletion;
	}

	
	
	
	
	public String updateDetails(QualityControlEntryActionBean bean, String targetPath, ActionServlet servlet
			) throws Exception {
		//QualityControlEntryActionBean bean = null;
		Connection conn = null;
		PreparedStatement ps = null;
		//ResultSet rset = null;
		ResultSet rs = null;
		int rowCount=0;
		String message="";
		int count=0;
		
		try {
			conn = RwsOffices.getConn();
			//System.out.println(bean.getIssueDate()+"########3"+bean.getEngineerAssign());
			
			
			String work_count = "select count(*) from rws_tp_quality_control_tbl where work_id=?";
			ps = conn.prepareStatement(work_count);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {
                count=rs.getInt(1);
				//bean.setSanctionedHabs(rs.getString(1));
			}
			
			ps.close();
			rs.close();
			
			
			if(count>=1){
				//message = "work id already existed....";
				//System.out.println(bean.getIssueDate()+"####*********####3"+bean.getEngineerAssign());
				String issueDate=bean.getIssueDate().toString();
				String certDate=bean.getCertDate().toString();
				String query = "update  rws_tp_quality_control_tbl set OFFICER_ASSIGNED_TO=?,OFFICER_ASSIGNED_TO1=?,OFFICER_ASSIGNED_TO2=?,OFFICER_ASSIGNED_TO3=?,INSPECTION_DATE=to_date(?,'dd/mm/yyyy'),ISSUE_CERTIFICATE_DATE=to_date(?,'dd/mm/yyyy')  where WORK_ID=?";
				ps = conn.prepareStatement(query);
				//ps.setString(1, bean.getWorkId());
				ps.setString(1, bean.getEngineerAssign());
				ps.setString(2, bean.getEngineerAssign1());
				ps.setString(3, bean.getEngineerAssign2());
				ps.setString(4, bean.getEngineerAssign3());
				//TO_DATE('"+bean.getIssueDate()+"','dd/mm/yyyy')
				//TO_DATE('"+bean.getCertDate()+"','dd/mm/yyyy')
				//ps.setString(6, TO_DATE('"+ABC+"','dd/mm/yyyy"));
				//ps.setString(7, TO_DATE(bean.getCertDate(),"dd/mm/yyyy"));
				/////////////ps.setDate(5, java.sql.Date.valueOf(yearmonthdayformat(bean.getIssueDate())));
				///////////ps.setDate(6, java.sql.Date.valueOf(yearmonthdayformat(bean.getCertDate())));
/*				query = "UPDATE  RWS_WORK_COMMENCEMENT_TBL set "
						+ "GROUNDING_DATE=to_date(?,'dd/mm/yyyy'),OFFICER_ASSIGNED_TO=?,OFFICER_ASSIGNED_TO1=?,OFFICER_ASSIGNED_TO2=?,OFFICER_ASSIGNED_TO3=?,OFFICE_CODE= ?,ENTERED_BY=?,UPDATE_DATE=SYSDATE where work_id=?";
				ps=conn.prepareStatement(query);
				ps.setString(1, bean.getWorkGndDate());*/
				/////////ps.setString(5, bean.getIssueDate());
				//////////////ps.setString(6, bean.getCertDate());
				//ps.setString(5, "13/01/2014");
				//ps.setString(6, "13/01/2014");
				
				ps.setString(5, issueDate);
				ps.setString(6, certDate);
				
				
				ps.setString(7, bean.getWorkId());
				//ps.setDate(6, java.sql.Date.valueOf("2013-09-04"));
				//ps.setDate(7, java.sql.Date.valueOf("2013-09-05"));
				///////updateDetails1( bean,  targetPath,  servlet);
				//////////updateDetails2( bean,  targetPath,  servlet);
				rowCount = ps.executeUpdate();
				if (rowCount < 1) {
					message = "Details cant be updated successfully.";
				} else {
					message = "Details  updated successfully.";
				}
				
				
				
				
				
			}else
			{
				System.out.println(bean.getIssueDate()+"####*********####3"+bean.getEngineerAssign());
				String issueDate=bean.getIssueDate().toString();
				String certDate=bean.getCertDate().toString();
				String query = "insert into rws_tp_quality_control_tbl (WORK_ID,OFFICER_ASSIGNED_TO,OFFICER_ASSIGNED_TO1,OFFICER_ASSIGNED_TO2,OFFICER_ASSIGNED_TO3,INSPECTION_DATE,ISSUE_CERTIFICATE_DATE) values (?,?,?,?,?,to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'))";
				ps = conn.prepareStatement(query);
				ps.setString(1, bean.getWorkId());
				ps.setString(2, bean.getEngineerAssign());
				ps.setString(3, bean.getEngineerAssign1());
				ps.setString(4, bean.getEngineerAssign2());
				ps.setString(5, bean.getEngineerAssign3());
				//ps.setString(6, bean.getIssueDate());
				//ps.setString(7, bean.getCertDate());
				/*ps.setString(6, "13/01/2013");
				ps.setString(7, "13/01/2013");*/
				ps.setString(6, issueDate);
				ps.setString(7, certDate);
				//TO_DATE('"+bean.getIssueDate()+"','dd/mm/yyyy')
				//TO_DATE('"+bean.getCertDate()+"','dd/mm/yyyy')
				//ps.setString(6, TO_DATE('"+ABC+"','dd/mm/yyyy"));
				//ps.setString(7, TO_DATE(bean.getCertDate(),"dd/mm/yyyy"));
				/////////ps.setDate(6, java.sql.Date.valueOf(yearmonthdayformat(bean.getIssueDate())));
				//////////ps.setDate(7, java.sql.Date.valueOf(yearmonthdayformat(bean.getCertDate())));
				//ps.setDate(6, java.sql.Date.valueOf("2013-09-04"));
				//ps.setDate(7, java.sql.Date.valueOf("2013-09-05"));
				/////////////updateDetails1( bean,  targetPath,  servlet);
				////////////updateDetails2( bean,  targetPath,  servlet);
				rowCount = ps.executeUpdate();
				if (rowCount < 1) {
					message = "Details cant be inserted successfully.";
				} else {
					message = "Details  inserted successfully.";
				}

			}
			
			
			
			
			
		} catch (Exception e) {
			Debug.println("Exception getProgramScheduleDetails:" + e);
		//System.out.println(e.setStackTrace(stackTrace););
			e.printStackTrace();
		} finally {
			if (ps != null)
				ps.close();
			if (rs != null)
				rs.close();
			if (conn != null)
				conn.close();
		}
		
		
		
		
		
		return message;
	}
	public static String updateDetails2(QualityControlEntryActionBean frm, String targetPath, ActionServlet servlet) {
		int rowCount;
		String message = "";
		rowCount = 0;
		PreparedStatement preparedStatement = null;
		Connection conn = null;
		message="";
		try {

			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			FileOutputStream outputStream = null;
			FormFile formFile = null;
			FileInputStream fis = null;
			File scannedFile = null;
			File targetFile = null;
			conn = RwsOffices.getConn();
			formFile = frm.getTptImg();
			if (formFile.getFileName() != null && !formFile.getFileName().equals("")) {
				if (formFile != null) {
					try {
						String path = servlet.getServletContext().getRealPath("") + formFile.getFileName();
						scannedFile = new File(path);
						outputStream = new FileOutputStream(scannedFile);
						if (outputStream != null) {

							outputStream.write(formFile.getFileData());
						}
						targetFile = new File(targetPath);

						if (!documentSanitizerImpl.madeSafe(scannedFile)) {
							message = "Image File is Corrupted";
							conn.setAutoCommit(true);
							scannedFile.delete();
							outputStream.close();
							targetFile.delete();
							return message;
						}
						compressImage(scannedFile, targetFile);

						fis = new FileInputStream(targetFile);
					} catch (Exception e) {
						System.out.println("exception in insertSourceDetails " + e);
					} finally {
						if (fis != null) {
						}
					}
					double fileSizeMB = ((frm.getTptImg().getFileSize() / 1024.0) / 1024.0);

					if (fileSizeMB > 0.2) {
						message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
						conn.setAutoCommit(true);
						scannedFile.delete();
						outputStream.close();
						targetFile.delete();
						return message;
					}
					//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
					String imagePath=servlet.getServletContext().getRealPath("/") ;
					 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
						 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
						 System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
					System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }else{
						 String sample[]  = imagePath.split( "webapps");
					 System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
					 System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }
					 imagePath = imagePath+ File.separator+"TPQCImages"+ File.separator+"TptImage";
					 System.out.println("imagePath*********"+imagePath);
					File myFilesDir = new File(imagePath);
					if (!myFilesDir.exists())
						myFilesDir.mkdirs();
					imagePath = imagePath + File.separator ;
					File filepath = new File(imagePath);
					File filepathisExits = new File(filepath+File.separator+frm.getWorkId()+"_tpt"+".jpg");
					if(filepathisExits.getAbsoluteFile().exists()){
						filepathisExits.delete();
					}
					 byte[] readData = new byte[1024];
						FileOutputStream fout=new FileOutputStream(filepath+File.separator+frm.getWorkId()+"_tpt"+".jpg"); 	
						int k = fis.read(readData);
					      while (k != -1) {
					    	  fout.write(readData, 0, k);
					        k = fis.read(readData);
					      }   			            
					    fout.close();
					if (scannedFile != null) {
						scannedFile.delete();

					}
					if (targetFile != null) {
						targetFile.delete();
					}
					if (outputStream != null) {
						outputStream.close();
					}
					if (fis != null) {
					//	fis.close();
					}
					
					//rowCount = preparedStatement.executeUpdate();
				}
			}
			if (rowCount < 1) {
				message = "Source Details Can't be inserted";
			} else {
				message = "Source Details Inserted Successfully";
			}
		}
		catch (Exception e) {
			System.out.println("exception in insertSourceDetails method of Rws_privateSourceDAO" + e);
		} finally {

		}
		return message;
	}
        
	public static String updateDetails1(WorksMonitoringActionForm frm, String targetPath, ActionServlet servlet) {
		int rowCount;
		String message = "";
		rowCount = 0;
		PreparedStatement preparedStatement = null;
		Connection conn = null;
		message="";
		try {

			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			FileOutputStream outputStream = null;
			FormFile formFile = null;
			FileInputStream fis = null;
			File scannedFile = null;
			File targetFile = null;
			conn = RwsOffices.getConn();
			formFile = frm.getQcImg();
			if (formFile.getFileName() != null && !formFile.getFileName().equals("")) {
				if (formFile != null) {
					try {
						String path = servlet.getServletContext().getRealPath("") + formFile.getFileName();
						scannedFile = new File(path);
						outputStream = new FileOutputStream(scannedFile);
						if (outputStream != null) {

							outputStream.write(formFile.getFileData());
						}
						targetFile = new File(targetPath);

						if (!documentSanitizerImpl.madeSafe(scannedFile)) {
							message = "Image File is Corrupted";
							conn.setAutoCommit(true);
							scannedFile.delete();
							outputStream.close();
							targetFile.delete();
							return message;
						}
						compressImage(scannedFile, targetFile);

						fis = new FileInputStream(targetFile);
					} catch (Exception e) {
						System.out.println("exception in insertSourceDetails " + e);
					} finally {
						if (fis != null) {
						}
					}
					double fileSizeMB = ((frm.getQcImg().getFileSize() / 1024.0) / 1024.0);

					if (fileSizeMB > 0.2) {
						message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
						conn.setAutoCommit(true);
						scannedFile.delete();
						outputStream.close();
						targetFile.delete();
						return message;
					}
					//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
					String imagePath=servlet.getServletContext().getRealPath("/") ;
					 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
						 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
						 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }else{
						 String sample[]  = imagePath.split( "webapps");
						// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }
					 imagePath = imagePath+ File.separator+"TPQCImages"+ File.separator+"TPQCImage";
					 System.out.println("TPQCimagePath*********"+imagePath);
					File myFilesDir = new File(imagePath);
					if (!myFilesDir.exists())
						myFilesDir.mkdirs();
					imagePath = imagePath + File.separator ;
					File filepath = new File(imagePath);
					File filepathisExits = new File(filepath+File.separator+frm.getWorkId()+"_tpqc"+".jpg");
					if(filepathisExits.getAbsoluteFile().exists()){
						filepathisExits.delete();
					}
					 byte[] readData = new byte[1024];
						FileOutputStream fout=new FileOutputStream(filepath+File.separator+frm.getWorkId()+"_tpqc"+".jpg"); 	
						int k = fis.read(readData);
					      while (k != -1) {
					    	  fout.write(readData, 0, k);
					        k = fis.read(readData);
					      }   			            
					    fout.close();
					if (scannedFile != null) {
						scannedFile.delete();

					}
					if (targetFile != null) {
						targetFile.delete();
					}
					if (outputStream != null) {
						outputStream.close();
					}
					if (fis != null) {
					//	fis.close();
					}
					
					//rowCount = preparedStatement.executeUpdate();
				}
			}
			if (rowCount < 1) {
				message = "Source Details Can't be inserted";
			} else {
				message = "Source Details Inserted Successfully";
			}
		}
		catch (Exception e) {
			System.out.println("exception in insertSourceDetails method of Rws_privateSourceDAO" + e);
		} finally {

		}
		return message;
	}
	private static void compressImage(File scannedFile, File targetFile) throws IOException {

		InputStream is = new FileInputStream(scannedFile);
		OutputStream os = new FileOutputStream(targetFile);

		float quality = 0.5f;

		BufferedImage image = ImageIO.read(is);

		Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpg");

		if (!writers.hasNext())
			throw new IllegalStateException("No writers found");

		ImageWriter writer = (ImageWriter) writers.next();
		ImageOutputStream ios = ImageIO.createImageOutputStream(os);
		writer.setOutput(ios);

		ImageWriteParam param = writer.getDefaultWriteParam();

		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(quality);

		writer.write(null, new IIOImage(image, null, null), param);

		is.close();
		os.close();
		ios.close();
		writer.dispose();
	}    
	
	
	String yearmonthdayformat(String date)
	{
		String result="";
		 if(date.contains("-")){
		String[] dates=date.split("-");
		result= dates[2]+"-"+dates[1]+"-"+dates[0];
		 }else
			 if(date.contains("/")){
					String[] dates=date.split("/");
					result= dates[2]+"-"+dates[1]+"-"+dates[0];
					 }
		 
		 return result;
	}
	
	
	

}