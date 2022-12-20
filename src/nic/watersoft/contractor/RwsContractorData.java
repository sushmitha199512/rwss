package nic.watersoft.contractor;
import jxl.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
//import nic.watersoft.commons.Debug;
 

public class RwsContractorData 
{
	static Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	DataSource dataSource = null;
	SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
	RwsContractor rwsContractor;
		
	public RwsContractorData(DataSource dataSource)
	{
		
		//System.out.println("in RwsContractorData class");
		this.dataSource = dataSource;		
	}
	
	public void  closeAll() throws Exception
	{
		if (rs != null) 
		{
			try 
			{
				rs.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll"+e);
			}
			rs = null;
		}
		if (stmt != null) 
		{
			try 
			{
				stmt.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			stmt = null;
		}
		if (conn != null) 
		{
			try 
			{
				conn.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			conn = null;
		}
		if (ps != null) 
		{
			try 
			{
				ps.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			ps = null;
		}
}
/**
 *  This method 'getWorkIds' is for fetching the details of Work for a Office  
 *  from tables 'RWS_NEW_EST_TBL' and 'RWS_WORK_PROPOSAL_TBL'
 * 
 */
	
public ArrayList getWorkIds(String assetTypeCode,String officeCode) throws Exception
{
	ArrayList workIds=new ArrayList();
	//System.out.println("****assettypecode= "+assetTypeCode);
	//System.out.println("****officeCode= "+officeCode);
	String query="";
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		query="SELECT E.WORK_ID,PROPOSAL_NAME FROM RWS_NEW_EST_TBL E,RWS_WORK_PROPOSAL_TBL P WHERE E.WORK_ID = P.WORK_ID AND TYPE_OF_ASSET_CODE='"+assetTypeCode+"' AND E.OFFICE_CODE = '"+officeCode+"' AND  TS_NO IS NOT NULL AND E.WORK_ID NOT IN (SELECT DISTINCT WORK_ID FROM RWS_TENDER_NOTIFY_LNK_TBL) AND  E.WORK_ID NOT IN (SELECT DISTINCT WORK_ID FROM RWS_TENDER_SCHEDULEA_TBL) ORDER BY E.WORK_ID";
		//System.out.println("query="+query);
		rs =stmt.executeQuery("SELECT E.WORK_ID,PROPOSAL_NAME FROM RWS_NEW_EST_TBL E,RWS_WORK_PROPOSAL_TBL P WHERE E.WORK_ID = P.WORK_ID AND TYPE_OF_ASSET_CODE='"+assetTypeCode+"' AND E.OFFICE_CODE = '"+officeCode+"' AND  TS_NO IS NOT NULL AND E.WORK_ID NOT IN (SELECT DISTINCT WORK_ID FROM RWS_TENDER_NOTIFY_LNK_TBL) AND  E.WORK_ID NOT IN (SELECT DISTINCT WORK_ID FROM RWS_TENDER_SCHEDULEA_TBL) ORDER BY E.WORK_ID");
        
		while ( rs.next() ) 
		{
			rwsContractor = new RwsContractor();
			//System.out.println("wrok id is"+rs.getString(1));
			rwsContractor.setWorkId(rs.getString(1));
			rwsContractor.setWorkName(rs.getString(1)+" - "+rs.getString(2));
			workIds.add(rwsContractor);
			
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getWorkIds in rwsContractorData ="+e);
	}
	finally 
	{
		closeAll();
	}
	return workIds;
}


public ArrayList getWorkComponents(String typeOfAsset,String workId, String type) throws Exception
{
	//System.out.println("Work Id : " + workId);
	//System.out.println("Work Type : " + type);
	String query=null;
	String workComp=null;
	ArrayList workComponents = new ArrayList();
	if(type.equals("new"))
	{
		query = " SELECT C.asset_component_code, A.asset_component_name, C.amount "
			  + " FROM rws_new_est_tbl E, rws_new_est_comp_lnk_tbl C, rws_asset_component_type_tbl A"
			  + " WHERE C.work_id = E.work_id AND ( C.asset_component_code = A.asset_component_code "
			  + " AND E.type_of_asset_code = A.type_of_asset_code) "
			  + " AND C.work_id = '" + workId +"'";
		
		//System.out.println("query in get work componets is  in new type"+query);
	}
	else
	if(type.equals("om"))
	{
		query = " SELECT C.asset_component_code, A.asset_component_name, C.amount "
			  + " FROM rws_om_est_tbl E, rws_om_est_comp_lnk_tbl C, rws_asset_component_type_tbl A"
			  + " WHERE C.work_id = E.work_id AND ( C.asset_component_code = A.asset_component_code "
			  + " AND E.type_of_asset_code = A.type_of_asset_code) "
			  + " AND C.work_id = '" + workId +"'";
		//System.out.println("query in get work componets is  in om type"+query);
	}
	//System.out.println("Query is : " + query);
	try{
		conn = dataSource.getConnection();
		Statement stat = conn.createStatement();
		 
		ResultSet rset = stat.executeQuery(query);
		ArrayList subComps;
		RwsContractor rwsContractor = null;
		CommonLists commonLists=null;
		while(rset.next())
		{
			rwsContractor = new RwsContractor();
			workComp=rset.getString(1);
			rwsContractor.setAssetComponent(workComp);
			rwsContractor.setAssetComponentCode(rset.getString(2));
			rwsContractor.setAmount(rset.getString(3));
			subComps=new ArrayList();
			commonLists=new CommonLists(dataSource);
			subComps=commonLists.getAssetSubComponents(typeOfAsset,workComp);
			//System.out.println("subComps size="+subComps.size());
		    rwsContractor.setWorkSubComps(subComps);	
			workComponents.add(rwsContractor);
	    }
	}
	catch(Exception e)	
	{
		//System.out.println("Error in getwork components:"+e.getMessage());
	}
	finally{
		
		closeAll();
	}
	return workComponents;
}



/**
 *  The method 'insertTenderScheduleA' is for inserting the details of Tender Schedule A  
 *  into database tables 'rws_tender_schedulea_tbl' and 'rws_tender_schedulea_lnk_tbl'
 */
public int[] insertTenderScheduleA(RwsContractor rwsContractor,Sheet s,ArrayList comps,DataSource dataSource) throws Exception
{
	
	//System.out.println("@@@@@@@@@@@in insert tender shedule a mentod");
	
	TenderScheduleACompForm tenderScheduleACompForm = new TenderScheduleACompForm();
	int rowCount[]=new int[50];
	try
	{
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		Cell[] row = null;
	    Cell[] column = null;
	    //System.out.println("no of rows="+s.getRows()+"no of columns="+s.getColumns());
	    row = s.getRow(0);
	    //System.out.println("%%%%%%%%%%%%%%%%%"+s.getRow(0));
	    StringBuffer sql = new StringBuffer("INSERT INTO RWS_TENDER_BOQ_TBL VALUES(?,?,?,?,?,?,?,?,?)");
	    //System.out.println("query="+sql.toString());
	    PreparedStatement pstmt=conn.prepareStatement(sql.toString());
	    for (int i = 1 ; i <8 ; i++)
        {

	      //System.out.println("in for loop");
	      pstmt.setString(1,rwsContractor.getWorkId());
	      row = s.getRow(i);
          if (row.length > 0)
            for (int j = 0; j <8; j++)
            {
              if(!row[j].getContents().trim().equals(""))
              {
              	
                //System.out.println("len row="+i+" "+j+"="+row[j].getContents().length());
			  
               	pstmt.setString(j+2,row[j].getContents());
			   
              }
            }
          pstmt.addBatch();
        }
	    //System.out.println("After for loop");
	    
	    rowCount=pstmt.executeBatch();
	    
	    //System.out.println("rowCount="+rowCount.length);
		stmt=conn.createStatement();
		//System.out.println("rwsContractor.getOfficeCode()="+rwsContractor.getOfficeCode());
		stmt.addBatch("insert into RWS_TENDER_SCHEDULEA_TBL " +
						"values('"+rwsContractor.getOfficeCode()+"'," +
						"'"+rwsContractor.getWorkId()+"'," +
						"'"+rwsContractor.getPreparedBy()+"'," +
						"to_date('"+rwsContractor.getPreparedOn()+"'," +
						"'dd/mm/yyyy'))");
		//System.out.println("Wok Comp Size="+comps.size());
		for (int i=0;i<comps.size();i++)
		{
			 
			tenderScheduleACompForm = (TenderScheduleACompForm)comps.get(i);
				
			
			//System.out.println("######### Record No : " + (i+1) + " ##########");
			//System.out.println("######### tenderScheduleACompForm.getAssetComponentCode() : " + tenderScheduleACompForm.getAssetComponent() + " ##########");
			//System.out.println("######### tenderScheduleACompForm.getAssetSubComponentCode() : " + tenderScheduleACompForm.getAssetSubCompTypeCode() + " ##########");
			//System.out.println("######### tenderScheduleACompForm.getQuantity() : " + tenderScheduleACompForm.getQuantity() + " ##########");
			//System.out.println("######### tenderScheduleACompForm.getUnitRate() : " + tenderScheduleACompForm.getUnitRate() + " ##########");
			//System.out.println("######### tenderScheduleACompForm.getAmount() : " + tenderScheduleACompForm.getAmount() + " ##########");
			stmt.addBatch("insert into rws_tender_schedulea_lnk_tbl " +
					  "values('"+rwsContractor.getWorkId()+"'," +
					  "'"+tenderScheduleACompForm.getAssetComponent()+"'," +
					  "'"+tenderScheduleACompForm.getAssetSubCompTypeCode()+"'," +
					  ""+tenderScheduleACompForm.getQuantity()+"," +
					  ""+tenderScheduleACompForm.getUnitRate()+"," +
					  ""+tenderScheduleACompForm.getAmount()+")");
		}
		rowCount = stmt.executeBatch();
		conn.commit();
		
	}
	catch(Exception e)
	{
		//System.out.println("The error is in insertTenderSchedule of rwsContractorData "+e.getMessage()+e);
	}
	finally 
	{
		closeAll();
	}
	return rowCount;
}

public int[] updateTenderScheduleA(String workId,RwsContractor rwsContractor,ArrayList Comps,DataSource dataSource) throws Exception
{
	  int rowCount[]= new int[50];
	   TenderScheduleACompForm tenderScheduleACompForm = new TenderScheduleACompForm();
	   try
		{
			    //System.out.println("Work Id----"+workId);
			    conn = dataSource.getConnection();
				conn.setAutoCommit(false);
				stmt=conn.createStatement();
				for (int j=0;j<Comps.size();j++)
				{
					tenderScheduleACompForm = (TenderScheduleACompForm)Comps.get(j);	
					//System.out.println("######### Record No : " + (j+1) + " ##########");
					//System.out.println("######### TenderScheduleACompForm.getAssetComponentCode() : " +  tenderScheduleACompForm.getAssetComponent() + " ##########");
					//System.out.println("######### TenderScheduleACompForm.getAssetSubCompTypeCode() : " +  tenderScheduleACompForm.getAssetSubCompTypeCode() + " ##########");
					//System.out.println("######### TenderScheduleACompForm.getQuantity() : " + tenderScheduleACompForm.getQuantity() + " ##########");
					//System.out.println("######### TenderScheduleACompForm.getUnitRate() : " +  tenderScheduleACompForm.getUnitRate() + " ##########");
					//System.out.println("######### TenderScheduleACompForm.getAmount() : " +  tenderScheduleACompForm.getAmount() + " ##########");
					
					stmt.addBatch("update  RWS_TENDER_SCHEDULEA_LNK_TBL set ASSET_SUBCOMPONENT_CODE='"+ tenderScheduleACompForm.getAssetSubCompTypeCode()+"',QUANTITY='"+tenderScheduleACompForm.getQuantity() +"',UNIT_RATE='"+ tenderScheduleACompForm.getUnitRate()+"' WHERE WORK_ID='"+workId+"' AND ASSET_COMPONENT_CODE ='"+tenderScheduleACompForm.getAssetComponent()+"'");
					
				}
				rowCount = stmt.executeBatch();
				conn.commit();
		}
		catch (Exception e)
		{
			//System.out.println(e.getMessage());
		}
		finally 
		{
			closeAll();
		}
		return rowCount;
	}
public ArrayList getTenderScheduleAs(String officeCode,DataSource dataSource) throws Exception 
{
	//System.out.println("in get tenderschedules");
	RwsContractor rwsContractor = null;
	ArrayList tenderScheduleA=new ArrayList();
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="select ts.work_id,AT.TYPE_OF_ASSET_NAME ,tl.asset_component_code,AC.ASSET_COMPONENT_NAME,tl.asset_subcomponent_code,sc.asset_subcomponent_name,tl.quantity,tl.UNIT_RATE ,tl.amount,e.type_of_asset_code "+
        "from rws_tender_scheduleA_tbl ts,rws_tender_scheduleA_lnk_tbl tl,rws_new_est_tbl e,RWS_ASSET_TYPE_TBL  at,RWS_ASSET_COMPONENT_TYPE_TBL AC,RWS_ASSET_SUBCOMPONENT_TBL sc where tl.work_id=ts.work_id "+
		  " and e.work_id=ts.work_id and at.type_of_asset_code=e.type_of_asset_code AND E.TYPE_OF_ASSET_CODE=AC.TYPE_OF_ASSET_CODE AND TL.asset_component_code=AC.asset_component_code and sc.TYPE_OF_ASSET_CODE=E.TYPE_OF_ASSET_CODE "+
		  " and sc.asset_component_code=tl.asset_component_code and sc.asset_subcomponent_code=tl.asset_subcomponent_code and ts.office_code='"+officeCode+"'";
	
		//System.out.println("Query is "+query);
		rs =stmt.executeQuery("select ts.work_id,AT.TYPE_OF_ASSET_NAME ,tl.asset_component_code,AC.ASSET_COMPONENT_NAME,tl.asset_subcomponent_code,sc.asset_subcomponent_name,tl.quantity,tl.UNIT_RATE ,tl.amount,e.type_of_asset_code "+
				              "from rws_tender_scheduleA_tbl ts,rws_tender_scheduleA_lnk_tbl tl,rws_new_est_tbl e,RWS_ASSET_TYPE_TBL  at,RWS_ASSET_COMPONENT_TYPE_TBL AC,RWS_ASSET_SUBCOMPONENT_TBL sc where tl.work_id=ts.work_id "+
							  " and e.work_id=ts.work_id and at.type_of_asset_code=e.type_of_asset_code AND E.TYPE_OF_ASSET_CODE=AC.TYPE_OF_ASSET_CODE AND TL.asset_component_code=AC.asset_component_code and sc.TYPE_OF_ASSET_CODE=E.TYPE_OF_ASSET_CODE "+
							  " and sc.asset_component_code=tl.asset_component_code and sc.asset_subcomponent_code=tl.asset_subcomponent_code and ts.office_code='"+officeCode+"'");
	
		while ( rs.next() ) 
		{
			rwsContractor = new RwsContractor();
			//System.out.println("work id="+rs.getString(1));
    		rwsContractor.setWorkId(rs.getString(1));
    		rwsContractor.setAssetTypeCode(rs.getString(2));
    		rwsContractor.setAssetComponent(rs.getString(3));
    		rwsContractor.setAssetComponentCode(rs.getString(4));
    		rwsContractor.setAssetSubCompTypeCode(rs.getString(5));
    		rwsContractor.setAssetSubCompTypeName(rs.getString(6));
    		rwsContractor.setQuantity(rs.getString(7));
    		rwsContractor.setUnitRate(rs.getString(8));
    		rwsContractor.setAmount(rs.getString(9));
			tenderScheduleA.add(rwsContractor);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getTenderScheduleAs="+e.getMessage());
	}
	finally 
	{
		closeAll();
		
	}
	return tenderScheduleA;
}

public   RwsContractor getTenderScheduleA(String workId,DataSource dataSource) throws Exception
{
	 
	RwsContractor rwsContractor=null,rwsContractor1=null;
	String workComp="";
	ArrayList subComps;
	ArrayList workComps=new ArrayList();
	CommonLists commonLists=new CommonLists();
	
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="select ts.work_id,p.PROPOSAL_NAME,e.type_of_asset_code,AT.TYPE_OF_ASSET_NAME ,tl.asset_component_code,AC.ASSET_COMPONENT_NAME,tl.asset_subcomponent_code,sc.asset_subcomponent_name,tl.quantity,tl.UNIT_RATE ,tl.amount "+
				     "from rws_tender_scheduleA_tbl ts,rws_tender_scheduleA_lnk_tbl tl,rws_new_est_tbl e,RWS_ASSET_TYPE_TBL  at,RWS_ASSET_COMPONENT_TYPE_TBL AC,RWS_ASSET_SUBCOMPONENT_TBL sc,RWS_WORK_PROPOSAL_TBL P where tl.work_id=ts.work_id "+
					 " and e.work_id=ts.work_id and at.type_of_asset_code=e.type_of_asset_code AND E.TYPE_OF_ASSET_CODE=AC.TYPE_OF_ASSET_CODE AND TL.asset_component_code=AC.asset_component_code and sc.TYPE_OF_ASSET_CODE=E.TYPE_OF_ASSET_CODE "+
					 " and sc.asset_component_code=tl.asset_component_code and sc.asset_subcomponent_code=tl.asset_subcomponent_code and ts.work_id='"+workId+"' and tl.work_Id='"+workId+"' and p.work_id='"+workId+"'";
		
		//System.out.println("query="+query);
		rs=stmt.executeQuery(query);
							  
		while ( rs.next() ) 
		{
			rwsContractor = new RwsContractor();
			rwsContractor1=  new RwsContractor();
			workComp=rs.getString(5);
			rwsContractor.setWorkId(rs.getString(1)+"-"+rs.getString(2));
			rwsContractor.setAssetTypeCode(rs.getString(3));
			rwsContractor.setAssetTypeName(rs.getString(4));
			rwsContractor1.setAssetComponent(workComp);
			rwsContractor1.setAssetComponentCode(rs.getString(6));
			rwsContractor1.setAssetSubCompTypeCode(rs.getString(7));
			rwsContractor1.setAssetSubCompTypeName(rs.getString(8));
			rwsContractor1.setQuantity(rs.getString(9));
			rwsContractor1.setUnitRate(rs.getString(10));
			rwsContractor1.setAmount(rs.getString(11));
			subComps=new ArrayList();
			commonLists=new CommonLists();
			subComps=commonLists.getAssetSubComponents(rs.getString(3),workComp);
			rwsContractor1.setWorkSubComps(subComps);
			workComps.add(rwsContractor1);
 		    rwsContractor.setWorkComps(workComps);
 		    rwsContractor.setWorkSubComps(subComps);
 		    
	 
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error is in getTenderScheduleA="+e);
	}
	finally 
	{
		closeAll();
	}
	return rwsContractor;
}

public int removetenderScheduleA(String workId,DataSource dataSource) throws Exception
{
	int rowCount=0;
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		rowCount =stmt.executeUpdate("DELETE FROM rws_tender_scheduleA_lnk_tbl WHERE WORK_id='"+workId+"'");
		 
		if(rowCount>0)
			rowCount =stmt.executeUpdate("DELETE FROM rws_tender_scheduleA_tbl WHERE WORK_id='"+workId+"'");
		 	
		
	}
	catch (Exception e)
	{
		//System.out.println("The error is in removetenderScheduleA="+e.getMessage());
	}
	finally 
	{
			closeAll();
	}
	return rowCount;
}
public int[] insertTenderNotification(RwsContractor rwsContractor,ArrayList workIds,DataSource dataSource) throws Exception
{
	int[] rowCount=new int[20];
	TenderWorkIdBean tenderWorkIdBean=new TenderWorkIdBean();
	try
	{
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		stmt=conn.createStatement();
		String query="insert into rws_tender_notification_tbl values('"+rwsContractor.getTenderIdNo()+"','"+rwsContractor.getTypeOfTender()+"',"+rwsContractor.getNoOfWorks()+",'"+rwsContractor.getTenderType()+"',to_date('"+rwsContractor.getIssueDate()+"','dd/mm/yyyy'),to_date('"+rwsContractor.getCloseDate()+"','dd/mm/yyyy'),'"+rwsContractor.getModeOfExecution()+"',"+rwsContractor.getCostOfTender()+","+rwsContractor.getSalesTax()+","+rwsContractor.getEstContractValue()+",'"+rwsContractor.getOfficeCode()+"','"+rwsContractor.getPreparedBy()+"',to_date('"+rwsContractor.getPreparedOn()+"','dd/mm/yyyy'))";
		//System.out.println(query);
		stmt.addBatch(query);
		for(int i=0;i<workIds.size();i++)
		{
			tenderWorkIdBean=(TenderWorkIdBean)workIds.get(i);
			if(tenderWorkIdBean.getWork()!=null)
				if(tenderWorkIdBean.getWork().equals("on"))
				{
					query="insert into RWS_TENDER_NOTIFY_LNK_TBL values('"+rwsContractor.getTenderIdNo()+"','"+tenderWorkIdBean.getWorkId()+"')";
					//System.out.println("query="+query);
					stmt.addBatch(query);
				}
		}
		rowCount=stmt.executeBatch();
		conn.commit();
		
	}
	catch(Exception e)
	{
		//System.out.println("The error is in rwsContractorData "+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return rowCount;
}


public ArrayList getWorkIds(DataSource dataSource) throws Exception
{
	RwsContractor rwsContractor = null;
	ArrayList workIds=new ArrayList();

	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		rs =stmt.executeQuery("select ts.work_id,P.PROPOSAL_NAME FROM  RWS_WORK_PROPOSAL_TBL P,  RWS_TENDER_SCHEDULEA_TBL  ts where p.work_id=ts.work_Id and ts.work_Id not in(select work_id from rws_tender_notify_lnk_tbl)");
		while ( rs.next() ) 
		{
			rwsContractor = new RwsContractor();
			rwsContractor.setWorkId(rs.getString(1));
			rwsContractor.setWorkName(rs.getString(2));
			workIds.add(rwsContractor);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getAssetsOnSource="+e);
	}
	finally 
	{
		closeAll();
	}
	return workIds;
}

public  ArrayList getTenderNotifications(String officeCode,DataSource dataSource) throws Exception
{
	RwsContractor rwsContractor = null;
	ArrayList tenderDetails=new ArrayList();

	try
	{
		Connection conn=dataSource.getConnection();
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery("select TENDER_IDNO,NO_OF_WORKS,to_char(TENDER_ISSUE_DATE,'dd/mm/yyyy'),to_char(TENDER_CLOSE_DATE,'dd/mm/yyyy'),COST_OF_TENDER_SCH,COST_OF_SALES_TAX,EST_CONTRACT_VALUE  from RWS_TENDER_NOTIFICATION_TBL where OFFICE_CODE ='"+officeCode+"'");
		while(rs.next())
		{
		  rwsContractor=new RwsContractor();
		  rwsContractor.setTenderIdNo(rs.getString(1));
		  rwsContractor.setNoOfWorks(rs.getString(2));
		  rwsContractor.setIssueDate(rs.getString(3));
		  rwsContractor.setCloseDate(rs.getString(4));
		  rwsContractor.setCostOfTender(rs.getString(5));
		  rwsContractor.setSalesTax(rs.getString(6));
		  rwsContractor.setEstContractValue(rs.getString(7));
		  tenderDetails.add(rwsContractor);
		}
		
	}
	catch(Exception e)
	{
		//System.out.println("error in getTenderNotifications:"+e.getMessage());
	}
	return tenderDetails;
}	

public  ArrayList getWorks(String tenderIdNo,DataSource dataSource) throws Exception
{
	RwsContractor rwsContractor = null;
	ArrayList works=new ArrayList();

	try
	{
		Connection conn = dataSource.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs =stmt.executeQuery("select ts.work_id,P.PROPOSAL_NAME FROM  RWS_WORK_PROPOSAL_TBL P, RWS_TENDER_SCHEDULEA_TBL ts where p.work_id=ts.work_Id and ts.work_Id in(select work_id from rws_tender_notify_lnk_tbl where tender_IdNo='"+tenderIdNo+"')");
		while ( rs.next() ) 
		{
			rwsContractor = new RwsContractor();
			rwsContractor.setWorkId(rs.getString(1));
			rwsContractor.setWorkName(rs.getString(2));
			works.add(rwsContractor);
		}
	 
	}
	catch (Exception e)
	{
		//System.out.println("The error in getHabsOnSource="+e);
	}
	finally 
	{
		closeAll();
	}
	return works;
}
public int[] removeTenderNotification(String tenderIdNo,DataSource dataSource)
{
	int[] rowCount=new int[20];
	try{
		conn=dataSource.getConnection();
		stmt=conn.createStatement();
		String query="delete from  rws_tender_notify_lnk_tbl  where tender_idno='"+tenderIdNo+"'";
		//System.out.println("query="+query);
		stmt.addBatch(query);
		query="delete from RWS_TENDER_NOTIFICATION_TBL where tender_idno='"+tenderIdNo+"'";
		//System.out.println("query="+query);
		stmt.addBatch(query);
		rowCount=stmt.executeBatch();
			
	}
	catch(Exception e)
	{
		//System.out.println("Error in remove tender notification:"+e.getMessage());
	}
	return rowCount;
}
public  RwsContractor getTenderNotification(String tenderId,String officeCode,DataSource dataSource) throws Exception
{
	 
	RwsContractor rwsContractor=null; 
	ArrayList workComps=new ArrayList();
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="select TENDER_IDNO,PACKAGE_WORK,NO_OF_WORKS,TENDER_TYPE ,TO_CHAR(TENDER_ISSUE_DATE,'dd/mm/yyyy'),TO_CHAR(TENDER_CLOSE_DATE,'dd/mm/yyyy'),MODE_OF_EXECUTION,COST_OF_TENDER_SCH,COST_OF_SALES_TAX,EST_CONTRACT_VALUE  from RWS_TENDER_NOTIFICATION_TBL where TENDER_IDNO='"+tenderId+"' and office_code='"+officeCode+"'";
		//System.out.println("query="+query);
		rs=stmt.executeQuery(query);
							  
		while ( rs.next() ) 
		{
			rwsContractor = new RwsContractor();
			rwsContractor.setTenderIdNo(rs.getString(1));
			rwsContractor.setTenderType(rs.getString(2));
  		    rwsContractor.setNoOfWorks(rs.getString(3));
  		    rwsContractor.setTypeOfTender(rs.getString(4));
  		    rwsContractor.setIssueDate(rs.getString(5));
  		    rwsContractor.setCloseDate(rs.getString(6));
  		    rwsContractor.setModeOfExecution(rs.getString(7));
  		    rwsContractor.setCostOfTender(rs.getString(8));
  		    rwsContractor.setSalesTax(rs.getString(9));
  		    rwsContractor.setEstContractValue(rs.getString(10));
	   }
	}
	catch (Exception e)
	{
		//System.out.println("The error is in getTenderScheduleA="+e);
	}
	finally 
	{
		closeAll();
	}
	return rwsContractor;
}
public  ArrayList getWorkIds(String tenderIdNo,String officeCode,DataSource dataSource) throws Exception
{
	RwsContractor rwsContractor = null;
	ArrayList works=new ArrayList();

	try
	{
		Connection conn = dataSource.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs =stmt.executeQuery("select tl.work_id,P.PROPOSAL_NAME FROM  RWS_WORK_PROPOSAL_TBL P, RWS_TENDER_NOTIFICATION_TBL tn,rws_tender_notify_lnk_tbl tl where tl.tender_idno=tn.tender_idno and tn.tender_IdNo='"+tenderIdNo+"' and  p.work_id=tl.work_id and tn.office_code='"+officeCode+"'");;
		while ( rs.next() ) 
		{
			rwsContractor = new RwsContractor();
			rwsContractor.setWorkId(rs.getString(1));
			rwsContractor.setWorkName(rs.getString(2));
			works.add(rwsContractor);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getWorkIds="+e);
	}
	finally 
	{
		closeAll();
	}
	return works;
}

public int updateTenderNotification(RwsContractor rwsContractor,String officeCode,DataSource dataSource) throws Exception
{
	int rowCount=0;
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="update RWS_TENDER_NOTIFICATION_TBL set PACKAGE_WORK='"+rwsContractor.getTenderType()+"',TENDER_TYPE='"+rwsContractor.getTenderType()+"',TENDER_ISSUE_DATE=to_date('"+rwsContractor.getIssueDate()+"','dd/mm/yyyy'),TENDER_CLOSE_DATE =to_date('"+rwsContractor.getCloseDate()+"','dd/mm/yyyy'),MODE_OF_EXECUTION='"+rwsContractor.getModeOfExecution()+"',COST_OF_TENDER_SCH="+rwsContractor.getCostOfTender()+",COST_OF_SALES_TAX="+rwsContractor.getSalesTax()+",EST_CONTRACT_VALUE="+rwsContractor.getEstContractValue()+" where tender_idno='"+rwsContractor.getTenderIdNo()+"' and office_code='"+officeCode+"'";
		//System.out.println("query="+query);
		rowCount=stmt.executeUpdate(query);
		
	}
	catch(Exception e)
	{
	//System.out.println("Erro in update tender notification"+e.getMessage());
	}
	return rowCount;
}		
public static ArrayList getTenderIds(DataSource dataSource)
{
    ArrayList tenderId=new ArrayList();
    Rws_Tender_Application_Bean appBean=null;
    try{
    	 conn = dataSource.getConnection();
    	 String query="select TENDER_IDNO from RWS_TENDER_NOTIFICATION_TBL";
    	 //System.out.println("Query is"+query);
    	 Statement stmt=conn.createStatement();
    	 ResultSet rs=stmt.executeQuery(query);
    	 while(rs.next())
    	 {
    	 	//System.out.println("in while loop");
    	 	appBean=new  Rws_Tender_Application_Bean();
    	 	appBean.setTenderIdNo(rs.getString("TENDER_IDNO"));
    	 	//System.out.println("value set");
    	 	tenderId.add(appBean);
    	 }
    	 conn.close();
    	}
    catch(Exception e)
	{
    	//System.out.println("Error in getting tender Ids"+e);
	}
   
	return tenderId;
}
public static ArrayList getTenderAppDetails(DataSource dataSource)
{
ArrayList tenderAppList=null;
Rws_Tender_Application_Bean appList=null;

int count=0;
         try
		 {
          tenderAppList=new ArrayList();
          conn = dataSource.getConnection();
          String query="select * from RWS_TENDER_APPL_TBL";
          Statement stmt=conn.createStatement();
          ResultSet rs=stmt.executeQuery(query);
          while(rs.next())
          { 
          	
          	appList=new Rws_Tender_Application_Bean();
          	
            appList.setTenderIdNo(rs.getString("TENDER_IDNO"));
            appList.setTenderApplNo(rs.getString("TENDER_APPL_NO"));
            appList.setContractorRegNo(rs.getString("CONTRACTOR_REG_NO"));
            appList.setPreparedBy(rs.getString("PREPARED_BY"));
            appList.setChequeNo(rs.getString("CHEQUE_NO"));
            appList.setChequeDate(rs.getString("CHEQUE_DT"));
            appList.setBank(rs.getString("BANK"));
            appList.setContractorName(rs.getString("CONTRACTOR_NAME"));
            appList.setContractorAdd1(rs.getString("CONTRACTOR_ADD1"));
            appList.setContractorAdd2(rs.getString("CONTRACTOR_ADD2"));
            appList.setContractorAdd3(rs.getString("CONTRACTOR_ADD3"));
            appList.setBranch(rs.getString("BRANCH"));
            appList.setTenderAmount(rs.getString("TENDER_AMOUNT"));
            
            tenderAppList.add(appList);
            count=count+1;
            //System.out.println("count is"+count);
            
          }
         	
		 }
         catch(Exception e)
		 {
         	//System.out.println("Exception in getting tenderapp list"+e);
		 }
return tenderAppList;
}
public static  boolean saveTenderAppDetails(DataSource dataSource,Rws_Tender_Application_Bean applBean)
{
	
	try{
	 conn = dataSource.getConnection();
	 //String query="INSERT INTO RWS_TENDER_APPL_TBL VALUES(?,?,?,?,?,TO_DATE(?,'DD/MM/YYYY'),?,?,?,?,?,?,?)";
	

	 String query="UPDATE RWS_TENDER_APPL_TBL SET TENDER_IDNO=?,TENDER_APPL_NO=?,CONTRACTOR_REG_NO=?,PREPARED_BY=?" +
	 ",CHEQUE_NO=?,CHEQUE_DT=TO_DATE(?,'DD/MM/YYYY'), BANK=?,CONTRACTOR_NAME=?,CONTRACTOR_ADD1=?,CONTRACTOR_ADD2=?,CONTRACTOR_ADD3=?,BRANCH=?" +
	 ",TENDER_AMOUNT=?";
	
	 String query1="INSERT INTO RWS_TENDER_APPL_TBL " +
	 		"VALUES("+applBean.getTenderIdNo()+","+applBean.getTenderApplNo()+","+
	 		""+applBean.getContractorRegNo()+",'',"+applBean.getChequeNo()+"," +
	 		"TO_DATE(applBean.getChequeDate(),'DD/MM/YYYY')," +
	 		""+applBean.getBank()+","+applBean.getContractorName()+","+applBean.getContractorAdd1()+"," +
	 		""+applBean.getContractorAdd2()+","+applBean.getContractorAdd3()+","+applBean.getBranch()+"," +
	 		""+applBean.getTenderAmount()+"";
	 //System.out.println("Query is"+query1);
	 PreparedStatement psmt=conn.prepareStatement(query);
	 psmt.setString(1,applBean.getTenderIdNo());
	 psmt.setString(2,applBean.getTenderApplNo());
	 psmt.setString(3,applBean.getContractorRegNo());
	 psmt.setString(4,applBean.getPreparedBy());
	 psmt.setString(5,applBean.getChequeNo());
	 psmt.setString(6,applBean.getChequeDate());
	 psmt.setString(7,applBean.getBank());
	 psmt.setString(8,applBean.getContractorName());
	 psmt.setString(9,applBean.getContractorAdd1());
	 psmt.setString(10,applBean.getContractorAdd2());
	 psmt.setString(11,applBean.getContractorAdd3());
	 psmt.setString(12,applBean.getBranch());
	 psmt.setString(13,applBean.getTenderAmount());
	
	 int count=psmt.executeUpdate();
	 
	 //System.out.println("status"+count);
      if(count>0)
      {
	  return true;
	  }
      else
      {
      	return false;
      }
     
     }
	 catch(Exception e)
	 {
	 //System.out.println("Exception in saving Tender App details"+e.getMessage());	

	 return false;
	}
}



}