package nic.watersoft.masters;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;


/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class QCAgencyForm extends ActionForm
{
	private String agencycode, agencyname, finyear, psourceCode;
	
	public String getFinyear() {
		return finyear;
	}

	public void setFinyear(String finyear) {
		this.finyear = finyear;
	}

	public String getAgencycode() {
		return agencycode;
	}

	public void setAgencycode(String agencycode) {
		this.agencycode = agencycode;
	}

	public String getAgencyname() {
		return agencyname;
	}

	public void setAgencyname(String agencyname) {
		this.agencyname = agencyname;
	}
	
	

	public static boolean isString(String str)
	{
	    return ((!str.equals(""))
	            && (str != null)
	            && (str.matches("^[a-zA-Z /,.]*$")));
	}
	
	public static boolean isNumber(String str)
	{
	    return ((!str.equals(""))
	            && (str != null)
	            && (str.matches("^[0-9]*$")));
	}

	public String getPsourceCode() {
		return psourceCode;
	}

	public void setPsourceCode(String psourceCode) {
		this.psourceCode = psourceCode;
	}
}
