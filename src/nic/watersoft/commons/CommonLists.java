package nic.watersoft.commons;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import javax.sql.DataSource;
import nic.watersoft.fundAccounting.Rws_BroProgDetailsBean;
import nic.watersoft.masters.Rws_SchoolDetailsBean;
 

public class CommonLists  
{
	private DataSource dataSource;
	private Connection conn;
	private Statement stat;
	private PreparedStatement ps;
	private ResultSet rset;
	private String query;
	private LabelValueBean labelValueBean;
	private SimpleDateFormat dateFormatter;
	
	public CommonLists()  
	{
		try
		{
			//Class.forName("oracle.jdbc.driver.OracleDriver");
		}
		catch(Exception e)
		{	//System.out.println("IN CommonLists constructor " + e);
		}
	}

	public CommonLists(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	private void closeAll()
	{
		if(rset != null)
		{
			try
			{	rset.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(stat != null)
		{
			try
			{	stat.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(ps != null)
		{
			try
			{	ps.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
		if(conn != null)
		{
			try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	
			}
		}
	}

	public ArrayList getRepresentatives() throws Exception
	{
		ArrayList representatives = new ArrayList();
		
		try
		{
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			query = " SELECT rep_code, rep_name "
				  + " FROM rws_public_rep_tbl ORDER BY rep_name";
			rset = stat.executeQuery(query);
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				representatives.add(labelValueBean);
			}
		}
		finally
		{	
			closeAll();
		}
		return representatives;
	}
	
	public ArrayList getConstituencies(String repCode) throws Exception
	{
		ArrayList constituencies = new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			query = " SELECT constituency_code, constituency_name FROM rws_constituency_tbl "
				  + " WHERE rep_code = " + repCode + " ORDER BY constituency_name ";
			
			rset = stat.executeQuery(query);
		
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				constituencies.add(labelValueBean);
			}
		}
		finally
		{
			closeAll();
		}
		return constituencies;
	}

	public String[] getRepresentativeDetails(String repCode, String constituencyCode) throws Exception
	{
		String[] repDetails = new String[2];
		//System.out.println("repCode " + repCode);
		//System.out.println("constituencyCode " + constituencyCode);
		try
		{
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			query = " SELECT name, address from rws_constituency_tbl WHERE "
				  + " rep_code = " + repCode + " AND constituency_code = " + constituencyCode ;
					
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				repDetails[0] = rset.getString(1);
				repDetails[1] = rset.getString(2);
			}
		}
		finally
		{
			closeAll();
		}
		return repDetails;
	}

	/**	
	*	Get the various Programme Codes and Names 
	*/
	public ArrayList getProgrammes() throws Exception{
		ArrayList programmes = new ArrayList();		
		try	{
			conn = RwsOffices.getConn();
			String query = "SELECT programme_code, programme_name FROM rws_programme_tbl ORDER BY programme_name ";						 
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while(rset.next()){
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				programmes.add(labelValueBean);
			}
		}catch(Exception e){
			System.out.println("The Exceptiion is in CommonLists getProgrammes : "+e.getMessage());
		}
		finally	{	
			closeAll();
		}
		return programmes;
	}
	
	public ArrayList getSubprogrammes(String programmeCode) throws Exception
	{
		ArrayList subprogrammes = new ArrayList();
		
		try
		{
			query = " SELECT subprogramme_code, subprogramme_name "
				  + " FROM rws_subprogramme_tbl WHERE programme_code=?"
				  + " ORDER BY subprogramme_name ";
			
			if(dataSource != null)
				conn = RwsOffices.getConn();
			
			ps = conn.prepareStatement(query);
			ps.setString(1, programmeCode);
			rset = ps.executeQuery();
						
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				subprogrammes.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return subprogrammes;
	}
	
		
	public ArrayList getSubprogrammes2(String programmeCode,String broId) throws Exception
	{
		ArrayList subprogrammes = new ArrayList();
		try
		{
			query = " SELECT distinct s.subprogramme_code, s.subprogramme_name FROM rws_subprogramme_tbl s,rws_bro_details_tbl b WHERE s.programme_code=b.programme_code and s.programme_code='"+programmeCode+"' and s.subprogramme_code=b.subPROGRAMME_CODE and b.bro_id='"+broId+"' ORDER BY subprogramme_name ";
			if(dataSource != null)
				conn = RwsOffices.getConn();
			//System.out.println("Get Subprogrammes Query:"+query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
						
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				subprogrammes.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return subprogrammes;
	}
	public int getQuarters(Rws_BroProgDetailsBean bean) throws Exception
	{
		int  qtr = 0;
		try
		{
			query = "select  distinct quarter  from rws_bro_details_tbl where programme_code='"+bean.getProgrammeCode()+"' and subprogramme_code='"+bean.getSubprogrammeCode()+"' and head_of_account='"+bean.getHeadOfAccount()+"' and center_state='"+bean.getSelects()+"' order by quarter";
			if(dataSource != null)
				conn = RwsOffices.getConn();
			Debug.println("Get quarters Query:"+query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			while(rset.next())
			{
				qtr = rset.getInt(1);
			}
			qtr++;
			
		}
		finally
		{	closeAll();
		}
		return qtr;
	}
	
	public int getBudgetAmount(Rws_BroProgDetailsBean bean) throws Exception
	{
		int  qtr = 0;
		try
		{
			query = "select  distinct budget_estimate from rws_bro_details_tbl where programme_code='"+bean.getProgrammeCode()+"' and subprogramme_code='"+bean.getSubprogrammeCode()+"' and head_of_account='"+bean.getHeadOfAccount()+"'";
			if(dataSource != null)
				conn = RwsOffices.getConn();
			Debug.println("Get budget amount Query:"+query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			while(rset.next())
			{
				qtr = rset.getInt(1);
			}
		}
		finally
		{	closeAll();
		}
		return qtr;
	}
	
	public int getAmountAlready(Rws_BroProgDetailsBean bean) throws Exception
	{
		int  qtr = 0;
		try
		{
			Debug.println("Quarter:"+bean.getQuarter());
			if(bean.getQuarter().equals("1"))
			{
				qtr = 0;
			}
			else
			{
				query = "select  sum(amt_already_auth) from rws_bro_details_tbl where  programme_code='"+bean.getProgrammeCode()+"' and subprogramme_code='"+bean.getSubprogrammeCode()+"' and head_of_account='"+bean.getHeadOfAccount()+"'";
				if(dataSource != null)
					conn = RwsOffices.getConn();
				Debug.println("Get  amount already Query:"+query);
				stat = conn.createStatement();
				rset = stat.executeQuery(query);
				while(rset.next())
				{
					qtr = rset.getInt(1);
				}
			}
			
		}
		finally
		{	closeAll();
		}
		return qtr;
	}
	public int getAmountNow(Rws_BroProgDetailsBean bean) throws Exception
	{
		int  qtr = 0;
		try
		{
			Debug.println("Quarter:"+bean.getQuarter());
			if(bean.getQuarter().equals("1"))
			{
				qtr = 0;
			}
			else
			{
				query = "select  sum(amt_now_auth) from rws_bro_details_tbl where  programme_code='"+bean.getProgrammeCode()+"' and subprogramme_code='"+bean.getSubprogrammeCode()+"' and head_of_account='"+bean.getHeadOfAccount()+"'";
				if(dataSource != null)
					conn = RwsOffices.getConn();
				Debug.println("Get  amount now Query:"+query);
				stat = conn.createStatement();
				rset = stat.executeQuery(query);
				while(rset.next())
				{
					qtr = rset.getInt(1);
				}
			}
			
		}
		finally
		{	closeAll();
		}
		return qtr;
	}
	public int getBudgetAmount1(Rws_BroProgDetailsBean bean) throws Exception
	{
		int  qtr = 0;
		try
		{
			query = "select  distinct budget_estimate from rws_bro_details_tbl where programme_code='"+bean.getProgrammeCode()+"' and subprogramme_code='"+bean.getSubprogrammeCode()+"' and head_of_account='"+bean.getHeadOfAccount()+"' and quarter='"+bean.getQuarter()+"'";
			if(dataSource != null)
				conn = RwsOffices.getConn();
			Debug.println("Get budget amount Query:"+query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			while(rset.next())
			{
				qtr = rset.getInt(1);
			}
		}
		finally
		{	closeAll();
		}
		return qtr;
	}
	
	public int getAmountAlready1(Rws_BroProgDetailsBean bean) throws Exception
	{
		int  qtr = 0;
		try
		{
			query = "select  sum(amt_already_auth) from rws_bro_details_tbl where programme_code='"+bean.getProgrammeCode()+"' and subprogramme_code='"+bean.getSubprogrammeCode()+"' and head_of_account='"+bean.getHeadOfAccount()+"'  and quarter='"+bean.getQuarter()+"'";
			if(dataSource != null)
				conn = RwsOffices.getConn();
			Debug.println("Get  amount already Query:"+query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			while(rset.next())
			{
				qtr = rset.getInt(1);
			}
		}
		finally
		{	closeAll();
		}
		return qtr;
	}
	public int getAmountNow1(Rws_BroProgDetailsBean bean) throws Exception
	{
		int  qtr = 0;
		try
		{
			Debug.println("Quarter:"+bean.getQuarter());
			if(bean.getQuarter().equals("1"))
			{
				qtr = 0;
			}
			else
			{
				query = "select  sum(amt_now_auth) from rws_bro_details_tbl where programme_code='"+bean.getProgrammeCode()+"' and subprogramme_code='"+bean.getSubprogrammeCode()+"' and head_of_account='"+bean.getHeadOfAccount()+"' and quarter='"+bean.getQuarter()+"'";
				if(dataSource != null)
					conn = RwsOffices.getConn();
				Debug.println("Get  amount now Query:"+query);
				stat = conn.createStatement();
				rset = stat.executeQuery(query);
				while(rset.next())
				{
					qtr = rset.getInt(1);
				}
			}
			
		}
		finally
		{	closeAll();
		}
		return qtr;
	}
	public boolean getStatus(Rws_BroProgDetailsBean bean) throws Exception
	{
		boolean flag = false;
		try
		{
			query = "select  * from rws_bro_details_tbl where programme_code='"+bean.getProgrammeCode()+"' and subprogramme_code='"+bean.getSubprogrammeCode()+"' and head_of_account='"+bean.getHeadOfAccount()+"'";
			if(dataSource != null)
				conn = RwsOffices.getConn();
			Debug.println("Get  Status Query:"+query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			if(rset.isBeforeFirst())
			{
				flag = true;
			}
		}
		finally
		{	closeAll();
		}
		return flag;
	}
	
	 public ArrayList getPaoList(String dcode) throws Exception
		{
			ArrayList paoList = new ArrayList();
			
			try
			{
				conn = RwsOffices.getConn();
				stat = conn.createStatement();
				query = " select d.dcode,d.dname,pao_code,pao_apao from rws_pao_tbl p,rws_district_tbl d where p.dcode = d.dcode and d.dcode='"+dcode+"' order by pao_code ";
				Debug.println("query is "+query);
				rset = stat.executeQuery(query);
				
				while(rset.next())
				{
					String name = "";
					if(rset.getString(4).equals("P"))
					{
						name += "PAO - "+rset.getString(2);
					}
					else if(rset.getString(4).equals("A"))
					{
						name += "APAO - "+rset.getString(2);
					}
					Debug.println("Name:"+name);
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(3));
					labelValueBean.setLabel(name);
					labelValueBean.setLabelValue(rset.getString(2)+" - "+rset.getString(1));
					paoList.add(labelValueBean);
				}
			}
			finally
			{	
				closeAll();
			}
			Debug.println("Pao List Size:"+paoList.size());
			return paoList;
		}
	 public ArrayList getHeadOfAccountList1(String broId) throws Exception
		{
			ArrayList headOfAccountList = new ArrayList();
			
			try
			{
				conn = RwsOffices.getConn();
				stat = conn.createStatement();
				//query = " SELECT h.HEAD_OF_ACCOUNT,h.HEAD_OF_ACCOUNT_NAME FROM RWS_HEAD_OF_ACCOUNT_TBL h,rws_bro_details_tbl b where b.bro_id = '"+broId+"' and h.HEAD_OF_ACCOUNT  = b.HEAD_OF_ACCOUNT ORDER BY HEAD_OF_ACCOUNT_NAME";
				query = "select distinct(head_of_account) from rws_bro_details_tbl where bro_id = '"+broId+"'";
				Debug.println("query to get heads1 is "+query);
				rset = stat.executeQuery(query);
				
				while(rset.next())
				{
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(1));
					labelValueBean.setLabelValue(rset.getString(1));
					headOfAccountList.add(labelValueBean);
				}
			}
			finally
			{	
				closeAll();
			}
			return headOfAccountList;
		}
	/*
	 * upto here ramesh added for BRO and LOC
	 * 
	 */
	public ArrayList getSubprogrammes1(String programmeCode,String workCat) throws Exception//added on feb16th
	{
		ArrayList subprogrammes = new ArrayList();
		
		try
		{
			query = " SELECT subprogramme_code, subprogramme_name "
				  + " FROM rws_subprogramme_tbl WHERE programme_code='" + programmeCode + "' and WORK_CATEGORY='"+workCat+"'"
				  + " ORDER BY subprogramme_name ";
			if(dataSource != null)
				conn = RwsOffices.getConn();
			
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
						
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				subprogrammes.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return subprogrammes;
	}
	
	/**	
	*	Get the various SubProgramme Codes and Names 
	*/
	public ArrayList getAllProgrammesSubProgrammes() throws Exception
	{
		ArrayList programmesSubProgrammes = new ArrayList();
		
		try
		{
			query = " SELECT P.programme_code, P.programme_name, " 
				  + " NVL(SP.subprogramme_code,''), NVL(SP.subprogramme_name,'') " 
				  + " FROM rws_programme_tbl P, rws_subprogramme_tbl SP " 
				  + " WHERE P.programme_code = SP.programme_code(+) ";

			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;			
			while(rset.next())
			{
				programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
				programmeSubProgrammeBean.setProgrammeCode(rset.getString(1));
				programmeSubProgrammeBean.setProgrammeName(rset.getString(2));
				programmeSubProgrammeBean.setSubprogrammeCode(rset.getString(3));
				programmeSubProgrammeBean.setSubprogrammeName(rset.getString(4));
				programmesSubProgrammes.add(programmeSubProgrammeBean);
			}
		}
		finally
		{	closeAll();
		}
		return programmesSubProgrammes;
	}
	

	/**	
	*	Gets the various Priorities
	*/
	public ArrayList getPriorities() throws Exception
	{
		ArrayList priorities = new ArrayList();
		
		try
		{
			query = " SELECT priority_code, priority_description "
				  + " FROM rws_priority_tbl order by priority_description";
			
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				priorities.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return priorities;
	}

	
	
	public ArrayList getWorkCategory(){
		ArrayList workcategory=new ArrayList();
		try {
			query="select *  from rws_work_category_tbl";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();			
			while(rset.next()){
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				workcategory.add(labelValueBean);				
			}
		}
		catch(Exception e){
			System.out.println("The Exceptiion is in CommonLists getWorkCategory :"+e.getMessage());
		}
		finally{
			closeAll();
		}
		return workcategory;	
	}
	
	public ArrayList getAssetTypes(String workcat,String plancode) throws Exception {
		ArrayList assetTypes = new ArrayList();
		try	{
			query = "SELECT type_of_asset_code , UPPER(type_of_asset_name) FROM rws_asset_type_tbl where type_of_asset_name in";
			if(workcat.equals("1") && plancode.equals("1")){
				query+="('CPWS') order by type_of_asset_code";
			}
			if(workcat.equals("1") && plancode.equals("2")){
				query+="('CPWS') order by type_of_asset_code";
			}
			if(workcat.equals("2") && plancode.equals("1")){
				query+="('PWS','SUSTAINABILITY','SCHOOLS','ANGANWADIS','PUBLIC INSTITUTES') order by type_of_asset_code";
			}
			if(workcat.equals("2") && plancode.equals("2")){				
				query+="('PWS','SUSTAINABILITY','LAB') order by type_of_asset_code";
			}
			if(workcat.equals("3") && plancode.equals("1")){
				query+="('CPWS','PWS','HANDPUMPS','SCHOOLS','OPEN WELLS') order by type_of_asset_code";
			}
			if(workcat.equals("3") && plancode.equals("2")){				
				query+="('PWS','HANDPUMPS') order by type_of_asset_code";
			}
			else if(workcat.equals("")){
				query+="('') order by type_of_asset_code";
			}
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();			
			while(rset.next()){
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				assetTypes.add(labelValueBean);
			}
		}
		catch(Exception e){
			System.out.println("The Exceptiion is in CommonLists getAssetTypes : "+e.getMessage());
		}
		finally	{	
			closeAll();
		}
		return assetTypes;
	}

public ArrayList getProgrammes1(String plan,String wrkType,String workCat) throws Exception
	{
		
		ArrayList programmes = new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			
			String query = "select w.programme_code,p.programme_name from rws_programme_tbl p,rws_work_prog_lnk_tbl w " +
					       "where w.programme_code=p.programme_code and w.plan_code=? and w.aug_new_code=? " +
					       "and w.category_code=? order by p.programme_code,p.programme_name";
						 
			ps = conn.prepareStatement(query);
			ps.setString(1, plan);
			ps.setString(2, wrkType);
			ps.setString(3, workCat);
			rset = ps.executeQuery();
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				programmes.add(labelValueBean);
			}
		}
		catch(Exception e)
		{
			Debug.println("Exception in getting Programe1"+e.getMessage());
		}
		finally
		{	
			closeAll();
		}
		return programmes;
	}


public ArrayList getProgrammes(String plan,String wrkType,String workCat)
{
	Debug.println("IN GETPROGRAMME1");
	ArrayList programmes = new ArrayList();
	try
	{
		conn = RwsOffices.getConn();
		String query = "select distinct w.programme_code,p.programme_name from rws_programme_tbl p,rws_work_prog_lnk_tbl w,rws_work_admn_tbl ad " +
				       "where w.programme_code=p.programme_code and w.plan_code='"+plan+"' and w.aug_new_code='"+wrkType+"' " +
				       "and w.category_code='"+workCat+"' and substr(ad.work_id,1,2)=w.programme_code ";
		Debug.println("QUERY IS:"+query);			 
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(2));
			programmes.add(labelValueBean);
		}
	}
	catch(Exception e)
	{
		Debug.println("Exception in getting Programe1"+e.getMessage());
	}
	finally
	{	
		closeAll();
	}
	return programmes;
}

public String getMaterialCode(String material) throws Exception {
	try {
		query = " SELECT mat_code,material  FROM RWS_PIPE_MATERIAL_TBL where material=?";
		conn = RwsOffices.getConn();
		ps = conn.prepareStatement(query);
		ps.setString(1, material);
		rset = ps.executeQuery();
		while (rset.next()) {
			material = rset.getString("mat_code");
		}
	} catch (Exception E) {
		 System.out.println("Exception in getMaterialCode in commonLists "+E);
	} finally {
		closeAll();
	}
	return material;
}

public ArrayList getPipeMatirals() throws Exception {
	ArrayList assetTypes = new ArrayList();
	try {
		query = " SELECT mat_code,material  FROM RWS_PIPE_MATERIAL_TBL ORDER BY MAT_CODE ";
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		while (rset.next()) {
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(2));
			labelValueBean.setLabel(rset.getString(2));
			assetTypes.add(labelValueBean);
		}
	} catch (Exception e) {
		System.out.println("Exception at getPipeMatirals in CommonLists: " + e);
	} finally {
		closeAll();
	}
	return assetTypes;
}
//newly
public ArrayList getPipeClass(String pipeCode) throws Exception {
	ArrayList pipeclasses = new ArrayList();
	try {
		query = " SELECT MAT_CODE, PIPE_CLASS  FROM RWS_PIPE_CLASS_TBL WHERE MAT_CODE=? ORDER BY MAT_CODE ";
		conn = RwsOffices.getConn();
		ps = conn.prepareStatement(query);
		ps.setString(1, pipeCode);
		rset = ps.executeQuery();
		while (rset.next()) {
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(2));
			labelValueBean.setLabel(rset.getString(2));
			pipeclasses.add(labelValueBean);
		}
	} catch (Exception e) {
		System.out.println("Exception at getPipeClass in CommonLists  : "+e);
	}finally {
		closeAll();
	}
	return pipeclasses;
}
//newly
public ArrayList getPipDia(String pipeCode) throws Exception {
	ArrayList pipedia = new ArrayList();
	try {
		query = " SELECT MAT_CODE, PIPE_DIA FROM RWS_PIPE_DIAMETER_TBL WHERE MAT_CODE=? ORDER BY MAT_CODE ";
			conn = RwsOffices.getConn();
		ps = conn.prepareStatement(query);
		ps.setString(1, pipeCode);
		rset = ps.executeQuery();
		while (rset.next()) {
			labelValueBean = new LabelValueBean();
			// labelValueBean.setValue(rset.getString(1));
			labelValueBean.setValue(rset.getString(2));
			labelValueBean.setLabel(rset.getString(2));
			pipedia.add(labelValueBean);
		}
	} catch (Exception e) {
		System.out.println("Exception at getPipDia in CommonLists: "+e);
	}finally {
		closeAll();
	}
	return pipedia;
}

// newly
public ArrayList getSchemeCodes(String assetTypeCode, String habCode) {
	ArrayList schemeCodes = new ArrayList();
	try {
		conn = RwsOffices.getConn();

		String query = "";

		if (assetTypeCode.equals("01"))
			query = "select substr(s.scheme_code,17,3),s.asset_code from rws_asset_mast_tbl a,RWS_asset_scheme_tbl    s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? AND SUBSTR(a.ASSET_CODE,5,2)=? order by s.scheme_code";
		else if (assetTypeCode.equals("02"))
			query = "select substr(s.scheme_code,17,3),s.asset_code from rws_asset_mast_tbl a,RWS_ASSET_SCHEME_TBL  s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? and substr(scheme_code,17,3) like '4%' order by s.scheme_code";

		else if (assetTypeCode.equals("03"))
			query = "select substr(s.scheme_code,17,3),s.asset_code from rws_asset_mast_tbl a,RWS_asset_scheme_tbl  s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? order by s.scheme_code";

		else if (assetTypeCode.equals("04"))
			query = "select substr(s.scheme_code,17,3),s.asset_code from rws_asset_mast_tbl a,RWS_ASSET_SCHEME_TBL  s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? order by s.scheme_code";
		else if (assetTypeCode.equals("05"))
			query = "select substr(s.scheme_code,17,3),s.asset_code from rws_asset_mast_tbl a,RWS_ASSET_SCHEME_TBL  s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? order by s.scheme_code";

		else if (assetTypeCode.equals("06"))
			query = "select substr(s.scheme_code,17,3),s.asset_code from rws_asset_mast_tbl a,RWS_ASSET_SCHEME_TBL  s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? order by s.scheme_code";

		else if (assetTypeCode.equals("07"))
			query = "select substr(s.scheme_code,17,3),s.asset_code from rws_asset_mast_tbl a,RWS_ASSET_SCHEME_TBL  s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? order by s.scheme_code";

		else if (assetTypeCode.equals("08"))
			query = "select substr(s.scheme_code,17,3),s.asset_code from rws_asset_mast_tbl a,RWS_ASSET_SCHEME_TBL  s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? order by s.scheme_code";
		else if (assetTypeCode.equals("09"))
			query = "select substr(s.scheme_code,17,3),s.asset_code from rws_asset_mast_tbl a,RWS_ASSET_SCHEME_TBL  s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? order by s.scheme_code";

		ps = conn.prepareStatement(query);
		ps.setString(1, assetTypeCode);
		ps.setString(2, habCode);
		if (assetTypeCode.equals("01"))
			ps.setString(3, habCode.substring(0, 2));
		rset = ps.executeQuery();
		while (rset.next()) {
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(2));
			labelValueBean.setLabel(rset.getString(1));
			schemeCodes.add(labelValueBean);
		}
	} catch (Exception e) {
		System.out.println("Exception in getSchemeCodes in commonLists =" + e);
	} finally {
		closeAll();
	}
	return schemeCodes;
}

public String getPumpCode(String assetTypeCode, String assetTypeName, String habCode) {
	String pumpCode = "";
	try {
		conn = RwsOffices.getConn();
		String query = "";
		query = "select max(substr(s.scheme_code,17,3)) from rws_asset_mast_tbl a,rws_asset_scheme_tbl s where "
				+ " a.asset_code=s.asset_code and a.type_of_asset_code=? and a.hab_code=? order by s.scheme_code";
		
		
		ps = conn.prepareStatement(query);
		ps.setString(1, assetTypeCode);
		ps.setString(2, habCode);
		rset = ps.executeQuery();
		while (rset.next()) {
			if (rset.getString(1) != null)
				pumpCode = "" + (Integer.parseInt(rset.getString(1)) + 1);
		}
		if (pumpCode.equals("")) {
			query = "select code_series from rws_asset_type_tbl where type_of_asset_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, assetTypeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				if (rset.getString(1) != null)
					pumpCode = "" + (rset.getString("code_series"));
			}
		}
		if (pumpCode.length() == 1)
			pumpCode = "00" + pumpCode;
		else if (pumpCode.length() == 2)
			pumpCode = "0" + pumpCode;
		
		
	} catch (Exception e) {
		 System.out.println("Exception at getPumpCode in RwsMasterData : "+e.getMessage());
	} finally {
		closeAll();
	}
	return pumpCode;
}
	
	public ArrayList getSourceTypes() throws Exception {
		ArrayList sourceTypes = new ArrayList();		
		try	{
			query = "SELECT source_type_code , UPPER(source_type_name) FROM rws_source_type_tbl ORDER BY source_type_name";			
			conn = RwsOffices.getConn();			 
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();			
			while(rset.next()){
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				sourceTypes.add(labelValueBean);
			}
		}
		catch(Exception e){
			System.out.println("The Exceptiion in CommonLists getSubsourceTypes :"+e.getMessage());
		}
		finally{	
			closeAll();
		}
		return sourceTypes;
	}
	
	public ArrayList getSubsourceTypes(String sourceType) throws Exception {
		ArrayList subsourceTypes = new ArrayList();
		try {
			query = "SELECT subsource_type_code , UPPER(subsource_type_name) FROM rws_subsource_type_tbl WHERE source_type_code = ? ORDER BY subsource_type_name";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceType);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				subsourceTypes.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exceptiion in CommonLists getSubsourceTypes :" + e.getMessage());
		} finally {
			closeAll();
		}
		return subsourceTypes;
	}

