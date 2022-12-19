/*
 * Created on 30-11-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.io.Serializable;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * @author Sai Prasad N
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */

public class RwspartABillForm extends ActionForm implements Serializable {

	
	@Override
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
	
		System.out.println("validating");
		return super.validate(mapping, request);
	}
	
	@Override
	public void reset(ActionMapping mapping, HttpServletRequest request) {
	System.out.println("Reseting");
		
		super.reset(mapping, request);
	}
	private String workName;

	private String workId;

	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}

	/**
	 * @param workId
	 *            The workId to set.
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}

	private String newsrcName;

	/**
	 * @return Returns the newsrcName.
	 */
	public String getNewsrcName() {
		return newsrcName;
	}

	/**
	 * @param newsrcName
	 *            The newsrcName to set.
	 */
	public void setNewsrcName(String newsrcName) {
		this.newsrcName = newsrcName;
	}

	/**
	 * @return Returns the workName.
	 */
	public String getWorkName() {
		return workName;
	}

	/**
	 * @param workName
	 *            The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}

	ArrayList billsList = null;

	ArrayList vouchersList = null;

	/**
	 * @return Returns the vouchersList.
	 */
	public ArrayList getVouchersList() {

		if (vouchersList == null) {
			return new ArrayList();
		}
		return vouchersList;

	}

	/**
	 * @param vouchersList
	 *            The vouchersList to set.
	 */
	public void setVouchersList(ArrayList vouchersList) {
		this.vouchersList = vouchersList;
	}

	/**
	 * @return Returns the billsList.
	 */
	public ArrayList getBillsList() {
		if (billsList == null) {
			return new ArrayList();
		}
		return billsList;
	}

	/**
	 * @param billsList
	 *            The billsList to set.
	 */
	public void setBillsList(ArrayList billsList) {
		this.billsList = billsList;
	}
}