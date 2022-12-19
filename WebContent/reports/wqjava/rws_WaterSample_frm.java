package nic.watersoft.wquality;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.DAOMessage;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_WaterSample_frm extends Action
{
	ArrayList sources=new ArrayList();
	ArrayList wqlabs=new ArrayList();
	ArrayList watertests=new ArrayList();
	ArrayList desgns=new ArrayList();
	ArrayList prhabs=new ArrayList();
	RwsMasterData rwsMasterData = new RwsMasterData();
	protected ActionForm buildWaterSampleForm(String testId,HttpServletRequest request) throws Exception 
	{
		WaterSampleForm waterSample = null;
		HttpSession session=request.getSession();
		RwsWQuality rwsWQuality=RwsWQualityData.getWaterSample(testId,getDataSource(request));
//		System.out.println("checking rwsWQuality=null");
			if(rwsWQuality!=null)
			{
//				System.out.println("in if");
				waterSample = new WaterSampleForm();
//				System.out.println("hab Code="+rwsWQuality.getHabCode());
				String habcode=rwsWQuality.getHabCode();
//				System.out.println("Dcode="+habcode.substring(0,2)+"Acode="+habcode.substring(2,5)+"Mcode="+rwsWQuality.getMandalCode()+"vcode="+rwsWQuality.getVillageCode()+"hcode="+habcode.substring(10,12)+"pcode="+rwsWQuality.getPanchCode());
				RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
				RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
//				System.out.println("co codee::"+rwsUser.getCircleOfficeCode());
				prhabs = rwsLocations.getHabitations(rwsUser.getCircleOfficeCode(),habcode.substring(5,7),habcode.substring(12,14),habcode.substring(7,10));
				
				System.out.println("PR HABS SIZE="+prhabs.size());
				//sources=RwsMasterData.getSources(getDataSource(request));
				//code added
				sources=RwsMasterData.getSources(getDataSource(request));
				//end of code added
				watertests=rwsMasterData.getWaterTests(getDataSource(request),rwsMasterData);
				desgns=RwsMasterData.getDesgns(getDataSource(request));
//				System.out.println("calling getWQLabs");
				wqlabs=RwsMasterData.getWQLabs(getDataSource(request));
				
				session.setAttribute("sources",sources);
				session.setAttribute("watertests",watertests);
				session.setAttribute("desgns",desgns);
				session.setAttribute("wqlabs",wqlabs);
				session.setAttribute("prhabs",prhabs);
	//			System.out.println("co coddd:"+rwsWQuality.getCoc());
				waterSample.setCircleOfficeCode(rwsWQuality.getCoc());
				waterSample.setDivisionOfficeCode(rwsWQuality.getDoc());
	//			System.out.println("value of sdoc is "+rwsWQuality.getSdoc());
				waterSample.setSubdivisionOfficeCode(rwsWQuality.getSdoc());
				waterSample.setMandalCode(rwsWQuality.getMandalCode());
				waterSample.setPanchayatCode(rwsWQuality.getPanchCode());
				waterSample.setVillageCode(rwsWQuality.getVillageCode());
				waterSample.setTestId(rwsWQuality.getTestId());
				waterSample.setHabCode(rwsWQuality.getHabCode());
				waterSample.setSourceCode(rwsWQuality.getSourceCode());         
				waterSample.setTestCode(rwsWQuality.getTestCode());      
				waterSample.setLabCode(rwsWQuality.getLabCode()); 
				waterSample.setNatureOfTest(rwsWQuality.getNatureOfTest());
				waterSample.setSampCollectCode(rwsWQuality.getSampCollectCode());
				waterSample.setSampCollectDate(rwsWQuality.getSampCollectDate());              
				waterSample.setSampCollectTime(rwsWQuality.getSampCollectTime());
				waterSample.setAssignedOn(rwsWQuality.getAssignedOn());  
				waterSample.setPreparedBy(rwsWQuality.getPreparedBy());   
				waterSample.setPreparedOn(rwsWQuality.getPreparedOn());  

			}
			
			
			return waterSample;
	}

	
	protected ActionForm buildWaterSampleForm2(String testId,HttpServletRequest request) throws Exception 
	{
		
		WaterSampleForm waterSample = null;
		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		HttpSession session=request.getSession();
	//	System.out.println("watch1.1");
		RwsWQuality rwsWQuality=RwsWQualityData.getWaterSample(testId,getDataSource(request));
//		System.out.println("watch1.2");
		if(rwsWQuality!=null)
		{
			session.setAttribute("editCheck","Y");
				System.out.println("checking rwsWQuality=null"+rwsWQuality.getCoc());
				System.out.println("in if");
				waterSample = new WaterSampleForm();
				System.out.println("hab Code="+rwsWQuality.getHabCode());
				String habcode=rwsWQuality.getHabCode();
				System.out.println("Dcode="+habcode.substring(0,2)+"Acode="+habcode.substring(2,5)+"Mcode="+rwsWQuality.getMandalCode()+"vcode="+rwsWQuality.getVillageCode()+"hcode="+habcode.substring(10,12)+"pcode="+rwsWQuality.getPanchCode());
				RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
				
				prhabs = rwsLocations.getHabitations(rwsUser.getCircleOfficeCode(),habcode.substring(5,7),habcode.substring(12,14),habcode.substring(7,10));
				
//				System.out.println("PR HABS SIZE="+prhabs.size());
				//sources=RwsMasterData.getSources(getDataSource(request));
				//code added
				sources=RwsMasterData.getSources(getDataSource(request));
				//end of code added
				watertests=rwsMasterData.getWaterTests(getDataSource(request),rwsMasterData);
				desgns=RwsMasterData.getDesgns(getDataSource(request));
	//			System.out.println("calling getWQLabs");
				wqlabs=RwsMasterData.getWQLabs(getDataSource(request));
				
				session.setAttribute("sources",sources);
				session.setAttribute("watertests",watertests);
				session.setAttribute("desgns",desgns);
				session.setAttribute("wqlabs",wqlabs);
				session.setAttribute("prhabs",prhabs);
				
				waterSample.setCircleOfficeCode(rwsWQuality.getCoc());
				waterSample.setDivisionOfficeCode(rwsWQuality.getDoc());
				waterSample.setSubdivisionOfficeCode(rwsWQuality.getSdoc());
				waterSample.setMandalCode(rwsWQuality.getMandalCode());
				waterSample.setPanchayatCode(rwsWQuality.getPanchCode());
				waterSample.setVillageCode(rwsWQuality.getVillageCode());
//				System.out.println("mandalCode is "+rwsWQuality.getMandalCode());
//				System.out.println("panchayatCode is "+rwsWQuality.getPanchCode());
				waterSample.setTestId(rwsWQuality.getTestId());
				waterSample.setHabCode(rwsWQuality.getHabCode());
				waterSample.setSourceType(rwsWQuality.getSourceType());
				waterSample.setSourceCode(rwsWQuality.getSourceCode());         
				waterSample.setTestCode(rwsWQuality.getTestCode());      
				waterSample.setLabCode(rwsWQuality.getLabCode()); 
				waterSample.setNatureOfTest(rwsWQuality.getNatureOfTest());
				waterSample.setSampCollectCode(rwsWQuality.getSampCollectCode());
				waterSample.setSampCollectDate(rwsWQuality.getSampCollectDate());              
	//			System.out.println("sampleCollectionDate "+rwsWQuality.getSampCollectDate());
				waterSample.setSampCollectTime(rwsWQuality.getSampCollectTime());
	//			System.out.println("sampleCollectionTime "+rwsWQuality.getSampCollectTime());
				waterSample.setAssignedOn(rwsWQuality.getAssignedOn());  
				waterSample.setPreparedBy(rwsWQuality.getPreparedBy());   
				waterSample.setPreparedOn(rwsWQuality.getPreparedOn());  
				
				request.setAttribute("circleOfficeName",rwsWQuality.getCircleOfficeName());
				request.setAttribute("divisionOfficeName",rwsWQuality.getDivisionOfficeName());
				request.setAttribute("subDivisionOfficeName",rwsWQuality.getSubDivisionOfficeName());

			
		//	System.out.println("getting circles");
			ArrayList circles = rwsOffices.getCircles("1");
			request.setAttribute("circles", circles);
	//		System.out.println("circles size is "+circles.size()+" doc is "+rwsWQuality.getDoc());
			
			ArrayList divisions = rwsOffices.getDivisions("1",rwsWQuality.getCoc());
			request.setAttribute("divisions", divisions);
			
			ArrayList subdivisions = rwsOffices.getSubdivisions("1",rwsWQuality.getCoc(),rwsWQuality.getDoc());
			request.setAttribute("subdivisions", subdivisions);
			
			ArrayList mandals=RwsMasterData.getsubdivisionmandals(rwsWQuality.getCoc(),rwsWQuality.getDoc(),rwsWQuality.getSdoc(),getDataSource(request));
			session.setAttribute("mandals",mandals);
	//		System.out.println("mandals size is "+mandals.size());
			
//			System.out.println("getting panchyats");
			ArrayList panchyats=rwsLocations.getPanchayats(rwsWQuality.getCoc(),rwsWQuality.getHabCode().substring(5,7));
			session.setAttribute("panchyats",panchyats);
	//		System.out.println("panchyats size is "+panchyats.size());
			
			prhabs = rwsLocations.getPanchayatHabitations(rwsWQuality.getCoc(),rwsWQuality.getHabCode().substring(5,7),rwsWQuality.getHabCode().substring(12,14));
			session.setAttribute("prhabs",prhabs);
//			System.out.println("prhabs size is "+prhabs.size());
			
			ArrayList sourceCodes=RwsWQualityData.getSourceCodesWithLocation(getDataSource(request),rwsWQuality.getSourceType(),rwsWQuality.getHabCode());
			session.setAttribute("sourceCodes",sourceCodes);
		}
		else
			session.setAttribute("editCheck","N");
			session.setAttribute("watersamples",waterSample);
			return waterSample;
	}
			
			
			
	

public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
{
		int avns = 0;
//		System.out.println("in execute method");
		String message=null;
		String displaymess=null;
		ArrayList watersamples=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchyats=new ArrayList();
		ArrayList villages=new ArrayList();
		//ArrayList prhabs=new ArrayList();
		ArrayList circles, divisions, subdivisions;
		HttpSession session=request.getSession();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		WaterSampleForm waterSample=(WaterSampleForm) form;
		String mode=waterSample.getMode();
		String mode1=request.getParameter("mode1");
		if(mode == null)
		{
			mode = mode1;
		}
		
		String headOfficeCode = rwsUser.getHeadOfficeCode();
		String circleOfficeCode = rwsUser.getCircleOfficeCode();
		String divisionOfficeCode = rwsUser.getDivisionOfficeCode();
		String subdivisionOfficeCode = rwsUser.getSubdivisionOfficeCode();
		String circle = waterSample.getCircleOfficeCode();
		String division = waterSample.getDivisionOfficeCode();
		String subdivision = waterSample.getSubdivisionOfficeCode();
		String mandalams = waterSample.getMandalCode();
		String panch = waterSample.getPanchayatCode();
		String habcodd = waterSample.getHabCode();
//		System.out.println("out side with::"+circle);
		if(circle == null || circle.equals("null") || circle.equals("")) 
		{
			circle = circleOfficeCode;
		}
		if(division == null || division.equals("null") || division.equals("")) division = divisionOfficeCode;
		if(subdivision == null || subdivision.equals("null") || subdivision.equals("")) subdivision = subdivisionOfficeCode;

		if(mode.equalsIgnoreCase("data"))
		{
	//		System.out.println("in side data");
			try
			{
	//			System.out.println("co code::"+circleOfficeCode);
	//			System.out.println("circle="+circleOfficeCode+"divison="+divisionOfficeCode+"subdiv="+subdivisionOfficeCode);
	//			System.out.println("circle="+request.getParameter("circleOfficeCode")+"divison="+request.getParameter("divisionOfficeCode")+"subdiv="+request.getParameter("subdivisionOfficeCode"));

					circles = rwsOffices.getCircles(headOfficeCode);
		//			System.out.println("Cirlce in java::"+circles.size());
					session.setAttribute("circles", circles);
					divisions = rwsOffices.getDivisions(headOfficeCode,circle);
					session.setAttribute("divisions", divisions);
					subdivisions = rwsOffices.getSubdivisions(headOfficeCode,circle,division);
					session.setAttribute("subdivisions", subdivisions);
					//mandals=RwsMasterData.getsubdivisionmandals(circleOfficeCode,divisionOfficeCode,subdivisionOfficeCode,getDataSource(request));
				    //session.setAttribute("mandals",mandals);
					mandals=RwsMasterData.getsubdivisionmandals(circle,division,subdivision,getDataSource(request));
					session.setAttribute("mandals",mandals);
					panchyats=rwsLocations.getPanchayats(circle,request.getParameter("mandalCode"));
						 prhabs = rwsLocations.getPanchayatHabitations(circle,request.getParameter("mandalCode"),request.getParameter("panchayatCode"));
						sources=RwsMasterData.getSources(getDataSource(request));
						session.removeAttribute("watertests");
						RwsMasterData rwsMasterData = new RwsMasterData();
						watertests=rwsMasterData.getWaterTests(getDataSource(request),rwsMasterData);
						rwsMasterData = null;
						desgns=RwsMasterData.getDesgns(getDataSource(request));
		//				System.out.println("calling getWQLabs");
						wqlabs=RwsMasterData.getWQLabs(getDataSource(request));
				ArrayList sourceCodes=new ArrayList();
				if(request.getParameter("sourceType")!=null)
				{
					if(!(request.getParameter("sourceType")).equalsIgnoreCase(""))
					{ 
						
		//				System.out.println("sourceType is "+request.getParameter("sourceType"));
						sourceCodes=RwsWQualityData.getSourceCodesWithLocation(getDataSource(request),request.getParameter("sourceType"),request.getParameter("habCode"));
		//				System.out.println("sourceCode.size is "+sourceCodes.size());
					}
				}
				if(request.getParameter("sourceCode")!=null)
				{
					if(!(request.getParameter("sourceCode")).equalsIgnoreCase(""))
					{ 
						
		//				System.out.println("sourceCode is "+request.getParameter("sourceCode"));
						String sourceLocation=RwsWQualityData.getSourceLocation(getDataSource(request),request.getParameter("sourceCode"));
						waterSample.setLocation(sourceLocation);
					}
				}
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchyats",panchyats);
				session.setAttribute("villages",villages);
				session.setAttribute("prhabs",prhabs);
				session.setAttribute("sources",sources);
				session.setAttribute("watertests",watertests);
				session.setAttribute("desgns",desgns);
				session.setAttribute("wqlabs",wqlabs);
				session.setAttribute("sourceCodes",sourceCodes);
				System.out.println("watertest size::"+watertests.size());
			}
			catch(Exception e)
			{
				System.out.println("The error in rws_WaterSample_frm data is=  "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("selectSource"))
		{
	//		System.out.println("select source");
			try
			{
			String sourceTypeCode=request.getParameter("sourceTypeCode");
			String sourceCode=request.getParameter("sourceCode");
			ArrayList sourceCodes=RwsWQualityData.getSourceCodesWithLocation(getDataSource(request),request.getParameter("sourceTypeCode"),request.getParameter("sourceCode").substring(0,16));
			waterSample.setSourceCode(request.getParameter("sourceCode"));
			waterSample.setSourceType(request.getParameter("sourceTypeCode"));
			
			session.setAttribute("sourceCodes",sourceCodes);
			
	//		System.out.println("hod code:"+request.getParameter("headOfficeCode"));
	//		System.out.println("mand code:"+request.getParameter("mandalCode"));
	//		System.out.println("panch code:"+request.getParameter("panchayatCode"));
	//		System.out.println("hab code:"+request.getParameter("habCode"));
			
			
			
			if(request.getParameter("headOfficeCode")!=null && !request.getParameter("circleOfficeCode").equals("") && !request.getParameter("divisionOfficeCode").equals("") && !request.getParameter("subdivisionOfficeCode").equals(""))
			{   //System.out.println("md");
				mandals=RwsMasterData.getsubdivisionmandals(request.getParameter("circleOfficeCode"),request.getParameter("divisionOfficeCode"),request.getParameter("subdivisionOfficeCode"),getDataSource(request));
				session.setAttribute("mandals",mandals);
			}   
			
			if(request.getParameter("mandalCode")!=null)
			{ 
				//System.out.println("mdc");
				if(!(waterSample.getMandalCode()).equalsIgnoreCase(""))
				{
					//System.out.println("md");
					//System.out.println("circleOfficeCode="+rwsUser.getCircleOfficeCode());
					if(!request.getParameter("circleOfficeCode").equals(""))
					 panchyats=rwsLocations.getPanchayat(request.getParameter("sourceCode"));
				//	System.out.println("panchyats.size()="+panchyats.size());
				}
			}
			if(request.getParameter("sourceCode") != null || request.getParameter("sourceCode") != "")
			{
			//	System.out.println(request.getParameter("sourceCode"));
				prhabs = rwsLocations.getPanchayatHabitations1(request.getParameter("sourceCode"));
			}
			
			/*if(request.getParameter("panchayatCode")!=null)
			{
				if(!(request.getParameter("panchayatCode")).equalsIgnoreCase(""))
				{
					if(!request.getParameter("circleOfficeCode").equals(""))
					 prhabs = rwsLocations.getPanchayatHabitations(request.getParameter("circleOfficeCode"),request.getParameter("mandalCode"),request.getParameter("panchayatCode"));
				}
			}
			*/
			session.setAttribute("mandals",mandals);
			session.setAttribute("panchyats",panchyats);
			session.setAttribute("prhabs",prhabs);
			session.setAttribute("habCode",session.getAttribute("habCode"));
			if(session.getAttribute("habCode") == null)
				request.setAttribute("special","special");
			else
				request.setAttribute("special","");
			
			}
			catch(Exception e)
			{
				System.out.println("An Exception has occured :"+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			System.out.println("view");
			try
			{
				String officeCode;
				if(request.getParameter("preparedBy")==null)
				officeCode=rwsUser.getOfficeCode();
				else officeCode=request.getParameter("preparedBy");
		//		System.out.println("waterSample.getPreparedBy()"+waterSample.getPreparedBy());
				watersamples=RwsWQualityData.getWaterSamples(officeCode,getDataSource(request));
			//	System.out.println("watersamples size is "+watersamples.size());
				session.setAttribute("watersamples",watersamples);
			}
			catch(Exception e)
			{
				System.out.println("An Exception has occured :"+e);
			}
				
		}
		
		if(mode.equalsIgnoreCase("viewSources"))
		{
	//		System.out.println("view sources");
			try{
			ArrayList sourcesList=null;
			ArrayList sss = (ArrayList) session.getAttribute("subdivisions");
			//System.out.println("sub div size in view sources:"+sss.size());
			String mandalCode=request.getParameter("mandalCode");
			String circlesOfficeCode = request.getParameter("circleOfficeCode");
			String panchayatCode = request.getParameter("panchayatCode");
			String habCode = request.getParameter("habCode");
			session.setAttribute("habCode",habCode);
//			System.out.println("circlesOfficeCode:"+circlesOfficeCode);
//			System.out.println("mandalCode:"+mandalCode);
//			System.out.println("panchayatCode:"+panchayatCode);
//			System.out.println("habCode:"+habCode);
//			System.out.println("habCode from watersample:"+waterSample.getHabCode());
			panchyats=rwsLocations.getPanchayats(circle,request.getParameter("mandalCode"));
			prhabs = rwsLocations.getPanchayatHabitations(circle,request.getParameter("mandalCode"),request.getParameter("panchayatCode"));
			sourcesList=RwsWQualityData.getSources(getDataSource(request),circlesOfficeCode,mandalCode,habCode,session);
	//		System.out.println("Source List Size::"+sourcesList.size());
			request.setAttribute("sourcesList",sourcesList);
			session.setAttribute("panchyats",panchyats);
			session.setAttribute("prhabs",prhabs);
			}
			catch(Exception e){
				System.out.println("Exception in viewSources is "+e);
			}
			
			
			mapping.findForward(mode);
		}
		if(mode.equalsIgnoreCase("save"))
		{
			System.out.println("save");
			try
			{
				RwsWQuality rwsWQuality = new RwsWQuality();
				

				rwsWQuality.setCoc(waterSample.getCircleOfficeCode());
				rwsWQuality.setDoc(waterSample.getDivisionOfficeCode());
				rwsWQuality.setSdoc(waterSample.getSubdivisionOfficeCode());
	//			System.out.println("sd code"+waterSample.getSubdivisionOfficeCode());
	//			System.out.println("sd code"+request.getParameter("subdivisionOfficeCode"));
				rwsWQuality.setTestId(waterSample.getTestId());
				rwsWQuality.setHabCode(waterSample.getHabCode());
//				System.out.println(waterSample.getHabCode());
				rwsWQuality.setSourceCode(waterSample.getSourceCode());     
				rwsWQuality.setSourceType(waterSample.getSourceType());     
				rwsWQuality.setTestCode(waterSample.getTestCode());      
				rwsWQuality.setLabCode(waterSample.getLabCode()); 
				rwsWQuality.setNatureOfTest(waterSample.getNatureOfTest());
				rwsWQuality.setSampCollectCode(waterSample.getSampCollectCode());
				rwsWQuality.setSampCollectDate(waterSample.getSampCollectDate());              
				rwsWQuality.setSampCollectTime(waterSample.getSampCollectTime());
				rwsWQuality.setAssignedOn(waterSample.getAssignedOn());  
				rwsWQuality.setPreparedBy(waterSample.getPreparedBy());   
				rwsWQuality.setPreparedOn(waterSample.getPreparedOn());  
				DAOMessage daoMessage=null;		
				if(rwsWQuality.getTestId().equals(""))
				{
					daoMessage=RwsWQualityData.insertWaterSample(rwsWQuality,getDataSource(request));
				}
				else
				{
					daoMessage=RwsWQualityData.updateWaterSample(rwsWQuality,getDataSource(request));
				}
				message=daoMessage.getMessage();
				
				request.setAttribute("message",message);
				waterSample.reset(mapping,request);	
			}
			
			catch(Exception e)
			{
				System.out.println("the error is in insert WaterSampleCollect= "+e);
			}
			
		
		}
		if(mode.equalsIgnoreCase("get"))
		{
			System.out.println("get");
//			System.out.println("test id:"+request.getParameter("testId"));
			try 
			{
	//			System.out.println("watch1");
				//form = buildWaterSampleForm(request.getParameter("testId"),request);
				form = buildWaterSampleForm2(request.getParameter("testId"),request);
//				System.out.println("watch2"); 
				
				if ("request".equals(mapping.getScope())) 
				{
	//				System.out.println("mapping.getAttribute is "+mapping.getAttribute());
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{
				System.out.println("The error in rws_waterSample_frm get is=  "+e);		
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			System.out.println("edit");
			try
			{
				RwsWQuality rwsWQuality = new RwsWQuality();
				
				rwsWQuality.setCoc(waterSample.getCircleOfficeCode());
				rwsWQuality.setDoc(waterSample.getDivisionOfficeCode());
				rwsWQuality.setSdoc(waterSample.getSubdivisionOfficeCode());
				rwsWQuality.setHabCode(waterSample.getHabCode());
				rwsWQuality.setSourceCode(waterSample.getSourceCode());         
				rwsWQuality.setTestCode(waterSample.getTestCode());      
				rwsWQuality.setLabCode(waterSample.getLabCode()); 
				rwsWQuality.setNatureOfTest(waterSample.getNatureOfTest());
				rwsWQuality.setSampCollectCode(waterSample.getSampCollectCode());
				rwsWQuality.setSampCollectDate(waterSample.getSampCollectDate());              
				rwsWQuality.setSampCollectTime(waterSample.getSampCollectTime());
				rwsWQuality.setAssignedOn(waterSample.getAssignedOn());  
				rwsWQuality.setPreparedBy(waterSample.getPreparedBy());   
				rwsWQuality.setPreparedOn(waterSample.getPreparedOn());  	
		
						
				RwsWQualityData.updateWaterSample(request.getParameter("testId"),rwsWQuality,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				System.out.println("the error is"+e);
			}
			
		}
		/*if(mode.equalsIgnoreCase("recordCheck"))
		{

			System.out.println("recordCheck");
			try 
			{
				String recordExist = "";
				recordExist = RwsWQualityData.recordExists(request.getParameter("testId"),getDataSource(request));
				System.out.println("recordExists in action ::"+recordExist);
				request.setAttribute("recordExist",recordExist);
			}
			catch (Exception e) 
			{
				System.out.println("Error is in this:"+e.getMessage());
			}
		}*/
		if(mode.equalsIgnoreCase("delete"))
		{
			System.out.println("delete");
			try 
			{
				int del=RwsWQualityData.removeWaterSample(request.getParameter("testId"),getDataSource(request));
				if(del>0)
				{
					displaymess = "Data deleted Succesfully";
				}
				else if(del == -1)
				{
					displaymess = "Test Results found with this Source! Data cannot be deleted!! ";
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
		if(mode.equals("reset"))
		{
			//waterSample.reset(mapping,request);
			waterSample.setTestId("");
			waterSample.setCircleOfficeCode("");
			waterSample.setDivisionOfficeCode("");
			waterSample.setSubdivisionOfficeCode("");
			waterSample.setPanchayatCode("");
			waterSample.setVillageCode("");
			waterSample.setMandalCode("");
			waterSample.setHabCode("");
			waterSample.setSourceCode("");
			waterSample.setSourceType("");
			waterSample.setTestCode("");
			waterSample.setNatureOfTest("");
			waterSample.setLabCode("");
			waterSample.setSampCollectCode("");
			waterSample.setSampCollectDate("");
			waterSample.setSampCollectTime("");
			waterSample.setAssignedTo("");
			waterSample.setAssignedOn("");
			waterSample.setPreparedBy("");
			waterSample.setPreparedOn("");
			waterSample.setMode("");
			waterSample.setLocation("");
		}
		
		return(mapping.findForward(mode));
	}
}

