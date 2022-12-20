/*
 * Created on Jan 12, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.DynaActionForm;
 
public class rws_hab_location_status_FormBean extends DynaActionForm {
	
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
     set("mode","data");
     set("coverageStaus","true");
 	}

}
