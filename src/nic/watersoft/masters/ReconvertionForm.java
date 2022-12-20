package nic.watersoft.masters;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;


public class ReconvertionForm extends ActionForm {
	
private String circle;
private String division;
private String subdivision;
private String habcode;
private String censusYear;
private String censusPlainPopu;
private String censuScPopu;
private String censusStPopu;
private String floatPopu;
private String floatPopuReasn;
private String statusDate;
private String plainPopuCovered;
private String scPopCov;
private String sctPopCov;
private String totWaterSupply;
private String existWaterLevel;
private String coverageStatus;
private String nearSurfaceSource;
private String nearGroundSource;
private String remarks ;
private String qualityEffected ;
private String updateDate ;
private String prevYearStatus;
private String presYearStatus ;
private String praposedFcStatus;
private String praposedFcEstAmount;
private String habitationType;
private String householdNo;
private String slippageCode;
private String noOfCattle;
private String habCategory;
private String existSourceNo;
private String safeSourceNo;
private String habSubType1;
private String ncSourceType;
private String sourceDistance;
private String lpcdCooking;
private String popuPresCov;
private String minorityDomminated;
private String lwe;
private String unsafeLpcd;
private String safeLpcd;
private String HabSubType;
private String tspNtsp;
private String ddwsHabcode;
private String noOfHouseConnGiven;
private String isItDa;
private String mcoded;
private String subcode;

private String dcodenew;

private String hpHabCode;
private String shpDkSupply;
private String shpNo;
private String cisternsDkSupply;
private String cisternsNo;
private String glsrDksSupply;
private String glsrNo;
private String ohsrDkSupply;
private String ohsrNo;
private String hpOthSupply;
private String hpNo;
private String owsOthSupply;
private String owsNo;
private String pondsOthSupply;
private String pondsNo;
private String ShwellOthSuply;
private String shwellNo;
private String pcpdDrink;
private String pcpdOthers;
private String stateOfHab;
private String pwsSupply;
private String pwsNo;
private String mpwsSupply;
private String mpwsNo;
private String cpwsSupply;
private String cpwsNo;
private String directPumpSupply;
private String directPumpingNo;
private String dwTankSupply;
private String dwTankNo;
private String cattleSupply;
private String cattleNo;
private String othersNo;
private String othersSupply;
private String hpsOthSupplyUnsafe;
private String hpsNoUnsafe;
private String othersSupplySafe;
private String othersNoSafe;
private String pwsUnsafeSupply;
private String pwsUnsafeNo;
private String mpwsUnsafeSupply;
private String mpwsUnsafeNo;
private String shpDkSupplySafe;
public String getHpHabCode() {
	return hpHabCode;
}

public void setHpHabCode(String hpHabCode) {
	this.hpHabCode = hpHabCode;
}

public String getShpDkSupply() {
	return shpDkSupply;
}

public void setShpDkSupply(String shpDkSupply) {
	this.shpDkSupply = shpDkSupply;
}

public String getShpNo() {
	return shpNo;
}

public void setShpNo(String shpNo) {
	this.shpNo = shpNo;
}

public String getCisternsDkSupply() {
	return cisternsDkSupply;
}

public void setCisternsDkSupply(String cisternsDkSupply) {
	this.cisternsDkSupply = cisternsDkSupply;
}

public String getCisternsNo() {
	return cisternsNo;
}

public void setCisternsNo(String cisternsNo) {
	this.cisternsNo = cisternsNo;
}

public String getGlsrDksSupply() {
	return glsrDksSupply;
}

public void setGlsrDksSupply(String glsrDksSupply) {
	this.glsrDksSupply = glsrDksSupply;
}

public String getGlsrNo() {
	return glsrNo;
}

public void setGlsrNo(String glsrNo) {
	this.glsrNo = glsrNo;
}

public String getOhsrDkSupply() {
	return ohsrDkSupply;
}

public void setOhsrDkSupply(String ohsrDkSupply) {
	this.ohsrDkSupply = ohsrDkSupply;
}

public String getOhsrNo() {
	return ohsrNo;
}

public void setOhsrNo(String ohsrNo) {
	this.ohsrNo = ohsrNo;
}

public String getHpOthSupply() {
	return hpOthSupply;
}

public void setHpOthSupply(String hpOthSupply) {
	this.hpOthSupply = hpOthSupply;
}

public String getHpNo() {
	return hpNo;
}

public void setHpNo(String hpNo) {
	this.hpNo = hpNo;
}

public String getOwsOthSupply() {
	return owsOthSupply;
}

public void setOwsOthSupply(String owsOthSupply) {
	this.owsOthSupply = owsOthSupply;
}

public String getOwsNo() {
	return owsNo;
}

public void setOwsNo(String owsNo) {
	this.owsNo = owsNo;
}

public String getPondsOthSupply() {
	return pondsOthSupply;
}

public void setPondsOthSupply(String pondsOthSupply) {
	this.pondsOthSupply = pondsOthSupply;
}

public String getPondsNo() {
	return pondsNo;
}

public void setPondsNo(String pondsNo) {
	this.pondsNo = pondsNo;
}

public String getShwellOthSuply() {
	return ShwellOthSuply;
}

public void setShwellOthSuply(String shwellOthSuply) {
	ShwellOthSuply = shwellOthSuply;
}

public String getShwellNo() {
	return shwellNo;
}

public void setShwellNo(String shwellNo) {
	this.shwellNo = shwellNo;
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

public String getStateOfHab() {
	return stateOfHab;
}

public void setStateOfHab(String stateOfHab) {
	this.stateOfHab = stateOfHab;
}

public String getPwsSupply() {
	return pwsSupply;
}

public void setPwsSupply(String pwsSupply) {
	this.pwsSupply = pwsSupply;
}

public String getPwsNo() {
	return pwsNo;
}

public void setPwsNo(String pwsNo) {
	this.pwsNo = pwsNo;
}

public String getMpwsSupply() {
	return mpwsSupply;
}

public void setMpwsSupply(String mpwsSupply) {
	this.mpwsSupply = mpwsSupply;
}

public String getMpwsNo() {
	return mpwsNo;
}

public void setMpwsNo(String mpwsNo) {
	this.mpwsNo = mpwsNo;
}

public String getCpwsSupply() {
	return cpwsSupply;
}

public void setCpwsSupply(String cpwsSupply) {
	this.cpwsSupply = cpwsSupply;
}

public String getCpwsNo() {
	return cpwsNo;
}

public void setCpwsNo(String cpwsNo) {
	this.cpwsNo = cpwsNo;
}

public String getDirectPumpSupply() {
	return directPumpSupply;
}

public void setDirectPumpSupply(String directPumpSupply) {
	this.directPumpSupply = directPumpSupply;
}

public String getDirectPumpingNo() {
	return directPumpingNo;
}

public void setDirectPumpingNo(String directPumpingNo) {
	this.directPumpingNo = directPumpingNo;
}

public String getDwTankSupply() {
	return dwTankSupply;
}

public void setDwTankSupply(String dwTankSupply) {
	this.dwTankSupply = dwTankSupply;
}

public String getDwTankNo() {
	return dwTankNo;
}

public void setDwTankNo(String dwTankNo) {
	this.dwTankNo = dwTankNo;
}

public String getCattleSupply() {
	return cattleSupply;
}

public void setCattleSupply(String cattleSupply) {
	this.cattleSupply = cattleSupply;
}

public String getCattleNo() {
	return cattleNo;
}

public void setCattleNo(String cattleNo) {
	this.cattleNo = cattleNo;
}

public String getOthersNo() {
	return othersNo;
}

public void setOthersNo(String othersNo) {
	this.othersNo = othersNo;
}

public String getOthersSupply() {
	return othersSupply;
}

public void setOthersSupply(String othersSupply) {
	this.othersSupply = othersSupply;
}

public String getHpsOthSupplyUnsafe() {
	return hpsOthSupplyUnsafe;
}

public void setHpsOthSupplyUnsafe(String hpsOthSupplyUnsafe) {
	this.hpsOthSupplyUnsafe = hpsOthSupplyUnsafe;
}

public String getHpsNoUnsafe() {
	return hpsNoUnsafe;
}

public void setHpsNoUnsafe(String hpsNoUnsafe) {
	this.hpsNoUnsafe = hpsNoUnsafe;
}

public String getOthersSupplySafe() {
	return othersSupplySafe;
}

public void setOthersSupplySafe(String othersSupplySafe) {
	this.othersSupplySafe = othersSupplySafe;
}

public String getOthersNoSafe() {
	return othersNoSafe;
}

public void setOthersNoSafe(String othersNoSafe) {
	this.othersNoSafe = othersNoSafe;
}

public String getPwsUnsafeSupply() {
	return pwsUnsafeSupply;
}

public void setPwsUnsafeSupply(String pwsUnsafeSupply) {
	this.pwsUnsafeSupply = pwsUnsafeSupply;
}

public String getPwsUnsafeNo() {
	return pwsUnsafeNo;
}

public void setPwsUnsafeNo(String pwsUnsafeNo) {
	this.pwsUnsafeNo = pwsUnsafeNo;
}

public String getMpwsUnsafeSupply() {
	return mpwsUnsafeSupply;
}

public void setMpwsUnsafeSupply(String mpwsUnsafeSupply) {
	this.mpwsUnsafeSupply = mpwsUnsafeSupply;
}

public String getMpwsUnsafeNo() {
	return mpwsUnsafeNo;
}

public void setMpwsUnsafeNo(String mpwsUnsafeNo) {
	this.mpwsUnsafeNo = mpwsUnsafeNo;
}

public String getShpDkSupplySafe() {
	return shpDkSupplySafe;
}

public void setShpDkSupplySafe(String shpDkSupplySafe) {
	this.shpDkSupplySafe = shpDkSupplySafe;
}

public String getShpNoSafe() {
	return shpNoSafe;
}

public void setShpNoSafe(String shpNoSafe) {
	this.shpNoSafe = shpNoSafe;
}

private String shpNoSafe;






public String getMcoded() {
	return mcoded;
}

public void setMcoded(String mcoded) {
	this.mcoded = mcoded;
}

public String getSubcode() {
	return subcode;
}

public void setSubcode(String subcode) {
	this.subcode = subcode;
}

public String getSafeSourceNo() {
	return safeSourceNo;
}

public void setSafeSourceNo(String safeSourceNo) {
	this.safeSourceNo = safeSourceNo;
}


public String getNcSourceType() {
	return ncSourceType;
}

public void setNcSourceType(String ncSourceType) {
	this.ncSourceType = ncSourceType;
}

public String getSourceDistance() {
	return sourceDistance;
}

public void setSourceDistance(String sourceDistance) {
	this.sourceDistance = sourceDistance;
}

public String getLpcdCooking() {
	return lpcdCooking;
}

public void setLpcdCooking(String lpcdCooking) {
	this.lpcdCooking = lpcdCooking;
}

public String getPopuPresCov() {
	return popuPresCov;
}

public void setPopuPresCov(String popuPresCov) {
	this.popuPresCov = popuPresCov;
}

public String getMinorityDomminated() {
	return minorityDomminated;
}

public void setMinorityDomminated(String minorityDomminated) {
	this.minorityDomminated = minorityDomminated;
}

public String getLwe() {
	return lwe;
}

public void setLwe(String lwe) {
	this.lwe = lwe;
}

public String getUnsafeLpcd() {
	return unsafeLpcd;
}

public void setUnsafeLpcd(String unsafeLpcd) {
	this.unsafeLpcd = unsafeLpcd;
}

public String getSafeLpcd() {
	return safeLpcd;
}

public void setSafeLpcd(String safeLpcd) {
	this.safeLpcd = safeLpcd;
}

public String getHabSubType() {
	return HabSubType;
}

public void setHabSubType(String habSubType) {
	HabSubType = habSubType;
}

public String getTspNtsp() {
	return tspNtsp;
}

public void setTspNtsp(String tspNtsp) {
	this.tspNtsp = tspNtsp;
}

public String getDdwsHabcode() {
	return ddwsHabcode;
}

public void setDdwsHabcode(String ddwsHabcode) {
	this.ddwsHabcode = ddwsHabcode;
}

public String getNoOfHouseConnGiven() {
	return noOfHouseConnGiven;
}

public void setNoOfHouseConnGiven(String noOfHouseConnGiven) {
	this.noOfHouseConnGiven = noOfHouseConnGiven;
}

public String getIsItDa() {
	return isItDa;
}

public void setIsItDa(String isItDa) {
	this.isItDa = isItDa;
}

public String getHouseHoldsSc() {
	return houseHoldsSc;
}

public void setHouseHoldsSc(String houseHoldsSc) {
	this.houseHoldsSc = houseHoldsSc;
}

public String getHouseHoldsST() {
	return houseHoldsST;
}

public void setHouseHoldsST(String houseHoldsST) {
	this.houseHoldsST = houseHoldsST;
}

public String getHouseHoldsPlain() {
	return houseHoldsPlain;
}

public void setHouseHoldsPlain(String houseHoldsPlain) {
	this.houseHoldsPlain = houseHoldsPlain;
}

public String getConSc() {
	return conSc;
}

public void setConSc(String conSc) {
	this.conSc = conSc;
}

public String getConSt() {
	return conSt;
}

public void setConSt(String conSt) {
	this.conSt = conSt;
}

public String getConPlain() {
	return conPlain;
}

public void setConPlain(String conPlain) {
	this.conPlain = conPlain;
}

public String getHouseHoldsMinority() {
	return houseHoldsMinority;
}

public void setHouseHoldsMinority(String houseHoldsMinority) {
	this.houseHoldsMinority = houseHoldsMinority;
}

public String getConMinority() {
	return conMinority;
}

public void setConMinority(String conMinority) {
	this.conMinority = conMinority;
}

public String getMinPopuCov() {
	return minPopuCov;
}

public void setMinPopuCov(String minPopuCov) {
	this.minPopuCov = minPopuCov;
}

public String getCensusMinorityPopu() {
	return censusMinorityPopu;
}

public void setCensusMinorityPopu(String censusMinorityPopu) {
	this.censusMinorityPopu = censusMinorityPopu;
}

private String houseHoldsSc;
private String houseHoldsST;
private String houseHoldsPlain;
private String conSc;
private String conSt;
private String conPlain;
private String houseHoldsMinority;
private String conMinority;
private String minPopuCov;
private String censusMinorityPopu;





public String getCircle() {
	return circle;
}

public void setCircle(String circle) {
	this.circle = circle;
}

public String getDivision() {
	return division;
}

public void setDivision(String division) {
	this.division = division;
}

public String getSubdivision() {
	return subdivision;
}

public void setSubdivision(String subdivision) {
	this.subdivision = subdivision;
}

public String getHabcode() {
	return habcode;
}

public void setHabcode(String habcode) {
	this.habcode = habcode;
}

public String getCensusYear() {
	return censusYear;
}

public void setCensusYear(String censusYear) {
	this.censusYear = censusYear;
}

public String getCensusPlainPopu() {
	return censusPlainPopu;
}

public void setCensusPlainPopu(String censusPlainPopu) {
	this.censusPlainPopu = censusPlainPopu;
}

public String getCensuScPopu() {
	return censuScPopu;
}

public void setCensuScPopu(String censuScPopu) {
	this.censuScPopu = censuScPopu;
}

public String getCensusStPopu() {
	return censusStPopu;
}

public void setCensusStPopu(String censusStPopu) {
	this.censusStPopu = censusStPopu;
}

public String getFloatPopu() {
	return floatPopu;
}

public void setFloatPopu(String floatPopu) {
	this.floatPopu = floatPopu;
}

public String getFloatPopuReasn() {
	return floatPopuReasn;
}

public void setFloatPopuReasn(String floatPopuReasn) {
	this.floatPopuReasn = floatPopuReasn;
}

public String getStatusDate() {
	return statusDate;
}

public void setStatusDate(String statusDate) {
	this.statusDate = statusDate;
}

public String getPlainPopuCovered() {
	return plainPopuCovered;
}

public void setPlainPopuCovered(String plainPopuCovered) {
	this.plainPopuCovered = plainPopuCovered;
}

public String getScPopCov() {
	return scPopCov;
}

public void setScPopCov(String scPopCov) {
	this.scPopCov = scPopCov;
}

public String getSctPopCov() {
	return sctPopCov;
}

public void setSctPopCov(String sctPopCov) {
	this.sctPopCov = sctPopCov;
}

public String getTotWaterSupply() {
	return totWaterSupply;
}

public void setTotWaterSupply(String totWaterSupply) {
	this.totWaterSupply = totWaterSupply;
}

public String getExistWaterLevel() {
	return existWaterLevel;
}

public void setExistWaterLevel(String existWaterLevel) {
	this.existWaterLevel = existWaterLevel;
}

public String getCoverageStatus() {
	return coverageStatus;
}

public void setCoverageStatus(String coverageStatus) {
	this.coverageStatus = coverageStatus;
}

public String getNearSurfaceSource() {
	return nearSurfaceSource;
}

public void setNearSurfaceSource(String nearSurfaceSource) {
	this.nearSurfaceSource = nearSurfaceSource;
}

public String getNearGroundSource() {
	return nearGroundSource;
}

public void setNearGroundSource(String nearGroundSource) {
	this.nearGroundSource = nearGroundSource;
}

public String getRemarks() {
	return remarks;
}

public void setRemarks(String remarks) {
	this.remarks = remarks;
}

public String getQualityEffected() {
	return qualityEffected;
}

public void setQualityEffected(String qualityEffected) {
	this.qualityEffected = qualityEffected;
}

public String getUpdateDate() {
	return updateDate;
}

public void setUpdateDate(String updateDate) {
	this.updateDate = updateDate;
}

public String getPrevYearStatus() {
	return prevYearStatus;
}

public void setPrevYearStatus(String prevYearStatus) {
	this.prevYearStatus = prevYearStatus;
}

public String getPresYearStatus() {
	return presYearStatus;
}

public void setPresYearStatus(String presYearStatus) {
	this.presYearStatus = presYearStatus;
}

public String getPraposedFcStatus() {
	return praposedFcStatus;
}

public void setPraposedFcStatus(String praposedFcStatus) {
	this.praposedFcStatus = praposedFcStatus;
}

public String getPraposedFcEstAmount() {
	return praposedFcEstAmount;
}

public void setPraposedFcEstAmount(String praposedFcEstAmount) {
	this.praposedFcEstAmount = praposedFcEstAmount;
}

public String getHabitationType() {
	return habitationType;
}

public void setHabitationType(String habitationType) {
	this.habitationType = habitationType;
}

public String getHouseholdNo() {
	return householdNo;
}

public void setHouseholdNo(String householdNo) {
	this.householdNo = householdNo;
}

public String getSlippageCode() {
	return slippageCode;
}

public void setSlippageCode(String slippageCode) {
	this.slippageCode = slippageCode;
}

public String getNoOfCattle() {
	return noOfCattle;
}

public void setNoOfCattle(String noOfCattle) {
	this.noOfCattle = noOfCattle;
}

public String getHabCategory() {
	return habCategory;
}

public void setHabCategory(String habCategory) {
	this.habCategory = habCategory;
}

public String getExistSourceNo() {
	return existSourceNo;
}

public void setExistSourceNo(String existSourceNo) {
	this.existSourceNo = existSourceNo;
}

private String district;
private String mandal;

public String getMandal() {
	return mandal;
}

public void setMandal(String mandal) {
	this.mandal = mandal;
}

public String getPanchayat() {
	return panchayat;
}

public void setPanchayat(String panchayat) {
	this.panchayat = panchayat;
}

public String getVillage() {
	return village;
}

public void setVillage(String village) {
	this.village = village;
}

public String getHabCode() {
	return habCode;
}

public void setHabCode(String habCode) {
	this.habCode = habCode;
}

public String getPanchayatName() {
	return panchayatName;
}

public void setPanchayatName(String panchayatName) {
	this.panchayatName = panchayatName;
}

public String getDistrict1() {
	return district1;
}

public void setDistrict1(String district1) {
	this.district1 = district1;
}

public String getMandal1() {
	return mandal1;
}

public void setMandal1(String mandal1) {
	this.mandal1 = mandal1;
}

public String getPanchayat1() {
	return panchayat1;
}

public void setPanchayat1(String panchayat1) {
	this.panchayat1 = panchayat1;
}

public String getVillage1() {
	return village1;
}

public void setVillage1(String village1) {
	this.village1 = village1;
}

public String getHabitation1() {
	return habitation1;
}

public void setHabitation1(String habitation1) {
	this.habitation1 = habitation1;
}

public String getHabName1() {
	return habName1;
}

public void setHabName1(String habName1) {
	this.habName1 = habName1;
}

public String getCoveredStatus() {
	return coveredStatus;
}

public void setCoveredStatus(String coveredStatus) {
	this.coveredStatus = coveredStatus;
}

private String panchayat;
private String village;
private String habCode;
private String panchayatName;

private String district1;
private String mandal1;
private String panchayat1;
private String village1;
private String habitation1;
private String habName1;
private String coveredStatus;
private String habitation;
private String constituency;
private String habName;
private String hcode;
private String prcode;
private String prHabName;




public String getHabitation() {
	return habitation;
}

public void setHabitation(String habitation) {
	this.habitation = habitation;
}

public String getConstituency() {
	return constituency;
}

public void setConstituency(String constituency) {
	this.constituency = constituency;
}

public String getHabName() {
	return habName;
}

public void setHabName(String habName) {
	this.habName = habName;
}

public String getHcode() {
	return hcode;
}

public void setHcode(String hcode) {
	this.hcode = hcode;
}

public void setDistrict(String district) {
	this.district = district;
}

public String getDistrict() {
	return district;
}

public void setPrcode(String prcode) {
	this.prcode = prcode;
}

public String getPrcode() {
	return prcode;
}

public void setPrHabName(String prHabName) {
	this.prHabName = prHabName;
}

public String getPrHabName() {
	return prHabName;
}

public void setHabSubType1(String habSubType1) {
	this.habSubType1 = habSubType1;
}

public String getHabSubType1() {
	return habSubType1;
}

public String getDcodenew() {
	return dcodenew;
}

public void setDcodenew(String dcodenew) {
	this.dcodenew = dcodenew;
}
	
}