	public ArrayList getSources(String sourceType, String subsourceType) throws Exception
	{
		ArrayList sources = new ArrayList();
		try
		{
			query = " SELECT source_code, UPPER(source_name)  "
				  + " FROM rws_source_tbl WHERE source_type_code = '" + sourceType + "' "
				  + " AND subsource_type_code = '" + subsourceType + "' "
				  + " ORDER BY source_name";
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				sources.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return sources;
	}
	
	public ArrayList getAssetComponents(String assetType) throws Exception {
		ArrayList assetComponents = new ArrayList();
		try {
			if (assetType.equals("05") | assetType.equals("06") || assetType.equals("07") || assetType.equals("08")) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("01");
				labelValueBean.setLabel("SOURCE");
				assetComponents.add(labelValueBean);
			}	else {
				query = "SELECT asset_component_code, asset_component_name FROM RWS_ASSET_COMPONENT_TYPE_TBL WHERE type_of_asset_code= ? "
						+ "ORDER BY asset_component_code";
				conn = RwsOffices.getConn();
				ps = conn.prepareStatement(query);
				ps.setString(1, assetType);
				rset = ps.executeQuery();
				while (rset.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					assetComponents.add(labelValueBean);
				}
			}
		} catch (Exception e) {
			System.out.println("The Exceptiion in CommonLists getAssetComponents :" + e.getMessage());
		} finally {
			closeAll();
		}
		return assetComponents;
	}

