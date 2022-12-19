package nic.watersoft.admin;

import java.io.Serializable;

public class Employee implements Serializable
{
	private String userid;
	private String code;
	private String name;
	private String label;
	private String presentStation;
	private String specialization;
	private String qualification;
	private String designation;
	private String permission;
	private String accessScope;
	private String role;
	private String roleId;
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
	private String delete;
	private String accountActivationDate;
	private String officeName;
	
	public void setUserid(String userid)
	{	this.userid = userid;
	}
	public String getUserid()
	{	return userid;
	}

	public void setCode(String code)
	{	this.code = code;
	}
	public String getCode()
	{	return code;
	}
	public void setName(String name)
	{	this.name = name;
	}
	public String getName()
	{	return name;
	}

	public void setLabel(String label)
	{	this.label = label;
	}
	public String getLabel()
	{	return label;
	}
	
	public void setDesignation(String designation)
	{	this.designation = designation;	
		
	}
	public String getDesignation()
	{	return designation;
	}

	public void setQualification(String qualification)
	{	this.qualification = qualification;
	}
	public String getQualification()
	{	return qualification;
	}
	
	public void setPresentStation(String presentStation)
	{	this.presentStation = presentStation;
	}
	public String getPresentStation()
	{	return presentStation;
	}

	public void setSpecialization(String specialization)
	{	this.specialization = specialization;
	}
	public String getSpecialization()
	{	return specialization;
	}

	public void setPermission(String permission)
	{	this.permission = permission;
	}
	public String getPermission()
	{	return permission;
	}
	
	public void setAccessScope(String accessScope)
	{	this.accessScope = accessScope;
	}
	public String getAccessScope()
	{	return accessScope;
	}

	public void setRole(String role)
	{	this.role = role;
	}
	public String getRole()
	{	return role;
	}
	
	public void setRoleId(String roleId)
	{	this.roleId = roleId;
	}
	public String getRoleId()
	{	return roleId;
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

	public void setDelete(String delete)
	{	this.delete = delete;
	}
	public String getDelete()
	{	return delete;
	}
	
	public void setAccountActivationDate(String accountActivationDate)
	{	this.accountActivationDate = accountActivationDate;
	}
	
	public String getAccountActivationDate()
	{	return accountActivationDate;		
	}
	
	public void setOfficeName(String officeName)
	{	this.officeName = officeName;		
	}
	
	public String getOfficeName()
	{	return officeName;		
	}
}
