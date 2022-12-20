package nic.watersoft.service;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "HabitationStatus")
public class HabStatus {
	
	private long fc;
	private long pc4;
	private long pc3;
	private long pc2;
	private long pc1;
	private long nc;
	private long nss;
	
	public long getFc() {
		return fc;
	}
	@XmlAttribute//@XmlElement(name = "FullyCovered")
	public void setFc(long fc) {
		this.fc = fc;
	}
	public long getPc4() {
		return pc4;
	}
	@XmlAttribute//@XmlElement(name = "PartiallyCovered4")
	public void setPc4(long pc4) {
		this.pc4 = pc4;
	}
	public long getPc3() {
		return pc3;
	}
	@XmlAttribute//@XmlElement(name = "PartiallyCovered3")
	public void setPc3(long pc3) {
		this.pc3 = pc3;
	}
	public long getPc2() {
		return pc2;
	}
	@XmlAttribute//@XmlElement(name = "PartiallyCovered2")
	public void setPc2(long pc2) {
		this.pc2 = pc2;
	}
	public long getPc1() {
		return pc1;
	}
	@XmlAttribute//@XmlElement(name = "PartiallyCovered1")
	public void setPc1(long pc1) {
		this.pc1 = pc1;
	}
	public long getNc() {
		return nc;
	}
	@XmlAttribute//@XmlElement(name = "NotCovered")
	public void setNc(long nc) {
		this.nc = nc;
	}
	public long getNss() {
		return nss;
	}
	@XmlAttribute//@XmlElement(name = "NoSafeSource")
	public void setNss(long nss) {
		this.nss = nss;
	}
	
}
