package nic.watersoft.proposals;

import java.io.Serializable;

public class workProposals implements Serializable 
{
	
	private String proposalName;
	private String proposalId;
	private int noOfHabs;
	private String addHab;
	private float estimateCost;
	private String remarks;
	private String augmentation;
	private float sancAmount;
	private String circleCode;
	private String divisionCode;
	private String subdivisionCode;
	private String gomsno;
	private String godate;
	private String chkBox;
	
	private String habCode;
	private String habName;
	private String assemblyCode;
	private String assemblyName;
	private String mandalCode;
	private String mandalName;
	private String population;
	private String covStatus;
	
	// Acessors 
	public void setSubdivisionCode(String subdivisionCode)
	{
		this.subdivisionCode = subdivisionCode;
	}
	public String getSubdivisionCode()
	{
		return subdivisionCode;
	}
	public void setDivisionCode(String divisionCode)
	{
		this.divisionCode = divisionCode;
	}
	public String getDivisionCode()
	{
		return divisionCode;
	}
	public void setCircleCode(String circleCode)
	{
		this.circleCode = circleCode;
	}
	public String getCircleCode()
	{
		return circleCode;
	}
	public void setSancAmount(float sancAmount)
	{
		this.sancAmount = sancAmount;
	}
	public float getSancAmount()
	{
		return sancAmount;
	}
	public void setAugmentation(String augmentation)
	{
		this.augmentation = augmentation;
	}
	public String getAugmentation()
	{
		return augmentation;
	}
	public void setRemarks(String remarks)
	{
		this.remarks = remarks;
	}
	public String getRemarks()
	{
		return addHab;
	}
	public void setEstimateCost(float estimateCost)
	{
		this.estimateCost = estimateCost;
	}
	public float getEstimateCost()
	{
		return estimateCost;
	}
	public void setAddHab(String addHab)
	{
		this.addHab = addHab;
	}
	public String getAddHab()
	{
		return addHab;
	}
	public void setNoOfHabs(int noOfHabs)
	{
		this.noOfHabs = noOfHabs;
	}
	public int getNoOfHabs()
	{
		return noOfHabs;
	}
public void setProposalId(String proposalId)
	{
		this.proposalId = proposalId;
	}
	public String getProposalId()
	{
		return proposalId;
	}
public void setProposalName(String proposalName)
	{
		this.proposalName = proposalName;
	}
	public String getProposalName()
	{
		return proposalName;
	}
	
	
	
	/**
	 * @return Returns the gomsno.
	 */
	public String getGomsno() {
		return gomsno;
	}
	/**
	 * @param gomsno The gomsno to set.
	 */
	public void setGomsno(String gomsno) {
		this.gomsno = gomsno;
	}
	/**
	 * @return Returns the godate.
	 */
	public String getGodate() {
		return godate;
	}
	/**
	 * @param godate The godate to set.
	 */
	public void setGodate(String godate) {
		this.godate = godate;
	}
	 
	/**
	 * @return Returns the chkBox.
	 */
	public String getChkBox() {
		return chkBox;
	}
	/**
	 * @param chkBox The chkBox to set.
	 */
	public void setChkBox(String chkBox) {
		this.chkBox = chkBox;
	}
	/**
	 * @return Returns the aCode.
	 */
	 
	/**
	 * @return Returns the covStatus.
	 */
	public String getCovStatus() {
		return covStatus;
	}
	/**
	 * @param covStatus The covStatus to set.
	 */
	public void setCovStatus(String covStatus) {
		this.covStatus = covStatus;
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
	 * @return Returns the habName.
	 */
	public String getHabName() {
		return habName;
	}
	/**
	 * @param habName The habName to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
	}
	/**
	 * @return Returns the mandalCode.
	 */
	public String getMandalCode() {
		return mandalCode;
	}
	/**
	 * @param mandalCode The mandalCode to set.
	 */
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
	}
	/**
	 * @return Returns the mandalName.
	 */
	public String getMandalName() {
		return mandalName;
	}
	/**
	 * @param mandalName The mandalName to set.
	 */
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	/**
	 * @return Returns the population.
	 */
	public String getPopulation() {
		return population;
	}
	/**
	 * @param population The population to set.
	 */
	public void setPopulation(String population) {
		this.population = population;
	}
	/**
	 * @return Returns the assemblyCode.
	 */
	public String getAssemblyCode() {
		return assemblyCode;
	}
	/**
	 * @param assemblyCode The assemblyCode to set.
	 */
	public void setAssemblyCode(String assemblyCode) {
		this.assemblyCode = assemblyCode;
	}
	/**
	 * @return Returns the assemblyName.
	 */
	public String getAssemblyName() {
		return assemblyName;
	}
	/**
	 * @param assemblyName The assemblyName to set.
	 */
	public void setAssemblyName(String assemblyName) {
		this.assemblyName = assemblyName;
	}
}
