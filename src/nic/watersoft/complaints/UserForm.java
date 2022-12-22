package nic.watersoft.complaints;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.BaseActionForm;

import org.apache.struts.action.ActionMapping;

public class UserForm extends BaseActionForm
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String agencycode;
	private String districtCode;
	private String scope;
	private String userId;	
	private String password;
	private String area;
	private String module;
	private String newPassword;	
	private String oldPassword;
	private String password1;
	private String confirmPassword;
	private String hint;
	
	private String read;
	private String write;
	private String del;
	private String mode;
	private String name;
	private String aadhaar;
	private String email;
	private String mobile;
	private String remarks;
	private String target;
	
	
	
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getModule() {
		return module;
	}
	public void setModule(String module) {
		this.module = module;
	}
	public void setUserId(String userId)
	{	this.userId = userId; 
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getUserid()
	{	return userId;
	}
	
	public void setPassword(String password)
	{	this.password = password;
	}
	public String getPassword()
	{	return password;
	}
	
	/*public void setDesignationCode(String designationCode)
	{	this.designationCode = designationCode;	
	}
	public String getDesignationCode()
	{	return designationCode;
	}*/
		
	public void setNewPassword(String newPassword)
	{	this.newPassword = newPassword;
	}
	public String getNewPassword()
	{	return newPassword;
	}

	public void setOldPassword(String oldPassword)
	{	this.oldPassword = oldPassword;
	}
	public String getOldPassword()
	{	return oldPassword;
	}

	public void setConfirmPassword(String confirmPassword)
	{	this.confirmPassword = confirmPassword; 
	}
	public String getConfirmPassword()
	{	return confirmPassword;
	}
	
	public void setHint(String hint)
	{	this.hint = hint;
	}
	public String getHint()
	{	return hint;
	}

	/*public void setProposals(String proposals)
	{	this.proposals = proposals;
	}
	public String getProposals()
	{	return proposals;
	}
	
	public void setEstimates(String estimates)
	{	this.estimates = estimates;
	}
	public String getEstimates()
	{	return estimates;
	}
	
	public void setWaterquality(String waterquality)
	{	this.waterquality = waterquality;
	}
	public String getWaterquality()
	{	return	waterquality;
	}
	
	public void setContractor(String contractor)
	{	this.contractor = contractor;
	}
	public String getContractor()
	{	return contractor;
	}
	
	public void setWorks(String works)
	{	this.works = works;
	}
	public String getWorks()
	{	return works;
	}
	
	public void setAssets(String assets)
	{	this.assets = assets;
	}
	public String getAssets()
	{	return assets;
	}
	
	public void setFunds(String funds)
	{	this.funds = funds;
	}
	public String getFunds()
	{	return funds;
	}
	
	public void setStocks(String stocks)
	{	this.stocks = stocks;
	}
	public String getStocks()
	{	return stocks;
	}	
	
	public void setMasters(String masters)
	{	this.masters = masters;
	}
	public String getMasters()
	{	return	masters;
	}	*/
	
	public void setRead(String read)
	{	this.read = read;
	}
	public String getRead()
	{	return read;
	}

	public void setWrite(String write)
	{	this.write = write;
	}
	public String getWrite()
	{	return	write;
	}

	public void setDel(String del)
	{	this.del = del;
	}
	public String getDel()
	{	return del;
	}
		
	public void setMode(String mode)
	{	this.mode = mode;
	}
	public String getMode()
	{	return mode;
	}
		
	/*public String getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}*/
	
	public String getUserId() {
		return userId;
	}
	public String getAgencycode() {
		return agencycode;
	}
	public void setAgencycode(String agencycode) {
		this.agencycode = agencycode;
	}
	public String getDistrictCode() {
		return districtCode;
	}
	public void setDistrictCode(String districtCode) {
		this.districtCode = districtCode;
	}
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAadhaar() {
		return aadhaar;
	}
	public void setAadhaar(String aadhaar) {
		this.aadhaar = aadhaar;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		this.userId = "";
		this.password = "";
		this.confirmPassword = "";
		this.newPassword = "";
		this.oldPassword = "";
		this.hint = "";
		this.name = "";
		this.aadhaar = "";
		this.agencycode = "";
		this.scope = "";
		this.districtCode = "";
		this.email = "";
		this.mobile = "";
		this.remarks = "";
		
		this.read = "";
		this.write = "";
		this.del = "";
	}
	public void setPassword1(String password1) {
		this.password1 = password1;
	}
	public String getPassword1() {
		return password1;
	}
}
