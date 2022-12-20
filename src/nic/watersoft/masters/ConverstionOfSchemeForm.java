package nic.watersoft.masters;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class ConverstionOfSchemeForm extends ActionForm{
	private String district;
	private String mandal;
	private String pcode;
	private String vcode;
	private String habCode;
	private Collection prHabs;
	private String mode;
	private String type_of_asset_name;
	private String type_of_asset_name1;
	private String assetCode;
	private String assetType;
	private String assetName;
	private ArrayList SchemesTo;
	public String getAssetCode() {
		return assetCode;
	}
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	public String getAssetType() {
		return assetType;
	}
	public void setAssetType(String assetType) {
		this.assetType = assetType;
	}
	public String getType_of_asset_name1() {
		return type_of_asset_name1;
	}
	public void setType_of_asset_name1(String type_of_asset_name1) {
		this.type_of_asset_name1 = type_of_asset_name1;
	}

	private String type_of_asset_code;
	
	public ConverstionOfSchemeForm() 
	{
		prHabs = new ArrayList();
	}
	public String getType_of_asset_name() {
		return type_of_asset_name;
	}
	public void setType_of_asset_name(String type_of_asset_name) {
		this.type_of_asset_name = type_of_asset_name;
	}
	public String getType_of_asset_code() {
		return type_of_asset_code;
	}
	public void setType_of_asset_code(String type_of_asset_code) {
		this.type_of_asset_code = type_of_asset_code;
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
	 * @return Returns the prHabs.
	 */
	public Collection getPrHabs() {
		return prHabs;
		
	}
	/**
	 * @param prHabs The prHabs to set.
	 */
	 
	
	public void setPrHabs(Collection prHabs) {
		 
		this.prHabs = prHabs;
		
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
	 * @param mode The mode to set.
	 */
	public void setMode(String mode)
	{
		this.mode=mode;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode()
	{
		return mode;
	}
	
	public ArrayList getSchemesTo() {
		return SchemesTo;
	}
	public void setSchemesTo(ArrayList schemesTo) {
		SchemesTo = schemesTo;
	}
	/*public PanchRaj getPRHAB_LIST(int index)
	{
		//System.out.println("index in  getPRHAB_LIST():"+index+"size="+prHabs.size());
		while(index >= prHabs.size())
		{
			prHabs.add(new PanchRaj());
		}
	 
		return (PanchRaj)((ArrayList) prHabs).get(index);
	}*/
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		 HttpSession session = request.getSession();
		 //System.out.println("it is in reset");
		 this.habCode="";
		 this.district="";
		 this.mandal="";
		 this.pcode="";
		 this.vcode="";
		this.type_of_asset_name="";
		this.type_of_asset_code="";
		 /*
		 ArrayList mandals=(ArrayList)session.getAttribute("mandals");
		 ArrayList panchyats=(ArrayList)session.getAttribute("panchyats");
		 ArrayList villages=(ArrayList)session.getAttribute("villages");
		 ArrayList habitations=(ArrayList)session.getAttribute("habitations");
			if(session.getAttribute("mandals") != null)
			 {
				 mandals.clear();
				 panchyats.clear();
				 villages.clear();
				 habitations.clear();
			 }
		 */
		 
		 prHabs.clear();
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
}
