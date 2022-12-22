<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%
Statement stmt1=null,stmt2=null,stmt4=null,stmt5=null,stmt6=null,stmt3=null,stmt8=null,stmt9=null,stmt10=null,stmt7=null;
ResultSet rs1=null,rs2=null,rs22=null,rs8=null,rs7=null,rs6=null,rs3=null,rs10=null,rs11=null,rs12=null,rs5=null,rs4=null,rs9=null;


StringBuffer attend=new StringBuffer();


//String fromdate=request.getParameter("fromDate");
StringBuffer fromdate=new StringBuffer();
fromdate.append(request.getParameter("fromDate"));


//String todate=request.getParameter("toDate");
StringBuffer todate=new StringBuffer();
todate.append(request.getParameter("toDate"));

DecimalFormat ndf = new DecimalFormat("######.##");
	
Format formatter;

int day=Integer.parseInt(fromdate.toString().substring(0,2));
int month=Integer.parseInt(fromdate.toString().substring(3,5));
int year=Integer.parseInt(fromdate.toString().substring(6,10));

int day1=Integer.parseInt(todate.toString().substring(0,2));
int month1=Integer.parseInt(todate.toString().substring(3,5));
int year1=Integer.parseInt(todate.toString().substring(6,10));


java.util.Date date = new java.util.Date(year-1900,month-1,day);
java.util.Date date1 = new java.util.Date(year1-1900,month1-1,day1);
formatter = new SimpleDateFormat("dd/MMM/yyyy");

//fromdate=fromdate.replace("/","-");
//////System.out.println("f1*************"+fromdate);

		
	
	//todate=todate.replace("/","-");
fromdate.delete(0,fromdate.length());
fromdate.append(formatter.format(date));

todate.delete(0,todate.length());
todate.append(formatter.format(date1));

//////System.out.println("f1*************"+fromdate);
//////System.out.println("f1*************"+todate);
//


//String dcode=request.getParameter("district");
StringBuffer dcode=new StringBuffer();
dcode.append(request.getParameter("district"));

int sno=1;
int gthcount=0;
float gthamount=0;
int ghcount=0;
int ghsources=0;
float ghamount=0;

int gbthcount=0;
int gbthsourcess=0;
float gbtamount=0;
float gbhamount=0;
int gdcount=0;
int gfcount=0;
float gdamount=0;
float gfamount=0;


%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
				
			
			</tr>  
		</table>
	</caption>
	

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> <font color="red"><b>Amount in Rs. lakhs</b></font></td>
</tr>




	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Abstract Stressed/Scarcity Habitations(Contingency plan)</td>
</tr>
<tr bgcolor="" align="center">
		<td align="center" class="rptHeading" colspan="14">FromDate:<font color="red"><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;ToDate:<font color="red"><%=todate%></font></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext rowspan=2>Sl.No</td>
               <td class=btext rowspan=2>District</td>
               <td class=btext rowspan=2>No. of Drought Habitations</td>
			 <td class=btext rowspan=2>Total Amount(In Lakhs)</td>
              <td class=btext  colspan=2> Only Transportation Habs</td> 
			   <td class=btext colspan=3> Only Hiring Habs</td> 
			   <td class=btext  colspan=4 nowrap>Both Transportation & Hiring Habs</td>
			   <td class=btext  colspan= 2 nowrap>Only Deepening Habitations</td>
	           <td class=btext colspan = 2 nowrap>Only Flushing Habs</td>
               <td class=btext colspan = 2 nowrap>Only Power Habs</td>
               <td class=btext colspan = 2 nowrap>Combination Habs</td>
               
	
	</tr> <tr>
	           <td class=btext >Habs No</td>
               <td class=btext >Amount</td>
               <td class=btext >Habs No</td>
               <td class=btext >No Of Sources</td>
               <td class=btext >Amount</td>
               <td class=btext >Habs No</td>
               <td class=btext >No Of Sources</td>
               <td class=btext >Trans Amount</td>
               <td class=btext >Hiring Amount</td>
	           <td class=btext >Habs No</td>
               <td class=btext >Amount</td>
	           <td class=btext >Habs No</td>
               <td class=btext >Amount</td>
				<td class=btext >Habs No</td>
               <td class=btext >Amount</td>
				<td class=btext >Habs No</td>
               <td class=btext >Amount</td>

			   
	</tr>
    
