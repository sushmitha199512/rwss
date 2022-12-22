package nic.watersoft.estimates;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.ProgrammeSubProgrammeBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.proposals.ProposalDTO;
import nic.watersoft.works.rws_works_WorkStatus_bean;
import nic.watersoft.works.rws_works_WorkStatus_form;

public class EstimateDAO 
{   
	private DataSource dataSource;
	private Connection conn;
	private Statement stat, tempStat;
	private ResultSet rset, tempRset;
	private String query;
	private boolean flag;
	private EstimateDTO estimateDTO;
	private RwsOffices rwsOffices;
	public int HEAD_OF_OFFICE_COUNT = 1;
	String content = null;  
	public EstimateDAO(DataSource dataSource)
	{	
		this.dataSource = dataSource;
	}
	
	private void closeAll()
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
	
	public boolean consider(EstimateDTO estimateDTO) throws Exception
	{
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		stat = conn.createStatement();
		
		String workId = estimateDTO.getWorkId();
		String assetComponentCode = null;
		//System.out.println("in EstimateDAO.java consider function");
				
		query = " INSERT INTO rws_new_est_tbl(office_code, work_id, financial_year,"
			  + " source_code, type_of_asset_code, total_components,"
			  + " estimate_amount, sanctioned_amount,"
			  + " design_draw_upld_date, detail_est_upld_date, remarks, "
			  + " prepared_by, prepared_on) VALUES( " 
			  + " '" + estimateDTO.getOfficeCode() + "'," 
			  + " '" + workId + "'," 
			  + " '" + estimateDTO.getFinancialYear() + "'," 
			  + " '" + estimateDTO.getSourceCode() + "',"
			  + " '" + estimateDTO.getAssetType() + "'," 
			  + estimateDTO.getTotalComponents() + "," 
			  + estimateDTO.getEstimateAmount() + ","  
			  + estimateDTO.getSanctionedAmount() + "," 
			  + " SYSDATE, SYSDATE, " 
			  + " '" + estimateDTO.getRemarks() + "', " 
			  + " '" + estimateDTO.getUserId() + "', SYSDATE )";
		//System.out.println("Estimate Query");
		//System.out.println(query);
		
		stat.addBatch(query);
		/*//CODE ADDED BY SANTOSH
		query ="INSERT INTO rws_new_est_workflow_tbl(work_id,flag,track_no) VALUES("
			+ "'" + workId +"',"
			+ "'N',0)";
		//System.out.println("Workflow Query");
		//System.out.println(query);
		
		stat.addBatch(query);
		
		//END
*/
		ArrayList components = estimateDTO.getComponents();
		Iterator iterator = components.iterator();
					
		EstimateHolder component = null;
		
		//System.out.println("components.size(): " + components.size());
			
		while(iterator.hasNext())
		{
			component = (EstimateHolder)iterator.next();
			assetComponentCode = component.getAssetComponent();
			
			if(assetComponentCode != null && !assetComponentCode.equals(""))
			{
				query = " INSERT INTO rws_new_est_comp_lnk_tbl VALUES(" 
					  + " '" + workId + "',"
					  + " '" + component.getAssetComponent() + "',"
					  + " '" + component.getAmount() + "')";
				//System.out.println("Component Query");
				//System.out.println(query);
				stat.addBatch(query);
			}
		 }
		
		 int updateCounts[] = stat.executeBatch();
		 flag = true;
		 for(int i=0; i<updateCounts.length; i++)
		 {
			 if(updateCounts[i] == 0)
				 flag = false;
		 }
		 
		 if(flag)
			conn.commit();

		 conn.setAutoCommit(true);
		 closeAll();
		 return flag;
	}
	
	/**
	*
	*
	*/
	public boolean submit(String[] workIds, EstimateDTO estimateDTO)
	{
		//System.out.println("submit() in EstimateDAO called.");
		String actionFrom = estimateDTO.getOfficeCode();
		String actionTo = estimateDTO.getSubmitTo();
		String sentBy = estimateDTO.getUserId();
		String sentTo = null;
		String officeType = null;
		
		try
		{
			int length = workIds.length;
			//System.out.println("length : " + length);
	
			if(!actionTo.substring(4,6).equals("00"))
				officeType = "SUB DIVISION OFFICE";
			else
			if(!actionTo.substring(3,4).equals("0"))
					officeType = "DIVISION OFFICE";
			else
			if(!actionTo.substring(1,3).equals("00"))
				officeType = "CIRCLE OFFICE";
			else
			if(!actionTo.substring(0,1).equals("0"))
				officeType = "HEAD OFFICE";
		
			query = " SELECT user_id FROM rws_password_tbl WHERE designation_code = "
				  + " (SELECT designation_code FROM rws_head_of_office_tbl WHERE office LIKE '" + officeType + "')" 
				  + " AND office_code = '" + actionTo + "'";
					
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			int rowCount = 0;
			while(rset.next())
			{
				rowCount++;
				sentTo = rset.getString(1);
			}
			if(rowCount != 1)
			{
				HEAD_OF_OFFICE_COUNT = rowCount;
				return false;
			}
			
			conn.setAutoCommit(false);
	
			for(int i=0; i<length; i++)
			{
				int trackNo = getNextTrackNo(workIds[i]);
				//System.out.println("conn.getAutoCommit() : " + conn.getAutoCommit());
				if(trackNo > 1)
				{
					query = " UPDATE rws_new_est_workflow_tbl SET flag = 'Y' WHERE "
						  + " work_id = '" + workIds[i] + "' AND track_no = " + (trackNo-1);
					//System.out.println("query1 is"+query);
					stat.addBatch(query);
				}
				
				query = " INSERT INTO rws_new_est_mirr_tbl(office_code, work_id, financial_year, source_code, "
					  + " type_of_asset_code, total_components, estimate_amount, sanctioned_amount, "
					  + " design_draw_upld_date, detail_est_upld_date, ts_office, ts_given_by, ts_no, ts_date, "
					  + " remarks, prepared_by, prepared_on, modified_by, modified_on, ts_amount, ssr_year)"
					  + " (SELECT office_code, work_id, financial_year, source_code, type_of_asset_code, "
					  + " total_components, estimate_amount, sanctioned_amount, design_draw_upld_date, "
					  + " detail_est_upld_date, ts_office, ts_given_by, ts_no, ts_date, "
					  + " remarks, prepared_by, prepared_on, '" + sentBy + "', SYSDATE, ts_amount, ssr_year "
					  + " FROM rws_new_est_tbl WHERE work_id = '" + workIds[i] + "')";
				//System.out.println("The qqqqqqqq is " + query);
				stat.addBatch(query);	  				  
				
				query = " INSERT INTO rws_new_est_clnk_mirr_tbl (SELECT work_id, asset_component_code, amount, '"
					  + sentBy + "', sysdate FROM rws_new_est_comp_lnk_tbl WHERE work_id = '" + workIds[i] + "')";
				stat.addBatch(query);
				
				query = " INSERT INTO rws_new_est_workflow_tbl VALUES("
					  + " '" + workIds[i] + "', " + trackNo + ", '" + actionFrom + "', "
					  + " '" + actionTo + "', 'S', SYSDATE, '" + sentBy + "', "
					  + " '" + sentTo + "', '" + estimateDTO.getLetterNo() + "',"
					  + " TO_DATE('" + estimateDTO.getSubmitDate() + "', 'dd/mm/yyyy')," 
					  + " '" + estimateDTO.getSubmitSubject() + "', " 
					  + " '" + estimateDTO.getSubmitRef() + "', "
					  + " '" + estimateDTO.getSubmitContent() + "', 'N')";
				//System.out.println("The query of submitting estimate: " + query);
				stat.addBatch(query);
			}
			
			int updateCounts[] = stat.executeBatch();
			flag = true;
			for(int i=0; i<updateCounts.length; i++)
			{
				if(updateCounts[i] == 0)
					flag = false;
			}
			 
			 if(flag)
			 {
				conn.commit();
				//System.out.println("all data saved");
			 }
	
			 conn.setAutoCommit(true);
		}
		catch(Exception e)
		{	Debug.writeln("Exception in submit : \n" + e);
			flag = false;
		}
		finally
		{	closeAll();
				
		}
	 return flag;
	}
	/*
	* 
	*/
	public boolean sanction(String[] workIds, EstimateDTO estimateDTO) throws Exception
	{
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		stat = conn.createStatement();
		//System.out.println("work Id Length="+workIds.length);
		String officeCode=estimateDTO.getOfficeCode();
		 
		 
		for(int i=0; i<workIds.length; i++)
		{
			query = " UPDATE rws_new_est_tbl SET ts_office = '" + estimateDTO.getOfficeCode() + "', "
				  + " ts_given_by = '" + estimateDTO.getUserId() + "', "
				  + " ts_no = '" + estimateDTO.getTsEndtNo() + "', "
				  + " ts_date = TO_DATE('" + estimateDTO.getTsEndtDate() + "', 'dd/mm/yyyy'), "
				  + " ts_amount = '" + estimateDTO.getTsAmount() + "', "
				  + " ssr_year = '" + estimateDTO.getSsrYear() + "'"
				  + " WHERE work_id = '" + workIds[i] + "'";
			//System.out.println("query1 in sanction() is "+query);
			stat.addBatch(query);
			if(officeCode.substring(officeCode.length()-2,officeCode.length()).equals("00"))
			 query = " UPDATE rws_new_est_workflow_tbl SET flag = 'Y' "
				  + " WHERE work_id = '" + workIds[i] + "'";
			//System.out.println("query2 in sanction() is "+query);
			stat.addBatch(query);
		}
		int updateCounts[] = stat.executeBatch();
		flag = true;
		//System.out.println("updateCounts length="+updateCounts.length);
		 for(int i=0; i<updateCounts.length; i++)
		{
		   //System.out.println("value="+updateCounts[i]);
		 	if(updateCounts[i] == 0)
				flag = false;
		}
		 
		if(flag){
		  conn.setAutoCommit(true);
		  conn.commit();
		} 
		closeAll();
		//System.out.println("flag="+flag);
		return flag;
	}
	
