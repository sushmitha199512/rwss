package nic.watersoft.drought;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.SubCompMetaData;
import nic.watersoft.proposals.ProposalHolder;
//
//import nic.watersoft.works.rws_works_WorkStatus_bean;
public class DroughtDAO
{
	private static DataSource dataSource;
	private Statement stat1, tempStat;
	private ResultSet rset1, tempRset;
	private static String query, query1;
	private String higherOfficeCode;
	private ArrayList consideredProposals;
	private ArrayList representativeProposals;
	private ArrayList forwardedProposals;
	private ArrayList submittedProposals;
	private ArrayList sanctionedProposals;
	private DroughtDTO proposalDTO;
	private DroughtHolder proposalHolder;
	private RwsOffices rwsOffices; 
	private boolean flag;
	private int ans1 = 0, ans2 = 0;
	private LabelValueBean labelValueBean;
	
	public int HEAD_OF_OFFICE_COUNT = 1;
	public String errorMessage = "";	
	public DroughtDAO()
	{
		try
		{
			Connection conn = RwsOffices.getConn();
			
		}
		catch(Exception e)
		{	
		}
	}

	public DroughtDAO(DataSource dataSource)
	{
		this.dataSource = dataSource;
		flag = false;
	}
	
	
	
	public  void deleteTempAddProgramsTable(HttpSession session,String workId)
	{
		
		try
		{
			ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
			
			if(rwsWorkAdmnProgLnkTmp!=null)
			{
				
				DroughtHolder ph=null;
				for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)
				{
					ph=(DroughtHolder)rwsWorkAdmnProgLnkTmp.get(i);
					if(ph.getWorkId().equals(workId))
						rwsWorkAdmnProgLnkTmp.set(i,null);
				}
				for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)
	    		{
					ph= (DroughtHolder)rwsWorkAdmnProgLnkTmp.get(i);
					if(ph==null)
	    			{
	    				rwsWorkAdmnProgLnkTmp.remove(i);
	    				i--;
	    			}
	    			
	    		}
			}
			else
			{
				
			}
		}
		catch(Exception e)
		{	Debug.println("Exception in deleteTempAddProgramsTable() : " + e);
		
		}
		
		
		
	}

public static String getNextProposalIdForAdminiStrative(String headOfficecode,String districtCode,String typeOfAsset,String programmeCode,String subprogrammeCode) 
	
{

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;

		java.util.Date date = new java.util.Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yy");
		String currentYear = dateFormatter.format(date);
		String drought="D";
		
		String workId = null;
	 	 
	 	try
		{	
	 		conn=RwsOffices.getConn();
	 		
	 		if(subprogrammeCode .equals(""))
				subprogrammeCode = "00";

			if(programmeCode.equals("") || districtCode .equals("") ||	typeOfAsset.equals(""))
				return new String("false");

			workId = programmeCode + subprogrammeCode + districtCode 
				   + typeOfAsset + currentYear + drought;

			query = " SELECT MAX(SUBSTR(work_id,12,3)) as work_id FROM rws_drought_works_tbl "
				  + " WHERE WORK_ID LIKE ?"; 
			ps=conn.prepareStatement(query);
			ps.setString(1, workId+"%");
			rset = ps.executeQuery();
			 
			if(rset.next())
			{    
				int	sno=rset.getInt(1);
			 	if(sno == 0)
					workId = workId + "001";
				else
				{
					if(sno >= 999)
						throw new Exception("No more WORK ID left.");
					else
					{
						String tempSno = null;
						if(sno<9)
							tempSno = "00"+(sno+1);
						else
						if(sno<99)
							tempSno = "0"+(sno+1);
						
						else
							tempSno = String.valueOf(sno+1);
						
						workId =  workId + String.valueOf(tempSno);
					}
				}
			}
			
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getNextProposalIdForAdminiStrative : \n" + e);	
		  
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(ps != null)
			{	try
				{	ps.close();
				}
				catch(SQLException sqle){
				}
			}
			if(conn != null)
			{	try
				{	conn.close();
				}
				catch(SQLException sqle){
				}
			}
		}
		return workId;
}
	
public ArrayList getTempSelectedHabsForAdminSanc2(ArrayList selectedHabCodes,String cirlce,String ses_id)
{
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rset = null;
	ArrayList tempSelectedHabs = new ArrayList();
	
	try
	{
		conn = RwsOffices.getConn();
		
		
			insertProposalTempHabsForAdmin3(selectedHabCodes,"tempSelectedHabs_tbl",ses_id);			
				
			String query = "SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, " 
				 + " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
		         + " FROM tempSelectedHabs_tbl T, rws_panchayat_raj_tbl P, " 
		         + " rws_habitation_directory_tbl D "
				 + " WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code "
				 + " and  substr(T.proposal_id,5,2)=? ORDER BY T.proposal_id ";
						 
			ps = conn.prepareStatement(query);
			ps.setString(1, cirlce);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null; 
			while(rset.next())
			{
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setProposalId(rset.getString(1));
				rwsLocationBean.setHabCode(rset.getString(2));
				rwsLocationBean.setHabName(rset.getString(3));
				rwsLocationBean.setStatus(rset.getString(4));
				rwsLocationBean.setPopulation(rset.getString(5));
				tempSelectedHabs.add(rwsLocationBean);
			}
			ps.close();
			query="DELETE FROM tempSelectedHabs_tbl where SESSION_ID=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, ses_id);
			ps.executeUpdate();
	}
	catch(Exception e)
	{	Debug.println("Exception in getTempSelectedHabsForAdminSanc2() : " + e);
		
	}
	finally
	{
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(ps != null)
		{	try
			{	ps.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	return tempSelectedHabs;
}
///////////////
public boolean insertProposalTempHabsForAdmin3(ArrayList tempSelectedHabCodes,String tabName,String ses_id)
{
	
	Connection conn = null;
	PreparedStatement ps = null,ps1=null;
	int[] updateCounts;
	try
	{
		conn = RwsOffices.getConn();
		conn.setAutoCommit(false);
		
		
		boolean status=true;
		ps1=conn.prepareStatement("select * from tab where tname =?");
		ps1.setString(1, tabName.toUpperCase());
		ResultSet rs=ps1.executeQuery();
		
		if(rs.next())
		{
			status=false;
		}
		if(status)
		{
		 query = "create table ? as select * from rws_temp_proposal_hab_tbl where 1=2";
		 ps = conn.prepareStatement(query);
		 ps.setString(1, tabName);
		 ps.addBatch(query);
		}
		/*
		query = "DELETE FROM "+tabName+" WHERE proposal_id='" + proposalId + "'";
		Debug.println("Query is :"+query);
		stat.addBatch(query);
		*/
		updateCounts = ps.executeBatch();
		
		for(int i=0;i<tempSelectedHabCodes.size();i++)
		{
			RwsLocationBean rwsLocationBean=(RwsLocationBean)tempSelectedHabCodes.get(i);
			String proposalId=rwsLocationBean.getProposalId();
			String habCode=rwsLocationBean.getHabCode();
			query = " INSERT INTO ? VALUES(?,?,?)" ; 
			
			ps = conn.prepareStatement(query);
			ps.setString(1, tabName);
			ps.setString(2, proposalId);	
			ps.setString(3, habCode);	
			ps.setString(4, ses_id);	
			ps.addBatch(query);
		}
		flag = true;
		updateCounts = ps.executeBatch();
		
		for(int i=0; i<updateCounts.length; i++)
		{
			if(updateCounts[i] < 0)
				flag = false;
		}
		flag = true;
		if(flag){
			conn.commit();
			
				
		}
		 
		
	}
	catch(Exception e)
	{	Debug.println("Exception in insertProposalTempHabsForAdmin2 : \n" + e);
		flag = false;
	}
	finally
	{
		if(ps != null)
		{	try
			{	ps.close();
			}
			catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}

	return flag;
}
////////////////////////////////
public ArrayList getAddedAdmnProgs(HttpSession session,String workId)throws Exception 
{
	ArrayList rwsWorkAdmnProgLnkTmpNew=new ArrayList();
	try{
	Debug.println("in getAddedAdmnProgs()");
	Debug.println("workId is "+workId);
	ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
	if(rwsWorkAdmnProgLnkTmp!=null)
	{
		Debug.println("rwsWorkAdmnProgLnkTmp containing added programs for all works is "+rwsWorkAdmnProgLnkTmp.size());
		for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)
		{
			DroughtHolder ph;
			DroughtHolder phNew=new DroughtHolder();
			
			/*
			 RwsWorkAdmnProgLnkTmpBean rwsWorkAdmnProgLnkTmpBean=new RwsWorkAdmnProgLnkTmpBean();
			 ph=(ProposalHolder)addedPorgs.get(i);
			 rwsWorkAdmnProgLnkTmpBean.setWorkId(workId);
			 rwsWorkAdmnProgLnkTmpBean.setProgrammeCode(ph.getProgrammeCode());
			 rwsWorkAdmnProgLnkTmpBean.setSubprogrammeCode(ph.getSubprogrammeCode());
			 rwsWorkAdmnProgLnkTmpBean.setAdminiStrativeNum(ph.getAdminiStrativeNum());
			 rwsWorkAdmnProgLnkTmpBean.setAdminiStrativeDate(ph.getAdminiStrativeDate());
			 rwsWorkAdmnProgLnkTmpBean.setSanctionAmout(ph.getSanctionAmout());
			 rwsWorkAdmnProgLnkTmp.add(rwsWorkAdmnProgLnkTmpBean);
			 */
			ph=(DroughtHolder)rwsWorkAdmnProgLnkTmp.get(i);
			
			if(ph.getWorkId().equals(workId))
			{
				phNew.setWorkId(workId);
				phNew.setProgrammeCode(ph.getProgrammeCode());
				phNew.setSubprogrammeCode(ph.getSubprogrammeCode());
				phNew.setAdminiStrativeNum(ph.getAdminiStrativeNum());
				phNew.setAdminiStrativeDate(ph.getAdminiStrativeDate());
				phNew.setSanctionAmout(ph.getSanctionAmout());
				rwsWorkAdmnProgLnkTmpNew.add(phNew);
			}
		}
	}
	Debug.println("rwsWorkAdmnProgLnkTmpNew containing added works for workId "+workId+" is"+rwsWorkAdmnProgLnkTmpNew.size());
}catch(Exception e){
	//Debug.println("Exception in getAddedAdmnProgs() is"+e);}
}
	return rwsWorkAdmnProgLnkTmpNew;
}
///////////////////

public int deleteTempSelectedHabs()
{
	Connection conn = null;
	Statement stat = null;
	int updateCount = 0;		
	try
	{
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		String query = " DELETE FROM rws_temp_proposal_hab_tbl "; 
		updateCount = stat.executeUpdate(query);
		RwsLocationBean rwsLocationBean = null; 
	}
	catch(Exception e)
	{	Debug.println("Exception in deleteTempSelectedHabs() : " + e);
	}
	finally
	{
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	return updateCount;
}
///////////////////////////
public int deleteTempSelectedHabs(String tablename)
{
	Connection conn = null;
	Statement stat = null;
	int updateCount = 0;
	PreparedStatement stmt = null;
	try
	{
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		String query = " DELETE FROM  "+tablename; 
		 
		Statement stmt1=conn.createStatement();
		boolean status=false;
		String qr="select * from tab where tname ="+tablename.toUpperCase();
		stmt=conn.prepareStatement(qr);
		ResultSet rs=stmt.executeQuery(qr);
		Debug.println("select * from tab where tname ='"+tablename.toUpperCase()+"'");
		if(rs.next())
		{
			Debug.println("table already exists");
			status=true;
		}
		if(status)
		{
		Debug.println("delete query is "+query);
 		updateCount = stat.executeUpdate(query);
		}
		RwsLocationBean rwsLocationBean = null; 
	}
	catch(Exception e)
	{	Debug.println("Exception in deleteTempSelectedHabs(table) : " + e);
	}
	finally
	{
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	return updateCount;
}
////////////////////////////
protected ArrayList getRevisedSanctionList(String officeCode,String workId,String plan,String augCode,String workCat,String assetCode)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	Debug.println("in getRevisedSanctionList()");
	boolean added=false;
	try
	{
			
		query = "select distinct adm.work_name,adm.work_id,ADMIN_NO ,to_char(ADMIN_DATE,'dd/mm/yyyy') ,SANCTION_AMOUNT ," +
		"REV_ADMIN_NO ," +
		"to_char(REV_ADMIN_DATE,'dd/mm/yyyy') ,REV_SANCTION_AMOUNT,adm.no_of_habs,rv.no_of_habs , c.circle_office_name,p.PROGRAMME_Name,s.SUBPROGRAMME_NAME ,At.TYPE_OF_ASSET_NAME," +
		"c.circle_office_code ,adm.office_code,d.division_office_name,w.category_name,pl.plan_name,aug.aug_new_name,sd.subdivision_office_name,adm.no_of_schools,rv.no_of_schools ,adm.no_of_labs,rv.no_of_labs,rv.lead_habitation " +
		" from RWS_REVISED_ADM_SANC_TBL rv,rws_work_admn_tbl" +
		" adm,rws_circle_office_tbl c,rws_programme_tbl p,  rws_asset_type_tbl AT,rws_subprogramme_tbl S,rws_division_office_tbl d,rws_work_category_tbl w,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl aug,rws_subdivision_office_tbl sd " +
		" where c.circle_office_code=d.circle_office_code and substr(adm.office_code,4,1)=d.division_office_code and sd.circle_office_code=d.circle_office_code and sd.division_office_code=d.division_office_code and substr(adm.office_code,5,2)=sd.subdivision_office_code and rv.WORK_ID=adm.work_id and c.circle_office_code=substr(rv.work_id,5,2)" +
		" and P.PROGRAMME_CODE=substr(rv.work_id,1,2) and s.SUBPROGRAMME_CODE(+)=substr(rv.work_id,3,2) and P.PROGRAMME_CODE=s.PROGRAMME_CODE " +
		" and at.TYPE_OF_ASSET_CODE=substr(rv.work_id,7,2) and adm.plan_code=pl.plan_code and w.category_code=adm.category_code and aug.aug_new_code= adm.aug_new_code" ;
	
if(officeCode!=null && officeCode.length()>=3 && !officeCode.substring(1,3).equals("00"))
	query=query+" and substr(adm.office_code,2,2)='"+officeCode.substring(1,3)+"'";
if(officeCode!=null && officeCode.length()>=4 && !officeCode.substring(3,4).equals("0"))
	query=query+" and substr(adm.office_code,4,1)='"+officeCode.substring(3,4)+"'";
if(officeCode!=null && officeCode.length()>=6 && !officeCode.substring(4,6).equals("00"))
	query=query+" and substr(adm.office_code,5,2)='"+officeCode.substring(4,6)+"'";

if(workId!=null && !workId.equals(""))
{
			query=query+" and adm.WORK_ID='"+workId+"'";
		}
		
		if(!plan.equals(""))
		{
			query=query+" and adm.PLAN_CODE='"+plan+"'";
		}
		if(!augCode.equals(""))
		{
			query=query+" and adm.AUG_NEW_CODE='"+augCode+"'";
		}
		if(!workCat.equals(""))
		{
			query=query+" and adm.CATEGORY_CODE ='"+workCat+"'";
		}
		if(!assetCode.equals(""))
		{
			query=query+" and adm.TYPE_OF_ASSET ='"+assetCode+"'";
		}
		 
		query=query+" order by adm.work_name ";
		
		
 		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		Debug.println("query is "+query);
		rset = stat.executeQuery(query);
		representativeProposals = new ArrayList();
		
		while(rset.next())
		{
			proposalDTO = new DroughtDTO();
			String code=rset.getString(2).substring(6,8);
			//String code=workId.substring(6,8);
			Debug.println("Code:"+code);
			if(!(code.equals("11")|| code.equals("12")))
			{
				proposalDTO.setNoOfHabs(rset.getString(9));
				proposalDTO.setRevNoOfHabs(rset.getString(10));
			}
			else if(code.equals("11"))
	 			{
				proposalDTO.setNoOfHabs(rset.getString(22));
				proposalDTO.setRevNoOfHabs(rset.getString(23));
	 			}
			else if(code.equals("12"))
 			{
				proposalDTO.setNoOfHabs(rset.getString(24));
				proposalDTO.setRevNoOfHabs(rset.getString(25));
 			}
			Debug.println("after");
			Debug.println("after habs:"+proposalDTO.getNoOfHabs());
			Debug.println("after rev habs:"+proposalDTO.getNoOfHabs());
			proposalDTO.setProposalName(rset.getString(1));
			proposalDTO.setProposalId(rset.getString(2));
			proposalDTO.setAdminNo(rset.getString(3));
			proposalDTO.setAdminDate(rset.getString(4));
			proposalDTO.setSanctionedAmount(rset.getString(5));
			proposalDTO.setRevAdminNo(rset.getString(6));
			proposalDTO.setRevAdminDate(rset.getString(7));
			proposalDTO.setRevSanctionedAmount(rset.getString(8));
			//proposalDTO.setNoOfHabs(rset.getString(9));
			//proposalDTO.setRevNoOfHabs(rset.getString(10));
			proposalDTO.setCircleOfficeName(rset.getString(11));
			proposalDTO.setProgrammeName(rset.getString(12));
			proposalDTO.setSubprogrammeName(rset.getString(13));
			proposalDTO.setTypeOfAsset(rset.getString(14));
			proposalDTO.setCircleOfficeCode(rset.getString(15));
			proposalDTO.setOfficeCode(rset.getString(16));
			proposalDTO.setDivisionOfficeName(rset.getString(17));
			proposalDTO.setWorkCat(rset.getString(18));
			proposalDTO.setPlan(rset.getString(19));
			proposalDTO.setWrkType(rset.getString(20));
			proposalDTO.setSubdivisionOfficeName(rset.getString(21));
			proposalDTO.setLeadHabitation(rset.getString("lead_habitation"));
			
			representativeProposals.add(proposalDTO);
		}
	}
	catch(Exception e)
	{	Debug.writeln("Exception in getRevisedSanctionList : \n" + e);			
	}
	finally
	{	
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle){ }
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}
	//System.out.println("representativeProposals.size() in ProposalDAO(): " + 
		//				representativeProposals.size());
	return representativeProposals;
}
///////////////////////////////
public DroughtDAOMessage deleteAdminiStrativeDetails(String proposalId, ArrayList viewlist)
{
	Connection conn = null;
	String q="";
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	DroughtDAOMessage daoMessage=new DroughtDAOMessage();
	daoMessage.setOperationSussess(true);
	try
	{
				
		conn = RwsOffices.getConn();
		conn.setAutoCommit(true);
		int count=0;
		
		for(int i=0;i<viewlist.size();i++){
			
			DroughtDTO droughtDto=(DroughtDTO)viewlist.get(i);
			if(droughtDto!=null){
				
			 if(droughtDto.getProposalId().equals(proposalId)){
			 	viewlist.remove(droughtDto);
			 	break;
			   		
			 }}
		}
		
		
		boolean delete=true;
		
		String query="";
		query="DELETE FROM RWS_drought_works_TBL WHERE WORK_ID=?";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, proposalId);
		pstmt.executeUpdate();
		conn.commit();
		daoMessage.setOperationSussess(true);
		daoMessage.setMessage("Record deleted successfully");
			
 	}
	catch(SQLException e)
	{
		daoMessage.setOperationSussess(false);
		if(e.getErrorCode()==17081)
			daoMessage.setMessage("Record cannot be deleted as child records exists");
		else
			daoMessage.setMessage("Record cannot be deleted");
		try{conn.rollback();}
		catch(Exception ex){}
			
	}
	catch(Exception e)
	{	
	    e.printStackTrace();
		daoMessage.setOperationSussess(false);
		daoMessage.setMessage("Record cannot be deleted");
		try{conn.rollback();}
		catch(Exception ex){}
	}
	finally
	{	 
		if(pstmt != null)
		{	try
			{	pstmt.close();
			}
			catch(SQLException sqle){ }
		}
		
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}
	return daoMessage;
}
public DroughtDAOMessage deleteRevisedDetails(String proposalId)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	DroughtDAOMessage daoMessage=new DroughtDAOMessage();
	daoMessage.setOperationSussess(true);
	boolean flag=false;
	int[] status={0};
	try
	{
		query = "DELETE FROM RWS_REVISED_ADM_SANC_TBL  WHERE WORK_ID='"+proposalId+"'";
		query1=" DELETE FROM RWS_REV_ADM_SANC_HAB_LNK_TBL  WHERE WORK_ID='"+proposalId+"'";
		String query2=" DELETE FROM RWS_REVISED_ADM_PROG_LNK_TBL WHERE WORK_ID='"+proposalId+"'";
		Debug.println(query+"\n"+query1);
		conn = RwsOffices.getConn();
		conn.setAutoCommit(false);
		stat = conn.createStatement();
		stat.addBatch(query);
		stat.addBatch(query1);
		stat.addBatch(query2);
		status=stat.executeBatch();
		if(status[0]<1)
		{
			daoMessage.setMessage("No Records Deleted");
			daoMessage.setOperationSussess(false);
		}
		else
		{
			daoMessage.setOperationSussess(true);
			daoMessage.setMessage("Record Deleted Successfully");
			conn.commit();
		}
	
		
	}
	catch(SQLException e)
	{
		Debug.writeln("Exception in deleteRevisedDetails :\n" + e);
		
		daoMessage.setOperationSussess(false);
		Debug.println("error code is "+e.getErrorCode());
		if(e.getErrorCode()==17081)
			daoMessage.setMessage("Record cannot be deleted as child records exists");
		else
			daoMessage.setMessage("Record cannot be deleted");
			
	}
	catch(Exception e)
	{	Debug.writeln("Exception in delete the revised data :\n" + e);
		daoMessage.setOperationSussess(false);
		daoMessage.setMessage("Records Cannot be Deleted");
	}
	finally
	{	 
		if(stat != null)
		{	try
			{	stat.close();
			}
		catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
		catch(SQLException sqle){ }
		}
	}
	return daoMessage;
}
/////////////////////////
protected ArrayList getAdminstrativeSanctionList(String officeCode,String workId)
{

	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	Debug.println("in getAdministrativeSanctionList()");
	try
	{
		query = "SELECT distinct ad.WORK_NAME ,ad.WORK_ID,ad.NO_OF_HABS,ad.ESTIMATE_COST " +
		",ad.SANCTION_AMOUNT,  ad.ADMIN_NO,to_char(ad.ADMIN_DATE,'dd/mm/yyyy') " +
		",decode(ad.SPILL_OVER,'y','YES','','No') ,At.TYPE_OF_ASSET_NAME  ,p.PROGRAMME_Name ," +
		" s.SUBPROGRAMME_NAME,ad.PREPARED_BY ,to_char(ad.PREPARED_ON,'dd/mm/yyyy')as" +
		" prepared_on ,AD.remarks,ad.office_code ,c.circle_office_name," +
		"c.circle_office_code,d.division_office_name,d.division_office_code,decode(ad.CATEGORY_CODE,'1','Projects','2','Normal','3','District Level'),pl.plan_name,a.aug_new_name" +
		" FROM  rws_work_admn_tbl ad, rws_programme_tbl P,  rws_subprogramme_tbl S," +
		" rws_asset_type_tbl AT ,rws_circle_office_tbl c,rws_division_office_tbl d,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl a" +
		" WHERE c.circle_office_code=substr(ad.office_code,2,2) and d.division_office_code=" +
		"substr(ad.office_code,4,1)and d.circle_office_code=substr(ad.office_code,2,2)and" +
		" d.head_office_code=substr(ad.office_code,1,1)and " +
		"c.head_office_code=substr(ad.office_code,1,1)and at.TYPE_OF_ASSET_CODE =" +
		"ad.TYPE_OF_ASSET and  P.PROGRAMME_CODE=ad.PROGRAMME_CODE " +
		" AND s.SUBPROGRAMME_CODE (+)=ad.SUBPROGRAMME_CODE and p.programme_code=s.programme_code" +
		" and pl.plan_code=ad.plan_code and a.aug_new_code=ad.aug_new_code " ; 
			    
		if(!workId.equals(""))
		{
			query=query+" and ad.WORK_ID='"+workId+"'";
		}
		query=query+" order by PREPARED_ON";
		
		Debug.println("Query is "+query);
 		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		representativeProposals = new ArrayList();
		
		while(rset.next())
		{
			proposalDTO = new DroughtDTO();
			
			proposalDTO.setProposalName(rset.getString(1));
			proposalDTO.setProposalId(rset.getString(2));
			proposalDTO.setNoOfHabs(rset.getString(3));
			proposalDTO.setEstimateCost(rset.getString(4));
			proposalDTO.setSanctionedAmount(rset.getString(5)); 
			proposalDTO.setAdminNo(rset.getString(6)); 
			proposalDTO.setAdminDate(rset.getString(7));
			proposalDTO.setSpillOver(rset.getString(8));
			proposalDTO.setTypeOfAsset(rset.getString(9));
			proposalDTO.setProgrammeName(rset.getString(10));
			proposalDTO.setSubprogrammeName(rset.getString(11));
			proposalDTO.setPreparedBy(rset.getString(12));
			proposalDTO.setPreparedOn(rset.getString(13));
			proposalDTO.setRemarks(rset.getString(14));
			proposalDTO.setOfficeCode(rset.getString(15));
			proposalDTO.setCircleOfficeName(rset.getString(16));
			proposalDTO.setCircleOfficeCode(rset.getString(17));
			proposalDTO.setDivisionOfficeName(rset.getString(18));
		 	proposalDTO.setDivisionOfficeCode(rset.getString(19));
		 	proposalDTO.setWorkCat(rset.getString(20));
		 	proposalDTO.setPlan(rset.getString(21));
		 	proposalDTO.setWrkType(rset.getString(22));
		 	
		 	representativeProposals.add(proposalDTO);
		}
	}
	catch(Exception e)
	{	Debug.writeln("Exception in getRepresentativeProposals : \n" + e);			
	}
	finally
	{	
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle){ }
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}
	Debug.println("representativeProposals.size() in ProposalDAO(): " + 
						representativeProposals.size());
	return representativeProposals;		
}
////////////////////////
public  void  getHabsForRevisedWorkIdToSession(HttpSession session,String workId  ) 
throws Exception
	{String code=workId.substring(6,8);
	 Debug.println("in getHabsForRevisedWorkIdToSessionnnnnnn"+code);
		Connection conn=null;
		try
		{
	     Debug.println("in getting habs for workId");
		 conn=RwsOffices.getConn();
		 conn.setAutoCommit(false);
		 Statement stmt=conn.createStatement();
		 deleteTempSelectedHabs();
		 Statement stmt2=conn.createStatement();
		 if(!(code.equals("11")||code.equals("12")))
		 {
		 query="select distinct work_id,hab_code from RWS_REV_ADM_SANC_HAB_LNK_TBL where work_id='"+workId+"'";
		 }
		 else if(code.equals("11"))
		 {
		 	query="select distinct work_id,hab_code,school_code from RWS_REV_SCHOOL_LNK_TBL where work_id='"+workId+"'";
		 }
		 else if(code.equals("12"))
		 {
		 	query="select distinct work_id,lab_code from RWS_REV_LAB_LNK_TBL where work_id='"+workId+"'";
		 }
		 Debug.println("getHabsForRevisedWorkIdToSessionnnnnnn"+query);
		 ResultSet rs=stmt.executeQuery(query);
		 ArrayList selectedHabCodesForRevisedAdmnSanc=new ArrayList();
		 while(rs.next())
			{
				RwsLocationBean rwsLocationBean=new RwsLocationBean();
				if(!(code.equals("11") ||code.equals("12")))
				{
				rwsLocationBean.setHabCode(rs.getString("hab_code"));
				rwsLocationBean.setProposalId(rs.getString("work_id"));
				}
				else if(code.equals("11"))
				{
					rwsLocationBean.setHabCode(rs.getString("hab_code")+rs.getString("school_code"));
					rwsLocationBean.setProposalId(rs.getString("work_id"));
					rwsLocationBean.setSchoolCode(rs.getString("school_code"));
				}
				else if(code.equals("12"))
				{
					rwsLocationBean.setProposalId(rs.getString("work_id"));
					rwsLocationBean.setHabCode(rs.getString("lab_code"));
				}
				selectedHabCodesForRevisedAdmnSanc.add(rwsLocationBean);
			}
		  session.setAttribute("tempSelectedAdmnHabs",selectedHabCodesForRevisedAdmnSanc);
		}
		catch(Exception e)
		{
			Debug.println("Exceptin is"+e);
		}
		finally
		{	 
			conn.close();
		}
	}
