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

public class ur_SubDivisionEntryAct_frm extends Action
{
	protected ActionForm buildSubDivisionForm(String hoc,String coc,String doc,String sdoc,HttpServletRequest request) throws Exception 
	{
		SubDivisionForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getUrbanSubDivision(hoc,coc,doc,sdoc,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new SubDivisionForm();

				form.setHoc(rwsMaster.getHoc()+" "+rwsMaster.getHon());
				form.setCoc(rwsMaster.getCoc()+" "+rwsMaster.getCon());
				form.setDoc(rwsMaster.getDoc()+" "+rwsMaster.getDon());
				form.setSdoc(rwsMaster.getSdoc());
				form.setSdon(rwsMaster.getSdon());
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList subdivisions=null;
		ArrayList mandalsubdivisions=null;
		ArrayList circles=null;
		ArrayList divcodes=new ArrayList();
		HttpSession session=request.getSession();
		
		SubDivisionForm frm=(SubDivisionForm) form;
		String mode=frm.getMode();
		
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				circles=rwsOffices.getUrbanCircles("2");
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equals("00"))
					{
						divcodes = rwsOffices.getUrbanDivisions("2",request.getParameter("coc"));
					}
				}
				if(request.getParameter("doc")!=null)
				{
					if(!(request.getParameter("doc")).equals("0"))
					{
						request.setAttribute("code",RwsMasterData.getUrbanSubDivisionCode("2",request.getParameter("coc"),request.getParameter("doc"),getDataSource(request)));
					}
				}
				session.setAttribute("circles",circles);
				session.setAttribute("divcodes",divcodes);
			}
			catch(Exception e)
			{
				//System.out.println("The code in SubDivision action data "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
			//System.out.println("coc="+request.getParameter("coc")+"coc1="+frm.getCoc()+"doc="+request.getParameter("doc")+"doc1="+frm.getDoc());
			String coc=frm.getCoc();
			if(coc.indexOf(" ")!=-1)
				coc=coc.substring(0,2);
			String doc=frm.getDoc();
			if(doc.indexOf(" ")!=-1)
				doc=doc.substring(0,1);
			//System.out.println("circle code="+coc+"division code="+doc);
			subdivisions=RwsMasterData.getUrbanSubDivisions(getDataSource(request),coc,doc);
			session.setAttribute("subdivisions",subdivisions);
			}
			catch(Exception e)
			{
				//System.out.println("The error in SubDivision View is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("getmandals"))
		{
			try
			{
			//System.out.println("coc="+request.getParameter("coc")+"doc="+request.getParameter("coc")+"sdoc="+request.getParameter("sdoc")+"sdon="+request.getParameter("sdon"));
			session.setAttribute("sdon",request.getParameter("sdon"));	
			mandalsubdivisions=RwsMasterData.getUrbanMandalSubDivisions(getDataSource(request),request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"));
			session.setAttribute("mandalsubdivisons",mandalsubdivisions);
			}
			catch(Exception e)
			{
				//System.out.println("The error in getMandals is "+e);
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
				rwsMaster.setSdon(frm.getSdon());
				
				ans=RwsMasterData.insertUrbanSubDivision(rwsMaster,getDataSource(request));
				
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("the error in SubDivision Insert is "+e);
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
				form = buildSubDivisionForm("2",request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request);
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
				//System.out.println("the error in SubDivision get is "+e);
			}
		
	}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setHoc(frm.getHoc().substring(0,frm.getHoc().indexOf(" ")));
				rwsMaster.setCoc(frm.getCoc().substring(0,frm.getCoc().indexOf(" ")));
				rwsMaster.setDoc(frm.getDoc().substring(0,frm.getDoc().indexOf(" ")));
				rwsMaster.setSdoc(frm.getSdoc());
				rwsMaster.setSdon(frm.getSdon());
				
				ans = RwsMasterData.updateUrbanSubDivision(rwsMaster,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error in SubDivision edit is "+e);
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
				int del=RwsMasterData.removeUrbanSubDivision("1",request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request));	
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
				//System.out.println("the error in SubDivision delete is "+e);
			}
		}
			return(mapping.findForward(mode));
	}

}
