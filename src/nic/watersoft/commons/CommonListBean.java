/*
 * Created on Dec 22, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;
import java.io.Serializable;


/**
 * @author NIC-APSU-RD
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CommonListBean implements Serializable
{

	private String prgmCode;
	private String prgmName;
	private String prgmStartYr;
	private int centralShare;
	private int stateShare;
	private int publicShare;
	private int otherShare;
	private String status;
	private String prgmEndDate;

	private String subprgmCode;
	private String subprgmName;
	private String codeName;
	
	/**
	 * @return Returns the centralShare.
	 */
	public int getCentralShare() {
		return centralShare;
	}
	/**
	 * @param centralShare The centralShare to set.
	 */
	public void setCentralShare(int centralShare) {
		this.centralShare = centralShare;
	}
	/**
	 * @return Returns the codeName.
	 */
	public String getCodeName() {
		return codeName;
	}
	/**
	 * @param codeName The codeName to set.
	 */
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	/**
	 * @return Returns the otherShare.
	 */
	public int getOtherShare() {
		return otherShare;
	}
	/**
	 * @param otherShare The otherShare to set.
	 */
	public void setOtherShare(int otherShare) {
		this.otherShare = otherShare;
	}
	/**
	 * @return Returns the prgmCode.
	 */
	public String getPrgmCode() {
		return prgmCode;
	}
	/**
	 * @param prgmCode The prgmCode to set.
	 */
	public void setPrgmCode(String prgmCode) {
		this.prgmCode = prgmCode;
	}
	/**
	 * @return Returns the prgmEndDate.
	 */
	public String getPrgmEndDate() {
		return prgmEndDate;
	}
	/**
	 * @param prgmEndDate The prgmEndDate to set.
	 */
	public void setPrgmEndDate(String prgmEndDate) {
		this.prgmEndDate = prgmEndDate;
	}
	/**
	 * @return Returns the prgmName.
	 */
	public String getPrgmName() {
		return prgmName;
	}
	/**
	 * @param prgmName The prgmName to set.
	 */
	public void setPrgmName(String prgmName) {
		this.prgmName = prgmName;
	}
	/**
	 * @return Returns the prgmStartYr.
	 */
	public String getPrgmStartYr() {
		return prgmStartYr;
	}
	/**
	 * @param prgmStartYr The prgmStartYr to set.
	 */
	public void setPrgmStartYr(String prgmStartYr) {
		this.prgmStartYr = prgmStartYr;
	}
	/**
	 * @return Returns the publicShare.
	 */
	public int getPublicShare() {
		return publicShare;
	}
	/**
	 * @param publicShare The publicShare to set.
	 */
	public void setPublicShare(int publicShare) {
		this.publicShare = publicShare;
	}
	/**
	 * @return Returns the stateShare.
	 */
	public int getStateShare() {
		return stateShare;
	}
	/**
	 * @param stateShare The stateShare to set.
	 */
	public void setStateShare(int stateShare) {
		this.stateShare = stateShare;
	}
	/**
	 * @return Returns the status.
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status The status to set.
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return Returns the subprgmCode.
	 */
	public String getSubprgmCode() {
		return subprgmCode;
	}
	/**
	 * @param subprgmCode The subprgmCode to set.
	 */
	public void setSubprgmCode(String subprgmCode) {
		this.subprgmCode = subprgmCode;
	}
	/**
	 * @return Returns the subprgmName.
	 */
	public String getSubprgmName() {
		return subprgmName;
	}
	/**
	 * @param subprgmName The subprgmName to set.
	 */
	public void setSubprgmName(String subprgmName) {
		this.subprgmName = subprgmName;
	}
	}

     


