
package nic.watersoft.contractor;
import java.util.*;
import java.text.*;


import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.validator.*;

public class Rws_Tender_Application_FormBean extends DynaValidatorForm 
{
public void reset(ActionMapping mapping,HttpServletRequest request)
{
 //System.out.println("reset method in  Rws_Tender_Application_FormBean");
 
 set("tenderIdNo","");
 set("tenderApplNo","");
 set("contractorRegNo","");
 set("preparedBy","");
 set("chequeNo","");
 set("mode","");
 set("bank","");
 set("contractorName","");
 set("contractorAdd1","");
 set("contractorAdd2","");
 set("contractorAdd3","");
 set("branch","");
 set("tenderAmount","");
 Date today = new Date();
 SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
 String datenewformat = formatter.format(today);
 set("chequeDate", datenewformat);
}
	
}
