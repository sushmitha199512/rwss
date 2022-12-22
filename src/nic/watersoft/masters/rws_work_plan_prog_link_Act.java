/*
 * Created on Jun 02, 2009 
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionForm;

import nic.watersoft.commons.Debug;

import javax.servlet.http.HttpSession;

import java.util.ArrayList;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.RwsUser;



public class rws_work_plan_prog_link_Act extends Action {  
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) {
    	System.gc();    	
    	ArrayList programme=null;
    	ArrayList workCategory=null;
    	Runtime s_runtime = Runtime.getRuntime ();
    	long Used_memory = s_runtime.totalMemory () - s_runtime.freeMemory ();
		System.gc();
		Used_memory = s_runtime.totalMemory () - s_runtime.freeMemory ();		
		System.gc();
		HttpSession session = request.getSession();					 
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
        rws_work_categoryForms fb=(rws_work_categoryForms)form;       
        String mode=fb.getMode();
        try{        
	        CommonLists  com=new CommonLists (getDataSource(request));
	        workCategory=com.getWorkCategory();
	        LabelValueBean labelValueBean=(LabelValueBean)workCategory.get(1);
	        session.setAttribute("workCategory",workCategory);
	        if(mode!=null && mode.equals("prog")) {
	        	if(fb.getWorkCategory()!=null && !fb.getWorkCategory().equals("")){
	       			programme=com.getProgrammes();
	                labelValueBean=(LabelValueBean)programme.get(1);
	                session.setAttribute("Programme",programme);
	       		}
	       		else {
	       			session.removeAttribute("Programme");
	       		}
	        }
	  		else{
	   			session.removeAttribute("Programme");
	   		}       		
	        mode = "data";
	        String mode1=request.getParameter("mode");
	        rws_work_plan_prog_linkDAo dao=new rws_work_plan_prog_linkDAo(getDataSource(request));

	        if(mode1.equals("save")){
	        	if (storedToken.equals(token)){
	        	 String plan=fb.getPlan();
	        	 String wrktype=fb.getWrktype();
	        	 String category=fb.getWorkCategory();
	        	 String program=fb.getProgram();
	        	 String result = dao.insertData(plan,wrktype,category,program);
	        	 if(result.equals("success"))
	        		 request.setAttribute("message","Record Inserted Successfully");
	        	 else if(result.equals("failure"))
	        		 request.setAttribute("message","Failed to Insert");
	        	 else if(result.equals("exist"))
	        		 request.setAttribute("message","This Combination Already Exists");
	        	 if(fb.getWorkCategory()!=null && !fb.getWorkCategory().equals("")) {
	       				programme=com.getProgrammes();
	       				labelValueBean=(LabelValueBean)programme.get(1);
	       				session.setAttribute("Programme",programme);       		}
	       			else{
	       			session.removeAttribute("Programme");
	       		}
	          }
	       	}
	        
	        if(mode1.equals("view")){
	        	String plan=fb.getPlan();
	        	String wrktype=fb.getWrktype();
	        	String category=fb.getWorkCategory();
	        	String program=fb.getProgram();
	        	ArrayList viewsum= dao.getviewData(plan,wrktype,category,program);
	        	request.setAttribute("viewsum", viewsum);                   	
	        	mode = "view";			
			}
	        
	        if(mode1!=null && mode1.equals("delete")) {
	        	if (storedToken.equals(token)){
		        	fb.setPlan(request.getParameter("plan"));
		        	fb.setWrktype(request.getParameter("wrktype"));
		        	fb.setWorkCategory(request.getParameter("category"));
		        	fb.setProgram(request.getParameter("program"));
		        	String msg=dao.getdeleteData(fb);
		        	if(msg.equals("success"))
		        		request.setAttribute("message","Record Deleted Successfully");
		        	else if(msg.equals("failure"))
		        		request.setAttribute("message","Failed to Delete");        	
		        	mode="close";
	        	}
	        }
	        
	        if(mode1.equals("get")) {		 	
	        	try{
	        		programme=com.getProgrammes();
	        		session.setAttribute("Programme",programme);                  
	        		rws_work_categoryForms	form1 = new rws_work_categoryForms();		 	
	        		form1.setPlan(request.getParameter("plan"));
	        		form1.setWrktype(request.getParameter("wrktype"));
	        		form1.setWorkCategory(request.getParameter("category"));
	        		form1.setProgram(request.getParameter("program"));		 				 
	        		form1.setPlancode(request.getParameter("plan"));
	        		form1.setWorkcode(request.getParameter("wrktype"));
	        		form1.setProgramcode(request.getParameter("program"));
	        		String catname = com.getCategoryName(request.getParameter("category"));
	        		form1.setCategorycode(catname);					 
	        		if ("request".equalsIgnoreCase(mapping.getScope())) {
						request.setAttribute(mapping.getAttribute(),form1);
					}
					else {
						session.setAttribute("form1", form1);
					}
	        		mode="get";		 	
	        	}
	        	catch (Exception e) {
	        		System.out.println("The Exception in rws_work_plan_prog_link_Act "+e.getMessage());
	        	}
	        }   
	 
	        if(mode1.equals("update")) {
	        	if (storedToken.equals(token)){
		        	String pcode=request.getParameter("progcode");
		        	programme=com.getProgrammes();
		        	session.setAttribute("Programme",programme);                    	
		         	rws_work_categoryForms	form1 = new rws_work_categoryForms();
		         	form1.setWorkCategory(request.getParameter("workCategory"));
				 	form1.setProgram(request.getParameter("program"));
				 	form1.setPlan(request.getParameter("plan"));
					form1.setWrktype(request.getParameter("wrktype"));
					String  msg=dao.geteditData(form1,pcode);
		          	request.setAttribute("message",msg);  
		          	if(msg.equals("success"))
		        		request.setAttribute("message","Record Updated Successfully");
		        	else if(msg.equals("failure"))
		        		request.setAttribute("message","Record can not be Updated");
		        	else if(msg.equals("exist"))
		        		request.setAttribute("message", "The Combination Already Exists");
		          	 mode="close";
	        	}
	         }
        } 
        catch(Exception e){
        	System.out.println("The Exception in rws_work_plan_prog_link_Act "+e.getMessage());
		}        
        return mapping.findForward(mode);
	}
}