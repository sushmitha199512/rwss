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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionForm;
import org.apache.commons.beanutils.BeanUtils;

//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsUser;

import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
//import nic.watersoft.commons.RwsUser;
import nic.watersoft.fundAccounting.Rws_BroDetailsBean;
import nic.watersoft.fundAccounting.Rws_BroDetailsForm;
//import nic.watersoft.masters.RwsHabStatusData;

//import org.apache.commons.beanutils.BeanUtils;

public class Rws_BroDetailsFrm extends Action 
{
	
    public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest 
			request,HttpServletResponse response)
	{
    	HttpSession session=request.getSession();
    	Rws_BroDetailsForm frm=(Rws_BroDetailsForm)form;
    	Rws_BroData broData=new Rws_BroData(getDataSource(request));
    	Rws_BroProgDetailsBean broProgDetailsBean2=new Rws_BroProgDetailsBean();
    	String mode=request.getParameter("mode");
    	
    	//System.out.println("Mode:"+mode);
    	//String target="success";
    	//Cookie mycookie[];
    	
    	RwsUser user=(RwsUser)session.getAttribute("RWS_USER");    
    	
    	if(user==null||user.getUserId()==null){
    		return mapping.findForward("expire");
    	   // response.sendRedirect("./sessionExpired.jsp");
    	}
    	
    	 
    	 
    	
    	ArrayList emptyList=new ArrayList(0);
    	
    	//System.out.println("mode is "+mode);
    	try
		{
    		if(mode!=null && mode.equals("init")){
	    		session.setAttribute("broDetailsList",emptyList);
	    		CommonLists commonLists=new CommonLists(getDataSource(request));
	    		
	    		ArrayList programmsList=commonLists.getProgrammes();
	    		session.setAttribute("programmsList",programmsList);
	    		//ArrayList headOfAccountList=commonLists.getHeadOfAccountList();
	    		//session.setAttribute("headOfAccountList",headOfAccountList);
	    		ArrayList majorHeadList=commonLists.getMajorHeadList();
	    		session.setAttribute("majorHeadList",majorHeadList);
	    		
	    		
	    	}  
    		if(mode!=null && mode.equals("data")){
    			
    			resetFrm(frm,session);  
    			ArrayList broIdList=broData.getBroIdList();
    			session.setAttribute("broIdList",broIdList);
    			session.setAttribute("mode","data");
    			
    			session.setAttribute("broDetailsList",emptyList);
    			CommonLists commonLists=new CommonLists(getDataSource(request));
    			
    			ArrayList programmsList=commonLists.getProgrammes();
    			session.setAttribute("programmsList",programmsList);
    			
    			ArrayList headOfAccountList=commonLists.getHeadOfAccountList();
    			session.setAttribute("headOfAccountList",headOfAccountList);
    			
    			ArrayList majorHeadList=commonLists.getMajorHeadList();
	    		session.setAttribute("majorHeadList",majorHeadList);
	    		int num=2010;
	    		ArrayList fnlist=commonLists.getFinancialYears(8);
	    		Debug.println("fnlist:"+fnlist.size());
	    		session.setAttribute("bro_financialYear",fnlist);
    		}
    		
    		if(mode!=null && mode.equals("addNew")) 
	    	{
    			resetFrm(frm,session);
    			session.setAttribute("broDetailsList",emptyList);
	    		CommonLists commonLists=new CommonLists(getDataSource(request));
	    		
	    		ArrayList programmsList=commonLists.getProgrammes();
	    		session.setAttribute("programmsList",programmsList);
	    		
	    		//ArrayList headOfAccountList=commonLists.getHeadOfAccountList();
	    		//session.setAttribute("headOfAccountList",headOfAccountList);
	    		//Debug.println(" before major head ");
	    		ArrayList majorHeadList=commonLists.getMajorHeadList();
	    		session.setAttribute("majorHeadList",majorHeadList);
	    		//Debug.println(" after major head ");
	    		session.setAttribute("mode","addNew");
	    	}
    		if(mode!=null && mode.equals("addNewProgrammeForBro"))
	    	{
	    		Debug.println("in addNewProgrammeForBro mode with :"+frm.getBro_financialYear());
    			CommonLists commonLists=new CommonLists(getDataSource(request));
    			
	    		Rws_BroProgDetailsBean broProgDetailsBean=null;
	    		
	    		ArrayList broDetailsList=frm.getBroDetailsList();
	    		Debug.println("1");
	    		if(broDetailsList==null)
	    		{
	    			Debug.println("2");
	    			broDetailsList=new ArrayList();
	    			session.setAttribute("broDetailsList",emptyList);
	    		}
	    		//Debug.println("3");
	    		Rws_BroDetailsBean broDetailsBean=new Rws_BroDetailsBean();
	    	//	BeanUtils.copyProperties(broDetailsBean,frm);
	    	//	String message=broData.insertBroDetails(broDetailsBean,broDetailsList);
	    		for(int i = 0;i<broDetailsList.size();i++)
	    		{
	    			//Debug.println("4");
    				 broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
    				if(broProgDetailsBean.getSubprogrammeCode() != null &&  !broProgDetailsBean.getSubprogrammeCode().equals(""))
    					{
    					//Debug.println("5");
    						ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
    						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
    						broDetailsList.set(i,broProgDetailsBean);
    					}
    				 else if(broProgDetailsBean.getSubprogrammeCode() == null || broProgDetailsBean.getSubprogrammeCode().equals(""))
    				 {
    				 	//Debug.println("6");
    				 	ArrayList subProgrammesList = new ArrayList(0);
    				 	broProgDetailsBean.setSubProgrammesList(subProgrammesList);
    					broDetailsList.set(i,broProgDetailsBean);
    				 }
    				
	    		}
	    		//Debug.println("7"); 
	    		for(int i = 0;i<broDetailsList.size();i++)
	    		{
	    			//Debug.println("8:"+request.getParameter("rowId"));
    				 broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
    				
    					Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
    					//ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
						//broProgDetailsBean.setSubProgrammesList(subProgrammesList);
						//broDetailsList.set(i,broProgDetailsBean);
    					ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
    					//Debug.println("size of submajor:"+submajorHeadList.size());
    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
    					//Debug.println("size of minorHeadList:"+minorHeadList.size());
    					broProgDetailsBean.setMinorHeadList(minorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
    	    			//Debug.println("size of :"+groupHeadList.size());
    	    			broProgDetailsBean.setGroupHeadList(groupHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    					ArrayList subHeadList=commonLists.getSubHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead());
    	    			//Debug.println("size of minorHeadList:"+subHeadList.size());
    	    			broProgDetailsBean.setSubHeadList(subHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    					ArrayList detailHeadList=commonLists.getDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead());
    	    			//Debug.println("size of :"+detailHeadList.size());
    	    			broProgDetailsBean.setDetailHeadList(detailHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    				    ArrayList subDetailHeadList=commonLists.getSubDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead(),broProgDetailsBean.getDetailHead());
    	    			//Debug.println("size of  subdetailHeadList:"+subDetailHeadList.size());
    	    			broProgDetailsBean.setSubDetailHeadList(subDetailHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    				
	    		}     
	    		//Debug.println("7");
	    		broProgDetailsBean=new Rws_BroProgDetailsBean();
	    		//Debug.println("8");
	    		broProgDetailsBean.setBudgetEstimateYear(frm.getBro_financialYear());
	    		//Debug.println("9");
	    		broDetailsList.add(broProgDetailsBean);
	    		//Debug.println("10");
	    		//System.out.println("size of broDetailsList after adding is "+broDetailsList.size());
	    		session.setAttribute("broDetailsList",broDetailsList);
	    	}
    		if(mode!= null && mode.equals("getSubProgram"))
    		{
    			try
				{
	    			CommonLists commonLists=new CommonLists(getDataSource(request));
	    			ArrayList broDetailsList=frm.getBroDetailsList();
	    			broDetailsList=frm.getBroDetailsList();
	    			for(int i = 0;i<broDetailsList.size();i++)
		    		{
	    				Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
	    				if(Integer.parseInt(request.getParameter("rowId")) == i)
	    				 {
	    						ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
	    						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
	    						broDetailsList.set(i,broProgDetailsBean);
	    				 }
	    				 else if(broProgDetailsBean.getSubprogrammeCode() != null &&  !broProgDetailsBean.getSubprogrammeCode().equals(""))
	    					{
	    						ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
	    						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
	    						broDetailsList.set(i,broProgDetailsBean);
	    					
	    				}
	    				 else if(broProgDetailsBean.getSubprogrammeCode() == null || broProgDetailsBean.getSubprogrammeCode().equals(""))
	    				 {
	    				 	ArrayList subProgrammesList = new ArrayList(0);
	    				 	broProgDetailsBean.setSubProgrammesList(subProgrammesList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				 }
		    		}
	    			
	    			for(int i = 0;i<broDetailsList.size();i++)
		    		{
		    			Debug.println("8:"+request.getParameter("rowId"));
		    			Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
	    				
	    					//Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
	    					//ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
							//broProgDetailsBean.setSubProgrammesList(subProgrammesList);
							//broDetailsList.set(i,broProgDetailsBean);
	    					ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
	    					//Debug.println("size of submajor:"+submajorHeadList.size());
	    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
	    					//Debug.println("size of minorHeadList:"+minorHeadList.size());
	    					broProgDetailsBean.setMinorHeadList(minorHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    					ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
	    	    			//Debug.println("size of :"+groupHeadList.size());
	    	    			broProgDetailsBean.setGroupHeadList(groupHeadList);
	    	    			broDetailsList.set(i,broProgDetailsBean);
	    					ArrayList subHeadList=commonLists.getSubHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead());
	    	    			//Debug.println("size of minorHeadList:"+subHeadList.size());
	    	    			broProgDetailsBean.setSubHeadList(subHeadList);
	    	    			broDetailsList.set(i,broProgDetailsBean);
	    					ArrayList detailHeadList=commonLists.getDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead());
	    	    			//Debug.println("size of :"+detailHeadList.size());
	    	    			broProgDetailsBean.setDetailHeadList(detailHeadList);
	    	    			broDetailsList.set(i,broProgDetailsBean);
	    				    ArrayList subDetailHeadList=commonLists.getSubDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead(),broProgDetailsBean.getDetailHead());
	    	    			//Debug.println("size of  subdetailHeadList:"+subDetailHeadList.size());
	    	    			broProgDetailsBean.setSubDetailHeadList(subDetailHeadList);
	    	    			broDetailsList.set(i,broProgDetailsBean);
	    				
		    		}     
	    			Rws_BroProgDetailsBean broProgDetailsBean1=(Rws_BroProgDetailsBean)broDetailsList.get(0);
	    			session.setAttribute("broDetailsList",broDetailsList);
		    		
				}
    			catch(Exception e)
				{
    				Debug.println(e.getMessage());
				}
	    	
    		}
    		
    		if(mode!=null && mode.equals("accDetails"))
	    		{
   				//Debug.println(" in accDetails");
    			String val=request.getParameter("val");
    			//Debug.println("val:"+val); 
    			CommonLists commonLists=new CommonLists(getDataSource(request));
    			
    			ArrayList broDetailsList=frm.getBroDetailsList();
    			broDetailsList=frm.getBroDetailsList();
    			Debug.println("size:"+broDetailsList.size());
    			for(int i = 0;i<broDetailsList.size();i++)
	    		{
	    			//Debug.println("8:"+request.getParameter("rowId"));
	    			Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
    				
    					//Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
    					ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
						broDetailsList.set(i,broProgDetailsBean);
    					ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
    					//Debug.println("size of submajor:"+submajorHeadList.size());
    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
    					//Debug.println("size of minorHeadList:"+minorHeadList.size());
    					broProgDetailsBean.setMinorHeadList(minorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
    	    			//Debug.println("size of :"+groupHeadList.size());
    	    			broProgDetailsBean.setGroupHeadList(groupHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    					ArrayList subHeadList=commonLists.getSubHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead());
    	    			//Debug.println("size of minorHeadList:"+subHeadList.size());
    	    			broProgDetailsBean.setSubHeadList(subHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    					ArrayList detailHeadList=commonLists.getDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead());
    	    			//Debug.println("size of :"+detailHeadList.size());
    	    			broProgDetailsBean.setDetailHeadList(detailHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    				    ArrayList subDetailHeadList=commonLists.getSubDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead(),broProgDetailsBean.getDetailHead());
    	    			//Debug.println("size of  subdetailHeadList:"+subDetailHeadList.size());
    	    			broProgDetailsBean.setSubDetailHeadList(subDetailHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    				
	    		}     
    			
	    		   if(val.equals("1")){
	    			
	    			for(int i = 0;i<broDetailsList.size();i++)
		    		{
	    				Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
	    				if(Integer.parseInt(request.getParameter("rowId")) == i)
	    				 {
	    					//Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
	    					ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
    						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
    						broDetailsList.set(i,broProgDetailsBean);
	    					ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
	    					//Debug.println("size of submajor:"+submajorHeadList.size());
	    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				  }
	    				 else if(broProgDetailsBean.getMajorHead() != null &&  !broProgDetailsBean.getMajorHead().equals(""))
	    					{
	    				 	//Debug.println("222222");	 
	    				 	ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
	    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    					
	    				}
	    				 else if(broProgDetailsBean.getMajorHead() == null || broProgDetailsBean.getMajorHead().equals(""))
	    				 {
	    				 	//Debug.println("33333");	 
	    				 	ArrayList submajorHeadList = new ArrayList(0);
	    				 	broProgDetailsBean.setSubmajorlist(submajorHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				 }
	    				
		    		}
	    			//Debug.println("form value1:"+(Rws_BroProgDetailsBean)broDetailsList.get(0));
					Rws_BroProgDetailsBean broProgDetailsBean1=(Rws_BroProgDetailsBean)broDetailsList.get(0); 
					session.setAttribute("broDetailsList",broDetailsList);
	    			
	    			
	    		}
    		   else if(val.equals("2")){ 
    		   	 for(int i = 0;i<broDetailsList.size();i++)
    	    		{
        				Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
        				ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
						broDetailsList.set(i,broProgDetailsBean);
        				ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
    					//Debug.println("size of submajor:"+submajorHeadList.size());
    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
        				if(Integer.parseInt(request.getParameter("rowId")) == i)
        				 {
        					//Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
        					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
        					//Debug.println("size of minorHeadList:"+minorHeadList.size());
        					broProgDetailsBean.setMinorHeadList(minorHeadList);
        					broDetailsList.set(i,broProgDetailsBean);
        				  }
        				 else if(broProgDetailsBean.getMinorHead() != null &&  !broProgDetailsBean.getMinorHead().equals(""))
        					{
        				 	//Debug.println("222222");	 
        				 	ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
        					//Debug.println("size of minorHeadList:"+minorHeadList.size());
        					broProgDetailsBean.setMinorHeadList(minorHeadList);
        					broDetailsList.set(i,broProgDetailsBean);
        					
        				}
        				 else if(broProgDetailsBean.getMinorHead() == null || broProgDetailsBean.getMinorHead().equals(""))
        				 {
        				 	//Debug.println("33333");	 
        				 	ArrayList minorHeadList = new ArrayList(0);
        				 	broProgDetailsBean.setMinorHeadList(minorHeadList);
        					broDetailsList.set(i,broProgDetailsBean);
        				 }
    				
    			   }
    				//Debug.println("form value2:"+(Rws_BroProgDetailsBean)broDetailsList.get(0));
    				Rws_BroProgDetailsBean broProgDetailsBean1=(Rws_BroProgDetailsBean)broDetailsList.get(0);
    				session.setAttribute("broDetailsList",broDetailsList);
    			}
	    		  else if(val.equals("3")){ 
	    		  	
					for(int i = 0;i<broDetailsList.size();i++)
		    		{
	    				Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
	    				ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
						broDetailsList.set(i,broProgDetailsBean);
	    				ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
    					//Debug.println("size of submajor:"+submajorHeadList.size());
    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
    					//Debug.println("size of minorHeadList:"+minorHeadList.size());
    					broProgDetailsBean.setMinorHeadList(minorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
	    				if(Integer.parseInt(request.getParameter("rowId")) == i)
	    				 {
	    					//Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
	    					ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
	    					//Debug.println("size of :"+groupHeadList.size());
	    					broProgDetailsBean.setGroupHeadList(groupHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				  }
	    				 else if(broProgDetailsBean.getGroupHead() != null &&  !broProgDetailsBean.getGroupHead().equals(""))
	    					{
	    				 	//Debug.println("222222");	 
	    				 	ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
	    					//Debug.println("size of :"+groupHeadList.size());
	    					broProgDetailsBean.setGroupHeadList(groupHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    					
	    				}
	    				 else if(broProgDetailsBean.getGroupHead() == null || broProgDetailsBean.getGroupHead().equals(""))
	    				 {
	    				 	///Debug.println("33333");	 
	    				 	ArrayList groupHeadList = new ArrayList(0);
	    				 	broProgDetailsBean.setGroupHeadList(groupHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				 }
					
				   }
					//Debug.println("form value3:"+(Rws_BroProgDetailsBean)broDetailsList.get(0));
					Rws_BroProgDetailsBean broProgDetailsBean1=(Rws_BroProgDetailsBean)broDetailsList.get(0);
					session.setAttribute("broDetailsList",broDetailsList);
				}
	    		  else if(val.equals("4")){
	    		  	for(int i = 0;i<broDetailsList.size();i++)
		    		{
	    				Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
	    				ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
						broDetailsList.set(i,broProgDetailsBean);
	    				ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
    					//Debug.println("size of submajor:"+submajorHeadList.size());
    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
    					//Debug.println("size of minorHeadList:"+minorHeadList.size());
    					broProgDetailsBean.setMinorHeadList(minorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
	    				
	    				ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
    					//Debug.println("size of :"+groupHeadList.size());
    					broProgDetailsBean.setGroupHeadList(groupHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
	    				if(Integer.parseInt(request.getParameter("rowId")) == i)
	    				 {
	    					//Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
	    					ArrayList subHeadList=commonLists.getSubHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead());
	    					//Debug.println("size of minorHeadList:"+subHeadList.size());
	    					broProgDetailsBean.setSubHeadList(subHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				  }
	    				 else if(broProgDetailsBean.getSubHead() != null &&  !broProgDetailsBean.getSubHead().equals(""))
	    					{
	    				 	//Debug.println("222222");	 
	    				 	ArrayList subHeadList=commonLists.getSubHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead());
	    					//Debug.println("size of minorHeadList:"+subHeadList.size());
	    					broProgDetailsBean.setSubHeadList(subHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    					
	    				}
	    				 else if(broProgDetailsBean.getSubHead() == null || broProgDetailsBean.getSubHead().equals(""))
	    				 {
	    				 	//Debug.println("33333");	 
	    				 	ArrayList subHeadList = new ArrayList(0);
	    				 	broProgDetailsBean.setSubHeadList(subHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				 }
					
				   }
					session.setAttribute("broDetailsList",broDetailsList);
	    		  	
	    		  }
	    		  else if(val.equals("5")){
	    		  	    		  	
	    		  	for(int i = 0;i<broDetailsList.size();i++)
		    		{
	    				Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
	    				ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
						broDetailsList.set(i,broProgDetailsBean);
	    				ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
    					///Debug.println("size of submajor:"+submajorHeadList.size());
    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
    					//Debug.println("size of minorHeadList:"+minorHeadList.size());
    					broProgDetailsBean.setMinorHeadList(minorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
	    				
	    				ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
    					//Debug.println("size of :"+groupHeadList.size());
    					broProgDetailsBean.setGroupHeadList(groupHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList subHeadList=commonLists.getSubHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead());
    					//Debug.println("size of :"+subHeadList.size());
    					broProgDetailsBean.setSubHeadList(subHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
	    				if(Integer.parseInt(request.getParameter("rowId")) == i)
	    				 {
	    					//Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
	    					ArrayList detailHeadList=commonLists.getDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead());
	    					//Debug.println("size of :"+detailHeadList.size());
	    					broProgDetailsBean.setDetailHeadList(detailHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				  }
	    				 else if(broProgDetailsBean.getDetailHead() != null &&  !broProgDetailsBean.getDetailHead().equals(""))
	    					{
	    				 	//Debug.println("222222");	 
	    				 	ArrayList detailHeadList=commonLists.getDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead());
	    					//Debug.println("size of :"+detailHeadList.size());
	    					broProgDetailsBean.setDetailHeadList(detailHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    					
	    				}
	    				 else if(broProgDetailsBean.getDetailHead() == null || broProgDetailsBean.getDetailHead().equals(""))
	    				 {
	    				 	//Debug.println("33333");	 
	    				 	ArrayList detailHeadList = new ArrayList(0);
	    				 	broProgDetailsBean.setDetailHeadList(detailHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				 }
					
				   }
					session.setAttribute("broDetailsList",broDetailsList);
	    		  }
	    		  else if(val.equals("6")){
	    		  	
	    		   	for(int i = 0;i<broDetailsList.size();i++)
		    		{
	    				Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
	    				ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
						broDetailsList.set(i,broProgDetailsBean);
	    				ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
    					//Debug.println("size of submajor:"+submajorHeadList.size());
    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
    					//Debug.println("size of minorHeadList:"+minorHeadList.size());
    					broProgDetailsBean.setMinorHeadList(minorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
	    				ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
    					//Debug.println("size of grp :"+groupHeadList.size());
    					broProgDetailsBean.setGroupHeadList(groupHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList subHeadList=commonLists.getSubHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead());
    					//Debug.println("size of subhead:"+subHeadList.size());
    					broProgDetailsBean.setSubHeadList(subHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList detailHeadList=commonLists.getDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead());
    					//Debug.println("size of detail:"+detailHeadList.size());
    					broProgDetailsBean.setDetailHeadList(detailHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
	    				if(Integer.parseInt(request.getParameter("rowId")) == i)
	    				 {
	    					//Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
	    					ArrayList subDetailHeadList=commonLists.getSubDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead(),broProgDetailsBean.getDetailHead());
	    					Debug.println("size of  subdetailHeadList:"+subDetailHeadList.size());
	    					broProgDetailsBean.setSubDetailHeadList(subDetailHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				  }
	    				 else if(broProgDetailsBean.getSubDetailHead() != null &&  !broProgDetailsBean.getSubDetailHead().equals(""))
	    					{
	    				 	Debug.println("222222");	 
	    				 	ArrayList subDetailHeadList=commonLists.getSubDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead(),broProgDetailsBean.getDetailHead());
	    					Debug.println("size of subdetailHeadList:"+subDetailHeadList.size());
	    					broProgDetailsBean.setSubDetailHeadList(subDetailHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    					
	    				}
	    				 else if(broProgDetailsBean.getSubDetailHead() == null || broProgDetailsBean.getSubDetailHead().equals(""))
	    				 {
	    				 	Debug.println("33333");	 
	    				 	ArrayList subDetailHeadList = new ArrayList(0);
	    				 	broProgDetailsBean.setSubDetailHeadList(subDetailHeadList);
	    					broDetailsList.set(i,broProgDetailsBean);
	    				 }
					
				   }
					session.setAttribute("broDetailsList",broDetailsList);
	    		  }
    			
    		}	
    			
    		if(mode!=null && mode.equals("save"))
	    	{
    			Rws_BroDetailsBean broDetailsBean=new Rws_BroDetailsBean();
    			String insertMode=(String)session.getAttribute("mode");
    			ArrayList broDetailsList=frm.getBroDetailsList();
    			//Debug.println(":"+frm.getTs());
    			Debug.println("scp:"+frm.getScp());
    			Debug.println("Ts:"+frm.getTsp());
    			BeanUtils.copyProperties(broDetailsBean,frm);
    			ArrayList broProgDetailsList=frm.getBroDetailsList();
    			session.setAttribute("broDetailsList",broDetailsList);
    			DAOMessage daoMessage=broData.insertBroDetails(broDetailsBean,broDetailsList,insertMode);
    			String message=daoMessage.getMessage();
    			ArrayList broIdList=broData.getBroIdList();
    			session.setAttribute("broIdList",broIdList);
    			
    			request.setAttribute("bro_id",frm.getBro_id());
    			if(message!=null)
    				request.setAttribute("message",message);
    			
    			if(daoMessage.getCode()<0)
    				mode="saveError";
    			resetFrm(frm,session);
	    	}
    		if(mode!=null && mode.equals("view"))
			{
				ArrayList broDetailsList;
				broDetailsList=broData.getBroList();
    			
				//System.out.println("broDetails sizes is "+broDetailsList.size());
				session.setAttribute("broDetailsListFromView",broDetailsList);
			}
    		if(mode!=null && mode.equals("getBroProgDetails"))
    		{
    			ArrayList broProgDetailsList;
    			String bro_id=request.getParameter("bro_id");
    			broProgDetailsList=broData.getBroProgDetails(bro_id);
        		
    			//System.out.println("broProgDetails sizes is "+broProgDetailsList.size());
    			request.setAttribute("broProgDetailsList",broProgDetailsList);
    		}
    		if(mode!=null && mode.equals("edit"))    
    		{
    			String bro_id=null;
    			if(request.getParameter("bro_id")!=null)
    				bro_id=request.getParameter("bro_id"); 
    			else
    				bro_id=(String)request.getAttribute("bro_id");
    			//System.out.println("briiiid:"+bro_id+"aaaaaaaaa");
    			if(bro_id==null || (bro_id!=null && (bro_id.equals("") || bro_id.equals(" ")))) 
    				{
    				//resetFrm(frm,session);
    				//System.out.println("11111");
    				session.setAttribute("broDetailsList",new ArrayList());
    				//System.out.println("22222");
    				}
    				//session.setAttribute("broDetailsList",emptyList);
    			ArrayList broDetailsList;
    			Rws_BroDetailsBean broDetailsBean=broData.getBro(bro_id);
    			 
    			frm.setBro_id(bro_id);
    			frm.setBro_reference(broDetailsBean.getBro_reference());
    			frm.setBro_date(broDetailsBean.getBro_date());
    			frm.setBro_budgetEstimate(broDetailsBean.getBro_budgetEstimate());
    			frm.setBro_sanctionAmount(broDetailsBean.getBro_sanctionAmount());
    			frm.setBro_amount(broDetailsBean.getBro_amount());
    			frm.setBro_financialYear(broDetailsBean.getBro_financialYear());
    			frm.setAppflag(broDetailsBean.getAppflag());
    			frm.setBro_appAmount(broDetailsBean.getBro_appAmount());
    			frm.setBro_addAmount(broDetailsBean.getBro_addAmount());
    			frm.setGf(broDetailsBean.getGf());
    			frm.setScp(broDetailsBean.getScp());
    			frm.setTsp(broDetailsBean.getTsp());
    			CommonLists commonLists=new CommonLists(getDataSource(request));
    			broDetailsList=broData.getBroProgDetails(bro_id);
    		//	System.out.println("`````````````````````````````````:"+broDetailsList.size());
    			for(int i = 0;i<broDetailsList.size();i++)
	    		{
    				Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
    				if(broProgDetailsBean.getSubprogrammeCode() != null &&  !broProgDetailsBean.getSubprogrammeCode().equals(""))
    					{
    						ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
    				 		broProgDetailsBean.setSubProgrammesList(subProgrammesList);
    						broDetailsList.set(i,broProgDetailsBean);
    					
    					}
    				 else if(broProgDetailsBean.getSubprogrammeCode() == null || broProgDetailsBean.getSubprogrammeCode().equals(""))
    				 {
    				 	ArrayList subProgrammesList = new ArrayList(0);
    				 	broProgDetailsBean.setSubProgrammesList(subProgrammesList);
    					broDetailsList.set(i,broProgDetailsBean);
    				 }    
	    		}   
    			
    			for(int i = 0;i<broDetailsList.size();i++)
	    		{
	    			//Debug.println("8:"+request.getParameter("rowId"));
	    			Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
    				
    					//Debug.println("11111:"+broProgDetailsBean.getHeadOfAccount());	
    					broProgDetailsBean.setMajorHead(broProgDetailsBean.getHeadOfAccount().substring(0,4));
    					//Debug.println("2:"+broProgDetailsBean.getHeadOfAccount().substring(5,7));
    					ArrayList majorHeadList=commonLists.getMajorHeadList();
    		    		session.setAttribute("majorHeadList",majorHeadList);
    		    		if(broProgDetailsBean.getHeadOfAccount().length()>=7 && broProgDetailsBean.getHeadOfAccount().substring(5,7)!=null && !broProgDetailsBean.getHeadOfAccount().substring(5,7).equals(""))
    		    		{
    					broProgDetailsBean.setSubMajorHead(broProgDetailsBean.getHeadOfAccount().substring(5,7));
    		    		}
    					ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
    					//Debug.println("2222222");
    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					if(broProgDetailsBean.getHeadOfAccount().length()>=11 && broProgDetailsBean.getHeadOfAccount().substring(8,11)!=null && !broProgDetailsBean.getHeadOfAccount().substring(8,11).equals(""))
    					{
    					broProgDetailsBean.setMinorHead(broProgDetailsBean.getHeadOfAccount().substring(8,11));
    					}
    					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
    					//Debug.println("size of minorHeadList:"+minorHeadList.size());
    					//Debug.println("3333333");
    					broProgDetailsBean.setMinorHeadList(minorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					if(broProgDetailsBean.getHeadOfAccount().length()>=14 && broProgDetailsBean.getHeadOfAccount().substring(12,14)!=null && !broProgDetailsBean.getHeadOfAccount().substring(12,14).equals("")){
    					broProgDetailsBean.setGroupHead(broProgDetailsBean.getHeadOfAccount().substring(12,14));
    					}
    					ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
    	    			//Debug.println("size of :"+groupHeadList.size());
    					//Debug.println("4444444");
    	    			broProgDetailsBean.setGroupHeadList(groupHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    	    			if(broProgDetailsBean.getHeadOfAccount().length()>=17 && broProgDetailsBean.getHeadOfAccount().substring(15,17)!=null && !broProgDetailsBean.getHeadOfAccount().substring(15,17).equals(""))
    	    			{
    	    			broProgDetailsBean.setSubHead(broProgDetailsBean.getHeadOfAccount().substring(15,17));
    	    			}
    					ArrayList subHeadList=commonLists.getSubHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead());
    	    			//Debug.println("size of minorHeadList:"+subHeadList.size());
    					//Debug.println("5555555");
    	    			broProgDetailsBean.setSubHeadList(subHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    	    			if(broProgDetailsBean.getHeadOfAccount().length()>=21 && broProgDetailsBean.getHeadOfAccount().substring(18,21)!=null && !broProgDetailsBean.getHeadOfAccount().substring(18,21).equals(""))
    	    			{
    	    	 		broProgDetailsBean.setDetailHead(broProgDetailsBean.getHeadOfAccount().substring(18,21));
    	    			}
    	    			ArrayList detailHeadList=commonLists.getDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead());
    	    			//Debug.println("size of :"+detailHeadList.size());
    	    			//Debug.println("6666666");
    	    			broProgDetailsBean.setDetailHeadList(detailHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    	    			if(broProgDetailsBean.getHeadOfAccount().length()>=25 && broProgDetailsBean.getHeadOfAccount().substring(22,25)!=null && !broProgDetailsBean.getHeadOfAccount().substring(22,25).equals(""))
    	    			{
    	    			broProgDetailsBean.setSubDetailHead(broProgDetailsBean.getHeadOfAccount().substring(22,25));
    	    			}
    				    
    	    			ArrayList subDetailHeadList=commonLists.getSubDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead(),broProgDetailsBean.getDetailHead());
    	    			//Debug.println("size of  subdetailHeadList:"+subDetailHeadList.size());
    	    			broProgDetailsBean.setSubDetailHeadList(subDetailHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    				
	    		}     
    			Rws_BroProgDetailsBean broProgDetailsBean1=(Rws_BroProgDetailsBean)broDetailsList.get(0);
    			//session.setAttribute("broDetailsList",broDetailsList);
    			//System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~:"+broDetailsList.size());
    			session.setAttribute("broDetailsList",broDetailsList);
	    		
    			
	    		
    			ArrayList programmsList=commonLists.getProgrammes();
	    		session.setAttribute("programmsList",programmsList);
	    		
	    		//ArrayList headOfAccountList=commonLists.getHeadOfAccountList();
	    		//session.setAttribute("headOfAccountList",headOfAccountList);
	    		
    			
	    		session.setAttribute("mode","data");
			
    		}
    		if(mode!=null && mode.equals("deleteFromBroProgList"))
    		{
    			CommonLists commonLists=new CommonLists(getDataSource(request));
    			ArrayList broDetailsList=frm.getBroDetailsList();
    			//Debug.println("in deleteFromBroProgList broDetailsList size :"+broDetailsList.size());
    			int rowId=Integer.parseInt(request.getParameter("rowId"));
    			broDetailsList.remove(rowId);
    			for(int i = 0;i<broDetailsList.size();i++)
	    		{
    				Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
    				if(broProgDetailsBean.getSubprogrammeCode() != null &&  !broProgDetailsBean.getSubprogrammeCode().equals(""))
    					{
    						ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
    						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
    						broDetailsList.set(i,broProgDetailsBean);
    					
    				}
    				 else if(broProgDetailsBean.getSubprogrammeCode() == null || broProgDetailsBean.getSubprogrammeCode().equals(""))
    				 {
    				 	ArrayList subProgrammesList = new ArrayList(0);
    				 	broProgDetailsBean.setSubProgrammesList(subProgrammesList);
    					broDetailsList.set(i,broProgDetailsBean);
    				 }
	    		}
    			for(int i = 0;i<broDetailsList.size();i++)
	    		{
	    			//Debug.println("8:"+request.getParameter("rowId"));
	    			Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(i);
    				
    					//Debug.println("11111:"+broProgDetailsBean.getMajorHead());	 
    					ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean.getProgrammeCode());
						broProgDetailsBean.setSubProgrammesList(subProgrammesList);
						broDetailsList.set(i,broProgDetailsBean);
    					ArrayList submajorHeadList=commonLists.getSubmajorHeadList(broProgDetailsBean.getMajorHead());
    					//Debug.println("size of submajor:"+submajorHeadList.size());
    					broProgDetailsBean.setSubmajorlist(submajorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList minorHeadList=commonLists.getMinorHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead());
    					//Debug.println("size of minorHeadList:"+minorHeadList.size());
    					broProgDetailsBean.setMinorHeadList(minorHeadList);
    					broDetailsList.set(i,broProgDetailsBean);
    					ArrayList groupHeadList=commonLists.getGroupHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead());
    	    			//Debug.println("size of :"+groupHeadList.size());
    	    			broProgDetailsBean.setGroupHeadList(groupHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    					ArrayList subHeadList=commonLists.getSubHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead());
    	    			//Debug.println("size of minorHeadList:"+subHeadList.size());
    	    			broProgDetailsBean.setSubHeadList(subHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    					ArrayList detailHeadList=commonLists.getDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead());
    	    			//Debug.println("size of :"+detailHeadList.size());
    	    			broProgDetailsBean.setDetailHeadList(detailHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    				    ArrayList subDetailHeadList=commonLists.getSubDetailHeadList(broProgDetailsBean.getMajorHead(),broProgDetailsBean.getSubMajorHead(),broProgDetailsBean.getMinorHead(),broProgDetailsBean.getGroupHead(),broProgDetailsBean.getSubHead(),broProgDetailsBean.getDetailHead());
    	    			//Debug.println("size of  subdetailHeadList:"+subDetailHeadList.size());
    	    			broProgDetailsBean.setSubDetailHeadList(subDetailHeadList);
    	    			broDetailsList.set(i,broProgDetailsBean);
    				
	    		}     
    			
    			
    			session.setAttribute("broDetailsList",broDetailsList);
    			
    		}
    		if(mode!=null && mode.equals("getQtrs"))
    		{
    			CommonLists commonLists=new CommonLists(getDataSource(request));
    			ArrayList broDetailsList=frm.getBroDetailsList();
    			int rowId=Integer.parseInt(request.getParameter("rowId"));
    			Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(rowId);
    			broProgDetailsBean.setBroId(frm.getBro_id());
    			int qtrs = commonLists.getQuarters(broProgDetailsBean);
    			int be = 0,already=0,now=0;
    			
    			if(commonLists.getStatus(broProgDetailsBean))
    			{
	    			//be = commonLists.getBudgetAmount(broProgDetailsBean);
	    			//already = commonLists.getAmountAlready(broProgDetailsBean);
	    			//now = commonLists.getAmountNow(broProgDetailsBean);
    			    if(commonLists.getStatus(broProgDetailsBean))
        			{
    	    		//	be = commonLists.getBudgetAmount1(broProgDetailsBean);
    	    			already = commonLists.getAmountAlready1(broProgDetailsBean);
    	    			//now = commonLists.getAmountNow(broProgDetailsBean);
    	    			broProgDetailsBean.setAmountAlreadyAuthorised(""+already);
        			}
	    			broProgDetailsBean.setQuarter(""+qtrs);
					//broProgDetailsBean.setBudgetEstimate(""+be);
					//broProgDetailsBean.setAmountAlreadyAuthorised(""+already);
					//broProgDetailsBean.setAmountNowAuthorised(""+now);
					
	   			}
    			else
    			{
    				be=0;already=0;
    				broProgDetailsBean.setQuarter(""+qtrs);
    				//broProgDetailsBean.setBudgetEstimate(""+be);
    				//broProgDetailsBean.setAmountAlreadyAuthorised(""+already);
    				//broProgDetailsBean.setAmountNowAuthorised("0");
    			}
				
				
				broDetailsList.set(rowId,broProgDetailsBean);
				//session.setAttribute("broDetailsList",broDetailsList);
				//int amountnow=0;
				
				for(int i = 0;i<broDetailsList.size();i++)
	    		{
    				Rws_BroProgDetailsBean broProgDetailsBean1=(Rws_BroProgDetailsBean)broDetailsList.get(i);
    				if(i!=rowId){
    				if(broProgDetailsBean1.getSubprogrammeCode() != null &&  !broProgDetailsBean1.getSubprogrammeCode().equals("")){
    						ArrayList subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean1.getProgrammeCode());
    						broProgDetailsBean1.setSubProgrammesList(subProgrammesList);
    				    //amountnow+=Integer.parseInt(broProgDetailsBean1.getAmountNowAuthorised());
    				    //broProgDetailsBean1.setAmountAlreadyAuthorised(""+amountnow);
    				    //broDetailsList
    					broDetailsList.set(i,broProgDetailsBean1);
    					
    				}
    				 if(broProgDetailsBean1.getSubprogrammeCode() == null || broProgDetailsBean1.getSubprogrammeCode().equals(""))
    				 {
    				 	ArrayList subProgrammesList = new ArrayList(0);
    				 	broProgDetailsBean1.setSubProgrammesList(subProgrammesList);
    					broDetailsList.set(i,broProgDetailsBean1);
    				 }
    				}
	    		}
				
				session.setAttribute("broDetailsList",broDetailsList);
    		}
    	/*	if(mode!=null && mode.equals("getFundType"))
    		{
    		    String headofaccount=request.getParameter("headofaccount");
    		    String groupsubhead=headofaccount.substring(12,15);
    		    Rws_BroData  broobject=new Rws_BroData(getDataSource(request));
    		   
    		    String fundtype=broobject.getFundType(groupsubhead);
    		    response.flushBuffer();
    		    PrintWriter writer= response.getWriter();
    		    response.setContentType("text/xml");
    		    response.setHeader("Cache-Control", "no-cache");
    		    writer.write(fundtype);
    		}*/
    		
    		
    		if(mode!=null && mode.equals("getQtrDetails"))
    		{
    			CommonLists commonLists=new CommonLists(getDataSource(request));
    			ArrayList broDetailsList=frm.getBroDetailsList();
    			
    			
    			int rowId=Integer.parseInt(request.getParameter("rowId"));
    			Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)broDetailsList.get(rowId);
    			broProgDetailsBean.setBroId(frm.getBro_id());
    			int be = 0,already=0,now=0;
    			
    			boolean exists=broData.findBudgetQuarterValue(broProgDetailsBean);
    			
    			Debug.println("Get Quearter details"+commonLists.getStatus(broProgDetailsBean));
    			
    			if(commonLists.getStatus(broProgDetailsBean))
    			{
	    			be = commonLists.getBudgetAmount1(broProgDetailsBean);
	    			already = commonLists.getAmountAlready1(broProgDetailsBean);
	    			//now = commonLists.getAmountNow(broProgDetailsBean);
	    			broProgDetailsBean.setAmountAlreadyAuthorised(""+already);
    			}
    			else
    			{
    				broProgDetailsBean.setBudgetEstimate("0");
    				broProgDetailsBean.setAmountAlreadyAuthorised("0");
    				broProgDetailsBean.setAmountNowAuthorised("0");
    			}
				//broProgDetailsBean.setBudgetEstimate(""+be);
				
				//broProgDetailsBean.setAmountNowAuthorised(""+now);
				
				
				//System.out.println("Already**** "+already+"Now**"+now);		
				broDetailsList.set(rowId,broProgDetailsBean);
				
				ArrayList subProgrammesList=null;
				
			for(int i = 0;i<broDetailsList.size();i++)
	    		{
    				Rws_BroProgDetailsBean broProgDetailsBean1=(Rws_BroProgDetailsBean)broDetailsList.get(i);
    				if(broProgDetailsBean1.getSubprogrammeCode() != null &&  !broProgDetailsBean1.getSubprogrammeCode().equals(""))
    					{
    						 subProgrammesList = commonLists.getSubprogrammes(broProgDetailsBean1.getProgrammeCode());
    						broProgDetailsBean1.setSubProgrammesList(subProgrammesList);
    						broDetailsList.set(i,broProgDetailsBean1);
    					
    				}
    				 else if(broProgDetailsBean1.getSubprogrammeCode() == null || broProgDetailsBean1.getSubprogrammeCode().equals(""))
    				 {
    				 	subProgrammesList = new ArrayList(0);
    				 	broProgDetailsBean1.setSubProgrammesList(subProgrammesList);
    					broDetailsList.set(i,broProgDetailsBean1);
    				 }
	    		}
				session.setAttribute("broDetailsList",broDetailsList);
				
				
				
    		}
    		if(mode!=null && mode.equals("delete"))
    		{
    			String bro_id=request.getParameter("bro_id");
    			String message=broData.deleteBroDetails(bro_id);
    			request.setAttribute("message",message);
    		}
    		if(mode!=null && mode.equals("deleteBro"))
    		{
    			String bro_id=frm.getBro_id();
    			String message=broData.deleteBroDetails(bro_id);
    			request.setAttribute("message",message);
    			
    			ArrayList broIdList=broData.getBroIdList();
    			session.setAttribute("broIdList",broIdList);
    		}
    		//this statement executes under all modes	
    		frm.setBroDetailsList(emptyList);
        		
		}
    	catch(Exception e){
    		//System.out.println("Exception in Rws_BroDetailsFrm is "+e);}
    	}
    	return mapping.findForward(mode);
	}
    
    void resetFrm(ActionForm form,HttpSession session)
    {
    	
    	ArrayList emptyList=new ArrayList(0);
    	Rws_BroDetailsForm frm=(Rws_BroDetailsForm)form;
    	frm.setBro_id("");
		frm.setBro_reference("");
		frm.setBro_date("");
		frm.setBro_budgetEstimate("");
		frm.setBro_sanctionAmount("");
		frm.setBro_amount("");
		frm.setBro_financialYear("");
		frm.setAppflag("");
		frm.setBro_appAmount("");
		frm.setBro_addAmount("");
		frm.setGf("");
		frm.setScp("");
		frm.setTsp("");
				
		frm.setBroDetailsList(emptyList);
		session.removeAttribute("broDetailsList");
		
    }
    void printBroDetailsListSizes(ArrayList locDetailsList)
    {
    	//System.out.println("in printBroDetailsListSizes"+locDetailsList.size());
    	for(int i=0;i<locDetailsList.size();i++)
    	{
    		Rws_BroProgDetailsBean broProgDetailsBean=(Rws_BroProgDetailsBean)locDetailsList.get(i);
    		ArrayList subProgrammesList=broProgDetailsBean.getSubProgrammesList();
    		if(subProgrammesList != null)
    			Debug.println("subProgrammesList size for "+i+"th object is "+subProgrammesList.size());
    		//System.out.println("selected values are :");
    		//System.out.println(locProgDetailsBean.getDistrict());
    		//System.out.println(broProgDetailsBean.getProgrammeCode());
    		//System.out.println(locProgDetailsBean.getSubprogram());
    		//System.out.println(locProgDetailsBean.getLocAmount());
    		//System.out.println(locProgDetailsBean.getOffice());
    		//System.out.println(locProgDetailsBean.getPlace());
    		//System.out.println(locProgDetailsBean.getPaoApaoFlag());
    		//System.out.println(locProgDetailsBean.getRemarks());
    		//Debug.println(broProgDetailsBean.getBudgetEstimateYear());
    	}
    }
}