/////////////////////////////////
public ArrayList getRevisedSelectedHabs(ArrayList selectedHabCodes,String workid)
{Debug.println("in getRevisedSelectedHabs method");
Connection conn = null;
Statement stat = null;
ResultSet rset = null;
ArrayList tempSelectedHabs = new ArrayList();
//Debug.println("in getRevisedSelectedHabs in proposalDAO:::::::::"+workid);
String code=workid.substring(6,8);
//Debug.println("in getRevisedSelectedHabs in proposalDAO:::::::::"+code);
//Debug.println("code in getRevisedSelectedHabs"+selectedHabCodes.size());
String tabName="";
String query ="";

//Debug.println("in getRevisedSelectedHabs in proposalDAO"+code);
try
{
	conn = RwsOffices.getConn();
	stat = conn.createStatement();
	if(!(code.equals("11")||code.equals("12")))
	{
	tabName="Revised_sanc_habs_tbl";
	}
	else if(code.equals("11"))
	{
		tabName="Revised_sanc_schools_tbl";
		}
	else if(code.equals("12"))
	{
		tabName="Revised_sanc_labs_tbl";
		}
	synchronized(this)
	{
			
		insertProposalTempHabsForAdmin2(selectedHabCodes,tabName,workid);
		//insertProposalTempHabsForAdmin(String proposalId, String[] habCodes,String tabName);
			
		if(!(code.equals("11")||code.equals("12")))
		{
		query= "SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, " 
			 + " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
	         + " FROM "+tabName+" T, rws_panchayat_raj_tbl P, " 
	         + " rws_habitation_directory_tbl D "
			 + " WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code "
			 + " ORDER BY P.panch_name ";
		}
		else if(code.equals("11"))
		{
			query= "select proposal_id,a.school_code,school_name,a.hab_code,panch_name from "+tabName+" a,rws_school_master_tbl  b,rws_complete_hab_view  v  where  a.hab_code=b.hab_code and a.school_code=b.school_code and a.hab_code=v.panch_code and b.hab_code=v.panch_code ";
								
		}
		else if(code.equals("12"))
		{
			query= "select distinct proposal_id,b.lab_code,lab_name,location from "+tabName+" a,rws_water_quality_lab_tbl b  where  a.lab_code=b.lab_code";
								
		}
		Debug.println("Query is for habssssss"+query);
		rset = stat.executeQuery(query);
		RwsLocationBean rwsLocationBean = null; 
		while(rset.next())
		{
			rwsLocationBean = new RwsLocationBean();
			if(!(code.equals("11")||code.equals("12")))
			{
			rwsLocationBean.setProposalId(rset.getString(1));
			rwsLocationBean.setHabCode(rset.getString(2));
			rwsLocationBean.setHabName(rset.getString(3));
			rwsLocationBean.setStatus(rset.getString(4));
			rwsLocationBean.setPopulation(rset.getString(5));
			}
			else if(code.equals("11"))
			{

	     	 	rwsLocationBean.setProposalId(rset.getString(1));
	     	 	rwsLocationBean.setHabCode(rset.getString(4));
		     	rwsLocationBean.setSchoolCode(rset.getString(2));
		     	rwsLocationBean.setSchoolName(rset.getString(3));
		     	rwsLocationBean.setHabName(rset.getString(5));
			}
			else if(code.equals("12"))
			{

				rwsLocationBean.setProposalId(rset.getString(1));
		     	rwsLocationBean.setLabCode(rset.getString(2));
		     	rwsLocationBean.setLabName(rset.getString(3));
		     	rwsLocationBean.setLocation(rset.getString(4));
			}
			tempSelectedHabs.add(rwsLocationBean);
		}
		if(!(code.equals("11")||code.equals("12")))
		{
		query="DELETE FROM "+tabName;
		}
		else if(code.equals("11"))
		{
			query="DELETE FROM "+tabName;
		}
		else if(code.equals("12"))
		{
			query="DELETE FROM "+tabName;
		}
		Debug.println(" delete query is "+query);
		stat.executeUpdate(query);
	}
}
catch(Exception e)
{	Debug.println("Exception in getRevisedSelectedHabs() : " + e);
	
}
finally
{
	if(rset != null)
	{	try
		{	rset.close();
		}
		catch(SQLException sqle)
		{	
		}
	}
	if(stat != null)
	{	try
		{	stat.close();
		}
		catch(SQLException sqle)
		{	
		}
	}
	if(conn != null)
	{	try
		{	conn.close();
		}
		catch(SQLException sqle)
		{	
		}
	}
}
return tempSelectedHabs;
}
/////////////////////////
public ArrayList getSelectedHabitationsForAdminStrative(String proposalId,String tabName,boolean flag)
{
	Debug.println("in habs list2");
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	String schemecode=proposalId.substring(6,8);
//	Debug.println("scheme code in getSelectedHabitationsForAdminStrative:"+schemecode);

	ArrayList habs = new ArrayList();
	try
	{
		if(!(schemecode.equals("11")|| schemecode.equals("12")))
		{
		query = " SELECT distinct PR.panch_code, PR.panch_name, "
			  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
			  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
			  + " rws_habitation_directory_tbl HD, rws_drought_works_tbl HL "
			  + " WHERE PR.panch_code = HL.habitation_code "
			  + " AND PR.panch_code = HD.hab_code "
			  + " AND HL.work_id ='" +  proposalId + "'";
		}else if(schemecode.equals("11"))
		{
			query =	" select s.hab_code,s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE,panch_name  from "
			  + " rws_school_master_tbl s, rws_work_school_lnk_tbl HL,rws_panchayat_raj_tbl b "
			  + " WHERE s.school_code = HL.school_code "
			  + " and s.hab_code=hl.hab_code and s.hab_code=b.panch_code   "
			  + " and work_id='"+proposalId+"'";
	    }
		else if(schemecode.equals("12"))
	    {
		query =	"SELECT  a.LAB_CODE,a.LAB_NAME,a.LOCATION FROM  rws_water_quality_lab_tbl a, RWS_WORK_LAB_LNK_TBL b WHERE   a.lab_code=b.lab_code and  WORK_ID='"+proposalId+"'" ;
	    }
	Debug.println("Query is in get  editttttt--ramessssssssssssssssssshhhhhhhhhhhhh:"+query);
		
		conn = RwsOffices.getConn();
		//Debug.println("connected to ..."+conn);
		String[] habcodes=new String[1000];
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
	 	RwsLocationBean rwsLocationBean = null;
		int i=0;
		while(rset.next())
		{	
		try{
			rwsLocationBean = new RwsLocationBean();
			if(!(schemecode.equals("11")|| schemecode.equals("12")))
			{
			rwsLocationBean.setHabCode(rset.getString(1));
			if(rset.getString(1)!=null)
			   {
				//Debug.println("connected to ..."+i+"**"+rset.getString(1));
			    habcodes[i]=rset.getString(1);
			    i++;
			   }
			
			rwsLocationBean.setHabName(rset.getString(2));
			rwsLocationBean.setPopulation(rset.getString(3));
			rwsLocationBean.setStatus(rset.getString(4));
			}
			else if(schemecode.equals("11"))
			{
				rwsLocationBean.setHabCode(rset.getString(1));
				rwsLocationBean.setHabMatch(rset.getString(1));					
				rwsLocationBean.setHabitationCode(rset.getString(1)+rset.getString(2));
				if(rset.getString(1)!=null)
			    {
				//Debug.println("connected to ..."+i+"**"+rset.getString(1));
			    habcodes[i]=rset.getString(1)+rset.getString(2);
			    i++;
			    }
			rwsLocationBean.setSchoolCode(rset.getString(2));
			rwsLocationBean.setSchoolName(rset.getString(3));
			rwsLocationBean.setSchoolLocation(rset.getString(4));
			rwsLocationBean.setSchoolClasification(rset.getString(5));
			rwsLocationBean.setNoofStudents(rset.getString(6));
			rwsLocationBean.setFacilities(rset.getString(7));
			rwsLocationBean.setPanchayatName(rset.getString(8));
			}
			else if(schemecode.equals("12"))
			{
				rwsLocationBean.setLabCode(rset.getString(1));
				if(rset.getString(1)!=null)
			   {
			//	Debug.println("connected to ..."+i+"**"+rset.getString(1));
			    habcodes[i]=rset.getString(1);
			    i++;
			   }
			
			rwsLocationBean.setLabCode(rset.getString(1));
			rwsLocationBean.setLabName(rset.getString(2));
			rwsLocationBean.setLocation(rset.getString(3));
							
			}
			habs.add(rwsLocationBean);
		}
		catch(Exception e)
		{
			Debug.println("Exception "+e);
		}
		}
		//Debug.println("habcode lenght is :"+habcodes.length);
		insertProposalTempHabsForAdmin(proposalId,habcodes,tabName,flag);
	}
	catch(Exception e)
	{	Debug.writeln("Exception in getSelectedHabitations for getSelectedHabitationsForAdminStrative  :\n" + e);			
	}
	finally
	{	if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle){ }
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}
	return habs;
}
///////////////////////////
public boolean insertProposalTempHabsForAdmin2(ArrayList tempSelectedHabCodes,String tabName,String workid)
{Debug.println("insertProposalTempHabsForAdmin2() called.-----****----");

Debug.println("table name is:"+tabName);
String code=workid.substring(6,8);
Debug.println("code in insertProposalTempHabsForAdmin2"+code);
Connection conn = null;
Statement stat = null;
int[] updateCounts;
try
{
	conn = RwsOffices.getConn();
	conn.setAutoCommit(false);
	stat = conn.createStatement();
	Statement stmt1=conn.createStatement();
	boolean status=true;
	String q="select * from tab where tname ='"+tabName.toUpperCase()+"'";
	ResultSet rs=stmt1.executeQuery(q);
	Debug.println("qqqqqqqqqqqq"+q);
	if(rs.next())
	{
		Debug.println("table already exists");
		status=false;
	}
	if(status)
	{
		if(status && (!(code.equals("11")|| code.equals("12"))))
		{
			 query = "create table "+ tabName+" as select * from rws_temp_proposal_hab_tbl where 1=2";
			 	stat.addBatch(query);
		}
		if(status && code.equals("11"))
		{
			query = "create table "+ tabName+" as select proposal_id,hab_code,'123' as school_code from rws_temp_proposal_hab_tbl where 1=2";
		 	stat.addBatch(query);
		}
		if(status && code.equals("12"))
		{
			query = "create table "+ tabName+" as select proposal_id,'21' as lab_code from rws_temp_proposal_hab_tbl where 1=2";
				Debug.println("qry:"+query);
		 	stat.addBatch(query);
		}
	
	 Debug.println(query);
	 stat.addBatch(query);
	}
	
	query = "DELETE FROM "+tabName+" WHERE proposal_id='" + workid + "'";
	Debug.println("Query is :"+query);
	stat.addBatch(query);
	
	updateCounts = stat.executeBatch();
	Debug.println("tempSelectedHabCodes size is "+tempSelectedHabCodes.size());
	for(int i=0;i<tempSelectedHabCodes.size();i++)
	{
		
		RwsLocationBean rwsLocationBean=(RwsLocationBean)tempSelectedHabCodes.get(i);
		Debug.println("proposalid:::in revised::"+rwsLocationBean.getProposalId());
		String proposalId=rwsLocationBean.getProposalId();
		String habCode=rwsLocationBean.getHabCode();
		Debug.println("habcode forrrrrr::::"+habCode);
		String labCode=rwsLocationBean.getLabCode();
		
		if(!(code.equals("11")|| code.equals("12")))
		{
			Debug.println("habcode for pws");
		query = " INSERT INTO "+tabName+" VALUES( "
				  + " '" + proposalId + "', '" + habCode + "')" ; 
		}
		else if(code.equals("11"))
		{
			Debug.println("habcodes:::::"+habCode);
			query = " INSERT INTO "+tabName+" VALUES( "
			  + " '" + proposalId + "', '" + habCode.substring(0,16) + "','" + habCode.substring(16,19) + "')" ; 
		}
		else if(code.equals("12"))
		{
			query = " INSERT INTO "+tabName+" VALUES( "
			  + " '" + proposalId + "', '" + habCode+"')" ; 
		}
		Debug.println("Query is "+query);
		stat.addBatch(query);
	
	}
	if(tempSelectedHabCodes.size()==0)
	{
		if(!(code.equals("11")||code.equals("12")))
			query ="insert into "+tabName+" select WORK_ID,HAB_CODE from RWS_REV_ADM_SANC_HAB_LNK_TBL where work_id='" + workid + "'";
		else if(code.equals("11"))
			query ="insert into "+tabName+" select * from RWS_REV_SCHOOL_LNK_TBL where work_id='" + workid + "'";
		else if(code.equals("12"))
			query ="insert into "+tabName+" select * from RWS_REV_LAB_LNK_TBL where work_id='" + workid + "'";
		Debug.println("ins qry:"+query);
	
		stat.addBatch(query);
	}
	
	flag = true;

	updateCounts = stat.executeBatch();
	
	for(int i=0; i<updateCounts.length; i++)
	{
		if(updateCounts[i] < 0)
			flag = false;
	}
	
	if(flag)
		conn.commit();
		
}
catch(Exception e)
{	Debug.println("Exception in insertProposalTempHabsForAdmin2 : \n" + e);
	flag = false;
}
finally
{
	if(stat != null)
	{	try
		{	stat.close();
		}
		catch(SQLException sqle){ }
	}
	if(conn != null)
	{	try
		{	conn.close();
		}
		catch(SQLException sqle){ }
	}
}

return flag;
}
/////////////////////////
public boolean insertProposalTempHabsForAdmin(String proposalId, String[] habCodes,String tabName,boolean flag)
{Debug.println("insertProposalTempHabsForAdmin() called.-----****----");
Debug.println("table name is:"+tabName);
Debug.println("Proposal Id : " + proposalId);
Debug.println("Hab Codes Length: " + habCodes.length);
String code = proposalId.substring(6,8);
Debug.println("proposalId.substring(6,8)"+code);
Connection conn = null;
Statement stat = null;
int[] updateCounts;
try
{
	conn = RwsOffices.getConn();
	conn.setAutoCommit(false);
	stat = conn.createStatement();
	query="";
	Statement stmt1=conn.createStatement();
	boolean status=true,status1=true,status2=true;
	//String selQry = "SELECT (select COUNT(*) from tab where tname ='"+tabName.toUpperCase()+"')A,(select COUNT(*) from tab where tname ='"+tabName.toUpperCase()+"_SCHOOL')b,(select COUNT(*) from tab where tname ='"+tabName.toUpperCase()+"_LAB')b FROM DUAL";
	String selQry = "SELECT  COUNT(*) from tab where UPPER(tname) ='"+tabName.toUpperCase()+"'";
	Debug.println("s qry:"+selQry);
	ResultSet rs=stmt1.executeQuery(selQry);
	if(rs.next())
	{
		Debug.println("table already existsssss:"+code);
		if(rs.getInt(1)>0)
			status = false;
		
	}
	Debug.println("status:"+status);
	//Debug.println("statussssssssssss:"+query);
	
	if(status && (!(code.equals("11")|| code.equals("12"))))
	{
		query = "create table "+ tabName+" as select proposal_id,hab_code as school_code from rws_temp_proposal_hab_tbl where 1=2";
		 	stat.addBatch(query);
	}
	if(status && code.equals("11"))
	{
		query = "create table "+ tabName+" as select proposal_id,hab_code,'123' as school_code from rws_temp_proposal_hab_tbl where 1=2";
	 	stat.addBatch(query);
	}
	if(status && code.equals("12"))
	{
		query = "create table "+ tabName+" as select proposal_id,'21' as lab_code from rws_temp_proposal_hab_tbl where 1=2";
			Debug.println("qry:::::uuuuuuuuuuuuuuuuuuuuuuuuuu:"+query);
	 	stat.addBatch(query);
	}
	
	Debug.println("table name is222222222ttttttttttttt:"+query);
		query = "DELETE FROM "+tabName+" WHERE proposal_id='" + proposalId + "'";
	Debug.println("Query is :"+query);
	stat.addBatch(query);

	updateCounts = stat.executeBatch();
	Debug.println("Habcodes length is"+habCodes.length);
	String tablenames="",tablenames1="" ,tablenames2="",tablenames3="";
	if(flag)
	{
		tablenames1="rws_admn_hab_lnk_tbl";
		tablenames2="rws_work_school_lnk_tbl";
		tablenames3="rws_work_lab_lnk_tbl";
		
	}
	else
	{
		tablenames1="RWS_REV_ADM_SANC_HAB_LNK_TBL";
		tablenames2="RWS_REV_SCHOOL_LNK_TBL";
		tablenames3="RWS_REV_LAB_LNK_TBL";
	}
	if(habCodes.length>0)
	{
		for(int i=0; i<habCodes.length; i++)
		{
			if(habCodes[i]!=null)
			{
				Debug.println("habcode[i] value:::::::::"+habCodes[i]);
				if(!(code.equals("11")||code.equals("12")))
					query = " INSERT INTO "+tabName+" VALUES( "
					  + " '" + proposalId + "', '" + habCodes[i] + "')" ; 
				else if(code.equals("11"))
					
					query = " INSERT INTO "+tabName+" VALUES( "
					  + " '" + proposalId + "', '" + habCodes[i].substring(0,16) + "', '" + habCodes[i].substring(16,19) + "')" ;
				else if(code.equals("12"))
					query = " INSERT INTO "+tabName+" VALUES( "
					  + " '" + proposalId + "', '" + habCodes[i] + "')" ; 
			Debug.println("Query is "+query);
			stat.addBatch(query);
			}
		}
	}
	else
	{
		if(!(code.equals("11")||code.equals("12")))
			query ="insert into "+tabName+" select WORK_ID,HAB_CODE   from "+tablenames1+" where work_id='" + proposalId + "'";
		else if(code.equals("11"))
			query ="insert into "+tabName+" select * from "+tablenames2+" where work_id='" + proposalId + "'";
		else if(code.equals("12"))
			query ="insert into "+tabName+" select * from "+tablenames3+" where work_id='" + proposalId + "'";
		Debug.println("ins qry:"+query);
	
		stat.addBatch(query);
	}
	Debug.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
	flag = true;

	updateCounts = stat.executeBatch();
	
	for(int i=0; i<updateCounts.length; i++)
	{
		if(updateCounts[i] < 0)
			flag = false;
	}
	
	if(flag)
		conn.commit();
	 
	
}
catch(Exception e)
{	Debug.println("Exception in insertProposalTempHabsForAdmin : \n" + e);
	flag = false;
}
finally
{
	if(stat != null)
	{	try
		{	stat.close();
		}
		catch(SQLException sqle){ }
	}
	if(conn != null)
	{	try
		{	conn.close();
		}
		catch(SQLException sqle){ }
	}
}

return flag;}
//////////////////////
public ArrayList getSelectedHabitationsForRevised(String proposalId)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;

	String code=proposalId.substring(6,8);
	Debug.println("in revised show"+code);
			ArrayList habs = new ArrayList();
			try
			{
				if(!(code.equals("11")||code.equals("12")))
		    	{
				query = " SELECT PR.panch_code, PR.panch_name, "
					  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
					  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
					  + " rws_habitation_directory_tbl HD, RWS_REV_ADM_SANC_HAB_LNK_TBL  HL "
					  + " WHERE PR.panch_code = HL.hab_code "
					  + " AND PR.panch_code = HD.hab_code "
					  + " AND HL.work_id ='" +  proposalId + "'";
		    	}else if (code.equals("11"))
		    	{
		    		query = "select s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE  from "
		  			  + " rws_school_master_tbl s,  RWS_REV_SCHOOL_LNK_TBL HL "
		  			  + " WHERE s.school_code = HL.school_code "
		  			  + " and s.hab_code=hl.hab_code  "
		  			  + " AND HL.work_id ='" +  proposalId + "'";
		    	}
		    	else if(code.equals("12"))
		    	{
		    		query = "SELECT l.LAB_CODE,LAB_NAME,LOCATION from "
		  			  + " RWS_WATER_QUALITY_LAB_TBL L, RWS_REV_LAB_LNK_TBL  HL "
		  			  + " WHERE L.LAB_CODE = HL.LAB_code "
		  			  + " AND HL.work_id ='" +  proposalId + "'";
		    	}
				
				conn = RwsOffices.getConn();
				stat = conn.createStatement();
				rset = stat.executeQuery(query);
				Debug.println("habs in proposals"+query);
				RwsLocationBean rwsLocationBean = null;
				while(rset.next())
				{rwsLocationBean = new RwsLocationBean();
					if(!(code.equals("11")||code.equals("12")))
			    	{
					
					rwsLocationBean.setHabCode(rset.getString(1));
					rwsLocationBean.setHabName(rset.getString(2));
					rwsLocationBean.setPopulation(rset.getString(3));
					rwsLocationBean.setStatus(rset.getString(4));
			    	}
					else if(code.equals("11"))
					{
						rwsLocationBean.setSchoolCode(rset.getString(1));
						rwsLocationBean.setSchoolName(rset.getString(2));
						rwsLocationBean.setSchoolLocation(rset.getString(3));
						rwsLocationBean.setSchoolClasification(rset.getString(4));
						rwsLocationBean.setNoofStudents(rset.getString(5));
						rwsLocationBean.setFacilities(rset.getString(6));
					}
					else if(code.equals("12"))
					{
						rwsLocationBean.setLabCode(rset.getString(1));
						rwsLocationBean.setLabName(rset.getString(2));
						rwsLocationBean.setLocation(rset.getString(3));
					}
					habs.add(rwsLocationBean);
				}
			}
			catch(Exception e)
			{	Debug.writeln("Exception in getSelectedHabitations :\n" + e);			
			}
			finally
			{	if(rset != null)
				{	try
					{	rset.close();
					}
					catch(SQLException sqle){ }
				}
				if(stat != null)
				{	try
					{	stat.close();
					}
					catch(SQLException sqle){ }
				}
				if(conn != null)
				{	try
					{	conn.close();
					}
					catch(SQLException sqle){ }
				}
			}
			return habs;
}

