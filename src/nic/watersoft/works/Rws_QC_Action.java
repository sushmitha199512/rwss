
package nic.watersoft.works;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.quartz.simpl.SystemPropertyInstanceIdGenerator;
public class Rws_QC_Action extends Action {
	
	DataSource dataSource = null;
	
	String circleCode = "";
	int divisionCode = 0;
	String subdivisionCode = "";
	String subdivisionName = "";
	String programmeCode = "";
	String subprogrammeCode = "";
	String mandal="";
	String workCode = "";
	String assetCode = "";	
	ArrayList Qc_divisions = null;
	ArrayList circles = null;
	ArrayList subdivisions = null;
	ArrayList programmes = null;
	ArrayList subprogrammes = null;
	ArrayList financialyears = null;
	ArrayList months = null;
	ArrayList assetType = null;
	String circleName ="";
	String divisionName = "";
	ArrayList worksfordeletion=new ArrayList();
	ArrayList worksforDel=new ArrayList();
	ArrayList checkedTests=new ArrayList();
	Collection worksdel = new ArrayList();
	Collection worksforDelete=new ArrayList();
	String checking[]=null;
	tenderMemo tendermemo = null;
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception 
	{
		HttpSession session = request.getSession(true);
		//HttpSession session = request.getSession();
		String storedToken,token;
		dataSource = getDataSource(request);
		//dataSource = getDataSource(request);
	 	
     	RwsOffices offices=new RwsOffices(dataSource);
		RwsUser user=new  RwsUser();
		user=(RwsUser)session.getAttribute("RWS_USER");
		WorksMonitoringActionForm worksBean = null;
		/*if (user == null)
			return mapping.findForward("expire");	
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}	*/	
		
		WorksMonitoringActionForm monitoringForm = (WorksMonitoringActionForm)form;
		//RwsQualityControlDAO rwsHabLinkDAO = new RwsQualityControlDAO();
		Rws_QC_DAO rwsHabLinkDAO = new Rws_QC_DAO();
		ArrayList employeesRecBy = null;
		ArrayList deeemployeesRecBy = null;
		ArrayList eeemployeesRecBy = null;
		ArrayList seemployeesRecBy = null;
		//WorkDeleteDAO1
		
		///////////WorksData1 worksData = new WorksData1(dataSource);
		//rws_works_WorksDAO rwsworksdao=new rws_works_WorksDAO();
		
		String mode1=request.getParameter("mode1");
		String mode=request.getParameter("mode");
		if(mode!=null && mode.equals("data")){
			
			
			try{
				
		/*		 if(mode1!=null && mode1.equals("DeleteWorks")){
					 int recno=0;int delcnt=0;
					 recno=Integer.parseInt(request.getParameter("resultCount"));
					 checking=new String[recno+1];
					   checking[0]=" ";
					 recno=Integer.parseInt(request.getParameter("resultCount"));
					 for(int i = 1; i < recno+1; i++){
					    if(request.getParameter("check"+i)!=null)
						  {
					       checking[i]="1"; 
					        delcnt = worksData.workDelete(dataSource,request.getParameter("check"+i),request.getParameter("deldate"));
						  } 
					    
					   }
					if(delcnt >0)
						request.setAttribute("message","Deleted Successfully");
					else if(delcnt == -1)
						request.setAttribute("message","Work Cannot be Deleted - Work Exists in Project Shelf(GOI)");
					else if(delcnt == -2)
						request.setAttribute("message","Work Cannot be Deleted - Work Selected Under AAP");
					else  if(delcnt == -3)
						request.setAttribute("message","Work Cannot be Deleted -- Work either Completed or Commissioned");	
					else  if(delcnt == -4)
						request.setAttribute("message","Work Cannot be Deleted -- Work Having MileStone Details");	
					else  if(delcnt == -5)
						request.setAttribute("message","Work Cannot be Deleted -- Work Having Bill Details");	
					String regCan=session.getAttribute("regular").toString();
					if(regCan.equals("Y")){
					mode1="getWorks";
					}
					else if(regCan.equals("N")){
						mode1="getCancelWorks";
					}
				}*/
				if(!(user.getUserId().equals("admin")||user.getUserId().equals("100000")||user.getUserId().substring(3,6).equals("vqc")))
				    {
					session.setAttribute("fixcircle","yes");			
				    String userId=user.getUserId();
					circleCode=userId.substring(1,3);
					divisionCode = monitoringForm.getCmbDivision();
					if(mode1==null)mode1="Divisions";
					}
				    else
				    {
				    session.setAttribute("fixcircle",null);
				    circleCode = monitoringForm.getCircleCode();
					divisionCode = monitoringForm.getCmbDivision();
					}
				    offices=new RwsOffices(dataSource);
				    
			    	if(user.getUserId().substring(3,6).equals("vqc"))
			    	{
			    		//session.setAttribute("fixcircle","yes");
			    		String userId=user.getUserId();					
						circleCode=userId.substring(1,3);//System.out.println("circleCode Action:"+circleCode);
						//circles = null;
			    		circles = offices.getCircleCombo("1",circleCode);
			    	}
			    	else
			    	{
			    		//circles = null;
			    		circles = offices.CircleCombo("1");
			    	}
			    	

			    	session.setAttribute("circles",circles);
				   
					if ((circleCode != null  && mode1!= null && mode1.equalsIgnoreCase("Divisions")))
					{ 						
						System.out.println("Action circleCode :"+circleCode);
						dataSource = getDataSource(request);
						monitoringForm.setCircleCode(circleCode);
						offices=new RwsOffices(dataSource);
						Qc_divisions = offices.getDivisions1(monitoringForm.getCircleCode());
						
						System.out.println("Action Qc_divisions :"+Qc_divisions);
						
						 if(Integer.parseInt(monitoringForm.getCircleCode())!=-1)
						    {
						    	//programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat());
						    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),circleCode,Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
						    }
						    else
						    {
						    	//programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),"-1");
						    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),"-1",Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
						    	session.removeAttribute("engAssignedBy");
						    	session.removeAttribute("engAssignedByDee");
						    	session.removeAttribute("engAssignedByEe");
						    	session.removeAttribute("engAssignedBySe");
						    	monitoringForm.setIssueDate("");
								monitoringForm.setCertDate("");
						    }
					   	session.setAttribute("QCdivisions",Qc_divisions);
					   	session.setAttribute("rwsWorks",worksfordeletion);
					   	mode1="subDivisions";		 		
					}
					
					if ((circleCode != null  && mode1!= null && mode1.equalsIgnoreCase("subDivisions")))
					{ 
						dataSource = getDataSource(request);	
						monitoringForm.setCircleCode(circleCode);
						offices=new RwsOffices(dataSource);
						subdivisions = offices.getSubDivisions1(monitoringForm.getCircleCode(), divisionCode+"");
						//System.out.println("subdivisions :"+subdivisions);
					   	session.setAttribute("subdivisions",subdivisions);
					   	
					   	if(Integer.parseInt(monitoringForm.getCircleCode())!=-1 && monitoringForm.getCmbDivision()!=-1)
					    {
					    	//programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat());
					    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),circleCode,Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
					    	programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat());
					    	subprogrammes=offices.getSubProgrammes(monitoringForm.getProgram());
					    }
					    else
					    {
					    	//programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),"-1");
					    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),"-1",Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
					    	programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),"-1");
					    	subprogrammes=offices.getSubProgrammes("-1");
					    	session.removeAttribute("engAssignedBy");
					    	session.removeAttribute("engAssignedByDee");
					    	session.removeAttribute("engAssignedByEe");
					    	session.removeAttribute("engAssignedBySe");
					    	monitoringForm.setIssueDate("");
							monitoringForm.setCertDate("");
					    }
					   	session.setAttribute("QCdivisions",Qc_divisions);
					   	session.setAttribute("rwsWorks",worksfordeletion);
					   	session.setAttribute("programmes",programmes);	
					   	session.setAttribute("subprogrammes",subprogrammes);
					   	mode1="workcategory";
					}
					
					 if( (mode1!= null && mode1.equalsIgnoreCase("workcategory")))
						{
						    //System.out.println("workcategory");
						    subprogrammes=offices.getSubProgrammes("");
						    //System.out.println("subprogrammes :"+subprogrammes);
						    session.removeAttribute("subprogrammes");
						    offices=new RwsOffices(dataSource);
						    ArrayList workcategory=offices.getWorkCategory();
						    session.setAttribute("workCategory",workcategory);
						    /*worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),"-1",Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
					    	programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),"-1");
					    	subprogrammes=offices.getSubProgrammes("-1");*/
					    	session.removeAttribute("engAssignedBy");
					    	session.removeAttribute("engAssignedByDee");
					    	session.removeAttribute("engAssignedByEe");
					    	session.removeAttribute("engAssignedBySe");
					    	monitoringForm.setIssueDate("");
							monitoringForm.setCertDate("");
							session.removeAttribute("subprogrammes");
							//System.out.println("monitoringForm.getSubdivisioncode() :"+monitoringForm.getSubdivisioncode());
						    if(Integer.parseInt(monitoringForm.getCircleCode())!=-1 && monitoringForm.getCmbDivision()!=-1 && Integer.parseInt(monitoringForm.getSubdivisioncode())!=-1)
						    {			
						    	//System.out.println("IF");
						    	//programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat());
						    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),circleCode,Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
						    	programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat());
						    	subprogrammes=offices.getSubProgrammes(monitoringForm.getProgram());
						    }
						    else
						    {
						    	//System.out.println("ELSE");
						    	//programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),"-1");
						    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),"-1",Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
						    	programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),"-1");
						    	subprogrammes=offices.getSubProgrammes("-1");
						    	session.removeAttribute("engAssignedBy");
						    	session.removeAttribute("engAssignedByDee");
						    	session.removeAttribute("engAssignedByEe");
						    	session.removeAttribute("engAssignedBySe");
						    	monitoringForm.setIssueDate("");
								monitoringForm.setCertDate("");
								session.setAttribute("subprogrammes",subprogrammes);
						    }
						   	session.setAttribute("QCdivisions",Qc_divisions);
						   	session.setAttribute("rwsWorks",worksfordeletion);
						   	session.setAttribute("programmes",programmes);	
						   	session.setAttribute("subprogrammes",subprogrammes);
						    mode1="programmes";				        				        	
						}
						
		 		    circleCode = monitoringForm.getCircleCode();
		 		    divisionCode = monitoringForm.getCmbDivision();
		 		   if( mode1!= null && mode1.equalsIgnoreCase("programmes"))
					{
		 		   		dataSource = getDataSource(request);
						monitoringForm.setCmbDivision(divisionCode);
					    offices=new RwsOffices(dataSource);
					    if(Integer.parseInt(monitoringForm.getCircleCode())!=-1 && monitoringForm.getCmbDivision()!=0)
					    {
					    	programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat());
					    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),circleCode,Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
					    }
					    else
					    {
					    	programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),"-1");
					    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),"-1",Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
					    	session.removeAttribute("engAssignedBy");
					    	session.removeAttribute("engAssignedByDee");
					    	session.removeAttribute("engAssignedByEe");
					    	session.removeAttribute("engAssignedBySe");
					    	monitoringForm.setIssueDate("");
							monitoringForm.setCertDate("");
					    }
			        	session.setAttribute("programmes",programmes);	
			        	session.setAttribute("rwsWorks",worksfordeletion);
			        	mode1="subprogrammes";
					}
		 		  if( mode1!= null && mode1.equalsIgnoreCase("subprogrammes"))
					{
		 			 //worksfordeletion=null;
					dataSource = getDataSource(request);
					monitoringForm.setCmbDivision(divisionCode);
					
				    offices=new RwsOffices(dataSource);
				   // System.out.println("monitoringForm.getProgram() :"+monitoringForm.getProgram());
				    
				    session.removeAttribute("engAssignedBy");
				    session.removeAttribute("engAssignedByDee");
				    session.removeAttribute("engAssignedByEe");
				    session.removeAttribute("engAssignedBySe");
			    	monitoringForm.setIssueDate("");
					monitoringForm.setCertDate("");
					
				    if(Integer.parseInt(monitoringForm.getCircleCode())!=-1 && monitoringForm.getCmbDivision()!=0 && Integer.parseInt(monitoringForm.getProgram())!=-1)
				    {
				    	subprogrammes=offices.getSubProgrammes(monitoringForm.getProgram());
				    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),circleCode,Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
				    }
				    else
				    {
				    	subprogrammes=offices.getSubProgrammes("-1");
				    	worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),"-1",Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());
				    	session.removeAttribute("engAssignedBy");
				    	session.removeAttribute("engAssignedByDee");
				    	session.removeAttribute("engAssignedByEe");
				    	session.removeAttribute("engAssignedBySe");
				    	monitoringForm.setIssueDate("");
						monitoringForm.setCertDate("");
				    }
				    session.setAttribute("subprogrammes",subprogrammes);
				    session.setAttribute("rwsWorks",worksfordeletion);
				   	}
					
				/*	if(mode1==null || mode.equals("data") ){
						worksdel=new ArrayList();
					monitoringForm.setWorksforDelete(new ArrayList());
					}*/
		 		  //System.out.println(mode+"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"+mode1);
		 			if (mode1 != null && mode1.equals("showQcCertificate")) {
		 				//System.out.println(mode+"!!!!!!!!$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"+mode1);
		 				
		 				/*WorksData1 worksData = new WorksData1(ds);

		 				byte a[] = worksData.getScannedCopy(request.getParameter("workId"), request.getParameter("slNo"));

		 				session.setAttribute("copyData", a);

		 				mode = "showFile";
		 				return mapping.findForward(mode);*/
		 				session.setAttribute("work_id", request.getParameter("workId"));
		 				//session.setAttribute("bill_date", request.getParameter("billDate").replace("/", "-"));
		 				//session.setAttribute("bill_sl_no", request.getParameter("slNo"));
		 				mode = "showFile";
		 				return mapping.findForward(mode);
		 			}
					
					if(mode1!=null && mode1.equalsIgnoreCase("getWorks")){
						//System.out.println("session :"+session.getAttribute("engAssignedBy"));
						 if(Integer.parseInt(monitoringForm.getCircleCode())!=-1 && monitoringForm.getCmbDivision()!=0)
						    {
							 //System.out.println("monitoringForm :"+monitoringForm.getSubdivisioncode());
							 worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),circleCode,Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());						
							 session.setAttribute("rwsWorks",worksfordeletion);
						    }
						 else
						 	{
							 worksfordeletion=rwsHabLinkDAO.getWorksforDeletion1(getDataSource(request),"-1",Integer.toString(monitoringForm.getCmbDivision()),"-1",monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat(),monitoringForm.getSubdivisioncode());						
							 session.setAttribute("rwsWorks",worksfordeletion);
							 session.removeAttribute("engAssignedBy");
							 session.removeAttribute("engAssignedByDee");
							 session.removeAttribute("engAssignedByEe");
							 session.removeAttribute("engAssignedBySe");
							 monitoringForm.setIssueDate("");
							 monitoringForm.setCertDate("");
						 	}
						
						//System.out.println("worksfordeletion.isEmpty() :"+worksfordeletion.isEmpty());
						
						//worksfordeletion.clear();
						
						/*if(worksfordeletion.isEmpty())
						{
							monitoringForm.setEngineerAssign("");
							monitoringForm.setEngineerAssign1("");
							monitoringForm.setEngineerAssign2("");
							monitoringForm.setEngineerAssign3("");
							System.out.println("vacharaaa.............");
							/////worksfordeletion.clear();
							session.setAttribute("rwsWorks",worksfordeletion);
						}
						else
						{
							worksfordeletion.clear();
							session.setAttribute("rwsWorks",worksfordeletion);
							System.out.println("raledu.............");
							monitoringForm.setEngineerAssign("");
							monitoringForm.setEngineerAssign1("");
							monitoringForm.setEngineerAssign2("");
							monitoringForm.setEngineerAssign3("");
						}*/
						
						
						/*for (int i=0;i<worksfordeletion.size();i++)
						{
							
							System.out.println("!!!!!!!!!"+worksfordeletion.get(0));
						}*/
						
						//worksfordeletion=rwsworksdao.getWorks22(monitoringForm, user.getUserId());
					
					/*tendermemo = new tenderMemo();
					worksdel=new ArrayList();
					for (int i=0;i<worksfordeletion.size();i++)
					{
						tendermemo = (tenderMemo)worksfordeletion.get(i);	
						worksdel.add(new worksforDeletion(tendermemo.getWorkname(),tendermemo.getWorkid(),tendermemo.getSanctionno(),tendermemo.getSanctiondt(),tendermemo.getSanctionamount(),tendermemo.getProgName(),tendermemo.getSubprogName(),tendermemo.getNoofhabs(),tendermemo.getWrkCanDate()));
					}		
					
					monitoringForm.setWorksforDelete(worksdel);*/
						mode1="getDetails";
					}
					
					
					
					
					/*if(mode1!=null && mode1.equalsIgnoreCase("getDetails")){
						
						System.out.println(monitoringForm.getWorkid()+"HHHHHHHHHH"+monitoringForm.getWorkName()+"hhhhh"+monitoringForm.getWorkid());
						
					}*/
					//System.out.println("mode1 :"+mode1);
					if (mode1!=null && mode1.equalsIgnoreCase("getDetails")) {
						String message="";
						//System.out.println("$$$$$$$********");
						//reset(bean);
						//String wType = bean.getWorkId().substring(6, 8);
						//System.out.println("circleCode :"+circleCode);
						session.removeAttribute("engAssignedBy");
						session.removeAttribute("engAssignedByDee");
						session.removeAttribute("engAssignedByEe");
						session.removeAttribute("engAssignedBySe");
						monitoringForm.setIssueDate("");
						monitoringForm.setCertDate("");
						message = rwsHabLinkDAO.getWorkDetails1(monitoringForm, request, getServlet());
							
							///////
						//System.out.println(monitoringForm.getWorkid()+"HHHHHHHHHH"+monitoringForm.getWorkName()+"hhhhh"+monitoringForm.getWorkid());

							if(!monitoringForm.getWorkId().equals(null) && !monitoringForm.getWorkId().equals("") && Integer.parseInt(monitoringForm.getCircleCode())!=-1 && monitoringForm.getCmbDivision()!=0){
							employeesRecBy = rwsHabLinkDAO.getEmployees(monitoringForm.getWorkId().substring(4, 6), 5, 9);
							deeemployeesRecBy = rwsHabLinkDAO.getDeeEmployees(monitoringForm.getWorkId().substring(4, 6), 5, 9);
							eeemployeesRecBy = rwsHabLinkDAO.getEeEmployees(monitoringForm.getWorkId().substring(4, 6), 5, 9);
							seemployeesRecBy = rwsHabLinkDAO.getSeEmployees(monitoringForm.getWorkId().substring(4, 6), 5, 9);							
							session.setAttribute("engAssignedBy", employeesRecBy);
							session.setAttribute("engAssignedByDee", deeemployeesRecBy);
							session.setAttribute("engAssignedByEe", eeemployeesRecBy);
							session.setAttribute("engAssignedBySe", seemployeesRecBy);
							}
							else
							{
								employeesRecBy = rwsHabLinkDAO.getEmployees(monitoringForm.getWorkId().substring(0, 0), 0, 0);
								deeemployeesRecBy = rwsHabLinkDAO.getDeeEmployees(monitoringForm.getWorkId().substring(0, 0), 0, 0);
								eeemployeesRecBy = rwsHabLinkDAO.getEeEmployees(monitoringForm.getWorkId().substring(0, 0), 0, 0);
								seemployeesRecBy = rwsHabLinkDAO.getSeEmployees(monitoringForm.getWorkId().substring(0, 0), 0, 0);
								session.setAttribute("engAssignedBy", employeesRecBy);
								session.setAttribute("engAssignedByDee", deeemployeesRecBy);
								session.setAttribute("engAssignedByEe", eeemployeesRecBy);
								session.setAttribute("engAssignedBySe", seemployeesRecBy);
								//session.removeAttribute("engAssignedBy");
								//session.removeAttribute("engAssignedByDee");
								//session.removeAttribute("engAssignedByEe");
								//session.removeAttribute("engAssignedBySe");
								monitoringForm.setIssueDate("");
								monitoringForm.setCertDate("");
							}
							worksBean = rwsHabLinkDAO.getProgramScheduleDetails1(getDataSource(request), monitoringForm.getWorkId());
							if (worksBean != null) {
								//fb.setSubDivAssign(worksBean.getSubDivAssign());
								monitoringForm.setEngineerAssign(worksBean.getEngineerAssign());
								monitoringForm.setEngineerAssignDee(worksBean.getEngineerAssignDee());
								monitoringForm.setEngineerAssignEe(worksBean.getEngineerAssignEe());
								monitoringForm.setEngineerAssignSe(worksBean.getEngineerAssignSe());
								//fb.setWorkGndDate(worksBean.getWorkGndDate());
								//fb.setAgreeDate(worksBean.getAgreeDate());
							} else if (worksBean == null) {
								//fb.setWorkGndDate("");
								monitoringForm.setEngineerAssign("");
								monitoringForm.setEngineerAssignDee("");
								monitoringForm.setEngineerAssignEe("");
								monitoringForm.setEngineerAssignSe("");
								monitoringForm.setIssueDate("");
								monitoringForm.setCertDate("");
								//bean.setWorkId("");
								
								//fb.setSubDivAssign("");
							}
							
							//bean.setTypeOfWork("hab");
						
						if (!message.equals("")) {
							request.setAttribute("message", message);
						}
					}
					
					//if (mode != null && mode.equals("updatedetails")) {
					 //System.out.println("***:"+mode1+":******"+mode);

						if (mode1.equalsIgnoreCase("upddetails")) {
							storedToken = (String)session.getAttribute("csrfToken");
						      token = request.getParameter("token");
						      if (storedToken.equals(token))
							     {
/*							System.out.println("YYYYY$$$$$$$$$$$$$$$$$$$$@@@@@@@@@@");
							     }else
							     {
										System.out.println("NNNNNNN$$$$$$$$$$$$$$$$$$$$@@@@@@@@@@");
 
							     }*/
							
						String message="";
						String targetPath = getServlet().getServletContext().getRealPath("")  + "temp.jpg";
						//System.out.println("bean daete.........."+monitoringForm.getCertDate()+"  -- "+monitoringForm.getIssueDate());
						 message=rwsHabLinkDAO.updateDetailsnew(monitoringForm, targetPath, getServlet());
						// System.out.println("******"+monitoringForm.getEngineerAssign());
						 request.setAttribute("message", message);
						}
					}
					
					/*if(mode1!=null && mode1.equalsIgnoreCase("getCancelWorks")){
						
						if(session.getAttribute("regular")!=null){
							session.removeAttribute("regular");
						}
						session.setAttribute("regular", "N");
						
						worksfordeletion=worksData.getCancelWorks(getDataSource(request),circleCode,Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat());
						tendermemo = new tenderMemo();
						worksdel=new ArrayList();
						for (int i=0;i<worksfordeletion.size();i++)
						{
						 tendermemo = (tenderMemo)worksfordeletion.get(i);	
						 worksdel.add(new worksforDeletion(tendermemo.getWorkname(),tendermemo.getWorkid(),tendermemo.getSanctionno(),tendermemo.getSanctiondt(),tendermemo.getSanctionamount(),tendermemo.getProgName(),tendermemo.getSubprogName(),tendermemo.getNoofhabs(),tendermemo.getWrkCanDate()));
						}		
						monitoringForm.setWorksforDelete(worksdel);
						}*/
			} 
			catch(Exception e)
			{
				Debug.println("Exception in WorkDelete:"+e);
			}
		}
		/*if(mode!=null && mode.equals("showHabs")){
	 			String selworkId = request.getParameter("workID");
	 			if( selworkId != null && selworkId.length() > 0)
	 			{
	 			 	ArrayList habs = worksData.getHabs(getDataSource(request),selworkId);
	 				request.setAttribute("selectedHabs", habs);
	 			}
			}*/
			
		
		return mapping.findForward(mode);
		
	}
}
