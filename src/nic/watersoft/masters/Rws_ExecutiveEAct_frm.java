package nic.watersoft.masters;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.LabelValueBean;


import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.*;


import org.apache.struts.action.*;

import nic.watersoft.commons.Debug;


public class Rws_ExecutiveEAct_frm extends Action {
	protected ActionForm buildEEForm(String circleOffice,String divisionOffice,String paoCode,HttpServletRequest request) throws Exception 
	{
		
		ExecutiveEForm executiveEForm=null;
		EEMasterData eeMasterData=new EEMasterData();
		RwsOffices rwsoffice=new RwsOffices();
		ArrayList circles=new ArrayList();
		ArrayList divisions=new ArrayList();
		HttpSession session = request.getSession();
		
		EEBean eeBean=EEMasterData.getPao1(circleOffice,divisionOffice,paoCode,getDataSource(request));
		
		
		
			if(eeBean != null)
			{
				
				executiveEForm = new ExecutiveEForm();
				executiveEForm.setPaoCode(eeBean.getPaoCode());
				executiveEForm.setCircleOffice(eeBean.getCircleOffice());
				circles=rwsoffice.getCircles();
				session.setAttribute("circles",circles);
				String cir=eeBean.getCircleOffice();
				Debug.println("cir"+cir);
				executiveEForm.setIsSaved("yes");
				
				executiveEForm.setCircleOffice(eeBean.getCircleOffice());
				executiveEForm.setCircleName(eeBean.getCircleName());
				
				
				executiveEForm.setDivisionOffice(eeBean.getDivisionOffice());
				executiveEForm.setDivisionName(eeBean.getDivisionName());
				
				//divisions=rwsoffice.getDivisions1(eeBean.getCircleOffice());
				//session.setAttribute("divisions",divisions);
				
				executiveEForm.setEeName(eeBean.getEeName());
				executiveEForm.setDateofPresent(eeBean.getDateofPresent());
				executiveEForm.setDateofReleaving(eeBean.getDateofReleaving());
				
				
			}
			return executiveEForm;
	}

	public Rws_ExecutiveEAct_frm() {
	}

	@SuppressWarnings("static-access")
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String page_to_be_displayed = " ";
		
		String message = null;
		String paocode="";
		
		
		
		
		
		
		
		
		
		
		
		RwsOffices rwsoffice=new RwsOffices();
		ArrayList circles=new ArrayList();
		ArrayList divisions=new ArrayList();
		ArrayList engineers=new ArrayList();

		ExecutiveEForm frm = (ExecutiveEForm) form;
		int i = 0;

		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		
		

