package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import nic.watersoft.works.tenderMemo;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class MandalSubDivisionForm extends ActionForm
{
	private String coc;
	private String doc;
	private String sdoc;
	private String district;
	private String mandal;
	private String mode;
	private String con;
	private String don;
	private String sdon;
	private String dname;
	private String mandalName;
	
	/*
	 * added by ramesh on 13/05/2009
	 */
	
	private String inQua;
	private String vname;
	private String vcode;
	private String qa;
	private String qp1;
	private String qp2;
	private String qp3;
	private String qp4;
	private String censusVillages;
	private String censusDistt;
	private String censusSubDist;
	private String sfncpop;
	private ArrayList habsData;
	private String checks;
	private String main;
	
	
	/**
	 * @return Returns the coc.
	 */
	public String getCoc() {
		return coc;
	}
	/**
	 * @param coc The coc to set.
	 */
	public void setCoc(String coc) {
		this.coc = coc;
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
	 * @return Returns the doc.
	 */
	public String getDoc() {
		return doc;
	}
	/**
	 * @param doc The doc to set.
	 */
	public void setDoc(String doc) {
		this.doc = doc;
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
	 * @return Returns the sdoc.
	 */
	public String getSdoc() {
		return sdoc;
	}
	/**
	 * @param sdoc The sdoc to set.
	 */
	public void setSdoc(String sdoc) {
		this.sdoc = sdoc;
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
	
	public void setCon(String con)
	{
		this.con=con;
		
	}
	public String getCon()
	{
		return con;
	}
	public void setDon(String don)
	{
		this.don=don;
	}
    public String getDon()
    {
    	return don;
    }
    public void setSdon(String sdon)
    {
    	this.sdon=sdon;
    }
    public String getSdon()
    {
      return sdon;
    }
    public void setDname(String dname)
    {
    	this.dname=dname;
    }
    public String getDname()
    {
    	return dname;
		
    }
    public void setMandalName(String mandalName)
    {
    	this.mandalName=mandalName;
    }
    public String getMandalName()
    {
      return mandalName;
    }
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		this.coc="";
		this.district="";
		this.dname="";
		this.doc="";
		this.mandal="";
		HttpSession session = request.getSession();
		ArrayList circle = (ArrayList)session.getAttribute("circles");
		ArrayList divcodes = (ArrayList)session.getAttribute("divisions");
		ArrayList subdivcodes = (ArrayList)session.getAttribute("subdivisions");
		ArrayList mandals = (ArrayList)session.getAttribute("mandals");
		
		if(divcodes != null)
		{
			
		 	divcodes.clear();
		 	subdivcodes.clear();
		}
		if(mandals != null)
		{
		  	mandals.clear();
		}
	}
	
	public String getInQua() {
		return inQua;
	}
	public void setInQua(String inQua) {
		this.inQua = inQua;
	}
	public String getVcode() {
		return vcode;
	}
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	public String getVname() {
		return vname;
	}
	
	public void setVname(String vname) {
		this.vname = vname;
	}
	
	public String getQa() {
		return qa;
	}
	public void setQa(String qa) {
		this.qa = qa;
	}
	public String getQp1() {
		return qp1;
	}
	public void setQp1(String qp1) {
		this.qp1 = qp1;
	}
	
	public String getCensusDistt() {
		return censusDistt;
	}
	public void setCensusDistt(String censusDistt) {
		this.censusDistt = censusDistt;
	}
	public String getCensusSubDist() {
		return censusSubDist;
	}
	public void setCensusSubDist(String censusSubDist) {
		this.censusSubDist = censusSubDist;
	}
	public String getCensusVillages() {
		return censusVillages;
	}
	public void setCensusVillages(String censusVillages) {
		this.censusVillages = censusVillages;
	}
	public String getQp2() {
		return qp2;
	}
	public void setQp2(String qp2) {
		this.qp2 = qp2;
	}
	public String getQp3() {
		return qp3;
	}
	public void setQp3(String qp3) {
		this.qp3 = qp3;
	}
	public String getQp4() {
		return qp4;
	}
	public void setQp4(String qp4) {
		this.qp4 = qp4;
	}
	
	public String getSfncpop() {
		return sfncpop;
	}
	public void setSfncpop(String sfncpop) {
		this.sfncpop = sfncpop;
	}
	
	public ArrayList getHabsData() {
		return habsData;
	}
	public void setHabsData(ArrayList habsData) {
		this.habsData = habsData;
	}
	public MandalSubDivisionForm()
	{
 		habsData=new ArrayList();
 	}
	public  tenderMemo  getWORKEXP_LIST(int index)
	{
		while(index >= habsData.size())
		{
			habsData.add(new tenderMemo());
		}
	 
		return (tenderMemo)habsData.get(index);
	}
	
	public String getChecks() {
		return checks;
	}
	public void setChecks(String checks) {
		this.checks = checks;
	}
	
	
	public String getMain() {
		return main;
	}
	public void setMain(String main) {
		this.main = main;
	}
}
