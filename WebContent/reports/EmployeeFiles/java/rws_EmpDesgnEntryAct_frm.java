package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.masters.EmpMasterData;
import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_EmpDesgnEntryAct_frm extends Action
{
	protected ActionForm buildDesgnForm(String desgnCode,HttpServletRequest request) throws Exception 
	{
		DesgnForm form = null;
		EmpMaster empMaster=EmpMasterData.getDesgn(desgnCode,getDataSource(request));
		
			if(empMaster!=null)
			{
				form = new DesgnForm();

				form.setDesgnCode(empMaster.getDesgnCode());
				form.setDesgnAcr(empMaster.getDesgnAcr());
				form.setDesgnName(empMaster.getDesgnName());
				//System.out.println("DesgnType Value from "+empMaster.getDesgnType()) ;
				form.setDesgnType(empMaster.getDesgnType());
				//System.out.println("DesgnType Value in "+form.getDesgnType()) ;
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
				request.setAttribute("code",EmpMasterData.getDesgnCode(getDataSource(request)));
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
			desgns=EmpMasterData.getDesgns(getDataSource(request));
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
				EmpMaster empMaster = new EmpMaster();
						
				empMaster.setDesgnCode(frm.getDesgnCode());
				empMaster.setDesgnAcr(frm.getDesgnAcr());
				empMaster.setDesgnName(frm.getDesgnName());
				empMaster.setDesgnType(frm.getDesgnType());
							
				ans=EmpMasterData.insertDesgn(empMaster,getDataSource(request));
				
				request.setAttribute("code",EmpMasterData.getDesgnCode(getDataSource(request)));
				
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("the error in Desgn Insert is "+e);
			}
			if(ans <1)
			{	if(EmpMasterData.errorMessage != null && EmpMasterData.errorMessage.length() > 0)
					message = EmpMasterData.errorMessage;
				else
				message="The Record Cant be inserted   ";
			}
			else
			{	message="Record Inserted Successfully";
			}
			request.setAttribute("message",message);
		}
		if(mode.equalsIgnoreCase("Update"))
		{
			try
			{
				EmpMaster empMaster = new EmpMaster();
						
				empMaster.setDesgnCode(frm.getDesgnCode());
				empMaster.setDesgnAcr(frm.getDesgnAcr());
				empMaster.setDesgnName(frm.getDesgnName());
				empMaster.setDesgnType(frm.getDesgnType());
							
				ans=EmpMasterData.updateDesgn(empMaster,getDataSource(request));
				
				request.setAttribute("code",EmpMasterData.getDesgnCode(getDataSource(request)));
				
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("the error in Desgn Update is "+e);
			}
			if(ans <1)
			{	if(EmpMasterData.errorMessage != null && EmpMasterData.errorMessage.length() > 0)
					message = EmpMasterData.errorMessage;
				else
				message="The Record Cant be Updated   ";
			}
			else
			{	message="Record Updated Successfully";
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
				EmpMaster empMaster = new EmpMaster();
						
				empMaster.setDesgnCode(frm.getDesgnCode());
				empMaster.setDesgnAcr(frm.getDesgnAcr());
				empMaster.setDesgnName(frm.getDesgnName());
				empMaster.setDesgnType(frm.getDesgnType());
				
				ans = EmpMasterData.updateDesgn(empMaster,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Desgn edit is "+e);
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
			int del=0;
			try 
			{	
				del=EmpMasterData.removeDesgn(request.getParameter("desgnCode"),getDataSource(request));	
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
