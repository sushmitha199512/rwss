/*
 * Created on 22-09-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * @author Sai Prasad N
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsRefundActionForm extends ActionForm{

	
	private String circleCode;
	private String divName;
	private int divCode;
	private String subDivCode;
	private String subDivName;
	private String workId;
	private String workName;
	private String subProgName;
    private String subProgCode;
    private int	cmbDivision;
    String programCode;

	/**
	 * @return Returns the programCode.
	 */
	public String getProgramCode() {
		return programCode;
	}
	/**
	 * @param programCode The programCode to set.
	 */
	public void setProgramCode(String programCode) {
		this.programCode = programCode;
	}
    String releaseDate;
    String finYear;
    
	/**
	 * @return Returns the finYear.
	 */
	public String getFinYear() {
		return finYear;
	}
	/**
	 * @param finYear The finYear to set.
	 */
	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}
	/**
	 * @return Returns the releaseDate.
	 */
	public String getReleaseDate() {
		return releaseDate;
	}
	/**
	 * @param releaseDate The releaseDate to set.
	 */
	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}
    private ArrayList refundWorks=new ArrayList();;
    private String bankOrPao;
    
    
    public RefundWork getRefundWork(int index) {
    	    	  while (this.refundWorks.size() <= index) {
    	  	refundWorks.add(new RefundWork());
    	  }
    	  return ((RefundWork) refundWorks.get(index)); 
    	 }
    
	/**
	 * @return Returns the bankOrPao.
	 */
	public String getBankOrPao() {
		
		return bankOrPao;
	}
	/**
	 * @param bankOrPao The bankOrPao to set.
	 */
	public void setBankOrPao(String bankOrPao) {
		this.bankOrPao = bankOrPao;
	}
	/**
	 * @return Returns the circleCode.
	 */
	public String getCircleCode() {
		return circleCode;
	}
	/**
	 * @param circleCode The circleCode to set.
	 */
	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}
	/**
	 * @return Returns the divCode.
	 */
	public int getDivCode() {
		return divCode;
	}
	/**
	 * @param divCode The divCode to set.
	 */
	public void setDivCode(int divCode) {
		this.divCode = divCode;
	}
	/**
	 * @return Returns the divName.
	 */
	public String getDivName() {
		return divName;
	}
	/**
	 * @param divName The divName to set.
	 */
	public void setDivName(String divName) {
		this.divName = divName;
	}
	/**
	 * @return Returns the subDivCode.
	 */
	public String getSubDivCode() {
		return subDivCode;
	}
	/**
	 * @param subDivCode The subDivCode to set.
	 */
	public void setSubDivCode(String subDivCode) {
		this.subDivCode = subDivCode;
	}
	/**
	 * @return Returns the subDivName.
	 */
	public String getSubDivName() {
		return subDivName;
	}
	/**
	 * @param subDivName The subDivName to set.
	 */
	public void setSubDivName(String subDivName) {
		this.subDivName = subDivName;
	}
	/**
	 * @return Returns the subProgCode.
	 */
	public String getSubProgCode() {
		return subProgCode;
	}
	/**
	 * @param subProgCode The subProgCode to set.
	 */
	public void setSubProgCode(String subProgCode) {
		this.subProgCode = subProgCode;
	}
	/**
	 * @return Returns the subProgName.
	 */
	public String getSubProgName() {
		return subProgName;
	}
	/**
	 * @param subProgName The subProgName to set.
	 */
	public void setSubProgName(String subProgName) {
		this.subProgName = subProgName;
	}
	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}
	/**
	 * @param workId The workId to set.
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	/**
	 * @return Returns the workName.
	 */
	public String getWorkName() {
		return workName;
	}
	/**
	 * @param workName The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	/**
	 * @return Returns the cmbDivision.
	 */
	public int getCmbDivision() {
		return cmbDivision;
	}
	/**
	 * @param cmbDivision The cmbDivision to set.
	 */
	public void setCmbDivision(int cmbDivision) {
		this.cmbDivision = cmbDivision;
	}
	/**
	 * @param refundWorks
	 */
	public void setRefundWorks(ArrayList refundWorks) {
		this.refundWorks=refundWorks;
		
	}
	/**
	 * @return Returns the refundWorks.
	 */
	public ArrayList getRefundWorks() {
		return refundWorks;
	}
}
