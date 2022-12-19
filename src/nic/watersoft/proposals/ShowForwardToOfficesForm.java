
package nic.watersoft.proposals;
import java.util.ArrayList;



import org.apache.struts.action.ActionForm;
public class ShowForwardToOfficesForm extends ActionForm{
	
	private ArrayList  proposalForwardToList;
	private String temp1;
	private String circle;
	private String division;
	private String subDivision;
	private ArrayList paramList;
	private ArrayList divisionList;
	private ArrayList subDivisionList;
	
	public ShowForwardToOfficesForm()
	{
		proposalForwardToList=new ArrayList();
		paramList=new ArrayList();
	}
	public ProposalDTO getFORWARDTO_LIST(int index)
	{
		while(index >= proposalForwardToList.size())
		{
			proposalForwardToList.add(new ProposalDTO());
		}
		
	return (ProposalDTO)proposalForwardToList.get(index);
		
	}
	
	public ArrayList getProposalForwardToList() {
		return proposalForwardToList;
	}
	public void setProposalForwardToList(ArrayList proposalForwardToList) {
		this.proposalForwardToList = proposalForwardToList;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public ArrayList getParamList() {
		return paramList;
	}
	public void setParamList(ArrayList paramList) {
		this.paramList = paramList;
	}
	public ArrayList getDivisionList() {
		return divisionList;
	}
	public void setDivisionList(ArrayList divisionList) {
		this.divisionList = divisionList;
	}
	public ArrayList getSubDivisionList() {
		return subDivisionList;
	}
	public void setSubDivisionList(ArrayList subDivisionList) {
		this.subDivisionList = subDivisionList;
	}
	public String getCircle() {
		return circle;
	}
	public void setCircle(String circle) {
		this.circle = circle;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getSubDivision() {
		return subDivision;
	}
	public void setSubDivision(String subDivision) {
		this.subDivision = subDivision;
	}
}
