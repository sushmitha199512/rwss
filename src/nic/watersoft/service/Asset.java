package nic.watersoft.service;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "Asset")
public class Asset implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long cpws;
	private long pws;
	private long mpws;
	private long dp;
	private long hp;
	private long shp;
	private long ow;
	private long pond;
	
	public long getCpws() {
		return cpws;
	}
	@XmlAttribute(name="cpws")
	public void setCpws(long cpws) {
		this.cpws = cpws;
	}
	public long getPws() {
		return pws;
	}
	@XmlAttribute(name="pws")
	public void setPws(long pws) {
		this.pws = pws;
	}
	public long getMpws() {
		return mpws;
	}
	@XmlAttribute(name="mpws")
	public void setMpws(long mpws) {
		this.mpws = mpws;
	}
	public long getDp() {
		return dp;
	}
	@XmlAttribute(name="dp")
	public void setDp(long dp) {
		this.dp = dp;
	}
	public long getHp() {
		return hp;
	}
	@XmlAttribute(name="hp")
	public void setHp(long hp) {
		this.hp = hp;
	}
	public long getShp() {
		return shp;
	}
	@XmlAttribute(name="shp")
	public void setShp(long shp) {
		this.shp = shp;
	}
	public long getOw() {
		return ow;
	}
	@XmlAttribute(name="ow")
	public void setOw(long ow) {
		this.ow = ow;
	}
	public long getPond() {
		return pond;
	}
	@XmlAttribute(name="pond")
	public void setPond(long pond) {
		this.pond = pond;
	}

}
