/**
 * Created on Jun 15, 2007
 
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import java.util.ArrayList;

 
public class rws_works_pick_tsHabs_form extends ActionForm
{
	private String mode;
	
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
}
