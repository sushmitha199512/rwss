package nic.watersoft.wquality;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_WaterSampleGeoTest_frm extends Action
{
public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
{
		int[] ans = new int[5];
		String message=null;
		String displaymess=null;
		ArrayList watersamples=null;
		
		String selectedMonth = request.getParameter("selectedMonth");
		//System.out.println("********************:"+selectedMonth);
		request.setAttribute("selectedMonth",selectedMonth);
		String selectedYear = request.getParameter("selectedYear");
		//System.out.println("@@@@@@@@@@@@@@@@:"+selectedYear);
		request.setAttribute("selectedYear",selectedYear);
		ArrayList watergeotests=new ArrayList();
		ArrayList checkedTests=new ArrayList();
		ArrayList empcodes=new ArrayList();	
		Collection geoTests = new ArrayList();
		ArrayList submittedTests=new ArrayList();
		Collection subTests = new ArrayList();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		WaterSampleGeoTestForm waterSampleGeoTest=(WaterSampleGeoTestForm) form;
	//	System.out.println("head::"+waterSampleGeoTest.getHeadOfficeCode());
		String mode=waterSampleGeoTest.getMode();
		HttpSession session=request.getSession();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		RwsWQuality rwsWQuality= new RwsWQuality();
		SampleForwardGeoTests sampleForwardGeoTests =new SampleForwardGeoTests();
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String officeCode=rwsUser.getHeadOfficeCode()+rwsUser.getCircleOfficeCode()+rwsUser.getDivisionOfficeCode()+rwsUser.getSubdivisionOfficeCode();
		//System.out.println("mode in rws_waterSampleGeoTest_frm is "+mode);
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				//System.out.println("officeCode is in rws_WaterSampleGeoTest_frm="+officeCode);
				String division = request.getParameter("divisionOfficeCode");
				String circle = request.getParameter("circleOfficeCode");
				String division1 = request.getParameter("divisionOfficeCode1");
				String circle1 = request.getParameter("circleOfficeCode1");
	//			System.out.println("Circle from Request::"+circle);
//				System.out.println("Division from Request::"+division);
//				System.out.println("Circle from Request::"+circle1);
//				System.out.println("Division from Request::"+division1);
//				System.out.println("Desg. Name::"+rwsUser.getDesignationName());
				empcodes=RwsWQualityData.getLabAssistants(getDataSource(request),officeCode);
				session.setAttribute("empcodes",empcodes);
				//System.out.println("labAssistants.size()="+empcodes.size());
	//			System.out.println("hod::"+request.getParameter("headOfficeCode"));
				String headOfficeCode="1";
				ArrayList circles = rwsOffices.getCircles(headOfficeCode);
				ArrayList circles1 = rwsOffices.getCircles(headOfficeCode);
				session.setAttribute("circles", circles);
				session.setAttribute("circles1", circles1);
				ArrayList divisions = rwsOffices.getDivisions(request.getParameter("headOfficeCode"),request.getParameter("circleOfficeCode"));
				ArrayList divisions1 = rwsOffices.getDivisions(request.getParameter("headOfficeCode"),request.getParameter("circleOfficeCode1"));
				session.setAttribute("divisions",divisions);
				session.setAttribute("divisions1",divisions1);
				watergeotests=RwsWQualityData.getForwardedTests(getDataSource(request),officeCode,rwsUser.getDesignationName(),circle,division);
				for (int i=0;i<watergeotests.size();i++)
				{
					rwsWQuality = (RwsWQuality)watergeotests.get(i);	
					geoTests.add(new SampleForwardGeoTests("false",rwsWQuality.getTestId(),rwsWQuality.getDivisionOfficeName(),rwsWQuality.getLabName(),rwsWQuality.getSampCollectDate(),rwsWQuality.getHabCode(),rwsWQuality.getSourceType(),rwsWQuality.getSourceCode(),rwsWQuality.getTestCode(),rwsWQuality.getSampCollectCode()));
				}
				waterSampleGeoTest.setSamplesForwardToLabs(geoTests);
				ArrayList subdivisions=rwsOffices.getSubdivisions(rwsUser.getHeadOfficeCode(),rwsUser.getCircleOfficeCode(),rwsUser.getDivisionOfficeCode());
				session.setAttribute("subdivisions",subdivisions);
				
				//System.out.println(subdivisions.size()+"");
				
				if(selectedYear != null)
					submittedTests=RwsWQualityData.getTestsSubmittedToSubdivision(getDataSource(request),officeCode,rwsUser.getDesignationName(),selectedMonth,selectedYear,circle1,division1);
				for (int i=0;i<submittedTests.size();i++)
				{
					rwsWQuality = (RwsWQuality)submittedTests.get(i);	
					subTests.add(new SampleForwardGeoTests("false",rwsWQuality.getTestId(),rwsWQuality.getDateAssignedFromDiv(),rwsWQuality.getHabCode(),rwsWQuality.getSourceCode(),rwsWQuality.getTestCode(),rwsWQuality.getForwadedOn(),rwsWQuality.getForwadedTo(),rwsWQuality.getResultObtainOn(),rwsWQuality.getResultForwardOn(),rwsWQuality.getSourceType(),rwsWQuality.getUpdateSource(),rwsWQuality.getRecommendations()));
				}
				waterSampleGeoTest.setResultsSubmittedToSubdivision(subTests);
				
			}
			catch(Exception e)
			{
				//System.out.println("The error in rws_WaterSample_frm data is=  "+e);
			}
		}
		if(mode.equalsIgnoreCase("Forward"))
		{
			try
			{
				checkedTests = (ArrayList)waterSampleGeoTest.getSamplesForwardToLabs();
				rwsWQuality.setRoc(officeCode);
				rwsWQuality.setPreparedBy(rwsUser.getUserId());
				rwsWQuality.setPreparedOn(sdf.format(new java.util.Date()));
				ans=RwsWQualityData.insertSampleGeoTestsForward(rwsWQuality,checkedTests,getDataSource(request));
				waterSampleGeoTest.reset(mapping,request);
				
			}
			
			catch(Exception e)
			{
				//System.out.println("the error is"+e);
			}
			if(ans.length < 0)
			{
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
		
		}
		if(mode.equalsIgnoreCase("Submit"))
		{
			try
			{
				//System.out.println("in submit mode of if");
				checkedTests = (ArrayList)waterSampleGeoTest.getResultsSubmittedToSubdivision();
				rwsWQuality.setRoc(officeCode);
				rwsWQuality.setPreparedBy(rwsUser.getUserId());
				rwsWQuality.setPreparedOn(sdf.format(new java.util.Date()));
				//System.out.println("calling insertResultsSubmittedToSubdivision()");
				ans=RwsWQualityData.insertResultsSubmittedToSubdivision(rwsWQuality,checkedTests,getDataSource(request));
				waterSampleGeoTest.reset(mapping,request);
				
			}
			
			catch(Exception e)
			{
				//System.out.println("the error is"+e);
			}
			if(ans.length < 0)
			{
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
		
		}
		
		if(mode.equalsIgnoreCase("testResult"))
		{
			try
			{
				ArrayList testResults=new ArrayList();
				String testId=request.getParameter("testId");
	//			System.out.println("testId is "+testId);
				testResults=RwsWQualityData.getTestResults(getDataSource(request),testId);
				waterSampleGeoTest.setTestResults(testResults);
				//System.out.println("testResults size is "+testResults.size());
				//System.out.println("set to request");
				session.setAttribute("testResults",testResults);
			}
			catch(Exception e){System.out.println("Exception in TestResult mode is "+e);}
		}
		if(mode.equalsIgnoreCase("testResults"))
		{
			ArrayList updateParameters = new ArrayList();
			try
			{
				ArrayList testResults=new ArrayList();
				String testId=request.getParameter("testId");
				String sourceCode = request.getParameter("sourceCode");
	//			System.out.println("testId is "+testId);
				updateParameters=RwsWQualityData.getWQUpdatTestPCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"),sourceCode);
				ArrayList testIds = new ArrayList();
				for(int i = 0;i<updateParameters.size();i++)
				{
					RwsWQuality ssd = (RwsWQuality)updateParameters.get(i);
					testIds.add(i,ssd.getTestId());					
				}
//				System.out.println("Test ids Size::"+testIds.size());
				session.setAttribute("testids",testIds);
				String sl = RwsWQualityData.getSourceLocation(getDataSource(request),sourceCode);
				if(sl == null)sl = "";
				request.setAttribute("sourceLocation",sl);
				session.setAttribute("updateParameters",updateParameters);
				testResults=RwsWQualityData.getTestResults(getDataSource(request),testId);
				waterSampleGeoTest.setTestResults(testResults);
				//System.out.println("testResults size is "+testResults.size());
				//System.out.println("set to request");
				session.setAttribute("testResults",testResults);
			}
			catch(Exception e){System.out.println("Exception in TestResult mode is "+e);}
		}	
		return(mapping.findForward(mode));
	}

}