	//newly
	public ArrayList getAssetSubComponents(String assetTypeCode, String assetComponentCode) throws Exception {
		ArrayList assetSubComponents = new ArrayList();
		try {
			if (assetTypeCode.equals("05")) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("001");
				labelValueBean.setLabel("SHALLOW HAND PUMPS");
				assetSubComponents.add(labelValueBean);
				return assetSubComponents;
			}
			if (assetTypeCode.equals("06")) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("001");
				labelValueBean.setLabel("OPEN WELLS");
				assetSubComponents.add(labelValueBean);
				return assetSubComponents;
			}
			if (assetTypeCode.equals("07")) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("001");
				labelValueBean.setLabel("PONDS");
				assetSubComponents.add(labelValueBean);
				return assetSubComponents;
			}
			if (assetTypeCode.equals("08")) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("001");
				labelValueBean.setLabel("OTHERS");
				assetSubComponents.add(labelValueBean);
				return assetSubComponents;
			}
			query = " SELECT asset_subcomponent_code, asset_subcomponent_name  FROM rws_asset_subcomponent_tbl WHERE type_of_asset_code=? "
					+ " AND asset_component_code = ? ORDER BY asset_subcomponent_code";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, assetTypeCode);
			ps.setString(2, assetComponentCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				assetSubComponents.add(labelValueBean);
			}
		}catch (Exception e) {
			System.out.println("Exception at getAssetSubComponents in CommonLists: "+e);
		} finally {
			closeAll();
		}
		return assetSubComponents;
	}
	
	public ArrayList getAssetTasks(String assetType, String assetComponentCode, 
			String assetSubComponentCode) throws Exception
	{
		ArrayList assetTasks = new ArrayList();
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		query = " SELECT asset_task_code, asset_task_name "
			  + " FROM rws_asset_task_tbl "
			  + " WHERE type_of_asset_code = '" + assetType + "' "
			  + " AND asset_component_code = '" + assetComponentCode + "' "
			  + " AND asset_subcomponent_code = '" + assetSubComponentCode + "' "
			  + " ORDER BY asset_task_name";
		rset = stat.executeQuery(query);
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(2));
			assetTasks.add(labelValueBean);
		}
		closeAll();
		return assetTasks;
	}
	
	public ArrayList getAssetSubTasks(String assetType, String assetComponentCode, 
			String assetSubComponentCode, String assetTaskCode) throws Exception
	{
		ArrayList assetSubTasks = new ArrayList();
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		query = " SELECT asset_sub_task_code, asset_sub_task_name "
			  + " FROM rws_asset_sub_task_tbl "
			  + " WHERE type_of_asset_code = '" + assetType + "' "
			  + " AND asset_component_code = '" + assetComponentCode + "' "
			  + " AND asset_subcomponent_code = '" + assetSubComponentCode + "' "
			  + " AND asset_task_code = '" + assetTaskCode + "' "
			  + " ORDER BY asset_sub_task_name";
		rset = stat.executeQuery(query);
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(2));
			assetSubTasks.add(labelValueBean);
		}
		closeAll();
		return assetSubTasks;
	}
	public String getAssetSubTaskDesc(String assetType, String assetComponentCode, 
			String assetSubComponentCode, String assetTaskCode, String assetSubTaskCode) throws Exception
	{
		String subTaskDesc ="";
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		query = " SELECT asset_sub_task_desc "
			  + " FROM rws_asset_sub_task_tbl "
			  + " WHERE type_of_asset_code = '" + assetType + "' "
			  + " AND asset_component_code = '" + assetComponentCode + "' "
			  + " AND asset_subcomponent_code = '" + assetSubComponentCode + "' "
			  + " AND asset_task_code = '" + assetTaskCode + "' "
			  + " AND asset_sub_task_code = '" + assetSubTaskCode + "' "; 
			 
		rset = stat.executeQuery(query);
		if(rset.next())
			subTaskDesc = rset.getString(1); 			
		
		closeAll();
		return subTaskDesc;
	}
	
	
	public ArrayList getWorkIds(String officeCode, String assetType) throws Exception
	{
		ArrayList workIds = new ArrayList();
		try
		{
			query = " SELECT work_id , UPPER(proposal_name)  "
				  + " FROM rws_work_proposal_tbl WHERE substr(work_id,7,2) = '" + assetType + "' "
				  + " AND office_code = '" + officeCode + "' "
				  + " AND work_id NOT IN (SELECT work_id FROM rws_new_est_tbl) "
				  + " ORDER BY proposal_name" ;
			
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1) + "-" + rset.getString(2));
				workIds.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return workIds;
	}
	
	public ArrayList getOMWorkIds(String officeCode, String assetType) throws Exception
	{
		ArrayList workIds = new ArrayList();
		
		try
		{
			query = " SELECT P.work_id , UPPER(A.asset_name) "
				  + " FROM rws_om_proposal_tbl P, rws_asset_mast_tbl A "
				  + " WHERE P.asset_code = A.asset_code "
				  + " AND office_code = '" + officeCode + "'"
				  + " AND work_id NOT IN (SELECT work_id FROM rws_om_est_tbl) "
				  + " AND P.work_id IS NOT NULL "
				  + " ORDER BY A.asset_name ";
						 
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1) + "-" + rset.getString(2));
				workIds.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return workIds;
	}

	public ArrayList getFinancialYears(int num)
	{
		ArrayList financialYears = new ArrayList();
		
		dateFormatter = new SimpleDateFormat("yyyy");
		java.util.Date date = new java.util.Date();

		int currentYear = Integer.parseInt(dateFormatter.format(date));
		
		for(int i=0; i< num; i++)
		{
			String nextYear = String.valueOf(currentYear + "-") + String.valueOf(currentYear+1);
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(nextYear);
			labelValueBean.setLabel(nextYear);
			financialYears.add(labelValueBean);
			currentYear--;
		
		}
				
		return financialYears;
	}

	public ArrayList getProposalIds(String assetCode, String financialYear,String district,String mandal,String panchayat,String village,String habCode,String repCode) throws Exception
	{
		ArrayList proposalIds = new ArrayList();
		query="";
	
		try
		{	
			//System.out.println("dcode="+district+"mcode="+mandal+"pcode="+panchayat+"vcode="+village+"habCode="+habCode+"repCode="+repCode);
	       if(!repCode.equals("") && repCode.length()!=0)
	       {	
			if(!district.equals(""))
			 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
				  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "' and rp.REP_CODE='"+repCode+"'"
				  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and substr(rp.LEAD_HAB_CODE,0,2)='"+district+"'";
			if(!district.equals("") && !mandal.equals(""))
				 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
					  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "'  and rp.REP_CODE='"+repCode+"'"
					  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and substr(rp.LEAD_HAB_CODE,0,2)='"+district+"' and substr(rp.LEAD_HAB_CODE,6,2)='"+mandal+"'";
			if(!district.equals("") && !mandal.equals("") && !panchayat.equals(""))
				 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
					  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "'  and rp.REP_CODE='"+repCode+"'"
					  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and substr(rp.LEAD_HAB_CODE,0,2)='"+district+"' and substr(rp.LEAD_HAB_CODE,6,2)='"+mandal+"' and substr(rp.LEAD_HAB_CODE,13,2)='"+panchayat+"'";
			if(!district.equals("") && !mandal.equals("") && !panchayat.equals("") && !village.equals(""))
				 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
					  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "'  and rp.REP_CODE='"+repCode+"'"
					  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and substr(rp.LEAD_HAB_CODE,0,2)='"+district+"'  and substr(rp.LEAD_HAB_CODE,6,2)='"+mandal+"' and substr(rp.LEAD_HAB_CODE,13,2)='"+panchayat+"' and substr(rp.LEAD_HAB_CODE,8,3)='"+village+"'";
			if(!district.equals("") && !mandal.equals("") && !panchayat.equals("") && !village.equals("") && !habCode.equals(""))
				 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
					  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "'  and rp.REP_CODE='"+repCode+"'"
					  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and rp.LEAD_HAB_CODE='"+habCode+"'";
	       }
	       else
	       {
	       	if(!district.equals(""))
				 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
					  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "' "
					  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and substr(rp.LEAD_HAB_CODE,0,2)='"+district+"'";
				if(!district.equals("") && !mandal.equals(""))
					 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
						  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "' "
						  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and substr(rp.LEAD_HAB_CODE,0,2)='"+district+"' and substr(rp.LEAD_HAB_CODE,6,2)='"+mandal+"'";
				if(!district.equals("") && !mandal.equals("") && !panchayat.equals(""))
					 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
						  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "' "
						  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and substr(rp.LEAD_HAB_CODE,0,2)='"+district+"' and substr(rp.LEAD_HAB_CODE,6,2)='"+mandal+"' and substr(rp.LEAD_HAB_CODE,13,2)='"+panchayat+"'";
				if(!district.equals("") && !mandal.equals("") && !panchayat.equals("") && !village.equals(""))
					 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
						  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "' "
						  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and substr(rp.LEAD_HAB_CODE,0,2)='"+district+"'  and substr(rp.LEAD_HAB_CODE,6,2)='"+mandal+"' and substr(rp.LEAD_HAB_CODE,13,2)='"+panchayat+"' and substr(rp.LEAD_HAB_CODE,8,3)='"+village+"'";
				if(!district.equals("") && !mandal.equals("") && !panchayat.equals("") && !village.equals("") && !habCode.equals(""))
					 query = " SELECT p.proposal_id,p.PROPOSAL_NAME FROM RWS_WORK_PROPOSAL_TBL p,rws_rep_proposal_tbl rp"
						  + " WHERE substr(p.proposal_id,3,4) = '" + financialYear + "' "
						  + " AND p.type_of_asset = '" + assetCode + "' and p.proposal_id=rp.proposal_id and rp.LEAD_HAB_CODE='"+habCode+"'";
	        }
			//System.out.println("query is "+ query);
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1)+"-"+rset.getString(2));
				proposalIds.add(labelValueBean);
			}
		}
		finally
		{	
			closeAll();
		}
		return proposalIds;
	}


	public ArrayList getOMProposalIds(String financialYear) throws Exception
	{
		ArrayList proposalIds = new ArrayList();
		try
		{	
			query = " SELECT om_proposal_id FROM rws_om_proposal_tbl "
				  + " WHERE substr(om_proposal_id,3,4) = '" + financialYear + "'";

			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1));
				proposalIds.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return proposalIds;
	}

	
	public ArrayList getHabBeans(String[] habCodes) throws Exception
	{
		conn = RwsOffices.getConn();
		ArrayList habitations = new ArrayList();
		for (int i=0; i<habCodes.length; i++)
		{
			query = " SELECT P.panch_code, P.panch_name, "
				  +	" (H.census_plain_popu + H.census_sc_popu + H.census_st_popu), "
				  + " H.coverage_status FROM rws_panchayat_raj_tbl P, "
				  + " rws_habitation_directory_tbl H " 
				  +	" WHERE P.panch_code = H.hab_code AND "
				  + " P.panch_code = '" + habCodes[i] + "'";
						
			stat = conn.createStatement();		
			rset = stat.executeQuery(query);
			RwsLocationBean rwsLocation = null;
			
			while(rset.next())
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabCode(rset.getString(1));
				rwsLocation.setHabName(rset.getString(2));
				rwsLocation.setPopulation(rset.getString(3));
				rwsLocation.setStatus(rset.getString(4));
			}
			habitations.add(rwsLocation);
		}
		closeAll();
		return habitations;
	}
	
	public ArrayList getAssetEndYears(String assetType) throws Exception
	{
		ArrayList endYears = new ArrayList();
		
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		query = " SELECT distinct end_year FROM rws_asset_mast_tbl "
			  + " WHERE type_of_asset_code = '" + assetType + "'"
			  + " ORDER BY end_year ";
		rset = stat.executeQuery(query);
		 
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			endYears.add(labelValueBean);
		}
		closeAll();
		return endYears;
	}
	
	/**
	 * Used in Representative Proposal Form for augmentation work
	 * @param assetType
	 * @param endYear
	 * @return ArrayList
	 * @throws Exception
	 */
	public ArrayList getAssetIds(String assetType, String endYear) throws Exception
	{
		ArrayList assetIds = new ArrayList();
		
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		query = " SELECT asset_code, asset_name FROM rws_asset_mast_tbl "
			  + " WHERE type_of_asset_code = '" + assetType + "'"
			  + " AND end_year = '" + endYear + "'";
		rset = stat.executeQuery(query);
		 
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(1) + "-" +rset.getString(2));
			assetIds.add(labelValueBean);
		}
		closeAll();
		return assetIds;
	}
	
	public SourceDTO getSourceDetails(String sourceCode)
	{
		SourceDTO sourceDTO = new SourceDTO();
		try
		{
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			query = " SELECT source_name, ST.source_type_name, SST.subsource_type_name, hab_code, "
				  + " no_of_habitaitons_coverd, population_benifited,  "
				  + " DECODE(seasonal,'N', 'NO', 'Y', 'YES'), "
				  + " source_condition, water_quality,"
				  + " static_water_level, summer_water_level, yield, dist_near_private_source, "
				  + " UPPER(location) FROM rws_source_tbl S, rws_source_type_tbl ST, rws_subsource_type_tbl SST "
				  + " WHERE S.source_type_code = ST.source_type_code "
				  + " AND (S.source_type_code = SST.source_type_code"
				  + " AND S.subsource_type_code = SST.subsource_type_code) "
				  + " AND S.source_code = '" + sourceCode + "'";
			rset = stat.executeQuery(query);
			while(rset.next())
			{
				sourceDTO.setSourceCode(sourceCode);
				sourceDTO.setSourceName(rset.getString(1));
				sourceDTO.setSourceTypeCode(rset.getString(2));
				sourceDTO.setSubSourceTypeCode(rset.getString(3));
				sourceDTO.setHabCode(rset.getString(4));
				sourceDTO.setNoOfHab(rset.getString(5));
				sourceDTO.setPopbenefited(rset.getString(6));
				sourceDTO.setSeasonal(rset.getString(7));
				sourceDTO.setPresentCondition(rset.getString(8));
				sourceDTO.setWaterQuality(rset.getString(9));
				sourceDTO.setStaticWaterLevel(rset.getString(10));
				sourceDTO.setSummerWaterLevel(rset.getString(11));
				sourceDTO.setYield(rset.getString(12));
				sourceDTO.setDistFromSource(rset.getString(13));
				sourceDTO.setLocation(rset.getString(14));
			}
			
		}
		catch(Exception e)
		{	//System.out.println("Exception in CommonLists.getSourceDetials():\n" + e);
		}
		finally
		{	closeAll();
		}
		
		return sourceDTO;
	}
	/* Remove this method 
	*/
	/*
	/**
	 * Gets dimensions for specified sub component 
	 * @param assetType
	 * @param componentCode
	 * @param subComponentCode
	 * @return ArrayList
	 * @throws Exception
	 */
	public ArrayList getComponentDimensions(String assetType, String componentCode, String subComponentCode)
	throws Exception
	{
		ArrayList dimensions = new ArrayList();
		conn = RwsOffices.getConn();
		stat = conn.createStatement();
		query = " SELECT measurement_type, measurement_unit "
			  + " FROM rws_subcomp_param_tbl "
			  + " WHERE type_of_asset_code = '" + assetType + "' "
			  + " AND asset_component_code = '" + componentCode + "' "
			  + " AND asset_subcomponent_code = '" + subComponentCode+ "' ";

		rset = stat.executeQuery(query);
		while (rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setLabel(rset.getString(1));
			labelValueBean.setValue(rset.getString(2));
			dimensions.add(labelValueBean);
		}
		closeAll();
		return dimensions;
	}
	public boolean isDate(String date)
	{
		boolean flag = false;
		
		String sDD = date.substring(0,2);
		String sMM = date.substring(3,5);
		String sYYYY = date.substring(6,10);
		int dd, mm, yyyy;
		if(date != null && date.length() == 10)
		{
			try
			{
				dd = Integer.parseInt(sDD);
				mm = Integer.parseInt(sMM);
				yyyy = Integer.parseInt(sYYYY);
				DateFormat df = DateFormat.getInstance();
				java.util.Date d = df.parse(date);
				
				GregorianCalendar gCal = new GregorianCalendar(yyyy,mm-1,dd);
				flag = true;
			}
			catch(Exception e)
			{	//System.out.println("Exception in isDate : \n" + e);
				flag = false;
			}
		}
		else
			flag = false;
		
		return flag;
	}
	
	public boolean isValidDate(String date)
	{
		boolean flag = false;
		
		String sDD = date.substring(0,2);
		String sMM = date.substring(3,5);
		String sYYYY = date.substring(6,10);
		int dd, mm, yyyy;
		
		try
		{
			dd = Integer.parseInt(sDD);
			mm = Integer.parseInt(sMM);
			yyyy = Integer.parseInt(sYYYY);
			GregorianCalendar gCal = new GregorianCalendar(yyyy,mm-1,dd);
		}
		catch(NumberFormatException nfe)
		{	//System.out.println("Exception in isDate : \n" + nfe);			
		}
		
		return flag;
	}
	
	 public static String  nslookup(String ipAddress) throws Exception {
	    java.net.InetAddress addr = java.net.InetAddress.getByName(ipAddress);
	    return addr.getHostName();
	  }
	
	 public ArrayList getCoverageStatuses(String habCode,String userId) throws Exception
		{
			ArrayList coverageStatuses = new ArrayList();
			try
			{
				conn = RwsOffices.getConn();
				stat=conn.createStatement();
				query = " SELECT coverage_status "
					  + " FROM rws_habitation_directory_tbl "
					  + " where hab_code= '"+habCode+"'";
					
				rset = stat.executeQuery(query);
			
				String status="";
							
				while(rset.next())
				{
					status=nic.watersoft.masters.RwsMasterData.format(rset.getString("coverage_status"));
				}
				//if(!userId.equals("admin") && !userId.equals("100000"))
				if(!userId.equals("admin"))
				{
					if(status.equalsIgnoreCase("FC"))
					{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						
					}
					else if(status.equalsIgnoreCase("PC4"))
					{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
					else if(status.equalsIgnoreCase("PC3"))
					{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
					else if(status.equalsIgnoreCase("PC2"))
					{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
					else if(status.equalsIgnoreCase("PC1"))
					{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
					else if(status.equalsIgnoreCase("NSS"))
					{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NC");
						labelValueBean.setLabel("NC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
					else if(status.equalsIgnoreCase("NC"))
					{
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NC");
						labelValueBean.setLabel("NC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
					else if(status.equalsIgnoreCase("UI"))
					{
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NC");
						labelValueBean.setLabel("NC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
					else if(status.equalsIgnoreCase(""))
					{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NC");
						labelValueBean.setLabel("NC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
				}
				else
				{
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("PC1");
					labelValueBean.setLabel("PC1");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("PC2");
					labelValueBean.setLabel("PC2");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("PC3");
					labelValueBean.setLabel("PC3");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("PC4");
					labelValueBean.setLabel("PC4");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("FC");
					labelValueBean.setLabel("FC");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("NSS");
					labelValueBean.setLabel("NSS");
					coverageStatuses.add(labelValueBean);
					
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("NC");
					labelValueBean.setLabel("NC");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("UI");
					labelValueBean.setLabel("UI");
					coverageStatuses.add(labelValueBean);
				}
					
			}
			catch(Exception e){
				//System.out.println("Exception in getCoverageStatuses is "+e);}
			}
			finally
			{	closeAll();
			}
			
			return coverageStatuses;
		}
	 
	 
	 public ArrayList getNssHabs(String dcode) throws Exception
		{
			ArrayList nssHabs = new ArrayList();
			try
			{
				conn = RwsOffices.getConn();
				query = " SELECT hd.hab_code,pr.panch_name "
					  + " FROM rws_habitation_directory_tbl hd,rws_panchayat_raj_tbl pr  "
					  + " where hd.hab_code=pr.panch_code and hd.coverage_status=? and substr(hd.hab_code,1,2)=?"
					  + " ORDER BY pr.panch_name";							 
				//stat = conn.createStatement();
				ps = conn.prepareStatement(query);
				ps.setString(1, "NSS");
				ps.setString(2, dcode);
				rset = ps.executeQuery();
				//rset = stat.executeQuery(query);
				while(rset.next()){
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					labelValueBean.setLabelValue(rset.getString(2)+" - " + rset.getString(1));
					nssHabs.add(labelValueBean);
				}
			}catch(Exception e){
				System.out.println("Exception in getNssHabs In CommonLists is "+e);
			}finally{	
				closeAll();				
			}
			//System.out.println("nssHabs sizse is "+nssHabs.size());
			return nssHabs;
		}
	 
	 public ArrayList getAdminWorkIdsAsIds(String circleOfficeCode) throws Exception
		{
			ArrayList workIdList = new ArrayList();
			
			try
			{
				conn = RwsOffices.getConn();
				String query = " SELECT WORK_ID,work_name "
							 + " FROM rws_work_admn_tbl where substr(work_id,5,2)='"+circleOfficeCode+"' ORDER BY work_id ";
							 
				//System.out.println("query is "+query);
				stat = conn.createStatement();
				rset = stat.executeQuery(query);
				while(rset.next())
				{
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					//labelValueBean.setLabel(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					workIdList.add(labelValueBean);
				}
			}
			finally
			{	
				closeAll();
			}
			return workIdList;
		}
	 
	 public ArrayList getMonths() throws Exception
		{
	 	String months[]={"","January","Feburary","March","April","May","June","July","August","September","October","November","December"};
        ArrayList monthsList = new ArrayList();
			
			try
			{
				
				
				for(int i=1;i<months.length;i++)
				{
					String month=i+"";
					if(month.length()==1)
						month="0"+month;
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(month);
					labelValueBean.setLabel(months[i]);
					monthsList.add(labelValueBean);
				}
			}
			finally
			{	
				closeAll();
			}
			return monthsList;
		}
	 	


	 public ArrayList getAssetTypes() throws Exception {
			ArrayList assetTypes = new ArrayList();	
			try	{
				query="SELECT type_of_asset_code , UPPER(type_of_asset_name) FROM rws_asset_type_tbl  where type_of_asset_code<> 10 "+
				" order by (case  type_of_asset_name  when 'CPWS'  THEN 1 when 'PWS' THEN 2  when 'MPWS' THEN 3 when 'DIRECT PUMPING' THEN 4 "+
				" when 'HANDPUMPS' THEN 5 when 'SHALLOW HAND PUMPS' THEN 6  when 'OPEN WELLS' THEN 7 when 'PONDS' THEN 8 when 'OTHERS' THEN 9 END) ASC ";
				conn = RwsOffices.getConn();
				ps = conn.prepareStatement(query);
				rset = ps.executeQuery();		
				while(rset.next()){
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					assetTypes.add(labelValueBean);
				}
			}
			catch(Exception e){
				System.out.println("The Exceptiion in CommonLists getAssetTypes :"+e.getMessage());
			}
			finally {	
				closeAll();
			}
			return assetTypes;
		}
	 

public ArrayList getAssets(String habCode,String schoolCode,String[] assetTypess) throws Exception
{
	ArrayList assetTypes = new ArrayList();
	Statement sst=null;
	ResultSet rss = null;
	try
	{
		conn = RwsOffices.getConn();
		Debug.println("assetTypess.length:"+assetTypess.length);
		for(int i=0;i<assetTypess.length;i++)
		{
			String typeOfAsset="";
			if(assetTypess[i].equals("01"))typeOfAsset="PWS";
			else if(assetTypess[i].equals("02"))typeOfAsset="MPWS";
			else if(assetTypess[i].equals("03"))typeOfAsset="CPWS";
			else if(assetTypess[i].equals("04"))typeOfAsset="HAND PUMPS";
			else if(assetTypess[i].equals("05"))typeOfAsset="SHALLOW HANDPUMP";
			else if(assetTypess[i].equals("06"))typeOfAsset="OPENWELL";
			else if(assetTypess[i].equals("07"))typeOfAsset="PONDS";
			else if(assetTypess[i].equals("08"))typeOfAsset="OTHERS";
			else if(assetTypess[i].equals("09"))typeOfAsset="DIRECT PUMPING";
			
			String assetTypeCode=assetTypess[i];
			query = "select a.asset_code,asset_name,nvl(location,'-') as location,nvl(to_char(date_creation,'dd-MM-YYYY'),'-') as date_creation,nvl(a.asset_cost,'0')as asset_cost from rws_asset_mast_tbl a,rws_asset_hab_tbl b where a.asset_code=b.asset_code and b.hab_code='"+habCode+"' and TYPE_OF_ASSET_CODE ='"+assetTypeCode+"'";
			Debug.println("get assetss:"+query); 
			
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				//labelValueBean = new LabelValueBean();
				Rws_SchoolDetailsBean rs = new Rws_SchoolDetailsBean();
			//	labelValueBean.setValue(rset.getString("asset_code"));
				/*String creation = rset.getString("date_creation");
				if(creation==null)creation="-";
				String loc = rset.getString("location");
				if(loc==null)loc="-";*/
				//labelValueBean.setLabel("ASSET - "+rset.getString("asset_name")+" / "+rset.getString("asset_cost")+" / "+rset.getString("location")+" / "+rset.getString("date_creation"));
				sst = conn.createStatement();
				String selqry = "select * from rws_school_asset_lnk_tbl where hab_code='"+habCode+"' and school_code='"+schoolCode+"' and asset_code='"+rset.getString(1)+"'";
				rss = sst.executeQuery(selqry);
				if(rss.next())
					rs.setAlreadyExists("Y");
				else
					rs.setAlreadyExists("N");
				rs.setType("ASSET");
				rs.setAssetTypeName(typeOfAsset);
				rs.setAssetCode(rset.getString(1));
				rs.setAssetName(rset.getString(2));
				rs.setLocation(rset.getString(3));
				rs.setDate(rset.getString(4));
				rs.setAssetCost(rset.getString(5));
				assetTypes.add(rs);
			}
			query = "SELECT a.WORK_ID,a.WORK_NAME,a.sanction_amount,to_char(c.date_of_comm,'dd-mm-yyyy') as date_of_comm FROM rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_work_completion_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.work_id=c.work_id and b.hab_code='"+habCode+"' and substr(a.work_id,7,2)='"+assetTypeCode+"' and DATE_OF_COMM is not null and a.work_id not in(select asset_code from rws_asset_mast_tbl)";
			//query = "SELECT a.WORK_ID,a.WORK_NAME,a.sanction_amount,to_char(b.date_of_comm,'dd/mm/yyyy') as date_of_comm FROM rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b where a.work_id=b.work_id and b.hab_code='"+habCode+"' and substr(a.work_id,7,2)='"+assetTypeCode+"' and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null)";
			Debug.println("get works:"+query); 
			stat.close();stat=null;
			rset.close();rset=null;
			if(sst!=null){sst.close();sst=null;}
			if(rss!=null){rss.close();rss=null;}
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				Rws_SchoolDetailsBean rs = new Rws_SchoolDetailsBean();
				//labelValueBean = new LabelValueBean();
			//	labelValueBean.setValue(rset.getString("asset_code"));
				/*String creation = rset.getString("date_creation");
				if(creation==null)creation="-";
				String loc = rset.getString("location");
				if(loc==null)loc="-";*/
				//labelValueBean.setLabel("ASSET - "+rset.getString("asset_name")+" / "+rset.getString("asset_cost")+" / "+rset.getString("location")+" / "+rset.getString("date_creation"));
				
				sst = conn.createStatement();
				String selqry = "select * from rws_school_asset_lnk_tbl where hab_code='"+habCode+"' and school_code='"+schoolCode+"' and asset_code='"+rset.getString(1)+"'";
				Debug.println("1:"+selqry);
				rss = sst.executeQuery(selqry);
				Debug.println("2:"+rss);
				if(rss.next())
					rs.setAlreadyExists("Y");
				else
					rs.setAlreadyExists("N");
				Debug.println("3");
				Debug.println("in works");
				rs.setType("WORK");
				rs.setAssetTypeName(typeOfAsset);
				rs.setAssetCode(rset.getString(1));
				rs.setAssetName(rset.getString(2));
				rs.setLocation("-");
				rs.setDate(rset.getString(4));
				rs.setAssetCost(rset.getString(3));
				assetTypes.add(rs);
			}
			//stat.close();stat=null;
			//rset.close();rset=null;
		}
		
	}
	catch(Exception e)
	{
		Debug.println("error:"+e.getMessage());
		e.getMessage();
	}
	finally
	{	closeAll();
	}
	return assetTypes;
}

public int saveAssets(String habCode,String schoolCode,String[] assets) throws Exception
{
	int count = 0;
	try
	{
		conn = RwsOffices.getConn();
	    PreparedStatement stmt = null;
		String aa = "delete from rws_school_asset_lnk_tbl where hab_code=? and school_code=?";
		//Statement ss = conn.createStatement();
		stmt = conn.prepareStatement(aa);
		stmt.setString(1, habCode);
		stmt.setString(2, schoolCode);
		stmt.executeUpdate();
		for(int i=0;i<assets.length;i++)
		{
			String assetTypeCode=assets[i];
			query = "insert into rws_school_asset_lnk_tbl values (?,?,?)";
			Debug.println("save assetsshh:"+query); 
			//stat = conn.createStatement();
			PreparedStatement stmt1 = conn.prepareStatement(query);
			stmt1.setString(1,habCode);
			stmt1.setString(2,schoolCode);
			stmt1.setString(3, assets[i]);
			Debug.println("in 1:"+stat);
			count += stmt.executeUpdate();
			Debug.println("in 2");
			System.out.println("count:"+count);
			stat.close();
		}
		
	}
	catch(Exception e)
	{
		e.getMessage();
	}
	finally
	{	closeAll();
	}
	return count;
}

public ArrayList getSubprgList(String prgcode)
       throws Exception
   {
       ArrayList getSubprgList;
       getSubprgList = new ArrayList();
       try
       {
           conn = RwsOffices.getConn();
           
           query = "select distinct SUBPROGRAMME_CODE,SUBPROGRAMME_NAME  from rws_subprogramme_tbl where PROGRAMME_CODE=? order by SUBPROGRAMME_CODE";
          ps=conn.prepareStatement(query);
          ps.setString(1, prgcode);
           for(rset = ps.executeQuery(); rset.next(); getSubprgList.add(labelValueBean))
           {
               labelValueBean = new LabelValueBean();
               labelValueBean.setValue(rset.getString(1));
               labelValueBean.setLabel(rset.getString(2));
               labelValueBean.setLabelValue(rset.getString(1) + "-" + rset.getString(2));
           }

       }
       catch(Exception e)
       {
           Debug.println("Exception in getSubprgList:" + e);
       }
       finally
       {
           closeAll();
       }
       return getSubprgList;
   }




public ArrayList getMajorHeadList() throws Exception
{
	ArrayList majorheadList=new ArrayList();
	try{
		conn = RwsOffices.getConn();
		
		query="select major_head_code,major_head_name from rws_majorhead_tbl order by major_head_code";
		ps = conn.prepareStatement(query);
		rset = ps.executeQuery();
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(1));
			labelValueBean.setLabelValue(rset.getString(1)+"-"+ rset.getString(2));
			majorheadList.add(labelValueBean);
		}
		
	}catch(Exception e)
	{
	 Debug.println("Exception getting major head:"+e);	
	}
	finally
	{	closeAll();
	}

return majorheadList;
}

public ArrayList getSubmajorHeadList(String mhcode) throws Exception
{
	ArrayList submajorheadList=new ArrayList();
	try{
		conn = RwsOffices.getConn();
		
		query="select submajor_head_code,submajor_head_name from rws_submajorhead_tbl where major_head_code=?";
		ps = conn.prepareStatement(query);
		ps.setString(1, mhcode);
		rset = ps.executeQuery();
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(1)+"-"+ rset.getString(2));
			labelValueBean.setLabelValue(rset.getString(1)+"-"+ rset.getString(2));
			submajorheadList.add(labelValueBean);
		}
		
	}catch(Exception e)
	{
	 Debug.println("Exception getting submajor head:"+e);	
	}finally
	{	closeAll();
}

return submajorheadList; 
}
      

public ArrayList getMinorHeadList(String mhcode,String shcode) throws Exception
{
	ArrayList minorheadList=new ArrayList();
	try{
		conn = RwsOffices.getConn();
		
		query="select minor_head_code,minor_head_name from rws_minorhead_tbl where major_head_code=? and submajor_head_code=?";
		ps = conn.prepareStatement(query);
		ps.setString(1, mhcode);
		ps.setString(2, shcode);
		rset = ps.executeQuery();  
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(1)+"-"+ rset.getString(2));
			labelValueBean.setLabelValue(rset.getString(1)+"-"+ rset.getString(2));
			minorheadList.add(labelValueBean);
		}
		
	}catch(Exception e)
	{
	 Debug.println("Exception getting minor head:"+e);	
	}finally
	{	closeAll();
}

return minorheadList;
}

public ArrayList getGroupHeadList(String mhcode,String shcode,String mincode) throws Exception
{
	ArrayList groupheadList=new ArrayList();
	try{
		conn = RwsOffices.getConn();
		
		query="select grp_subhead_code,grpr_subhead_name from rws_groupsubhead_tbl where major_head_code=? and submajor_head_code=? and minor_head_code=?";
		ps = conn.prepareStatement(query);
		ps.setString(1, mhcode);
		ps.setString(2, shcode);
		ps.setString(3, mincode);
		rset = ps.executeQuery();  
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(1)+"-"+ rset.getString(2));
			labelValueBean.setLabelValue(rset.getString(1)+"-"+ rset.getString(2));
			groupheadList.add(labelValueBean);
		}
		
	}catch(Exception e)
	{
	 Debug.println("Exception getting minor head:"+e);	
	}finally
	{	closeAll();
}

return groupheadList;
}
public ArrayList getSubHeadList(String mhcode,String shcode,String mincode,String gphcode) throws Exception
{
	ArrayList subheadList=new ArrayList();
	try{
		conn = RwsOffices.getConn();
		
		query="select subhead_code,subhead_name from rws_subhead_tbl where major_head_code=? and submajor_head_code=? and minor_head_code=? and grp_subhead_code=?";
		ps = conn.prepareStatement(query);
		ps.setString(1, mhcode);
		ps.setString(2, shcode);
		ps.setString(3, mincode);
		ps.setString(4, gphcode);
		rset = ps.executeQuery();  
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(1)+"-"+ rset.getString(2));
			labelValueBean.setLabelValue(rset.getString(1)+"-"+ rset.getString(2));
			subheadList.add(labelValueBean);
		}
		
	}catch(Exception e)
	{
	 Debug.println("Exception getting minor head:"+e);	
	}finally
	{	closeAll();
}

return subheadList;
}
public ArrayList getDetailHeadList(String mhcode,String shcode,String mincode,String gphcode,String subcode) throws Exception
{
	ArrayList detailheadList=new ArrayList();
	try{
		conn = RwsOffices.getConn();
		
		query="select detail_head_code,detail_head_name from rws_detailhead_tbl where major_head_code=? and submajor_head_code=? and minor_head_code=? and grp_subhead_code=? and subhead_code=? ";
		ps = conn.prepareStatement(query);
		ps.setString(1, mhcode);
		ps.setString(2, shcode);
		ps.setString(3, mincode);
		ps.setString(4, gphcode);
		ps.setString(5, subcode);
		
		rset = ps.executeQuery();  
		while(rset.next())
		{
			
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(1)+"-"+ rset.getString(2));
			labelValueBean.setLabelValue(rset.getString(1)+"-"+ rset.getString(2));
			detailheadList.add(labelValueBean);
		}
		
	}catch(Exception e)
	{
	 Debug.println("Exception getDetailHeadList:"+e);	
	}finally
	{	closeAll();
}

