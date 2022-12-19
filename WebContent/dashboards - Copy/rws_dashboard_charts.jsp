<%@ include file="/reports/conn.jsp"  %>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="nic.watersoft.commons.*"  %>
<%@ page import="java.io.*,java.util.*,java.text.*" %>
<%
	ArrayList colorsCodes=new java.util.ArrayList();	
	colorsCodes.add("F6BD0F");
	colorsCodes.add("8BBA00");

	colorsCodes.add("FF8E46");
	colorsCodes.add("008E8E");
	colorsCodes.add("8E468E");
	colorsCodes.add("D64646");
	colorsCodes.add("588526");
	colorsCodes.add("B3AA00");
	colorsCodes.add("008ED6");
	colorsCodes.add("9D080D");
	colorsCodes.add("A186BE");
	colorsCodes.add("F6BD0F");


	ArrayList monthCodes =new ArrayList();
	monthCodes.add("APR");
	monthCodes.add("MAY");
	monthCodes.add("JUN");
	monthCodes.add("JUL");
	monthCodes.add("AUG");
	monthCodes.add("SEP");
	monthCodes.add("OCT");
	monthCodes.add("NOV");
	monthCodes.add("DEC");
	monthCodes.add("JAN");
	monthCodes.add("FEB");
	monthCodes.add("MAR");


String uri = (String)request.getRequestURI();
String qs = request.getQueryString();
if(qs!=null)uri += "?"+qs;

Enumeration valsNames = request.getParameterNames();
while(valsNames.hasMoreElements())
{
	String value = (String)valsNames.nextElement();
	//System.out.println(value);
		uri += "&"+value+ "=" + request.getParameter(value);

}
//System.out.println("uri:"+uri);
boolean flagChecking = false;
StringBuffer uriBuf = new StringBuffer(uri);
if(uriBuf.indexOf("script")!=-1)flagChecking = true;
if(uriBuf.indexOf("img")!=-1)flagChecking = true;
if(uriBuf.indexOf("src")!=-1)flagChecking = true;
if(uriBuf.indexOf("iframe")!=-1)flagChecking = true;
if(uriBuf.indexOf("EMBED")!=-1)flagChecking = true;
if(uriBuf.indexOf("OBJECT")!=-1)flagChecking = true;
if(uriBuf.indexOf("select")!=-1)flagChecking = true;
if(uriBuf.indexOf("delete")!=-1)flagChecking = true;
if(uriBuf.indexOf("update")!=-1)flagChecking = true;
if(uriBuf.indexOf("union")!=-1)flagChecking = true;
if(uriBuf.indexOf("NULL")!=-1)flagChecking = true;
if(uriBuf.indexOf("FROM")!=-1)flagChecking = true;
if(uriBuf.indexOf("DUAL")!=-1)flagChecking = true;



//System.out.println("flagChecking:"+flagChecking);
if(!flagChecking)
{
	final StringBuffer result = new StringBuffer();
	final StringCharacterIterator iterator = new StringCharacterIterator(uri);
	char character =  iterator.current();
	while (character != CharacterIterator.DONE ){
	 if (character == '<' || character == '>'  || character == '\\') {
		 flagChecking = true;
	  }
	  character = iterator.next();
	}
}
//System.out.println("flagChecking:"+flagChecking);
if(flagChecking){
try{response.sendRedirect("/pred/pred_mal_page.jsp");}catch(Exception e){}
} 
%>
<%
	String strXML = "";

  String type=request.getParameter("type");
  String finYear=request.getParameter("finyear");
  String userId=request.getParameter("userid");
 // System.out.println("ddd3333:"+userId+"---type="+type);
   String syear=finYear.substring(0,4);
        String eyear=finYear.substring(5,9);
	Hashtable h = new Hashtable();
	Hashtable h1 = new Hashtable();
