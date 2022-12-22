package nic.watersoft.masters;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import nic.watersoft.commons.Debug;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_EmpQualEntryAct_frm extends Action
{
	protected ActionForm buildQualForm(String qualCode,HttpServletRequest request) throws Exception 
	{
		QualForm form = null;
		EmpMaster EmpMaster=EmpMasterData.getQual(qualCode,getDataSource(request));
		
			if(EmpMaster!=null)
			{
				form = new QualForm();

				form.setQualCode(EmpMaster.getQualCode());
				form.setQualName(EmpMaster.getQualName());
				
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList quals=null;
		QualForm frm=(QualForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();

		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("qcode",EmpMasterData.getQualCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				//System.out.println("the error in qcode is "+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				quals=EmpMasterData.getQuals(getDataSource(request));
				session.setAttribute("quals",quals);
			}
			catch(Exception e)
			{
				System.err.println(e);
			}
			
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				//System.out.println("in the Save Part of Qual "+mode );
				EmpMaster EmpMaster = new EmpMaster();
						
				EmpMaster.setQualCode(frm.getQualCode());
				EmpMaster.setQualName(frm.getQualName());
				
				ans=EmpMasterData.insertQual(EmpMaster,getDataSource(request));
	
				request.setAttribute("qcode",EmpMasterData.getQualCode(getDataSource(request)));

				frm.reset(mapping,request);
				
			}
			catch(SQLException e)
			{
				//System.out.println("the error is"+e);
			}
			catch(Exception e)
			{
				//System.out.println("the error is"+e);
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
				form = buildQualForm(request.getParameter("qualCode"),request);
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
				//System.out.println("the error is Get Qual is "+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				EmpMaster EmpMaster = new EmpMaster();
					
				EmpMaster.setQualCode(frm.getQualCode());
				EmpMaster.setQualName(frm.getQualName());
				
				ans = EmpMasterData.updateQual(EmpMaster,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error is Edit Qual is "+e);
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
			ans=EmpMasterData.removeQual(request.getParameter("qualCode"),getDataSource(request));
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
			//System.out.println("the error in removeQual is "+e);	
		}
	}	
		return(mapping.findForward(mode));
	}
}
