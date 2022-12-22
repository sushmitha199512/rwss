package nic.watersoft.contractor;

import java.util.ArrayList;
import org.apache.struts.action.ActionForm;

public class ContractorForm
  extends ActionForm
{
  private String workId = "";
  private String workName = "";
  private String adminNo = "";
  private String sanctionAmount = "";
  private String sanctionDate = "";
  private String officeEntered = "";
  private String mode;
  private String adminDate = "";
  private ArrayList works;
  private ArrayList workscircles;
  
  public ContractorForm() {}
  
  public ArrayList getWorkscircles()
  {
    return workscircles;
  }
  

  public void setWorkscircles(ArrayList workscircles)
  {
    this.workscircles = workscircles;
  }
  

  private String circleOfficeCode = "";
  private String circleOfficeName = "";
  private String circleCode = "";
  private String circleName = "";
  


  public String getCircleCode()
  {
    return circleCode;
  }
  

  public void setCircleCode(String circleCode)
  {
    this.circleCode = circleCode;
  }
  

  public String getCircleName()
  {
    return circleName;
  }
  

  public void setCircleName(String circleName)
  {
    this.circleName = circleName;
  }
  

  public String getCircleOfficeCode()
  {
    return circleOfficeCode;
  }
  

  public void setCircleOfficeCode(String circleOfficeCode)
  {
    this.circleOfficeCode = circleOfficeCode;
  }
  

  public String getCircleOfficeName()
  {
    return circleOfficeName;
  }
  

  public void setCircleOfficeName(String circleOfficeName)
  {
    this.circleOfficeName = circleOfficeName;
  }
  

  public String getDivisionOfficeCode()
  {
    return divisionOfficeCode;
  }
  

  public void setDivisionOfficeCode(String divisionOfficeCode)
  {
    this.divisionOfficeCode = divisionOfficeCode;
  }
  

  public String getDivisionOfficeName()
  {
    return divisionOfficeName;
  }
  



  public void setDivisionOfficeName(String divisionOfficeName) { this.divisionOfficeName = divisionOfficeName; }
  
  private String divisionOfficeCode = "";
  private String divisionOfficeName = "";
  



  public String getContractorCode()
  {
    return contractorCode;
  }
  

  public void setContractorCode(String contractorCode)
  {
    this.contractorCode = contractorCode;
  }
  

  public String getContractorName()
  {
    return contractorName;
  }
  



  public void setContractorName(String contractorName) { this.contractorName = contractorName; }
  
  private String contractorCode = "";
  private String contractorName = "";
  
  public String getAdminDate()
  {
    return adminDate;
  }
  

  public void setAdminDate(String adminDate)
  {
    this.adminDate = adminDate;
  }
  

  public String getMode()
  {
    return mode;
  }
  

  public void setMode(String mode)
  {
    this.mode = mode;
  }
  

  public String getAdminNo()
  {
    return adminNo;
  }
  

  public void setAdminNo(String adminNo)
  {
    this.adminNo = adminNo;
  }
  

  public String getOfficeEntered()
  {
    return officeEntered;
  }
  

  public void setOfficeEntered(String officeEntered)
  {
    this.officeEntered = officeEntered;
  }
  

  public String getSanctionAmount()
  {
    return sanctionAmount;
  }
  

  public void setSanctionAmount(String sanctionAmount)
  {
    this.sanctionAmount = sanctionAmount;
  }
  

  public String getSanctionDate()
  {
    return sanctionDate;
  }
  

  public void setSanctionDate(String sanctionDate)
  {
    this.sanctionDate = sanctionDate;
  }
  

  public String getWorkId()
  {
    return workId;
  }
  

  public void setWorkId(String workId)
  {
    this.workId = workId;
  }
  

  public String getWorkName()
  {
    return workName;
  }
  

  public void setWorkName(String workName)
  {
    this.workName = workName;
  }
  

  public ArrayList getWorks()
  {
    return works;
  }
  

  public void setWorks(ArrayList works)
  {
    this.works = works;
  }
}
