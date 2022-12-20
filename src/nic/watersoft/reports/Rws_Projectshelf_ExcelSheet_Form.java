package nic.watersoft.reports;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

/**
 * 
 * @author Sai Prasad N Modified On 22.04.2014
 */
public class Rws_Projectshelf_ExcelSheet_Form extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String demo1;
	private String demo2;

	private int totalSchemes;
	private int totalSchemeSources;
	private int schemesNotHavingSources;
	private int totalHabitations;
	private int schemesNotHavingHabs;
	private int schemesNotHavingProgs;

	private FormFile uploadFile;
	
	private String msg;

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public FormFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(FormFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	public int getTotalSchemes() {
		return totalSchemes;
	}

	public void setTotalSchemes(int totalSchemes) {
		this.totalSchemes = totalSchemes;
	}

	public int getTotalSchemeSources() {
		return totalSchemeSources;
	}

	public void setTotalSchemeSources(int totalSchemeSources) {
		this.totalSchemeSources = totalSchemeSources;
	}

	public int getSchemesNotHavingSources() {
		return schemesNotHavingSources;
	}

	public void setSchemesNotHavingSources(int schemesNotHavingSources) {
		this.schemesNotHavingSources = schemesNotHavingSources;
	}

	public int getTotalHabitations() {
		return totalHabitations;
	}

	public void setTotalHabitations(int totalHabitations) {
		this.totalHabitations = totalHabitations;
	}

	public int getSchemesNotHavingHabs() {
		return schemesNotHavingHabs;
	}

	public void setSchemesNotHavingHabs(int schemesNotHavingHabs) {
		this.schemesNotHavingHabs = schemesNotHavingHabs;
	}

	public int getSchemesNotHavingProgs() {
		return schemesNotHavingProgs;
	}

	public void setSchemesNotHavingProgs(int schemesNotHavingProgs) {
		this.schemesNotHavingProgs = schemesNotHavingProgs;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	/**
	 * @return Returns the demo1.
	 */
	public String getDemo1() {
		return demo1;
	}

	/**
	 * @param demo1
	 *            The demo1 to set.
	 */
	public void setDemo1(String demo1) {
		this.demo1 = demo1;
	}

	/**
	 * @return Returns the demo2.
	 */
	public String getDemo2() {
		return demo2;
	}

	/**
	 * @param demo2
	 *            The demo2 to set.
	 */
	public void setDemo2(String demo2) {
		this.demo2 = demo2;
	}
}
