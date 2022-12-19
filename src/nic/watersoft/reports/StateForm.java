package nic.watersoft.reports;
import org.apache.struts.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * Form bean for a Struts application.
 * Users may access 2 fields on this form:
 * <ul>
 * <li>empname - [your comment here]
 * <li>empno - [your comment here]
 * </ul>
 * @version 	1.0
 * @author
 */
public class StateForm extends ActionForm

{

	
	String dcode;
	String dname;
	int dcount;
	String mcode;
	String mname;
	int mcount;
	String pcode;
	String pname;
	int pcount;
	String vcode;
	String vname;
	int tcount;
	String panchcode;
	String panchname;
	int panchcount;
	 private String assetCount;
	 private String assetName;
	 private String typeAssetcode;
	 private String dist;
	 private String districtradio;
	 
	/**
	 * @return Returns the districtradio.
	 */
	public String getDistrictradio() {
		return districtradio;
	}
	/**
	 * @param districtradio The districtradio to set.
	 */
	public void setDistrictradio(String districtradio) {
		this.districtradio = districtradio;
	}
	/**
	 * @return Returns the habitationdisplay.
	 */
	public ArrayList getHabitationdisplay() {
		return habitationdisplay;
	}
	/**
	 * @param habitationdisplay The habitationdisplay to set.
	 */
	public void setHabitationdisplay(ArrayList habitationdisplay) {
		this.habitationdisplay = habitationdisplay;
	}
	 private String districtCode;
	 private String districtName;
	 private String mand;
	 private String mandalCode;
	 private String mandalName;
	 private String panch;
	 private String panchayatCode;
	 private String panchayatName;
	 private String vill;
	 private String villageCode;
	 private String villageName;
	 ArrayList habitationdisplay; 
	 private String panchCode;
	 private String panchName;
	
	
	 
	 
	/**
	 * @return Returns the dist.
	 */
	public String getDist() {
		return dist;
	}
	/**
	 * @param dist The dist to set.
	 */
	public void setDist(String dist) {
		this.dist = dist;
	}
	/**
	 * @return Returns the districtCode.
	 */
	public String getDistrictCode() {
		return districtCode;
	}
	/**
	 * @param districtCode The districtCode to set.
	 */
	public void setDistrictCode(String districtCode) {
		this.districtCode = districtCode;
	}
	/**
	 * @return Returns the districtName.
	 */
	public String getDistrictName() {
		return districtName;
	}
	/**
	 * @param districtName The districtName to set.
	 */
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	/**
	 * @return Returns the mand.
	 */
	public String getMand() {
		return mand;
	}
	/**
	 * @param mand The mand to set.
	 */
	public void setMand(String mand) {
		this.mand = mand;
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
	 * @return Returns the ohrsLts.
	 */
	public String getOhrsLts() {
		return ohrsLts;
	}
	/**
	 * @param ohrsLts The ohrsLts to set.
	 */
	public void setOhrsLts(String ohrsLts) {
		this.ohrsLts = ohrsLts;
	}
	/**
	 * @return Returns the ohsrCapacityLts.
	 */
	public String getOhsrCapacityLts() {
		return ohsrCapacityLts;
	}
	/**
	 * @param ohsrCapacityLts The ohsrCapacityLts to set.
	 */
	public void setOhsrCapacityLts(String ohsrCapacityLts) {
		this.ohsrCapacityLts = ohsrCapacityLts;
	}
	/**
	 * @return Returns the ohsrCode.
	 */
	public String getOhsrCode() {
		return ohsrCode;
	}
	/**
	 * @param ohsrCode The ohsrCode to set.
	 */
	public void setOhsrCode(String ohsrCode) {
		this.ohsrCode = ohsrCode;
	}
	/**
	 * @return Returns the ohsrEmptyHrs.
	 */
	public String getOhsrEmptyHrs() {
		return ohsrEmptyHrs;
	}
	/**
	 * @param ohsrEmptyHrs The ohsrEmptyHrs to set.
	 */
	public void setOhsrEmptyHrs(String ohsrEmptyHrs) {
		this.ohsrEmptyHrs = ohsrEmptyHrs;
	}
	/**
	 * @return Returns the ohsrFillHrs.
	 */
	public String getOhsrFillHrs() {
		return ohsrFillHrs;
	}
	/**
	 * @param ohsrFillHrs The ohsrFillHrs to set.
	 */
	public void setOhsrFillHrs(String ohsrFillHrs) {
		this.ohsrFillHrs = ohsrFillHrs;
	}
	/**
	 * @return Returns the ohsrHygiene.
	 */
	public String getOhsrHygiene() {
		return ohsrHygiene;
	}
	/**
	 * @param ohsrHygiene The ohsrHygiene to set.
	 */
	public void setOhsrHygiene(String ohsrHygiene) {
		this.ohsrHygiene = ohsrHygiene;
	}
	/**
	 * @return Returns the ohsrLocation.
	 */
	public String getOhsrLocation() {
		return ohsrLocation;
	}
	/**
	 * @param ohsrLocation The ohsrLocation to set.
	 */
	public void setOhsrLocation(String ohsrLocation) {
		this.ohsrLocation = ohsrLocation;
	}
	/**
	 * @return Returns the ohsrLwl.
	 */
	public String getOhsrLwl() {
		return ohsrLwl;
	}
	/**
	 * @param ohsrLwl The ohsrLwl to set.
	 */
	public void setOhsrLwl(String ohsrLwl) {
		this.ohsrLwl = ohsrLwl;
	}
	/**
	 * @return Returns the ohsrMwl.
	 */
	public String getOhsrMwl() {
		return ohsrMwl;
	}
	/**
	 * @param ohsrMwl The ohsrMwl to set.
	 */
	public void setOhsrMwl(String ohsrMwl) {
		this.ohsrMwl = ohsrMwl;
	}
	/**
	 * @return Returns the ohsrStages.
	 */
	public String getOhsrStages() {
		return ohsrStages;
	}
	/**
	 * @param ohsrStages The ohsrStages to set.
	 */
	public void setOhsrStages(String ohsrStages) {
		this.ohsrStages = ohsrStages;
	}
	/**
	 * @return Returns the panch.
	 */
	public String getPanch() {
		return panch;
	}
	/**
	 * @param panch The panch to set.
	 */
	public void setPanch(String panch) {
		this.panch = panch;
	}
	/**
	 * @return Returns the panchayatCode.
	 */
	public String getPanchayatCode() {
		return panchayatCode;
	}
	/**
	 * @param panchayatCode The panchayatCode to set.
	 */
	public void setPanchayatCode(String panchayatCode) {
		this.panchayatCode = panchayatCode;
	}
	/**
	 * @return Returns the panchayatName.
	 */
	public String getPanchayatName() {
		return panchayatName;
	}
	/**
	 * @param panchayatName The panchayatName to set.
	 */
	public void setPanchayatName(String panchayatName) {
		this.panchayatName = panchayatName;
	}
	/**
	 * @return Returns the vill.
	 */
	public String getVill() {
		return vill;
	}
	/**
	 * @param vill The vill to set.
	 */
	public void setVill(String vill) {
		this.vill = vill;
	}
	/**
	 * @return Returns the villageCode.
	 */
	public String getVillageCode() {
		return villageCode;
	}
	/**
	 * @param villageCode The villageCode to set.
	 */
	public void setVillageCode(String villageCode) {
		this.villageCode = villageCode;
	}
	/**
	 * @return Returns the villageName.
	 */
	public String getVillageName() {
		return villageName;
	}
	/**
	 * @param villageName The villageName to set.
	 */
	public void setVillageName(String villageName) {
		this.villageName = villageName;
	}
	/**
	 * @return Returns the assetCount.
	 */
	public String getAssetCount() {
		return assetCount;
	}
	/**
	 * @param assetCount The assetCount to set.
	 */
	public void setAssetCount(String assetCount) {
		this.assetCount = assetCount;
	}
	/**
	 * @return Returns the assetName.
	 */
	public String getAssetName() {
		return assetName;
	}
	/**
	 * @param assetName The assetName to set.
	 */
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	/**
	 * @return Returns the typeAssetcode.
	 */
	public String getTypeAssetcode() {
		return typeAssetcode;
	}
	/**
	 * @param typeAssetcode The typeAssetcode to set.
	 */
	public void setTypeAssetcode(String typeAssetcode) {
		this.typeAssetcode = typeAssetcode;
	}
	/**
	 * @return Returns the bptCapacity.
	 */
	
	/**
	 * @return Returns the bptCode.
	 */
	/**
	 * @return Returns the ohsrCode.
	 */
	
	
	 private String ohrsLts;
	 private String ohsrLocation;
	 private String ohsrCapacityLts;
	 private String ohsrFillHrs;
	 private String ohsrEmptyHrs;
	 private String ohsrHygiene;
	 private String ohsrCode;
	 private String ohsrStages;
	 private String ohsrLwl;
	 private String ohsrMwl;
	 private String mode;
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
	 * @return Returns the asset.
	 */
	public String getAsset() {
		return asset;
	}
	/**
	 * @param asset The asset to set.
	 */
	public void setAsset(String asset) {
		this.asset = asset;
	}
	 private String asset;
 

     	 
	 
	 
	 
	
	/**
	 * @return Returns the disBalanceNeeded.
	 */
	/**
	 * @param disBalanceNeeded The disBalanceNeeded to set.
	 */
	
	/**
	 * @return Returns the disClass.
	 */
	/**
	 * @param disClass The disClass to set.
	 */
	/**
	 * @return Returns the disCode.
	 */
	/**
	 * @param disCode The disCode to set.
	 */
	
	/**
	 * @return Returns the disCovered.
	 */
	
	/**
	 * @param disCovered The disCovered to set.
	 */
	
	/**
	 * @return Returns the disDiameter.
	 */
	
	/**
	 * @param disDiameter The disDiameter to set.
	 */
	/**
	 * @return Returns the disLength.
	 */
	/**
	 * @param disLength The disLength to set.
	 */
	/**
	 * @return Returns the disMaterial.
	 */
	/**
	 * @param disMaterial The disMaterial to set.
	 */
	
	/**
	 * @return Returns the disMaterialCode.
	 */
	
	/**
	 * @param disMaterialCode The disMaterialCode to set.
	 */
	
	/**
	 * @return Returns the disNoOfPipes.
	 */
	
	/**
	 * @param disNoOfPipes The disNoOfPipes to set.
	 */
	
	/**
	 * @return Returns the disTotLength.
	 */
	/**
	 * @param disTotLength The disTotLength to set.
	 */
	
	/**
	 * @return Returns the disTotLenProvided.
	 */
	
	/**
	 * @param disTotLenProvided The disTotLenProvided to set.
	 */
	
	/**
	 * @return Returns the noOfPipes.
	 */
	
	/**
	 * @param noOfPipes The noOfPipes to set.
	 */
	
	/**
	 * @return Returns the panchcode.
	 */
	public String getPanchcode() {
		return panchcode;
	}
	/**
	 * @param panchcode The panchcode to set.
	 */
	public void setPanchcode(String panchcode) {
		this.panchcode = panchcode;
	}
	/**
	 * @return Returns the panchcount.
	 */
	public int getPanchcount() {
		return panchcount;
	}
	/**
	 * @param panchcount The panchcount to set.
	 */
	public void setPanchcount(int panchcount) {
		this.panchcount = panchcount;
	}
	/**
	 * @return Returns the panchname.
	 */
	public String getPanchname() {
		return panchname;
	}
	/**
	 * @param panchname The panchname to set.
	 */
	public void setPanchname(String panchname) {
		this.panchname = panchname;
	}
	/**
	 * @return Returns the tcount.
	 */
	public int getTcount() {
		return tcount;
	}
	/**
	 * @param tcount The tcount to set.
	 */
	public void setTcount(int tcount) {
		this.tcount = tcount;
	}
	int vcount;
	
	
	/**
	 * @return Returns the dcode.
	 */
	public String getDcode() {
		return dcode;
	}
	/**
	 * @param dcode The dcode to set.
	 */
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	/**
	 * @return Returns the dcount.
	 */
	public int getDcount() {
		return dcount;
	}
	/**
	 * @param dcount The dcount to set.
	 */
	public void setDcount(int dcount) {
		this.dcount = dcount;
	}
	/**
	 * @return Returns the dname.
	 */
	public String getDname() {
		return dname;
	}
	/**
	 * @param dname The dname to set.
	 */
	public void setDname(String dname) {
		this.dname = dname;
	}
	/**
	 * @return Returns the empname.
	 */
	
	/**
	 * @param empname The empname to set.
	 */
	/**
	 * @return Returns the empno.
	 */
	/**
	 * @param empno The empno to set.
	 */
	
	/**
	 * @return Returns the mcode.
	 */
	public String getMcode() {
		return mcode;
	}
	/**
	 * @param mcode The mcode to set.
	 */
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	/**
	 * @return Returns the mcount.
	 */
	public int getMcount() {
		return mcount;
	}
	/**
	 * @param mcount The mcount to set.
	 */
	public void setMcount(int mcount) {
		this.mcount = mcount;
	}
	/**
	 * @return Returns the mname.
	 */
	public String getMname() {
		return mname;
	}
	/**
	 * @param mname The mname to set.
	 */
	public void setMname(String mname) {
		this.mname = mname;
	}
	/**
	 * @return Returns the pcode.
	 */
	public String getPcode() {
		return pcode;
	}
	/**
	 * @param pcode The pcode to set.
	 */
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	/**
	 * @return Returns the pcount.
	 */
	public int getPcount() {
		return pcount;
	}
	/**
	 * @param pcount The pcount to set.
	 */
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	/**
	 * @return Returns the pname.
	 */
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
	 * @return Returns the vcode.
	 */
	public String getVcode() {
		return vcode;
	}
	/**
	 * @param vcode The vcode to set.
	 */
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	/**
	 * @return Returns the vcount.
	 */
	public int getVcount() {
		return vcount;
	}
	/**
	 * @param vcount The vcount to set.
	 */
	public void setVcount(int vcount) {
		this.vcount = vcount;
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
	/**
	 * @return Returns the deptId.
	 */
	
	/**
	 * @param deptId The deptId to set.
	 */
	
	/**
	 * @return Returns the deptName.
	 */
	
	/**
	 * @return Returns the deptname.
	 */
	
	/**
	 * @param deptname The deptname to set.
	 */
	
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
	
}