public ArrayList getAdminstrativeSanctionView(String officeCode,String circlecode,String divcode,String subdivcode,String catg,String schm,String prog,String subprog,String plan)
{Connection conn = null;
PreparedStatement pstmt = null,pstmt1 = null;
ResultSet rset = null,rset1 = null;
try
{      
 		 query = "SELECT distinct ad.WORK_NAME ,ad.WORK_ID,ad.work_type,ad.habitation_code,ad.admin_AMOUNT,ad.ADMIN_NO,to_char(ad.ADMIN_DATE,'dd/mm/yyyy') ,At.TYPE_OF_ASSET_NAME,"
 		 		+ "p.PROGRAMME_Name ,s.SUBPROGRAMME_NAME,ad.PREPARED_BY ,to_char(ad.PREPARED_ON,'dd/mm/yyyy')asprepared_on ,ad.office_code,w.category_name,pl.plan_name,TS_NO,to_char(TS_DATE,'dd/mm/yyyy'),"
 		 		+ "TS_AMOUNT,SSR_YEAR,SOURCE_HAB_CODE,ASSET_CODE,NEW_EXISTING,to_char(SITE_HAND_OVER_DATE,'dd/mm/yyyy'),to_char(GROUNDING_DATE,'dd/mm/yyyy'),EXPENDITURE_UPTO,to_char(EXPENDITURE_UPTO_DT,'dd/mm/yyyy'),"
 		 		+ "VALUE_OF_WORK_NOT_PAID,to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),to_char(Date_of_COMM,'dd/mm/yyyy'),ad.approved_under,AD.remarks,AUG_WORKID,ad.sus_code "
 		 		+ "FROM  rws_drought_works_tbl ad, rws_programme_tbl P,  rws_subprogramme_tbl S,rws_asset_type_tbl AT,rws_work_category_tbl w,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl a ,RWS_SOURCE_TYPE_TBL sd, RWS_SUBSOURCE_TYPE_TBL ssd "
 		 		+ "where  ad.category_code=w.category_code and at.TYPE_OF_ASSET_CODE =ad.TYPE_OF_ASSET and  P.PROGRAMME_CODE=ad.PROGRAMME_CODE AND (ad.PROGRAMME_CODE=s.PROGRAMME_CODE  and ad.subprogramme_code=s.subprogramme_code) "
 		 		+ "and ad.plan_code=pl.plan_code and substr(ad.WORK_ID,5,2)=? and ad.CATEGORY_CODE=? and ad.TYPE_OF_ASSET =?"; 
			if(!divcode.equals(""))
			{
				query+=" and substr(ad.office_code,4,1)='"+divcode+"'";
			}
			if(!subdivcode.equals(""))
			{
				query+=" and substr(ad.office_code,5,2)='"+subdivcode+"'";
			}
		    		
			if(prog!=null&&!prog.equals(""))
			{
			query+="and ad.PROGRAMME_CODE='"+prog+"'";
			}
			if(subprog!=null&&!subprog.equals(""))
			{
			query+="and ad.SUBPROGRAMME_CODE='"+subprog+"'";
			}
			query+=" order by 1 asc";
			
 		conn = RwsOffices.getConn();
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, circlecode);
		pstmt.setString(2, catg);
		pstmt.setString(3, schm);
		rset = pstmt.executeQuery();
		representativeProposals = new ArrayList();
	
	while(rset.next())
	{
		
		String sus_name="";
		if(rset.getString(34)!=null && !rset.getString(34).equals(""))
		{
			String qry1="select sus_name from rws_sus_id_tbl where sus_code=?";
			pstmt1 = conn.prepareStatement(qry1);
			pstmt1.setString(1, rset.getString(34));
			rset1 = pstmt1.executeQuery();
			if(rset1.next())
			{
			  sus_name=rset1.getString(1);
			}
		
		}
		else
			sus_name="-";
		
		proposalDTO = new DroughtDTO();
		proposalDTO.setProposalName(rset.getString(1));
		proposalDTO.setProposalId(rset.getString(2));
		proposalDTO.setWorkType(rset.getString(3));
		proposalDTO.setNoOfHabs(rset.getString(4));
		proposalDTO.setSanctionedAmount(rset.getString(5)); 
		proposalDTO.setAdminNo(rset.getString(6)); 
		proposalDTO.setAdminDate(rset.getString(7));
		proposalDTO.setTypeOfAsset(rset.getString(8));
		proposalDTO.setProgrammeName(rset.getString(9));
		proposalDTO.setSubprogrammeName(rset.getString(10));
		proposalDTO.setPreparedBy(rset.getString(11));
		proposalDTO.setPreparedOn(rset.getString(12));
		proposalDTO.setOfficeCode(rset.getString(13));
		proposalDTO.setWorkCat(rset.getString(14));
		proposalDTO.setPlan(rset.getString(15));			
	    proposalDTO.setTsno(rset.getString(16));
	    proposalDTO.setTsamt(rset.getString(17));
	    proposalDTO.setTsdate(rset.getString(18));
	    proposalDTO.setSsryr(rset.getString(19));
	    proposalDTO.setSrhabcode(rset.getString(20));
	    proposalDTO.setAstcode(rset.getString(21));
	    proposalDTO.setNewext(rset.getString(22));
	    proposalDTO.setSitedate(rset.getString(23));
	    proposalDTO.setGrounddate(rset.getString(24));
	    proposalDTO.setExpupto(rset.getString(25));
	    proposalDTO.setExpuptodate(rset.getString(26));
	    proposalDTO.setNotpaidvalue(rset.getString(27));
	    proposalDTO.setCompdate(rset.getString(28));
	    proposalDTO.setFincompdate(rset.getString(29));
	    proposalDTO.setCommdate(rset.getString(30));
	    proposalDTO.setProoved(rset.getString(31));
	    proposalDTO.setRemarks(rset.getString(32));
	    proposalDTO.setWrkType(rset.getString(33));
	    proposalDTO.setSusType(sus_name);
		representativeProposals.add(proposalDTO);
	}
}
catch(Exception e)
{	Debug.writeln("Exception in drought works view " + e);	
   
}
finally
{	
	if(rset != null)
	{	try
		{	rset.close();
		}
		catch(SQLException sqle){ }
	}
	if(pstmt != null)
	{	try
		{	pstmt.close();
		}
		catch(SQLException sqle){ }
	}
	if(pstmt1 != null)
	{	try
		{	pstmt1.close();
		}
		catch(SQLException sqle){ }
	}
	if(conn != null)
	{	try
		{	conn.close();
		}
		catch(SQLException sqle){ }
	}
}
return representativeProposals;

}
public String[] getMandalCodesFormAdmn(String proposalId)throws Exception 
{
	Connection conn=null;
	String[] mcodes={};
	String q="";
	try
	{
		String code=proposalId.substring(6,8);
		Debug.println("code in getMandalCodesFormAdmn"+code);
	   conn=RwsOffices.getConn();
	   Statement stmt=conn.createStatement();
	 // Debug.println("select distinct substr(hab_code,6,2) from RWS_ADMN_HAB_LNK_TBL  where WORK_ID ='"+proposalId+"'");
	  if(!(code.equals("11")||code.equals("12")))
	  {
	  q="select distinct substr(hab_code,6,2) from RWS_ADMN_HAB_LNK_TBL  where WORK_ID ='"+proposalId+"'";
	  }
	  else if(code.equals("11"))
	  	{
	  q="select distinct substr(hab_code,6,2) from RWS_WORK_SCHOOL_LNK_TBL  where WORK_ID ='"+proposalId+"'";
	  	}
	  else if(code.equals("12"))
	  	{
	  	q="select  distinct substr(b.office_code,2,2) from RWS_WORK_LAB_LNK_TBL a, rws_water_quality_lab_tbl b where WORK_ID ='"+proposalId+"' and a.lab_code=b.lab_code";
	  	}
	  	Debug.println("QQQQ"+q);
	  ResultSet rs=stmt.executeQuery(q);
	  int count = 0;
	  
	  while(rs.next())
	  {
	  	count++;
	  }
	  mcodes=new String[count];
	  if(!(code.equals("11")|| code.equals("12")))
	  {
	  q="select distinct substr(hab_code,6,2) from RWS_ADMN_HAB_LNK_TBL  where WORK_ID ='"+proposalId+"'";
	  }
	  else
	  	if(code.equals("11"))
	  	{
	  		q="select distinct substr(hab_code,6,2) from RWS_WORK_SCHOOL_LNK_TBL  where WORK_ID ='"+proposalId+"'";
	  	}
	  	if(code.equals("12"))
	  	{
	  		q="select  distinct substr(b.office_code,2,2) from RWS_WORK_LAB_LNK_TBL a, rws_water_quality_lab_tbl b where WORK_ID ='"+proposalId+"' and a.lab_code=b.lab_code";
	  	}
	  rs=stmt.executeQuery(q);
	  int i=0;
	  while(rs.next())
	  {
	  	if(rs.getString(1)!=null)
	  	{
	  	mcodes[i]=rs.getString(1);
	  	i++;
	  	}
	  }
		Debug.println("#### mcodes length:::::::::"+mcodes.length);
	}
	catch(Exception e)
	{
		Debug.println("Exception is :##"+e);
	}
	finally
	{
		conn.close();
	}
	return mcodes;
	}
