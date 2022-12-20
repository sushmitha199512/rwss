/*
 * Created on 30-05-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * @author RWSS_DPT1(Sai Prasad N)
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsContractorAmtTransferBean extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList transfersList;
	private String isDsValide;
	private ArrayList sourceBankDetails;
	private String sourceBankIfscCode;
	private String availableGrant;
	private String isSourcebankRegister;
	private String tokenSLNO;

	public String getTokenSLNO() {
		return tokenSLNO;
	}

	public void setTokenSLNO(String tokenSLNO) {
		this.tokenSLNO = tokenSLNO;
	}

	public String getAvailableGrant() {
		return availableGrant;
	}

	public String getIsSourcebankRegister() {
		return isSourcebankRegister;
	}

	public void setIsSourcebankRegister(String isSourcebankRegister) {
		this.isSourcebankRegister = isSourcebankRegister;
	}

	public void setAvailableGrant(String availableGrant) {
		this.availableGrant = availableGrant;
	}

	public String getSourceBankIfscCode() {
		return sourceBankIfscCode;
	}

	public void setSourceBankIfscCode(String sourceBankIfscCode) {
		this.sourceBankIfscCode = sourceBankIfscCode;
	}

	public ArrayList getSourceBankDetails() {
		return sourceBankDetails;
	}

	public void setSourceBankDetails(ArrayList sourceBankDetails) {
		this.sourceBankDetails = sourceBankDetails;
	}

	public String getIsDsValide() {
		if (this.isDsValide == null || this.isDsValide.equals("")) {
			return "no";
		}
		return isDsValide;
	}

	public void setIsDsValide(String isDsValide) {
		this.isDsValide = isDsValide;
	}

	private String certificate;

	public String getCertificate() {
		return certificate;
	}

	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}

	public ArrayList getTransfersList() {
		return transfersList;
	}

	public void setTransfersList(ArrayList transfersList) {
		this.transfersList = transfersList;
	}

}