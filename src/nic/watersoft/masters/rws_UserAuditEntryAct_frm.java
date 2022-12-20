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

//import nic.watersoft.commons.Debug;

public class rws_UserAuditEntryAct_frm extends Action
{
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException,NumberFormatException
	{
		
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList tslimits=null;
		RwsMaster rwsMaster=null;
		HttpSession session=request.getSession(); 
		UserAuditForm frm=(UserAuditForm) form;
		String mode;//=frm.getMode();
		String fromDate;
		mode=request.getParameter("mode");
		//System.out.println("mode issssssssssss" +mode);

		if(mode.equalsIgnoreCase("data2"))
		{		
			try
			{	
				if(request.getParameter("user")!=null)
				{
					//System.out.println("Started the users in Action");
					String usr=request.getParameter("user");	
					request.setAttribute("users",RwsMasterData.getUsers(getDataSource(request)));
					frm.setUser(usr);
					//System.out.println("User:"+usr);
					
				}
				else	   
				{ 
					//System.out.println("Started the ----> user in Action else");  
					request.setAttribute("users",RwsMasterData.getUsers(getDataSource(request)));
					//System.out.println("Ended the ----> users in Action else ");  
				}
			}catch(Exception e)
			{
				//System.out.println("Error in rws_UserAuditEntryAct_frm in data2 mode:"+e);
			}
		}//close data
		
		if(mode.equalsIgnoreCase("data"))
		{	
			 String usr=request.getParameter("user");
			 usr=frm.getUser();
			//System.out.println("userrrrrrrr:"+usr);
			String frdt=request.getParameter("fromDate");
			frdt=frm.getFromDate();
			try
			{	
			   if(request.getParameter("fromDate")!=null)
				{
				//System.out.println("Started the fromDate in Action");
					
				request.setAttribute("users",RwsMasterData.getUsers(getDataSource(request)));
				frm.setUser(usr);
					
				request.setAttribute("fromdates",RwsMasterData.getFromDates(usr,getDataSource(request)));
			    frm.setFromDate(frdt);
	            
				//request.setAttribute("todates",RwsMasterData.getToDates(usr,frdt,getDataSource(request)));
				//System.out.println("Ended the fromDate-->toDate in Action:");
				
				//mode="data1";
				
				}
			
				else	   
				{ 
				//System.out.println("Started the ----> fromDate in Action"); 
				request.setAttribute("users",RwsMasterData.getUsers(getDataSource(request)));
				frm.setUser(usr);
				request.setAttribute("fromdates",RwsMasterData.getFromDates(usr,getDataSource(request)));
				frm.setFromDate(frdt);
				/*
				 ArrayList fromDate=new ArrayList();
				 rwsMaster = (RwsMaster)fromDate.get(0);
				 frm.setFromDate(rwsMaster.getFromDate()); */
				 //System.out.println("Ended the ----> fromDate Action ");  
				}
			}catch(Exception e)
			{
				//System.out.println("Error in rws_UserAuditEntryAct_frm in data mode:"+e);
			}
		}//close data


		if(mode.equalsIgnoreCase("data1"))
		{	
			 String usr=request.getParameter("user");
			 usr=frm.getUser();
			//System.out.println("userrrrrrrr:"+usr);
			String frdt=request.getParameter("fromDate");
			frdt=frm.getFromDate();
			try
			{	
			   if(request.getParameter("fromDate")!=null)
				{
				//System.out.println("Started the fromDate in Action");
					
				request.setAttribute("users",RwsMasterData.getUsers(getDataSource(request)));
				frm.setUser(usr);
					
				request.setAttribute("fromdates",RwsMasterData.getFromDates(usr,getDataSource(request)));
			    frm.setFromDate(frdt);
	            
				request.setAttribute("todates",RwsMasterData.getToDates(usr,frdt,getDataSource(request)));
				//System.out.println("Ended the fromDate-->toDate in Action:");
				}
			
				else	   
				{ 
				//System.out.println("Started the ----> fromDate in Action"); 
				request.setAttribute("users",RwsMasterData.getUsers(getDataSource(request)));
				frm.setUser(usr);
				request.setAttribute("fromdates",RwsMasterData.getFromDates(usr,getDataSource(request)));
				frm.setFromDate(frdt);
				/*
				 ArrayList fromDate=new ArrayList();
				 rwsMaster = (RwsMaster)fromDate.get(0);
				 frm.setFromDate(rwsMaster.getFromDate()); */
				 //System.out.println("Ended the ----> fromDate Action ");  
				}
			}catch(Exception e)
			{
				//System.out.println("Error in rws_UserAuditEntryAct_frm in data mode:"+e);
			}
		}//close data

		if(mode.equalsIgnoreCase("view"))
		{
			try
			{	

				//System.out.println("Started the ----> View in Action");  
				rwsMaster=new RwsMaster();
				nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(getDataSource(request));
				rwsMaster.setFromDate(frm.getFromDate());
				rwsMaster.setToDate(frm.getToDate());	
				rwsMaster.setUserid(frm.getUser());
				//System.out.println("in view userid is"+rwsMaster.getUserid());
				request.setAttribute("useraudits",RwsMasterData.getUserAudit(rwsMaster,getDataSource(request)));
				
				String circleOfficeName="";
				if(!request.getParameter("user").equals("00"))
					circleOfficeName=rwsOffices.getCircleOfficeName(getDataSource(request),request.getParameter("user").substring(0,1),request.getParameter("user").substring(1,3));
				else
					circleOfficeName="ALL";
				//System.out.println("circleOfficeName is "+circleOfficeName);
				request.setAttribute("circleOfficeName",circleOfficeName);
				
				mode="view";
				//System.out.println("Ended the ----> View in Action"+mode);
			//System.out.println("Ended ATLASTTTTTT");
			}catch(Exception e)
			{
				//System.out.println("Error in rws_UserAuditEntryAct_frm in view mode:"+e);
			}
		}//close view
		return mapping.findForward(mode);
	}
}