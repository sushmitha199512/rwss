package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class rws_functional_repair_frm extends ActionForm{
	private static final long serialVersionUID = 1L;
	private String dcode;
	private String mcode;
	private String panchayat;
	private String vcode;
	private String asttype;
	private String asttypecode;
	private String ast;
	private ArrayList<rws_functional_repair_frm> sources;
	private ArrayList repairTypes;
	private String repairCode;
	private String repairName;
	private String sourceCode;
	private String sourceTypeName;	
	private String repairType;
	private String checks;	
	private String mode;
	private String astComp;
	private String astCompCode;
	private String astCompName;	
	private String astSubComp;
	private String astSubCompCode;
	private String astSubCompName;	
	private String souType;
	private String sourceTypeCode;
	private String assetCode;
	private String assetName;
	private String compCode;
	private String compName;
	private String location;
	private String status;
	private String compLat;
	private String compLong;
	private String compRepairCode;	
	private String compRepairdate;
	private String CompRepairCost;
	private String imgStatus;
	private String inspectedBy;
	private String notFunctionalStatus;
	private String alterArangmts;
	
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getChecks() {
		return checks;
	}
	public void setChecks(String checks) {
		this.checks = checks;
	}
	public String getDcode() {
		return dcode;
	}
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	public String getMcode() {
		return mcode;
	}
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	public String getAsttype() {
		return asttype;
	}
	public void setAsttype(String asttype) {
		this.asttype = asttype;
	}
	public String getAst() {
		return ast;
	}
	public void setAst(String ast) {
		this.ast = ast;
	}
	
	public ArrayList<rws_functional_repair_frm> getSources() {
		return sources;
	}
	public void setSources(ArrayList<rws_functional_repair_frm> sources) {
		this.sources = sources;
	}
	/*public ArrayList getSources() {
		return sources;
	}
	public void setSources(ArrayList sources) {
		this.sources = sources;
	}*/
	public ArrayList getRepairTypes() {
		return repairTypes;
	}
	public void setRepairTypes(ArrayList repairTypes) {
		this.repairTypes = repairTypes;
	}
	
	public String getSourceCode() {
		return sourceCode;
	}
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}
	public String getSourceTypeName() {
		return sourceTypeName;
	}
	public void setSourceTypeName(String sourceTypeName) {
		this.sourceTypeName = sourceTypeName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRepairType() {
		return repairType;
	}
	public void setRepairType(String repairType) {
		this.repairType = repairType;
	}
	public String getRepairCode() {
		return repairCode;
	}
	public void setRepairCode(String repairCode) {
		this.repairCode = repairCode;
	}
	public String getPanchayat() {
		return panchayat;
	}
	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}
	public String getVcode() {
		return vcode;
	}
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	public String getAstSubComp() {
		return astSubComp;
	}
	public void setAstSubComp(String astSubComp) {
		this.astSubComp = astSubComp;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getAsttypecode() {
		return asttypecode;
	}
	public void setAsttypecode(String asttypecode) {
		this.asttypecode = asttypecode;
	}
	public String getAstCompCode() {
		return astCompCode;
	}
	public void setAstCompCode(String astCompCode) {
		this.astCompCode = astCompCode;
	}
	public String getAstCompName() {
		return astCompName;
	}
	public void setAstCompName(String astCompName) {
		this.astCompName = astCompName;
	}
	public String getAstComp() {
		return astComp;
	}
	public void setAstComp(String astComp) {
		this.astComp = astComp;
	}
	public String getSouType() {
		return souType;
	}
	public void setSouType(String souType) {
		this.souType = souType;
	}
	
	public String getRepairName() {
		return repairName;
	}
	public void setRepairName(String repairName) {
		this.repairName = repairName;
	}
	public String getCompRepairCode() {
		return compRepairCode;
	}
	public void setCompRepairCode(String compRepairCode) {
		this.compRepairCode = compRepairCode;
	}
	public String getCompRepairdate() {
		return compRepairdate;
	}
	public void setCompRepairdate(String compRepairdate) {
		this.compRepairdate = compRepairdate;
	}
	
	
	public String getCompRepairCost() {
		return CompRepairCost;
	}
	public void setCompRepairCost(String compRepairCost) {
		CompRepairCost = compRepairCost;
	}
	public String getSourceTypeCode() {
		return sourceTypeCode;
	}
	public void setSourceTypeCode(String sourceTypeCode) {
		this.sourceTypeCode = sourceTypeCode;
	}
	public String getAstSubCompCode() {
		return astSubCompCode;
	}
	public void setAstSubCompCode(String astSubCompCode) {
		this.astSubCompCode = astSubCompCode;
	}
	public String getAstSubCompName() {
		return astSubCompName;
	}
	public void setAstSubCompName(String astSubCompName) {
		this.astSubCompName = astSubCompName;
	}
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	public String getCompCode() {
		return compCode;
	}
	public void setCompCode(String compCode) {
		this.compCode = compCode;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getCompLat() {
		return compLat;
	}
	public void setCompLat(String compLat) {
		this.compLat = compLat;
	}
	public String getCompLong() {
		return compLong;
	}
	public void setCompLong(String compLong) {
		this.compLong = compLong;
	}
	public String getImgStatus() {
		return imgStatus;
	}
	public void setImgStatus(String imgStatus) {
		this.imgStatus = imgStatus;
	}
	public String getInspectedBy() {
		return inspectedBy;
	}
	public void setInspectedBy(String inspectedBy) {
		this.inspectedBy = inspectedBy;
	}
	public String getNotFunctionalStatus() {
		return notFunctionalStatus;
	}
	public void setNotFunctionalStatus(String notFunctionalStatus) {
		this.notFunctionalStatus = notFunctionalStatus;
	}
	public String getAlterArangmts() {
		return alterArangmts;
	}
	public void setAlterArangmts(String alterArangmts) {
		this.alterArangmts = alterArangmts;
	}

}
