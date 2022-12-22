<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*"%>

<% int t, j;

	int count, q, c = 0;

	String x = "", y;

	String distcode = "", distname = "", query;

	String chart1URL, imageMap1;

	String state, fromdt, todt;

	String dist[], districts[], distnames[];

	double data1[], data2[];

	int[] colors = { 0xb8bc9c, 0xa0bdc4, 0x999966, 0xc3c3e6, 0x333366 };

	int totfc = 0, totpc1 = 0, totpc2 = 0, totpc3 = 0, totpc4 = 0;
Statement stmt1=null;

  String qq="select (select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='W') a1,(select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='S') a2, (select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='C') a3,(select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='D') a4,(select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='N') a5 from dual";
	
try{
 stmt1 = conn.createStatement();
ResultSet rs55 = stmt1.executeQuery(qq);
  while(rs55.next())
{
totfc=rs55.getInt(1);	
totpc1=rs55.getInt(2);	
totpc2=rs55.getInt(3);	
totpc3=rs55.getInt(4);	
totpc4=rs55.getInt(5);	
System.out.println("Comming"+totpc4);

}

	}catch(Exception e)
{
e.printStackTrace();
}						
	%>
<style type="text/css">
   .tss1{color:navy;font-size:10pt;text-align:center;background-color:pink}
   .tss2{font-size:8pt}
   .tss3{font-size:8pt;text-align:right}
   .tr1{font-size:10pt;color:navy}
 BODY{
   scrollbar-face-color: #DBE3EA;
   scrollbar-highlight-color: #FFFFFF;
   scrollbar-shadow-color: #DEE3E7;
   scrollbar-3dlight-color: #D1D7DC;
   scrollbar-arrow-color:  #006699;
   scrollbar-track-color: #ffffff;
   scrollbar-darkshadow-color: #98AAB1;
}
</style>
<%
		try {
			response.setContentType("text/html");
		} catch (Exception e) { //System.out.println(e+"Couldn't create Pool");
		}

		x = "p";
		//System.out.println("RRRRRRRRRR"+x);
		dist = new String[7];
		count = 0;
		c = 0;
		double[] data = new double[7];
		dist[0] = "working";
		data[0] = totfc;
		dist[1] = "seasonal";
		data[1] = totpc1;
		dist[2] = "condemned";
		data[2] = totpc2;
		dist[3] = "dried";
		data[3] = totpc3;
		dist[4] = "notworking";
		data[4] = totpc4;
		count = 0;
		c = 0;

		int p = 0;

		for (count = 1; count < dist.length; count++) {
			count++;
		}

		//    //System.out.println("count=  "+count);
		for (int m = 0; m < count; m++) {
			if (data[m] != 0) {
				p++;

			}

		}
		// //System.out.println("value of c is  "+p);

		districts = new String[p];
		data1 = new double[p];

		for (int m = 0; m < count; m++) {
			if (data[m] != 0) {
				districts[c] = dist[m];
				data1[c] = data[m];
				c++;
				//		   //System.out.println("value of c is  "+c);
			}

		}
		/*for (int k=0;k<c;k++)
		 { 
		 ////System.out.println("value of c is  "+k+"  data1 value is  "+data1[k]);
		 }*/

		if (p != 0) {}%>