<% 
StringBuffer query= new StringBuffer();
StringBuffer thabs =new StringBuffer();  
StringBuffer tvalues =new StringBuffer(); 
StringBuffer hvalues =new StringBuffer();
StringBuffer bthvalues =new StringBuffer();
StringBuffer dvalues =new StringBuffer();
StringBuffer fvalues =new StringBuffer();
StringBuffer power =new StringBuffer();

StringBuffer qq=new StringBuffer();

try
{

	Hashtable onlyTransportH=new Hashtable();
	Hashtable onlyHiringH=new Hashtable();
	Hashtable bothTransHiringH=new Hashtable();
	Hashtable onlyDeepeningH=new Hashtable();
	Hashtable onlyFlushningH=new Hashtable();
	Hashtable totalHabs=new Hashtable();
	Hashtable onlyPower=new Hashtable();

	
//	////System.out.println("dcode"+dcode.toString());
	
	
   // String query = "";

    
	 if(dcode.toString()!=null && !dcode.toString().equals("") && dcode.toString().equals("51"))
		{
	  query.append("select  d.dcode,d.dname from rws_district_tbl d where d.dcode<>'16'  order by d.dname");
	  }
	else if(dcode.toString()!=null && !dcode.toString().equals("") && !dcode.toString().equals("51"))
	{
	  query.append("select  dcode,dname from rws_district_tbl where dcode='"+dcode.toString()+"'");
	  }else {
	  query.append("select  dcode,dname from rws_district_tbl");
	  }
	 
	 
//attend.append("");
 
  stmt1=conn.createStatement();
  stmt2=conn.createStatement();
  stmt3=conn.createStatement();
  stmt4=conn.createStatement();
  stmt5=conn.createStatement();
  stmt6=conn.createStatement();
  stmt7=conn.createStatement();
  stmt8=conn.createStatement();
  stmt9=conn.createStatement();
  stmt10=conn.createStatement();

   
  rs1=stmt1.executeQuery(query.toString());
  
  
  while (rs1.next())
	{
	  query.delete(0,query.length());
//String q10="select count(*),nvl(sum(TRANSPORT_EST),0),nvl(sum(HIRING_EST),0),nvl(sum(DEEPENING_EST),0),nvl(sum(FLUSHING_EST),0),nvl(sum(POWER_EST),0) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and to_date(FRM_DATE) >= '"+fromdate+"' and (to_date(FRM_DATE) <='"+todate+"')" ;
 query.append("select count(*),nvl(sum(TRANSPORT_EST),0),nvl(sum(HIRING_EST),0),nvl(sum(DEEPENING_EST),0),nvl(sum(FLUSHING_EST),0),nvl(sum(POWER_EST),0) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and to_date(FRM_DATE) >= '"+fromdate+"' and (to_date(FRM_DATE) <='"+todate+"')" );
	//////System.out.println("Query10:"+q10);		
//rs9=stmt9.executeQuery(q10);
rs9=stmt9.executeQuery(query.toString());
            while(rs9.next())
            {
              totalHabs.put(rs1.getString(1),rs9.getString(1)+"@"+rs9.getString(2)+"@"+rs9.getString(3)+"@"+rs9.getString(4)+"@"+rs9.getString(5)+"@"+rs9.getString(6));
           }
	
            
            
            
            
            query.delete(0,query.length());
  //String q1="select count(*),sum(nvl(TRANSPORT_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='Y' and (FLUSHING is NULL or FLUSHING='0')  and (DEEPENING is NULL or DEEPENING='0')  and (HIRING_OF_SOURCES is NULL or HIRING_OF_SOURCES='0')  and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"'  and to_date(FRM_DATE) <='"+todate+"'";
	query.append("select count(*),sum(nvl(TRANSPORT_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='Y' and (FLUSHING is NULL or FLUSHING='0')  and (DEEPENING is NULL or DEEPENING='0')  and (HIRING_OF_SOURCES is NULL or HIRING_OF_SOURCES='0')  and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"'  and to_date(FRM_DATE) <='"+todate+"'");
		//rs3=stmt2.executeQuery(q1);
		rs3=stmt2.executeQuery(query.toString());
            while(rs3.next())
            {
              onlyTransportH.put(rs1.getString(1),rs3.getString(1)+"@"+rs3.getString(2));
           }
	//	  ////System.out.println("Q1:"+query.toString());
		
		  
		  
		  
		  
		 query.delete(0,query.length());  
//String q2="select count(*),sum(nvl(HIRING_OF_SOURCES,0)),sum(nvl(HIRING_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='N' and (FLUSHING is NULL or FLUSHING='0')  and (DEEPENING is NULL or DEEPENING='0')  and (HIRING_OF_SOURCES is not NULL and  HIRING_OF_SOURCES>'0') and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'";
query.append("select count(*),sum(nvl(HIRING_OF_SOURCES,0)),sum(nvl(HIRING_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='N' and (FLUSHING is NULL or FLUSHING='0')  and (DEEPENING is NULL or DEEPENING='0')  and (HIRING_OF_SOURCES is not NULL and  HIRING_OF_SOURCES>'0') and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'");		
		//rs4=stmt3.executeQuery(q2);
		rs4=stmt3.executeQuery(query.toString());
//		 ////System.out.println("Q2:"+query.toString());
            while(rs4.next())
            {
              onlyHiringH.put(rs1.getString(1),rs4.getString(1)+"@"+rs4.getString(2)+"@"+rs4.getString(3));
           }
			
            
            
            
            query.delete(0,query.length());       
 //String q3="select count(*),sum(nvl(HIRING_OF_SOURCES,0)),sum(nvl(TRANSPORT_EST,0)),sum(nvl(HIRING_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='Y' and (FLUSHING is NULL or FLUSHING='0') and (DEEPENING is NULL or DEEPENING='0') and (HIRING_OF_SOURCES is not NULL and HIRING_OF_SOURCES >'0') and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'";
query.append("select count(*),sum(nvl(HIRING_OF_SOURCES,0)),sum(nvl(TRANSPORT_EST,0)),sum(nvl(HIRING_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='Y' and (FLUSHING is NULL or FLUSHING='0') and (DEEPENING is NULL or DEEPENING='0') and (HIRING_OF_SOURCES is not NULL and HIRING_OF_SOURCES >'0') and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'");
 //   ////System.out.println("Q3:"+query.toString());
	//	rs5=stmt4.executeQuery(q3);
	rs5=stmt4.executeQuery(query.toString());
            while(rs5.next())
            {
              bothTransHiringH.put(rs1.getString(1),rs5.getString(1)+"@"+rs5.getString(2)+"@"+rs5.getString(3)+"@"+rs5.getString(2));
           }

           
            
            
           
            query.delete(0,query.length()); 
//String q4="select count(*),sum(nvl(DEEPENING_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='N' and (FLUSHING is NULL or FLUSHING='0') and (DEEPENING is not NULL and DEEPENING>'0') and (HIRING_OF_SOURCES is NULL or HIRING_OF_SOURCES='0') and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'";
query.append("select count(*),sum(nvl(DEEPENING_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='N' and (FLUSHING is NULL or FLUSHING='0') and (DEEPENING is not NULL and DEEPENING>'0') and (HIRING_OF_SOURCES is NULL or HIRING_OF_SOURCES='0') and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'");

// ////System.out.println("Q4:"+q4);
		//rs6=stmt5.executeQuery(q4);
		rs6=stmt5.executeQuery(query.toString());
            while(rs6.next())
            {
              onlyDeepeningH.put(rs1.getString(1),rs6.getString(1)+"@"+rs6.getString(2));
           }
            
            
            
            
            
            
            
            query.delete(0,query.length());
 //String q5="select count(*),sum(nvl(FLUSHING_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='N' and (FLUSHING is not NULL and FLUSHING>'0') and (DEEPENING is NULL or DEEPENING='0') and (HIRING_OF_SOURCES is NULL or HIRING_OF_SOURCES='0') and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'";
query.append("select count(*),sum(nvl(FLUSHING_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='N' and (FLUSHING is not NULL and FLUSHING>'0') and (DEEPENING is NULL or DEEPENING='0') and (HIRING_OF_SOURCES is NULL or HIRING_OF_SOURCES='0') and POWER_PROBLEM='N' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'");	
 // ////System.out.println("Q5:"+q5);
		//rs7=stmt6.executeQuery(q5);
		rs7=stmt6.executeQuery(query.toString());
            while(rs7.next())
            {
              onlyFlushningH.put(rs1.getString(1),rs7.getString(1)+"@"+rs7.getString(2));
           }
	
            
            
            
            
            

//power problem
       query.delete(0,query.length());
//String q6="select count(*),sum(nvl(POWER_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='N' and (FLUSHING is NULL or FLUSHING='0')  and (DEEPENING is NULL or DEEPENING='0') and (HIRING_OF_SOURCES is NULL or HIRING_OF_SOURCES='0') and POWER_PROBLEM='Y' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'";
query.append("select count(*),sum(nvl(POWER_EST,0)) from RWS_DROUGHT_HABITATION_TBL where   substr(habcode,1,2)='"+rs1.getString(1)+"' and TRANSPORTATION ='N' and (FLUSHING is NULL or FLUSHING='0')  and (DEEPENING is NULL or DEEPENING='0') and (HIRING_OF_SOURCES is NULL or HIRING_OF_SOURCES='0') and POWER_PROBLEM='Y' and  to_date(FRM_DATE) >= '"+fromdate+"' and to_date(FRM_DATE) <='"+todate+"'");
//////System.out.println("Q5:"+q6);
		//rs22=stmt10.executeQuery(q6);
		rs22=stmt10.executeQuery(query.toString());
            while(rs22.next())
            {
              onlyPower.put(rs1.getString(1),rs22.getString(1)+"@"+rs22.getString(2));
           }
	


	   
		   
} //END loop for districts
int habsTotal=0,combHabs=0;






//String qq=null;

query.delete(0,query.length());
if(dcode.toString()!=null && !dcode.toString().equals("") && !dcode.toString().equals("51"))
{
 qq.append("select  dcode,dname from rws_district_tbl where dcode='"+dcode+"'");
}else{
 qq.append("select  d.dcode,d.dname from rws_district_tbl d where d.dcode<>'16'  order by d.dname");
}
    double habsAmountTotal=0,habsAmountTotal1=0;double powerAmnt=0,combHabAMount=0,remtot=0,remtot1=0,tot1=0.0;
 int powerTotHabs=0;int tothabs=0;
//	////System.out.println("MM:"+qq);
	
	rs8=stmt7.executeQuery(qq.toString());
	

	String tot[]=null;
	while(rs8.next())
            {
			
		//////System.out.println("while start");
            	
			//String thabs=(String)totalHabs.get(rs8.getString(1));
			thabs.delete(0,thabs.length());
			thabs.append(totalHabs.get(rs8.getString(1)));
        				
			//String tot[]=thabs.split("@");
			if(thabs!=null){
			 tot=thabs.toString().split("@");
            }
			
					
			
			
			
   //////System.out.println("Dname"+rs8.getString(2));
			///////System.out.println("Deee"+tot.length );
			
		tothabs=Integer.parseInt(tot[0]);
			habsTotal+=Integer.parseInt(tot[0]);
habsAmountTotal1=Double.parseDouble(tot[1])+Double.parseDouble(tot[2])+Double.parseDouble(tot[3])+Double.parseDouble(tot[4])+Double.parseDouble(tot[5]);
			
   
habsAmountTotal+=habsAmountTotal1;

//////System.out.println("Deeeeeeeeeeeeeeeeeeeeeeeeeee");
			//String tvalues=(String)onlyTransportH.get(rs8.getString(1));
			tvalues.delete(0,tvalues.length());
			tvalues.append(onlyTransportH.get(rs8.getString(1)));
			
			
			//String v1[]=tvalues.split("@");
			String v1[]=tvalues.toString().split("@");
			
			
           combHabs+=Integer.parseInt(v1[0]);
			gthcount+=Integer.parseInt(v1[0]);
			if(!v1[1].equals("null"))
			{ 
			 gthamount+=Float.parseFloat(v1[1]);
                   
     combHabAMount+=Float.parseFloat(v1[1]);
                
			}
			
			hvalues.delete(0,hvalues.length());
			//String hvalues=(String)onlyHiringH.get(rs8.getString(1));
			hvalues.append(onlyHiringH.get(rs8.getString(1)));
			
			//String v2[]=hvalues.split("@");
			String v2[]=hvalues.toString().split("@");
			
combHabs+=Integer.parseInt(v2[0]);
			ghcount+=Integer.parseInt(v2[0]);
			if(!v2[1].equals("null"))
			{ 
			 ghsources+=Float.parseFloat(v2[1]);

			}
			if(!v2[2].equals("null"))
			{ 
			 ghamount+=Float.parseFloat(v2[2]);
combHabAMount+=Float.parseFloat(v2[2]);
			}
			
			bthvalues.delete(0,bthvalues.length());
			//String bthvalues=(String)bothTransHiringH.get(rs8.getString(1));
			
			bthvalues.append(bothTransHiringH.get(rs8.getString(1)));
			
			//String v3[]=bthvalues.split("@");
			String v3[]=bthvalues.toString().split("@");
			
			combHabs+=Integer.parseInt(v3[0]);
			 gbthcount+=Integer.parseInt(v3[0]);
			 if(!v3[1].equals("null"))
			{ 
			 gbthsourcess+=Float.parseFloat(v3[1]);
			}
			if(!v3[2].equals("null"))
			{ 
			 gbtamount+=Float.parseFloat(v3[2]);
 combHabAMount+=Float.parseFloat(v3[2]);
			}
			if(!v3[3].equals("null"))
			{ 
			 gbhamount+=Float.parseFloat(v3[3]);
 combHabAMount+=Float.parseFloat(v3[3]);
			}
			

			dvalues.delete(0,dvalues.length());
			//String dvalues=(String)onlyDeepeningH.get(rs8.getString(1));
			dvalues.append(onlyDeepeningH.get(rs8.getString(1)));
			//String v4[]=dvalues.split("@");
			String v4[]=dvalues.toString().split("@");
combHabs+=Integer.parseInt(v4[0]);
			 gdcount+=Integer.parseInt(v4[0]);
			 if(!v4[1].equals("null"))
			{ 
			 gdamount+=Float.parseFloat(v4[1]);
  combHabAMount+=Float.parseFloat(v4[1]);
			}
			
			 
			 
			 
			 fvalues.delete(0,fvalues.length());
			//String fvalues=(String)onlyFlushningH.get(rs8.getString(1));
			fvalues.append(onlyFlushningH.get(rs8.getString(1)));
			//String v5[]=fvalues.split("@");
			String v5[]=fvalues.toString().split("@");
combHabs+=Integer.parseInt(v5[0]);
			 gfcount+=Integer.parseInt(v5[0]);
			if(!v5[1].equals("null"))
			{ 
			 gfamount+=Float.parseFloat(v5[1]);
		combHabAMount+=Float.parseFloat(v5[1]);
			}

			power.delete(0,power.length());
//String power=(String)onlyPower.get(rs8.getString(1));
power.append(onlyPower.get(rs8.getString(1)));
			//String v6[]=power.split("@");
			String v6[]=power.toString().split("@");
combHabs+=Integer.parseInt(v6[0]);
 if(!v6[1].equals("null"))
			{ 
			 powerAmnt+=Float.parseFloat(v6[1]);     
    combHabAMount+=Float.parseFloat(v6[1]);
			}
 if(!v6[0].equals("null"))
			{ 
			 powerTotHabs+=Integer.parseInt(v6[0]);
			}

 //////System.out.println("Total"+tothabs);
 //////System.out.println("Total"+combHabs);

remtot+=tothabs-combHabs;
remtot1+=habsAmountTotal1-combHabAMount;
 

		%>
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue NOWRAP><%=rs8.getString(2)%></td>
				<td class=rptValue NOWRAP><%=tot[0].toString() %></td>
				<td class=rptValue NOWRAP><%=ndf.format(habsAmountTotal1) %></td>
				<td class=rptValue NOWRAP><%=v1[0].toString() %></td>
				<td class=rptValue NOWRAP><%=v1[1].toString().equals("null")?"0.0":v1[1].toString() %></td>
                <td class=rptValue NOWRAP><%=v2[0].toString() %></td>
                <td class=rptValue NOWRAP><%=v2[1].toString().equals("null")?"0":v2[1].toString()  %></td>
				<td class=rptValue NOWRAP><%=v2[2].toString().equals("null")?"0.0":v2[2].toString() %></td>
				<td class=rptValue NOWRAP><%=v3[0].toString() %></td>
                <td class=rptValue NOWRAP><%=v3[1].toString().equals("null")?"0":v3[1].toString()  %></td>
                <td class=rptValue NOWRAP><%=v3[2].toString().equals("null")?"0.0":v3[2].toString()  %></td>
				<td class=rptValue NOWRAP><%=v3[3].toString().equals("null")?"0.0":v3[3].toString()  %></td>
				<td class=rptValue NOWRAP><%=v4[0].toString() %></td>
                <td class=rptValue NOWRAP><%=v4[1].toString().equals("null")?"0.0":v4[1].toString()  %></td>
				<td class=rptValue NOWRAP><%=v5[0].toString() %></td>
                <td class=rptValue NOWRAP><%=v5[1].toString().equals("null")?"0.0":v5[1].toString()  %></td>
				
				<td class=rptValue NOWRAP><%=v6[0].toString() %></td>
                <td class=rptValue NOWRAP><%=v6[1].toString().equals("null")?"0.0":v6[1].toString()  %></td>
				
				<td class=rptValue NOWRAP><%=tothabs-combHabs %></td>
                <td class=rptValue NOWRAP><%=ndf.format(habsAmountTotal1-combHabAMount) %></td>
				
				
		
			
				</tr>
<%	
combHabs=0;
combHabAMount=0;
tothabs=0;

habsAmountTotal1=0;		
}
	%>
	<tr>
	 <td class="btext" colspan="2">Total:</td>
       <td class="btext" ><%=habsTotal%></td> 
<td class="btext" ><%=ndf.format(habsAmountTotal) %></td>  
  	  <td class="btext" ><%=gthcount%></td>	
	  <td class="btext" ><%=ndf.format(gthamount) %></td>



	  <td class="btext" ><%=ghcount %></td>  
	  <td class="btext" ><%=ghsources %></td>
	  <td class="btext" ><%=ndf.format(ghamount) %></td>
       <td class="btext" ><%=gbthcount %></td>
	
	  <td class="btext" ><%=gbthsourcess %></td>
      <td class="btext" ><%=ndf.format(gbtamount) %></td>
      <td class="btext" ><%=ndf.format(gbhamount) %></td>
     <td class="btext" ><%=gdcount %></td>
     <td class="btext" ><%=ndf.format(gdamount) %></td>
	 <td class="btext" ><%=gfcount %></td>
	<td class="btext" ><%=ndf.format(gfamount) %></td>
	<td  class="btext"><%=powerTotHabs %></td>
<td class="btext"><%=ndf.format(powerAmnt) %></td>
 <TD class="btext" ><%=ndf.format(remtot)  %></TD> 
 <TD class="btext" ><%=ndf.format(remtot1) %></TD>
	 	</tr>
	<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	  attend=null;
	  fromdate=null;
	  todate=null;
	  dcode=null;
	  query= null;
	  thabs =null; 
	  tvalues =null;
	  hvalues =null;
	  bthvalues =null;
	  dvalues =null;
	  fvalues =null;
	  power =null;

	try
	{
		if(rs1 != null )
		{
			rs1.close();
		}
		if(stmt1 != null )
		{
			stmt1.close();
		}
		if(rs2 != null )
		{
			rs2.close();
		}
		if(stmt2 != null )
		{
			stmt2.close();
		}
if(stmt4 != null )
		{
			stmt4.close();
		}
if(stmt3 != null )
		{
			stmt3.close();
		}
if(stmt5 != null )
		{
			stmt5.close();
		}
if(stmt7 != null )
		{
			stmt7.close();
		}
		if( conn != null )
		{
			conn.close();
		}
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
}

%>
</table>
</form>

</td></tr>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</span>
