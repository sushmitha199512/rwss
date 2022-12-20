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

public class rws_ContamEntryAct_frm extends Action
{
	protected ActionForm buildContamForm(String contamCode,HttpServletRequest request) throws Exception 
	{
		ContamForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getContam(contamCode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new ContamForm();

				form.setContamCode(rwsMaster.getContamCode());
				form.setContamName(rwsMaster.getContamName());
				
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList contams=null;
		HttpSession session=request.getSession();

		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {
			return mapping.findForward("expire");
		}
		
		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN)  || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");
		}
		
		ContamForm frm=(ContamForm) form;
		String mode=frm.getMode();
		 
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("acode",RwsMasterData.getContamCode(getDataSource(request)));
			//	System.out.println("in getcontam code");
			}
			catch(Exception e)
			{
				System.out.println("The error in rws_ContamEntryAct_frm in data is "+e);
			//	e.printStackTrace();
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
			contams=RwsMasterData.getContams(getDataSource(request));
			session.setAttribute("contams",contams);
			}
			catch(Exception e)
			{
				System.out.println("The error in rws_ContamEntryAct_frm in view is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
					
				rwsMaster.setContamCode(frm.getContamCode());
				rwsMaster.setContamName(frm.getContamName());
				
				ans=RwsMasterData.insertContam(rwsMaster,getDataSource(request));
				request.setAttribute("acode",RwsMasterData.getContamCode(getDataSource(request)));
				
			}
			
			catch(Exception e)
			{
				System.err.println("The error in rws_ContamEntryAct_frm in insert is "+e);
			}
			if(ans <1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
					message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
		
		}
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildContamForm(request.getParameter("contamCode"),request);
				//session.setAttribute("model", form);
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
				System.err.println("The error in rws_ContamEntryAct_frm in get is "+e);
			}
		}
		if(mode.equalsIgnoreCase("getdelete"))
		{
			
			
			try 
			{
				form = buildContamForm(request.getParameter("contamCode"),request);
				//session.setAttribute("model", form);
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
				System.err.println("The error in rws_ContamEntryAct_frm in get is "+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			System.out.println("Update token :"+token);
			System.out.println("Update storedToken :"+storedToken);
			if (storedToken.equals(token)) {
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setContamCode(frm.getContamCode());
				rwsMaster.setContamName(frm.getContamName());
				
				ans=RwsMasterData.updateContam(rwsMaster,getDataSource(request));
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_ContamEntryAct_frm in edit is "+e);
			}
			if(ans <1)
			{	if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
				message="The record cannot be updated.";
				mode = "get";
				request.setAttribute("message",message);
			}
		}
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			System.out.println("Dele token :"+token);
			System.out.println("Dele storedToken :"+storedToken);
			if (storedToken.equals(token)) {
			try 
			{
				ans=RwsMasterData.removeContam(request.getParameter("contamCode"),getDataSource(request));
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
				System.err.println("The error in rws_ContamEntryAct_frm in delete is "+e);
			}
		  }
			else
			{
				System.out.println("Testing");
			}
		}
		return(mapping.findForward(mode));
	}
}
