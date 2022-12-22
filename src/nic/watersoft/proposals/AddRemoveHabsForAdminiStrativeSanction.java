package nic.watersoft.proposals;

import java.util.ArrayList;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.Debug;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nic.watersoft.commons.RwsLocations;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class AddRemoveHabsForAdminiStrativeSanction extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
		HttpServletResponse response) throws Exception
	{
		//System.out.println("in AddRemoveHabsForAdminiStrativeSanction action ");
		String target = new String("data-success");
		try{
		String proposalId = request.getParameter("proposalId");
//		added by swapna
		String code="";
		//
		ProposalForm myForm = (ProposalForm)form;
		String mode = myForm.getMode();
		Debug.println("Mode:"+mode);
		HttpSession session = request.getSession();
		RwsLocations rwsLocations = null;
		//System.out.println("The mode in AddRemoveHabs is for admin sanction " + mode);
		if(mode != null)
		{
			ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
			if(mode.equals("addRemoveHabs"))
			{
				if(proposalId != null && proposalId.length() >0)
				{
//					added by swapna
				 	 code = proposalId.substring(6,8);
//
					ProposalDTO proposalDTO = proposalDAO.getProposalDetails(proposalId);
					String officeCode = proposalDTO.getOfficeCode();
					if(officeCode == null || officeCode.length() ==0)
					{
						officeCode = request.getParameter("officeCode");
					}
					//System.out.println("officeCode :" + officeCode);
					if(officeCode==null)
					{
						officeCode="";
					}
					rwsLocations = new RwsLocations(getDataSource(request));
					RwsUser user=new RwsUser();
					user=(RwsUser)session.getAttribute("RWS_USER");
					String[] mcodes=null;
				 	String all=request.getParameter("All");
					
					String circleOfficeCode = officeCode.substring(1,3);
					String view=request.getParameter("view");
					if(view!=null&&view.equals("Mandal-view"))
					{
				  	 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode);
				 	 session.setAttribute("mandalss", mandals);
				 	 //swapna
				 	ArrayList districts=rwsLocations.getDistricts();
				 	 session.setAttribute("districts", districts);
					 System.out.println("districts:"+districts.size()); 
				 	 System.out.println("mandals:"+mandals.size());  
				 	 String tabName1="";
				 	if(!(code.equals("11")||code.equals("12")))
				 	 {
				 	 target="Mandal-view";
				 	 }
				 	 else if(code.equals("11"))
				 	 {
				 		 target="Mandal-school";
				 	 }
				 	else if(code.equals("12"))
				 	 {
				 		 target="Mandal-lab";
				 	 }
				 	 proposalDAO=new ProposalDAO(getDataSource(request));
				 	  String[] manCodes=new String[50];
				 	   manCodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
				 	  session.setAttribute("checkManCodes",manCodes);
				 	  
				 	  Debug.println("code after mandel::"+code);
				 	 if(!(code.equals("11")|| code.equals("12")))
						{
							tabName1 = "tab_"+user.getUserId()+"_temp";
						}
						else if(code.equals("11"))
						{
							tabName1 = "tab_"+user.getUserId()+"_temp_school";
						}
						else if(code.equals("12"))
						{
							tabName1 = "tab_"+user.getUserId()+"_temp_lab";
						}
				 	 //
				 	 //System.out.println("mandals:"+mandals.size());  
				 	
				 	ArrayList habs = rwsLocations.getAdminStrativeHabitations(proposalId, officeCode,null,mcodes,all);
				 	//Debug.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
					 ArrayList tempSelectedHabs = proposalDAO.getTempSelectedHabsForAdminSancEdit(proposalId,tabName1);
					// Debug.println("cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc");
					// Debug.println("selected habs length:"+tempSelectedHabs.size());
						ArrayList selectedHabs = null;
						Debug.println(tempSelectedHabs.size()+"");
						if(tempSelectedHabs.size() <= 0)
						{	
							System.out.println("-----------All Selected Habitations are----------");
							selectedHabs = proposalDAO.getSelectedHabitations(proposalId);
							request.setAttribute("selectedHabs", selectedHabs);
						}
						else
							request.setAttribute("selectedHabs", tempSelectedHabs);
					//	Debug.println("selected habs lengthhhhhh:"+tempSelectedHabs.size());	
						session.setAttribute("newhabitations", habs); 
			 	 	  session.setAttribute("H_"+proposalId,manCodes);
				 //	  Debug.println("TARGET IS-----------"+target);
			 	 	  return mapping.findForward(target);
					}
					//Debug.println("aaaaaaaaadddddddddrrrrrrrrrrrrr");
				   	String temp=request.getParameter("selectedMcodes");
				   //	System.out.println("Mandal codes are"+temp);
					  mcodes=temp.split("@");
					  session.setAttribute("H_"+proposalId,mcodes);
					  proposalDAO=new ProposalDAO(getDataSource(request)); 
					//System.out.println("GETTING HABS");
					//String schemecode=proposalId.substring(6,8);
					//Debug.println("schemecode::::"+schemecode);
					Debug.println("code::ffghhg::"+code);
					String tabName="";
					
					if(!(code.equals("11")|| code.equals("12")))
					{
						Debug.println("code::::"+code);
						tabName = "tab_"+user.getUserId()+"_temp";
					}
					else if(code.equals("11"))
					{
						Debug.println("code::::"+code);
						tabName = "tab_"+user.getUserId()+"_temp_school";
					}
					else if(code.equals("12"))
					{
						Debug.println("code::::"+code);
						tabName = "tab_"+user.getUserId()+"_temp_lab";
					}
					String[] selectedHabss = {};
					boolean flag = true;
					if(request.getParameter("flag")!=null && request.getParameter("flag").equals("false"))flag=false;
					proposalDAO.insertProposalTempHabsForAdmin(proposalId, selectedHabss,tabName,flag);
					ArrayList habs = rwsLocations.getAdminStrativeHabitations(proposalId, officeCode,null,mcodes,all);
					//Debug.println("asfghjkl;:"+habs.size());
					Debug.println("tname:::::::::::::"+tabName);
					ArrayList tempSelectedHabs = proposalDAO.getTempSelectedHabsForAdminSancEdit(proposalId,tabName);
					ArrayList selectedHabs = null;
					//Debug.println(tempSelectedHabs.size()+"");
					if(tempSelectedHabs.size() <= 0)
					{	
						System.out.println("-----------All Selected Habitations are----------");
						selectedHabs = proposalDAO.getSelectedHabitations(proposalId);
						request.setAttribute("selectedHabs", selectedHabs);
					}
					else
						request.setAttribute("selectedHabs", tempSelectedHabs);
					
					session.setAttribute("newhabitations", habs);
					
					request.setAttribute("proposalId", proposalId);
					request.setAttribute("from", request.getParameter("from"));
				}
					
		}
		else
		if(mode.equals("Save"))
		{
			proposalId = request.getParameter("proposalId");
			String[] selectedHabs = request.getParameterValues("habCodes");
			//Debug.println("sel length:"+selectedHabs.length);
			nic.watersoft.commons.RwsUser user=new nic.watersoft.commons.RwsUser();
			user=(RwsUser)session.getAttribute("RWS_USER");
			String schemecode=proposalId.substring(6,8);
			String tabName = "";
			if(!(schemecode.equals("11")|| schemecode.equals("12")))
			{
				tabName = "tab_"+user.getUserId()+"_temp";
			}
			else if(schemecode.equals("11"))
			{
				tabName = "tab_"+user.getUserId()+"_temp_school";
			}
			else if(schemecode.equals("12"))
			{
				tabName = "tab_"+user.getUserId()+"_temp_lab";
			}
			boolean flag = true;
			if(request.getParameter("flag")!=null && request.getParameter("flag").equals("false"))flag=false;
		 	
			if(proposalDAO.insertProposalTempHabsForAdmin(proposalId, selectedHabs,tabName,flag))
			{
				//Debug.println("111111111111111111111111111");
				request.setAttribute("insert-success", "inserted");
				ArrayList habs = proposalDAO.getSelectedHabitationsForAdminStrative2(proposalId,tabName);
				//Debug.println("22222222222222222222222222222:::::::::::"+habs.size());
				
				session.setAttribute("habs", habs);
				String[] habs1 = proposalDAO.getSelectedHabitationsForAdminStrative2(proposalId,tabName,habs.size());
				session.setAttribute("habs1", habs1);
			}
				else
			    request.setAttribute("insert-success", "not-inserted");
				
				request.setAttribute("from", request.getParameter("from"));
				
				target = new String("save-success");
					
				request.setAttribute("proposalId", proposalId);
			}
		  }
		}
		catch(Exception e)
		{
			//System.out.println("Exception in add or remove habs form :"+e);
		}
		Debug.println("TARGET IS"+target);
		return mapping.findForward(target);
	}
}