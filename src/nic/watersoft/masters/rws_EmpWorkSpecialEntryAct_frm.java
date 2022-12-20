package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

public class rws_EmpWorkSpecialEntryAct_frm extends Action
{
	protected ActionForm buildWorkSpecForm(String workSpecCode,HttpServletRequest request) throws Exception 
	{
		WorkSpecialForm form = null;
		EmpMaster EmpMaster=EmpMasterData.getWorkSpec(workSpecCode,getDataSource(request));		
			if(EmpMaster!=null)
			{
				form = new WorkSpecialForm();
				form.setWorkSpecCode(EmpMaster.getWorkSpecCode());
				form.setWorkSpecName(EmpMaster.getWorkSpecName());				
			}
	return form;
	}
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");			
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsEEUser(user.getUserId()) ))) {
			return mapping.findForward("unAuthorise");	
		}			
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList workSpecs=null;	
		WorkSpecialForm frm=(WorkSpecialForm) form;
		String mode=frm.getMode();		 
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("code",EmpMasterData.getWorkSpecialCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_WorkSpecialEntryAct_frm in inc is "+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				workSpecs=EmpMasterData.getWorkSpecs(getDataSource(request));
				session.setAttribute("workSpecs",workSpecs);
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_WorkSpecialEntryAct_frm in inc is "+e);
			}
		}
		if(mode.equalsIgnoreCase("save"))
		{
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {			
			try
			{
				EmpMaster EmpMaster = new EmpMaster();					
				EmpMaster.setWorkSpecCode(frm.getWorkSpecCode());
				EmpMaster.setWorkSpecName(frm.getWorkSpecName());
				ans=EmpMasterData.insertWorkSpec(EmpMaster,getDataSource(request));
				request.setAttribute("code",EmpMasterData.getWorkSpecialCode(getDataSource(request)));
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_WorkSpecialEntryAct_frm in inc is "+e);
			}
		    }
			if(ans <1)
			{	if(EmpMasterData.errorMessage != null && EmpMasterData.errorMessage.length() > 0)
					message = EmpMasterData.errorMessage;
				else
				message="The Record Cant be inserted";
			}
			else
			{	message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildWorkSpecForm(request.getParameter("workSpecCode"),request);
				if ("request".equalsIgnoreCase(mapping.getScope())) 	{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else{
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_WorkSpecialEntryAct_frm in inc is "+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {
		    	try	  
			{
				EmpMaster EmpMaster = new EmpMaster();		
				EmpMaster.setWorkSpecCode(frm.getWorkSpecCode());
				EmpMaster.setWorkSpecName(frm.getWorkSpecName());				
				ans = EmpMasterData.updateWorkSpec(EmpMaster,getDataSource(request));
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_WorkSpecialEntryAct_frm in inc is "+e);
			}
		    }
			if(ans <1)
			{	if(EmpMasterData.errorMessage != null && EmpMasterData.errorMessage.length() > 0)
					message = EmpMasterData.errorMessage;
				else
				message="The record cannot be updated.";
				mode = "get";
				request.setAttribute("message",message);
			}
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
			ans=EmpMasterData.removeWorkSpec(request.getParameter("workSpecCode"),getDataSource(request));
			if(ans>0)
			{
				displaymess = "Data deleted Succesfully";
			}
			else
			{
				displaymess = "Data cannot be deleted";
			}
			request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_WorkSpecialEntryAct_frm in inc is "+e);
			}
		}
		return(mapping.findForward(mode));
	}
}