return detailheadList;
}

public ArrayList getSubDetailHeadList(String mhcode,String shcode,String mincode,String gphcode,String subcode,String dtcode) throws Exception
{
	ArrayList subdetailheadList=new ArrayList();
	try{
		conn = RwsOffices.getConn();
		query="select subdetail_head_code,subdetail_head_name from rws_subdetail_tbl where major_head_code=? and submajor_head_code=? and minor_head_code=? and grp_subhead_code=? and subhead_code=? and detail_head_code=? ";
		ps = conn.prepareStatement(query);
		ps.setString(1, mhcode);
		ps.setString(2, shcode);
		ps.setString(3, mincode);
		ps.setString(4, gphcode);
		ps.setString(5, subcode);
		ps.setString(6, dtcode);
		rset = ps.executeQuery();  
		while(rset.next())
		{
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(1)+"-"+ rset.getString(2));
			labelValueBean.setLabelValue(rset.getString(1)+"-"+ rset.getString(2));
			subdetailheadList.add(labelValueBean);
		}
		
	}catch(Exception e)
	{
	 Debug.println("Exception getting subdetail head:"+e);	
	}finally
	{	closeAll();
}

return subdetailheadList;
}

public ArrayList getHeadOfAccountList() throws Exception
	{
		ArrayList headOfAccountList = new ArrayList();
		
		try
		{
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			//query = " SELECT HEAD_OF_ACCOUNT , HEAD_OF_ACCOUNT_NAME  FROM RWS_HEAD_OF_ACCOUNT_TBL ORDER BY HEAD_OF_ACCOUNT_NAME";
			query="select a.major_head_code||'-'||b.submajor_head_code||'-'||c.MINOR_HEAD_CODE||'-'||d.GRP_SUBHEAD_CODE||'-'||e.SUBHEAD_CODE||'-'||f.DETAIL_HEAD_CODE||'-'||g.SUBDETAIL_HEAD_CODE as code from rws_majorhead_tbl a,rws_submajorhead_tbl b,rws_minorhead_tbl c,rws_groupsubhead_tbl d,rws_subhead_tbl e,rws_detailhead_tbl f,rws_subdetail_tbl g where a.major_head_code=b.major_head_code and a.major_head_code=c.major_head_code and b.submajor_head_code=c.submajor_head_code and a.major_head_code=d.major_head_code and b.submajor_head_code=d.submajor_head_code and c.MINOR_HEAD_CODE = d.minor_head_code and a.major_head_code=e.major_head_code and b.submajor_head_code=e.submajor_head_code and c.MINOR_HEAD_CODE = e.minor_head_code and d.GRP_SUBHEAD_CODE = e.GRP_SUBHEAD_CODE and a.major_head_code=f.major_head_code and b.submajor_head_code=f.submajor_head_code and c.MINOR_HEAD_CODE = f.minor_head_code and d.GRP_SUBHEAD_CODE = f.GRP_SUBHEAD_CODE and e.SUBHEAD_CODE=f.SUBHEAD_CODE and a.major_head_code=g.major_head_code and b.submajor_head_code=g.submajor_head_code and c.MINOR_HEAD_CODE = g.minor_head_code and d.GRP_SUBHEAD_CODE = g.GRP_SUBHEAD_CODE and e.SUBHEAD_CODE=g.SUBHEAD_CODE and f.DETAIL_HEAD_CODE=g.DETAIL_HEAD_CODE";
			//System.out.println("query is "+query);
			rset = stat.executeQuery(query);
			  
			while(rset.next())
			{
				labelValueBean = new LabelValueBean(); 
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1));
				headOfAccountList.add(labelValueBean);
			}
		}
		finally
		{	
			closeAll();
		}
		return headOfAccountList;
	}
	public String getCategoryName(String pcode) throws Exception
	{
		String pname = "";
		try
		{
			conn = RwsOffices.getConn();
			String query = " SELECT category_name FROM rws_work_category_tbl where category_code='"+pcode+"'";
			Debug.println(""+query );			 
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				pname = rset.getString(1);
			}
		}
		finally
		{	
			closeAll();
		}
		return pname;
	}
	
