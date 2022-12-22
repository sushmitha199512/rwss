/*
 * Created on 23-11-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.wquality;

/**
 * @author RWSS_DPT1
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
	
	import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.DAOMessage;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.RwsMasterData;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

	public class RwsWQLabTestingParamAction  extends Action	{
		ArrayList sources=new ArrayList();
		ArrayList wqlabs=new ArrayList();
		ArrayList watertests=new ArrayList();
		ArrayList desgns=new ArrayList();
		ArrayList prhabs=new ArrayList();
		RwsMasterData rwsMasterData = new RwsMasterData();
		RwsWQualityParamData rwsMasterData1=new RwsWQualityParamData();
		RwsWQLabDAO rwsWQLabDAO=new RwsWQLabDAO();
		protected ActionForm buildWaterSampleForm(String testId,HttpServletRequest request) throws Exception 
		{					
			RwsWQLabTestingForm waterSample = null;
			HttpSession session=request.getSession();
			RwsWQuality rwsWQuality=RwsWQualityParamData.getWaterSample(testId,getDataSource(request));
				if(rwsWQuality!=null) {
					waterSample = new RwsWQLabTestingForm();
					String habcode=rwsWQuality.getHabCode();
					RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
					RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
					prhabs = rwsLocations.getHabitations(rwsUser.getCircleOfficeCode(),habcode.substring(5,7),habcode.substring(12,14),habcode.substring(7,10));
					
					sources=RwsMasterData.getSources(getDataSource(request));
					watertests=rwsMasterData1.getWaterTests(getDataSource(request),rwsMasterData);
					desgns=RwsMasterData.getDesgns(getDataSource(request));
					wqlabs=RwsMasterData.getWQLabs(getDataSource(request));
					
					session.setAttribute("sources1",sources);
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

		
		protected ActionForm buildWaterSampleForm2(String testId,HttpServletRequest request) throws Exception {
			WaterSampleForm waterSample = null;
			RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
			RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
			HttpSession session=request.getSession();
			RwsWQuality rwsWQuality=RwsWQualityParamData.getWaterSample(testId,getDataSource(request));
	        
			if(rwsWQuality!=null){
				session.setAttribute("editCheck","Y");
				waterSample = new WaterSampleForm();
				String habcode=rwsWQuality.getHabCode();
				RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
				prhabs = rwsLocations.getHabitations(rwsUser.getCircleOfficeCode(),habcode.substring(5,7),habcode.substring(12,14),habcode.substring(7,10));
				sources=RwsMasterData.getSources(getDataSource(request));
				watertests=rwsMasterData1.getWaterTests(getDataSource(request),rwsMasterData);
				desgns=RwsMasterData.getDesgns(getDataSource(request));
				wqlabs=RwsMasterData.getWQLabs1(habcode.substring(0,2));
				session.setAttribute("wqlabs",wqlabs);
				session.setAttribute("sources1",sources); 
				session.setAttribute("watertests",watertests);
				session.setAttribute("desgns",desgns);
				session.setAttribute("prhabs",prhabs);
				waterSample.setCircleOfficeCode(rwsWQuality.getCoc());
				waterSample.setDivisionOfficeCode(rwsWQuality.getDoc());
				waterSample.setSubdivisionOfficeCode(rwsWQuality.getSdoc());
				waterSample.setMandalCode(rwsWQuality.getMandalCode());
				waterSample.setPanchayatCode(rwsWQuality.getPanchCode());
				waterSample.setVillageCode(rwsWQuality.getVillageCode());
				waterSample.setTestId(rwsWQuality.getTestId());
				waterSample.setHabCode(rwsWQuality.getHabCode());
				waterSample.setSourceType(rwsWQuality.getSourceType());
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
				waterSample.setCircleOfficeName(rwsWQuality.getCircleOfficeName());
				waterSample.setDivisionOfficeName(rwsWQuality.getDivisionOfficeName());
				waterSample.setSubDivisionOfficeName(rwsWQuality.getSubDivisionOfficeName());
				request.setAttribute("circleOfficeName",rwsWQuality.getCircleOfficeName());
				request.setAttribute("divisionOfficeName",rwsWQuality.getDivisionOfficeName());
				request.setAttribute("subDivisionOfficeName",rwsWQuality.getSubDivisionOfficeName());
				waterSample.setCircleOfficeName(rwsWQuality.getCircleOfficeName());	
				waterSample.setDivisionOfficeName(rwsWQuality.getDivisionOfficeName());
				waterSample.setSubDivisionOfficeName(rwsWQuality.getSubDivisionOfficeName());
				waterSample.setMandalCode(rwsWQuality.getMandalCode());
				waterSample.setMandalName(rwsWQuality.getMandalName());
				waterSample.setPanchayatCode(rwsWQuality.getPanchCode());
				waterSample.setPanchayatName(rwsWQuality.getPanchName());
				waterSample.setHabCode(rwsWQuality.getHabCode());
				waterSample.setHabName(rwsWQuality.getHabName());			
				
				ArrayList circles = rwsOffices.getCircles("1");
				request.setAttribute("circles", circles);
				
				ArrayList divisions = rwsOffices.getDivisions("1",rwsWQuality.getCoc());
				request.setAttribute("divisions", divisions);
				
				ArrayList subdivisions = rwsOffices.getSubdivisions("1",rwsWQuality.getCoc(),rwsWQuality.getDoc());
				request.setAttribute("subdivisions", subdivisions);		
				
				ArrayList mandals=RwsMasterData.getDivSubdiv(getDataSource(request),rwsWQuality.getHabCode());
				RwsMaster rm = (RwsMaster)mandals.get(0);
				waterSample.setDivisionOfficeCode(rm.getDivisionOfficeCode());
				waterSample.setSubdivisionOfficeCode(rm.getSubdivisionOfficeCode());
				waterSample.setHabCode(rwsWQuality.getHabCode());
				
				String division=rm.getDivisionOfficeCode();
				String subdivision=rm.getSubdivisionOfficeCode();
				ArrayList mandal=RwsMasterData.getMandals(getDataSource(request),rwsWQuality.getCoc(),division,subdivision);
				
				RwsMaster rm1 = (RwsMaster)mandal.get(0);
				waterSample.setMandalCode(rwsWQuality.getHabCode().substring(5,7));
				session.setAttribute("mandals",mandal);
				ArrayList panchyats=rwsLocations.getPanchayats(rwsWQuality.getCoc(),rwsWQuality.getHabCode().substring(5,7));
				session.setAttribute("panchyats",panchyats);				
				prhabs = rwsLocations.getPanchayatHabitations(rwsWQuality.getCoc(),rwsWQuality.getHabCode().substring(5,7),rwsWQuality.getHabCode().substring(12,14));
				session.setAttribute("prhabs",prhabs);
				
				ArrayList sourceCodes=RwsWQualityParamData.getSourceCodesWithLocation(getDataSource(request),rwsWQuality.getSourceType(),rwsWQuality.getHabCode());
				session.setAttribute("sourceCodes",sourceCodes);
			}	else	{
					session.setAttribute("editCheck","N");
					session.setAttribute("watersamples",waterSample);
					request.setAttribute("message","Sample Cannot edited because of Test Parameter Values already entered for this sample");
			}
			return waterSample;
		}  		
		
		protected ActionForm buildWaterSampleFormftk1(String ftktestId,String sourceCode,HttpServletRequest request) throws Exception {
			WaterSampleForm waterSample = null;
			RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
			RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
			RwsWQualityParamData rwsWqualitydata=new RwsWQualityParamData();
			HttpSession session=request.getSession();
			ArrayList wqlist = RwsWQualityParamData.getftkListDetails(getDataSource(request),request.getParameter("sourceCode"),request.getParameter("ftktestid"));
			request.setAttribute("wqlist",wqlist);
		    RwsWQuality bean =RwsWQualityParamData.getWaterSampleftk1(sourceCode,ftktestId,sourceCode.substring(0,16));
			if(bean!=null)
			{
					session.setAttribute("editCheck1","Y");
					waterSample = new WaterSampleForm();
					String habcode=bean.getHabCode();
					RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
					
					prhabs = rwsLocations.getHabitations(rwsUser.getCircleOfficeCode(),habcode.substring(5,7),habcode.substring(12,14),habcode.substring(7,10));
					sources=RwsMasterData.getSources(getDataSource(request));
					watertests=rwsMasterData1.getWaterTests(getDataSource(request),rwsMasterData);
					session.setAttribute("sources1",sources);
					session.setAttribute("watertests",watertests);
					session.setAttribute("prhabs",prhabs);
					waterSample.setFtktestid(bean.getFtktestid());
					waterSample.setHabCode(bean.getHabCode());
					waterSample.setSourceType(bean.getSourceType());
					waterSample.setSourceCode(bean.getSourceCode()); 
					String rs=rwsWqualitydata.contaminValue(getDataSource(request),request.getParameter("ftktestid"));
					waterSample.setContamin(rs);							
					waterSample.setForwardDate(bean.getForwardDate());  
					waterSample.setFtkTestDate(bean.getFtkTestDate()); 
					session.setAttribute("contaminvalue", rs);
					request.setAttribute("contamin","YES");
					request.setAttribute("circleOfficeName",bean.getCircleOfficeName());
					waterSample.setCircleOfficeCode(bean.getCircleOfficeCode());
					waterSample.setCircleOfficeName(bean.getCircleOfficeName());	
					waterSample.setDivisionOfficeCode(bean.getDivisionOfficeCode());	
					waterSample.setDivisionOfficeName(bean.getDivisionOfficeName());	
					waterSample.setSubdivisionOfficeCode(bean.getSubdivisionOfficeCode());	
					waterSample.setSubDivisionOfficeName(bean.getSubDivisionOfficeName());
					waterSample.setMandalCode(bean.getMandalCode());
					waterSample.setMandalName(bean.getMandalName());
					waterSample.setPanchayatCode(bean.getPanchCode());
					waterSample.setPanchayatName(bean.getPanchName());
					waterSample.setHabCode(bean.getHabCode());
					waterSample.setHabName(bean.getHabName());
			
				ArrayList circles = rwsOffices.getCircles("1");
				request.setAttribute("circles", circles);
				ArrayList sourceCodes=RwsWQualityParamData.getSourceCodesWithLocation(getDataSource(request),bean.getSourceType(),bean.getHabCode());
				session.setAttribute("sourceCodes",sourceCodes);
			}
			else
				session.setAttribute("editCheck1","N");
				session.setAttribute("watersamples",waterSample);
				return waterSample;
		}
		protected ActionForm buildWaterSampleFormftk(String sourceCode,String ftktestId,HttpServletRequest request) throws Exception {
			
			WaterSampleForm waterSample = null;
			RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
			RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
			RwsWQualityParamData rwsWqualitydata=new RwsWQualityParamData();
			HttpSession session=request.getSession();
			ArrayList wqlist = RwsWQualityParamData.getftkListDetails(getDataSource(request),request.getParameter("sourceCode"),request.getParameter("ftktestid"));
		    request.setAttribute("wqlist",wqlist);
		    RwsWQuality bean =RwsWQualityParamData.getWaterSampleftk(request.getParameter("sourceCode"),request.getParameter("ftktestid"),getDataSource(request));
			if(bean!=null)
			{
					session.setAttribute("editCheck1","Y");
					waterSample = new WaterSampleForm();
					String habcode=bean.getHabCode();
					RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");					
					prhabs = rwsLocations.getHabitations(rwsUser.getCircleOfficeCode(),habcode.substring(5,7),habcode.substring(12,14),habcode.substring(7,10));
					sources=RwsMasterData.getSources(getDataSource(request));
					watertests=rwsMasterData1.getWaterTests(getDataSource(request),rwsMasterData);
					
					session.setAttribute("sources1",sources);
					session.setAttribute("watertests",watertests);
					session.setAttribute("prhabs",prhabs);
					
					waterSample.setCircleOfficeCode(bean.getCoc());
					waterSample.setDivisionOfficeCode(bean.getDoc());
					waterSample.setSubdivisionOfficeCode(bean.getSdoc());
					waterSample.setMandalCode(bean.getMandalCode());
					waterSample.setPanchayatCode(bean.getPanchCode());
					waterSample.setVillageCode(bean.getVillageCode());
					waterSample.setFtktestid(bean.getFtktestid());
					waterSample.setHabCode(bean.getHabCode());
					waterSample.setSourceType(bean.getSourceType());
					waterSample.setSourceCode(bean.getSourceCode()); 					
					
					String rs=rwsWqualitydata.contaminValue(getDataSource(request),request.getParameter("ftktestid"));
					
					waterSample.setContamin(rs);							
					waterSample.setForwardDate(bean.getForwardDate());  
					waterSample.setFtkTestDate(bean.getFtkTestDate()); 
					session.setAttribute("contaminvalue", rs);
					request.setAttribute("contamin","YES");
					request.setAttribute("circleOfficeName",bean.getCircleOfficeName());			
			
				ArrayList circles = rwsOffices.getCircles("1");
				request.setAttribute("circles", circles);
				ArrayList mandals=RwsMasterData.getDivSubdiv(getDataSource(request),bean.getHabCode());
				RwsMaster rm = (RwsMaster)mandals.get(0);
				waterSample.setDivisionOfficeCode(rm.getDivisionOfficeCode());
				waterSample.setSubdivisionOfficeCode(rm.getSubdivisionOfficeCode());
				waterSample.setHabCode(bean.getHabCode());
				ArrayList panchyats=rwsLocations.getPanchayats(bean.getCoc(),bean.getHabCode().substring(5,7));
				session.setAttribute("panchyats",panchyats);
				prhabs = rwsLocations.getPanchayatHabitations(bean.getCoc(),bean.getHabCode().substring(5,7),bean.getHabCode().substring(12,14));
				session.setAttribute("prhabs",prhabs);
				ArrayList sourceCodes=RwsWQualityParamData.getSourceCodesWithLocation(getDataSource(request),bean.getSourceType(),bean.getHabCode());
				session.setAttribute("sourceCodes",sourceCodes);
			}
			else
				session.setAttribute("editCheck1","N");
				session.setAttribute("watersamples",waterSample);
				return waterSample;
		}		
		protected ActionForm buildWaterSampleFormftolab(String sourceCode,String ftktestId,HttpServletRequest request) throws Exception 
		{
			
			WaterSampleForm waterSample = new WaterSampleForm();
			RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
			RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
			HttpSession session=request.getSession();
		    RwsWQuality bean  =RwsWQualityParamData.getWaterSampleftk(request.getParameter("sourceCode"),request.getParameter("ftktestid"),getDataSource(request));
	   		if(bean!=null)
			{
				String habcode=bean.getHabCode();
				RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
				prhabs = rwsLocations.getHabitations(habcode.substring(0,2),bean.getMandalCode(),bean.getPanchCode(),habcode.substring(7,10));
				sources=RwsMasterData.getSources(getDataSource(request));
				watertests=rwsMasterData1.getWaterTests(getDataSource(request),rwsMasterData);
				desgns=RwsMasterData.getDesgns(getDataSource(request));
				wqlabs=RwsMasterData.getWQLabs(getDataSource(request));
				ArrayList circles = rwsOffices.getCircles("1");
				request.setAttribute("circles", circles);
				ArrayList divisions = rwsOffices.getDivisions(rwsUser.getHeadOfficeCode(),bean.getCoc());
				session.setAttribute("divisions", divisions);
				ArrayList panchyats=rwsLocations.getPanchayats(bean.getCoc(),bean.getHabCode().substring(5,7));
				session.setAttribute("panchyats",panchyats);
				ArrayList mandals=RwsMasterData.getDivSubdiv(getDataSource(request),bean.getHabCode());
				RwsMaster rm = (RwsMaster)mandals.get(0);
				waterSample.setCircleOfficeCode(bean.getCoc());
				waterSample.setDivisionOfficeCode(rm.getDivisionOfficeCode());
				waterSample.setSubdivisionOfficeCode(rm.getSubdivisionOfficeCode());
				String division=rm.getDivisionOfficeCode();
				String subdivision=rm.getSubdivisionOfficeCode();
				ArrayList mandal=RwsMasterData.getMandals(getDataSource(request),bean.getCoc(),division,subdivision);
				RwsMaster rm1 = (RwsMaster)mandal.get(0);
				waterSample.setMandalCode(rm1.getMandalCode());
				waterSample.setMandalCode(bean.getMandalCode());
				waterSample.setPanchayatCode(bean.getPanchCode());
				waterSample.setHabCode(bean.getHabCode());
				session.setAttribute("mandals",mandal);
				session.setAttribute("sources1",sources);
				session.setAttribute("watertests",watertests);
				session.setAttribute("desgns",desgns);
				session.setAttribute("wqlabs",wqlabs);
				session.setAttribute("prhabs",prhabs);
				waterSample.setSourceType(bean.getSourceType());
				waterSample.setSourceCode(bean.getSourceCode());
				waterSample.setFtktestid(ftktestId);
		} 
		else  			
			session.setAttribute("watersamples",waterSample);
			return waterSample;
		}	
		

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {
			int avns = 0;
			String message=null;
			String displaymess=null;
			ArrayList watersamples=new ArrayList();
			ArrayList mandals=new ArrayList();
			ArrayList panchyats=new ArrayList();
			ArrayList villages=new ArrayList();			
			ArrayList circles=null, divisions=null, subdivisions=null;
			HttpSession session=request.getSession();
			String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
			RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
			RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
			if(rwsUser==null)
				return mapping.findForward("expire");
			if(rwsUser.getUserId()!= null && !(rwsUser.getUserId().equals(Constants.ADMIN) || rwsUser.getUserId().equals(Constants.LAKH_USER) || Constants.IsWaterQualityUser(rwsUser.getUserId())  || Constants.IsUser(rwsUser.getUserId()) )) {
				return mapping.findForward("unAuthorise");	
			}
			RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
			RwsWQLabTestingForm waterSample=(RwsWQLabTestingForm) form;
			String mode=waterSample.getMode();
			String mode1=request.getParameter("mode1");
			if(mode == null){
				mode = mode1; 
			}
			
			String headOfficeCode="1"; 
			String circleOfficeCode = rwsUser.getCircleOfficeCode();
			String divisionOfficeCode = rwsUser.getDivisionOfficeCode();
			String subdivisionOfficeCode = rwsUser.getSubdivisionOfficeCode();
			String circle = waterSample.getCircleOfficeCode();
			String division = waterSample.getDivisionOfficeCode();
			String subdivision = waterSample.getSubdivisionOfficeCode();
			String mandalams = waterSample.getMandalCode();
			String panch = waterSample.getPanchayatCode();
			String habcodd = waterSample.getHabCode();
			session.setAttribute("forwarded","NO");
			session.setAttribute("forwardedsurcCode","");
			session.setAttribute("forwardedsurcType","");
			session.setAttribute("forwardedftkid","");
			if(circle == null || circle.equals("null") || circle.equals("")){
				circle = circleOfficeCode;
			}
			if(division == null || division.equals("null") || division.equals("")){
	    		division = divisionOfficeCode;
			}
			if(subdivision == null || subdivision.equals("null") || subdivision.equals("")){
				subdivision = subdivisionOfficeCode;
			}
			if(headOfficeCode == null){
				headOfficeCode = rwsUser.getHeadOfficeCode();
			}			
			if(circleOfficeCode == null){
				circleOfficeCode = rwsUser.getCircleOfficeCode(); 
			}
			if(divisionOfficeCode == null){
				divisionOfficeCode = rwsUser.getDivisionOfficeCode();
			}
			if(subdivisionOfficeCode == null || subdivisionOfficeCode.equals("")){
				subdivisionOfficeCode = rwsUser.getSubdivisionOfficeCode();
			}			
			if(mode.equalsIgnoreCase("data") ){ 
				session.setAttribute("wqtestParams",new ArrayList());				
				try	{    
					if(waterSample.getCircleOfficeCode()==null){
						circles = rwsOffices.getCircles(headOfficeCode);
						session.setAttribute("circles", circles);
					}
					if(rwsUser.getCircleOfficeCode()!=null)	{
						divisions = rwsOffices.getDivisions(headOfficeCode,circle);
						  session.setAttribute("divisions", divisions);						  
					} else {
						session.setAttribute("divisions", new ArrayList());							
					}
					if(rwsUser.getSubdivisionOfficeCode()!=null && !circle.equals("00") && !division.equals("0") ){
						subdivisions = rwsOffices.getSubdivisions(headOfficeCode,circle,division);
						session.setAttribute("subdivisions", subdivisions);	
					}
					else{
						session.setAttribute("subdivisions", new ArrayList());
					}
					if(circle!=null && !circle.equals("") && divisions!=null && !divisions.equals("") && subdivisions!=null && !subdivisions.equals("")){
							mandals=RwsMasterData.getMandals(getDataSource(request),circle,division,subdivision);
							session.setAttribute("mandals",mandals);
					}					
					ArrayList sourceCodes=new ArrayList();
					if(waterSample.getFtklab().equals("ftk")){
						mandals=RwsMasterData.getMandals(getDataSource(request),circle,division,subdivision);
						session.setAttribute("mandals",mandals);
						if(waterSample.getMandalCode()!=null){
							panchyats=rwsLocations.getPanchayats(circle,request.getParameter("mandalCode"));
							session.setAttribute("panchyats",panchyats);
						} else{
							session.setAttribute("panchyats",new ArrayList());
						}
						if(waterSample.getPanchayatCode()!=null){
							prhabs = rwsLocations.getPanchayatHabitations(circle,request.getParameter("mandalCode"),request.getParameter("panchayatCode"));
							session.setAttribute("prhabs",prhabs);
						}
						else{
							session.setAttribute("prhabs",new ArrayList());	
						}
						sources=RwsMasterData.getSources(getDataSource(request));
						session.setAttribute("sources1",sources);
						session.setAttribute("sourceCodes",sourceCodes);
					    
					if(waterSample.getFtklab().equals("ftk") && !(request.getParameter("sourceCode")).equalsIgnoreCase("")) {		        	
			        	String ftktestid=RwsWQualityParamData.getftkTestId(request.getParameter("sourceCode"),getDataSource(request));
			        	waterSample.setFtktestid(ftktestid);
		        	}
					if(waterSample.getSourceType()!=null && waterSample.getFtklab().equals("ftk")){ 
						if(!(request.getParameter("sourceType")).equalsIgnoreCase("")){ 
							sourceCodes=RwsWQualityParamData.getSourceCodesWithLocation(getDataSource(request),request.getParameter("sourceType"),request.getParameter("habCode"));
						}
						session.setAttribute("sourceCodes",sourceCodes);
					}
					if(request.getParameter("mode1")!=null && request.getParameter("mode1").equals("formftk")){						
						waterSample.setMandalCode(request.getParameter("mandalCode"));
						waterSample.setPanchayatCode(request.getParameter("panchayatCode"));
						waterSample.setHabCode(request.getParameter("habCode"));
						waterSample.setSourceType(request.getParameter("sourceType"));
						waterSample.setSourceCode(request.getParameter("sourceCode"));
						session.setAttribute("panchyats",new ArrayList());
						session.setAttribute("villages",new ArrayList());
						session.setAttribute("prhabs",new ArrayList());
						session.setAttribute("sources1",new ArrayList());
						session.setAttribute("watertests",new ArrayList());
						session.setAttribute("desgns",new ArrayList());
						session.setAttribute("wqlabs",new ArrayList());
						session.setAttribute("sourceCodes",new ArrayList());					
					}
				}
				else if(waterSample.getFtklab().equals("lab")){
					if(circle!=null && !circle.equals("") && divisions!=null && !divisions.equals("") && subdivisions!=null && !subdivisions.equals("")){
						mandals=RwsMasterData.getMandals(getDataSource(request),circle,division,subdivision);
						session.setAttribute("mandals",mandals);
					}					
					if(circle!=null && !circle.equals("") && mandals!=null && !mandals.equals("")){
						panchyats=rwsLocations.getPanchayats(circle,request.getParameter("mandalCode"));
						session.setAttribute("panchyats",panchyats);					
					} 
					else{
						session.setAttribute("panchyats",new ArrayList());
					}  					
					if(circle!=null && !circle.equals("") && request.getParameter("mandalCode")!=null && !request.getParameter("mandalCode").equals("") && request.getParameter("panchayatCode")!=null && !request.getParameter("panchayatCode").equals("")){
						prhabs = rwsLocations.getPanchayatHabitations(circle,request.getParameter("mandalCode"),request.getParameter("panchayatCode"));
						session.setAttribute("prhabs",prhabs);		
					}  
					else{  
						session.setAttribute("prhabs",new ArrayList());  
					}
					sources=RwsMasterData.getSources(getDataSource(request));
					session.setAttribute("sources1",sources); 
						RwsMasterData rwsMasterData = new RwsMasterData();
						watertests=rwsMasterData1.getWaterTests(getDataSource(request),rwsMasterData);
						session.setAttribute("watertests",watertests);
						desgns=RwsMasterData.getDesgns(getDataSource(request));
						session.setAttribute("desgns",desgns);
						if(waterSample.getCircleOfficeCode()!=null && !waterSample.getCircleOfficeCode().equals(""))
						wqlabs=RwsMasterData.getWQLabs1(waterSample.getCircleOfficeCode());
						session.setAttribute("wqlabs",wqlabs);
						session.setAttribute("sourceCodes",sourceCodes);
						if(request.getParameter("sourceType")!=null && waterSample.getFtklab().equals("lab")){	
							if(!(request.getParameter("sourceType")).equalsIgnoreCase("")){  
								waterSample.setFtktestid("");								
								sourceCodes=RwsWQualityData.getSourceCodesWithLocation1(getDataSource(request),request.getParameter("sourceType"),request.getParameter("habCode"));
							}
							session.setAttribute("sourceCodes",sourceCodes);
						} 
						if(request.getParameter("mode1")!=null && request.getParameter("mode1").equals("formlab")){	
						waterSample.setMandalCode(request.getParameter("mandalCode"));
						waterSample.setPanchayatCode(request.getParameter("panchayatCode"));
						waterSample.setHabCode(request.getParameter("habCode"));
						waterSample.setSourceType(request.getParameter("sourceType"));
						waterSample.setSourceCode(request.getParameter("sourceCode"));
						session.setAttribute("panchyats",new ArrayList());
						session.setAttribute("villages",new ArrayList());
						session.setAttribute("prhabs",new ArrayList());
						session.setAttribute("sources1",new ArrayList());
						session.setAttribute("watertests",new ArrayList());
						session.setAttribute("desgns",new ArrayList());
						session.setAttribute("wqlabs",new ArrayList());
						session.setAttribute("sourceCodes",new ArrayList());						
					}	 
				}  
				if(request.getParameter("sourceCode")!=null ){
					if(!(request.getParameter("sourceCode")).equalsIgnoreCase("")){ 
						String sourceLocation=RwsWQualityParamData.getSourceLocation(getDataSource(request),request.getParameter("sourceCode"));
						waterSample.setLocation(sourceLocation);
					}
				}					
			}
			catch(Exception e) {
					System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
				}				
			} 

			if(mode.equalsIgnoreCase("selectftkSource")){
				try	{
					ArrayList sourceCodes=new ArrayList();
					String sourceTypeCode=request.getParameter("sourceTypeCode");
					String sourceCode=request.getParameter("sourceCode");
					sourceCodes=RwsWQualityParamData.getSourceCodesWithLocation(getDataSource(request),request.getParameter("sourceTypeCode"),request.getParameter("sourceCode").substring(0,16));
					waterSample.setSourceCode(request.getParameter("sourceCode"));
					waterSample.setSourceType(request.getParameter("sourceTypeCode"));
					session.setAttribute("sourceCodes",sourceCodes);	
				
					if(request.getParameter("headOfficeCode")!=null && !request.getParameter("circleOfficeCode").equals("") && !request.getParameter("divisionOfficeCode").equals("") && !request.getParameter("subdivisionOfficeCode").equals("")){   
						mandals=RwsMasterData.getMandals(getDataSource(request),request.getParameter("circleOfficeCode"),request.getParameter("divisionOfficeCode"),request.getParameter("subdivisionOfficeCode"));
						session.setAttribute("mandals",mandals);
					}   					
					if(request.getParameter("mandalCode")!=null){ 
						if(!(waterSample.getMandalCode()).equalsIgnoreCase("")){
							 if(!request.getParameter("circleOfficeCode").equals(""))
							 panchyats=rwsLocations.getPanchayat(request.getParameter("sourceCode"));
						}
					}
					if(request.getParameter("sourceCode") != null || request.getParameter("sourceCode") != ""){
						prhabs = rwsLocations.getPanchayatHabitations1(request.getParameter("sourceCode"));
					}				
					
					session.setAttribute("mandals",mandals);
					session.setAttribute("panchyats",panchyats);
					session.setAttribute("prhabs",prhabs);
					session.setAttribute("habCode",session.getAttribute("habCode"));
					if(session.getAttribute("habCode") == null)
						request.setAttribute("special","special");
					else
						request.setAttribute("special","");					
				}
				catch(Exception e){
					System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
				}
			}
			
			if(mode.equalsIgnoreCase("parameters")){
				 try{
					ArrayList parameters=RwsWQualityParamData.getWQTestParameterCodes(getDataSource(request),waterSample.getTestCode(),"1");
					waterSample.setWqtestParams(parameters);				
				 }catch(Exception e){
					 System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
				 }
				return mapping.findForward("data");
			}
			
			if(mode.equalsIgnoreCase("selectSource")){		
				try	{
						waterSample.setFtktestid("");						
						ArrayList sourceCodes=new ArrayList();
						String sourceTypeCode=request.getParameter("sourceTypeCode");
						String sourceCode=request.getParameter("sourceCode");
						waterSample.setSourceCode(request.getParameter("sourceCode"));
						sourceCodes=RwsWQualityParamData.getSourceCodesWithLocation(getDataSource(request),request.getParameter("sourceTypeCode"),request.getParameter("sourceCode").substring(0,16));
						waterSample.setSourceType(request.getParameter("sourceTypeCode"));
						session.setAttribute("sourceCodes",sourceCodes);
						session.setAttribute("habCode",session.getAttribute("habCode"));
						if(session.getAttribute("habCode") == null)
							request.setAttribute("special","special");
						else
							request.setAttribute("special","");					
				}				
				catch(Exception e){
					System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
				}				
			}
			
			if(mode.equals("delete"))
			{
				if (storedToken.equals(token)){	
					int del=0;
					try {  
						 waterSample.setTestId(request.getParameter("testId"));
						 del=RwsWQualityParamData.removeWaterSample(request.getParameter("testId"),getDataSource(request));
						 if(del>0){
							displaymess = "Data deleted Succesfully";
							mode = "View";
							waterSample.setCircleOfficeCode(request.getParameter("coc"));
							waterSample.setDivisionOfficeCode(request.getParameter("doc"));
							waterSample.setSubdivisionOfficeCode(request.getParameter("sdoc"));
							waterSample.setMandalCode(request.getParameter("mandalCode"));
						}
						else {
							displaymess = "Quality Tests Exists for this Sample - Failed to delete";
						} 
						request.setAttribute("displaymess",displaymess);	
					}
					catch (Exception e) {
						System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
					}
			     }else{
					 return mapping.findForward("unAuthorise");
				 }
			}
			
			if(mode.equals("Deleteftk")){
				if (storedToken.equals(token)){
					int del=0;
				    try {   
							waterSample.setFtktestid(request.getParameter("ftktestid"));
							waterSample.setSourceCode(request.getParameter("sourceCode"));
							del=RwsWQualityParamData.removeWaterSampleftk(request.getParameter("ftktestid"),request.getParameter("sourceCode"),getDataSource(request));
						if(del>0){
							displaymess = "Data deleted Succesfully";
							mode = "view";
							waterSample.setCircleOfficeCode(request.getParameter("coc"));
							waterSample.setDivisionOfficeCode(request.getParameter("doc"));
							waterSample.setSubdivisionOfficeCode(request.getParameter("sdoc"));
							waterSample.setMandalCode(request.getParameter("mandalCode"));
						} 						 
						else {
							displaymess = "Data cannot be deleted";
						}
						
						request.setAttribute("displaymess",displaymess);						
					}
					catch (Exception e) {
						System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
					}
					
			     }else{
					 return mapping.findForward("unAuthorise");
				 }
			}
			
			if(mode.equals("View")){  
				try	{
					String officeCode;
					if(request.getParameter("preparedBy")==null)
					officeCode=rwsUser.getOfficeCode();
					else officeCode=request.getParameter("preparedBy");
					watersamples=RwsWQualityParamData.getWaterSamples(officeCode,waterSample,getDataSource(request));
					session.setAttribute("watersamples",watersamples);
				}
				catch(Exception e){
					System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
				}					
			}
			
			if(mode.equals("view"))
			{   
				try	{
						String officeCode;
						if(request.getParameter("preparedBy")==null)
						officeCode=rwsUser.getOfficeCode();
						else officeCode=request.getParameter("preparedBy");
						watersamples=RwsWQualityParamData.getfktdetails(officeCode,waterSample,getDataSource(request));
						session.setAttribute("watersamples",watersamples);
				}
				catch(Exception e){ 
					System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
				}					
			}
			
			if(mode.equalsIgnoreCase("viewSources")){
				try{
						ArrayList sourcesList=null;
						String mandalCode=request.getParameter("mandalCode");
						String circlesOfficeCode = request.getParameter("circleOfficeCode");
						String panchayatCode = request.getParameter("panchayatCode");
						String habCode = request.getParameter("habCode");
						panchyats=rwsLocations.getPanchayats(circle,request.getParameter("mandalCode"));
						prhabs = rwsLocations.getPanchayatHabitations(circle,request.getParameter("mandalCode"),request.getParameter("panchayatCode"));
						sources=RwsMasterData.getSources(getDataSource(request));
						sourcesList=RwsWQualityParamData.getSources(getDataSource(request),circlesOfficeCode,mandalCode,habCode,session);
						request.setAttribute("sources1",sources);
						request.setAttribute("sourcesList",sourcesList);
						session.setAttribute("panchyats",panchyats);
						session.setAttribute("prhabs",prhabs);	              
				}
				catch(Exception e){
					System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
				}	
				mapping.findForward(mode);
			}
			
			if(mode.equalsIgnoreCase("viewftkSources"))	{
				try{
					ArrayList sourcesList=null;
					ArrayList sss = (ArrayList) session.getAttribute("subdivisions");
					String mandalCode=request.getParameter("mandalCode");
					String circlesOfficeCode = request.getParameter("circleOfficeCode");
					String panchayatCode = request.getParameter("panchayatCode");
					String habCode = request.getParameter("habCode");
					session.setAttribute("panchayatCode",panchayatCode);
					session.setAttribute("habCode",habCode);
					panchyats=rwsLocations.getPanchayats(circle,request.getParameter("mandalCode"));
					prhabs = rwsLocations.getPanchayatHabitations(circle,request.getParameter("mandalCode"),request.getParameter("panchayatCode"));
					sources=RwsMasterData.getSources(getDataSource(request));
				
					sourcesList=RwsWQualityParamData.getftkSources(getDataSource(request),circlesOfficeCode,mandalCode,habCode,session);
				
					request.setAttribute("sources1",sources);
					request.setAttribute("sourcesList",sourcesList);
					session.setAttribute("panchyats",panchyats);
					session.setAttribute("prhabs",prhabs);
				}
				catch(Exception e){
					System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
				}	
				mapping.findForward(mode);
			}
			if(mode.equalsIgnoreCase("save")){    				
				
				
				if (storedToken.equals(token)){
					RwsWQualityParamData rwsWQualityParamData=new RwsWQualityParamData();
					try	{     
						RwsWQuality rwsWQuality = new RwsWQuality();				
						rwsWQuality.setFtklab(waterSample.getFtklab());	
						rwsWQuality.setForwardDate(waterSample.getForwardDate());
						rwsWQuality.setForwardtolab(waterSample.getForwardtolab());
						rwsWQuality.setFtkTestDate(waterSample.getFtkTestDate());				
						
						rwsWQuality.setCoc(waterSample.getCircleOfficeCode());
						rwsWQuality.setDoc(waterSample.getDivisionOfficeCode());
						rwsWQuality.setSdoc(waterSample.getSubdivisionOfficeCode());
					    rwsWQuality.setTestId(waterSample.getTestId());
						rwsWQuality.setHabCode(waterSample.getHabCode());
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
						rwsWQuality.setFtktestid(waterSample.getFtktestid());
						
						DAOMessage daoMessage=null;								
										
						   rwsWQuality.setCondemnSource(waterSample.getCondemTheSource());
						   rwsWQuality.setUpdateSource(waterSample.getUpdateSourceData());
						   rwsWQuality.setRecommendations(waterSample.getRecomended());
						   rwsWQuality.setPreparedOn(waterSample.getTestDate());
						   rwsWQuality.setForwadedOn(waterSample.getForwardedOn());
						   
						   daoMessage=rwsWQualityParamData.insertWQLabSamplesAndResults1(rwsWQuality,request,waterSample.getPotable());
						   
							message=daoMessage.getMessage();
							request.setAttribute("message",message);
							reset(waterSample);							
							  
						if(waterSample.getFtklab().equalsIgnoreCase("Lab") && !rwsWQuality.getTestId().equals("")){
							daoMessage=RwsWQualityParamData.updateWaterSample(rwsWQuality,getDataSource(request));							
							message=daoMessage.getMessage();							
							request.setAttribute("message",message);
						}		
						
					}
					catch(Exception e){
						System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
					}
				ArrayList a = (ArrayList)session.getAttribute("prhabs");
				return mapping.findForward(mode);
			}else{
				 return mapping.findForward("unAuthorise");
			 }
		}
			
		if(mode.equalsIgnoreCase("get")){
				try {
		           	if(waterSample.getFtklab().equals("ftk")){
		           		form = buildWaterSampleFormftk1(request.getParameter("ftktestid"),request.getParameter("sourceCode"),request);
					} 
		           	else if(waterSample.getFtklab().equals("lab")){
		           		form = buildWaterSampleForm2(request.getParameter("testId"),request);    
					  if(RwsWQualityParamData.checkIsExists(request.getParameter("testId"))){
					  	mode="close";
					  }
					}
					if ("request".equals(mapping.getScope())) {
						request.setAttribute(mapping.getAttribute(), form);
					}
					else {
						session.setAttribute(mapping.getAttribute(), form);
					}
				}
				catch (Exception e) {
					System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());	
				}
			}
		
			if(mode.equalsIgnoreCase("forwardtolab")){				
				try {
					form = buildWaterSampleFormftolab(request.getParameter("sourceCode"),request.getParameter("ftktestid"),request);
					if ("request".equals(mapping.getScope())) {
						request.setAttribute(mapping.getAttribute(), form);
					}
					else {
						session.setAttribute(mapping.getAttribute(), form);
					}
				}
				catch (Exception e) {
					System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());	
				}
			}
			
			if(mode.equalsIgnoreCase("edit")){
				 if (storedToken.equals(token)){
						try	{
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
								
						RwsWQualityParamData.updateWaterSample(request.getParameter("testId"),rwsWQuality,getDataSource(request));
						
					}
					catch (Exception e) {
						System.out.println("An Exception in RwsWQLabTestingParamAction :"+e.getMessage());
					}
				 }else{
					 return mapping.findForward("unAuthorise");
				 }				
			}
			
			if(mode.equalsIgnoreCase("dataedit")){
				try {
					panchyats=rwsLocations.getPanchayats(request.getParameter("sourceCode").substring(0,2),request.getParameter("sourceCode").substring(5,7));
					
					session.setAttribute("panchyats",panchyats);
					prhabs = rwsLocations.getPanchayatHabitations(request.getParameter("sourceCode").substring(0,2),request.getParameter("sourceCode").substring(5,7),request.getParameter("sourceCode").substring(12,14));
					session.setAttribute("prhabs",prhabs);
					session.setAttribute("contaminvalue",request.getParameter("contamin"));
					mode = "get";
					session.setAttribute("editCheck1","Y");
				} catch (Exception e) {					
					e.printStackTrace();
				}
			}
						
			if(mode.equals("reset")){
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
				waterSample.setFtktestid("");
				
			}
			return(mapping.findForward(mode));
		}
		public void reset(RwsWQLabTestingForm waterSample){
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
			waterSample.setLocation("");
			waterSample.setTestDate("");
			waterSample.setRecomended("");
		}
	}
