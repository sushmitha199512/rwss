
package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class ContractorForm extends ActionForm
{
		
	private String contractorCode;    
	private String contractorName;
	private String contractorClass;    
	private String contractorRating;
	private String contractorRegno;    
	private String registerAt;
	private String registrationDate;    
	private String street;
	private String area;    
	private String city;
	private String pin;
	private String phone;    
	private String mobile;
	private String fax;
	private String email;    
	private String panNo;
	private String tinNo;    
	private String validFrom;
	private String validTo;    
	private String projectsExecuted;
	private String projectsInhand;    
	private String projectsCompletedLastYear;
	private String projectsCompletedInTime;    
	private String projectsAbandoned;
	private String noofEoat;    
	private String noofSupplentary;
	private String noofPenalised;
	private String remarks;
	private String vatNo=null;
	private String specialize=null;
	private String mode;
	private String firstName;
    private String lastName;
    private String middleName;
    private String voterId;

    //added by Swapna on 08112010 for contractor report
    private String contractRadio;
    private String divisionRadio;
    private String cName;
    private String circleOfficeCode;
    private String circleOfficeName;
    private String divisionOfficeCode;
    private String divisionOfficeName;
    private String category;
    private String adharNo;
    private String bankName;
    private String branchName;
    private String ifscCode;
    private String accountNo;
    private String branchAddress;
    
    
	/**
	 * @return Returns the adharNo.
	 */
	public String getAdharNo() {
		return adharNo;
	}
	/**
	 * @param adharNo The adharNo to set.
	 */
	public void setAdharNo(String adharNo) {
		this.adharNo = adharNo;
	}
	/**
	 * @return Returns the firstName.
	 */
	public String getFirstName() {
		return firstName;
	}
	/**
	 * @param firstName The firstName to set.
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	/**
	 * @return Returns the lastName.
	 */
	public String getLastName() {
		return lastName;
	}
	/**
	 * @param lastName The lastName to set.
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	/**
	 * @return Returns the middleName.
	 */
	public String getMiddleName() {
		return middleName;
	}
	/**
	 * @param middleName The middleName to set.
	 */
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	/**
	 * @return Returns the voterId.
	 */
	public String getVoterId() {
		return voterId;
	}
	/**
	 * @param voterId The voterId to set.
	 */
	public void setVoterId(String voterId) {
		this.voterId = voterId;
	}
	public void setContractorName(String contractorName)
	{
		this.contractorName=contractorName;
	}
	public String getContractorName()
	{
		return contractorName;
	}
	public void setContractorCode(String contractorCode)
	{
		this.contractorCode=contractorCode;
	}
	public String getContractorCode()
	{
		return contractorCode;
	}
	public void setContractorClass(String contractorClass)
	{
		this.contractorClass=contractorClass;
	}
	public String getContractorClass()
	{
		return contractorClass;
	}
	public void setContractorRating(String contractorRating)
	{
		this.contractorRating=contractorRating;
	}
	public String getContractorRating()
	{
		return contractorRating;
	}
	public void setContractorRegno(String contractorRegno)
	{
		this.contractorRegno=contractorRegno;
	}
	public String getContractorRegno()
	{
		return contractorRegno;
	}
	public void setRegisterAt(String registerAt)
	{
		this.registerAt=registerAt;
	}
	public String getRegisterAt()
	{
		return registerAt;
	}
	public void setRegistrationDate(String registrationDate)
	{
		this.registrationDate=registrationDate;
	}
	public String getRegistrationDate()
	{
		return registrationDate;
	}
	public void setStreet(String street)
	{
		this.street=street;
	}
	public String getStreet()
	{
		return street;
	}
	public void setArea(String area)
	{
		this.area=area;
	}
	public String getArea()
	{
		return area;
	}
	public void setCity(String city)
	{
		this.city=city;
	}
	public String getCity()
	{
		return city;
	}
	public void setPin(String pin)
	{
		this.pin=pin;
	}
	public String getPin()
	{
		return pin;
	}
	public void setPhone(String phone)
	{
		this.phone=phone;
	}
	public String getPhone()
	{
		return phone;
	}
	public void setMobile(String mobile)
	{
		this.mobile=mobile;
	}
	public String getMobile()
	{
		return mobile;
	}
	public void setFax(String fax)
	{
		this.fax=fax;
	}
	public String getFax()
	{
		return fax;
	}
	public void setEmail(String email)
	{
		this.email=email;
	}
	public String getEmail()
	{
		return email;
	}
	public void setPanNo(String panNo)
	{
		this.panNo=panNo;
	}
	public String getPanNo()
	{
		return panNo;
	}
	public void setTinNo(String tinNo)
	{
		this.tinNo=tinNo;
	}
	public String getTinNo()
	{
		return tinNo;
	}
	public void setValidFrom(String validFrom)
	{
		this.validFrom=validFrom;
	}
	public String getValidFrom()
	{
		return validFrom;
	}
	public void setValidTo(String validTo)
	{
		this.validTo=validTo;
	}
	public String getValidTo()
	{
		return validTo;
	}
	public void setProjectsExecuted(String projectsExecuted)
	{
		this.projectsExecuted=projectsExecuted;
	}
	public String getProjectsExecuted()
	{
		return projectsExecuted;
	}
	public void setProjectsInhand(String projectsInhand)
	{
		this.projectsInhand=projectsInhand;
	}
	public String getProjectsInhand()
	{
		return projectsInhand;
	}
	public void setProjectsCompletedLastYear(String projectsCompletedLastYear)
	{
		this.projectsCompletedLastYear=projectsCompletedLastYear;
	}
	public String getProjectsCompletedLastYear()
	{
		return projectsCompletedLastYear;
	}
	public void setProjectsCompletedInTime(String projectsCompletedInTime)
	{
		this.projectsCompletedInTime=projectsCompletedInTime;
	}
	public String getProjectsCompletedInTime()
	{
		return projectsCompletedInTime;
	}
	public void setProjectsAbandoned(String projectsAbandoned)
	{
		this.projectsAbandoned=projectsAbandoned;
	}
	public String getProjectsAbandoned()
	{
		return projectsAbandoned;
	}
	public void setNoofEoat(String noofEoat)
	{
		this.noofEoat=noofEoat;
	}
	public String getNoofEoat()
	{
		return noofEoat;
	}
	public void setNoofSupplentary(String noofSupplentary)
	{
		this.noofSupplentary=noofSupplentary;
	}
	public String getNoofSupplentary()
	{
		return noofSupplentary;
	}
	public void setNoofPenalised(String noofPenalised)
	{
		this.noofPenalised=noofPenalised;
	}
	public String getNoofPenalised()
	{
		return noofPenalised;
	}
	public void setRemarks(String remarks)
	{
		this.remarks=remarks;
	}
	public String getRemarks()
	{
		return remarks;
	}
	public void setVatNo(String vatNo)
	{
		this.vatNo=vatNo;
	}
	public String getVatNo()
	{
		return vatNo;
	}
	public void setSpecialize(String specialize)
	{
		this.specialize=specialize;
	}
	public String getSpecialize()
	{
		return specialize;
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
	
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	public String getCircleOfficeName() {
		return circleOfficeName;
	}
	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}
	public String getCName() {
		return cName;
	}
	public void setCName(String name) {
		cName = name;
	}
	public String getContractRadio() {
		return contractRadio;
	}
	public void setContractRadio(String contractRadio) {
		this.contractRadio = contractRadio;
	}
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	public String getDivisionOfficeName() {
		return divisionOfficeName;
	}
	public void setDivisionOfficeName(String divisionOfficeName) {
		this.divisionOfficeName = divisionOfficeName;
	}
	public String getDivisionRadio() {
		return divisionRadio;
	}
	public void setDivisionRadio(String divisionRadio) {
		this.divisionRadio = divisionRadio;
	}
	
public String getCategory() {
	return category;
}
public void setCategory(String category) {
	this.category = category;
}
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		this.contractorCode="";           
		this.firstName="";
		this.lastName="";
		this.middleName="";
		this.voterId="";
		this.contractorClass="";          
		this.contractorRating="";         
		this.contractorRegno="";          
		this.registerAt="";               
		this.registrationDate="";         
		this.street="";                   
		this.area="";                     
		this.city="";                     
		this.pin="";                      
		this.phone="";                    
		this.mobile="";                   
		this.fax="";                      
		this.email="";                    
		this.panNo="";                    
		this.tinNo="";                    
		this.validFrom="";                
		this.validTo="";                  
		this.projectsExecuted="";         
		this.projectsInhand="";           
		this.projectsCompletedLastYear="";
		this.projectsCompletedInTime="";  
		this.projectsAbandoned="";        
		this.noofEoat="";                 
		this.noofSupplentary="";          
		this.noofPenalised="";            
		this.remarks="";                  
		this.vatNo="";               
		this.specialize="";          
	}
	
	/**
	 * @return Returns the accountNo.
	 */
	public String getAccountNo() {
		return accountNo;
	}
	/**
	 * @param accountNo The accountNo to set.
	 */
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
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
	public String getBranchAddress() {
		return branchAddress;
	}
	public void setBranchAddress(String branchAddress) {
		this.branchAddress = branchAddress;
	}
}