package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class SectionForm extends ActionForm
{
	private String hoc;
	private String coc;
	private String doc;
	private String sdoc;
	private String soc;
	private String son;
	private String button;
	private String mode;
		
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
	public void setSoc(String soc)
	{
		this.soc=soc;
	}
	public String getSoc()
	{
		return soc;
	}
	public void setSon(String son)
	{
		this.son=son;
	}
	public String getSon()
	{
		return son;
	}
	public void setButton(String button)
	{
		this.button=button;
	}
	public String getButton()
	{
		return button;
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
		 this.coc="";
		 this.doc="";
		 this.sdoc="";
		 this.soc="";
		 this.son="";
	}
	
}