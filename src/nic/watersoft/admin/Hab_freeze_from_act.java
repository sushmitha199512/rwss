/*
 * Created on Nov 6, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.admin;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.*;
import nic.watersoft.commons.*;
import java.util.ArrayList;
/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Hab_freeze_from_act extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			 HttpServletResponse response) throws Exception{
			 Hab_freeze_form frm=(Hab_freeze_form)form;
		     //System.out.println("printing mode");
			 //System.out.println("mode is "+request.getParameter("mode"));
			 // to populate the districts
			 String target = request.getParameter("mode");
             RwsOffices rwsoffices=new RwsOffices(getDataSource(request)); 
			 ArrayList districtlist=rwsoffices.getDistricts();
			 request.setAttribute("districts",districtlist);
			 //to display habitation status date to be freezed
			 Freeze_status_data freeze_status_data= new Freeze_status_data();
			 String StatusDt=freeze_status_data.getStatusDt();
			 frm.setMhabstatus(StatusDt);
			 
			 
			 return mapping.findForward(target);
	}
    
	
	
			 

}
