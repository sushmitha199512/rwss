package nic.watersoft.worksMonitoring;

import java.io.Serializable;
import java.util.ArrayList;
public class tenderMemo implements Serializable 
{
	private String offissuedfrom;
	private String offissuedto;
	private String workid;
	private String dateofcomp;
	private String sno;
	private String groundDate;
	private String workname;
	private String cmbWorks;
	private String works;
	private String habName;
	private String revHabName;
	private String selHabNames;
	private String panchCode;
	private String panchName;
	private String mandalName;
	private String mandalCode;
	private String subCompCode;
	private String subCompName;
	private String value;
	private String label;
	private String mstone;
	private String stages;
	private String targetDate;
	private String percentComp;
	private String mstoneCode;
	private String mstoneName;
	private String mstoneStageCode;
	private String mstoneStageName;
	private String valueOFWorkDone;
	private String mileStones;
	
	private String expMonth;
	private String expYear;
	private String expMonthDuring;
	private String expMonthUp;
	private String expUptoPrevYear;
	//private String stage;
	private ArrayList mileStone;
	private ArrayList stage;
	private ArrayList mileStoneStagesList;
	private String achievementDate;
	private String progName;
	private String progCode;
	private String aggrigateExpenditureForProg;
	
	tenderMemo()
	{
		mileStoneStagesList=new ArrayList();
	}
	// Acessors 
	public void setRevHabName(String revHabName)
	{
		this.revHabName = revHabName;
	}
	public String getRevHabName()
	{
		return revHabName;
	}
	public void setWorks(String works)
	{
		this.works = works;
	}
	public String getWorks()
	{
		return works;
	}
	public void setCmbWorks(String cmbWorks)
	{
		this.cmbWorks = cmbWorks;
	}
	public String getCmbWorks()
	{
		return cmbWorks;
	}
	public void setGroundDate(String groundDate)
	{
		this.groundDate = groundDate;
	}
	public String getGroundDate()
	{
		return groundDate;
	}
	 
	public void setOffissuedfrom(String offissuedfrom)
	{
		this.offissuedfrom = offissuedfrom;
	}
	public String getOffissuedfrom()
	{
		return offissuedfrom;
	}
	public void setOffissuedto(String offissuedto)
	{
		this.offissuedto = offissuedto;
	}
	public String getOffissuedto()
	{
		return offissuedto;
	}
	public void setWorkid(String workid)
	{
		this.workid = workid;
	}
	public String getWorkid()
	{
		return workid;
	}
	public void setDateofcomp(String dateofcomp)
	{
		this.dateofcomp = dateofcomp;
	}
	public String getDateofcomp()
	{
		return dateofcomp;
	}
	
