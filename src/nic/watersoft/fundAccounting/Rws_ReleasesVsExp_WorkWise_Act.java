/*
 * Created on Sep 21, 2007
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

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author Santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_ReleasesVsExp_WorkWise_Act  extends Action 
{
	
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
    		if(mode!=null && mode.equals("init"))
	    	{
    			ArrayList releasesVsExpenditureList=broData.getReleasesVsExpenditureList();
    			request.setAttribute("releasesVsExpenditureList",releasesVsExpenditureList);
    			ArrayList releasesVsExpenditureDetaisList=broData.getReleasesVsExpenditureDetailsList();
    			request.setAttribute("releasesVsExpenditureDetailsList",releasesVsExpenditureDetaisList);
    			ArrayList expenditureDetailsList=broData.getExpenditreDetailsListForRelVsExp();
    			request.setAttribute("expenditureDetailsList",expenditureDetailsList);
    			ArrayList expenditureUptoPrevYearList=broData.getExpenditureUptoPrevYearList();
    			request.setAttribute("expenditureUptoPrevYearList",expenditureUptoPrevYearList);
    		}
    		if(mode!=null && mode.equals("officeWiseInit"))
	    	{
    			ArrayList releasesDetailsCircleOfficeWise=broData.getReleasesDetailsCircleOfficeWiseList();
    			//System.out.println("releasesDetailsCircleOfficeWise size is "+releasesDetailsCircleOfficeWise.size());
    			request.setAttribute("releasesDetailsCircleOfficeWise",releasesDetailsCircleOfficeWise);
    			
    			ArrayList releasesDetailsDivisionOfficeWiseList=broData.getReleasesDetailsDivisionOfficeWiseList();
    			//System.out.println("releasesDetailsDivisionOfficeWiseList size is "+releasesDetailsDivisionOfficeWiseList.size());
    			request.setAttribute("releasesDetailsDivisionOfficeWiseList",releasesDetailsDivisionOfficeWiseList);
    			
    			
	    	}
		}catch(Exception e){
			//System.out.println("Exception in Rws_ReleasesVsExp_WorkWise is "+e);}
		}
    			
    			
    	
    	return mapping.findForward(mode);
	}
}