///////////////////////////
public ArrayList getTempSelectedHabsForAdminSancEdit(String proposalId,String tabName)
{Connection conn = null;
Statement stat = null;
ResultSet rset = null;
String query ="";
ArrayList tempSelectedHabs = new ArrayList();
String scheme=proposalId.substring(6,8);
System.out.println("scheme in getTempSelectedHabsForAdminSancEdit "+scheme);
try
{
	conn = RwsOffices.getConn();
	stat = conn.createStatement();
	if(!(scheme.equals("11")|| scheme.equals("12")))
	{
		query = " SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, " 
				 + " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
		         + " FROM "+tabName+" T, rws_panchayat_raj_tbl P, " 
		         + " rws_habitation_directory_tbl D "
				 + " WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code "
				 + " AND T.proposal_id = '" + proposalId + "'";
	}else if(scheme.equals("11"))
	{
		//query ="select a.*,B.SCHOOL_CODE ,SCHOOL_NAME from RWS_ADMIN_HABS_PICK_VIEW A, RWS_SCHOOL_MASTER_TBL B,"+tabName+" c WHERE  A.PANCH_CODE=b.HAB_CODE and a.panch_code=c.hab_code and b.school_code=c.school_code and proposal_id='" + proposalId + "'";
		query="select a.*,B.SCHOOL_CODE ,SCHOOL_NAME from RWS_SCHOOL_MASTER_TBL a,tab_admin_temp_school b WHERE  a.hab_code=b.hab_code and a.school_code=b.school_code and b.proposal_id='" + proposalId + "'";
	}
	else if(scheme.equals("12"))
	{
		query ="SELECT  a.LAB_CODE,lab_name,location FROM  rws_water_quality_lab_tbl a,"+tabName+" c  WHERE  a.lab_code=c.lab_code and c.proposal_id='" + proposalId + "'";
		
	}
	
	Debug.println("Query is : getTempSelectedHabsForAdminSancEdit "+query);		
	
	rset = stat.executeQuery(query);
	RwsLocationBean rwsLocationBean = null; 
	while(rset.next())
	{
		Debug.println("aaaaaaaaaaaa:"+rset.getString(2));
		Debug.println("bbbbbbbbbbbb:"+scheme);
		if(!(scheme.equals("11")|| scheme.equals("12")))
		{
		//System.out.println("in rset");
		rwsLocationBean = new RwsLocationBean();
		rwsLocationBean.setProposalId(rset.getString(1));
		rwsLocationBean.setHabCode(rset.getString(2));
		rwsLocationBean.setHabName(rset.getString(3));
		rwsLocationBean.setStatus(rset.getString(4));
		rwsLocationBean.setPopulation(rset.getString(5));
		}
		else if(scheme.equals("11"))
		{
			rwsLocationBean = new RwsLocationBean();
			rwsLocationBean.setProposalId(rset.getString(1));
			rwsLocationBean.setHabCode(rset.getString(4)+rset.getString(9));
			rwsLocationBean.setHabName(rset.getString(5));
			rwsLocationBean.setSchoolCode(rset.getString(4)+rset.getString("SCHOOL_CODE"));
			rwsLocationBean.setSchoolName(rset.getString("school_name"));
			rwsLocationBean.setSchoolClasification(rset.getString("SCHOOL_CODE"));
		}
		else if(scheme.equals("12"))
		{
			rwsLocationBean = new RwsLocationBean();
			rwsLocationBean.setProposalId(proposalId);
			rwsLocationBean.setLabCode(rset.getString(1));
			rwsLocationBean.setLabName(rset.getString(2));
			rwsLocationBean.setLocation(rset.getString(3));
			
		}
		tempSelectedHabs.add(rwsLocationBean);
		}
	
}
catch(Exception e)
{	Debug.println("Exception in getTempSelectedHabsForAdminSancEdit() : " + e);
	
}
finally
{
	if(rset != null)
	{	try
		{	rset.close();
		}
		catch(SQLException sqle)
		{	
		}
	}
	if(stat != null)
	{	try
		{	stat.close();
		}
		catch(SQLException sqle)
		{	
		}
	}
	if(conn != null)
	{	try
		{	conn.close();
		}
		catch(SQLException sqle)
		{	
		}
	}
}
System.out.println("##################################"+tempSelectedHabs.size());
return tempSelectedHabs;
}
//////////////////////////
public ArrayList getSelectedHabitations(String proposalId)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;

	ArrayList habs = new ArrayList();
	try
	{
		query = " SELECT PR.panch_code, PR.panch_name, "
			  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
			  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
			  + " rws_habitation_directory_tbl HD, rws_proposal_hab_lnk_tbl HL "
			  + " WHERE PR.panch_code = HL.hab_code "
			  + " AND PR.panch_code = HD.hab_code "
			  + " AND HL.proposal_id ='" +  proposalId + "'";
		
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		
		RwsLocationBean rwsLocationBean = null;
		while(rset.next())
		{
			rwsLocationBean = new RwsLocationBean();
			rwsLocationBean.setHabCode(rset.getString(1));
			rwsLocationBean.setHabName(rset.getString(2));
			rwsLocationBean.setPopulation(rset.getString(3));
			rwsLocationBean.setStatus(rset.getString(4));
			habs.add(rwsLocationBean);
		}
	}
	catch(Exception e)
	{	Debug.writeln("Exception in getSelectedHabitations :\n" + e);			
	}
	finally
	{	if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle){ }
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}
	return habs;
}

public ArrayList getTempSelectedHabsForAdminSancEdit1(String[] habs)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	ArrayList tempSelectedHabs = new ArrayList();
	try
	{
		RwsLocationBean rwsLocationBean = null; 
		for(int jj=0;jj<habs.length;jj++)
		{
			//System.out.println("in rset");
			rwsLocationBean = new RwsLocationBean();
			rwsLocationBean.setHabCode(habs[jj].substring(0,16));
			rwsLocationBean.setHabName(habs[jj].substring(17,habs[jj].length()));
			tempSelectedHabs.add(rwsLocationBean);
		}
		Debug.println("temp size:"+tempSelectedHabs.size());
	}
	catch(Exception e)
	{	Debug.println("Exception in getTempSelectedHabsForAdminSancEdit() : " + e);
		
	}
	finally
	{
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	System.out.println("##################################"+tempSelectedHabs.size());
	return tempSelectedHabs;
}

