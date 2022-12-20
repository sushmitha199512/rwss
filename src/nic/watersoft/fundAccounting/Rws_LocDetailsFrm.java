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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionMapping;


import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionForm;
import org.apache.commons.beanutils.BeanUtils;

import nic.watersoft.fundAccounting.Rws_LocDetailsBean;
import nic.watersoft.fundAccounting.Rws_LocDetailsForm;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

public class Rws_LocDetailsFrm extends Action 
{
	
    /* (non-Javadoc)
     * @see org.apache.struts.action.Action#execute(org.apache.struts.action.ActionMapping, org.apache.struts.action.ActionForm, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest 
			request,HttpServletResponse response)
	{
    	HttpSession session=request.getSession();
    	RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
    	Debug.println("user:"+user);
    	if(user==null){
    		return mapping.findForward("expire");
    	}
    	Debug.println("user2:"+user);
    	final String userId=user.getOfficeCode();
    	final String officeType=user.getOfficeName();
    	Rws_LocDetailsForm frm=(Rws_LocDetailsForm)form;
    	Rws_BroData broData=new Rws_BroData(getDataSource(request));
    	String mode=request.getParameter("mode");
    	
    	//String target="success"; 
    	Debug.println("userID:"+user);
    	
    	
    	
    	ArrayList emptyList=new ArrayList(0);
    	//// System.out.println("officeType is "+officeType);
    	Debug.println("mode is "+mode);
    	try
		{
    		if(mode!=null && mode.equals("init"))
	    	{
    			// System.out.println("bro id in init mode:"+frm.getBroId());
	    		session.setAttribute("locDetailsList",emptyList);
    			frm.setLocDetailsList(emptyList);
	    		CommonLists commonLists=new CommonLists(getDataSource(request));
	    		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
	    		
	    		ArrayList programmsList=commonLists.getProgrammes();
	    		session.setAttribute("programmsList",programmsList);
	    		
	    		ArrayList districtList=rwsLocations.getDistricts();
	    		session.setAttribute("districtList",districtList);
	    		    		
	    	}
    		
    		
    		if(mode!=null && mode.equals("programmeChanged"))
	    	{
    			CommonLists commonLists=new CommonLists(getDataSource(request));
    			RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
    			ArrayList locDetailsList=frm.getLocDetailsList();
    			int rowId=Integer.parseInt(request.getParameter("rowId"));
    			Rws_LocProgDetailsBean locProgDetailsBean=(Rws_LocProgDetailsBean)locDetailsList.get(rowId);
    			
    			//// System.out.println("*******District name in LOC***********"+locProgDetailsBean.getDistrictName());
    			
    			
    			
    			
    			
	    		ArrayList subProgrammesList = commonLists.getSubprogrammes2(locProgDetailsBean.getProgram(),frm.getBroId());
	    		locProgDetailsBean.setSubProgrammesList(subProgrammesList);
	    		//// System.out.println("officesList size in programmeChanged mode is "+locProgDetailsBean.getOfficeList().size());
	    		locProgDetailsBean.setWorkIdList(broData.getWorkIdListForDivision(frm.getBroId(),frm.getLocId(),locProgDetailsBean.getProgram(),userId));
	    		locDetailsList.set(Integer.parseInt(request.getParameter("rowId")),locProgDetailsBean);
	    		ArrayList officesList=rwsOffices.getAllDivisionsWithOfficeCode1(locProgDetailsBean.getDistrict());
	    		ArrayList paoList=commonLists.getPaoList(locProgDetailsBean.getDistrict());
	    		locDetailsList=setOfficeList(locDetailsList,officesList,locProgDetailsBean.getProject(),Integer.parseInt(request.getParameter("rowId")),paoList);
	    		
	    		
	    		//session.setAttribute("paoList",paoList);
	    		//locProgDetailsBean.setPaoList(paoList);
	    		locDetailsList.set(rowId,locProgDetailsBean);
	    		session.setAttribute("locDetailsList",locDetailsList);
	    		
	    		frm.setLocDetailsList(locDetailsList);
	    		printLocDetailsListSizes(frm.getLocDetailsList());
	    		
	    		//getWorkIdListForDivision(String broId,String locId,String programmeCode,String officeCode) throws Exception
	    		String news = (String)session.getAttribute("hello");
	    		//// System.out.println("Hello in program Changed:"+news);
	    		session.setAttribute("hello",news);
	    	}
    		
    		if(mode!=null && mode.equals("getCircles"))
	    	{
    			RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
    			CommonLists commonLists=new CommonLists(getDataSource(request));
	    		
    			ArrayList officesList=rwsOffices.getAllCirclesWithOfficeCode("1");
    			Object o1=new Object();
    			
    			ArrayList locDetailsList = frm.getLocDetailsList();
    			
    			
    			locDetailsList=setOfficeList(locDetailsList,officesList,null,Integer.parseInt(request.getParameter("index")),null);
    			locDetailsList=setWorkIdList(locDetailsList,emptyList,Integer.parseInt(request.getParameter("index")));
    			session.setAttribute("locDetailsList",locDetailsList);
	    	}
			if(mode!=null && mode.equals("getDiv"))
			{
				RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
				ArrayList divisions=rwsOffices.getAllDivisionsWithOfficeCode1(request.getParameter("district"));
				request.setAttribute("divisions",divisions);
			}
    		if(mode!=null && mode.equals("getDivisions"))
	    	{
			
    			CommonLists commonLists=new CommonLists(getDataSource(request));
	    		ArrayList officesList=new ArrayList(emptyList);
    			RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
    			
    			//ArrayList locDetailsList=frm.getLocDetailsList();
    			
    			//to be changed to get the subdivisions from the selected district
    			ArrayList locDetailsList = frm.getLocDetailsList();
    			
    			
    			//ArrayList wrksform=frm.getWorks();
    			
    			//Rws_LocDetailsForm locform=(Rws_LocDetailsForm)wrksform.get(0);
    			 
    			//// System.out.println("IN loc progdetails bean workid"+locform.getW   
    			
    			
    			//// System.out.println("in getdivisions2");
    			Rws_LocProgDetailsBean locProgDetailsBean=new Rws_LocProgDetailsBean();
    			
    			try
    			{
    			     //// System.out.println("row id"+);
    			    String row_id=request.getParameter("rowid");
    			    if(row_id!=null)
    			   locProgDetailsBean=(Rws_LocProgDetailsBean)locDetailsList.get(Integer.parseInt(row_id));
    			    
    			    
    			    //locProgDetailsBean=(Rws_LocProgDetailsBean)locDetailsList.get(0);
    			}
    			catch(Exception e)
    			{
    			    e.printStackTrace();
    			
    			}
    			
    		//	// System.out.println("DIstrict Name###"+locProgDetailsBean.getDistrict());
    			//// System.out.println("in getdivisions2");


    			officesList=rwsOffices.getAllDivisionsWithOfficeCode1(request.getParameter("district"));
    			//request.setAttribute
    			//// System.out.println("in getdivisions2");
    			//// System.out.println("locDetailsList size is "+locDetailsList.size());
    			ArrayList paoList=commonLists.getPaoList(locProgDetailsBean.getDistrict());
    			locDetailsList=setOfficeList(locDetailsList,officesList,locProgDetailsBean.getProject(),Integer.parseInt(request.getParameter("index")),paoList);
    	//		// System.out.println("in getdivisions3");
//    			code to get workId list(This code is executed only in headOffice Login and when project checkbox is checked
	    		//ArrayList workIdList=commonLists.getAdminWorkIdsAsIds(userId.substring(1,3));
	    		//session.setAttribute("workIdList",workIdList);
    		//	// System.out.println("in getdivisions4");
    			
    			locDetailsList=setWorkIdList(locDetailsList,commonLists,Integer.parseInt(request.getParameter("index")));
    			session.setAttribute("locDetailsList",locDetailsList);

    //	// System.out.println("in getdivisions5");
    			String news = (String)session.getAttribute("hello");
    		//	// System.out.println("Hello value in get divisions:"+news);
	    		session.setAttribute("hello",news);
    				    		
	    	}
    		if(mode!=null && mode.equals("data"))
	    	{
    			RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
	    		session.setAttribute("locIdList",emptyList);
	    		session.setAttribute("circleLocIdList",emptyList);
    			
    			//frm.setProject("off");
    			
    			//// System.out.println("office is "+user.getOfficeName());
    			ArrayList BROIdList=broData.getBroIdList(userId);
    			session.setAttribute("BROIdList",BROIdList);
    			
    			
    			session.setAttribute("EAmode","data");
    			
    			session.setAttribute("locDetailsList",emptyList);//??this line is commented and no line is added
	    		CommonLists commonLists=new CommonLists(getDataSource(request));
	    		
	    		
	    		/*ArrayList programmsList=commonLists.getProgrammes();
	    		session.setAttribute("programmsList",programmsList);*/
	    		
