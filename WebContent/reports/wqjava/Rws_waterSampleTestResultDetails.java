package nic.watersoft.wquality;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_waterSampleTestResultDetails extends Action
{
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList watersampleres=new ArrayList();
		Collection waterLabTests = new ArrayList();
		Collection parameters = new ArrayList();
		ArrayList testParams = new ArrayList();
		ArrayList updateParameters=new ArrayList();
		ArrayList testParameters=new ArrayList();
		ArrayList testDetails=new ArrayList();
				
		HttpSession session=request.getSession();
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String testId=(String)request.getAttribute("testId");
		WaterSampleResForm waterSampleResForm=(WaterSampleResForm) form;
		String mode=waterSampleResForm.getMode();
		String circle="",division="";

		if(mode.equalsIgnoreCase("testResultDetails"))
		{
			try
			{
				waterLabTests=RwsWQualityData.getWQLabTests(getDataSource(request),rwsUser.getUserId(),circle,division);
				waterSampleResForm.setWqLabTests(waterLabTests);
			}
			catch(Exception e)
			{
				System.out.println("The error in data is rws_WaterTestResultDetails is  "+e);
			}
			
		}
	return mapping.findForward(mode);
	}
}