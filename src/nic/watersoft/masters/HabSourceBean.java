package nic.watersoft.masters;

import java.io.Serializable;

public class HabSourceBean implements Serializable
{
	
	private String habCode;
	private String panchRajCode;
	private String panchRajName; 
	private int totPop;
	private String coverStatus;
	private boolean isSaved;
	private String isChecked="false";
	public HabSourceBean()
	{
		
	}
	public HabSourceBean(String habCode,String panchRajCode,String panchRajName,int totPop,String coverStatus)
	{
		this.habCode=habCode;
		this.panchRajCode=panchRajCode;
		this.panchRajName=panchRajName;
		this.totPop=totPop;
		this.coverStatus=coverStatus;
		this.isSaved=false;
		this.isChecked="true";
	}
	public HabSourceBean(String habCode,String panchRajCode,String panchRajName,int totPop,String coverStatus,boolean isSaved)
	{
		this.habCode=habCode;
		this.panchRajCode=panchRajCode;
		this.panchRajName=panchRajName;
		this.totPop=totPop;
		this.coverStatus=coverStatus;
		this.isSaved=isSaved;
		//System.out.println("isSaved is "+this.isSaved);
	}
	
	
  
	/**
	 * @return Returns the coverStatus.
	 */
	public String getCoverStatus() {
		return coverStatus;
	}
	/**
	 * @param coverStatus The coverStatus to set.
	 */
	public void setCoverStatus(String coverStatus) {
		this.coverStatus = coverStatus;
	}
	/**
	 * @return Returns the habCode.
	 */
	public String getHabCode() {
		return habCode;
	}
	/**
	 * @param habCode The habCode to set.
	 */
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	/**
	 * @return Returns the panchRajCode.
	 */
	public String getPanchRajCode() {
		return panchRajCode;
	}
	/**
	 * @param panchRajCode The panchRajCode to set.
	 */
	public void setPanchRajCode(String panchRajCode) {
		this.panchRajCode = panchRajCode;
	}
	/**
	 * @return Returns the panchRajName.
	 */
	public String getPanchRajName() {
		return panchRajName;
	}
	/**
	 * @param panchRajName The panchRajName to set.
	 */
	public void setPanchRajName(String panchRajName) {
		this.panchRajName = panchRajName;
	}
	/**
	 * @return Returns the totPop.
	 */
	public int getTotPop() {
		return totPop;
	}
	/**
	 * @param totPop The totPop to set.
	 */
	public void setTotPop(int totPop) {
		this.totPop = totPop;
	}
	public boolean isSaved() {
		return isSaved;
	}
	public void setSaved(boolean isSaved) {
		this.isSaved = isSaved;
	}
	
	public String getIsChecked() {
		return isChecked;
	}
	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}
}