/*
 * Created on May 29, 2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;



import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import nic.watersoft.drought.Rws_Drought_Admin_Sanction_Frm;
/**
 * @author admin
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class PickAdministrativeSources extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception 
{
		Debug.println("in PickAdminStrativeSources Action class");
		System.gc();
		DataSource ds = null;
		String target = new String("data-success");
	 	String headOfficeCode = request.getParameter("hoc");
		String circleOfficeCode = request.getParameter("coc");
		String subdivisionCode = request.getParameter("subdivisionOfficeCode");
	 	String search = request.getParameter("search");
		//System.out.println("in pick sources: "+search);
		String proposalId = request.getParameter("proposalId");
		String officeCode = headOfficeCode + circleOfficeCode ;	
		String mode=request.getParameter("mode");
		//System.out.println("MODE VALUE IS---------->"+request.getParameter("mode"));
		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		
		Rws_Drought_Admin_Sanction_Frm myform=new Rws_Drought_Admin_Sanction_Frm();
		
		HttpSession session = request.getSession();
		
		if(mode != null && mode.equalsIgnoreCase("pickSources"))
		{   String ccode=(String)request.getParameter("coc");
	        Debug.println("iam in sourcesssssssssssssssssssssssssssss"+ccode);
	        try{
			DroughtDAO	proposalDAO=new DroughtDAO(getDataSource(request));
			ArrayList mandalCode = proposalDAO.getMandals(circleOfficeCode);
			int size=mandalCode.size();
	    	session.setAttribute("mandalCode",mandalCode);	
	    	Debug.println("Target:"+target+size);
	        }
	        catch(Exception e){
	        	e.printStackTrace();
	        }
			mode = "pickSources";
			
		}	

	return mapping.findForward(target);
}
	
}