	public ArrayList getPendingEstimates(String officeCode) 
	{
		//System.out.println("getPendingEstimates() called.");
		//System.out.println("-----------------------------");
		//System.out.println("Office Code: " + officeCode);
		String[] designations = {"AEE","DEE","EE","SE","CE(RWS)"};	
		ArrayList pendingEstimatesList = null, pendingEstimates = null;
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			pendingEstimatesList = new ArrayList();
			for(int i=0; i<designations.length; i++)
			{
				query = " SELECT T.cost_lower_limit, T.cost_upper_limit FROM rws_est_ts_work_value_tbl T,"
					  + " rws_designation_tbl D " 
					  + " WHERE T.designation_code = D.designation_code "
					  + " AND UPPER(D.designation_acr) LIKE '" + designations[i]+ "'";
				
				rset = stat.executeQuery(query);
				double upperLimit = 0;
				double lowerLimit = 0;
				if(rset.next())
				{
					lowerLimit = rset.getDouble(1);
					upperLimit = rset.getDouble(2);
				}
				
				query = " SELECT E.office_code, E.work_id, E.financial_year, S.source_name, "
					  + " A.type_of_asset_name, E.total_components, E.estimate_amount, E.sanctioned_amount,  "
					  + " E.remarks, TO_CHAR(E.prepared_on, 'dd/mm/yyyy') "
					  + " FROM rws_new_est_tbl E, rws_asset_type_tbl A,"
					  + " rws_source_tbl S "
					  + " WHERE E.office_code = '" + officeCode + "'"
					  + " AND E.source_code = S.source_code "
					  + " AND E.type_of_asset_code = A.type_of_asset_code "
					  + " AND E.ts_office IS NULL AND E.ts_given_by IS NULL "
					  + " AND E.ts_no IS NULL AND E.ts_date IS NULL "
					  + " AND E.work_id NOT IN (SELECT work_id FROM rws_new_est_workflow_tbl)"
					  + " AND E.sanctioned_amount*100000 >= " + lowerLimit;
				if(i < 4)
				query += " AND E.sanctioned_amount*100000 <=" + upperLimit; 
				
				//query+= " AND E.type_of_asset_code!='04';
					  
				rset = stat.executeQuery(query);
		
				pendingEstimates = new ArrayList();
				EstimateDTO estimateDTO = null;
						
				while(rset.next())
				{
					estimateDTO = new EstimateDTO();		
					estimateDTO.setOfficeCode(rset.getString(1));
					estimateDTO.setWorkId(rset.getString(2));
					estimateDTO.setFinancialYear(rset.getString(3));
					estimateDTO.setSourceCode(rset.getString(4));
					estimateDTO.setAssetType(rset.getString(5));
					estimateDTO.setTotalComponents(rset.getString(6));
					estimateDTO.setEstimateAmount(rset.getString(7));
					estimateDTO.setSanctionedAmount(rset.getString(8));
					estimateDTO.setRemarks(rset.getString(9));
					estimateDTO.setPreparedOn(rset.getString(10));
					pendingEstimates.add(estimateDTO);
				}
				pendingEstimatesList.add(pendingEstimates);
			}
		}
		catch(Exception e)
		{	//System.out.println("Exception in getPendingEstimates(): " + e);
			e.printStackTrace();
		}
		finally
		{	closeAll();
		}
		