//System.out.println("ddd:"+userId);
String userQuery="";

  if(userId!=null && !userId.equals("admin") &&  !userId.equals("100000") &&  !userId.equals("1000DR") &&   !userId.equals("guest")  &&   !userId.equals("ENC") &&   !userId.equals("secrwss") &&   !userId.equals("EE-Budget") &&   !userId.equals("minrwss") ){
      
if(!userId.substring(3,6).equals("000")){
   		userQuery="and substr(b.office_code,2,2)='"+userId.substring(1,3)+"' and  substr(b.office_code,4,1)='"+userId.substring(3,4)+"'  ";
}else {
userQuery="and substr(b.office_code,2,2)='"+userId.substring(1,3)+"'";
}
 }
  if(userId.substring(0,3).equals("col")){
	  userQuery="and substr(b.office_code,2,2)='"+(String)session.getAttribute("district")+"'";
  }
   if(type!=null && type.equals("relDiv")){
	  	
	
     
		//Initialize <graph> element
		strXML = "<graph caption='Monthly Releases(Bank+PAO)'  subCaption='Financial Year"+finYear+"' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='Month' yAxisName='Releases (Amount in Crores)' numberPrefix=''>";
		//Add all data
         

		String sq = "select distinct TO_CHAR(bank_send_date,'MON') ,(sum(BILL_AMOUNT_CENTRAL)/10000000)  from rws_bill_bank_bridge_det_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id "+userQuery+"  and BANK_SEND_DATE >='01-APR-"+syear+"'  and BANK_SEND_DATE <'01-APR-"+eyear+"' ";
		if(userId.substring(0,3).equals("col")){
			  sq+="and substr(b.work_id,5,2)='"+(String)session.getAttribute("district")+"'";
		  }
		sq+=" group by TO_CHAR(bank_send_date,'MON')  order by 1";
		//System.out.println("qqq:"+sq);
        try {
			Statement stmtgraph = conn.createStatement();
			ResultSet rrs = stmtgraph.executeQuery(sq);
			int jj = 0;
			while (rrs.next()) {
				String month = rrs.getString(1);
				String dda = rrs.getString(2);
				h.put(month, dda);

			}

String sq1 = "select distinct TO_CHAR(STATE_SEND_DATE,'MON') ,(sum(BILL_AMOUT_STATE)/10000000)  from rws_bill_pao_bridge_det_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id "+userQuery+"  and  STATE_SEND_DATE >='01-APR-"+syear+"'  and STATE_SEND_DATE <'01-APR-"+eyear+"' ";
if(userId.substring(0,3).equals("col")){
	  sq1+="and substr(b.work_id,5,2)='"+(String)session.getAttribute("district")+"'";
}
sq1+=" group by TO_CHAR(STATE_SEND_DATE,'MON')  order by 1";

//System.out.println("Pao:"+sq1);
Statement stmtgraph1= conn.createStatement();
			ResultSet rrs1 = stmtgraph1.executeQuery(sq1);
			while (rrs1.next()) {
				String month = rrs1.getString(1);
				String dda = rrs1.getString(2);
				h1.put(month, dda);

			}

			for (int gv = 0; gv < monthCodes.size(); gv++) {
				String v = "0",v1="0"; double  tv=0.0;
				if (h.get(monthCodes.get(gv)) != null) {
					v = (String) h.get(monthCodes.get(gv));
                     tv=Double.parseDouble(v);
				}
			if (h1.get(monthCodes.get(gv)) != null) {
					v1 = (String) h1.get(monthCodes.get(gv));
                                          tv+=Double.parseDouble(v1);
				}
               
				strXML = strXML + "<set name='" + monthCodes.get(gv)
						+ "'  value='" + tv + "' color='" + colorsCodes.get(jj)
						+ "' />";
				jj++;

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		strXML = strXML + "</graph>";
		//System.out.println("data:"+strXML);
	
	 
%>
<%= strXML %>

<% }  else if(type!=null && type.equals("expDiv")){ 
       
	  
      
		
		//Initialize <graph> element
		strXML = "<graph caption='Monthly Expenditure' subCaption='Financial Year"+finYear+"'   decimals='2' decimalPrecision='2' formatNumberScale='0'  pieSliceDepth='25'  decimalPrecision='1' showNames='1' xAxisName='Month' yAxisName='Expenditure(Amount in Crores)' numberPrefix=''>";
		//Add all data

		String sq = "select distinct TO_CHAR(VOUCHER_DT,'MON') ,(sum(VOUCHER_AMT)/10000000)  from RWS_WORK_EXP_VOUCHER_TBL a, rws_work_admn_tbl b  where a.work_id=b.work_id   "+userQuery+"  and   VOUCHER_DT >='01-APR-"+syear+"'  and VOUCHER_DT<'01-APR-"+eyear+"' ";
		if(userId.substring(0,3).equals("col")){
			  sq+="and substr(b.work_id,5,2)='"+(String)session.getAttribute("district")+"'";
		  }
		sq+=" group by TO_CHAR(VOUCHER_DT,'MON')";
		//System.out.println("qqq:"+sq);
		try {
			Statement stmtgraph1 = conn.createStatement();
			ResultSet rrs1 = stmtgraph1.executeQuery(sq);
			int in = 0;	int jj = 0;
			while (rrs1.next()) {
				String month = rrs1.getString(1);
				String dda = rrs1.getString(2);
				h.put(month, dda);

			}

			for (int gv = 0; gv < monthCodes.size(); gv++) {
				String v = "0";
				if (h.get(monthCodes.get(gv)) != null) {
					v = (String) h.get(monthCodes.get(gv));
				}
				if(v!=null && !v.equals("0")){
				strXML = strXML + "<set name='" + monthCodes.get(gv)
						+ "'  value='" + v + "' color='" + colorsCodes.get(jj)
						+ "' />";
					}
				jj++;

			}


		} catch (Exception e) {
			e.printStackTrace();
		}

		strXML = strXML + "</graph>";
		%>
<%=strXML  %>

<% } else if(type!=null && type.equals("asset")){  

		//Initialize <graph> element
		strXML = "<graph caption='Asset Types' subCaption=''  showPercentageInLabel='1' pieSliceDepth='25'  decimals='0' decimalPrecision='0' formatNumberScale='0' showNames='1' xAxisName='Asset Types' yAxisName='No Of Assets' numberPrefix=''>";
		//Add all data
         

		String sq = "select count(*),type_of_asset_name,b.type_of_asset_code from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s,RWS_COMPLETE_HAB_VIEW  b where a.hab_code=b.panch_code and  a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code not in('08','11','12') ";
		if(userId.substring(0,3).equals("col")){
			  sq+="and substr(a.hab_code,1,2)='"+(String)session.getAttribute("district")+"'";
		  }
		sq+=" group by b.type_of_asset_code,type_of_asset_name  order by b.type_of_asset_code";
		//System.out.println("asset:"+sq);
        try {
			Statement stmtgraph = conn.createStatement();
			ResultSet rrs = stmtgraph.executeQuery(sq);
			int jj = 0;
			while (rrs.next()) {
                   String atype=""; 
                       if(rrs.getString(2).equals("HANDPUMPS"))
			{
		atype="HP";
}else if(rrs.getString(2).equals("SHALLOW HAND PUMPS"))
{
atype="SHP";
}
else if(rrs.getString(2).equals("DIRECT PUMPING"))
{
atype="DP";
}
else if(rrs.getString(2).equals("OPEN WELLS"))
{
atype="OW";
}else{
       atype=rrs.getString(2);
}
				strXML = strXML + "<set name='" + atype
						+ "'  value='" + rrs.getString(1) + "' color='" + colorsCodes.get(jj)
						+ "' />";
jj++;

			}
              
				
	} catch (Exception e) {
			e.printStackTrace();
		}

		strXML = strXML + "</graph>";

%>
<%= strXML%>
<% }  else if(type!=null && type.equals("test")){  

			String[][] arrData = new String[6][3];
			    		//Store Name of Products
			    		arrData[0][0] = "Product A";
			        	arrData[1][0] = "Product B";
			        	arrData[2][0] = "Product C";
			        	arrData[3][0] = "Product D";
			        	arrData[4][0] = "Product E";
			        	arrData[5][0] = "Product F";
			        	
			        	//Store sales data
			        	arrData[0][1] = "567500";
			        	arrData[1][1] = "815300";
			        	arrData[2][1] = "556800";
			        	arrData[3][1]= "734500";
			        	arrData[4][1] = "676800";
		        		arrData[5][1] = "648500";
			
						//Store sales data for previous year
						arrData[0][2]= "547300";
						arrData[1][2] = "584500";
						arrData[2][2]= "754000";
						arrData[3][2]= "456300";
						arrData[4][2]= "754500";
						arrData[5][2]= "437600";
		
					 strXML = "<graph caption='Sales by Product' numberPrefix='$' formatNumberScale='1' decimalPrecision='0' >";
			    	
			    	//Initialize <categories> element - necessary to generate a multi-series chart
			    	String strCategories = "<categories>";
			    	
			    	//Initiate <dataset> elements
			    	String strDataCurr = "<dataset seriesName='Current Year' color='AFD8F8'>";
			    	String strDataPrev = "<dataset seriesName='Previous Year' color='F6BD0F'>";
			    	
			    	//Iterate through the data	
			    	for(int i=0;i<arrData.length;i++){
			    		//Append <category name='...' /> to strCategories
			    		strCategories = strCategories + "<category name='" + arrData[i][0] + "' />";
			    		//Add <set value='...' /> to both the datasets
			    		strDataCurr = strDataCurr + "<set value='" + arrData[i][1] + "' />";
			    		strDataPrev = strDataPrev + "<set value='" + arrData[i][2] + "' />";	
			    	}
			    	
			    	//Close <categories> element
			    	strCategories = strCategories + "</categories>";
			    	
			    	//Close <dataset> elements
			    	strDataCurr = strDataCurr + "</dataset>";
			    	strDataPrev = strDataPrev + "</dataset>";
			    	
			    	//Assemble the entire XML now
		    		strXML = strXML + strCategories + strDataCurr + strDataPrev + "</graph>";

%>
<%= strXML%>
<% }  %>



