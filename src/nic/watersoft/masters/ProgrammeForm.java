package nic.watersoft.masters;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class ProgrammeForm extends ActionForm
{
	private String prgmCode;
	private String prgmName;
	private String prgmStartYr;
	private double centralShare;
	private double stateShare;
	private double publicShare;
	private double otherShare;
	private String status;
	private String prgmEndDate;
	private String mode;
	private String nrdwprelated;
	private String cmcoredb;
	private String progBelongTo;
		
	public void setPrgmCode(String prgmCode)
	{
		this.prgmCode=prgmCode;
	}
	public String getPrgmCode()
	{
		return prgmCode;
	}
	public void setPrgmName(String prgmName)
	{
		this.prgmName=prgmName;
	}
	public String getPrgmName()
	{
		return prgmName;
	}
	public void setPrgmStartYr(String prgmStartYr)
	{
		this.prgmStartYr=prgmStartYr;
	}
	public String getPrgmStartYr()
	{
		return prgmStartYr;
	}
	
	public double getCentralShare() {
		return centralShare;
	}
	public void setCentralShare(double centralShare) {
		this.centralShare = centralShare;
	}
	public double getStateShare() {
		return stateShare;
	}
	public void setStateShare(double stateShare) {
		this.stateShare = stateShare;
	}
	public double getPublicShare() {
		return publicShare;
	}
	public void setPublicShare(double publicShare) {
		this.publicShare = publicShare;
	}
	public double getOtherShare() {
		return otherShare;
	}
	public void setOtherShare(double otherShare) {
		this.otherShare = otherShare;
	}
	public void setStatus(String status)
	{
		this.status=status;
	}
	public String getStatus()
	{
		return status;
	}
	public void setPrgmEndDate(String prgmEndDate)
	{
		this.prgmEndDate=prgmEndDate;
	}
	public String getPrgmEndDate()
	{
		return prgmEndDate;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode)
	{
		this.mode=mode;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode()
	{
		return mode;
	}
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		this.prgmCode="";   
		this.prgmName="";   
		this.prgmStartYr="";
		this.centralShare=0;  
		this.stateShare=0;    
		this.publicShare=0;   
		this.otherShare=0;    
		this.status="";     
		this.prgmEndDate="";
		this.nrdwprelated="";
		this.cmcoredb="";
	}
	public String getNrdwprelated() {
		return nrdwprelated;
	}
	public void setNrdwprelated(String nrdwprelated) {
		this.nrdwprelated = nrdwprelated;
	}
	public String getCmcoredb() {
		return cmcoredb;
	}
	public void setCmcoredb(String cmcoredb) {
		this.cmcoredb = cmcoredb;
	}
	public String getProgBelongTo() {
		return progBelongTo;
	}
	public void setProgBelongTo(String progBelongTo) {
		this.progBelongTo = progBelongTo;
	}
		
		
}
