package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_HeadEntryAct_frm extends Action
{	
	ArrayList headdetails=new ArrayList();
	protected ActionForm buildHeadForm(String hoc,HttpServletRequest request) throws Exception 
	{
		HeadForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getHead(hoc,getDataSource(request));		
			if(rwsMaster!=null)
			{
				form = new HeadForm();
				form.setHoc(rwsMaster.getHoc());
				form.setHon(rwsMaster.getHon());		
				form.setHoName(rwsMaster.getHoName());				
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{		
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}			
		String message=null;
		String displaymess=null;	
		HeadForm frm=(HeadForm) form;
		String mode=frm.getMode();
		if(mode.equalsIgnoreCase("data")){
			try{
				request.setAttribute("hcode",RwsMasterData.getHeadCode(getDataSource(request)));
			}catch(Exception e){
				System.out.println("The error in Head View is "+e);
			}
		}
		if(mode.equalsIgnoreCase("view")){
			try{
				RwsMasterData rwsMasterData=new RwsMasterData();
				headdetails=RwsMasterData.getHeaddetails(getDataSource(request));				
				session.setAttribute("headdetails",headdetails);
				frm.setHeaddetails(headdetails);
			}catch(Exception e){
				System.out.println("The error in Head View is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("Save")){
			try{	
				 session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {	
					RwsMaster rwsMaster = new RwsMaster();						
					rwsMaster.setHoc(frm.getHoc());
					rwsMaster.setHon(frm.getHon());			
					rwsMaster.setHoName(frm.getHoName());
					rwsMaster.setHoImage(frm.getHoImage());
					String targetPath = getServlet().getServletContext().getRealPath("")  + "temp.jpg";			
					message=RwsMasterData.insertHead(rwsMaster,getDataSource(request),targetPath,getServlet());
					request.setAttribute("hcode",RwsMasterData.getHeadCode(getDataSource(request)));				
					frm.reset(mapping,request);				
					request.setAttribute("message",message);
					mode="Save";
			     }
			}catch(Exception e)	{
				System.out.println("the error in Head Insert is "+e);
			}	
		}
		if(mode.equalsIgnoreCase("get")){
			try {
				form = buildHeadForm(request.getParameter("hoc"),request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				}
				else {	
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{				
				System.out.println("the error in Head get is "+e);
			}
		
	}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{	
				 session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {	
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setHoc(frm.getHoc());
					rwsMaster.setHon(frm.getHon());                
					rwsMaster.setHoName(frm.getHoName());				
					rwsMaster.setHoImage(frm.getHoImage());
					String targetPath = getServlet().getServletContext().getRealPath("") + "temp.jpg";					
					message = RwsMasterData.updateHead(rwsMaster,getDataSource(request),targetPath,getServlet());
					mode="data";
			     }
			}catch(Exception e) 
			{	
				System.out.println("the error in Head edit is "+e);
			}
			if(!message.equals("Officer Details Updated Successfully"))			
				mode = "get";			
			request.setAttribute("message",message);			
		}		
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{	
				int del=RwsMasterData.removeHead(request.getParameter("hoc"),getDataSource(request));	
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
				//System.out.println("the error in Head delete is "+e);
			}
		}
			return(mapping.findForward(mode));
	}
}
