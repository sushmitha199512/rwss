/**
 * 
 */
package nic.watersoft.reports;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

/**
 * @author RWSS_DPT3  JYOTHI G
 *
 */
public class Rws_Imis_Ids_Form  extends ActionForm
{
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private FormFile inputFile;
	public FormFile getInputFile() {
		return inputFile;
	}
	public void setInputFile(FormFile inputFile) {
		this.inputFile = inputFile;
	}
	

	
}
