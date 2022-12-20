<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@	page import="java.sql.*, java.util.*" %>


<%!

public ArrayList getColorCodes(){

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
return colorsCodes;


}
public ArrayList getMonthCodes(){


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
return monthCodes;

}

public String getDivExpenditure(String userId,String finYear) {
	
        String syear=finYear.substring(0,4);
        String eyear=finYear.substring(5,9);
	ArrayList colorsCodes=getColorCodes();
		String strXML = "";
		//Initialize <graph> element
		strXML = "<graph caption='Monthly Expenditure' subCaption='Financial Year 2012-2013' decimals='2' decimalPrecision='2' formatNumberScale='0'  pieSliceDepth='25'  decimalPrecision='1' showNames='1' xAxisName='Month' yAxisName='Expenditure(Amount in Crores)' numberPrefix=''>";
		//Add all data

		String sq = "select distinct TO_CHAR(VOUCHER_DT,'MON') ,(sum(VOUCHER_AMT)/10000000)  from RWS_WORK_EXP_VOUCHER_TBL  where VOUCHER_DT >='01-APR-"+syear+"'  and VOUCHER_DT<'01-APR-"+eyear+"' group by TO_CHAR(VOUCHER_DT,'MON')";
		try {
			Statement stmtgraph1 = conn.createStatement();
			ResultSet rrs1 = stmtgraph1.executeQuery(sq);
			int in = 0;
			while (rrs1.next()) {
				String month = rrs1.getString(1);
				String dda = rrs1.getString(2);

				strXML = strXML + "<set name='" + month + "'  value='" + dda
						+ "' color='" + colorsCodes.get(in) + "' />";
				in++;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		strXML = strXML + "</graph>";
		//System.out.println("sss:" + strXML);
		return strXML;

	}

	/**************************************************************************************************************************************************/

	public String getDivReleases(String userId,String finYear) {

        String syear=finYear.substring(0,4);
        String eyear=finYear.substring(5,9);
		Hashtable h = new Hashtable();
		String strXML = "";
        ArrayList monthCodes=getMonthCodes();
        ArrayList colorsCodes=getColorCodes();
		//Initialize <graph> element
		strXML = "<graph caption='Monthly Releases' subCaption='Financial Year 2012-2013' showPercentageInLabel='1' pieSliceDepth='25'  decimals='2' decimalPrecision='2' formatNumberScale='0' showNames='1' xAxisName='Month' yAxisName='Releases (Amount in Crores)' numberPrefix=''>";
		//Add all data

		String sq = "select distinct TO_CHAR(bank_send_date,'MON') ,(sum(BILL_AMOUNT_CENTRAL)/10000000)  from rws_bill_bank_bridge_det_tbl where BANK_SEND_DATE >='01-APR-"+syear+"'  and BANK_SEND_DATE <'01-APR-"+eyear+"' group by TO_CHAR(bank_send_date,'MON')  order by 1";
		try {
			Statement stmtgraph = conn.createStatement();
			ResultSet rrs = stmtgraph.executeQuery(sq);
			int jj = 0;
			while (rrs.next()) {
				String month = rrs.getString(1);
				String dda = rrs.getString(2);
				h.put(month, dda);

			}

			for (int gv = 0; gv < monthCodes.size(); gv++) {
				String v = "0";
				if (h.get(monthCodes.get(gv)) != null) {
					v = (String) h.get(monthCodes.get(gv));
				}

				strXML = strXML + "<set name='" + monthCodes.get(gv)
						+ "'  value='" + v + "' color='" + colorsCodes.get(jj)
						+ "' />";
				jj++;

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		strXML = strXML + "</graph>";

		return strXML;
	}

	%>
