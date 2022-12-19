
package nic.watersoft.reports;

import javax.servlet.http.HttpServletRequest;
 
import org.apache.struts.action.ActionMapping;
import org.apache.struts.validator.*;


public class rws_asset_CheckList_FormBean extends DynaValidatorForm 
{
public void reset(ActionMapping mapping,HttpServletRequest request)
{
 set("mode","data");
 
 set("pws","");
 set("mpws","");
 set("cpws","");
 set("handPump","");  
 set("shallowHandPumps","");
 set("ponds","");
 set("openWells","");
 set("dp","");
 
 set("assetCode","");
 
 set("pwsCount","");
 set("mpwsCount","");
 set("cpwsCount","");
 set("handPumpCount","");
 set("shalHpCount","");
 set("pondsCount","");
 set("wellsCount","");
 set("dpCount","");
 
 set("circleCode",""); 
 set("circleName","");
 set("divisionCode","");
 set("divisionName","");
 set("subdivisionCode","");
 set("subdivName","");
 set("districtCode","");
 set("districtName","");
 set("mandalCode","");
 set("mandalName","");
 set("panchayatCode","");
 set("panchayatName","");
 set("villageCode","");
 set("villageName","");
 set("habitationCode","");
 set("habitationName","");
 
}

}
