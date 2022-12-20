/*
 * Created on Aug 6, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_BroLocDetails_rpt extends Action 
{
	
    public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest 
			request,HttpServletResponse response)
	{
    	HttpSession session=request.getSession();
    	Rws_BroLocDetails_rpt_Form frm=(Rws_BroLocDetails_rpt_Form)form;
    	Rws_BroData broData=new Rws_BroData(getDataSource(request));
    	String mode=request.getParameter("mode");
    	//String target="success";
    	ArrayList emptyList=new ArrayList(0);
    	
    	//System.out.println("mode is "+mode);
    	try
		{
    		if(mode!=null && mode.equals("getBroList_frm"))
	    	{
    			
    			ArrayList financialYearsList=broData.getBroFinancialYearsList();
    			request.setAttribute("financialYearsList",financialYearsList);
	    	}
    		if(mode!=null && mode.equals("getBroList_frm_view"))
	    	{
    			
    			ArrayList financialYearsList=broData.getBroFinancialYearsList();
    			request.setAttribute("financialYearsList",financialYearsList);
    			
    			ArrayList broList=broData.getBroList(request.getParameter("bro_financialYear"));
    			request.setAttribute("broList",broList);
    			ArrayList broProgList=broData.getBroProgDetails();
    			request.setAttribute("broProgList",broProgList);
    			
	    	}
    		if(mode!=null && mode.equals("getBroList"))
	    	{
    			
    			ArrayList broList=broData.getBroList();
    			request.setAttribute("broList",broList);
    			ArrayList broProgList=broData.getBroProgDetails();
    			request.setAttribute("broProgList",broProgList);
	    	}
    		if(mode!=null && mode.equals("getLocList"))
	    	{
    			
    			ArrayList locList=broData.getLocProgDetailsForRpt(request.getParameter("broId"),"100000");
    			request.setAttribute("locList",locList);
    			request.setAttribute("broId",request.getParameter("broId"));
    			request.setAttribute("toDisplay","LOC");
	    	}
    		if(mode!=null && mode.equals("getCircleLocList"))
	    	{
    			
    			ArrayList locList=broData.getCircleLocProgDetailsForRpt(request.getParameter("broId"),request.getParameter("locId"));
    			request.setAttribute("locList",locList);
    			request.setAttribute("broId",request.getParameter("broId"));
    			request.setAttribute("toDisplay","CLOC");
	    	}
    		if(mode!=null && mode.equals("getProjectLocList"))
	    	{
    			
    			ArrayList locList=broData.getProjectLocListForRpt(request.getParameter("broId"),request.getParameter("locId"));
    			request.setAttribute("locList",locList);
    			request.setAttribute("broId",request.getParameter("broId"));
    			request.setAttribute("toDisplay","PLOC");
	    	}
    		
		}catch(Exception e){
			//System.out.println("Exception in Rws_BroLocDetails_rpt is "+e);}
		}
		
		return mapping.findForward(mode);
	}
}