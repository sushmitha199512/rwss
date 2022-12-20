package nic.watersoft.masters;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.drought.DroughtFlushRecords;

public class RWS_Direct_Bills_DAO {
	Connection conn = null;
	Connection conn2 = null;
	Statement stmt = null;
	Statement stmt2 = null;
	PreparedStatement pstat = null;
	PreparedStatement pstat1 = null;
	PreparedStatement pstat2 = null;
	PreparedStatement ps = null;
	ResultSet rset = null;
	ResultSet rs = null;
	ResultSet rset1 = null;
	ResultSet rset2 = null;
	String query = null;
	String query1 = null;
	String query2 = null;

		private boolean flag;

	public RWS_Direct_Bills_DAO()
	{
		 
		try
		{
			
		}
		catch (Exception e)
		{
			Debug.println("Exception in WorksData():"+e);
		}
	}
	public RWS_Direct_Bills_DAO(DataSource dataSource)
	{
		try
		{
		}
		catch(Exception e)
		{	
			Debug.println("Exception in WorksData(datasource):"+e);
		}
	}



	public String getDate()
	{
		Date date = new Date();
   SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        String datenewformat = formatter.format(date);
		return datenewformat;
	}

	public String getMonthName(DataSource dataSource, String monthcode)
	{
		String monthName = "";
		try
		{
			conn = RwsOffices.getConn();
			query = " SELECT month_name FROM rws_month_mast_tbl WHERE month_code = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1,monthcode);
			rset = pstat.executeQuery();
			if (rset.next())
			{
				monthName = rset.getString("month_name");
			}
			if(rset!=null)rset.close();
		}
		catch (Exception e)
		{
			Debug.println("Exception in getMonthName():"+e);
		}
		finally
		{
			try
			  {
				if(rset!=null)rset.close();
				if(pstat!=null)pstat.close();
				if(conn!=null)conn.close();
			  }
			catch(Exception e)
			{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
		}
		return monthName;
	}


public String getcircleName(DataSource dataSource,String circleCode)
	{
		
		String circleName = "";
		try
		{
			conn = RwsOffices.getConn();
			query = " SELECT circle_office_name FROM RWS_CIRCLE_OFFICE_TBL  WHERE CIRCLE_OFFICE_CODE = ? ";
			pstat = conn.prepareStatement(query);
			pstat.setString(1,circleCode);
			
			rset = pstat.executeQuery();
			if (rset.next())
			{	
				
				circleName = rset.getString("circle_office_name");
			}
			if(rset!=null)rset.close();
		}
		catch (Exception e)
		{
			Debug.println("Exception getcircleName():"+e);
		}
		finally
		{
			try
			  {
				if(rset!=null)rset.close();
				if(pstat!=null)pstat.close();
				if(conn!=null)conn.close();
			  }
			catch(Exception e)
			{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
		}
			return circleName;
	}


public static boolean checkBills(String workid,Connection connn)
{
	boolean flag = false;
	try
	{
		
		Statement stmt = connn.createStatement();
		String qry = "select * from rws_work_bill_tbl where WORK_ID='"+workid+"'";
		Debug.println("qry in checkbill:"+qry);
		ResultSet rs = stmt.executeQuery(qry);
		if(rs.next())flag=true;
	}
	catch (Exception e)
	{
		//Debug.println("Exception in this function:"+e);
	}
	return flag;
}
public static boolean checkMileStone(String workid,Connection connn)
{
	boolean flag = false;
	try
	{
		
		Statement stmt = connn.createStatement();
		String qry = "select * from RWS_MILESTONE_TARGET_ACH_TBL where WORK_ID='"+workid+"'";
		Debug.println("qry in checkbill:"+qry);
		ResultSet rs = stmt.executeQuery(qry);
		if(rs.next())flag=true;
	}
	catch (Exception e)
	{
		//Debug.println("Exception in this function:"+e);
	}
	return flag;
}


public String getdivisionName(DataSource dataSource,String circleCode,int divisionCode)
	{
		
		String divisionName = "";
		try
		{
			conn = RwsOffices.getConn();
			query = " SELECT division_office_name FROM RWS_division_OFFICE_TBL  WHERE CIRCLE_OFFICE_CODE = ? and division_office_code = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1,circleCode);
			pstat.setInt(2,divisionCode);
			rset = pstat.executeQuery();
			if (rset.next())
			{	
				
				divisionName = rset.getString("division_office_name");
			}
			if(rset!=null)rset.close();
		}
		catch (Exception e)
		{
			Debug.println("Exception getdivisionName():"+e);
		}
		finally
		{
			try
			  {
				if(rset!=null)rset.close();
				if(pstat!=null)pstat.close();
				if(conn!=null)conn.close();
			  }
			catch(Exception e)
			{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
		}
		{
			releaseConnection();

		}
		return divisionName;
	}



public String getsubDivisionName(DataSource dataSource, String circleCode, int divisionCode, String subdivisionCode)
	{
		
		String subdivisionName = "";
		try
		{
			conn = RwsOffices.getConn();
			query = " SELECT subdivision_office_name FROM RWS_SUBDIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE = ? and DIVISION_OFFICE_CODE = ? and subdivision_office_code = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1,circleCode);
			pstat.setInt(2,divisionCode);
			pstat.setString(3,subdivisionCode);			
			rset = pstat.executeQuery();
			if (rset.next())
			{	
				
				subdivisionName = rset.getString("subdivision_office_name");
			}
			if(rset!=null)rset.close();
		}
		catch (Exception e)
		{
			Debug.println("Exception getsubDivisionName():"+e);
		}
		finally
		{
			try
			  {
				if(rset!=null)rset.close();
				if(pstat!=null)pstat.close();
				if(conn!=null)conn.close();
			  }
			catch(Exception e)
			{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
		}
		return subdivisionName;
	}

	public String getprogrammeName(DataSource dataSource,String programmeCode)
	{
		
		String programmeName = "";
		try
		{
			conn = RwsOffices.getConn();
			query = " SELECT programme_name FROM rws_programme_tbl  WHERE programme_code = ? ";
			pstat = conn.prepareStatement(query);
			pstat.setString(1,programmeCode);
			rset = pstat.executeQuery();
			if (rset.next())
			{	
				
				programmeName = rset.getString("programme_name");
			}
		}
		catch (Exception e)
		{
			Debug.println("Exception getprogrammeName():"+e);
		}
		finally
		{
			try
			{if(rset!=null)rset.close();
			if(pstat!=null)pstat.close();
			if(conn!=null)conn.close();
			}
			catch(Exception e)
			{}
			
		}
		
		return programmeName;
	}


public String getsubprogrammeName(DataSource dataSource,String programmeCode,String subprogrammeCode)
	{
		String query="";
		String subprogrammeName = "";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT subprogramme_name FROM rws_subprogramme_tbl  WHERE programme_code = ? and subprogramme_code = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1,programmeCode);
			pstat.setString(2,subprogrammeCode);
			rset = pstat.executeQuery();
			if (rset.next())
			{	
				subprogrammeName = rset.getString("subprogramme_name");
			}
		}
		catch (Exception e)
		{
			Debug.println("Exception getsubprogrammeName():"+e);
		}
		finally
		{
			try
			  {
				if(rset!=null)rset.close();
				if(pstat!=null)pstat.close();
				if(conn!=null)conn.close();
			  }
			catch(Exception e)
			{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
		}
		return subprogrammeName;
	}



	public ArrayList getMandals(DataSource dataSource,String circlecode) throws Exception
	{
		Debug.println("trying to get the mandals.....");
		ArrayList mtenderMemo = null;
		String query = null;
		try
		{
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE" +
			 " DCODE=? ORDER BY MNAME";
			Debug.println("Query:"+query);
			ps = conn.prepareStatement(query);
			ps.setString(1,circlecode);
			rs = ps.executeQuery();
			Rws_Direct_Bills_Bean tendermemo = null;
				mtenderMemo = new ArrayList();
				while (rs.next())
				{
					tendermemo = new Rws_Direct_Bills_Bean();
		 			tendermemo.setMandalCode(rs.getString(2));
					tendermemo.setMandalName(rs.getString(3));
		 			mtenderMemo.add(tendermemo);
				}
		}
		catch (Exception e)
		{
			Debug.println("The error in getMandals()=== Works Data "+e);
		}
		finally 
		{
			if(rs!=null)rs.close();
			if(stmt!=null)stmt.close();
			if(conn!=null)conn.close();
		}
		Debug.println("3.5:"+mtenderMemo.size());
		return mtenderMemo;
	}
	
public ArrayList MileStones(DataSource dataSource)
{
	ArrayList ntenderMemo = null;
	try
	{
		
		conn2 = RwsOffices.getConn();
		query = " SELECT MILESTONE_CODE  ,MILESTONE_NAME  FROM " +
				" rws_milestone_tbl " ;
				
		stmt2 = conn2.createStatement();
		rset1 = stmt2.executeQuery(query);
		Rws_Direct_Bills_Bean tendermemo = null;
		ntenderMemo = new ArrayList();
		while (rset1.next())
		{
			tendermemo = new Rws_Direct_Bills_Bean();
			tendermemo.setMstoneCode(rset1.getString(1));
			tendermemo.setMstoneName(rset1.getString(2));
			
			
			ntenderMemo.add(tendermemo);
		}
	
	}
	catch (Exception e)
	{
		Debug.println("Exception in MileStones()"+e);
	}
	finally
	{
		try
		  {
			if(rset1!=null)rset1.close();
			if(stmt2!=null)stmt2.close();
			conn2.close();
		  }
		catch(Exception e)
		{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
	}
	return ntenderMemo;
}

public void releaseConnection()
{
		try
		{
			if (rset != null)
			{
				if(rset!=null)rset.close();
				rset=null;
			}
			if (pstat != null)
			{
				if(pstat!=null)pstat.close();
				pstat=null;
			}
			if (conn != null)
			{
				if(conn!=null)conn.close();
				conn=null;
			}
			if (conn2 != null)
			{
				conn2.close();
				conn2=null;
			}
			
		}
		catch (Exception e)
		{
			Debug.println("Exception:"+e);
		}
}

	
		public ArrayList getProgramMileStones(DataSource dataSource,String workId)
		{
			ArrayList mileStrone=new ArrayList();
			Connection conn=null;
			try
			{
				conn=RwsOffices.getConn();
				Statement stmt=conn.createStatement();
				String qry = "select MILESTONE_NAME ,MILESTONE_STAGE_NAME ," +
				"to_char(TARGET_DATE,'dd/mm/yyyy'),PERCENT_COMPLETED ,WORK_ID,ah.MILESTONE_CODE,ah.MILESTONE_STAGE_CODE " +
				" ,to_char(ah.ACHIEVE_DATE ,'dd/mm/yyyy'),COMPONENT_NO,PERCENT_COMPLETED_WORK,MAJOR_MILESTONE_CODE,MILESTONE_SLNO,PERCENT_COMPLETED_WORK*100000 as amnt,nvl(PERCENT_COMPLETED*100000,0) as amntt1,ms_stage,decode(TYPE_OF_CONTRACTOR,'1','Civil','2','Electrical','3','Mechanical','4','Borewell','5','Spill Over') as TYPE_OF_CONTRACTOR,to_char(EOAT_DT,'dd/mm/yyyy') as EOAT_DT,COMPONENT_NO_ACH,decode(ms_stage,'1','Not Started','2','In Progress','3','Complted') as stagge,PERCENT_COMPLETED_WORK_VAL,PERCENT_COMPLETED_VAL" +
				" from  RWS_MILESTONE_TARGET_ACH_TBL " +
				"ah,rws_milestone_tbl mi,"
              +" rws_milestone_stage_tbl smi where  " +
        		"ah.MILESTONE_CODE =mi.MILESTONE_CODE and ah.MILESTONE_CODE " +
        		"=smi.MILESTONE_CODE and ah.MILESTONE_STAGE_CODE=smi.MILESTONE_STAGE_CODE " +
        		"and ah.work_id='"+workId+"'  order by MAJOR_MILESTONE_CODE,MILESTONE_SLNO";
				//qry = "select MILESTONE_SLNO,WORK_ID,MAJOR_MILESTONE_CODE,MILESTONE_CODE,MILESTONE_STAGE_CODE,COMPONENT_NO,to_char(TARGET_DATE,'dd/mm/yyyy') TARGET_DATE,to_char(ACHIEVE_DATE,'dd/mm/yyyy') ACHIEVE_DATE,PERCENT_COMPLETED_WORK,PERCENT_COMPLETED from   rws_MILESTONE_TARGET_ACH_TBL   where  WORK_ID  ='"+workId+"' order by MILESTONE_SLNO" ;
				Debug.println("getting programm milestones:"+qry);
				ResultSet rs=stmt.executeQuery(qry);
				while(rs.next())
				{
					Rws_Direct_Bills_Bean tm=new Rws_Direct_Bills_Bean();
					tm.setWorkid(rs.getString("WORK_ID"));
					tm.setMileStoneSno(rs.getString("MILESTONE_SLNO"));
				 	tm.setMstoneName(rs.getString(1));
				 	tm.setMstoneStageName(rs.getString(2));
					tm.setTargetDate(rs.getString(3));
					tm.setPercentComp(rs.getString(4));
					tm.setWorkid(rs.getString(5));
					tm.setMstoneCode(rs.getString(6));
					tm.setMstoneStageCode(rs.getString(7));
					tm.setAchievementDate(rs.getString(8));
					tm.setPerCompInWorkValue(rs.getString("PERCENT_COMPLETED_WORK_VAL"));
					Debug.println("3:"+tm.getPerCompInWorkValue());
					tm.setMajorMileStone(rs.getString("MAJOR_MILESTONE_CODE"));
					tm.setCompInNo(rs.getString("COMPONENT_NO"));
					tm.setPerCompInWork(rs.getString("PERCENT_COMPLETED_WORK"));
					Debug.println("2:"+rs.getLong("amntt1"));
					tm.setPerCompValue(rs.getString("PERCENT_COMPLETED_VAL"));
					tm.setMileStoneProgress(rs.getString("ms_stage"));
					tm.setTypeOfContractor(rs.getString("TYPE_OF_CONTRACTOR"));
					tm.setEoatTargetDate(rs.getString("EOAT_DT"));
					tm.setCompInNoAch(rs.getString("COMPONENT_NO_ACH"));
					tm.setBudgetInfo(rs.getString("stagge"));
					if((rs.getString(8)!=null && !rs.getString(8).equals("")) || (rs.getString(4)!=null && !rs.getString(4).equals("")))
						tm.setLabel("Y");
					else
						tm.setLabel("N");
					mileStrone.add(tm);
				}
			}
			catch(Exception e)
			{
				Debug.println("Exception in getProgramMileStones:"+e);
			}
			return mileStrone;
		}
		public boolean saveMileStonesForProg(DataSource ds,String mstone,String stage,String achDate,String workID,String perComp,String majorMileStone,String mileStoneSno,String pStage,String compNoAch,String perCompValue)throws Exception 
		{
			boolean status=true;
			try{
			conn=RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt=conn.createStatement();
			String qry = "Update RWS_MILESTONE_TARGET_ACH_TBL set ACHIEVE_DATE =to_date('"+achDate+"','dd/mm/yyyy'),PERCENT_COMPLETED='"+perComp+"',ms_stage='"+pStage+"',COMPONENT_NO_ACH='"+compNoAch+"',PERCENT_COMPLETED_VAL='"+perCompValue+"'" +
    		" where work_id='"+workID+"' and MILESTONE_CODE = '"+mstone+"' and MAJOR_MILESTONE_CODE = '"+majorMileStone+"'" +
    		" and MILESTONE_STAGE_CODE ='"+stage+"' and MILESTONE_SLNO = '"+mileStoneSno+"'";
			 //System.out.println("Qry:"+qry);
		     
		    stmt.executeUpdate(qry);
		    conn.commit();
			}
			catch(Exception e)
			{
				Debug.println("Exception saveMileStonesForProg:"+e);
			}
			finally 
			{
				if(conn!=null)conn.close();
			}
			return status;
		}

		public static double round(double d, int decimalPlace){
			BigDecimal bd = null;
			try{
		    bd = new BigDecimal(Double.toString(d));
		    bd = bd.setScale(decimalPlace,BigDecimal.ROUND_HALF_UP);
			}catch(Exception e)
			{
				e.printStackTrace();
			}
		    return bd.doubleValue();
		  }
		public static long round1(long d, int decimalPlace){
		    BigDecimal bd = new BigDecimal(Long.toString(d));
		    bd = bd.setScale(decimalPlace,BigDecimal.ROUND_HALF_EVEN);
		    return bd.longValue();
		  }
		public static double round(float d, int decimalPlace)
		{
		    BigDecimal bd = new BigDecimal(Double.toString(d));
		    bd = bd.setScale(decimalPlace,BigDecimal.ROUND_HALF_UP);
		    return bd.doubleValue();
		  }

		
		 public ArrayList getEmployees(String dcode,int start,int end)
		 {

			ArrayList employees = new ArrayList();
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				query = "SELECT EMPLOYEE_CODE,EMPLOYEE_SURNAME||'.'||EMPLOYEE_NAME,designation_acr FROM rws_employee_tbl a,rws_designation_tbl b where a.designation_code=b.designation_code and substr(OFFICE_CODE,2,2) = '"+dcode+"' and (a.DESIGNATION_CODE>="+start+" and a.DESIGNATION_CODE<="+end+") ORDER BY a.DESIGNATION_CODE";
				Debug.println("qry in get employeessssss:"+query);
				rset = stmt.executeQuery(query);
				LabelValueBean bean = null;
				while (rset.next())
				{
					bean = new LabelValueBean();
					bean.setValue(rset.getString(1));
					bean.setLabel(rset.getString(3)+" - "+rset.getString(1)+" - "+rset.getString(2));
					employees.add(bean);
				}
			}
			catch (Exception e)
			{
				Debug.println("Exception in getEmployesssssssssss():"+e);
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
			return employees;
		
		 }
		 public ArrayList getContractors(String workId)
		 {

			ArrayList conts = new ArrayList();
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				query = "SELECT a.contractor_code,contractor_name_company FROM rws_contractor_tbl a,rws_contractor_selection_tbl b where a.contractor_code=b.contractor_code and b.work_id='"+workId+"'";
				Debug.println("qry in get getContractors:"+query);
				rset = stmt.executeQuery(query);
				LabelValueBean bean = null;
				while (rset.next())
				{
					bean = new LabelValueBean();
					bean.setValue(rset.getString(1));
					bean.setLabel(rset.getString(2));
					conts.add(bean);
				}
			}
			catch (Exception e)
			{
				Debug.println("Exception in getContractors():"+e);
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
			return conts;
		
		 }
		 public ArrayList getAllBills(String workId)
		 {

			ArrayList conts = new ArrayList();
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
			String	query2 = "SELECT BILL_SL_NO,BILL_NO  FROM rws_work_direct_bill_tbl where work_id='"+workId+"' order by BILL_SL_NO";
				Debug.println("qry in get get all bills:"+query2);
				rset = stmt.executeQuery(query2);
				LabelValueBean bean = null;
				while (rset.next())
				{
					bean = new LabelValueBean();
					bean.setValue(rset.getString(1));
					bean.setLabel(rset.getString(2));
					conts.add(bean);
				}
			}
			catch (Exception e)
			{
				Debug.println("Exception in getAllBills():"+e);
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
			return conts;
		
		 }
		 
		 public String getBillVoucherAmount(String workId,String bill)
		 {
		 	System.out.println("ssssssss:");
		 	DecimalFormat ndf = new DecimalFormat("####.00");
		 	ResultSet rs123 = null;
		 	String returnValue = "";
		 	try{
		 		conn = RwsOffices.getConn();
		 	   Statement stqq =null; 
		 	   ResultSet rsqq = null;
		 	  String getAmount = "";
		 	   Statement gmst1 = conn.createStatement();
		 	   System.out.println("bill:"+bill);
		 	   if(bill.equals("0"))
		 	   {
		 	   		getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_direct_bill_tbl  where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
		 	   		ResultSet gmrs1 = gmst1.executeQuery(getAmount);
			 	   if(gmrs1.next())
			 		{
			 			returnValue = gmrs1.getString(1);
			 		}
			 		else 
			 		{
			 			returnValue = "0";
			 		}
		 	   }
		 	  else
		 	  {
		 	  		
		 	  	getAmount ="select nvl(sum(BILL_AMT_ADMISSIBLE),0)  from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"'" ;
		 	  			
		 	  		System.out.println("QRY@@@@@:"+getAmount);
		 	  		ResultSet gmrs1 = gmst1.executeQuery(getAmount);
		 	   		long val1=0,val2=0;
			 	   if(gmrs1.next())
			 		{
			 	   		if(gmrs1.getString(1)!=null && !gmrs1.getString(1).equals(""))
			 	   			val1 = gmrs1.getLong(1);
			 	   		
			 		}
			 	   Debug.println("val1:"+val1);
			 	 
		 	   		returnValue = ""+(val1);
		 	  } 
				 		returnValue = "";
		 	   Debug.println("qryssssdddddddddsssss:"+getAmount);
		 	   
		 		
		 	String stat123="select nvl(sum(voucher_amt),0) from rws_work_direct_voucher_tbl  where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
		 	Debug.println("stat12333333333:"+stat123);
		 	stqq = conn.createStatement();
		 	rsqq=stqq.executeQuery(stat123);
		 	 if(rsqq.next())
		 	{
		 		//returnValue += ""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2)
		 		returnValue += ""+rsqq.getString(1);//Math.round(Float.parseFloat(rsqq.getString(1))*100000*100)/100f);
		 	}
		 	else
		 	{
		 		returnValue += "0";
		 	}
		 	}
		 	   catch(Exception e)
		 	   {
		 			System.out.println("EXCEPTION IN getting Connection"+e.getMessage());
		 	   } 
		 	   finally
		 	   {
		 			try
		 			{
		 			}
		 			catch(Exception d)
		 			{

		 			}
		 	}
		 	return returnValue;
		 }
		 
		 
		 public ArrayList getVouchers(String workId)
		 {
			ArrayList vouchers = new ArrayList();
			try
			{
				
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
			String	query3 = "SELECT recorded_by,to_char(recorded_date,'dd/mm/yyyy'),check_measured_by,to_char(check_measure_dt,'dd/mm/yyyy'),voucher_no,to_char(voucher_dt,'dd/mm/yyyy'),voucher_amt,cheque_no,to_char(cheque_dt,'dd/mm/yyyy'),SUPER_CHECK_MEASURED_BY,to_char(SUPER_CHECK_MEASURE_DT,'dd/mm/yyyy'),REMARKS,PROGRAMME_CODE,nvl(MBOOK_NO,'') as MBOOK_NO,CONTRACTOR_CODE,GRANT_DISTRIB,BILL_SL_NO from rws_work_direct_voucher_tbl where work_id='"+workId+"' ORDER BY RECORDED_DATE";
			Debug.println("in get vouchers - - dao--->" + query3);
				rset = stmt.executeQuery(query3);
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				while (rset.next())
				{  
					tenderMemoBean = new Rws_Direct_Bills_Bean();
					tenderMemoBean.setProgCode(rset.getString("PROGRAMME_CODE"));
					tenderMemoBean.setSno(rset.getString("MBOOK_NO"));
					tenderMemoBean.setEmpCodeRecorded(rset.getString(1));
					tenderMemoBean.setRecordedDate(rset.getString(2));
					tenderMemoBean.setEmpCode(rset.getString(3)); 
					tenderMemoBean.setCheckMesuaredDate(rset.getString(4));
					tenderMemoBean.setVoucherNo(rset.getString(5));
					tenderMemoBean.setVoucherDate(rset.getString(6)); 
					tenderMemoBean.setVoucherAmount(rset.getString(7));//""+((Double.parseDouble(rset.getString(7)))*100000));
					tenderMemoBean.setChequeNo(rset.getString(8));
					tenderMemoBean.setChequeDate(rset.getString(9));				
					tenderMemoBean.setEmpCodeSuper(rset.getString(10));
					tenderMemoBean.setSuperCheckMesuaredDate(rset.getString(11));
					tenderMemoBean.setCheckMesuaredRemarks(rset.getString(12));
					tenderMemoBean.setContCode(rset.getString("CONTRACTOR_CODE"));
					tenderMemoBean.setBudgetInfo(rset.getString("GRANT_DISTRIB"));
					tenderMemoBean.setBillSlNo(rset.getString("BILL_SL_NO"));
					tenderMemoBean.setMileStoneSno(rset.getString("BILL_SL_NO"));
					
					String amt = getBillVoucherAmount(workId,rset.getString("BILL_SL_NO"));
					
//					System.out.println("value amtttttttt"+amt);
//					String[] amts = amt.split("/");
//					System.out.println("value amtttttttt2222222"+amts[0]);
					System.out.println("value amtttttttt2222222"+amt);
					tenderMemoBean.setPaymentAdmissable(amt);
					//tenderMemoBean.setBillVoucherAmount(amts[1]);
					
					
					/*String query6= "select voucher_amt from rws_work_direct_voucher_tbl where work_id='"+workId+"' and bill_sl_no='"+billNo+"' ";
					ResultSet rset2 = stmt.executeQuery(query6);
					if(rset2.next())
					tenderMemoBean.setBillVoucherAmount(rset2.getString(1));				
					else
						tenderMemoBean.setBillVoucherAmount("0");*/
					//tenderMemoBean.setPaymentMode(rset.getString("payment_mode"));
					vouchers.add(tenderMemoBean);
				}
			}
			catch (Exception e)
			{
				Debug.println("Exception in getVochers():"+e);
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
			return vouchers;
		
		 }
		 public ArrayList getBills(String workId)
		 {
		 	Debug.println("in get bills methodddddddddddddddddddddd");
			ArrayList vouchers = new ArrayList();
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				query = "SELECT BILL_SL_NO,BILL_NO,to_char(bill_date,'dd/mm/yyyy'),BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"' ORDER BY 1";
				Debug.println("qry in get BILLS:"+query);
				rset = stmt.executeQuery(query);
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				String total = "0";
				while (rset.next())
				{
					tenderMemoBean = new Rws_Direct_Bills_Bean();
					tenderMemoBean.setBillSlNo(rset.getString(1));
					tenderMemoBean.setBillNo(rset.getString(2));
					tenderMemoBean.setBillDate(rset.getString(3));
					//tenderMemoBean.setBillDateEE(rset.getString("eeDate"));
					tenderMemoBean.setGrossValueContractor(rset.getString(4)); 
					tenderMemoBean.setGrossValueAdmissable(rset.getString(5));
					
					tenderMemoBean.setGrossValueOfBill(""+(rset.getDouble(5)-(Double.parseDouble(total))));
					
					String stat123="select nvl(sum(voucher_amt),0) from RWS_WORK_DIRECT_VOUCHER_TBL  where work_id='"+workId+"' and BILL_SL_NO ='"+rset.getString(1)+"'";
					//System.out.println("stat123:"+stat123);
					Statement stqq = conn.createStatement();
					ResultSet rsqq=stqq.executeQuery(stat123);
					if(rsqq.next())
						tenderMemoBean.setBillVoucherAmount(rsqq.getString(1));//""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2));
					else
						tenderMemoBean.setBillVoucherAmount("0");
					/*String stat1234="select (select nvl(sum(BILL_AMOUNT_CENTRAL),0)  from rws_bill_bank_bridge_det_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+rset.getString(1)+"' and BILL_ACTIVATION_FLAG='P')a,(select nvl(sum(BILL_AMOUT_state),0)  from rws_bill_pao_bridge_det_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+rset.getString(1)+"' and BILL_ACTIVATION_FLAG='P')b from dual";
					Statement stqqq = conn.createStatement();
					ResultSet rsqqq = stqqq.executeQuery(stat1234);
					if(rsqqq.next())
					{
						tenderMemoBean.setBillReleaseAmount(""+(rsqqq.getLong(1)+rsqqq.getLong(2)));//""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2));
					}
					else
						tenderMemoBean.setBillReleaseAmount("0");*/
					vouchers.add(tenderMemoBean);
				}
			}
			catch (Exception e)
			{
				Debug.println("Exception in getBills():"+e);
				e.printStackTrace();
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
			return vouchers;
		
		 }
		 /**
		  *  Modify BY Sai Prasad N
		  * @param workId
		  * @param billslno
		  * @return
		  */
		 public String getNewBillAmount(String workId,String billslno)
		 {
		 	Debug.println("in getNewBillAmount nethod 111:"+billslno);
			String billAmount = "";
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				if(billslno!=null && billslno.equals("0"))
					query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"' )a,(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"' and bill_sl_no='0')b from dual";
				else if(billslno!=null && Integer.parseInt(billslno)<0)
					query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"' )a,(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"' and bill_sl_no<>'0')b,(select nvl(sum(BILL_AMT_CONTRACTOR),0)-nvl(sum(BILL_AMT_ADMISSIBLE),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"' and bill_sl_no>0)c,(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"' and bill_sl_no<0)d  from dual";
				else
				{
					//query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"' and TYPE_OF_CONTRACTOR <> '5')a,(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"' and bill_sl_no>0)b,(select nvl(sum(BILL_AMT_contractor),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"' and bill_sl_no>0)C,(select nvl(sum(BILL_AMT_ADMISSIBLE),0)-nvl(sum(BILL_AMT_CONTRACTOR),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"' and bill_sl_no>0)D from dual";
					query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"' )a,(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"')b,(select nvl(sum(BILL_AMT_contractor),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"')C,(select nvl(sum(BILL_AMT_ADMISSIBLE),0)-nvl(sum(BILL_AMT_CONTRACTOR),0) from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"')D from dual";
				}
				Debug.println("qry in get getNewBillAmount:"+query);
				rset = stmt.executeQuery(query);
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				String total = "0";
				if (rset.next())
				{
					long achAmount = rset.getLong(1);
					System.out.println("achAmount"+achAmount);
					long billAmt = rset.getLong(2);
					System.out.println("billamout"+billAmt);
					if(billslno!=null  && Integer.parseInt(billslno)<0)
						billAmount = ""+(rset.getLong(3)-rset.getLong(4));
					    //billAmount = rset.getString(3);
					else if(billslno!=null && billslno.equals("0"))
						billAmount = ""+(achAmount-billAmt);
					else 
					{
						Debug.println("in >0");
						Debug.println("amt"+rset.getString(4));
						if(rset.getInt(4)>0)
							billAmount = ""+(achAmount-billAmt);
						else
							billAmount = ""+(achAmount-rset.getLong(3));
						Debug.println("final:"+billAmount);
					}
						 
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
			Debug.println("bill amt:"+billAmount);
			return billAmount;
		
		 }
		 public String getSpillOverAmount(String workId,String billslno)
		 {
		 	Debug.println("in getNewBillAmount methodddddddddddddddddddddd:"+billslno);
			String billAmount = "";
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				//if(billslno!=null && billslno.equals("0"))
					query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"' and TYPE_OF_CONTRACTOR = '5')a,(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where work_id='"+workId+"' and bill_sl_no='0')b from dual";
				/*else if(billslno!=null && billslno.equals("-1"))
					query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"' and TYPE_OF_CONTRACTOR <> '5')a,(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where work_id='"+workId+"' and bill_sl_no<>'0')b,(select nvl(sum(BILL_AMT_CONTRACTOR),0)-nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where work_id='"+workId+"' and bill_sl_no<>'0')c from dual";//49011001100563
				else
				{
					query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"' and TYPE_OF_CONTRACTOR <> '5')a,(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where work_id='"+workId+"' and bill_sl_no>0)b from dual";
					//query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"' and TYPE_OF_CONTRACTOR <> '5')a,(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where work_id='"+workId+"' and bill_sl_no>0)b,(select nvl(sum(BILL_AMT_contractor),0) from rws_work_bill_TBL where work_id='"+workId+"' and bill_sl_no>0)C,(select nvl(sum(BILL_AMT_ADMISSIBLE),0)-nvl(sum(BILL_AMT_CONTRACTOR),0) from rws_work_bill_TBL where work_id='"+workId+"' and bill_sl_no>0)D from dual";
				}*/
				Debug.println("qry in get getNewBillAmount:"+query);
				rset = stmt.executeQuery(query);
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				String total = "0";
				if (rset.next())
				{
					long achAmount = rset.getLong(1);
					long billAmt = rset.getLong(2);
					billAmount = ""+(achAmount-billAmt);
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
			Debug.print("bill amt:"+billAmount);
			return billAmount;
		
		 }
		 
		 public int getNewVoucherAmount(String workId)
		 {
		 	Debug.println("in getNewBillAmount methodddddddddddddddddddddd");
			int flag = 0;
			Rws_Direct_Bills_Bean tenderMemoBean = null;
			
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				String q1 = "select BILL_AMT_ADMISSIBLE from rws_work_direct_bill_tbl where work_id='"+workId+"'";
				Debug.println("qry in get getNewBillAmount:"+q1);
				Statement stmt1 = conn.createStatement();
				ResultSet rs1 = stmt1.executeQuery(q1);
				if(rs1.next()){
					String aa = rs1.getString(1);
					flag =  Integer.parseInt(aa);
					
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
			Debug.println(":"+flag);
			return flag;
		
		 }
		 
		 public ArrayList getBillSNoByWorkId(String workId)
		 {
		 	Debug.println("in getNewBillAmount methodddddddddddddddddddddd");
			ArrayList flag= new ArrayList();
			Rws_Direct_Bills_Bean tenderMemoBean = null;
			
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				String q1 = "select bill_sl_no,bill_no from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_AMT_ADMISSIBLE is not null  order by bill_sl_no";
				Debug.println("qry in get getNewBillAmount:"+q1);
				Statement stmt1 = conn.createStatement();
				ResultSet rs1 = stmt1.executeQuery(q1);
				while(rs1.next()){
					System.out.println("rs1.getString(1) - ->"+ rs1.getString(1));
				String	flag1 =  rs1.getString(1);
				flag.add(flag1);
					
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
			Debug.println(":"+flag);
			return flag;
		
		 }
		 
		 
		
		 public String getBillVoucherAmountbyWorkId(String workId,String bill)
		 {
			 	System.out.println("ssssssss:");
			 	DecimalFormat ndf = new DecimalFormat("####.00");
			 	ResultSet rs123 = null;
			 	String returnValue = "";
			 	try{
			 		conn = RwsOffices.getConn();
			 	   Statement stqq =null; 
			 	   ResultSet rsqq = null;
			 	  String getAmount = "";
			 	   Statement gmst1 = conn.createStatement();
			 	   System.out.println("bill:"+bill);
			 	   if(bill.equals("0"))
			 	   {
			 	   		getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
			 	   		ResultSet gmrs1 = gmst1.executeQuery(getAmount);
				 	   if(gmrs1.next())
				 		{
				 			returnValue = gmrs1.getString(1);
				 		}
				 		else 
				 		{
				 			returnValue = "0";
				 		}
			 	   }
			 	  else
			 	  {
			 	  		
			 	  	getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
			 	  		
			 	  		System.out.println("QRY@@@@@:"+getAmount);
			 	  		ResultSet gmrs1 = gmst1.executeQuery(getAmount);
			 	   		long val1=0,val2=0;
				 	   if(gmrs1.next())
				 		{
				 	   		if(gmrs1.getString(1)!=null && !gmrs1.getString(1).equals(""))
				 	   			val1 = gmrs1.getLong(1);
				 	   		if(gmrs1.getString(2)!=null && !gmrs1.getString(2).equals(""))
				 	   			val2 = gmrs1.getLong(2);
				 		}
				 	   Debug.println("val1:"+val1);
				 	  Debug.println("val2:"+val2);
			 	   		returnValue = ""+(val1+val2);
			 	  } 
					 		returnValue += "/";
			 	   Debug.println("qryssssdddddddddsssss:"+getAmount);
			 	   
			 		
			 	String stat123="select nvl(sum(voucher_amt),0) from rws_work_direct_voucher_tbl  where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' ";
			 	Debug.println("stat12333333333:"+stat123);
			 	stqq = conn.createStatement();
			 	rsqq=stqq.executeQuery(stat123);
			 	 if(rsqq.next())
			 	{
			 		//returnValue += ""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2)
			 		returnValue += ""+rsqq.getString(1);//Math.round(Float.parseFloat(rsqq.getString(1))*100000*100)/100f);
			 	}
			 	else
			 	{
			 		returnValue += "0";
			 	}
			 	}
			 	   catch(Exception e)
			 	   {
			 			System.out.println("EXCEPTION IN getting Connection"+e.getMessage());
			 	   } 
			 	   finally
			 	   {
			 			try
			 			{
			 			}
			 			catch(Exception d)
			 			{

			 			}
			 	}
			 	return returnValue;
			 }
		 public String getBillAmount(String workId)
		 {
		 	ResultSet rs123 = null;
		 	String returnValue = "0";
		 	try{
		 		conn = RwsOffices.getConn();
		 		Statement stqq =null; 
		 		ResultSet rsqq = null;
		 		String getAmount = "";
		 		Statement gmst1 = conn.createStatement();

		 		getAmount = "select nvl(sum(BILL_AMT_ADMISSIBLE),0)  from rws_WORK_bill_tbl where work_id='"+workId+"'";
		 		Debug.println("get bill amt query:"+getAmount);
		 		ResultSet gmrs1 = gmst1.executeQuery(getAmount);
		 		long val1=0;
		 		if(gmrs1.next())
		 		{
			 		if(gmrs1.getString(1)!=null && !gmrs1.getString(1).equals(""))
			 		returnValue = gmrs1.getString(1);
		 		}
		 	   Debug.println("qryssssdddddddddsssss:"+getAmount);
		 	}
	 	   catch(Exception e)
	 	   {
	 			System.out.println("EXCEPTION IN getting Connection"+e.getMessage());
	 	   } 
	 	   finally
	 	   {
	 			try
	 			{
	 			}
	 			catch(Exception d)
	 			{
	
	 			}
		 	}
		 	return returnValue;
		 }

		 public String getServerDate()
		 {
		 	Debug.println("in getServerDate methodddddddddddddddddddddd");
			String serverDate = "";
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				query = "select to_char(sysdate,'dd/mm/yyyy') from dual";
				Debug.println("qry in get getServerDate:"+query);
				rset = stmt.executeQuery(query);
				Rws_Direct_Bills_Bean tenderMemoBean = null;
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
		
		 public String saveBills(ArrayList vouchers,String workId,Collection removes,HttpServletRequest request)
		 {
		 	String returnValue = "Failed to Save/Update Voucher(s)";
				boolean ff = false;
		 	//Debug.println("bbbb:"+removes.size());
			try
			{
				conn = RwsOffices.getConn();
				conn.setAutoCommit(false);
				stmt = conn.createStatement();
				Statement stmt1 = conn.createStatement();
				Statement stmt2 = conn.createStatement();
				Statement stmt3 = conn.createStatement();
				Statement stmt4 = conn.createStatement();
				HttpSession session = request.getSession();
				RwsUser user = null;
				user = (RwsUser) session.getAttribute("RWS_USER");
				Collection c = new ArrayList();
				
				Debug.println("22:"+c.size());
				for(int j=0;j<vouchers.size();j++)
				{
					Rws_Direct_Bills_Bean tenderMemoBean = (Rws_Direct_Bills_Bean)vouchers.get(j);
					Debug.println("BILL no111:"+tenderMemoBean.getBillSlNo());
					String sno = tenderMemoBean.getMileStoneSno();
					Debug.println("BILL no222:"+sno);
					Debug.println("33:"+(removes.contains(tenderMemoBean.getBillSlNo()) && !c.contains(sno)));
					if(removes.contains(tenderMemoBean.getBillSlNo()) && !c.contains(tenderMemoBean.getBillSlNo()))
					{
						String qq = "select * from RWS_WORK_DIRECT_BILL_TBL where work_id='"+workId+"' and bill_sl_no='"+tenderMemoBean.getBillSlNo()+"'";
						Debug.println("qry:"+qq);
						ResultSet rrt = stmt4.executeQuery(qq);
						if(rrt.next())
						{
							if(Integer.parseInt(tenderMemoBean.getGrossValueContractor()) >= Integer.parseInt(tenderMemoBean.getGrossValueAdmissable()))
							{
								query = "update RWS_WORK_DIRECT_BILL_TBL set BILL_AMT_ADMISSIBLE = '"+tenderMemoBean.getGrossValueAdmissable()+"',BILL_AMT_CONTRACTOR='"+tenderMemoBean.getGrossValueContractor()+"' where work_id='"+workId+"' and bill_sl_no='"+tenderMemoBean.getBillSlNo()+"'";
								stmt.addBatch(query);
							}
							else
							{
								ff = true;
							}
						}
						else
						{
							if(Integer.parseInt(tenderMemoBean.getGrossValueContractor()) >= Integer.parseInt(tenderMemoBean.getGrossValueAdmissable()))
							{
								query = "insert into RWS_WORK_DIRECT_BILL_TBL values('"+workId+"'," +
								"'"+tenderMemoBean.getBillSlNo()+"','"+tenderMemoBean.getBillNo()+"',"+
								"to_date('"+tenderMemoBean.getBillDate()+"','dd/mm/yyyy'),"+
								"'"+tenderMemoBean.getGrossValueContractor()+"',"+
								"'"+tenderMemoBean.getGrossValueAdmissable()+"',sysdate,'"+user.getUserId()+"')";
								stmt.addBatch(query);
							}
							else
							{
								ff = true;
							}
							
						}
						Debug.println("save qry:"+j+":"+query);
					}
				}
				
				int[] val = stmt.executeBatch();
				System.out.println("val - - ->"  + val.length);
				int[] vall = {};
				if(val.length>0)
					vall = stmt.executeBatch();
				System.out.println("val - - ->"  + vall.length);
				if(val.length>0 && val.length>0)
				{
					returnValue = "Saved Successfully";
				}
			}
			catch (Exception e)
			{
				try {
					conn.rollback();
					returnValue = "Failed to Save/Update Voucher(s)";
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				Debug.println("Exception in saveVouchers:"+e);
			}
			finally
			{
				try
				  {
					if(stmt!=null)stmt.close();
					if(conn!=null)conn.close();
				  }
				catch(Exception e)
				{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
			}
			if(ff)
				returnValue = "Failed to Save/Update Voucher(s) - Admissible Amount of the Bill Should Not be Greater than Contractor Amount";
			return returnValue;
	}
		 //
		 /**
		  * Modify By Sai Prasad N
		  */
		 public String removeBills(ArrayList vouchers,String workId,String[] removeList,String remarks,String userId)
		 {
		 	Debug.println("in remove bills method");
		 	String returnValue = "";
		 	int alreadyThere = 0;
			try
			{
				conn = RwsOffices.getConn();
				conn.setAutoCommit(false);
				stmt = conn.createStatement();
				Statement stmt2 = conn.createStatement();
				Statement stmt3 = conn.createStatement();
				Statement stt = conn.createStatement();
				Statement stt1 = conn.createStatement();
				Statement stt2 = conn.createStatement();
				
				boolean flag = false;
				Rws_Direct_Bills_Bean tenderMemoBeann = (Rws_Direct_Bills_Bean)vouchers.get(0);
				if(tenderMemoBeann.getBillSlNo().equals("0"))
					flag = true;
				Debug.println("Flag:"+flag);
				
				String index = "";
				Debug.println("vouchers.size():"+vouchers.size());
				for(int i = 0;i<vouchers.size();i++)
	        	{
					Rws_Direct_Bills_Bean tenderMemoBean = (Rws_Direct_Bills_Bean)vouchers.get(i);
					Debug.println("bbbbbbbbbbbbbbbbbbb:"+tenderMemoBean.getBillSlNo());
					
					if(tenderMemoBean.getBillSlNo().equals(removeList[0]))
					{
						index = ""+i;
					}
	        	}
				for(int i = 0;i<removeList.length;i++)
	        	{
					Debug.println("aaaaaaaaaaaaaa:"+removeList[i]);
					Rws_Direct_Bills_Bean tenderMemoBean = (Rws_Direct_Bills_Bean)vouchers.get(Integer.parseInt(index)); 
					query = "select * from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_SL_NO='"+tenderMemoBean.getBillSlNo()+"'";
					Debug.println("select in DELETE qry:"+i+":"+query);
					ResultSet rss = stt.executeQuery(query);
 
					 if(rss.next() && alreadyThere >= 0)
					{
						query1 = "delete from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_SL_NO='"+tenderMemoBean.getBillSlNo()+"'";
						Debug.println("in DELETE qry:"+i+":"+query1);
						stmt.addBatch(query1);
						//query1 = "delete from rws_MILESTONE_TARGET_ACH_TBL where work_id='"+workId+"' and BILL_SL_NO='"+tenderMemoBean.getBillSlNo()+"'";
						//Debug.println("in DELETE qry:"+i+":"+query1);
						//stmt.addBatch(query1);						
					}
					else
					{
						alreadyThere ++;
					}
	        	}
				int[] val = stmt.executeBatch();
				if(val.length>0)
				{
					conn.setAutoCommit(true);
					conn.commit();
					Debug.println("alreadyThere:"+alreadyThere);
					if(alreadyThere==0)
						returnValue = (removeList.length)+"Bill(s) Deleted Successfully for the Work ID:"+workId;
					if(alreadyThere>0)
						returnValue = (removeList.length-alreadyThere)+"Bill(s) Deleted Successfully and "+alreadyThere+" Bill(s) Not Deleted Because Voucher(s) Exists for the Work ID:"+workId;
				}
				else
				{
					if(alreadyThere==-1)
						returnValue = "Bill cannot be Deleted because Head Office released the amount (GOI/State) for this Bill of the Work ID:"+workId;
					else if(alreadyThere==-2)
						returnValue = "Bill cannot be Deleted because Head Office to be released the amount (GOI/State) for this Bill of the Work ID:"+workId;
					else 
						returnValue = "No Bill(s) Removed Because Voucher(s) Exists for the Bill(s)";
				}
				
			}
			catch (Exception e)
			{
				try {
					conn.rollback();
					returnValue = "Failed to Remove Bill(s)";
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				Debug.println("Exception in remove bills:"+e);
			}
			finally
			{
				try
				  {
					if(stmt!=null)stmt.close();
					if(conn!=null)conn.close();
				  }
				catch(Exception e)
				{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
			}
			return returnValue;
		 }
		 public ArrayList getVouchers(String workId,String slNo)
		 {

			ArrayList vouchers = new ArrayList();
			try
			{
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				query = "SELECT recorded_by,to_char(recorded_date,'dd/mm/yyyy'),check_measured_by,to_char(check_measure_dt,'dd/mm/yyyy'),voucher_no,to_char(voucher_dt,'dd/mm/yyyy'),voucher_amt,cheque_no,to_char(cheque_dt,'dd/mm/yyyy'),SUPER_CHECK_MEASURED_BY,to_char(SUPER_CHECK_MEASURE_DT,'dd/mm/yyyy'),REMARKS,PROGRAMME_CODE,nvl(MBOOK_NO,'') as MBOOK_NO,MILESTONE_SLNO,CONTRACTOR_CODE,GRANT_DISTRIB,BILL_SL_NO,BILL_SL_NO from RWS_WORK_DIRECT_VOUCHER_TBL where work_id='"+workId+"' ORDER BY RECORDED_DATE";//and MILESTONE_SLNO ='"+slNo+"'
				Debug.println("qry in get voucherssssssssssssssssddd:"+query);
				rset = stmt.executeQuery(query);
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				while (rset.next())
				{
					tenderMemoBean = new Rws_Direct_Bills_Bean();
					tenderMemoBean.setMileStoneSno(rset.getString("MILESTONE_SLNO"));
					tenderMemoBean.setProgCode(rset.getString("PROGRAMME_CODE"));
					tenderMemoBean.setSno(rset.getString("MBOOK_NO"));
					tenderMemoBean.setEmpCodeRecorded(rset.getString(1));
					tenderMemoBean.setRecordedDate(rset.getString(2));
					tenderMemoBean.setEmpCode(rset.getString(3)); 
					tenderMemoBean.setCheckMesuaredDate(rset.getString(4));
					tenderMemoBean.setVoucherNo(rset.getString(5));
					tenderMemoBean.setVoucherDate(rset.getString(6));
					tenderMemoBean.setVoucherAmount(rset.getString(7));//""+round(((Double.parseDouble(rset.getString(7)))*100000),2));
					tenderMemoBean.setChequeNo(rset.getString(8));
					tenderMemoBean.setChequeDate(rset.getString(9));					
					tenderMemoBean.setEmpCodeSuper(rset.getString(10));
					tenderMemoBean.setSuperCheckMesuaredDate(rset.getString(11));
					tenderMemoBean.setCheckMesuaredRemarks(rset.getString(12));
					if(rset.getString("CONTRACTOR_CODE")!=null && !rset.getString("CONTRACTOR_CODE").equals(""))
						tenderMemoBean.setContCode(rset.getString("CONTRACTOR_CODE"));
					else
						tenderMemoBean.setContCode("");
					tenderMemoBean.setBudgetInfo(rset.getString("GRANT_DISTRIB"));
					tenderMemoBean.setBillSlNo(rset.getString("BILL_SL_NO"));
					Statement stqq =null; 
				   ResultSet rsqq = null;
					String getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_direct_bill_tbl where work_id='"+workId+"' and BILL_SL_NO ='"+rset.getString("BILL_SL_NO")+"' ";
				   	//System.out.println("qry:"+getAmount);
				   Statement gmst1 = conn.createStatement();
				   ResultSet gmrs1 = gmst1.executeQuery(getAmount);
				   if(gmrs1.next())
					{
						tenderMemoBean.setPaymentAdmissable(gmrs1.getString(1));
					}
					else
					{
						tenderMemoBean.setPaymentAdmissable("0");
					}
				   
				   String stat123="select nvl(sum(voucher_amt),0) from rws_work_direct_voucher_tbl  where work_id='"+workId+"' and BILL_SL_NO ='"+rset.getString("BILL_SL_NO")+"'";
				   //System.out.println("stat123:"+stat123);
				   stqq = conn.createStatement();
				   rsqq=stqq.executeQuery(stat123);
				    if(rsqq.next())
				   {
				    	tenderMemoBean.setBillVoucherAmount(rsqq.getString(1));//""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2));
				   }
				   else
				   {
				   	tenderMemoBean.setBillVoucherAmount(rsqq.getString(1));
				   }
					vouchers.add(tenderMemoBean);
				}
			}
			catch (Exception e)
			{
				Debug.println("Exception in WorkStageList():"+e);
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
			return vouchers;
		
		 }
		 public String saveVouchers(ArrayList vouchers,String workId,ArrayList progs)
		 {
		 	String returnValue = "";
			try
			{
				conn = RwsOffices.getConn();
				conn.setAutoCommit(false);
				stmt = conn.createStatement();
				Statement stmt1 = conn.createStatement();
				Statement stmt2 = conn.createStatement();
				Statement stmt3 = conn.createStatement();
				query = "delete from rws_work_direct_voucher_tbl where work_id='"+workId+"'";
				Debug.println("qry in save to deleete vouchers:"+query);
				stmt.addBatch(query);
				for(int j=0;j<vouchers.size();j++)
				{
					Rws_Direct_Bills_Bean tenderMemoBean = (Rws_Direct_Bills_Bean)vouchers.get(j);
					Debug.println("voucher no:"+tenderMemoBean.getVoucherNo());
					String sno = "";
					Debug.println("Voucher Amount in Rupees:"+tenderMemoBean.getVoucherAmount());
					double vAmount = (Double.parseDouble(tenderMemoBean.getVoucherAmount()))/100000;
					vAmount = round(vAmount,2);
					Debug.println("Voucher Amount in Lakhs:"+vAmount);
					query = "insert into rws_work_direct_voucher_tbl values('"+workId+"'," +
							"'"+tenderMemoBean.getEmpCodeRecorded()+"',"+
							"to_date('"+tenderMemoBean.getRecordedDate()+"','dd/mm/yyyy'),"+
							"to_date('"+tenderMemoBean.getCheckMesuaredDate()+"','dd/mm/yyyy'),"+
							"'"+tenderMemoBean.getEmpCode()+"',"+
							"'"+tenderMemoBean.getVoucherNo()+"',"+
							"to_date('"+tenderMemoBean.getVoucherDate()+"','dd/mm/yyyy'),"+
							"'"+tenderMemoBean.getVoucherAmount()+"',"+
							"'"+tenderMemoBean.getChequeNo()+"',"+
							"to_date('"+tenderMemoBean.getChequeDate()+"','dd/mm/yyyy'),"+				
							"to_date('"+tenderMemoBean.getSuperCheckMesuaredDate()+"','dd/mm/yyyy'),"+
							"'"+tenderMemoBean.getEmpCodeSuper()+"',"+
							"'"+tenderMemoBean.getCheckMesuaredRemarks()+"'," +
							"'"+tenderMemoBean.getProgCode()+"'," +
							"'"+tenderMemoBean.getSno()+"'," +
							"'"+sno+"','"+tenderMemoBean.getContCode()+"','"+tenderMemoBean.getBudgetInfo()+"','','','')";
					Debug.println("save qry:"+j+":"+query);
					stmt.addBatch(query);
				}
				int[] val = stmt.executeBatch();
				
				
			}
			catch (Exception e)
			{
				try {
					conn.rollback();
					returnValue = "Failed to Save/Update Voucher(s)";
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				Debug.println("Exception in saveVouchers:"+e);
			}
			finally
			{
				try
				  {
					if(stmt!=null)stmt.close();
					if(conn!=null)conn.close();
				  }
				catch(Exception e)
				{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
			}
			return returnValue;
		
		 }
		 
		 
		 public String getmilseStoneNo(String workId,String slNo){
			 	String mileSlNo="";				
				try
				{
					conn = RwsOffices.getConn();
					stmt = conn.createStatement();
					String q1 = "select MILESTONE_SLNO from rws_milestone_target_ach_tbl where work_id='"+workId+"' and MILESTONE_SLNO='"+slNo+"'";
					Debug.println("MILESTONE_SLNO  - -:"+q1);
					Statement stmt1 = conn.createStatement();
					ResultSet rs1 = stmt1.executeQuery(q1);
					while(rs1.next()){
						System.out.println("rs1.getString(1) - ->"+ rs1.getString(1));
						mileSlNo =  rs1.getString(1);
					}
					
				}
				catch (Exception e)
				{
					Debug.println("Exception in gmileSlNo:"+e);
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
				Debug.println(":"+flag);
				return mileSlNo;
			
			 
		 }
		 
		 public boolean getCheckWorkId(String workId,String slNo,String milestone){


				try {
					conn = RwsOffices.getConn();
					Statement pstmt = conn.createStatement();
					ResultSet rs1 = null;

					String query = "select * from RWS_WORK_direct_VOUCHER_TBL where work_id='"+workId+"' and bill_sl_no='"+slNo+"' and MILESTONE_SLNO='"+milestone+"' and VOUCHER_AMT is not null";
					System.out.println("Query************************:" + query);
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
		 public String saveVouchers(ArrayList vouchers,String workId)
		 {
			 

			 	String returnValue = "";
				try
				{
					conn = RwsOffices.getConn();
					conn.setAutoCommit(false);
					stmt = conn.createStatement();
					Statement stmt1 = conn.createStatement();
					Statement stmt2 = conn.createStatement();
					Statement stmt3 = conn.createStatement();
					//Statement stmt4 = conn.createStatement();
					query = "delete from RWS_WORK_direct_VOUCHER_TBL where work_id='"+workId+"'";// and MILESTONE_SLNO='"+slNo+"'";
					Debug.println("qry in save to deleete vouchers:"+query);
					stmt.addBatch(query);
					for(int j=0;j<vouchers.size();j++)
					{
						Rws_Direct_Bills_Bean tenderMemoBean = (Rws_Direct_Bills_Bean)vouchers.get(j);
						Debug.println("voucher no:"+tenderMemoBean.getVoucherNo());
						String sno ="";
						Debug.println("Voucher Amount in Rupees:"+tenderMemoBean.getVoucherAmount());
						double vAmount = (Double.parseDouble(tenderMemoBean.getVoucherAmount()))/100000;
						vAmount = round(vAmount,2);
						Debug.println("Voucher Amount in Lakhs:"+vAmount);
						
						query = "insert into RWS_WORK_direct_VOUCHER_TBL values('"+workId+"'," +
						"'"+tenderMemoBean.getEmpCodeRecorded()+"',"+
						"to_date('"+tenderMemoBean.getRecordedDate()+"','dd/mm/yyyy'),"+
						"to_date('"+tenderMemoBean.getCheckMesuaredDate()+"','dd/mm/yyyy'),"+
						"'"+tenderMemoBean.getEmpCode()+"',"+
						"'"+tenderMemoBean.getVoucherNo()+"',"+
						"to_date('"+tenderMemoBean.getVoucherDate()+"','dd/mm/yyyy'),"+
						"'"+tenderMemoBean.getVoucherAmount()+"',"+
						"'"+tenderMemoBean.getChequeNo()+"',"+
						"to_date('"+tenderMemoBean.getChequeDate()+"','dd/mm/yyyy'),"+				
						"to_date('"+tenderMemoBean.getSuperCheckMesuaredDate()+"','dd/mm/yyyy'),"+
						"'"+tenderMemoBean.getEmpCodeSuper()+"',"+
						"'"+tenderMemoBean.getCheckMesuaredRemarks()+"'," +
						"'"+tenderMemoBean.getProgCode()+"'," +
						"'"+tenderMemoBean.getSno()+"', " +
								"'"+sno+"'," +
						"'"+tenderMemoBean.getContCode()+"','"+tenderMemoBean.getBudgetInfo()+"','"+tenderMemoBean.getBillSlNo()+"','',sysdate)";
						//}
						Debug.println("save qry:"+j+":"+query);
						stmt.addBatch(query);
					}
					
					int[] val = stmt.executeBatch();
					if(val.length>0)
					{
					    returnValue = "Voucher(s) Successfully Updated for the Work ID:"+workId;
						conn.setAutoCommit(true);
						conn.commit();
					}
					
				}
				catch (Exception e)
				{
					try {
						conn.rollback();
						returnValue = "Failed to Save/Update Voucher(s)";
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
					Debug.println("Exception in saveVouchers:"+e);
				}
				finally
				{
					try
					  {
						if(stmt!=null)stmt.close();
						if(conn!=null)conn.close();
					  }
					catch(Exception e)
					{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
				}
				return returnValue;
}

		 public String removeVouchers(ArrayList vouchers,String workId,String[] removeList)
		 {
		 	String returnValue = "";
			try
			{
				conn = RwsOffices.getConn();
				conn.setAutoCommit(false);
				stmt = conn.createStatement();
				Statement stmt2 = conn.createStatement();
				Statement stmt3 = conn.createStatement();
				for(int i = 0;i<removeList.length;i++)
	        	{
					Rws_Direct_Bills_Bean tenderMemoBean = (Rws_Direct_Bills_Bean)vouchers.get(Integer.parseInt(removeList[i]));
					double vAmount = (Double.parseDouble(tenderMemoBean.getVoucherAmount()))/100000;
					vAmount = round(vAmount,2);
					query = "delete from RWS_WORK_DIRECT_VOUCHER_TBL where work_id='"+workId+"' and VOUCHER_NO=" +
							"'"+tenderMemoBean.getVoucherNo()+"'";
					if(tenderMemoBean.getMileStoneSno()!=null && !tenderMemoBean.getMileStoneSno().equals(""))
						query += " and MILESTONE_SLNO='"+tenderMemoBean.getMileStoneSno()+"'";
					Debug.println("DELETE qry:"+i+":"+query);
					stmt.addBatch(query);
					
	        	}
				int[] val = stmt.executeBatch();
				
				stmt3.executeBatch();
				if(val.length>0)
				{
					conn.setAutoCommit(true);
					conn.commit();
					returnValue = "Voucher(s) Deleted Successfully for the Work ID:"+workId;
				}
				
			}
			catch (Exception e)
			{
				try {
					conn.rollback();
					returnValue = "Failed to Remove Voucher(s)";
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				Debug.println("Exception in saveVouchers:"+e);
			}
			finally
			{
				try
				  {
					if(stmt!=null)stmt.close();
					if(conn!=null)conn.close();
				  }
				catch(Exception e)
				{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
			}
			return returnValue;
		
		 }
		 public ArrayList getAdminPrograms(String workId )throws Exception
			{
				ArrayList programms=null;
				try
				{
					String qry="select a.programme_code,programme_name from rws_work_admn_tbl a,rws_programme_tbl p " +
							"where a.programme_code=p.programme_code and work_id='"+workId+"' union " +
							"select a.programme_code,programme_name from RWS_WORK_ADMN_PROG_LNK_TBL a,rws_programme_tbl p " +
							"where a.programme_code=p.programme_code and work_id='"+workId+"'";
					Debug.println("get AdminPrograms:"+qry);
					conn=RwsOffices.getConn();
					PreparedStatement psmt=conn.prepareStatement(qry);
					ResultSet rs=psmt.executeQuery();
					programms=new ArrayList();
					LabelValueBean bean = null;
					while (rs.next())
					{
						bean = new LabelValueBean();
						bean.setValue(rs.getString(1));
						bean.setLabel(rs.getString(2));
						programms.add(bean);
					}
				}
				catch(Exception e)
				{
					Debug.println("Exception in getAdminPrograms():"+e);
				}
				finally 
				{
					releaseConnection();
				}
				
				return programms;
			}
		 
}
