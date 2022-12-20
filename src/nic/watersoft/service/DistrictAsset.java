package nic.watersoft.service;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "District")
public class DistrictAsset implements Serializable {

	private static final long serialVersionUID = 1L;

	private String dcode;
	private String dname;
	private Asset assets;
	
	public DistrictAsset() {}
	
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
	
	public Asset getAssets() {
		return assets;
	}
	@XmlElement(name = "Asset")
	public void setAssets(Asset assets) {
		this.assets = assets;
	}
	
}
