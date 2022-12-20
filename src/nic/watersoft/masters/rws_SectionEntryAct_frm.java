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

public class rws_SectionEntryAct_frm extends Action
{
	protected ActionForm buildSectionForm(String hoc,String coc,String doc,String sdoc,String soc,HttpServletRequest request) throws Exception 
	{
		SectionForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getSection(hoc,coc,doc,sdoc,soc,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new SectionForm();

				form.setHoc(rwsMaster.getHoc());
				form.setCoc(rwsMaster.getCoc());
				form.setDoc(rwsMaster.getDoc());
				form.setSdoc(rwsMaster.getSdoc());
				form.setSoc(rwsMaster.getSoc());
				form.setSon(rwsMaster.getSon());
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList subdivs=new ArrayList();
		ArrayList circles=new ArrayList();
		ArrayList sections=new ArrayList();
		ArrayList divcodes=new ArrayList();
		HttpSession session=request.getSession();
		
		SectionForm frm=(SectionForm) form;
		String mode=frm.getMode();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				circles=rwsOffices.getCircles("1");
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equals("00"))
					{
						divcodes = rwsOffices.getDivisions("1",request.getParameter("coc"));
					}
				}
				if(request.getParameter("doc")!=null)
				{
					if(!(request.getParameter("doc")).equals("0"))
					{
						subdivs=rwsOffices.getSubdivisions("1",request.getParameter("coc"),request.getParameter("doc"));
					}
				}
				if(request.getParameter("sdoc")!=null)
				{
					//System.out.println("before ="+request.getParameter("sdoc"));
					if(!(request.getParameter("sdoc")).equals("0"))
					{
						//System.out.println("after ");
						request.setAttribute("code",RwsMasterData.getSectionCode("1",request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));
					}
				}
				session.setAttribute("circles",circles);
				session.setAttribute("divcodes",divcodes);
				session.setAttribute("subdivs",subdivs);
			}
			catch(Exception e)
			{
				//System.out.println("The code in Section action data"+e);
			}
	}
		
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
			sections=RwsMasterData.getSections(getDataSource(request));
			session.setAttribute("sections",sections);
			}
			catch(Exception e)
			{
				//System.out.println("The error in Section View is "+e);
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
				rwsMaster.setSdoc(frm.getSdoc());
				rwsMaster.setSoc(frm.getSoc());
				rwsMaster.setSon(frm.getSon());
				
				ans=RwsMasterData.insertSection(rwsMaster,getDataSource(request));
				
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("the error in Section Insert is "+e);
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
				form = buildSectionForm("1",request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("soc"),request);
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
				//System.out.println("the error in Section get is "+e);
			}
		
	}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setHoc(frm.getHoc());
				rwsMaster.setCoc(frm.getCoc());
				rwsMaster.setDoc(frm.getDoc());
				rwsMaster.setSdoc(frm.getSdoc());
				rwsMaster.setSoc(frm.getSoc());
				rwsMaster.setSon(frm.getSon());
				
				RwsMasterData.updateSection(rwsMaster,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Section edit is "+e);
			}
			
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{	
				int del=RwsMasterData.removeSection("1",request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("soc"),getDataSource(request));	
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
				//System.out.println("the error in Section delete is "+e);
			}
		}
			return(mapping.findForward(mode));
	}

}
