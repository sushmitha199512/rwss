package nic.watersoft.admin;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.BaseActionForm;

import org.apache.struts.action.ActionMapping;

public class UserForm extends BaseActionForm
{	
	private String userId;
	private String password;
	private String designationCode;
	private String newPassword;	
	private String oldPassword;
	private String password1;
	private String confirmPassword;
	private String hint;
	private String proposals; 
	private String estimates;
	private String waterquality;
	private String contractor;
	private String works;
	private String assets;
	private String funds;
	private String stocks;
	private String masters;
	private String read;
	private String write;
	private String del;
	private String mode;
	
	private String roleId;
	private String roleName;
	private String roleDesc;

	public void setUserId(String userId)
	{	this.userId = userId; 
	}
	public String getUserid()
	{	return userId;
	}
	
	public void setPassword(String password)
	{	this.password = password;
	}
	public String getPassword()
	{	
		return password;
	}
	
	public void setDesignationCode(String designationCode)
	{	this.designationCode = designationCode;	
	}
	public String getDesignationCode()
	{	return designationCode;
	}
		
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

	public void setProposals(String proposals)
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
	}	
	
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
		
	public String getRoleDesc() {
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
	}
	
	public String getUserId() {
		return userId;
	}
	public void reset(ActionMapping mapping, HttpServletRequest request)
	{
		this.userId = "";
		this.password = "";
		this.confirmPassword = "";
		this.newPassword = "";
		this.oldPassword = "";
		this.hint = "";
		this.proposals = "";
		this.estimates = "";
		this.waterquality = "";
		this.contractor = "";
		this.works = "";
		this.assets = "";
		this.funds = "";
		this.stocks = "";
		this.masters = "";
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
