package nic.watersoft.service;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "District")
public class DistrictCoverage implements Serializable {

	private static final long serialVersionUID = 1L;

	private String dcode;
	private String dname;
	private HabStatus habStatus;
	
	public DistrictCoverage(){}

	public String getDcode() {
		return dcode;
	}
	@XmlAttribute(name = "code")
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}

	public String getDname() {
		return dname;
	}
	@XmlAttribute(name = "name")
	public void setDname(String dname) {
		this.dname = dname;
	}

	public HabStatus getHabStatus() {
		return habStatus;
	}
	@XmlElement(name = "HabitationStatus")
	public void setHabStatus(HabStatus habStatus) {
		this.habStatus = habStatus;
	}
	
	
	
}