		return pendingEstimatesList;
	}
	
	
	public ArrayList getSubmittedEstimates(String officeCode) 
	{
		//System.out.println("getSubmittedEstimates() called.");
		//System.out.println("-----------------------------");
		//System.out.println("Office Code: " + officeCode);
		String[] designations = {"AEE","DEE","EE","SE","CE(RWS)"};	
		ArrayList submittedEstimatesList = null, submittedEstimates = null;
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		String actionFrom = null; 
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			submittedEstimatesList = new ArrayList();
			for(int i=0; i<designations.length; i++)
			{
				query = " SELECT T.cost_lower_limit, T.cost_upper_limit FROM rws_est_ts_work_value_tbl T,"
					  + " rws_designation_tbl D " 
					  + " WHERE T.designation_code = D.designation_code "
					  + " AND D.designation_acr LIKE UPPER('" + designations[i]+ "')";
				
				rset = stat.executeQuery(query);
				double upperLimit = 0;
				double lowerLimit = 0;
				if(rset.next())
				{
					lowerLimit = rset.getDouble(1);
					upperLimit = rset.getDouble(2);
				}
				
				query = " SELECT E.work_id, E.financial_year, S.source_name, "
					  + " A.type_of_asset_name, E.total_components, E.estimate_amount, E.sanctioned_amount,  "
					  + " E.remarks, TO_CHAR(E.prepared_on, 'dd/mm/yyyy'), W.action_from, "
					  + " W.memo_no, TO_CHAR(W.for_sub_date, 'dd/mm/yyyy'), "
					  + " W.subject, NVL(W.ref,''), W.content, W.action_type "
					  + " FROM rws_new_est_tbl E, rws_asset_type_tbl A,"
					  + " rws_source_tbl S, rws_new_est_workflow_tbl W "
					  + " WHERE W.action_to = '" + officeCode + "'"
					  + " AND W.action_type = 'S' AND W.flag = 'N'"
					  + " AND E.source_code = S.source_code "
					  + " AND E.type_of_asset_code = A.type_of_asset_code "
					  + " AND E.ts_office IS NULL AND E.ts_given_by IS NULL "
					  + " AND E.ts_no IS NULL AND E.ts_date IS NULL "
					  + " AND E.work_id = W.work_id "
					  + " AND E.sanctioned_amount*100000 >= " + lowerLimit;
				if(i < 4)
				query += " AND E.sanctioned_amount*100000 <=" + upperLimit; 
					  
//				query+= " AND E.type_of_asset_code!='04';
				rset = stat.executeQuery(query);
		
				submittedEstimates = new ArrayList();
				EstimateDTO estimateDTO = null;
						
				while(rset.next())
				{
					estimateDTO = new EstimateDTO();		
					estimateDTO.setWorkId(rset.getString(1));
					estimateDTO.setFinancialYear(rset.getString(2));
					estimateDTO.setSourceCode(rset.getString(3));
					estimateDTO.setAssetType(rset.getString(4));
					estimateDTO.setTotalComponents(rset.getString(5));
					estimateDTO.setEstimateAmount(rset.getString(6));
					estimateDTO.setSanctionedAmount(rset.getString(7));
					estimateDTO.setRemarks(rset.getString(8));
					estimateDTO.setPreparedOn(rset.getString(9));
					actionFrom = rset.getString(10);
					estimateDTO.setOfficeCode(actionFrom);
					estimateDTO.setOfficeName(rwsOffices.getOfficeName(actionFrom, true));
					estimateDTO.setLetterNo(rset.getString(11));
					estimateDTO.setSubmitDate(rset.getString(12));
					estimateDTO.setSubmitSubject(rset.getString(13));
					estimateDTO.setSubmitRef(rset.getString(14));
					content = rset.getString(15);
					content = content.replaceAll("\\n","");
					content = content.replaceAll("\\r","<br>");
					estimateDTO.setSubmitContent(content);
					estimateDTO.setFlag(rset.getString(16));
					
					submittedEstimates.add(estimateDTO);
				}
				submittedEstimatesList.add(submittedEstimates);
			}
		}
		catch(Exception e)
		{	//System.out.println("Exception in getSubmittedEstimates(): " + e);
		}
		finally
		{	closeAll();
		}
		
		return submittedEstimatesList;
	}
	
	public ArrayList viewNewEstimates(String officeCode)
	{
		ArrayList estimateList = new ArrayList();
		//System.out.println("viewNewEstiamtes() called.");
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			query = " SELECT E.work_id, P.proposal_name, E.financial_year, S.source_name, "
				  + " AT.type_of_asset_name, E.total_components, E.estimate_amount, E.sanctioned_amount,  "
				  + " E.remarks FROM rws_new_est_tbl E, rws_source_tbl	S, rws_asset_type_tbl AT, "
				  + " rws_work_proposal_tbl P"
				  + " WHERE E.source_code = S.source_code "
				  + " AND E.type_of_asset_code = AT.type_of_asset_code "
				  + " AND E.work_id = P.work_id "
				  + " AND E.work_id NOT IN (SELECT work_id FROM rws_om_est_workflow_tbl) "
				  + " AND E.ts_no IS NULL "
				  + " AND E.office_code = '" + officeCode + "'";
//		
			rset = stat.executeQuery(query);
			EstimateDTO estimateDTO = null;
			while(rset.next())
			{
				estimateDTO = new EstimateDTO();
				estimateDTO.setWorkId(rset.getString(1));
				estimateDTO.setWorkName(rset.getString(2));
				estimateDTO.setFinancialYear(rset.getString(3));
				estimateDTO.setSourceCode(rset.getString(4));
				estimateDTO.setAssetType(rset.getString(5));
				estimateDTO.setTotalComponents(rset.getString(6));
				estimateDTO.setEstimateAmount(rset.getString(7));
				estimateDTO.setSanctionedAmount(rset.getString(8));
				estimateDTO.setRemarks(rset.getString(9));
				estimateList.add(estimateDTO);		
			}

		}
		catch(Exception e)
		{	//System.out.println("Exception in viewNewEstimates(): " + e);	
		}
		finally
		{	closeAll();
		}
		
		return estimateList;
	}
	
	public boolean updateNewEstimate(EstimateDTO estimateDTO)
	{
		//System.out.println("updateNewEstimate() called.");
		int updateCounts[]; 
		try
		{
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			
			query = " UPDATE rws_new_est_tbl SET financial_year = '" + estimateDTO.getFinancialYear() + "', "
			      + " source_code = '" + estimateDTO.getSourceCode() + "', "
				  + " total_components = '" + estimateDTO.getTotalComponents() + "', "
				  + " remarks = '" + estimateDTO.getRemarks() + "' "
				  + " WHERE work_id = '" + estimateDTO.getWorkId()+ "'";
			stat.addBatch(query);
			
			query = " DELETE FROM rws_new_est_clnk_mirr_tbl WHERE work_id='" + estimateDTO.getWorkId()+ "'";
			stat.addBatch(query);
			
			query = " DELETE FROM rws_new_est_comp_lnk_tbl WHERE work_id='" + estimateDTO.getWorkId()+ "'";
			stat.addBatch(query);
			
			ArrayList components = estimateDTO.getComponents();
			EstimateHolder holder = null;
			for(int i=0; i<components.size(); i++)
			{
				holder = (EstimateHolder)components.get(i);
				query = " INSERT INTO rws_new_est_comp_lnk_tbl VALUES('" + estimateDTO.getWorkId()+ "', "
					  + " '" + holder.getAssetComponent() + "', '" + holder.getAmount() + "')";
				
				stat.addBatch(query);
			}
					
			updateCounts = stat.executeBatch();
			flag = true;
			if(flag)
				conn.commit();
			conn.setAutoCommit(true);
		}
		catch(Exception e)
		{	Debug.writeln("Exception in updateNewEstimates : \n" + e);			
		}
		finally
		{	closeAll();			
		}
		return flag;
	}
	
	public boolean deleteNewEstimate(String workId)
	{
		//System.out.println("deleteNewEstimate() called.");
		try
		{
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			query = " DELETE FROM rws_new_est_comp_lnk_tbl WHERE work_id='" + workId + "'";
			stat.addBatch(query);
			query = " DELETE FROM rws_new_est_tbl WHERE work_id='" + workId + "'";
			stat.addBatch(query);
			
			int[] updateCounts = stat.executeBatch();
			flag = true;
			for(int i=0; i<updateCounts.length; i++)
			{
				if(updateCounts[i] < 0)
					flag = false;
			}
			if(flag)
				conn.commit();
			conn.setAutoCommit(true);
		}
		catch(Exception e)
		{	//System.out.println("Exception in deleteNewEstimate(): " + e);
		}
		finally
		{	closeAll();
		}
				
		return flag;
	}
	
	/**
	*
	*
	*/
	public int getNextTrackNo(String workId) throws Exception
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		int nextTrackNo = 1;

		try
		{
			query = " SELECT MAX(track_no)+1 from rws_new_est_workflow_tbl "
				  + " WHERE work_id = '" + workId + "'";
			
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			if(rset.next())
			{
				nextTrackNo = rset.getInt(1);

				if(nextTrackNo == 0)
					nextTrackNo = 1;
			}
			
			//System.out.println("Estimate Track No in getNextTrackNo() : " + nextTrackNo);
		}
		finally
		{
			if(rset != null)
			{
				try
				{	//System.out.println("Closing rset(getNextTrackNo)");
					rset.close();
				}
				catch(SQLException sqle)
				{	//System.out.println("Closing rset(getNextTrackNo) SQLException : " + sqle);
				}
			}
			if(stat != null)
			{
				try
				{	//System.out.println("Closing stat(getNextTrackNo)");
					stat.close();
				}
				catch(SQLException sqle)
				{	//System.out.println("Closing stat(getNextTrackNo) SQLException : " + sqle);
				}
			}
			if(conn != null)
			{
				try
				{	//System.out.println("Closing conn(getNextTrackNo)");
					conn.close();
				}
				catch(SQLException sqle)
				{	//System.out.println("Closing conn(getNextTrackNo) SQLException : " + sqle);
				}
			}
		}
		return nextTrackNo;
	}


	public ProposalDTO getWorkDetails(String workId) throws Exception
	{
		ProposalDTO proposalDTO = new ProposalDTO();
		query = " SELECT work_id, proposal_name, no_of_habs, P.programme_name, SP.subprogramme_name, "
			  + " AT.type_of_asset_name, DECODE(state_central, 'C', 'CENTRE', 'S', 'STATE'), "
			  + " admin_sanc_auth, admin_no, TO_CHAR(admin_date, 'dd/mm/yyyy'), goms_no, "
			  + " DECODE(phased,'Y', 'Yes', 'N', 'NO'), NVL(phase_no,0), "
			  + " estimate_cost, sanction_amount, remarks "
			  + " FROM rws_work_proposal_tbl WP, rws_programme_tbl P, rws_subprogramme_tbl SP, "
			  + " rws_asset_type_tbl AT "
			  + " WHERE WP.work_id = '" + workId + "' "
			  + " AND WP.type_of_asset = AT.type_of_asset_code "
			  + " AND WP.programme_code = P.programme_code "
			  + " AND (WP.subprogramme_code = SP.subprogramme_code(+) "
			  + " AND WP.programme_code = SP.programme_code(+)) "; 
			  
		conn = dataSource.getConnection();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);

		while(rset.next())
		{
			proposalDTO.setWorkId(rset.getString(1));
			proposalDTO.setProposalName(rset.getString(2));
			proposalDTO.setNoOfHabs(rset.getString(3));
			proposalDTO.setProgrammeName(rset.getString(4));
			proposalDTO.setSubprogrammeName(rset.getString(5));
			proposalDTO.setAssetName(rset.getString(6));
			proposalDTO.setSanctionedAt(rset.getString(7));
			proposalDTO.setSanctioningAuthority(rset.getString(8));
			proposalDTO.setAdminNo(rset.getString(9));
			proposalDTO.setAdminDate(rset.getString(10));
			proposalDTO.setGoNo(rset.getString(11));
			proposalDTO.setPhased(rset.getString(12));
			proposalDTO.setPhaseNo(rset.getString(13));
			proposalDTO.setEstimateCost(rset.getString(14));
			proposalDTO.setSanctionedAmount(rset.getString(15));
			proposalDTO.setRemarks(rset.getString(16));
		}
		closeAll();
		return proposalDTO;
	}

	public EstimateDTO getWorkAmount(String workId, String tsOffice, String designationCode) throws Exception
	{

		query = " SELECT estimate_cost, sanction_amount FROM rws_work_proposal_tbl "
			  + " WHERE work_id = '" + workId + "'";
		
		conn = dataSource.getConnection();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		EstimateDTO estimateDTO = new EstimateDTO();
		String estimateAmount = "0";
		String sanctionedAmount = "0";	
		if(rset.next())
		{
			estimateDTO.setEstimateAmount(rset.getString(1));
			estimateDTO.setSanctionedAmount(rset.getString(2));

		}
		double dSanctionedAmount = Double.parseDouble(sanctionedAmount);
		dSanctionedAmount*=100000;
		//System.out.println("dSanctionedAmount: " + dSanctionedAmount);
		//System.out.println("tsOffice: " + tsOffice);
		//System.out.println("designationCode: " + designationCode);
		designationCode = "2";
		//System.out.println("designationCode: " + designationCode);
		int index = tsOffice.indexOf("Office");
		tsOffice = tsOffice.substring(0, index);
		tsOffice = tsOffice.trim();
		//System.out.println("tsOffice is " + tsOffice);
		query = " SELECT cost_lower_limit, cost_upper_limit FROM rws_est_ts_work_value_tbl "
			  + " WHERE UPPER(office) LIKE UPPER('" + tsOffice + "') "
			  + " AND designation_code = '" + designationCode + "'";

		//System.out.println("The Query is : " + query);
		rset = stat.executeQuery(query);
		java.math.BigDecimal costLowerLimit = null;
		java.math.BigDecimal costUpperLimit = null;
		if(rset.next())
		{
			costLowerLimit = rset.getBigDecimal(1);
			costUpperLimit = rset.getBigDecimal(2);
		}
		//System.out.println("costLowerLimit " + costLowerLimit );
		//System.out.println("costUpperLimit " + costUpperLimit );
		if(costLowerLimit != null && costUpperLimit != null)
		{
			if(dSanctionedAmount > costLowerLimit.doubleValue() && dSanctionedAmount <= costUpperLimit.doubleValue());
			{
				//System.out.println("IN IF condition...");
				estimateDTO.setAllowed(true);
			}
		}
			
		closeAll();
		return estimateDTO;
	}
	
	public EstimateDTO getEstimateDetails(String workId)
	{
		//System.out.println("getEstimateDetails() called.");
		//System.out.println("Work Id is " + workId);
		EstimateDTO estimateDTO = new EstimateDTO();
		
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			query = " SELECT P.proposal_name, E.financial_year, E.type_of_asset_code, A.type_of_asset_name, "
				  + " S.source_code, S.source_type_code, S.subsource_type_code, "
				  + " E.total_components, E.estimate_amount, E.sanctioned_amount, E.remarks "
				  + " FROM rws_new_est_tbl E, rws_asset_type_tbl A, rws_work_proposal_tbl P, "
				  + " rws_source_tbl S "
				  + " WHERE E.type_of_asset_code = A.type_of_asset_code "
				  + " AND E.work_id = P.work_id "
				  + " AND E.source_code = S.source_code "
				  + " AND E.work_id = '" + workId + "'";
			
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				estimateDTO.setWorkId(workId);
				estimateDTO.setWorkName(rset.getString(1));
				estimateDTO.setFinancialYear(rset.getString(2));
				estimateDTO.setAssetTypeCode(rset.getString(3));
				estimateDTO.setAssetType(rset.getString(4));
				estimateDTO.setSourceCode(rset.getString(5));
				estimateDTO.setSourceType(rset.getString(6));
				estimateDTO.setSubsourceType(rset.getString(7));
				estimateDTO.setTotalComponents(rset.getString(8));
				estimateDTO.setEstimateAmount(rset.getString(9));
				estimateDTO.setSanctionedAmount(rset.getString(10));
				estimateDTO.setRemarks(rset.getString(11));
			}
			
		}
		catch(Exception e)
		{	//System.out.println("Exception in getEstimateDetails():\n" + e);			
		}
		finally
		{	closeAll();
		}
		
		return estimateDTO;
	}