//	code addded by sridhar for getting workis for ts preparation
	public ArrayList getWorkIds(String ccode,String divcode,String subcode,String assetType) throws Exception
	{
	 ArrayList work=new ArrayList();
	 StringBuffer qry=new StringBuffer(); 
	 try{
	 conn = RwsOffices.getConn();
	 stat = conn.createStatement();
	 qry.append("select work_id,work_name from rws_work_admn_tbl where admin_date is not null  and  work_id not in (select work_id from rws_new_est_tbl) and  substr(office_code,2,2)='"+ccode+"' ");
	 if(divcode!=null && !divcode.equals("")&& !divcode.equals("0")){
	 qry.append(" and  substr(office_code,4,1)='"+divcode+"' ");}
	 if(subcode!=null && !subcode.equals("")&& !subcode.equals("0")){
	 qry.append(" and  substr(office_code,5,2)='"+subcode+"'");}
	 if(assetType!=null && !assetType.equals("")){
	 qry.append(" and  category_code ='"+assetType+"'");}
	 qry.append(" order by 1");
	 Debug.println("qry:"+qry);
	 rset = stat.executeQuery(qry.toString());
	 while(rset.next())
	 {
	 	labelValueBean = new LabelValueBean();
		labelValueBean.setValue(rset.getString(1));
		labelValueBean.setLabel(rset.getString(1) + "-" + rset.getString(2));
		work.add(labelValueBean);
	 }
	 }catch(Exception e){
	 	Debug.println("Exception in getting workids..:"+e);
	 }
	 finally
		{	closeAll();
		}
	 return work;
	}
	//code added by sridhar for tsmilestones
	public ArrayList getAssetTypes1() throws Exception
	 {
		ArrayList assetTypes = new ArrayList();
		  
		try  
		{
			//query = " SELECT type_of_asset_code , UPPER(type_of_asset_name)  "
				//  + " FROM rws_asset_type_tbl order by type_of_asset_name";
			//query="SELECT type_of_asset_code , UPPER(type_of_asset_name) FROM rws_asset_type_tbl   order by (case  type_of_asset_name  when 'CPWS'  THEN 1  when 'PWS' THEN 2  when 'MPWS' THEN 3 when 'DIRECT PUMPING' THEN 4  when 'HANDPUMPS' THEN 5 when 'SHALLOW HAND PUMPS' THEN 6  when 'OPEN WELLS' THEN 7  when 'PONDS' THEN 8 when 'OTHERS' THEN 9 when 'SUSTAINBILITY' THEN 10 END ) ASC ";
			query="select distinct a.category_code,category_name from rws_work_category_tbl a,rws_work_admn_tbl b where a.category_code=b.category_code order by 1 ";
			
			Debug.println("qry::::::::::::::::::::::::::"+query);
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				assetTypes.add(labelValueBean);
			}
		}
		finally
		{	closeAll();
		}
		return assetTypes;
	}
	public ArrayList getWorks(String ccode,String divcode,String subcode,String wrkcat) throws Exception
	{
	  ArrayList work=new ArrayList();
	  StringBuffer qry=new StringBuffer(); 
		 try{
		 conn = RwsOffices.getConn();
		
		 qry.append("select work_id,work_name from rws_work_admn_tbl where  substr(office_code,2,2)=?  and  category_code =?");
		 if(divcode!=null && !divcode.equals("")&& !divcode.equals("0")){
		 qry.append(" and  substr(office_code,4,1)=? ");}
		 if(subcode!=null && !subcode.equals("")&& !subcode.equals("0")){
		 qry.append(" and  substr(office_code,5,2)=?");}
		 qry.append(" order by 1");
		
		 ps = conn.prepareStatement(qry.toString());
		 
			 ps.setString(1, ccode);
			 ps.setString(2, wrkcat);
		 
		 	if(divcode!=null && !divcode.equals("")&& !divcode.equals("0")){
				ps.setString(3, divcode);
			}
			if(subcode!=null && !subcode.equals("") && !subcode.equals("0")){
				ps.setString(4, subcode);
			}
			
		 rset = ps.executeQuery();
		 while(rset.next())  
		 {
		 	labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(1) + "-" + rset.getString(2));
			work.add(labelValueBean);
		 }
		 
		 }catch(Exception e){
		 	Debug.println("Exception in CommonLists getWorks:"+e);
		 }
		 finally
			{	closeAll();
			}
	  
	 return work;
	}



