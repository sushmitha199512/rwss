
package nic.watersoft.commons;

import java.io.Serializable;


public class ProgrammeSubProgrammeBean implements Serializable 
{
	private String programmeCode;
	private String programmeName;
	private String subprogrammeCode;
	private String subprogrammeName;
		
	/**
	 * @return Returns the programmeCode.
	 */
	public String getProgrammeCode() {
		return programmeCode;
	}
	/**
	 * @param programmeCode The programmeCode to set.
	 */
	public void setProgrammeCode(String programmeCode) {
		this.programmeCode = programmeCode;
	}
	/**
	 * @return Returns the programmeName.
	 */
	public String getProgrammeName() {
		return programmeName;
	}
	/**
	 * @param programmeName The programmeName to set.
	 */
	public void setProgrammeName(String programmeName) {
		this.programmeName = programmeName;
	}
	/**
	 * @return Returns the subprogrammeCode.
	 */
	public String getSubprogrammeCode() {
		return subprogrammeCode;
	}
	/**
	 * @param subprogrammeCode The subprogrammeCode to set.
	 */
	public void setSubprogrammeCode(String subprogrammeCode) {
		this.subprogrammeCode = subprogrammeCode;
	}
	/**
	 * @return Returns the subprogrammeName.
	 */
	public String getSubprogrammeName() {
		return subprogrammeName;
	}
	/**
	 * @param subprogrammeName The subprogrammeName to set.
	 */
	public void setSubprogrammeName(String subprogrammeName) {
		this.subprogrammeName = subprogrammeName;
	}
}
