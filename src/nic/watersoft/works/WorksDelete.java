
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
public class WorksDelete extends Action {
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
	ArrayList divisions = null;
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
		dataSource = getDataSource(request);
		dataSource = getDataSource(request);
	 	
     	RwsOffices offices=new RwsOffices(dataSource);
		RwsUser user=new  RwsUser();
		user=(RwsUser)session.getAttribute("RWS_USER");
		
		if (user == null)
			return mapping.findForward("expire");	
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}		
		
		WorksMonitoringActionForm monitoringForm = (WorksMonitoringActionForm)form;
		
		WorksData1 worksData = new WorksData1(dataSource);
		
		String mode1=request.getParameter("mode1");
		String mode=request.getParameter("mode");
		if(mode!=null && mode.equals("data")){
			
			
			try{
			 	
				 if(mode1!=null && mode1.equals("DeleteWorks")){
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
				}
				if(!(user.getUserId().equals("admin")||user.getUserId().equals("100000")))
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
			    	circles = offices.CircleCombo("1");
			    	session.setAttribute("circles",circles);
				   
					if ((circleCode != null  && mode1!= null && mode1.equalsIgnoreCase("Divisions")))
					{ 
						
						dataSource = getDataSource(request);
						monitoringForm.setCircleCode(circleCode);
						offices=new RwsOffices(dataSource);
					    divisions = offices.getDivisions1(monitoringForm.getCircleCode());
					   	session.setAttribute("divisions",divisions);
					   	mode1="workcategory";
		 						 		
					}
					 if( (mode1!= null && mode1.equalsIgnoreCase("workcategory")))
						{
					 	
						
						    offices=new RwsOffices(dataSource);
						    ArrayList workcategory=offices.getWorkCategory();
						    session.setAttribute("workCategory",workcategory);
						    mode1="programmes";
				        				        	
						}
						
					
		 		    circleCode = monitoringForm.getCircleCode();
		 		    divisionCode = monitoringForm.getCmbDivision();
		 		   if( mode1!= null && mode1.equalsIgnoreCase("programmes"))
					{
		 		   		dataSource = getDataSource(request);
						monitoringForm.setCmbDivision(divisionCode);
					    offices=new RwsOffices(dataSource);
			        	programmes=offices.getProgrammes1(monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat());
			        	session.setAttribute("programmes",programmes);
			        	
			        	mode1="subprogrammes";
					}
		 		  if( mode1!= null && mode1.equalsIgnoreCase("subprogrammes"))
					{
		 		 
					dataSource = getDataSource(request);
					monitoringForm.setCmbDivision(divisionCode);
					
				    offices=new RwsOffices(dataSource);
				    subprogrammes=offices.getSubProgrammes(monitoringForm.getProgram());
				    session.setAttribute("subprogrammes",subprogrammes);
				   	}
					
					if(mode1==null || mode.equals("data") ){
						worksdel=new ArrayList();
					monitoringForm.setWorksforDelete(new ArrayList());}
					
					if(mode1!=null && mode1.equalsIgnoreCase("getWorks")){
						
						if(session.getAttribute("regular")!=null){
							session.removeAttribute("regular");
						}
						session.setAttribute("regular", "Y");
						
						worksfordeletion=worksData.getWorksforDeletion(getDataSource(request),circleCode,Integer.toString(monitoringForm.getCmbDivision()),monitoringForm.getProgram(),monitoringForm.getSubprogram(),monitoringForm.getPlan(),monitoringForm.getWrktype(),monitoringForm.getWorkCat());
						
					
					tendermemo = new tenderMemo();
					worksdel=new ArrayList();
					for (int i=0;i<worksfordeletion.size();i++)
					{
						tendermemo = (tenderMemo)worksfordeletion.get(i);	
						worksdel.add(new worksforDeletion(tendermemo.getWorkname(),tendermemo.getWorkid(),tendermemo.getSanctionno(),tendermemo.getSanctiondt(),tendermemo.getSanctionamount(),tendermemo.getProgName(),tendermemo.getSubprogName(),tendermemo.getNoofhabs(),tendermemo.getWrkCanDate()));
					}		
					
					monitoringForm.setWorksforDelete(worksdel);
					}
					if(mode1!=null && mode1.equalsIgnoreCase("getCancelWorks")){
						
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
						}
					
					
			} catch(Exception e)
			{
				Debug.println("Exception in WorkDelete:"+e);
				}
		}
		if(mode!=null && mode.equals("showHabs")){
	 			String selworkId = request.getParameter("workID");
	 			if( selworkId != null && selworkId.length() > 0)
	 			{
	 			 	ArrayList habs = worksData.getHabs(getDataSource(request),selworkId);
	 				request.setAttribute("selectedHabs", habs);
	 			}
			}
			
		
		return mapping.findForward(mode);
		
	}
}