		if (mode != null && mode.equalsIgnoreCase("view")) 
		{
			try
			{
				EEMasterData eeMasterData=new EEMasterData();
				engineers=EEMasterData.getEngineers();
				session.setAttribute("engineers",engineers);
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			page_to_be_displayed="view";
		}
		if (mode.equals("edit")) 
		{
			Debug.println("edit"+mode);
            try{
            	  	
            	
            	EEBean eeBean=new EEBean();
            	ExecutiveEForm executiveEForm=new ExecutiveEForm();
            	eeBean.setCircleOffice(frm.getCircleOffice());
            	eeBean.setDivisionOffice(frm.getDivisionOffice());
            	eeBean.setPaoCode(frm.getPaoCode());
            	eeBean.setEeName(frm.getEeName());
            	eeBean.setDateofPresent(frm.getDateofPresent());
            	String pao=eeBean.getPaoCode();
				
            	//String p=EEMasterData.getPaoComp(eeBean.getCircleOffice(),eeBean.getDivisionOffice());
            	//if(p.equals(pao))
            	//{
				    
				    
 			    					int x=EEMasterData.updateEE1(eeBean,getDataSource(request));
 			    					if(x>=1)
 			    					{
 			    						message="Record Updated";
 			    					}
            	//}
 			    					
 				
 				
 					
 			    				//String p1=EEMasterData.getPaoCompDate(eeBean.getCircleOffice(),eeBean.getDivisionOffice(),p);				
 			   					//Debug.println("ppaocode**************"+p1);
 								//if(p1==null  )
 								//{
 								//Debug.println("ppaocode**************1"+p1);
 								//message="Do u want Change please enter Releaving Date for this PAOCode"+p+"change remaining fields";
 								
 								//paocode=new EEMasterData().getPaoName(eeBean.getCircleOffice(),eeBean.getDivisionOffice(),frm);
 								
 								//}
 								
 					
 				String e=frm.getDateofReleaving();
 				Debug.println("e**********"+e);
 				
 					if(e!= null && !e.equals(""))
 					
 								{
 					
 									Debug.println("2*********");
 								
 									eeBean.setDateofReleaving(frm.getDateofReleaving());
 								
 								 int ee=EEMasterData.updateEE2(eeBean);
 								 message="Record Updated";
 								 
 								
 				
 								//
 								int zz=EEMasterData.shiftEE1(eeBean);
 								 Debug.println("zz"+zz);
 								 if(zz==1)
 								 {
 								 	int pp=EEMasterData.deleteEE1(eeBean);
 								 }
 								}
 								 reset1(frm);
 				
 								
 				
 				request.setAttribute("message",message);
 				
 			
 			}
 			catch(Exception e1)
 			{
 			e1.printStackTrace();
 			}
 			page_to_be_displayed="edit";
 			}

			//
		if (mode != null && mode.equalsIgnoreCase("data")) {
						
			try {
			if (request.getParameter("special") != null	&& request.getParameter("special").equals("reset"))
			{
				reset(frm);
				
			}
			EEMasterData eeMasterData=new EEMasterData();
			
			String eename="";
			String dateofpresent="";
			String dateofreleaving="";
				
			circles = rwsoffice.getCircles();
			session.setAttribute("circles",circles);
			if(frm.getCircleOffice()!=null)
			{
	 	 	divisions = rwsoffice.getDivisions1(frm.getCircleOffice());
	 	 	session.setAttribute("divisions",divisions);
			}
			
			reset1(frm);
			paocode=eeMasterData.getPaoName(frm.getCircleOffice(),frm.getDivisionOffice(),frm);
								
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			page_to_be_displayed="data";
		}
		
		if(mode.equalsIgnoreCase("get"))
		{
			
			
			try 
			{
				Debug.println("3");
				form = buildEEForm(request.getParameter("circleOffice"),request.getParameter("divisionOffice"),request.getParameter("paoCode"),request);
				
				if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				//System.out.println("the error is Get Constiuency is "+e);
			}
			page_to_be_displayed="get";
		}

		if (mode != null && mode.equalsIgnoreCase("save")) 
			
			{
				try
				{
				ExecutiveEForm executiveEForm=new ExecutiveEForm();
				EEMasterData eemaster=new EEMasterData();
				EEBean eeBean=new EEBean();
				int paocount=EEMasterData.getPaoCount(frm.getCircleOffice(),frm.getDivisionOffice());
				if(paocount==0)
				{
					int saveee=EEMasterData.saveEE(executiveEForm,frm.getCircleOffice(),frm.getDivisionOffice(),frm.getPaoCode(),frm.getEeName(),frm.getDateofPresent(),frm.getDateofReleaving());
					if(saveee==1 || paocount==1 )
					{
					message="Record Saved Successfully";
					}
					reset1(frm);
					
				}
						
					if(paocount>=1){
					
					String pacoCodeavail = eemaster.paoCodeExists(frm.getCircleOffice(),frm.getDivisionOffice(),frm.getPaoCode());
						if(!pacoCodeavail.isEmpty() && frm.getDateofReleaving() == null)
						{
							message="Record Already Exists .If you want to Change Employee Code Please carry the Releaving Date. ";
						}					
					else
					{
						String paoCode=eemaster.getPaoComp(frm.getCircleOffice(),frm.getDivisionOffice());					
						String p1=EEMasterData.getPaoCompDate(frm.getCircleOffice(),frm.getDivisionOffice(),paoCode);	
						if(p1==null )
						{
						message="Do You want Change Employee Code of Employee Code"+paoCode+" . Please enter Releaving the Date";
						paocode=eemaster.getPaoName(frm.getCircleOffice(),frm.getDivisionOffice(),frm);											
						}						
						if(frm.getDateofReleaving()!= null && !frm.getDateofReleaving().equals(""))
						{
							int x=EEMasterData.updateEE(executiveEForm,frm.getCircleOffice(),frm.getDivisionOffice(),frm.getPaoCode(),frm.getEeName(),frm.getDateofPresent(),frm.getDateofReleaving());
							eeBean.setDateofReleaving(frm.getDateofReleaving());								
							 int ee=EEMasterData.updateEE2(eeBean);
						 message="Record Updated .Employee Code"+paoCode+" Has been Removed & Will be effected to Digital Signature of EE";
						}
					 } 
					String dateofReleaving=frm.getDateofReleaving();
	 				if(dateofReleaving!=null && !dateofReleaving.equals(""))
	 				{
					 int removeEmp=EEMasterData.shiftEE(executiveEForm,frm.getCircleOffice(),frm.getDivisionOffice(),frm.getPaoCode(),frm.getEeName(),frm.getDateofPresent(),frm.getDateofReleaving());
					 if(removeEmp==1)
					 {
						int pp=EEMasterData.deleteEE(executiveEForm,frm.getCircleOffice(),frm.getDivisionOffice(),frm.getPaoCode());
						int eeDSCReg = eemaster.deleteEERegDscToken(executiveEForm,frm.getCircleOffice(),frm.getDivisionOffice(),frm.getPaoCode());
						message="Digital Signature of EE has been deleted. Please Register with newly updated data. ";
					 	reset1(frm);
					 }
	 			   }
				}
				request.setAttribute("message",message);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				page_to_be_displayed="save";
			}
					
		
		
			
		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(ExecutiveEForm frm) {
		frm.setCircleOffice("");
		frm.setDivisionOffice("");
		frm.setPaoCode("");
		frm.setDateofPresent("");
		frm.setDateofReleaving("");
		frm.setEeName("");
		
		
		
	}
	public void reset1(ExecutiveEForm frm) {
		//frm.setCircleOffice("");
		//frm.setDivisionOffice("");
		frm.setPaoCode("");
		frm.setDateofPresent("");
		frm.setDateofReleaving("");
		frm.setEeName("");
		
		
		
	}
	
		
		
		
		
		
	}
	