public ArrayList getRepView(String officeCode) 
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;

	//Debug.println("In ProposalDAO getRepView() officeCode: " + officeCode);
	try
	{
		conn = RwsOffices.getConn();
		
		query = " SELECT UPPER(RP.proposal_name), RP.proposal_id, " 
			  + " TO_CHAR(RP.rep_date,'dd/mm/yyyy') as proposal_date,"
			  + " RP.no_of_habs, A.type_of_asset_name, "
			  + " UPPER(NVL(P.programme_name,'')), "
			  + " UPPER(NVL(S.subprogramme_name,'')), "
			  + " RP.estimate_cost,  "
			  + " UPPER(NVL(RP.remarks, '')) "
			  + " FROM "
			  + " rws_rep_proposal_tbl RP, rws_programme_tbl P, "
			  + " rws_subprogramme_tbl S, rws_asset_type_tbl A "
			  + " WHERE RP.type_of_asset = A.type_of_asset_code(+) AND "
			  + " RP.programme_code = P.programme_code (+) AND "
			  + " (RP.subprogramme_code = S.subprogramme_code(+) AND "
			  + " RP.programme_code = S.programme_code(+) ) "
			  + " AND RP.office_code = '" + officeCode + "' "
			  + " AND RP.flag = 'N' "
			  + " ORDER BY proposal_date ";
			 
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		representativeProposals = new ArrayList();
		
		while(rset.next())
		{
			proposalDTO = new DroughtDTO();
			proposalDTO.setProposalName(rset.getString(1));
			proposalDTO.setProposalId(rset.getString(2));
			proposalDTO.setProposalDate(rset.getString(3));
			proposalDTO.setNoOfHabs(rset.getString(4));
			proposalDTO.setAssetName(rset.getString(5));
			proposalDTO.setProgrammeName(rset.getString(6));
			proposalDTO.setSubprogrammeName(rset.getString(7));
			proposalDTO.setEstimateCost(rset.getString(8));
			proposalDTO.setRemarks(rset.getString(9));
			representativeProposals.add(proposalDTO);
		}
	}
	catch(Exception e)
	{	Debug.writeln("Exception in getRepView :\n" + e);			
	}
	finally
	{	if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle){ }
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}
	Debug.println("representativeProposals.size() in ProposalDAO(): " +representativeProposals.size());
	return representativeProposals;
}
public String planName(String proposalId)
{

	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	String planName="";
	try
	{
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		String query = "select p.plan_name from rws_plan_nonplan_tbl p,rws_work_admn_tbl w " +
				       " where w.work_id='"+proposalId+"' and p.plan_code=w.plan_code";
		Debug.println("Query is"+query);		
		
		rset = stat.executeQuery(query);
		RwsLocationBean rwsLocationBean = null; 
		while(rset.next())
		{
			planName=rset.getString(1);
		}
	}
	catch(Exception e)
	{	Debug.println("Exception ::" + e);
		
	}
	finally
	{
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	return planName;
}
public String augName(String proposalId)
{

	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	String augName= "";
	try
	{
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		String query ="select p.aug_new_name from rws_augumentation_new_tbl p,rws_work_admn_tbl w " +
	                  " where w.work_id='"+proposalId+"' and p.aug_new_code=w.aug_new_code";
		Debug.println("Query is"+query);		
		rset = stat.executeQuery(query);
		RwsLocationBean rwsLocationBean = null; 
		while(rset.next())
		{
			augName=rset.getString(1);
		}
	}
	catch(Exception e)
	{	Debug.println("Exception ::" + e);
		
	}
	finally
	{
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	return augName;
}
public boolean deleteRepProposal(String proposalId)
{
	Connection conn = null;
	Statement stat = null;

	try
	{
		conn = RwsOffices.getConn();
		conn.setAutoCommit(false);
		stat = conn.createStatement();
		
		query = " DELETE FROM rws_proposal_hab_lnk_tbl WHERE proposal_id = '" + proposalId + "'"; 
		stat.addBatch(query);
		
		query = " DELETE FROM rws_rep_proposal_tbl WHERE proposal_id = '" + proposalId + "'"; 
		stat.addBatch(query);

		flag = true;
		int[] updateCounts = stat.executeBatch();
		for(int i=0; i<updateCounts.length; i++)
		{
			if(updateCounts[i] == 0)
				flag = false;
		}
		if(flag)
			conn.commit();

		conn.setAutoCommit(true);
	}
	catch(Exception e)
	{	Debug.writeln("Exception in deleteRepProposal :\n" + e);			
	}
	finally
	{	
		if(stat != null)
		{	try
			{	
				stat.close();
			}
			catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}

	return flag;
}
protected ArrayList getAdminstrativeSanctionList1(String proposalId,String officeCode,String workId,String circlecode,String divcode,String subdivcode,String catg,String schm,String prog,String subprog)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	String query="";
	String newsubdiv="";
	//updated by 
	String scheme=proposalId.substring(6,8);
	Debug.println("schemenamee:::in proposals"+scheme);
	try
	{
		System.out.println("in getAdminstrativeSanctionList1");
		query="select substr(office_code,5,2) from rws_drought_works_tbl where work_id='"+proposalId+"'";
		 conn = RwsOffices.getConn();
		 stat = conn.createStatement();
		 rset = stat.executeQuery(query);
		 if (rset.next())
		 {
		 newsubdiv=rset.getString(1);
		 Debug.println(">"+newsubdiv);
		 }
		 Debug.println("11111111");
		 if ( newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00")  )
		 {
		 	Debug.println("in 1st");
		 	query = "SELECT distinct ad.WORK_NAME ,ad.WORK_ID" ;
		    query += ",ad.ADMIN_AMOUNT ,ad.ADMIN_NO,to_char(ad.ADMIN_DATE,'dd/mm/yyyy') " +
			",At.TYPE_OF_ASSET_NAME,p.PROGRAMME_Name ," +
			" s.SUBPROGRAMME_NAME,ad.PREPARED_BY ,to_char(ad.PREPARED_ON,'dd/mm/yyyy')as" +
			" prepared_on ,AD.remarks,ad.office_code,w.CATEGORY_NAME" +
			" ,c.circle_office_code,c.circle_office_name,d.division_office_code,d.division_office_name" +
			",sd.subdivision_office_code,sd.subdivision_office_name,pl.plan_name,a.AUG_NEW_Code,ad.AUG_WORKID,ad.habitation_code"+
			" FROM  rws_drought_works_tbl ad, rws_programme_tbl P,  rws_subprogramme_tbl S, " +
			" rws_asset_type_tbl AT,rws_work_category_tbl w " +
			",rws_circle_office_tbl c,rws_division_office_tbl d" +
			",rws_subdivision_office_tbl sd,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl a  "+
			" where " +
			"  ad.AUG_NEW_CODE=a.AUG_NEW_CODE  and ad.plan_code=pl.plan_code and w.category_code=ad.category_code and at.TYPE_OF_ASSET_CODE = ad.TYPE_OF_ASSET and  P.PROGRAMME_CODE=ad.PROGRAMME_CODE " +
			" AND (ad.PROGRAMME_CODE=s.PROGRAMME_CODE  and ad.subprogramme_code=s.subprogramme_code) and work_id='"+proposalId+"' "+
			" and substr(ad.office_code,2,2)=c.circle_office_code and (substr(ad.office_code,2,2)=d.circle_office_code and substr(ad.office_code,4,1)=d.division_office_code) "+ 
	        " and (substr(ad.office_code,2,2)=sd.circle_office_code and substr(ad.office_code,4,1)=sd.division_office_code and "+ 
	        " substr(ad.office_code,5,2)=sd.subdivision_office_code)";
		 }
	    else
	    {Debug.println("in 2nd");
		query = "SELECT distinct ad.WORK_NAME ,ad.WORK_ID," ;
		query+="ad.admin_AMOUNT,ad.ADMIN_NO,to_char(ad.ADMIN_DATE,'dd/mm/yyyy') " +
		",At.TYPE_OF_ASSET_NAME,p.PROGRAMME_Name ," +
		" s.SUBPROGRAMME_NAME,ad.PREPARED_BY ,to_char(ad.PREPARED_ON,'dd/mm/yyyy')as" +
		" prepared_on ,AD.remarks,ad.office_code,w.CATEGORY_NAME," +
		" c.circle_office_code,c.circle_office_name,d.division_office_code,d.division_office_name,pl.plan_name,a.AUG_NEW_code,ad.AUG_WORKID,ad.habitation_code" +
		" FROM  rws_drought_works_tbl ad, rws_programme_tbl P,  rws_subprogramme_tbl S, " +
		" rws_asset_type_tbl AT,rws_work_category_tbl w " +
		",rws_circle_office_tbl c,rws_division_office_tbl d,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl a " +
		" where " +
		"  ad.AUG_NEW_CODE=a.AUG_NEW_CODE  and ad.plan_code=pl.plan_code and w.category_code=ad.category_code and at.TYPE_OF_ASSET_CODE = ad.TYPE_OF_ASSET and  P.PROGRAMME_CODE=ad.PROGRAMME_CODE " +
		" AND (ad.PROGRAMME_CODE=s.PROGRAMME_CODE  and ad.subprogramme_code=s.subprogramme_code) and work_id='"+proposalId+"' "+
		" and substr(ad.office_code,2,2)=c.circle_office_code and (substr(ad.office_code,2,2)=d.circle_office_code and substr(ad.office_code,4,1)=d.division_office_code) "; 
     
	    }

		if(!workId.equals(""))
		{
			Debug.println("in 3rd");
			query=query+" and ad.WORK_ID='"+workId+"'";
		}Debug.println("11111111");
	    //if all and circle selected
	    if(((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& divcode.equals("") && subdivcode.equals(""))) ||
	    		((catg!=null&&catg.equals("")|| schm!=null&& schm.equals("")|| prog!=null&& prog.equals("")||subprog!=null&& subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& divcode.equals("") && subdivcode.equals(""))))
		{
	    	Debug.println("if all and circle selected");
	    	query=query+" and substr(ad.WORK_ID,5,2)='"+circlecode+"'";
	    	
		}
//	  if all and circle and division selected
	   else if(((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& !divcode.equals("") && subdivcode.equals("")))||
	   		((catg!=null&& catg.equals("")|| schm!=null&& schm.equals("")|| prog!=null&& prog.equals("")||subprog!=null&& subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& !divcode.equals("") && subdivcode.equals(""))))
		{
	   	Debug.println("if all and circle and division selected");
	    	query=query+" and substr(ad.WORK_ID,5,2)='"+circlecode+"'";
	    
		}
//		  if all and circle and division and subdivision selected
	   else if(((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& !divcode.equals("") && !subdivcode.equals("")))||
	   		((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& !divcode.equals("") && !subdivcode.equals(""))))
		{  
	   	    Debug.println("11111111");
	        Debug.println("if all and circle and division and subdivision selected");
	    	query=query+" and substr(ad.WORK_ID,5,2)='"+circlecode+"'";
	    	
		}
	   else if(((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&& circlecode.equals("")&& divcode.equals("") && subdivcode.equals(""))))
		{
	     	Debug.println("if all and no circle and no division and no subdivision selected");
	    	
		}
	    
		query=query+" order by 17 desc";
		
		Debug.println("Query In Proposal DAO :"+query);
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		representativeProposals = new ArrayList();
		
		while(rset.next())
		{
			proposalDTO = new DroughtDTO();
			
			proposalDTO.setProposalName(rset.getString(1));
			proposalDTO.setProposalId(rset.getString(2));
			proposalDTO.setSanctionedAmount(rset.getString(3)); 
			proposalDTO.setAdminNo(rset.getString(4)); 
			proposalDTO.setAdminDate(rset.getString(5));
			proposalDTO.setTypeOfAsset(rset.getString(6));
			proposalDTO.setProgrammeName(rset.getString(7));
			proposalDTO.setSubprogrammeName(rset.getString(8));
			proposalDTO.setPreparedBy(rset.getString(9));
			proposalDTO.setPreparedOn(rset.getString(10));
			proposalDTO.setRemarks(rset.getString(11));
			proposalDTO.setOfficeCode(rset.getString(12));
			proposalDTO.setWorkCat(rset.getString(13));
			proposalDTO.setCircleOfficeCode(rset.getString(14));
			proposalDTO.setCircleOfficeName(rset.getString(15));
			proposalDTO.setDivisionOfficeCode(rset.getString(16));
		 	proposalDTO.setDivisionOfficeName(rset.getString(17));
		 	Debug.println("eeeeeeetetete");
		 	if ( newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00"))
		 	{
		 	  Debug.println("tttttttttttttttttt");
		 	  proposalDTO.setSubdivisionOfficeCode(rset.getString(18));
		 	  Debug.println("tttttttttttttttttt");
		 	  proposalDTO.setSubdivisionOfficeName(rset.getString(19));
		 	  //Debug.println("<<<<<"+rset.getString(20));
		 	 // Debug.println("<<<<<"+rset.getString(21));
		 	  proposalDTO.setPlan(rset.getString(20));
		 	  Debug.println("tttttttttttttttttt");
		 	  proposalDTO.setWrkType(rset.getString(21));
		 	}
		 	else if( newsubdiv==null || newsubdiv.equals("") || newsubdiv.equals("00"))
		 	{
		 		 Debug.println("tttttttttttttttttt");
		 		// Debug.println(">>>>>>>>"+rset.getString(22));
			 	 // Debug.println(">>>>>>>>>"+rset.getString(23));
			 	 proposalDTO.setPlan(rset.getString(18));
			 	 proposalDTO.setWrkType(rset.getString(19));
		 	}
		 	Debug.println("tttttttttttttttttt lead_habitaion:"+rset.getString("HABITATION_code"));
		 	proposalDTO.setAugsch(rset.getString("aug_workid"));
		 	//proposalDTO.setProoved(rset.getString("approved_under"));
		 	proposalDTO.setHabvalue(rset.getString("HABITATION_Code"));
		 	representativeProposals.add(proposalDTO);
		}
	}
	catch(Exception e)
	{	Debug.writeln("Exception in getRepresentativeProposals DAO : \n" + e.getMessage());			
	}
	finally
	{	
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle){ }
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}
	
	return representativeProposals;
} 

protected ArrayList getDroughtAdminstrativeSanctionList(String proposalId)
		{
			Connection conn = null;
		PreparedStatement ps = null,ps1=null,ps2=null;
		ResultSet rset = null,rset1=null,rset2=null;
		String query="",query1="";
		String newsubdiv="",stype="",substype="";
		
		String scheme=proposalId.substring(6,8);
		
		try
		{
			
			query="select substr(office_code,5,2),source_type_code,subsource_type_code from rws_drought_works_tbl where work_id=?";
			 conn = RwsOffices.getConn();
			 ps = conn.prepareStatement(query);
			 ps.setString(1, proposalId);
			 rset = ps.executeQuery();
			 if (rset.next())
			 {
			 newsubdiv=rset.getString(1);
			 stype=rset.getString(2);
			 substype=rset.getString(3);
			 
			 }
			   
			 	query1 = "SELECT distinct ad.WORK_NAME ,ad.WORK_ID,ad.work_type,ad.sus_code,ad.ADMIN_AMOUNT ,ad.ADMIN_NO,to_char(ad.ADMIN_DATE,'dd/mm/yyyy'),At.TYPE_OF_ASSET_NAME,p.PROGRAMME_Name,"
			 			+ "s.SUBPROGRAMME_NAME,ad.PREPARED_BY ,to_char(ad.PREPARED_ON,'dd/mm/yyyy')as prepared_on ,AD.remarks,ad.office_code,w.CATEGORY_NAME,"
			 			+ "c.circle_office_code,c.circle_office_name,d.division_office_code,d.division_office_name,pl.plan_name,ad.AUG_WORKID,ad.habitation_code,ad.approved_under,TS_NO,"
			 			+ "to_char(TS_DATE,'dd/mm/yyyy') ,TS_AMOUNT,SSR_YEAR,source_hab_code,source_code,source_name,source_location,ASSET_CODE,NEW_EXISTING ,to_char(SITE_HAND_OVER_DATE,'dd/mm/yyyy'),"
			 			+ "to_char(GROUNDING_DATE,'dd/mm/yyyy') ,EXPENDITURE_UPTO  ,to_char(EXPENDITURE_UPTO_DT,'dd/mm/yyyy'),VALUE_OF_WORK_NOT_PAID, to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),"
			 			+ "to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),to_char(DATE_OF_COMM,'dd/mm/yyyy')";
		        if(stype!=null && !stype.equals("") && substype!=null && !substype.equals(""))
			    {
			    query1+=",source_type_name,SUBSOURCE_TYPE_NAME";
			    }
		        if ( newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00")  )
			    {
			    query1+=",sd.subdivision_office_code,sd.subdivision_office_name";
			    }
		        if(stype!=null && !stype.equals("") && substype!=null && !substype.equals("") && newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00"))
			    {
		        	query1+=",source_type_name,SUBSOURCE_TYPE_NAME,sd.subdivision_office_code,sd.subdivision_office_name";
			    }
				query1+=" FROM  rws_drought_works_tbl ad, rws_programme_tbl P,rws_subprogramme_tbl S, rws_asset_type_tbl AT,rws_work_category_tbl w,rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl a, rws_source_type_tbl st ,rws_subsource_type_tbl sst "
						+ "where ad.plan_code=pl.plan_code and w.category_code=ad.category_code and at.TYPE_OF_ASSET_CODE = ad.TYPE_OF_ASSET and  P.PROGRAMME_CODE=ad.PROGRAMME_CODE AND (ad.PROGRAMME_CODE=s.PROGRAMME_CODE  and ad.subprogramme_code=s.subprogramme_code) and work_id='"+proposalId+"' and substr(ad.office_code,2,2)=c.circle_office_code "
						+ "and (substr(ad.office_code,2,2)=d.circle_office_code and substr(ad.office_code,4,1)=d.division_office_code) ";
				if ( newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00")  )
			    { 
					query1+= " and (substr(ad.office_code,2,2)=sd.circle_office_code and substr(ad.office_code,4,1)=sd.division_office_code and  substr(ad.office_code,5,2)=sd.subdivision_office_code) ";
			    }
				if(stype!=null && !stype.equals("") && substype!=null && !substype.equals(""))
			    {
			    	query1+="AND AD.SOURCE_TYPE_CODE=ST.SOURCE_TYPE_CODE AND AD.SUBSOURCE_TYPE_CODE=SST.SUBSOURCE_TYPE_CODE AND AD.SOURCE_TYPE_CODE=SST.SOURCE_TYPE_CODE";
			    }
				if ( newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00") && stype!=null && !stype.equals("") && substype!=null && !substype.equals("")  )
			    {
					query1+= " and (substr(ad.office_code,2,2)=sd.circle_office_code and substr(ad.office_code,4,1)=sd.division_office_code and  substr(ad.office_code,5,2)=sd.subdivision_office_code)AND AD.SOURCE_TYPE_CODE=ST.SOURCE_TYPE_CODE AND AD.SUBSOURCE_TYPE_CODE=SST.SUBSOURCE_TYPE_CODE AND AD.SOURCE_TYPE_CODE=SST.SOURCE_TYPE_CODE ";
			    }
			query1=query1+" order by 19 desc";
			
			Debug.println("Query In Proposal DAO :"+query1);
			conn = RwsOffices.getConn();
			ps1 = conn.prepareStatement(query1);
			rset1 = ps1.executeQuery();
			representativeProposals = new ArrayList();
			
			while(rset1.next())
			{
				proposalDTO = new DroughtDTO();
				
				String sus_name="";
				if(rset1.getString(4)!=null && !rset1.getString(4).equals(""))
				{
					String qry1="select sus_name from rws_sus_id_tbl where sus_code=?";
					ps2 = conn.prepareStatement(qry1);
					ps2.setString(1, rset1.getString(4));
					rset2 = ps2.executeQuery();
					if(rset2.next())
					{
					  sus_name=rset2.getString(1);
					}
				
				}
				else
					sus_name="-";
				
				
				
				proposalDTO.setProposalName(rset1.getString(1));
				proposalDTO.setProposalId(rset1.getString(2));
				proposalDTO.setWorkType(rset1.getString(3));
				proposalDTO.setSusType(sus_name);
				proposalDTO.setSanctionedAmount(rset1.getString(5)); 
				proposalDTO.setAdminNo(rset1.getString(6)); 
				proposalDTO.setAdminDate(rset1.getString(7));
				proposalDTO.setTypeOfAsset(rset1.getString(8));
				proposalDTO.setProgrammeName(rset1.getString(9));
				proposalDTO.setSubprogrammeName(rset1.getString(10));
				proposalDTO.setPreparedBy(rset1.getString(11));
				proposalDTO.setPreparedOn(rset1.getString(12));
				proposalDTO.setRemarks(rset1.getString(13));
				proposalDTO.setOfficeCode(rset1.getString(14));
				proposalDTO.setWorkCat(rset1.getString(15));
				proposalDTO.setCircleOfficeCode(rset1.getString(16));
				proposalDTO.setCircleOfficeName(rset1.getString(17));
				proposalDTO.setDivisionOfficeCode(rset1.getString(18));
			 	proposalDTO.setDivisionOfficeName(rset1.getString(19));
			 	proposalDTO.setPlan(rset1.getString(20));
			 	proposalDTO.setWrkType(rset1.getString(21)); 
			 	proposalDTO.setNoOfHabs(rset1.getString(22));
			 	proposalDTO.setProoved(rset1.getString(23));
			 	proposalDTO.setTsno(rset1.getString(24));
			 	proposalDTO.setTsdate(rset1.getString(25));
			 	proposalDTO.setTsamt(rset1.getString(26));
			 	proposalDTO.setSsryr(rset1.getString(27));
			 	proposalDTO.setSrhabcode(rset1.getString(28));		 	
			 	proposalDTO.setScrcode(rset1.getString(29));
			 	proposalDTO.setSrname(rset1.getString(30));
			 	proposalDTO.setSrloc(rset1.getString(31));
			 	proposalDTO.setAstcode(rset1.getString(32));
			 	if(rset1.getString(32)!=null)
			 	{
			 	proposalDTO.setNewext(rset1.getString(33));
			 	}
			 	else
			 	{
			 		proposalDTO.setNewext("N");
			 	}
			 	proposalDTO.setSitedate(rset1.getString(34));
			 	proposalDTO.setGrounddate(rset1.getString(35));
			 	proposalDTO.setExpupto(rset1.getString(36));
			 	proposalDTO.setExpuptodate(rset1.getString(37));
				proposalDTO.setNotpaidvalue(rset1.getString(38));
				proposalDTO.setCompdate(rset1.getString(39));
				proposalDTO.setFincompdate(rset1.getString(40));
				proposalDTO.setCommdate(rset1.getString(41));
				if(stype!=null && !stype.equals("") && substype!=null && !substype.equals(""))
			    {
			 	proposalDTO.setSrtypecode(rset1.getString(42));
			 	proposalDTO.setSubsrtypecode(rset1.getString(43));
			    }
				if( newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00")  )
			    {
			 	proposalDTO.setSubdivisionOfficeCode(rset1.getString(42));
			 	proposalDTO.setSubdivisionOfficeName(rset1.getString(43)); 
			 	Debug.println("proposalDTO.setSubdivisionOfficeName"+proposalDTO.getSubdivisionOfficeName());
			    }
				if(stype!=null && !stype.equals("") && substype!=null && !substype.equals("") &&  newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00") )
			    {
					proposalDTO.setSrtypecode(rset1.getString(42));
				 	proposalDTO.setSubsrtypecode(rset1.getString(43));
				 	proposalDTO.setSubdivisionOfficeCode(rset1.getString(44));
				 	proposalDTO.setSubdivisionOfficeName(rset1.getString(45)); 
			    }
				
				
			 	representativeProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getRepresentativeProposals DAO : \n" + e.getMessage());	
		    e.printStackTrace();
		}
		finally
		{	
			if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){ }
			}
			if(ps != null)
			{	try
				{	ps.close();
				}
				catch(SQLException sqle){ }
			}
			if(rset1 != null)
			{	try
				{	rset1.close();
				}
				catch(SQLException sqle){ }
			}
			if(ps1 != null)
			{	try
				{	ps1.close();
				}
				catch(SQLException sqle){ }
			}
			if(conn != null)
			{	try
				{	conn.close();
				}
				catch(SQLException sqle){ }
			}
		}
		Debug.println("representativeProposals.size() in ProposalDAO(): " + representativeProposals.size());
		return representativeProposals;
		
} 




public String[] getSelectedHabitationsForAdminStrative1(String proposalId,String tabName,int size)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
String schemecode=proposalId.substring(6,8);
//Debug.println("scheme code is::::::::::::::::"+schemecode);
	ArrayList habs = new ArrayList();
	String[] habcodes=new String[size];
	try
	{
		if(!(schemecode.equals("11")|| schemecode.equals("12")))
		{
		query = " SELECT distinct PR.panch_code, PR.panch_name, "
			  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
			  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
			  + " rws_habitation_directory_tbl HD, rws_drought_works_tbl HL "
			  + " WHERE PR.panch_code = HL.habitation_code "
			  + " AND PR.panch_code = HD.hab_code "
			  + " AND HL.work_id ='" +  proposalId + "'";
		}else if(schemecode.equals("11"))
		{
			query =	" select s.hab_code,s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE  from "
			  + " rws_school_master_tbl s, rws_work_school_lnk_tbl  HL "
			  + " WHERE s.school_code = HL.school_code "
			  + " and s.hab_code=hl.hab_code  "
			  + " and work_id='"+proposalId+"'";
	    }
		else if(schemecode.equals("12"))
	    {
		query =	"SELECT  a.LAB_CODE,a.lab_name,location FROM  rws_water_quality_lab_tbl a, RWS_WORK_LAB_LNK_TBL b WHERE   a.lab_code=b.lab_code and  WORK_ID='"+proposalId+"'" ;
	    }
						
		//Debug.println("Query is in get Habs2:"+query);
		
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
	 	RwsLocationBean rwsLocationBean = null;
		int i=0;
		while(rset.next())
		{	
		try{
			
			if(rset.getString(1)!=null)
			{
			//	Debug.println("connected to ..."+i+"**"+rset.getString(1));
			 habcodes[i]=rset.getString(1);
			i++;
			}
			
		}
		catch(Exception e)
		{
			Debug.println("Exception "+e);
		}
			
		}
	//	Debug.println("habcode lenght is :"+habcodes.length);
		//insertProposalTempHabsForAdmin(proposalId,habcodes,tabName);
	}
	catch(Exception e)
	{	Debug.writeln("Exception in getSelectedHabitations for getSelectedHabitationsForAdminStrative  :\n" + e);			
	}
	finally
	{	if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle){ }
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle){ }
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle){ }
		}
	}
	return habcodes;
}
public ArrayList getMandals(String circlecode) throws Exception
{
	Debug.println("trying to get the mandals.....");
	ArrayList mtenderMemo = null;
	String query = null;
	Connection conn = null;
	Statement stat = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	
	try
	{  
		conn = RwsOffices.getConn();
		query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL  a,RWS_DROUGHT_FLUSH_DEEPEN_TBL b WHERE  a.dcode=substr(b.habitation_code,1,2) and a.mcode=substr(b.habitation_code,6,2)  " +
		 "  and substr(b.habitation_code,1,2)='"+circlecode+"' ORDER BY MNAME";
		stat = conn.createStatement();
		rs = stat.executeQuery(query);
		Debug.println("Query:"+query);
		LabelValueBean dto = null;
		mtenderMemo = new ArrayList();
			while (rs.next())
			{   dto = new LabelValueBean();
				dto.setValue(rs.getString(2));
				dto.setLabel(rs.getString(3));
				mtenderMemo.add(dto);
	 			
			}
	}
	catch (Exception e)
	{
		Debug.println("The error in getMandals()=== "+e);
	}
	finally 
	{
		if(rs!=null)rs.close();
		if(stat!=null)stat.close();
		if(conn!=null)conn.close();
	}
	Debug.println("3.5:"+mtenderMemo.size());
	return mtenderMemo;
}

public ArrayList SubCompType()
	{
	Connection conn = null;
	Statement stat = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	Debug.println("------------in geting all source types--------------------");
	ArrayList ntenderMemo = null;
	try
	{
		conn = RwsOffices.getConn();
		// Debug.println("asset code:"+assetCode);
		query = "SELECT * FROM RWS_SOURCE_TYPE_TBL where SOURCE_TYPE_CODE='1'";
		Debug.println(query);
		stat = conn.createStatement();
		rs = stat.executeQuery(query);
		LabelValueBean dto = null;
		ntenderMemo = new ArrayList();
		
			while (rs.next())
			{
				dto = new LabelValueBean();			
				dto.setValue(rs.getString(1));
				dto.setLabel(rs.getString(2));
				ntenderMemo.add(dto);
			}
		
	}
	catch (Exception e)
	{
		Debug.println("Exception SubCompType:"+e);
	}
	finally
	{
		try
		  {
			if(rs!=null)rs.close();
			if(stat!=null)stat.close();
			if(conn!=null)conn.close();
		  }
		catch(Exception e)
		{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
	}
	return ntenderMemo;
}



public String SubCompTypeName(String scode)
{
Connection conn = null;
Statement stat = null;
ResultSet rs = null;
PreparedStatement ps = null;
Debug.println("------------in geting all source types--------------------");
String sourceName = null;
try
{
	conn = RwsOffices.getConn();
	Debug.println("asset code:"+scode);
	query = "SELECT SOURCE_TYPE_NAME FROM RWS_SOURCE_TYPE_TBL where SOURCE_TYPE_CODE='"+scode+"' ";
	Debug.println(query);
	stat = conn.createStatement();
	rs = stat.executeQuery(query);
	LabelValueBean dto = null;
	
		while (rs.next())
		{
			sourceName=rs.getString(1);
		}
	
}
catch (Exception e)
{
	Debug.println("Exception SubCompType:"+e);
}
finally
{
	try
	  {
		if(rs!=null)rs.close();
		if(stat!=null)stat.close();
		if(conn!=null)conn.close();
	  }
	catch(Exception e)
	{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
}
return sourceName;
}


public String getSourceValue(String sname)
{
Connection conn = null;
Statement stat = null;
ResultSet rs = null;
PreparedStatement ps = null;
Debug.println("------------hai  iam getting code for name--------------------");
String sourceCode = null;
try
{
	conn = RwsOffices.getConn();
	Debug.println("asset code:"+sname);
	query = "SELECT SOURCE_TYPE_code FROM RWS_SOURCE_TYPE_TBL where SOURCE_TYPE_name='"+sname+"' ";
	Debug.println(query);
	stat = conn.createStatement();
	rs = stat.executeQuery(query);
	LabelValueBean dto = null;
	
		while (rs.next())
		{
			sourceCode=rs.getString(1);
		}
	
}
catch (Exception e)
{
	Debug.println("Exception SubCompType:"+e);
}
finally
{
	try
	  {
		if(rs!=null)rs.close();
		if(stat!=null)stat.close();
		if(conn!=null)conn.close();
	  }
	catch(Exception e)
	{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
}
return sourceCode;
}
public ArrayList SiteHab1(String circlecode, String divisioncode,String subdivisioncode,String mandalCode)
	{ Connection conn = null;
	  Statement stmt = null;
	  ResultSet rset = null;
	  PreparedStatement ps = null;
	  Debug.println("trying to get the site habitations mandal........");
	//Debug.println("mandalcode"+mandalCode);
	ArrayList ntenderMemo = null;
	try
	{
		conn = RwsOffices.getConn();
		stmt = conn.createStatement();
	    query = " SELECT  distinct P.panch_code, P.panch_name FROM rws_panchayat_raj_tbl P, "
			  + " rws_habitation_directory_tbl H,rws_habitation_directory_tbl hd,rws_mandal_tbl m,RWS_DROUGHT_FLUSH_DEEPEN_TBL f " 
			  +	" WHERE hd.hab_code=p.panch_code and hd.hab_code=h.hab_code and P.panch_code = H.hab_code AND f.habitation_code=p.panch_code and "
			  + " H.circle_office_code = '" + circlecode + "' and substr(p.panch_code,6,2)='" + mandalCode + "'  and h.circle_office_code=m.dcode and m.mcode='"+mandalCode+"' and hd.coverage_status <> 'UI' and hd.coverage_status is not null"
			  + " order by P.panch_name";
		rset = stmt.executeQuery(query);
		Debug.println("Habitation actual query"+query);
		LabelValueBean dto = null;
		ntenderMemo = new ArrayList();
		while (rset.next())
		{   dto = new LabelValueBean();
			dto.setValue(rset.getString(1));
			dto.setLabel(rset.getString(1)+"-"+rset.getString(2));
			ntenderMemo.add(dto);
		}
	
	}
	catch (Exception e)
	{
		Debug.println("Exception SiteHabs:"+e);
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
	
	return ntenderMemo;
}

public ArrayList getSubSourceTypes(String subSourceCode,String assetCode)
{       Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		PreparedStatement ps = null;

	Debug.println("------------in geting all subcompTypes--------------------");
	ArrayList ntenderMemo = null;
	try
	{   conn = RwsOffices.getConn();
		query = "SELECT * FROM RWS_SUBSOURCE_TYPE_TBL where source_type_code="+subSourceCode+" and  SUBSOURCE_TYPE_CODE not in(2,3) order by SUBSOURCE_TYPE_CODE";
		Debug.println(query);
		stmt = conn.createStatement();
		rset = stmt.executeQuery(query);
		LabelValueBean dto = null;
		ntenderMemo = new ArrayList();
		while (rset.next())
			{   
				dto = new LabelValueBean();
				dto.setValue(rset.getString(2));
				dto.setLabel(rset.getString(3));
				
				ntenderMemo.add(dto);
			}
				
		dto = new LabelValueBean();
		dto.setValue("5");
		dto.setLabel("Sources");
		
		ntenderMemo.add(dto);
	
	}
	catch (Exception e)
	{
		Debug.println("Exception SubCompType:"+e);
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
	return ntenderMemo;
}


public String SubSourceCompTypeName(String subSourceCode,String subsourcetypecode )
{       Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		PreparedStatement ps = null;

	Debug.println("------------in geting all subcompTypes--------------------");
	String SubSourceCompName = null;
	try
	{   conn = RwsOffices.getConn();
		query = "SELECT SUBSOURCE_TYPE_NAME FROM RWS_SUBSOURCE_TYPE_TBL where source_type_code="+subSourceCode+"  and SUBSOURCE_TYPE_CODE ='"+subsourcetypecode+"' ";
		Debug.println(query);
		stmt = conn.createStatement();
		rset = stmt.executeQuery(query);
			while (rset.next())
			{   
				SubSourceCompName=rset.getString(1);
			}
	}
	catch (Exception e)
	{
		Debug.println("Exception SubCompType:"+e);
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
	return SubSourceCompName;
}


public String getSubSourceValue(int Sourcename,String SubSourceName )
{       Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		PreparedStatement ps = null;

	Debug.println("------------in geting all subcompTypes--------------------");
	String SubSourceCompValue = null;
	try
	{   conn = RwsOffices.getConn();
		query = "SELECT SUBSOURCE_TYPE_Code FROM RWS_SUBSOURCE_TYPE_TBL where source_type_code="+Sourcename+"  and SUBSOURCE_TYPE_name ='"+SubSourceName+"' ";
		Debug.println(query);
		stmt = conn.createStatement();
		rset = stmt.executeQuery(query);
			while (rset.next())
			{   
				SubSourceCompValue=rset.getString(1);
			}
	}
	catch (Exception e)
	{
		Debug.println("Exception SubCompType:"+e);
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
	return SubSourceCompValue;
}


public ArrayList getSourceDetails(String shcode,String srcode,String ssrcode)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	ArrayList sourceDetails = new ArrayList();
	
	String tableName="";
	try
	{
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		
		
		System.out.println("Surface Code:"+srcode);
		System.out.println("Subsurface Code:"+ssrcode);
		String query ="";
				if(srcode.equals("1") && ssrcode.equals("1")){
					tableName="rws_hp_subComp_param_tbl";
					 query = "Select hp_code,nvl(location,'-'),nvl(location,'-') from "+tableName+" where substr(hp_code,1,16)='"+shcode+"'";
				}else if(srcode.equals("1") && ssrcode.equals("4")){
					tableName="rws_open_well_mast_tbl";
					 query = "Select OPENWELL_CODE,nvl(location,'-'),nvl(location,'-') from "+tableName+" where substr(OPENWELL_CODE,1,16)='"+shcode+"'";
				}else {
					tableName="RWS_SOURCE_TBL";
					 query = "Select SOURCE_CODE ,nvl(location,'-'),nvl(SOURCE_NAME,'-') from "+tableName+" where substr(SOURCE_CODE,1,16)='"+shcode+"'";
				}
			
						 
			Debug.println("Query is "+query);
			rset = stat.executeQuery(query);
			DroughtDTO dto = null; 
			while(rset.next())
			{
				dto = new DroughtDTO();
				dto.setSouCode(rset.getString(1));
				dto.setSouName(rset.getString(2));
				dto.setSouLocation(rset.getString(3));
				sourceDetails.add(dto);
			}
			
	}
	catch(Exception e)
	{	Debug.println("Exception in getTempSelectedHabsForAdminSanc2() : " + e);
		
	}
	finally
	{
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	return sourceDetails;
}



public String getSourceCode(String sourceType,String habCode,String workId) throws Exception
{   Connection conn = null;
	Statement stmt = null;
	ResultSet rset = null;
	PreparedStatement ps = null;
	RwsMaster rwsMaster = null;
	String formed_source_code="";
	SubCompMetaData subCompMetaData=new SubCompMetaData(sourceType.substring(0,2),sourceType.substring(4,5),sourceType.substring(5,6),habCode);
	try {
		String compCode = subCompMetaData.getSubCompRep();
		String insertTable = subCompMetaData.getTableName();
		String schemeCodeField = subCompMetaData.getSchemeCodeField();
		conn = RwsOffices.getConn();
		stmt = conn.createStatement();
		String query="select CODE_SERIES from RWS_ASSET_TYPE_TBL where TYPE_OF_ASSET_CODE='"+sourceType.substring(0,2)+"'";
		Debug.println("Query :::::"+query);
		ResultSet rs = stmt.executeQuery(query);
		String schemeCode = "";
		if(rs.next())
		{
			schemeCode = rs.getString(1);
		}
		Debug.println("Schemee COde:"+schemeCode);
		Debug.println("Table Name:"+insertTable);
		if(stmt!=null)stmt.close();
		stmt = conn.createStatement();
		query = "select "+schemeCodeField+" from "+insertTable+" where hab_code like '"+habCode+"%' order by substr("+schemeCodeField+",22,3)";
		Debug.println("get data:"+query);
		rs = stmt.executeQuery(query);
		String maxCode = "";
		while(rs.next())
		{
			maxCode = rs.getString(1);
		}
		Debug.println("Max Code:"+maxCode);
		int slno = 001;
		if(maxCode != null && maxCode.length() != 0 && maxCode.length() == 24)
		{
			slno = Integer.parseInt(maxCode.substring(21,24));
			slno++; 
		}
		String temp = ""+slno;
		String finalSlNo="";
		if(temp.length() == 1)
		{
			finalSlNo = "00"+temp;
		}
		else if(temp.length() == 2)
		{
			finalSlNo = "0"+temp;
		}
		else if(temp.length() == 3)
		{
			finalSlNo = temp;
		}
		Debug.println("Sl No:"+slno);
		Debug.println("Final Sl No:"+finalSlNo);
		formed_source_code = habCode+schemeCode+compCode+finalSlNo;
		Debug.println("formed_source_code:"+formed_source_code);
	}   catch (Exception e) {
		Debug.println("Exception is getSourceCodes:"+e.getMessage());
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
	return formed_source_code;
}

public ArrayList getCircles(String headOfficeCode,String circleOfficeCode) throws Exception
{   Connection conn = null;
	Statement stmt = null;
	ResultSet rset = null;
	PreparedStatement ps = null;
	Debug.println("in getCircles with HOD:"+headOfficeCode+circleOfficeCode);
	ArrayList circles = new ArrayList();
	try
	{
		conn = rwsOffices.getConn();
		query = " SELECT circle_office_code, circle_office_name "
			  + " FROM rws_circle_office_tbl "
			  + " WHERE head_office_code = ? and circle_office_code= ? "
			  + " ORDER BY circle_office_name";
					 
		//stat = conn.createStatement();
		Debug.println("query in getCircles is "+query);
		ps = conn.prepareStatement(query);
		ps.setString(1,headOfficeCode);
		ps.setString(2,circleOfficeCode);
		rset = ps.executeQuery();
		//rset = stat.executeQuery(query);
					
		while(rset.next())
		{
			LabelValueBean  dto= new LabelValueBean();
			dto.setValue(rset.getString(1));
			dto.setLabel(rset.getString(2));
			dto.setLabelValue(rset.getString(2)+" - " + rset.getString(1));
			circles.add(dto);
		}
	}
	catch (Exception e) {
		Debug.println("Exception is getSourceCodes:"+e.getMessage());
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
	
	return circles;
}

public ArrayList getAllAssetTypes() throws Exception
{    Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		PreparedStatement ps = null;
	ArrayList assets = new ArrayList();
	try
	{

		conn=rwsOffices.getConn();
		stat=conn.createStatement();
		rset=stat.executeQuery("select * from rws_asset_type_tbl order by type_of_asset_code ");
		while(rset.next())
		{
			LabelValueBean dto=new LabelValueBean();
			dto.setValue(rset.getString(1));
			dto.setLabel(rset.getString(2));
			assets.add(dto);
		}
	
	}
	catch(Exception e){nic.watersoft.commons.Debug.println("Exception in get all assets is "+e);}
	finally
	{
		try
		  {
			if(rset!=null)rset.close();
			if(stat!=null)stat.close();
			if(conn!=null)conn.close();
		  }
		catch(Exception e)
		{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
	}
	return assets;
}


public ArrayList getDroughtWorksList(String dcode,String expyear,String scheme,Rws_Drought_Admin_Sanction_Frm myForm,String divCode,String subDivCode,String mcode,String habcode) throws Exception
{   Connection conn = null;
	
	ResultSet rset = null;
	PreparedStatement ps = null;
	
	ArrayList works = new ArrayList();
	try
	{
		
		conn=rwsOffices.getConn();
		
		int ey = 0;
		
		String qry = "";
		if(!expyear.equals("<1970") && !expyear.equals("ALL"))
		{
			qry = "select work_id,division_office_name,subdivision_office_name,work_name,admin_no,sanction_amount,to_char(admin_date,'dd/mm/yy') as admin_date,LEAD_HABITATION from rws_work_admn_tbl w,rws_division_office_tbl d,rws_subdivision_office_tbl sd where d.circle_office_code=?";
			qry += " and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and substr(office_code,4,1)=d.division_office_code and substr(office_code,5,2)=sd.subdivision_office_code and substr(work_id,5,2)=? and substr(work_id,7,2)=?  and to_char(admin_date,'yyyy')=? and admin_date is not null";
			if(divCode!=null && !divCode.equals(""))qry += " and d.division_office_code=?";
			if(subDivCode!=null && !subDivCode.equals(""))qry += " and sd.subdivision_office_code=? and lead_habitation=?";
			
		}
		else if(!expyear.equals("ALL"))
		{
			qry = "select work_id,division_office_name,subdivision_office_name,work_name,admin_no,sanction_amount,to_char(admin_date,'dd/mm/yy') as admin_date,LEAD_HABITATION from rws_work_admn_tbl w,rws_division_office_tbl d,rws_subdivision_office_tbl sd where d.circle_office_code=?";
			qry += " and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and substr(office_code,4,1)=d.division_office_code and substr(office_code,5,2)=sd.subdivision_office_code and substr(work_id,5,2)=? and substr(work_id,7,2)=?  and to_char(admin_date,'yyyy')<'1970' and admin_date is not null";
			if(divCode!=null && !divCode.equals(""))qry += " and d.division_office_code=?";
			if(subDivCode!=null && !subDivCode.equals(""))qry += " and sd.subdivision_office_code=? and lead_habitation=?";
			
		}
		else
		{
			qry = "select work_id,division_office_name,subdivision_office_name,work_name,admin_no,sanction_amount,to_char(admin_date,'dd/mm/yy') as admin_date,LEAD_HABITATION from rws_work_admn_tbl w,rws_division_office_tbl d,rws_subdivision_office_tbl sd where d.circle_office_code=?";
			qry += " and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and substr(office_code,4,1)=d.division_office_code and substr(office_code,5,2)=sd.subdivision_office_code and substr(work_id,5,2)=? and substr(work_id,7,2)=? and admin_date is not null";
			if(divCode!=null && !divCode.equals(""))qry += " and d.division_office_code=?";
			if(subDivCode!=null && !subDivCode.equals(""))qry += " and sd.subdivision_office_code=? and lead_habitation=?";
			
		}
		qry += " and aug_new_code='1' order by division_office_name,subdivision_office_name";
		System.out.println(qry);
		ps=conn.prepareStatement(qry);
		if(!expyear.equals("<1970") && !expyear.equals("ALL"))
		{
			ps.setString(1, dcode);
			ps.setString(2, dcode);
			ps.setString(3, scheme);
			ps.setString(4, expyear);
			
			if(divCode!=null && !divCode.equals(""))
				ps.setString(5, divCode);
			if(subDivCode!=null && !subDivCode.equals("")){
				ps.setString(6, subDivCode);
				ps.setString(7, habcode);
			}
		}
		else if(!expyear.equals("ALL"))
		{
			ps.setString(1, dcode);
			ps.setString(2, dcode);
			ps.setString(3, scheme);
			
			if(divCode!=null && !divCode.equals(""))
				ps.setString(4, divCode);
			if(subDivCode!=null && !subDivCode.equals("")){
				ps.setString(5, subDivCode);
				ps.setString(6, habcode);
			}
		}
		else
		{
			ps.setString(1, dcode);
			ps.setString(2, dcode);
			ps.setString(3, scheme);
			
			if(divCode!=null && !divCode.equals(""))
				ps.setString(4, divCode);
			if(subDivCode!=null && !subDivCode.equals("")){
				ps.setString(5, subDivCode);
				ps.setString(6, habcode);
			}
		}
		
		rset=ps.executeQuery();
		Statement stata = conn.createStatement();
		while(rset.next())
		{
			myForm = new Rws_Drought_Admin_Sanction_Frm();
			myForm.setWorkid(rset.getString("work_id"));
			myForm.setTypeOfAsset("WORK");
			myForm.setDivisionOfficeName(rset.getString("division_office_name"));
			myForm.setSubdivisionOfficeName(rset.getString("subdivision_office_name"));
			myForm.setWorkname(rset.getString("work_name"));
			myForm.setAdmin_no(rset.getString("ADMIN_NO"));
			myForm.setAdmin_amount(rset.getString("SANCTION_AMOUNT"));
			myForm.setLocation("-");
			myForm.setAdmin_date(rset.getString("ADMIN_DATE"));
			
			String[] list = getWorkLeadHabMandalName(rset.getString("LEAD_HABITATION"),stata);
		
			myForm.setMandal(list[0]);
			myForm.setHabCode(list[1]);
			myForm.setRepAddress(list[2]);
			myForm.setRepName(list[3]);
			works.add(myForm);
		}
		if(!expyear.equals("<1970") && !expyear.equals("ALL"))
		{
			qry = "select a.asset_code,division_office_name,subdivision_office_name,to_char(a.date_creation,'dd/mm/yy') as date_creation,nvl(a.start_year,'-') as start_year,nvl(a.asset_name,'-') as asset_name,nvl(a.asset_cost,'0') as asset_cost,HAB_CODE,nvl(location,'-') as location from rws_asset_mast_tbl a,rws_division_office_tbl d,rws_subdivision_office_tbl sd where   a.circle_office_code=?";
			qry += " and a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.subdivision_office_code=sd.subdivision_office_code and  a.type_of_asset_code=?  and to_char(a.date_creation,'yyyy')=?  and a.date_creation  is not null";
			if(divCode!=null && !divCode.equals(""))qry += " and d.division_office_code=?";
			if(subDivCode!=null && !subDivCode.equals(""))qry += " and sd.subdivision_office_code=? and hab_code=?";
			
			
		}
		else if(!expyear.equals("ALL"))
		{
			qry = "select a.asset_code,division_office_name,subdivision_office_name,to_char(a.date_creation,'dd/mm/yy') as date_creation,nvl(a.start_year,'-') as start_year,nvl(a.asset_name,'-') as asset_name,nvl(a.asset_cost,'0') as asset_cost,HAB_CODE,nvl(location,'-') as location from rws_asset_mast_tbl a,rws_division_office_tbl d,rws_subdivision_office_tbl sd where   a.circle_office_code=?";
			qry += " and a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.subdivision_office_code=sd.subdivision_office_code and  a.type_of_asset_code=?  and to_char(a.date_creation,'yyyy') <1970 and a.date_creation  is not null";
			if(divCode!=null && !divCode.equals(""))qry += " and d.division_office_code=?";
			if(subDivCode!=null && !subDivCode.equals(""))qry += " and sd.subdivision_office_code=? and hab_code=?";
			
			
		}
		else
		{
			qry = "select a.asset_code,division_office_name,subdivision_office_name,to_char(a.date_creation,'dd/mm/yy') as date_creation,nvl(a.start_year,'-') as start_year,nvl(a.asset_name,'-') as asset_name,nvl(a.asset_cost,'0') as asset_cost,HAB_CODE,nvl(location,'-') as location from rws_asset_mast_tbl a,rws_division_office_tbl d,rws_subdivision_office_tbl sd where   a.circle_office_code=?";
			qry += " and a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.subdivision_office_code=sd.subdivision_office_code and  a.type_of_asset_code=? and a.date_creation  is not null";
			if(divCode!=null && !divCode.equals(""))qry += " and d.division_office_code=?";
			if(subDivCode!=null && !subDivCode.equals(""))qry += " and sd.subdivision_office_code=? and hab_code=?";
		}
		qry += " order by division_office_name,subdivision_office_name";			
		System.out.println(qry);
		rset.close();ps.close();
		ps=conn.prepareStatement(qry);
		if(!expyear.equals("<1970") && !expyear.equals("ALL"))
		{
			ps.setString(1, dcode);
			ps.setString(2, scheme);
			ps.setString(3, expyear);
			
			if(divCode!=null && !divCode.equals(""))
				ps.setString(4, divCode);
			if(subDivCode!=null && !subDivCode.equals("")){
				ps.setString(5, subDivCode);
				ps.setString(6, habcode);
			}
		}
		else if(!expyear.equals("ALL"))
		{
			ps.setString(1, dcode);
			ps.setString(2, scheme);
			
			if(divCode!=null && !divCode.equals(""))
				ps.setString(3, divCode);
			if(subDivCode!=null && !subDivCode.equals("")){
				ps.setString(4, subDivCode);
				ps.setString(5, habcode);
			}
		}
		else
		{
			ps.setString(1, dcode);
			ps.setString(2, scheme);
			
			if(divCode!=null && !divCode.equals(""))
				ps.setString(3, divCode);
			if(subDivCode!=null && !subDivCode.equals("")){
				ps.setString(4, subDivCode);
				ps.setString(5, habcode);
			}
		}
		
		rset=ps.executeQuery();
			
		Statement statb = conn.createStatement();
		
		while(rset.next())
		{
			
			myForm = new Rws_Drought_Admin_Sanction_Frm();
			myForm.setWorkid(rset.getString("asset_code"));
			myForm.setTypeOfAsset("ASSET");
			myForm.setDivisionOfficeName(rset.getString("division_office_name"));
			myForm.setSubdivisionOfficeName(rset.getString("subdivision_office_name"));
			myForm.setWorkname(rset.getString("asset_name"));
			myForm.setAdmin_no(rset.getString("start_year"));
            myForm.setAdmin_date(rset.getString("date_creation"));
			myForm.setAdmin_amount(rset.getString("asset_cost"));
			myForm.setLocation(rset.getString("location"));
			try
			{
				String[] list = getWorkLeadHabMandalName(rset.getString("HAB_CODE"),statb);
				myForm.setMandal(list[0]);
				myForm.setHabCode(list[1]);
				myForm.setRepAddress(list[2]);
				myForm.setRepName(list[3]);
			}
			catch(Exception e)
			{
				Debug.println("Exception in getDroughtWorksList"+e.getMessage());
			}
			works.add(myForm);
			
		}
	
	}
	catch(Exception e){Debug.println("Exception in getDroughtWorksList "+e);
	
	}
	finally
	{
		try
		  {
			if(rset!=null)rset.close();
			if(ps!=null)ps.close();
			if(conn!=null)conn.close();
		  }
		catch(Exception e)
		{Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());}
	}
	return works;
}
public String[] getWorkLeadHabMandalName(String leadHabCode,Statement stats)
{
	String[] list = new String[4];
	Connection conn = null;	
	ResultSet rss = null;
	PreparedStatement ps = null;	
	ArrayList works = new ArrayList();
	try
	{
		
		conn=rwsOffices.getConn();
		String qry = "select mname,pname,panch_code,panch_name from rws_mandal_tbl a,rws_panchayat_tbl p,rws_panchayat_raj_tbl b where substr(b.hab_code,1,2)=a.dcode  and substr(b.hab_code,6,2)=a.mcode and a.mcode=p.mcode and substr(b.hab_code,13,2)=p.pcode and a.dcode=p.dcode and b.panch_code=?";
		ps=conn.prepareStatement(qry);
		ps.setString(1, leadHabCode);
		rss=ps.executeQuery();
		if(rss.next())
		{
			list[0] = rss.getString(1);
			list[1] = rss.getString(3);
			list[2] = rss.getString(4);
			list[3] = rss.getString(2);
		}
		else
		{
			list[0] = "-";
			list[1] = "-";
			list[2] = "-";
			list[3] = "-";
		}
	}
	catch(Exception e)
	{
		Debug.println("ERROR IN GETTING getWorkLeadHabMandalName:"+e.getMessage());
	}
	finally
		{	if(rss != null)
			{	try
				{	rss.close();
				}
				catch(SQLException sqle){
				}
			}
			if(ps != null)
			{	try
				{	ps.close();
				}
				catch(SQLException sqle){
				}
			}
			if(conn != null)
			{	try
				{	conn.close();
				}
				catch(SQLException sqle){
				}
			}
}
	return list;
}

public boolean saveAddminWorkIdAddedProgs2(DataSource dataSource,ArrayList addedPorgs,String workId,String Stat)throws Exception 
{
	boolean status=true;
	Connection conn=null;
	try
	{
		conn=RwsOffices.getConn();
		Statement stmt=conn.createStatement();
		conn.setAutoCommit(false);
		String query;
		Debug.println("entering while loop");
		if(addedPorgs.size()==0)
		{
			 query="DELETE FROM RWS_WORK_ADMN_PROG_LNK_TBL WHERE WORK_ID='"+workId+"'";
			 Debug.println("query is "+query);
			 stmt.addBatch(query)	;
			 
		}
		for(int i=0;i<addedPorgs.size();i++)
		{
			Debug.println("in while");
			ProposalHolder ph=new ProposalHolder();
			ph=(ProposalHolder)addedPorgs.get(i);
			if(Stat!=null)
			{
				if(i==0)
				{
					 query="DELETE FROM RWS_WORK_ADMN_PROG_LNK_TBL WHERE WORK_ID='"+workId+"'";
					 Debug.println("query is "+query);
					 stmt.addBatch(query)	;
				}
			 	query="INSERT INTO RWS_WORK_ADMN_PROG_LNK_TBL(WORK_ID ,PROGRAMME_CODE ,SUB_PROGRAMME_CODE ,ADMIN_NO ,ADMIN_DATE ,SANCTION_AMOUNT )" +
				"VALUES('"+workId+"','"+ph.getProgrammeCode()+"','"+ph.getSubprogrammeCode()+"','"+ph.getAdminiStrativeNum()+"'," +
				"to_date('"+ph.getAdminiStrativeDate()+"','dd/mm/yyyy'),'"+ph.getSanctionAmout()+"')";
				Debug.println("query is "+query);
			 	stmt.addBatch(query);
			}
		    else
		    {
			    Debug.println("in else");
		    	/*
		    	query="INSERT INTO RWS_WORK_ADMN_PROG_LNK_TEMP(WORK_ID ,PROGRAMME_CODE ,SUB_PROGRAMME_CODE ,ADMIN_NO ,ADMIN_DATE ,SANCTION_AMOUNT )" +
				"VALUES('"+workId+"','"+ph.getProgrammeCode()+"','"+ph.getSubprogrammeCode()+"','"+ph.getAdminiStrativeNum()+"'," +
				"to_date('"+ph.getAdminiStrativeDate()+"','dd/mm/yyyy'),'"+ph.getSanctionAmout()+"')";
				stmt.addBatch(query);
				*/
			 }
			
		}
		int value[]=stmt.executeBatch();
 		if(status)
		{ 
			conn.commit();
		}
	}
	catch(Exception e)
	{   status=false;
		Debug.println("Exception"+e);
	}
	finally
	{
		conn.close();
	}
	return status;
}

public ArrayList saveAddminWorkIdAddedProgsToSession(HttpSession session,DataSource dataSource,ArrayList addedPorgs,String workId)throws Exception 
{
		ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
		if(rwsWorkAdmnProgLnkTmp==null)
			rwsWorkAdmnProgLnkTmp=new ArrayList();
		for(int i=0;i<addedPorgs.size();i++)
		{
			ProposalHolder ph;
			ProposalHolder newHolder=new ProposalHolder();
			/*
			RwsWorkAdmnProgLnkTmpBean rwsWorkAdmnProgLnkTmpBean=new RwsWorkAdmnProgLnkTmpBean();
			ph=(ProposalHolder)addedPorgs.get(i);
			rwsWorkAdmnProgLnkTmpBean.setWorkId(workId);
			rwsWorkAdmnProgLnkTmpBean.setProgrammeCode(ph.getProgrammeCode());
			rwsWorkAdmnProgLnkTmpBean.setSubprogrammeCode(ph.getSubprogrammeCode());
			rwsWorkAdmnProgLnkTmpBean.setAdminiStrativeNum(ph.getAdminiStrativeNum());
			rwsWorkAdmnProgLnkTmpBean.setAdminiStrativeDate(ph.getAdminiStrativeDate());
			rwsWorkAdmnProgLnkTmpBean.setSanctionAmout(ph.getSanctionAmout());
			rwsWorkAdmnProgLnkTmp.add(rwsWorkAdmnProgLnkTmpBean);
			*/
			ph=(ProposalHolder)addedPorgs.get(i);
			newHolder.setWorkId(workId);
			newHolder.setProgrammeCode(ph.getProgrammeCode());
			newHolder.setSubprogrammeCode(ph.getSubprogrammeCode());
			newHolder.setAdminiStrativeNum(ph.getAdminiStrativeNum());
			newHolder.setAdminiStrativeDate(ph.getAdminiStrativeDate());
			newHolder.setSanctionAmout(ph.getSanctionAmout());
			rwsWorkAdmnProgLnkTmp.add(newHolder);
		}
		session.setAttribute("rwsWorkAdmnProgLnkTmp",rwsWorkAdmnProgLnkTmp);
		
	return rwsWorkAdmnProgLnkTmp;
}


public boolean saveRevisedWorkIdAddedProgs2(HttpSession session,DataSource dataSource,ArrayList addedPorgs,String workId,String Stat)throws Exception 
{
	boolean savedToSession=true;
	Debug.println("in saveRevisedWorkIdAddedProgs2");
	Debug.println("addedPorgs size is "+addedPorgs.size());
	ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
	if(rwsWorkAdmnProgLnkTmp==null)
		rwsWorkAdmnProgLnkTmp=new ArrayList();
	try
	{
		Debug.println("-------------------status is -----------------------------"+Stat);
		ProposalHolder ph=null;
		for(int i=0;i<addedPorgs.size();i++)
		{
			
			 //
			ProposalHolder newHolder=new ProposalHolder();
			
			ph=(ProposalHolder)addedPorgs.get(i);
			Debug.println("work id is "+workId);
			newHolder.setProposalId(workId);
			Debug.println("programmeCode is "+ph.getProgrammeCode());
			newHolder.setProgrammeCode(ph.getProgrammeCode());
			Debug.println("getSubprogrammeCode is "+ph.getSubprogrammeCode());
			newHolder.setSubprogrammeCode(ph.getSubprogrammeCode());
			Debug.println("getRevisedAdminiStrativeNum is "+ph.getRevisedAdminiStrativeNum());
			newHolder.setRevisedAdminiStrativeNum(ph.getRevisedAdminiStrativeNum());
			Debug.println("getRevisedAdminiStrativeDate is "+ph.getRevisedAdminiStrativeDate());
			newHolder.setRevisedAdminiStrativeDate(ph.getRevisedAdminiStrativeDate());
			Debug.println("getRevisedSanctionAmout is "+ph.getRevisedSanctionAmout());
			newHolder.setRevisedSanctionAmout(ph.getRevisedSanctionAmout());
			rwsWorkAdmnProgLnkTmp.add(newHolder);
			//
			  
			 
		}
		session.setAttribute("rwsWorkAdmnProgLnkTmp",rwsWorkAdmnProgLnkTmp);
		
	}
	catch(Exception e)
	{  
		Debug.println("Exception in revised add"+e);
		savedToSession=false;
	}
	
	return savedToSession;
}


public boolean saveRevisedWorkIdAddedProgsFromView(DataSource dataSource,ArrayList addedPorgs,String workId)throws Exception 
{
	boolean status=true;
	Connection conn=null;
	try
	{
		
		Debug.println("in saveRevisedWorkIdAddedProgsFromView()");
		conn=RwsOffices.getConn();
		Statement stmt=conn.createStatement();
		conn.setAutoCommit(false);
		for(int i=0;i<addedPorgs.size();i++)
		{
			ProposalHolder ph=new ProposalHolder();
			ph=(ProposalHolder)addedPorgs.get(i);
			if(i==0)
			{
				query="DELETE FROM RWS_REVISED_ADM_PROG_LNK_TBL WHERE WORK_ID='"+workId+"'";
				Debug.println("query is "+query);
 				stmt.addBatch(query);
			}
				
			
			stmt.addBatch("INSERT INTO RWS_REVISED_ADM_PROG_LNK_TBL(WORK_ID ,PROGRAMME_CODE ,SUB_PROGRAMME_CODE ,ADMIN_NO ,ADMIN_DATE ,rev_SANCTION_AMOUNT  )" +
						"VALUES('"+workId+"','"+ph.getProgrammeCode()+"','"+ph.getSubprogrammeCode()+"','"+ph.getRevisedAdminiStrativeNum()+"'," +
						"to_date('"+ph.getRevisedAdminiStrativeDate()+"','dd/mm/yyyy'),'"+ph.getRevisedSanctionAmout()+"')");
		    //Debug.println("INSERT INTO RWS_REVISED_ADM_PROG_LNK_TBL(WORK_ID ,PROGRAMME_CODE ,SUB_PROGRAMME_CODE ,ADMIN_NO ,ADMIN_DATE ,rev_SANCTION_AMOUNT  )" +
				//	"VALUES('"+workId+"','"+ph.getProgrammeCode()+"','"+ph.getSubprogrammeCode()+"','"+ph.getRevisedAdminiStrativeNum()+"'," +
				//	"to_date('"+ph.getRevisedAdminiStrativeDate()+"','dd/mm/yyyy'),'"+ph.getRevisedSanctionAmout()+"')");	
		 
    	}
		int value[]=stmt.executeBatch();
		if(status)
		{ 
			conn.commit();
		}
	}
	catch(Exception e)
	{   status=false;
		Debug.println("Exception in revised add"+e);
	}
	
	finally
	{
		conn.close();
	}
	return status;
}


public  void deleteTempAddRevProgramsTable(HttpSession session,String workId)
{
	
	Debug.println("in deleteTempAddProgramsTable()");
	Debug.println("workId is "+workId);
	try
	{
		ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
		
		if(rwsWorkAdmnProgLnkTmp!=null)
		{
			//RwsWorkAdmnProgLnkTmpBean rwsWorkAdmnProgLnkTmpBean=null;
			Debug.println("rwsWorkAdmnProgLnkTmp size is "+rwsWorkAdmnProgLnkTmp.size());
			
			ProposalHolder ph=null;
			for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)
			{
				Debug.println("i is "+i);
				ph=(ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);
				if(ph.getProposalId().equals(workId))
					rwsWorkAdmnProgLnkTmp.set(i,null);
			}
			for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)
    		{
				ph= (ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);
				Debug.println("i in remove is "+i);
    			if(ph==null)
    			{
    				rwsWorkAdmnProgLnkTmp.remove(i);
    				i--;
    			}
    		}
		}
		else
		{
			Debug.println("rwsWorkAdmnProgLnkTmp in session is null");
		}
	}
	catch(Exception e)
	{	Debug.println("Exception in deleteTempAddProgramsTable() : " + e);
	
	}
	
	
	
}


public ArrayList getAddedProgramsListForRevised(DataSource dataSource ,String WorkId)throws Exception 
{
	ArrayList list=new ArrayList();
	ProposalHolder ph=null;
	Connection conn=null;
	nic.watersoft.commons.CommonLists commonLists=null;
	try
	{
		conn=RwsOffices.getConn();
		Statement stmt=conn.createStatement();
		String query="select distinct pl.PROGRAMME_CODE,pl.SUB_PROGRAMME_CODE," +
		"pl.ADMIN_NO,to_char(pl.ADMIN_DATE,'dd/mm/yyyy')ad," +
		"pl.work_id ,pl.SANCTION_AMOUNT,ad.work_Name ,to_char(rv.ADMIN_DATE,'dd/mm/yyyy')rvdt,rv.ADMIN_NO ," +
		"rv.REV_SANCTION_AMOUNT  from" +
		" RWS_WORK_ADMN_PROG_LNK_TBL pl,rws_work_admn_tbl ad ,RWS_REVISED_ADM_PROG_LNK_TBL rv where " +
		"pl.work_id='"+WorkId+"' and ad.work_id='"+WorkId+"' and rv.work_id='"+WorkId+"' " +
		"and rv.programme_code=pl.programme_code and rv.sub_programme_code=pl.sub_programme_code";
		Debug.println(query);
		
		ResultSet rs=stmt.executeQuery(query);
		
		while(rs.next())
		{
			commonLists=new nic.watersoft.commons.CommonLists(dataSource);
			ph=new ProposalHolder();
	 	    ph.setProgrammeCode(rs.getString(1));
	 	    ArrayList subprogrammes = commonLists.getSubprogrammes(rs.getString(1));
			ph.setSubprogrammes(subprogrammes);
		 	ph.setSubprogrammeCode(rs.getString(2));
			ph.setAdminiStrativeNum(rs.getString(3));
			ph.setAdminiStrativeDate(rs.getString(4));
	 		ph.setWorkId(rs.getString(5));
			ph.setSanctionAmout(rs.getString(6));
			ph.setWorkName(rs.getString(7));
			ph.setRevisedAdminiStrativeDate(rs.getString(8));
			ph.setRevisedAdminiStrativeNum(rs.getString(9));
			ph.setRevisedSanctionAmout(rs.getString(10));
			list.add(ph);
		}
		
	}
	catch(Exception e)
	{
		Debug.println("Exception in geting added programs list"+e);
	}
	finally
	{
		conn.close();
	}
	return list;
}



public ArrayList getAddedProgramsList(DataSource dataSource ,String WorkId)throws Exception 
{
	ArrayList list=new ArrayList();
	ProposalHolder ph=null;
	Connection conn=null;
	CommonLists commonLists=null;
	try
	{
//		updated query fieldsname sunprograme name
		conn=RwsOffices.getConn();
		Statement stmt=conn.createStatement();
		//String query="select distinct pl.PROGRAMME_CODE,p.programme_name,pl.SUB_PROGRAMME_CODE,sp.subprogramme_name,pl.ADMIN_NO,to_char(pl.ADMIN_DATE,'dd/mm/yyyy')ad," +
		//"pl.work_id ,pl.SANCTION_AMOUNT,ad.work_Name from RWS_WORK_ADMN_PROG_LNK_TBL pl,rws_work_admn_tbl ad,rws_programme_tbl p,rws_subprogramme_tbl sp  where pl.work_id='"+WorkId+"'  and pl.PROGRAMME_CODE=p.programme_code and sp.programme_code=pl.PROGRAMME_CODE and sp.subprogramme_code=pl.SUB_PROGRAMME_CODE and ad.work_id='"+WorkId+"'";
		//Debug.println(query);
		String query="select distinct pl.PROGRAMME_CODE,p.programme_name,sp.SUBPROGRAMME_CODE,sp.subprogramme_name,pl.ADMIN_NO,to_char(pl.ADMIN_DATE,'dd/mm/yyyy')ad," +
		"pl.work_id ,pl.SANCTION_AMOUNT,ad.work_Name from RWS_WORK_ADMN_PROG_LNK_TBL pl,rws_work_admn_tbl ad,rws_programme_tbl p,rws_subprogramme_tbl sp  where pl.work_id='"+WorkId+"'  and pl.PROGRAMME_CODE=p.programme_code and sp.programme_code=pl.PROGRAMME_CODE and sp.subprogramme_code=pl.SUB_PROGRAMME_CODE and ad.work_id='"+WorkId+"'";
		Debug.println("qqq in query getAddedProgramsList"+query);
		ResultSet rs=stmt.executeQuery(query);
		while(rs.next())
		{
			commonLists=new  CommonLists(dataSource);
			ph=new ProposalHolder();
	 	    ph.setProgrammeCode(rs.getString("PROGRAMME_CODE"));
	 	    ph.setProgrammeName(rs.getString("programme_name"));
	 	    ArrayList subprogrammes = commonLists.getSubprogrammes(rs.getString("PROGRAMME_CODE"));
			ph.setSubprogrammes(subprogrammes);
			//updated by swapna 
		 	ph.setSubprogrammeCode(rs.getString("SUBPROGRAMME_CODE"));
		 	//
		 	ph.setSubProgrammeName(rs.getString("subprogramme_name"));
			ph.setAdminiStrativeNum(rs.getString("ADMIN_NO"));
			ph.setAdminiStrativeDate(rs.getString("ad"));
			ph.setWorkId(rs.getString("work_id"));
			ph.setSanctionAmout(rs.getString("SANCTION_AMOUNT"));
			ph.setWorkName(rs.getString("work_Name"));
			list.add(ph);
		}
		
	}
	catch(Exception e)
	{
		Debug.println("Exception in geting added programs list"+e);
	}
	finally
	{
		conn.close();
	}
	return list;
  }

public ArrayList getAssetTypes(String workcat,String plancode) throws Exception
{   Connection conn=null;
	ArrayList assetTypes = new ArrayList();
	PreparedStatement ps=null;
	ResultSet rset=null;
	try
	{
		query = " SELECT type_of_asset_code , UPPER(type_of_asset_name)  "
			  + " FROM rws_asset_type_tbl where type_of_asset_name in";
		if(workcat.equals("1")&& plancode.equals("1"))
		{
			
			query+="('CPWS') order by type_of_asset_code";
		}
		if(workcat.equals("1")&& plancode.equals("2"))
		{
			
			query+="('CPWS') order by type_of_asset_code";
		}
		if(workcat.equals("2") && plancode.equals("1"))
		{
			query+="('PWS') order by type_of_asset_code";
		}
		
	   if(workcat.equals("2") && plancode.equals("2"))
		{
			
			query+="('PWS') order by type_of_asset_code";
		}
		if(workcat.equals("3") && plancode.equals("1"))
		{
			
			query+="('PWS','HANDPUMPS','OPEN WELLS') order by type_of_asset_code";
		}
		if(workcat.equals("3") && plancode.equals("2"))
		{
			
			query+="('PWS','HANDPUMPS') order by type_of_asset_code";
		}
		else if(workcat.equals(""))
		{
			query+="('') order by type_of_asset_code";
		}
			
		
		conn = RwsOffices.getConn();
		ps=conn.prepareStatement(query);
		rset=ps.executeQuery();

		LabelValueBean labelValueBean =new LabelValueBean();
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(2));
			assetTypes.add(labelValueBean);
		}
	}
	finally
	{
		if (rset != null) {
			try {
				rset.close();
			} catch (SQLException sqle) {
			}
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (SQLException sqle) {
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException sqle) {
			}
		}
	}
	return assetTypes;
}

public String getHabCode(String proposalId)
{

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rset = null;
	String habCode= "";
	try
	{
		conn = RwsOffices.getConn();
		
		String query ="select habitation_code from rws_drought_works_tbl p where work_id=?";
		ps = conn.prepareStatement(query);	
		ps.setString(1, proposalId);
		rset = ps.executeQuery();
		RwsLocationBean rwsLocationBean = null; 
		while(rset.next())
		{
			habCode=rset.getString(1);
		}
	}
	catch(Exception e)
	{	Debug.println("Exception in getHabCode:" + e);
		
	}
	finally
	{
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(ps != null)
		{	try
			{	ps.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	return habCode;
}

/**
 * @param sourceHabCode
 * @return
 */
public ArrayList getSourceDetails(String sourceHabCode) {
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	ArrayList sourceDetails = new ArrayList();
	
	String tableName="";
	try
	{
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		
		
					
	 query = "Select hp_code  from RWS_DROUGHT_FLUSH_DEEPEN_TBL where substr(hp_code,1,16)='"+sourceHabCode+"'";
			
						 
			Debug.println("Query is "+query);
			rset = stat.executeQuery(query);
			DroughtDTO dto = null; 
			while(rset.next())
			{
				dto = new DroughtDTO();
				dto.setSouCode(rset.getString(1));
				getSourcenameAndLoaction(dto);
				sourceDetails.add(dto);
			}
			
	}
	catch(Exception e)
	{	Debug.println("Exception in getTempSelectedHabsForAdminSanc2() : " + e);
		
	}
	finally
	{
		if(rset != null)
		{	try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(stat != null)
		{	try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{	try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}
	return sourceDetails;
}

/**
 * @param dto
 */
private void getSourcenameAndLoaction(DroughtDTO dto) {
	try
	{
		Connection conn = RwsOffices.getConn();
		Statement stat = conn.createStatement();
		
	if(dto.getSouCode().substring(19,21).equals("HP")){					
	 query = "Select nvl(location,'-'),nvl(location,'-')  from rws_hp_subComp_param_tbl where hp_code='"+dto.getSouCode()+"'";
	}else if(dto.getSouCode().substring(19,21).equals("OW")){					
		 query = "Select nvl(location,'-'),nvl(location,'-')  from rws_open_well_mast_tbl where OPENWELL_CODE='"+dto.getSouCode()+"'";
	}else if(dto.getSouCode().substring(19,21).equals("SO")){					
		 query = "Select nvl(location,'-'),nvl(source_name,'-')  from RWS_SOURCE_TBL where source_code='"+dto.getSouCode()+"'";
	}
	ResultSet rs=stat.executeQuery(query);
	while(rs.next()){
		
		dto.setSouLocation(rs.getString(1));
		dto.setSouName(rs.getString(2));
	}
			
	}catch(Exception e){
		e.printStackTrace();
	}
	
}


public ArrayList getsusWorkTypes()
{
	
	ArrayList sustypes=new ArrayList();
	Connection conn = null;
	PreparedStatement ps = null;
	try 
	{   
		query="select *  from rws_sus_id_tbl";
		 conn = RwsOffices.getConn();
		 ps = conn.prepareStatement(query);
		 ResultSet rset = ps.executeQuery();
		
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(2));
			sustypes.add(labelValueBean);
			
		}
	}
	catch(Exception e)
	{
		Debug.println("EXCEPTION IN GET WORK CATEGORY"+e.getMessage());
	}
	finally{

		if (ps != null) {
			try {
				ps.close();
			} catch (SQLException sqle) {
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException sqle) {
			}
		}
	
	}
	return sustypes;

}

public  ArrayList getManHabitations(String ccode,String divcode,String subdivcode,String mcode) throws Exception
{
	ArrayList habs=new ArrayList();
	  Connection conn=null;
	  ResultSet rset=null;
	  
	 String query="";
	try
	{
		conn = RwsOffices.getConn();
		Statement stmt1 = conn.createStatement();
		//query=" SELECT RAJ.HAB_CODE,RAJ.PANCH_CODE,RAJ.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL RAJ,RWS_HABITATION_DIRECTORY_TBL HD WHERE RAJ.PANCH_CODE = HD.HAB_CODE AND hd.circle_office_code='"+ccode+"' and hd.division_office_code='"+divcode+"' and hd.subdivision_office_code='"+subdivcode+"' and SUBSTR(RAJ.HAB_CODE,1,2)='"+ccode+"' AND SUBSTR(RAJ.HAB_CODE,6,2)='"+mcode+"' AND (HD.COVERAGE_STATUS IS NOT NULL OR HD.COVERAGE_STATUS <> 'UI')";
		query="select panch_code,panch_name from rws_panchayat_raj_tbl a,rws_mandal_subdivision_tbl hd where substr(a.panch_code,1,2)='"+ccode+"' and substr(a.panch_code,6,2)='"+mcode+"' and   hd.circle_office_code='"+ccode+"' and hd.division_office_code='"+divcode+"' and hd.subdivision_office_code='"+subdivcode+"' and substr(a.panch_code,1,2)=hd.dcode and substr(a.panch_code,6,2)=hd.mcode";
		System.out.println("query in getHabitations is "+query);
		PreparedStatement ps = conn.prepareStatement(query);
		
			 rset = ps.executeQuery();

		while ( rset.next() ) 
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(2));
			labelValueBean.setLabelValue(rset.getString(1)+" - " + rset.getString(2));
			habs.add(labelValueBean);
		}
	}
	catch (Exception e)
	{
		e.printStackTrace();
	}
	finally 
	{
		if(conn!=null){
			conn.close();
		}
		if(rset!=null){
			rset.close();
		}
	}
	return habs;
}



}