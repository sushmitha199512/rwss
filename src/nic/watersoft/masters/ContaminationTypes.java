package nic.watersoft.masters;

public class ContaminationTypes
{
	private String contType; 
	private double percent;
	
	public ContaminationTypes()
	{
		
	}
	public ContaminationTypes(String contType,double percent)
	{
		this.contType=contType;
		this.percent = percent;
	}
	public ContaminationTypes(String contType)
	{
		this.contType=contType;
	}
	
	/**
	 * @return Returns the contType.
	 */
	public String getContType() {
		return contType;
	}
	/**
	 * @param contType The contType to set.
	 */
	public void setContType(String contType) {
		this.contType = contType;
	}
	/**
	 * @return Returns the percent.
	 */
	public double getPercent() {
		return percent;
	}
	/**
	 * @param percent The percent to set.
	 */
	public void setPercent(double percent) {
		this.percent = percent;
	}
}
