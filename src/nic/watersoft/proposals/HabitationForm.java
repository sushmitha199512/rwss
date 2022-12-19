package nic.watersoft.proposals;

import java.util.ArrayList;

import nic.watersoft.commons.RwsLocationBean;

import org.apache.struts.action.ActionForm;

public class HabitationForm extends ActionForm 
{
	private String mode;
	private ArrayList habCodes;
	
	public void setMode(String mode)
	{	this.mode = mode;
	}
	public String getMode()
	{	return mode;
	}

	public void setHabCodes(ArrayList habCodes)
	{	this.habCodes = habCodes;
	}
	public ArrayList getHabCodes()
	{	return habCodes;
	}
	public RwsLocationBean getHABITATIONS(int index)
	{
		while(index >= habCodes.size())
		{
			habCodes.add(new RwsLocationBean());
		}
		return (RwsLocationBean)habCodes.get(index);
	}
}
