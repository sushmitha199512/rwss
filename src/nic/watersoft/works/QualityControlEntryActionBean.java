/*
 * Created on 22-03-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.io.Serializable;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

/**
 * @author RWSS_DPT1(Sai Prasad N)
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class QualityControlEntryActionBean extends ActionForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	String workId;

	String workName;

	String programName;

	String sanctionedDate;
	
	String sanctionedAmount;

	String subProgName;
	
	String sanctionedHabs;
	
	private String qcCertificateImage;

	private String tptReportImage;
	
	private FormFile qcImg;
	private FormFile tptImg;
	private String qcImgAvailble;
	private String tptImgAvailble;
	
	private String issueDate;
    private String certDate;
	
	//String typeOfWork;
   private  String workGndDate;
    private String engineerAssign;
	private String engineerAssign1;
	private String engineerAssign2;
	private String engineerAssign3;
	
	

	//String coveredHabs;

    public String getQcImgAvailble() {
		return qcImgAvailble;
	}
	public void setQcImgAvailble(String qcImgAvailble) {
		this.qcImgAvailble = qcImgAvailble;
	}
	public String getTptImgAvailble() {
		return tptImgAvailble;
	}
	public void setTptImgAvailble(String tptImgAvailble) {
		this.tptImgAvailble = tptImgAvailble;
	}
	public FormFile getQcImg() {
		return qcImg;
	}
	public void setQcImg(FormFile qcImg) {
		this.qcImg = qcImg;
	}
	public FormFile getTptImg() {
		return tptImg;
	}
	public void setTptImg(FormFile tptImg) {
		this.tptImg = tptImg;
	}
	public String getQcCertificateImage() {
		return qcCertificateImage;
	}
	public void setQcCertificateImage(String qcCertificateImage) {
		this.qcCertificateImage = qcCertificateImage;
	}
	public String getTptReportImage() {
		return tptReportImage;
	}
	public void setTptReportImage(String tptReportImage) {
		this.tptReportImage = tptReportImage;
	}

	String isAdmnSanction;
    public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public String getCertDate() {
		return certDate;
	}
	public void setCertDate(String certDate) {
		this.certDate = certDate;
	}

	
	

	
	public String getWorkGndDate() {
		return workGndDate;
	}
	public void setWorkGndDate(String workGndDate) {
		this.workGndDate = workGndDate;
	}
	public String getEngineerAssign() {
		return engineerAssign;
	}
	public void setEngineerAssign(String engineerAssign) {
		this.engineerAssign = engineerAssign;
	}
	public String getEngineerAssign1() {
		return engineerAssign1;
	}
	public void setEngineerAssign1(String engineerAssign1) {
		this.engineerAssign1 = engineerAssign1;
	}
	public String getEngineerAssign2() {
		return engineerAssign2;
	}
	public void setEngineerAssign2(String engineerAssign2) {
		this.engineerAssign2 = engineerAssign2;
	}
	public String getEngineerAssign3() {
		return engineerAssign3;
	}
	public void setEngineerAssign3(String engineerAssign3) {
		this.engineerAssign3 = engineerAssign3;
	}
	/**
	 * @return Returns the isAdmnSanction.
	 */
	public String getIsAdmnSanction() {
		return isAdmnSanction;
	}
	/**
	 * @param isAdmnSanction The isAdmnSanction to set.
	 */
	public void setIsAdmnSanction(String isAdmnSanction) {
		this.isAdmnSanction = isAdmnSanction;
	}
	/**
	 * @return Returns the isCompletion.
	 */
	
	/**
	 * @return Returns the isTechSancationed.
	 */
	
	/**
	 * @param isTechSancationed The isTechSancationed to set.
	 */
	
	/**
	 * @return Returns the coveredHabs.
	 */
	

	/**
	 * @param coveredHabs
	 *            The coveredHabs to set.
	 */

	/**
	 * @return Returns the programName.
	 */
	public String getProgramName() {
		return programName;
	}

	/**
	 * @param programName
	 *            The programName to set.
	 */
	public void setProgramName(String programName) {
		this.programName = programName;
	}

	/**
	 * @return Returns the sanctionedAmount.
	 */
	public String getSanctionedAmount() {
		return sanctionedAmount;
	}

	/**
	 * @param sanctionedAmount
	 *            The sanctionedAmount to set.
	 */
	public void setSanctionedAmount(String sanctionedAmount) {
		this.sanctionedAmount = sanctionedAmount;
	}

	/**
	 * @return Returns the sanctionedDate.
	 */
	public String getSanctionedDate() {
		return sanctionedDate;
	}

	/**
	 * @param sanctionedDate
	 *            The sanctionedDate to set.
	 */
	public void setSanctionedDate(String sanctionedDate) {
		this.sanctionedDate = sanctionedDate;
	}

	/**
	 * @return Returns the subProgName.
	 */
	public String getSubProgName() {
		return subProgName;
	}

	/**
	 * @param subProgName
	 *            The subProgName to set.
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
	 * @param workId
	 *            The workId to set.
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
	 * @param workName
	 *            The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}



	/**
	 * @return Returns the sanctionedHabs.
	 */
	public String getSanctionedHabs() {
		return sanctionedHabs;
	}

	/**
	 * @param sanctionedHabs
	 *            The sanctionedHabs to set.
	 */
	public void setSanctionedHabs(String sanctionedHabs) {
		this.sanctionedHabs = sanctionedHabs;
	}
}