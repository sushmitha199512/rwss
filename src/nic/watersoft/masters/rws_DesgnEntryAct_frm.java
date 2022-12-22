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

public class rws_DesgnEntryAct_frm extends Action
{
	protected ActionForm buildDesgnForm(String desgnCode,HttpServletRequest request) throws Exception 
	{
		DesgnForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getDesgn(desgnCode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new DesgnForm();

				form.setDesgnCode(rwsMaster.getDesgnCode());
				form.setDesgnAcr(rwsMaster.getDesgnAcr());
				form.setDesgnName(rwsMaster.getDesgnName());
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList desgns=null;
		DesgnForm frm=(DesgnForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("code",RwsMasterData.getDesgnCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				//System.out.println("The error in Desgn inc is "+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
			desgns=RwsMasterData.getDesgns(getDataSource(request));
			session.setAttribute("desgns",desgns);
			}
			catch(Exception e)
			{
				//System.out.println("The error in Desgn View is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setDesgnCode(frm.getDesgnCode());
				rwsMaster.setDesgnAcr(frm.getDesgnAcr());
				rwsMaster.setDesgnName(frm.getDesgnName());
				
				ans=RwsMasterData.insertDesgn(rwsMaster,getDataSource(request));
				
				request.setAttribute("code",RwsMasterData.getDesgnCode(getDataSource(request)));
				
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("the error in Desgn Insert is "+e);
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
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildDesgnForm(request.getParameter("desgnCode"),request);
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
		
				//System.out.println("the error is"+e);
			}
		
	}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setDesgnCode(frm.getDesgnCode());
				rwsMaster.setDesgnAcr(frm.getDesgnAcr());
				rwsMaster.setDesgnName(frm.getDesgnName());
				
				ans = RwsMasterData.updateDesgn(rwsMaster,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Desgn edit is "+e);
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
		if(mode.equalsIgnoreCase("delete"))
		{
			int del=0;
			try 
			{	
				del=RwsMasterData.removeDesgn(request.getParameter("desgnCode"),getDataSource(request));	
				if(del>0)
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
				//System.out.println("the error in Desgn delete is "+e);
			}
		}
			return(mapping.findForward(mode));
	}

}