//------------------------------------------------------------------------------------------------------
	public boolean omConsider(EstimateDTO estimateDTO) throws Exception
	{
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		stat = conn.createStatement();
		
		String workId = estimateDTO.getWorkId();
		String assetComponentCode = null;
		String assetSubComponentCode = null;
		String taskCode = null;
		String subTaskCode = null;
		
		//System.out.println("estimateDTO.getAssetType(): " + estimateDTO.getAssetType());
		
		query = " INSERT INTO rws_om_est_tbl(office_code, work_id, financial_year,"
			  + " source_code, type_of_asset_code, total_components,"
			  + " estimate_amount, sanctioned_amount,"
			  + " detail_est_upld_date, layout_upld_date, manpower_charges, power_charges,  "
			  + " consumables, repairs_renewals, others, remarks, "
			  + " prepared_by, prepared_on) VALUES( " 
			  + " '" + estimateDTO.getOfficeCode() + "'," 
			  + " '" + workId + "'," 
			  + " '" + estimateDTO.getFinancialYear() + "'," 
			  + " '" + estimateDTO.getSourceCode() + "',"
			  + " '" + estimateDTO.getAssetType() + "'," 
			  + estimateDTO.getTotalComponents() + "," 
			  + estimateDTO.getEstimateAmount() + ","  
			  + estimateDTO.getSanctionedAmount() + "," 
			  + " SYSDATE, SYSDATE, " 
			  + " '" + estimateDTO.getManpowerCharges() + "',"
			  + " '" + estimateDTO.getPowerCharges() + "',"
			  + " '" + estimateDTO.getConsumables() + "',"
			  + " '" + estimateDTO.getRepairs() + "',"
			  + " '" + estimateDTO.getOthers() + "',"
			  + " '" + estimateDTO.getRemarks() + "', " 
			  + " '" + estimateDTO.getUserId() + "', SYSDATE )";
		//System.out.println("Estimate Query");
		//System.out.println(query);
		
		stat.addBatch(query);

		ArrayList components = estimateDTO.getComponents();
		Iterator iterator = components.iterator();
					
		EstimateHolder component = null;
		
		
		//System.out.println("components.size(): " + components.size());
			
		while(iterator.hasNext())
		{
			component = (EstimateHolder)iterator.next();
			assetComponentCode = component.getAssetComponent();
			
			if(assetComponentCode != null && !assetComponentCode.equals(""))
			{
				query = " INSERT INTO rws_om_est_comp_lnk_tbl VALUES(" 
					  + " '" + workId + "', '" + assetComponentCode + "',"
					  + " '" + component.getAmount() + "')";
					
				stat.addBatch(query);
			}
		}
		
		 int updateCounts[] = stat.executeBatch();
		 flag = true;
		 for(int i=0; i<updateCounts.length; i++)
		 {
			 if(updateCounts[i] == 0)
				 flag = false;
		 }
		 
		 if(flag)
			conn.commit();

		 conn.setAutoCommit(true);
		 closeAll();
		 return flag;
	}
	
	/**
	*
	*
	*/
	public boolean omSubmit(String[] workIds, EstimateDTO estimateDTO) throws Exception
	{
		//System.out.println("omSubmit() called.");
		flag = false;
		String actionFrom = estimateDTO.getOfficeCode();
		String actionTo = estimateDTO.getSubmitTo();
		String sentBy = estimateDTO.getUserId();
		String sentTo = null;
		String officeType = null;
		int length = workIds.length;
			
		if(!actionTo.substring(4,6).equals("00"))
			officeType = "SUB DIVISION OFFICE";
		else
		if(!actionTo.substring(3,4).equals("0"))
				officeType = "DIVISION OFFICE";
		else
		if(!actionTo.substring(1,3).equals("00"))
			officeType = "CIRCLE OFFICE";
		else
		if(!actionTo.substring(0,1).equals("0"))
			officeType = "HEAD OFFICE";
	
		query = " SELECT user_id FROM rws_password_tbl WHERE designation_code = "
			  + " (SELECT designation_code FROM rws_head_of_office_tbl WHERE office LIKE '" + officeType + "')" 
			  + " AND office_code = '" + actionTo + "'";
		//System.out.println("query1 in omSubmit() is"+query);
		conn = dataSource.getConnection();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		int rowCount = 0;
		while(rset.next())
		{
			rowCount++;
			sentTo = rset.getString(1);
		}
		if(rowCount != 1)
		{
			HEAD_OF_OFFICE_COUNT = rowCount;
			return false;
		}
		
		conn.setAutoCommit(false);
		
		for(int i=0; i<length; i++)
		{
			int trackNo = getOMNextTrackNo(workIds[i]);
			if(trackNo > 1)
			{
				query = " UPDATE rws_om_est_workflow_tbl SET flag = 'Y' WHERE "
					  + " work_id = '" + workIds[i] + "' AND track_no = " + (trackNo-1); 
				stat.addBatch(query);
			}

			query = " INSERT INTO rws_om_est_mirr_tbl(office_code, work_id, financial_year, source_code, "
				  + " type_of_asset_code, total_components, estimate_amount, sanctioned_amount, "
				  + " detail_est_upld_date, layout_upld_date, ts_office, ts_given_by, ts_no, ts_date, "
				  + " manpower_charges, power_charges, consumables, repairs_renewals, others,"
				  + " remarks, prepared_by, prepared_on, modified_by, modified_on, ts_amount, ssr_year)"
				  + " (SELECT office_code, work_id, financial_year, source_code, type_of_asset_code, "
				  + " total_components, estimate_amount, sanctioned_amount, detail_est_upld_date, "
				  + " layout_upld_date, ts_office, ts_given_by, ts_no, ts_date, "
				  + " manpower_charges, power_charges, consumables, repairs_renewals, others,"
				  + " remarks, prepared_by, prepared_on, '" + sentBy + "', SYSDATE, ts_amount, ssr_year "
				  + " FROM rws_om_est_tbl WHERE work_id = '" + workIds[i] + "')";
			//System.out.println("query2 in omSubmit() is"+query);
			stat.addBatch(query);	  				  
			
			query = " INSERT INTO rws_om_est_clnk_mirr_tbl (SELECT work_id, asset_component_code, amount, '"
				  + sentBy + "', sysdate FROM rws_om_est_comp_lnk_tbl WHERE work_id = '" + workIds[i] + "')";
			//System.out.println("query3 in omSubmit() is"+query);
			stat.addBatch(query);
			
			query = " INSERT INTO rws_om_est_workflow_tbl VALUES("
				  + " '" + workIds[i] + "', " + trackNo + ", '" + actionFrom + "', "
				  + " '" + actionTo + "', 'S', SYSDATE, '" + sentBy + "', "
				  + " '" + sentTo + "', '" + estimateDTO.getLetterNo() + "',"
				  + " TO_DATE('" + estimateDTO.getSubmitDate() + "', 'dd/mm/yyyy')," 
				  + " '" + estimateDTO.getSubmitSubject() + "', " 
				  + " '" + estimateDTO.getSubmitRef() + "', "
				  + " '" + estimateDTO.getSubmitContent() + "', 'N')";
			//System.out.println("query4 in omSubmit() is"+query);
			stat.addBatch(query);
		}

		
		 int updateCounts[] = stat.executeBatch();
		 flag = true;
		 for(int i=0; i<updateCounts.length; i++)
		 {
			 if(updateCounts[i] == 0)
				 flag = false;
		 }
		 
		 if(flag)
			conn.commit();

		 conn.setAutoCommit(true);
		 
		 closeAll();
		 return flag;
	}
	
	
	public boolean omSanction(String[] workIds, EstimateDTO estimateDTO)
	{
		try
		{
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			for(int i=0; i<workIds.length; i++)
			{
				query = " UPDATE rws_om_est_tbl SET ts_office = '" + estimateDTO.getOfficeCode() + "', "
					  + " ts_given_by = '" + estimateDTO.getEmployeeCode() + "', "
					  + " ts_no = '" + estimateDTO.getTsEndtNo() + "', "
					  + " ts_date = TO_DATE('" + estimateDTO.getTsEndtDate() + "', 'dd/mm/yyyy'), "
					  + " ts_amount = '" + estimateDTO.getTsAmount() + "', "
					  + " ssr_year = '" + estimateDTO.getSsrYear() + "'"
					  + " WHERE work_id = '" + workIds[i] + "'";
				
				stat.addBatch(query);
				
				query = " UPDATE rws_om_est_workflow_tbl SET flag = 'Y' "
					  + " WHERE work_id = '" + workIds[i] + "'";
				stat.addBatch(query);
			}
			
			int updateCounts[] = stat.executeBatch();
			flag = true;
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
		{	//System.out.println("Exception in omSanction() " + e);
		}
		finally
		{	closeAll();
		}
		
		return flag;
	}
	
	
	
	public ArrayList viewOMEstimates(String officeCode)
	{
		ArrayList estimateList = new ArrayList();
		//System.out.println("viewOMEstimates() called.");
		//System.out.println("Office Code is " + officeCode);
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			query = " SELECT E.work_id, AM.asset_name ,E.financial_year, S.source_name, "
				  + " AT.type_of_asset_name, E.total_components, E.estimate_amount, E.sanctioned_amount,  "
				  + " E.manpower_charges, E.power_charges, E.consumables, E.repairs_renewals, E.others, "
				  + " E.remarks FROM rws_om_est_tbl E, rws_source_tbl	S, rws_asset_type_tbl AT,"
				  + " rws_asset_mast_tbl AM WHERE E.source_code = S.source_code "
				  + " AND E.type_of_asset_code = AT.type_of_asset_code "
				  + " AND SUBSTR(E.work_id,7,14) = AM.asset_code "
				  + " AND E.work_id NOT IN (SELECT work_id FROM rws_om_est_workflow_tbl)"
				  + " AND E.ts_no IS NULL "
				  + " AND E.office_code = '" + officeCode + "'";
			rset = stat.executeQuery(query);
			EstimateDTO estimateDTO = null;
			while(rset.next())
			{
				estimateDTO = new EstimateDTO();
				estimateDTO.setWorkId(rset.getString(1));
				estimateDTO.setWorkName(rset.getString(2));
				estimateDTO.setFinancialYear(rset.getString(3));
				estimateDTO.setSourceCode(rset.getString(4));
				estimateDTO.setAssetType(rset.getString(5));
				estimateDTO.setTotalComponents(rset.getString(6));
				estimateDTO.setEstimateAmount(rset.getString(7));
				estimateDTO.setSanctionedAmount(rset.getString(8));
				estimateDTO.setManpowerCharges(rset.getString(9));
				estimateDTO.setPowerCharges(rset.getString(10));
				estimateDTO.setConsumables(rset.getString(11));
				estimateDTO.setRepairs(rset.getString(12));
				estimateDTO.setOthers(rset.getString(13));
				estimateDTO.setRemarks(rset.getString(14));
				estimateList.add(estimateDTO);
			}

		}
		catch(Exception e)
		{	//System.out.println("Exception in viewOMEstimates(): " + e);	
		}
		finally
		{	closeAll();
		}
		
		return estimateList;
	}
	
	public ArrayList getOMPendingEstimates(String officeCode) 
	{
		//System.out.println("getOMPendingEstimates() called.");
		//System.out.println("-----------------------------");
		//System.out.println("Office Code: " + officeCode);
		String[] designations = {"AEE","DEE","EE","SE","CE(RWS)"};	
		ArrayList pendingEstimatesList = null, pendingEstimates = null;
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			pendingEstimatesList = new ArrayList();
			for(int i=0; i<designations.length; i++)
			{
				query = " SELECT T.cost_lower_limit, T.cost_upper_limit FROM rws_est_ts_work_value_tbl T,"
					  + " rws_designation_tbl D " 
					  + " WHERE T.designation_code = D.designation_code "
					  + " AND D.designation_acr LIKE UPPER('" + designations[i]+ "')";
				
				rset = stat.executeQuery(query);
				double upperLimit = 0;
				double lowerLimit = 0;
				if(rset.next())
				{
					lowerLimit = rset.getDouble(1);
					upperLimit = rset.getDouble(2);
				}
				
				query = " SELECT E.office_code, E.work_id, E.financial_year, S.source_name, "
					  + " A.type_of_asset_name, E.total_components, E.estimate_amount, E.sanctioned_amount,  "
					  + " E.remarks, TO_CHAR(E.prepared_on, 'dd/mm/yyyy') "
					  + " FROM rws_om_est_tbl E, rws_asset_type_tbl A,"
					  + " rws_source_tbl S "
					  + " WHERE E.office_code = '" + officeCode + "'"
					  + " AND E.source_code = S.source_code "
					  + " AND E.type_of_asset_code = A.type_of_asset_code "
					  + " AND E.ts_office IS NULL AND E.ts_given_by IS NULL "
					  + " AND E.ts_no IS NULL AND E.ts_date IS NULL "
					  + " AND E.work_id NOT IN (SELECT work_id FROM rws_om_est_workflow_tbl)"
					  + " AND E.sanctioned_amount*100000 >= " + lowerLimit;
				if(i < 4)
				query += " AND E.sanctioned_amount*100000 <=" + upperLimit; 
					  
				rset = stat.executeQuery(query);
				//System.out.println("OM Pending Estimates Query is \n" + query);
				pendingEstimates = new ArrayList();
				EstimateDTO estimateDTO = null;
						
				while(rset.next())
				{
					estimateDTO = new EstimateDTO();		
					estimateDTO.setOfficeCode(rset.getString(1));
					estimateDTO.setWorkId(rset.getString(2));
					estimateDTO.setFinancialYear(rset.getString(3));
					estimateDTO.setSourceCode(rset.getString(4));
					estimateDTO.setAssetType(rset.getString(5));
					estimateDTO.setTotalComponents(rset.getString(6));
					estimateDTO.setEstimateAmount(rset.getString(7));
					estimateDTO.setSanctionedAmount(rset.getString(8));
					estimateDTO.setRemarks(rset.getString(9));
					estimateDTO.setPreparedOn(rset.getString(10));
					pendingEstimates.add(estimateDTO);
				}
				pendingEstimatesList.add(pendingEstimates);
			}
		}
		catch(Exception e)
		{	//System.out.println("Exception in getOMPendingEstimates(): " + e);
			e.printStackTrace();
		}
		finally
		{	closeAll();
		}
		
		return pendingEstimatesList;
	}
	
	public ArrayList getOMSubmittedEstimates(String officeCode) 
	{
		//System.out.println("getOMSubmittedEstimates() called.");
		//System.out.println("-----------------------------");
		//System.out.println("Office Code: " + officeCode);
		String[] designations = {"AEE","DEE","EE","SE","CE(RWS)"};	
		ArrayList submittedEstimatesList = null, submittedEstimates = null;
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		String actionFrom = null; 
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			submittedEstimatesList = new ArrayList();
			for(int i=0; i<designations.length; i++)
			{
				query = " SELECT T.cost_lower_limit, T.cost_upper_limit FROM rws_est_ts_work_value_tbl T,"
					  + " rws_designation_tbl D " 
					  + " WHERE T.designation_code = D.designation_code "
					  + " AND D.designation_acr LIKE UPPER('" + designations[i]+ "')";
				
				rset = stat.executeQuery(query);
				double upperLimit = 0;
				double lowerLimit = 0;
				if(rset.next())
				{
					lowerLimit = rset.getDouble(1);
					upperLimit = rset.getDouble(2);
				}
				
				query = " SELECT E.work_id, E.financial_year, S.source_name, "
					  + " A.type_of_asset_name, E.total_components, E.estimate_amount, E.sanctioned_amount,  "
					  + " E.remarks, TO_CHAR(E.prepared_on, 'dd/mm/yyyy'), W.action_from, "
					  + " W.memo_no, TO_CHAR(W.for_sub_date, 'dd/mm/yyyy'), "
					  + " W.subject, NVL(W.ref,''), W.content, W.action_type "
					  + " FROM rws_om_est_tbl E, rws_asset_type_tbl A,"
					  + " rws_source_tbl S, rws_om_est_workflow_tbl W "
					  + " WHERE W.action_to = '" + officeCode + "'"
					  + " AND W.action_type = 'S' AND W.flag = 'N'"
					  + " AND E.source_code = S.source_code "
					  + " AND E.type_of_asset_code = A.type_of_asset_code "
					  + " AND E.ts_office IS NULL AND E.ts_given_by IS NULL "
					  + " AND E.ts_no IS NULL AND E.ts_date IS NULL "
					  + " AND E.work_id = W.work_id "
					  + " AND E.sanctioned_amount*100000 >= " + lowerLimit;
				if(i < 4)
				query += " AND E.sanctioned_amount*100000 <=" + upperLimit; 
					  
				
				rset = stat.executeQuery(query);
		
				submittedEstimates = new ArrayList();
				EstimateDTO estimateDTO = null;
						
				while(rset.next())
				{
					estimateDTO = new EstimateDTO();		
					estimateDTO.setWorkId(rset.getString(1));
					estimateDTO.setFinancialYear(rset.getString(2));
					estimateDTO.setSourceCode(rset.getString(3));
					estimateDTO.setAssetType(rset.getString(4));
					estimateDTO.setTotalComponents(rset.getString(5));
					estimateDTO.setEstimateAmount(rset.getString(6));
					estimateDTO.setSanctionedAmount(rset.getString(7));
					estimateDTO.setRemarks(rset.getString(8));
					estimateDTO.setPreparedOn(rset.getString(9));
					actionFrom = rset.getString(10);
					estimateDTO.setOfficeCode(actionFrom);
					estimateDTO.setOfficeName(rwsOffices.getOfficeName(actionFrom, true));
					estimateDTO.setLetterNo(rset.getString(11));
					estimateDTO.setSubmitDate(rset.getString(12));
					estimateDTO.setSubmitSubject(rset.getString(13));
					estimateDTO.setSubmitRef(rset.getString(14));
					content = rset.getString(15);
					content = content.replaceAll("\\n","");
					content = content.replaceAll("\\r","<br>");
					estimateDTO.setSubmitContent(content);
					estimateDTO.setFlag(rset.getString(16));
					
					submittedEstimates.add(estimateDTO);
				}
				submittedEstimatesList.add(submittedEstimates);
			}
		}
		catch(Exception e)
		{	//System.out.println("Exception in getOMSubmittedEstimates(): " + e);
		}
		finally
		{	closeAll();
		}
		
		return submittedEstimatesList;
	}
	
	
	public int getOMNextTrackNo(String workId) throws Exception
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		int nextTrackNo = 1;

		try
		{
			query = " SELECT MAX(track_no)+1 from rws_om_est_workflow_tbl "
				  + " WHERE work_id = '" + workId + "'";
					
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			if(rset.next())
			{
				nextTrackNo = rset.getInt(1);
				if(nextTrackNo == 0)
					nextTrackNo = 1;
			}
			
			//System.out.println("OM Estimate Track No in getOMNextTrackNo() : " + nextTrackNo);
		}
		finally
		{
			if(rset != null)
			{
				try
				{	//System.out.println("Closing rset(getOMNextTrackNo)");
					rset.close();
				}
				catch(SQLException sqle)
				{	//System.out.println("Closing rset(getOMNextTrackNo) SQLException : " + sqle);
				}
			}
			if(stat != null)
			{
				try
				{	//System.out.println("Closing stat(getOMNextTrackNo)");
					stat.close();
				}
				catch(SQLException sqle)
				{	//System.out.println("Closing stat(getOMNextTrackNo) SQLException : " + sqle);
				}
			}
			if(conn != null)
			{
				try
				{	//System.out.println("Closing conn(getOMNextTrackNo)");
					conn.close();
				}
				catch(SQLException sqle)
				{	//System.out.println("Closing conn(getOMNextTrackNo) SQLException : " + sqle);
				}
			}
		}

		return nextTrackNo;
	}
	
	public EstimateDTO getOMEstimateDetails(String workId)
	{
		//System.out.println("getOMEstimateDetails() called.");
		//System.out.println("Work Id is " + workId);
		EstimateDTO estimateDTO = new EstimateDTO();
		
		try
		{
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			query = " SELECT AM.asset_name, E.financial_year, E.type_of_asset_code, A.type_of_asset_name, "
				  + " S.source_code, S.source_type_code, S.subsource_type_code, "
				  + " E.total_components, E.estimate_amount, E.sanctioned_amount, E.manpower_charges, "
				  + " E.power_charges, E.consumables,  E.repairs_renewals, E.others, E.remarks"
				  + " FROM rws_om_est_tbl E, rws_asset_type_tbl A, rws_asset_mast_tbl AM, "
				  + " rws_source_tbl S "
				  + " WHERE E.type_of_asset_code = A.type_of_asset_code "
				  + " AND SUBSTR(E.work_id,7,20) = AM.asset_code "
				  + " AND E.source_code = S.source_code "
				  + " AND E.work_id = '" + workId + "'";
			
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				estimateDTO.setWorkId(workId);
				estimateDTO.setWorkName(rset.getString(1));
				estimateDTO.setFinancialYear(rset.getString(2));
				estimateDTO.setAssetTypeCode(rset.getString(3));
				estimateDTO.setAssetType(rset.getString(4));
				estimateDTO.setSourceCode(rset.getString(5));
				estimateDTO.setSourceType(rset.getString(6));
				estimateDTO.setSubsourceType(rset.getString(7));
				estimateDTO.setTotalComponents(rset.getString(8));
				estimateDTO.setEstimateAmount(rset.getString(9));
				estimateDTO.setSanctionedAmount(rset.getString(10));
				estimateDTO.setManpowerCharges(rset.getString(11));
				estimateDTO.setPowerCharges(rset.getString(12));
				estimateDTO.setConsumables(rset.getString(13));
				estimateDTO.setRepairs(rset.getString(14));
				estimateDTO.setOthers(rset.getString(15));
				estimateDTO.setRemarks(rset.getString(16));
			}
			
		}
		catch(Exception e)
		{	//System.out.println("Exception in getOMEstimateDetails():\n" + e);			
		}
		finally
		{	closeAll();
		}
		
		return estimateDTO;
	}
	
	public boolean updateOMEstimate(EstimateDTO estimateDTO)
	{
		//System.out.println("updateOMEstimate() called.");
		int updateCounts[]; 
		try
		{
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			
			query = " UPDATE rws_om_est_tbl SET financial_year = '" + estimateDTO.getFinancialYear() + "', "
			      + " source_code = '" + estimateDTO.getSourceCode() + "', "
				  + " total_components = '" + estimateDTO.getTotalComponents() + "', "
				  + " manpower_charges = '" + estimateDTO.getManpowerCharges() + "', "
				  + " power_charges = '" + estimateDTO.getPowerCharges() + "', "
				  + " consumables = '" + estimateDTO.getConsumables() + "', "
				  + " repairs_renewals = '" + estimateDTO.getRepairs() + "', "
				  + " others = '" + estimateDTO.getOthers() + "', "
				  + " remarks = '" + estimateDTO.getRemarks() + "' "
				  + " WHERE work_id = '" + estimateDTO.getWorkId()+ "'";
			stat.addBatch(query);
			
			query = " DELETE FROM rws_om_est_clnk_mirr_tbl WHERE work_id='" + estimateDTO.getWorkId()+ "'";
			stat.addBatch(query);
			
			query = " DELETE FROM rws_om_est_comp_lnk_tbl WHERE work_id='" + estimateDTO.getWorkId()+ "'";
			stat.addBatch(query);
			
			ArrayList components = estimateDTO.getComponents();
			EstimateHolder holder = null;
			for(int i=0; i<components.size(); i++)
			{
				holder = (EstimateHolder)components.get(i);
				query = " INSERT INTO rws_om_est_comp_lnk_tbl VALUES('" + estimateDTO.getWorkId()+ "', "
					  + " '" + holder.getAssetComponent() + "', '" + holder.getAmount() + "')";
				
				stat.addBatch(query);
			}
					
			updateCounts = stat.executeBatch();
			flag = true;
			for(int j=0; j<updateCounts.length; j++)
			{
				if(updateCounts[j] == 0)
					flag = false;
			}
			
			if(flag)
				conn.commit();
			conn.setAutoCommit(true);
		}
		catch(Exception e)
		{	Debug.writeln("Exception in updateOMEstimates : \n" + e);			
		}
		finally
		{	closeAll();			
		}
		return flag;
	}
	
	public boolean deleteOMEstimate(String workId)
	{
		try
		{
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			query = " DELETE FROM rws_om_est_comp_lnk_tbl WHERE work_id='" + workId + "'";
			stat.addBatch(query);
			query = " DELETE FROM rws_om_est_tbl WHERE work_id='" + workId + "'";
			stat.addBatch(query);
			
			int[] updateCounts = stat.executeBatch();
			flag = true;
			for(int i=0; i<updateCounts.length; i++)
			{
				if(updateCounts[i] < 0)
					flag = false;
			}
			if(flag)
				conn.commit();
			conn.setAutoCommit(true);
		}
		catch(Exception e)
		{	//System.out.println("Exception in deleteOMEstimate(): " + e);
		}
		finally
		{	closeAll();
		}
				
		return flag;
	}