public ArrayList getLocalityAssetTypes(String ccode,String divcode,String subcode) throws Exception
{
	ArrayList assetTypes = new ArrayList();
	StringBuffer query=new StringBuffer();
	try
	{
		query.append("select distinct a.category_code,category_name from rws_work_category_tbl a,rws_work_admn_tbl b where a.category_code=b.category_code and substr(office_code,2,2)=?");
		if(divcode!=null && !divcode.equals("") && !divcode.equals("0"))
		{
		 query.append(" and substr(office_code,4,1)=?");
		}
		if(subcode!=null && !subcode.equals("") && !subcode.equals("0"))
		{
		 query.append(" and substr(office_code,5,2)=?");
		}
		query.append(" order by 1 ");
		conn = RwsOffices.getConn();
		ps = conn.prepareStatement(query.toString());
		ps.setString(1, ccode);
		if(divcode!=null && !divcode.equals("") && !divcode.equals("0"))
		{
			ps.setString(2, divcode);
		}
		if(subcode!=null && !subcode.equals("") && !subcode.equals("0"))
		{
			ps.setString(3, subcode);
		}
		
		rset = ps.executeQuery();
		
		while(rset.next())
		{ 
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(2));
			assetTypes.add(labelValueBean);
		}
	}
	catch( Exception e){
		Debug.println("Exception in CommonLists getLocalityAssetTypes:"+e);
	}
	finally
	{	closeAll();
	}
	return assetTypes;
}
public String getWorkStatus(String work_id,Connection conn1) throws Exception
	{
		String returnValue="";
		ArrayList status = new ArrayList();
		Statement stmt1 = null,stmt2=null,stmt3=null;
		ResultSet rs = null,rs1 = null,rs2 = null;
		String qry ="";
		//Debug.println("1:"+work_id);
			try {
						//conn1 = RwsOffices.getConn();
						closeStatement(stmt1);	
						stmt1 = conn1.createStatement();
						qry = "select to_char(date_of_completion,'dd/mm/yyyy'),to_char(date_of_comm,'dd/mm/yyyy'),to_char(DT_FIN_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='"+work_id+"'";
					//	Debug.println("1:"+qry);
						closeResultSet(rs);
						rs1 = stmt1.executeQuery(qry);
						if(rs1.next())
						{
								if(rs1.getString(3)!=null && !rs1.getString(3).equals(""))
								{
									status.add(0,"Financially Completed");
									status.add(1,rs1.getString(3));
									returnValue = "Financially Completed";
								}
								else if(rs1.getString(2)!=null && !rs1.getString(2).equals(""))
								{
									status.add(0,"Commissioned");
									status.add(1,rs1.getString(2));
									returnValue = "Commissioned";
								}
								else if(rs1.getString(1)!=null && !rs1.getString(1).equals("")) 
								{
									status.add(0,"Completed");
									status.add(1,rs1.getString(1));
									returnValue = "Completed";
								}
						}
						else
						{
							String groundDate = "";
							closeStatement(stmt2);	
							stmt2 = conn1.createStatement();
							String qry1 = "select to_char(grounding_date,'dd/mm/yyyy') from rws_work_commencement_tbl where work_id='"+work_id+"'";
							//Debug.println("3:"+qry1);
							closeResultSet(rs);
							rs = stmt2.executeQuery(qry1);
							if(rs.next())
							{
								status.add(0,"Grounded");
								status.add(1,groundDate);
								returnValue = "Grounded";
							}
							else
							{
								status.add(0,"Not Grounded");
								status.add(1,groundDate);
								returnValue = "Not Grounded";							
							}
						}
				} catch (Exception e) {
				Debug.println("The error in get sub hab name="+  e);
			} finally {
				try{
					closeResultSet(rs2);
					closeResultSet(rs1);
					closeResultSet(rs);
					closeStatement(stmt1);
					closeStatement(stmt2);
					closeStatement(stmt3);
			   }
			catch(Exception e)
				{
				Debug.println("getting closing ResultSet"+e);
			}
		}
			//Debug.println("Finally return value:"+returnValue);
	return returnValue;
	}
	/*
	 * 
	 * @author ramesh ends
	 *
	 */

	public static void closeConnection(Connection conn)
	{
		try
		{
			if(conn!=null)conn.close();
			if(!conn.isClosed())conn.close();
			conn=null;
		}
		catch(Exception e)
		{
			Debug.println("Close Connection Method:"+e.getMessage());
		}
		finally
		{
			try
			{
				if(conn!=null)conn.close();
				if(!conn.isClosed())conn.close();
				conn=null;
			}
			catch(Exception e)
			{
				Debug.println("Close Connection Method:"+e.getMessage());
			}
		}
	}
	
	public static void closeStatement(Statement stmt)
	{
		try
		{
			if(stmt!=null)stmt.close();
			stmt = null;
		}
		catch(Exception e)
		{
			Debug.println("Close Statement Method:"+e.getMessage());
		}
		finally
		{
			try
			{
				if(stmt!=null)stmt.close();
				stmt = null;
			}
			catch(Exception e)
			{
				Debug.println("Close Statement Method:"+e.getMessage());
			}
		}
	}
	
	public static void closeResultSet(ResultSet rs)
	{
		try
		{
			if(rs!=null)rs.close();
			rs = null;
		}
		catch(Exception e)
		{
			Debug.println("Close RS Method:"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)rs.close();
				rs = null;
			}
			catch(Exception e)
			{
				Debug.println("Close RS Method:"+e.getMessage());
			}
		}
	}
}