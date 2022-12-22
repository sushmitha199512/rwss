package nic.watersoft.commons;

public class Mask_IP_Address {
	private static String maskString(String strText, int start, int end) throws Exception{
		String maskChar = "X";
	        if(strText == null || strText.equals(""))
	            return "";
	        
	        if(start < 0)
	            start = 0;
	        
	        if( end > strText.length() )
	            end = strText.length();
	            
	        if(start > end)
	            throw new Exception("End index cannot be greater than start index");
	        
	        int maskLength = end - start;
	        
	        if(maskLength == 0)
	        {
	        	return strText;
	        }
	        StringBuilder sbMaskString = new StringBuilder(maskLength);
	        for(int i = 0; i < maskLength; i++){
	            sbMaskString.append(maskChar);
	        }
	        
	        return strText.substring(0, start) 
	            + sbMaskString.toString() 
	            + strText.substring(start + maskLength);
	    }
	public static String FinalmaskString(String str) throws Exception{
		int firstocc = str.indexOf(".");
	    int secocc = str.indexOf(".",(firstocc+1));
	    if(firstocc>0){
		return Mask_IP_Address.maskString(Mask_IP_Address.maskString(str, firstocc+1, secocc), 0, firstocc);
	    }
	    else
	    	return Mask_IP_Address.maskString(Mask_IP_Address.maskString(str, 0, 6), 0, 6);
	    }
}