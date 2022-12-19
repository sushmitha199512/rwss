package nic.watersoft.masters;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

import java.util.*;
public class HeadForm extends ActionForm
{
	
	private String hoc;
	private String hon;
	private String mode;
	
//	added by jyothi 
	private String hoName;
	private FormFile hoImage;//TEJA
	
	
	
	private ArrayList headdetails;
	
	public FormFile getHoImage() {
		return hoImage;
	}
	public void setHoImage(FormFile hoImage) {
		this.hoImage = hoImage;
	}
	public ArrayList getHeaddetails() {
		return headdetails;
	}
	public void setHeaddetails(ArrayList headdetails) {
		this.headdetails = headdetails;
	}
	//end
		
	public void setHoc(String hoc)
	{
		this.hoc=hoc;
	}
	public String getHoc()
	{
		return hoc;
	}
	public void setHon(String hon)
	{
		this.hon=hon;
	}
	public String getHon()
	{
		return hon;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode)
	{
		this.mode=mode;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode()
	{
		return mode;
	}
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		 this.hoc=" ";
		 this.hon=" ";
	}
	
		
public String getHoName() {
	return hoName;
}
public void setHoName(String hoName) {
	this.hoName = hoName;
}
}
