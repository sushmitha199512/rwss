package nic.watersoft.commons;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;
import java.util.regex.Pattern;

public class ValidationUtils {

	private static final String ALPHA_WITH_BRACES = "^[a-zA-Z() ]*$";
	private static final String ALPHA_WITH_SPACE_FORMAT = "^[a-zA-Z ]*$";
	private static final String ALPHA_WITH_DOT_SPACE_FORMAT = "^[a-zA-Z. ]*$";
	private static final String ALPHA_NUM_WTH_SPACE_FORMAT = "^[a-zA-Z0-9  ]*$";
	private static final String ALPHA_NUM_FORMAT = "^[a-zA-Z0-9 ]*$";
	private static final String NUM_FORMAT = "^[0-9]*$";
	private static final String ADDRESS_FORMAT = "^[a-zA-Z0-9-.,: ;/()]*$";
	private static final String EMAIL_FORMAT = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
			+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	private static final String PHONE_NUM_FORMAT= "^[6-9][0-9]{9}$";
	private static final String DECIMAL_NUMBER="^\\d+\\.\\d{0,2}$";
	//private static final String VEHICLE_REG_NUM="^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$";
	private static final String VEHICLE_REG_NUM="^[A-Z]{2}[0-9]{2}[A-Z]{1,3}[0-9]{1,4}$";
	private static final String ALPHA_WITH_DOT_SPACE_NUM_FORMAT = "^[a-zA-Z0-9. ]*$";
	private static final String NUMBERS_SPECIAL_CHARACTERS_WITHOUT_ALPHA_FORMAT = "^[0-9&#; ]+$";
	
	
	
	public boolean teluguDataValidator(String input) {
		Pattern pattern = Pattern.compile(NUMBERS_SPECIAL_CHARACTERS_WITHOUT_ALPHA_FORMAT);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		//||input.equalsIgnoreCase(" ")
		 if(input.isEmpty()){
			return true;
		}
		 else if (!matcher.matches()) {
			return false;
		}
		return true;
	}
	
	public boolean aphaWithBracesValidator(String input) {
		Pattern pattern = Pattern.compile(ALPHA_WITH_BRACES);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}	

	
	public boolean aphaWithSpaceValidator(String input) {
		Pattern pattern = Pattern.compile(ALPHA_WITH_SPACE_FORMAT);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}
	public boolean aphaWithSpaceDotValidator(String input) {
		Pattern pattern = Pattern.compile(ALPHA_WITH_DOT_SPACE_FORMAT);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}

	public boolean aphaNumWithSpaceDotValidator(String input) {
		Pattern pattern = Pattern.compile(ALPHA_WITH_DOT_SPACE_NUM_FORMAT);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}
	public boolean numValidator(String input) {
		Pattern pattern = Pattern.compile(NUM_FORMAT);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}

	public boolean maxLenghtValidator(String input, int length) {
		if (!(input.length() == length)) {
			return false;
		}
		return true;
	}

	public boolean adressValidator(String input) {
		Pattern pattern = Pattern.compile(ADDRESS_FORMAT);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}

	public boolean emailValidator(String email) {
		String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
		Boolean b = email.matches(EMAIL_REGEX);
		if (b) {
			return true;
		} else {
			return false;
		}
	}

	public String getCSRFCode() {
		String csrfCode = "Error";
		Random rdm = new Random();
		int rl = rdm.nextInt(54545451);
		try {
			String hash1 = Integer.toHexString(rl);
			while (hash1.length() < 6) {
				rl = rdm.nextInt(54545451);
				hash1 = Integer.toHexString(rl);
			}
			csrfCode = hash1.substring(0, 6).toUpperCase();			
		} catch (Exception e) {
			System.out.println("Exception in generating getCSRFCode() "+e);
			csrfCode = "Error";
		}
		return csrfCode;
	}

	public boolean phoneValidator(String phone) {
		if (phone.matches(PHONE_NUM_FORMAT)) {
			return true;
		}
		return false;
	}

	public boolean alphaNumValidator(String input) {
		Pattern pattern = Pattern.compile(ALPHA_NUM_FORMAT);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}
	
	public boolean alphaNumWithSpaceValidator(String input) {
		Pattern pattern = Pattern.compile(ALPHA_NUM_WTH_SPACE_FORMAT);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}
	
	public boolean ValidLatitude(String lat) {
		
		double latitude=Double.valueOf(lat);
		
		if ((latitude>=-90)&&(latitude<=+90 ) ){
			return true;
		}
		return false;
	}

	public boolean ValidLongitude(String lon) {
		
		double longitude=Double.valueOf(lon);
		
		if ((longitude>=-180)&&(longitude<=+180 ) ){
			return true;
		}
		return false;
	}
	public boolean DecimalNumValidator(String input) {
		Pattern pattern = Pattern.compile(DECIMAL_NUMBER);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}
	public boolean VehicleRegNumValidator(String input) {
		Pattern pattern = Pattern.compile(VEHICLE_REG_NUM);
		java.util.regex.Matcher matcher = pattern.matcher(input);
		if (!matcher.matches()) {
			return false;
		}
		return true;
	}
	public boolean financialYearValidator(String input) {
		
		ArrayList arrayList=new ArrayList();
		
		try {
			Date sysdate = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy");
			SimpleDateFormat format1 = new SimpleDateFormat("M");
			String Year = format.format(sysdate);
			String month = format1.format(sysdate);
			
			String finYear = "";
			int cy = 0, cy1 = 0;
			
			if (Integer.parseInt(month) >= 04) {
				cy = Integer.parseInt(Year);
				cy1 = cy + 1;
				while (cy >= 2011) {
					 finYear=cy+"-"+cy1;
	
					cy = cy - 1;
					cy1 = cy + 1;
					arrayList.add(finYear);
				}
			} else if (Integer.parseInt(month) < 4) {
				cy = Integer.parseInt(Year) - 1;
				cy1 = cy + 1;
				while (cy >= 2011) {

					 finYear=cy+"-"+cy1;
					cy = cy - 1;
					cy1 = cy + 1;//System.out.println("finYear :"+finYear);
					arrayList.add(finYear);
				}
	
			}
			
			if(arrayList.contains(input)){
				return true;
			}
			else{
				return false;
			}
			
			
		}
		catch(Exception e){
			System.out.println("Exception at Financial Year checking"+e);
		}
			
		return true;
	}

}
