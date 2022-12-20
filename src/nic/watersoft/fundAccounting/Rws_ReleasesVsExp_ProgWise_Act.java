/*
 * Created on Nov 12, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import nic.watersoft.commons.Debug;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_ReleasesVsExp_ProgWise_Act extends Action{
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest 
			request,HttpServletResponse response)
	{
    	HttpSession session=request.getSession();
    	Rws_ReleasesVsExp_WorkWise_Form frm=(Rws_ReleasesVsExp_WorkWise_Form)form;
    	Rws_BroData broData=new Rws_BroData(getDataSource(request));
    	String mode=request.getParameter("mode");
    	//String target="success";
    	ArrayList emptyList=new ArrayList(0);
    	
    	//System.out.println("mode is "+mode);
    	try
		{
    		if(mode!=null && (mode.equals("init")||mode.equals("ProgWiseDrillFrm")))
	    	{
    			ArrayList programmesList=broData.getReleasesVsExpenditureProgrammesList();
    			request.setAttribute("programmesList",programmesList);
    			ArrayList financialYearsList=broData.getReleasesVsExpenditureYearsList();
    			request.setAttribute("financialYearsList",financialYearsList);
	    	}
    		if(mode!=null && mode.equals("getProgWiseRpt"))
	    	{
    			ArrayList releasesVsExpProgWiseList=broData.getReleasesVsExpenditureProgWiseList(request.getParameter("fromYear"),request.getParameter("programme"));
    			request.setAttribute("releasesVsExpProgWiseList",releasesVsExpProgWiseList);
    			
	    	}
    		if(mode!=null && mode.equals("getProgWiseDrillRpt"))
	    	{
    			ArrayList releasesVsExpProgWiseList=broData. getReleasesVsExpenditureProgWiseDrill(request.getParameter("fromYear"));
    			request.setAttribute("releasesVsExpProgWiseList",releasesVsExpProgWiseList);
    			
	    	}
    		if(mode!=null && mode.equals("getProgWiseReleasesRpt"))
	    	{
    			ArrayList releasesProgWiseList=broData.getReleasesDetails(request.getParameter("fromYear"),request.getParameter("programme"));
    			request.setAttribute("releasesProgWiseList",releasesProgWiseList);
    			
	    	}
    		
		}
    	catch(Exception e){
    		//System.out.println("Exception in Rws_ReleasesVsExp_ProgWise_Act is "+e);}
    	}
    	
    	return mapping.findForward(mode);
	}
	
    	
}