//------------------------------------------------------------------------------------------------------	
	
	/**
	*
	*
	*/
	public ProposalDTO getOMWorkDetails(String workId) 
	{
		ProposalDTO proposalDTO = new ProposalDTO();
		Statement stat1 = null;
		ResultSet rset1 = null;
		try
		{
			query = " SELECT OMP.work_id, OMP.om_proposal_id, AM.asset_name, "
				  + " OMP.financial_year, estimate_cost, sanctioned_amount, "
				  + " admin_no, TO_CHAR(admin_date, 'dd/mm/yyyy'), go_no, admn_sanc_auth, "
				  + " DECODE(state_central, 'C', 'CENTRE', 'S', 'STATE'), remarks, no_of_habs "
				  + " FROM rws_om_proposal_tbl OMP,"
				  + " rws_asset_mast_tbl AM "
				  + " WHERE OMP.work_id = '" + workId + "' "
				  + " AND OMP.asset_code = AM.asset_code "; 
			
			conn = dataSource.getConnection();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			stat1 = conn.createStatement();
			if(rset.next())
			{
				proposalDTO.setWorkId(rset.getString(1));
				String proposalId = rset.getString(2);
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setAssetName(rset.getString(3));
				proposalDTO.setFinancialYear(rset.getString(4));	
				proposalDTO.setEstimateCost(rset.getString(5));
				proposalDTO.setSanctionedAmount(rset.getString(6));
				proposalDTO.setAdminNo(rset.getString(7));
				proposalDTO.setAdminDate(rset.getString(8));
				proposalDTO.setGoNo(rset.getString(9));
				proposalDTO.setSanctioningAuthority(rset.getString(10));
				proposalDTO.setSanctionedAt(rset.getString(11));
				proposalDTO.setRemarks(rset.getString(12));
				proposalDTO.setNoOfHabs(rset.getString(13));
				
				query = " SELECT NVL(P.programme_name,''), " 
					  + " NVL(SP.subprogramme_name,'') FROM "
					  + " rws_om_proposal_tbl OMP, rws_om_proposal_prog_lnk_tbl PP,"
					  + " rws_programme_tbl P,  rws_subprogramme_tbl SP "
					  + " WHERE OMP.om_proposal_id = PP.om_proposal_id "
					  + " AND PP.programme_code = P.programme_code "
					  + " AND PP.programme_code = SP.programme_code(+) "
					  + " AND PP.subprogramme_code = SP.subprogramme_code(+) "
					  + " AND OMP.om_proposal_id = '" + proposalId + "'";
				rset1 = stat1.executeQuery(query);
				ArrayList programmes = new ArrayList();
				ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
								
				query = " SELECT P.panch_code, P.panch_name, "
					  + " (H.census_plain_popu + H.census_sc_popu + H.census_st_popu), H.coverage_status "
					  + " FROM rws_om_proposal_hab_lnk_tbl O, rws_panchayat_raj_tbl P, "
					  + " rws_habitation_directory_tbl H "
					  + " WHERE O.hab_code = P.panch_code AND P.panch_code = H.hab_code "
					  + " AND O.om_proposal_id = '" + proposalId + "'";
				rset1 = stat1.executeQuery(query);
				ArrayList habs = new ArrayList();
				RwsLocationBean rwsLocationBean = null;
				while(rset1.next())
				{
					rwsLocationBean = new RwsLocationBean();
					rwsLocationBean.setHabCode(rset.getString(1));
					rwsLocationBean.setHabName(rset.getString(2));
					rwsLocationBean.setPopulation(rset.getString(3));
					rwsLocationBean.setStatus(rset.getString(4));
					habs.add(rwsLocationBean);
				}
				proposalDTO.setHabs(habs);
				
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMWorkDetials(): \n" + e);			
		}
		finally
		{	
			if(rset1 != null)
			{
				try
				{	rset1.close();					
				}
				catch(SQLException sqle){ }
			}
			if(stat1 != null)
			{
				try
				{	stat1.close();					
				}
				catch(SQLException sqle){ }
			}
			closeAll();
		}
		
		return proposalDTO;
	}
	
	/**
	*
	*
	*/
	public EstimateDTO getOMWorkAmount(String workId, String tsOffice, String designationCode) throws Exception
	{

		query = " SELECT estimate_cost, sanctioned_amount FROM rws_om_proposal_tbl "
			  + " WHERE work_id = '" + workId + "'";
		
		conn = dataSource.getConnection();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		EstimateDTO estimateDTO = new EstimateDTO();
		double estimateAmount = 0;
		double sanctionedAmount = 0;	
		if(rset.next())
		{
			estimateAmount = rset.getDouble(1);
			sanctionedAmount = rset.getDouble(2);
			estimateDTO.setEstimateAmount(rset.getString(1));
			estimateDTO.setSanctionedAmount(rset.getString(2));
		}
		
		closeAll();
		return estimateDTO;
	}



	/**
	*
	*
	*/
	public ArrayList getWorkComponents(String workId, String type) throws Exception
	{
		//System.out.println("Work Id : " + workId);
		//System.out.println("Work Type : " + type);
		if(type.equals("new"))
		{
			query = " SELECT C.asset_component_code, A.asset_component_name, C.amount "
				  + " FROM rws_new_est_tbl E, rws_new_est_comp_lnk_tbl C, rws_asset_component_type_tbl A"
				  + " WHERE C.work_id = E.work_id AND ( C.asset_component_code = A.asset_component_code "
				  + " AND E.type_of_asset_code = A.type_of_asset_code) "
				  + " AND C.work_id = '" + workId + "'";
		}
		else
		if(type.equals("om"))
		{
			query = " SELECT C.asset_component_code, A.asset_component_name, C.amount "
				  + " FROM rws_om_est_tbl E, rws_om_est_comp_lnk_tbl C, rws_asset_component_type_tbl A"
				  + " WHERE C.work_id = E.work_id AND ( C.asset_component_code = A.asset_component_code "
				  + " AND E.type_of_asset_code = A.type_of_asset_code) "
				  + " AND C.work_id = '" + workId + "'";
		}
		//System.out.println("Query is : " + query);
		
		conn = dataSource.getConnection();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
		ArrayList workComponents = new ArrayList();
		EstimateHolder estimateHolder = null;
		while(rset.next())
		{
			estimateHolder = new EstimateHolder();
			estimateHolder.setAssetComponent(rset.getString(1));
			estimateHolder.setAssetComponentCode(rset.getString(2));
			estimateHolder.setAmount(rset.getString(3));
			
			workComponents.add(estimateHolder);
		}
		closeAll();
		return workComponents;
	}
	
	public ArrayList getComponents()throws Exception
    {
    	ArrayList mileStones=null;
       ResultSet rs=null;
       PreparedStatement prpStmt = null;
       conn=RwsOffices.getConn();
    	try
		{
          String sqlQuery = " SELECT   *  from   rws_tech_components_tbl order by 2" ;
	       //System.out.println(sqlQuery);
          prpStmt = conn.prepareStatement(sqlQuery);
          rs = prpStmt.executeQuery();
          mileStones=new ArrayList();
          rws_works_WorkStatus_bean bean=null;
     	   while(rs.next())
			{
     	       bean=new rws_works_WorkStatus_bean();
     	       bean.setMileStone(rs.getString(1));
     	       bean.setMileStoneName(rs.getString(2));
     	       mileStones.add(bean);
     	 	}
          if(rs!=null)rs.close();
          //System.out.println("Milesotnes size is:"+mileStones.size());

      } 
      catch ( SQLException e ) 
		{
          System.err.println("SQL Exception occured while accessing the table" );
          e.printStackTrace();
          return null;
      }
      catch ( Exception e ) 
		{
          e.printStackTrace();
          return null;
      }
      finally
		{
      	if(prpStmt!=null)prpStmt.close();
         	if(rs!=null)rs.close();
           if(conn!=null)conn.close();
		}
    	return mileStones;
    }
	public ArrayList getItems(String comp_code)throws Exception
     {
     	ArrayList mileStones=null;
        ResultSet rs=null;
        PreparedStatement prpStmt = null;
        conn=RwsOffices.getConn();
     	try
		{
           String sqlQuery = " SELECT   *  from   rws_tech_comp_items_tbl where comp_code='"+comp_code+"' order by 3" ;
	       Debug.println(sqlQuery);
           prpStmt = conn.prepareStatement(sqlQuery);
           rs = prpStmt.executeQuery();
           mileStones=new ArrayList();
           rws_works_WorkStatus_bean bean=null;
      	   while(rs.next())
 			{
      	       bean=new rws_works_WorkStatus_bean();
      	       bean.setStage(rs.getString(2));
      	       bean.setStageName(rs.getString(3));
      	       mileStones.add(bean);
      	 	}
           if(rs!=null)rs.close();
           Debug.println("Items size is in method:"+mileStones.size());

       } 
       catch ( SQLException e ) 
		{
           System.err.println("SQL Exception occured while accessing the table" );
           e.printStackTrace();
           return null;
       }
       catch ( Exception e ) 
		{
           e.printStackTrace();
           return null;
       }
       finally
		{
       	if(prpStmt!=null)prpStmt.close();
          	if(rs!=null)rs.close();
            if(conn!=null)conn.close();
		}
     	return mileStones;
     }
// inserting technical milestones 
	 public int insertMistoneData(ArrayList selectedList,String workCode,rws_works_WorkStatus_bean worksBean) throws Exception
		{
		 	boolean sucess=true;
		 	Statement stmt=null,stmt1=null;
			ResultSet rset=null;
			conn=RwsOffices.getConn();  
			stmt=conn.createStatement();
			stmt1=conn.createStatement();
			String query="";
			try
			{
				rws_works_WorkStatus_bean mileStoneBean=new rws_works_WorkStatus_bean();
				for(int i=0;i<selectedList.size();i++)
				{
					mileStoneBean=(rws_works_WorkStatus_bean)selectedList.get(i);
					String qry = "select * from RWS_TECH_MILESTONE_TAR_TBL where work_id='"+workCode+"' and MILESTONE_SLNO='"+mileStoneBean.getMajorMileStone()+"'";
					Debug.println("qry:"+qry);
					 rset = stmt.executeQuery(qry);
					if(rset.next())  
					{
						
					query=" update RWS_TECH_MILESTONE_TAR_TBL set MILESTONE_SLNO='"+mileStoneBean.getMajorMileStone()+"',MILESTONE_CODE='"+mileStoneBean.getMileStone()+"',QTY='"+mileStoneBean.getQtyts()+"',UNITS='"+mileStoneBean.getUnitsts()+"',AMOUNT='"+mileStoneBean.getAmountts()+"' where WORK_ID='"+workCode+"' and ITEM_NO='"+mileStoneBean.getMileStoneSno()+"'" ;	
					}
					else
					{
					 
					 query="insert into RWS_TECH_MILESTONE_TAR_TBL (WORK_ID,MILESTONE_CODE,QTY,UNITS,AMOUNT,MILESTONE_SLNO,ITEM_NO) values('"+workCode+"','"+mileStoneBean.getMileStone()+"','"+mileStoneBean.getQtyts()+"','"+mileStoneBean.getUnitsts()+"','"+mileStoneBean.getAmountts()+"','"+mileStoneBean.getMajorMileStone()+"','"+mileStoneBean.getMileStoneSno()+"')";
					}
					Debug.println("query:"+query);
					stmt1.addBatch(query);
				}
 	//	}
				int rcounts[]=stmt1.executeBatch();
				for(int i=selectedList.size()+2;i<rcounts.length;i++)
				if(rcounts[i]<1)
					sucess=false;
			}catch(Exception e)
			{
			 Debug.println("Exception in in Inserting MileStones Data:"+e);	
			}
		 	if(sucess)
			{
			return 1;
			}
			else
			return -1;
		}
	 
	 // Technical MileStones view of from
	 
	 public ArrayList getMileStoneData(String workId)throws Exception
	 {
	 	ArrayList miledata=new ArrayList();
	 	ResultSet rs=null;
        PreparedStatement pstmt = null;
	    conn=RwsOffices.getConn();
     	rws_works_WorkStatus_bean bean=null;
     	try
		{
     	  String sqlQuery = "select * from rws_tech_item_target_tbl where  WORK_ID  ='"+workId+"' order by ITEM_SLNO" ;
     	  Debug.println(sqlQuery);
          pstmt = conn.prepareStatement(sqlQuery);
          rs = pstmt.executeQuery();
          while(rs.next())
		  {
          	bean=new rws_works_WorkStatus_bean();
          	bean.setMileStoneSno(rs.getString("ITEM_SLNO"));
          	bean.setMileStone(rs.getString("COMP_CODE"));
          	bean.setItem(rs.getString("ITEM_CODE"));
          	bean.setQtyts(rs.getString("QTY"));
          	bean.setUnitsts(rs.getString("UNITS"));
          	bean.setAmountts(rs.getString("AMOUNT"));
          	miledata.add(bean);
		   }
          
		}catch(Exception e)  
		{
		Debug.println("Exception in getMileStoneData method:"+e);	
		}
	 	return miledata;
	 }
//	code addded by ramesh on 26112010 for getting works for ts preparation
		public ArrayList getWorkIds(String ccode,String divcode,String subcode,String assetType) throws Exception
		{
		 ArrayList work=new ArrayList();
		 StringBuffer qry=new StringBuffer(); 
		 try{
		 conn = RwsOffices.getConn();
		 stat = conn.createStatement();
		 qry.append("select work_id,work_name from rws_work_admn_tbl where admin_date is not null  and  work_id not in (select work_id from rws_contractor_selection_tbl) and  work_id not in (select work_id from RWS_work_commencement_TBL) and  work_id not in (select work_id from RWS_work_completion_TBL) and  substr(office_code,2,2)='"+ccode+"' and  substr(office_code,4,1)='"+divcode+"' and  category_code ='"+assetType+"'");
		 if(subcode!=null && !subcode.equals("")&& !subcode.equals("0")){
		 qry.append(" and  substr(office_code,5,2)='"+subcode+"'");}
		 qry.append(" order by 1");
		 Debug.println("qry:"+qry);
		 rset = stat.executeQuery(qry.toString());
		 LabelValueBean labelValueBean = null;
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
		public ArrayList getAssetTypesWork() throws Exception
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
				LabelValueBean labelValueBean = null;
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
		public int insertTsDetails(TsMileStoneForm bean,ArrayList Habs,ArrayList items)throws Exception
		{
	    	
	   	    java.util.Date d=new java.util.Date();
	   	    Debug.println("date:"+d);
	   	    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	   	    SimpleDateFormat format  = new SimpleDateFormat("yyyy");
	   	    String curruntDate=formatter.format(d);
	   	    Debug.println("date1:"+curruntDate);
	   	  //  SimpleDateFormat formatter1 = new SimpleDateFormat("dd/mon/yyyy");
		   //	String curruntDate1=formatter1.format(d);
	   	    //Debug.println("date2:"+curruntDate1);
	   	    String currentYear=format.format(d);
	   	    int status = -1;
	        ResultSet rs=null;
	        Statement prpStmt = null;
	        Connection connection = null;
	        Statement sttt = null;
	        ResultSet rsss = null;
	      try
			{
	      		connection = RwsOffices.getConn();
	      		prpStmt = connection.createStatement();
	      		connection.setAutoCommit(false);
	            sttt = connection.createStatement();
	            String qq = "select * from RWS_NEW_EST_TBL where work_id='"+bean.getWorkId()+"'";
	            Debug.println("1:"+qq);
	            rsss = sttt.executeQuery(qq);
	            if(!rsss.next()){
				       String sqlQuery = "INSERT INTO RWS_NEW_EST_TBL(OFFICE_CODE  ,FINANCIAL_YEAR ,SOURCE_CODE ," +
				       		"WORK_ID,TYPE_OF_ASSET_CODE ,TS_GIVEN_BY ,TS_NO ,TS_DATE,TS_AMOUNT " +
				       		",SSR_YEAR ,PREPARED_BY , PREPARED_ON,ts_office,UPDATE_DATE)" +
				       		"values('"+bean.getOfficeCode()+"','"+currentYear+"',''," +
				       		"'"+bean.getWorkId()+"','"+(bean.getWorkId()).substring(6,8)+"','"+bean.getTsAccBy()+"'," +
				       		"'"+bean.getTsNo()+"',to_date('"+bean.getTsDate()+"','dd/mm/yyyy')," +
				       		"'"+bean.getTsAmnt()+"','"+bean.getSyr()+"','"+bean.getPreparedBy()+"',to_date('"+curruntDate+"','dd/mm/yyyy')," +
				       		"'"+bean.getTsOffice()+"',to_date('"+curruntDate+"','dd/mm/yyyy')) ";
				       Debug.println("12:"+sqlQuery);
				       
			           prpStmt.addBatch(sqlQuery);
			           
			           for(int i=0;i<Habs.size();i++)
			           {
				           	if(!Habs.get(i).equals("00000000000000"))
				           	{
				           		sqlQuery="INSERT INTO RWS_EST_NEW_HAB_LNK_TBL(WORK_ID,HAB_CODE)values('"+bean.getWorkId()+"','"+Habs.get(i)+"')";
				           		Debug.println("13:"+sqlQuery);
				           		prpStmt.addBatch(sqlQuery);
				           	}
			           }
			           status= 1;
	            }
	            else
	            {
					String sqlQuery = "UPDATE RWS_NEW_EST_TBL SET OFFICE_CODE='"+bean.getOfficeCode()+"'  ,FINANCIAL_YEAR='"+currentYear+"' ," +
						"TS_NO ='"+bean.getTsNo()+"',TS_DATE=to_date('"+bean.getTsDate()+"','dd/mm/yyyy')," +
						"TS_AMOUNT='"+bean.getTsAmnt()+"' ,SSR_YEAR='"+bean.getSyr()+"' ,PREPARED_BY='"+bean.getPreparedBy()+"' , " +
						"PREPARED_ON =to_date('"+curruntDate+"','dd/mm/yyyy'),ts_office='"+bean.getTsOffice()+"'," +
						"update_date=to_date('"+curruntDate+"','dd/mm/yyyy') WHERE WORK_ID='"+bean.getWorkId()+"'" ;
					Debug.println("22:"+sqlQuery);
					prpStmt.addBatch(sqlQuery);
					
					sqlQuery = "DELETE FROM RWS_EST_NEW_HAB_LNK_TBL WHERE WORK_id='"+bean.getWorkId()+"'";
					Debug.println("23:"+sqlQuery);
					prpStmt.addBatch(sqlQuery);
					
					for(int i=0;i<Habs.size();i++)
					{
						if(!Habs.get(i).equals("00000000000000"))
						{
							sqlQuery="INSERT INTO RWS_EST_NEW_HAB_LNK_TBL(WORK_ID,HAB_CODE)values('"+bean.getWorkId()+"','"+Habs.get(i)+"')";
							Debug.println("24:"+sqlQuery);
					       	prpStmt.addBatch(sqlQuery);
						}
					}
					status= 2;
	            }
	            //prpStmt.executeBatch();
				//Statement StmtNew1 = connection.createStatement();
				String sqlQry = "delete from rws_tech_item_target_tbl where work_id='"+bean.getWorkId()+"'";
				Debug.println("31:"+sqlQry);
				prpStmt.addBatch(sqlQry);
				for(int i=0;i<items.size();i++)
				{
					rws_works_WorkStatus_bean mileStoneBean=(rws_works_WorkStatus_bean)items.get(i);
					sqlQry="INSERT INTO rws_tech_item_target_tbl values('"+bean.getWorkId()+"','"+mileStoneBean.getMileStoneSno()+"','"+mileStoneBean.getMileStone()+"','"+mileStoneBean.getItem()+"','"+mileStoneBean.getQtyts()+"','"+mileStoneBean.getUnitsts()+"','"+mileStoneBean.getAmountts()+"')";
					Debug.println("32:"+sqlQry);
					prpStmt.addBatch(sqlQry);
				}
				Debug.println("before executed:"+prpStmt);
				prpStmt.executeBatch();
				//StmtNew1.executeBatch();
				Debug.println("all executed" );
	           connection.setAutoCommit(true);
	           Debug.println("all executed1" );
	           connection.commit();
	           Debug.println("all executed2" );
	           
	   
	       } 
	       catch ( SQLException e ) 
			{
	       		Debug.println("11111:"+e.getErrorCode());
	       		connection.rollback();
	           Debug.println("SQL Exception occured" );
	           e.printStackTrace();
	           return -1;
	       }
	       catch ( Exception e ) 
			{
	       		connection.rollback();
	       		Debug.println("Exception occured:"+e.getMessage());
	       		Debug.println("1:"+e.getCause());
	       		
	           e.printStackTrace();
	           return -1;
	       }
	       finally
			{
	       		if(prpStmt!=null)prpStmt.close();
	          	if(rs!=null)rs.close();
	          	if(rsss!=null)rsss.close();
	          	if(sttt!=null)sttt.close();
	            if(connection!=null)connection.close();
			}
	       Debug.println("status:"+status);
	       return status;
	      	
		}
		public int RemoveItems(String workId,String[] index,ArrayList Milestones)
		{
			int returnValue = 0;
			ResultSet rs=null;
	        PreparedStatement prpStmt = null;
	        Connection connection = null;
	        rws_works_WorkStatus_bean bean = null;
	        Debug.println("index length:"+index.length);
			try
			{
				connection = RwsOffices.getConn();
				connection.setAutoCommit(false);
				String qry = "delete from rws_tech_item_target_tbl where work_id='"+workId+"' and ITEM_SLNO = ?";
				Debug.println("qry:"+qry);
				prpStmt = connection.prepareStatement(qry);
				int removedMs = 0;
				for (int i = 0; i < index.length; i++) {
					int ndx = 0;
					if (index[i] != null) {
						try {
							ndx = Integer.parseInt(index[i]);
							bean = (rws_works_WorkStatus_bean) Milestones.get(Integer.parseInt(index[i]));
							Debug.println("code:"+bean.getMileStoneSno());
							prpStmt.setString(1,bean.getMileStoneSno());
							prpStmt.addBatch();
						}
						catch(Exception e){e.printStackTrace();}
					}
				}
				int count[] = prpStmt.executeBatch();
				if(count!=null)
					returnValue = count.length;
				Debug.println("returnValue:"+returnValue);
				connection.setAutoCommit(true);
				connection.commit();
				
			}
			catch ( Exception e ) 
			{
	       		try {
					connection.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
	       		Debug.println("Exception occured:"+e.getMessage());
				}
	       		Debug.println("1:"+e.getCause());
	            e.printStackTrace();
	       }
	       finally
			{
				try {
					if(prpStmt!=null)prpStmt.close();
					if(rs!=null)rs.close();
		            if(connection!=null)connection.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}	          	
			}
			return returnValue;
		}
}
