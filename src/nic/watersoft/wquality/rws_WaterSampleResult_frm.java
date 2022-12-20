
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

import nic.watersoft.commons.RwsLocations;
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
//		Debug.println("in buildWaterSampleResForm");
		WaterSampleResForm waterSampleResForm = null;
		Collection watersampleres = new ArrayList();
		Collection parameters = new ArrayList();
		HttpSession session=request.getSession();
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		watersampleres=RwsWQualityData.getWQLabTest(getDataSource(request),rwsUser.getUserId(),testId);
	//	Debug.println("water samples size in action::"+watersampleres.size());
		
		session.setAttribute("watersampleres",watersampleres);
		ArrayList aa = new ArrayList();
		RwsWQuality rwsWQuality=RwsWQualityData.getWaterSampleResult(getDataSource(request),testId);
			if(rwsWQuality!=null)
			{  
	//			Debug.println("in side if loop::"+rwsWQuality.getRecommendations());
				waterSampleResForm = new WaterSampleResForm();
				waterSampleResForm.setWqLabTests(watersampleres);
				waterSampleResForm.setRecommendations(rwsWQuality.getRecommendations());
				//waterSampleResForm.setCondemnSource(rwsWQuality.getCondemnSource());      
				waterSampleResForm.setUpdateSource(rwsWQuality.getUpdateSource());  
				waterSampleResForm.setForwadedOn(rwsWQuality.getForwadedOn());   		
			}
			return waterSampleResForm;
	}


	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws Exception
	{
		System.gc();
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList watersampleres=new ArrayList();
		Collection waterLabTests = new ArrayList();
		Collection parameters = new ArrayList();
		ArrayList testParams = new ArrayList();
		ArrayList updateParameters=new ArrayList();
		ArrayList waterPtestUpdateList=new ArrayList();
		
		//Debug.println(" i am in quality test ");
		HttpSession session=request.getSession();
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		WaterSampleResForm waterSampleResForm=(WaterSampleResForm) form;
		Debug.println("user:"+rwsUser);
		if(rwsUser==null)
			return mapping.findForward("expire");
		session = request.getSession();
		
		String mode=waterSampleResForm.getMode();
		// Debug.println("mode in rws_WaterSampleResult_frm= "+mode);
		String sourceCode = request.getParameter("sourceCode");
		// Debug.println("sourceCode:"+sourceCode);
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
		if(mode.equalsIgnoreCase("edit"))
		{
			  Debug.println("2@@@@@@@2");
			try
			{
				Debug.println("dddddddddddddddd");
				ArrayList carryResults = null;
				Debug.println("110000000000000000");
				RwsWQuality rwsWQuality = new RwsWQuality();
				//ArrayList results = (ArrayList)session.getAttribute("results");
				//Debug.println("in edit mode:"+results.size());
				Debug.println("111111111111111111");
				int rcount = 0;
				if(session.getAttribute("carryResults") != null){
					carryResults = (ArrayList)session.getAttribute("carryResults");	
					Debug.println("carryResults submit mode:"+carryResults.size());
					ArrayList tests = (ArrayList)waterSampleResForm.getWqLabTests();
//					Debug.println("test id="+(String)session.getAttribute("testId"));
					rwsWQuality.setRecommendations(waterSampleResForm.getRecommendations());
					//rwsWQuality.setCondemnSource(waterSampleResForm.getCondemnSource());      
					rwsWQuality.setUpdateSource(waterSampleResForm.getUpdateSource());  
					rwsWQuality.setForwadedOn(waterSampleResForm.getForwadedOn()); 
					rwsWQuality.setPreparedBy(waterSampleResForm.getPreparedBy());
					rwsWQuality.setPreparedOn(waterSampleResForm.getPreparedOn());
					Debug.println("22222222222222222"+carryResults.size());
					
					if(carryResults!=null && carryResults.size()>0){ 
						rcount=RwsWQualityData.updateWaterSampleResult((String)session.getAttribute("testId"),carryResults,rwsWQuality,getDataSource(request));
						
					}
					Debug.println("count in water quality::"+rcount);
				}
				else{
					Debug.println("sdsadasfsadfsdfsdfsdfsdfsdfsdfds");
					rcount=-1;}  
				
				 Debug.println(" 3@@@@@@@@@:"+rcount);
				if(rcount == 0 ) 
				{
					message="The Record Cant be Updated-Please Update Test Results for atleast one Testing Parameter";
				}
				else if(rcount >1)  
				{
					message="Record Updated Successfully";
				}
				else if(rcount == -1)
				{
					message="Record Can not be Updated - Please Update Test Results for atleast one Testing Parameter";
				}
				    mode="close";
				    session.setAttribute("carryResults",new ArrayList());
				    session.removeAttribute("results");
			}
			catch (Exception e) 
			{ 
				Debug.println("the error in Water Sample Test Result edit is "+e);
			}
			
			request.setAttribute("message",message);
			
		}  
		if(mode.equalsIgnoreCase("data"))
		{
			// Debug.println("in data mode");
			try
			{
				
				String circle = waterSampleResForm.getCircleOfficeCode();
				String division = waterSampleResForm.getDivisionOfficeCode();
				String subdivision=waterSampleResForm.getSubdivisionOfficeCode();
				String mandal= waterSampleResForm.getMandalCode();
				if(circle==null)
					circle=rwsUser.getCircleOfficeCode();
				if(division==null)
					division=rwsUser.getDivisionOfficeCode();
				if(subdivision==null)
					subdivision=rwsUser.getSubdivisionOfficeCode();
				ArrayList circles=null, divisions=null, subdivisions=null,mandals=null;
				String headOfficeCode="1";
				RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
				circles = rwsOffices.getCircles(headOfficeCode);
				session.setAttribute("circles", circles);
				
				if(circles!=null && !circles.equals("")){
				divisions = rwsOffices.getDivisions(headOfficeCode,circle);
				session.setAttribute("divisions",divisions);  
				}
				//Debug.println("2");  
				if(circle!=null && division!=null && !circle.equals("") && !division.equals(""))
				{  
					Debug.println(" inmandalssssss details11111 ");
					subdivisions=rwsOffices.getSubdivisions(headOfficeCode,circle,division);
					session.setAttribute("subdivisions",subdivisions);
				}
				if( (circle!=null  && !circle.equals("")) && (!division.equals("") && division!=null))
				{
					Debug.println(" inmandalssssss details ");
					mandals=rwsOffices.getDivmandals(circle,division,subdivision);
					session.setAttribute("mandals",mandals);
				} 
				Debug.println("5");
				if(mandal!=null && !mandal.equals("")){
				waterLabTests=RwsWQualityData.getWQLabTests(getDataSource(request),circle,division,subdivision,mandal);
				waterSampleResForm.setWqLabTests(waterLabTests);
				}
				else
				{
					Debug.println("ssssssssssssssssssssssssss");
					waterSampleResForm.setWqLabTests(new ArrayList());
				}
				
				
				
			}
			catch(Exception e)
			{
				Debug.println("The error in data is rws_WaterSampleResult_frm is  "+e);
			}
			
		}
		if(mode.equalsIgnoreCase("test"))
		{
			Debug.println(" in test mode");
			// session.removeAttribute("carryResults");
			RwsWQuality rwsWQuality=new RwsWQuality();
			nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(getDataSource(request));
			try
			{
		//		Debug.println("test code="+request.getParameter("testCode")+"testId="+request.getParameter("testId"));
				if(getSelectedTestParameters(session,waterSampleResForm,request.getParameter("testId"))!=null)
				{
					Debug.println("in if");
					parameters=(ArrayList)getSelectedTestParameters(session,waterSampleResForm,request.getParameter("testId"));
				}
				else
				{
					Debug.println("in else");
					//parameters=RwsWQualityData.getTestParameterCodes(getDataSource(request),request.getParameter("testId"),request.getParameter("testCode"));
					parameters=RwsWQualityData.getWQUpdatTestPCodes1(getDataSource(request),request.getParameter("testId"),request.getParameter("testCode"));
					if(parameters.size()==0)
						parameters=RwsWQualityData.getTestParameterCodes(getDataSource(request),request.getParameter("testId"),request.getParameter("testCode"));
				}
				Debug.println("Parameters Size:"+parameters.size());
				Debug.println("parameters"+parameters);
				waterSampleResForm.setWqtestParams(parameters);
				
				//updateParameters=RwsWQualityData.getWQUpdatTestPCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"));
				updateParameters=RwsWQualityData.getWQUpdatTestPCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"),sourceCode);
				ArrayList testIds = new ArrayList();
				for(int i = 0;i<updateParameters.size();i++)
				{
					RwsWQuality ssd = (RwsWQuality)updateParameters.get(i);
					testIds.add(i,ssd.getTestId());					
				}
		//		Debug.println("Test ids Size::"+testIds.size());
				session.setAttribute("testids",testIds);
		//		Debug.println("Size in test::"+updateParameters.size());
//				updateParameters=RwsWQualityData.getWQUpdatTestParameterCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"),request.getParameter("sourceCode"));
				String sl = RwsWQualityData.getSourceLocation(getDataSource(request),sourceCode);
				if(sl == null)sl = "";
				request.setAttribute("sourceLocation",sl);
				Debug.println("Source Name"+sl);
				request.setAttribute("districtName",rwsOffices.getDistrictName(request.getParameter("sourceCode").substring(0,2)));
				request.setAttribute("mandalName",rwsOffices.getMandalName(request.getParameter("sourceCode").substring(0,2),request.getParameter("sourceCode").substring(5,7)));
				request.setAttribute("habitationName",rwsOffices.getHabitationName(getDataSource(request),request.getParameter("sourceCode").substring(0,16)));
				session.setAttribute("updateParameters",updateParameters);
				//Debug.println("Exiting from test mode");
			}
			catch(Exception e)
			{
				Debug.println("The error in test is rws_WaterSampleResult_frm is  "+e);
			}
		}
		/*
		 * added by ramesh 
		 */
		if(mode.equalsIgnoreCase("testNewParams"))
		{
			Debug.println(" in testNewParams mode");
			// session.removeAttribute("carryResults");
			RwsWQuality rwsWQuality=new RwsWQuality();
			RwsWQualityData data=new RwsWQualityData();
			nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(getDataSource(request));
			try  
			{
		//		Debug.println("test code="+request.getParameter("testCode")+"testId="+request.getParameter("testId"));
				ArrayList parameters1=new ArrayList();
				parameters=RwsWQualityData.getTestParameterCodes(request.getParameter("testCode"),request.getParameter("testId"));
				waterSampleResForm.setWqtestParams(parameters);
				parameters1=data.getSelectedParameters(request.getParameter("testCode"),request.getParameter("testId"));
				session.setAttribute("parameters1",parameters1);
				updateParameters=RwsWQualityData.getWQUpdatTestPCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"),sourceCode);
				ArrayList testIds = new ArrayList();
				for(int i = 0;i<updateParameters.size();i++)
				{
					RwsWQuality ssd = (RwsWQuality)updateParameters.get(i);
					testIds.add(i,ssd.getTestId());					
				}
				session.setAttribute("testids",testIds);
				
				String sl = RwsWQualityData.getSourceLocation(getDataSource(request),sourceCode);
				if(sl == null)sl = "";
				request.setAttribute("sourceLocation",sl);
				// Debug.println("Source Name"+sl);
				request.setAttribute("districtName",rwsOffices.getDistrictName(request.getParameter("sourceCode").substring(0,2)));
				request.setAttribute("mandalName",rwsOffices.getMandalName(request.getParameter("sourceCode").substring(0,2),request.getParameter("sourceCode").substring(5,7)));
				request.setAttribute("habitationName",rwsOffices.getHabitationName(getDataSource(request),request.getParameter("sourceCode").substring(0,16)));
				session.setAttribute("updateParameters",updateParameters);
				mode = "test";
			}
			catch(Exception e)
			{
				Debug.println("The error in test is rws_WaterSampleResult_frm is  "+e);
			}
		}
		//end of code added
		if(mode.equalsIgnoreCase("testview"))
		{
			Debug.println(" In test view");
			
			RwsWQuality rwsWQuality=new RwsWQuality();
			nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(getDataSource(request));
			try
			{
				parameters=RwsWQualityData.getWQTestParameterCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"));
				waterSampleResForm.setWqtestParams(parameters);
				String source = (String)session.getAttribute("sourcecode");
				updateParameters=RwsWQualityData.getWQUpdatTestPCodes(getDataSource(request),request.getParameter("testCode"),request.getParameter("testId"),source);
				ArrayList testIds = new ArrayList();
				for(int i = 0;i<updateParameters.size();i++)
				{
					RwsWQuality ssd = (RwsWQuality)updateParameters.get(i);
					testIds.add(i,ssd.getTestId());					
				}
				session.setAttribute("testids",testIds);
				session.setAttribute("updateParameters",updateParameters);
				
				String sl = RwsWQualityData.getSourceLocation(getDataSource(request),source);
				if(sl == null)sl = "";
				request.setAttribute("sourceLocation",sl);
				request.setAttribute("districtName",rwsOffices.getDistrictName(source.substring(0,2)));
				request.setAttribute("mandalName",rwsOffices.getMandalName(source.substring(0,2),source.substring(5,7)));
				request.setAttribute("habitationName",rwsOffices.getHabitationName(getDataSource(request),source.substring(0,16)));
				
			}
			catch(Exception e)
			{
				Debug.println("The error in test view is rws_WaterSampleResult_frm is  "+e);
			}
		}
		if(mode.equalsIgnoreCase("updateTests"))
		{
			Debug.println(" in Update Tests mode ");
			
			RwsWQuality rwsWQuality=new RwsWQuality();
			String testId = request.getParameter("testid");
			String testCode=request.getParameter("testCode");
			updateParameters=RwsWQualityData.getWQUpdatTestPCodes1(getDataSource(request),testId,testCode);
//			Debug.println("size in action class::"+updateParameters.size());
			//session.setAttribute("updateParameters",updateParameters);
			session.setAttribute("updateParameters",updateParameters);
		}
		if(mode.equalsIgnoreCase("saveQT"))
			{	
				String selectedRadio = request.getParameter("selectedRadio");
				//Debug.println("selectedRadio::"+selectedRadio);
				
				WaterSampleTestResLnk ws1 = new WaterSampleTestResLnk();
				ArrayList carryResults = new ArrayList();
				
				try  
				{
					session.removeAttribute("carryResults");
					ArrayList results = (ArrayList)waterSampleResForm.getWqtestParams();
					Debug.println("Result size:"+results.size());
					if(results.size()> 0){
					boolean flag = RwsWQualityData.insertQualityTestResultsTemp(results,request.getParameter("testId"));
					Debug.println("flag:"+flag);
					if(flag)
						request.setAttribute("message","Results Added - Click SUBMIT button to Save Permanently");
					else
						request.setAttribute("message","Failed to Add Results - Try Again");
					int i = 0;
					 request.removeAttribute("carryResults");
					for(int x=0;x<results.size();x++)
					{
						ws1 = (WaterSampleTestResLnk)results.get(x);
						carryResults.add(i++,ws1.getTestId());
						carryResults.add(i++,ws1.getTestPCode());
						carryResults.add(i++,ws1.getResult());
					 }
					session.setAttribute("carryResults",carryResults);
					session.setAttribute("results",results);
					int update = 0;
					mode = "saveQT";
					}else
					{
						request.setAttribute("message","Failed to Add - Please Re-Enter the Results");	
						mode="testNewParam";
					}
					 
				}	
				catch(Exception e)
				{
					Debug.println("The error in save mode of  rws_WaterSampleResult_frm is  "+e);
				}
			}

		
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{   
				
				//Debug.println("view mode@@@@@");
				watersampleres=RwsWQualityData.getWaterSampleResults(getDataSource(request),waterSampleResForm,rwsUser.getUserId());
				session.setAttribute("watersampleres",watersampleres);
				
			}
			catch(Exception e)
			{
				Debug.println("Exception Quality Tests View Mode:"+e);
			}
		}
		if(mode.equalsIgnoreCase("submit"))
		{
			try
			{
 		   		Debug.println("in submit mode");
 		  
				String selectedRadio = request.getParameter("selectedRadio");
		    	//Debug.println("selectedRadio::"+selectedRadio);
				RwsWQuality rwsWQuality = new RwsWQuality();
				
				ArrayList results = (ArrayList)session.getAttribute("results");
				Debug.println("submit mode:"+results.size());
				ArrayList carryResults = null;
				if(session.getAttribute("carryResults") != null){
					carryResults = (ArrayList)session.getAttribute("carryResults");	
				}
				Debug.println("carryResults submit mode:"+carryResults.size());
				ArrayList tests = (ArrayList)waterSampleResForm.getWqLabTests();
				rwsWQuality.setRecommendations(waterSampleResForm.getRecommendations());
				rwsWQuality.setUpdateSource(waterSampleResForm.getUpdateSource());  
				rwsWQuality.setForwadedOn(waterSampleResForm.getForwadedOn()); 
				rwsWQuality.setPreparedBy(waterSampleResForm.getPreparedBy());
				rwsWQuality.setPreparedOn(waterSampleResForm.getPreparedOn()); 
				ArrayList allResults=getAllTestResults(session,waterSampleResForm);
				
				String rcount = "";
				if(carryResults!=null && carryResults.size()>0)
				{
					rcount=RwsWQualityData.insertWaterSampleRes2(rwsWQuality,tests,selectedRadio,getDataSource(request));
				}
				else
					rcount = "Record Can not be inserted - Please Enter Test Results for atleast one Testing Parameter";
				waterSampleResForm.reset(mapping,request);
				session.setAttribute("allResults",null);
				
				waterSampleResForm.setRecommendations("");
				request.setAttribute("message",rcount);
				session.setAttribute("carryResults",new ArrayList());
				
			}
			
			catch(Exception e)
			{
				Debug.println("the error is in  Submit mode: "+e);
			}
			//session.removeAttribute("carryResults");
		
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				//Debug.println(" in get mode");
				
				
				form = buildWaterSampleResForm(request.getParameter("testId"),request);
				//Debug.println(" 1111111111111111");
				session.setAttribute("testId",request.getParameter("testId"));
				if ("request".equals(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
				//Debug.println(" 22222222222");
			}
			catch (Exception e) 
			{
				Debug.println("the error in get mode :"+e);
			}
		
		}
		
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				 // Debug.println(" delete mode of quality tests" + request.getParameter("testId"));
				int del=RwsWQualityData.removeWaterSampleRes(request.getParameter("testId"),getDataSource(request));
				if(del>0)
				{
					displaymess = "Record deleted Succesfully";
				}
				else
				{
					displaymess = "Failed to delete";
				}
				request.setAttribute("message",displaymess);
			}
			catch (Exception e) 
			{
				Debug.println("Error is in Delete mode :"+e.getMessage());
			}
			mode = "close";
		}
		
		System.gc();
		Debug.println("return mode:"+mode);
		return(mapping.findForward(mode));
	}


	public ArrayList getAllTestResults(HttpSession session,ActionForm form)
	{
//		Debug.println("in getAllTestResults");
		ArrayList allResults=new ArrayList();
		try
		{
			WaterSampleResForm waterSampleResForm=(WaterSampleResForm)form;
			
			if(session.getAttribute("allResults")!=null)
			allResults=(ArrayList)session.getAttribute("allResults");
			
			
			WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
	 
//			Debug.println("in first for loop"+allResults.size());
			for(int i=0;i<allResults.size();i++)
			{
				
				ArrayList resultsTmp=(ArrayList)allResults.get(i);
				for(int j=0;j<resultsTmp.size();j++)
				{
					waterSampleTestResLnk=(WaterSampleTestResLnk)resultsTmp.get(j);
//					Debug.println("testId is "+waterSampleTestResLnk.getTestId());
					//Debug.println("test Name is "+waterSampleTestResLnk.getTestName());
//					Debug.println("test Pcode is "+waterSampleTestResLnk.getTestPCode());
					//Debug.println("test parameter name is "+waterSampleTestResLnk.getTestPName());
//					Debug.println("test result is "+waterSampleTestResLnk.getResult());
				}
//				Debug.println("here i have to write all the info. to save........");
			}
			
		}
		catch(Exception e)
		{
			Debug.println("The error in checks is rws_WaterSampleResult_frm is  "+e);
		}
		return allResults;
	}
	
	public ArrayList getSelectedTestParameters(HttpSession session,ActionForm form,String testId)
	{
//		Debug.println("in getSelectedTestParameters");
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
			Debug.println("The error in selectedParamerts method "+e);
		}
		return null;
	}
	
	public void setAllResults(HttpSession session,ActionForm form)
	{
//		Debug.println("in setAllResults");
		ArrayList allResults=new ArrayList();
		WaterSampleResForm waterSampleResForm=(WaterSampleResForm)form;
		try{
		if(session.getAttribute("allResults")!=null)
			allResults=(ArrayList)session.getAttribute("allResults");
			
			ArrayList results = (ArrayList)waterSampleResForm.getWqtestParams();
			if(results.size()!=0)
			allResults.add(results);
			
	
			session.setAttribute("allResults",allResults);
		}catch(Exception e){Debug.println("Exception in setAllResults : "+e);}
	}
	
	public boolean replaceInAllResults(ArrayList allResults,ArrayList results)
	{
		boolean replaced=false; 
		try{
//		Debug.println("in replaceInAllResults");
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
//			Debug.println("index is "+allResults.indexOf(resultsTmp));
			replaced=true;
			}
		}
		}catch(Exception e){Debug.println("Exception in replaceInAllResults "+e);}
//		Debug.println("replaceInAllResults status::"+replaced);
		return replaced;
	}
}
