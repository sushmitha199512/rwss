package nic.watersoft.commons;
import java.math.BigDecimal;
import java.text.DecimalFormat;
public class IndianLakhs
{
 public static String IndianFormatLakhs(double value)
    {
        String stringValue = new Double(value).toString();
        DecimalFormat df = new DecimalFormat("0.00");
        stringValue = df.format(value);

	//System.out.println("lakh   "+stringValue);

String checkminus = stringValue.substring(0, 1);
	//System.out.println("checkminus   "+checkminus);

if(checkminus.equals("-"))
		
		{
stringValue=stringValue.substring(1, stringValue.length());
       	//System.out.println("minusString   "+stringValue);
 
        // Seperating Integral and Fractional parts
        int dotLocation = stringValue.indexOf(".");
        String integralPart = stringValue.substring(0, dotLocation);
		if (integralPart.length() > 3) {
			
		String checks = integralPart.substring(0,integralPart.length()-3);
		//System.out.println("First time"+checks);
		String check = integralPart.substring(integralPart.length()-3,integralPart.length());
		
		int check1=Integer.parseInt(check.substring(0,1));
		
		//int check2=Integer.parseInt(check.substring(2,4));
		//System.out.println("Fith Time"+check1);
		String test1="";
		int testval=0;
		if(check1>=5)
		{
			test1=checks;
			testval=(Integer.parseInt(test1));
			testval=testval+1;			
		//System.out.println("Fourth time"+testval);
		//String roundvalue = check1+"000";
		
		String finalval = (String.valueOf(testval));
				
		 //finalval = test1;
		
        String fractionalPart = stringValue.substring(dotLocation + 1);
        
        //Logic to insert comma(s)
        int i = 2;
        
        StringBuffer sb = new StringBuffer(finalval);
        sb = sb.reverse();
        if (finalval.length() >2) {
            sb.insert(i, '.');
        }



      /*  if (i < finalval.length() && finalval.length() > 4) {
			
          i = i + 4;
            sb.insert(i, ',');
        }*/
        
        sb = sb.reverse();
        finalval = sb.toString();
        
        /*if (finalval.startsWith(",")) {
            finalval = finalval.substring(1);
        }*/
        // Combining Integral and Fractional parts
		
		if(finalval.length()>2){
        stringValue = finalval  ;
		
		}else if(finalval.length()==2){
			stringValue ="."+finalval ;
		
			
		}else if(finalval.length()==1){
			stringValue ="."+"0"+finalval ;
			//System.out.println("$$$$$$$$$$$$$"+stringValue);
			
		}
		
        // Returning the result
		}else{
			String  finalval = checks;
		
        String fractionalPart = stringValue.substring(dotLocation + 1);
        
        //Logic to insert comma(s)
        int i = 2;
        
        StringBuffer sb = new StringBuffer(finalval);
        sb = sb.reverse();
		
        if (finalval.length() >2) {
            sb.insert(i, '.');
        }
        /*if (i < finalval.length() && finalval.length() > 4) {
            i = i + 4;
            sb.insert(i, ',');
        }*/
        
        sb = sb.reverse();
        finalval = sb.toString();
        
		
     /*   if (finalval.startsWith(",")) {
            finalval = finalval.substring(1);
        }*/
		
        // Combining Integral and Fractional parts
		if(finalval.length()>2){
        stringValue = finalval ;
		
		}else if(finalval.length()==2){
			stringValue ="."+finalval ;
			
		}else if(finalval.length()==1){
			stringValue ="."+"0"+finalval ;			
		}

		}}else if (integralPart.length() == 3){

			 StringBuffer sb = new StringBuffer(integralPart);
			 sb = sb.reverse();
			 int check1=Integer.parseInt(sb.substring(0,1));
			 String test1="";
				int testval=1;
			 if(check1>=5){
			String impval=String.valueOf(testval); 
			integralPart=impval;
			stringValue="."+"0"+integralPart;
			//System.out.println("-----------"+stringValue);
			 }else{
				 //eg:-0nly 3 digites values print 500 is also consider 0
				//stringValue="."+integralPart;
				stringValue="."+00;
				//System.out.println("&&&&&&&&&&First&&&&&&&&&&&"+integralPart);
				//System.out.println("^^^^^^^^^^^^^^^"+stringValue);
			 }}else{
				 int testval=0;
				 String impval=String.valueOf(testval); 
				 integralPart=impval;
				 stringValue=integralPart+".00";
				
			 }
			 stringValue="-"+stringValue;
			 
			 
			 }
			 else{

     int dotLocation = stringValue.indexOf(".");
        String integralPart = stringValue.substring(0, dotLocation);
		if (integralPart.length() > 3) {
			
		String checks = integralPart.substring(0,integralPart.length()-3);
		//System.out.println("First time"+checks);
		String check = integralPart.substring(integralPart.length()-3,integralPart.length());
		
		int check1=Integer.parseInt(check.substring(0,1));
		
		//int check2=Integer.parseInt(check.substring(2,4));
		//System.out.println("Fith Time"+check1);
		String test1="";
		int testval=0;
		if(check1>=5)
		{
			test1=checks;
			testval=(Integer.parseInt(test1));
			testval=testval+1;			
		//System.out.println("Fourth time"+testval);
		//String roundvalue = check1+"000";
		
		String finalval = (String.valueOf(testval));
				
		 //finalval = test1;
		
        String fractionalPart = stringValue.substring(dotLocation + 1);
        
        //Logic to insert comma(s)
        int i = 2;
        
        StringBuffer sb = new StringBuffer(finalval);
        sb = sb.reverse();
        if (finalval.length() >2) {
            sb.insert(i, '.');
        }



      /*  if (i < finalval.length() && finalval.length() > 4) {
			
          i = i + 4;
            sb.insert(i, ',');
        }*/
        
        sb = sb.reverse();
        finalval = sb.toString();
        
        /*if (finalval.startsWith(",")) {
            finalval = finalval.substring(1);
        }*/
        // Combining Integral and Fractional parts
		
		if(finalval.length()>2){
        stringValue = finalval  ;
		
		}else if(finalval.length()==2){
			stringValue ="."+finalval ;
		
			
		}else if(finalval.length()==1){
			stringValue ="."+"0"+finalval ;
			//System.out.println("$$$$$$$$$$$$$"+stringValue);
			
		}
		
        // Returning the result
		}else{
			String  finalval = checks;
		
        String fractionalPart = stringValue.substring(dotLocation + 1);
        
        //Logic to insert comma(s)
        int i = 2;
        
        StringBuffer sb = new StringBuffer(finalval);
        sb = sb.reverse();
		
        if (finalval.length() >2) {
            sb.insert(i, '.');
        }
        /*if (i < finalval.length() && finalval.length() > 4) {
            i = i + 4;
            sb.insert(i, ',');
        }*/
        
        sb = sb.reverse();
        finalval = sb.toString();
        
		
     /*   if (finalval.startsWith(",")) {
            finalval = finalval.substring(1);
        }*/
		
        // Combining Integral and Fractional parts
		if(finalval.length()>2){
        stringValue = finalval ;
		
		}else if(finalval.length()==2){
			stringValue ="."+finalval ;
			
		}else if(finalval.length()==1){
			stringValue ="."+"0"+finalval ;			
		}

		}}else if (integralPart.length() == 3){

			 StringBuffer sb = new StringBuffer(integralPart);
			 sb = sb.reverse();
			 int check1=Integer.parseInt(sb.substring(0,1));
			 String test1="";
				int testval=1;
			 if(check1>=5){
			String impval=String.valueOf(testval); 
			integralPart=impval;
			stringValue="."+"0"+integralPart;
			//System.out.println("-----------"+stringValue);
			 }else{
				 //eg:-0nly 3 digites values print 500 is also consider 0
				//stringValue="."+integralPart;
				stringValue="."+00;
				//System.out.println("&&&&&&&&&&First&&&&&&&&&&&"+integralPart);
				//System.out.println("^^^^^^^^^^^^^^^"+stringValue);
			 }}else{
				 int testval=0;
				 String impval=String.valueOf(testval); 
				 integralPart=impval;
				 stringValue=integralPart+".00";
				
			 }
			 }
		return stringValue;
	  }
	public static String IndianFormatLakhs(float value)
    {
		//System.out.println("VALUE:"+value);
        String stringValue = new Float(value).toString();
		int dotLocation = stringValue.indexOf(".");
        String integralPart = stringValue.substring(0, dotLocation);
        String decimalPart = stringValue.substring(dotLocation+1,stringValue.length());
		if(decimalPart.length()==1)
		{
			decimalPart+="0";
		}
		if(decimalPart.length()>2)
		{
			decimalPart=decimalPart.substring(0,2);
		}
		stringValue=integralPart+"."+decimalPart;
		
        return stringValue;
    }
	public static String getFloatValue(float f2total)
	{
		int decimalPlace = 2;
		BigDecimal bd = new BigDecimal(Float.toString(f2total));
		bd = bd.setScale(decimalPlace,BigDecimal.ROUND_HALF_UP);
		float ff = bd.floatValue();
		String kft="";
		String kt=""+ff;
		int kk1=kt.indexOf(".");
		String ffk=kt.substring(0,kk1);
		String ffkk=kt.substring(kk1+1,kt.length());
		if(ffkk.length()==1){
			String avalue=ffkk+"0";			
			kft=ffk+"."+avalue;
		
		}else{
			kft=kt;
		}
		return kft;
	}
	public static String getDoubleValue(double f2total)
	{
		Debug.println("total:"+f2total);
		String kft="";
		int decimalPlace = 2;
		BigDecimal bd = new BigDecimal(Double.toString(f2total));
		bd = bd.setScale(decimalPlace,BigDecimal.ROUND_HALF_UP);
		float ff = bd.floatValue();
		String kt=""+ff;
		int kk1=kt.indexOf(".");
		String ffk=kt.substring(0,kk1);
		String ffkk=kt.substring(kk1+1,kt.length());
		if(ffkk.length()==1){
			String avalue=ffkk+"0";			
			kft=ffk+"."+avalue;
		
		}else{			
			kft=ffk+"."+ffkk;}		
		return kft;
	}
	public static String getDoubleValue1(long f2total)
	{
		Debug.println("total:"+f2total);
		String kft="";
		int decimalPlace = 2;
		BigDecimal bd = new BigDecimal(""+f2total);
		bd = bd.setScale(decimalPlace,BigDecimal.ROUND_HALF_UP);
		long ff = bd.longValue();
		Debug.println("1:"+ff);
		String kt=""+ff;
		Debug.println("2:"+kt);
		int kk1=kt.indexOf(".");
		String ffk=kt.substring(0,kk1);
		String ffkk=kt.substring(kk1+1,kt.length());
		if(ffkk.length()==1){
			String avalue=ffkk+"0";			
			kft=ffk+"."+avalue;
		
		}else{			
			kft=ffk+"."+ffkk;}		
		return kft;
	}
	public static String getCommon(String bal1,double rbalence)
	{
		String fft = "";
		if(bal1.length() > 7){
		/*String ff = (IndianLakhs.IndianFormatLakhs(rbalence));
		int ff1=ff.indexOf(".");
		String ffk=ff.substring(0,ff1);
		String ffkk=ff.substring(ff1+1,ff.length());
		fft=ffk+ffkk;*/
		fft=IndianLakhs.IndianFormatLakhs(rbalence);
		
		}
		else{
			fft=IndianLakhs.IndianFormatLakhs(rbalence);
			
			}
		
		return fft;
	}

