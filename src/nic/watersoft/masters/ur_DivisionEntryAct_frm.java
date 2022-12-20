package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ur_DivisionEntryAct_frm extends Action
{
	protected ActionForm buildDivisionForm(String hoc,String coc,String doc,HttpServletRequest request) throws Exception 
	{
		DivisionForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getUrbanDivision(hoc,coc,doc,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new DivisionForm();

				form.setHoc(rwsMaster.getHoc()+" "+rwsMaster.getHon());
				form.setCoc(rwsMaster.getCoc()+" "+rwsMaster.getCon());
				form.setDoc(rwsMaster.getDoc());
				form.setDon(rwsMaster.getDon());
				form.setDivStatus(rwsMaster.getDivStatus());
				 
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList divisions=null;
		ArrayList circles=new ArrayList();
		
		HttpSession session=request.getSession();
		
		DivisionForm frm=(DivisionForm) form;
		String mode=frm.getMode();

		if(mode.equalsIgnoreCase("data"))
		{
			try
			{	
				//circles=RwsMasterData.getCircleCodes("1",getDataSource(request));
				RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
				circles=rwsOffices.getUrbanCircles("2");
				session.setAttribute("circles",circles);
				request.setAttribute("code",RwsMasterData.getUrbanDivisionCode(request.getParameter("hoc"),request.getParameter("coc"),getDataSource(request)));
				
			}
			catch(Exception e)
			{
				//System.out.println("The error in Division inc is "+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				//System.out.println("coc="+request.getParameter("coc")+"coc1="+frm.getCoc());
				String coc=frm.getCoc();
				if(coc.indexOf(" ")!=-1)
					coc=coc.substring(0,2);
				divisions=RwsMasterData.getUrbanDivisions(getDataSource(request),coc);
				session.setAttribute("divisions",divisions);
			}
			catch(Exception e)
			{
				//System.out.println("The error in Division View is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setHoc(frm.getHoc());
				rwsMaster.setCoc(frm.getCoc());
				rwsMaster.setDoc(frm.getDoc());
				rwsMaster.setDon(frm.getDon());
				rwsMaster.setDivStatus(frm.getDivStatus());
				ans=RwsMasterData.insertUrbanDivision(rwsMaster,getDataSource(request));
				
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("the error in Division Insert is "+e);
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
				form = buildDivisionForm(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"),request);
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
				//System.out.println("the error in Division get is "+e);
			}
		
	}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setHoc(frm.getHoc().substring(0,frm.getHoc().indexOf(" ")));
				rwsMaster.setCoc(frm.getCoc().substring(0,frm.getCoc().indexOf(" ")));
				rwsMaster.setDoc(frm.getDoc());
				System.out.println("Sataus:"+frm.getDivStatus());
				
				rwsMaster.setDon(frm.getDon());
				
				ans = RwsMasterData.updateUrbanDivision(rwsMaster,getDataSource(request),frm.getDivStatus());
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Division edit is "+e);
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
			try 
			{	
				int del=RwsMasterData.removeUrbanDivision(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"),getDataSource(request));	
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
				//System.out.println("the error in Division delete is "+e);
			}
		}
			return(mapping.findForward(mode));
	}

}
