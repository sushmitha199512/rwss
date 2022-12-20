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

import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

public class rws_PublicRepEntryAct_frm extends Action
{
	protected ActionForm buildPublicRepForm(String publicRepCode,HttpServletRequest request) throws Exception 
	{
		PublicRepForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getPublicRep(publicRepCode,getDataSource(request));		
			if(rwsMaster!=null){
				form = new PublicRepForm();
				form.setPublicRepCode(rwsMaster.getPublicRepCode());
				form.setPublicRepName(rwsMaster.getPublicRepName());				
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		//Debug.println("user:" + user);
		if (user == null)
			return mapping.findForward("expire");
		int ans = 0;
		String repcode=null;
		String message=null;
		String displaymess=null;
		ArrayList publicReps=null;		
		PublicRepForm publicRepForm=(PublicRepForm) form;
		RwsMaster rwsMaster = new RwsMaster();
		String mode=publicRepForm.getMode();
			
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				repcode=RwsMasterData.getPublicRepCode(getDataSource(request));
				request.setAttribute("repcode",repcode);
			}
			catch(Exception e)
			{
				System.err.println("rws_PublicRepEntryAct_frm in inc is  "+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				publicReps=RwsMasterData.getPublicReps(getDataSource(request));
			}
			catch(Exception e)
			{
				System.err.println("rws_PublicRepEntryAct_frm in view is  "+e);
			}
			session.setAttribute("publicReps",publicReps);		
		}

		if(mode.equalsIgnoreCase("save"))
		{
			 session = request.getSession();
		     String storedToken = (String)session.getAttribute("csrfToken");
		     String token = request.getParameter("token");
		     if (storedToken.equals(token))
		     {				
			   	ValidationUtils validator=new ValidationUtils();				
				if(!publicRepForm.getPublicRepCode().equals(repcode)) {
					mode="data";
					request.setAttribute("message","Representative Code Changed while processing");
				}
				if(publicRepForm.getPublicRepName()!=null && !publicRepForm.getPublicRepName().equals("") && validator.aphaWithSpaceDotValidator(publicRepForm.getPublicRepName()) ) {
					try
					{
						rwsMaster.setPublicRepCode(publicRepForm.getPublicRepCode());
						rwsMaster.setPublicRepName(publicRepForm.getPublicRepName());							
						ans=RwsMasterData.insertPublicRep(rwsMaster,getDataSource(request));
						repcode=RwsMasterData.getPublicRepCode(getDataSource(request));
						request.setAttribute("repcode",repcode);						
					}
					catch(Exception e)
					{
						System.err.println("rws_PublicRepEntryAct_frm in insert is  "+e);
					}
					if(ans <1)
					{	if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
							message = RwsMasterData.errorMessage;
						else
						message="The Record Cant be inserted   ";
					}
					else
					{	message="Record Inserted Successfully";
					}
					request.setAttribute("message",message);
			}else {
				message="Alphabets with Space allowed ";
				request.setAttribute("message",message);
			}
		   }
		}
		
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildPublicRepForm(request.getParameter("publicRepCode"),request);
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
				System.err.println("rws_PublicRepEntryAct_frm in get is  "+e);
			}			
		}

		if(mode.equalsIgnoreCase("edit"))
		{
			 session = request.getSession();
		     String storedToken = (String)session.getAttribute("csrfToken");
		     String token = request.getParameter("token");
		     if (storedToken.equals(token))
		     {				
		    	ValidationUtils validator=new ValidationUtils();				
				if(publicRepForm.getPublicRepName()!=null && !publicRepForm.getPublicRepName().equals("") && validator.aphaWithSpaceValidator(publicRepForm.getPublicRepName()) ) {
					try
					{														
						rwsMaster.setPublicRepCode(publicRepForm.getPublicRepCode());
						rwsMaster.setPublicRepName(publicRepForm.getPublicRepName());				
						ans = RwsMasterData.updatePublicRep(rwsMaster,getDataSource(request));				
					}
					catch (Exception e) 
					{
						System.err.println("rws_PublicRepEntryAct_frm in edit is  "+e);
					}
					if(ans <1)
					{	if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
							message = RwsMasterData.errorMessage;
						else
						message="The record cannot be updated.";
						mode = "get";
						request.setAttribute("message",message);
					}
				}else {
					message="Alphabets with Space allowed ";
					request.setAttribute("message",message);
				}
			   }
		}		
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				int rcount=RwsMasterData.removePublicRep(request.getParameter("publicRepCode"),getDataSource(request));
				if(rcount>0)
				{
					displaymess = "The Record Deleted Succesfully";
				}
				else
				{
					displaymess = "The Record Cannot be deleted";
				}
			}
			catch (Exception e) 
			{
				System.err.println("rws_PublicRepEntryAct_frm in delete is  "+e);
			}
			request.setAttribute("displaymess",displaymess);
		}			
	return(mapping.findForward(mode));
	}
}