	/**
	 * @return Returns the workname.
	 */
	public String getWorkname() {
		return workname;
	}
	/**
	 * @param workname The workname to set.
	 */
	public void setWorkname(String workname) {
		this.workname = workname;
	}
	/**
	 * @return Returns the habNames.
	 */
	public String getHabName() {
		return habName;
	}
	/**
	 * @param habNames The habNames to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
	}
	/**
	 * @return Returns the selHabNames.
	 */
	public String getSelHabNames() {
		return selHabNames;
	}
	/**
	 * @param selHabNames The selHabNames to set.
	 */
	public void setSelHabNames(String selHabNames) {
		this.selHabNames = selHabNames;
	}
	/**
	 * @return Returns the panchCode.
	 */
	public String getPanchCode() {
		return panchCode;
	}
	/**
	 * @param panchCode The panchCode to set.
	 */
	public void setPanchCode(String panchCode) {
		this.panchCode = panchCode;
	}
	/**
	 * @return Returns the panchName.
	 */
	public String getPanchName() {
		return panchName;
	}
	/**
	 * @param panchName The panchName to set.
	 */
	public void setPanchName(String panchName) {
		this.panchName = panchName;
	}
	/**
	 * @return Returns the subCompCode.
	 */
	/**
	 * @return Returns the panchCode.
	 */
	public String getMandalCode() {
		return mandalCode;
	}
	/**
	 * @param panchCode The panchCode to set.
	 */
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
		}
	/**
	 * @return Returns the panchName.
	 */
	public String getMandalName() {
		return mandalName;
	}
	/**
	 * @param panchName The panchName to set.
	 */
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	/**
	 * @return Returns the subCompCode.
	 */
	public String getSubCompCode() {
		return subCompCode;
	}
	/**
	 * @param subCompCode The subCompCode to set.
	 */
	public void setSubCompCode(String subCompCode) {
		this.subCompCode = subCompCode;
	}
	/**
	 * @return Returns the subCompName.
	 */
	public String getSubCompName() {
		return subCompName;
	}
	/**
	 * @param subCompName The subCompName to set.
	 */
	public void setSubCompName(String subCompName) {
		this.subCompName = subCompName;
	}
	/**
	 * @return Returns the label.
	 */
	public String getLabel() {
		return label;
	}
	/**
	 * @param label The label to set.
	 */
	public void setLabel(String label) {
		this.label = label;
	}
	/**
	 * @return Returns the value.
	 */
	public String getValue() {
		return value;
	}
	/**
	 * @param value The value to set.
	 */
	public void setValue(String value) {
		this.value = value;
	}
	/**
	 * @return Returns the mstone.
	 */
	public String getMstone() {
		return mstone;
	}
	/**
	 * @param mstone The mstone to set.
	 */
	public void setMstone(String mstone) {
		this.mstone = mstone;
	}
	/**
	 * @return Returns the percentComp.
	 */
	public String getPercentComp() {
		return percentComp;
	}
	/**
	 * @param percentComp The percentComp to set.
	 */
	public void setPercentComp(String percentComp) {
		this.percentComp = percentComp;
	}
	/**
	 * @return Returns the stages.
	 */
	public String getStages() {
		return stages;
	}
	/**
	 * @param stages The stages to set.
	 */
	public void setStages(String stages) {
		this.stages = stages;
	}
	/**
	 * @return Returns the targetDate.
	 */
	public String getTargetDate() {
		return targetDate;
	}
	/**
	 * @param targetDate The targetDate to set.
	 */
	public void setTargetDate(String targetDate) {
		this.targetDate = targetDate;
	}
	/**
	 * @return Returns the mstoneCode.
	 */
	public String getMstoneCode() {
		return mstoneCode;
	}
	/**
	 * @param mstoneCode The mstoneCode to set.
	 */
	public void setMstoneCode(String mstoneCode) {
		this.mstoneCode = mstoneCode;
	}
	/**
	 * @return Returns the mstoneName.
	 */
	public String getMstoneName() {
		return mstoneName;
	}
	/**
	 * @param mstoneName The mstoneName to set.
	 */
	public void setMstoneName(String mstoneName) {
		this.mstoneName = mstoneName;
	}
	/**
	 * @return Returns the mstoneStageCode.
	 */
	public String getMstoneStageCode() {
		return mstoneStageCode;
	}
	/**
	 * @param mstoneStageCode The mstoneStageCode to set.
	 */
	public void setMstoneStageCode(String mstoneStageCode) {
		this.mstoneStageCode = mstoneStageCode;
	}
	/**
	 * @return Returns the mstoneStageName.
	 */
	public String getMstoneStageName() {
		return mstoneStageName;
	}
	/**
	 * @param mstoneStageName The mstoneStageName to set.
	 */
	public void setMstoneStageName(String mstoneStageName) {
		this.mstoneStageName = mstoneStageName;
	}
	 
	public String getMileStones() {
		return mileStones;
	}
	/**
	 * @param mileStones The mileStones to set.
	 */
	public void setMileStones(String mileStones) {
		this.mileStones = mileStones;
	}
	/**
	 * @return Returns the stage.
	 */
	/*public String getStage() {
		return stage;
	}
	/**
	 * @param stage The stage to set.
	 */
	/*public void setStage(String stage) {
		this.stage = stage;
	}*/
	/**
	 * @return Returns the mileStone.
	 */
	public ArrayList getMileStone() {
		return mileStone;
	}
	/**
	 * @param mileStone The mileStone to set.
	 */
	public void setMileStone(ArrayList mileStone) {
		this.mileStone = mileStone;
	}
	/**
	 * @return Returns the stage.
	 */
	public ArrayList getStage() {
		return stage;
	}
	/**
	 * @param stage The stage to set.
	 */
	public void setStage(ArrayList stage) {
		this.stage = stage;
	}
	/**
	 * @param sno The sno to set.
	 */
	public void setSno(String sno) {
		this.sno = sno;
	}
	/**
	 * @return Returns the expMonth.
	 */
	public String getExpMonth() {
		return expMonth;
	}
	/**
	 * @param expMonth The expMonth to set.
	 */
	public void setExpMonth(String expMonth) {
		this.expMonth = expMonth;
	}
	/**
	 * @return Returns the expMonthDuring.
	 */
	public String getExpMonthDuring() {
		return expMonthDuring;
	}
	/**
	 * @param expMonthDuring The expMonthDuring to set.
	 */
	public void setExpMonthDuring(String expMonthDuring) {
		this.expMonthDuring = expMonthDuring;
	}
	/**
	 * @return Returns the expMonthUp.
	 */
	public String getExpMonthUp() {
		return expMonthUp;
	}
	/**
	 * @param expMonthUp The expMonthUp to set.
	 */
	public void setExpMonthUp(String expMonthUp) {
		this.expMonthUp = expMonthUp;
	}
	
	/**
	 * @return Returns the expYear.
	 */
	public String getExpYear() {
		return expYear;
	}
	/**
	 * @param expYear The expYear to set.
	 */
	public void setExpYear(String expYear) {
		this.expYear = expYear;
	}
	/**
	 * @return Returns the expUptoPrevYear.
	 */
	public String getExpUptoPrevYear() {
		return expUptoPrevYear;
	}
	/**
	 * @param expUptoPrevYear The expUptoPrevYear to set.
	 */
	public void setExpUptoPrevYear(String expUptoPrevYear) {
		this.expUptoPrevYear = expUptoPrevYear;
	}
	public ArrayList getMileStoneStagesList() {
		return mileStoneStagesList;
	}
	public void setMileStoneStagesList(ArrayList mileStoneStagesList) {
		this.mileStoneStagesList = mileStoneStagesList;
	}
	/**
	 * @return Returns the achievementDate.
	 */
	public String getAchievementDate() {
		return achievementDate;
	}
	/**
	 * @param achievementDate The achievementDate to set.
	 */
	public void setAchievementDate(String achievementDate) {
		this.achievementDate = achievementDate;
	}
	/**
	 * @return Returns the sno.
	 */
	public String getSno() {
		return sno;
	}
	/**
	 * @return Returns the valueOFWorkDone.
	 */
	public String getValueOFWorkDone() {
		return valueOFWorkDone;
	}
	/**
	 * @param valueOFWorkDone The valueOFWorkDone to set.
	 */
	public void setValueOFWorkDone(String valueOFWorkDone) {
		this.valueOFWorkDone = valueOFWorkDone;
	}
	/**
	 * @return Returns the progCode.
	 */
	public String getProgCode() {
		return progCode;
	}
	/**
	 * @param progCode The progCode to set.
	 */
	public void setProgCode(String progCode) {
		this.progCode = progCode;
	}
	/**
	 * @return Returns the progName.
	 */
	public String getProgName() {
		return progName;
	}
	/**
	 * @param progName The progName to set.
	 */
	public void setProgName(String progName) {
		this.progName = progName;
	}
	
	
	/**
	 * @return Returns the aggrigateExpenditureForProg.
	 */
	public String getAggrigateExpenditureForProg() {
		return aggrigateExpenditureForProg;
	}
	/**
	 * @param aggrigateExpenditureForProg The aggrigateExpenditureForProg to set.
	 */
	public void setAggrigateExpenditureForProg(
			String aggrigateExpenditureForProg) {
		this.aggrigateExpenditureForProg = aggrigateExpenditureForProg;
	}
}

