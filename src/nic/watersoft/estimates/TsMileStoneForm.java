/**
 * Created on Jun 15, 2007
 
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.estimates;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.fundAccounting.Rws_BroProgDetailsBean;
import nic.watersoft.works.rws_works_WorkStatus_bean;
import nic.watersoft.works.tenderMemo;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import java.util.ArrayList;

 
public class TsMileStoneForm extends ActionForm
{
	
	private String mode;
	private String mode1; 
	private String circleName;
	private String circleOfficeCode;
	private String divName;
	private String divisionOfficeCode;
	private String subdivisionOfficeCode;
	private String subDivName;
	private String workId;
	private String workName;
	private String assetType;
	private ArrayList mileStones;
	private String mileStone;
	private String item;
	private String tQty;
	private String tUnits;
	private String tAmount;
	private String itemSlNo;
	
	//Technical Sanction
	
	private String tsMode;
    private String tsAccBy;
    private String tsAmnt;
    private String tsNo;
    private String tsDate;
    private String tsHabsBen;
    private String tsHabNames;
    private String tsOffice;
    private String ssrYear;
    private String tsPlainPop;
    private String tsScPop;
    private String tsStPop;
    private String tsTotPop;
    /**Revised Tecnicla saction  */
    private String revTsMode="data";
    private String revTsAccBy;
    private String revTsAmnt;
    private String revTsNo;
    private String revTsDate;
    private String revTsHabsBen;
    private String revTsHabNames;
    private String revTsOffice;
    private String revSsrYear;
    private String revTsPlainPopu;
    private String revTsScPopu;
    private String revTsSTPopu;
    private String revTsTotpopu;
    private String syr;
    private String subDivCode;
    private String adminNo;
    private String adminDate;
    private String adminAmnt;
    private String preparedBy;
    private String officeCode;
	
	public String getTAmount() {
		return tAmount;
	}
	public void setTAmount(String amount) {
		tAmount = amount;
	}
	public String getTQty() {
		return tQty; 
	}
	public void setTQty(String qty) {
		tQty = qty;
	}
	public String getTUnits() {
		return tUnits;
	}
	public void setTUnits(String units) {
		tUnits = units;
	}
	public String getMileStone() {
		return mileStone;
	}
	public void setMileStone(String mileStone) {
		this.mileStone = mileStone;
	}
	public ArrayList getMileStones() {
		return mileStones;
	}
	public void setMileStones(ArrayList mileStones) {
		this.mileStones = mileStones;
	}
	public String getAssetType() {
		return assetType;
	}
	public void setAssetType(String assetType) {
		this.assetType = assetType;
	}
	
	public String getCircleName() {
		return circleName;
	}
	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}
	
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	public String getSubdivisionOfficeCode() {
		return subdivisionOfficeCode;
	}
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
		this.subdivisionOfficeCode = subdivisionOfficeCode;
	}
	public String getDivName() {
		return divName;
	}
	public void setDivName(String divName) {
		this.divName = divName;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMode1() {
		return mode1;
	}
	public void setMode1(String mode1) {
		this.mode1 = mode1;
	}
	
	public String getSubDivName() {
		return subDivName;
	}
	public void setSubDivName(String subDivName) {
		this.subDivName = subDivName;
	}
	public String getWorkId() {
		return workId;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public String getWorkName() {
		return workName;
	} 
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	public TsMileStoneForm()
	{
		mileStones=new ArrayList();
		
	}
	public rws_works_WorkStatus_bean getMILES(int index)
	{
		while(index >= mileStones.size())
		{
			mileStones.add(new rws_works_WorkStatus_bean());
		}
		return (rws_works_WorkStatus_bean)((ArrayList) mileStones).get(index);
	}
	
	public String getRevSsrYear() {
		return revSsrYear;
	}
	public void setRevSsrYear(String revSsrYear) {
		this.revSsrYear = revSsrYear;
	}
	public String getRevTsAccBy() {
		return revTsAccBy;
	}
	public void setRevTsAccBy(String revTsAccBy) {
		this.revTsAccBy = revTsAccBy;
	}
	public String getRevTsAmnt() {
		return revTsAmnt;
	}
	public void setRevTsAmnt(String revTsAmnt) {
		this.revTsAmnt = revTsAmnt;
	}
	public String getRevTsDate() {
		return revTsDate;
	}
	public void setRevTsDate(String revTsDate) {
		this.revTsDate = revTsDate;
	}
	public String getRevTsHabNames() {
		return revTsHabNames;
	}
	public void setRevTsHabNames(String revTsHabNames) {
		this.revTsHabNames = revTsHabNames;
	}
	public String getRevTsHabsBen() {
		return revTsHabsBen;
	}
	public void setRevTsHabsBen(String revTsHabsBen) {
		this.revTsHabsBen = revTsHabsBen;
	}
	public String getRevTsMode() {
		return revTsMode;
	}
	public void setRevTsMode(String revTsMode) {
		this.revTsMode = revTsMode;
	}
	public String getRevTsNo() {
		return revTsNo;
	}
	public void setRevTsNo(String revTsNo) {
		this.revTsNo = revTsNo;
	}
	public String getRevTsOffice() {
		return revTsOffice;
	}
	public void setRevTsOffice(String revTsOffice) {
		this.revTsOffice = revTsOffice;
	}
	public String getRevTsPlainPopu() {
		return revTsPlainPopu;
	}
	public void setRevTsPlainPopu(String revTsPlainPopu) {
		this.revTsPlainPopu = revTsPlainPopu;
	}
	public String getRevTsScPopu() {
		return revTsScPopu;
	}
	public void setRevTsScPopu(String revTsScPopu) {
		this.revTsScPopu = revTsScPopu;
	}
	public String getRevTsSTPopu() {
		return revTsSTPopu;
	}
	public void setRevTsSTPopu(String revTsSTPopu) {
		this.revTsSTPopu = revTsSTPopu;
	}
	public String getRevTsTotpopu() {
		return revTsTotpopu;
	}
	public void setRevTsTotpopu(String revTsTotpopu) {
		this.revTsTotpopu = revTsTotpopu;
	}
	public String getSsrYear() {
		return ssrYear;
	}
	public void setSsrYear(String ssrYear) {
		this.ssrYear = ssrYear;
	}
	public String getTsAccBy() {
		return tsAccBy;
	}
	public void setTsAccBy(String tsAccBy) {
		this.tsAccBy = tsAccBy;
	}
	public String getTsAmnt() {
		return tsAmnt;
	}
	public void setTsAmnt(String tsAmnt) {
		this.tsAmnt = tsAmnt;
	}
	public String getTsDate() {
		return tsDate;
	}
	public void setTsDate(String tsDate) {
		this.tsDate = tsDate;
	}
	public String getTsHabNames() {
		return tsHabNames;
	}
	public void setTsHabNames(String tsHabNames) {
		this.tsHabNames = tsHabNames;
	}
	public String getTsHabsBen() {
		return tsHabsBen;
	}
	public void setTsHabsBen(String tsHabsBen) {
		this.tsHabsBen = tsHabsBen;
	}
	public String getTsMode() {
		return tsMode;
	}
	public void setTsMode(String tsMode) {
		this.tsMode = tsMode;
	}
	public String getTsNo() {
		return tsNo;
	}
	public void setTsNo(String tsNo) {
		this.tsNo = tsNo;
	}
	public String getTsOffice() {
		return tsOffice;
	}
	public void setTsOffice(String tsOffice) {
		this.tsOffice = tsOffice;
	}
	public String getTsPlainPop() {
		return tsPlainPop;
	}
	public void setTsPlainPop(String tsPlainPop) {
		this.tsPlainPop = tsPlainPop;
	}
	public String getTsScPop() {
		return tsScPop;
	}
	public void setTsScPop(String tsScPop) {
		this.tsScPop = tsScPop;
	}
	public String getTsStPop() {
		return tsStPop;
	}
	public void setTsStPop(String tsStPop) {
		this.tsStPop = tsStPop;
	}
	public String getTsTotPop() {
		return tsTotPop;
	}
	public void setTsTotPop(String tsTotPop) {
		this.tsTotPop = tsTotPop;
	}
	
	public String getAdminAmnt() {
		return adminAmnt;
	}
	public void setAdminAmnt(String adminAmnt) {
		this.adminAmnt = adminAmnt;
	}
	public String getAdminDate() {
		return adminDate;
	}
	public void setAdminDate(String adminDate) {
		this.adminDate = adminDate;
	}
	public String getAdminNo() {
		return adminNo;
	}
	public void setAdminNo(String adminNo) {
		this.adminNo = adminNo;
	}
	public String getSubDivCode() {
		return subDivCode;
	}
	public void setSubDivCode(String subDivCode) {
		this.subDivCode = subDivCode;
	}
	public String getSyr() {
		return syr;
	}
	public void setSyr(String syr) {
		this.syr = syr;
	}
	
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	
	public String getOfficeCode() {
		return officeCode;
	}
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	public String getPreparedBy() {
		return preparedBy;
	}
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	
	public String getItemSlNo() {
		return itemSlNo;
	}
	public void setItemSlNo(String itemSlNo) {
		this.itemSlNo = itemSlNo;
	}
 }