	public static String getAct(float ftotal){
		String kft="";
		String kt=""+ftotal;
		Debug.println("1:"+kt);
		int kk1=kt.indexOf(".");
		Debug.println("2:"+kk1);
		String ffk=kt.substring(0,kk1);
		Debug.println("3:"+ffk);
		String ffkk=kt.substring(kk1+1,kt.length());
		Debug.println("4:"+ffkk);
		if(ffkk.length()==1){
			String avalue=ffkk+"0";
			
			kft=ffk+"."+avalue;
		//System.out.println("1$$$$$$$$$$$$$$$$$$$$$$$$$"+kft);
		}else{	
			
			kft=ffk+"."+ffkk;}
		Debug.println("5:"+kft);
		return kft;
	}
	public static String getAct(double ftotal){
		String kft="";
		String kt=""+ftotal;
		Debug.println("1:"+kt);
		int kk1=kt.indexOf(".");
		Debug.println("2:"+kk1);
		String ffk=kt.substring(0,kk1);
		Debug.println("3:"+ffk);
		String ffkk=kt.substring(kk1+1,kt.length());
		Debug.println("4:"+ffkk);
		if(ffkk.length()==1){
			String avalue=ffkk+"0";
			
			kft=ffk+"."+avalue;
		//System.out.println("1$$$$$$$$$$$$$$$$$$$$$$$$$"+kft);
		}else{	
			
			kft=ffk+"."+ffkk;}
		Debug.println("5:"+kft);
		return kft;
	}
}