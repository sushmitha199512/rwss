/*
 * Created on 13-Jul-2010
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.DynaActionForm;
/**
 * @author Sridhar
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class rws_Work_Gap_Act extends Action  {
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws Exception
	 {
		rws_works_WorkStatus_form workform= (rws_works_WorkStatus_form)form;
		HttpSession ses=request.getSession(); 
	 	String mode=""; 
	 	String circleCode,progCode,progName;
	 	String workid,workname,adminno,admindate,samount,assettype,astwork,assets;
	 	//Debug.println("1");
	 	try{ 
	 		circleCode=workform.getCircleCode(); 
	 		progCode=workform.getProgCode(); 
	 		//subDivCode=workform.getSubDivCode();  
	 		RwsOffices rwsoffice=new RwsOffices(getDataSource(request));
	 		HttpSession session=request.getSession();
	 		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
			Debug.println("user:"+user);
			if(user==null)
				return mapping.findForward("expire");
			session = request.getSession();
		
		rws_Aug_Link_Mainscheme_Dao alm=new rws_Aug_Link_Mainscheme_Dao();
	    mode=request.getParameter("mode");
	    if(mode.equals("data"))
		{
	    	ArrayList circles = rwsoffice.getCircles();
	    	ArrayList programs = alm.getPrograms(circleCode);
	 	 	ses.setAttribute("circles",circles);
	 	 	ses.setAttribute("programs",programs);
	 	 	//ses.setAttribute("divisions",divisions);
	 	 	session.removeAttribute("viewworks");
		}
	    
	    if(mode.equals("save"))
	    {
	      String stage=request.getParameter("workStage");
		  System.out.println("stage:"+stage);
	      String val=request.getParameter("value");
	      Debug.println("valof:"+val);
	      int updateworks=alm.UpdateWorks(stage,val);
	      if(updateworks>0)
	       	request.setAttribute("message",updateworks+" Work(s) Updated Successfully");
			 else
			request.setAttribute("message","Failed to Update");
	      
	     mode="view";  
	    } 
	    if(mode.equals("view"))
	    {
	     String cir=workform.getCircleCode();
	     Debug.println("circle:"+cir);
	     //String st[]=request.getParameterValues("mode1");
	     String stage=request.getParameter("workStage");
	     System.out.println("stage:"+stage);
	    
	     ArrayList viewworks=alm.getViewWorks(stage,circleCode,progCode);	 
	     session.setAttribute("viewworks",viewworks);
	     
	    }
	    if(mode.equals("excelview")) 
	    { 
	    	Debug.println("in excel view mode");
	     String cir=workform.getCircleCode();
	     //Debug.println("circle:"+cir);
	     String circode=request.getParameter("circle");
	     String stage=request.getParameter("workStage");
	     System.out.println("stage:"+stage);
	    
	     ArrayList viewworks=alm.getViewWorks(stage,circode,progCode);	 
	     Debug.println("size in action:"+viewworks.size());
	     session.setAttribute("viewworks",viewworks);
	     
	    }
	 	}catch(Exception e)
		{
	 		System.out.println("Exception in Work Gap Act:"+e);
		}
	 return mapping.findForward(mode);
	 }

}
