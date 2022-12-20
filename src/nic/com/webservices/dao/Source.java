package nic.com.webservices.dao;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Source {


	private String sourceCode;

	public String getSourceCode() {
		return sourceCode;
	}
	@XmlElement
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}
	
	
	
}
