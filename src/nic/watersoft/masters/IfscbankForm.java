package nic.watersoft.masters;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class IfscbankForm extends ActionForm
{
	private String ifscCode="";
private String bankName="";
private String branchName="";
private String accountNumber="";
private String bankAddress="";
private String mode="";
private String accountholderName="";
private String personAccount="";
private String personAddress="";
private String personAddress1="";
/**
 * @return Returns the accountholderName.
 */
public String getAccountholderName() {
	return accountholderName;
}
/**
 * @param accountholderName The accountholderName to set.
 */
public void setAccountholderName(String accountholderName) {
	this.accountholderName = accountholderName;
}
/**
 * @return Returns the personAccount.
 */
public String getPersonAccount() {
	return personAccount;
}
/**
 * @param personAccount The personAccount to set.
 */
public void setPersonAccount(String personAccount) {
	this.personAccount = personAccount;
}
/**
 * @return Returns the personAddress.
 */
public String getPersonAddress() {
	return personAddress;
}
/**
 * @param personAddress The personAddress to set.
 */
public void setPersonAddress(String personAddress) {
	this.personAddress = personAddress;
}
/**
 * @return Returns the personAddress1.
 */
public String getPersonAddress1() {
	return personAddress1;
}
/**
 * @param personAddress1 The personAddress1 to set.
 */
public void setPersonAddress1(String personAddress1) {
	this.personAddress1 = personAddress1;
}
/**
 * @return Returns the accountNumber.
 */
public String getAccountNumber() {
	return accountNumber;
}
/**
 * @param accountNumber The accountNumber to set.
 */
public void setAccountNumber(String accountNumber) {
	this.accountNumber = accountNumber;
}
/**
 * @return Returns the bankAddress.
 */
public String getBankAddress() {
	return bankAddress;
}
/**
 * @param bankAddress The bankAddress to set.
 */
public void setBankAddress(String bankAddress) {
	this.bankAddress = bankAddress;
}
/**
 * @return Returns the bankName.
 */
public String getBankName() {
	return bankName;
}
/**
 * @param bankName The bankName to set.
 */
public void setBankName(String bankName) {
	this.bankName = bankName;
}
/**
 * @return Returns the branchName.
 */
public String getBranchName() {
	return branchName;
}
/**
 * @param branchName The branchName to set.
 */
public void setBranchName(String branchName) {
	this.branchName = branchName;
}
	/**
	 * @return Returns the ifscCode.
	 */
	public String getIfscCode() {
		return ifscCode;
	}
	/**
	 * @param ifscCode The ifscCode to set.
	 */
	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}
/**
 * @return Returns the mode.
 */
public String getMode() {
	return mode;
}
/**
 * @param mode The mode to set.
 */
public void setMode(String mode) {
	this.mode = mode;
}
}