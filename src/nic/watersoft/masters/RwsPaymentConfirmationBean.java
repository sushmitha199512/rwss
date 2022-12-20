package nic.watersoft.masters;

import java.io.Serializable;
import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsPaymentConfirmationBean extends ActionForm implements
		Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList filesTobeSentList;

	public ArrayList getFilesTobeSentList() {
		return filesTobeSentList;
	}

	public void setFilesTobeSentList(ArrayList filesTobeSentList) {
		this.filesTobeSentList = filesTobeSentList;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
