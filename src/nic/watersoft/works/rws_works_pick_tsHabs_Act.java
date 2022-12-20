/*
 * Created on Jun 21, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;
import java.util.ArrayList;

import nic.watersoft.commons.RwsLocations;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import nic.watersoft.commons.Debug;

/**
 * @author reddy
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class rws_works_pick_tsHabs_Act extends Action 
{
	private DataSource dataSource;
    
   	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest 
			request,HttpServletResponse response)
	{
   		String success="";
   		DataSource ds=getDataSource(request);
   		HttpSession session =request.getSession();
   		rws_works_pick_tsHabs_form fb = (rws_works_pick_tsHabs_form)form;
   		String workId = request.getParameter("workId");
   		if(workId==null || workId.equals(""))
   		{
   			workId = request.getParameter("workId");
   		}
   		
   		String mcodes[]=null;
   		String habCodes[]=null;
   		String mode=request.getParameter("mode");
   		RwsLocations rwsLocations=null;
   		WorksDAO dao=null;
   		String revTs=request.getParameter("revTs");
   		
   		request.setAttribute("revTs",revTs);
   		ArrayList habsList=new ArrayList();
   		if(revTs!=null&revTs.equals("Yes"))
   			habsList=(ArrayList)session.getAttribute("SanctionedRevHabs");
   		if(revTs!=null&revTs.equals("No"))
   			habsList=(ArrayList)session.getAttribute("SanctionedHabs");
   		try
		{
   			 
		   			if(mode!=null&&mode.equals("saveHabs"))
		   			{  
		   				habCodes=request.getParameterValues("selectedHabCode");
		   				
		   				 
		   				ArrayList SanctionedHabs=new ArrayList();
		   				if(SanctionedHabs!=null)
		   				{
		   			 		for(int i=0;i<habCodes.length;i++)
		   					{
		   						if(habCodes[i]!=null||!habCodes[i].equals(""));;
		   						SanctionedHabs.add(habCodes[i]);
		   					}
		   			 	   if(SanctionedHabs!=null)
				              session.setAttribute("SanctionedHabs",SanctionedHabs);
		   				}
		   				
		   			}
		   			else
			   		{
				   		  rwsLocations = new RwsLocations(getDataSource(request));
				   		String circleOfficeCode=null;
				   		if(workId!=null)
				   			circleOfficeCode=workId.substring(4,6);
				   		if(request.getParameter("selectedMcodes")==null)
				   		{
					    	ArrayList mandals=rwsLocations.getMandals(circleOfficeCode);
					    	session.setAttribute("mandals", mandals);
						 	success="pick-man";
						 	if(revTs!=null && revTs.equals("Yes")){
						 		success="pick-man-rev";
						 		}
				   		}
				   		else
				   		{
				   			String all=request.getParameter("All");
				   			if(all==null||all.equals(""))
				   			{	
					   			String temp=request.getParameter("selectedMcodes");
								mcodes=temp.split("@@");
								
								dao = rws_works_factory.createWorksDAO(ds);
					        	ArrayList habitations= dao.getHabsInMandals(workId,habsList,mcodes);
					        	if(habitations!=null)
					        	  request.setAttribute("habitations",habitations);
				   		
				   			}
				   			if(all!=null&&all.equals("yes"))
				   			{
				   				  dao = rws_works_factory.createWorksDAO(ds);
					        	ArrayList habitations= dao.getTotHabs(workId,habsList);
					        	if(habitations!=null)
					        	  request.setAttribute("habitations",habitations);
				   			}
				   			success="pick-habs";
				   			if(revTs!=null&revTs.equals("Yes"))
				   				success="pick-habs-rev";
				   		}
			   		 }
		   	    
   			 
  		}
   		catch(Exception e)
		{
   			Debug.println("Exception in technical sanctioned pickhabs Action:"+e);
		}
		return mapping.findForward(success);
	}

}
