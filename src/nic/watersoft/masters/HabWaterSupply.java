package nic.watersoft.masters;

public class HabWaterSupply
{
	private String shpSupply;
	private String shpNo;
	private String cisternsSupply;
	private String cisternsNo;
	private String glsrSupply;
	private String glsrNo;
	private String ohsrSupply;
	private String ohsrNo;
	private String drinkTotalSupply;
	private String drinkTotalNo;
	private String hpSupply;
	private String hpNo;
	private String owsSupply;
	private String owsNo;
	private String pondsSupply;
	private String pondsNo;
	private String shwSupply;
	private String shwNo;
	private String otherTotalSupply;
	private String otherTotalNo;
	private String pcpdDrink;
	private String pcpdOthers;
	private String pcpdTotal;
	private String totalWaterSupply;
	private String levelOfWaterSupply;
	private String status;
	
	public HabWaterSupply()
	{
		
	}
	public HabWaterSupply(String shpSupply, String shpNo, String cisternsSupply, String cisternsNo, String glsrSupply,
				String glsrNo, String ohsrSupply, String ohsrNo, String drinkTotalSupply, String drinkTotalNo,
				String hpSupply, String hpNo, String owsSupply,String owsNo, String pondsSupply, 
				String pondsNo, String shwSupply, String shwNo, String otherTotalSupply, String otherTotalNo,  
				String pcpdDrink, String pcpdOthers, String pcpdTotal, String status)
	{
		this.shpSupply = shpSupply;
		this.shpNo = shpNo;
		this.cisternsSupply = cisternsSupply;
		this.cisternsNo = cisternsNo;
		this.glsrSupply = glsrSupply;
		this.glsrNo = glsrNo;
		this.ohsrSupply = ohsrSupply;
		this.ohsrNo = ohsrNo;
		this.drinkTotalSupply = drinkTotalSupply;
		this.drinkTotalNo = drinkTotalNo;
		this.hpSupply = hpSupply;
		this.hpNo = hpNo;
		this.owsSupply = owsSupply;
		this.owsNo = owsNo;
		this.pondsSupply = pondsSupply;
		this.pondsNo = pondsNo;
		this.shwSupply = shwSupply;
		this.shwNo = shwNo;
		this.otherTotalSupply = otherTotalSupply;
		this.otherTotalNo = otherTotalNo;
		this.pcpdDrink = pcpdDrink;
		this.pcpdOthers = pcpdOthers;
		this.pcpdTotal = pcpdTotal;
		this.status = status;
	}
	
	
	
	public String getCisternsNo() {
		return cisternsNo;
	}
	public void setCisternsNo(String cisternsNo) {
		this.cisternsNo = cisternsNo;
	}
	public String getCisternsSupply() {
		return cisternsSupply;
	}
	public void setCisternsSupply(String cisternsSupply) {
		this.cisternsSupply = cisternsSupply;
	}
	public String getDrinkTotalNo() {
		return drinkTotalNo;
	}
	public void setDrinkTotalNo(String drinkTotalNo) {
		this.drinkTotalNo = drinkTotalNo;
	}
	public String getDrinkTotalSupply() {
		return drinkTotalSupply;
	}
	public void setDrinkTotalSupply(String drinkTotalSupply) {
		this.drinkTotalSupply = drinkTotalSupply;
	}
	public String getGlsrNo() {
		return glsrNo;
	}
	public void setGlsrNo(String glsrNo) {
		this.glsrNo = glsrNo;
	}
	public String getGlsrSupply() {
		return glsrSupply;
	}
	public void setGlsrSupply(String glsrSupply) {
		this.glsrSupply = glsrSupply;
	}
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getHpSupply() {
		return hpSupply;
	}
	public void setHpSupply(String hpSupply) {
		this.hpSupply = hpSupply;
	}
	public String getOhsrNo() {
		return ohsrNo;
	}
	public void setOhsrNo(String ohsrNo) {
		this.ohsrNo = ohsrNo;
	}
	public String getOhsrSupply() {
		return ohsrSupply;
	}
	public void setOhsrSupply(String ohsrSupply) {
		this.ohsrSupply = ohsrSupply;
	}
	public String getOtherTotalNo() {
		return otherTotalNo;
	}
	public void setOtherTotalNo(String otherTotalNo) {
		this.otherTotalNo = otherTotalNo;
	}
	public String getOtherTotalSupply() {
		return otherTotalSupply;
	}
	public void setOtherTotalSupply(String otherTotalSupply) {
		this.otherTotalSupply = otherTotalSupply;
	}
	public String getOwsNo() {
		return owsNo;
	}
	public void setOwsNo(String owsNo) {
		this.owsNo = owsNo;
	}
	public String getOwsSupply() {
		return owsSupply;
	}
	public void setOwsSupply(String owsSupply) {
		this.owsSupply = owsSupply;
	}
	public String getPcpdDrink() {
		return pcpdDrink;
	}
	public void setPcpdDrink(String pcpdDrink) {
		this.pcpdDrink = pcpdDrink;
	}
	public String getPcpdOthers() {
		return pcpdOthers;
	}
	public void setPcpdOthers(String pcpdOthers) {
		this.pcpdOthers = pcpdOthers;
	}
	public String getPcpdTotal() {
		return pcpdTotal;
	}
	public void setPcpdTotal(String pcpdTotal) {
		this.pcpdTotal = pcpdTotal;
	}
	public String getPondsNo() {
		return pondsNo;
	}
	public void setPondsNo(String pondsNo) {
		this.pondsNo = pondsNo;
	}
	public String getPondsSupply() {
		return pondsSupply;
	}
	public void setPondsSupply(String pondsSupply) {
		this.pondsSupply = pondsSupply;
	}
	public String getShpNo() {
		return shpNo;
	}
	public void setShpNo(String shpNo) {
		this.shpNo = shpNo;
	}
	public String getShpSupply() {
		return shpSupply;
	}
	public void setShpSupply(String shpSupply) {
		this.shpSupply = shpSupply;
	}
	public String getShwNo() {
		return shwNo;
	}
	public void setShwNo(String shwNo) {
		this.shwNo = shwNo;
	}
	public String getShwSupply() {
		return shwSupply;
	}
	public void setShwSupply(String shwSupply) {
		this.shwSupply = shwSupply;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public void setTotalWaterSupply(String totalWaterSupply)
	{	this.totalWaterSupply = totalWaterSupply;
	}
	public String getTotalWaterSupply()
	{	return totalWaterSupply;
	}
	
	public void setLevelOfWaterSupply(String levelOfWaterSupply)
	{	this.levelOfWaterSupply = levelOfWaterSupply;
	}
	public String getLevelOfWaterSupply()
	{	return levelOfWaterSupply;
	}
}
