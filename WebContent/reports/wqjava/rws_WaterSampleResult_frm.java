package nic.watersoft.wquality;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_WaterSampleResult_frm extends Action
{
	protected ActionForm buildWaterSampleResForm(String testId,HttpServletRequest request) throws Exception 
	{
//		System.out.println("in buildWaterSampleResForm");
		WaterSampleResForm waterSampleResForm = null;
		Collection watersampleres = new ArrayList();
		Collection parameters = new ArrayList();
		HttpSession session=request.getSession();
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		watersampleres=RwsWQualityData.getWQLabTest(getDataSource(request),rwsUser.getUserId(),testId);
	//	System.out.println("water samples size in action::"+watersampleres.size());
		
		session.setAttribute("watersampleres",watersampleres);
		ArrayList aa = new ArrayList();
		RwsWQuality rwsWQuality=RwsWQualityData.getWaterSampleResult(getDataSource(request),testId);
			if(rwsWQuality!=null)
			{
	//			System.out.println("in side if loop::"+rwsWQuality.getRecommendations());
				waterSampleResForm = new WaterSampleResForm();
				waterSampleResForm.setWqLabTests(watersampleres);
				waterSampleResForm.setRecommendations(rwsWQuality.getRecommendations());
				waterSampleResForm.setCondemnSource(rwsWQuality.getCondemnSource());      
				waterSampleResForm.setUpdateSource(rwsWQuality.getUpdateSource());  
				waterSampleResForm.setForwadedOn(rwsWQuality.getForwadedOn());   		
			}
			return waterSampleResForm;
	}


	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws Exception
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList watersampleres=new ArrayList();
		Collection waterLabTests = new ArrayList();
		Collection parameters = new ArrayList();
		ArrayList testParams = new ArrayList();
		ArrayList updateParameters=new ArrayList();
		ArrayList waterPtestUpdateList=new ArrayList();
				
		HttpSession session=request.getSession();
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		WaterSampleResForm waterSampleResForm=(WaterSampleResForm) form;
		String mode=waterSampleResForm.getMode();
	//	System.out.println("mode in rws_WaterSampleResult_frm= "+mode);
		String sourceCode = request.getParameter("sourceCode");
		if(mode.equalsIgnoreCase("doNothing"))
		{
			java.util.Date date=new java.util.Date();
           long now=date.getTime();
          // response.setHeader("Expires",(now-(1000*60*60))+"");
           response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
           response.setHeader("Pragma","no-cache"); //HTTP 1.0
           response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

          
			response.setContentType("text/html/XML");
			java.io.PrintWriter out=response.getWriter();
	 	     out.println("</>ok</>");
	 	     out.flush();
			return mapping.findForward(mode);
		}
		if(mode.equalsIgnoreCase("data"))
		{
	//		System.out.println("in data mode");
			try
			{
				String circle = waterSampleResForm.getCircleOfficeCode();
				String division = waterSampleResForm.getDivisionOfficeCode();
	//			System.out.println("Circle::"+circle);
	//			System.out.println("Division:"+division);
				RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
				String headOfficeCode="1";
				ArrayList circles = rwsOffices.getCircles(headOfficeCode);
				session.setAttribute("circles", circles);
				ArrayList divisions = rwsOffices.getDivisions(headOfficeCode,request.getParameter("circleOfficeCode"));
				session.setAttribute("divisions",divisions);
				waterLabTests=RwsWQualityData.getWQLabTests(getDataSource(request),rwsUser.getUserId(),circle,division);
	//			System.out.println("waterLabTests.size is "+waterLabTests.size());
				waterSampleResForm.setWqLabTests(waterLabTests);
			}
			catch(Exception e)
			{
				System.out.println("The error in data is rws_WaterSampleResult_frm is  "+e);
			}
			
		}
		/*
		if(mode.equalsIgnoreCase("test"))
		{
			RwsWQuality rwsWQuality=new RwsWQuality();
			try
			{
				 
				System.out.println("test code="+request.getParameter("testCode")+"testId="+request.getParameter("testId"));
				parameters=RwsWQualityData.getTestParameterCodes(getDataSource(request),request.getParameter("testCode"));
				waterSampleResForm.setWqtestParams(parameters);
				updateParameters=RwsWQualityData.getWQUpdatTestPCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"));
				session.setAttribute("updateParameters",updateParameters);
			}
			catch(Exception e)
			{
				System.out.println("The error in test is rws_WaterSampleResult_frm is  "+e);
			}
		}
		*/
		//code added on 270206
		if(mode.equalsIgnoreCase("test"))
		{
			RwsWQuality rwsWQuality=new RwsWQuality();
			nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(getDataSource(request));
			try
			{
		//		System.out.println("test code="+request.getParameter("testCode")+"testId="+request.getParameter("testId"));
				if(getSelectedTestParameters(session,waterSampleResForm,request.getParameter("testId"))!=null)
				{
					System.out.println("in if");
					parameters=(ArrayList)getSelectedTestParameters(session,waterSampleResForm,request.getParameter("testId"));
				}
				else
				{
					System.out.println("in else");
					parameters=RwsWQualityData.getTestParameterCodes(getDataSource(request),request.getParameter("testId"),request.getParameter("testCode"));
				}
				//System.out.println("Parameters Size:"+parameters.size());
				waterSampleResForm.setWqtestParams(parameters);
				
				//updateParameters=RwsWQualityData.getWQUpdatTestPCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"));
				updateParameters=RwsWQualityData.getWQUpdatTestPCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"),sourceCode);
				ArrayList testIds = new ArrayList();
				for(int i = 0;i<updateParameters.size();i++)
				{
					RwsWQuality ssd = (RwsWQuality)updateParameters.get(i);
					testIds.add(i,ssd.getTestId());					
				}
		//		System.out.println("Test ids Size::"+testIds.size());
				session.setAttribute("testids",testIds);
		//		System.out.println("Size in test::"+updateParameters.size());
//				updateParameters=RwsWQualityData.getWQUpdatTestParameterCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"),request.getParameter("sourceCode"));
				String sl = RwsWQualityData.getSourceLocation(getDataSource(request),sourceCode);
				if(sl == null)sl = "";
				request.setAttribute("sourceLocation",sl);
				System.out.println("Source Name"+sl);
				request.setAttribute("districtName",rwsOffices.getDistrictName(request.getParameter("sourceCode").substring(0,2)));
				request.setAttribute("mandalName",rwsOffices.getMandalName(request.getParameter("sourceCode").substring(0,2),request.getParameter("sourceCode").substring(5,7)));
				request.setAttribute("habitationName",rwsOffices.getHabitationName(getDataSource(request),request.getParameter("sourceCode").substring(0,16)));
				session.setAttribute("updateParameters",updateParameters);
				//System.out.println("Exiting from test mode");
			}
			catch(Exception e)
			{
				System.out.println("The error in test is rws_WaterSampleResult_frm is  "+e);
			}
		}
		//end of code added
		if(mode.equalsIgnoreCase("testview"))
		{
			RwsWQuality rwsWQuality=new RwsWQuality();
			nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(getDataSource(request));
			try
			{
	//			System.out.println("testid="+request.getParameter("testId"));
	//			System.out.println("test code="+request.getParameter("testCode"));
				parameters=RwsWQualityData.getWQTestParameterCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"));
				waterSampleResForm.setWqtestParams(parameters);
				String source = (String)session.getAttribute("sourcecode");
				updateParameters=RwsWQualityData.getWQUpdatTestPCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"),source);
			//	System.out.println("Size new ::"+updateParameters.size());
				ArrayList testIds = new ArrayList();
				for(int i = 0;i<updateParameters.size();i++)
				{
					RwsWQuality ssd = (RwsWQuality)updateParameters.get(i);
					testIds.add(i,ssd.getTestId());					
				}
//				System.out.println("Test ids Size::"+testIds.size());
				session.setAttribute("testids",testIds);
				session.setAttribute("updateParameters",updateParameters);
//				System.out.println("Source COde::"+session.getAttribute("sourcecode"));
				
				String sl = RwsWQualityData.getSourceLocation(getDataSource(request),source);
				if(sl == null)sl = "";
				request.setAttribute("sourceLocation",sl);
//				System.out.println("Mandal Name::"+rwsOffices.getMandalName(source.substring(0,2),source.substring(5,7)));
//				System.out.println("habitationName"+rwsOffices.getHabitationName(getDataSource(request),source.substring(0,16)));
//				System.out.println("Source Name"+sl);
				request.setAttribute("districtName",rwsOffices.getDistrictName(source.substring(0,2)));
				request.setAttribute("mandalName",rwsOffices.getMandalName(source.substring(0,2),source.substring(5,7)));
				request.setAttribute("habitationName",rwsOffices.getHabitationName(getDataSource(request),source.substring(0,16)));
				
			}
			catch(Exception e)
			{
				System.out.println("The error in test is rws_WaterSampleResult_frm is  "+e);
			}
		}
		if(mode.equalsIgnoreCase("updateTests"))
		{
			RwsWQuality rwsWQuality=new RwsWQuality();
			String testId = request.getParameter("testid");
			updateParameters=RwsWQualityData.getWQUpdatTestPCodes1(getDataSource(request),testId);
//			System.out.println("size in action class::"+updateParameters.size());
			session.setAttribute("updateParameters",updateParameters);
		}
		if(mode.equalsIgnoreCase("save"))
		{	
			String selectedRadio = request.getParameter("selectedRadio");
	//		System.out.println("selectedRadio::"+selectedRadio);
			Connection conn = null;
			Statement stmt = null;
			DataSource dataSource = getDataSource(request);
			WaterSampleForm wsf = new WaterSampleForm();
			WaterSampleTestResLnk ws = new WaterSampleTestResLnk();
			WaterSampleTestResLnk ws1 = new WaterSampleTestResLnk();
			ArrayList carryResults = new ArrayList();
			try
			{
				conn = dataSource.getConnection();	
				stmt=conn.createStatement();
	//			//System.out.println("in save mode start:"+session.getAttribute("allResults"));
				ArrayList results = (ArrayList)waterSampleResForm.getWqtestParams();
				int i = 0;
				session.removeAttribute("carryResults");
				for(int x=0;x<results.size();x++)
				{
					ws1 = (WaterSampleTestResLnk)results.get(x);
					
		//				System.out.println("in if loop with value I::"+ws1.getTestId());
	//					System.out.println("in if loop with value I::"+ws1.getTestPCode());
	//					System.out.println("in if loop with value I::"+ws1.getResult());
						carryResults.add(i++,ws1.getTestId());
						carryResults.add(i++,ws1.getTestPCode());
						carryResults.add(i++,ws1.getResult());
					
				}
//				System.out.println("carryResults size in save mode::"+carryResults.size());
				session.setAttribute("carryResults",carryResults);
				session.setAttribute("results",results);
				
				int update = 0;
				
				/*for(int x=0;x<results.size();x++)
				{
					ws = (WaterSampleTestResLnk)results.get(x);
					if(ws.getResult() != null && !ws.getResult().equals(""))
					{
						System.out.println(ws.getTestId()+ws.getTestPCode()+ws.getResult());
						String q ="insert into RWS_WQ_TEST_RESULTS_LNK_TBL  values('"+ws.getTestId()+"','"+ws.getTestPCode()+"','"+ws.getResult()+"')";
						System.out.println("query for insert is::"+q);
						update = stmt.executeUpdate(q);
					}
					
				}*/
			}	
			catch(Exception e)
			{
				System.out.println("The error in checks is rws_WaterSampleResult_frm is  "+e);
			}
		}

		
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{   
				watersampleres=RwsWQualityData.getWaterSampleResults(getDataSource(request),rwsUser.getUserId());
				session.setAttribute("watersampleres",watersampleres);
				
			}
			catch(Exception e)
			{
				System.out.println(e+"");
			}
		}
		
		if(mode.equalsIgnoreCase("submit"))
		{
			try
			{
//				System.out.println("in submit mode");
				String selectedRadio = request.getParameter("selectedRadio");
		//		System.out.println("selectedRadio::"+selectedRadio);
				RwsWQuality rwsWQuality = new RwsWQuality();
				ArrayList results = (ArrayList)session.getAttribute("results");
				ArrayList carryResults = new ArrayList();
				if(session.getAttribute("carryResults") != null){
					carryResults = (ArrayList)session.getAttribute("carryResults");	
				}
				ArrayList tests = (ArrayList)waterSampleResForm.getWqLabTests();
			//	System.out.println("Tests Size::"+tests.size());
				//System.out.println("carryResults Size::"+carryResults.size());
				
				//getAllTestResults(session,waterSampleResForm);
			//	System.out.println(waterSampleResForm.getRecommendations());
				rwsWQuality.setRecommendations(waterSampleResForm.getRecommendations());
				rwsWQuality.setCondemnSource(waterSampleResForm.getCondemnSource());      
				rwsWQuality.setUpdateSource(waterSampleResForm.getUpdateSource());  
				rwsWQuality.setForwadedOn(waterSampleResForm.getForwadedOn()); 
				rwsWQuality.setPreparedBy(waterSampleResForm.getPreparedBy());
				rwsWQuality.setPreparedOn(waterSampleResForm.getPreparedOn()); 
				rwsWQuality.setCondemnSource(waterSampleResForm.getCondemnSource());

				ArrayList allResults=getAllTestResults(session,waterSampleResForm);
				//int[] rcount=RwsWQualityData.insertWaterSampleRes(rwsWQuality,tests,results,getDataSource(request));
				//int[] rcount=RwsWQualityData.insertWaterSampleRes(rwsWQuality,tests,allResults,getDataSource(request));
				int[] rcount=RwsWQualityData.insertWaterSampleRes1(rwsWQuality,tests,carryResults,selectedRadio,getDataSource(request));
				
				waterSampleResForm.reset(mapping,request);
				session.setAttribute("allResults",null);
				//System.out.println("rcount::"+rcount);
				if(rcount.length <= 0 )
				{
					message="The Record Cant be inserted   ";
				}
				else
				{
					message="Record Inserted Successfully";
				}
				
				request.setAttribute("message",message);
				
				
			}
			
			catch(Exception e)
			{
				System.out.println("the error is"+e);
			}
			
		
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildWaterSampleResForm(request.getParameter("testId"),request);
				session.setAttribute("testId",request.getParameter("testId"));
				if ("request".equals(mapping.getScope())) 
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
				System.out.println("the error is"+e);
			}
		
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				RwsWQuality rwsWQuality = new RwsWQuality();
				ArrayList results = (ArrayList)session.getAttribute("results");
				ArrayList tests = (ArrayList)waterSampleResForm.getWqLabTests();
