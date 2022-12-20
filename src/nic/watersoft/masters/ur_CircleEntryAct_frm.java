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

public class ur_CircleEntryAct_frm extends Action
{
	protected ActionForm buildCircleForm(String hoc,String coc,HttpServletRequest request) throws Exception 
	{
		CircleForm form = null;
		RwsMaster rwsMaster=UrMasterData.getCircle(hoc,coc,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new CircleForm();

				form.setHoc(rwsMaster.getHoc()+" "+rwsMaster.getHon());
				form.setCoc(rwsMaster.getCoc());
				form.setCon(rwsMaster.getCon());
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList circles=null;
		HttpSession session=request.getSession();
		CircleForm frm=(CircleForm) form;
		String mode=frm.getMode();

		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("code",UrMasterData.getCircleCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				//System.out.println(e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
			circles=UrMasterData.getCircleCodes(getDataSource(request));
			session.setAttribute("circles",circles);
			}
			catch(Exception e)
			{
				//System.out.println("The error in Circle View is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setHoc(frm.getHoc());
				rwsMaster.setCoc(frm.getCoc());
				rwsMaster.setCon(frm.getCon());
				
				ans=UrMasterData.insertCircle(rwsMaster,getDataSource(request));
				
				request.setAttribute("code",UrMasterData.getCircleCode(getDataSource(request)));
				
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("the error in Circle Insert is "+e);
			}
			if(ans <1)
			{	if(UrMasterData.errorMessage != null && UrMasterData.errorMessage.length() > 0)
					message = UrMasterData.errorMessage;
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
				form = buildCircleForm(request.getParameter("hoc"),request.getParameter("coc"),request);
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
			 	rwsMaster.setHoc(frm.getHoc().substring(0,frm.getHoc().indexOf(" ")));
				rwsMaster.setCoc(frm.getCoc());
				rwsMaster.setCon(frm.getCon());
				
				ans = UrMasterData.updateCircle(rwsMaster,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Circle edit is "+e);
			}
			if(ans <1)
			{	if(UrMasterData.errorMessage != null && UrMasterData.errorMessage.length() > 0)
					message = UrMasterData.errorMessage;
				else
				message="The record cannot be updated.";
				mode = "get";
			}
			request.setAttribute("message",message);
			
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{	
				int del=UrMasterData.removeCircle(request.getParameter("hoc"),request.getParameter("coc"),getDataSource(request));	
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
				//System.out.println("the error in Circle delete is "+e);
			}
		}
			return(mapping.findForward(mode));
	}

}
