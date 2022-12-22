package nic.watersoft.proposals;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.StringTokenizer;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.ProgrammeSubProgrammeBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.RwsUtils;

public class ProposalDAO{	
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
	private ProposalDTO proposalDTO;
	private RwsOffices rwsOffices; 
	private boolean flag;
	private int ans1 = 0, ans2 = 0;
	
	public int HEAD_OF_OFFICE_COUNT = 1;
	public String errorMessage = "";	
	public ProposalDAO(){
		try	{
			Connection conn = RwsOffices.getConn();			
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO : \n" + e.getMessage());		
		}
	}

	public ProposalDAO(DataSource dataSource){
		this.dataSource = dataSource;
		flag = false;
	}	
	
	
	public boolean consider(String[] proposalIds, ProposalDTO proposalDTO){
		Connection conn = null;
		Statement stat = null;		
		String preparedBy = proposalDTO.getUserId();
		if(proposalIds != null || proposalIds.length > 0){
			int[] updateCounts=null;
			try	{				
				conn = getConn();
				conn.setAutoCommit(false);
				stat = conn.createStatement();
				for(int i=0; i<proposalIds.length; i++)	{
					query = " UPDATE rws_rep_proposal_tbl SET flag='C' WHERE proposal_id = '" + proposalIds[i] + "'";
					stat.addBatch(query);
					query = " INSERT INTO rws_work_proposal_tbl(office_code, no_of_habs, "
						  + " proposal_id, proposal_name, programme_code, "
						  + " subprogramme_code, estimate_cost, prepared_by, "
						  + " prepared_on, remarks, priority_code, type_of_asset, flag) ( "
						  + " SELECT office_code, no_of_habs, proposal_id, proposal_name, "
						  + " programme_code, subprogramme_code, estimate_cost, "
						  + " '" + preparedBy +"',SYSDATE, remarks, priority_code, "
						  + " type_of_asset, flag FROM rws_rep_proposal_tbl WHERE proposal_id = '" + proposalIds[i] + "')";
					stat.addBatch(query);
					query = " UPDATE rws_work_proposal_tbl set sanc_office='HO' where proposal_id='" +
							proposalIds[i] + "'";
					stat.addBatch(query);					
					query = " INSERT INTO rws_work_proposal_mirror_tbl(office_code, no_of_habs, "
						  + " proposal_id, proposal_name, programme_code, "
						  + " subprogramme_code, estimate_cost, prepared_by, prepared_on, remarks,"
						  + " flag, priority_code, type_of_asset, modified_by, modified_on, track_no) "
						  + " ( SELECT office_code, no_of_habs, proposal_id, proposal_name, programme_code,"
						  + " subprogramme_code, estimate_cost, prepared_by, prepared_on, remarks,"
						  + " flag, priority_code, type_of_asset, '" + preparedBy + "', SYSDATE, 0 "  
						  + " FROM rws_rep_proposal_tbl WHERE proposal_id = '" + proposalIds[i] + "')";
					stat.addBatch(query);
				}
				updateCounts = stat.executeBatch();
				flag = true;
				for(int i=0; i<updateCounts.length; i++){
					if(updateCounts[i] != 1)
						flag = false;
				}
				if(flag)
					conn.commit();
				conn.setAutoCommit(true);
				
			}
			catch(Exception e){	
				Debug.writeln("The Exception is in ProposalDAO consider : \n" + e.getMessage());			
				for(int i=0; i<updateCounts.length; i++){
					Debug.writeln("The Exception is in ProposalDAO consider update counts = "+updateCounts[i]);
				}			
			}
			finally	{
				try{
					if(stat != null){
						stat.close();					
					}
					if(conn != null){	
						conn.close();
					}
				}
				catch(SQLException sqle){ 
					Debug.writeln("The Exception is in ProposalDAO consider finally : \n" + sqle.getMessage());						
				}
			}
		}
		return flag;
	}
	
	
	public boolean submit(String[] proposalIds, ProposalDTO proposalDTO){
		Connection conn = null;
		Statement stat = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		String officeCode = proposalDTO.getOfficeCode();
		String actionFrom = proposalDTO.getOfficeCode();
		String actionTo =  proposalDTO.getSubmitTo();
		String sentBy = proposalDTO.getUserId();;
		String sentTo = null;
		String officeType = null;		
		try	{
			conn = getConn();			
			if(!actionTo.substring(4,6).equals("00"))
				officeType = "SUB DIVISION OFFICE";
			else if(!actionTo.substring(3,4).equals("0"))
				officeType = "DIVISION OFFICE";
			else if(!actionTo.substring(1,3).equals("00"))
				officeType = "CIRCLE OFFICE";
			else if(!actionTo.substring(0,1).equals("0"))
				officeType = "HEAD OFFICE";	
			query = " SELECT user_id FROM rws_password_tbl WHERE designation_code = "
				  + " (SELECT designation_code FROM rws_head_of_office_tbl WHERE office LIKE ? )" 
				  + " AND office_code = '" + actionTo + "'";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, officeType);
			rset = stmt.executeQuery();
			int rowCount = 0;			
			while(rset.next()){
				rowCount++;
				sentTo = rset.getString(1);
			}
			if(rowCount != 1){
				HEAD_OF_OFFICE_COUNT = rowCount;
				return false;
			}
			conn.setAutoCommit(false);		
			for(int i=0; i<proposalIds.length; i++)	{				
				int trackNo = getNextTrackNo(proposalIds[i]);								
				query = " INSERT INTO rws_work_proposal_mirror_tbl(office_code, no_of_habs, "
					  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
					  + " estimate_cost, prepared_by, prepared_on, remarks, flag, priority_code,"
					  + " type_of_asset, modified_by, modified_on, track_no)"
					  + " (SELECT office_code, no_of_habs, proposal_id, proposal_name, "
					  + " programme_code, subprogramme_code, estimate_cost, prepared_by, prepared_on, "
					  + " remarks, flag, priority_code, type_of_asset, "
					  + " '" + sentBy + "', SYSDATE, " + trackNo + " FROM rws_work_proposal_tbl"
					  + " WHERE proposal_id = '" + proposalIds[i] + "')";
				stat.addBatch(query);								
				if(trackNo > 1)	{
					query = " UPDATE rws_proposal_workflow_tbl SET flag='Y' " 
						  + " WHERE proposal_id = '" + proposalIds[i] + "' AND track_no = " + (trackNo-1);
					stat.addBatch(query);
				}			
				query = " INSERT INTO rws_proposal_workflow_tbl(proposal_id, track_no," 
					  + " action_from, action_to, action_type, action_date, sent_by,"
					  + " sent_to, memo_no, subject, ref, content, for_sub_date, flag)"
					  + " VALUES('" + proposalIds[i] + "'," + trackNo + ", "
					  + " '" + actionFrom + "', '" + actionTo + "', " 
					  + " 'S', SYSDATE, " 
					  + " '" + sentBy + "', '" + sentTo + "'," 
					  + " '" + proposalDTO.getLetterNo() + "'," 
					  + " '" + proposalDTO.getSubmitSubject() + "',"
					  + " '" + proposalDTO.getSubmitRef() + "'," 
					  + " '" + proposalDTO.getSubmitContent() + "',"
					  + " TO_DATE('"+proposalDTO.getSubmitDate()+"','dd/mm/yyyy'),'N')";
				stat.addBatch(query);
			}
			int arr[]=stat.executeBatch();
			flag = true;								
			conn.commit();
			conn.setAutoCommit(true);
		}
		catch(Exception e){
			Debug.writeln("The Exception is in ProposalDAO submit : \n" + e.getMessage());		
		}
		finally	{
			try{
				if(rset != null){		
					rset.close();
				}
				if(stmt != null){
					stmt.close();					
				}
				if(stat != null){
					stat.close();					
				}				
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){ 
				Debug.writeln("The Exception is in ProposalDAO submit finally : \n" + sqle.getMessage());						
			}			
		}
		return flag;
	}
	
	
	public boolean forward(String[] proposalIds, ProposalDTO proposalDTO){
		Connection conn = null;
		Statement stat = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;		
		String officeCode = proposalDTO.getOfficeCode();
		String actionFrom = proposalDTO.getOfficeCode();
		String forwardTo = proposalDTO.getForwardTo();
		String[] actionTo = null;
		String sentBy = proposalDTO.getUserId();
		String sentTo = null;
		String officeType = null;
		StringTokenizer stringTokenizer = new StringTokenizer(forwardTo,",");
		int noOfForwards = stringTokenizer.countTokens();		
		actionTo = new String[noOfForwards];
		int k=0;
		while(stringTokenizer.hasMoreElements()){
			actionTo[k] = stringTokenizer.nextToken();
			k++;
		}		
		String employeeCodes[] = new String[actionTo.length]; 
		try	{
			conn = getConn();
			stat = conn.createStatement();			
			for(int	i=0; i< actionTo.length; i++){
				if(!actionTo[i].substring(4,6).equals("00"))
					officeType = "SUB DIVISION OFFICE";
				else
				if(!actionTo[i].substring(3,4).equals("0"))
						officeType = "DIVISION OFFICE";
				else
				if(!actionTo[i].substring(1,3).equals("00"))
					officeType = "CIRCLE OFFICE";
				else
				if(!actionTo[i].substring(0,1).equals("0"))
					officeType = "HEAD OFFICE";
				
				query = " SELECT user_id FROM rws_password_tbl WHERE designation_code = "
					  + " (SELECT designation_code FROM rws_head_of_office_tbl WHERE office LIKE  ? )" 
					  + " AND office_code =  ? ";				
				stmt = conn.prepareStatement(query);
				stmt.setString(1, officeType);
				stmt.setString(2, actionTo[i]);
				rset = stmt.executeQuery();
				while(rset.next()){
					employeeCodes[i] = rset.getString(1);
				}
			}
			int p = 0;
			for (int i=0; i<employeeCodes.length; i++){
				if(employeeCodes[i] != null)
						p++;
			}
			if(p != employeeCodes.length){
				HEAD_OF_OFFICE_COUNT = p;
				return false;
			}
			conn.setAutoCommit(false);							
			for(int i=0; i<proposalIds.length; i++){
				int trackNo = getNextTrackNo(proposalIds[i]);				
				query = " INSERT INTO rws_work_proposal_mirror_tbl(office_code, no_of_habs, "
					  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
					  + " estimate_cost, prepared_by, prepared_on, state_central, "
					  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
					  + " goms_no, admin_sanc_auth, sanction_amount, modified_by, modified_on, "
					  + " track_no, phased, phase_no ) "
					  + " (SELECT office_code, no_of_habs, "
					  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
					  + " estimate_cost, prepared_by, prepared_on, state_central, "
					  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
					  + " goms_no, admin_sanc_auth, sanction_amount, "
					  + " '" + sentBy + "', SYSDATE, " + trackNo + ", phased, phase_no "
					  + " FROM rws_work_proposal_tbl "
					  + " WHERE proposal_id = '" + proposalIds[i] + "')";
				stat.addBatch(query);
				int updateTrackNo=0;			
				updateTrackNo=getTrackNo(proposalIds[i],sentBy);
				for(int j=0; j< noOfForwards; j++){					
					if(updateTrackNo > 1){
						query = " UPDATE rws_proposal_workflow_tbl SET flag='Y' WHERE proposal_id = '" + proposalIds[i] + "' AND track_no = " + (updateTrackNo);
						stat.addBatch(query);
					}					
					query = " INSERT INTO rws_proposal_workflow_tbl(proposal_id, track_no, "
						  + " action_from, action_to, action_type, action_date, "
						  + " sent_by, sent_to, memo_no, subject, ref, content, for_sub_date,flag) "
						  + " VALUES('" + proposalIds[i] + "'," + trackNo + ", "
						  + " '" + actionFrom + "', '" + actionTo[j] + "', 'F', SYSDATE, " 
						  + " '" + sentBy + "', "
						  + " '" + employeeCodes[j] + "', " 
						  + " '" + proposalDTO.getMemoNo() + "', " 
						  + " '" + proposalDTO.getForwardSubject() + "', "
						  + " '" + proposalDTO.getForwardRef() + "', " 
						  + " '" + proposalDTO.getForwardContent() + "',"
						  + " TO_DATE('"+proposalDTO.getForwardDate()+"','dd/mm/yyyy'),'N')";
					stat.addBatch(query);
				}
			}
			flag = true;
			int[] updateCounts = stat.executeBatch();
			for(int i=0; i<updateCounts.length; i++){
				Debug.println("updateCounts["+i+"]="+updateCounts[i]);
				if(updateCounts[i] != 1)
					flag = false;
			}  
			if(flag)
				conn.commit();
			conn.setAutoCommit(true);			
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO forward : \n" + e.getMessage());		
		}
		finally	{
			try{
				if(rset != null){		
					rset.close();
				}
				if(stmt != null){
					stmt.close();					
				}
				if(stat != null){
					stat.close();					
				}				
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){ 
				Debug.writeln("The Exception is in ProposalDAO forward finally : \n" + sqle.getMessage());						
			}				
		}
		return flag;
	}
	
	
	
	public ArrayList getAdminstativeSanctionedWorkIds(String headOfficeCode, String circleOfficeCode,String  DivisionCode,String subdiv,String asset,String prog,String subProg,String plan,String wrkType,String workCat) throws Exception{
		ArrayList workIds = new ArrayList();
		Connection conn=null;
		boolean where_added=false;
		try	{
			query = "select distinct ad.work_id,ad.work_name ,ad.office_code from rws_work_admn_tbl ad where ";				
			if(circleOfficeCode!=null && !circleOfficeCode.equals("")){
				if(where_added){
					query=query.concat(" and ");
					where_added=true;
				}
				query=query.concat("substr(ad.WORK_ID,5,2)='"+circleOfficeCode+"'");
				where_added=true;
			}
			if(DivisionCode!=null && !DivisionCode.equals("")){
				if(where_added){
					query=query.concat(" and ");
					where_added=true;
				}
				query=query.concat(" substr(ad.office_code,4,1)='"+DivisionCode+"'");
				where_added=true;
			}
			if(asset!=null && !asset.equals("")){
				if(where_added)	{
					query=query.concat(" and ");
					where_added=true;
				}
				query=query.concat(" TYPE_OF_ASSET ='"+asset+"'");
				where_added=true;
			}
			if(subdiv!=null && !subdiv.equals("")){
				if(where_added)	{
					query=query.concat(" and ");
					where_added=true;
				}
				query=query.concat(" substr(ad.office_code,5,2)='"+subdiv+"' ");
				where_added=true;
			}
			if(prog!=null && !prog.equals("")){
				if(where_added){
					query=query.concat(" and ");
					where_added=true;
				}
				query=query.concat(" substr(ad.work_id,1,2)='"+prog+"' ");
				where_added=true;
			}
			if(subProg!=null && !subProg.equals("")){
				if(where_added)	{
					query=query.concat(" and ");
					where_added=true;
				}
				query=query.concat(" substr(ad.work_id,3,2)='"+subProg+"'");
				where_added=true;
			}
			if(asset!=null && !asset.equals("")){
				if(where_added){
					query=query.concat(" and ");
					where_added=true;
				}					
				query=query.concat(" substr(ad.work_id,7,2)='"+asset+"'");
				where_added=true;
			}
			if(workCat!=null && !workCat.equals("")){
				if(where_added)	{
					query=query.concat(" and ");
					where_added=true;
				}
				query=query.concat(" ad.category_code='"+workCat+"'");
				where_added=true;
			}
			if(plan!=null && !plan.equals("")){
				if(where_added){
					query=query.concat(" and ");
					where_added=true;
				}
				query=query.concat(" ad.plan_code='"+plan+"'");
				where_added=true;
			}
			if(wrkType!=null && !wrkType.equals("")){
				if(where_added)	{
					query=query.concat(" and ");
					where_added=true;
				}
				query=query.concat(" ad.aug_new_code='"+wrkType+"'");
				where_added=true;
			}
			conn = getConn();
			PreparedStatement stat = conn.prepareStatement(query);
			ResultSet rset = stat.executeQuery();
			while(rset.next()){			
				String query1="select work_id from RWS_REVISED_ADM_SANC_TBL where work_id= ? ";
				PreparedStatement statement=conn.prepareStatement(query1);
				statement.setString(1, rset.getString(1));
				ResultSet resultSet=statement.executeQuery();
				if(resultSet.next()){}
				else{
					LabelValueBean labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					workIds.add(labelValueBean);
				}
				if(resultSet != null){
					resultSet.close();
				}
				if(statement != null){
					statement.close();
				}
			}
		} catch(Exception e){
			System.out.println("The Exception is in ProposalDAO getAdminstativeSanctionedWorkIds : "+ e.getMessage());
		} finally {
			conn.close();
		}
		return workIds;
	}
	
	
	public ProposalDTO getWorkDetails1(String workId ,String workName) throws Exception	{
		ProposalDTO	proposalDTO=null;
		Connection conn=null;
		try	{
			query = "select distinct w.category_name,pl.plan_name,a.aug_new_name,p.programme_name,s.subprogramme_name,ad.work_name,lead_habitation" +
				" from rws_work_admn_tbl ad,rws_work_category_tbl w,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl a," +
				" rws_programme_tbl p,rws_subprogramme_tbl s where ad.category_code=w.category_code and pl.plan_code=ad.plan_code " +
				" and ad.aug_new_code=a.aug_new_code and p.programme_code=ad.programme_code and " +
				"s.subprogramme_code=ad.subprogramme_code and ad.work_ID= ? and ad.work_name= ? ";
 			conn = getConn();
			PreparedStatement stat = conn.prepareStatement(query);
			stat.setString(1, workId);
			stat.setString(2, workName);
			ResultSet rset = stat.executeQuery();
			proposalDTO = new ProposalDTO();
			if(rset.next())	{
				proposalDTO.setWorkCat(rset.getString(1)); 
				proposalDTO.setPlan(rset.getString(2));
				proposalDTO.setWrkType(rset.getString(3));
				proposalDTO.setProgrammeName(rset.getString(4)); 
				proposalDTO.setSubprogrammeName(rset.getString(5));
				proposalDTO.setLeadHabitation(rset.getString("lead_habitation"));
			}
			if(rset != null){
				rset.close();
			}
			if(stat != null){
				stat.close();
			}
		}
		catch(Exception e){
			System.out.println("The Exception is in ProposalDAO getWorkDetails1 : "+ e.getMessage());
		}
		finally	{	 
			conn.close();
		}
		return proposalDTO;
	}	
	
	
	public boolean forwardFromHeadOffice(String[] proposalIds, ProposalDTO proposalDTO)	{
		Connection conn = null;
		Statement stat = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		try	{
			String officeCode = proposalDTO.getOfficeCode();
			String actionFrom = proposalDTO.getOfficeCode();
			String forwardTo = proposalDTO.getForwardTo();
			String forwardToDivision = proposalDTO.getForwardToDivision();
			String forwardToSubDivision = proposalDTO.getForwardToSubDivision();
			String[] actionTo = null;
			String[] actionToDivision = null;
			String[] actionToSubDivision = null;
			String sentBy = proposalDTO.getUserId();
			String sentTo = null;
			String officeType = null;
			StringTokenizer stringTokenizer = new StringTokenizer(forwardTo,",");
			StringTokenizer stringTokenizerForwardToDivision = new StringTokenizer(forwardToDivision,",");
			StringTokenizer stringTokenizerForwardToSubDivision = new StringTokenizer(forwardToSubDivision,",");
			int noOfForwards = stringTokenizer.countTokens();
			int noOfDivisionForwards = stringTokenizerForwardToDivision.countTokens();
			int noOfSubDivisionForwards = stringTokenizerForwardToSubDivision.countTokens();		
			if(forwardToDivision==null||forwardToDivision.equals("")){
				noOfDivisionForwards=0;
			}
			if(forwardToSubDivision==null||forwardToSubDivision.equals("")){
				noOfSubDivisionForwards=0;
			}		
			actionTo = new String[noOfForwards];
			actionToDivision = new String[noOfDivisionForwards];
			actionToSubDivision = new String[noOfSubDivisionForwards];
			int k=0;
			while(stringTokenizer.hasMoreElements()&& noOfForwards!=0){
				actionTo[k] = stringTokenizer.nextToken();
				k++;
			}
			k=0;
			while(stringTokenizerForwardToDivision.hasMoreElements() && noOfDivisionForwards!=0){
				actionToDivision[k] = stringTokenizerForwardToDivision.nextToken();
				k++;
			}		
			k=0;
			while(stringTokenizerForwardToSubDivision.hasMoreElements() && noOfSubDivisionForwards!=0){
				actionToSubDivision[k] = stringTokenizerForwardToSubDivision.nextToken();
				k++;
			}		
			String employeeCodes[] = new String[actionTo.length]; 
			String DivisionemployeeCodes[] = new String[actionToDivision.length]; 
			String SubDivisionemployeeCodes[] = new String[actionToSubDivision.length]; 		
			conn = getConn();
			stat = conn.createStatement();
			for(int	i=0; i< actionTo.length; i++){
				if(!actionTo[i].substring(4,6).equals("00"))
					officeType = "SUB DIVISION OFFICE";
				else
				if(!actionTo[i].substring(3,4).equals("0"))
						officeType = "DIVISION OFFICE";
				else
				if(!actionTo[i].substring(1,3).equals("00"))
					officeType = "CIRCLE OFFICE";
				else
				if(!actionTo[i].substring(0,1).equals("0"))
					officeType = "HEAD OFFICE";
	
				query = " SELECT user_id FROM rws_password_tbl WHERE designation_code = (SELECT designation_code FROM rws_head_of_office_tbl WHERE office LIKE  ? )" 
					  + " AND office_code =  ? ";
				stmt = conn.prepareStatement(query);		
				stmt.setString(1, officeType);
				stmt.setString(2, actionTo[i]);
				rset = stmt.executeQuery();
				while(rset.next()){
					employeeCodes[i] = rset.getString(1);
				}
				if(stmt != null){
					stmt.close();					
				}
			}
			int p = 0;
			for (int i=0; i<employeeCodes.length; i++){
				if(employeeCodes[i] != null)
					p++;
			}
			if(p != employeeCodes.length){
				HEAD_OF_OFFICE_COUNT = p;
				return false;
			}
			conn.setAutoCommit(false);							
			for(int i=0; i<proposalIds.length; i++){
				int trackNo = getNextTrackNo(proposalIds[i]);					
				query = " INSERT INTO rws_work_proposal_mirror_tbl(office_code, no_of_habs, "
					  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
					  + " estimate_cost, prepared_by, prepared_on, state_central, "
					  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
					  + " goms_no, admin_sanc_auth, sanction_amount, modified_by, modified_on, "
					  + " track_no, phased, phase_no ) "
					  + " (SELECT office_code, no_of_habs, "
					  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
					  + " estimate_cost, prepared_by, prepared_on, state_central, "
					  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
					  + " goms_no, admin_sanc_auth, sanction_amount, "
					  + " '" + sentBy + "', SYSDATE, " + trackNo + ", phased, phase_no "
					  + " FROM rws_work_proposal_tbl "
					  + " WHERE proposal_id = '" + proposalIds[i] + "')";
				stat.addBatch(query);								
				for(int j=0; j< noOfForwards; j++){					
					if(trackNo > 1)	{
						query = " UPDATE rws_proposal_workflow_tbl SET flag='Y' " 
							  + " WHERE proposal_id = '" + proposalIds[i] + "' AND track_no = " + (trackNo-1);
						stat.addBatch(query);
					}					
					query = " INSERT INTO rws_proposal_workflow_tbl(proposal_id, track_no, "
						  + " action_from, action_to, action_type, action_date, "
						  + " sent_by, sent_to, memo_no, subject, ref, content, for_sub_date,flag) "
						  + " VALUES('" + proposalIds[i] + "'," + trackNo + ", "
						  + " '" + actionFrom + "', '" + actionTo[j] + "', 'F', SYSDATE, " 
						  + " '" + sentBy + "', "
						  + " '" + employeeCodes[j] + "', " 
						  + " '" + proposalDTO.getMemoNo() + "', " 
						  + " '" + proposalDTO.getForwardSubject() + "', "
						  + " '" + proposalDTO.getForwardRef() + "', " 
						  + " '" + proposalDTO.getForwardContent() + "',"
						  + " TO_DATE('"+proposalDTO.getForwardDate()+"','dd/mm/yyyy'),'N')";
					stat.addBatch(query);
				}
			}			
			for(int	i=0; i< actionToDivision.length && noOfDivisionForwards!=0; i++){
				if(!actionToDivision[i].substring(4,6).equals("00"))
					officeType = "SUB DIVISION OFFICE";
				else if(!actionToDivision[i].substring(3,4).equals("0"))
						officeType = "DIVISION OFFICE";
				else if(!actionToDivision[i].substring(1,3).equals("00"))
					officeType = "CIRCLE OFFICE";
				else if(!actionToDivision[i].substring(0,1).equals("0"))
					officeType = "HEAD OFFICE";
				query = " SELECT user_id FROM rws_password_tbl WHERE designation_code = (SELECT designation_code FROM rws_head_of_office_tbl WHERE office LIKE ? )" 
					  + " AND office_code = ? ";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, officeType);
				stmt.setString(2, actionToDivision[i]);
				rset = stmt.executeQuery();
				while(rset.next()){
					employeeCodes[i] = rset.getString(1);
				}
				if(stmt != null){
					stmt.close();					
				}
			}
			p = 0;
			for (int i=0; i<employeeCodes.length; i++)	{
				if(employeeCodes[i] != null)
					p++;
			}
			if(p != employeeCodes.length){
				HEAD_OF_OFFICE_COUNT = p;
				return false;
			}
			conn.setAutoCommit(false);							
			for(int i=0; i<proposalIds.length && noOfDivisionForwards!=0; i++){
				int trackNo = getNextTrackNo(proposalIds[i]);
				trackNo++;
					
				query = " INSERT INTO rws_work_proposal_mirror_tbl(office_code, no_of_habs, "
					  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
					  + " estimate_cost, prepared_by, prepared_on, state_central, "
					  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
					  + " goms_no, admin_sanc_auth, sanction_amount, modified_by, modified_on, "
					  + " track_no, phased, phase_no ) "
					  + " (SELECT office_code, no_of_habs, "
					  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
					  + " estimate_cost, prepared_by, prepared_on, state_central, "
					  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
					  + " goms_no, admin_sanc_auth, sanction_amount, "
					  + " '" + sentBy + "', SYSDATE, " + trackNo + ", phased, phase_no "
					  + " FROM rws_work_proposal_tbl "
					  + " WHERE proposal_id = '" + proposalIds[i] + "')";
				stat.addBatch(query);									
				for(int j=0; j< noOfForwards; j++){						
					query = " INSERT INTO rws_proposal_workflow_tbl(proposal_id, track_no, "
						  + " action_from, action_to, action_type, action_date, "
						  + " sent_by, sent_to, memo_no, subject, ref, content, for_sub_date,flag) "
						  + " VALUES('" + proposalIds[i] + "'," + trackNo + ", "
						  + " '" + actionFrom + "', '" + actionToDivision[j] + "', 'F', SYSDATE, " 
						  + " '" + sentBy + "', "
						  + " '" + employeeCodes[j] + "', " 
						  + " '" + proposalDTO.getMemoNo() + "', " 
						  + " '" + proposalDTO.getForwardSubject() + "', "
						  + " '" + proposalDTO.getForwardRef() + "', " 
						  + " '" + proposalDTO.getForwardContent() + "',"
						  + " TO_DATE('"+proposalDTO.getForwardDate()+"','dd/mm/yyyy'),'N')";
					stat.addBatch(query);
				}
			}	
			for(int	i=0; i< actionToSubDivision.length && noOfSubDivisionForwards!=0; i++){
				if(!actionToSubDivision[i].substring(4,6).equals("00"))
					officeType = "SUB DIVISION OFFICE";
				else if(!actionToSubDivision[i].substring(3,4).equals("0"))
					officeType = "DIVISION OFFICE";
				else if(!actionToSubDivision[i].substring(1,3).equals("00"))
					officeType = "CIRCLE OFFICE";
				else if(!actionToSubDivision[i].substring(0,1).equals("0"))
					officeType = "HEAD OFFICE";			
				query = " SELECT user_id FROM rws_password_tbl WHERE designation_code = "
					  + " (SELECT designation_code FROM rws_head_of_office_tbl WHERE office LIKE ? )" 
					  + " AND office_code = ? ";						
				stmt = conn.prepareStatement(query);
				stmt.setString(1, officeType);
				stmt.setString(2, actionToSubDivision[i]);
				rset = stmt.executeQuery();
				while(rset.next()){
					employeeCodes[i] = rset.getString(1);
				}
				if(stmt != null){
					stmt.close();					
				}
			}
			p = 0;
			for (int i=0; i<employeeCodes.length; i++){
				if(employeeCodes[i] != null)
					p++;
			}
			if(p != employeeCodes.length){
				HEAD_OF_OFFICE_COUNT = p;
				return false;
			}
			conn.setAutoCommit(false);							
			for(int i=0; i<proposalIds.length && noOfSubDivisionForwards!=0; i++){
				int trackNo = getNextTrackNo(proposalIds[i]);
				if(noOfDivisionForwards!=0)
					trackNo++;
				trackNo++;
				query = " INSERT INTO rws_work_proposal_mirror_tbl(office_code, no_of_habs, "
					  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
					  + " estimate_cost, prepared_by, prepared_on, state_central, "
					  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
					  + " goms_no, admin_sanc_auth, sanction_amount, modified_by, modified_on, "
					  + " track_no, phased, phase_no ) "
					  + " (SELECT office_code, no_of_habs, "
					  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
					  + " estimate_cost, prepared_by, prepared_on, state_central, "
					  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
					  + " goms_no, admin_sanc_auth, sanction_amount, "
					  + " '" + sentBy + "', SYSDATE, " + trackNo + ", phased, phase_no "
					  + " FROM rws_work_proposal_tbl "
					  + " WHERE proposal_id = '" + proposalIds[i] + "')";
				stat.addBatch(query);										
				for(int j=0; j< noOfForwards; j++){
					query = " INSERT INTO rws_proposal_workflow_tbl(proposal_id, track_no, "
						  + " action_from, action_to, action_type, action_date, "
						  + " sent_by, sent_to, memo_no, subject, ref, content, for_sub_date,flag) "
						  + " VALUES('" + proposalIds[i] + "'," + trackNo + ", "
						  + " '" + actionFrom + "', '" + actionToSubDivision[j] + "', 'F', SYSDATE, " 
						  + " '" + sentBy + "', "
						  + " '" + employeeCodes[j] + "', " 
						  + " '" + proposalDTO.getMemoNo() + "', " 
						  + " '" + proposalDTO.getForwardSubject() + "', "
						  + " '" + proposalDTO.getForwardRef() + "', " 
						  + " '" + proposalDTO.getForwardContent() + "',"
						  + " TO_DATE('"+proposalDTO.getForwardDate()+"','dd/mm/yyyy'),'N')";
					stat.addBatch(query);
				}
			}
			flag = true;
			int[] updateCounts = stat.executeBatch();			
			for(int i=0; i<updateCounts.length; i++){
				if(updateCounts[i] != 1)
					flag = false;
			}  
			if(flag)
				conn.commit();
			conn.setAutoCommit(true);			
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO forwardFromHeadOffice : \n" + e.getMessage());		
		}
		finally	{
			try{
				if(rset != null){		
					rset.close();
				}
				if(stmt != null){
					stmt.close();					
				}
				if(stat != null){
					stat.close();					
				}				
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){ 
				Debug.writeln("The Exception is in ProposalDAO forwardFromHeadOffice finally : \n" + sqle.getMessage());						
			}				
		}
		return flag;
	}
	
	
	public boolean others(String[] proposalIds, ProposalDTO proposalDTO){
		Connection conn = null;
		Statement stat = null;
		try	{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			String actionType = proposalDTO.getActionType();			
			for(int i=0; i<proposalIds.length; i++)	{
				query = " INSERT INTO rws_proposal_workflow_tbl(proposal_id, track_no," 
					  + " action_from, action_to, action_type, action_date, sent_by,"
					  + " sent_to, memo_no, subject, ref, content, for_sub_date, flag)"
					  + " VALUES('" + proposalIds[i] + "', -1,'000000','000000',"
					  + " '" + actionType + "', SYSDATE, "
					  + " '" + proposalDTO.getEmployeeCode() + "',"
					  + " '" + proposalDTO.getEmployeeCode() + "',"
					  + " '000000', '000000','000000',"
					  + " '" + proposalDTO.getRemarks() + "', SYSDATE, 'N')";
				stat.addBatch(query);				
				query = " UPDATE rws_work_proposal_tbl SET flag='"+actionType+"' WHERE proposal_id='"+proposalIds[i]+"'";
				stat.addBatch(query);
			}
			flag = true;
			int updateCounts[]=stat.executeBatch();
			for(int i=0; i<updateCounts.length; i++){
				if(updateCounts[i] == 0)
					flag = false;
			}
			if(flag)
				conn.commit();				
				conn.setAutoCommit(true);
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO others : \n" + e.getMessage());		
		}
		finally	{
			try{
				if(stat != null){
					stat.close();					
				}				
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){ 
				Debug.writeln("The Exception is in ProposalDAO others finally : \n" + sqle.getMessage());						
			}				
		}
		return flag;
	}
	
	
	public boolean considerForSanction(String[] proposalIds, ProposalDTO proposalDTO){
		Connection conn = null;
		Statement stat = null;						
		try{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			String actionType = proposalDTO.getActionType();			
			for(int i=0; i<proposalIds.length; i++){
				int trackNo = getNextTrackNo(proposalIds[i]);				
				query = " INSERT INTO rws_proposal_workflow_tbl(proposal_id, " 
					  + " track_no, action_from, action_to, action_type, "
					  + " action_date, sent_by, sent_to, memo_no, subject, "
					  + " ref, content, for_sub_date, flag)"
					  + " (SELECT proposal_id," + trackNo + ", action_from, "
					  + " action_to, 'P', SYSDATE, sent_by, sent_to, "
					  + " memo_no, subject, ref, content,for_sub_date,'N' "
					  + " FROM rws_proposal_workflow_tbl "
					  + " WHERE proposal_id = '" + proposalIds[i] + "' AND "
					  + " track_no = " + (trackNo-1) + ")";
				stat.addBatch(query);				
				query = " UPDATE rws_proposal_workflow_tbl SET flag='Y' WHERE proposal_id='"+proposalIds[i]+"' AND track_no = " + (trackNo-1);
				stat.addBatch(query);
				
				query = " UPDATE rws_work_proposal_tbl SET flag='P' WHERE proposal_id='"+proposalIds[i]+"'";
				stat.addBatch(query);
				
				query = " UPDATE rws_rep_proposal_tbl SET flag='P' WHERE proposal_id='"+proposalIds[i]+"'";
				stat.addBatch(query);
			}
			flag = true;
			int updateCounts[]=stat.executeBatch();
			for(int i=0; i<updateCounts.length; i++){
				if(updateCounts[i] == 0)
					flag = false;
			}
			if(flag)
				conn.commit();			
			conn.setAutoCommit(true);
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO considerForSanction : \n" + e.getMessage());		
		}
		finally	{
			try{
				if(stat != null){
					stat.close();					
				}				
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){ 
				Debug.writeln("The Exception is in ProposalDAO considerForSanction finally : \n" + sqle.getMessage());						
			}				
		}
		return flag;
	}
	
	
	public boolean sanction(String[] proposalIds, String[] sanctionAmounts, ProposalDTO proposalDTO){
		Connection conn = null;
		Statement stat = null;		
		String officeCode = proposalDTO.getOfficeCode();
		String preparedBy = proposalDTO.getUserId();
		String adminNo = proposalDTO.getAdminNo();
		String adminDate = proposalDTO.getAdminDate();
		String goNo = proposalDTO.getGoNo();
		String sancAuthority = proposalDTO.getSanctioningAuthority();
		String sancAt = proposalDTO.getSanctionedAt();
		String sanctionedAmount = proposalDTO.getSanctionedAmount();		
		if(proposalIds != null || proposalIds.length > 0){
			try{	
				conn = getConn();
				conn.setAutoCommit(false);
				stat = conn.createStatement();
				for(int i=0; i<proposalIds.length; i++){
					query = " UPDATE rws_rep_proposal_tbl SET flag='A' WHERE proposal_id = '" + proposalIds[i] + "'";
				    stat.addBatch(query);
					int trackNo = getNextTrackNo(proposalIds[i]);
					if(trackNo > 1){
						query = " UPDATE rws_proposal_workflow_tbl SET flag='Y' "
							  + " WHERE proposal_id = '" + proposalIds[i] + "' "
							  + " AND track_no = " + (trackNo -1) ;						
						stat.addBatch(query);
					}					
					String newWorkId = getNextWorkId(proposalIds[i]);
					if(newWorkId != null && newWorkId.equals("false"))
						return false;
					query = " UPDATE rws_work_proposal_tbl "
						  + " SET flag = 'A', admin_no='" + adminNo+ "',"
						  + " admin_date = TO_DATE('" + adminDate + "', 'dd/mm/yyyy'), "
						  + " goms_no = '" + goNo + "', "
						  + " admin_sanc_auth='"+ sancAuthority + "', "
						  + " state_central = '" + sancAt + "', "
						  + " work_id = '" + newWorkId + "', "
						  + " sanction_amount = '" + sanctionAmounts[i] + "' "
						  + " WHERE proposal_id = '" + proposalIds[i] + "'";						  				
					stat.addBatch(query);
					
					query="insert into rws_work_proposal_tbl (work_id) values('"+newWorkId+"')";
						
					query = " INSERT INTO rws_work_proposal_mirror_tbl(office_code, no_of_habs, "
						  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
						  + " estimate_cost, prepared_by, prepared_on, state_central, "
						  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
						  + " goms_no, admin_sanc_auth, sanction_amount, modified_by, modified_on, "
						  + " track_no,phased, phase_no ) "
						  + " (SELECT office_code, no_of_habs, "
						  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
						  + " estimate_cost, prepared_by, prepared_on, state_central, "
						  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
						  + " goms_no, admin_sanc_auth, sanction_amount, "
						  + " '" + preparedBy + "', SYSDATE, 999, phased, phase_no "   
						  + " FROM rws_work_proposal_tbl "
						  + " WHERE proposal_id = '" + proposalIds[i] + "')";
					stat.addBatch(query);
					
					int[] updateCounts = stat.executeBatch();
					for(int j=0; j<updateCounts.length; j++){
						if(updateCounts[j] != 0)
							conn.commit();
					}
				}		
				conn.setAutoCommit(true);				
			}
			catch(Exception e){	
				Debug.writeln("The Exception is in ProposalDAO sanction : \n" + e.getMessage());		
			}
			finally	{
				try{
					if(stat != null){
						stat.close();					
					}				
					if(conn != null){	
						conn.close();
					}
				}
				catch(SQLException sqle){ 
					Debug.writeln("The Exception is in ProposalDAO sanction finally : \n" + sqle.getMessage());						
				}				
			}
		}
		return true;
	}
	
	
	public String getNextProposalId(String headOfficeCode, String circleOfficeCode) {
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		java.util.Date date = new java.util.Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy");
		String currentYear = dateFormatter.format(date);
		String headOfficeName = "RW";
		if(headOfficeCode != null && headOfficeCode.equals("1"))
			headOfficeName = "RW";
		else if(headOfficeCode != null && headOfficeCode.equals("2"))
			headOfficeName = "PR";		
		
		if(circleOfficeCode != null && circleOfficeCode.equals(""))
				circleOfficeCode = "00";				
		String proposalId = headOfficeName + currentYear + circleOfficeCode;
		try	{	
			query = " SELECT MAX(SUBSTR(proposal_id,3,10)) as proposal_id FROM rws_rep_proposal_tbl "
				  + " WHERE proposal_id LIKE ? "; 
			conn = getConn();			
			stat = conn.prepareStatement(query);
			stat.setString(1, proposalId+"%");
			rset = stat.executeQuery();
			if(rset.next()){
				int temp = rset.getInt(1);
				if(temp == 0)
					proposalId = proposalId + "0001";
				else{
					int sno = Integer.parseInt(String.valueOf(temp).substring(6,10));
					String tempSNo ="";
					if(sno < 9)
						tempSNo =  "000"+(++sno);
					else if(sno < 99)
						tempSNo =  "00"+(++sno);
					else if(sno < 999)
						tempSNo =  "0"+(++sno);
					else if(sno < 9999)
						tempSNo = String.valueOf(++sno);						
					proposalId = proposalId + tempSNo;
				}
			}
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getNextProposalId : \n" + e.getMessage());		
		}
		finally	{
			try{
				if(rset != null){
					rset.close();					
				}
				if(stat != null){
					stat.close();					
				}				
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){ 
				Debug.writeln("The Exception is in ProposalDAO getNextProposalId finally : \n" + sqle.getMessage());						
			}				
		}
		return proposalId;
	}	
	
	
	public int getNextTrackNo(String proposalId){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		int nextTrackNo = 1;
		try	{
			String query = " SELECT MAX(track_no)+1 from rws_proposal_workflow_tbl WHERE proposal_id = ? ";
			conn = getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, proposalId);
			rset = stat.executeQuery();
			if(rset.next())	{
				nextTrackNo = rset.getInt(1);
				if(nextTrackNo == 0)
					nextTrackNo = 1;
			}
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getNextTrackNo : \n" + e.getMessage());		
		}
		finally	{
			try{
				if(rset != null){
					rset.close();					
				}
				if(stat != null){
					stat.close();					
				}				
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){ 
				Debug.writeln("The Exception is in ProposalDAO getNextTrackNo finally : \n" + sqle.getMessage());						
			}				
		}
		return nextTrackNo;
	}
	
	
	public String getNextWorkId(String proposalId){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		java.util.Date date = new java.util.Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yy");
		String currentYear = dateFormatter.format(date);		
		String workId = null;
		String programmeCode = null;
		String subprogrammeCode = null;
		String districtCode = null;
		String typeOfAsset = null;				
		try	{	
			query = " SELECT programme_code, subprogramme_code, "
				  + " SUBSTR(OFFICE_CODE,2,2) AS districtCode, type_of_asset "
				  + " FROM rws_work_proposal_tbl WHERE proposal_id= ? ";
			conn = getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, proposalId);
			rset = stat.executeQuery();
			if(rset.next())	{
				programmeCode = rset.getString(1);
				subprogrammeCode = rset.getString(2);
				districtCode = rset.getString(3);
				typeOfAsset = rset.getString(4); 
			}
			if(subprogrammeCode == null)
				subprogrammeCode = "00";
			if(programmeCode == null || districtCode == null ||	typeOfAsset == null)
				return new String("false");
			workId = programmeCode + subprogrammeCode + districtCode + typeOfAsset + currentYear;
			query = "SELECT MAX(SUBSTR(work_id,11,4)) as work_id FROM rws_work_proposal_tbl WHERE work_id LIKE ? "; 
			stat = conn.prepareStatement(query);
			stat.setString(1, workId+"%");
			rset = stat.executeQuery();
			if(rset.next()){
				int sno = rset.getInt(1);
				if(sno == 0)
					workId = workId + "0001";
				else{
					if(sno >= 9999)
						throw new Exception("No more WORK ID left.");
					else{
						String tempSno = null;
						if(sno<9)
							tempSno = "000"+(sno+1);
						else if(sno<99)
							tempSno = "00"+(sno+1);
						else if(sno<999)
							tempSno = "0"+(sno+1);
						else
							tempSno = String.valueOf(sno+1);						
						workId =  workId + String.valueOf(tempSno);
					}
				}
			}
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getNextWorkId : \n" + e.getMessage());		
		}
		finally	{
			try{
				if(rset != null){
					rset.close();					
				}
				if(stat != null){
					stat.close();					
				}				
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){ 
				Debug.writeln("The Exception is in ProposalDAO getNextWorkId finally : \n" + sqle.getMessage());						
			}				
		}
		return workId;
	}

	
	protected ArrayList getRepresentativeProposals(String officeCode){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		try	{
			query = " SELECT RP.proposal_name, RP.proposal_id, " 
				  + " TO_CHAR(RP.rep_date,'dd/mm/yyyy') as proposal_date,"
				  + " RP.no_of_habs, NVL(P.programme_name,''), NVL(S.subprogramme_name,''),"
				  + " estimate_cost, NVL(RP.remarks, ''), NVL(AT.type_of_asset_name,'') "
				  + " FROM "
				  + " rws_rep_proposal_tbl RP, rws_programme_tbl P, "
				  + " rws_subprogramme_tbl S, rws_asset_type_tbl AT "
				  + " WHERE "
				  + " RP.programme_code = P.programme_code (+) AND "
				  + " (RP.subprogramme_code = S.subprogramme_code(+) AND "
				  + " RP.programme_code = S.programme_code(+) ) AND "
				  + " RP.type_of_asset = AT.type_of_asset_code(+) AND "
				  + " RP.flag = 'N' AND RP.office_code = ? " 
				  + " ORDER BY rep_date ";			
			conn = getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, officeCode);
			rset = stat.executeQuery();
			representativeProposals = new ArrayList();			
			while(rset.next()){
				proposalDTO = new ProposalDTO();
				proposalDTO.setProposalName(rset.getString(1));
				proposalDTO.setProposalId(rset.getString(2));
				proposalDTO.setProposalDate(rset.getString(3));
				proposalDTO.setNoOfHabs(rset.getString(4));
				proposalDTO.setProgrammeName(rset.getString(5));
				proposalDTO.setSubprogrammeName(rset.getString(6));
				proposalDTO.setEstimateCost(rset.getString(7));
				proposalDTO.setRemarks(rset.getString(8));
				proposalDTO.setAssetName(rset.getString(9));
				representativeProposals.add(proposalDTO);
			}
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getRepresentativeProposals : \n" + e.getMessage());		
		}
		finally	{
			try{
				if(rset != null){
					rset.close();					
				}
				if(stat != null){
					stat.close();					
				}				
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){ 
				Debug.writeln("The Exception is in ProposalDAO getRepresentativeProposals finally : \n" + sqle.getMessage());						
			}				
		}
		return representativeProposals;
	}

	public ArrayList getConsideredProposals(String officeCode) {	
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		try	{
			query = " SELECT WP.proposal_id, WP.proposal_name, " 
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'),"
				  + " WP.no_of_habs, NVL(P.programme_name,''), NVL(S.subprogramme_name,''), "
				  + " NVL(AT.type_of_asset_name, ''), WP.estimate_cost, NVL(WP.remarks, '') "
				  + " FROM "
				  + " rws_work_proposal_tbl WP, rws_programme_tbl P,"
				  + " rws_subprogramme_tbl S, rws_asset_type_tbl AT "
				  + " WHERE "
				  + " WP.programme_code = P.programme_code (+) AND "
				  + " (WP.subprogramme_code = S.subprogramme_code(+) AND "
				  + " WP.programme_code = S.programme_code(+) ) AND "
				  + " WP.type_of_asset = AT.type_of_asset_code(+) AND "
				  + " WP.flag = 'C' AND WP.office_code ='" + officeCode + "' AND "
				  + " WP.proposal_id NOT IN (SELECT proposal_id FROM rws_proposal_workflow_tbl) " 
				 // +	" AND WP.sanc_office='HO'"
				  + " ORDER BY WP.prepared_on ";
			
			Debug.println("query in getConsideredProposals() is:"+query);
			
			conn = getConn();			
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			consideredProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				proposalDTO.setProposalId(rset.getString(1));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalDate(rset.getString(3));
				proposalDTO.setNoOfHabs(rset.getString(4));
				proposalDTO.setProgrammeName(rset.getString(5));
				proposalDTO.setSubprogrammeName(rset.getString(6));
				proposalDTO.setAssetName(rset.getString(7));
				proposalDTO.setEstimateCost(rset.getString(8));
				proposalDTO.setRemarks(rset.getString(9));
				consideredProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getConsideredProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){ 	}
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
		Debug.println("consideredProposals.size() in ProposalDAO: " + consideredProposals.size());
		return consideredProposals;
	}
	
	
	//CODE ADDED BY SANTOSH
	
	
	
	public ArrayList getConsideredProposalsForSanction(String officeCode) 
	{	
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		try
		{
			/* query = " SELECT WP.proposal_id, WP.proposal_name, " 
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'),"
				  + " WP.no_of_habs, NVL(P.programme_name,''), NVL(S.subprogramme_name,''), "
				  + " NVL(AT.type_of_asset_name, ''), WP.estimate_cost, NVL(WP.remarks, '') "
				  + " FROM "
				  + " rws_work_proposal_tbl WP, rws_programme_tbl P,"
				  + " rws_subprogramme_tbl S, rws_asset_type_tbl AT "
				  + " WHERE "
				  + " WP.programme_code = P.programme_code (+) AND "
				  + " (WP.subprogramme_code = S.subprogramme_code(+) AND "
				  + " WP.programme_code = S.programme_code(+) ) AND "
				  + " WP.type_of_asset = AT.type_of_asset_code(+) AND "
				  + " WP.flag = 'C' AND WP.office_code ='" + officeCode + "' AND "
				  + " WP.proposal_id NOT IN (SELECT proposal_id FROM rws_proposal_workflow_tbl) "
				  + " ORDER BY WP.prepared_on ";
				  
		  */
			
			query = " SELECT WP.proposal_id, WP.proposal_name, " 
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'),"
				  + " WP.no_of_habs, NVL(P.programme_name,''), NVL(S.subprogramme_name,''), "
				  + " NVL(AT.type_of_asset_name, ''), WP.estimate_cost, NVL(WP.remarks, '') "
				  + " FROM "
				  + " rws_work_proposal_tbl WP, rws_programme_tbl P,"
				  + " rws_subprogramme_tbl S, rws_asset_type_tbl AT "
				  + " WHERE "
				  + " WP.programme_code = P.programme_code (+) AND "
				  + " (WP.subprogramme_code = S.subprogramme_code(+) AND "
				  + " WP.programme_code = S.programme_code(+) ) AND "
				  + " WP.type_of_asset = AT.type_of_asset_code(+) AND "
				  + " WP.flag = 'C' AND WP.office_code ='" + officeCode + "' AND "
				  + " WP.proposal_id NOT IN (SELECT proposal_id FROM rws_proposal_workflow_tbl) AND" 
				  +	" WP.sanc_office='CO' "
				  + " ORDER BY WP.prepared_on ";
			
			conn = getConn();			
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			consideredProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				proposalDTO.setProposalId(rset.getString(1));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalDate(rset.getString(3));
				proposalDTO.setNoOfHabs(rset.getString(4));
				proposalDTO.setProgrammeName(rset.getString(5));
				proposalDTO.setSubprogrammeName(rset.getString(6));
				proposalDTO.setAssetName(rset.getString(7));
				proposalDTO.setEstimateCost(rset.getString(8));
				proposalDTO.setRemarks(rset.getString(9));
				consideredProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getConsideredProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){ 	}
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
		return consideredProposals;
	}
	
	
	
	//CODE ADDED BY SANTOSH
	/*
	*
	*
	*/
	public ArrayList getSubmittedProposals(String officeCode, String proposalType)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		
		try
		{
			/*query = " SELECT PWT.action_from, WP.proposal_name, WP.proposal_id, "
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), WP.no_of_habs, "
				  + " NVL(P.programme_name,''), "
				  + " NVL(SP.subprogramme_name,''), "
				  + " NVL(WP.estimate_cost,0), "
				  + " NVL(WP.sanction_amount,0), "
				  + " NVL(WP.remarks,''), NVL(PWT.memo_no,''),"
				  + " NVL(PWT.subject,''), NVL(PWT.ref,''),"
				  + " NVL(PWT.content,''), "
				  + " TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'),"
				  + " NVL(AT.type_of_asset_name, ''), "
				  + " NVL(WP.programme_code,'00'), NVL(WP.subprogramme_code,'00'), "
				  + " NVL(WP.type_of_asset,'00') "
				  + " FROM rws_work_proposal_tbl WP,rws_programme_tbl P, "
				  + " rws_subprogramme_tbl SP, rws_proposal_workflow_tbl PWT, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE  "
				  + " (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND WP.flag = '" + proposalType + "' AND "
				  + " (PWT.action_type='S' AND PWT.flag='N' AND PWT.action_to='" + officeCode + "') ";
				  */
			
			
			query = " SELECT PWT.action_from, WP.proposal_name, WP.proposal_id, "
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), WP.no_of_habs, "
				  + " NVL(P.programme_name,''), "
				  + " NVL(SP.subprogramme_name,''), "
				  + " NVL(WP.estimate_cost,0), "
				  + " NVL(WP.sanction_amount,0), "
				  + " NVL(WP.remarks,''), NVL(PWT.memo_no,''),"
				  + " NVL(PWT.subject,''), NVL(PWT.ref,''),"
				  + " NVL(PWT.content,''), "
				  + " TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'),"
				  + " NVL(AT.type_of_asset_name, ''), "
				  + " NVL(WP.programme_code,'00'), NVL(WP.subprogramme_code,'00'), "
				  + " NVL(WP.type_of_asset,'00') "
				  + " FROM rws_work_proposal_tbl WP,rws_programme_tbl P, "
				  + " rws_subprogramme_tbl SP, rws_proposal_workflow_tbl PWT, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE  "
				  + " (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND WP.flag = '" + proposalType +"'"
				  + " AND WP.SANC_OFFICE='HO'"
				  + " AND " + " (PWT.action_type='S' AND PWT.flag='N' AND PWT.action_to='" + officeCode + "') ";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			submittedProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			rwsOffices = new RwsOffices(dataSource);
			String content = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
						
				String actionFrom = rset.getString(1);
				proposalDTO.setOfficeCode(actionFrom);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(actionFrom, true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalId(rset.getString(3));
				proposalDTO.setProposalDate(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				proposalDTO.setProgrammeName(rset.getString(6));
				proposalDTO.setSubprogrammeName(rset.getString(7));
				String estimateCost = rset.getString(8);
				String sanctionedAmount = rset.getString(9);
				proposalDTO.setEstimateCost(estimateCost);
				if(sanctionedAmount.equals("0"))
					proposalDTO.setSanctionedAmount(estimateCost);
				else
					proposalDTO.setSanctionedAmount(sanctionedAmount);
				proposalDTO.setRemarks(rset.getString(10));
				proposalDTO.setMemoNo(rset.getString(11));
				proposalDTO.setSubmitSubject(rset.getString(12));
				proposalDTO.setSubmitRef(rset.getString(13));
				content = rset.getString(14);
				content = content.replaceAll("\\n", "");
				content = content.replaceAll("\\r", "<br>");
							 
				proposalDTO.setSubmitContent(content);
				
				proposalDTO.setSubmitDate(rset.getString(15));
				proposalDTO.setAssetName(rset.getString(16));
				proposalDTO.setProgrammeCode(rset.getString(17));
				proposalDTO.setSubprogrammeCode(rset.getString(18));
				proposalDTO.setAssetCode(rset.getString(19));

				submittedProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getSubmittedProposals : \n" + e);			
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
		
		return submittedProposals;
	}
	
	
	//code added by santosh
	public ArrayList getSubmittedProposalsForCircleOfficeSanction(String officeCode, String proposalType)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		
		try
		{
			query = " SELECT PWT.action_from, WP.proposal_name, WP.proposal_id, "
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), WP.no_of_habs, "
				  + " NVL(P.programme_name,''), "
				  + " NVL(SP.subprogramme_name,''), "
				  + " NVL(WP.estimate_cost,0), "
				  + " NVL(WP.sanction_amount,0), "
				  + " NVL(WP.remarks,''), NVL(PWT.memo_no,''),"
				  + " NVL(PWT.subject,''), NVL(PWT.ref,''),"
				  + " NVL(PWT.content,''), "
				  + " TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'),"
				  + " NVL(AT.type_of_asset_name, ''), "
				  + " NVL(WP.programme_code,'00'), NVL(WP.subprogramme_code,'00'), "
				  + " NVL(WP.type_of_asset,'00') "
				  + " FROM rws_work_proposal_tbl WP,rws_programme_tbl P, "
				  + " rws_subprogramme_tbl SP, rws_proposal_workflow_tbl PWT, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE  "
				  + " (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND WP.flag = '" + proposalType+"'" 
				  + " AND WP.SANC_OFFICE='CO'"
				  + " AND " + " (PWT.action_type='S' AND PWT.flag='N' AND PWT.action_to='" + officeCode + "') ";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			submittedProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			rwsOffices = new RwsOffices(dataSource);
			String content = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
						
				String actionFrom = rset.getString(1);
				proposalDTO.setOfficeCode(actionFrom);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(actionFrom, true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalId(rset.getString(3));
				proposalDTO.setProposalDate(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				proposalDTO.setProgrammeName(rset.getString(6));
				proposalDTO.setSubprogrammeName(rset.getString(7));
				String estimateCost = rset.getString(8);
				String sanctionedAmount = rset.getString(9);
				proposalDTO.setEstimateCost(estimateCost);
				if(sanctionedAmount.equals("0"))
					proposalDTO.setSanctionedAmount(estimateCost);
				else
					proposalDTO.setSanctionedAmount(sanctionedAmount);
				proposalDTO.setRemarks(rset.getString(10));
				proposalDTO.setMemoNo(rset.getString(11));
				proposalDTO.setSubmitSubject(rset.getString(12));
				proposalDTO.setSubmitRef(rset.getString(13));
				content = rset.getString(14);
				content = content.replaceAll("\\n", "");
				content = content.replaceAll("\\r", "<br>");
							 
				proposalDTO.setSubmitContent(content);
				
				proposalDTO.setSubmitDate(rset.getString(15));
				proposalDTO.setAssetName(rset.getString(16));
				proposalDTO.setProgrammeCode(rset.getString(17));
				proposalDTO.setSubprogrammeCode(rset.getString(18));
				proposalDTO.setAssetCode(rset.getString(19));

				submittedProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getSubmittedProposals : \n" + e);			
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
		
		Debug.println("submittedProposals.size() in ProposalDAO: " +submittedProposals.size());
		return submittedProposals;
	}
//end of code added by santosh
	/**
	*
	*
	*/
	public ArrayList getForwardedProposals(String actionTo, String proposalType)
	{	
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		rwsOffices = new RwsOffices(dataSource);
		try
		{
			Debug.println("in getForwardedProposals");
			query = " SELECT PWT.action_from, UPPER(WP.proposal_name), "
				  + " WP.proposal_id, WP.work_id, WP.admin_no, "
				  + " TO_CHAR(WP.admin_date, 'dd/mm/yyyy'), "
				  + " WP.goms_no, TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), "
				  + " WP.no_of_habs, "
				  + " NVL(AT.type_of_asset_name, ''), NVL(P.programme_name,''), "
				  + " NVL(SP.subprogramme_name,''), "
				  + " WP.estimate_cost, WP.sanction_amount, PWT.action_type, "
				  + " PWT.memo_no,PWT.subject,TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'), "
				  + " NVL(PWT.ref,''), PWT.content "
				  + " FROM rws_work_proposal_tbl WP,rws_programme_tbl P, "
				  + " rws_subprogramme_tbl SP,rws_proposal_workflow_tbl PWT, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE  "
				  + " (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND WP.flag = '" + proposalType + "' AND "
				  + " (PWT.action_type='F' AND PWT.flag='N' AND PWT.action_to='" + actionTo + "') order by PWT.action_from";
			Debug.println("query is "+query);
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			forwardedProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			String content = null;
			while(rset.next())
			{
				
				proposalDTO = new ProposalDTO();
				String officeCode = rset.getString(1);
				proposalDTO.setOfficeCode(officeCode);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(officeCode,true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalId(rset.getString(3));
				proposalDTO.setWorkId(rset.getString(4));
				proposalDTO.setAdminNo(rset.getString(5));
				proposalDTO.setAdminDate(rset.getString(6));
				proposalDTO.setGoNo(rset.getString(7));
				proposalDTO.setProposalDate(rset.getString(8));
				proposalDTO.setNoOfHabs(rset.getString(9));
				proposalDTO.setAssetName(rset.getString(10));
				proposalDTO.setProgrammeName(rset.getString(11));
				proposalDTO.setSubprogrammeName(rset.getString(12));
				proposalDTO.setEstimateCost(rset.getString(13));
				proposalDTO.setSanctionedAmount(rset.getString(14));
				proposalDTO.setFlag(rset.getString(15));
				proposalDTO.setMemoNo(rset.getString(16));
				proposalDTO.setForwardSubject(rset.getString(17));
				proposalDTO.setForwardDate(rset.getString(18));
				proposalDTO.setForwardRef(rset.getString(19));
				content = rset.getString(20);
				content = content.replaceAll("\\n","");
				content = content.replaceAll("\\r","<br>");
				proposalDTO.setForwardContent(content);
												
				forwardedProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getForwardedProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
				
		Debug.println("forwardedProposals.size() in ProposalDAO: " + forwardedProposals.size());
		return forwardedProposals;
	}
	
	/*
	*
	*
	*/
	public ArrayList getSubmittedProposals(String actionFrom, String actionTo, String proposalType)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		
		try
		{
			query = " SELECT PWT.action_from, WP.proposal_name, WP.proposal_id, "
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), WP.no_of_habs, "
				  + " NVL(P.programme_name,''), "
				  + " NVL(SP.subprogramme_name,''), "
				  + " NVL(WP.estimate_cost,0), "
				  + " NVL(WP.sanction_amount,0), "
				  + " NVL(WP.remarks,''), NVL(PWT.memo_no,''),"
				  + " NVL(PWT.subject,''), NVL(PWT.ref,''),"
				  + " NVL(PWT.content,''), "
				  + " TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'),"
				  + " NVL(AT.type_of_asset_name, ''), "
				  + " NVL(WP.programme_code,'00'), NVL(WP.subprogramme_code,'00'), "
				  + " NVL(WP.type_of_asset,'00') "
				  + " FROM rws_work_proposal_tbl WP,rws_programme_tbl P, "
				  + " rws_subprogramme_tbl SP, rws_proposal_workflow_tbl PWT, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE  "
				  + " (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND WP.flag = '" + proposalType + "' AND "
				  + " PWT.action_type='S' AND PWT.flag='N' "
				  +	" AND PWT.action_to='" + actionTo + "' ";
				  if(!actionFrom.equals(""))
				  query += " AND PWT.action_from LIKE '" + actionFrom + "%'";
				  
			Debug.println("New Submitted Query is " + query);
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			submittedProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			rwsOffices = new RwsOffices(dataSource);
			String content = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
						
				String officeCode = rset.getString(1);
				proposalDTO.setOfficeCode(officeCode);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(officeCode, true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalId(rset.getString(3));
				proposalDTO.setProposalDate(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				proposalDTO.setProgrammeName(rset.getString(6));
				proposalDTO.setSubprogrammeName(rset.getString(7));
				String estimateCost = rset.getString(8);
				String sanctionedAmount = rset.getString(9);
				proposalDTO.setEstimateCost(estimateCost);
				if(sanctionedAmount.equals("0"))
					proposalDTO.setSanctionedAmount(estimateCost);
				else
					proposalDTO.setSanctionedAmount(sanctionedAmount);
				proposalDTO.setRemarks(rset.getString(10));
				proposalDTO.setMemoNo(rset.getString(11));
				proposalDTO.setSubmitSubject(rset.getString(12));
				proposalDTO.setSubmitRef(rset.getString(13));
				content = rset.getString(14);
				content = content.replaceAll("\\n", "");
				content = content.replaceAll("\\r", "<br>");
				
				proposalDTO.setSubmitContent(content);
				proposalDTO.setSubmitDate(rset.getString(15));
				proposalDTO.setAssetName(rset.getString(16));
				proposalDTO.setProgrammeCode(rset.getString(17));
				proposalDTO.setSubprogrammeCode(rset.getString(18));
				proposalDTO.setAssetCode(rset.getString(19));

				submittedProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getSubmittedProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		
		Debug.println("submittedProposals.size() in ProposalDAO: " +submittedProposals.size());
		return submittedProposals;
	}
	
	/*
	* Returns a list of New Proposals which are considered for administrative sanction
	* @param actionFrom - The Office from which the proposal is submitted
	* @param actionTo - The Office to which the proposal is submitted
	*/
	/* public ArrayList getPendingProposals(String actionFrom, String actionTo)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		ArrayList pendingProposals = new ArrayList();
		Debug.println("action form="+actionFrom+"actionTo="+actionTo);
		try
		{
			query = " SELECT PWT.action_from, WP.proposal_name, WP.proposal_id, "
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), WP.no_of_habs, "
				  + " NVL(WP.type_of_asset,'00'), NVL(AT.type_of_asset_name, ''), "
				  + " NVL(WP.programme_code,'00'), NVL(P.programme_name,''), " 
				  +	" NVL(WP.subprogramme_code,'00'), NVL(SP.subprogramme_name,''),"
				  + " WP.estimate_cost, NVL(WP.sanction_amount,0), "
				  + " PWT.action_type, PWT.memo_no, "
				  + " TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'), "
				  + " PWT.subject, NVL(PWT.ref,''), PWT.content"
				  + " FROM rws_work_proposal_tbl WP, rws_proposal_workflow_tbl PWT, "
				  + " rws_programme_tbl P, rws_subprogramme_tbl SP, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND WP.flag = 'P' AND "
				  + " PWT.action_type='P' AND PWT.flag='N' AND " 
				  +	" PWT.action_to='" + actionTo + "' ";
				 
			if(!actionFrom.equals(""))
			   query += " AND PWT.action_from LIKE '" + actionFrom + "%'";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			submittedProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			rwsOffices = new RwsOffices(dataSource);
			String content = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				Debug.println("test values");
				String officeCode = rset.getString(1);
				Debug.println(rset.getString(1));
				proposalDTO.setOfficeCode(officeCode);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(officeCode, true));
				proposalDTO.setProposalName(rset.getString(2));
				Debug.println(rset.getString(2));
				proposalDTO.setProposalId(rset.getString(3));
				Debug.println(rset.getString(3));
				proposalDTO.setProposalDate(rset.getString(4));
				Debug.println(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				Debug.println(rset.getString(5));
				proposalDTO.setAssetCode(rset.getString(6));
				Debug.println(rset.getString(6));
				proposalDTO.setAssetName(rset.getString(7));
				Debug.println(rset.getString(7));
				proposalDTO.setProgrammeCode(rset.getString(8));
				Debug.println(rset.getString(8));
				proposalDTO.setProgrammeName(rset.getString(9));
				Debug.println(rset.getString(9));
				proposalDTO.setSubprogrammeCode(rset.getString(10));
				Debug.println(rset.getString(10));
				proposalDTO.setSubprogrammeName(rset.getString(11));
				Debug.println(rset.getString(11));
				double estimateCost = rset.getDouble(12);
				Debug.println(rset.getDouble(12));
				double sanctionedAmount = rset.getDouble(13);
				Debug.println(rset.getDouble(13));
				proposalDTO.setEstimateCost(String.valueOf(estimateCost));
							
				if(sanctionedAmount == 0)
					sanctionedAmount = estimateCost;
					
				DecimalFormat df = new DecimalFormat("##0.00");
				Debug.println("sanction Amount="+sanctionedAmount);
				
				String tempSanctionAmount = df.format(sanctionedAmount);
				proposalDTO.setSanctionedAmount(tempSanctionAmount);
				Debug.println("tempSanctionAmount="+tempSanctionAmount);										
				proposalDTO.setFlag(rset.getString(14));
				Debug.println(rset.getString(14));
				proposalDTO.setMemoNo(rset.getString(15));
				Debug.println(rset.getString(15));
				proposalDTO.setSubmitSubject(rset.getString(16));
				Debug.println(rset.getString(16));
				proposalDTO.setSubmitRef(rset.getString(17));
				Debug.println(rset.getString(17));
				content = rset.getString(18);
				Debug.println(rset.getString(18));
				content = content.replaceAll("\\n", "");
				content = content.replaceAll("\\r", "<br>");
				proposalDTO.setSubmitContent(content);
				proposalDTO.setSubmitDate(rset.getString(19));
				Debug.println(rset.getString(19));
				pendingProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getPendingProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
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
		
		Debug.println("pendingProposals.size() in ProposalDAO: " + 
							pendingProposals.size());
		return pendingProposals;
	}*/
	
	public ArrayList getPendingProposals(String actionFrom, String actionTo)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		ArrayList pendingProposals = new ArrayList();
		try
		{
			query = " SELECT PWT.action_from, WP.proposal_name, WP.proposal_id, "
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), WP.no_of_habs, "
				  + " NVL(WP.type_of_asset,'00'), NVL(AT.type_of_asset_name, ''), "
				  + " NVL(WP.programme_code,'00'), NVL(P.programme_name,''), " 
				  +	" NVL(WP.subprogramme_code,'00'), NVL(SP.subprogramme_name,''),"
				  + " WP.estimate_cost, NVL(WP.sanction_amount,0), "
				  + " PWT.action_type, PWT.memo_no, "
				  + " TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'), "
				  + " PWT.subject, NVL(PWT.ref,''), PWT.content"
				  + " FROM rws_work_proposal_tbl WP, rws_proposal_workflow_tbl PWT, "
				  + " rws_programme_tbl P, rws_subprogramme_tbl SP, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND WP.flag = 'P' AND "
				  + " PWT.action_type='P' AND PWT.flag='N' AND " 
				  +	" PWT.action_to='" + actionTo + "' ";
				 
			if(!actionFrom.equals(""))
			   query += " AND PWT.action_from LIKE '" + actionFrom + "%'";
			
			Debug.println("query in getPendingProposals() is:"+query);
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			submittedProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			rwsOffices = new RwsOffices(dataSource);
			String content = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
						
				String officeCode = rset.getString(1);
				proposalDTO.setOfficeCode(officeCode);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(officeCode, true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalId(rset.getString(3));
				proposalDTO.setProposalDate(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				proposalDTO.setAssetCode(rset.getString(6));
				proposalDTO.setAssetName(rset.getString(7));
				proposalDTO.setProgrammeCode(rset.getString(8));
				proposalDTO.setProgrammeName(rset.getString(9));
				proposalDTO.setSubprogrammeCode(rset.getString(10));
				proposalDTO.setSubprogrammeName(rset.getString(11));
				
				double estimateCost = rset.getDouble(12);
				double sanctionedAmount = rset.getDouble(13);
				proposalDTO.setEstimateCost(String.valueOf(estimateCost));
							
				if(sanctionedAmount == 0)
					sanctionedAmount = estimateCost;
					
				DecimalFormat df = new DecimalFormat("##0.00");
				String tempSanctionAmount = df.format(sanctionedAmount);
				proposalDTO.setSanctionedAmount(tempSanctionAmount);
										
				proposalDTO.setFlag(rset.getString(14));
				proposalDTO.setMemoNo(rset.getString(15));
				proposalDTO.setSubmitDate(rset.getString(16));
				proposalDTO.setSubmitSubject(rset.getString(17));
				proposalDTO.setSubmitRef(rset.getString(18));
				content = rset.getString(19);
				content = content.replaceAll("\\n", "");
				content = content.replaceAll("\\r", "<br>");
				proposalDTO.setSubmitContent(content);
				pendingProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getPendingProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
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
		
		Debug.println("pendingProposals.size() in ProposalDAO: " +pendingProposals.size());
		return pendingProposals;
	}


	/*
	*
	*
	*/
	
	//code added by santosh
	public ArrayList getPendingProposalsForCircle(String actionFrom, String actionTo)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		ArrayList pendingProposals = new ArrayList();
		try
		{
			query = " SELECT PWT.action_from, WP.proposal_name, WP.proposal_id, "
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), WP.no_of_habs, "
				  + " NVL(WP.type_of_asset,'00'), NVL(AT.type_of_asset_name, ''), "
				  + " NVL(WP.programme_code,'00'), NVL(P.programme_name,''), " 
				  +	" NVL(WP.subprogramme_code,'00'), NVL(SP.subprogramme_name,''),"
				  + " WP.estimate_cost, NVL(WP.sanction_amount,0), "
				  + " PWT.action_type, PWT.memo_no, "
				  + " TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'), "
				  + " PWT.subject, NVL(PWT.ref,''), PWT.content"
				  + " FROM rws_work_proposal_tbl WP, rws_proposal_workflow_tbl PWT, "
				  + " rws_programme_tbl P, rws_subprogramme_tbl SP, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND WP.flag = 'P' AND "
				  + " PWT.action_type='P' AND PWT.flag='N' AND " 
				  + " WP.sanc_office='CO' AND"
				  +	" PWT.action_to='" + actionTo + "' ";
				 
			if(!actionFrom.equals(""))
			   query += " AND PWT.action_from LIKE '" + actionFrom + "%'";
			
			Debug.println("query in getPendingProposals() is:"+query);
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			submittedProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			rwsOffices = new RwsOffices(dataSource);
			String content = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
						
				String officeCode = rset.getString(1);
				proposalDTO.setOfficeCode(officeCode);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(officeCode, true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalId(rset.getString(3));
				proposalDTO.setProposalDate(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				proposalDTO.setAssetCode(rset.getString(6));
				proposalDTO.setAssetName(rset.getString(7));
				proposalDTO.setProgrammeCode(rset.getString(8));
				proposalDTO.setProgrammeName(rset.getString(9));
				proposalDTO.setSubprogrammeCode(rset.getString(10));
				proposalDTO.setSubprogrammeName(rset.getString(11));
				
				double estimateCost = rset.getDouble(12);
				double sanctionedAmount = rset.getDouble(13);
				proposalDTO.setEstimateCost(String.valueOf(estimateCost));
							
				if(sanctionedAmount == 0)
					sanctionedAmount = estimateCost;
					
				DecimalFormat df = new DecimalFormat("##0.00");
				String tempSanctionAmount = df.format(sanctionedAmount);
				proposalDTO.setSanctionedAmount(tempSanctionAmount);
										
				proposalDTO.setFlag(rset.getString(14));
				proposalDTO.setMemoNo(rset.getString(15));
				proposalDTO.setSubmitDate(rset.getString(16));
				proposalDTO.setSubmitSubject(rset.getString(17));
				proposalDTO.setSubmitRef(rset.getString(18));
				content = rset.getString(19);
				content = content.replaceAll("\\n", "");
				content = content.replaceAll("\\r", "<br>");
				proposalDTO.setSubmitContent(content);
				pendingProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getPendingProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
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
		
		Debug.println("pendingProposals.size() in ProposalDAO: " + pendingProposals.size());
		return pendingProposals;
	}

	
	protected ArrayList getSanctionedProposalsForCircle(String officeCode)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		try
		{
			query = " SELECT UPPER(WP.proposal_name), WP.proposal_id, WP.work_id, " 
				  + " TO_CHAR(WP.admin_date,'dd/mm/yyyy') as proposal_date,"
				  + " WP.no_of_habs, "
				  + " NVL(P.programme_name,''), "
				  + " NVL(S.subprogramme_name,''), "
				  + " WP.estimate_cost, WP.sanction_amount,  "
				  + " WP.admin_no, WP.goms_no, "
				  + " UPPER(NVL(WP.remarks, '')), "
				  + " UPPER(NVL(AT.type_of_asset_name, '')) "
				  + " FROM "
				  + " rws_work_proposal_tbl WP, rws_programme_tbl P,"
				  + " rws_subprogramme_tbl S, rws_asset_type_tbl AT "
				  + " WHERE "
				  + " WP.programme_code = P.programme_code (+) AND "
				  + " (WP.subprogramme_code = S.subprogramme_code(+) AND "
				  + " WP.programme_code = S.programme_code(+) ) AND "
				  + " WP.type_of_asset = AT.type_of_asset_code(+) AND " 
				  + " WP.flag = 'A' AND WP.proposal_id NOT IN "
				  + " (SELECT proposal_id FROM rws_proposal_workflow_tbl WHERE flag='N') "
				  + " AND WP.sanc_office='CO' "
				  + " ORDER BY proposal_date ";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			sanctionedProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				proposalDTO.setProposalName(rset.getString(1));
				proposalDTO.setProposalId(rset.getString(2));
				proposalDTO.setWorkId(rset.getString(3));
				proposalDTO.setAdminDate(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				proposalDTO.setProgrammeName(rset.getString(6));
				proposalDTO.setSubprogrammeName(rset.getString(7));
				proposalDTO.setEstimateCost(rset.getString(8));
				proposalDTO.setSanctionedAmount(rset.getString(9));
				proposalDTO.setAdminNo(rset.getString(10));
				proposalDTO.setGoNo(rset.getString(11));
				proposalDTO.setRemarks(rset.getString(12));
				proposalDTO.setAssetName(rset.getString(13));
				sanctionedProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getSanctionedProposals : \n" + e);			
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
		Debug.println("sanctionedProposals.size() in ProposalDAO(): " + sanctionedProposals.size());
		return sanctionedProposals;
	}

	
	
	//end of code added by santosh
	protected ArrayList getSanctionedProposals(String officeCode)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		try
		{
			query = " SELECT UPPER(WP.proposal_name), WP.proposal_id, WP.work_id, " 
				  + " TO_CHAR(WP.admin_date,'dd/mm/yyyy') as proposal_date,"
				  + " WP.no_of_habs, "
				  + " NVL(P.programme_name,''), "
				  + " NVL(S.subprogramme_name,''), "
				  + " WP.estimate_cost, WP.sanction_amount,  "
				  + " WP.admin_no, WP.goms_no, "
				  + " UPPER(NVL(WP.remarks, '')), "
				  + " UPPER(NVL(AT.type_of_asset_name, '')) "
				  + " FROM "
				  + " rws_work_proposal_tbl WP, rws_programme_tbl P,"
				  + " rws_subprogramme_tbl S, rws_asset_type_tbl AT "
				  + " WHERE "
				  + " WP.programme_code = P.programme_code (+) AND "
				  + " (WP.subprogramme_code = S.subprogramme_code(+) AND "
				  + " WP.programme_code = S.programme_code(+) ) AND "
				  + " WP.type_of_asset = AT.type_of_asset_code(+) AND " 
				  + " WP.flag = 'A' AND WP.proposal_id NOT IN "
				  + " (SELECT proposal_id FROM rws_proposal_workflow_tbl WHERE flag='N') " 
				  + " ORDER BY proposal_date ";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			sanctionedProposals = new ArrayList();
			ProposalDTO proposalDTO = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				proposalDTO.setProposalName(rset.getString(1));
				proposalDTO.setProposalId(rset.getString(2));
				proposalDTO.setWorkId(rset.getString(3));
				proposalDTO.setAdminDate(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				proposalDTO.setProgrammeName(rset.getString(6));
				proposalDTO.setSubprogrammeName(rset.getString(7));
				proposalDTO.setEstimateCost(rset.getString(8));
				proposalDTO.setSanctionedAmount(rset.getString(9));
				proposalDTO.setAdminNo(rset.getString(10));
				proposalDTO.setGoNo(rset.getString(11));
				proposalDTO.setRemarks(rset.getString(12));
				proposalDTO.setAssetName(rset.getString(13));
				sanctionedProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getSanctionedProposals : \n" + e);			
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
		Debug.println("sanctionedProposals.size() in ProposalDAO(): " + sanctionedProposals.size());
		return sanctionedProposals;
	}

	public ArrayList listNewProposals(String officeCode)  
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		ArrayList proposalList = new ArrayList(4);
		ArrayList representativeProposals = null;
		ArrayList consideredProposals = null;
		ArrayList sentProposals = null;
		ArrayList receivedProposals = null;
		ProposalDTO proposalDTO = null;
		String actionTo = null;
		String content = null;
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			rwsOffices = new RwsOffices(dataSource);
			
			query = " SELECT RP.proposal_id, RP.proposal_name, RP.no_of_habs, "
				  + " TO_CHAR(RP.rep_date, 'dd/mm/yyyy'), "
				  + " NVL(AT.type_of_asset_name,''), NVL(P.programme_name,''),"
				  + " NVL(SP.subprogramme_name, ''), estimate_cost, "
				  + " DECODE(RP.flag,'N','Not Considered','C','Considered','A','Sanctioned')"
				  + " FROM rws_rep_proposal_tbl RP, rws_asset_type_tbl AT, "
				  + " rws_programme_tbl P, rws_subprogramme_tbl SP "
				  + " WHERE RP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND RP.programme_code = P.programme_code(+) "
				  + " AND (RP.programme_code = SP.programme_code(+) "
				  + "      AND RP.subprogramme_code = SP.subprogramme_code(+)) "
				  + " AND RP.office_code = '" + officeCode +"' "
				  + " ORDER BY RP.rep_date ";
			
			rset = stat.executeQuery(query);
			representativeProposals = new ArrayList();
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				proposalDTO.setProposalId(rset.getString(1));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setNoOfHabs(rset.getString(3));
				proposalDTO.setProposalDate(rset.getString(4));
				proposalDTO.setAssetName(rset.getString(5));
				proposalDTO.setProgrammeName(rset.getString(6));
				proposalDTO.setSubprogrammeName(rset.getString(7));
				proposalDTO.setEstimateCost(rset.getString(8));
				proposalDTO.setFlag(rset.getString(9));
				representativeProposals.add(proposalDTO);
			}
			Debug.println("Representative Proposals " + query);
			proposalList.add(representativeProposals);
			
			query = " SELECT PWT.action_to, UPPER(WP.proposal_name), WP.proposal_id, "
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), WP.no_of_habs, "
				  + " NVL(P.programme_name,''), NVL(SP.subprogramme_name,''), "
				  + " NVL(AT.type_of_asset_name, ''), "
				  + " WP.estimate_cost, WP.sanction_amount, "
				  + " NVL(WP.remarks,''), PWT.memo_no, "
				  + " TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'), "
				  + " PWT.subject, NVL(PWT.ref,''), PWT.content, "
				  + " DECODE(WP.flag, 'C', 'UNDER PROCESS', 'D','DEFERRED','T','TRANSMITTED TO OTHER DEPARTMENT','A','SANCTIONED'), "
				  + " PWT.action_type "
				  + " FROM rws_work_proposal_tbl WP, rws_programme_tbl P, "
				  + " rws_subprogramme_tbl SP, rws_proposal_workflow_tbl PWT, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE "
				  + " (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND PWT.action_from = '" + officeCode + "'";
			Debug.println("Sent Proposals " + query);
			rset = stat.executeQuery(query);
			sentProposals = new ArrayList();
			
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				actionTo = rset.getString(1);
				proposalDTO.setOfficeCode(actionTo);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(actionTo, true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalId(rset.getString(3));
				proposalDTO.setProposalDate(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				proposalDTO.setProgrammeName(rset.getString(6));
				proposalDTO.setSubprogrammeName(rset.getString(7));
				proposalDTO.setAssetName(rset.getString(8));
				proposalDTO.setEstimateCost(rset.getString(9));
				proposalDTO.setSanctionedAmount(rset.getString(10));
				proposalDTO.setRemarks(rset.getString(11));
				proposalDTO.setMemoNo(rset.getString(12));
				proposalDTO.setForwardDate(rset.getString(13));
				proposalDTO.setForwardSubject(rset.getString(14));
				proposalDTO.setForwardRef(rset.getString(15));
				content = rset.getString(16);
				content = content.replaceAll("\\n","");
				content = content.replaceAll("\\r","<br>");
				Debug.println("Content 1 is \n" + content);
				proposalDTO.setForwardContent(content);
				proposalDTO.setStatus(rset.getString(17));
				proposalDTO.setFlag(rset.getString(18));
				
				sentProposals.add(proposalDTO);
			}
			
			proposalList.add(sentProposals);
			
			query = " SELECT PWT.action_from, UPPER(WP.proposal_name), WP.proposal_id, "
				  + " TO_CHAR(WP.prepared_on,'dd/mm/yyyy'), WP.no_of_habs, "
				  + " NVL(P.programme_name,''), NVL(SP.subprogramme_name,''), "
				  + " NVL(AT.type_of_asset_name, ''), "
				  + " WP.estimate_cost, WP.sanction_amount, "
				  + " NVL(WP.remarks,''), PWT.memo_no, "
				  + " TO_CHAR(PWT.for_sub_date,'dd/mm/yyyy'), "
				  + " PWT.subject, NVL(PWT.ref,''), PWT.content, "
				  + " DECODE(WP.flag, 'C', 'UNDER PROCESS', 'D','DEFERRED','T','TRANSMITTED TO OTHER DEPARTMENT', 'A','SANCTIONED'), "
				  + " PWT.action_type "
				  + " FROM rws_work_proposal_tbl WP, rws_programme_tbl P, "
				  + " rws_subprogramme_tbl SP, rws_proposal_workflow_tbl PWT, "
				  + " rws_asset_type_tbl AT "
				  + " WHERE "
				  + " (WP.proposal_id = PWT.proposal_id) AND "
				  + " (WP.programme_code = P.programme_code (+)) "
				  + " AND "
				  + " (WP.programme_code = SP.programme_code(+) AND "
				  + " WP.subprogramme_code = SP.subprogramme_code (+) ) "
				  + " AND WP.type_of_asset = AT.type_of_asset_code(+) "
				  + " AND PWT.action_to = '" + officeCode + "'";
			
			Debug.println("Received Proposals " + query);
			rset = stat.executeQuery(query);
			receivedProposals = new ArrayList();
			
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
						
				actionTo = rset.getString(1);
				proposalDTO.setOfficeCode(actionTo);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(actionTo, true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setProposalId(rset.getString(3));
				proposalDTO.setProposalDate(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
				proposalDTO.setProgrammeName(rset.getString(6));
				proposalDTO.setSubprogrammeName(rset.getString(7));
				proposalDTO.setAssetName(rset.getString(8));
				proposalDTO.setEstimateCost(rset.getString(9));
				proposalDTO.setSanctionedAmount(rset.getString(10));
				proposalDTO.setRemarks(rset.getString(11));
				proposalDTO.setMemoNo(rset.getString(12));
				proposalDTO.setForwardDate(rset.getString(13));
				proposalDTO.setForwardSubject(rset.getString(14));
				proposalDTO.setForwardRef(rset.getString(15));
				content = rset.getString(16);
				content = content.replaceAll("\\n","");
				content = content.replaceAll("\\r","<br>");
				Debug.println("Content 2 is \n" + content);
				proposalDTO.setForwardContent(content);
				proposalDTO.setStatus(rset.getString(17));
				proposalDTO.setFlag(rset.getString(18));
				
				receivedProposals.add(proposalDTO);
			}
			
			proposalList.add(receivedProposals);
			
		}
		catch(Exception e)
		{	Debug.writeln("Exception in listNewProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		
		return proposalList;
	}
	
	/**
	*
	*
	*/
	public ArrayList getProposalTracking(String proposalId)
	{
		Debug.println("getProposalTracking() called.");
		Connection conn = null;
		Statement stat = null, stat1 = null;
		ResultSet rset = null, rset1 = null;
		ArrayList proposalTracks = new ArrayList();
		ArrayList consideredTracks = new ArrayList();
		ArrayList actualTracks = new ArrayList();
		ArrayList sanctionedTracks = new ArrayList();
		
		ProposalDTO proposalDTO = null;		
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();	
			/* Query for selecting proposal track in which it has been considered */
			query = " SELECT M.office_code, M.proposal_name, M.no_of_habs, NVL(PR.programme_name,''), "
				  + " NVL(SP.subprogramme_name,''), M.estimate_cost, P.user_id, D.designation_acr, "
				  + " TO_CHAR(M.prepared_on, 'dd/mm/yyyy'), NVL(PRI.priority_description, ''), "
				  + " NVL(T.type_of_asset_name,''),  NVL(M.remarks,'')  "
				  + " FROM rws_work_proposal_mirror_tbl M, rws_asset_type_tbl T, "
				  + " rws_password_tbl P, rws_designation_tbl D, rws_programme_tbl PR, " 
				  + " rws_subprogramme_tbl SP, rws_priority_tbl PRI "
				  + " WHERE M.type_of_asset = T.type_of_asset_code(+) "
				  + " AND M.programme_code = PR.programme_code(+) "
				  + " AND ( M.subprogramme_code = SP.subprogramme_code(+) "
				  + "     AND M.programme_code = SP.programme_code(+) ) "
				  + " AND M.priority_code = PRI.priority_code(+) "
				  + " AND M.prepared_by = P.user_id " 
				  + " AND P.designation_code = D.designation_code "
				  + " AND M.track_no = 0 "
				  + " AND M.proposal_id = '" + proposalId + "'";
			Debug.println("Track 1 query is \n" + query);
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(rset.getString(1), true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setNoOfHabs(rset.getString(3));
				proposalDTO.setProgrammeName(rset.getString(4));
				proposalDTO.setSubprogrammeName(rset.getString(5));
				proposalDTO.setEstimateCost(rset.getString(6));
				proposalDTO.setUserId(rset.getString(7) + ", " +rset.getString(8));
				proposalDTO.setProposalDate(rset.getString(9));
				proposalDTO.setPriorityCode(rset.getString(10));
				proposalDTO.setTypeOfAsset(rset.getString(11));
				proposalDTO.setRemarks(rset.getString(12));
				
				consideredTracks.add(proposalDTO);
			}
						
			proposalTracks.add(consideredTracks);

			/* Query for proposal tracks after consideration but before sanction */
			query = " SELECT M.office_code, M.proposal_name, M.no_of_habs, NVL(PR.programme_name, ''),"
				  + " NVL(SP.subprogramme_name,''), M.estimate_cost, M.remarks, "
				  + " NVL(T.type_of_asset_name, ''), NVL(PRI.priority_description, ''), "
				  + " M.sanction_amount, M.flag, M.admin_no, "
				  + " TO_CHAR(M.admin_date, 'dd/mm/yyyy'), M.goms_no, "
				  + " DECODE(M.state_central,'S','STATE','C','CENTRE'), M.admin_sanc_auth, M.work_id, "
				  + " W.track_no, W.memo_no, TO_CHAR(W.for_sub_date, 'dd/mm/yyyy'), "
				  + " W.subject, NVL(W.ref,''), W.content, "
				  + " W.action_from, W.action_to, "
				  + " DECODE(W.action_type, 'S', 'SUBMITTED', 'F','FORWARDED', 'D', 'DEFERRED', 'T','TRANSMITTED TO OTHER DEPARTMENT'), "
				  + " TO_CHAR(W.action_date, 'dd/mm/yyyy'), "
				  + " P1.user_id, D1.designation_acr, "
				  + " P2.user_id, D2.designation_acr "
				  + " FROM rws_proposal_workflow_tbl W, rws_work_proposal_mirror_tbl M, "
				  + " rws_asset_type_tbl T, rws_priority_tbl PRI, rws_programme_tbl PR,"
				  + " rws_subprogramme_tbl SP, rws_password_tbl P1, rws_password_tbl P2, "
				  + " rws_designation_tbl D1, rws_designation_tbl D2 "
				  + " WHERE M.proposal_id = W.proposal_id "
				  + " AND M.type_of_asset = T.type_of_asset_code(+) "
				  + " AND M.programme_code = PR.programme_code(+) "
				  + " AND ( M.subprogramme_code = SP.subprogramme_code(+) "
				  + "     AND M.programme_code = SP.programme_code(+) ) "
				  + " AND M.priority_code = PRI.priority_code(+) "
				  + " AND (W.sent_by = P1.user_id "
				  + "      AND P1.designation_code = D1.designation_code) "
				  + " AND (W.sent_to = P2.user_id "
				  + "      AND P2.designation_code = D2.designation_code) "
				  + " AND M.track_no = W.track_no "
				  + " AND M.proposal_id = '" + proposalId + "'"
				  + " ORDER BY M.track_no ";
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();

				proposalDTO.setProposalId(proposalId);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(rset.getString(1), true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setNoOfHabs(rset.getString(3));
				proposalDTO.setProgrammeName(rset.getString(4));
				proposalDTO.setSubprogrammeName(rset.getString(5));
				proposalDTO.setEstimateCost(rset.getString(6));
				proposalDTO.setRemarks(rset.getString(7));
				proposalDTO.setTypeOfAsset(rset.getString(8));
				proposalDTO.setPriorityCode(rset.getString(9));

				proposalDTO.setSanctionedAmount(rset.getString(10));
				proposalDTO.setFlag(rset.getString(11));
				proposalDTO.setAdminNo(rset.getString(12));
				proposalDTO.setAdminDate(rset.getString(13));
				proposalDTO.setGoNo(rset.getString(14));
				proposalDTO.setSanctionedAt(rset.getString(15));
				proposalDTO.setSanctioningAuthority(rset.getString(16));
				proposalDTO.setWorkId(rset.getString(17));
				proposalDTO.setTrackNo(rset.getString(18));
				proposalDTO.setLetterNo(rset.getString(19));
				proposalDTO.setSubmitDate(rset.getString(20));
				proposalDTO.setSubmitSubject(rset.getString(21));
				proposalDTO.setSubmitRef(rset.getString(22));
				proposalDTO.setSubmitContent(rset.getString(23));
				proposalDTO.setActionFrom(rwsOffices.getOfficeName(rset.getString(24), true));
				proposalDTO.setActionTo(rwsOffices.getOfficeName(rset.getString(25), true));
				proposalDTO.setActionType(rset.getString(26));
				proposalDTO.setActionDate(rset.getString(27));
				proposalDTO.setSentBy(rset.getString(28) + ", " + rset.getString(29));
				proposalDTO.setSentTo(rset.getString(30) + ", " + rset.getString(31));
				
				actualTracks.add(proposalDTO);
			}

			proposalTracks.add(actualTracks);

			/* Query for selecting proposal track in which it has been sanctioned */
			query = " SELECT P.office_code, M.proposal_name, M.no_of_habs, PR.programme_name, "
				  + " SP.subprogramme_name, T.type_of_asset_name, PRI.priority_description, "
				  + " M.remarks, M.estimate_cost, M.sanction_amount, M.admin_no, "
				  + " TO_CHAR(M.admin_date, 'dd/mm/yyyy'), goms_no,"
				  + " NVL(DECODE(state_central, 'S', 'STATE', 'C', 'CENTRE'),' '), "
				  + " NVL(admin_sanc_auth, ' '), M.work_id, P.user_id, D.designation_acr, " 
				  + " DECODE(M.phased, 'Y', 'YES', 'N', 'NO'),  NVL(phase_no, 0) "
				  + " FROM rws_work_proposal_mirror_tbl M, rws_password_tbl P, rws_designation_tbl D, " 
				  + " rws_programme_tbl PR, rws_subprogramme_tbl SP, rws_priority_tbl PRI, "
				  + " rws_asset_type_tbl T "
				  + " WHERE M.modified_by = P.user_id " 
				  + " AND P.designation_code = D.designation_code "
				  + " AND M.type_of_asset = T.type_of_asset_code(+) "
				  + " AND M.programme_code = PR.programme_code(+) "
				  + " AND ( M.subprogramme_code = SP.subprogramme_code(+) "
				  + "     AND M.programme_code = SP.programme_code(+) ) "
				  + " AND M.priority_code = PRI.priority_code(+) "
				  + " AND M.track_no = 999 AND M.proposal_id = '" + proposalId + "'";
			
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(rset.getString(1), true));
				proposalDTO.setProposalName(rset.getString(2));
				proposalDTO.setNoOfHabs(rset.getString(3));
				proposalDTO.setProgrammeName(rset.getString(4));
				proposalDTO.setSubprogrammeName(rset.getString(5));
				proposalDTO.setTypeOfAsset(rset.getString(6));
				proposalDTO.setPriorityCode(rset.getString(7));
				proposalDTO.setRemarks(rset.getString(8));
				proposalDTO.setEstimateCost(rset.getString(9));
				proposalDTO.setSanctionedAmount(rset.getString(10));
				proposalDTO.setAdminNo(rset.getString(11));
				proposalDTO.setAdminDate(rset.getString(12));
				proposalDTO.setGoNo(rset.getString(13));
				proposalDTO.setSanctionedAt(rset.getString(14));
				proposalDTO.setSanctioningAuthority(rset.getString(15));
				proposalDTO.setWorkId(rset.getString(16));
				proposalDTO.setUserId(rset.getString(17) + ", " + rset.getString(18));
				proposalDTO.setPhased(rset.getString(19));
				proposalDTO.setPhaseNo(rset.getString(20));

				sanctionedTracks.add(proposalDTO);
				
			}
			proposalTracks.add(sanctionedTracks);

		}
		catch(Exception e)
		{	Debug.writeln("Exception in getProposalTracking : \n" + e);
		}
		finally
		{
			if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
				}
				catch(SQLException sqle){
				}
			}
			if(conn != null)
			{	try{
				conn.close();
				}
				catch(SQLException sqle){
				}
			}
		}
		return proposalTracks;
	}
		

	/* -------------------------------------- O&M Proposals --------------------------------------- */

	/**
	*
	*
	*/
	public boolean omConsider(String[] assetCodes, String[] programmeCodes, ProposalDTO proposalDTO) 
	{
		Connection conn = null;
		Statement stat1 = null;
		Statement stat2 = null;
		ResultSet rset = null;
		
		int assetLength = assetCodes.length;
		int programmeLength = 0;
		if(programmeCodes != null)
			programmeLength = programmeCodes.length;
		
		String headOfficeCode = proposalDTO.getHeadOfficeCode();
		String circleOfficeCode = proposalDTO.getCircleOfficeCode();
		String divisionOfficeCode = proposalDTO.getDivisionOfficeCode();
		String subdivisionOfficeCode = proposalDTO.getSubdivisionOfficeCode();
		String officeCode = headOfficeCode + circleOfficeCode + divisionOfficeCode + subdivisionOfficeCode;
		int functionalHabSize = 0;							
		try
		{
			conn = getConn();
			stat1 = conn.createStatement();
			conn.setAutoCommit(false);
			stat2 = conn.createStatement();
						
			for(int i=0; i< assetLength; i++)
			{
				Debug.println("1: conn.getAutoCommit() : " + conn.getAutoCommit());
				
				query = " SELECT COUNT(*) FROM rws_temp_om_proposal_hab_tbl "
					  + " WHERE asset_code ='" + assetCodes[i] + "'";
				rset = stat1.executeQuery(query);
				if(rset.next())
				{	functionalHabSize = rset.getInt(1);
				}
				
				Debug.println("2: conn.getAutoCommit() : " + conn.getAutoCommit());
				
				conn.setAutoCommit(false);
				String proposalId = getNextOMProposalId(assetCodes[i]);
				query = " INSERT INTO rws_om_proposal_tbl(office_code,asset_code, "
					  + " om_proposal_id, financial_year, estimate_cost, "
					  + " prepared_on, prepared_by, remarks, flag) VALUES(" 
					  + " '" + officeCode + "', '" + assetCodes[i] + "', "
					  + " '" + proposalId + "', " 
					  + " '" + proposalDTO.getFinancialYear() + "', " 
					  + proposalDTO.getEstimateCost() + ", SYSDATE , "
					  + " '" + proposalDTO.getUserId() + "', " 
					  + " '" + proposalDTO.getRemarks() + "', 'C')";
				
				stat2.addBatch(query);
							
				String programmeCode = "";
				String subprogrammeCode = null;
				int index = 0;
				for(int j=0; j<programmeLength; j++)
				{
					programmeCode = programmeCodes[j];
					subprogrammeCode = "";
					index = programmeCode.indexOf("_");
					Debug.println("Index is " + index);
					if(index != -1)
					{	
						programmeCode = programmeCode.substring(0,index);
						subprogrammeCode = programmeCodes[j].substring(index+1,programmeCodes[j].length());
					}
					
					query = " INSERT INTO rws_om_proposal_prog_lnk_tbl "
						  + " VALUES('" + proposalId + "', "
						  + " '" + programmeCode + "', '" + subprogrammeCode + "')";
					
					stat2.addBatch(query);
				}
				
				if(functionalHabSize == 0)
				{
					query = " INSERT INTO rws_om_proposal_hab_lnk_tbl(om_proposal_id,hab_code) "
						  + " (SELECT '" + proposalId + "', hab_code FROM rws_asset_hab_tbl "
						  + " WHERE asset_code = '" + assetCodes[i] + "')";
					stat2.addBatch(query);
					
					query = " UPDATE rws_om_proposal_tbl SET no_of_habs = ( SELECT COUNT(hab_code) FROM "
						  + " rws_asset_hab_tbl WHERE asset_code = '" + assetCodes[i] + "') "
						  + " WHERE om_proposal_id = '" + proposalId + "'";
					stat2.addBatch(query);
				}	
				else
				{
					query = " INSERT INTO rws_om_proposal_hab_lnk_tbl(om_proposal_id,hab_code) "
						  + " (SELECT '" + proposalId + "', hab_code FROM rws_temp_om_proposal_hab_tbl "
						  + " WHERE asset_code = '" + assetCodes[i] + "')";
					stat2.addBatch(query);
					
					query = " UPDATE rws_om_proposal_tbl SET no_of_habs = ( SELECT COUNT(hab_code) FROM "
						  + " rws_temp_om_proposal_hab_tbl WHERE asset_code = '" + assetCodes[i] + "') "
						  + " WHERE om_proposal_id = '" + proposalId + "'";
					stat2.addBatch(query);
				}
								
				query = " INSERT INTO rws_om_proposal_mirror_tbl(office_code, "
					  + " asset_code, om_proposal_id, financial_year, estimate_cost, "
					  + " sanctioned_amount, admin_no, admin_date, go_no,"
					  + " state_central, admn_sanc_auth, prepared_on, prepared_by, "
					  + " remarks, flag, modi_office_code, modi_date, track_no, work_id, no_of_habs ) "
					  + " (SELECT office_code, asset_code, "
					  + " om_proposal_id, financial_year, estimate_cost,"
					  + " sanctioned_amount, admin_no, admin_date, go_no,"
					  + " state_central, admn_sanc_auth, prepared_on, prepared_by, remarks, "
					  + " flag, '" + officeCode + "', SYSDATE, 0, work_id, no_of_habs" 
					  + " FROM rws_om_proposal_tbl "
					  + " WHERE om_proposal_id = '" + proposalId + "')";

				stat2.addBatch(query);
			}
			
			flag = true;
			int[] updateCounts = stat2.executeBatch();
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
		{	Debug.writeln("Exception in omConsider : \n" + e);
			flag = false;
		}
		finally
		{	
			if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat1 != null)
			{	try
				{	stat1.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat2 != null)
			{	try
				{	stat1.close();
				}
				catch(SQLException sqle){
				}
			}
			if(conn != null)
			{	try{
				conn.close();
				}
				catch(SQLException sqle){
				}
			}
		}
		return flag;
	}
	
	/**
	*
	*
	*/
	public boolean omSubmit(String[] proposalIds, ProposalDTO proposalDTO)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		int proposalLength = proposalIds.length;
		
		String officeCode = proposalDTO.getOfficeCode(); 
		String letterNo = proposalDTO.getLetterNo();
		String subject = proposalDTO.getSubmitSubject();
		String ref = proposalDTO.getSubmitRef();
		String content = proposalDTO.getSubmitContent();
		String submitDate = proposalDTO.getSubmitDate();
		
		String actionFrom = proposalDTO.getOfficeCode();
		String actionTo = RwsOffices.getHigherOfficeCode(officeCode);
		String sentBy = proposalDTO.getUserId();
		String sentTo = null;
		String officeType = null;
		try
		{
			conn = getConn();
			
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
			Debug.println("Head Of Office query in omSubmit() \n" + query);
			
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
						
			for(int i=0; i<proposalLength ; i++)
			{
				int trackNo = getOMTrackNo(proposalIds[i]);
							
				query = " INSERT INTO rws_om_proposal_mirror_tbl(office_code, "
					  + " asset_code, om_proposal_id, financial_year, estimate_cost, "
					  + " sanctioned_amount, admin_no, admin_date, go_no,"
					  + " state_central, admn_sanc_auth, prepared_on, prepared_by, "
					  + " remarks, flag, modi_office_code, modi_date, track_no, work_id ) "
					  + " (SELECT office_code, asset_code, "
					  + " om_proposal_id, financial_year, estimate_cost,"
					  + " sanctioned_amount, admin_no, admin_date, go_no,"
					  + " state_central, admn_sanc_auth, prepared_on, prepared_by, remarks, "
					  + " flag, '" + officeCode + "', SYSDATE, " + trackNo + ", work_id " 
					  + " FROM rws_om_proposal_tbl "
					  + " WHERE om_proposal_id = '" + proposalIds[i] + "')";

				stat.addBatch(query);
				
				if(trackNo > 1)
				{
					query = " UPDATE rws_om_proposal_workflow_tbl SET flag='Y' " 
						  + " WHERE om_proposal_id = '" + proposalIds[i] + "' AND track_no = " + (trackNo-1);
					stat.addBatch(query);
				}

				query = " INSERT INTO rws_om_proposal_workflow_tbl VALUES ( "
					  + " '" + proposalIds[i] + "', " + trackNo + ", "
					  + "'" + actionFrom + "', '" + actionTo + "', "
					  + " 'S', SYSDATE, '" + sentBy + "', '" + sentTo + "', '" + letterNo + "', "
					  + " '" + subject + "', '" + ref + "', '" + content + "', "
					  + " TO_DATE('" + submitDate + "','dd/mm/yyyy'), 'N') ";

				stat.addBatch(query);
			}
			
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
		{	Debug.writeln("Exception in omSubmit : \n" + e);
			flag = false;
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return flag;
	}

	/**
	*
	*
	*/
	public boolean omForward(String[] proposalIds, ProposalDTO proposalDTO)
	{	
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		int proposalLength = proposalIds.length;
		String officeCode = proposalDTO.getOfficeCode(); 
		String actionFrom = proposalDTO.getOfficeCode(); 
		String actionTo[] = null;
		
		String forwardTo = proposalDTO.getForwardTo();

		String sentBy = proposalDTO.getUserId();
		String memoNo = proposalDTO.getMemoNo();
		String subject = proposalDTO.getForwardSubject();
		String ref = proposalDTO.getForwardRef();
		String content = proposalDTO.getForwardContent();
		String forwardDate = proposalDTO.getForwardDate();

		String sentTo = null;
		String officeType = null;
		StringTokenizer stringTokenizer = new StringTokenizer(forwardTo,",");
		int noOfForwards = stringTokenizer.countTokens();
		
		actionTo = new String[noOfForwards];
		int k=0;
		while(stringTokenizer.hasMoreElements())
		{
			actionTo[k] = stringTokenizer.nextToken();
			k++;
		}
		String employeeCodes[] = new String[actionTo.length]; 
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			
			for(int	i=0; i< actionTo.length; i++)
			{
				if(!actionTo[i].substring(4,6).equals("00"))
					officeType = "SUB DIVISION OFFICE";
				else
				if(!actionTo[i].substring(3,4).equals("0"))
						officeType = "DIVISION OFFICE";
				else
				if(!actionTo[i].substring(1,3).equals("00"))
					officeType = "CIRCLE OFFICE";
				else
				if(!actionTo[i].substring(0,1).equals("0"))
					officeType = "HEAD OFFICE";

				query = " SELECT user_id FROM rws_password_tbl WHERE designation_code = "
					  + " (SELECT designation_code FROM rws_head_of_office_tbl WHERE office LIKE '" + officeType + "')" 
					  + " AND office_code = '" + actionTo[i] + "'";
				Debug.println("Head Of Office query in omForward() \n" + query);

				rset = stat.executeQuery(query);
				while(rset.next())
				{
					employeeCodes[i] = rset.getString(1);
				}
			}
			int p = 0;
			for (int i=0; i<employeeCodes.length; i++)
			{
				if(employeeCodes[i] != null)
						p++;
			}
			if(p != employeeCodes.length)
			{
				HEAD_OF_OFFICE_COUNT = p;
				return false;
			}

			conn.setAutoCommit(false);
			for(int i=0; i<proposalIds.length; i++)
			{
				int trackNo = getOMTrackNo(proposalIds[i]);
								
				query = " INSERT INTO rws_om_proposal_mirror_tbl(office_code, "
					  + " asset_code, om_proposal_id, financial_year, estimate_cost,"
					  + " sanctioned_amount, admin_no, admin_date, go_no,"
					  + " state_central, admn_sanc_auth, prepared_on, prepared_by, "
					  + " remarks, flag, modi_office_code, modi_date, track_no, work_id ) "
					  + " (SELECT office_code, asset_code, "
					  + " om_proposal_id, financial_year, estimate_cost,"
					  + " sanctioned_amount, admin_no, admin_date, go_no,"
					  + " state_central, admn_sanc_auth, prepared_on, prepared_by, remarks, "
					  + " flag, '" + officeCode + "', SYSDATE, " + trackNo + ", work_id " 
					  + " FROM rws_om_proposal_tbl "
					  + " WHERE om_proposal_id = '" + proposalIds[i] + "')";
				Debug.println("Query is 1: " + query);
				stat.addBatch(query);

				for(int j=0; j< noOfForwards; j++)
				{
					if(trackNo > 1)
					{
						query = " UPDATE rws_om_proposal_workflow_tbl SET flag='Y' " 
							  + " WHERE om_proposal_id = '" + proposalIds[i] + "' AND track_no = " + (trackNo-1);
						stat.addBatch(query);
						Debug.println("Query is 2: " + query);
					}
					
					query = " INSERT INTO rws_om_proposal_workflow_tbl VALUES( "
						  + "'" + proposalIds[i] + "', " + trackNo + ", " 
						  + " '" + actionFrom + "', '" + actionTo[j] + "', 'F', SYSDATE, " 
						  + " '" + sentBy + "', "
						  + " '" + employeeCodes[j] + "', '" + memoNo + "', '" + subject + "', "
						  + " '" + ref + "', '" + content + "',"
						  + " TO_DATE('" + forwardDate + "','dd/mm/yyyy'), 'N') ";
					stat.addBatch(query);
					Debug.println("Query is 3: " + query);
				}
			}
			
			flag = true;
			int[] updateCounts = stat.executeBatch();
			for(int i=0; i<updateCounts.length; i++)
			{
				if(updateCounts[i] != 1)
					flag = false;
			}
			if(flag)
				conn.commit();

			conn.setAutoCommit(true);
		}
		catch(Exception e)
		{	Debug.writeln("Exception in omForward : \n" + e);
			flag = false;
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return flag;
	}
	
	public boolean omOthers(String[] proposalIds, ProposalDTO proposalDTO)
	{
		Connection conn = null;
		Statement stat = null;
		try
		{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			String actionType = proposalDTO.getActionType();
			String officeCode = proposalDTO.getOfficeCode();
			String userId = proposalDTO.getUserId();
			
			for(int i=0; i<proposalIds.length; i++)
			{
				int trackNo = getOMTrackNo(proposalIds[i]);
				
				query = " UPDATE rws_om_proposal_tbl SET flag='"+actionType+"'"
					  + " WHERE om_proposal_id='"+proposalIds[i]+"'";
				stat.addBatch(query);
			
				query = " INSERT INTO rws_om_proposal_mirror_tbl(office_code, "
					  + " asset_code, om_proposal_id, financial_year, estimate_cost,"
					  + " sanctioned_amount, admin_no, admin_date, go_no,"
					  + " state_central, admn_sanc_auth, prepared_on, prepared_by, "
					  + " remarks, flag, modi_office_code, modi_date, track_no, work_id ) "
					  + " (SELECT office_code, asset_code, "
					  + " om_proposal_id, financial_year, estimate_cost,"
					  + " sanctioned_amount, admin_no, admin_date, go_no,"
					  + " state_central, admn_sanc_auth, prepared_on, prepared_by, remarks, "
					  + " flag, '" + officeCode + "', SYSDATE, " + trackNo + ", work_id " 
					  + " FROM rws_om_proposal_tbl "
					  + " WHERE om_proposal_id = '" + proposalIds[i] + "')";
				stat.addBatch(query);
				
				if(trackNo > 1)
				{
					query = " UPDATE rws_om_proposal_workflow_tbl SET flag='Y' " 
						  + " WHERE om_proposal_id = '" + proposalIds[i] + "' AND track_no = " + (trackNo-1);
					stat.addBatch(query);
				}
							
				query = " INSERT INTO rws_om_proposal_workflow_tbl(om_proposal_id, track_no," 
					  + " action_from, action_to, action_type, action_date, sent_by,"
					  + " sent_to, memo_no, subject, ref, content, for_sub_date, flag)"
					  + " VALUES('" + proposalIds[i] + "'," + trackNo + ","
					  + " '" + officeCode + "','" + officeCode + "', "
					  + " '" + actionType + "', SYSDATE, "
					  + " '" + userId + "','" +  userId + "',"
					  + " '000000', '000000','000000',"
					  + " '" + proposalDTO.getOtherRemarks() + "', SYSDATE, 'N')";
				Debug.println("Defer Query is " + query);
				stat.addBatch(query);

			}
				flag = true;
				int updateCounts[] = stat.executeBatch();
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
		{	Debug.writeln("Exception in omOthers : \n" + e);
			flag = false;
		}
		finally
		{	
			if(stat != null)
			{	try
				{	stat.close();
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
		return flag;
	}
	
	public boolean omDeleteConsidered(String[] proposalIds)
	{
		Connection conn = null;
		Statement stat = null;
		
		try
		{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			
			for(int i=0; i< proposalIds.length; i++)
			{
				query = " DELETE FROM rws_om_proposal_prog_lnk_tbl "
					  + " WHERE om_proposal_id = '" + proposalIds[i] + "'";
				stat.addBatch(query);
				
				query = " DELETE FROM rws_om_proposal_hab_lnk_tbl "
					  + " WHERE om_proposal_id = '" + proposalIds[i] + "'";
				stat.addBatch(query);
				
				query = " DELETE FROM rws_om_proposal_mirror_tbl "
					  + " WHERE om_proposal_id = '" + proposalIds[i] + "'"
					  + " AND track_no = 0";
				stat.addBatch(query);
				
				query = " DELETE FROM rws_om_proposal_tbl "
					  + " WHERE om_proposal_id = '" + proposalIds[i] + "'";
				stat.addBatch(query);
			}
			int[] updateCounts = stat.executeBatch();
			flag = true;
			conn.commit();
			conn.setAutoCommit(true);
					
		}
		catch(Exception e)
		{
			flag = false;
			Debug.print("Exception in omDeleteConsidered " + e.getMessage());
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
		return flag;
	}
	
	public boolean omConsiderForSanction(String[] proposalIds, ProposalDTO proposalDTO)
	{
		Connection conn = null;
		Statement stat = null;
						
		try
		{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			String actionType = proposalDTO.getActionType();
			
			for(int i=0; i<proposalIds.length; i++)
			{
				int trackNo = getOMTrackNo(proposalIds[i]);
				
				query = " INSERT INTO rws_om_proposal_workflow_tbl(om_proposal_id, " 
					  + " track_no, action_from, action_to, action_type, "
					  + " action_date, sent_by, sent_to, memo_no, subject, "
					  + " ref, content, for_sub_date, flag)"
					  + " (SELECT om_proposal_id," + trackNo + ", action_from, "
					  + " action_to, 'P', SYSDATE, sent_by, sent_to, "
					  + " memo_no, subject, ref, content,for_sub_date,'N' "
					  + " FROM rws_om_proposal_workflow_tbl "
					  + " WHERE om_proposal_id = '" + proposalIds[i] + "' AND "
					  + " track_no = " + (trackNo-1) + ")";
				stat.addBatch(query);
				
				query = " UPDATE rws_om_proposal_workflow_tbl SET flag='Y'"
					  + " WHERE om_proposal_id='"+proposalIds[i]+"' "
					  + " AND track_no = " + (trackNo-1);
				stat.addBatch(query);
				
				query = " UPDATE rws_om_proposal_tbl SET flag='P'"
					  + " WHERE om_proposal_id='"+proposalIds[i]+"'";
				stat.addBatch(query);
			}
			flag = true;
			int updateCounts[]=stat.executeBatch();
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
		{	Debug.writeln("Exception in omConsiderForSanction : \n" + e);
			flag = false;
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
		return flag;
	}
	
	/*
	*
	*
	*/
	public boolean omSanction(String[] proposalIds, String[] sanctionAmounts, ProposalDTO proposalDTO)
	{
		Connection conn = null;
		Statement stat = null;

		String officeCode = proposalDTO.getOfficeCode();
		String preparedBy = proposalDTO.getUserId();
		String adminNo = proposalDTO.getAdminNo();
		String adminDate = proposalDTO.getAdminDate();
		String goNo = proposalDTO.getGoNo();
		String sancAuthority = proposalDTO.getSanctioningAuthority();
		String sancAt = proposalDTO.getSanctionedAt();
		String sanctionedAmount = proposalDTO.getSanctionedAmount();
			
		if(proposalIds != null || proposalIds.length > 0)
		{
			try
			{	
				conn = getConn();
				conn.setAutoCommit(false);
				stat = conn.createStatement();

				for(int i=0; i<proposalIds.length; i++)
				{
					int trackNo = getOMTrackNo(proposalIds[i]);

					if(trackNo > 1)
					{
						query = " UPDATE rws_om_proposal_workflow_tbl SET flag='Y' "
							  + " WHERE om_proposal_id = '" + proposalIds[i] + "' "
							  + " AND track_no = " + (trackNo-1);
						Debug.println("Query 1: " + query);
						stat.addBatch(query);
					}
					
					query = " UPDATE rws_om_proposal_tbl "
						  + " SET flag = 'A', admin_no='" + adminNo+ "',"
						  + " admin_date = TO_DATE('" + adminDate + "', 'dd/mm/yyyy'), "
						  + " go_no = '" + goNo + "', "
						  + " admn_sanc_auth='"+ sancAuthority + "', "
						  + " state_central = '" + sancAt + "', "
						  + " work_id = '" + proposalIds[i] + "', "
						  + " sanctioned_amount = '" + sanctionAmounts[i] + "'" 
						  + " WHERE om_proposal_id = '" + proposalIds[i] + "'";
					Debug.println("Query 2: " + query);	  				
					stat.addBatch(query);

					query = " INSERT INTO rws_om_proposal_mirror_tbl(office_code, "
						  + " asset_code, om_proposal_id, financial_year, estimate_cost, "
						  + " sanctioned_amount, admin_no, admin_date, go_no,"
						  + " state_central, admn_sanc_auth, prepared_on, prepared_by, "
						  + " remarks, flag, modi_office_code, modi_date, track_no, work_id ) "
						  + " (SELECT office_code, asset_code, "
						  + " om_proposal_id, financial_year, estimate_cost,"
						  + " sanctioned_amount, admin_no, admin_date, go_no,"
						  + " state_central, admn_sanc_auth, prepared_on, prepared_by, remarks, "
						  + " flag, '" + officeCode + "', SYSDATE, 99, work_id " 
						  + " FROM rws_om_proposal_tbl "
						  + " WHERE om_proposal_id = '" + proposalIds[i] + "')";
					Debug.println("Query 3: " + query);		
				stat.addBatch(query);
				}
				
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
			{	Debug.println("Exception in omSanction:\n" + e);
				flag = false;
			}
			finally
			{	if(stat != null)
				{	try
					{	stat.close();
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
		}
		return flag;
	}
	
	/**
	*
	*
	*/
	public String getNextOMProposalId(String assetCode)
	{
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy");
		String currentYear = dateFormatter.format(new java.util.Date());
		String omProposalId = "OM" + currentYear + assetCode;				
		
		return omProposalId;
	}
	
	/*
	*
	*
	*/
	public int getOMTrackNo(String omProposalId)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		int nextTrackNo = 1;
		try
		{
			query = " SELECT MAX(track_no)+1 from rws_om_proposal_workflow_tbl "
				  + " WHERE om_proposal_id = '" + omProposalId + "'";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				nextTrackNo = rset.getInt(1);
				
				if(nextTrackNo == 0)
					nextTrackNo = 1;
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMTrackNo : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return nextTrackNo;
	}
	
	/*
	* @param <code>String</code>
	* @param <code>String</code>
	* @param <code>String</code>
	*/
	protected ArrayList getAssets(String circleOfficeCode, String divisionOfficeCode,
				String subdivisionOfficeCode)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		ArrayList assets = null;
		try
		{
			query = " SELECT asset_code, UPPER(asset_name), hab_code, UPPER(location), "
				  + " TO_CHAR(date_creation, 'dd/mm/yyyy') as date_creation, "
				  + " DECODE(asset_status,'1', 'WORKING', '2', 'NOT WORKING', '3', 'DRIED')," 
				  + " asset_cost, start_year, end_year "
				  + " FROM rws_asset_mast_tbl AM, rws_asset_type_tbl AT "
				  + " WHERE AM.type_of_asset_code = AT.type_of_asset_code AND "
				  + " UPPER(AT.type_of_asset_name) like 'CPWS' AND "
				  + " AM.circle_office_code = '" + circleOfficeCode + "' AND "
				  + " AM.division_office_code = '" + divisionOfficeCode + "' AND "
				  + " AM.subdivision_office_code = '" + subdivisionOfficeCode + "' AND "
				  + " AM.asset_code NOT IN (SELECT asset_code FROM rws_om_proposal_tbl) ";  
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			assets = new ArrayList();
			Asset asset = null;
			tempStat = conn.createStatement();
			int noOfHabs = 0;
			int noOfFunctionalHabs = 0;
			while(rset.next())
			{
				asset = new Asset();
				String assetCode = rset.getString(1);
				asset.setAssetCode(assetCode);
				asset.setAssetName(rset.getString(2));
				asset.setHabCode(rset.getString(3));
				asset.setLocation(rset.getString(4));
				asset.setCreationDate(rset.getString(5));
				asset.setAssetStatus(rset.getString(6));
				asset.setAssetCost(rset.getString(7));
				asset.setStartYear(rset.getString(8));
				asset.setEndYear(rset.getString(9));
				query = " SELECT COUNT(hab_code) FROM rws_asset_hab_tbl "
					  + " WHERE asset_code='" + assetCode + "'";
				tempRset = tempStat.executeQuery(query);
				tempRset.next();
				noOfHabs = tempRset.getInt(1);
				asset.setNoOfHabs(String.valueOf(noOfHabs));
				
				query = " SELECT COUNT(hab_code) FROM rws_temp_om_proposal_hab_tbl "
					  + " WHERE asset_code='" + assetCode + "'";
				tempRset = tempStat.executeQuery(query);
				tempRset.next();
				noOfFunctionalHabs = tempRset.getInt(1);
				if(noOfFunctionalHabs == 0)
					noOfFunctionalHabs = noOfHabs; 
				asset.setNoOfFunctionalHabs(String.valueOf(noOfFunctionalHabs));
				
				assets.add(asset);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getAssests : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return assets;
	}
	
	public ArrayList getAssetHabitations(String assetCode) 
	{
		ArrayList assetHabs = new ArrayList();
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			query = " SELECT PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu+HD.census_sc_popu+HD.census_st_popu), "
				  + " HD.coverage_status FROM rws_asset_hab_tbl AH, "
				  + " rws_panchayat_raj_tbl PR, rws_habitation_directory_tbl HD "
				  + " WHERE AH.hab_code = PR.panch_code "
				  + " AND AH.hab_code = HD.hab_code "
				  + " AND AH.asset_code = '" + assetCode + "'";
			Debug.println("Asset Hab Query is " + query);
			rset = stat.executeQuery(query);
			RwsLocationBean rwsLocationBean = null;
			while(rset.next())
			{
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setHabCode(rset.getString(1));
				rwsLocationBean.setHabName(rset.getString(2));
				rwsLocationBean.setPopulation(rset.getString(3));
				rwsLocationBean.setStatus(rset.getString(4));
				assetHabs.add(rwsLocationBean);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getAssetHabitations : \n" + e);			
		}
		finally
		{
			if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		
		return assetHabs;
	}
	
	/**
	*
	*
	*/
	public ArrayList getOMConsideredProposals(String officeCode)
	{	
		Debug.println("getOMConsideredProposals() called.");
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Statement stat1 = null;
		ResultSet rset1 = null;
		
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
		try
		{
			query = " SELECT OMP.om_proposal_id, OMP.asset_code, UPPER(AM.asset_name) ,"
				  + " UPPER(NVL(OMP.estimate_cost,'0')), "
				  + " NVL(OMP.financial_year,''), "
				  + " TO_CHAR(OMP.prepared_on,'dd/mm/yyyy'),  "
				  + " UPPER(NVL(OMP.remarks,'')), no_of_habs "
				  + " FROM rws_om_proposal_tbl OMP, rws_asset_mast_tbl AM"
				  + " WHERE "
				  + " OMP.asset_code = AM.asset_code AND OMP.flag='C'"
				  + " AND OMP.office_code='" + officeCode + "' AND "
				  + " OMP.om_proposal_id NOT IN  "
				  + " (SELECT om_proposal_id FROM rws_om_proposal_workflow_tbl) ";
				  
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rset = stat.executeQuery(query);
			consideredProposals = new ArrayList();
			String proposalId = null;
			ArrayList programmes = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				proposalId = rset.getString(1);
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setAssetCode(rset.getString(2));
				proposalDTO.setAssetName(rset.getString(3));
				proposalDTO.setEstimateCost(rset.getString(4));
				proposalDTO.setFinancialYear(rset.getString(5));
				proposalDTO.setProposalDate(rset.getString(6));
				proposalDTO.setNoOfFunctionalHabs(rset.getString(8));
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
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				consideredProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMConsideredProposals is :\n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return consideredProposals;
	}
	
	/**
	*
	*
	*/
	public ArrayList getOMSubmittedProposals(String actionTo, String proposalType)
	{
		Debug.println("getOMSubmittedProposals() called.");
		Connection conn = null;
		Statement stat = null;
		Statement stat1 = null;
		ResultSet rset = null;
		ResultSet rset1 = null;
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null; 
		higherOfficeCode = RwsOffices.getHigherOfficeCode(actionTo);
		
		try
		{
			query = " SELECT OMPWT.action_from, OMP.om_proposal_id, "
				  + " OMP.financial_year, OMP.asset_code, AM.asset_name,  "
				  + " OMP.estimate_cost, NVL(OMP.sanctioned_amount, 0),"
				  + " TO_CHAR(OMP.prepared_on,'dd/mm/yyyy'), "
				  + " OMPWT.memo_no, TO_CHAR(OMPWT.for_sub_date,'dd/mm/yyyy'),"
				  + " OMPWT.subject, NVL(OMPWT.ref,''),"
				  + " OMPWT.content, OMPWT.action_type, OMP.no_of_habs "
				  + " FROM rws_om_proposal_tbl OMP, "
				  + " rws_om_proposal_workflow_tbl OMPWT, "
				  + " rws_asset_mast_tbl AM WHERE  "
				  + " (OMP.om_proposal_id = OMPWT.om_proposal_id) "
				  + " AND OMP.asset_code = AM.asset_code "
				  + " AND OMP.flag = '" + proposalType + "' AND OMPWT.action_type='S' "
				  + " AND OMPWT.flag = 'N' AND OMPWT.action_to='" + actionTo + "'";
				  			
			Debug.println("query in getOMSubmittedProposals() is "+query);
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rset = stat.executeQuery(query);
			submittedProposals = new ArrayList();
			rwsOffices = new RwsOffices(dataSource);
			String officeCode = "", officeName="";
			String proposalId = null;
			ArrayList programmes = null;
			String content = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();

				officeCode = rset.getString(1);
				proposalId = rset.getString(2);
				officeName = rwsOffices.getOfficeName(officeCode, true);
				
				proposalDTO.setOfficeCode(officeCode);
				proposalDTO.setOfficeName(officeName);
				
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setFinancialYear(rset.getString(3));
				proposalDTO.setAssetCode(rset.getString(4));
				proposalDTO.setAssetName(rset.getString(5));
				proposalDTO.setEstimateCost(rset.getString(6));
				proposalDTO.setSanctionedAmount(rset.getString(7));
				proposalDTO.setProposalDate(rset.getString(8));
				proposalDTO.setLetterNo(rset.getString(9));
				proposalDTO.setSubmitDate(rset.getString(10));
				proposalDTO.setSubmitSubject(rset.getString(11));
				proposalDTO.setSubmitRef(rset.getString(12));
				content = rset.getString(13);
				content = content.replaceAll("\\n","");
				content = content.replaceAll("\\r","<br>");
				proposalDTO.setSubmitContent(content);
				proposalDTO.setFlag(rset.getString(14));
				proposalDTO.setNoOfFunctionalHabs(rset.getString(15));
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
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);			
				submittedProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMSubmitedProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		Debug.println("OM submittedProposals.size() in ProposalDAO: " + submittedProposals.size());
		return submittedProposals;
	}
	
	/**
	*
	*
	*/
	public ArrayList getOMForwardedProposals(String actionTo, String proposalType)
	{
		Debug.println("getOMForwardedProposals() called.");
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Statement stat1 = null;
		ResultSet rset1 = null;
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
		try
		{
			query = " SELECT OMPWT.action_from, OMP.om_proposal_id, "
				  + " OMP.financial_year, OMP.asset_code, AM.asset_name, "
				  + " OMP.estimate_cost, NVL(OMP.sanctioned_amount, '0'),"
				  + " TO_CHAR(OMP.prepared_on,'dd/mm/yyyy'), "
				  + " OMPWT.memo_no, TO_CHAR(OMPWT.for_sub_date,'dd/mm/yyyy'),"
				  + " OMPWT.subject, NVL(OMPWT.ref,''), "
				  + " OMPWT.content, OMPWT.action_type, "
				  + " OMP.work_id, OMP.admin_no, "
				  + " TO_CHAR(OMP.admin_date,'dd/mm/yyyy'), OMP.go_no, OMP.no_of_habs "
				  + " FROM rws_om_proposal_tbl OMP,"
				  + " rws_om_proposal_workflow_tbl OMPWT, "
				  + " rws_asset_mast_tbl AM WHERE  "
				  + " (OMP.om_proposal_id = OMPWT.om_proposal_id) "
				  + " AND OMP.asset_code = AM.asset_code " 
				  + " AND OMP.flag = '" + proposalType + "' AND OMPWT.flag = 'N' "
				  + " AND OMPWT.action_type='F' AND OMPWT.action_to='" + actionTo + "'";
		
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rset = stat.executeQuery(query);
			forwardedProposals = new ArrayList();
			rwsOffices = new RwsOffices(dataSource);
			String officeCode = "", officeName = "";
			ArrayList programmes = null;
			String proposalId = null;
			String content = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				officeCode = rset.getString(1);
				proposalId = rset.getString(2);
				officeName = rwsOffices.getOfficeName(officeCode, true);
				
				proposalDTO.setOfficeCode(officeCode);
				proposalDTO.setOfficeName(officeName);
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setFinancialYear(rset.getString(3));
				proposalDTO.setAssetCode(rset.getString(4));
				proposalDTO.setAssetName(rset.getString(5));
				proposalDTO.setEstimateCost(rset.getString(6));
				proposalDTO.setSanctionedAmount(rset.getString(7));
				proposalDTO.setProposalDate(rset.getString(8));
				proposalDTO.setMemoNo(rset.getString(9));
				proposalDTO.setForwardDate(rset.getString(10));
				proposalDTO.setForwardSubject(rset.getString(11));
				proposalDTO.setForwardRef(rset.getString(12));
				content = rset.getString(13);
				content = content.replaceAll("\\n","");
				content = content.replaceAll("\\r","<br>");
				proposalDTO.setForwardContent(content);
				proposalDTO.setFlag(rset.getString(14));
				proposalDTO.setWorkId(rset.getString(15));
				proposalDTO.setAdminNo(rset.getString(16));
				proposalDTO.setAdminDate(rset.getString(17));
				proposalDTO.setGoNo(rset.getString(18));
				proposalDTO.setNoOfFunctionalHabs(rset.getString(19));
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
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
											
				forwardedProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMForwardedProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		
		Debug.println("OM forwardProposals.size() in ProposalDAO: " + forwardedProposals.size());
		return forwardedProposals;
	}
	
	/**
	*
	*
	*/
	public ArrayList getOMPendingProposals(String actionFrom, String actionTo)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Statement stat1 = null;
		ResultSet rset1 = null;
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
		
		ArrayList pendingProposals = new ArrayList();
		Debug.println("In getOMPendingProposalData.do");
		Debug.println("Action From is " + actionFrom);
		Debug.println("Action To is " + actionTo);
		
		try
		{
			query = " SELECT OMPWT.action_from, OMP.om_proposal_id, "
				  + " OMP.financial_year, OMP.asset_code, AM.asset_name,  "
				  + " OMP.estimate_cost, NVL(OMP.sanctioned_amount, 0),"
				  + " TO_CHAR(OMP.prepared_on,'dd/mm/yyyy'), "
				  + " OMPWT.memo_no, TO_CHAR(OMPWT.for_sub_date,'dd/mm/yyyy'),"
				  + " OMPWT.subject, NVL(OMPWT.ref,''),"
				  + " OMPWT.content, OMPWT.action_type, OMP.no_of_habs "
				  + " FROM rws_om_proposal_tbl OMP, rws_asset_mast_tbl AM, "
				  + " rws_om_proposal_workflow_tbl OMPWT "
				  + " WHERE  "
				  + " (OMP.om_proposal_id = OMPWT.om_proposal_id)"
				  + " AND OMP.asset_code = AM.asset_code "
				  + " AND OMP.flag = 'P' AND OMPWT.action_type='P' "
				  + " AND OMPWT.flag = 'N' AND OMPWT.action_to='" + actionTo + "'";
			if(!actionFrom.equals(""))
			query += " AND OMPWT.action_from LIKE '" + actionFrom + "%'"; 
			
			Debug.println("Pending Query is " + query);
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rset = stat.executeQuery(query);
			
			rwsOffices = new RwsOffices(dataSource);
			String officeCode = "", officeName="";
			String proposalId = null;
			ArrayList programmes = null;
			
			String content = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();

				officeCode = rset.getString(1);
				proposalId = rset.getString(2);
				officeName = rwsOffices.getOfficeName(officeCode, true);
				
				proposalDTO.setOfficeCode(officeCode);
				proposalDTO.setOfficeName(officeName);
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setFinancialYear(rset.getString(3));
				proposalDTO.setAssetCode(rset.getString(4));
				proposalDTO.setAssetName(rset.getString(5));
				String estimateCost = rset.getString(6);
				double sanctionedAmount = rset.getDouble(7);
				
				proposalDTO.setEstimateCost(estimateCost);
				if(sanctionedAmount == 0)
					proposalDTO.setSanctionedAmount(estimateCost);
				else
					proposalDTO.setSanctionedAmount(String.valueOf(sanctionedAmount));
								
				proposalDTO.setProposalDate(rset.getString(8));
				proposalDTO.setLetterNo(rset.getString(9));
				proposalDTO.setSubmitDate(rset.getString(10));
				proposalDTO.setSubmitSubject(rset.getString(11));
				proposalDTO.setSubmitRef(rset.getString(12));
				content = rset.getString(13);
				content = content.replaceAll("\\n","");
				content = content.replaceAll("\\r","<br>");
				proposalDTO.setSubmitContent(content);
				proposalDTO.setFlag(rset.getString(14));
				proposalDTO.setNoOfFunctionalHabs(rset.getString(15));
				query = " SELECT PP.programme_code, NVL(P.programme_name,''), " 
					  + " NVL(SP.subprogramme_name,'') FROM "
					  + " rws_om_proposal_tbl OMP, rws_om_proposal_prog_lnk_tbl PP,"
					  + " rws_programme_tbl P,  rws_subprogramme_tbl SP "
					  + " WHERE OMP.om_proposal_id = PP.om_proposal_id "
					  + " AND PP.programme_code = P.programme_code "
					  + " AND PP.programme_code = SP.programme_code(+) "
					  + " AND PP.subprogramme_code = SP.subprogramme_code(+) "
					  + " AND OMP.om_proposal_id = '" + proposalId + "'";
				rset1 = stat1.executeQuery(query);
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeCode(rset1.getString(1));
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(2));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(3));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				pendingProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMPendingProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		Debug.println("OM pendingProposals.size() in ProposalDAO: " +pendingProposals.size());
		return pendingProposals;
	}
	
	/**
	*
	*
	*/
	protected ArrayList getOMSanctionedProposals(String officeCode)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Statement stat1 = null;
		ResultSet rset1 = null;
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;

		try
		{
			query = " SELECT OMP.om_proposal_id, OMP.work_id, OMP.asset_code, "
				  + " AM.asset_name, OMP.financial_year, OMP.admin_no, "
				  + " TO_CHAR(admin_date, 'dd/mm/yyyy'), OMP.go_no,"
				  + " OMP.sanctioned_amount, OMP.no_of_habs "
				  + " FROM rws_om_proposal_tbl OMP, rws_asset_mast_tbl AM"
				  + " WHERE "
				  + " OMP.asset_code = AM.asset_code " 
				  + " AND OMP.flag = 'A' AND OMP.om_proposal_id NOT IN "
				  + " (SELECT om_proposal_id FROM rws_om_proposal_workflow_tbl " 
				  + " WHERE flag='N')";

			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rset = stat.executeQuery(query);

			sanctionedProposals = new ArrayList();
			ArrayList programmes = new ArrayList();
			ProposalDTO proposalDTO = null;
			String proposalId = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				proposalId = rset.getString(1);
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setWorkId(rset.getString(2));
				proposalDTO.setAssetCode(rset.getString(3));
				proposalDTO.setAssetName(rset.getString(4));
				proposalDTO.setFinancialYear(rset.getString(5));
				proposalDTO.setAdminNo(rset.getString(6));
				proposalDTO.setAdminDate(rset.getString(7));
				proposalDTO.setGoNo(rset.getString(8));
				proposalDTO.setSanctionedAmount(rset.getString(9));
				proposalDTO.setNoOfFunctionalHabs(rset.getString(10));
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
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				sanctionedProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMSanctionedProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		Debug.println("sanctionedProposals.size() in ProposalDAO(): " +	sanctionedProposals.size());
		return sanctionedProposals;
	}
	
	public ArrayList listOMProposals(String officeCode) 
	{
		Connection conn = null;
		Statement stat = null, stat1 = null;;
		ResultSet rset = null, rset1 = null;
		ArrayList proposalList = new ArrayList(2);
		ArrayList sentProposals = null;
		ArrayList receivedProposals = null;
		ProposalDTO proposalDTO = null;
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null; 
		String actionTo = null;
		String content = null;
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rwsOffices = new RwsOffices(dataSource);
						
			query = " SELECT OMPWT.action_to, OMP.om_proposal_id, "
				  + " OMP.financial_year, OMP.asset_code, AM.asset_name, "
				  + " OMP.estimate_cost, NVL(OMP.sanctioned_amount, '0'),"
				  + " TO_CHAR(OMP.prepared_on,'dd/mm/yyyy'), "
				  + " DECODE(OMP.flag, 'C', 'UNDER PROCESS', 'D','DEFERRED','T','TRANSMITTED TO OTHER DEPARTMENT', 'A','SANCTIONED'), "
				  + " OMPWT.memo_no, TO_CHAR(OMPWT.for_sub_date,'dd/mm/yyyy'),"
				  + " OMPWT.subject, NVL(OMPWT.ref,''), "
				  + " OMPWT.content, OMPWT.action_type "
				  + " FROM rws_om_proposal_tbl OMP,"
				  + " rws_om_proposal_workflow_tbl OMPWT, "
				  + " rws_asset_mast_tbl AM WHERE  "
				  + " (OMP.om_proposal_id = OMPWT.om_proposal_id) "
				  + " AND OMP.asset_code = AM.asset_code " 
				  + " AND OMPWT.action_from = '" + officeCode + "'";
			
			Debug.println("Sent Proposals " + query);
			rset = stat.executeQuery(query);
			sentProposals = new ArrayList();
			String proposalId = null;
			ArrayList programmes = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				actionTo = rset.getString(1);
				proposalId = rset.getString(2);
				proposalDTO.setOfficeCode(actionTo);
				
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(actionTo, true));
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setFinancialYear(rset.getString(3));
				proposalDTO.setAssetCode(rset.getString(4));
				proposalDTO.setAssetName(rset.getString(5));
				proposalDTO.setEstimateCost(rset.getString(6));
				proposalDTO.setSanctionedAmount(rset.getString(7));
				proposalDTO.setProposalDate(rset.getString(8));
				proposalDTO.setStatus(rset.getString(9));
				proposalDTO.setMemoNo(rset.getString(10));
				proposalDTO.setSubmitDate(rset.getString(11));
				proposalDTO.setSubmitSubject(rset.getString(12));
				proposalDTO.setSubmitRef(rset.getString(13));
				content = rset.getString(14);
				content = content.replaceAll("\\n","");
				content = content.replaceAll("\\r","<br>");
				proposalDTO.setSubmitContent(content);
				proposalDTO.setFlag(rset.getString(15));
								
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
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				
				sentProposals.add(proposalDTO);
			}
			
			proposalList.add(sentProposals);
			
			query = " SELECT OMPWT.action_to, OMP.om_proposal_id, "
				  + " OMP.financial_year, OMP.asset_code, AM.asset_name, "
				  + " OMP.estimate_cost, NVL(OMP.sanctioned_amount, '0'),"
				  + " TO_CHAR(OMP.prepared_on,'dd/mm/yyyy'), "
				  + " DECODE(OMP.flag, 'C', 'UNDER PROCESS', 'D','DEFERRED','T','TRANSMITTED TO OTHER DEPARTMENT', 'A','SANCTIONED'), "
				  + " OMPWT.memo_no, TO_CHAR(OMPWT.for_sub_date,'dd/mm/yyyy'),"
				  + " OMPWT.subject, NVL(OMPWT.ref,''), "
				  + " OMPWT.content, OMPWT.action_type "
				  + " FROM rws_om_proposal_tbl OMP,"
				  + " rws_om_proposal_workflow_tbl OMPWT, "
				  + " rws_asset_mast_tbl AM WHERE  "
				  + " (OMP.om_proposal_id = OMPWT.om_proposal_id) "
				  + " AND OMP.asset_code = AM.asset_code " 
				  + " AND OMPWT.action_to = '" + officeCode + "'";
			
			Debug.println("Received Proposals " + query);
			rset = stat.executeQuery(query);
			receivedProposals = new ArrayList();
			
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				actionTo = rset.getString(1);
				proposalId = rset.getString(2);
				proposalDTO.setOfficeCode(actionTo);
				
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(actionTo, true));
				proposalDTO.setProposalId(proposalId);
				proposalDTO.setFinancialYear(rset.getString(3));
				proposalDTO.setAssetCode(rset.getString(4));
				proposalDTO.setAssetName(rset.getString(5));
				proposalDTO.setEstimateCost(rset.getString(6));
				proposalDTO.setSanctionedAmount(rset.getString(7));
				proposalDTO.setProposalDate(rset.getString(8));
				proposalDTO.setStatus(rset.getString(9));
				proposalDTO.setMemoNo(rset.getString(10));
				proposalDTO.setSubmitDate(rset.getString(11));
				proposalDTO.setSubmitSubject(rset.getString(12));
				proposalDTO.setSubmitRef(rset.getString(13));
				content = rset.getString(14);
				content = content.replaceAll("\\n","");
				content = content.replaceAll("\\r","<br>");
				proposalDTO.setSubmitContent(content);
				proposalDTO.setFlag(rset.getString(15));
								
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
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				
				receivedProposals.add(proposalDTO);
			}
			
			proposalList.add(receivedProposals);
			
		}
		catch(Exception e)
		{	Debug.writeln("Exception in listOMProposals : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		
		return proposalList;
	}

// --------------------------------------------------------------------------------------------------

	
	public ProposalDTO getOMProposal(String omProposalId)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		
		query = " SELECT OMP.office_code, OMP.om_proposal_id, OMP.asset_code,"
			  + " AM.asset_name, OMP.financial_year, "
			  + " OMP.estimate_cost, OMP.sanctioned_amount,"
			  + " NVL(OMP.remarks,'') "
			  + " FROM rws_om_proposal_tbl OMP, rws_asset_mast_tbl AM "
			  + " WHERE	OMP.asset_code = AM.asset_code "
			  + " AND OMP.om_proposal_id = '" + omProposalId + "'";
		
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				proposalDTO = new ProposalDTO();
				proposalDTO.setProposalId(rset.getString(2));
				proposalDTO.setAssetCode(rset.getString(3));
				proposalDTO.setAssetName(rset.getString(4));
				proposalDTO.setFinancialYear(rset.getString(5));
				proposalDTO.setEstimateCost(rset.getString(6));
				proposalDTO.setSanctionedAmount(rset.getString(7));
				proposalDTO.setRemarks(rset.getString(8));
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMProposal : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return proposalDTO;
	}
	
	public ArrayList getOMProposalProgrammes(String omProposalId)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		ArrayList programmeSubprogrammes = null;
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			query = " SELECT programme_code, subprogramme_code FROM "
				  + " rws_om_proposal_tbl OMP, rws_om_proposal_prog_lnk_tbl PL "
				  + " WHERE OMP.om_proposal_id = PL.om_proposal_id "
				  + " AND PL.om_proposal_id = '" + omProposalId + "'";
			rset = stat.executeQuery(query);
			ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
			programmeSubprogrammes = new ArrayList();
			while(rset.next())
			{
				programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
				programmeSubProgrammeBean.setProgrammeCode(rset.getString(1));
				programmeSubProgrammeBean.setSubprogrammeCode(rset.getString(2));
				programmeSubprogrammes.add(programmeSubProgrammeBean); 
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMProposalProgrammes : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return programmeSubprogrammes;
	}
	
	public boolean editOMProposal(ProposalDTO proposalDTO, String[] programmeCodes)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		String officeCode = proposalDTO.getOfficeCode();
		String omProposalId = proposalDTO.getProposalId();
		Debug.println("DAO Test1");
								
		try
		{
			Debug.println("DAO Test2");
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			Debug.println("DAO Test3");
			query = " UPDATE rws_om_proposal_tbl SET "
				  + " estimate_cost = '" + proposalDTO.getEstimateCost() + "', "
				  + " financial_year = '" + proposalDTO.getFinancialYear() + "', "
				  + " remarks = '" + proposalDTO.getRemarks() + "'"
				  + " WHERE om_proposal_id = '" + omProposalId + "'";
			stat.addBatch(query);
			Debug.println("DAO Test4");
			Debug.println("query1:"+query);
			query = " DELETE FROM rws_om_proposal_prog_lnk_tbl "
				  + " WHERE om_proposal_id='" + omProposalId + "'";
			Debug.println("DAO Test5");
			Debug.println("query2:"+query);
			stat.addBatch(query);
			String programmeCode = "";
			String subprogrammeCode = null;
			int index = 0;
			Debug.println("DAO Test6");
			int programmeLength = programmeCodes.length;
			Debug.println("DAO Test6A");
			for(int j=0; j<programmeLength; j++)
			{
				Debug.println("DAO Test7");
				programmeCode = programmeCodes[j];
				subprogrammeCode = "";
				index = programmeCode.indexOf("_");
				if(index != -1)
				{	Debug.println("DAO Test8");
					programmeCode = programmeCode.substring(0,index);
					subprogrammeCode = programmeCodes[j].substring(index+1,programmeCodes[j].length());
				}
				Debug.println("DAO Test9");
				query = " INSERT INTO rws_om_proposal_prog_lnk_tbl "
					  + " VALUES('" + omProposalId + "', "
					  + " '" + programmeCode + "', '" + subprogrammeCode + "')";
				Debug.println("DAO Test10");
				Debug.println("query3:"+query);
				stat.addBatch(query);
			}
			Debug.println("DAO Test11");
			flag = true;
			int[] updateCounts = stat.executeBatch();
			Debug.println("updateCounts.length="+updateCounts.length);
			for(int i=0; i<updateCounts.length; i++)
			{
				Debug.println("DAO Test12");
				if(updateCounts[i] == 0)
				{
					//flag = false;
					Debug.println("value of updateCounts["+i+"]==0 and flag=false");
				}
				
			}
			if(flag)
				conn.commit();

			conn.setAutoCommit(true);
			Debug.println("DAO Test13");
		}
		catch(Exception e)
		{	Debug.writeln("Exception in editOMProposal : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return flag;
	}
	
	public boolean editOMAdminProposal(ProposalDTO proposalDTO, String[] programmeCodes)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		String officeCode = proposalDTO.getOfficeCode();
		String omProposalId = proposalDTO.getProposalId();
		
		try
		{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
							
			query = " UPDATE rws_om_proposal_tbl SET "
				  + " estimate_cost = '" + proposalDTO.getEstimateCost() + "', "
				  + " sanctioned_amount = '" + proposalDTO.getSanctionedAmount() + "', "
				  + " financial_year = '" + proposalDTO.getFinancialYear() + "', "
				  + " remarks = '" + proposalDTO.getRemarks() + "'"
				  + " WHERE om_proposal_id = '" + omProposalId + "'";
			stat.addBatch(query);
			
			query = " DELETE FROM rws_om_proposal_prog_lnk_tbl "
				  + " WHERE om_proposal_id='" + omProposalId + "'";
			stat.addBatch(query);
			String programmeCode = "";
			String subprogrammeCode = null;
			int index = 0;
			int programmeLength = programmeCodes.length;
			for(int j=0; j<programmeLength; j++)
			{
				programmeCode = programmeCodes[j];
				subprogrammeCode = "";
				index = programmeCode.indexOf("_");
				if(index != -1)
				{	
					programmeCode = programmeCode.substring(0,index);
					subprogrammeCode = programmeCodes[j].substring(index+1,programmeCodes[j].length());
				}
				
				query = " INSERT INTO rws_om_proposal_prog_lnk_tbl "
					  + " VALUES('" + omProposalId + "', "
					  + " '" + programmeCode + "', '" + subprogrammeCode + "')";
				
				stat.addBatch(query);
			}
			
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
		{	Debug.writeln("Exception in editOMAdminProposal : \n" + e);			
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

		return flag;
	}
	
	
	public ArrayList getOMProposalTracking(String omProposalId)
	{
		Debug.println("getOMProposalTracking() called.");
		Connection conn = null;
		Statement stat = null, stat1 = null;
		ResultSet rset = null, rset1 = null;
		ArrayList proposalTracks = new ArrayList();
		ArrayList consideredTracks = new ArrayList();
		ArrayList actualTracks = new ArrayList();
		ArrayList sanctionedTracks = new ArrayList();

		ArrayList programmes = null;
		ProposalDTO proposalDTO = null;		
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();	
			/* Query for selecting proposal track in which it has been considered */
			query = " SELECT M.office_code, M.asset_code, A.asset_name, M.financial_year,"
				  + " M.estimate_cost, P.user_id, D.designation_acr, "
				  + " TO_CHAR(M.prepared_on, 'dd/mm/yyyy'), M.remarks, NVL(M.no_of_habs, 0)  "
				  + " FROM rws_om_proposal_mirror_tbl M, rws_asset_mast_tbl A, "
				  + " rws_password_tbl P, rws_designation_tbl D " 
				  + " WHERE M.asset_code = A.asset_code "
				  + " AND M.prepared_by = P.user_id " 
				  + " AND P.designation_code = D.designation_code "
				  + " AND M.track_no = 0 "
				  + " AND M.om_proposal_id = '" + omProposalId + "'";
			
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				proposalDTO.setProposalId(omProposalId);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(rset.getString(1), true));
				proposalDTO.setAssetCode(rset.getString(2));
				proposalDTO.setAssetName(rset.getString(3));
				proposalDTO.setFinancialYear(rset.getString(4));
				proposalDTO.setEstimateCost(rset.getString(5));
				proposalDTO.setUserId(rset.getString(6) + ", " +rset.getString(7));
				proposalDTO.setProposalDate(rset.getString(8));
				proposalDTO.setRemarks(rset.getString(9));
				proposalDTO.setNoOfHabs(rset.getString(10));
				
				query = " SELECT NVL(P.programme_name,''), " 
					  + " NVL(SP.subprogramme_name,'') FROM "
					  + " rws_om_proposal_tbl OMP, rws_om_proposal_prog_lnk_tbl PP,"
					  + " rws_programme_tbl P,  rws_subprogramme_tbl SP "
					  + " WHERE OMP.om_proposal_id = PP.om_proposal_id "
					  + " AND PP.programme_code = P.programme_code "
					  + " AND PP.programme_code = SP.programme_code(+) "
					  + " AND PP.subprogramme_code = SP.subprogramme_code(+) "
					  + " AND OMP.om_proposal_id = '" + omProposalId + "'";
				rset1 = stat1.executeQuery(query);
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				consideredTracks.add(proposalDTO);
			}
						
			proposalTracks.add(consideredTracks);
			/* Query for proposal tracks after consideration but before sanction */
			query = " SELECT M.office_code, M.asset_code, A.asset_name, "
				  + " M.financial_year, M.estimate_cost, M.remarks, M.no_of_habs, "
				  + " M.sanctioned_amount, M.flag, M.admin_no, "
				  + " TO_CHAR(M.admin_date, 'dd/mm/yyyy'), M.go_no, "
				  + " DECODE(M.state_central,'S','STATE','C','CENTRE'), M.admn_sanc_auth, M.work_id, "
				  + " W.track_no, W.memo_no, TO_CHAR(W.for_sub_date, 'dd/mm/yyyy'), "
				  + " W.subject, NVL(W.ref,''), W.content, "
				  + " W.action_from, W.action_to, "
				  + " DECODE(W.action_type, 'S', 'SUBMITTED', 'F','FORWARDED', 'D', 'DEFERRED', 'T','TRANSMITTED TO OTHER DEPARTMENT'), "
				  + " TO_CHAR(W.action_date, 'dd/mm/yyyy'), "
				  + " P1.user_id, D1.designation_acr, "
				  + " P2.user_id, D2.designation_acr "
				  + " FROM rws_om_proposal_workflow_tbl W, rws_om_proposal_mirror_tbl M, "
				  + " rws_asset_mast_tbl A, "
				  + " rws_password_tbl P1, rws_password_tbl P2, "
				  + " rws_designation_tbl D1, rws_designation_tbl D2 "
				  + " WHERE M.om_proposal_id = W.om_proposal_id "
				  + " AND M.asset_code = A.asset_code "
				  + " AND (W.sent_by = P1.user_id "
				  + "      AND P1.designation_code = D1.designation_code) "
				  + " AND (W.sent_to = P2.user_id "
				  + "      AND P2.designation_code = D2.designation_code) "
				  + " AND M.track_no = W.track_no "
				  + " AND M.om_proposal_id = '" + omProposalId + "'"
				  + " ORDER BY M.track_no ";
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{	
				proposalDTO = new ProposalDTO();
				
				proposalDTO.setProposalId(omProposalId);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(rset.getString(1), true));
				proposalDTO.setAssetCode(rset.getString(2));
				proposalDTO.setAssetName(rset.getString(3));
				proposalDTO.setFinancialYear(rset.getString(4));
				proposalDTO.setEstimateCost(rset.getString(5));
				proposalDTO.setRemarks(rset.getString(6));
				proposalDTO.setNoOfHabs(rset.getString(7));
				proposalDTO.setSanctionedAmount(rset.getString(8));
				proposalDTO.setFlag(rset.getString(9));
				proposalDTO.setAdminNo(rset.getString(10));
				proposalDTO.setAdminDate(rset.getString(11));
				proposalDTO.setGoNo(rset.getString(12));
				proposalDTO.setSanctionedAt(rset.getString(13));
				proposalDTO.setSanctioningAuthority(rset.getString(14));
				proposalDTO.setWorkId(rset.getString(15));
				proposalDTO.setTrackNo(rset.getString(16));
				proposalDTO.setLetterNo(rset.getString(17));
				proposalDTO.setSubmitDate(rset.getString(18));
				proposalDTO.setSubmitSubject(rset.getString(19));
				proposalDTO.setSubmitRef(rset.getString(20));
				proposalDTO.setSubmitContent(rset.getString(21));
				proposalDTO.setActionFrom(rwsOffices.getOfficeName(rset.getString(22), true));
				proposalDTO.setActionTo(rwsOffices.getOfficeName(rset.getString(23), true));
				proposalDTO.setActionType(rset.getString(24));
				proposalDTO.setActionDate(rset.getString(25));
				proposalDTO.setSentBy(rset.getString(26) + ", " + rset.getString(27));
				proposalDTO.setSentTo(rset.getString(28) + ", " + rset.getString(29));
				
				query = " SELECT NVL(P.programme_name,''), " 
					  + " NVL(SP.subprogramme_name,'') FROM "
					  + " rws_om_proposal_tbl OMP, rws_om_proposal_prog_lnk_tbl PP,"
					  + " rws_programme_tbl P,  rws_subprogramme_tbl SP "
					  + " WHERE OMP.om_proposal_id = PP.om_proposal_id "
					  + " AND PP.programme_code = P.programme_code "
					  + " AND PP.programme_code = SP.programme_code(+) "
					  + " AND PP.subprogramme_code = SP.subprogramme_code(+) "
					  + " AND OMP.om_proposal_id = '" + omProposalId + "'";
				rset1 = stat1.executeQuery(query);
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				
				actualTracks.add(proposalDTO);
			}
			proposalTracks.add(actualTracks);


			/* Query for selecting proposal track in which it has been sanctioned */
			query = " SELECT M.modi_office_code, M.financial_year, M.estimate_cost,"
				  + " M.sanctioned_amount, M.admin_no, TO_CHAR(M.admin_date, 'dd/mm/yyyy'), "
				  + " go_no, NVL(DECODE(state_central, 'S', 'STATE', 'C', 'CENTRE'),' '), "
				  + " NVL(admn_sanc_auth, ' '), M.work_id, P.user_id, D.designation_acr, " 
				  + " M.remarks, NVL(M.no_of_habs, 0)  "
				  + " FROM rws_om_proposal_mirror_tbl M, rws_password_tbl P, rws_designation_tbl D " 
				  + " WHERE M.prepared_by = P.user_id " 
				  + " AND P.designation_code = D.designation_code "
				  + " AND M.track_no = 99 AND M.om_proposal_id = '" + omProposalId + "'";
			
			rset = stat.executeQuery(query);
			if(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				proposalDTO.setProposalId(omProposalId);
				proposalDTO.setOfficeName(rwsOffices.getOfficeName(rset.getString(1), true));
				proposalDTO.setFinancialYear(rset.getString(2));
				proposalDTO.setEstimateCost(rset.getString(3));
				proposalDTO.setSanctionedAmount(rset.getString(4));
				proposalDTO.setAdminNo(rset.getString(5));
				proposalDTO.setAdminDate(rset.getString(6));
				proposalDTO.setGoNo(rset.getString(7));
				proposalDTO.setSanctionedAt(rset.getString(8));
				proposalDTO.setSanctioningAuthority(rset.getString(9));
				proposalDTO.setWorkId(rset.getString(10));
				proposalDTO.setUserId(rset.getString(11) + ", " +rset.getString(12));
				proposalDTO.setRemarks(rset.getString(13));
				proposalDTO.setNoOfHabs(rset.getString(14));
				
				query = " SELECT NVL(P.programme_name,''), " 
					  + " NVL(SP.subprogramme_name,'') FROM "
					  + " rws_om_proposal_mirror_tbl OMP, rws_om_proposal_prog_lnk_tbl PP,"
					  + " rws_programme_tbl P,  rws_subprogramme_tbl SP "
					  + " WHERE OMP.om_proposal_id = PP.om_proposal_id "
					  + " AND PP.programme_code = P.programme_code "
					  + " AND PP.programme_code = SP.programme_code(+) "
					  + " AND PP.subprogramme_code = SP.subprogramme_code(+) "
					  + " AND OMP.om_proposal_id = '" + omProposalId + "'";
				rset1 = stat1.executeQuery(query);
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				sanctionedTracks.add(proposalDTO);
			}

			proposalTracks.add(sanctionedTracks);
		}
		catch(Exception e)
		{
			Debug.println("O&M Proposal Tracking: \n " + e.getMessage());
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return proposalTracks;
	}
	
	
	public ArrayList getRepView(String officeCode){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		try{
			conn = getConn();			
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
				  + " AND RP.office_code = ? "
				  + " AND RP.flag = 'N' "
				  + " ORDER BY proposal_date ";				 
			stat = conn.prepareStatement(query);
			stat.setString(1, officeCode);
			rset = stat.executeQuery();
			representativeProposals = new ArrayList();			
			while(rset.next()){
				proposalDTO = new ProposalDTO();
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
		catch(Exception e){
			Debug.writeln("The Exception is in ProposalDAO getRepView : \n" + e.getMessage());		
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO getRepView finally : \n" + sqle.getMessage());
			}
		}
		return representativeProposals;
	}
	

	public boolean siteIdentification(String[] proposalIds, String officeCode)
	{
		Connection conn = null;
		Statement stat = null;
		
		try
		{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			
			String circleOfficeCode = officeCode.substring(1,3);
			String divisionOfficeCode = officeCode.substring(3,4);
			String subdivisionOfficeCode = officeCode.substring(4,6);

			for(int i=0; i<proposalIds.length; i++)
			{
				//query modified by removing divisionofficecode and suddivisionofficecode
				//on 050407
				/*
				query = " INSERT INTO rws_source_iden_fin_tbl(circle_office_code, division_office_code, "
					  + " subdivision_office_code, work_id) "
					  + " (SELECT '" + circleOfficeCode + "', '" + divisionOfficeCode + "', "
					  + " '" + subdivisionOfficeCode + "', work_id " 
					  + " FROM rws_work_proposal_tbl "
					  + " WHERE proposal_id ='" + proposalIds[i] + "')";*/
				
				query = " INSERT INTO rws_source_iden_fin_tbl( "
					  + "  work_id,TYPE_OF_ASSET_CODE ) "
					  + " (SELECT "
					  + " work_id,TYPE_OF_ASSET  " 
					  + " FROM rws_work_proposal_tbl "
					  + " WHERE proposal_id ='" + proposalIds[i] + "')";
					  
				stat.addBatch(query);
			}
			
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
		catch(SQLException sqle)
		{
			Debug.writeln("SQL Exception in siteIdentification :\n" + sqle);
			flag = false;
			Debug.println("sqle.getErrorCode() " + sqle.getErrorCode());
			if(sqle.getErrorCode() == 1)
				errorMessage = "Proposal already sent to site identification.";
		}
		catch(Exception e)
		{	Debug.writeln("Exception in siteIdentification :\n" + e);
			flag = false;
		}
		finally
		{	if(stat != null)
			{	try
				{	stat.close();
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
		
		return flag;
	}

	public boolean updateNewProposal(ProposalDTO proposalDTO, String[] habCodes, String type)
	{
		Connection conn = null;
		Statement stat = null;

		try
		{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			String proposalId = proposalDTO.getProposalId();
			
			int habCount =0;
			if(habCodes != null && habCodes.length > 0)
			{
				query = " DELETE FROM rws_proposal_hab_lnk_tbl "
					  + " WHERE proposal_id='" + proposalId + "'"; 
				Debug.println("query 2 " + query);
				stat.addBatch(query);
				
				for(int i =0; i<habCodes.length; i++)
				{	habCount++;
					query = " INSERT INTO rws_proposal_hab_lnk_tbl(proposal_id, hab_code) "
						  + " VALUES('" + proposalId + "', '" + habCodes[i] + "')";
					Debug.println("query 3 " + query);
					stat.addBatch(query);
				}
				
			}
			
			if(type.equals("ord"))
			{
				query = " UPDATE rws_work_proposal_tbl "
					  + " SET proposal_name = '" + proposalDTO.getProposalName() + "', "  
					  + " programme_code = '" + proposalDTO.getProgrammeCode() + "', "
					  + " subprogramme_code = '" + proposalDTO.getSubprogrammeCode() + "',"
					  + " no_of_habs =" + habCount + ", "
					  + " estimate_cost =" + proposalDTO.getEstimateCost() + ", "
					  + " type_of_asset ='" + proposalDTO.getTypeOfAsset() + "', "
					  + " priority_code ='" + proposalDTO.getPriorityCode() + "', "
					  + " sanc_office='" + proposalDTO.getSanctionLevel() + "'"
					  + " WHERE proposal_id = '" + proposalId + "'";
				stat.addBatch(query);
				Debug.println("query is:"+query);
			}
			else
			if(type.equals("adm"))
			{
				query = " UPDATE rws_work_proposal_tbl "
					  + " SET proposal_name = '" + proposalDTO.getProposalName() + "', "  
					  + " no_of_habs =" + habCount + ", "
					  + " programme_code = '" + proposalDTO.getProgrammeCode() + "', "
					  + " subprogramme_code = '" + proposalDTO.getSubprogrammeCode() + "',"
					  + " priority_code ='" + proposalDTO.getPriorityCode() + "', "
					  + " estimate_cost =" + proposalDTO.getEstimateCost() + ", "
					  + " sanction_amount =" + proposalDTO.getSanctionedAmount() + ", "
					  + " type_of_asset ='" + proposalDTO.getTypeOfAsset() + "' ";
					if(proposalDTO.getPhased().equals("Y"))
					{
						query += ", phased='" + proposalDTO.getPhased() + "', "
						      +  " phase_no = '" + proposalDTO.getPhaseNo() + "' ";
					}

				query += " WHERE proposal_id = '" + proposalId + "'";
				Debug.println("proposal query is " + query);
				stat.addBatch(query);

				if(proposalDTO.getPhased().equals("Y"))
				{
					query = " INSERT INTO rws_proposal_phase_tbl VALUES(" 
						  + " '" + proposalDTO.getProposalId() + "', "
						  + " '" + proposalDTO.getPhaseNo() + "', "
						  + " '') ";
					Debug.println("phase query is " + query);
					stat.addBatch(query);
				}
				
				String centralShare = proposalDTO.getCentralShare();
				String stateShare = proposalDTO.getStateShare();
				String publicContribution = proposalDTO.getPublicContribution();
				String gpShare = proposalDTO.getGpShare();
				String others = proposalDTO.getOthers();

				if(!centralShare.equals("") || !stateShare.equals("") || !gpShare.equals("") ||
					 !publicContribution.equals("") || !others.equals(""))
				{
					query = " INSERT INTO rws_proposal_share_tbl VALUES(" 
						  + " '" + proposalDTO.getProposalId() + "', "
						  + " '" + proposalDTO.getCentralShare() + "', "
						  + " '" + proposalDTO.getStateShare() + "', "
						  + " '" + proposalDTO.getGpShare() + "', "
						  + " '" + proposalDTO.getPublicContribution() + "', "
						  + " '" + proposalDTO.getOthers() + "') ";
					Debug.println("share query is " + query);
					stat.addBatch(query);
				}

			}
			
			flag = true;
			int[] updateCounts = stat.executeBatch();
			for(int i=0; i<updateCounts.length; i++)
			{
				Debug.println("updateCounts["+i+"] == " + updateCounts[i]);
				if(updateCounts[i] == 0)
					flag = false;
			}
			if(flag)
				conn.commit();

			conn.setAutoCommit(true);
		}
		catch(Exception e)
		{	Debug.writeln("Exception in updateNewProposal :\n" + e);			
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

	public boolean updateRepProposal(ProposalDTO proposalDTO, String[] habCodes) 
	{
		Connection conn = null;
		Statement stat = null;

		try
		{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			String proposalId = proposalDTO.getProposalId();
			query = " INSERT INTO rws_work_proposal_mirror_tbl(office_code, no_of_habs, "
				  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
				  + " estimate_cost, prepared_by, prepared_on, state_central, "
				  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
				  + " goms_no, admin_sanc_auth, sanction_amount ) "
				  + " (SELECT office_code, no_of_habs, "
				  + " proposal_id, proposal_name, programme_code, subprogramme_code, "
				  + " estimate_cost, prepared_by, prepared_on, state_central, "
				  + " work_id, remarks, flag, priority_code, type_of_asset, admin_no, admin_date,"
				  + " goms_no, admin_sanc_auth, sanction_amount "
				  + " FROM rws_work_proposal_tbl "
				  + " WHERE proposal_id = '" + proposalId + "')";
			
			stat.addBatch(query);

			if(habCodes != null && habCodes.length > 0)
			{
				query = " INSERT INTO rws_proposal_hl_mirror_tbl "
					  + " (SELECT * FROM rws_proposal_hab_lnk_tbl "
					  + " WHERE proposal_id='" + proposalId + "')"; 
				
				stat.addBatch(query);
				
				query = " DELETE FROM rws_proposal_hab_lnk_tbl "
					  + " WHERE proposal_id='" + proposalId + "'"; 
				
				stat.addBatch(query);
				
				for(int i =0; i<habCodes.length; i++)
				{	
					query = " INSERT INTO rws_proposal_hab_lnk_tbl(proposal_id, habcode) "
						  + " VALUES('" + proposalId + "', '" + habCodes[i] + "')"; 
					stat.addBatch(query);
				}
			}
			
			query = " UPDATE rws_work_proposal_tbl "
				  + " SET proposal_name = '" + proposalDTO.getProposalName() + "', "  
				  + " programme_code = '" + proposalDTO.getProgrammeCode() + "', "
				  + " subprogramme_code = '" + proposalDTO.getSubprogrammeCode() + "',"
				  + " no_of_habs =" + proposalDTO.getNoOfHabs() + ", "
				  + " estimate_cost =" + proposalDTO.getEstimateCost() + ", "
				  + " type_of_asset ='" + proposalDTO.getTypeOfAsset() + "', "
				  + " priority_code ='" + proposalDTO.getPriorityCode() + "' "
				  + " WHERE proposal_id = '" + proposalId + "'";
			
			stat.addBatch(query);

			stat.executeBatch();
		}
		catch(Exception e)
		{	Debug.writeln("Exception in updateRepProposal :\n" + e);			
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


	
	public ArrayList getSelectedHabitations(String proposalId){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		ArrayList habs = new ArrayList();
		try	{
			query = " SELECT PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD, rws_proposal_hab_lnk_tbl HL "
				  + " WHERE PR.panch_code = HL.hab_code "
				  + " AND PR.panch_code = HD.hab_code "
				  + " AND HL.proposal_id = ? ";			
			conn = getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, proposalId);
			rset = stat.executeQuery();			
			RwsLocationBean rwsLocationBean = null;
			while(rset.next()){
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setHabCode(rset.getString(1));
				rwsLocationBean.setHabName(rset.getString(2));
				rwsLocationBean.setPopulation(rset.getString(3));
				rwsLocationBean.setStatus(rset.getString(4));
				habs.add(rwsLocationBean);
			}
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getSelectedHabitations :\n" + e.getMessage());			
		}
		finally	{	
			try{
				if(rset != null){	
					rset.close();
				}
				if(stat != null){	
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO getSelectedHabitations finally :\n" + sqle.getMessage());
			}
		}
		return habs;
	}
	
	public ProposalDTO getProposalDetails(String proposalId)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;

		try
		{
			query = " SELECT office_code, proposal_id, proposal_name, no_of_habs, "
				  + " programme_code, subprogramme_code, type_of_asset, priority_code, "
				  + " estimate_cost, sanction_amount, phased, phase_no, sanc_office "
				  + " FROM rws_work_proposal_tbl WHERE proposal_id = '" + proposalId + "'";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			proposalDTO = new ProposalDTO();
			
			
			while(rset.next())
			{
				proposalDTO.setOfficeCode(rset.getString(1));
				proposalDTO.setProposalId(rset.getString(2));
				proposalDTO.setProposalName(rset.getString(3));
				proposalDTO.setNoOfHabs(rset.getString(4));
				proposalDTO.setProgrammeCode(rset.getString(5));
				proposalDTO.setSubprogrammeCode(rset.getString(6));
				proposalDTO.setTypeOfAsset(rset.getString(7));
				proposalDTO.setPriorityCode(rset.getString(8));
				proposalDTO.setEstimateCost(rset.getString(9));
				proposalDTO.setSanctionedAmount(rset.getString(10));
				proposalDTO.setPhased(rset.getString(11));
				proposalDTO.setPhaseNo(rset.getString(12));
				proposalDTO.setSanctionLevel(rset.getString(13));
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getProposalDetails :\n" + e);			
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
				
		return proposalDTO;
	}
	
	public boolean deleteRepProposal(String proposalId){
		Connection conn = null;
		Statement stat = null;
		try	{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();			
			query = " DELETE FROM rws_proposal_hab_lnk_tbl WHERE proposal_id = '" + proposalId + "'"; 
			stat.addBatch(query);			
			query = " DELETE FROM rws_rep_proposal_tbl WHERE proposal_id = '" + proposalId + "'"; 
			stat.addBatch(query);
			flag = true;
			int[] updateCounts = stat.executeBatch();
			for(int i=0; i<updateCounts.length; i++){
				if(updateCounts[i] == 0)
					flag = false;
			}
			if(flag)
				conn.commit();
			conn.setAutoCommit(true);
		}
		catch(Exception e){	
			Debug.println("The Exception is in ProposalDAO  deleteRepProposal : "+e.getMessage());
		}
		finally{	
			try{
				if(stat != null){	
					stat.close();
				}
				if(conn != null){	
					conn.close();			
				}
			}
			catch(SQLException sqle){ 
				Debug.println("The Exception is in ProposalDAO deleteRepProposal finally : "+sqle.getMessage());
			}
		}
		return flag;
	}

	public ProposalDTO getOtherDetails(String proposalId)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		try
		{
			query = " SELECT UPPER(C.constituency_name), UPPER(R.rep_name), UPPER(P.rep_name), "
				  + " UPPER(NVL(P.rep_address,'<span class=notAvailable>NOT MENTIONED</span>')), "
				  + " TO_CHAR(rep_date,'dd/mm/yyyy'), "
				  + " UPPER(NVL(P.endorsed_by,'<span class=notAvailable>NOT MENTIONED</span>')), "
				  + " NVL(P.endorsement_no,'<span class=notAvailable>NOT MENTIONED</span>'), "
				  + " NVL(TO_CHAR(P.endorsement_date,'dd/mm/yyyy'),'"
				  + " <span class=notAvailable>NOT MENTIONED</span>'), "
				  + " NVL(P.recommendations,'<span class=notAvailable>NOT MENTIONED</span>'), "
				  + " NVL(PR.priority_description,'<span class=notAvailable>NOT MENTIONED</span>'), "
				  + " NVL(P.description,'<span class=notAvailable>NOT MENTIONED</span>'), "
				  + " NVL(P.remarks, '<span class=notAvailable>NOT MENTIONED</span>')"
				  + " FROM rws_rep_proposal_tbl P, rws_public_rep_tbl R, rws_priority_tbl PR,"
				  + " rws_constituency_tbl C"
				  + " WHERE P.proposal_id='" + proposalId + "' AND (P.rep_code = R.rep_code) "
				  + " AND P.priority_code = PR.priority_code (+) "
				  + " AND (substr(P.lead_hab_code,3,3) = C.constituency_code AND C.rep_code='01')";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			proposalDTO = new ProposalDTO();		
			
			if(rset.next())
			{	
				proposalDTO.setConstituencyName(rset.getString(1));
				proposalDTO.setRepCode(rset.getString(2));
				proposalDTO.setRepName(rset.getString(3));
				proposalDTO.setRepAddress(rset.getString(4));
				proposalDTO.setRepDate(rset.getString(5));
				proposalDTO.setEndorsedBy(rset.getString(6));
				proposalDTO.setEndorsementNo(rset.getString(7));
				proposalDTO.setEndorsementDate(rset.getString(8));
				proposalDTO.setRecommendations(rset.getString(9));
				proposalDTO.setPriorityCode(rset.getString(10));
				proposalDTO.setDescription(rset.getString(11));
				proposalDTO.setRemarks(rset.getString(12));
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOtherDetails :\n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		
		return proposalDTO;
	}
	
	public ProposalDTO getRepEditData(String proposalId)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		try
		{
			query = " SELECT rep_code, NVL(UPPER(rep_name),''), NVL(UPPER(rep_address),''), "
				  + " TO_CHAR(rep_date,'dd/mm/yyyy'), NVL(UPPER(endorsed_by),''), "
				  + " NVL(UPPER(endorsement_no),''), NVL(TO_CHAR(endorsement_date,'dd/mm/yyyy'),''), "
				  + " recommendations, UPPER(proposal_name), proposal_id, no_of_habs, programme_code, "
				  + " subprogramme_code, priority_code, type_of_asset, estimate_cost, "
				  + " UPPER(remarks), NVL(UPPER(description),''), "
				  + " lead_hab_code, minister_for, others, constituency_code "
				  + " FROM rws_rep_proposal_tbl "
				  + " WHERE UPPER(flag)='N' AND proposal_id = '" + proposalId + "'";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			proposalDTO = new ProposalDTO();
			if(rset.next())
			{
				proposalDTO.setRepCode(rset.getString(1));
				proposalDTO.setRepName(rset.getString(2));
				proposalDTO.setRepAddress(rset.getString(3));
				proposalDTO.setRepDate(rset.getString(4));
				proposalDTO.setEndorsedBy(rset.getString(5));
				proposalDTO.setEndorsementNo(rset.getString(6));
				proposalDTO.setEndorsementDate(rset.getString(7));
				proposalDTO.setRecommendations(rset.getString(8));
				proposalDTO.setProposalName(rset.getString(9));
				proposalDTO.setProposalId(rset.getString(10));
				proposalDTO.setNoOfHabs(rset.getString(11));
				proposalDTO.setProgrammeCode(rset.getString(12));
				proposalDTO.setSubprogrammeCode(rset.getString(13));
				proposalDTO.setPriorityCode(rset.getString(14));
				proposalDTO.setTypeOfAsset(rset.getString(15));
				proposalDTO.setEstimateCost(rset.getString(16));
				proposalDTO.setRemarks(rset.getString(17));
				proposalDTO.setDescription(rset.getString(18));
				proposalDTO.setLeadHabitation(rset.getString(19));
				proposalDTO.setMinisterFor(rset.getString(20));
				proposalDTO.setOthers(rset.getString(21));
				proposalDTO.setConstituencyCode(rset.getString(22));
				
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getRepEditData :\n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return proposalDTO;

	}
	
	public ArrayList getProposalYears() 
	{
		ArrayList years = new ArrayList();
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		LabelValueBean labelValueBean = null;
		try
		{
			query = " SELECT DISTINCT SUBSTR(proposal_id, 3, 4) FROM "
				  + " rws_work_proposal_tbl ";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			String year = null;
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				year = rset.getString(1);
				labelValueBean.setValue(year);
				labelValueBean.setLabel(year);
				years.add(labelValueBean);
			}
			
		}
		catch(Exception e)
		{
			Debug.println("Exception in getProposalYears " + e);
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
		return years;
	}
	
	public ArrayList getOMProposalYears()
	{
		ArrayList years = new ArrayList();
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		LabelValueBean labelValueBean = null;
		try
		{
			query = " SELECT DISTINCT SUBSTR(om_proposal_id, 3, 4) FROM "
				  + " rws_om_proposal_tbl ";
			
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			String year = null;
			while(rset.next())
			{
				labelValueBean = new LabelValueBean();
				year = rset.getString(1);
				labelValueBean.setValue(year);
				labelValueBean.setLabel(year);
				years.add(labelValueBean);
			}
			
		}
		catch(Exception e)
		{
			Debug.println("Exception in getProposalYears " + e);
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
		return years;
	}
	
	public ProposalDTO getSanctionDetails(String proposalId, String type)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		
		if(type != null && type.equals("new"))
		{
			query = " SELECT WP.proposal_id, WP.no_of_habs, UPPER(C.constituency_name), " 
				  + " UPPER(R.rep_name), UPPER(RP.rep_name),  "
				  + " NVL(RP.rep_address,''), TO_CHAR(RP.rep_date,'dd/mm/yyyy'), "
				  + " NVL(RP.endorsed_by,''), NVL(RP.minister_for,''),"
				  + " NVL(RP.others,''), NVL(RP.endorsement_no,''),"
				  + " NVL(TO_CHAR(RP.endorsement_date,'dd/mm/yyyy'),''),"
				  + " NVL(RP.recommendations,''), NVL(PR.priority_description,''),"
				  + " NVL(RP.description,''), WP.estimate_cost,"
				  + " NVL(WP.admin_sanc_auth, ''), "
				  + " NVL(DECODE(WP.state_central,'S','STATE','C', 'CENTRE'),'') "
				  + " FROM rws_rep_proposal_tbl RP, rws_work_proposal_tbl WP, "
				  + " rws_public_rep_tbl R, rws_priority_tbl PR, "
				  + " rws_constituency_tbl C "
				  + " WHERE RP.proposal_id = WP.proposal_id AND " 
				  +	" WP.proposal_id='" + proposalId + "' AND (RP.rep_code = R.rep_code) "
				  + " AND WP.priority_code = PR.priority_code (+) "
				  + " AND (substr(RP.lead_hab_code,3,3) = C.constituency_code AND C.rep_code='01')";
		}
		else
		if(type != null && type.equals("om"))
		{
			query = " SELECT om_proposal_id, asset_code, financial_year, "
				  + " estimate_cost, admn_sanc_auth,  "
				  + " DECODE(state_central,'S','STATE', 'C', 'CENTRE') "
				  + " FROM rws_om_proposal_tbl WHERE "
				  + " om_proposal_id = '" + proposalId + "'";
		}

		try
		{
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				if(type.equals("new"))
				{
					proposalDTO.setProposalId(rset.getString(1));
					proposalDTO.setNoOfHabs(rset.getString(2));
					proposalDTO.setConstituencyName(rset.getString(3));
					proposalDTO.setRepCode(rset.getString(4));
					proposalDTO.setRepName(rset.getString(5));
					proposalDTO.setRepAddress(rset.getString(6));
					proposalDTO.setRepDate(rset.getString(7));
					proposalDTO.setEndorsedBy(rset.getString(8));
					proposalDTO.setMinisterFor(rset.getString(9));
					proposalDTO.setOthers(rset.getString(10));
					proposalDTO.setEndorsementNo(rset.getString(11));
					proposalDTO.setEndorsementDate(rset.getString(12));
					proposalDTO.setRecommendations(rset.getString(13));
					proposalDTO.setPriorityCode(rset.getString(14));
					proposalDTO.setDescription(rset.getString(15));
					proposalDTO.setEstimateCost(rset.getString(16));
					proposalDTO.setSanctioningAuthority(rset.getString(17));
					proposalDTO.setSanctionedAt(rset.getString(18));
				}
				else
				if(type.equals("om"))
				{
					proposalDTO.setProposalId(rset.getString(1));
					proposalDTO.setAssetCode(rset.getString(2));
					proposalDTO.setFinancialYear(rset.getString(3));
					proposalDTO.setEstimateCost(rset.getString(4));
					proposalDTO.setSanctioningAuthority(rset.getString(5));
					proposalDTO.setSanctionedAt(rset.getString(6));
				}
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getSanctionDetails :\n" + e);			
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
		return proposalDTO;
	}
	
	public String insertProgramme(String others) 
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		String programmeCode = "";
		query = " SELECT MAX(programme_code) FROM rws_programme_tbl ";
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			
			if(rset.next())
			{
				programmeCode = rset.getString(1);
				int sno = Integer.parseInt(programmeCode);
				Debug.println("SNo is " + sno);
				if(sno < 10)
					programmeCode = "0"+(sno+1);
				else
				if(sno < 100)
					programmeCode = String.valueOf(sno++);	
			}
			Debug.println("Programme Code " + programmeCode);
			
			query = " INSERT INTO rws_programme_tbl(programme_code, programme_name, "
				  + " programme_start_year, fresh_ongoing) VALUES(?,?,'2005-2006','F')";
			PreparedStatement ps =conn.prepareStatement(query);
			ps.setString(1,programmeCode);
			ps.setString(2,others);
			int ans = ps.executeUpdate();
						
		}
		catch(Exception e)
		{	Debug.writeln("Exception in insertProgramme :\n" + e);			
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
		return programmeCode;
	}
	
	
	public ArrayList getTempSelectedHabs()
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		ArrayList tempSelectedHabs = new ArrayList();
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			String query = " SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, " 
						 + " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
				         + " FROM rws_temp_proposal_hab_tbl T, rws_panchayat_raj_tbl P, " 
				         + " rws_habitation_directory_tbl D "
						 + " WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code "
						 + " ORDER BY T.proposal_id ";
						 
			Debug.println("Query is "+query);
			rset = stat.executeQuery(query);
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
		}
		catch(Exception e)
		{	Debug.println("Exception in getTempSelectedHabs()-- : " + e);
			
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
	
	
	public ArrayList getRevisedSelectedHabs(ArrayList selectedHabCodes,String workid){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		ArrayList tempSelectedHabs = new ArrayList();
		String code=workid.substring(6,8);
		String tabName="";
		String query ="";
		try	{
			conn = getConn();
			if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))){
				tabName="Revised_sanc_habs_tbl";
			}
			else if(code.equals("11")){
				tabName="Revised_sanc_schools_tbl";
			}
			else if(code.equals("12")){
				tabName="Revised_sanc_labs_tbl";
			}else if(code.equals("14")){
				tabName="Revised_sanc_pi_tbl";
			}
			else if(code.equals("13")){
				tabName="Revised_sanc_angan_tbl";
			}
			synchronized(this){				
				insertProposalTempHabsForAdmin2(selectedHabCodes,tabName,workid);				
				if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))){
					query= "SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, " 
						 + " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
				         + " FROM "+tabName+" T, rws_panchayat_raj_tbl P, " 
				         + " rws_habitation_directory_tbl D "
						 + " WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code "
						 + " ORDER BY P.panch_name ";
				}
				else if(code.equals("11")){
					query= "select proposal_id,a.school_code,school_name,a.hab_code,panch_name from "+tabName+" a,rws_school_master_tbl  b,rws_complete_hab_view  v  where  a.hab_code=b.hab_code and a.school_code=b.school_code and a.hab_code=v.panch_code and b.hab_code=v.panch_code ";
				}
				else if(code.equals("12")){
					query= "select distinct proposal_id,b.lab_code,lab_name,location from "+tabName+" a,rws_water_quality_lab_tbl b  where  a.lab_code=b.lab_code";
				}else if(code.equals("14")){
					query= "select proposal_id,a.PI_CODE,LOCATION,a.hab_code,panch_name from "+tabName+" a,IMIS_PUBLIC_INSTITUTIONS_TBL  b,rws_complete_hab_view  v  where  a.hab_code=b.habcode and a.school_code=b.school_code and a.hab_code=v.panch_code and b.habcode=v.panch_code ";
				}
				else if(code.equals("13")){
					//query= "select proposal_id,a.ANGANWADI_CODE,LOCATION,a.hab_code,panch_name from "+tabName+" a,IMIS_ANGANWADIES_TBL  b,rws_complete_hab_view  v  where  a.hab_code=b.habcode and a.school_code=b.school_code and a.hab_code=v.panch_code and b.habcode=v.panch_code ";
					
					query="select proposal_id,a.ANGANWADI_CODE,SCH_NAME,a.hab_code,panch_name from "+tabName+" a,IMIS_ANGANWADIES_TBL  b,rws_complete_hab_view  v  where  a.hab_code=b.habcode and a.ANGANWADI_code=b.school_ID and a.hab_code=v.panch_code and b.habcode=v.panch_code ";
				}
				stat = conn.prepareStatement(query);
				rset = stat.executeQuery();
				RwsLocationBean rwsLocationBean = null; 
				while(rset.next()){
					rwsLocationBean = new RwsLocationBean();
					if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))){
						rwsLocationBean.setProposalId(rset.getString(1));
						rwsLocationBean.setHabCode(rset.getString(2));
						rwsLocationBean.setHabName(rset.getString(3));
						rwsLocationBean.setStatus(rset.getString(4));
						rwsLocationBean.setPopulation(rset.getString(5));
					}
					else if(code.equals("11")){
			     	 	rwsLocationBean.setProposalId(rset.getString(1));
			     	 	rwsLocationBean.setHabCode(rset.getString(4));
				     	rwsLocationBean.setSchoolCode(rset.getString(2));
				     	rwsLocationBean.setSchoolName(rset.getString(3));
				     	rwsLocationBean.setHabName(rset.getString(5));
					}
					else if(code.equals("12")){
						rwsLocationBean.setProposalId(rset.getString(1));
				     	rwsLocationBean.setLabCode(rset.getString(2));
				     	rwsLocationBean.setLabName(rset.getString(3));
				     	rwsLocationBean.setLocation(rset.getString(4));
					}else if(code.equals("14")){
			     	 	rwsLocationBean.setProposalId(rset.getString(1));
			     	 	rwsLocationBean.setHabCode(rset.getString(4));
				     	rwsLocationBean.setPiCode(rset.getString(2));
				     	rwsLocationBean.setPiLocation(rset.getString(3));
				     	rwsLocationBean.setHabName(rset.getString(5));
					}
					tempSelectedHabs.add(rwsLocationBean);
				}
				if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))){
					query="DELETE FROM "+tabName;
				}
				else if(code.equals("11")){
					query="DELETE FROM "+tabName;
				}
				else if(code.equals("12")){
					query="DELETE FROM "+tabName;
				}else if(code.equals("14")){
					query="DELETE FROM "+tabName;
				}
				stat = conn.prepareStatement(query);
				stat.executeUpdate();
			}
		}
		catch(Exception e){	
			Debug.println("The Exception is in ProposalDAO getRevisedSelectedHabs : " + e.getMessage());		
		}
		finally	{
			try{
				if(rset != null){	
					rset.close();
				}
				if(stat != null) {	
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){	
				Debug.println("The Exception is in ProposalDAO getRevisedSelectedHabs : " + sqle.getMessage());	
			}
		}
		return tempSelectedHabs;
	}
	
	public ArrayList getTempSelectedHabs(String proposalId)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		ArrayList tempSelectedHabs = new ArrayList();
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			String query = " SELECT T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, " 
						 + " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
				         + " FROM rws_temp_proposal_hab_tbl T, rws_panchayat_raj_tbl P, " 
				         + " rws_habitation_directory_tbl D "
						 + " WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code "
						 + " AND T.proposal_id = '" + proposalId + "'";
						 						 
			rset = stat.executeQuery(query);
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
		}
		catch(Exception e)
		{	Debug.println("Exception in getTempSelectedHabs() : " + e);
			
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
	
	public int deleteTempSelectedHabs(String tablename){
		Connection conn = null;
		PreparedStatement stat = null;
		int updateCount = 0;		
		try	{
			conn = getConn();
			String query = " DELETE FROM  "+tablename; 			 
			boolean status=false;
			PreparedStatement stmt1=conn.prepareStatement("select * from tab where tname = ?");
			stmt1.setString(1, tablename.toUpperCase());
			ResultSet rs=stmt1.executeQuery();
			if(rs.next()){
				status=true;
			}
			if(status){
				stat = conn.prepareStatement(query);				
				updateCount = stat.executeUpdate();
			}
			RwsLocationBean rwsLocationBean = null; 
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO deleteTempSelectedHabs : \n" + e.getMessage());			
		}
		finally{	
			try{
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO deleteTempSelectedHabs finally : \n" + sqle.getMessage());
			}
		}
		return updateCount;
	}
	
	public int deleteTempSelectedHabs()	{
		Connection conn = null;
		PreparedStatement stat = null;
		int updateCount = 0;		
		try	{
			conn = getConn();
			String query = " DELETE FROM rws_temp_proposal_hab_tbl "; 
			stat = conn.prepareStatement(query);
			updateCount = stat.executeUpdate();
			RwsLocationBean rwsLocationBean = null; 
		}
		catch(Exception e){	
			Debug.println("The Exception is in ProposalDAO deleteTempSelectedHabs : " + e.getMessage());
		}
		finally	{
			try{
				if(stat != null){	
					stat.close();
				}
				if(conn != null){		
					conn.close();				
				}
			}
			catch(SQLException sqle){	
				Debug.println("The Exception is in ProposalDAO deleteTempSelectedHabs Finally : " + sqle.getMessage());
			}
		}
		return updateCount;
	}
	
	public boolean insertOMProposalTempHabs(String assetCode, String[] habCodes)
	{
		Debug.println("insertOMProposalTempHabs() called.");
		Connection conn = null;
		Statement stat = null;
		int updateCounts[];
		
		try
		{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			query = " DELETE FROM rws_temp_om_proposal_hab_tbl WHERE asset_code='" + assetCode + "'";
			stat.addBatch(query);
			for(int i=0; i<habCodes.length; i++)
			{
				query = " INSERT INTO rws_temp_om_proposal_hab_tbl VALUES('"+assetCode + "','"+habCodes[i]+"')";
				stat.addBatch(query);
			}
			updateCounts = stat.executeBatch();
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
		{	Debug.writeln("Exception in insertOMProposalTempHabs :\n" + e);
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
	
	public int deleteOMTempProposalHabs()
	{
		int updateCount = 0;
		Connection conn = null;
		Statement stat = null;
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			query = " DELETE FROM rws_temp_om_proposal_hab_tbl ";
			updateCount = stat.executeUpdate(query);
		}
		catch(Exception e)
		{	Debug.writeln("Exception in insertOMProposalTempHabs :\n" + e);
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
		return updateCount;
	}
	
	
	public ArrayList showFunctionalHabs(String assetCode)
	{
		Debug.println("showFunctionalHabs() called.");
		Debug.println("Asset Code : " + assetCode);
		
		ArrayList functionalHabs = new ArrayList();
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		try
		{
			conn = getConn();
			stat = conn.createStatement();
			query = " SELECT P.panch_code, P.panch_name,"
				  + " (H.census_plain_popu + H.census_st_popu + H.census_st_popu), H.coverage_status"
				  + " FROM rws_temp_om_proposal_hab_tbl O, rws_panchayat_raj_tbl P, " 
				  + " rws_habitation_directory_tbl H WHERE O.hab_code = P.panch_code " 
				  + " AND O.hab_code = H.hab_code " 
				  + " AND asset_code = '" + assetCode + "'";
			
			rset = 	stat.executeQuery(query);
			RwsLocationBean rwsLocationBean = null;   
			while(rset.next())
			{
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setHabCode(rset.getString(1));
				rwsLocationBean.setHabName(rset.getString(2));
				rwsLocationBean.setPopulation(rset.getString(3));
				rwsLocationBean.setStatus(rset.getString(4));
				functionalHabs.add(rwsLocationBean);
			}
			if(functionalHabs.size() == 0)
			{
				Debug.println("In FFF");
				query = " SELECT PR.panch_code, PR.panch_name, "
					  + " (HD.census_plain_popu+HD.census_sc_popu+HD.census_st_popu), "
					  + " HD.coverage_status FROM rws_om_proposal_hab_lnk_tbl PH, "
					  + " rws_panchayat_raj_tbl PR, rws_habitation_directory_tbl HD "
					  + " WHERE PH.hab_code = PR.panch_code "
					  + " AND PH.hab_code = HD.hab_code "
					  + " AND SUBSTR(PH.om_proposal_id, 7, 20) = '" + assetCode + "'";
				rset = stat.executeQuery(query);
				
				while(rset.next())
				{
					rwsLocationBean = new RwsLocationBean();
					rwsLocationBean.setHabCode(rset.getString(1));
					rwsLocationBean.setHabName(rset.getString(2));
					rwsLocationBean.setPopulation(rset.getString(3));
					rwsLocationBean.setStatus(rset.getString(4));
					functionalHabs.add(rwsLocationBean);
				}
			}
			if(functionalHabs.size() == 0)
			{
				Debug.println("In GGG");
				query = " SELECT PR.panch_code, PR.panch_name, "
					  + " (HD.census_plain_popu+HD.census_sc_popu+HD.census_st_popu), "
					  + " HD.coverage_status FROM rws_asset_hab_tbl AH, "
					  + " rws_panchayat_raj_tbl PR, rws_habitation_directory_tbl HD "
					  + " WHERE AH.hab_code = PR.panch_code "
					  + " AND AH.hab_code = HD.hab_code "
					  + " AND AH.asset_code = '" + assetCode + "'";
				rset = stat.executeQuery(query);
				
				while(rset.next())
				{
					rwsLocationBean = new RwsLocationBean();
					rwsLocationBean.setHabCode(rset.getString(1));
					rwsLocationBean.setHabName(rset.getString(2));
					rwsLocationBean.setPopulation(rset.getString(3));
					rwsLocationBean.setStatus(rset.getString(4));
					functionalHabs.add(rwsLocationBean);
				}
			}
			
		}
		catch(Exception e)
		{	Debug.writeln("Exception in showFunctionalHabs :\n" + e);
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
		return functionalHabs;
	}
	
	public boolean insertProposalTempHabs(String proposalId, String[] habCodes)
	{
		Debug.println("insertProposalTempHabs() called.");
		Debug.println("Proposal Id : " + proposalId);
		Debug.println("Hab Codes Length: " + habCodes.length);
		
		Connection conn = null;
		Statement stat = null;
		int[] updateCounts;
		try
		{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			query = "DELETE FROM rws_temp_proposal_hab_tbl WHERE proposal_id='" + proposalId + "'";
			stat.addBatch(query);
			
			for(int i=0; i<habCodes.length; i++)
			{
				query = " INSERT INTO rws_temp_proposal_hab_tbl VALUES( "
					  + " '" + proposalId + "', '" + habCodes[i] + "')" ; 
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
			conn.setAutoCommit(true);
			
		}
		catch(Exception e)
		{	Debug.println("Exception in insertProposalTempHabs : \n" + e);
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
	
	
	public boolean removeProposalFromTempTable(String proposalId){
		Connection conn = null;
		Statement stat = null;
		int[] updateCounts;
		try	{
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			query = "DELETE FROM rws_temp_proposal_hab_tbl WHERE proposal_id='" + proposalId + "'";
			stat.addBatch(query);			
			updateCounts = stat.executeBatch();			
			for(int i=0; i<updateCounts.length; i++){
				if(updateCounts[i] < 0)
					flag = false;
			}		
			if(flag)
				conn.commit();
			conn.setAutoCommit(true);			
		}
		catch(Exception e){	
			Debug.println("The Exception is in ProposalDAO removeProposalFromTempTable : \n " + e.getMessage());
			flag = false;
		}
		finally	{
			try{
				if(stat != null){	
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}
			catch(SQLException sqle){
				Debug.println("The Exception is in ProposalDAO removeProposalFromTempTable Finally : \n " + sqle.getMessage());				
			}
		}
		return flag;
	}
	
	
	public boolean insertProposalTempHabsToSession(HttpSession session,String proposalId, String[] habCodes){
		boolean insertedToSession=true;
		ArrayList selectedHabCodesForRevisedAdmnSanc=(ArrayList)session.getAttribute("selectedHabCodesForRevisedAdmnSanc");
		if(selectedHabCodesForRevisedAdmnSanc==null)
			selectedHabCodesForRevisedAdmnSanc=new ArrayList();
		try{		
			for(int i=0;i<habCodes.length;i++){
				RwsLocationBean rwsLocationBean=new RwsLocationBean();
				rwsLocationBean.setHabCode(habCodes[i]);
				rwsLocationBean.setProposalId(proposalId);
				selectedHabCodesForRevisedAdmnSanc.add(rwsLocationBean);
			}		
			session.setAttribute("selectedHabCodesForRevisedAdmnSanc",selectedHabCodesForRevisedAdmnSanc);
			session.setAttribute("tempSelectedAdmnHabs",selectedHabCodesForRevisedAdmnSanc);
			String code=proposalId.substring(6,8);
			RwsUser user=new RwsUser();
			user=(RwsUser)session.getAttribute("RWS_USER");
			String tabName1="";
			if(!(code.equals("11")|| code.equals("12")|| code.equals("13")|| code.equals("14"))){
				tabName1 = "tab_"+user.getUserId()+"_temp";
			}
			else if(code.equals("11")){
				tabName1 = "tab_"+user.getUserId()+"_temp_school";
			}
			else if(code.equals("12")){
				tabName1 = "tab_"+user.getUserId()+"_temp_lab";
			}else if(code.equals("14")){
				tabName1 = "tab_"+user.getUserId()+"_temp_pi";
			}
			insertProposalTempHabsForAdmin2(selectedHabCodesForRevisedAdmnSanc,tabName1,proposalId);			
			ArrayList tempSelectedHabs = getTempSelectedHabs();
			session.setAttribute("tempSelectedRepProposalHabs",tempSelectedHabs);
			removeProposalFromTempTable(proposalId);
		}
		catch(Exception e){	
			Debug.println("The Exception is in ProposalDAO insertProposalTempHabsToSession : \n" + e.getMessage());			
			insertedToSession = false;
		}
		return insertedToSession;
	}
	
	
	public boolean insertProposalTempHabsToSessionVar(HttpSession session,String proposalId, String[] habCodes,String sessionVar){
		boolean insertedToSession=true;
		ArrayList selectedHabCodesForRevisedAdmnSanc=(ArrayList)session.getAttribute(sessionVar);
		if(selectedHabCodesForRevisedAdmnSanc==null)
			selectedHabCodesForRevisedAdmnSanc=new ArrayList();
		try{		
			for(int i=0;i<habCodes.length;i++){
				RwsLocationBean rwsLocationBean=new RwsLocationBean();
				rwsLocationBean.setHabCode(habCodes[i]);
				rwsLocationBean.setProposalId(proposalId);
				selectedHabCodesForRevisedAdmnSanc.add(rwsLocationBean);
			}			
			insertProposalTempHabsForAdmin2(selectedHabCodesForRevisedAdmnSanc,"rws_temp_proposal_hab_tbl",proposalId);
			ArrayList tempSelectedHabs = getTempSelectedHabs();
			session.setAttribute(sessionVar,tempSelectedHabs);
			removeProposalFromTempTable(proposalId);
		}
		catch(Exception e){	
			System.out.println("The Exception is in ProposalDAO insertProposalTempHabsToSessionVar : "+e.getMessage());
			insertedToSession = false;
		}
		return insertedToSession;
	}
	
		
	public void removeHabsFromSession(HttpSession session,String workId)	{
		try{			
			ArrayList tempSelectedAdmnHabs=(ArrayList)session.getAttribute("selectedHabCodesForRevisedAdmnSanc");
			if(tempSelectedAdmnHabs==null)
				tempSelectedAdmnHabs=new ArrayList();
			for (int i = 0; i < tempSelectedAdmnHabs.size(); i++){
				nic.watersoft.commons.RwsLocationBean rwsLocationBean=(nic.watersoft.commons.RwsLocationBean)tempSelectedAdmnHabs.get(i);
				if(rwsLocationBean.getProposalId().equals(workId)){
					tempSelectedAdmnHabs.set(i,null);
				}			
			}
			for (int i = 0; i < tempSelectedAdmnHabs.size(); i++){
				nic.watersoft.commons.RwsLocationBean rwsLocationBean=(nic.watersoft.commons.RwsLocationBean)tempSelectedAdmnHabs.get(i);
				if(rwsLocationBean==null){
					tempSelectedAdmnHabs.remove(i);
					i--;
				}
			}
			session.setAttribute("selectedHabCodesForRevisedAdmnSanc",tempSelectedAdmnHabs);
		}catch(Exception e){
			Debug.println("The Exception is in ProposalDAO removeHabsFromSession : "+e.getMessage());		
		}
		
	}
	// Existing Sources
	
	
	
	public ArrayList getExistingSources(String officeCode)
	{
		Debug.println("getExisting sources is called.");
		Debug.println("office code="+officeCode);
		ArrayList existingSources=new ArrayList();
		Connection conn = null;
		Statement stat = null;
		ResultSet rset1=null;
		String query="";
		try{
	 	   
		  conn = getConn();
		  stat = conn.createStatement();
	 
		  query="select distinct s.source_code,s.source_name,p.panch_code,p.panch_name from rws_source_tbl s,rws_rep_proposal_tbl rp," +
		  		"rws_work_proposal_tbl wp,rws_panchayat_raj_tbl p where	rp.proposal_id=wp.proposal_id and wp.flag='A' and rp.flag='A' and rp.OFFICE_CODE='"+officeCode+"'" +
		  		"and s.hab_code=rp.LEAD_HAB_CODE and p.panch_code=rp.LEAD_HAB_CODE";
		  Debug.println("query="+query);
		  rset1=stat.executeQuery(query);
		  while(rset1.next())
		  {
		  	  ProposalDTO proposaldto=new ProposalDTO();
		  	  proposaldto.setSourceCode(rset1.getString(1));
		  	  proposaldto.setSourceName(rset1.getString(2));
		  	  proposaldto.setLeadHabitation(rset1.getString(3));
		  	  proposaldto.setHabName(rset1.getString(4)); 
		  	  existingSources.add(proposaldto);
		  }
		   
		 }
		 catch(Exception e)
		 {
			Debug.println("Error in getExisting Works:"+e.getMessage());
		 }
		 finally
		 {
			
			if(rset1 != null)
			{	try
				{	rset1.close();
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
          return existingSources;
   }	
	
	
	
	
	//	 Existing Work Details 
	public ArrayList getExistingWorks(String officeCode,int id)
	{
		Debug.println("getExisting works is called.");
		Debug.println("office code="+officeCode);
		ArrayList existingWorks=new ArrayList();
		Connection conn = null;
		Statement stat = null;
		ResultSet rset1=null;
		RwsOffices office=new RwsOffices();
		String officeQuery=null;
		String query="";
		try{
	 	   
		  conn = getConn();
		  stat = conn.createStatement();
		  Debug.println("id="+id);
		  String officeType=office.getOfficeType(officeCode);
		  Debug.println("office type is"+officeType);
		  
		  //code added by santosh
		  if(officeType.equalsIgnoreCase("Head Office"))
		  {
		  	officeQuery="like '"+officeCode.substring(0,1)+"%'";
		  }
		  if(officeType.equalsIgnoreCase("Circle"))
		  {
		  	officeQuery="like '"+officeCode.substring(0,3)+"%'";
		  }
		  if(officeType.equalsIgnoreCase("Division"))
		  {
		  	officeQuery="like '"+officeCode.substring(0,4)+"%'";
		  }
		  if(officeType.equalsIgnoreCase("Sub Division"))
		  {
		  	officeQuery="='"+officeCode+"'";
		  }
		  //end
		  
		  if(id==1)
		  {	
			  
		  /*query="select wp.PROPOSAL_ID,wp.PROPOSAL_NAME,a.TYPE_OF_ASSET_NAME,UPPER(NVL(P.programme_name,'')),UPPER(NVL(S.subprogramme_name,'')),wp.WORK_ID,wp.ESTIMATE_COST,rp.REP_NAME,TO_CHAR(rp.PREPARED_ON,'dd/mm/yyyy') from "+
                                  " rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,rws_programme_tbl P,rws_subprogramme_tbl S, rws_asset_type_tbl A  where "+
                                  " RP.type_of_asset = A.type_of_asset_code(+) AND RP.programme_code = P.programme_code(+) and ( RP.subprogramme_code = S.subprogramme_code (+) AND RP.programme_code = S.programme_code(+)) and"+ 
                                  " wp.proposal_id=rp.proposal_id and wp.office_code=rp.office_code and wp.office_code='"+officeCode+"' and wp.flag=rp.flag and wp.flag!='A'";*/
		  query="select wp.PROPOSAL_ID,wp.PROPOSAL_NAME,a.TYPE_OF_ASSET_NAME,UPPER(NVL(P.programme_name,'')),UPPER(NVL(S.subprogramme_name,'')),wp.WORK_ID,wp.ESTIMATE_COST,rp.REP_NAME,TO_CHAR(rp.PREPARED_ON,'dd/mm/yyyy'),wp.office_code from "+
          " rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,rws_programme_tbl P,rws_subprogramme_tbl S, rws_asset_type_tbl A  where "+
          " RP.type_of_asset = A.type_of_asset_code(+) AND RP.programme_code = P.programme_code(+) and ( RP.subprogramme_code = S.subprogramme_code (+) AND RP.programme_code = S.programme_code(+)) and"+ 
          " wp.proposal_id=rp.proposal_id and wp.office_code=rp.office_code and wp.office_code "+officeQuery+" and wp.flag=rp.flag and wp.flag!='A' order by wp.office_code";

		  Debug.println("query="+query);
		  rset1=stat.executeQuery(query);
		  while(rset1.next())
		  {
		  	  ProposalDTO proposaldto=new ProposalDTO();
		  	  proposaldto.setProposalId(rset1.getString(1));
		  	  proposaldto.setProposalName(rset1.getString(2));
		  	  proposaldto.setAssetName(rset1.getString(3));
		  	  proposaldto.setProgrammeName(rset1.getString(4));
		  	  proposaldto.setSubprogrammeName(rset1.getString(5));
		  	  proposaldto.setWorkId(rset1.getString(6));
		  	  proposaldto.setEstimateCost(rset1.getString(7));
		  	  proposaldto.setRepName(rset1.getString(8));
		  	  proposaldto.setProposalDate(rset1.getString(9));
		  	  proposaldto.setSubdivisionOfficeCode(rset1.getString("office_code"));
		  	  existingWorks.add(proposaldto);
		  }
		 }
		 else if(id==2)
		  {	
		 	
		 /* query=" select wp.PROPOSAL_ID,wp.PROPOSAL_NAME,a.TYPE_OF_ASSET_NAME,UPPER(NVL(P.programme_name,'')),UPPER(NVL(S.subprogramme_name,'')),wp.WORK_ID,wp.ESTIMATE_COST,TO_CHAR(wp.ADMIN_DATE,'dd/mm/yyyy') ,wp.ADMIN_SANC_AUTH,wp.SANCTION_AMOUNT from"+
                " rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,rws_programme_tbl P,rws_subprogramme_tbl S, rws_asset_type_tbl A  where "+
                " RP.type_of_asset = A.type_of_asset_code(+) AND RP.programme_code = P.programme_code(+) and ( RP.subprogramme_code = S.subprogramme_code (+) AND RP.programme_code = S.programme_code(+)) and "+ 
                " wp.proposal_id=rp.proposal_id and wp.office_code=rp.office_code and wp.office_code='"+officeCode+"' and wp.flag=rp.flag and wp.flag='A'";*/
			  query=" select wp.PROPOSAL_ID,wp.PROPOSAL_NAME,a.TYPE_OF_ASSET_NAME,UPPER(NVL(P.programme_name,'')),UPPER(NVL(S.subprogramme_name,'')),wp.WORK_ID,wp.ESTIMATE_COST,TO_CHAR(wp.ADMIN_DATE,'dd/mm/yyyy') ,wp.ADMIN_SANC_AUTH,wp.SANCTION_AMOUNT,wp.office_code from"+
              " rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,rws_programme_tbl P,rws_subprogramme_tbl S, rws_asset_type_tbl A  where "+
              " RP.type_of_asset = A.type_of_asset_code(+) AND RP.programme_code = P.programme_code(+) and ( RP.subprogramme_code = S.subprogramme_code (+) AND RP.programme_code = S.programme_code(+)) and "+ 
              " wp.proposal_id=rp.proposal_id and wp.office_code=rp.office_code and wp.office_code "+officeQuery+" and wp.flag=rp.flag and wp.flag='A' order by wp.office_code";
				
		  Debug.println("query="+query);
		  rset1=stat.executeQuery(query);
		  while(rset1.next())
		  {
		  	  ProposalDTO proposaldto=new ProposalDTO();
		  	  proposaldto.setProposalId(rset1.getString(1));
		  	  proposaldto.setProposalName(rset1.getString(2));
		  	  proposaldto.setAssetName(rset1.getString(3));
		  	  proposaldto.setProgrammeName(rset1.getString(4));
		  	  proposaldto.setSubprogrammeName(rset1.getString(5));
		  	  proposaldto.setWorkId(rset1.getString(6));
		  	  proposaldto.setEstimateCost(rset1.getString(7));
		  	  proposaldto.setAdminDate(rset1.getString(8));
		  	  proposaldto.setSanctioningAuthority(rset1.getString(9));
		  	  proposaldto.setSanctionedAmount(rset1.getString(10));
		  	  proposaldto.setSubdivisionOfficeCode(rset1.getString("office_code"));
		  	  existingWorks.add(proposaldto);
		  }
		 }
		 else if(id==3)
		  {	
		 	
		  /*query=" select distinct  wp.proposal_id,wp.proposal_name,a.TYPE_OF_ASSET_NAME,UPPER(NVL(P.programme_name,'')),UPPER(NVL(S.subprogramme_name,'')),ts.work_id,ts.ESTIMATE_AMOUNT ,"+
		  	    " ts.TS_AMOUNT,TO_CHAR(ts.TS_DATE,'dd/mm/yyyy')  from  rws_work_proposal_tbl wp,rws_new_est_tbl ts,rws_new_est_workflow_tbl tsw,rws_programme_tbl P,rws_subprogramme_tbl S," +
		  	    " rws_asset_type_tbl A  where wp.type_of_asset = A.type_of_asset_code(+) AND wp.programme_code = P.programme_code(+) and ( wp.subprogramme_code = S.subprogramme_code (+) AND wp.programme_code = S.programme_code(+)) " +
		  	    " and wp.work_id=ts.work_id and wp.work_id=tsw.work_id and tsw.FLAG ='Y' and ts.work_id=tsw.work_id and wp.work_id=tsw.work_id and wp.office_code='"+officeCode+"' and ts.office_code='"+officeCode+"' and wp.office_code=ts.office_code";
		  	*/
		 	//code added by santosh
			 	query=" select distinct  wp.proposal_id,wp.proposal_name,a.TYPE_OF_ASSET_NAME,UPPER(NVL(P.programme_name,'')),UPPER(NVL(S.subprogramme_name,'')),ts.work_id,ts.ESTIMATE_AMOUNT ,"+
		  	    " ts.TS_AMOUNT,TO_CHAR(ts.TS_DATE,'dd/mm/yyyy'),wp.office_code  from  rws_work_proposal_tbl wp,rws_new_est_tbl ts,rws_programme_tbl P,rws_subprogramme_tbl S," +
		  	    " rws_asset_type_tbl A  where wp.type_of_asset = A.type_of_asset_code(+) AND wp.programme_code = P.programme_code(+) and ( wp.subprogramme_code = S.subprogramme_code (+) AND wp.programme_code = S.programme_code(+)) " +
		  	    " and wp.work_id=ts.work_id   and wp.office_code "+officeQuery+" and ts.office_code "+officeQuery+" and wp.office_code=ts.office_code and ts.ts_no is not null order by wp.office_code";
		  	//end
		  
		  Debug.println("query="+query);
		  rset1=stat.executeQuery(query);
		  while(rset1.next())
		  {
		  	  ProposalDTO proposaldto=new ProposalDTO();
		  	  proposaldto.setProposalId(rset1.getString(1));
		  	  proposaldto.setProposalName(rset1.getString(2));
		  	  proposaldto.setAssetName(rset1.getString(3));
		  	  proposaldto.setProgrammeName(rset1.getString(4));
		  	  proposaldto.setSubprogrammeName(rset1.getString(5));
		  	  proposaldto.setWorkId(rset1.getString(6));
		  	  proposaldto.setEstimateCost(rset1.getString(7));
		  	  proposaldto.setSanctionedAmount(rset1.getString(8));
		  	  proposaldto.setAdminDate(rset1.getString(9));
		  	  proposaldto.setSubdivisionOfficeCode(rset1.getString("office_code"));
		  	  existingWorks.add(proposaldto);
		  }
		 }
		 else if(id==4)
		  {	
		 	
		  Debug.println("circle="+officeCode.substring(1,3)+"division="+officeCode.substring(3,4)+"subdivi="+officeCode.substring(4,6));
		   /*query="select  a.asset_code,a.asset_name,pr.panch_name,a.location,a.asset_status,a.asset_cost,a.start_year,a.end_year from " +
		  		"rws_asset_mast_tbl a,rws_rep_proposal_tbl rp, rws_work_proposal_tbl wp,RWS_PANCHAYAT_RAJ_TBL  pr  where  a.asset_code=wp.work_id and" +
		  		" rp.proposal_id=wp.proposal_id and a.hab_code=pr.panch_code and a.circle_office_code='"+officeCode.substring(1,3)+"' and a.division_office_code='"+officeCode.substring(3,4)+"' and a.SUBDIVISION_OFFICE_CODE='"+officeCode.substring(4,6)+"' and wp.office_code='"+officeCode+"'";*/   
		   query="select  a.asset_code,a.asset_name,pr.panch_name,a.location,a.asset_status,a.asset_cost,a.start_year,a.end_year,wp.office_code from " +
	  		"rws_asset_mast_tbl a,rws_rep_proposal_tbl rp, rws_work_proposal_tbl wp,RWS_PANCHAYAT_RAJ_TBL  pr  where  a.asset_code=wp.work_id and" +
	  		" rp.proposal_id=wp.proposal_id and a.hab_code=pr.panch_code and a.circle_office_code='"+officeCode.substring(1,3)+"' and a.division_office_code='"+officeCode.substring(3,4)+"' and a.SUBDIVISION_OFFICE_CODE='"+officeCode.substring(4,6)+"' and wp.office_code "+officeQuery+" order by wp.office_code";   

		   Debug.println("query="+query);
		   rset1=stat.executeQuery(query);
		   while(rset1.next())
		   {
		  	  ProposalDTO proposaldto=new ProposalDTO();
		  	  proposaldto.setAssetCode(rset1.getString(1));
		  	  proposaldto.setAssetName(rset1.getString(2));
		  	  proposaldto.setLeadHabitation(rset1.getString(3));
		  	  proposaldto.setLocation(rset1.getString(4));
		  	  proposaldto.setAssetStatus(rset1.getString(rset1.getString(5)));
		  	  proposaldto.setAssetCost(rset1.getString(6));
		  	  proposaldto.setStartYear(rset1.getString(7));
		  	  proposaldto.setEndYear(rset1.getString(8));
		  	  proposaldto.setSubdivisionOfficeCode(rset1.getString("office_code"));
		   	  existingWorks.add(proposaldto);
		   }
		  }
		 }
		 catch(Exception e)
		 {
			Debug.println("Error in getExisting Works:"+e.getMessage());
		 }
		 finally
		 {
			
			if(rset1 != null)
			{	try
				{	rset1.close();
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
          return existingWorks;
   }	
	
	public ArrayList getOMProposalsAdministrativeSanctioned(String officeCode,String[] assetCodes)
	{	
		Debug.println("getOMProposalsAdministrativeSanctioned() called.");
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Statement stat1 = null;
		ResultSet rset1 = null;
		
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
		try
		{
			String assetCodesQuery=" and am.asset_code in(";
			/*for(int i=0;i<assetCodes.length;i++,assetCodesQuery=assetCodesQuery+",")
			{
				assetCodesQuery=assetCodesQuery+assetCodes[i];
			}*/
			assetCodesQuery+="'"+assetCodes[0]+"'";
			assetCodesQuery+=")";
			query = " SELECT OMPWT.action_from, OMP.om_proposal_id,  " +
					" OMP.financial_year, OMP.asset_code, AM.asset_name,   " +
					" OMP.estimate_cost, NVL(OMP.sanctioned_amount, 0)," +
					" TO_CHAR(OMP.prepared_on,'dd/mm/yyyy') as proposal_date," +
					" OMPWT.memo_no, TO_CHAR(OMPWT.for_sub_date,'dd/mm/yyyy')," +
					" OMPWT.subject, NVL(OMPWT.ref,''), OMPWT.content," +
					" OMPWT.action_type, OMP.no_of_habs,ompwt2.action_from " +
					" as subDivision  FROM rws_om_proposal_tbl OMP," +
					" rws_om_proposal_workflow_tbl OMPWT,rws_om_proposal_workflow_tbl" +
					" OMPWT2,  rws_asset_mast_tbl AM WHERE " +
					" (OMP.om_proposal_id = OMPWT.om_proposal_id) " +
					" AND OMP.asset_code = AM.asset_code  " +
					" AND OMP.flag = 'A' AND OMPWT.action_type='P'" +
					" AND OMPWT.flag = 'Y' and ompwt.om_proposal_id=ompwt2.om_proposal_id" +
					" and ompwt2.track_no=1"+assetCodesQuery;
				  
			Debug.println("omproposals administratively sanctioned query is:"+query);
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rset = stat.executeQuery(query);
			consideredProposals = new ArrayList();
			String proposalId = null;
			ArrayList programmes = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				Debug.println("1");
				proposalDTO.setProposalId(rset.getString("om_proposal_id"));
				Debug.println("2");
				proposalDTO.setAssetCode(rset.getString("asset_code"));
				Debug.println("3");
				proposalDTO.setAssetName(rset.getString("asset_name"));
				Debug.println("4");
				proposalDTO.setEstimateCost(rset.getString("estimate_cost"));
				Debug.println("5");
				proposalDTO.setFinancialYear(rset.getString("financial_year"));
				Debug.println("6");
				proposalDTO.setProposalDate(rset.getString("proposal_date"));
				Debug.println("7");
				proposalDTO.setNoOfFunctionalHabs(rset.getString("no_of_habs"));
				Debug.println("8");
				proposalDTO.setActionFrom(rset.getString("subDivision"));
				Debug.println("9");
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
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				consideredProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMConsideredProposals is :\n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return consideredProposals;
	}
	
	public ArrayList getOMProposalsTechnicallySanctioned(String officeCode)
	{	
		Debug.println("getOMProposalsTechnicallySanctioned() called.");
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Statement stat1 = null;
		ResultSet rset1 = null;
		
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
		try
		{
			query = " SELECT OMPWT.action_from, OMP.om_proposal_id,  " +
					" OMP.financial_year, OMP.asset_code, AM.asset_name,   " +
					" OMP.estimate_cost, NVL(OMP.sanctioned_amount, 0)," +
					" TO_CHAR(OMP.prepared_on,'dd/mm/yyyy') as proposal_date," +
					" OMPWT.memo_no, TO_CHAR(OMPWT.for_sub_date,'dd/mm/yyyy')," +
					" OMPWT.subject, NVL(OMPWT.ref,''), OMPWT.content," +
					" OMPWT.action_type, OMP.no_of_habs,ompwt2.action_from " +
					" as subDivision  FROM rws_om_proposal_tbl OMP," +
					" rws_om_proposal_workflow_tbl OMPWT,rws_om_proposal_workflow_tbl" +
					" OMPWT2,  rws_asset_mast_tbl AM WHERE " +
					" (OMP.om_proposal_id = OMPWT.om_proposal_id) " +
					" AND OMP.asset_code = AM.asset_code  " +
					" AND OMP.flag = 'A' AND OMPWT.action_type='P'" +
					" AND OMPWT.flag = 'Y' and ompwt.om_proposal_id=ompwt2.om_proposal_id" +
					" and ompwt2.track_no=1";
				  
			Debug.println("omproposals technically sanctioned query is:"+query);
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rset = stat.executeQuery(query);
			consideredProposals = new ArrayList();
			String proposalId = null;
			ArrayList programmes = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				//proposalId = rset.getString(1);
				Debug.println("1");
				proposalDTO.setProposalId(rset.getString("om_proposal_id"));
				Debug.println("2");
				proposalDTO.setAssetCode(rset.getString("asset_code"));
				Debug.println("3");
				proposalDTO.setAssetName(rset.getString("asset_name"));
				Debug.println("4");
				proposalDTO.setEstimateCost(rset.getString("estimate_cost"));
				Debug.println("5");
				proposalDTO.setFinancialYear(rset.getString("financial_year"));
				Debug.println("6");
				proposalDTO.setProposalDate(rset.getString("proposal_date"));
				Debug.println("7");
				proposalDTO.setNoOfFunctionalHabs(rset.getString("no_of_habs"));
				Debug.println("8");
				proposalDTO.setActionFrom(rset.getString("subDivision"));
				Debug.println("9");
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
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				consideredProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMConsideredProposals is :\n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return consideredProposals;
	}
	
	public ArrayList getOMProposalsPendingForAdministrativeSanction(String officeCode)
	{	
		Debug.println("getOMProposalsPendingForAdministrativeSanction called.");
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Statement stat1 = null;
		ResultSet rset1 = null;
		
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
		try
		{
			query = " SELECT OMPWT.action_from, OMP.om_proposal_id,  " +
					" OMP.financial_year, OMP.asset_code, AM.asset_name,   " +
					" OMP.estimate_cost, NVL(OMP.sanctioned_amount, 0)," +
					" TO_CHAR(OMP.prepared_on,'dd/mm/yyyy') as proposal_date," +
					" OMPWT.memo_no, TO_CHAR(OMPWT.for_sub_date,'dd/mm/yyyy')," +
					" OMPWT.subject, NVL(OMPWT.ref,''), OMPWT.content," +
					" OMPWT.action_type, OMP.no_of_habs,ompwt2.action_from " +
					" as subDivision  FROM rws_om_proposal_tbl OMP," +
					" rws_om_proposal_workflow_tbl OMPWT,rws_om_proposal_workflow_tbl" +
					" OMPWT2,  rws_asset_mast_tbl AM WHERE " +
					" (OMP.om_proposal_id = OMPWT.om_proposal_id) " +
					" AND OMP.asset_code = AM.asset_code  " +
					" AND OMP.flag = 'A' AND OMPWT.action_type='P'" +
					" AND OMPWT.flag = 'Y' and ompwt.om_proposal_id=ompwt2.om_proposal_id" +
					" and ompwt2.track_no=1";
				  
			Debug.println("omproposals pending for administrative sanction query is:"+query);
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rset = stat.executeQuery(query);
			consideredProposals = new ArrayList();
			String proposalId = null;
			ArrayList programmes = null;
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				Debug.println("1");
				proposalDTO.setProposalId(rset.getString("om_proposal_id"));
				Debug.println("2");
				proposalDTO.setAssetCode(rset.getString("asset_code"));
				Debug.println("3");
				proposalDTO.setAssetName(rset.getString("asset_name"));
				Debug.println("4");
				proposalDTO.setEstimateCost(rset.getString("estimate_cost"));
				Debug.println("5");
				proposalDTO.setFinancialYear(rset.getString("financial_year"));
				Debug.println("6");
				proposalDTO.setProposalDate(rset.getString("proposal_date"));
				Debug.println("7");
				proposalDTO.setNoOfFunctionalHabs(rset.getString("no_of_habs"));
				Debug.println("8");
				proposalDTO.setActionFrom(rset.getString("subDivision"));
				Debug.println("9");
				
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
				programmes = new ArrayList();
				while(rset1.next())
				{
					programmeSubProgrammeBean = new ProgrammeSubProgrammeBean();
					programmeSubProgrammeBean.setProgrammeName(rset1.getString(1));
					programmeSubProgrammeBean.setSubprogrammeName(rset1.getString(2));
					programmes.add(programmeSubProgrammeBean);
				}
				proposalDTO.setProgrammes(programmes);
				consideredProposals.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMConsideredProposals is :\n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return consideredProposals;
	}
	public ArrayList getOMProposalsAssetDetails(String officeCode,String[] assetCodes)
	{
		Debug.println("getOMProposalsAssetDetails called.");
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Statement stat1 = null;
		ResultSet rset1 = null;
		
		ArrayList assetDetails = new ArrayList();
		ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
		try
		{
			

			query = "select asset_code,asset_name,at.type_of_asset_name,hab_code,location," +
					"date_creation,asset_status,asset_cost,start_year,end_year from " +
					"rws_asset_mast_tbl am,rws_asset_type_tbl at where " +
					"at.type_of_asset_code=am.type_of_asset_code and am.asset_code in(";
			
				for(int i=0;i<assetCodes.length;i++)
				{
					query+="'"+assetCodes[i]+"'";
					if((assetCodes.length-1)!=i)
						query+=",";
				}
				query+=")";
				
			
				  
			Debug.println("omproposals assetDetails query is:"+query);
			conn = getConn();
			stat = conn.createStatement();
			stat1 = conn.createStatement();
			rset = stat.executeQuery(query);
			
			
			
			while(rset.next())
			{
				proposalDTO = new ProposalDTO();
				
				Debug.println("1");
				proposalDTO.setAssetCode(rset.getString("asset_code"));
				Debug.println("2");
				proposalDTO.setAssetName(rset.getString("asset_name"));
				Debug.println("3");
				proposalDTO.setTypeOfAssetCode(rset.getString("type_of_asset_name"));
				Debug.println("4");
				proposalDTO.setHabCode(rset.getString("hab_code"));
				Debug.println("5");
				proposalDTO.setLocation(rset.getString("location"));
				Debug.println("6");
				proposalDTO.setDateCreation(rset.getString("date_creation"));
				Debug.println("7");
				proposalDTO.setAssetStatus(rset.getString("asset_status"));
				Debug.println("8");
				proposalDTO.setAssetCost(rset.getString("asset_cost"));
				Debug.println("9");
				proposalDTO.setStartYear(rset.getString("start_year"));
				proposalDTO.setEndYear(rset.getString("end_year"));
				assetDetails.add(proposalDTO);
			}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getOMConsideredProposals is :\n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return assetDetails;
	
	}
	
	public int getTrackNo(String proposalId,String sentTo)
	{
		Connection conn=null;
		Statement stat=null;
		ResultSet rset=null;
		int trackNo=0;
		
		try{
		conn=RwsOffices.getConn();
		stat=conn.createStatement();
		String query="select max(track_no) from RWS_PROPOSAL_WORKFLOW_TBL where " 
					+ " proposal_id='"+proposalId
					+"' and sent_to='"+sentTo+"'";
		Debug.println("query in getTrackNo is "+query);
		rset=stat.executeQuery(query);
		if(rset.next())
			trackNo=rset.getInt(1);
		}catch(Exception e)
		{	Debug.writeln("Exception in getTrackNo() is :\n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		
		return trackNo;
	}
//------------------- End Of ProposalDAO class ------------------------
	
	
	
	
	public static String getNextProposalIdForAdminiStrative(String headOfficecode,String districtCode,String typeOfAsset,String programmeCode,String subprogrammeCode){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		java.util.Date date = new java.util.Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yy");
		String currentYear = dateFormatter.format(date);
		String workId = null;	 	 
	 	try {	
	 		conn=RwsOffices.getConn();
	 		if(subprogrammeCode .equals(""))
				subprogrammeCode = "00";
			if(programmeCode.equals("") || districtCode .equals("") ||	typeOfAsset.equals(""))
				return new String("false");
			workId = programmeCode + subprogrammeCode + districtCode + typeOfAsset + currentYear;
			query = "SELECT MAX(SUBSTR(work_id,11,4)) as work_id FROM RWS_WORK_ADMN_TBL WHERE WORK_ID LIKE  ? "; 
			stat=conn.prepareStatement(query);
			stat.setString(1, workId+"%");
			rset = stat.executeQuery();			 
			if(rset.next()){    
				int	sno=rset.getInt(1);
			 	if(sno == 0)
					workId = workId + "0001";
				else{
					if(sno >= 9999)
						throw new Exception("No more WORK ID left.");
					else {
						String tempSno = null;
						if(sno<9)
							tempSno = "000"+(sno+1);
						else if(sno<99)
							tempSno = "00"+(sno+1);
						else if(sno<999)
							tempSno = "0"+(sno+1);
						else
							tempSno = String.valueOf(sno+1);						
						workId =  workId + String.valueOf(tempSno);
					}
				}
			}
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getNextProposalIdForAdminiStrative : \n" + e.getMessage());			
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO getNextProposalIdForAdminiStrative finally : \n" + sqle.getMessage());
			}
		}
		return workId;
	}
	
	
	public DAOMessage deleteAdminiStrativeDetails(String proposalId){
		Connection conn = null;
		String q="",q1="",q2="",q3="",q4="",q5="",q6="";
		PreparedStatement stat = null,stat1=null,stat2=null,stat3=null,stat4=null,stat5=null;
		ResultSet rset = null,rset1 = null,rset2 = null,rset3 = null,rset4 = null,rset5 = null;
		DAOMessage daoMessage=new DAOMessage();
		daoMessage.setOperationSussess(true);
		try	{
			conn = getConn();
			conn.setAutoCommit(false);
			int count=0;
			boolean delete=true;
			q1 = "select * from rws_new_est_tbl where work_id= ? ";
			q2 = "select * from RWS_CONTRACTOR_SELECTION_TBL where work_id= ? ";
			q3 = "select * from RWS_WORK_COMMENCEMENT_TBL where work_id= ? ";
			q4 = "select * from RWS_WORK_EXPENDITURE_TBL where work_id= ? ";
			q5 = "select * from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id= ? ";
			q6 = "select * from RWS_WORK_COMPLETION_TBL where work_id= ? ";			
			
			stat = conn.prepareStatement(q1);
			stat.setString(1, proposalId);
			rset=stat.executeQuery();
			
			stat1 = conn.prepareStatement(q2);
			stat1.setString(1, proposalId);
			rset1=stat1.executeQuery();
			
			stat2 = conn.prepareStatement(q3);
			stat2.setString(1, proposalId);
			rset2=stat2.executeQuery();
			
			stat3 = conn.prepareStatement(q4);
			stat3.setString(1, proposalId);
			rset3=stat3.executeQuery();
			
			stat4 = conn.prepareStatement(q5);
			stat4.setString(1, proposalId);
			rset4=stat4.executeQuery();
			
			stat5 = conn.prepareStatement(q6);		
			stat5.setString(1, proposalId);
			rset5=stat5.executeQuery();

			if(rset.next()){
				delete=false;
				throw new SQLException("RECORD EXIST IN CHILD TABLE");
			}
			if(rset1.next() && delete){
				delete=false;
				throw new SQLException("RECORD EXIST IN CHILD TABLE");
			}
			if(rset2.next() && delete){
				delete=false;
				throw new SQLException("RECORD EXIST IN CHILD TABLE");
			}
			if(rset3.next() && delete){
				delete=false;
				throw new SQLException("RECORD EXIST IN CHILD TABLE");
			}
			if(rset4.next() && delete){
				delete=false;
				throw new SQLException("RECORD EXIST IN CHILD TABLE");
			}
			if(rset5.next() && delete){
				delete=false;
				throw new SQLException("RECORD EXIST IN CHILD TABLE");
			}
			if(delete){
				if(stat!=null)stat.close();
				String queries[]=new String[3];
				queries[0]="DELETE FROM RWS_WORK_ADMN_TBL WHERE WORK_ID= ? ";
				queries[1]="DELETE FROM RWS_ADMN_HAB_LNK_TBL WHERE WORK_ID= ? ";
			    queries[2]="DELETE FROM RWS_WORK_ADMN_PROG_LNK_TBL WHERE WORK_ID= ? ";				
				for(int i=queries.length-1;i>=0;i--){
					stat = conn.prepareStatement(queries[i]);
					stat.setString(1, proposalId);
					stat.executeUpdate();
					count++;
				}
				if(count == 3){
			 		conn.commit();
			 		daoMessage.setOperationSussess(true);
			 		daoMessage.setMessage("Record deleted successfully");
			 	}
			 	else{
					daoMessage.setOperationSussess(false);
			 		daoMessage.setMessage("No Records have been deleted");
				}
			}
	 	}
		catch(SQLException e){
			Debug.writeln("The SQLException is in ProposalDAO deleteAdminiStrativeDetails : \n" + e.getMessage());			
			daoMessage.setOperationSussess(false);
			if(e.getErrorCode()==17081)
				daoMessage.setMessage("Record cannot be deleted as child records exists");
			else
				daoMessage.setMessage("Record cannot be deleted");
			try{
				conn.rollback();
			}
			catch(Exception ex){
				Debug.writeln("The SQLException is in ProposalDAO deleteAdminiStrativeDetails rollback : \n" + ex.getMessage());				
			}				
		}
		catch(Exception e){
			Debug.writeln("The Exception is in ProposalDAO deleteAdminiStrativeDetails : \n" + e.getMessage());			
			daoMessage.setOperationSussess(false);
			daoMessage.setMessage("Record cannot be deleted");
			try{
				conn.rollback();
			}
			catch(Exception ex){	
				Debug.writeln("The Exception is in ProposalDAO deleteAdminiStrativeDetails rollback : \n" + ex.getMessage());			
			}
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(rset1 != null) {	
					rset1.close();				
				}
				if(rset2 != null) {	
					rset2.close();				
				}
				if(rset3 != null) {	
					rset3.close();				
				}
				if(rset4 != null) {	
					rset4.close();				
				}
				if(rset5 != null) {	
					rset5.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(stat1 != null) {
					stat1.close();
				}
				if(stat2 != null) {
					stat2.close();
				}
				if(stat3 != null) {
					stat3.close();
				}
				if(stat4 != null) {
					stat4.close();
				}
				if(stat5 != null) {
					stat5.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO deleteAdminiStrativeDetails finally : \n" + sqle.getMessage());
			}
		}
		return daoMessage;
	}
	
	
	public DAOMessage deleteRevisedDetails(String proposalId) {
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		DAOMessage daoMessage=new DAOMessage();
		daoMessage.setOperationSussess(true);
		boolean flag=false;
		int[] status={0};
		try{
			query = "DELETE FROM RWS_REVISED_ADM_SANC_TBL  WHERE WORK_ID='"+proposalId+"'";
			query1=" DELETE FROM RWS_REV_ADM_SANC_HAB_LNK_TBL  WHERE WORK_ID='"+proposalId+"'";
			String query2=" DELETE FROM RWS_REVISED_ADM_PROG_LNK_TBL WHERE WORK_ID='"+proposalId+"'";
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			stat.addBatch(query);
			stat.addBatch(query1);
			stat.addBatch(query2);
			status=stat.executeBatch();
			if(status[0]<1){
				daoMessage.setMessage("No Records Deleted");
				daoMessage.setOperationSussess(false);
			}
			else{
				daoMessage.setOperationSussess(true);
				daoMessage.setMessage("Record Deleted Successfully");
				conn.commit();
			}			
		}
		catch(SQLException e){
			Debug.writeln("The SQLException is in ProposalDAO deleteRevisedDetails : \n" + e.getMessage());			
			daoMessage.setOperationSussess(false);
			if(e.getErrorCode()==17081)
				daoMessage.setMessage("Record cannot be deleted as child records exists");
			else
				daoMessage.setMessage("Record cannot be deleted");				
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO deleteRevisedDetails : \n" + e.getMessage());			
			daoMessage.setOperationSussess(false);
			daoMessage.setMessage("Records Cannot be Deleted");
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO deleteRevisedDetails finally : \n" + sqle.getMessage());
			}
		}
		return daoMessage;
	}
	
	
	protected ArrayList getAdminstrativeSanctionList(String officeCode,String workId){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		try	{
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
			if(!workId.equals("")){
				query=query+" and ad.WORK_ID='"+workId+"'";
			}
			query=query+" order by PREPARED_ON";	
	 		conn = getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			representativeProposals = new ArrayList();			
			while(rset.next()){
				proposalDTO = new ProposalDTO();				
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
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getAdminstrativeSanctionList : \n" + e.getMessage());			
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO getAdminstrativeSanctionList finally : \n" + sqle.getMessage());
			}
		}
		return representativeProposals;		
	}
	

	public ArrayList getSelectedHabitationsForAdminStrative(String proposalId,String tabName,boolean flag){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		String schemecode=proposalId.substring(6,8);
		ArrayList habs = new ArrayList();
		try{
			if(!(schemecode.equals("11")|| schemecode.equals("12")|| schemecode.equals("13")|| schemecode.equals("14"))){
				query = " SELECT distinct PR.panch_code, PR.panch_name, "
					  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
					  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
					  + " rws_habitation_directory_tbl HD, rws_admn_hab_lnk_tbl HL "
					  + " WHERE PR.panch_code = HL.hab_code "
					  + " AND PR.panch_code = HD.hab_code "
					  + " AND HL.work_id ='" +  proposalId + "'";
			}else if(schemecode.equals("11")){
				
				/*query =	" select s.hab_code,s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE,panch_name  from "
				  + " rws_school_master_tbl s, rws_work_school_lnk_tbl HL,rws_panchayat_raj_tbl b "
				  + " WHERE s.school_code = HL.school_code "
				  + " and s.hab_code=hl.hab_code and s.hab_code=b.panch_code   "
				  + " and work_id='"+proposalId+"'";*/
				
				 Calendar rightNow = Calendar.getInstance();
		          	int year = rightNow.get(Calendar.YEAR);
		          	
		          	if(year <2021){
		          		query = " select s.hab_code,s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,pr.panch_name  from "
		         				  + " rws_school_master_tbl s, rws_work_school_lnk_tbl  HL,rws_panchayat_raj_tbl pr "
		         				  + " WHERE s.school_code = HL.school_code "
		         				  + " and s.hab_code=hl.hab_code  and hl.hab_code=pr.panch_code and s.hab_code=pr.panch_code "
		         				  + " AND HL.work_id ='"+proposalId+"'";

		          		
		          	}else{
		          		query = " select s.habcode,s.SCHOOL_ID,SCH_NAME,HABITATIONNAME ,INSTITUTIONCATEGORY ,pr.panch_name  from "
		         				  + " IMIS_SCHOOLS_TBL  s, rws_work_school_lnk_tbl  HL,rws_panchayat_raj_tbl pr "
		         				  + " WHERE s.SCHOOL_ID = HL.school_code "
		         				  + " and s.habcode=hl.hab_code  and hl.hab_code=pr.panch_code and s.habcode=pr.panch_code "
		         				  + " AND HL.work_id ='"+proposalId+"'";
		          		
		          	}
				
		    }else if(schemecode.equals("13")){
				query =	" select s.habcode,s.SCHOOL_ID,SCH_NAME,INSTITUTIONCATEGORY,NOS_TAP_CONNECTION ,panch_name  from "
						  + " IMIS_ANGANWADIES_TBL s, rws_work_pi_lnk_tbl  HL,rws_panchayat_raj_tbl b "
						  + " WHERE s.SCHOOL_ID = HL.PI_CODE "
						  + " and s.habcode=hl.hab_code and s.habcode=b.panch_code   "
						  + " and work_id='"+proposalId+"'";
			}else if(schemecode.equals("14")){
						query =	" select s.habcode,s.PI_ID,LOCATION,CATEGORY,NOS_TAP_CONNECTION ,panch_name  from "
								  + " IMIS_PUBLIC_INSTITUTIONS_TBL s, rws_work_pi_lnk_tbl  HL,rws_panchayat_raj_tbl b "
								  + " WHERE s.PI_ID = HL.PI_CODE "
								  + " and s.habcode=hl.hab_code and s.habcode=b.panch_code   "
								  + " and work_id='"+proposalId+"'";
						    }
			else if(schemecode.equals("12"))  {
				query =	"SELECT  a.LAB_CODE,a.LAB_NAME,a.LOCATION FROM  rws_water_quality_lab_tbl a, RWS_WORK_LAB_LNK_TBL b WHERE   a.lab_code=b.lab_code and  WORK_ID='"+proposalId+"'" ;
		    }
			conn = getConn();
			String[] habcodes=new String[1000];
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
		 	RwsLocationBean rwsLocationBean = null;
			int i=0;
			while(rset.next()){	
				try{
					rwsLocationBean = new RwsLocationBean();
					if(!(schemecode.equals("11")|| schemecode.equals("12")|| schemecode.equals("13")|| schemecode.equals("14"))){
						rwsLocationBean.setHabCode(rset.getString(1));
						if(rset.getString(1)!=null) {
							habcodes[i]=rset.getString(1);
							i++;
						}				
						rwsLocationBean.setHabName(rset.getString(2));
						rwsLocationBean.setPopulation(rset.getString(3));
						rwsLocationBean.setStatus(rset.getString(4));
					}
					else if(schemecode.equals("11")) {
						rwsLocationBean.setHabCode(rset.getString(1));
						rwsLocationBean.setHabMatch(rset.getString(1));					
						rwsLocationBean.setHabitationCode(rset.getString(1)+rset.getString(2));
						if(rset.getString(1)!=null) {
							habcodes[i]=rset.getString(1)+rset.getString(2);
							i++;
						}
						rwsLocationBean.setSchoolCode(rset.getString(2));
						rwsLocationBean.setSchoolName(rset.getString(3));
						rwsLocationBean.setSchoolLocation(rset.getString(4));
						rwsLocationBean.setSchoolClasification(rset.getString(5));
						//rwsLocationBean.setNoofStudents(rset.getString(6));
						//rwsLocationBean.setFacilities(rset.getString(7));
						rwsLocationBean.setPanchayatName(rset.getString(8));
					}else if(schemecode.equals("14")) {
						rwsLocationBean.setHabCode(rset.getString(1));
						rwsLocationBean.setHabMatch(rset.getString(1));					
						rwsLocationBean.setHabitationCode(rset.getString(1)+rset.getString(2));
						if(rset.getString(1)!=null) {
							habcodes[i]=rset.getString(1)+rset.getString(2);
							i++;
						}
						rwsLocationBean.setPiCode(rset.getString(2));
						rwsLocationBean.setPiLocation(rset.getString(3));
					//	rwsLocationBean.setSchoolLocation(rset.getString(4));
						rwsLocationBean.setPiCategory(rset.getString(4));
						rwsLocationBean.setPis_no_tap_conn(rset.getString(5));
						//rwsLocationBean.setFacilities(rset.getString(7));
						rwsLocationBean.setPanchayatName(rset.getString(6));
					}else if(schemecode.equals("13")) {
						rwsLocationBean.setHabCode(rset.getString(1));
						rwsLocationBean.setHabMatch(rset.getString(1));					
						rwsLocationBean.setHabitationCode(rset.getString(1)+rset.getString(2));
						if(rset.getString(1)!=null) {
							habcodes[i]=rset.getString(1)+rset.getString(2);
							i++;
						}
						rwsLocationBean.setSchoolCode(rset.getString(2));
						rwsLocationBean.setSchoolName(rset.getString(3));
					//	rwsLocationBean.setSchoolLocation(rset.getString(4));
						rwsLocationBean.setSchoolClasification(rset.getString(4));
						rwsLocationBean.setSchNoofTapConn(rset.getString(5));
						//rwsLocationBean.setFacilities(rset.getString(7));
						rwsLocationBean.setPanchayatName(rset.getString(6));
					}
					else if(schemecode.equals("12")){
						rwsLocationBean.setLabCode(rset.getString(1));
						if(rset.getString(1)!=null) {
							habcodes[i]=rset.getString(1);
							i++;
						}				
						rwsLocationBean.setLabCode(rset.getString(1));
						rwsLocationBean.setLabName(rset.getString(2));
						rwsLocationBean.setLocation(rset.getString(3));								
					}
					habs.add(rwsLocationBean);
				}catch(Exception e)	{
					Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative : \n" + e.getMessage());
				}
			}
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative : \n" + e.getMessage());			
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative finally : \n" + sqle.getMessage());
			}
		}
		return habs;
	}

	
	public String[] getSelectedHabitationsForAdminStrative1(String proposalId,String tabName,int size){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		String schemecode=proposalId.substring(6,8);
		ArrayList habs = new ArrayList();
		String[] habcodes=new String[size];
		try	{
			if(!(schemecode.equals("11")|| schemecode.equals("12")|| schemecode.equals("13")|| schemecode.equals("14"))){
				query = " SELECT distinct PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD, rws_admn_hab_lnk_tbl HL "
				  + " WHERE PR.panch_code = HL.hab_code "
				  + " AND PR.panch_code = HD.hab_code "
				  + " AND HL.work_id ='" +  proposalId + "'";
			}else if(schemecode.equals("11")){
				query =	" select s.hab_code,s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE  from "
				  + " rws_school_master_tbl s, rws_work_school_lnk_tbl  HL "
				  + " WHERE s.school_code = HL.school_code "
				  + " and s.hab_code=hl.hab_code  "
				  + " and work_id='"+proposalId+"'";
		    } else if(schemecode.equals("12"))   {
		    	query =	"SELECT  a.LAB_CODE,a.lab_name,location FROM  rws_water_quality_lab_tbl a, RWS_WORK_LAB_LNK_TBL b WHERE   a.lab_code=b.lab_code and  WORK_ID='"+proposalId+"'" ;
		    }else if(schemecode.equals("14")){
		    	query =	" select s.habcode,s.PI_ID,LOCATION,CATEGORY,NOS_TAP_CONNECTION ,panch_name  from "
						  + " IMIS_PUBLIC_INSTITUTIONS_TBL s, rws_work_pi_lnk_tbl  HL,rws_panchayat_raj_tbl b "
						  + " WHERE s.PI_ID = HL.PI_CODE "
						  + " and s.habcode=hl.hab_code and s.habcode=b.panch_code   "
						  + " and work_id='"+proposalId+"'";
				    }
		    else if(schemecode.equals("13")){
		    	query =	" select s.habcode,s.SCHOOL_ID,SCH_NAME,INSTITUTIONCATEGORY,NOS_TAP_CONNECTION ,panch_name  from "
						  + " IMIS_ANGANWADIES_TBL s, RWS_WORK_ANGANWADI_LNK_TBL  HL,rws_panchayat_raj_tbl b "
						  + " WHERE s.SCHOOL_ID = HL.ANGANWADI_CODE "
						  + " and s.habcode=hl.hab_code and s.habcode=b.panch_code   "
						  + " and work_id='"+proposalId+"'";
				    }
			conn = getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
		 	RwsLocationBean rwsLocationBean = null;
			int i=0;
			while(rset.next()){	
				try{				
					if(rset.getString(1)!=null)	{
						habcodes[i]=rset.getString(1);
						i++;
					}				
				} catch(Exception e){
					Debug.println("Exception "+e);
				}				
			}
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative1 : \n" + e.getMessage());			
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative1 finally : \n" + sqle.getMessage());
			}
		}
		return habcodes;
	}

	
	public ArrayList getSelectedHabitationsForAdminStrative2(String proposalId,String tabName){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;		
		String schemecode=proposalId.substring(6,8);

		ArrayList habs = new ArrayList();
		try{
			if(!(schemecode.equals("11")|| schemecode.equals("12")|| schemecode.equals("13")|| schemecode.equals("14"))){
				query = " SELECT distinct PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD, "+tabName+" HL "
				  + " WHERE PR.panch_code = HL.hab_code "
				  + " AND PR.panch_code = HD.hab_code "
				  + " AND HL.proposal_id ='" +  proposalId + "'";
			} else if(schemecode.equals("11")) {
				query =	" select s.hab_code,s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE,panch_name  from "
				  + " rws_school_master_tbl s, "+tabName+"  HL,rws_panchayat_raj_tbl b "
				  + " WHERE s.school_code = HL.school_code "
				  + " and s.hab_code=hl.hab_code and s.hab_code=b.panch_code   "
				  + " and proposal_id='"+proposalId+"'";
		    } else if(schemecode.equals("12")) {
		    	query =	"SELECT  a.LAB_CODE,a.LAB_NAME,a.LOCATION FROM  rws_water_quality_lab_tbl a, "+tabName+"  b WHERE   a.lab_code=b.lab_code and  proposal_ID='"+proposalId+"'" ;
		    }else if(schemecode.equals("14")) {
		    	query =	" select s.habcode,s.PI_ID,LOCATION,CATEGORY,NOS_TAP_CONNECTION ,panch_name  from "
						  + " IMIS_PUBLIC_INSTITUTIONS_TBL s, "+tabName+"  HL,rws_panchayat_raj_tbl b "
						  + " WHERE s.PI_ID = HL.PI_CODE "
						  + " and s.habcode=hl.hab_code and s.habcode=b.panch_code   "
						  + " and proposal_id='"+proposalId+"'";
		    
				/*query =	" select s.hab_code,s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE,panch_name  from "
						  + " rws_school_master_tbl s, "+tabName+"  HL,rws_panchayat_raj_tbl b "
						  + " WHERE s.school_code = HL.school_code "
						  + " and s.habcode=hl.hab_code and s.habcode=b.panch_code   "
						  + " and proposal_id='"+proposalId+"'";*/
				    }
			conn = getConn();
			String[] habcodes=new String[1000];
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
		 	RwsLocationBean rwsLocationBean = null;
			int i=0;
			while(rset.next()){	
				try{
					rwsLocationBean = new RwsLocationBean();
					if(!(schemecode.equals("11")|| schemecode.equals("12")|| schemecode.equals("13")|| schemecode.equals("14"))){
						rwsLocationBean.setHabCode(rset.getString(1));
						if(rset.getString(1)!=null){
							habcodes[i]=rset.getString(1);
							i++;
						}
						rwsLocationBean.setHabName(rset.getString(2));
						rwsLocationBean.setPopulation(rset.getString(3));
						rwsLocationBean.setStatus(rset.getString(4));
					} else if(schemecode.equals("11")) {
						rwsLocationBean.setHabCode(rset.getString(1)+rset.getString(2));
						rwsLocationBean.setHabMatch(rset.getString(1));
						rwsLocationBean.setHabitationCode(rset.getString(1)+rset.getString(2));
						if(rset.getString(1)!=null) {
							habcodes[i]=rset.getString(1);
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
					else if(schemecode.equals("12")){
						rwsLocationBean.setLabCode(rset.getString(1));
						if(rset.getString(1)!=null){
							habcodes[i]=rset.getString(1);
							i++;
					    }				
						rwsLocationBean.setLabCode(rset.getString(1));
						rwsLocationBean.setLabName(rset.getString(2));
						rwsLocationBean.setLocation(rset.getString(3));								
					}
					else if(schemecode.equals("14")) {
						rwsLocationBean.setHabCode(rset.getString(1)+rset.getString(2));
						rwsLocationBean.setHabMatch(rset.getString(1));
						rwsLocationBean.setHabitationCode(rset.getString(1)+rset.getString(2));
						if(rset.getString(1)!=null) {
							habcodes[i]=rset.getString(1);
							i++;
						}
						rwsLocationBean.setPiCode(rset.getString(2));
						rwsLocationBean.setPiLocation(rset.getString(3));
						rwsLocationBean.setPiCategory(rset.getString(4));
						rwsLocationBean.setPis_no_tap_conn(rset.getString(5));
						//rwsLocationBean.setPiAvailTapConn(rset.getString(6));
						//rwsLocationBean.setFacilities(rset.getString(7));
						rwsLocationBean.setPanchayatName(rset.getString(6));
					}
					habs.add(rwsLocationBean);
				}
				catch(Exception e){
					Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative2 : \n" + e.getMessage());
				}				
			}
		} catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative2 : \n" + e.getMessage());			
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative2 finally : \n" + sqle.getMessage());
			}
		}
		return habs;
	}
	
	//updated by swapna
	public String[] getSelectedHabitationsForAdminStrative2(String proposalId,String tabName,int size){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		String schemecode=proposalId.substring(6,8);
			ArrayList habs = new ArrayList();
			String[] habcodes=new String[size];
			try	{
				if(!(schemecode.equals("11")|| schemecode.equals("12")|| schemecode.equals("13")|| schemecode.equals("14"))){ 
					query = " SELECT distinct PR.panch_code, PR.panch_name, "
					  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
					  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
					  + " rws_habitation_directory_tbl HD, rws_admn_hab_lnk_tbl HL "
					  + " WHERE PR.panch_code = HL.hab_code "
					  + " AND PR.panch_code = HD.hab_code "
					  + " AND HL.work_id ='" +  proposalId + "'";
				}else if(schemecode.equals("11")) {
					query =	" select s.hab_code,s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE  from "
					  + " rws_school_master_tbl s, rws_work_school_lnk_tbl  HL "
					  + " WHERE s.school_code = HL.school_code "
					  + " and s.hab_code=hl.hab_code  "
					  + " and work_id='"+proposalId+"'";
			    }else if(schemecode.equals("14")) {
			    				    	
					query =	" select s.habcode,s.PI_ID,LOCATION,CATEGORY,NOS_TAP_CONNECTION from "
							  + " imis_public_institutions_tbl s, rws_work_pi_lnk_tbl  HL "
							  + " WHERE s.PI_ID = HL.PI_CODE "
							  + " and s.habcode=hl.hab_code  "
							  + " and work_id='"+proposalId+"'";
					    } 
				else if(schemecode.equals("12")) {
			    	query =	"SELECT  a.LAB_CODE,a.lab_name,location FROM  rws_water_quality_lab_tbl a, RWS_WORK_LAB_LNK_TBL b WHERE   a.lab_code=b.lab_code and  WORK_ID='"+proposalId+"'" ;
			    }			
				conn = getConn();		
				stat = conn.prepareStatement(query);
				rset = stat.executeQuery();
			 	RwsLocationBean rwsLocationBean = null;
				int i=0;
				while(rset.next()){	
					try{			
						if(rset.getString(1)!=null){
							habcodes[i]=rset.getString(1);
							i++;
						}			
					}
					catch(Exception e){
						Debug.println("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative2 "+e);
					}			
				}
			} catch(Exception e){	
				Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative2  :\n" + e.getMessage());			
			}
			finally	{	
				try{
					if(rset != null){	
						rset.close();
					}
					if(stat != null){	
						stat.close();
					}
					if(conn != null){	
						conn.close();
					}
				}catch(SQLException sqle){
					Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForAdminStrative2 finally :\n" + sqle.getMessage());
				}
			}
			return habcodes;
	}
	
	
	protected ArrayList getRevisedSanctionList(String officeCode,String workId,String plan,String augCode,String workCat,String assetCode){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		boolean added=false;
		try	{
			query = "select distinct adm.work_name,adm.work_id,ADMIN_NO ,to_char(ADMIN_DATE,'dd/mm/yyyy') ,SANCTION_AMOUNT ," +
				"REV_ADMIN_NO ,to_char(REV_ADMIN_DATE,'dd/mm/yyyy') ,REV_SANCTION_AMOUNT,adm.no_of_habs,rv.no_of_habs , c.circle_office_name,p.PROGRAMME_Name,s.SUBPROGRAMME_NAME ,At.TYPE_OF_ASSET_NAME," +
				"c.circle_office_code ,adm.office_code,d.division_office_name,w.category_name,pl.plan_name,aug.aug_new_name,sd.subdivision_office_name,adm.no_of_schools,rv.no_of_schools ,adm.no_of_labs,rv.no_of_labs,rv.lead_habitation,adm.NO_OF_PIS, rv.NO_OF_PIS " +
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
			if(workId!=null && !workId.equals("")){
				query=query+" and adm.WORK_ID='"+workId+"'";
			}			
			if(!plan.equals("")){
				query=query+" and adm.PLAN_CODE='"+plan+"'";
			}
			if(!augCode.equals("")){
				query=query+" and adm.AUG_NEW_CODE='"+augCode+"'";
			}
			if(!workCat.equals("")){
				query=query+" and adm.CATEGORY_CODE ='"+workCat+"'";
			}
			if(!assetCode.equals("")){
				query=query+" and adm.TYPE_OF_ASSET ='"+assetCode+"'";
			}			 
			query=query+" order by adm.work_name ";			
	 		conn = getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			representativeProposals = new ArrayList();			
			while(rset.next()){
				proposalDTO = new ProposalDTO();
				String code=rset.getString(2).substring(6,8);
				if(!(code.equals("11")|| code.equals("12")|| code.equals("13")|| code.equals("14"))){
					proposalDTO.setNoOfHabs(rset.getString(9));
					proposalDTO.setRevNoOfHabs(rset.getString(10));
				}
				else if(code.equals("11")){
					proposalDTO.setNoOfHabs(rset.getString(22));
					proposalDTO.setRevNoOfHabs(rset.getString(23));
		 		}
				else if(code.equals("12")){
					proposalDTO.setNoOfHabs(rset.getString(24));
					proposalDTO.setRevNoOfHabs(rset.getString(25));
	 			}else if(code.equals("14")){
					proposalDTO.setNoOfHabs(rset.getString(27));
					proposalDTO.setRevNoOfHabs(rset.getString(28));
	 			}
				proposalDTO.setProposalName(rset.getString(1));
				proposalDTO.setProposalId(rset.getString(2));
				proposalDTO.setAdminNo(rset.getString(3));
				proposalDTO.setAdminDate(rset.getString(4));
				proposalDTO.setSanctionedAmount(rset.getString(5));
				proposalDTO.setRevAdminNo(rset.getString(6));
				proposalDTO.setRevAdminDate(rset.getString(7));
				proposalDTO.setRevSanctionedAmount(rset.getString(8));
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
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getRevisedSanctionList : \n" + e.getMessage());			
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO getRevisedSanctionList finally : \n" + sqle.getMessage());
			}
		}
		return representativeProposals;
	}
	//....
	public  void  getHabsForRevisedWorkId(String workId  ) 
	 throws Exception
		{
		Connection conn=null;
		try
		{
	     Debug.println("in getting habs for workId");
		 conn=RwsOffices.getConn();
		 conn.setAutoCommit(false);
		 Statement stmt=conn.createStatement();
		 deleteTempSelectedHabs();
		 Statement stmt2=conn.createStatement();
		 query="select distinct work_id,hab_code from RWS_REV_ADM_SANC_HAB_LNK_TBL where work_id='"+workId+"'";
		 Debug.println("Query is"+query);
		 ResultSet rs=stmt.executeQuery(query);
		
	     while(rs.next())
	     {
		 query1="  insert into rws_temp_proposal_hab_tbl(PROPOSAL_ID ,hab_code)values" +
		 		"('"+rs.getString(1)+"','"+rs.getString(2)+"')";
		 
		 Debug.println("Query 2"+query1);
		 stmt2.addBatch(query1);
	     }
 	     int[] val=stmt2.executeBatch();
 	     boolean value=true;
 	     for(int i=0;i<val.length;i++)
 	     {
 	     	if(val[i]==0)
 	     	value=false;
 	     }
 	     if(value)
 	     {
 	     	conn.commit();
 	     }
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

	
	public  void  getHabsForRevisedWorkIdToSession(HttpSession session,String workId) throws Exception{
		String code=workId.substring(6,8);
		Connection conn=null;
		PreparedStatement stmt=null;
		try	{
		     conn=RwsOffices.getConn();
			 conn.setAutoCommit(false);
			 deleteTempSelectedHabs();
			 if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))){
				 query="select distinct work_id,hab_code from RWS_REV_ADM_SANC_HAB_LNK_TBL where work_id= ? ";
			 }
			 else if(code.equals("11")){
			 	query="select distinct work_id,hab_code,school_code from RWS_REV_SCHOOL_LNK_TBL where work_id= ? ";
			 }
			 else if(code.equals("12")){
			 	query="select distinct work_id,lab_code from RWS_REV_LAB_LNK_TBL where work_id= ? ";
			 } else if(code.equals("14")){
				 	query="select distinct work_id,hab_code,pi_code from RWS_REV_PI_LNK_TBL where work_id= ? ";
				 }
			 stmt=conn.prepareStatement(query);
			 stmt.setString(1, workId);
			 ResultSet rs=stmt.executeQuery();
			 ArrayList selectedHabCodesForRevisedAdmnSanc=new ArrayList();
			 while(rs.next()){
					RwsLocationBean rwsLocationBean=new RwsLocationBean();
					if(!(code.equals("11") ||code.equals("12")||code.equals("13")||code.equals("14"))){
						rwsLocationBean.setHabCode(rs.getString("hab_code"));
						rwsLocationBean.setProposalId(rs.getString("work_id"));
					}
					else if(code.equals("11")){
						rwsLocationBean.setHabCode(rs.getString("hab_code")+rs.getString("school_code"));
						rwsLocationBean.setProposalId(rs.getString("work_id"));
						rwsLocationBean.setSchoolCode(rs.getString("school_code"));
					}
					else if(code.equals("12")){
						rwsLocationBean.setProposalId(rs.getString("work_id"));
						rwsLocationBean.setHabCode(rs.getString("lab_code"));
					}else if(code.equals("14")){
						rwsLocationBean.setHabCode(rs.getString("hab_code")+rs.getString("pi_code"));
						rwsLocationBean.setProposalId(rs.getString("work_id"));
						rwsLocationBean.setPiCode(rs.getString("pi_code"));
					}
					selectedHabCodesForRevisedAdmnSanc.add(rwsLocationBean);
				}
			  session.setAttribute("tempSelectedAdmnHabs",selectedHabCodesForRevisedAdmnSanc);
			}
			catch(Exception e){
				Debug.println("The Exceptin is in ProposalDAO getHabsForRevisedWorkIdToSession : "+e.getMessage());
			}
			finally{
				stmt.close();
				conn.close();
			}
		}
	
	
	public ArrayList getSelectedHabitationsForRevised(String proposalId){
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		String code=proposalId.substring(6,8);
		ArrayList habs = new ArrayList();
		try	{
			if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))	{
				query = " SELECT PR.panch_code, PR.panch_name, "
					  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
					  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
					  + " rws_habitation_directory_tbl HD, RWS_REV_ADM_SANC_HAB_LNK_TBL  HL "
					  + " WHERE PR.panch_code = HL.hab_code "
					  + " AND PR.panch_code = HD.hab_code "
					  + " AND HL.work_id ='" +  proposalId + "'";
		    }else if (code.equals("11")){
	    		query = "select s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE  from "
	  			  + " rws_school_master_tbl s,  RWS_REV_SCHOOL_LNK_TBL HL "
	  			  + " WHERE s.school_code = HL.school_code "
	  			  + " and s.hab_code=hl.hab_code  "
	  			  + " AND HL.work_id ='" +  proposalId + "'";
		    }else if(code.equals("12")){
	    		query = "SELECT l.LAB_CODE,LAB_NAME,LOCATION from "
	  			  + " RWS_WATER_QUALITY_LAB_TBL L, RWS_REV_LAB_LNK_TBL  HL "
	  			  + " WHERE L.LAB_CODE = HL.LAB_code "
	  			  + " AND HL.work_id ='" +  proposalId + "'";
		    }else if (code.equals("14")){
		    	query =	" select s.PI_ID,LOCATION,CATEGORY,NOS_TAP_CONNECTION from "
						  + " imis_public_institutions_tbl s, RWS_REV_pi_LNK_TBL  HL "
						  + " WHERE s.PI_ID = HL.PI_CODE "
						  + " and s.habcode=hl.hab_code  "
						  + " and HL.work_id='"+proposalId+"'";
		    
	    		/*query = "select s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE  from "
	  	  			  + " rws_school_master_tbl s,  RWS_REV_SCHOOL_LNK_TBL HL "
	  	  			  + " WHERE s.school_code = HL.school_code "
	  	  			  + " and s.hab_code=hl.hab_code  "
	  	  			  + " AND HL.work_id ='" +  proposalId + "'";*/
	  		    }					
			conn = getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while(rset.next()){
				rwsLocationBean = new RwsLocationBean();
				if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))	{						
					rwsLocationBean.setHabCode(rset.getString(1));
					rwsLocationBean.setHabName(rset.getString(2));
					rwsLocationBean.setPopulation(rset.getString(3));
					rwsLocationBean.setStatus(rset.getString(4));
			    }
				else if(code.equals("11")){
					rwsLocationBean.setSchoolCode(rset.getString(1));
					rwsLocationBean.setSchoolName(rset.getString(2));
					rwsLocationBean.setSchoolLocation(rset.getString(3));
					rwsLocationBean.setSchoolClasification(rset.getString(4));
					rwsLocationBean.setNoofStudents(rset.getString(5));
					rwsLocationBean.setFacilities(rset.getString(6));
				}
				else if(code.equals("12")){
					rwsLocationBean.setLabCode(rset.getString(1));
					rwsLocationBean.setLabName(rset.getString(2));
					rwsLocationBean.setLocation(rset.getString(3));
				}else if(code.equals("14")){
					rwsLocationBean.setPiCode(rset.getString(1));
					rwsLocationBean.setPiLocation(rset.getString(2));
					rwsLocationBean.setPiCategory(rset.getString(3));
					rwsLocationBean.setPis_no_tap_conn(rset.getString(4));
					
				}
				habs.add(rwsLocationBean);
			}
		}
		catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForRevised : \n" + e.getMessage());			
		}
		finally{	
			try{
				if(rset != null) {	
					rset.close();				
				}
				if(stat != null) {
					stat.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO getSelectedHabitationsForRevised finally : \n" + sqle.getMessage());
			}
		}
		return habs;
	}
	
	public ArrayList getAdminstativeSanctionedWorkIds(String headOfficeCode, String circleOfficeCode,String  DivisionCode,String ty,String prog,String subProg) 
	 throws Exception
		{
			ArrayList workIds = new ArrayList();
			Connection conn=null;
			try
			{
				query = " select distinct ad.work_id,ad.work_name ,ad.office_code from rws_work_admn_tbl ad where " +
						"substr(ad.WORK_ID,5,2)='"+circleOfficeCode+"'" +
					    " and substr(ad.work_id,1,2)='"+prog+"'" +
					    " and substr(ad.work_id,3,2)='"+subProg+"'" +
					    " and substr(ad.work_id,7,2)='"+ty+"' and ad.work_id not in (select work_id from RWS_REVISED_ADM_SANC_TBL)";
				/*query1=	" and substr(office_code,4,1)='"+DivisionCode+"'";
				if(!DivisionCode.equals(""))
				{
					query=query+query1;
				}*/
				Debug.println("query is "+query);
				conn = getConn();
				Statement stat = conn.createStatement();
				ResultSet rset = stat.executeQuery(query);
				
				while(rset.next())
				{
					LabelValueBean labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					workIds.add(labelValueBean);
				}
			}
			catch(Exception e)
			{
				Debug.println("Exceptin is"+e);
			}
			finally
			{	 
				conn.close();
				
			}
			return workIds;
		}
	
	
	public ProposalHolder getWorkDetails(String workId ,String workName) throws Exception {
 		ProposalHolder	proposalHolder=null;
 		String scheme1=workId.substring(6,8);
 		Connection conn=null;
		try	{
			query = " select distinct work_name, work_id ,ADMIN_NO ,to_char(ADMIN_DATE,'dd/mm/yyyy'),SANCTION_AMOUNT ";
			if(!(scheme1.equals("11")|| scheme1.equals("12")|| scheme1.equals("13")|| scheme1.equals("14"))) {
				query += ",NO_OF_HABS";
			}
			else if(scheme1.equals("11")){
				query += ",NO_OF_SCHOOLS";
 			}
			else if(scheme1.equals("12")){
				query += ",NO_OF_LABS";
 			}else if(scheme1.equals("14")){
				query += ",NO_OF_PIS";
 			}
			query += " from rws_work_admn_tbl where work_id= ? " ;
 			conn = getConn();
			PreparedStatement stat = conn.prepareStatement(query);
			stat.setString(1, workId);
			ResultSet rset = stat.executeQuery();
			proposalHolder = new ProposalHolder();
			if(rset.next())	{
				proposalHolder.setWorkName(workName); 
				proposalHolder.setProposalName(rset.getString(2)); 
				proposalHolder.setProposalId(rset.getString(2)); 
				proposalHolder.setAdminiStrativeNum(rset.getString(3)); 
				proposalHolder.setAdminiStrativeDate(rset.getString(4)); 
				proposalHolder.setSanctionAmout(rset.getString(5)); 
				proposalHolder.setNoOfHabs(rset.getString(6)); 
			}
			if(rset != null){
				rset.close();
			}
			if(stat != null){
				stat.close();
			}
		} catch(Exception e){
			Debug.println("The Exceptin is in ProposalDAO getWorkDetails : "+e.getMessage());
		}
		finally	{	 
			conn.close();
		}
		return proposalHolder;
	}
	
	public  void  getHabsForWorkId(String workId ,String workName) 
	 throws Exception
		{
		 
			Connection conn=null;
			try
			{
		     Debug.println("in getting habs for workId");
			 conn=RwsOffices.getConn();
			 conn.setAutoCommit(false);
			 Statement stmt=conn.createStatement();
			 deleteTempSelectedHabs();
			 Statement stmt2=conn.createStatement();
			 query="select distinct work_id,hab_code from rws_admn_hab_lnk_tbl where work_id='"+workId+"'";
			 Debug.println("Query is"+query);
			 ResultSet rs=stmt.executeQuery(query);
			
		     while(rs.next())
		     {
			 query1="  insert into rws_temp_proposal_hab_tbl(PROPOSAL_ID ,hab_code)values" +
			 		"('"+rs.getString(1)+"','"+rs.getString(2)+"')";
			 
			 Debug.println("Query 2"+query1);
			 stmt2.addBatch(query1);
		     }
	 	     int[] val=stmt2.executeBatch();
	 	     boolean value=true;
	 	     for(int i=0;i<val.length;i++)
	 	     {
	 	     	if(val[i]==0)
	 	     	value=false;
	 	     }
	 	     if(value)
	 	     {
	 	     	conn.commit();
	 	     }
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

	
	public  ArrayList  getHabsForWorkId2(String workId ,String workName) throws Exception {
		ArrayList admnSancSelectedHabs=new ArrayList();
	 	String code=workId.substring(6,8);
		Connection conn=null;
		try	{
			 conn=RwsOffices.getConn();
			 conn.setAutoCommit(false);
			 deleteTempSelectedHabs();
			 if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))){ 
			 	query="select distinct work_id,hab_code from rws_admn_hab_lnk_tbl where work_id= ? ";			 	
			 }
			 else if(code.equals("11")){
			 	query="select work_id,hab_code,school_code  from rws_work_school_lnk_tbl  where  work_id= ? ";			 	
			 }
			 else if(code.equals("12"))	 {
			 	query="select  * from rws_work_lab_lnk_tbl where work_id= ? ";			 	
			 } else if(code.equals("14")){
				 	query="select work_id,hab_code,pi_code  from rws_work_pi_lnk_tbl  where  work_id= ? ";			 	
				 }
			 PreparedStatement stmt=conn.prepareStatement(query);	
			 stmt.setString(1, workId);
			 ResultSet rs=stmt.executeQuery();			
		     while(rs.next()) {
				RwsLocationBean rwsLocationBean=new RwsLocationBean();
		     	if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))) {
			     	rwsLocationBean.setProposalId(rs.getString(1));
			     	rwsLocationBean.setHabCode(rs.getString(2));
				}
		     	else if(code.equals("11")){
		     	 	rwsLocationBean.setProposalId(rs.getString(1));
		     	 	rwsLocationBean.setHabCode(rs.getString(2)+rs.getString(3));
			     	rwsLocationBean.setSchoolCode(rs.getString(3));			     	
				}
		     	else if(code.equals("12")){
		     	 	rwsLocationBean.setProposalId(rs.getString(1));
			     	rwsLocationBean.setHabCode(rs.getString(2));
		     	}else if(code.equals("14")){
		     	 	rwsLocationBean.setProposalId(rs.getString(1));
		     	 	rwsLocationBean.setHabCode(rs.getString(2)+rs.getString(3));
			     	rwsLocationBean.setPiCode(rs.getString(3));			     	
				}
		     	admnSancSelectedHabs.add(rwsLocationBean);
		     }
		     if(rs != null){
				rs.close();
			}
			if(stmt != null){
				stmt.close();
			}		     
		}
		catch(Exception e){
			Debug.println("The Exception is in ProposalDAO getHabsForWorkId2 : "+e.getMessage());
		}
		finally	{	 
				conn.close();
		}
		return admnSancSelectedHabs;
	}
	
	//////////////////////////////////////////////////////////
//	added fro prajapadam////////////////
	public Rws_Prajapadam_Bean getHabDetils(String HabCode) 
	
    {
		Rws_Prajapadam_Bean bean=new Rws_Prajapadam_Bean();
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
 
	 	 
	 	try
		{	
	 		conn=RwsOffices.getConn();
	 		stat=conn.createStatement();
	 		ResultSet rs=stat.executeQuery("select  decode(EXIST_CPWS,'Y','on') ," +
	 				"decode(EXIST_PWS,'Y','on') ,decode(EXIST_DIRECT_PUMPING,'Y','on'),decode(EXIST_BOREWELLS ,'Y','on')," +
	 				"decode(EXIST_OTHERS,'Y','on') ,OTHER_DETAILS " +
	 				" from  RWS_PRAJAPADAM_EXIST_SCH_TBL  where hab_code='"+HabCode+"'");
	 		
	 		//Debug.println("select  decode(EXIST_CPWS,'Y','on') ," +
	 			//	"decode(EXIST_PWS,'Y','on') ,decode(EXIST_DIRECT_PUMPING,'Y','on'),decode(EXIST_BOREWELLS ,'Y','on')," +
	 			//	"decode(EXIST_OTHERS,'Y','on') ,OTHER_DETAILS " +
	 			//	" from  RWS_PRAJAPADAM_EXIST_SCH_TBL  where hab_code='"+HabCode+"'");
	 		while(rs.next())
	 		{
	 			bean.setCpws(rs.getString(1));
	 			bean.setPws(rs.getString(2));
	 			bean.setDirectPump(rs.getString(3));
	 			bean.setBoreWells(rs.getString(4));
	 			bean.setOthers(rs.getString(5));
	 			bean.setOthersValue(rs.getString(6));
	 			 
	 			 
	 		}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in gethab exist details : \n" + e);			
		}
		finally
		{	if(rset != null)
			{	try
				{	rset.close();
				}
				catch(SQLException sqle){
				}
			}
			if(stat != null)
			{	try
				{	stat.close();
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
		return bean;
}	
		
	public String getNextWorkIdForPrajapadam(String headOfficecode,String districtCode,String typeOfAsset,String programmeCode,String subprogrammeCode) 
		
	    {
			Connection conn = null;
			Statement stat = null;
			ResultSet rset = null;

			java.util.Date date = new java.util.Date();
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yy");
			String currentYear = dateFormatter.format(date);
			Debug.println("4444444444444444"+districtCode+programmeCode+subprogrammeCode+typeOfAsset);
			String workId = null;
		 	 
		 	try
			{	
		 		conn=RwsOffices.getConn();
		 		stat=conn.createStatement();
		 		if(subprogrammeCode .equals(""))
					subprogrammeCode = "00";

				if(programmeCode.equals("") || districtCode .equals("") ||	typeOfAsset.equals(""))
					return new String("false");
				//programmeCode= (""+Integer.parseInt(programmeCode)).trim();
				subprogrammeCode= (""+Integer.parseInt(subprogrammeCode)).trim();
				
				workId = programmeCode + subprogrammeCode +"P"+ districtCode 
					   + typeOfAsset + currentYear;

				 query = " SELECT MAX(SUBSTR(work_id,11,4)) FROM RWS_PRAJAPADAM_TBL " +
				 		 " WHERE WORK_ID LIKE '"+workId+"%'"; 
	 		 	
				Debug.println("query is "+query);
				rset = stat.executeQuery(query);
				 
				if(rset.next())
				{    
					int	sno=rset.getInt(1);
				 	Debug.println("SNO"+sno);
					if(sno == 0)
						workId = workId + "0001";
					else
					{
						if(sno >= 9999)
							throw new Exception("No more WORK ID left.");
						else
						{
							String tempSno = null;
							if(sno<9)
								tempSno = "000"+(sno+1);
							else
							if(sno<99)
								tempSno = "00"+(sno+1);
							else
							if(sno<999)
								tempSno = "0"+(sno+1);
							else
								tempSno = String.valueOf(sno+1);
							
							workId =  workId + String.valueOf(tempSno);
						}
					}
				}
				 Debug.println("Work Id for   is : " + workId);
			}
			catch(Exception e)
			{	Debug.writeln("Exception in getWorkId : \n" + e);			
			}
			finally
			{	if(rset != null)
				{	try
					{	rset.close();
					}
					catch(SQLException sqle){
					}
				}
				if(stat != null)
				{	try
					{	stat.close();
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
	public  boolean  getHabExistence(String habCode) 
	throws Exception
		{
		  boolean value=true;
			Connection conn=null;
			try
			{
		     Debug.println("in insertPrajaPadamDetails");
			 conn=RwsOffices.getConn();
			 conn.setAutoCommit(false);
			 
			 Statement stmt2=conn.createStatement();
		 	 ResultSet rs=stmt2.executeQuery("select * from RWS_PRAJAPADAM_EXIST_SCH_TBL where hab_code='"+habCode+"'");
		 	 if(rs.next())
		 	 {
		 	 	value=true;
		 	 }
			 else
			 {
			 	value=false;
			 }
		 	     
			}
			catch(Exception e)
			{
				Debug.println("Exceptin is"+e);
				value=false;
			}
			finally
			{	 
				conn.close();
			}
			return value; 
		}
	public  boolean  insertPrajaPadamDetails(String query1 ,String query2,String workName,String workId,String user) 
		 throws Exception
			{
			  boolean value=true;
				Connection conn=null;
				try
				{
			     Debug.println("in insertPrajaPadamDetails");
				 conn=RwsOffices.getConn();
				 conn.setAutoCommit(false);
				 
				 Statement stmt2=conn.createStatement();
			 	 stmt2.addBatch(query1);
				 stmt2.addBatch(query2);
			 	// stmt2.addBatch("insert into rws_work_admn_tbl (work_id,work_name,FLAG,office_code,no_of_habs)values('"+workId+"','"+workName+"','P','"+user+"','0')");
		 	     int[] val=stmt2.executeBatch();
		 	    
		 	     for(int i=0;i<val.length;i++)
		 	     {
		 	     	if(val[i]==0)
		 	     	value=false;
		 	     }
		 	     if(value)
		 	     {
		 	     	conn.commit();
		 	     }
				}
				catch(Exception e)
				{
					Debug.println("Exceptin is"+e);
					value=false;
				}
				finally
				{	 
					conn.close();
				}
				return value; 
			}

////////////////////////////////////	//
	///Added for work wise report
	

	public ArrayList getWorkIds(String circle,String prog,String subProg,String typAsset,String workcat,String plan,String wrktype)throws Exception 
		{
			Debug.println("in geting work id s for report");
			Connection conn=null;
			Statement stat = null;
			ResultSet rset = null;
			
		 	ArrayList workIds = new ArrayList();
		 	ProposalHolder	proposalHolder=null;
		 	
		 	java.util.Date date = new java.util.Date();
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yy");
			String currentYear = dateFormatter.format(date);
		     
			try
			{
				  conn = getConn();
				
				query="select distinct Work_name,work_id from rws_work_admn_tbl " +
					"where work_id like'%"+prog+subProg+circle+typAsset+"%' and category_code='"+workcat+"' and aug_new_code='"+wrktype+"' and plan_code='"+plan+"'";
				Debug.println("query is "+query);
				stat=conn.createStatement();
				rset=stat.executeQuery(query);
				while(rset.next())
				{
					proposalHolder=new ProposalHolder();
					proposalHolder.setWorkId(rset.getString(1));	
					proposalHolder.setWorkName(rset.getString(2));
					workIds.add(proposalHolder);
				}
	 
			}
			catch(Exception e)
			{	Debug.writeln("Exception in getting workIds :\n" + e);			
			}
			finally
			{	if(rset != null)
				{	try
					{	rset.close();
					}
					catch(SQLException sqle){
					}
				}
				if(stat != null)
				{	try
					{	stat.close();
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
			return workIds;
		
		}
	
	
	
	protected ArrayList getWorkWiseList( String workId)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		try
		{
			query = " select distinct ad.WORK_NAME,ad.ESTIMATE_COST ,ad.SANCTION_AMOUNT ,ad.TYPE_OF_ASSET" +
					" , ad.NO_OF_HABS ,p.PROGRAMME_NAME,count( distinct(substr(ah.HAB_CODE ,3,3)))" +
					",count( distinct(substr(ah.HAB_CODE ,6,2)))," +
					"count(distinct(substr(hab_code,8,3)))  from RWS_WORK_ADMN_TBL ad,rws_programme_tbl P, " +
					"rws_admn_hab_lnk_tbl ah  where   ah.work_id=ad.work_id and P.PROGRAMME_CODE=ad.PROGRAMME_CODE " +
					" and ad.work_Id='" +workId+"'"+
					"   group by ad.WORK_NAME,ad.ESTIMATE_COST ,ad.SANCTION_AMOUNT   ,ad.TYPE_OF_ASSET ," +
					"ah.hab_code,ad.NO_OF_HABS,p.PROGRAMME_NAME    " ; 
 		    Debug.println("Query is "+query);
	 		conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			representativeProposals = new ArrayList();
			proposalDTO = new ProposalDTO();
			if(rset.next())
			{
	 			proposalDTO.setProposalName(rset.getString(1));
			 	proposalDTO.setEstimateCost(rset.getString(2));
				proposalDTO.setSanctionedAmount(rset.getString(3)); 
				proposalDTO.setTypeOfAsset(rset.getString(4));
				proposalDTO.setNoOfHabs(rset.getString(5));
		 		proposalDTO.setProgrammeName(rset.getString(6));
		 		proposalDTO.setNoOfConst(rset.getString(7));
			 	proposalDTO.setMandalsCout(rset.getString(8));
				proposalDTO.setVillagesCount(rset.getString(9));
	 	 	}
			///////////////////////////////////////////////////////////////////////////////
			query="select count(QUALITY_AFFECTED)," +
					"CASE WHEN HC.CONT_TYPE LIKE '%FLOURIDE%'THEN COUNT(HC.HAB_CODE)END," +
					" CASE WHEN HC.CONT_TYPE LIKE '%BRACKISH%'THEN COUNT(HC.HAB_CODE)END" +
					" from RWS_REV_ADM_SANC_HAB_LNK_TBL   ah,rws_habitation_directory_tbl h," +
					" RWS_HAB_CONTAMINATION_TBL HC where   h.hab_code=ah.hab_code and  " +
					" QUALITY_AFFECTED='Y' and HC.HAB_CODE=AH.HAB_CODE AND ah.work_id='"+workId+"'" +
					" GROUP BY QUALITY_AFFECTED,HC.CONT_TYPE";
			
		    Debug.println("Query is "+query);
		    rset = stat.executeQuery(query);
			while(rset.next()) 
			{
				if(rset.getString(1)!=null)
				proposalDTO.setQaAdmHabs(rset.getString(1));
				if(rset.getString(2)!=null)
					proposalDTO.setAdmFlouride(rset.getString(2));
				if(rset.getString(3)!=null)
					proposalDTO.setAdmBrackish(rset.getString(3));
			}
			
					query="select count(QUALITY_AFFECTED)," +
					"CASE WHEN HC.CONT_TYPE LIKE '%FLOURIDE%'THEN COUNT(HC.HAB_CODE)END," +
					" CASE WHEN HC.CONT_TYPE LIKE '%BRACKISH%'THEN COUNT(HC.HAB_CODE)END" +
					" from RWS_EST_NEW_HAB_LNK_TBL  ah,rws_habitation_directory_tbl h," +
					" RWS_HAB_CONTAMINATION_TBL HC where   h.hab_code=ah.hab_code and  " +
					" QUALITY_AFFECTED='Y' and HC.HAB_CODE=AH.HAB_CODE AND ah.work_id='"+workId+"'" +
					" GROUP BY QUALITY_AFFECTED,HC.CONT_TYPE";
	
			    Debug.println("Query is "+query);
			    rset = stat.executeQuery(query);
				while(rset.next()) 
				{
					if(rset.getString(1)!=null)
					proposalDTO.setQaTecHabs(rset.getString(1));
					if(rset.getString(2)!=null)
						proposalDTO.setTecFlouride(rset.getString(2));
					if(rset.getString(3)!=null)
						proposalDTO.setTecBrackish(rset.getString(3));
				}
					query="select count(QUALITY_AFFECTED)," +
					"CASE WHEN HC.CONT_TYPE LIKE '%FLOURIDE%'THEN COUNT(HC.HAB_CODE)END," +
					" CASE WHEN HC.CONT_TYPE LIKE '%BRACKISH%'THEN COUNT(HC.HAB_CODE)END" +
					" from RWS_REV_ADM_SANC_HAB_LNK_TBL  ah,rws_habitation_directory_tbl h," +
					" RWS_HAB_CONTAMINATION_TBL HC where   h.hab_code=ah.hab_code and  " +
					" QUALITY_AFFECTED='Y' and HC.HAB_CODE=AH.HAB_CODE AND ah.work_id='"+workId+"'" +
					" GROUP BY QUALITY_AFFECTED,HC.CONT_TYPE";
	
			    Debug.println("Query is "+query);
			    rset = stat.executeQuery(query);
					while(rset.next()) 
					{
						if(rset.getString(1)!=null)
						proposalDTO.setQaRevHabs(rset.getString(1));
						if(rset.getString(2)!=null)
							proposalDTO.setRevFlouride(rset.getString(2));
						if(rset.getString(3)!=null)
							proposalDTO.setRevBrackish(rset.getString(3));
					}
					query="select count(QUALITY_AFFECTED)," +
					"CASE WHEN HC.CONT_TYPE LIKE '%FLOURIDE%'THEN COUNT(HC.HAB_CODE)END," +
					" CASE WHEN HC.CONT_TYPE LIKE '%BRACKISH%'THEN COUNT(HC.HAB_CODE)END" +
					" from RWS_REV_EST_NEW_HAB_LNK_TBL  ah,rws_habitation_directory_tbl h," +
					" RWS_HAB_CONTAMINATION_TBL HC where   h.hab_code=ah.hab_code and  " +
					" QUALITY_AFFECTED='Y' and HC.HAB_CODE=AH.HAB_CODE AND ah.work_id='"+workId+"'" +
					" GROUP BY QUALITY_AFFECTED,HC.CONT_TYPE";

				    Debug.println("Query is "+query);
				    rset = stat.executeQuery(query);
					while(rset.next()) 
					{
						if(rset.getString(1)!=null)
						proposalDTO.setQaRevTecHabs(rset.getString(1));
						if(rset.getString(2)!=null)
							proposalDTO.setRevTecFlouride(rset.getString(2));
						if(rset.getString(3)!=null)
							proposalDTO.setRevTecBrackish(rset.getString(3));
					}
			///////////////////////////////////////////////////////////////////////////////////////////
			query="select " +
					"case  when COVERAGE_STATUS ='NC' then count(COVERAGE_STATUS) End," +
					"case  when COVERAGE_STATUS ='PC1' then count(COVERAGE_STATUS) End," +
					"case  when COVERAGE_STATUS ='PC2' then count(COVERAGE_STATUS) End," +
					" case  when COVERAGE_STATUS ='PC3' then count(COVERAGE_STATUS) End," +
					" case  when COVERAGE_STATUS ='PC4' then count(COVERAGE_STATUS) End," +
					"case  when COVERAGE_STATUS ='FC' then count(COVERAGE_STATUS) End " +
					" from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl h where" +
					"   h.hab_code=ah.hab_code  and ah.work_id='"+workId+"' group by COVERAGE_STATUS";
			Debug.println("Query is "+query);
			rset=stat.executeQuery(query);
			while(rset.next())
			{
				if(rset.getString(1)!=null)
				proposalDTO.setNcCountAdm(rset.getString(1));
				if(rset.getString(2)!=null)
				proposalDTO.setPc1CountAdm(rset.getString(2));
				if(rset.getString(3)!=null)
				proposalDTO.setPc2CountAdm(rset.getString(3));
				if(rset.getString(4)!=null)
				proposalDTO.setPc3CountAdm(rset.getString(4));
				if(rset.getString(5)!=null)
				proposalDTO.setPc4CountAdm(rset.getString(5));
				if(rset.getString(6)!=null)
				proposalDTO.setFcCountAdm(rset.getString(6));
 		     }
			
			query="select  " +
			"case  when COVERAGE_STATUS ='NC' then count(COVERAGE_STATUS) End," +
			"case  when COVERAGE_STATUS ='PC1' then count(COVERAGE_STATUS) End," +
			"case  when COVERAGE_STATUS ='PC2' then count(COVERAGE_STATUS) End," +
			" case  when COVERAGE_STATUS ='PC3' then count(COVERAGE_STATUS) End," +
			" case  when COVERAGE_STATUS ='PC4' then count(COVERAGE_STATUS) End," +
			"case  when COVERAGE_STATUS ='FC' then count(COVERAGE_STATUS) End," +
			" count(ah.hab_code),es.TS_AMOUNT " +
			" from rws_est_new_hab_lnk_tbl ah,rws_new_est_tbl es,rws_habitation_directory_tbl h where" +
			"   h.hab_code=ah.hab_code  and ah.work_id='"+workId+"' and es.work_id=ah.work_Id" +
					" group by COVERAGE_STATUS,ah.hab_code,es.TS_AMOUNT";
	        Debug.println("Query is "+query);
	        
	        rset=stat.executeQuery(query);
	        
			while(rset.next())
			{ 
				 
				if(rset.getString(1)!=null)
				{
			 	 proposalDTO.setNcCountTec((rset.getInt(1))+Integer.parseInt(formatNull(proposalDTO.getNcCountTec()))+"");
				}
				if(rset.getString(2)!=null)
				{
				 proposalDTO.setPc1CountTec(rset.getInt(2)+Integer.parseInt(formatNull(proposalDTO.getPc1CountTec()))+"");
				}
				if(rset.getString(3)!=null)
				{
				 proposalDTO.setPc2CountTec(rset.getInt(3)+Integer.parseInt(formatNull(proposalDTO.getPc2CountTec()))+"");
				}
				if(rset.getString(4)!=null)
				{
				 proposalDTO.setPc3CountTec(rset.getInt(4)+Integer.parseInt(formatNull(proposalDTO.getPc3CountTec()))+"");
				}
				if(rset.getString(5)!=null)
				{
				 proposalDTO.setPc4CountTec(rset.getInt(5)+Integer.parseInt(formatNull(proposalDTO.getPc4CountTec()))+"");
				}
				if(rset.getString(6)!=null)
				{
				 proposalDTO.setFcCountTec(rset.getInt(6)+Integer.parseInt(formatNull(proposalDTO.getFcCountTec()))+"");
				}
				if(rset.getString(7)!=null)
				{
				 proposalDTO.setNoOfTechHabs(rset.getInt(7)+Integer.parseInt(formatNull(proposalDTO.getNoOfTechHabs()))+"");
				}	
				if(rset.getString(8)!=null)
					proposalDTO.setTsAmount(rset.getString(8));
 		     }
			query="select " +
			"case  when COVERAGE_STATUS ='NC' then count(COVERAGE_STATUS) End," +
			"case  when COVERAGE_STATUS ='PC1' then count(COVERAGE_STATUS) End," +
			"case  when COVERAGE_STATUS ='PC2' then count(COVERAGE_STATUS) End," +
			" case  when COVERAGE_STATUS ='PC3' then count(COVERAGE_STATUS) End," +
			" case  when COVERAGE_STATUS ='PC4' then count(COVERAGE_STATUS) End," +
			"case  when COVERAGE_STATUS ='FC' then count(COVERAGE_STATUS) End ," +
			"count(ah.hab_code),rv.REV_SANCTION_AMOUNT " +
			" from RWS_REV_ADM_SANC_HAB_LNK_TBL  ah,RWS_REVISED_ADM_SANC_TBL rv,rws_habitation_directory_tbl h where" +
			"   h.hab_code=ah.hab_code  and ah.work_id='"+workId+"' and rv.work_id=ah.work_id" +
					" group by COVERAGE_STATUS,ah.hab_code,rv.REV_SANCTION_AMOUNT ";
	        Debug.println("Query is "+query);
	        
	        rset=stat.executeQuery(query);
			while(rset.next())
			{
				if(rset.getString(1)!=null)
				proposalDTO.setNcCountRev(rset.getInt(1)+Integer.parseInt(formatNull(proposalDTO.getNcCountRev()))+"");
				if(rset.getString(2)!=null)
				proposalDTO.setPc1CountRev(rset.getInt(2)+Integer.parseInt(formatNull(proposalDTO.getPc1CountRev()))+"");
				if(rset.getString(3)!=null)
				proposalDTO.setPc2CountRev(rset.getInt(3)+Integer.parseInt(formatNull(proposalDTO.getPc2CountRev()))+"");
				if(rset.getString(4)!=null)
				proposalDTO.setPc3CountRev(rset.getInt(4)+Integer.parseInt(formatNull(proposalDTO.getPc3CountRev()))+"");
				if(rset.getString(5)!=null)
				proposalDTO.setPc4CountRev(rset.getInt(5)+Integer.parseInt(formatNull(proposalDTO.getPc4CountRev()))+"");
				if(rset.getString(6)!=null)
				proposalDTO.setFcCountRev(rset.getInt(6)+Integer.parseInt(formatNull(proposalDTO.getFcCountRev()))+"");
				if(rset.getString(7)!=null)
					proposalDTO.setNoOfRevhHabs(rset.getInt(7)+Integer.parseInt(formatNull(proposalDTO.getNoOfRevhHabs()))+"");
				if(rset.getString(8)!=null)
					proposalDTO.setRevSanctionedAmount(rset.getString(8));
 		     }
	         
			query="select " +
			"case  when COVERAGE_STATUS ='NC' then count(COVERAGE_STATUS) End," +
			"case  when COVERAGE_STATUS ='PC1' then count(COVERAGE_STATUS) End," +
			"case  when COVERAGE_STATUS ='PC2' then count(COVERAGE_STATUS) End," +
			" case  when COVERAGE_STATUS ='PC3' then count(COVERAGE_STATUS) End," +
			" case  when COVERAGE_STATUS ='PC4' then count(COVERAGE_STATUS) End," +
			"case  when COVERAGE_STATUS ='FC' then count(COVERAGE_STATUS) End ," +
			"count(ah.hab_code) " +
			" from rws_rev_est_new_hab_lnk_tbl  ah ,rws_habitation_directory_tbl h where" +
			"   h.hab_code=ah.hab_code  and ah.work_id='"+workId+"' " +
					" group by COVERAGE_STATUS,ah.hab_code ";
	        Debug.println("Query is "+query);
	        
	        rset=stat.executeQuery(query);
			while(rset.next())
			{
				if(rset.getString(1)!=null)
				proposalDTO.setNcCountTeRev(rset.getInt(1)+Integer.parseInt(formatNull(proposalDTO.getNcCountTeRev()))+"");
				if(rset.getString(2)!=null)
				proposalDTO.setPc1CountTeRev(rset.getInt(2)+Integer.parseInt(formatNull(proposalDTO.getPc1CountTeRev()))+"");
				if(rset.getString(3)!=null)
				proposalDTO.setPc2CountTeRev(rset.getInt(3)+Integer.parseInt(formatNull(proposalDTO.getPc2CountTeRev()))+"");
				if(rset.getString(4)!=null)
				proposalDTO.setPc3CountTeRev(rset.getInt(4)+Integer.parseInt(formatNull(proposalDTO.getPc3CountTeRev()))+"");
				if(rset.getString(5)!=null)
				proposalDTO.setPc4CountTeRev(rset.getInt(5)+Integer.parseInt(formatNull(proposalDTO.getPc4CountTeRev()))+"");
				if(rset.getString(6)!=null)
				proposalDTO.setFcCountTeRev(rset.getInt(6)+Integer.parseInt(formatNull(proposalDTO.getFcCountTeRev()))+"");
				if(rset.getString(7)!=null)
					proposalDTO.setNoOfRevTeHabs(rset.getInt(7)+Integer.parseInt(formatNull(proposalDTO.getNoOfRevTeHabs()))+"");
				
 		     }
			query="select sum(REV_SANCTIONED_AMOUNT)  from RWS_NEW_REVISED_EST_TBL where work_id='"+workId+"'";
			rset=stat.executeQuery(query);
			Debug.println("Query is "+query);
			while(rset.next())
			{
		 		if(rset.getString(1)!=null)
					proposalDTO.setTsRevAmount(rset.getString(1));
			}
			query="select tenderAppl.work_id,tenderAppl.CONTRACTOR_NAME ,to_char(tenderAppl.RECIEVED_ON,'dd/mm/yyyy')RECIEVED_ON," 
				+ " contractor.TENDER_COMMITTEE ,contractor.COMPETENT_AUTHORITY," 
				+ " to_char(contractor.TENDER_APPROVED_ON,'dd/mm/yyyy')TENDER_APPROVED_ON,to_char(contractor.LOA_ISSUED_ON,'dd/mm/yyyy')LOA_ISSUED_ON ," 
				+ " to_char(contractor.AGREEMENT_DATE,'dd/mm/yyyy')AGREEMENT_DATE   from rws_tender_appl_tbl tenderAppl," 
				+ " RWS_CONTRACTOR_SELECTION_TBL contractor,RWS_MILESTONE_TARGET_ACH_TBL" 
				+ " mileStone where tenderAppl.work_id=contractor.work_id(+)" 
				+ " and contractor.work_id=mileStone.work_id(+) and contractor.work_id='"+workId+"'";
			 Debug.println("Query is "+query);
		        
		        rset=stat.executeQuery(query);
				while(rset.next())
				{
					if(rset.getString(5)!=null)
					   proposalDTO.setTenRecievedOn(rset.getString("RECIEVED_ON"));
					if(rset.getString(6)!=null)
					   proposalDTO.setTenConName(rset.getString("CONTRACTOR_NAME"));
					if(rset.getString("TENDER_COMMITTEE")!=null)
						proposalDTO.setTenCommitte(rset.getString("TENDER_COMMITTEE"));
					if(rset.getString("COMPETENT_AUTHORITY")!=null)
						proposalDTO.setTenCompeAu(rset.getString("COMPETENT_AUTHORITY"));
					if(rset.getString("TENDER_APPROVED_ON")!=null)
						proposalDTO.setTenAppvOn(rset.getString("TENDER_APPROVED_ON"));
					if(rset.getString("LOA_ISSUED_ON")!=null)
						proposalDTO.setTenLoaIssOn(rset.getString("LOA_ISSUED_ON"));
					if(rset.getString("AGREEMENT_DATE")!=null)
						proposalDTO.setTenAggrDate(rset.getString("AGREEMENT_DATE"));
				}
				/*
				 * @ADDED BY MANOJ
				 */
				
				query=" SELECT P.PANCH_NAME,S.SOURCE_CODE,S.SOURCE_NAME,S.SITE_HAND_OVER_DATE " +
				  " FROM RWS_SOURCE_IDEN_FIN_TBL S,RWS_PANCHAYAT_RAJ_TBL P WHERE " +
				  " P.PANCH_CODE=S.HAB_CODE AND WORK_ID='"+workId+"'";
			Debug.println(query);
			rset=stat.executeQuery(query);
			if(rset.next())
			{
				Debug.println("INSIDE WHILE LOOP");
				if(rset.getString(2) !=null && !rset.getString(2).equals("") && !rset.getString(2).equals("null"))
				    proposalDTO.setSourceCode(rset.getString(2));
				else
					proposalDTO.setSourceCode("-  -  -");
				if(rset.getString(3) !=null && !rset.getString(3).equals("") && !rset.getString(3).equals("null"))
				    proposalDTO.setSourceName(rset.getString(3));
				else
					proposalDTO.setSourceName("-  -  -");
				if(rset.getString(4) !=null && !rset.getString(4).equals("") && !rset.getString(4).equals("null"))
				    proposalDTO.setSiteHandingOverDate(rset.getString(4));
				else
					proposalDTO.setSiteHandingOverDate("-  -  -");
				if(rset.getString(1) !=null && !rset.getString(1).equals("") && !rset.getString(1).equals("null"))
				    proposalDTO.setHabName(rset.getString(1));
				else
					proposalDTO.setHabName("-  -  -");
			}
			else
			{
				Debug.println("IN ELSE PART OF -  -  - LOGIC");
				proposalDTO.setHabName("-  -  -");
				proposalDTO.setSourceCode("-  -  -");
				proposalDTO.setSourceName("-  -  -");
				proposalDTO.setSiteHandingOverDate("-  -  -");
				
			}
			
			query="select to_char(GROUNDING_DATE,'dd/mm/yyyy'),SUBDIVISION_OFFICE_NAME,OFFICER_ASSIGNED_TO," +
				  "OFFICER_ASSIGNED_TO1,OFFICER_ASSIGNED_TO2,OFFICER_ASSIGNED_TO3 from " +
				  "RWS_WORK_COMMENCEMENT_TBL,RWS_SUBDIVISION_OFFICE_TBL S " +
				  "where S.SUBDIVISION_OFFICE_CODE=SUBSTR (OFFICE_CODE,5,2)and WORK_ID='"+workId+"'";
			rset=stat.executeQuery(query);
			if(rset.next())
			{
				if(rset.getString(1) != null && !rset.getString(1).equals("null") && !rset.getString(1).equals(""))
					proposalDTO.setWorkStartDate(rset.getString(1));
				else
					proposalDTO.setWorkStartDate("-  -  -");
				if(rset.getString(2) != null && !rset.getString(2).equals("null") && !rset.getString(2).equals(""))
				    proposalDTO.setAssignedSubdivision(rset.getString(2));
			    else
			    	proposalDTO.setAssignedSubdivision("-  -  -");
				if(rset.getString(3) != null && !rset.getString(3).equals("null") && !rset.getString(3).equals(""))
					proposalDTO.setAssignedEngg1(rset.getString(3));
				else
					proposalDTO.setAssignedEngg1("-  -  -");
				if(rset.getString(4) != null && !rset.getString(4).equals("null") && !rset.getString(4).equals(""))
					proposalDTO.setAssignedEngg2(rset.getString(4));
				else
					proposalDTO.setAssignedEngg2("-  -  -");
				if(rset.getString(5) != null && !rset.getString(5).equals("null") && !rset.getString(5).equals(""))
					proposalDTO.setAssignedEngg3(rset.getString(5));
				else
					proposalDTO.setAssignedEngg3("-  -  -");
				if(rset.getString(6) != null && !rset.getString(6).equals("null") && !rset.getString(6).equals(""))
					proposalDTO.setAssignedEngg4(rset.getString(6));
				else
					proposalDTO.setAssignedEngg4("-  -  -");
			}
			else
			{
				proposalDTO.setWorkStartDate("-  -  -");
				proposalDTO.setAssignedSubdivision("-  -  -");
				proposalDTO.setAssignedEngg1("-  -  -");
				proposalDTO.setAssignedEngg2("-  -  -");
				proposalDTO.setAssignedEngg3("-  -  -");
				proposalDTO.setAssignedEngg4("-  -  -");
			}
			query="select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),to_char(DATE_OF_COMM,'dd-mm-yyyy'),Remarks " +
				  " from RWS_WORK_COMPLETION_TBL where WORK_ID='"+workId+"'";
			rset=stat.executeQuery(query);
			if(rset.next())
			{
				if(rset.getString(1) != null && !rset.getString(1).equals("null") && !rset.getString(1).equals(""))
					proposalDTO.setDateOfCompletion(rset.getString(1));
				else
					proposalDTO.setDateOfCompletion("-  -  -");
				if(rset.getString(2) != null && !rset.getString(2).equals("null") && !rset.getString(2).equals(""))
					proposalDTO.setDateOfCommmisioning(rset.getString(2));
				else
					proposalDTO.setDateOfCommmisioning("-  -  -");
				if(rset.getString(3) != null && !rset.getString(3).equals("null") && !rset.getString(3).equals(""))
					proposalDTO.setRemarks(rset.getString(3));
				else
					proposalDTO.setRemarks("-  -  -");
			}
			else
			{
				proposalDTO.setDateOfCompletion("-  -  -");
				proposalDTO.setDateOfCommmisioning("-  -  -");
				proposalDTO.setRemarks("-  -  -");
			}
			query="select p.PROGRAMME_NAME,sum(w.EXPENDITURE_UPTO_THE_PRE_YEAR) from rws_programme_tbl p," +
				  "rws_work_exp_upto_pre_year_tbl w where w.programme_code=p.programme_code " +
				  "and WORK_ID='"+workId+"' group by p.programme_name";
			Debug.println(query);
			rset=stat.executeQuery(query);
			String expUpto="";
			while(rset.next())
			{
				if(rset.getString(2) != null && !rset.getString(2).equals("") && !rset.getString(2).equals("null"))
				expUpto=expUpto.concat(rset.getString(1)+":"+rset.getString(2)+",");
			}
			Debug.println("EXP UPTO PREV"+expUpto);
			proposalDTO.setExpUptoPreYear(expUpto);
			
			query="select YEAR,MONTH from rws_work_expenditure_tbl where WORK_ID='"+workId+"'";
			rset=stat.executeQuery(query);
			String year="";
			while(rset.next())
			{
				String []month={"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
				if(rset.getString(2).equals("01"))
					year=year.concat(rset.getString(1)+" "+month[0]+",");
				if(rset.getString(2).equals("02"))
					year=year.concat(rset.getString(1)+" "+month[1]+",");
				if(rset.getString(2).equals("03"))
					year=year.concat(rset.getString(1)+" "+month[2]+",");
				if(rset.getString(2).equals("04"))
					year=year.concat(rset.getString(1)+" "+month[3]+",");
				if(rset.getString(2).equals("05"))
					year=year.concat(rset.getString(1)+" "+month[4]+",");
				if(rset.getString(2).equals("06"))
					year=year.concat(rset.getString(1)+" "+month[5]+",");
				if(rset.getString(2).equals("07"))
					year=year.concat(rset.getString(1)+" "+month[6]+",");
				if(rset.getString(2).equals("08"))
					year=year.concat(rset.getString(1)+" "+month[7]+",");
				if(rset.getString(2).equals("09"))
					year=year.concat(rset.getString(1)+" "+month[8]+",");
				if(rset.getString(2).equals("10"))
					year=year.concat(rset.getString(1)+" "+month[9]+",");
				if(rset.getString(2).equals("11"))
					year=year.concat(rset.getString(1)+" "+month[10]+",");
				if(rset.getString(2).equals("12"))
					year=year.concat(rset.getString(1)+" "+month[11]+",");					
			}
			proposalDTO.setYearMonth(year);
			
			query="select p.PROGRAMME_NAME,sum(w.EXPENDITURE_DURING) from rws_programme_tbl p," +
				  " RWS_WORK_EXPENDITURE_TBL w where w.programme_code=p.programme_code and work_id='"+workId+"'" +
				  " group by p.programme_name";
			rset=stat.executeQuery(query);
			String str="";
			while(rset.next())
			{
				str=str.concat(rset.getString(1)+":"+rset.getString(2)+",");
			}
			Debug.println("PRGRAM WISE EXP."+str);
			proposalDTO.setProgramWiseExp(str);
			
			int tot_expenditure=0;
			query="SELECT SUM(EXPENDITURE_DURING) FROM  RWS_WORK_EXPENDITURE_TBL WHERE WORK_ID='"+workId+"'";
			rset=stat.executeQuery(query);
			if(rset.next())
			{
				if(rset.getString(1) != null && !rset.getString(1).equals("") && !rset.getString(1).equals("null"))
					tot_expenditure=tot_expenditure+Integer.parseInt(rset.getString(1));
			}
			query="select sum(EXPENDITURE_UPTO_THE_PRE_YEAR) from rws_work_exp_upto_pre_year_tbl where WORK_ID='"+workId+"'";
			rset=stat.executeQuery(query);
			if(rset.next())
			{
				if(rset.getString(1) != null && !rset.getString(1).equals("") && !rset.getString(1).equals("null"))
					tot_expenditure=tot_expenditure+Integer.parseInt(rset.getString(1));
			}
			Debug.println("TOTAL EXPENDITURE:"+tot_expenditure);
			proposalDTO.setTotExpenditure(tot_expenditure);
				
				
				/*
				 * @END OF ADDED BY MANOJ
				 */
			representativeProposals.add(proposalDTO);
		}
		catch(Exception e)
		{	Debug.writeln("Exception in while getting the worlwise details : \n" + e);			
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
		Debug.println("representativeProposals.size() in ProposalDAO(): " + representativeProposals.size());
		return representativeProposals;
	}
	public  boolean  insertPrajaPadamDetails(String query1 ,String query2) 
	 throws Exception
		{
		  boolean value=true;
			Connection conn=null;
			try
			{
		     Debug.println("in insertPrajaPadamDetails");
			 conn=RwsOffices.getConn();
			 conn.setAutoCommit(false);
			 
			 Statement stmt2=conn.createStatement();
		 	 stmt2.addBatch(query1);
			 stmt2.addBatch(query2);
		 	// stmt2.addBatch("insert into rws_work_admn_tbl (work_id,work_name,FLAG,office_code,no_of_habs)values('"+workId+"','"+workName+"','P','"+user+"','0')");
	 	     int[] val=stmt2.executeBatch();
	 	    
	 	     for(int i=0;i<val.length;i++)
	 	     {
	 	     	if(val[i]==0)
	 	     	value=false;
	 	     }
	 	     if(value)
	 	     {
	 	     	conn.commit();
	 	     }
			}
			catch(Exception e)
			{
				Debug.println("Exceptin is"+e);
				value=false;
			}
			finally
			{	 
				conn.close();
			}
			return value; 
		}
	public boolean deletePrajapadamDetails(String workId,String habCode)
	{
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
        boolean flag=false;
		int[] status={};
		try
		{
			query = "DELETE FROM RWS_prajapadam_tbl WHERE WORK_ID='"+workId+"' and hab_code='"+habCode+"'";
			 Debug.println("DELETE FROM RWS_prajapadam_tbl WHERE WORK_ID='"+workId+"' and hab_code='"+habCode+"'");
			conn = getConn();
			conn.setAutoCommit(false);
			stat = conn.createStatement();
			stat.addBatch(query);
			 
			status=stat.executeBatch();
			
	 		if(status.length>0)
			{
	 			flag=true;
				conn.commit();
			}
	 	}
		catch(Exception e)
		{	Debug.writeln("Exception in delete prajapadam details :\n" + e);			
		}
		finally
		{	 
			 
			if(conn != null)
			{	try
				{	conn.close();
				}
				catch(SQLException sqle){ }
			}
		}
		return flag;
	}
	public ArrayList getPrajapadamList(String dcode,String mcode,String HabCode,String workId)
	
    {
		Rws_Prajapadam_Bean bean=null;
		ArrayList prajapadamList=null;
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
    	try
		{	
	 		  conn=RwsOffices.getConn();
	 		stat=conn.createStatement();
	 		String query="select Decode(EXIST_CPWS,'Y','YES') ,DECODE(EXIST_PWS,'Y','YES')," +
	 				" DECODE(EXIST_DIRECT_PUMPING ,'Y','YES'),DECODE(EXIST_BOREWELLS ,'Y','YES'), " +
	 				" DECODE(EXIST_OTHERS,'Y','YES') ,OTHER_DETAILS ,WORK_NAME,ESTIMATE_COST," +
	 				" PROGRAMME_name,SUBPROGRAMME_name,ADMN_SANC_NO ,TO_char(ADMN_SANC_DATE,'dd/mm/yyyy')," +
	 				" EXP_UPTO_THE_PRE_MONTH,to_char(GROUND_DATE,'dd/mm/yyyy'),to_char(COMPLETION_DATE,'dd/mm/yyyy')," +
	 				" PHY_STAGE_OF_WORK,p.REMARKS,p.DCODE,d.dname, p.MCODE,m.mname,p.HAB_CODE," +
	 				" WORK_ID,p.TYPE_OF_ASSET_CODE,pr.panch_name,c.CONSTITUENCY_NAME ,hab.coverage_status," +
	 				" EXP_DUR_THE_MONTH ,EXP_TO_BE_INCURRED,decode(SANCTIONED_AT,'D','DISTRICT','S','STATE')   from " +
	 				" RWS_PRAJAPADAM_TBL p,RWS_PRAJAPADAM_EXIST_SCH_TBL pe ,rws_district_tbl  d," +
	 				" rws_mandal_tbl m ,rws_panchayat_raj_tbl pr,rws_constituency_tbl c,rws_habitation_directory_tbl hab, " +
	 				" rws_programme_tbl pg ,rws_subProgramme_tbl su where p.hab_code=pe.hab_code  and  d.dcode=p.dcode and m.dcode=p.dcode " +
	 				" and m.mcode=p.mcode and pr.panch_code=p.hab_code and c.CONSTITUENCY_code=" +
	 				" substr(p.hab_code,3,3) and hab.hab_code=p.hab_code and pg.programme_code=p.programme_code and su.programme_code(+)=p.programme_code and " +
	 				" su.subProgramme_code(+)=p.subProgramme_code and c.constituency_type='A' ";
	 		prajapadamList=new ArrayList();
	 		if(dcode!=null)
	 		{
		 		if(!dcode.equals(""))
		 		{
		 			query=query+" and p.dcode='"+dcode+"'";
		 			if(!mcode.equals(""))
			 		{
		 				query=query+" and p.mcode='"+mcode+"'";
		 				if(!HabCode.equals(""))
				 		{
				 			query=query+" and p.hab_code='"+HabCode+"'";
				 		}
			 		}
		 		}
		 	if(workId!=null)
		 	{
		 		if(!workId.equals(""))
		 		{
		 		query=query+" and p.work_id='"+workId+"'";	
		 		}
		 	}
	 		}
	 		
	 		 
	 		Debug.println("Query is **************"+query);
	 		ResultSet rs=stat.executeQuery(query);
	 		while(rs.next())
	 		{
	 			bean=new Rws_Prajapadam_Bean();
	 			bean.setCpws(rs.getString(1));
	 			bean.setPws(rs.getString(2));
	 			bean.setDirectPump(rs.getString(3));
	 			bean.setBoreWells(rs.getString(4));
	 			bean.setOthers(rs.getString(5));
	 			bean.setOthersValue(rs.getString("OTHER_DETAILS"));
	 			bean.setWorkName(rs.getString("WORK_NAME"));
	 			bean.setEstCost(""+rs.getFloat("ESTIMATE_COST"));
	 			bean.setProgramme(rs.getString("PROGRAMME_Name"));
	 			bean.setSubProgramme(rs.getString("SUBPROGRAMME_name"));
	 			bean.setAdminSancRefNo(rs.getString("ADMN_SANC_NO"));
	 			bean.setAdminSancDate(rs.getString(12));
	 			bean.setExpendetureUpTotheMonth(""+rs.getFloat("EXP_UPTO_THE_PRE_MONTH"));
	 			bean.setDateOfGrounding(rs.getString(14));
	 			bean.setDateOfComple(rs.getString(15));
	 			bean.setPhysycalStageOFWork(rs.getString("PHY_STAGE_OF_WORK"));
	 			bean.setRemarks(rs.getString(17));
	 			bean.setDistrictCode(rs.getString(18));
                bean.setDistrictName(rs.getString(19));
                bean.setMandalCode(rs.getString(20));
                bean.setMandalName(rs.getString(21));
                bean.setHabCode(rs.getString(22));
                bean.setWorkId(rs.getString(23));
                bean.setTypeOfAssetCode(rs.getString(24));
                bean.setHabName(rs.getString(25));;
                bean.setConName(rs.getString(26));
                bean.setStatusAsOn(rs.getString(27));
                bean.setExpendetureDuringMon(""+rs.getFloat(28));
                bean.setExpendetureToBeIncurred(""+rs.getFloat(29));
                bean.setSanctionAt(rs.getString(30));
	 			prajapadamList.add(bean);
	 		}
		}
		catch(Exception e)
		{	Debug.writeln("Exception in getWorkId : \n" + e);			
		}
		finally
		{	 
			if(conn != null)
			{	try
				{	conn.close();
				}
				catch(SQLException sqle){
				}
			}
		}
		return prajapadamList;
}	
	public  boolean  insertProgrammes(String programme) 
	throws Exception
	{
		boolean value=true;
		int upCount=0;
		Connection conn=null;
		String PROGRAMME_START_YEAR ="";
		java.util.Date d=new java.util.Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy");
		
		String currentYear = dateFormatter.format(d);
		dateFormatter = new SimpleDateFormat("MM");
		
		d=new java.util.Date();
		int month=Integer.parseInt(dateFormatter.format(d));
		Debug.println("Mont is "+month);
		if(month<4)
		{
			PROGRAMME_START_YEAR=Integer.parseInt(currentYear)-1+"-"+currentYear;
		}
		else
		{
			PROGRAMME_START_YEAR=currentYear+"-"+(Integer.parseInt(currentYear)+1);
		}
		Debug.println("Programme starting year is :"+PROGRAMME_START_YEAR+"  MONTH:::"+month);
		try
		{
			String prog_code=null;
			Debug.println("in inserting new Programme");
			conn=RwsOffices.getConn();
			conn.setAutoCommit(false);
			Statement stmt1=conn.createStatement();
			ResultSet rs=stmt1.executeQuery("select max(PROGRAMME_CODE)+1 from rws_programme_tbl");
			if(rs.next())
			{
				prog_code=rs.getString(1);	
				Statement stmt2=conn.createStatement();
				PreparedStatement ps = conn.prepareStatement("INSERT INTO RWS_PROGRAMME_TBL(PROGRAMME_NAME ,PROGRAMME_CODE ,PROGRAMME_START_YEAR ,FRESH_ONGOING )values(?,?,?,'F')");
				ps.setString(1,programme);
				ps.setString(2,prog_code);
				ps.setString(3,PROGRAMME_START_YEAR);
				upCount= ps.executeUpdate();
			}
			if(upCount==1)
			{
				conn.commit();
			}
		}
		catch(Exception e)
		{
			Debug.println("Exceptin is"+e);
			value=false;
		}
		finally
		{	 
			conn.close();
		}
		return value; 
	}
	
	public ArrayList saveAddminWorkIdAddedProgsToSession(HttpSession session,DataSource dataSource,ArrayList addedPorgs,String workId)throws Exception {
			ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
			if(rwsWorkAdmnProgLnkTmp==null)
				rwsWorkAdmnProgLnkTmp=new ArrayList();
			for(int i=0;i<addedPorgs.size();i++){
				ProposalHolder ph;
				ProposalHolder newHolder=new ProposalHolder();
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
	
	
	public ArrayList getAddedAdmnProgs(HttpSession session,String workId)throws Exception {
		ArrayList rwsWorkAdmnProgLnkTmpNew=new ArrayList();
		try{
			ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
			if(rwsWorkAdmnProgLnkTmp!=null){
				for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++){
					ProposalHolder ph;
					ProposalHolder phNew=new ProposalHolder();
					ph=(ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);				
					if(ph.getWorkId().equals(workId)){
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
		}catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO getAddedAdmnProgs : \n" + e.getMessage());			
		}return rwsWorkAdmnProgLnkTmpNew;
	}
	
	public ArrayList getAddedRevisedProgs(HttpSession session,String workId)throws Exception 
	{
			ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
			ArrayList rwsWorkAdmnProgLnkTmpNew=new ArrayList();
			for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)
			{
				ProposalHolder ph;
				ProposalHolder phNew=new ProposalHolder();
				
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
				ph=(ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);
				if(ph.getWorkId().equals(workId))
				{
				phNew.setWorkId(workId);
				phNew.setProgrammeCode(ph.getProgrammeCode());
				phNew.setSubprogrammeCode(ph.getSubprogrammeCode());
				phNew.setRevisedAdminiStrativeNum(ph.getRevisedAdminiStrativeNum());
				phNew.setRevisedAdminiStrativeDate(ph.getRevisedAdminiStrativeDate());
				phNew.setRevisedSanctionAmout(ph.getRevisedSanctionAmout());
			
				rwsWorkAdmnProgLnkTmpNew.add(phNew);
				}
			}
			
		return rwsWorkAdmnProgLnkTmpNew;
	}
	
	public  void deleteTempAddProgramsTable(HttpSession session,String workId){
		try	{
			ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");			
			if(rwsWorkAdmnProgLnkTmp!=null)	{
				ProposalHolder ph=null;
				for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)	{
					ph=(ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);
					if(ph.getWorkId().equals(workId))
						rwsWorkAdmnProgLnkTmp.set(i,null);
				}
				for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)	{
					ph= (ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);
					if(ph==null){
	    				rwsWorkAdmnProgLnkTmp.remove(i);
	    				i--;
	    			}	    			
	    		}
			}
			else {
			}
		}
		catch(Exception e){	
			System.out.println("The Exception is in ProposalDAO deleteTempAddProgramsTable : " + e.getMessage());		
		}		
	}
	
	public  void deleteTempAddRevProgramsTable(HttpSession session,String workId){		
		try	{
			ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");			
			if(rwsWorkAdmnProgLnkTmp!=null)	{
				ProposalHolder ph=null;
				for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)	{
					ph=(ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);
					if(ph.getProposalId().equals(workId))
						rwsWorkAdmnProgLnkTmp.set(i,null);
				}
				for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++){
					ph= (ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);
					if(ph==null){
	    				rwsWorkAdmnProgLnkTmp.remove(i);
	    				i--;
	    			}
	    		}
			}
			else{
			}
		}
		catch(Exception e){	
			Debug.println("The Exception is in ProposalDAO deleteTempAddRevProgramsTable : " + e.getMessage());		
		}		
	}
	
	public boolean saveAddminWorkIdAddedProgs2(DataSource dataSource,ArrayList addedPorgs,String workId,String Stat)throws Exception {
		boolean status=true;
		Connection conn=null;
		try{
			conn=RwsOffices.getConn();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			String query;
			if(addedPorgs.size()==0){
				 query="DELETE FROM RWS_WORK_ADMN_PROG_LNK_TBL WHERE WORK_ID='"+workId+"'";
				 stmt.addBatch(query)	;				 
			}
			for(int i=0;i<addedPorgs.size();i++){
				ProposalHolder ph=new ProposalHolder();
				ph=(ProposalHolder)addedPorgs.get(i);
				if(Stat!=null){
					if(i==0){
						 query="DELETE FROM RWS_WORK_ADMN_PROG_LNK_TBL WHERE WORK_ID='"+workId+"'";
						 stmt.addBatch(query)	;
					}
				 	query="INSERT INTO RWS_WORK_ADMN_PROG_LNK_TBL(WORK_ID ,PROGRAMME_CODE ,SUB_PROGRAMME_CODE ,ADMIN_NO ,ADMIN_DATE ,SANCTION_AMOUNT )" +
					"VALUES('"+workId+"','"+ph.getProgrammeCode()+"','"+ph.getSubprogrammeCode()+"','"+ph.getAdminiStrativeNum()+"'," +
					"to_date('"+ph.getAdminiStrativeDate()+"','dd/mm/yyyy'),'"+ph.getSanctionAmout()+"')";
					stmt.addBatch(query);
				}
			    else{}			
			}
			int value[]=stmt.executeBatch();
	 		if(status){ 
				conn.commit();
			}
		}
		catch(Exception e){   
			status=false;
			Debug.println("The Exception is in ProposalDAO saveAddminWorkIdAddedProgs2 : "+e.getMessage());
		}
		finally{
			conn.close();
		}
		return status;
	}
	
	
	public boolean saveRevisedWorkIdAddedProgs2(HttpSession session,DataSource dataSource,ArrayList addedPorgs,String workId,String Stat)throws Exception {
		boolean savedToSession=true;
		ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
		if(rwsWorkAdmnProgLnkTmp==null)
			rwsWorkAdmnProgLnkTmp=new ArrayList();
		try{
			ProposalHolder ph=null;
			for(int i=0;i<addedPorgs.size();i++){
				ProposalHolder newHolder=new ProposalHolder();				
				ph=(ProposalHolder)addedPorgs.get(i);
				newHolder.setProposalId(workId);
				newHolder.setProgrammeCode(ph.getProgrammeCode());
				newHolder.setSubprogrammeCode(ph.getSubprogrammeCode());
				newHolder.setRevisedAdminiStrativeNum(ph.getRevisedAdminiStrativeNum());
				newHolder.setRevisedAdminiStrativeDate(ph.getRevisedAdminiStrativeDate());
				newHolder.setRevisedSanctionAmout(ph.getRevisedSanctionAmout());
				rwsWorkAdmnProgLnkTmp.add(newHolder);				 
			}
			session.setAttribute("rwsWorkAdmnProgLnkTmp",rwsWorkAdmnProgLnkTmp);
			
		}
		catch(Exception e){  
			Debug.println("The Exception is in ProposalDAO saveRevisedWorkIdAddedProgs2 : "+e.getMessage());
			savedToSession=false;
		}		
		return savedToSession;
	}

	
	public boolean saveRevisedWorkIdAddedProgsFromView(DataSource dataSource,ArrayList addedPorgs,String workId)throws Exception {
		boolean status=true;
		Connection conn=null;
		try {
			conn=RwsOffices.getConn();
			Statement stmt=conn.createStatement();
			conn.setAutoCommit(false);
			for(int i=0;i<addedPorgs.size();i++){
				ProposalHolder ph=new ProposalHolder();
				ph=(ProposalHolder)addedPorgs.get(i);
				if(i==0){
					query="DELETE FROM RWS_REVISED_ADM_PROG_LNK_TBL WHERE WORK_ID='"+workId+"'";
					stmt.addBatch(query);
				}				
				stmt.addBatch("INSERT INTO RWS_REVISED_ADM_PROG_LNK_TBL(WORK_ID ,PROGRAMME_CODE ,SUB_PROGRAMME_CODE ,ADMIN_NO ,ADMIN_DATE ,rev_SANCTION_AMOUNT  )" +
					"VALUES('"+workId+"','"+ph.getProgrammeCode()+"','"+ph.getSubprogrammeCode()+"','"+ph.getRevisedAdminiStrativeNum()+"'," +
					"to_date('"+ph.getRevisedAdminiStrativeDate()+"','dd/mm/yyyy'),'"+ph.getRevisedSanctionAmout()+"')");
			}
			int value[]=stmt.executeBatch();
			if(status){ 
				conn.commit();
			}
		}
		catch(Exception e){   
			status=false;
			Debug.println("The Exception is in ProposalDAO saveRevisedWorkIdAddedProgsFromViewe : "+e.getMessage());
		}		
		finally{
			conn.close();
		}
		return status;
	}
	
	
	public ArrayList getAddedProgramsListForRevised(DataSource dataSource ,String WorkId)throws Exception {
		ArrayList list=new ArrayList();
		ProposalHolder ph=null;
		Connection conn=null;
		nic.watersoft.commons.CommonLists commonLists=null;
		try	{
			conn=RwsOffices.getConn();
			String query="select distinct pl.PROGRAMME_CODE,pl.SUB_PROGRAMME_CODE, pl.ADMIN_NO,to_char(pl.ADMIN_DATE,'dd/mm/yyyy')ad,"
					+ " pl.work_id ,pl.SANCTION_AMOUNT,ad.work_Name ,to_char(rv.ADMIN_DATE,'dd/mm/yyyy')rvdt,rv.ADMIN_NO ,"
					+ " rv.REV_SANCTION_AMOUNT from RWS_WORK_ADMN_PROG_LNK_TBL pl,rws_work_admn_tbl ad ,RWS_REVISED_ADM_PROG_LNK_TBL rv where " 
					+ " pl.work_id= ? and ad.work_id= ? and rv.work_id= ? and rv.programme_code=pl.programme_code and rv.sub_programme_code=pl.sub_programme_code";
			PreparedStatement stmt=conn.prepareStatement(query);
			stmt.setString(1, WorkId);
			stmt.setString(2, WorkId);
			stmt.setString(3, WorkId);
			ResultSet rs=stmt.executeQuery();			
			while(rs.next()){
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
		catch(Exception e){
			Debug.println("The Exception is in ProposalDAO  getAddedProgramsListForRevised : "+e.getMessage());
		}
		finally{
			conn.close();
		}
		return list;
	}

	
protected ArrayList getAdminstrativeSanctionList(String officeCode,String workId,String circlecode,String divcode,String subdivcode,String catg,String schm,String prog,String subprog,String plan,String aug,String userId){
	Connection conn = null;
	PreparedStatement stat = null,stmt1=null,stmt3=null,stmt2=null,stmt=null,stmt4=null;
	ResultSet rset = null,rs1=null,rs=null,rs2=null,rs3=null,rs4=null;
	try	{
	   	 query = "SELECT distinct ad.WORK_NAME ,ad.WORK_ID,ad.NO_OF_HABS,ad.ESTIMATE_COST " +
			",ad.SANCTION_AMOUNT,ad.ADMIN_NO,to_char(ad.ADMIN_DATE,'dd/mm/yyyy') " +
			",decode(ad.SPILL_OVER,'y','YES','','No'),At.TYPE_OF_ASSET_NAME,p.PROGRAMME_Name ," +
			" s.SUBPROGRAMME_NAME,ad.PREPARED_BY ,to_char(ad.PREPARED_ON,'dd/mm/yyyy')as" +
			" prepared_on ,AD.remarks,ad.office_code,w.category_name,to_char(ad.PREPARED_ON,'yyyy/mm/dd'),pl.plan_name,a.aug_new_name,ad.NO_OF_SCHOOLS,ad.NO_OF_LABS,nvl(ad.core_dashboard_status,'N') as core_dashboard_status" +
			" FROM  rws_work_admn_tbl ad, rws_programme_tbl P,  rws_subprogramme_tbl S," +
			" rws_asset_type_tbl AT,rws_work_category_tbl w,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl a  where ad.category_code=w.category_code and at.TYPE_OF_ASSET_CODE =" +
			"ad.TYPE_OF_ASSET and  P.PROGRAMME_CODE=ad.PROGRAMME_CODE " +
			" AND (ad.PROGRAMME_CODE=s.PROGRAMME_CODE  and ad.subprogramme_code=s.subprogramme_code) and ad.plan_code=pl.plan_code and ad.aug_new_code=a.aug_new_code "; 
			if(!circlecode.equals("")){
				query=query+" and substr(ad.WORK_ID,5,2)='"+circlecode+"'";
			}
			if(!divcode.equals("")){
				query=query+" and substr(ad.office_code,4,1)='"+divcode+"'";
			}
			if(!subdivcode.equals("")){
				query=query+" and substr(ad.office_code,5,2)='"+subdivcode+"'";
			}
		    if(!workId.equals("")){
				query=query+" and ad.WORK_ID='"+workId+"'";
			}
		    if(catg!=null&&!catg.equals("")){
		    	query=query+"and ad.CATEGORY_CODE='"+catg+"'";
			}
			if(schm!=null&&!schm.equals("")){
				query=query+"and ad.TYPE_OF_ASSET ='"+schm+"'";
			}
			if(prog!=null&&!prog.equals("")){
				query=query+"and ad.PROGRAMME_CODE='"+prog+"'";
			}
			if(subprog!=null&&!subprog.equals("")){
				query=query+"and ad.SUBPROGRAMME_CODE='"+subprog+"'";
			}				 
		query=query+" order by 17 desc";	
	 	conn = getConn();
	 	stat = conn.prepareStatement(query);
	 	rset = stat.executeQuery();
	 	representativeProposals = new ArrayList();		
		while(rset.next()){
			proposalDTO = new ProposalDTO();			
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
			proposalDTO.setWorkCat(rset.getString(16));
			proposalDTO.setPlan(rset.getString(18));
			proposalDTO.setWrkType(rset.getString(19));
			proposalDTO.setNoOfSchools(rset.getString(20));
			proposalDTO.setNoOfLabs(rset.getString(21));
			if(rset.getString("core_dashboard_status").equals("Y")){
				proposalDTO.setCoreDashboardStatus("YES");
			}
			else{
				proposalDTO.setCoreDashboardStatus("NO");
			}			
			String qry = "select to_char(grounding_date,'dd/mm/yyyy') from rws_work_commencement_tbl where work_id= ? ";
			stmt1 = conn.prepareStatement(qry);
			stmt1.setString(1, rset.getString(2));
			rs = stmt1.executeQuery();
			if(rs.next()){
				String groundDate = rs.getString(1);
				String qry1 = "select to_char(date_of_completion,'dd/mm/yyyy'),to_char(date_of_comm,'dd/mm/yyyy'),to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),to_char(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id= ? ";
				stmt3 = conn.prepareStatement(qry1);
				stmt3.setString(1, rset.getString(2));
				rs1 = stmt3.executeQuery();
				if(rs1.next()){
					if(rs1.getString(3)!=null && !rs1.getString(3).equals("")){
						proposalDTO.setPhysicalSatus("Financially Completed");
					}
					else if(rs1.getString(2)!=null && !rs1.getString(2).equals(""))	{
						proposalDTO.setPhysicalSatus("Commissioned");
					}
					else if(rs1.getString(1)!=null && !rs1.getString(1).equals(""))	{
						proposalDTO.setPhysicalSatus("Completed");
					}
					else{
						proposalDTO.setPhysicalSatus("Grounded");
					}
					if(rs1.getString(4)!=null && !rs1.getString(4).equals("")){
						proposalDTO.setPhysicalSatus("Partial Completed");
					}
				}
				else{
					proposalDTO.setPhysicalSatus("Grounded");
				}
				rs1.close();
				stmt1.close();
			}
			else{			
			String qry1 = "select to_char(AGREEMENT_DATE,'dd/mm/yyyy') from Rws_Contractor_Selection_Tbl where work_id= ? ";
			stmt2=conn.prepareStatement(qry1);
			stmt2.setString(1, rset.getString(2));
			rs2 = stmt2.executeQuery();
			if(rs2.next()){
				proposalDTO.setPhysicalSatus("Contractors Selected");
			}else{
				String qry2 = "select to_char(SITE_IDENT_DATE,'dd/mm/yyyy') from Rws_Source_Iden_Fin_Tbl where work_id= ? ";
				stmt=conn.prepareStatement(qry2);
				stmt.setString(1, rset.getString(2));
				rs3 = stmt.executeQuery();
				if(rs3.next()){
					proposalDTO.setPhysicalSatus("Sources Identified");
				}else{
					String qry3 = "select to_char(TS_DATE,'dd/mm/yyyy') from Rws_New_Est_Tbl where work_id= ? ";
					stmt4=conn.prepareStatement(qry3);
					stmt4.setString(1, rset.getString(2));
					rs4 = stmt4.executeQuery();
					if(rs4.next()){
						proposalDTO.setPhysicalSatus("TechnicallySanctioned");		
					}else{			
						proposalDTO.setPhysicalSatus("AdminSanctioned");		
					}
					rs4.close();
					stmt4.close();
			}
				rs3.close();
				stmt.close();
			}
				rs2.close();
				stmt2.close();
			}
			rs.close();
			stmt1.close();
			representativeProposals.add(proposalDTO);
		}
	}
	catch(Exception e){	
		Debug.println("The Exception is in ProposalDAO  getAdminstrativeSanctionList : "+e.getMessage());
	}
	finally{	
		try{
			if(rset != null){
				rset.close();
			}
			if(stat != null){	
				stat.close();
			}
			if(conn != null){	
				conn.close();			
			}
		}
		catch(SQLException sqle){ 
			Debug.println("The Exception is in ProposalDAO  getAdminstrativeSanctionList finally : "+sqle.getMessage());
		}
	}
	return representativeProposals;
}

	
	public ArrayList getAddedProgramsList(DataSource dataSource ,String WorkId)throws Exception {
		ArrayList list=new ArrayList();
		ProposalHolder ph=null;
		Connection conn=null;
		CommonLists commonLists=null;
		try	{
			conn=RwsOffices.getConn();
			String query="select distinct pl.PROGRAMME_CODE,p.programme_name,sp.SUBPROGRAMME_CODE,sp.subprogramme_name,pl.ADMIN_NO,to_char(pl.ADMIN_DATE,'dd/mm/yyyy')ad," 
					+ " pl.work_id ,pl.SANCTION_AMOUNT,ad.work_Name from RWS_WORK_ADMN_PROG_LNK_TBL pl,rws_work_admn_tbl ad,rws_programme_tbl p,rws_subprogramme_tbl sp where"
					+ " pl.work_id= ? and pl.PROGRAMME_CODE=p.programme_code and sp.programme_code=pl.PROGRAMME_CODE and sp.subprogramme_code=pl.SUB_PROGRAMME_CODE and ad.work_id= ? ";
			PreparedStatement stmt=conn.prepareStatement(query);
			stmt.setString(1, WorkId);
			stmt.setString(2, WorkId);
			ResultSet rs=stmt.executeQuery();
			while(rs.next()){
				commonLists=new  CommonLists(dataSource);
				ph=new ProposalHolder();
		 	    ph.setProgrammeCode(rs.getString("PROGRAMME_CODE"));
		 	    ph.setProgrammeName(rs.getString("programme_name"));
		 	    ArrayList subprogrammes = commonLists.getSubprogrammes(rs.getString("PROGRAMME_CODE"));
				ph.setSubprogrammes(subprogrammes);
				ph.setSubprogrammeCode(rs.getString("SUBPROGRAMME_CODE"));
			 	ph.setSubProgrammeName(rs.getString("subprogramme_name"));
				ph.setAdminiStrativeNum(rs.getString("ADMIN_NO"));
				ph.setAdminiStrativeDate(rs.getString("ad"));
				ph.setWorkId(rs.getString("work_id"));
				ph.setSanctionAmout(rs.getString("SANCTION_AMOUNT"));
				ph.setWorkName(rs.getString("work_Name"));
				list.add(ph);
			}		
		}
		catch(Exception e){
			Debug.println("The Exception is in ProposalDAO getAddedProgramsList : "+e.getMessage());
		}
		finally{
			conn.close();
		}
		return list;
	}
	
	
	public String[] getMandalCodesFormAdmn(String proposalId)throws Exception {
		Connection conn=null;
		String[] mcodes={};
		String q="";
		try	{
			String code=proposalId.substring(6,8);
			conn=RwsOffices.getConn();
			PreparedStatement stmt= null;
			if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))){
				q="select distinct substr(hab_code,6,2) from RWS_ADMN_HAB_LNK_TBL  where WORK_ID ='"+proposalId+"'";
			}
			else if(code.equals("11")){
				q="select distinct substr(hab_code,6,2) from RWS_WORK_SCHOOL_LNK_TBL  where WORK_ID ='"+proposalId+"'";
			}else if(code.equals("14")){
				q="select distinct substr(hab_code,6,2) from RWS_WORK_pi_LNK_TBL  where WORK_ID ='"+proposalId+"'";
			}
			else if(code.equals("12")){
				q="select  distinct substr(b.office_code,2,2) from RWS_WORK_LAB_LNK_TBL a, rws_water_quality_lab_tbl b where WORK_ID ='"+proposalId+"' and a.lab_code=b.lab_code";
		  	}
			stmt=conn.prepareStatement(q);
		  	ResultSet rs=stmt.executeQuery(q);
			int count = 0;	  
			while(rs.next()){
			  	count++;
			}
			mcodes=new String[count];
			if(!(code.equals("11")|| code.equals("12")|| code.equals("13")|| code.equals("14"))){ 
				q="select distinct substr(hab_code,6,2) from RWS_ADMN_HAB_LNK_TBL  where WORK_ID ='"+proposalId+"'";
			}
			else if(code.equals("11")){
		  		q="select distinct substr(hab_code,6,2) from RWS_WORK_SCHOOL_LNK_TBL  where WORK_ID ='"+proposalId+"'";
		  	}
		  	if(code.equals("12")) {
		  		q="select  distinct substr(b.office_code,2,2) from RWS_WORK_LAB_LNK_TBL a, rws_water_quality_lab_tbl b where WORK_ID ='"+proposalId+"' and a.lab_code=b.lab_code";
		  	}else if(code.equals("14")){
		  		q="select distinct substr(hab_code,6,2) from RWS_WORK_PI_LNK_TBL  where WORK_ID ='"+proposalId+"'";
		  	}
		  	stmt=conn.prepareStatement(q);
		  	rs=stmt.executeQuery();
		  	int i=0;
		  	while(rs.next()){
		  		if(rs.getString(1)!=null){
		  			mcodes[i]=rs.getString(1);
		  			i++;
		  		}
		  	}
		  	rs.close();
			stmt.close();		
		}
		catch(Exception e){
			Debug.println("The Exception is in ProposalDAO getMandalCodesFormAdmn : "+e.getMessage());
		}
		finally{
			conn.close();
		}
		return mcodes;
	}


public String planName(String proposalId){
	Connection conn = null;
	PreparedStatement stat = null;
	ResultSet rset = null;
	String planName="";
	try {
		conn = getConn();
		String query = "select p.plan_name from rws_plan_nonplan_tbl p,rws_work_admn_tbl w where w.work_id= ? and p.plan_code=w.plan_code";
		stat = conn.prepareStatement(query);
		stat.setString(1, proposalId);
		rset = stat.executeQuery();
		RwsLocationBean rwsLocationBean = null; 
		while(rset.next()){
			planName=rset.getString(1);
		}
	}
	catch(Exception e){	
		Debug.println("The Exception is in ProposalDAO  planName : "+e.getMessage());
	}
	finally{	
		try{
			if(rset != null){
				rset.close();
			}
			if(stat != null){	
				stat.close();
			}
			if(conn != null){	
				conn.close();			
			}
		}
		catch(SQLException sqle){ 
			Debug.println("The Exception is in ProposalDAO  planName finally : "+sqle.getMessage());
		}
	}
	return planName;
}


public String augName(String proposalId){
	Connection conn = null;
	PreparedStatement stat = null;
	ResultSet rset = null;
	String augName= "";
	try	{
		conn = getConn();
		String query ="select p.aug_new_name from rws_augumentation_new_tbl p,rws_work_admn_tbl w where w.work_id= ? and p.aug_new_code=w.aug_new_code";
		stat = conn.prepareStatement(query);
		stat.setString(1, proposalId);
		rset = stat.executeQuery();
		RwsLocationBean rwsLocationBean = null; 
		while(rset.next()){
			augName=rset.getString(1);
		}
	}
	catch(Exception e){	
		Debug.println("The Exception is in ProposalDAO  augName : "+e.getMessage());
	}
	finally{	
		try{
			if(rset != null){
				rset.close();
			}
			if(stat != null){	
				stat.close();
			}
			if(conn != null){	
				conn.close();			
			}
		}
		catch(SQLException sqle){ 
			Debug.println("The Exception is in ProposalDAO augName finally : "+sqle.getMessage());
		}
	}
	return augName;
}


public ArrayList getTempSelectedHabsForAdminSancEdit(String proposalId,String tabName){
	Connection conn = null;
	PreparedStatement stat = null;
	ResultSet rset = null;
	String query ="";
	ArrayList tempSelectedHabs = new ArrayList();
	String scheme=proposalId.substring(6,8);
	try {
		conn = getConn();
		if(!(scheme.equals("11")|| scheme.equals("12")|| scheme.equals("13")|| scheme.equals("14"))) { 
			query = " SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
		         + " FROM "+tabName+" T, rws_panchayat_raj_tbl P, rws_habitation_directory_tbl D WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code AND T.proposal_id =  ? ";
		} else if(scheme.equals("11")) {
			query="select a.*,B.SCHOOL_CODE ,SCHOOL_NAME from RWS_SCHOOL_MASTER_TBL a,"+tabName+" b WHERE  a.hab_code=b.hab_code and a.school_code=b.school_code and b.proposal_id= ? ";

/*			query="select a.*,B.SCHOOL_CODE ,SCHOOL_NAME from RWS_SCHOOL_MASTER_TBL a,tab_admin_temp_school b WHERE  a.hab_code=b.hab_code and a.school_code=b.school_code and b.proposal_id= ? ";
*/		} else if(scheme.equals("12")){
			query ="SELECT  a.LAB_CODE,lab_name,location FROM  rws_water_quality_lab_tbl a,"+tabName+" c  WHERE  a.lab_code=c.lab_code and c.proposal_id= ? ";
		}	 else if(scheme.equals("14")) {
			query="select a.HABCODE,a.PI_ID,a.HABITATIONNAME,a.LOCATION from IMIS_PUBLIC_INSTITUTIONS_TBL a,"+tabName+" b WHERE  a.habcode=b.hab_code and a.pi_id=b.pi_id and b.proposal_id= ? ";

/*			query="select a.*,B.SCHOOL_CODE ,SCHOOL_NAME from RWS_SCHOOL_MASTER_TBL a,tab_admin_temp_school b WHERE  a.hab_code=b.hab_code and a.school_code=b.school_code and b.proposal_id= ? ";
*/		} else if(scheme.equals("13")) {
	query="select a.* from IMIS_ANGANWADIES_TBL a,"+tabName+" b WHERE  a.habcode=b.hab_code and a.school_id=b.school_code and b.proposal_id= ? ";

/*			query="select a.*,B.SCHOOL_CODE ,SCHOOL_NAME from RWS_SCHOOL_MASTER_TBL a,tab_admin_temp_school b WHERE  a.hab_code=b.hab_code and a.school_code=b.school_code and b.proposal_id= ? ";
*/		}
		stat = conn.prepareStatement(query);
		stat.setString(1, proposalId);		
		rset = stat.executeQuery();
		RwsLocationBean rwsLocationBean = null; 
		while(rset.next()) {
			if(!(scheme.equals("11")|| scheme.equals("12")|| scheme.equals("13")|| scheme.equals("14"))){
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setProposalId(rset.getString(1));
				rwsLocationBean.setHabCode(rset.getString(2));
				rwsLocationBean.setHabName(rset.getString(3));
				rwsLocationBean.setStatus(rset.getString(4));
				rwsLocationBean.setPopulation(rset.getString(5));
			}
			else if(scheme.equals("11")){
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setProposalId(rset.getString(1));
				rwsLocationBean.setHabCode(rset.getString(4)+rset.getString(9));
				rwsLocationBean.setHabName(rset.getString(5));
				rwsLocationBean.setSchoolCode(rset.getString(4)+rset.getString("SCHOOL_CODE"));
				rwsLocationBean.setSchoolName(rset.getString("school_name"));
				rwsLocationBean.setSchoolClasification(rset.getString("SCHOOL_CODE"));
			}			 
			else if(scheme.equals("13")){
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setProposalId(proposalId);
				rwsLocationBean.setHabCode(rset.getString(4)+rset.getString(9));
				rwsLocationBean.setHabName(rset.getString(5));
				rwsLocationBean.setSchoolCode(rset.getString("hab_code")+rset.getString("SCHOOL_CODE"));
				rwsLocationBean.setSchoolName(rset.getString("school_name"));
				rwsLocationBean.setSchoolClasification(rset.getString("SCHOOL_CODE"));
			}else if(scheme.equals("14")){
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setProposalId(proposalId);
				rwsLocationBean.setHabCode(rset.getString(1)+rset.getString(2));
				rwsLocationBean.setHabName(rset.getString(3));
				rwsLocationBean.setPiCode(rset.getString(1)+rset.getString(2));
				rwsLocationBean.setPiLocation(rset.getString("LOCATION"));
				
			}
			else if(scheme.equals("12")){
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setProposalId(proposalId);
				rwsLocationBean.setLabCode(rset.getString(1));
				rwsLocationBean.setLabName(rset.getString(2));
				rwsLocationBean.setLocation(rset.getString(3));				
			}
			tempSelectedHabs.add(rwsLocationBean);
		}	
	} catch(Exception e){	
		Debug.println("The Exception is in ProposalDAO getTempSelectedHabsForAdminSancEdit : " + e.getMessage());
	} finally {
		try{
			if(rset != null) {	
				rset.close();			
			}
			if(stat != null) {	
				stat.close();
			}
			if(conn != null){	
				conn.close();
			}
		} catch(SQLException sqle){	
			Debug.println("The Exception is in ProposalDAO getTempSelectedHabsForAdminSancEdit Finally : " + sqle.getMessage());
		}
	}
	return tempSelectedHabs;
}

public ArrayList getTempSelectedHabsForAdminSancEdit1(String[] habs) {
	Connection conn = null;
	ArrayList tempSelectedHabs = new ArrayList();
	try	{
		RwsLocationBean rwsLocationBean = null; 
		for(int jj=0;jj<habs.length;jj++){
			rwsLocationBean = new RwsLocationBean();
			rwsLocationBean.setHabCode(habs[jj].substring(0,16));
			rwsLocationBean.setHabName(habs[jj].substring(17,habs[jj].length()));
			tempSelectedHabs.add(rwsLocationBean);
		}
	}
	catch(Exception e){	
		Debug.println("The Exception is in ProposalDAO getTempSelectedHabsForAdminSancEdit1() : " + e.getMessage());		
	}
	return tempSelectedHabs;
}

public String[] getTempSelectedHabsForAdminSancEdit1(String proposalId,String tabName,int len){
	Connection conn = null;
	PreparedStatement stat = null;
	ResultSet rset = null;
	ArrayList tempSelectedHabs = new ArrayList();
	String[] habcodes=new String[len];
	try	{
		conn = getConn();
		String query = " SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
				+ " FROM "+tabName+" T, rws_panchayat_raj_tbl P, rws_habitation_directory_tbl D WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code AND T.proposal_id =  ? ";	
		stat = conn.prepareStatement(query);
		stat.setString(1, proposalId);
		rset = stat.executeQuery();
		RwsLocationBean rwsLocationBean = null; 
		int i = 0;
		String a = "";
		int s = a.indexOf("(");
		while(rset.next()){
			if(rset.getString(1)!=null){
				habcodes[i]=rset.getString(2);
				i++;
			}
		}
	}
	catch(Exception e){	
		Debug.println("The Exception is in ProposalDAO getTempSelectedHabsForAdminSancEdit1 : " + e.getMessage());		
	} finally {
		try{
			if(rset != null) {	
				rset.close();			
			}
			if(stat != null) {	
				stat.close();
			}
			if(conn != null){	
				conn.close();
			}
		} catch(SQLException sqle){	
			Debug.println("The Exception is in ProposalDAO getTempSelectedHabsForAdminSancEdit1 Finally : " + sqle.getMessage());
		}
	}
	return habcodes;
	
}

public boolean insertProposalTempHabsForAdmin(String proposalId, String[] habCodes,String tabName,boolean flag) {
	String code = proposalId.substring(6,8);
	Connection conn = null;
	Statement stat = null;
	int[] updateCounts;
	try{
		conn = getConn();
		conn.setAutoCommit(false);
		stat = conn.createStatement();
		query="";
		boolean status=true,status1=true,status2=true;
		String selQry = "SELECT  COUNT(*) from tab where UPPER(tname) = ? ";
		PreparedStatement stmt1=conn.prepareStatement(selQry);
		stmt1.setString(1, tabName.toUpperCase());
		ResultSet rs=stmt1.executeQuery();
		if(rs.next()){
			if(rs.getInt(1)>0)
				status = false;		
		}	
		if(status && (!(code.equals("11")|| code.equals("12")|| code.equals("13")|| code.equals("14")))){ 
			query = "create table "+ tabName+" as select proposal_id,hab_code as hab_code from rws_temp_proposal_hab_tbl where 1=2";
		 	stat.addBatch(query);
		}
		if(status && code.equals("11")){
			query = "create table "+ tabName+" as select proposal_id,hab_code,'123' as school_code from rws_temp_proposal_hab_tbl where 1=2";
		 	stat.addBatch(query);
		}
		if(status && code.equals("12")){
			query = "create table "+ tabName+" as select proposal_id,'21' as lab_code from rws_temp_proposal_hab_tbl where 1=2";
			stat.addBatch(query);
		}	
		if(status && code.equals("13")){
			query = "create table "+ tabName+" as select proposal_id,hab_code,'123' as school_code from rws_temp_proposal_hab_tbl where 1=2";
		 	stat.addBatch(query);
		}
		if(status && code.equals("14")){
			query = "create table "+ tabName+" as select proposal_id,hab_code,'123' as pi_code from rws_temp_proposal_hab_tbl where 1=2";
		 	stat.addBatch(query);
		}
		query = "DELETE FROM "+tabName+" WHERE proposal_id='" + proposalId + "'";
		stat.addBatch(query);	
		updateCounts = stat.executeBatch();
		String tablenames="",tablenames1="" ,tablenames2="",tablenames3="",tablenames4="",tablenames5="";
		if(flag){
			tablenames1="rws_admn_hab_lnk_tbl";
			tablenames2="rws_work_school_lnk_tbl";
			tablenames3="rws_work_lab_lnk_tbl";		
			tablenames4 = "rws_work_pi_lnk_tbl";
			tablenames5 = "RWS_WORK_ANGANWADI_LNK_TBL";
		}
		else{
			tablenames1="RWS_REV_ADM_SANC_HAB_LNK_TBL";
			tablenames2="RWS_REV_SCHOOL_LNK_TBL";
			tablenames3="RWS_REV_LAB_LNK_TBL";
			tablenames4 = "RWS_REV_pi_LNK_TBL";
			tablenames5 = "RWS_REV_ANGANWADI_LNK_TBL";
		}
		if(habCodes.length>0){
			for(int i=0; i<habCodes.length; i++){
				if(habCodes[i]!=null){
					if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))
						query = " INSERT INTO "+tabName+" VALUES( "+" '"+proposalId+"', '"+habCodes[i]+"')" ; 
					else if(code.equals("11"))						
						query = " INSERT INTO "+tabName+" VALUES( "+" '"+proposalId+"', '"+habCodes[i].substring(0,16)+"', '"+habCodes[i].substring(16,habCodes[i].length()-1)+"')" ;
					else if(code.equals("12"))
						query = " INSERT INTO "+tabName+" VALUES( "+" '"+proposalId+"', '"+habCodes[i]+"')" ; 
					else if(code.equals("13")){		
						
						query = " INSERT INTO "+tabName+" VALUES( "+" '"+proposalId+"', '"+habCodes[i].substring(0,16)+"', '"+habCodes[i].substring(16,habCodes[i].length()-1)+"')" ;
					}
					else if(code.equals("14"))	{					
						query = " INSERT INTO "+tabName+" VALUES( "+" '"+proposalId+"', '"+habCodes[i].substring(0,16)+"', '"+habCodes[i].substring(16,habCodes[i].length()-1)+"')" ;
					}
					stat.addBatch(query);
				}
			}
		}
		else{ 
			if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))
				query ="insert into "+tabName+" select WORK_ID,HAB_CODE   from "+tablenames1+" where work_id='" + proposalId + "'";
			else if(code.equals("11"))
			//	query ="insert into "+tabName+" select * from "+tablenames2+" where work_id='" + proposalId + "'";
				query ="insert into "+tabName+" select work_id,hab_code,school_code from "+tablenames2+" where work_id='" + proposalId + "'";

				else if(code.equals("12"))
				query ="insert into "+tabName+" select * from "+tablenames3+" where work_id='" + proposalId + "'";
				else if(code.equals("13"))
					//	query ="insert into "+tabName+" select * from "+tablenames2+" where work_id='" + proposalId + "'";
						query ="insert into "+tabName+" select work_id,hab_code,school_code from "+tablenames5+" where work_id='" + proposalId + "'";

				else if(code.equals("14"))
					//	query ="insert into "+tabName+" select * from "+tablenames2+" where work_id='" + proposalId + "'";
						query ="insert into "+tabName+" select work_id,hab_code,pi_code from "+tablenames4+" where work_id='" + proposalId + "'";

			stat.addBatch(query);
		}
		flag = true;	
		updateCounts = stat.executeBatch();		
		for(int i=0; i<updateCounts.length; i++){
			if(updateCounts[i] < 0)
				flag = false;
		}		
		if(flag)
			conn.commit();		
	}
	catch(Exception e){	
		Debug.println("The Exception is in ProposalDAO insertProposalTempHabsForAdmin : \n" + e.getMessage());
		flag = false;
	}
	finally {
		try{
			if(stat != null){	
				stat.close();
			}
			if(conn != null){	
				conn.close();		
			}
		}
		catch(SQLException sqle){
			Debug.println("The Exception is in ProposalDAO insertProposalTempHabsForAdmin Finaly : \n" + sqle.getMessage());
		}		
	}
	return flag;
}
/*
 * added by ramesh on 170909 for add or remove in admin sanction edit
 */
//updated by swapna
public ArrayList getProposalTempHabsForAdmin(String proposalId,String tabName)
{Debug.println("getProposalTempHabsForAdmin() called.-----****----");
Debug.println("table name is:"+tabName);
Debug.println("Proposal Id : " + proposalId);
Connection conn = null;
Statement stat = null;
ArrayList habs = new ArrayList();
String code=proposalId.substring(6,8);
try
{
	conn = getConn();
	stat = conn.createStatement();
	query = "select * FROM "+tabName+" WHERE proposal_id='" + proposalId + "'";
	Debug.println("Query is :"+query);
	ResultSet rs = stat.executeQuery(query);
	int i = 0 ;
	while(rs.next())
	{
		if(!(code.equals("11")||code.equals("12")))
		{
		habs.add(i++,rs.getString("hab_code"));
		}
		else if(code.equals("11"))
		{
	habs.add(i++,rs.getString("hab_code")+rs.getString("school_code"));
		}
	}
}
catch(Exception e)
{	Debug.println("Exception in getProposalTempHabsForAdmin : \n" + e);
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

return habs;
}


public boolean insertProposalTempHabsForAdmin2(ArrayList tempSelectedHabCodes,String tabName,String workid){
	String code=workid.substring(6,8);
	Connection conn = null;
	Statement stat = null;
	int[] updateCounts;
	try{
		conn = getConn();
		conn.setAutoCommit(false);
		stat = conn.createStatement();
		boolean status=true;
		String q="SELECT * FROM TAB WHERE TNAME = ? ";
		PreparedStatement stmt1=conn.prepareStatement(q);
		stmt1.setString(1, tabName.toUpperCase());
		ResultSet rs=stmt1.executeQuery();
		if(rs.next()){
			status=false;
		}
		if(status){
			if(status && (!(code.equals("11")|| code.equals("12")))) {
				query = "create table "+ tabName+" as select * from rws_temp_proposal_hab_tbl where 1=2";
			 	stat.addBatch(query);
			}
			if(status && code.equals("11")){
				query = "create table "+ tabName+" as select proposal_id,hab_code,'123' as school_code from rws_temp_proposal_hab_tbl where 1=2";
			 	stat.addBatch(query);
			}
			if(status && code.equals("12")){
				query = "create table "+ tabName+" as select proposal_id,'21' as lab_code from rws_temp_proposal_hab_tbl where 1=2";
				stat.addBatch(query);
			}
			stat.addBatch(query);
		}	
		query = "DELETE FROM "+tabName+" WHERE proposal_id='" + workid + "'";
		stat.addBatch(query);
		updateCounts = stat.executeBatch();
		for(int i=0;i<tempSelectedHabCodes.size();i++){		
			RwsLocationBean rwsLocationBean=(RwsLocationBean)tempSelectedHabCodes.get(i);
			String proposalId=rwsLocationBean.getProposalId();
			String habCode=rwsLocationBean.getHabCode();
			String labCode=rwsLocationBean.getLabCode();		
			if(!(code.equals("11")|| code.equals("12"))){
				query = " INSERT INTO "+tabName+" VALUES( "+" '"+proposalId+"', '"+habCode+"')" ; 
			}
			else if(code.equals("11")){
				query = " INSERT INTO "+tabName+" VALUES( "+" '"+proposalId+"', '"+habCode.substring(0,16)+"','"+habCode.substring(16,19)+"')" ; 
			}
			else if(code.equals("12")){
				query = " INSERT INTO "+tabName+" VALUES( "+" '"+proposalId+"', '"+habCode+"')" ; 
			}
			stat.addBatch(query);	
		}
		if(tempSelectedHabCodes.size()==0){
			if(!(code.equals("11")||code.equals("12")))
				query ="insert into "+tabName+" select WORK_ID,HAB_CODE from RWS_REV_ADM_SANC_HAB_LNK_TBL where work_id='" + workid + "'";
			else if(code.equals("11"))
				query ="insert into "+tabName+" select * from RWS_REV_SCHOOL_LNK_TBL where work_id='" + workid + "'";
			else if(code.equals("12"))
				query ="insert into "+tabName+" select * from RWS_REV_LAB_LNK_TBL where work_id='" + workid + "'";
			stat.addBatch(query);
		}	
		flag = true;
		updateCounts = stat.executeBatch();
		for(int i=0; i<updateCounts.length; i++){
			if(updateCounts[i] < 0)
				flag = false;
		}	
		if(flag)
			conn.commit();		
	} catch(Exception e) {	
		Debug.println("The Exception is in ProposalDAO insertProposalTempHabsForAdmin2 : \n" + e.getMessage());
		flag = false;
	} finally {
		try{
			if(stat != null){	
				stat.close();
			}
			if(conn != null){	
				conn.close();
			}
		}
		catch(SQLException sqle){ 
			Debug.println("The Exception is in ProposalDAO insertProposalTempHabsForAdmin2 : \n" + sqle.getMessage());
		}	
	}
	return flag;
}
//%%%%%%%%% function to insert selected habitations to session(incomplete)
/*
public boolean insertProposalTempHabsForAdminToSession(HttpSession session,String proposalId, String[] habCodes,String tabName)
{
	Debug.println("insertProposalTempHabsForAdminToSession() called.-----****----");
	Debug.println("table name is:"+tabName);
	Debug.println("Proposal Id : " + proposalId);
	Debug.println("Hab Codes Length: " + habCodes.length);
	
	ArrayList tempSelectedHabs=(ArrayList)session.getAttribute("tempSelectedHabs");
	if(tempSelectedHabs==null)
		tempSelectedHabs=new ArrayList();
	
	Connection conn = null;
	Statement stat = null;
	int[] updateCounts;
	try
	{
		conn = getConn();
		conn.setAutoCommit(false);
		stat = conn.createStatement();
		Statement stmt1=conn.createStatement();
		boolean status=true;
		ResultSet rs=stmt1.executeQuery("select * from tab where tname ='"+tabName.toUpperCase()+"'");
		Debug.println("select * from tab where tname ='"+tabName.toUpperCase()+"'");
		if(rs.next())
		{
			Debug.println("table already exists");
			status=false;
		}
		if(status)
		{
		 query = "create table "+ tabName+" as select * from rws_temp_proposal_hab_tbl where 1=2";
		 Debug.println(query);
		 stat.addBatch(query);
		}
		query = "DELETE FROM "+tabName+" WHERE proposal_id='" + proposalId + "'";
		Debug.println("Query is :"+query);
		stat.addBatch(query);
 
		updateCounts = stat.executeBatch();
		Debug.println("Habcodes length is"+habCodes.length);
		for(int i=0; i<habCodes.length; i++)
		{
			if(habCodes[i]!=null)
			{
			query = " INSERT INTO "+tabName+" VALUES( "
				  + " '" + proposalId + "', '" + habCodes[i] + "')" ; 
			Debug.println("Query is "+query);
			stat.addBatch(query);
			}
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
	{	Debug.println("Exception in insertProposalTempHabs : \n" + e);
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
*/
public ArrayList getTempSelectedHabsForAdminSanc(String tablename,String cirlce)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	ArrayList tempSelectedHabs = new ArrayList();
	try
	{
		conn = getConn();
		stat = conn.createStatement();
		
		
		String query = " SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, " 
			 + " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
	         + " FROM "+tablename+" T, rws_panchayat_raj_tbl P, " 
	         + " rws_habitation_directory_tbl D "
			 + " WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code "
			 + " and  substr(T.proposal_id,5,2)='"+cirlce+"' ORDER BY T.proposal_id ";
					 
		Debug.println("Query is "+query);
		rset = stat.executeQuery(query);
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
	}
	catch(Exception e)
	{	Debug.println("Exception in getTempSelectedHabsForAdminSanc() : " + e);
		
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


public ArrayList getTempSelectedHabsForAdminSanc2(ArrayList selectedHabCodes,String cirlce,String ses_id){
	Connection conn = null;
	PreparedStatement stat = null;
	ResultSet rset = null;
	ArrayList tempSelectedHabs = new ArrayList();	
	try{
		conn = getConn();
		insertProposalTempHabsForAdmin3(selectedHabCodes,"tempSelectedHabs_tbl",ses_id);				
		String query = "SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, " 
			 + " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) FROM tempSelectedHabs_tbl T, rws_panchayat_raj_tbl P, " 
	         + " rws_habitation_directory_tbl D WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code and substr(T.proposal_id,5,2)= ? ORDER BY T.proposal_id ";	
		stat = conn.prepareStatement(query);
		stat.setString(1, cirlce);
		rset = stat.executeQuery();
		RwsLocationBean rwsLocationBean = null; 
		while(rset.next()){
			rwsLocationBean = new RwsLocationBean();
			rwsLocationBean.setProposalId(rset.getString(1));
			rwsLocationBean.setHabCode(rset.getString(2));
			rwsLocationBean.setHabName(rset.getString(3));
			rwsLocationBean.setStatus(rset.getString(4));
			rwsLocationBean.setPopulation(rset.getString(5));
			tempSelectedHabs.add(rwsLocationBean);
		}
		query="DELETE FROM tempSelectedHabs_tbl where SESSION_ID= ? ";
		stat = conn.prepareStatement(query);
		stat.setString(1, ses_id);
		stat.executeUpdate(query);
	}
	catch(Exception e){	
		Debug.println("The Exception is in ProposalDAO getTempSelectedHabsForAdminSanc2 : " + e.getMessage());		
	}
	finally	{
		try{
			if(rset != null) {	
				rset.close();				
			}
			if(stat != null) {
				stat.close();
			}
			if(conn != null){	
				conn.close();
			}
		}catch(SQLException sqle){
			Debug.writeln("The Exception is in ProposalDAO getTempSelectedHabsForAdminSanc2 finally : \n" + sqle.getMessage());
		}
	}
	return tempSelectedHabs;
}


public boolean insertProposalTempHabsForAdmin3(ArrayList tempSelectedHabCodes,String tabName,String ses_id){
	Connection conn = null;
	PreparedStatement stmt1 = null;
	Statement stat = null;
	ResultSet rs=null;
	int[] updateCounts;
	try {
		conn = getConn();
		stat = conn.createStatement();
		conn.setAutoCommit(false);
		boolean status=true;
		stmt1=conn.prepareStatement("select * from tab where tname = ? ");
		stmt1.setString(1, tabName.toUpperCase());
		rs=stmt1.executeQuery();
		if(rs.next()){
			status=false;
		}
		if(status){
			 query = "create table "+ tabName+" as select * from rws_temp_proposal_hab_tbl where 1=2";
			 stat.addBatch(query);
		}
		updateCounts = stat.executeBatch();
		for(int i=0;i<tempSelectedHabCodes.size();i++){
			RwsLocationBean rwsLocationBean=(RwsLocationBean)tempSelectedHabCodes.get(i);
			String proposalId=rwsLocationBean.getProposalId();
			String habCode=rwsLocationBean.getHabCode();
			query = " INSERT INTO "+tabName+" VALUES("+"'"+proposalId+"', '"+habCode+"', '"+ses_id+"')" ; 
			stat.addBatch(query);
		}
		flag = true;
		updateCounts = stat.executeBatch();		
		for(int i=0; i<updateCounts.length; i++){
			if(updateCounts[i] < 0)
				flag = false;
		}
		flag = true;
		if(flag){
			conn.commit();				
		}
	}
	catch(Exception e){	
		Debug.println("The Exception is in ProposalDAO insertProposalTempHabsForAdmin3 : \n" + e.getMessage());
		flag = false;
	}
	finally{
		try{
			if(rs != null){	
				rs.close();
			}
			if(stat != null){	
				stat.close();
			}
			if(stmt1 != null){	
				stmt1.close();
			}
		}catch(SQLException sqle){
			Debug.writeln("The Exception is in ProposalDAO getTempSelectedHabsForAdminSanc2 finally : \n" + sqle.getMessage());
		}
	}
	return flag;
}

///%%%%%%%%%%function to get selected temp habs
public ArrayList getTempSelectedHabsForAdminSancFromSession(HttpSession session,String tablename,String cirlce)
{
	Connection conn = null;
	Statement stat = null;
	ResultSet rset = null;
	ArrayList tempSelectedHabs = new ArrayList();
	try
	{
		conn = getConn();
		stat = conn.createStatement();
		String query = " SELECT distinct T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, " 
			 + " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
	         + " FROM "+tablename+" T, rws_panchayat_raj_tbl P, " 
	         + " rws_habitation_directory_tbl D "
			 + " WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code "
			 + " and  substr(T.proposal_id,5,2)='"+cirlce+"' ORDER BY T.proposal_id ";
					 
		Debug.println("Query is "+query);
		rset = stat.executeQuery(query);
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
	}
	catch(Exception e)
	{	Debug.println("Exception in getTempSelectedHabsForAdminSancFromSession() : " + e);
		
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
//updated by swapna
public String[] getMandalCodesFormRevised(String proposalId)throws Exception 
{Debug.println("revised>>>>>>>>>>>>>>>>>>>in proposal");
Connection conn=null;
String[] mcodes={};
String q="";
try
{
	String code=proposalId.substring(6,8);
	Debug.println("code in getMandalCodesFormrevised"+code);
  conn=RwsOffices.getConn();
  Statement stmt=conn.createStatement();
 // Debug.println("select distinct substr(hab_code,6,2) from RWS_ADMN_HAB_LNK_TBL  where WORK_ID ='"+proposalId+"'");
  if(!(code.equals("11")||code.equals("12")))
  {
  q="select distinct substr(hab_code,6,2) from RWS_REV_ADM_SANC_HAB_LNK_TBL  where WORK_ID ='"+proposalId+"'";
  }
  else if(code.equals("11"))
  	{
  q="select distinct substr(hab_code,6,2) from RWS_REV_SCHOOL_LNK_TBL  where WORK_ID ='"+proposalId+"'";
  	}
  else if(code.equals("12"))
  	{
  	q="select  distinct substr(b.office_code,2,2) from RWS_REV_LAB_LNK_TBL a, rws_water_quality_lab_tbl b where WORK_ID ='"+proposalId+"' and a.lab_code=b.lab_code";
  	}
  	Debug.println("QQQQ in revised"+q);
  ResultSet rs=stmt.executeQuery(q);
  int count = 0;
  
  while(rs.next())
  {
  	count++;
  }
  mcodes=new String[count];
  if(!(code.equals("11")|| code.equals("12")))
  {
  q="select distinct substr(hab_code,6,2) from RWS_REV_ADM_SANC_HAB_LNK_TBL  where WORK_ID ='"+proposalId+"'";
  }
  else
  	if(code.equals("11"))
  	{
  		q="select distinct substr(hab_code,6,2) from RWS_REV_SCHOOL_LNK_TBL  where WORK_ID ='"+proposalId+"'";
  	}
  	if(code.equals("12"))
  	{
  		q="select  distinct substr(b.office_code,2,2) from RWS_REV_LAB_LNK_TBL a, rws_water_quality_lab_tbl b where WORK_ID ='"+proposalId+"' and a.lab_code=b.lab_code";
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
	Debug.println("#### mcodes length in revised:::::::::"+mcodes.length);
}
catch(Exception e)
{
	Debug.println("Exception is :##"+e);
}
finally
{
	conn.close();
}
return mcodes;}

public String formatNull(String val)
{
	if(val==null)
	{
		val="0";
	}
	return val;
}

protected ArrayList getAdminstrativeSanctionList1(String proposalId,String officeCode,String workId,String circlecode,String divcode,String subdivcode,String catg,String schm,String prog,String subprog){
	Connection conn = null;
	PreparedStatement stat = null;
	ResultSet rset = null;
	String query="";
	String newsubdiv="";
	String scheme=proposalId.substring(6,8);
	try{
		 query="select substr(office_code,5,2) from rws_work_admn_tbl where work_id= ? ";
		 conn = getConn();
		 stat = conn.prepareStatement(query);
		 stat.setString(1, proposalId);
		 rset = stat.executeQuery();
		 if (rset.next()) {
			 newsubdiv=rset.getString(1);
		 }
		 if ( newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00")){
		 	query = "SELECT distinct ad.WORK_NAME ,ad.WORK_ID," ;
		    if(!(scheme.equals("11")|| scheme.equals("12"))){
				query += "NO_OF_HABS";
			}
			else if(scheme.equals("11")){
				query += "NO_OF_SCHOOLS";
 			}
			else if(scheme.equals("12")){
				query += "NO_OF_LABS";
 			} 
		   query += ",ad.ESTIMATE_COST,ad.SANCTION_AMOUNT,ad.ADMIN_NO,to_char(ad.ADMIN_DATE,'dd/mm/yyyy') " +
			",decode(ad.SPILL_OVER,'y','YES','','No'),At.TYPE_OF_ASSET_NAME,p.PROGRAMME_Name ," +
			" s.SUBPROGRAMME_NAME,ad.PREPARED_BY ,to_char(ad.PREPARED_ON,'dd/mm/yyyy')as" +
			" prepared_on ,AD.remarks,ad.office_code,w.CATEGORY_NAME,to_char(ad.PREPARED_ON,'yyyy/mm/dd')" +
			" ,c.circle_office_code,c.circle_office_name,d.division_office_code,d.division_office_name" +
			",sd.subdivision_office_code,sd.subdivision_office_name,pl.plan_name,a.AUG_NEW_NAME,ad.AUG_WORKID,ad.approved_under,ad.lead_habitation,ad.core_dashboard_status,nvl(ad.STATE_APPROVED,'') as STATE_APPROVED"+
			" FROM  rws_work_admn_tbl ad, rws_programme_tbl P,  rws_subprogramme_tbl S, " +
			" rws_asset_type_tbl AT,rws_work_category_tbl w " +
			",rws_circle_office_tbl c,rws_division_office_tbl d" +
			",rws_subdivision_office_tbl sd,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl a  "+
			" where "+" ad.AUG_NEW_CODE=a.AUG_NEW_CODE  and ad.plan_code=pl.plan_code and w.category_code=ad.category_code and at.TYPE_OF_ASSET_CODE = ad.TYPE_OF_ASSET and  P.PROGRAMME_CODE=ad.PROGRAMME_CODE " +
			" AND (ad.PROGRAMME_CODE=s.PROGRAMME_CODE  and ad.subprogramme_code=s.subprogramme_code) and work_id='"+proposalId+"' "+
			" and substr(ad.office_code,2,2)=c.circle_office_code and (substr(ad.office_code,2,2)=d.circle_office_code and substr(ad.office_code,4,1)=d.division_office_code) "+ 
	        " and (substr(ad.office_code,2,2)=sd.circle_office_code and substr(ad.office_code,4,1)=sd.division_office_code and "+ 
	        " substr(ad.office_code,5,2)=sd.subdivision_office_code)";
		 } else {
			query = "SELECT distinct ad.WORK_NAME ,ad.WORK_ID," ;
			 if(!(scheme.equals("11")|| scheme.equals("12"))){
				query += "NO_OF_HABS";
			 }
			 else if(scheme.equals("11")){
				query += "NO_OF_SCHOOLS";
 			 }
			 else if(scheme.equals("12")){
				 query += "NO_OF_LABS";
			 }  
			 query+=",ad.ESTIMATE_COST,ad.SANCTION_AMOUNT,ad.ADMIN_NO,to_char(ad.ADMIN_DATE,'dd/mm/yyyy') " +
					 ",decode(ad.SPILL_OVER,'y','YES','','No'),At.TYPE_OF_ASSET_NAME,p.PROGRAMME_Name ," +
					 " s.SUBPROGRAMME_NAME,ad.PREPARED_BY ,to_char(ad.PREPARED_ON,'dd/mm/yyyy')as" +
					 " prepared_on ,AD.remarks,ad.office_code,w.CATEGORY_NAME,to_char(ad.PREPARED_ON,'yyyy/mm/dd')" +
					 " ,c.circle_office_code,c.circle_office_name,d.division_office_code,d.division_office_name,pl.plan_name,a.AUG_NEW_NAME,ad.AUG_WORKID,ad.approved_under,ad.lead_habitation,ad.core_dashboard_status,nvl(ad.STATE_APPROVED,'') as STATE_APPROVED" +
					 " FROM  rws_work_admn_tbl ad, rws_programme_tbl P,  rws_subprogramme_tbl S, " +
					 " rws_asset_type_tbl AT,rws_work_category_tbl w " +
					 ",rws_circle_office_tbl c,rws_division_office_tbl d,rws_plan_nonplan_tbl pl,rws_augumentation_new_tbl a " +
					 " where " +
					 "  ad.AUG_NEW_CODE=a.AUG_NEW_CODE  and ad.plan_code=pl.plan_code and w.category_code=ad.category_code and at.TYPE_OF_ASSET_CODE = ad.TYPE_OF_ASSET and  P.PROGRAMME_CODE=ad.PROGRAMME_CODE " +
					 " AND (ad.PROGRAMME_CODE=s.PROGRAMME_CODE  and ad.subprogramme_code=s.subprogramme_code) and work_id='"+proposalId+"' "+
					 " and substr(ad.office_code,2,2)=c.circle_office_code and (substr(ad.office_code,2,2)=d.circle_office_code and substr(ad.office_code,4,1)=d.division_office_code) "; 
        }
		if(!workId.equals("")){
			query=query+" and ad.WORK_ID='"+workId+"'";
		}
	    if(((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& divcode.equals("") && subdivcode.equals(""))) || ((catg!=null&&catg.equals("")|| schm!=null&& schm.equals("")|| prog!=null&& prog.equals("")||subprog!=null&& subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& divcode.equals("") && subdivcode.equals("")))){
	    	query=query+" and substr(ad.WORK_ID,5,2)='"+circlecode+"'";			
		}
	    else if(((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& !divcode.equals("") && subdivcode.equals(""))) || ((catg!=null&& catg.equals("")|| schm!=null&& schm.equals("")|| prog!=null&& prog.equals("")||subprog!=null&& subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& !divcode.equals("") && subdivcode.equals("")))){
	    	query=query+" and substr(ad.WORK_ID,5,2)='"+circlecode+"'";
		}
	    else if(((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& !divcode.equals("") && !subdivcode.equals(""))) || ((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&&!circlecode.equals("")&& !divcode.equals("") && !subdivcode.equals("")))){
	    	query=query+" and substr(ad.WORK_ID,5,2)='"+circlecode+"'";
		}
	    else if(((catg!=null&&!catg.equals("")|| schm!=null&& !schm.equals("")|| prog!=null&& !prog.equals("")||subprog!=null&& !subprog.equals(""))&& (circlecode!=null&& circlecode.equals("")&& divcode.equals("") && subdivcode.equals("")))){
	   	}	    
		query=query+" order by 17 desc";		
		conn = getConn();
		stat = conn.prepareStatement(query);
		rset = stat.executeQuery();
		representativeProposals = new ArrayList();		
		while(rset.next()){
			proposalDTO = new ProposalDTO();			
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
			proposalDTO.setOthers(rset.getString(16));			
			proposalDTO.setWorkCat(rset.getString(16));
			proposalDTO.setCircleOfficeCode(rset.getString(18));
			proposalDTO.setCircleOfficeName(rset.getString(19));
			proposalDTO.setDivisionOfficeCode(rset.getString(20));
		 	proposalDTO.setDivisionOfficeName(rset.getString(21));
		 	if ( newsubdiv!=null && !newsubdiv.equals("") && !newsubdiv.equals("00")){
		 	    proposalDTO.setSubdivisionOfficeCode(rset.getString(22));
		 	    proposalDTO.setSubdivisionOfficeName(rset.getString(23));
		 	    proposalDTO.setPlan(rset.getString(24));
		 	    proposalDTO.setWrkType(rset.getString(25));
		 	}
		 	else if( newsubdiv==null || newsubdiv.equals("") || newsubdiv.equals("00")){
		 		proposalDTO.setSubdivisionOfficeCode("00");
		 		proposalDTO.setPlan(rset.getString(22));
			 	proposalDTO.setWrkType(rset.getString(23));
		 	}
		 	proposalDTO.setAugsch(rset.getString("aug_workid"));
		 	proposalDTO.setProoved(rset.getString("approved_under"));
		 	proposalDTO.setLeadHabitation(rset.getString("LEAD_HABITATION"));
		 	proposalDTO.setCoreDashboardStatus(rset.getString("core_dashboard_status"));
		 	proposalDTO.setApprooved(rset.getString("STATE_APPROVED"));
		 	representativeProposals.add(proposalDTO);
		}
	}
	catch(Exception e){	
		Debug.writeln("The Exception is in ProposalDAO getAdminstrativeSanctionList1 : \n" + e.getMessage());	
	}
	finally{
		try{
			if(rset != null){	
				rset.close();
			}
			if(stat != null){	
				stat.close();
			}
			if(conn != null){		
				conn.close();
			}
		}
		catch(SQLException sqle){ 
			Debug.writeln("The Exception is in ProposalDAO getAdminstrativeSanctionList1 finally : \n" + sqle.getMessage());	
		}
	}
	return representativeProposals;
} 

protected ArrayList getRevisedSanctionList(String officeCode,String workId,String workcategory,String asset,String program,String subProgram,String circle,String division,String subdiv)
{
	
	Debug.println(workcategory+"*"+asset+"*"+program+"*"+subProgram+"*"+circle+"*"+division+"*"+subdiv);
	Connection conn = null;
	Statement stat = null,stat1=null;
	ResultSet rset = null,rset1= null;
	Debug.println("in getRevisedSanctionList()");
	try
	{
		
			query = "select distinct adm.work_name,adm.work_id,ADMIN_NO ,to_char(ADMIN_DATE,'dd/mm/yyyy') ,SANCTION_AMOUNT ," +
					"REV_ADMIN_NO ," +
					"to_char(REV_ADMIN_DATE,'dd/mm/yyyy') ,REV_SANCTION_AMOUNT," +
					"adm.no_of_habs,rv.no_of_habs ,c.circle_office_name,p.PROGRAMME_Name,s.SUBPROGRAMME_NAME ,At.TYPE_OF_ASSET_NAME," +
					"c.circle_office_code ,adm.office_code,adm.WORK_CATEGORY,d.division_office_code,d.division_office_name " +
					
					" from RWS_REVISED_ADM_SANC_TBL rv,rws_work_admn_tbl" +
					" adm,rws_circle_office_tbl c,rws_division_office_tbl d,rws_programme_tbl p,  rws_asset_type_tbl AT,rws_subprogramme_tbl S" +
					" where rv.WORK_ID=adm.work_id and c.circle_office_code=substr(rv.work_id,5,2)" +
					"and P.PROGRAMME_CODE=substr(rv.work_id,1,2) and s.SUBPROGRAMME_CODE(+)=substr(rv.work_id,3,2)" +
					" and s.PROGRAMME_CODE=p.PROGRAMME_CODE and at.TYPE_OF_ASSET_CODE=substr(rv.work_id,7,2) " + 
					" and d.circle_office_code=c.circle_office_code and substr(adm.office_code,4,1)=d.division_office_code ";
					 
			if(!workId.equals(""))
			{
				query=query+" and adm.WORK_ID='"+workId+"'";
			}
			if(!workcategory.equals(""))
			{
				query=query+" and adm.WORK_CATEGORY='"+workcategory+"'";
			}
			if(!asset.equals(""))
			{
				query=query+" and adm.TYPE_OF_ASSET ='"+asset+"'";
			}
			if(!program.equals(""))
			{
				query=query+" and adm.PROGRAMME_CODE ='"+program+"'";
			}
			if(!subProgram.equals(""))
			{
				query=query+" and adm.SUBPROGRAMME_CODE ='"+subProgram+"'";
			}
			
			if(!circle.equals(""))
			{
				query=query+" and substr(adm.OFFICE_CODE,2,2) ='"+circle+"'";
			}
			if(!division.equals(""))
			{
				query=query+" and substr(adm.OFFICE_CODE,4,1) ='"+division+"'";
			}
			if(!subdiv.equals(""))
			{
				query=query+" and substr(adm.OFFICE_CODE,5,2) ='"+subdiv+"'";
			}
			
			query=query+" order by adm.work_name ";
			
		
 		conn = getConn();
		stat = conn.createStatement();
		Debug.println("query is "+query);
		rset = stat.executeQuery(query);
		representativeProposals = new ArrayList();
		
		while(rset.next())
		{
			proposalDTO = new ProposalDTO();
			
			proposalDTO.setProposalName(rset.getString(1));
			proposalDTO.setProposalId(rset.getString(2));
			proposalDTO.setAdminNo(rset.getString(3));
			proposalDTO.setAdminDate(rset.getString(4));
			proposalDTO.setSanctionedAmount(rset.getString(5));
			proposalDTO.setRevAdminNo(rset.getString(6));
			proposalDTO.setRevAdminDate(rset.getString(7));
			proposalDTO.setRevSanctionedAmount(rset.getString(8));
			proposalDTO.setNoOfHabs(rset.getString(9));
			proposalDTO.setRevNoOfHabs(rset.getString(10));
			proposalDTO.setCircleOfficeName(rset.getString(11));
			proposalDTO.setProgrammeName(rset.getString(12));
			proposalDTO.setSubprogrammeName(rset.getString(13));
			proposalDTO.setTypeOfAsset(rset.getString(14));
			proposalDTO.setCircleOfficeCode(rset.getString(15));
			proposalDTO.setOfficeCode(rset.getString(16));
			proposalDTO.setWorkCat(rset.getString(17));
			proposalDTO.setDivisionOfficeName(rset.getString(19));
			proposalDTO.setDivisionOfficeCode(rset.getString(18));
			String office=rset.getString(16);
			Debug.println("OFFICE CODE = "+office);
			if( !( (office.substring(4)).equals("00") ) )
				{
					Debug.println("333333333");
					try 
					   {
						stat1 = conn.createStatement();
						String str="select subdivision_office_code,subdivision_office_name" +
						    		" from rws_subdivision_office_tbl where " +
						    		" circle_office_code='"+proposalDTO.getCircleOfficeCode()+"' " +
									" and division_office_code='"+proposalDTO.getDivisionOfficeCode()+"' " +
									" and subdivision_office_code='"+office.substring(4)+"'";
						Debug.println(str);
						rset1=stat1.executeQuery(str);
						while(rset1.next())
								{
								  Debug.println("44444444");
								  proposalDTO.setSubdivisionOfficeCode(rset1.getString(1));
								  proposalDTO.setSubdivisionOfficeName(rset1.getString(2));
								}
					   }
					   catch(Exception e)
					            {Debug.println("Exception in Getting Subdiv data"+e.getMessage());}
				}
	 		representativeProposals.add(proposalDTO);
		}
	}
	catch(Exception e)
	{	Debug.writeln("Exception in getRevisedSanctionList : \n" + e);			
	}
	finally
	{	
		 if(rset1 != null)
	     {
	     	try{rset1.close();}
	        catch(Exception e){}
	     }
	     if(stat1 != null)
	     {
	     	try{stat1.close();}
	        catch(Exception e){}
	     }		
		
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
public static Connection getConn(){
	Connection conn2=null;
	try {
		conn2 = RwsOffices.getConn(); 
	} catch (Exception e) {
		Debug.println("The Exception is in ProposalDAO getConn() :"+e.getMessage());
	}
	return conn2;
}

	
	
	public void saveHabsToTempTable(String tabName1, String[] habsarray, String sessionid,String proposalId) {
		Connection conn=getConn();
		PreparedStatement stmt=null,stmt1=null,stmt2=null,stmt3=null;
		ResultSet rs=null;
		try{
		conn.setAutoCommit(true);
		String code = proposalId.substring(6,8);
		boolean status=false;		
		String selQry = "SELECT  COUNT(*) from tab where UPPER(tname) = ? ";
		stmt1=conn.prepareStatement(selQry);
		stmt1.setString(1, tabName1.toUpperCase());
		rs=stmt1.executeQuery();
		if(rs.next()) {
			if(rs.getInt(1)>0)
				status = false;else status=true;		
		}
		if(status){
			String qs="";							
			if(!(code.equals("11")|| code.equals("12") || code.equals("13") || code.equals("14"))) {
		 		qs="create table "+tabName1+" (PROPOSAL_ID VARCHAR2(14),HAB_CODE VARCHAR2(16),HAB_NAME VARCHAR2(100),SID VARCHAR2(100),RECORD_DATE DATE)";
			}
			else if(code.equals("11")) {
				qs="create table "+tabName1+" (PROPOSAL_ID VARCHAR2(14),HAB_CODE VARCHAR2(16),SCHOOL_CODE VARCHAR2(100),SID VARCHAR2(100),RECORD_DATE DATE)";
			}
			else if(code.equals("12")) {
				qs="create table "+tabName1+" (PROPOSAL_ID VARCHAR2(14),LAB_CODE VARCHAR2(100),SID VARCHAR2(100),RECORD_DATE DATE)";
			}else if(code.equals("13")) { //Aganwadi tbl
				qs="create table "+tabName1+" (PROPOSAL_ID VARCHAR2(14),HAB_CODE VARCHAR2(16),ANGANWADI_CODE VARCHAR2(100),SID VARCHAR2(100),RECORD_DATE DATE)";
			}else if(code.equals("14")) { //public Institute code
				qs="create table "+tabName1+" (PROPOSAL_ID VARCHAR2(14),HAB_CODE VARCHAR2(16),PI_CODE VARCHAR2(100),SID VARCHAR2(100),RECORD_DATE DATE)";
			}			
			stmt2=conn.prepareStatement(qs);
			stmt2.executeUpdate();
		}
		String q="";		
		String currentDate=RwsUtils.getCurrentDate("dd/MM/yyyy");		
		stmt3=conn.prepareStatement("delete from "+tabName1+" where SID= ? ");
		stmt3.setString(1, sessionid);
		stmt3.executeUpdate();		
		for(int i = 0;i<habsarray.length;i++){
			if(!(code.equals("11")|| code.equals("12")|| code.equals("13") || code.equals("14"))){				
				q="insert into "+tabName1+ " values('"+proposalId+"','"+habsarray[i].substring(0,16)+"','"+habsarray[i].substring(17,habsarray[i].length())+"','"+sessionid+"',to_date('"+currentDate+"','dd/mm/yyyy'))";
			} else if(code.equals("11")){
		 		q="insert into "+tabName1+ " values('"+proposalId+"','"+habsarray[i].substring(0,16)+"','"+habsarray[i].substring(17,habsarray[i].length())+"','"+sessionid+"',to_date('"+currentDate+"','dd/mm/yyyy'))";
		 	} 
			else if(code.equals("13")){
		 		q="insert into "+tabName1+ " values('"+proposalId+"','"+habsarray[i].substring(0,16)+"','"+habsarray[i].substring(17,habsarray[i].length())+"','"+sessionid+"',to_date('"+currentDate+"','dd/mm/yyyy'))";
		 	}
			
			else if(code.equals("12")){				 	
			 	q="insert into "+tabName1+ " values('"+proposalId+"','"+habsarray[i].substring(0,habsarray[i].length())+"','"+sessionid+"',to_date('"+currentDate+"','dd/mm/yyyy'))";
			}	else if(code.equals("14")){
		 		q="insert into "+tabName1+ " values('"+proposalId+"','"+habsarray[i].substring(0,16)+"','"+habsarray[i].substring(17,habsarray[i].length())+"','"+sessionid+"',to_date('"+currentDate+"','dd/mm/yyyy'))";
		 	}	
			//System.out.println("q in saveHabsToTempTable :"+q);
		stmt3=conn.prepareStatement(q);
		stmt3.executeUpdate();
		conn.commit();
		}
		}catch(Exception e){
			Debug.writeln("The Exception is in ProposalDAO saveHabsToTempTable : \n" + e.getMessage());		
		}
		finally{	
			try{
				if(rs != null) {	
					rs.close();				
				}
				if(stmt != null) {
					stmt.close();
				}
				if(stmt1 != null) {
					stmt1.close();
				}
				if(stmt2 != null) {
					stmt3.close();
				}
				if(stmt3 != null) {
					stmt3.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO saveHabsToTempTable finally : \n" + sqle.getMessage());
			}
		}
	}

	
	public void deleteTempTables(String tabName1, String proposalId, String sessionId) {
		Connection conn=getConn();
		PreparedStatement smt=null;
		try{
			smt=conn.prepareStatement("delete from  "+tabName1+" where PROPOSAL_ID= ? ");
			smt.setString(1, proposalId);
			smt.executeUpdate();
		}catch(Exception e){	
			Debug.writeln("The Exception is in ProposalDAO deleteTempTables : \n" + e.getMessage());			
		}
		finally{	
			try{				
				if(smt != null) {
					smt.close();
				}
				if(conn != null){	
					conn.close();
				}
			}catch(SQLException sqle){
				Debug.writeln("The Exception is in ProposalDAO deleteTempTables finally : \n" + sqle.getMessage());
			}
		}
		
	}
}