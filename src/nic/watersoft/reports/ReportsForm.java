/*
 * Created on Aug 6, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
/**
 * @author vikas
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

package nic.watersoft.reports;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class ReportsForm extends ActionForm
{
		
	private String level="";
	private String district="";
	private String mandal="";
	private String panchayat="";
	private String village="";
	private String habitation="";
	
	//code added for Duplicates Report
	private String district1="";
	private String mandal1="";
	private String panchayat1="";
	private String village1="";
	private String habitation1="";
	private String duplicate="";
	private String dubcount="";
	private String dubhabcode="";	
	private String mode="";
	
	
	//code added for UnIdentified Report
	private String status="";
	private String daname="";
	private String macode="";
	private String maname="";
	private String vaname="";
	private String vacode="";
	private String paname="";
	private String pacode="";
	private String hacode="";
	private String haname="";
	private String covstatus="";
	
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		this.level="";
		this.district="ALL";
		this.mandal="ALL";
		this.district="";
		this.mandal="";
		this.panchayat="";
		this.village="";
		
		
	}
	
	//code added for DistrictReport
	
	private String distcode="";
	private String distname="";
	private String mandcode="";
	private String mandname="";
	private String FC="";
	private String PC1="";
	private String PC2="";
	private String PC3="";
	private String PC4="";
	private String NC="";
	private String NSS="";
	private String total="";
	
	//code for retreving the total of all columns
	
	private String totfc="";
	private String totpc1="";
	private String totpc2="";
	private String totpc3="";
	private String totpc4="";
	private String totnc="";
	private String totnss="";
		
	private String distcode1="";
	private String distname1="";
	private String mandcode1="";
	private String mandname1="";
	private String FC1="";
	private String PC11="";
	private String PC21="";
	private String PC31="";
	private String PC41="";
	private String NC1="";
	private String NSS1="";
	private String total1="";
	
	
	
	
	/**
	 * @return Returns the daname.
	 */
	public String getDaname() {
		return daname;
	}
	/**
	 * @param daname The daname to set.
	 */
	public void setDaname(String daname) {
		this.daname = daname;
	}
	/**
	 * @return Returns the covstatus.
	 */
	public String getCovstatus() {
		return covstatus;
	}
	/**
	 * @param covstatus The covstatus to set.
	 */
	public void setCovstatus(String covstatus) {
		this.covstatus = covstatus;
	}
	/**
	 * @return Returns the hacode.
	 */
	public String getHacode() {
		return hacode;
	}
	/**
	 * @param hacode The hacode to set.
	 */
	public void setHacode(String hacode) {
		this.hacode = hacode;
	}
	/**
	 * @return Returns the haname.
	 */
	public String getHaname() {
		return haname;
	}
	/**
	 * @param haname The haname to set.
	 */
	public void setHaname(String haname) {
		this.haname = haname;
	}
	/**
	 * @return Returns the macode.
	 */
	public String getMacode() {
		return macode;
	}
	/**
	 * @param macode The macode to set.
	 */
	public void setMacode(String macode) {
		this.macode = macode;
	}
	/**
	 * @return Returns the maname.
	 */
	public String getManame() {
		return maname;
	}
	/**
	 * @param maname The maname to set.
	 */
	public void setManame(String maname) {
		this.maname = maname;
	}
	/**
	 * @return Returns the pacode.
	 */
	public String getPacode() {
		return pacode;
	}
	/**
	 * @param pacode The pacode to set.
	 */
	public void setPacode(String pacode) {
		this.pacode = pacode;
	}
	/**
	 * @return Returns the paname.
	 */
	public String getPaname() {
		return paname;
	}
	/**
	 * @param paname The paname to set.
	 */
	public void setPaname(String paname) {
		this.paname = paname;
	}
	/**
	 * @return Returns the vacode.
	 */
	public String getVacode() {
		return vacode;
	}
	/**
	 * @param vacode The vacode to set.
	 */
	public void setVacode(String vacode) {
		this.vacode = vacode;
	}
	/**
	 * @return Returns the vaname.
	 */
	public String getVaname() {
		return vaname;
	}
	/**
	 * @param vaname The vaname to set.
	 */
	public void setVaname(String vaname) {
		this.vaname = vaname;
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
	 * @return Returns the dubcount.
	 */
	public String getDubcount() {
		return dubcount;
	}
	/**
	 * @param dubcount The dubcount to set.
	 */
	public void setDubcount(String dubcount) {
		this.dubcount = dubcount;
	}
	/**
	 * @return Returns the dubhabcode.
	 */
	public String getDubhabcode() {
		return dubhabcode;
	}
	/**
	 * @param dubhabcode The dubhabcode to set.
	 */
	public void setDubhabcode(String dubhabcode) {
		this.dubhabcode = dubhabcode;
	}
	/**
	 * @return Returns the duplicate.
	 */
	public String getDuplicate() {
		return duplicate;
	}
	/**
	 * @param duplicate The duplicate to set.
	 */
	public void setDuplicate(String duplicate) {
		this.duplicate = duplicate;
	}
	/**
	 * @return Returns the totfc.
	 */
	public String getTotfc() {
		return totfc;
	}
	/**
	 * @param totfc The totfc to set.
	 */
	public void setTotfc(String totfc) {
		this.totfc = totfc;
	}
	/**
	 * @return Returns the totnc.
	 */
	public String getTotnc() {
		return totnc;
	}
	/**
	 * @param totnc The totnc to set.
	 */
	public void setTotnc(String totnc) {
		this.totnc = totnc;
	}
	/**
	 * @return Returns the totnss.
	 */
	public String getTotnss() {
		return totnss;
	}
	/**
	 * @param totnss The totnss to set.
	 */
	public void setTotnss(String totnss) {
		this.totnss = totnss;
	}
	/**
	 * @return Returns the totpc1.
	 */
	public String getTotpc1() {
		return totpc1;
	}
	/**
	 * @param totpc1 The totpc1 to set.
	 */
	public void setTotpc1(String totpc1) {
		this.totpc1 = totpc1;
	}
	/**
	 * @return Returns the totpc2.
	 */
	public String getTotpc2() {
		return totpc2;
	}
	/**
	 * @param totpc2 The totpc2 to set.
	 */
	public void setTotpc2(String totpc2) {
		this.totpc2 = totpc2;
	}
	/**
	 * @return Returns the totpc3.
	 */
	public String getTotpc3() {
		return totpc3;
	}
	/**
	 * @param totpc3 The totpc3 to set.
	 */
	public void setTotpc3(String totpc3) {
		this.totpc3 = totpc3;
	}
	/**
	 * @return Returns the totpc4.
	 */
	public String getTotpc4() {
		return totpc4;
	}
	/**
	 * @param totpc4 The totpc4 to set.
	 */
	public void setTotpc4(String totpc4) {
		this.totpc4 = totpc4;
	}
	/**
	 * @return Returns the total.
	 */
	public String getTotal() {
		return total;
	}
	/**
	 * @param total The total to set.
	 */
	public void setTotal(String total) {
		this.total = total;
	}
	/**
	 * @return Returns the total1.
	 */
	public String getTotal1() {
		return total1;
	}
	/**
	 * @param total1 The total1 to set.
	 */
	public void setTotal1(String total1) {
		this.total1 = total1;
	}
	/**
	 * @return Returns the distcode1.
	 */
	public String getDistcode1() {
		return distcode1;
	}
	/**
	 * @param distcode1 The distcode1 to set.
	 */
	public void setDistcode1(String distcode1) {
		this.distcode1 = distcode1;
	}
	/**
	 * @return Returns the distname1.
	 */
	public String getDistname1() {
		return distname1;
	}
	/**
	 * @param distname1 The distname1 to set.
	 */
	public void setDistname1(String distname1) {
		this.distname1 = distname1;
	}
	/**
	 * @return Returns the fC1.
	 */
	public String getFC1() {
		return FC1;
	}
	/**
	 * @param fc1 The fC1 to set.
	 */
	public void setFC1(String fc1) {
		FC1 = fc1;
	}
	/**
	 * @return Returns the nC1.
	 */
	public String getNC1() {
		return NC1;
	}
	/**
	 * @param nc1 The nC1 to set.
	 */
	public void setNC1(String nc1) {
		NC1 = nc1;
	}
	/**
	 * @return Returns the nSS1.
	 */
	public String getNSS1() {
		return NSS1;
	}
	/**
	 * @param nss1 The nSS1 to set.
	 */
	public void setNSS1(String nss1) {
		NSS1 = nss1;
	}
	/**
	 * @return Returns the pC11.
	 */
	public String getPC11() {
		return PC11;
	}
	/**
	 * @param pc11 The pC11 to set.
	 */
	public void setPC11(String pc11) {
		PC11 = pc11;
	}
	/**
	 * @return Returns the pC21.
	 */
	public String getPC21() {
		return PC21;
	}
	/**
	 * @param pc21 The pC21 to set.
	 */
	public void setPC21(String pc21) {
		PC21 = pc21;
	}
	/**
	 * @return Returns the pC31.
	 */
	public String getPC31() {
		return PC31;
	}
	/**
	 * @param pc31 The pC31 to set.
	 */
	public void setPC31(String pc31) {
		PC31 = pc31;
	}
	/**
	 * @return Returns the pC41.
	 */
	public String getPC41() {
		return PC41;
	}
	/**
	 * @param pc41 The pC41 to set.
	 */
	public void setPC41(String pc41) {
		PC41 = pc41;
	}
	/**
	 * @return Returns the distcode.
	 */
	public String getDistcode() {
		return distcode;
	}
	/**
	 * @param distcode The distcode to set.
	 */
	public void setDistcode(String distcode) {
		this.distcode = distcode;
	}
	/**
	 * @return Returns the distname.
	 */
	public String getDistname() {
		return distname;
	}
	/**
	 * @param distname The distname to set.
	 */
	public void setDistname(String distname) {
		this.distname = distname;
	}
	/**
	 * @return Returns the fC.
	 */
	public String getFC() {
		return FC;
	}
	/**
	 * @param fc The fC to set.
	 */
	public void setFC(String fc) {
		FC = fc;
	}
	/**
	 * @return Returns the nC.
	 */
	public String getNC() {
		return NC;
	}
	/**
	 * @param nc The nC to set.
	 */
	public void setNC(String nc) {
		NC = nc;
	}
	/**
	 * @return Returns the nSS.
	 */
	public String getNSS() {
		return NSS;
	}
	/**
	 * @param nss The nSS to set.
	 */
	public void setNSS(String nss) {
		NSS = nss;
	}
	/**
	 * @return Returns the pC1.
	 */
	public String getPC1() {
		return PC1;
	}
	/**
	 * @param pc1 The pC1 to set.
	 */
	public void setPC1(String pc1) {
		PC1 = pc1;
	}
	/**
	 * @return Returns the pC2.
	 */
	public String getPC2() {
		return PC2;
	}
	/**
	 * @param pc2 The pC2 to set.
	 */
	public void setPC2(String pc2) {
		PC2 = pc2;
	}
	/**
	 * @return Returns the pC3.
	 */
	public String getPC3() {
		return PC3;
	}
	/**
	 * @param pc3 The pC3 to set.
	 */
	public void setPC3(String pc3) {
		PC3 = pc3;
	}
	/**
	 * @return Returns the pC4.
	 */
	public String getPC4() {
		return PC4;
	}
	/**
	 * @param pc4 The pC4 to set.
	 */
	public void setPC4(String pc4) {
		PC4 = pc4;
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
	 * @return Returns the district.
	 */
	public String getDistrict() {
		return district;
	}
	/**
	 * @param district The district to set.
	 */
	public void setDistrict(String district) {
		this.district = district;
	}
	/**
	 * @return Returns the level.
	 */
	public String getLevel() {
		return level;
	}
	/**
	 * @param level The level to set.
	 */
	public void setLevel(String level) {
		this.level = level;
	}
	
	/**
	 * @return Returns the mandal.
	 */
	public String getMandal() {
		return mandal;
	}
	/**
	 * @param mandal The mandal to set.
	 */
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	/**
	 * @return Returns the mandcode.
	 */
	public String getMandcode() {
		return mandcode;
	}
	/**
	 * @param mandcode The mandcode to set.
	 */
	public void setMandcode(String mandcode) {
		this.mandcode = mandcode;
	}
	/**
	 * @return Returns the mandcode1.
	 */
	public String getMandcode1() {
		return mandcode1;
	}
	/**
	 * @param mandcode1 The mandcode1 to set.
	 */
	public void setMandcode1(String mandcode1) {
		this.mandcode1 = mandcode1;
	}
	/**
	 * @return Returns the mandname.
	 */
	public String getMandname() {
		return mandname;
	}
	/**
	 * @param mandname The mandname to set.
	 */
	public void setMandname(String mandname) {
		this.mandname = mandname;
	}
	/**
	 * @return Returns the mandname1.
	 */
	public String getMandname1() {
		return mandname1;
	}
	/**
	 * @param mandname1 The mandname1 to set.
	 */
	public void setMandname1(String mandname1) {
		this.mandname1 = mandname1;
	}
	/**
	 * @return Returns the district1.
	 */
	public String getDistrict1() {
		return district1;
	}
	/**
	 * @param district1 The district1 to set.
	 */
	public void setDistrict1(String district1) {
		this.district1 = district1;
	}
	/**
	 * @return Returns the habitation.
	 */
	public String getHabitation() {
		return habitation;
	}
	/**
	 * @param habitation The habitation to set.
	 */
	public void setHabitation(String habitation) {
		this.habitation = habitation;
	}
	/**
	 * @return Returns the habitation1.
	 */
	public String getHabitation1() {
		return habitation1;
	}
	/**
	 * @param habitation1 The habitation1 to set.
	 */
	public void setHabitation1(String habitation1) {
		this.habitation1 = habitation1;
	}
	/**
	 * @return Returns the mandal1.
	 */
	public String getMandal1() {
		return mandal1;
	}
	/**
	 * @param mandal1 The mandal1 to set.
	 */
	public void setMandal1(String mandal1) {
		this.mandal1 = mandal1;
	}
	/**
	 * @return Returns the panchayat.
	 */
	public String getPanchayat() {
		return panchayat;
	}
	/**
	 * @param panchayat The panchayat to set.
	 */
	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}
	/**
	 * @return Returns the panchayat1.
	 */
	public String getPanchayat1() {
		return panchayat1;
	}
	/**
	 * @param panchayat1 The panchayat1 to set.
	 */
	public void setPanchayat1(String panchayat1) {
		this.panchayat1 = panchayat1;
	}
	/**
	 * @return Returns the village.
	 */
	public String getVillage() {
		return village;
	}
	/**
	 * @param village The village to set.
	 */
	public void setVillage(String village) {
		this.village = village;
	}
	/**
	 * @return Returns the village1.
	 */
	public String getVillage1() {
		return village1;
	}
	/**
	 * @param village1 The village1 to set.
	 */
	public void setVillage1(String village1) {
		this.village1 = village1;
	}
}
