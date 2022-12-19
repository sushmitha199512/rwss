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

public class rws_HofficeEntryAct_frm extends Action
{
	

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		int ans = 0;
		String message=null;
		HofficeForm frm=(HofficeForm)form;
		String mode;
		mode=frm.getMode();		 
		
		if(mode.equalsIgnoreCase("data")){
			try
			{			
				request.setAttribute("offices",RwsMasterData.getHoffice(getDataSource(request)));
				request.setAttribute("designations",RwsMasterData.getDesignation(getDataSource(request)));				
				ArrayList datas = RwsMasterData.getHOData(getDataSource(request));
				RwsMaster rwsMaster = null;				
				rwsMaster = (RwsMaster)datas.get(0);
				frm.setOffice(rwsMaster.getOffice());
				frm.setDesignation(rwsMaster.getDesignation());								
			}catch(Exception e){
				System.err.println("The error in rws_HofficeEntryAct_frm in data is "+e);
			}
		}
		if(mode.equalsIgnoreCase("update"))
		{
			/*
			if(frm.getOffice().equals("") || frm.getDesignation().equals("") )
			{
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
					message = RwsMasterData.errorMessage;
					else
					message="U Must Select Office and HeadOffice  ";
			}
			else
			{   */
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {	
			try
				{
				RwsMaster rwsMaster=new RwsMaster();
				rwsMaster.setOffice(frm.getOffice());
				rwsMaster.setDesignation(frm.getDesignation());
				ans=RwsMasterData.UpdateHoffice(rwsMaster,getDataSource(request));
				}
			catch(Exception e)
				{	
					//System.out.println("The error in rws_HofficeEntryAct_frm in Update is:"+e);
				}

				if(ans<1)
					{
					/*if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
					message = RwsMasterData.errorMessage;
					else  */
					message="The Record Cant be Updated   ";
					}
				else
					{
					message="Record Updated Successfully";
					}
			//}//end of empty
		    }
				try
				{
				request.setAttribute("offices",RwsMasterData.getHoffice(getDataSource(request)));
				request.setAttribute("designations",RwsMasterData.getDesignation(getDataSource(request)));
				}catch(Exception e)
				{
					//System.out.println("The error in rws_HofficeEntryAct_frm in Update-->data mode is:"+e);
				}			
			mode="data";
		   }

		   if(mode.equalsIgnoreCase("view"))
		{
			try
			{			session.setAttribute("hoffices",RwsMasterData.getHoffices(getDataSource(request)));
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_HofficeEntryAct_frm in view is "+e);
			}
		}
		return(mapping.findForward(mode));
	}
}
