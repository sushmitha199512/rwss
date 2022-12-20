package nic.watersoft.commons;
import java.io.Serializable;

public class LabelValueBean implements Serializable
{
	private String label;
	private String value;
	private String labelValue;
	private int count;
	private String proposalId;
	private boolean tankerStatus;
	private String tlabels;
	
	public String getTlabels() {
		return tlabels;
	}
	public void setTlabels(String tlabels) {
		this.tlabels = tlabels;
	}
	/**
	 * @return Returns the label.
	 */
	public String getLabel() {
		return label;
	}
	/**
	 * @param label The label to set.
	 */
	public void setLabel(String label) {
		this.label = label;
	}
	/**
	 * @return Returns the labelValue.
	 */
	public String getLabelValue() {
		return labelValue;
	}
	/**
	 * @param labelValue The labelValue to set.
	 */
	public void setLabelValue(String labelValue) {
		this.labelValue = labelValue;
	}
	/**
	 * @return Returns the value.
	 */
	public String getValue() {
		return value;
	}
	/**
	 * @param value The value to set.
	 */
	public void setValue(String value) {
		this.value = value;
	}
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getProposalId() {
		return proposalId;
	}
	public void setProposalId(String proposalId) {
		this.proposalId = proposalId;
	}
	public boolean isTankerStatus() {
		return tankerStatus;
	}
	public void setTankerStatus(boolean tankerStatus) {
		this.tankerStatus = tankerStatus;
	}
}