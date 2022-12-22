package nic.com.webservices.dao;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class AssetDetails {
	
	private List<Asset> asset;

	public List<Asset> getAsset() {
		return asset;
	}
	
	@XmlElement
	public void setAsset(List<Asset> asset) {
		this.asset = asset;
	}
	
	
}
