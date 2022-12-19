package nic.watersoft.contractor;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.contractor.TenderWorkIdBean;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * Form bean for a Struts application.
 * @version 	1.0
 * @author      Venugopal
 */
public class TenderNotificationForm extends ActionForm

{
	private String officeCode;
	private String tenderIdNo;
	private String typeOfTender;
	private String noOfWorks;
	private String tenderType;
	private String costOfTender;
	private String salesTax;
	private String estContractValue;
	private String modeOfExecution;
    private String issueDate;
    private String closeDate;
    private ArrayList workIds;
    private String preparedBy;
    private String preparedOn;
    private String mode;
    
     /**
     * Get issueDate
     * @return String
     */
    public TenderNotificationForm()
    {
    	workIds=new ArrayList();
    }
    
    public String getIssueDate() {
        return issueDate;
    }

	/**
	 * @return Returns the workIds.
	 */
	public ArrayList getWorkIds() {
		return workIds;
	}
	/**
	 * @param workIds The workIds to set.
	 */
	public void setWorkIds(ArrayList workIds) {
		this.workIds = workIds;
	}
    /**
     * Set issueDate
     * @param <code>String</code>
     */
    public void setIssueDate(String i) {
        this.issueDate = i;
    }

    /**
     * Get noOfWorks
     * @return String
     */
    public String getNoOfWorks() {
        return noOfWorks;
    }

    /**
     * Set noOfWorks
     * @param <code>String</code>
     */
    public void setNoOfWorks(String n) {
        this.noOfWorks = n;
    }

    /**
     * Get typeOfTender
     * @return String
     */
    public String getTypeOfTender() {
        return typeOfTender;
    }

    /**
     * Set typeOfTender
     * @param <code>String</code>
     */
    public void setTypeOfTender(String t) {
        this.typeOfTender = t;
    }

    /**
     * Get tenderIdNo
     * @return String
     */
    public String getTenderIdNo() {
        return tenderIdNo;
    }

    /**
     * Set tenderIdNo
     * @param <code>String</code>
     */
    public void setTenderIdNo(String t) {
        this.tenderIdNo = t;
    }

    /**
     * Get closeDate
     * @return String
     */
    public String getCloseDate() {
        return closeDate;
    }

    /**
     * Set closeDate
     * @param <code>String</code>
     */
    public void setCloseDate(String c) {
        this.closeDate = c;
    }

    public TenderWorkIdBean getWORKID_LIST(int index)
	{
		while(index >= workIds.size())
		{
			//System.out.println("index in getWORKID_LIST= "+index);
			workIds.add(new TenderWorkIdBean());
		}
		return (TenderWorkIdBean)workIds.get(index);
	}
    /**
	 * @return Returns the costOfTender.
	 */
	public String getCostOfTender() {
		return costOfTender;
	}
	/**
	 * @param costOfTender The costOfTender to set.
	 */
	public void setCostOfTender(String costOfTender) {
		this.costOfTender = costOfTender;
	}
	/**
	 * @return Returns the estContractValue.
	 */
	public String getEstContractValue() {
		return estContractValue;
	}
	/**
	 * @param estContractValue The estContractValue to set.
	 */
	public void setEstContractValue(String estContractValue) {
		this.estContractValue = estContractValue;
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
	/**
	 * @return Returns the modeOfExecution.
	 */
	public String getModeOfExecution() {
		return modeOfExecution;
	}
	/**
	 * @param modeOfExecution The modeOfExecution to set.
	 */
	public void setModeOfExecution(String modeOfExecution) {
		this.modeOfExecution = modeOfExecution;
	}
	/**
	 * @return Returns the officeCode.
	 */
	public String getOfficeCode() {
		return officeCode;
	}
	/**
	 * @param officeCode The officeCode to set.
	 */
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	/**
	 * @return Returns the preparedBy.
	 */
	public String getPreparedBy() {
		return preparedBy;
	}
	/**
	 * @param preparedBy The preparedBy to set.
	 */
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	/**
	 * @return Returns the preparedOn.
	 */
	public String getPreparedOn() {
		return preparedOn;
	}
	/**
	 * @param preparedOn The preparedOn to set.
	 */
	public void setPreparedOn(String preparedOn) {
		this.preparedOn = preparedOn;
	}
	/**
	 * @return Returns the salesTax.
	 */
	public String getSalesTax() {
		return salesTax;
	}
	/**
	 * @param salesTax The salesTax to set.
	 */
	public void setSalesTax(String salesTax) {
		this.salesTax = salesTax;
	}
	/**
	 * @return Returns the tenderType.
	 */
	public String getTenderType() {
		return tenderType;
	}
	/**
	 * @param tenderType The tenderType to set.
	 */
	public void setTenderType(String tenderType) {
		this.tenderType = tenderType;
	}
	

    public void reset(ActionMapping mapping, HttpServletRequest request) {

        // Reset values are provided as samples only. Change as appropriate.

        workIds.clear();
        issueDate = "";
        noOfWorks = "";
        typeOfTender = "";
        tenderIdNo = "";
        closeDate = "";
        tenderType = "";
    	costOfTender = "";
    	salesTax = "";
    	estContractValue = "";
    	modeOfExecution = "";
        

    }

}
