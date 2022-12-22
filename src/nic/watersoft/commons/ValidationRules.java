package nic.watersoft.commons;



import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.validator.Field;
import org.apache.commons.validator.ValidatorAction;
import org.apache.commons.validator.util.ValidatorUtils;
import org.apache.struts.action.ActionErrors;


public class ValidationRules
{
	
	public static boolean validateJDate(Object bean, ValidatorAction va,
			Field field, ActionErrors errors, HttpServletRequest request)
	{
		String dateField = ValidatorUtils.getValueAsString(bean, field.getProperty());
		if(dateField == null && dateField.length() != 10)
			return false;
		
		String datePart = dateField.substring(0,2); 
		String monthPart = dateField.substring(3,2);
		String yearPart = dateField.substring(7,4);
		
		//System.out.println("datePart: " + datePart);
		//System.out.println("monthPart: " + monthPart);
		//System.out.println("yearPart: " + yearPart);
		
		GregorianCalendar gCal = new GregorianCalendar(); 
		Date userDate = gCal.getTime();
		Date currentDate = new Date();
		if(userDate.after(currentDate))
			return false;
		else
			return true;
	}
}
