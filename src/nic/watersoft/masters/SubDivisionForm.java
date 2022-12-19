package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class SubDivisionForm extends ActionForm
{
	private String hoc;
	private String coc;
	private String doc;
	private String sdoc;
	private String sdon;
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
	public void setSdon(String sdon)
	{
		this.sdon=sdon;
	}
	public String getSdon()
	{
		return sdon;
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
		 this.sdoc=" ";
		 this.sdon=" ";
	}
	
}