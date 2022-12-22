package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class WQLabForm extends ActionForm
{
	
	private String status;
	/**
	 * @return Returns the status.
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status The status to set.
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	private String mode;
	private String hoc;
	private String coc;
	private String doc;
	private String sdoc;
	private String desgnCode;
	private String labCode;
	private String labName; 
	private String location;
	private String labEstablishedYear;
	private String contactNum;
	private String levelCode;
	private String mancode;
	private String subdivcode;
	
	ArrayList heads=new ArrayList();
	ArrayList circlecodes=new ArrayList();
	ArrayList divcodes=new ArrayList();
	ArrayList mandalcodes=new ArrayList();
	
	ArrayList subDivisions=new ArrayList();
	/**
	 * @return Returns the subdivcode.
	 */
	public String getSubdivcode() {
		return subdivcode;
	}
	/**
	 * @param subdivcode The subdivcode to set.
	 */
	public void setSubdivcode(String subdivcode) {
		this.subdivcode = subdivcode;
	}
	public void setMancode(String mancode)
	{
		this.mancode=mancode;
	}
	public String getMancode()
	{
		return mancode;
	}	
	public void setlabEstablishedYear(String labEstablishedYear)
	{
		this.labEstablishedYear=labEstablishedYear;
	}
	public String getlabEstablishedYear()
	{
		return labEstablishedYear;
	}
	public void setcontactNum(String contactNum)
	{
		this.contactNum=contactNum;
	}
	public String getcontactNum()
	{
		return contactNum;
	}
	public void setlevelCode(String levelCode)
	{
		this.levelCode=levelCode;
	}
	public String getlevelCode()
	{
		return levelCode;
	}
	public void setHoc(String hoc)
	{
		this.hoc=hoc;
	}
	public String getHoc()
	{
		return hoc;
	}
	public void setCoc(String coc)
	{
		this.coc=coc;
	}
	public String getCoc()
	{
		return coc;
	}
	public void setDoc(String doc)
	{
		this.doc=doc;
	}
	public String getDoc()
	{
		return doc;
	}
	public void setSdoc(String sdoc)
	{
		this.sdoc=sdoc;
	}
	public String getSdoc()
	{
		return sdoc;
	}
	public void setLabCode(String labCode)
	{
		this.labCode=labCode;
	}
	public String getLabCode()
	{
		return labCode;
	}
	public void setLabName(String labName)
	{
		this.labName=labName;
	}
	public String getLabName()
	{
		return labName;
	}
	public void setLocation(String location)
	{
		this.location=location;
	}
	public String getLocation()
	{
		return location;
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
	/**
	 * @param mode The desgnCode to set.
	 */
	public void setDesgnCode(String desgnCode)
	{
		this.desgnCode=desgnCode;
	}
	/**
	 * @return Returns the desgnCode.
	 */
	public String getDesgnCode()
	{
		return desgnCode;
	}
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		HttpSession session=request.getSession();
		this.labCode="";  
		this.labName="";  
		this.location="";
		this.hoc="";
		this.desgnCode="";
		this.mancode="";
		heads=(ArrayList)session.getAttribute("heads");
		circlecodes=(ArrayList)session.getAttribute("circlecodes");
		divcodes=(ArrayList)session.getAttribute("divcodes");
		mandalcodes=(ArrayList)session.getAttribute("mandalcodes");
		if(heads != null)
		{
			circlecodes.clear();
			divcodes.clear();
		}
	}
	
}