	    		//code to get workId list(This code is executed only in headOffice Login and when project checkbox is checked
	    		//ArrayList workIdList=commonLists.getAdminWorkIdsAsIds(userId.substring(1,3));
	    		//session.setAttribute("workIdList",workIdList);
	    		
	    		ArrayList districtList=rwsLocations.getDistricts();
	    		session.setAttribute("districtList",districtList);
	    		
	    		/*ArrayList headOfAccountList=commonLists.getHeadOfAccountList();
	    		session.setAttribute("headOfAccountList",headOfAccountList);
	    		
	    		ArrayList paoList=commonLists.getPaoList("");
	    		session.setAttribute("paoList",paoList);
	    		*/
	    		
	    		
	    		session.setAttribute("grantedAmtProgWiseList",emptyList);
	    		
	    		resetFrm(frm,session);
	    		
	    		
	    	}
    		if(mode!=null && mode.equals("addNew"))
	    	{
    			resetFrm1(frm,session);
    			
	    		CommonLists commonLists=new CommonLists(getDataSource(request));
	    		
	    		// System.out.println("bro id in add new mode:"+frm.getBroId());
	    		
	    		//ArrayList programmsList=commonLists.getProgrammes();
	    		ArrayList programmsList=broData.getBroProgrammsList(frm.getBroId(),userId);
	    		session.setAttribute("programmsList",programmsList);
	    		
	    		ArrayList headOfAccountList=commonLists.getHeadOfAccountList1(frm.getBroId());
	    		session.setAttribute("headOfAccountList",headOfAccountList);
	    		
	    		session.setAttribute("grantedAmtProgWiseList",emptyList);
	    		
	    		
	    		//session.setAttribute("mode","addNew");
	    		session.setAttribute("EAmode","addNew");
	    		// System.out.println("end of add new");
	    	}
    		if(mode!=null && mode.equals("addNewProgrammeForLoc"))
	    	{
	    		//// System.out.println("in addNewProgrammeForLoc mode");
	    		//// System.out.println("getting details from from bean");
    			try
				{
    				// System.out.println("frm.getLocReference():"+frm.getLocReference());
    				frm.setLocId(frm.getLocId());
    				frm.setLocReference(frm.getLocReference());
    			CommonLists commonLists=new CommonLists(getDataSource(request));
	    		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
	    		ArrayList locDetailsList=new ArrayList(frm.getLocDetailsList());
	    		printLocDetailsListSizes(locDetailsList);
	    		if(locDetailsList==null)
	    		{
	    			locDetailsList=new ArrayList();
	    			session.setAttribute("locDetailsList",emptyList);
	    		}
	    		Rws_LocProgDetailsBean locProgDetailsBean=new Rws_LocProgDetailsBean();
	    		//locProgDetailsBean.setProject("off");
	    		locProgDetailsBean.setDistrictName(rwsOffices.getDistrictName(userId.substring(1,3)));
	    		locProgDetailsBean.setDistrict(userId.substring(1,3));
	    		locProgDetailsBean.setLocDate(frm.getLocRelDate());
	    		
	    		ArrayList paoList=commonLists.getPaoList(locProgDetailsBean.getDistrict());
	    		//session.setAttribute("paoList",paoList);
	    		locProgDetailsBean.setPaoList(paoList);
	    	/*	ArrayList officesList=null;
	    		if(userId.equals("100000"))
	    			officesList=rwsOffices.getAllDivisionsWithOfficeCode1(locProgDetailsBean.getDistrict());
	    		else
	    			officesList=broData.getLowerOffices(userId);
	    		
	    		locProgDetailsBean.setOfficeList(officesList);*/
	    		if(officeType.equals("Division Office"))
	    		{
	    			locProgDetailsBean.setWorkIdList(broData.getWorkIdListForDivision(frm.getBroId(),frm.getLocId(),userId));
	    		
	    		}
    				
	    		locDetailsList.add(locProgDetailsBean);
	    		//// System.out.println("size of locDetailsList after adding is "+locDetailsList.size());
	    		session.setAttribute("locDetailsList",locDetailsList);
	    		frm.setLocDetailsList(locDetailsList);
	    		//frm.setLocReference("abc");
	    		
	    		
	    		//// System.out.println("grantedAmount "+broData.getGrantedAmount(frm.getBroId(),userId)+"");
				}
    			catch(Exception e)
				{
    				e.printStackTrace();
				}
    			session.setAttribute("hello","new");
	    	}
    		
    		if(mode!=null && mode.equals("getCircleLocIdList"))
	    	{
    			ArrayList circleLocIdList=broData.getCircleLocIdList(frm.getBroId(),frm.getLocId(),userId);
    			session.setAttribute("circleLocIdList",circleLocIdList);
    		}
    		if(mode!=null && mode.equals("save"))
	    	{
    			// System.out.println(" in save of LOC");
    			Rws_LocDetailsBean locDetailsBean=new Rws_LocDetailsBean();
    			String insertMode=(String) session.getAttribute("EAmode");
    			// System.out.println("after getting insert mode");
    			ArrayList locDetailsList=frm.getLocDetailsList();
    			// System.out.println("bro id:"+frm.getBroId());
    			// System.out.println("loc id:"+frm.getLocId());
    			BeanUtils.copyProperties(locDetailsBean,frm);
    			// System.out.println("broId is "+locDetailsBean.getBroId());
    			ArrayList locProgDetailsList=frm.getLocDetailsList();
    			//for display purpose
    			for(int i=0;i<locProgDetailsList.size();i++)
            	{
    				Rws_LocProgDetailsBean locProgDetailsBean=(Rws_LocProgDetailsBean)locProgDetailsList.get(i);
    				
    				Debug.println("officeCode is "+locProgDetailsBean.getOffice());
            		
            	}
            	// System.out.println("loc size"+locDetailsList.size());
    			//end of display purpose
    			session.setAttribute("locDetailsList",locDetailsList);
    			// System.out.println("before inset called");
    			DAOMessage daoMessage=broData.insertLocDetails(locDetailsBean,locDetailsList,insertMode,userId);
    			// System.out.println("after inset called");
    			String message=daoMessage.getMessage();
    			ArrayList locIdList=broData.getLocIdList();
    			
    			//session.setAttribute("locIdList",locIdList);
    			
    			request.setAttribute("locId",frm.getLocId());
    			if(message!=null)
    				request.setAttribute("message",message);
    			
    			if(daoMessage.getCode()<0)
    				mode="saveError";
    			
	    	} 
    		
    		if(mode!=null && mode.equals("HOA"))
    		{
    			String news = (String)session.getAttribute("hello");
	    		// System.out.println("the new value in workId:"+news);
	    		
    			//// System.out.println("in mode workId with Program:"+request.getParameter("program"));
    			//// System.out.println("in mode workId with sub Program:"+request.getParameter("subprogram"));
    			String get = "";
    			String count = request.getParameter("count");
    			session.setAttribute("count",count);
    			if(request.getParameter("get") != null)get  = request.getParameter("get");
    			ArrayList locDetailsList=frm.getLocDetailsList();
    			request.setAttribute("locDetailsList",locDetailsList);
    			String work_id = request.getParameter("work_id");
    			String program="",subprogram="";
    			
    		
    			try
				{
    				ArrayList works = new ArrayList();
    			    program=request.getParameter("program");
					subprogram=request.getParameter("subprogram"); 
       				works = broData.getHeadOfAccountListForLOC(request.getParameter("broId"));
       				Debug.println("head size:"+works.size());
       				session.setAttribute("HoaList",works);
       				//frm.setWorks(works);
				}
    			catch(Exception e) 
				{
    				//// System.out.println("in gettting work id's error:"+e.getMessage());
    			    e.printStackTrace();
				}
    		}
    		
    		if(mode!=null && mode.equals("workId"))
    		{
    			try{
    			String news = (String)session.getAttribute("hello");
	    		//// System.out.println("the new value in workId:"+news);
	    		String dist=request.getParameter("district");
	    		request.setAttribute("district",dist);
	    		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
				ArrayList divisions=rwsOffices.getDivisions("1",dist);
				request.setAttribute("divisions",divisions);
				
				ArrayList programs=rwsOffices.getProgrammes("1",dist,"","");
				request.setAttribute("programs",programs);
				ArrayList wrkcat=rwsOffices.getWorkCategory();
				request.setAttribute("wrkcat",wrkcat);
				//// System.out.println("before work id getting");
				//String work_id = request.getParameter("work_id");
    			String program="",workcat="",division="";
				//district =work_id.substring(4,6);
				//// System.out.println("1111111111111");
				program=request.getParameter("program1");
				//// System.out.println("2222222222222");
				ArrayList works = new ArrayList();	  
				division=request.getParameter("division");
				//// System.out.println("333333333333333");
				workcat=request.getParameter("wrkcat1");
				//// System.out.println("111:"+request.getParameter("special"));
				if(request.getParameter("special")!=null && request.getParameter("special").equals("1")){
				works = broData.getWorks(dist,division,program,workcat);
				frm.setWorks(works);
				request.setAttribute("workslist","yes");
				}else{
					frm.setWorks(new ArrayList());
				}
    			}
    			catch(Exception e)
				{
    				//// System.out.println("in gettting work id's error:"+e.getMessage());
    			    e.printStackTrace();
				}
    		} 
				
				/*
				// System.out.println("in mode workId with Program:");
    			//// System.out.println("in mode workId with sub Program:"+request.getParameter("subprogram"));
    			String get = "";
    			String count = request.getParameter("count");
    			session.setAttribute("count",count);
    			if(request.getParameter("get") != null)get  = request.getParameter("get");
    			ArrayList locDetailsList=frm.getLocDetailsList();
    			request.setAttribute("locDetailsList",locDetailsList);
    			String work_id = request.getParameter("work_id");
    			String program="",workcat="",division="";
    			
    		/*	for(int i=work_id.length()-1;i<14;i++)
    			{
    			    work_id="0"+work_id;
    			}*/
    			//// System.out.println("Work Id in work id mode:"+request.getParameter("work_id"));
    			/*try
				{
    				ArrayList d = new ArrayList();
    				ArrayList financialYearsList = new ArrayList();
    				ArrayList works = new ArrayList();
    				RwsOffices r = new RwsOffices(getDataSource(request));
    				String district = "",year = "";
    				
    				if(request.getParameter("district") != null)
    				{
    					district = request.getParameter("district");
    	
    				}
    				program=request.getParameter("program");
  					
    				division=request.getParameter("division");
    				workcat=request.getParameter("wrkcat");
    				works = broData.getWorks(district,division,program,workcat);
    				frm.setWorks(works);
    				request.setAttribute("workslist","yes");
    				/*if(request.getParameter("year") != null)
    				{
    					year = request.getParameter("year");
    				}*/
    				
        			/*// System.out.println("workid***"+work_id);
        			// System.out.println("year:"+year);
        			String date = "";
        			if(work_id != null && !work_id.equals(""))
    				{
    					date = r.getAdminDate(work_id);
    					/*
    					 * 
    					 * commented by kiran  
    					request.setAttribute("distName",work_id.substring(4,6)); 
    					request.setAttribute("distName",district);*/
    					
    					/*request.setAttribute("district",district);

    					request.setAttribute("year",date);
    					d = r.getDistrictsCodesNames();
    					
    					/*
    					 * commented by kiran
    					 * request.setAttribute("districts",d);
    					 * session.setAttribute("districts",d);
    					*/
    					/*program=request.getParameter("program");
    					//subprogram=request.getParameter("subprogram");
    					request.setAttribute("program",program);
    					//request.setAttribute("subprogram",subprogram);
    					
    					
    					//// System.out.println("Programme code"+program+"subprogram"+subprogram);

    					
    				
    					financialYearsList=broData.getReleasesVsExpenditureYearsList1();
    					request.setAttribute("financialYearsList",financialYearsList);
	        			request.setAttribute("some","some");
    				}
        			else
        			{
	        			
        			    request.setAttribute("district",district);
        			    program=request.getParameter("program");
    					//subprogram=request.getParameter("subprogram");
    					request.setAttribute("program",program);
    					//request.setAttribute("subprogram",subprogram);    					
        				financialYearsList=broData.getReleasesVsExpenditureYearsList();
	        			request.setAttribute("financialYearsList",financialYearsList);
        			}
        			// System.out.println("arraylist d size:"+d.size());
        			if(get.equals("1"))
        			{
        			    program=request.getParameter("program");
    					  					
	       				division=request.getParameter("division");
	       				workcat=request.getParameter("wrkcat");
    					works = broData.getWorks(district,division,program,workcat);
	       				frm.setWorks(works);
	       				request.setAttribute("workslist","yes");
        			}*/
        			
				
    		if(mode!=null && mode.equals("view"))
			{
				ArrayList locDetailsList;  
				//locDetailsList=broData.getLocList();
				String broid=frm.getBroId();
				String locid=frm.getLocId();
				System.out.println("locid:"+locid);
				locDetailsList=broData.getLocList(userId,officeType,broid,locid);
				//// System.out.println("locDetails sizes is "+locDetailsList.size());
				session.setAttribute("locDetailsListFromView",locDetailsList);
			}
    		if(mode!=null && mode.equals("getLocProgDetails"))
    		{  
    			// System.out.println(" gfhdgsfh");
    			ArrayList locProgDetailsList1;
    			String locId=request.getParameter("locId");
    			String broId=request.getParameter("broId");
    			//locProgDetailsList=broData.getLocProgDetails(locId);
    			Debug.println("111111111");
    			locProgDetailsList1=broData.getLocProgDetailsViewList(broId,locId,userId);
    			Debug.println("2222222");  
    			// System.out.println("locProgDetails sizes is "+locProgDetailsList1.size());
    			request.setAttribute("locProgDetailsList1",locProgDetailsList1);
    		}
    		if(mode!=null && mode.equals("broIdChangedInSaveMode"))
    		{ 
    			Rws_LocDetailsBean locDetailsBean = new Rws_LocDetailsBean();
    			BeanUtils.copyProperties(locDetailsBean,frm); 
    			//locDetailsBean=broData.getBroRefDetails(frm.getBroId());
    			locDetailsBean=broData.getBroRefDetails(frm.getBroId(),userId);
    			// System.out.println("bro ref:"+locDetailsBean.getBroReference());
    			BeanUtils.copyProperties(frm,locDetailsBean);
    			
    			ArrayList programmsList=broData.getBroProgrammsList(frm.getBroId(),userId);
    			session.setAttribute("programmsList",programmsList);
    			
    			ArrayList grantedAmtProgWiseList=broData.getGrantedAmtProgWiseList(frm.getBroId(),userId);
    			//ArrayList grantedAmtProgWiseList=broData.getGrantedAmtProgWiseList(frm.getBroId(),frm.getLocId(),userId);
    			session.setAttribute("grantedAmtProgWiseList",grantedAmtProgWiseList);
    			
    			
    			if(!userId.equals("100000"))
    			{
    				ArrayList locIdList=broData.getLocIdList(frm.getBroId(),userId);
        			session.setAttribute("locIdList",locIdList);
        			
    			}
	    			
    			
    		}
    		if(mode!=null && mode.equals("broIdChangedInEditMode"))
    		{
    			Rws_LocDetailsBean locDetailsBean = new Rws_LocDetailsBean();
    			String broId=frm.getBroId();
    			resetFrm(frm,session);
    			// System.out.println("bro ref in form after:"+frm.getBroReference());
    			//BeanUtils.copyProperties(locDetailsBean,frm);
    			locDetailsBean=broData.getBroRefDetails(broId,userId);
    			// System.out.println("bro ref:"+locDetailsBean.getBroReference());
    			BeanUtils.copyProperties(frm,locDetailsBean);
    			// System.out.println("bro ref in form after:"+frm.getBroReference());
    			request.setAttribute("br",frm.getBroReference());
    			ArrayList locIdList=broData.getLocIdList(broId,userId);
    			session.setAttribute("locIdList",locIdList);
    			// System.out.println("111111111");
    			ArrayList programmsList=broData.getBroProgrammsList(frm.getBroId(),userId);
    			session.setAttribute("programmsList",programmsList);
    			
    			
	    		
    		}
    		if(mode!=null && mode.equals("edit"))
    		{
    			CommonLists commonLists=new CommonLists(getDataSource(request));
	    		// System.out.println(" in edit mode");  
    			String locId="";
    			String broId="";
    			String circleLocId="";
    			RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
    			//used only in the case of circle login
    			circleLocId=frm.getCircleLocId();
    			//// System.out.println("circleLocId="+circleLocId);
    			ArrayList locDetailsList = null;
    			if(request.getParameter("special") == null){
    				locDetailsList=frm.getLocDetailsList();}
    			else
    			{
    				locDetailsList = (ArrayList)request.getAttribute("locDetailsList");
    			}
    			//// System.out.println("locDetailsList size:"+locDetailsList.size());
    			if(request.getParameter("locId")!=null)
    				locId=request.getParameter("locId");
    			else
    				locId=(String)request.getAttribute("locId");
    			//// System.out.println("finally LocId:"+locId);
    			if(request.getParameter("circleLocId")!=null)
    				circleLocId=request.getParameter("circleLocId");
    			else
    				circleLocId=(String)request.getAttribute("circleLocId");
    			
    			broId = frm.getBroId();
    			//ArrayList locDetailsList;
    			//ArrayList locIdList=broData.getLocIdList(frm.getBroId());
    			
    			// System.out.println(" in edit mode 1");  
    			ArrayList locIdList=broData.getLocIdList(frm.getBroId(),userId);
    			session.setAttribute("locIdList",locIdList);
    			//// System.out.println("**********************:"+frm.getLocId());
    			if(!frm.getLocId().equals(""))
    			{
    				resetFrm(frm,session);
    				Rws_LocDetailsBean locDetailsBean=null;
    				if(!officeType.equals("Circle Office")){
    					locDetailsBean=broData.getLoc(locId,broId,userId);
    						
    				}
    				else
    				{
    					locDetailsBean=broData.getLoc(locId,broId,circleLocId,userId);
    				//	// System.out.println("In else");
    				}
    				
    				 System.out.println("Loc reference is *******"+frm.getLocReference());
        			BeanUtils.copyProperties(frm,locDetailsBean);
        		}
    			else
    			{
    				resetLocDetails(frm,session);
    			}
    			
    			//locDetailsList=broData.getLocProgDetails(locId);
    			// System.out.println(" in edit mode 2");  
    			if(!officeType.equals("Circle Office"))
    				locDetailsList=broData.getLocProgDetails(locId,userId,frm.getCircleLocId(),broId);
    			else
    				locDetailsList=broData.getLocProgDetails(locId,frm.getCircleLocId(),userId);
    			//// System.out.println("locDetailsList.size():"+locDetailsList.size());
    			//code added
    			//// System.out.println("**************:"+request.getParameter("workId"));
    			//request.setAttribute("workId",request.getParameter("workId"));
    			try
				{
    				//// System.out.println("*****************Size:"+locDetailsList.size());
	    			for(int i=0;i<locDetailsList.size();i++)
	    			{
	    				locDetailsList=setWorkIdList(locDetailsList,commonLists,i);
	    				Rws_LocProgDetailsBean locProgDetailsBean=(Rws_LocProgDetailsBean)locDetailsList.get(i);
	    				ArrayList officesList=rwsOffices.getAllDivisionsWithOfficeCode1(locProgDetailsBean.getDistrict());
	    				ArrayList paoList=commonLists.getPaoList(locProgDetailsBean.getDistrict());
	    				locDetailsList=setOfficeList(locDetailsList,officesList,locProgDetailsBean.getProject(),i,paoList);
	    	    		
	    	    		//locProgDetailsBean.setPaoApaoFlag("true");
	    	     		//session.setAttribute("paoList",paoList);
	    	    	//	// System.out.println("District id in prog details bean***"+locProgDetailsBean.getDistrict());	    	   
	    	    		
	    	    		
	    	    		ArrayList headOfAccountList=commonLists.getHeadOfAccountList1(frm.getBroId());
	    	    		session.setAttribute("headOfAccountList",headOfAccountList);
	    			}
				}
    			catch(Exception e)
				{
    				// System.out.println("exception in ******************:"+e.getMessage());
				}
	    			
    			// System.out.println(" in edit mode 3");  
    			session.setAttribute("locDetailsList",locDetailsList);//??
    			frm.setLocDetailsList(locDetailsList);
	    		
    			ArrayList programmsList=null;
    			programmsList=broData.getBroProgrammsList(frm.getBroId(),userId);
    			session.setAttribute("programmsList",programmsList);
    			
    			//// System.out.println("grantedAmount "+broData.getGrantedAmount(frm.getBroId(),userId)+"");
    			//session.setAttribute("mode","data");
    			session.setAttribute("EAmode","data");
    			
    			//code added
    			ArrayList grantedAmtProgWiseList=null;
    			if(!officeType.equals("Circle Office"))
    				grantedAmtProgWiseList=broData.getGrantedAmtProgWiseList(frm.getBroId(),frm.getLocId(),userId);
    			else
    				grantedAmtProgWiseList=broData.getGrantedAmtProgWiseList(frm.getBroId(),frm.getLocId(),frm.getCircleLocId(),userId);
    			//ArrayList grantedAmtProgWiseList=broData.getGrantedAmtProgWiseList(frm.getBroId(),frm.getLocId(),userId);
    			session.setAttribute("grantedAmtProgWiseList",grantedAmtProgWiseList);
    			// System.out.println(" in edit mode 4");  
    			if(officeType.equals("Circle Office"))
    			{
    				ArrayList circleLocIdList=broData.getCircleLocIdList(frm.getBroId(),frm.getLocId(),userId);
    				session.setAttribute("circleLocIdList",circleLocIdList);	
    			}
    			
    			if(officeType.equals("Division Office"))
    			{
    				ArrayList grantedAmtWorkWiseList=broData.getLocAmountForWorks(frm.getBroId(),frm.getLocId(),userId);
    				
    				session.setAttribute("grantedAmtWorkWiseList",grantedAmtWorkWiseList);
    				ArrayList circleLocIdList=broData.getCircleLocIdToDivisionList(frm.getBroId(),frm.getLocId(),userId);
    				session.setAttribute("circleLocIdList",circleLocIdList);
    				//// System.out.println("circleLocIdList size is "+circleLocIdList.size());
    				//// System.out.println("grantedAmtWorkWiseList size is "+grantedAmtWorkWiseList.size());
    			}
    			// System.out.println(" in edit mode 5");  
    			
    		}
    		
    		if(mode!=null && mode.equals("locIdChanged"))
    		{
    			CommonLists commonLists=new CommonLists(getDataSource(request));
	    		String locId="";
    			String broId="";
    			String circleLocId="";
    			RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
    			//used only in the case of circle login
    			circleLocId=frm.getCircleLocId();
    			//// System.out.println("circleLocId="+circleLocId);
    			ArrayList locDetailsList = null;
    			if(request.getParameter("special") == null){
    				locDetailsList=frm.getLocDetailsList();}
    			else
    			{
    				locDetailsList = (ArrayList)request.getAttribute("locDetailsList");
    			}
    			//// System.out.println("locDetailsList size:"+locDetailsList.size());
    			if(request.getParameter("locId")!=null)
    				locId=request.getParameter("locId");
    			else
    				locId=(String)request.getAttribute("locId");
    			//// System.out.println("finally LocId:"+locId);
    			if(request.getParameter("circleLocId")!=null)
    				circleLocId=request.getParameter("circleLocId");
    			else
    				circleLocId=(String)request.getAttribute("circleLocId");
    			
    			broId = frm.getBroId();
    			//ArrayList locDetailsList;
    			//ArrayList locIdList=broData.getLocIdList(frm.getBroId());
    			
    			
    			ArrayList locIdList=broData.getLocIdList(frm.getBroId(),userId);
    			session.setAttribute("locIdList",locIdList);
    			//// System.out.println("**********************:"+frm.getLocId());
    			if(!frm.getLocId().equals(""))
    			{
    				resetFrm(frm,session);
    				Rws_LocDetailsBean locDetailsBean=null;
    				if(!officeType.equals("Circle Office")){
    					locDetailsBean=broData.getLoc(locId,broId,userId);
    						
    				}
    				else
    				{
    					locDetailsBean=broData.getLoc(locId,broId,circleLocId,userId);
    				//	// System.out.println("In else");
    				}
    				
    				//// System.out.println("Loc reference is *******"+frm.getLocReference());
        			BeanUtils.copyProperties(frm,locDetailsBean);
        		}
    			else
    			{
    				resetLocDetails(frm,session);
    			}
    			
    			//locDetailsList=broData.getLocProgDetails(locId);
    			
    			if(!officeType.equals("Circle Office"))
    				locDetailsList=broData.getLocProgDetails(locId,userId,frm.getCircleLocId(),broId);
    			else
    				locDetailsList=broData.getLocProgDetails(locId,frm.getCircleLocId(),userId);
    			//// System.out.println("locDetailsList.size():"+locDetailsList.size());
    			//code added
    			//// System.out.println("**************:"+request.getParameter("workId"));
    			//request.setAttribute("workId",request.getParameter("workId"));
    			try
				{
    				//// System.out.println("*****************Size:"+locDetailsList.size());
	    			for(int i=0;i<locDetailsList.size();i++)
	    			{
	    				locDetailsList=setWorkIdList(locDetailsList,commonLists,i);
	    				Rws_LocProgDetailsBean locProgDetailsBean=(Rws_LocProgDetailsBean)locDetailsList.get(i);
	    				ArrayList officesList=rwsOffices.getAllDivisionsWithOfficeCode1(locProgDetailsBean.getDistrict());
	    				ArrayList paoList=commonLists.getPaoList(locProgDetailsBean.getDistrict());
	    				locDetailsList=setOfficeList(locDetailsList,officesList,locProgDetailsBean.getProject(),i,paoList);
	    	    		
	    	    		//locProgDetailsBean.setPaoApaoFlag("true");
	    	     		//session.setAttribute("paoList",paoList);
	    	    	//	// System.out.println("District id in prog details bean***"+locProgDetailsBean.getDistrict());	    	   
	    	    		
	    	    		
	    	    		ArrayList headOfAccountList=commonLists.getHeadOfAccountList1(frm.getBroId());
	    	    		session.setAttribute("headOfAccountList",headOfAccountList);
	    			}
				}
    			catch(Exception e)
				{
    				// System.out.println("exception in ******************:"+e.getMessage());
				}
	    			
    			
    			session.setAttribute("locDetailsList",locDetailsList);//??
    			frm.setLocDetailsList(locDetailsList);
	    		
    			ArrayList programmsList=null;
    			programmsList=broData.getBroProgrammsList(frm.getBroId(),userId);
    			session.setAttribute("programmsList",programmsList);
    			
    			//// System.out.println("grantedAmount "+broData.getGrantedAmount(frm.getBroId(),userId)+"");
    			//session.setAttribute("mode","data");
    			session.setAttribute("EAmode","data");
    			
    			//code added
    			ArrayList grantedAmtProgWiseList=null;
    			if(!officeType.equals("Circle Office"))
    				grantedAmtProgWiseList=broData.getGrantedAmtProgWiseList(frm.getBroId(),frm.getLocId(),userId);
    			else
    				grantedAmtProgWiseList=broData.getGrantedAmtProgWiseList(frm.getBroId(),frm.getLocId(),frm.getCircleLocId(),userId);
    			//ArrayList grantedAmtProgWiseList=broData.getGrantedAmtProgWiseList(frm.getBroId(),frm.getLocId(),userId);
    			session.setAttribute("grantedAmtProgWiseList",grantedAmtProgWiseList);
    		
    			if(officeType.equals("Circle Office"))
    			{
    				ArrayList circleLocIdList=broData.getCircleLocIdList(frm.getBroId(),frm.getLocId(),userId);
    				session.setAttribute("circleLocIdList",circleLocIdList);	
    			}
    			
    			if(officeType.equals("Division Office"))
    			{
    				ArrayList grantedAmtWorkWiseList=broData.getLocAmountForWorks(frm.getBroId(),frm.getLocId(),userId);
    				
    				session.setAttribute("grantedAmtWorkWiseList",grantedAmtWorkWiseList);
    				ArrayList circleLocIdList=broData.getCircleLocIdToDivisionList(frm.getBroId(),frm.getLocId(),userId);
    				session.setAttribute("circleLocIdList",circleLocIdList);
    				//// System.out.println("circleLocIdList size is "+circleLocIdList.size());
    				//// System.out.println("grantedAmtWorkWiseList size is "+grantedAmtWorkWiseList.size());
    			}
    			
    		}
    	
    		
    		
    		if(mode!=null && mode.equals("deleteFromLocProgList"))
    		{
    			ArrayList locDetailsList=frm.getLocDetailsList();
    			//// System.out.println("locDetailsList from frm size is "+locDetailsList.size());
    			int rowId=Integer.parseInt(request.getParameter("rowId"));
    			locDetailsList.remove(rowId);
    			session.setAttribute("locDetailsList",locDetailsList);
    		}
    		if(mode!=null && mode.equals("delete"))
    		{
    			String locId=request.getParameter("locId");
    			String message=broData.deleteLocDetails(locId);
    			request.setAttribute("message",message);
    		}
    		if(mode!=null && mode.equals("deleteLoc"))
    		{
    			String locId=frm.getLocId();
    			String message=broData.deleteLocDetails(locId);
    			request.setAttribute("message",message);
    			
    			ArrayList locIdList=broData.getLocIdList();
    			session.setAttribute("locIdList",locIdList);
    		}
    		
    			
		}
    	catch(Exception e){
    		//// System.out.println("Exception in Rws_BroDetailsFrm is "+e);}
    	}
    	return mapping.findForward(mode);
	}
    
    void printLocDetailsListSizes(ArrayList locDetailsList)
    {
    	//// System.out.println("in printLocDetailsListSizes");
    	for(int i=0;i<locDetailsList.size();i++)
    	{
    		Rws_LocProgDetailsBean locProgDetailsBean=(Rws_LocProgDetailsBean)locDetailsList.get(i);
    		ArrayList subProgrammesList=locProgDetailsBean.getSubProgrammesList();
    		//// System.out.println("subProgrammesList size for "+i+"th object is "+subProgrammesList.size());
    		//// System.out.println("selected values are :");
    		//// System.out.println(locProgDetailsBean.getDistrict());
    		//// System.out.println(locProgDetailsBean.getProgram());
    		//// System.out.println(locProgDetailsBean.getSubprogram());
    		//// System.out.println(locProgDetailsBean.getLocAmount());
    		//// System.out.println(locProgDetailsBean.getOffice());
    		//// System.out.println(locProgDetailsBean.getPlace());
    		//// System.out.println(locProgDetailsBean.getPaoApaoFlag());
    		//// System.out.println(locProgDetailsBean.getRemarks());
    	}
    }
    void resetFrm(ActionForm form,HttpSession session)
    {
    	
    	ArrayList emptyList=new ArrayList(0);
    	Rws_LocDetailsForm frm=(Rws_LocDetailsForm)form;
    	frm.setLocId("");
		frm.setLocReference("");
		frm.setLocRelDate("");
		frm.setLocAmount("");
		frm.setDwaAuthorisationReference("");
		frm.setDwaAuthorisationDate("");
		frm.setBroId("");
		frm.setBroReference("");
		frm.setBroAmount("");
		frm.setBroAmountAlreadyAllocatedForLOCs("");
		frm.setRemainingAmountToBeAllocated("");
		frm.setBroRemainingAmountToBeAllocated("");
		
		frm.setLocDetailsList(emptyList);
		session.setAttribute("locDetailsList",emptyList);
		
    }
    void resetFrm1(ActionForm form,HttpSession session)
    {
    	
    	ArrayList emptyList=new ArrayList(0);
    	Rws_LocDetailsForm frm=(Rws_LocDetailsForm)form;
    	frm.setLocId("");
		frm.setLocReference("");
		frm.setLocRelDate("");
		frm.setLocAmount("");
		frm.setDwaAuthorisationReference("");
		frm.setDwaAuthorisationDate("");
		
		frm.setLocDetailsList(emptyList);
		session.setAttribute("locDetailsList",emptyList);
		
    }
    void resetLocDetails(ActionForm form,HttpSession session)
    {
    	
    	ArrayList emptyList=new ArrayList(0);
    	Rws_LocDetailsForm frm=(Rws_LocDetailsForm)form;
    	frm.setLocId("");
		frm.setLocReference("");
		frm.setLocRelDate("");
		frm.setLocAmount("");
		frm.setDwaAuthorisationReference("");
		frm.setDwaAuthorisationDate("");
		
		frm.setLocDetailsList(emptyList);
		session.setAttribute("locDetailsList",emptyList);
		
    }
    
    public ArrayList setOfficeList(ArrayList locDetailsList,ArrayList officesList,String project,int rowId,ArrayList paoList)
    {
        //Debug.println("Project Selected"+project);
		//// System.out.println("locDetailsList from frm size is "+locDetailsList.size());
		//// System.out.println("officesList size is "+officesList.size());
		Rws_LocProgDetailsBean locProgDetailsBean=(Rws_LocProgDetailsBean)locDetailsList.get(rowId);
		if(officesList!=null)
		locProgDetailsBean.setOfficeList(officesList);
		if(project!=null)
		locProgDetailsBean.setProject(project);
		if(paoList!=null)
		locProgDetailsBean.setPaoList(paoList);
		locDetailsList.set(rowId,locProgDetailsBean);
		return locDetailsList;
    }
    public ArrayList setWorkIdList(ArrayList locDetailsList,CommonLists commonLists,int rowId)
    {
    	Rws_LocProgDetailsBean locProgDetailsBean=(Rws_LocProgDetailsBean)locDetailsList.get(rowId);
    	try
		{
    		//// System.out.println("project is "+locProgDetailsBean.getProject());
    		String circleOfficeCode=locProgDetailsBean.getDistrict();
    		String project=locProgDetailsBean.getProject();
    		if(project.equalsIgnoreCase("on"))
    		{
    			ArrayList workIdList=commonLists.getAdminWorkIdsAsIds(circleOfficeCode);
        		locProgDetailsBean.setWorkIdList(workIdList);
    			locDetailsList.set(rowId,locProgDetailsBean);
    		}
    		else
    		{
    			locProgDetailsBean.setWorkIdList(new ArrayList(0));
    			locDetailsList.set(rowId,locProgDetailsBean);
    		}
    	}catch(Exception e){
    		//// System.out.println("Exception in setWorkIdList is "+e);}
    	}
    	return locDetailsList;
    }
    public ArrayList setWorkIdList(ArrayList locDetailsList,ArrayList workIdList,int rowId)
    {
		Rws_LocProgDetailsBean locProgDetailsBean=(Rws_LocProgDetailsBean)locDetailsList.get(rowId);
		try{
		String circleOfficeCode=locProgDetailsBean.getDistrict();
		locProgDetailsBean.setWorkIdList(workIdList);
		locDetailsList.set(rowId,locProgDetailsBean);
		}catch(Exception e){
			//// System.out.println("Exception in setWorkIdList is "+e);}
		}
		return locDetailsList;
    }
}