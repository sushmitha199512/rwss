package nic.watersoft.masters;

//import java.util.List;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
//import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class rws_EmployeeSearch_Act extends Action
{
	
	protected ActionForm buildEmpDesgnForm(String empcode,String mode,HttpServletRequest request) throws Exception
	{
		HttpSession session=request.getSession();
		RwsOffices rwsOffices=new RwsOffices();
		nic.watersoft.masters.EmpForm form=new nic.watersoft.masters.EmpForm();
		try
		{			
			//form=new EmpSearchForm();
			//System.out.println("in Try lock");
						
		}catch(Exception e)
		{
			//System.out.println("Error in BuildDesignForm  "+e);
		}
	
		return form;
	}
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		ArrayList zonecodes=new ArrayList();
		ArrayList desgns=new ArrayList();
		ArrayList heads=new ArrayList();
		ArrayList emps=new ArrayList();		
		String message=null;
		ArrayList circles=null;
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = new EmpMaster();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		EmpSearchForm frm=(EmpSearchForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		if(user==null)
		return mapping.findForward("expire");	
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}
		
				
		if(mode.equalsIgnoreCase("EmployeeList"))
		{
			try{
			if(request.getParameter("mode1")!=null && request.getParameter("mode1").equals("init")){
			 resetFrm(frm);
			}
			heads = rwsOffices.getHeads(); 
			session.setAttribute("heads",heads); 
			circles=rwsOffices.getCircles();
			session.setAttribute("circles",circles);
	
			desgns=EmpMasterData.getDesgns1(frm.getDesig(),frm.getCircleOfficeCode());
			session.setAttribute("desgns",desgns); 

			
			zonecodes=EmpMasterData.getZones();
			session.setAttribute("zonecodes",zonecodes); 
			}catch(Exception e)  
			{
				System.out.println("Error in Mode EmployeeList  "+e);
			}
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{ 
				//System.out.println("empcode"+request.getParameter("empcode"));
				
				form =(EmpForm)buildEmpDesgnForm(request.getParameter("empcode"),mode,request);
				
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
				////System.out.println("the error in Emp get is = "+e);
			}
		}
		  
		if(mode.equalsIgnoreCase("view"))
		{
			try 
			{	
				EmpSearchForm empSearchForm=new EmpSearchForm();
				empSearchForm.setDesig(frm.getDesig());
				empSearchForm.setDesgnCode(frm.getDesgnCode());
				empSearchForm.setHoc(frm.getHoc());
				empSearchForm.setZone(frm.getZone());
				String empcode=request.getParameter("empcode");
				//System.out.println("empcode:"+empcode);
				emps=EmpMasterData.getEmpsSearch(frm.getHoc(),frm.getCircleOfficeCode(),frm.getZone(),frm.getDesig(),frm.getDesgnCode(),empcode);
				//System.out.println("emps:"+emps.size());
				session.setAttribute("emps",emps);
				
				//////System.out.println("EMPS "+emps);
				} 
				 
			catch(Exception e)
			{
				////System.out.println("The error in Emp View is "+e);
			}
		}
		if(mode.equalsIgnoreCase("Insert New Record"))
		{
		 mode="Insert";
		}
		 
		
		////System.out.println("The Mode Returned SEARCH FORM "+mode);
		return(mapping.findForward(mode));
	}
    public void resetFrm(EmpSearchForm frm){
    	frm.setCircleOfficeCode("");
    	frm.setDesgnName("");
    	frm.setDesig("");
    	frm.setDesgnCode("");
    }
	
} 
