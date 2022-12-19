package nic.watersoft.masters;

import java.io.Serializable;

public class PanchRaj implements Serializable
{
	
	private String habitation;
	private String habCode; 
	private String habName; 
	private String jbCode; 
	private String habPop;
	
	private String divName;
	private String subDivname;
	private String mandalName;
	private String dname;
	private String pName;
	private String vname;
	public PanchRaj()
	{
	}

	public PanchRaj(String habitation,String habCode,String jbCode,String habName)
	{
		 
	    this.habitation=habitation;	
		this.habCode=habCode;
		this.habName = habName;
		this.jbCode=jbCode;
	 	
	}
	
	public PanchRaj(String habCode)
	{
		this.habCode = habCode;
	 	 
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
	
	/**
	 * @return Returns the habName.
	 */
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
	 * @return Returns the jbcode
	 */
	public String getJbCode() {
		return jbCode;
	}
	/**
	 * @param jbCode to set to jbCode
	 */
	public void setJbCode(String jbCode) {
		this.jbCode=jbCode;
	}
	
	public String getHabPop() {
		return habPop;
	}
	public void setHabPop(String habPop) {
		this.habPop = habPop;
	}
	
	/**
	 * @return Returns the divName.
	 */
	public String getDivName() {
		return divName;
	}
	/**
	 * @param divName The divName to set.
	 */
	public void setDivName(String divName) {
		this.divName = divName;
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
	 * @return Returns the pName.
	 */
	public String getPName() {
		return pName;
	}
	/**
	 * @param name The pName to set.
	 */
	public void setPName(String name) {
		pName = name;
	}
	/**
	 * @return Returns the subDivname.
	 */
	public String getSubDivname() {
		return subDivname;
	}
	/**
	 * @param subDivname The subDivname to set.
	 */
	public void setSubDivname(String subDivname) {
		this.subDivname = subDivname;
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
}