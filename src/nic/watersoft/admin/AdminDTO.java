
package nic.watersoft.admin;

import java.io.Serializable;

import nic.watersoft.commons.BaseDTO;


public class AdminDTO extends BaseDTO implements Serializable
{
	private String userid;
	private String password;
	private String newPassword;	
	private String oldPassword;	
	private String confirmPassword;
	private String designation;
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
	private String role;
	private String roleId;
	private String roleName;
	private String roleDesc;
		
	public String getAssets() {
		return assets;
	}
	
	public void setAssets(String assets) {
		this.assets = assets;
	}
	
	public String getConfirmPassword() {
		return confirmPassword;
	}
	
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	
	public String getContractor() {
		return contractor;
	}
	
	public void setContractor(String contractor) {
		this.contractor = contractor;
	}
	
	public String getDel() {
		return del;
	}
	
	public void setDel(String del) {
		this.del = del;
	}
	
	public String getEstimates() {
		return estimates;
	}
	
	public void setEstimates(String estimates) {
		this.estimates = estimates;
	}
	
	public String getFunds() {
		return funds;
	}
	
	public void setFunds(String funds) {
		this.funds = funds;
	}
	
	public String getHint() {
		return hint;
	}
	
	public void setHint(String hint) {
		this.hint = hint;
	}
	
	public String getMasters() {
		return masters;
	}
	
	public void setMasters(String masters) {
		this.masters = masters;
	}
	
	public String getNewPassword() {
		return newPassword;
	}
	
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	
	public String getOldPassword() {
		return oldPassword;
	}
	
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getProposals() {
		return proposals;
	}
	
	public void setProposals(String proposals) {
		this.proposals = proposals;
	}
	
	public String getRead() {
		return read;
	}
	
	public void setRead(String read) {
		this.read = read;
	}
	
	public String getRole() {
		return role;
	}
	
	public void setRole(String role) {
		this.role = role;
	}
	
	public String getStocks() {
		return stocks;
	}
	
	public void setStocks(String stocks) {
		this.stocks = stocks;
	}
	
	public String getUserid() {
		return userid;
	}
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getWaterquality() {
		return waterquality;
	}
	
	public void setWaterquality(String waterquality) {
		this.waterquality = waterquality;
	}
	
	public void setWorks(String works)
	{	this.works = works;
	}
	public String getWorks()
	{	return works;
	}
			
	public void setWrite(String write)
	{	this.write = write;
	}
	public String getWrite()
	{	return write;
	}
	
	public void setRoleId(String roleId)
	{	this.roleId = roleId;
	}
	public String getRoleId()
	{	return roleId;
	}
	
	public void setRoleName(String roleName)
	{	this.roleName = roleName;
	}
	public String getRoleName()
	{	return roleName;
	}
	
	public void setRoleDesc(String roleDesc)
	{	this.roleDesc = roleDesc;
	}
	public String getRoleDesc()
	{	return roleDesc;
	}
	
	public void setDesignation(String designation)
	{	this.designation = designation;
	}
	public String getDesignation()
	{	return designation ;
	}
	
}
