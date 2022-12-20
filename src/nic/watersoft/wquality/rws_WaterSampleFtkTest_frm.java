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

public class rws_WaterSampleFtkTest_frm extends Action
{
public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
{
		int[] ans = new int[5];
		String message=null;
		String displaymess=null;
		ArrayList watersamples=null;
		System.out.println("i am in watersample ftk test execute method");
		//Debug.println("******************** in execute");
		String selectedMonth = request.getParameter("selectedMonth");
		//System.out.println("********************:"+selectedMonth);
		request.setAttribute("selectedMonth",selectedMonth);
		String selectedYear = request.getParameter("selectedYear");
		//System.out.println("@@@@@@@@@@@@@@@@:"+selectedYear);
		request.setAttribute("selectedYear",selectedYear);
		ArrayList watergeotests=new ArrayList();
		ArrayList waterftktests=new ArrayList();
		ArrayList checkedTests=new ArrayList();
		ArrayList empcodes=new ArrayList();	
		Collection geoTests = new ArrayList();
		ArrayList submittedTests=new ArrayList();
		Collection subTests = new ArrayList();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		WaterSampleFtkTestForm waterSampleFtkTest=(WaterSampleFtkTestForm) form;
	//	System.out.println("head::"+waterSampleGeoTest.getHeadOfficeCode());
		String mode=waterSampleFtkTest.getMode();
		HttpSession session=request.getSession();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		RwsWQuality rwsWQuality= new RwsWQuality();
		SampleForwardFtkTests sampleForwardFtkTests =new SampleForwardFtkTests();
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String officeCode=rwsUser.getHeadOfficeCode()+rwsUser.getCircleOfficeCode()+rwsUser.getDivisionOfficeCode()+rwsUser.getSubdivisionOfficeCode();
		//System.out.println("mode in rws_waterSampleGeoTest_frm is "+mode);
		System.out.println("office code:"+officeCode);
		 if(mode.equalsIgnoreCase("data"))
		  {
		   try
		   {
		    //System.out.println("officeCode is in rws_WaterSampleGeoTest_frm="+officeCode);
		    String division = request.getParameter("divisionOfficeCode");
		    String circle = request.getParameter("circleOfficeCode");
		    String division1 = request.getParameter("divisionOfficeCode1");
		    String circle1 = request.getParameter("circleOfficeCode1");
		    String mandal = request.getParameter("mandalCode");
		    String mandal1=request.getParameter("mandalCode1");
		    if(circle==null)
		    {
		     session.removeAttribute("mandals");
		    }
		    
		 //   System.out.println("Circle from Request::"+circle);
//		    System.out.println("Division from Request::"+division);
//		    System.out.println("Circle from Request::"+circle1);
//		    System.out.println("Division from Request::"+division1);
//		    System.out.println("Desg. Name::"+rwsUser.getDesignationName());
		    empcodes=RwsWQualityData.getLabAssistants(getDataSource(request),officeCode);
		    session.setAttribute("empcodes",empcodes);
		    //System.out.println("labAssistants.size()="+empcodes.size());
		 //   System.out.println("hod::"+request.getParameter("headOfficeCode"));
		    String headOfficeCode="1";
		    ArrayList circles = rwsOffices.getCircles(headOfficeCode);
		    ArrayList circles1 = rwsOffices.getCircles(headOfficeCode);
		    
		    session.setAttribute("circles", circles);
		    session.setAttribute("circles1", circles1);
		    
		    Debug.println("circles1:" +circles1);
		    Debug.println("request.getParameter"+ request.getParameter("circleOfficeCode1"));
		    if(request.getParameter("circleOfficeCode1")!=null)
		    {
		    ArrayList mandals1=rwsOffices.getDistrictMandals(request.getParameter("circleOfficeCode1"));
		    session.setAttribute("mandals1",mandals1);
		    } else{
		     session.setAttribute("mandals1",new ArrayList());
		    }
		    
		    
		    //ArrayList divisions = rwsOffices.getDivisions(request.getParameter("headOfficeCode"),request.getParameter("circleOfficeCode"));
		    //ArrayList divisions1 = rwsOffices.getDivisions(request.getParameter("headOfficeCode"),request.getParameter("circleOfficeCode1"));
		    //session.setAttribute("divisions",divisions);
		    //session.setAttribute("divisions1",divisions1);
		   // if(request.getParameter("circleOfficeCode")!=null){
		    //ArrayList mandals=rwsOffices.getDistrictMandals(request.getParameter("circleOfficeCode"));
		    //session.setAttribute("mandals",mandals);
		    //} else{
		     //session.setAttribute("mandals",new ArrayList());
		    //}
		    
		    //waterftktests=RwsWQualityData.getFtkNotForwardedTests(getDataSource(request),officeCode,circle,mandal);
		    
		   /* for (int i=0;i<waterftktests.size();i++)
		    {
		     rwsWQuality = (RwsWQuality)waterftktests.get(i); 
		     geoTests.add(new SampleForwardFtkTests("false",rwsWQuality.getFtktestid(),rwsWQuality.getMandalName(),rwsWQuality.getHabCode(),rwsWQuality.getSourceType(),rwsWQuality.getSourceCode(),rwsWQuality.getFtkTestDate(),rwsWQuality.getForwardDate()));
		    }
		    waterSampleFtkTest.setSamplesForwardToLabs(geoTests);
		    ArrayList subdivisions=rwsOffices.getSubdivisions(rwsUser.getHeadOfficeCode(),rwsUser.getCircleOfficeCode(),rwsUser.getDivisionOfficeCode());
		    session.setAttribute("subdivisions",subdivisions);*/
		    
		    //System.out.println(subdivisions.size()+"");
		    
		    //String ftktestid=request.getParameter("ftktestid");
		    //Debug.println("ftktestid:"+ftktestid);
		    if(selectedYear != null)
		     submittedTests=RwsWQualityData.getFtkForwardedTests(getDataSource(request),officeCode,circle1,mandal1,selectedMonth,selectedYear);
		    
		    for (int i=0;i<submittedTests.size();i++)
		    {
		     rwsWQuality = (RwsWQuality)submittedTests.get(i); 
		     subTests.add(new SampleForwardFtkTests("false",rwsWQuality.getFtktestid(),rwsWQuality.getMandalName(),rwsWQuality.getHabCode(),rwsWQuality.getSourceType(),rwsWQuality.getSourceCode(),rwsWQuality.getFtkTestDate(),rwsWQuality.getForwardDate(),rwsWQuality.getNatureOfTest(),"","","","",""));
		    }
		    
		    waterSampleFtkTest.setResultsSubmittedToSubdivision(subTests);
		    
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
				checkedTests = (ArrayList)waterSampleFtkTest.getSamplesForwardToLabs();
				rwsWQuality.setRoc(officeCode);
				rwsWQuality.setPreparedBy(rwsUser.getUserId());
				rwsWQuality.setPreparedOn(sdf.format(new java.util.Date()));
				ans=RwsWQualityData.insertSampleGeoTestsForward(rwsWQuality,checkedTests,getDataSource(request));
				waterSampleFtkTest.reset(mapping,request);
				
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
				checkedTests = (ArrayList)waterSampleFtkTest.getResultsSubmittedToSubdivision();
				rwsWQuality.setRoc(officeCode);
				rwsWQuality.setPreparedBy(rwsUser.getUserId());
				rwsWQuality.setPreparedOn(sdf.format(new java.util.Date()));
				//System.out.println("calling insertResultsSubmittedToSubdivision()");
				ans=RwsWQualityData.insertResultsSubmittedToSubdivision(rwsWQuality,checkedTests,getDataSource(request));
				waterSampleFtkTest.reset(mapping,request);
				
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
				String ftktestid=request.getParameter("ftktestid");
				Debug.println("ftktestid" +ftktestid);
				session.setAttribute(ftktestid,"ftktestid");
				String sourceCode=request.getParameter("sourceCode");
	            //Debug.println("sourceCode is "+sourceCode);
				//testResults=RwsWQualityData.getTestResults(getDataSource(request),testId);
				testResults=RwsWQualityData.getftkListDetails(getDataSource(request),sourceCode,ftktestid);
				waterSampleFtkTest.setTestResults(testResults);
				//Debug.println("testResults size is "+testResults.size());
				//System.out.println("set to request");
				//session.setAttribute("testResults",testResults);
				request.setAttribute("testResults",testResults);
				 Debug.println("testResults11111111"+testResults.get(0));
				 
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
				waterSampleFtkTest.setTestResults(testResults);
				//System.out.println("testResults size is "+testResults.size());
				//System.out.println("set to request");
				session.setAttribute("testResults",testResults);
			}
			catch(Exception e){System.out.println("Exception in TestResult mode is "+e);}
		}	
		return(mapping.findForward(mode));
	}

}
