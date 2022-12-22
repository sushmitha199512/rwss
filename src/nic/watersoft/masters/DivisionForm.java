package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class DivisionForm extends ActionForm
{
	
	private String hoc;
	private String coc;
	private String doc;
	private String don;
	private String mode;
	private String divStatus;
		
	/**
	 * @return Returns the divStatus.
	 */
	public String getDivStatus() {
		return divStatus;
	}
	/**
	 * @param divStatus The divStatus to set.
	 */
	public void setDivStatus(String divStatus) {
		this.divStatus = divStatus;
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
	public void setDon(String don)
	{
		this.don=don;
	}
	public String getDon()
	{
		return don;
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
		 this.coc=" ";
		 this.doc=" ";
		 this.don=" ";
	}
	
}