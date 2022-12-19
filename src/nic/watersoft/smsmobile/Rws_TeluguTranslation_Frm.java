package nic.watersoft.smsmobile;
import java.util.ArrayList;
/*import java.util.Collection;*/
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_TeluguTranslation_Frm extends ActionForm
{
	//private boolean tankerStatus;
	private boolean tankerStatus;
	public boolean isTankerStatus() {
		return tankerStatus;
	}
	public void setTankerStatus(boolean tankerStatus) {
		this.tankerStatus = tankerStatus;
	}
	private String officeCode;
	private String officeName;
	private String headOfficeCode;
	private String headOfficeName;
	private String circleOfficeCode;
	private String circleOfficeName;
	private String district;
	private String dcode;
	private String districtName;
	private String dname;
	private String mcode;
	private String mname;
	private String mandal;
	private String panchayat;
	private String village;
	private String habitation;
	private String pcode;
	private String pname;
	private String vname;
	private String vcode;
	
	
	private String hcode;
	private String prcode;
 	private String habCode;
 	private String mandalName;
    private String habName;
    private String mode;
	private boolean init;
	private String tRegno;
	private String volName;
	private String volMobile;
	private String tlabel;
	public String getTlabel() {
		return tlabel;
	}
	public void setTlabel(String tlabel) {
		this.tlabel = tlabel;
	}
	public String gettRegno() {
		return tRegno;
	}
	public void settRegno(String tRegno) {
		this.tRegno = tRegno;
	}
	public String getVolName() {
		return volName;
	}
	public void setVolName(String volName) {
		this.volName = volName;
	}
	public String getVolMobile() {
		return volMobile;
	}
	public void setVolMobile(String volMobile) {
		this.volMobile = volMobile;
	}
	
	
	
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	
	public String getCircleOfficeName() {
		return circleOfficeName;
	}
	
	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}
	
	public String getHeadOfficeCode() {
		return headOfficeCode;
	}
	/**
	 * @param headOfficeCode The headOfficeCode to set.
	 */
	public void setHeadOfficeCode(String headOfficeCode) {
		this.headOfficeCode = headOfficeCode;
	}
	/**
	 * @return Returns the headOfficeName.
	 */
	public String getHeadOfficeName() {
		return headOfficeName;
	}
	/**
	 * @param headOfficeName The headOfficeName to set.
	 */
	public void setHeadOfficeName(String headOfficeName) {
		this.headOfficeName = headOfficeName;
	}
/**
 * @return Returns the officeCode.
 */
public String getOfficeCode() {
	return officeCode;
}
/**
 * @param officeCode The officeCode to set.
 */
public void setOfficeCode(String officeCode) {
	this.officeCode = officeCode;
}
	/**
	 * @return Returns the officeName.
	 */
	public String getOfficeName() {
		return officeName;
	}
	/**
	 * @param officeName The officeName to set.
	 */
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	
	public String getDistrict() {
		return district;
	}
	/**
	 * @param district The district to set.
	 */
	public void setDistrict(String district) {
		this.district = district;
	}
	
	public String getHabCode() {
		return habCode;
	}
	/**
	 * @param habCode The habCode to set.
	 */
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	public String getMandal() {
		return mandal;
	}
	/**
	 * @param mandal The mandal to set.
	 */
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	
	public String getPcode() {
		return pcode;
	}
	/**
	 * @param pcode The pcode to set.
	 */
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getVcode() {
		return vcode;
	}
	/**
	 * @param vcode The vcode to set.
	 */
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	
	public void setMode(String mode)
	{
		this.mode=mode;
	}
	public String getMode()
	{
		return mode;
	}
	public boolean getInit() {
		return init;
	}
	
	public void setInit(boolean init) {
		this.init = init;
	}
public String getDcode() {
		return dcode;
	}
	
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
public String getPname() {
		return pname;
	}
	/**
	 * @param pname The pname to set.
	 */
	public void setPname(String pname) {
		this.pname = pname;
	}
	/**
	 * @return Returns the vname.
	 */
	public String getVname() {
		return vname;
	}
	/**
	 * @param vname The vname to set.
	 */
	public void setVname(String vname) {
		this.vname = vname;
	}
	
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
	 * @return Returns the sdon.
	 */
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		 
		 HttpSession session = request.getSession();
           ArrayList mandals = (ArrayList)session.getAttribute("mandals");
		 ArrayList panchayats = (ArrayList)session.getAttribute("panchyats");
		 ArrayList villages = (ArrayList)session.getAttribute("villages");
		 ArrayList volunteers = (ArrayList)session.getAttribute("volunteers");
		 ArrayList habs = (ArrayList)session.getAttribute("habitations");
		/* ArrayList tankers = (ArrayList)session.getAttribute("tankers");*/
		  this.circleOfficeName="";
		 this.district="";
           if(mandals != null)
		   	mandals.clear();
		 if(panchayats != null)
		 	panchayats.clear();
		 if(villages != null)
		 	villages.clear();
		 if(volunteers != null)
			 volunteers.clear();
		 if(habs != null)
		 	habs.clear();
		 if(volunteers!=null)
			 volunteers.clear(); 
		 
		 this.init = true;
	}
	
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getMcode() {
		return mcode;
	}
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getPanchayat() {
		return panchayat;
	}
	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	
	public String getHabitation() {
		return habitation;
	}
	public void setHabitation(String habitation) {
		this.habitation = habitation;
	}
	public String getVillage() {
		return village;
	}
	public void setVillage(String village) {
		this.village = village;
	}
	public String getHcode() {
		return hcode;
	}
	public void setHcode(String hcode) {
		this.hcode = hcode;
	}
	public String getPrcode() {
		return prcode;
	}
	public void setPrcode(String prcode) {
		this.prcode = prcode;
	}
	
		
}