//				System.out.println("test id="+(String)session.getAttribute("testId"));
				rwsWQuality.setRecommendations(waterSampleResForm.getRecommendations());
				rwsWQuality.setCondemnSource(waterSampleResForm.getCondemnSource());      
				rwsWQuality.setUpdateSource(waterSampleResForm.getUpdateSource());  
				rwsWQuality.setForwadedOn(waterSampleResForm.getForwadedOn()); 
				rwsWQuality.setPreparedBy(waterSampleResForm.getPreparedBy());
				rwsWQuality.setPreparedOn(waterSampleResForm.getPreparedOn()); 
						
				int[] rcount=RwsWQualityData.updateWaterSampleResult((String)session.getAttribute("testId"),results,rwsWQuality,getDataSource(request));
				if(rcount.length <= 0 )
				{	if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
						message = RwsMasterData.errorMessage;
					else
					message="The record cannot be updated.";
					mode = "get";
				}
				else
					message="The record updated successfully.";
			}
			catch (Exception e) 
			{
				System.out.println("the error in Water Sample Test Result edit is "+e);
			}
			
			request.setAttribute("message",message);
			
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				int del=RwsWQualityData.removeWaterSampleRes(request.getParameter("testId"),getDataSource(request));
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
				System.out.println("Error is in this:"+e.getMessage());
			}
		}
		
		
		return(mapping.findForward(mode));
	}


	public ArrayList getAllTestResults(HttpSession session,ActionForm form)
	{
//		System.out.println("in getAllTestResults");
		ArrayList allResults=new ArrayList();
		try
		{
			WaterSampleResForm waterSampleResForm=(WaterSampleResForm)form;
			
			if(session.getAttribute("allResults")!=null)
			allResults=(ArrayList)session.getAttribute("allResults");
			
			
			WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
	
//			System.out.println("in first for loop"+allResults.size());
			for(int i=0;i<allResults.size();i++)
			{
				
				ArrayList resultsTmp=(ArrayList)allResults.get(i);
				for(int j=0;j<resultsTmp.size();j++)
				{
					waterSampleTestResLnk=(WaterSampleTestResLnk)resultsTmp.get(j);
//					System.out.println("testId is "+waterSampleTestResLnk.getTestId());
					//System.out.println("test Name is "+waterSampleTestResLnk.getTestName());
//					System.out.println("test Pcode is "+waterSampleTestResLnk.getTestPCode());
					//System.out.println("test parameter name is "+waterSampleTestResLnk.getTestPName());
//					System.out.println("test result is "+waterSampleTestResLnk.getResult());
				}
//				System.out.println("here i have to write all the info. to save........");
			}
			
		}
		catch(Exception e)
		{
			System.out.println("The error in checks is rws_WaterSampleResult_frm is  "+e);
		}
		return allResults;
	}
	
	public ArrayList getSelectedTestParameters(HttpSession session,ActionForm form,String testId)
	{
//		System.out.println("in getSelectedTestParameters");
		ArrayList allResults=new ArrayList();
		try
		{
			WaterSampleResForm waterSampleResForm=(WaterSampleResForm)form;
			
			if(session.getAttribute("allResults")!=null)
			allResults=(ArrayList)session.getAttribute("allResults");
			
			WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
	
			for(int i=0;i<allResults.size();i++)
			{
				ArrayList resultsTmp=(ArrayList)allResults.get(i);
				for(int j=0;j<resultsTmp.size();j++)
				{
					waterSampleTestResLnk=(WaterSampleTestResLnk)resultsTmp.get(j);
					if(waterSampleTestResLnk.getTestId().equals(testId))
					{
						
						return resultsTmp;
					}
				}
			}
			
		}
		catch(Exception e)
		{
			System.out.println("The error in checks is rws_WaterSampleResult_frm is  "+e);
		}
		return null;
	}
	
	public void setAllResults(HttpSession session,ActionForm form)
	{
//		System.out.println("in setAllResults");
		ArrayList allResults=new ArrayList();
		WaterSampleResForm waterSampleResForm=(WaterSampleResForm)form;
		try{
		if(session.getAttribute("allResults")!=null)
			allResults=(ArrayList)session.getAttribute("allResults");
			
			ArrayList results = (ArrayList)waterSampleResForm.getWqtestParams();
			if(results.size()!=0)
			allResults.add(results);
			
	
			session.setAttribute("allResults",allResults);
		}catch(Exception e){System.out.println("Exception in setAllResults : "+e);}
	}
	
	public boolean replaceInAllResults(ArrayList allResults,ArrayList results)
	{
		boolean replaced=false;
		try{
//		System.out.println("in replaceInAllResults");
		WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
		waterSampleTestResLnk=(WaterSampleTestResLnk)results.get(0);
		String testId=waterSampleTestResLnk.getTestId();
		boolean exists=false;
		
		for(int i=0;i<allResults.size();i++)
		{
			exists=false;
			ArrayList resultsTmp=(ArrayList)allResults.get(i);
			for(int j=0;j<resultsTmp.size();j++)
			{
				waterSampleTestResLnk=(WaterSampleTestResLnk)resultsTmp.get(j);
				if(waterSampleTestResLnk.getTestId().equals(testId))
					exists=true;
			}
			if(exists)
			{
			allResults.set(allResults.indexOf(resultsTmp),results);
//			System.out.println("index is "+allResults.indexOf(resultsTmp));
			replaced=true;
			}
		}
		}catch(Exception e){System.out.println("Exception in replaceInAllResults "+e);}
//		System.out.println("replaceInAllResults status::"+replaced);
		return replaced;
	}
}
