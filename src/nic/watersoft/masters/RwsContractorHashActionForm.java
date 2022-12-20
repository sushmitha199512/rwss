package nic.watersoft.masters;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsContractorHashActionForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String contractorCode;
	private String cotractorName;
	private String ifscCode;
	private String bankName;
	private String accountNumber;
	private String certificate;
	
	
	
	
	

	public String getCertificate() {
		return certificate;
	}

	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}

	private ArrayList cList=new ArrayList();

	public ArrayList getcList() {
		return cList;
	}

	public void setcList(ArrayList cList) {
		this.cList = cList;
	}

	public String getContractorCode() {
		return contractorCode;
	}

	public void setContractorCode(String contractorCode) {
		this.contractorCode = contractorCode;
	}

	public String getCotractorName() {
		return cotractorName;
	}

	public void setCotractorName(String cotractorName) {
		this.cotractorName = cotractorName;
	}

	public String getIfscCode() {
		return ifscCode;
	}

	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

}
