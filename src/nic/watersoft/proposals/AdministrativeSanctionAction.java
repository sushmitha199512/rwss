package nic.watersoft.proposals;

import java.text.SimpleDateFormat;
import java.util.Date;
//import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.ArrayList;
import java.lang.StringBuffer;

import javax.sql.DataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class AdministrativeSanctionAction extends Action {
	String new_wid;
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String target = new String("insert-success");
		String tabName1="";
		RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;
		Administrative_Sanction_Act adact=new Administrative_Sanction_Act();
		Connection conn = null;
		PreparedStatement stmt = null, stmt1=null, stmt2=null;
		Statement stat = null;		
		ResultSet rst=null;
		DataSource dataSource = getDataSource(request);
		String mode = myForm.getMode();
		String leadhab = request.getParameter("leadhab");
		String leadvalue = "";
		HttpSession session = request.getSession();
		RwsUser user=(RwsUser)session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId()!=null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}
		String sessionId=session.getId();		
		if(leadhab != null && !leadhab.equals("undefined")){
			session.setAttribute("leadvalue",request.getParameter("leadhab"));
		}
	    String revisedUpdatedViewId="";
		String query = null;
		String officeCode = myForm.getHeadOfficeCode() + myForm.getCircleOfficeCode() + myForm.getDivisionOfficeCode() + myForm.getSubdivisionOfficeCode();
		boolean work_id_available=false;
		String message = "";
		String month[]={"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
		try{			
			if(mode != null && mode.equals("duplicateCheck")){			
			    int no_of_duplicate_records=0;
				conn=RwsOffices.getConn();
				stat=conn.createStatement();
				Iterator iterator1 = myForm.getProposals().iterator();
				ProposalHolder proposalHolder1 = null;
			 	while(iterator1.hasNext()){
					proposalHolder1 = (ProposalHolder)iterator1.next();
				}
			 	StringBuffer s=new StringBuffer(proposalHolder1.getAdminiStrativeDate());
			 	String date=s.replace(3,5,month[Integer.parseInt(s.substring(3,5))-1])+"";
			 	String qry="SELECT * FROM RWS_WORK_ADMN_TBL WHERE SUBSTR(OFFICE_CODE,2,2)= ? AND NO_OF_HABS= ? AND PROGRAMME_CODE= ? AND SUBPROGRAMME_CODE= ? AND TYPE_OF_ASSET= ? AND SANCTION_AMOUNT= ? AND PLAN_CODE= ? AND AUG_NEW_CODE= ? AND CATEGORY_CODE= ? AND ADMIN_DATE= ? ";
			 	stmt=conn.prepareStatement(qry);
			 	stmt.setString(1, myForm.getCircleOfficeCode());
			 	stmt.setString(2, proposalHolder1.getNoOfHabs());
			 	stmt.setString(3, myForm.getPrograms());
			 	stmt.setString(4, myForm.getSubPrograms());
			 	stmt.setString(5, myForm.getTypeOfAsset());
			 	stmt.setString(6, proposalHolder1.getSanctionAmout());
			 	stmt.setString(7, myForm.getPlan());
			 	stmt.setString(8, myForm.getWrktype());
			 	stmt.setString(9, myForm.getWorkCat());
			 	stmt.setString(10, date);									
				rst=stmt.executeQuery();
			 	while(rst.next()) {
			 		no_of_duplicate_records++;
			 	}		 	
			 	if(no_of_duplicate_records > 0)	{
			 		request.setAttribute("duplicateExist","Y");
			 	} else {
			 		request.setAttribute("duplicateExist","N");		 		
			 	}
			   target="failure1";
			   Iterator iterator = myForm.getProposals().iterator();
			   ProposalHolder proposalHolder = null;
			   while(iterator.hasNext()){
				   proposalHolder = (ProposalHolder)iterator.next();
				   String[] habCodes = request.getParameterValues("H_"+proposalHolder.getProposalId());
				   if(leadhab != null && leadhab.equals("undefined")){
					   session.setAttribute("leadvalue",habCodes[0]);
					}
			   }		   
		    }
			
			if(mode != null && mode.equals("Save")){			
				if(session.getAttribute("leadvalue") != null){
					leadvalue = (String)session.getAttribute("leadvalue");
				}
				if(request.getParameter("leadlab")!=null && !request.getParameter("leadlab").equals(""))
					leadvalue = request.getParameter("leadlab");
				try {
					conn = RwsOffices.getConn();
					stat=conn.createStatement();					
					conn.setAutoCommit(false);
					Iterator iterator = myForm.getProposals().iterator();
					ProposalHolder proposalHolder = null;
				 	int total = 0;
					String augmentedWorkId = null;
					Date today = new Date();
					SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
					String datenewformat = formatter.format(today);
					while(iterator.hasNext()){
						total++;
						augmentedWorkId = "";
						proposalHolder = (ProposalHolder)iterator.next();
						String isAugmentedWork = proposalHolder.getAugmentation();
						if(isAugmentedWork != null && isAugmentedWork.equals("Y")) 
							augmentedWorkId = proposalHolder.getWorkId();
						String subdiv=myForm.getSubdivisionOfficeCode();
						String lab=proposalHolder.getNoOfLabs();
						String scheme=myForm.getTypeOfAsset();
						try	{
							stmt1 = conn.prepareStatement("select * from RWS_WORK_ADMN_TBL where WORK_ID= ? ");
							stmt1.setString(1, proposalHolder.getProposalId());
						    rst=stmt1.executeQuery();
						    work_id_available=rst.next();				   
						}
						catch( Exception e){
							Debug.println("The Exception is in AdministrativeSanctionAction SAVE 11: "+e.getMessage());
							e.printStackTrace();
						}
						finally	{
							rst.close();
							stmt1.close();
						}					
						String[] habCodes = (String[])session.getAttribute("proposalsHabs");
						String[] labCodes = (String[])session.getAttribute("proposalsHabs");
						String[] schoolCodes = (String[])session.getAttribute("proposalsHabs");
						String code = proposalHolder.getProposalId().substring(6,8); 
						if(!(code.equals("11")|| code.equals("12") || code.equals("13") || code.equals("14"))){
							tabName1 = "rws_hab_selected_temp_tbl";
						}
						else if(code.equals("11")){
							tabName1 = "rws_sch_selected_temp_tbl";
						}
						else if(code.equals("12")){
							tabName1 = "rws_lab_selected_temp_tbl";
						}else if(code.equals("13")){
							tabName1 = "rws_angan_selected_temp_tbl";
						}
						else if(code.equals("14")){
							tabName1 = "rws_pi_selected_temp_tbl";
						}
						if (!work_id_available){ 
							new_wid=proposalHolder.getProposalId();
							if( subdiv!=null && !(subdiv.equals(""))){
								query = " INSERT INTO RWS_WORK_ADMN_TBL (OFFICE_CODE";
								if(!(scheme.equals("11")|| scheme.equals("12")|| scheme.equals("13")|| scheme.equals("14"))){
									query += ",NO_OF_HABS";
								}
								else if(scheme.equals("11")){
									query += ",NO_OF_SCHOOLS";
					 			}
								else if(scheme.equals("12")){
									query += ",NO_OF_LABS";
								}else if(scheme.equals("14")){
									query += ",NO_OF_PIS";
								}
								else if(scheme.equals("13")){
									query += ",NO_OF_ANGANWADIS";
								}
								query += ",WORK_NAME,PROGRAMME_CODE,SUBPROGRAMME_CODE,PREPARED_BY , PREPARED_ON ,WORK_ID,REMARKS,FLAG,TYPE_OF_ASSET,ADMIN_NO,ADMIN_DATE, SANCTION_AMOUNT,SANC_OFFICE,PLAN_CODE,AUG_NEW_CODE,CATEGORY_CODE,LEAD_HABITATION,AUG_WORKID,APPROVED_UNDER,state_approved,SUSTAINABILITY_RELATED,core_dashboard_status) " 
										+" VALUES( '" +myForm.getHeadOfficeCode()+ myForm.getCircleOfficeCode()+
											myForm.getDivisionOfficeCode()+subdiv+"'," +
						 					"'"+ proposalHolder.getNoOfHabs()+"'," +
						 				    "'"+ proposalHolder.getProposalName()+"'," +
						 				    "'"+ myForm.getPrograms()+"'," +
						 				    "'"+ myForm.getSubPrograms()+"'," +
						 		 		    "'"+ myForm.getUserId()+"'," +
						 				    "to_date('"+ datenewformat+"','dd/mm/yyyy')," +
						 				    "'"+ proposalHolder.getProposalId()+"'," +
						 				    "'"+ proposalHolder.getRemarks()+"'," +
						 				    "'A'," +"'"+ myForm.getTypeOfAsset()+"'," +
						 				    "'"+ proposalHolder.getAdminiStrativeNum()+"'," +
						 				    "to_date('"+proposalHolder.getAdminiStrativeDate()+"','dd/mm/yyyy')," +
						 				    "'"+ proposalHolder.getSanctionAmout()+"'," +
						 				    "''," +"'"+myForm.getPlan()+"','"+myForm.getWrktype()+"','"+myForm.getWorkCat()
						 				    +"','"+leadvalue+"','"+myForm.getAugsch()+"','"+myForm.getProoved()
						 				    +"','"+myForm.getApprooved()+"','"+myForm.getSustainDetails()
						 				    +"','"+myForm.getCoreDashboardStatus()+"')";					
							} else 	{
								query = " INSERT INTO RWS_WORK_ADMN_TBL (OFFICE_CODE ";
								if(!(scheme.equals("11")|| scheme.equals("12")|| scheme.equals("13") || scheme.equals("14"))){
									query += ",NO_OF_HABS";
								}
								else if(scheme.equals("11")){
									query += ",NO_OF_SCHOOLS";
					 			}
								else if(scheme.equals("12")){
									query += ",NO_OF_LABS";
					 			}else if(scheme.equals("14")){
									query += ",NO_OF_PIS";
					 			}
							else if(scheme.equals("13")){
								query += ",NO_OF_ANGANWADIS";
				 			}
								query += ",WORK_NAME ,PROGRAMME_CODE ,SUBPROGRAMME_CODE , PREPARED_BY , PREPARED_ON ,WORK_ID ,REMARKS ,FLAG ,TYPE_OF_ASSET ,ADMIN_NO ,ADMIN_DATE , SANCTION_AMOUNT ,SANC_OFFICE ,PLAN_CODE,AUG_NEW_CODE,CATEGORY_CODE,LEAD_HABITATION,AUG_WORKID,APPROVED_UNDER,state_approved,SUSTAINABILITY_RELATED,core_dashboard_status) " +
			                      "VALUES( '" +myForm.getHeadOfficeCode()+myForm.getCircleOfficeCode()+myForm.getDivisionOfficeCode()+"00"+"'," +
									"'"+ proposalHolder.getNoOfHabs()+"'," +
				 				    "'"+ proposalHolder.getProposalName()+"'," +
				 				    "'"+ myForm.getPrograms()+"'," +
				 				    "'"+ myForm.getSubPrograms()+"'," +
				 		 		    "'"+ myForm.getUserId()+"'," +
				 				    "to_date('"+ datenewformat+"','dd/mm/yyyy')," +
				 				    "'"+ proposalHolder.getProposalId()+"'," +
				 				    "'"+ proposalHolder.getRemarks()+"'," +
				 				    "'A'," + "'" + myForm.getTypeOfAsset()+"'," +
				 				    "'"+ proposalHolder.getAdminiStrativeNum()+"'," +
				 				    "to_date('"+proposalHolder.getAdminiStrativeDate()+"','dd/mm/yyyy')," +
				 				    "'"+ proposalHolder.getSanctionAmout()+"'," +
				 				    "''," + "'"+myForm.getPlan()+"','"+myForm.getWrktype()+"','"+myForm.getWorkCat() +
				 				    "','"+leadvalue+"','"+myForm.getAugsch()+"','"+myForm.getProoved()+"','"
				 				    +myForm.getApprooved()+"','"+myForm.getSustainDetails()+"','"
				 				    +myForm.getCoreDashboardStatus()+"')";
							}
							stat.addBatch(query);							
							if(scheme!=null && !(scheme.equals("11")||scheme.equals("12")||scheme.equals("13")||scheme.equals("14")))	{					
								int noOfHabs = 0;
								stmt=conn.prepareStatement("select * from  "+tabName1+"  where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
							    while(rr.next()){
									query = " INSERT INTO rws_admn_hab_lnk_tbl(work_id, hab_code) VALUES('"+proposalHolder.getProposalId()+"', "+" '"+rr.getString(2)+"')";						
									noOfHabs++;
									total++;
									stat.addBatch(query);
							    }
							}
							else if(scheme!=null && scheme.equals("12")){
								int noOfLabs = 0;						
								stmt=conn.prepareStatement("select * from "+tabName1+" where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
							    while(rr.next()){
									query = " INSERT INTO rws_work_lab_lnk_tbl(work_id, lab_code) VALUES('"+proposalHolder.getProposalId()+"', "+ " '"+rr.getString(2).substring(0,3)+"')";							
									noOfLabs++;
									total++;
									stat.addBatch(query);
								}						
							}
							else if(scheme!=null && scheme.equals("14")){
								int noOfSchools = 0;							
								stmt=conn.prepareStatement("select * from "+tabName1+" where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
								String[] codeArr = null; 
							    while(rr.next()){	
							    	codeArr = rr.getString(3).split("-");
									query = " INSERT INTO rws_work_pi_lnk_tbl(work_id,hab_code,PI_CODE) VALUES('"+proposalHolder.getProposalId()+"', "+"'"+rr.getString(2)+"','"+codeArr[0]+"')";
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}
							
							else if(scheme!=null && scheme.equals("11")){
								int noOfSchools = 0;							
								stmt=conn.prepareStatement("select * from "+tabName1+" where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
								String[] codeArr = null; 
							    while(rr.next()){		
							    	codeArr = rr.getString(3).split("-");
									query = " INSERT INTO rws_work_school_lnk_tbl(work_id,hab_code,school_code) VALUES('"+proposalHolder.getProposalId()+"', "+"'"+rr.getString(2)+"','"+codeArr[0]+"')";
									System.out.println("query######"+query);
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}	
							else if(scheme!=null && scheme.equals("13")){
								int noOfSchools = 0;							
								stmt=conn.prepareStatement("select * from "+tabName1+" where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
							    while(rr.next()){
							    	//query = " INSERT INTO rws_work_school_lnk_tbl(work_id,hab_code,school_code) VALUES('"+proposalHolder.getProposalId()+"', "+"'"+rr.getString(2)+"','"+rr.getString(3).substring(0,3)+"')";
							    	System.out.println("*****************"+rr.getString(3));
							    	
							    	String s[]=rr.getString(3).split("-");
									query = " INSERT INTO rws_work_anganwadi_lnk_tbl(work_id,hab_code,anganwadi_code) VALUES('"+proposalHolder.getProposalId()+"', "+"'"+rr.getString(2)+"','"+s[0]+"')";
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}
							String query1="DELETE FROM  tab_admin_temp where PROPOSAL_ID='"+proposalHolder.getProposalId()+"'";
						}					
						else if(work_id_available){
						 	String circleOfficeCode = myForm.getCircleOfficeCode();
						 	String typeOfAssetCode = myForm.getTypeOfAsset();
						 	String ProgrammeCode = myForm.getPrograms();
						 	String subProgrammeCode = myForm.getSubPrograms();
						 	String nextProposalId = "";
						 	String headOfficeCode = myForm.getHeadOfficeCode();
						 	ArrayList proposals = null;	
						 	if(circleOfficeCode!=null && !circleOfficeCode.equals("") && typeOfAssetCode!=null && !typeOfAssetCode.equals("") && ProgrammeCode!=null && !ProgrammeCode.equals("") && subProgrammeCode!=null && !subProgrammeCode.equals("")){
								nextProposalId = ProposalDAO.getNextProposalIdForAdminiStrative(headOfficeCode, circleOfficeCode,typeOfAssetCode,ProgrammeCode,subProgrammeCode);	
							}
						 	StringBuffer wid=new StringBuffer(""+new_wid);
						 	String secondPart=(""+new_wid).substring(10,14);
						 	int sno = Integer.parseInt(secondPart);
						 	sno=sno+1;
							if(sno<10)
								secondPart = "000"+sno;
							else if(sno<100)
								secondPart = "00"+sno;
							else if(sno<1000)
								secondPart = "0"+sno;
							else
								secondPart = String.valueOf(sno);
							wid=wid.replace(10,14,secondPart);
							proposalHolder.setProposalId(""+wid);
							new_wid=""+wid;
							proposalHolder.setProposalId(nextProposalId);
							if( subdiv!=null && !(subdiv.equals(""))){	
								query = " INSERT INTO RWS_WORK_ADMN_TBL (OFFICE_CODE";
								if(!(scheme.equals("11")|| scheme.equals("12")|| scheme.equals("13")|| scheme.equals("14"))){
									query += ",NO_OF_HABS";
								}
								else if(scheme.equals("11")){
									query += ",NO_OF_SCHOOLS";
					 			}
								else if(scheme.equals("12")){
									query += ",NO_OF_LABS";
					 			}			else if(scheme.equals("14")){
									query += ",NO_OF_PIS";
								}	else if(scheme.equals("13")){
									query += ",NO_OF_ANGANWADIS";
								}			
								query += ",WORK_NAME,PROGRAMME_CODE,SUBPROGRAMME_CODE,PREPARED_BY ,"+
										"PREPARED_ON ,WORK_ID,REMARKS,FLAG,TYPE_OF_ASSET,ADMIN_NO,ADMIN_DATE," +
										" SANCTION_AMOUNT,SANC_OFFICE,PLAN_CODE,AUG_NEW_CODE,CATEGORY_CODE,LEAD_HABITATION,AUG_WORKID,APPROVED_UNDER,state_approved ,SUSTAINABILITY_RELATED,core_dashboard_status) " +
										"VALUES( '" +myForm.getHeadOfficeCode()+ myForm.getCircleOfficeCode()+
										myForm.getDivisionOfficeCode()+subdiv+"'," +
					 					"'"+ proposalHolder.getNoOfHabs()+"'," +
					 				    "'"+ proposalHolder.getProposalName()+"'," +
					 				    "'"+ myForm.getPrograms()+"'," +
					 				    "'"+ myForm.getSubPrograms()+"'," +
					 		 		    "'"+ myForm.getUserId()+"'," +
					 				    "to_date('"+ datenewformat+"','dd/mm/yyyy')," +
					 				    "'" + proposalHolder.getProposalId()+"'," +
					 				    "'" + proposalHolder.getRemarks()+"'," +
					 				    "'A'," + "'" + myForm.getTypeOfAsset()+"'," +
					 				    "'" + proposalHolder.getAdminiStrativeNum()+"'," +
					 				    "to_date('"+ proposalHolder.getAdminiStrativeDate() + "','dd/mm/yyyy')," +
					 				    "'" + proposalHolder.getSanctionAmout()+"'," +
					 				    "''," + "'" + myForm.getPlan() +"','"+ myForm.getWrktype() +"','" + myForm.getWorkCat() 
					 				    + "','"+leadvalue+"','"+myForm.getAugsch()+"','"+myForm.getProoved()
					 				    +"','"+myForm.getApprooved()+"','"+myForm.getSustainDetails()+"','"
					 				    +myForm.getCoreDashboardStatus()+"')"; 					
							} else	{	
								query = " INSERT INTO RWS_WORK_ADMN_TBL (OFFICE_CODE ";
								if(!(scheme.equals("11")|| scheme.equals("12")|| scheme.equals("13")|| scheme.equals("14"))) {
									query += ",NO_OF_HABS";
								}
								else if(scheme.equals("11")) {
									query += ",NO_OF_SCHOOLS";
					 			}
								else if(scheme.equals("12")) {
									query += ",NO_OF_LABS";
								}	else if(scheme.equals("14")){
									query += ",NO_OF_PIS";
								}
								else if(scheme.equals("13")){
									query += ",NO_OF_ANGANWADIS";
								}
								query += ",WORK_NAME ,PROGRAMME_CODE ,SUBPROGRAMME_CODE , PREPARED_BY ," +
						 			"PREPARED_ON ,WORK_ID ,REMARKS ,FLAG ,TYPE_OF_ASSET ,ADMIN_NO ,ADMIN_DATE ," +
						 			" SANCTION_AMOUNT ,SANC_OFFICE ,PLAN_CODE,AUG_NEW_CODE,CATEGORY_CODE,LEAD_HABITATION,AUG_WORKID,APPROVED_UNDER,state_approved ,SUSTAINABILITY_RELATED,core_dashboard_status) " +
			                         "VALUES( '" +myForm.getHeadOfficeCode()+ myForm.getCircleOfficeCode()+ myForm.getDivisionOfficeCode()+"00"+"'," +
						 					"'"+ proposalHolder.getNoOfHabs()+"'," +
						 				    "'"+ proposalHolder.getProposalName()+"'," + "'" + myForm.getPrograms()+"'," +
						 				    "'"+ myForm.getSubPrograms()+"'," + "'" + myForm.getUserId()+"'," +
						 				    "to_date('"+ datenewformat+"','dd/mm/yyyy')," + "'" + proposalHolder.getProposalId()+"'," +
						 				    "'"+ proposalHolder.getRemarks()+"'," + "'A'," + "'" + myForm.getTypeOfAsset() +"'," +
						 				    "'"+ proposalHolder.getAdminiStrativeNum()+"'," + "to_date('"+proposalHolder.getAdminiStrativeDate()+"','dd/mm/yyyy')," +
						 				    "'"+ proposalHolder.getSanctionAmout()+"'," + "''," +
						 				    "'"+myForm.getPlan()+"','"+myForm.getWrktype()+"','"+myForm.getWorkCat()+"','"
						 				    +leadvalue+"','"+myForm.getAugsch()+"','"+myForm.getProoved()+"','"
						 				    +myForm.getApprooved()+"','"+myForm.getSustainDetails()+"','"
						 				    +myForm.getCoreDashboardStatus()+"')";
							}	
							stat.addBatch(query);					
							if(scheme!=null && !(scheme.equals("11")||scheme.equals("12")||scheme.equals("13")||scheme.equals("14 "))){					
								int noOfHabs = 0;
								stmt=conn.prepareStatement("select * from  "+tabName1+"  where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
								while(rr.next()) {
									query = " INSERT INTO rws_admn_hab_lnk_tbl(work_id, hab_code) VALUES('" + proposalHolder.getProposalId() + "', "+" '"+rr.getString(2)+"')";
									noOfHabs++;
									total++;
									stat.addBatch(query);
								}
							}
							else if(scheme!=null && scheme.equals("12")){
								int noOfLabs = 0;
								stmt=conn.prepareStatement("select * from  "+tabName1+"  where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
								while(rr.next()) {
									query = " INSERT INTO rws_work_lab_lnk_tbl(work_id, lab_code) VALUES('"+proposalHolder.getProposalId()+"', "+" '"+rr.getString(2).substring(0,3)+"')";							
									noOfLabs++;
									total++;
									stat.addBatch(query);
								}						
							}
							else if(scheme!=null && scheme.equals("14")){
								int noOfSchools = 0;							
								stmt=conn.prepareStatement("select * from "+tabName1+" where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
								String[] codeArr = null; 
							    while(rr.next()){	
							    	codeArr = rr.getString(3).split("-");						
									query = " INSERT INTO rws_work_pi_lnk_tbl(work_id,hab_code,PI_CODE) VALUES('"+proposalHolder.getProposalId()+"', "+"'"+rr.getString(2)+"','"+codeArr[0]+"')";
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}
							else if(scheme!=null && scheme.equals("11")){
								int noOfSchools = 0;
								stmt=conn.prepareStatement("select * from  "+tabName1+"  where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
								String[] codeArr = null; 
							    while(rr.next()) {
							    	codeArr = rr.getString(3).split("-");		
									query = " INSERT INTO rws_work_school_lnk_tbl(work_id,hab_code,school_code)" 
										  + " VALUES('" + proposalHolder.getProposalId() + "', " + "'" + rr.getString(2) + "','" + codeArr[0] + "')";
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}
							else if(scheme!=null && scheme.equals("13")){
								int noOfSchools = 0;							
								stmt=conn.prepareStatement("select * from "+tabName1+" where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
							    while(rr.next()){
							    	//query = " INSERT INTO rws_work_school_lnk_tbl(work_id,hab_code,school_code) VALUES('"+proposalHolder.getProposalId()+"', "+"'"+rr.getString(2)+"','"+rr.getString(3).substring(0,3)+"')";
							    	System.out.println("*****************"+rr.getString(3));
							    	
							    	String s[]=rr.getString(3).split("-");
									query = " INSERT INTO rws_work_anganwadi_lnk_tbl(work_id,hab_code,anganwadi_code) VALUES('"+proposalHolder.getProposalId()+"', "+"'"+rr.getString(2)+"','"+s[0]+"')";
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}
							
							
							String query1="DELETE FROM  tab_admin_temp where PROPOSAL_ID='"+proposalHolder.getProposalId()+"'";
						}				
						conn.setAutoCommit(true);
				 	    conn.commit();				
						ProposalDAO proposalDAO=new ProposalDAO();
						ArrayList rwsWorkAdmnProgLnkTmp=proposalDAO.getAddedAdmnProgs(session,proposalHolder.getProposalId());
						if(rwsWorkAdmnProgLnkTmp!=null && rwsWorkAdmnProgLnkTmp.size()>0){
							ProposalHolder ph;
							for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)	{
							   ph=(ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);
							   String subprogram="";
							   String programCode=ph.getProgrammeCode();
							   String adminNo=ph.getAdminiStrativeNum();
							   subprogram=ph.getSubprogrammeCode();
							   String sanctionAmount=ph.getSanctionAmout();
							   if(subprogram==null){
							   		subprogram="";
							   }
							   String date="";
							   date=ph.getAdminiStrativeDate();
							   if(date==null) {
							   		date="";
							   }
						 		query="INSERT INTO RWS_WORK_ADMN_PROG_LNK_TBL(WORK_ID ,PROGRAMME_CODE ,SUB_PROGRAMME_CODE ,ADMIN_NO ,ADMIN_DATE ,SANCTION_AMOUNT )" +
							    	  "VALUES('"+proposalHolder.getProposalId()+"', '"+programCode+"', '"+subprogram+"', '"+adminNo+"', " +"to_date('"+date+"','dd/mm/yyyy'),'"+sanctionAmount+"')";
						 		stat.addBatch(query);
							}							
						}
					}			
					int[] updateCounts = stat.executeBatch();
					boolean flag = true;
					for(int i=0; i< total; i++){
						if(updateCounts[i] != 1)
							flag = false;
					}
					if(flag){
						ProposalDAO proposalDAO = new ProposalDAO(dataSource);
						conn.setAutoCommit(true);
						conn.commit();
						conn.setAutoCommit(true);
						session.removeAttribute("selectedHabs");
						session.removeAttribute("constituencies");
						session.removeAttribute("RepresentativeProposalForm");
						session.removeAttribute("tempSelectedAdmnHabs");
						session.removeAttribute("rwsWorkAdmnProgLnkTmp");
						session.removeAttribute("proposalsHabs");
						session.removeAttribute("habsarray");
						proposalDAO.deleteTempSelectedHabs();
						proposalDAO.deleteTempTables(tabName1,proposalHolder.getProposalId(),sessionId);
						if(work_id_available) {
							message="Record(s) inserted successfully ,With a new Work Id:"+proposalHolder.getProposalId()+"";
						}
						else {
							message= "Record(s) inserted successfully!";
						}
						session.setAttribute("GlobalConstants.Message",message);
					}			  
				}
				catch(Exception e){	
					System.out.println("The Exception is in AdministrativeSanctionAction Save 12: " + e.getMessage());
					//e.printStackTrace();
					message = "The Record Cannot be inserted!";				
					session.setAttribute("GlobalConstants.Message", message);
					target = "failure1";
				}
				finally{
					if(stat != null){	
						stat.close();
					}
					if(conn != null){	
						conn.close();
					}
				}			
			}
			
			if(mode != null && mode.equals("Revised")){
				try {
					if(session.getAttribute("leadvalue") != null){
						leadvalue = (String)session.getAttribute("leadvalue");
					}
					if(request.getParameter("leadlab")!=null && !request.getParameter("leadlab").equals(""))
						leadvalue = request.getParameter("leadlab");
					conn = RwsOffices.getConn();
					conn.setAutoCommit(false);
					stat = conn.createStatement();
					Statement stat1=conn.createStatement();						
					Iterator iterator = myForm.getProposals().iterator();
					ProposalHolder proposalHolder = null;
				 	int total = 0;
					String augmentedWorkId = null;
					Date today = new Date();
					SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
					String datenewformat = formatter.format(today);
					while(iterator.hasNext()){
						total++;
						augmentedWorkId = "";
						proposalHolder = (ProposalHolder)iterator.next();
						String isAugmentedWork = proposalHolder.getAugmentation();
						if(isAugmentedWork != null && isAugmentedWork.equals("Y")) 
							augmentedWorkId = proposalHolder.getWorkId();
					 	String subdiv=myForm.getSubdivisionOfficeCode();
						String scheme=myForm.getTypeOfAsset();
					 	if( subdiv!=null && !(subdiv.equals("")) ){
					 		query = " INSERT INTO RWS_REVISED_ADM_SANC_TBL (OFFICE_CODE ";
							if(!(scheme.equals("11")|| scheme.equals("12")|| scheme.equals("13") || scheme.equals("14"))){
								query += ",NO_OF_HABS";
							}
							else if(scheme.equals("11")){
								query += ",NO_OF_SCHOOLS";
				 			}
							else if(scheme.equals("12")){
								query += ",NO_OF_LABS";
				 			}else if(scheme.equals("14")){
				 				query += ",NO_OF_PIS";
				 			}
							query +=",WORK_NAME ,PROGRAMME_CODE ,SUBPROGRAMME_CODE , PREPARED_BY ," +
					 			"PREPARED_ON ,WORK_ID ,FLAG ,TYPE_OF_ASSET ,REV_ADMIN_NO  ,REV_ADMIN_DATE  ," +
					 			" REV_SANCTION_AMOUNT  ,REV_SANC_OFFICE,LEAD_HABITATION) " +
								"VALUES( '" + myForm.getHeadOfficeCode()+myForm.getCircleOfficeCode()+myForm.getDivisionOfficeCode()+subdiv+"'," +
					 					"'"+ proposalHolder.getNoOfHabs()+"'," +
					 				    "'"+ proposalHolder.getWorkName()+"'," +
					 				    "'"+ myForm.getPrograms()+"'," +
					 				    "'"+ myForm.getSubPrograms()+"'," +
					 			 	    "'"+ myForm.getUserId()+"'," +
					 				    "to_date('"+ datenewformat+"','dd/mm/yyyy')," +
					 				    "'"+ proposalHolder.getProposalId()+"'," +				 				    
					 				    "'R'," +"'"+ myForm.getTypeOfAsset()+"'," +
					 				    "'"+ proposalHolder.getRevisedAdminiStrativeNum()+"'," +
					 				    "to_date('"+proposalHolder.getRevisedAdminiStrativeDate()+"','dd/mm/yyyy')," +
					 				    "'"+ proposalHolder.getRevisedSanctionAmout()+"','','"+leadvalue+"')" ;
					 	} else {
					 		query = " INSERT INTO RWS_REVISED_ADM_SANC_TBL (OFFICE_CODE ";
							if(!(scheme.equals("11")|| scheme.equals("12")|| scheme.equals("13")|| scheme.equals("14"))){
								query += ",NO_OF_HABS";
							}
							else if(scheme.equals("11")){
								query += ",NO_OF_SCHOOLS";
				 			}
							else if(scheme.equals("12")){
								query += ",NO_OF_LABS";
				 			}else if(scheme.equals("14")){
				 				query += ",NO_OF_PIS";
				 			}
				 			else if(scheme.equals("13")){
				 				query += ",NO_OF_ANGANWADIS";
				 			}
							query +=",WORK_NAME ,PROGRAMME_CODE ,SUBPROGRAMME_CODE , PREPARED_BY ," +
					 			"PREPARED_ON ,WORK_ID ,FLAG ,TYPE_OF_ASSET ,REV_ADMIN_NO  ,REV_ADMIN_DATE  ," +
					 			" REV_SANCTION_AMOUNT  ,REV_SANC_OFFICE  ) " +
								"VALUES( '" + myForm.getHeadOfficeCode()+myForm.getCircleOfficeCode()+myForm.getDivisionOfficeCode()+"00"+"'," +
					 					"'"+ proposalHolder.getNoOfHabs()+"'," +
					 				    "'"+ proposalHolder.getWorkName()+"'," +
					 				    "'"+ myForm.getPrograms()+"'," +
					 				    "'"+ myForm.getSubPrograms()+"'," +
					 			 	    "'"+ myForm.getUserId()+"'," +
					 				    "to_date('"+ datenewformat+"','dd/mm/yyyy')," +
					 				    "'"+ proposalHolder.getProposalId()+"'," +
					 					"'R'," +"'"+ myForm.getTypeOfAsset()+"'," +
					 				    "'"+ proposalHolder.getRevisedAdminiStrativeNum()+"'," +
					 				    "to_date('"+proposalHolder.getRevisedAdminiStrativeDate()+"','dd/mm/yyyy')," +
					 				    "'"+ proposalHolder.getRevisedSanctionAmout()+"'," +
					 				    "'')" ;
					 		}
						stat.addBatch(query);
						if(! proposalHolder.getNoOfHabs().equals("")){
							String[] habCodes={};
							try{
						  	  	habCodes = request.getParameterValues("H_" + proposalHolder.getProposalName());
							}
						  	catch(Exception e){
						  		System.out.println("The Exception is in AdministrativeSanctionAction Revised : " + e.getMessage());
							}
							
						  	if(scheme!=null && !(scheme.equals("11")||scheme.equals("12")||scheme.equals("13")||scheme.equals("14")))	{
								int noOfHabs = 0;									
								for (int i = 0; i < habCodes.length; i++){
									query = " INSERT INTO RWS_REV_ADM_SANC_HAB_LNK_TBL (work_id, hab_code)" 
										+ " VALUES('" + proposalHolder.getProposalName() + "', " 
										+ " '" + habCodes[i] + "')";												
									noOfHabs++;
									total++;
									stat.addBatch(query);
								}
							}
						  	
							else if(scheme!=null && scheme.equals("12")){
								int noOfLabs = 0;												
								for (int i = 0; i < habCodes.length; i++){
									query = " INSERT INTO RWS_REV_LAB_LNK_TBL(work_id, lab_code)" 
										  + " VALUES('" + proposalHolder.getProposalId() + "', " 
										  + " '" + habCodes[i] + "')";								
									noOfLabs++;
									total++;
									stat.addBatch(query);
								}							
							}
						  	
							else if(scheme!=null && scheme.equals("11")){
								int noOfSchools = 0;							
								for (int i = 0; i < habCodes.length; i++) {
									query = " INSERT INTO RWS_REV_SCHOOL_LNK_TBL(work_id,hab_code,school_code)" 
										  + " VALUES('" + proposalHolder.getProposalId() + "', " 
										  +"'" + habCodes[i].substring(0,16) + "','" + habCodes[i].substring(16,19) + "')";
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}	
							else if(scheme!=null && scheme.equals("14")){
								int noOfSchools = 0;							
								stmt=conn.prepareStatement("select * from "+tabName1+" where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
								String[] codeArr = null; 
							    while(rr.next()){	
							    	codeArr = rr.getString(3).split("-");				
									query = " INSERT INTO RWS_REV_pi_LNK_TBL(work_id,hab_code,PI_CODE) VALUES('"+proposalHolder.getProposalId()+"', "+"'"+rr.getString(2)+"','"+codeArr[0]+"')";
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}
							else if(scheme!=null && scheme.equals("13")){
								int noOfSchools = 0;							
								stmt=conn.prepareStatement("select * from "+tabName1+" where proposal_id= ? and sid= ? ");
								stmt.setString(1, proposalHolder.getProposalId());
								stmt.setString(2, sessionId);
								ResultSet rr= stmt.executeQuery();
								String[] codeArr = null; 
							    while(rr.next()){	
							    	codeArr = rr.getString(3).split("-");				
									query = " INSERT INTO RWS_REV_anganwadi_LNK_TBL(work_id,hab_code,anganwadi_CODE) VALUES('"+proposalHolder.getProposalId()+"', "+"'"+rr.getString(2)+"','"+codeArr[0]+"')";
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}
							else if(scheme!=null && scheme.equals("11")){
								int noOfSchools = 0;							
								for (int i = 0; i < habCodes.length; i++) {
									query = " INSERT INTO RWS_REV_SCHOOL_LNK_TBL(work_id,hab_code,school_code)" 
										  + " VALUES('" + proposalHolder.getProposalId() + "', " 
										  +"'" + habCodes[i].substring(0,16) + "','" + habCodes[i].substring(16,19) + "')";
									noOfSchools++;
									total++;
									stat.addBatch(query);
								}
							}
						}
					}
					ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
					if(rwsWorkAdmnProgLnkTmp!=null && rwsWorkAdmnProgLnkTmp.size()>0) {						
						for(int i=0;i<rwsWorkAdmnProgLnkTmp.size();i++)	{
							ProposalHolder newHolder=(ProposalHolder)rwsWorkAdmnProgLnkTmp.get(i);					    
					 		if(i==0) {
					 			query="delete from RWS_REVISED_ADM_PROG_LNK_TBL where work_id='"+newHolder.getProposalId()+"'";
					 			stat.addBatch(query);						  
					 		}
							String subprogram="";
						    subprogram=newHolder.getSubprogrammeCode();
						    if(subprogram==null){
						     	subprogram="";
						    }
						    String date="";
						    date=newHolder.getRevisedAdminiStrativeDate();
						    if(date==null){
						    	date="";
						    }
					 		query="INSERT INTO RWS_REVISED_ADM_PROG_LNK_TBL(WORK_ID ,PROGRAMME_CODE ,SUB_PROGRAMME_CODE ,ADMIN_NO ,ADMIN_DATE ,REV_SANCTION_AMOUNT  )" +
					 			 "VALUES('"+newHolder.getProposalId()+"','"+newHolder.getProgrammeCode()+"','"+subprogram+"','"+newHolder.getRevisedAdminiStrativeNum()+"'," +
								 "to_date('"+date+"','dd/mm/yyyy'),'"+newHolder.getRevisedSanctionAmout()+"')";
					 		stat.addBatch(query);
						}						
					}
					int[] updateCounts = stat.executeBatch();
					boolean flag = true;
					for(int i=0; i< total; i++)	{
						if(updateCounts[i] != 1)
							flag = false;
					}
					if(flag) {
						conn.commit();
						conn.setAutoCommit(true);
						session.removeAttribute("schemes");
						session.removeAttribute("programmes1");
						session.removeAttribute("SubPrograms1");
						session.removeAttribute("divisions1");
				    	session.removeAttribute("subdivisions1");
				    	session.removeAttribute("tempSelectedAdmnHabs");
						session.removeAttribute("selectedHabs");
						session.removeAttribute("constituencies");
						session.removeAttribute("RepresentativeProposalForm");
						session.removeAttribute("rwsWorkAdmnProgLnkTmp");
						ProposalDAO proposalDAO = new ProposalDAO(dataSource);
						proposalDAO.deleteTempSelectedHabs();	
						proposalDAO.deleteTempAddProgramsTable(session,proposalHolder.getProposalId());
						session.setAttribute("GlobalConstants.Message", "Record(s) inserted successfully!");
						reset(myForm);
					}			 
				}
				catch(Exception e){	
					Debug.writeln("The Exception is in AdministrativeSanctionAction while adding the revised data: " + e);
					message = "The Record Cannot be inserted!";
					session.setAttribute("GlobalConstants.Message", message);
					target = "failure";
				}
				finally	{
					if(stat != null){	
						stat.close();
					}
					if(conn != null){	
						conn.close();
					}
				}
			}
			
			if(mode != null && mode.equals("RevisedUpdate")){
				if(session.getAttribute("leadvalue") != null){
					leadvalue = (String)session.getAttribute("leadvalue");
				}
				if(request.getParameter("leadlab")!=null && !request.getParameter("leadlab").equals(""))
					leadvalue = request.getParameter("leadlab");
				try{
					conn = RwsOffices.getConn();
					conn.setAutoCommit(false);
					stat = conn.createStatement();										
					Iterator iterator = myForm.getProposals().iterator();
					ProposalHolder proposalHolder = null;
				 	int total = 0;
					String augmentedWorkId = null;
					Date today = new Date();
					SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
					String datenewformat = formatter.format(today);
					while(iterator.hasNext()){
						total++;
						augmentedWorkId = "";
						proposalHolder = (ProposalHolder)iterator.next();
						String isAugmentedWork = proposalHolder.getAugmentation();
						if(isAugmentedWork != null && isAugmentedWork.equals("Y")) 
							augmentedWorkId = proposalHolder.getWorkId();
						String[] habCodes={};
						try{
							revisedUpdatedViewId=proposalHolder.getProposalId();
					  	    habCodes = request.getParameterValues("H_"+proposalHolder.getProposalId());
						}
					  	catch(Exception e){
					  		System.out.println("The Exception is in AdministrativeSanctionAction  : " + e.getMessage());							
						}					  
					 	String code=proposalHolder.getProposalId().substring(6,8);
					  	query = " UPDATE RWS_REVISED_ADM_SANC_TBL set " ;
					 	if(!(code.equals("11")||code.equals("12"))){
					 		 query += "  NO_OF_HABS='"+ habCodes.length+"'";
					 	}
					 	else if(code.equals("11")){
					 		query += "  NO_OF_SCHOOLS='"+ habCodes.length+"'";
					 	}
					 	else if(code.equals("12")){
					 		query += "  NO_OF_LABS='"+ habCodes.length+"'";
				 		}				 			
				 		query += ", REV_ADMIN_NO ='"+ proposalHolder.getRevisedAdminiStrativeNum()+"'" +
					 			" ,REV_ADMIN_DATE =to_date('"+proposalHolder.getRevisedAdminiStrativeDate()+"','dd/mm/yyyy') ," +
					 			" REV_SANCTION_AMOUNT ='"+ proposalHolder.getRevisedSanctionAmout()+"',lead_habitation='"+leadvalue+"' where work_id='"+ proposalHolder.getProposalId()+"'" ;
				 		stat.addBatch(query);
						 if(!(code.equals("11")||code.equals("12"))){
						 	 query="delete from RWS_REV_ADM_SANC_HAB_LNK_TBL where work_id='"+proposalHolder.getProposalId()+"'";
					 	 }
					 	 else if(code.equals("11")){
					 		query="delete from RWS_REV_SCHOOL_LNK_TBL where work_id='"+proposalHolder.getProposalId()+"'";
					 	 }
					 	 else if(code.equals("12")){
					 		query="delete from RWS_REV_LAB_LNK_TBL where work_id='"+proposalHolder.getProposalId()+"'";
				 		 }
						 stat.addBatch(query);
		 				 int noOfHabs = 0;
		 				 if(!(code.equals("11")||code.equals("12"))){
		 					int noOfHabs1 = 0;					 
		 					for (int i = 0; i < habCodes.length; i++){
								query = " INSERT INTO RWS_REV_ADM_SANC_HAB_LNK_TBL (work_id, hab_code)" 
									  + " VALUES('" + proposalHolder.getProposalId() + "', " 
									  + " '" + habCodes[i] + "')";							
								noOfHabs1++;
								total++;
								stat.addBatch(query);
							} 
						 }
		 				 else if(code.equals("11")){	 					
		 					int noOfSchools = 0;
		 					for (int i = 0; i < habCodes.length; i++){
		 						query = " INSERT INTO RWS_REV_SCHOOL_LNK_TBL(work_id,hab_code,school_code)" 
									  + " VALUES('" + proposalHolder.getProposalId() + "', " +"'" + habCodes[i].substring(0,14) + "','" + habCodes[i].substring(14,17) + "')";
								noOfSchools++;
								total++;
								stat.addBatch(query);
							} 					 
				 		}
		 				else if(code.equals("12")){
		 					int noOfLabs = 0;
		 					for (int i = 0; i < habCodes.length; i++){
								query = " INSERT INTO RWS_REV_LAB_LNK_TBL (work_id, lab_code)" 
									  + " VALUES('" + proposalHolder.getProposalId() + "', " + " '" + habCodes[i] + "')";
								noOfLabs++;
								total++;
								stat.addBatch(query);
	 						}					 
				 		} 				
	 			    }			
					int[] updateCounts = stat.executeBatch();
					boolean flag = true;
					for(int i=0; i< total; i++)	{
						if(updateCounts[i] < 1)
							flag = false;
					}
					if(flag){
						conn.commit();
						conn.setAutoCommit(true);										
						session.removeAttribute("selectedHabs");
						session.removeAttribute("circles1");
						session.removeAttribute("RepresentativeProposalForm");
						session.removeAttribute("workIds");
						ProposalDAO proposalDAO = new ProposalDAO(dataSource);
						user=(RwsUser)session.getAttribute("RWS_USER");
						proposalDAO.deleteTempSelectedHabs("hab_"+user.getUserId()+"_temp");
						session.setAttribute("GlobalConstants.Message", "Record(s) Updated successfully!");
					}			 
				}
				catch(Exception e){	
					System.out.println("The Exception is in AdministrativeSanctionAction 1233: " + e.getMessage());					
					//e.printStackTrace();
					message = "The Record Cannot be inserted!";
					session.setAttribute("GlobalConstants.Message", message);
					target = "failure";
				}
				finally {
					if(stat != null){	
						stat.close();
					}
					if(conn != null){	
						conn.close();
					}
				}
				mode="RevisedUpdatedView";			
			}
			
			if(mode != null && mode.equals("RevisedUpdatedView")){			
				session.removeAttribute("selectedHabs");
				officeCode = user.getOfficeCode();
				officeCode = "1"+myForm.getCircleOfficeCode()+myForm.getDivisionOfficeCode()+myForm.getSubdivisionOfficeCode();
				ProposalDAO proposalDAO = new ProposalDAO(dataSource);
				ArrayList RevisedList = proposalDAO.getRevisedSanctionList(officeCode,revisedUpdatedViewId,"","","","");
				request.setAttribute("RevisedSanctionList", RevisedList);
				target = new String("updatedrevisedwork");
			}
			
			if(mode != null && mode.equalsIgnoreCase("Update")){
				try	{
					conn = RwsOffices.getConn();
					conn.setAutoCommit(false);
					stat = conn.createStatement();										
					Iterator iterator = myForm.getProposals().iterator();
					ProposalHolder proposalHolder = null;
				 	int total = 0;
					String augmentedWorkId = null;
					Date today = new Date();
					SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
					String datenewformat = formatter.format(today);
					while(iterator.hasNext()){
						total++;
						augmentedWorkId = "";
						proposalHolder = (ProposalHolder)iterator.next();
						String isAugmentedWork = proposalHolder.getAugmentation();
						if(isAugmentedWork != null && isAugmentedWork.equals("Y")) 
							augmentedWorkId = proposalHolder.getWorkId();
							String scheme=proposalHolder.getProposalId().substring(6,8);
						query = " UPDATE   RWS_WORK_ADMN_TBL set OFFICE_CODE='" + myForm.getHeadOfficeCode()+ myForm.getCircleOfficeCode()+ myForm.getDivisionOfficeCode()+""+myForm.getSubdivisionOfficeCode()+"'" ;
							if(!(scheme.equals("11")|| scheme.equals("12"))) {
								query += ",NO_OF_HABS='"+proposalHolder.getNoOfHabs()+"'";
							}
							else if(scheme.equals("11")){
								query += ",NO_OF_SCHOOLS='"+proposalHolder.getNoOfHabs()+"'";
							}
							else if(scheme.equals("12")){
								query += ",NO_OF_LABS='"+proposalHolder.getNoOfHabs()+"'";
							}	
						query +=",WORK_NAME ='"+ proposalHolder.getProposalName()+"'" +
				 		 	" ,PREPARED_BY='"+ myForm.getUserId()+"' " +
				 			" ,PREPARED_ON= to_date('"+ datenewformat+"','dd/mm/yyyy')" +
				 			", REMARKS='"+ proposalHolder.getRemarks()+"'" +
				 			" ,FLAG ='A'" +
				 		 	" ,ADMIN_NO='"+ proposalHolder.getAdminiStrativeNum()+"'" +
				 			" ,ADMIN_DATE=to_date('"+proposalHolder.getAdminiStrativeDate()+"','dd/mm/yyyy')" +
				 			", SANCTION_AMOUNT='"+ proposalHolder.getSanctionAmout()+"'" +
				 			" ,SANC_OFFICE='' ,SPILL_OVER = decode('"+ proposalHolder.getSpillOver()+"','on','y')" +
			 			    " ,lead_habitation='"+request.getParameter("leadhab")+"',core_dashboard_status='"+myForm.getCoreDashboardStatus()+"' where WORK_id='"+ proposalHolder.getProposalId()+"'"; 
						session.setAttribute("propsalId",proposalHolder.getProposalId());
						stat.addBatch(query); 
						if(!(scheme.equals("11")|| scheme.equals("12"))){
							query="DElETE FROM rws_admn_hab_lnk_tbl WHERE WORK_id='"+ proposalHolder.getProposalId()+"'";
						}
						else if(scheme.equals("11")){
							query="DElETE FROM rws_work_school_lnk_tbl WHERE WORK_id='"+ proposalHolder.getProposalId()+"'";
						}
						else if(scheme.equals("12")){
							query="DElETE FROM rws_work_lab_lnk_tbl WHERE WORK_id='"+ proposalHolder.getProposalId()+"'";
						}
						stat.addBatch(query); 				     
					 	String[] habCodes = request.getParameterValues("H_"+proposalHolder.getProposalId());
						int noOfHabs = 0;
						if(scheme!=null && !(scheme.equals("11")||scheme.equals("12")))	{
							for (int i = 0; i < habCodes.length; i++){
								query = " INSERT INTO rws_admn_hab_lnk_tbl(work_id, hab_code)" 
									  + " VALUES('" + proposalHolder.getProposalId() + "', " + " '" + habCodes[i] + "')";						
								noOfHabs++;
								total++;
								stat.addBatch(query);
							}
						}
						else if(scheme!=null && scheme.equals("12")){
							int noOfLabs = 0;						
							for (int i = 0; i < habCodes.length; i++){
								query = " INSERT INTO rws_work_lab_lnk_tbl(work_id, lab_code)" 
									  + " VALUES('" + proposalHolder.getProposalId() + "', " 
									  + " '" + habCodes[i] + "')";							
								noOfLabs++;
								total++;
								stat.addBatch(query);
							}						
						}
						else if(scheme!=null && scheme.equals("11")){
							int noOfSchools = 0;					  
							for (int i = 0; i < habCodes.length; i++){
								query = " INSERT INTO rws_work_school_lnk_tbl(work_id,hab_code,school_code)" 
									  + " VALUES('" + proposalHolder.getProposalId() + "', " + "'" + habCodes[i].substring(0,16) + "','" + habCodes[i].substring(16,19) + "')";
								noOfSchools++;
								total++;
								stat.addBatch(query);
							}
						}
					}
					int[] updateCounts = stat.executeBatch();
					boolean flag = true;
					for(int i=0; i< total; i++)	{
						if(updateCounts[i] < 1)
							flag = false;
					}
					if(flag){
						conn.commit();
						conn.setAutoCommit(true);										
						session.removeAttribute("selectedHabs");
						session.removeAttribute("constituencies");
						session.removeAttribute("RepresentativeProposalForm");
						ProposalDAO proposalDAO = new ProposalDAO(dataSource);
						proposalDAO.deleteTempSelectedHabs();										
						session.setAttribute("GlobalConstants.Message", "Record(s) Updated Successfully!");
					}
				     mode="UpdatedView";
				}
				catch(Exception e){
					System.out.println("The Exception is in AdministrativeSanctionAction : " + e.getMessage());					
					message = "The record Cannot inserted !";
					session.setAttribute("GlobalConstants.Message", message);
					target = "failure";
				} 
				finally	{
					if(stat != null){	
						stat.close();
					}
					if(conn != null){	
						conn.close();
					}
				}
			}
			
		    if(mode != null && mode.equals("Delete")){
				String workId = request.getParameter("proposalId");
				ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request)); 
				DAOMessage daoMessage=proposalDAO.deleteAdminiStrativeDetails(workId);
				request.setAttribute("message",daoMessage.getMessage());
				target = new String("view-success");
			}
		    
		    if(mode != null && mode.equals("DeleteRev")){
				String workId = request.getParameter("proposalId");
				ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request)); 
				DAOMessage daoMessage=proposalDAO.deleteRevisedDetails(workId);
				request.setAttribute("message",daoMessage.getMessage());				
				mode="updatedrevisedwork";
				target = new String("updatedrevisedwork");
			}
		    
		 	if(mode != null && mode.equals("View"))	{
		 		ProposalDTO proposalDTO = new ProposalDTO();	 		
		 		String circleoffice=myForm.getCircleOfficeCode();
			    session.removeAttribute("selectedHabs");
				officeCode = user.getOfficeCode();
				String category=myForm.getWorkCat();					     
				String scheme=myForm.getTypeOfAsset();					     
				String subprogram=myForm.getSubPrograms();					     
				String program=myForm.getPrograms();
				ProposalDAO proposalDAO = new ProposalDAO(dataSource);
				ArrayList adminiStrativeSanctionList1 = proposalDAO.getAdminstrativeSanctionList(officeCode,"",myForm.getCircleOfficeCode(),myForm.getDivisionOfficeCode(),myForm.getSubdivisionOfficeCode(),category,scheme,program,subprogram,myForm.getPlan(),myForm.getWrktype(),user.getUserId());
				request.setAttribute("AdministrativeSanctionList", adminiStrativeSanctionList1);			
				target = new String("view-success");
			}
		 	
		 	if(mode != null && mode.equals("UpdatedView")){
		 		ProposalDTO proposalDTO = new ProposalDTO();	 		
		 		String circleoffice=myForm.getCircleOfficeCode();
			    session.removeAttribute("selectedHabs");
				officeCode = user.getOfficeCode();
				ProposalDAO proposalDAO = new ProposalDAO(dataSource);
				ArrayList adminiStrativeSanctionList1 = proposalDAO.getAdminstrativeSanctionList(officeCode,(String)session.getAttribute("propsalId"));
				request.setAttribute("AdministrativeSanctionList", adminiStrativeSanctionList1);
				session.removeAttribute("propsalId");
				target = new String("updatedwork");
			}
		 	
		 	if(mode != null && mode.equals("RevisedView")){			
				session.removeAttribute("selectedHabs");
				officeCode = user.getOfficeCode();
				officeCode = "1"+myForm.getCircleOfficeCode()+myForm.getDivisionOfficeCode()+myForm.getSubdivisionOfficeCode();
				ProposalDAO proposalDAO = new ProposalDAO(dataSource);
				ArrayList RevisedList = proposalDAO.getRevisedSanctionList(officeCode,"",myForm.getPlan(),myForm.getWrktype(),myForm.getWorkCat(),myForm.getTypeOfAsset());
				request.setAttribute("RevisedSanctionList", RevisedList);			
				target = new String("view-success");
			}
		 	
			if(mode != null && mode.equals("RevisedEdit")){			
				session.removeAttribute("selectedHabs");
				officeCode = user.getOfficeCode();
				ProposalDAO proposalDAO = new ProposalDAO(dataSource);			
				ArrayList RevisedList = proposalDAO.getRevisedSanctionList(officeCode,request.getParameter("proposalId"),"","","","");
				ProposalDTO proposalDTO = new ProposalDTO();
				proposalDTO=(ProposalDTO)RevisedList.get(0);			
				ProposalHolder	proposalHolder = new ProposalHolder();
				proposalHolder.setProposalName(proposalDTO.getProposalName());
				proposalHolder.setProposalId(proposalDTO.getProposalId());
				if(request.getParameter("noOfSelectedHabs")== null || (request.getParameter("noOfSelectedHabs")!=null && request.getParameter("noOfSelectedHabs").equals("")))
					proposalDTO.setRevNoOfHabs(proposalDTO.getRevNoOfHabs());
				else
					proposalDTO.setRevNoOfHabs(request.getParameter("noOfSelectedHabs"));
				proposalHolder.setRevNoOfHabs(proposalDTO.getRevNoOfHabs());
			 	proposalHolder.setAdminiStrativeDate(proposalDTO.getAdminDate());
				proposalHolder.setAdminiStrativeNum(proposalDTO.getAdminNo());
				proposalHolder.setSanctionAmout(proposalDTO.getSanctionedAmount());
				proposalHolder.setRevisedAdminiStrativeDate(proposalDTO.getRevAdminDate());
				proposalHolder.setRevisedAdminiStrativeNum(proposalDTO.getRevAdminNo());
				proposalHolder.setRevisedSanctionAmout(proposalDTO.getRevSanctionedAmount());
				session.setAttribute("leads",proposalDTO.getLeadHabitation());
				RevisedList=new ArrayList();
				RevisedList.add(proposalHolder); 
				myForm.setProposals(RevisedList);			
		 	    myForm.setTypeOfAsset(proposalDTO.getTypeOfAsset());
			    myForm.setPrograms(proposalDTO.getProgrammeName());
			    myForm.setSubPrograms(proposalDTO.getSubprogrammeName());
			    myForm.setCircleOfficeName(proposalDTO.getCircleOfficeName());
			    myForm.setCircleOfficeCode(proposalDTO.getCircleOfficeCode());
			    myForm.setDivisionOfficeName(proposalDTO.getDivisionOfficeName());
			    myForm.setSubdivisionOfficeName(proposalDTO.getSubdivisionOfficeName());
			    myForm.setWorkCat(proposalDTO.getWorkCat());
			    myForm.setPlan(proposalDTO.getPlan());
				myForm.setWrktype(proposalDTO.getWrkType());			
			    try {
			    	if(request.getParameter("showHabs").equals("true"))	{
			    		if(request.getParameter("initial")!=null && request.getParameter("initial").equals("true")){
			    			proposalDAO.getHabsForRevisedWorkIdToSession(session,proposalDTO.getProposalId()  );	    		
			    		}		    	
			    	}
			    	session.setAttribute("selectedHabs", proposalDAO.getRevisedSelectedHabs((ArrayList)session.getAttribute("tempSelectedAdmnHabs"),proposalDTO.getProposalId()));
			    }
			    catch(Exception e){
			    	System.out.println("The Exception is in AdministrativeSanctionAction : " + e.getMessage());						
				}		  
				target = new String("Edit-Page");
			}
			
			if(mode != null && mode.equals("showHabs")){
				String proposalId = request.getParameter("proposalId");
				String code=proposalId.substring(6,8);
				if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))){
					target = new String("data-success");
				}
				else if(code.equals("11")){
					target = new String("data-success1");	
				}
				else if(code.equals("12")){
					target = new String("data-success2");
				}else if(code.equals("14")){
					target = new String("data-success4");
				}
				if( proposalId != null && proposalId.length() > 0){
				 	ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));			 	
				 	user=(RwsUser)session.getAttribute("RWS_USER");
				 	boolean flag = true;
					if(request.getParameter("flag")!=null && request.getParameter("flag").equals("false"))flag=false;			 	
					ArrayList habs = proposalDAO.getSelectedHabitationsForAdminStrative(proposalId,"tab_"+user.getUserId()+"_temp",flag); 
					request.setAttribute("selectedHabs", habs);
				}
			}
			if(mode != null && mode.equals("showRevHabs")){
				String proposalId = request.getParameter("proposalId");
				String code=proposalId.substring(6,8);
				if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14")))	{
					target = new String("data-success");
				}
				else if(code.equals("11")){
					target = new String("data-success1");	
				}
				else if(code.equals("12")){
					target = new String("data-success2");
				}else if(code.equals("14")){
					target = new String("data-success4");
				}
				if( proposalId != null && proposalId.length() > 0){
					ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request)); 
					ArrayList habs = proposalDAO.getSelectedHabitationsForRevised(proposalId); 
					request.setAttribute("selectedHabs", habs);
				}
			}
		}catch(Exception e){
			System.out.println("The Exception is in AdministrativeSanctionAction : "+e.getMessage());
		}
		return mapping.findForward(target);			
	}
		
	public void reset(RepresentativeProposalForm myForm){
		myForm.setRepCode("");
		myForm.setConstituencyCode("");
		myForm.setRepName("");
		myForm.setRepAddress("");
		myForm.setRepDate("");
		myForm.setDescription("");
		myForm.setEndorsementNo("");
		myForm.setEndorsementDate("");
		myForm.setEndorsedBy("");
		myForm.setRecommendations("");
		myForm.setInit(true);
		myForm.setSelectedHabCode("");
		myForm.setCircleOfficeCode("");
		myForm.setDivisionOfficeCode("");
		myForm.setTypeOfAsset("");
		myForm.setWorkCat("");
		myForm.setPrograms("");
		myForm.setSubPrograms("");
		myForm.setSubdivisionOfficeCode("");
		myForm.setPlan("");
		myForm.setWrktype("");
		myForm.setAugsch("");
		myForm.setProoved("");
		myForm.setSustainDetails("");
		if(myForm.getProposals()!=null){
			Iterator iterator = myForm.getProposals().iterator();		
			ProposalHolder proposalHolder = null;
			while(iterator.hasNext()){
				proposalHolder = (ProposalHolder)iterator.next();
				proposalHolder.setEstimateCost("");
				proposalHolder.setAdminiStrativeDate("");
				proposalHolder.setAdminiStrativeNum("");
				proposalHolder.setSpillOver("");
				proposalHolder.setNoOfHabs("");
				proposalHolder.setProposalName("");
				proposalHolder.setSanctionAmout("");
				proposalHolder.setProposalId("");
				proposalHolder.setProposalName("");
				proposalHolder.setRemarks("");
			}
		}		
	}
}
