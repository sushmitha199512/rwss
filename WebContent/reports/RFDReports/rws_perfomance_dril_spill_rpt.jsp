<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
   String scheme=(String)session.getAttribute("scheme");
   String programe=(String)session.getAttribute("programe");
 String subProg=(String)session.getAttribute("subprograme");
String financialyr=(String)session.getAttribute("financialyr");
String divCode=request.getParameter("divCode");

String startyr =financialyr.substring(0,4);
	String endyr =financialyr.substring(5,9);
    String endyr1 =financialyr.substring(5,9);
double gexplast=0.0;
double gsanamt=0.0;
double sanamt=0.0;
double bal=0.0;
double gbal=0.0;
double gexplastMonth=0.0;
double gexpcurMonth=0.0;
int ghabsSanctioned=0;
int ghabsCovered=0;
  String circleOfficeCode=request.getParameter("ccode");
   if(circleOfficeCode!=null){
 session.setAttribute("circleOfficeCode",circleOfficeCode);
  }
  
  String type=request.getParameter("type");
   if(type!=null){
		session.setAttribute("type",type);
}

 String catageory=request.getParameter("cat");
   if(catageory!=null){
		session.setAttribute("catageory",catageory);
}


    DecimalFormat ndf = new DecimalFormat("##.##");

String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   String sysyear=sysdate.substring(6,10);

String prevmonth=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=RwsUtils.getNextMonth().toUpperCase();
    
if(startyr.equals(sysyear) && cmonth.equals("APR")){
   prevmonth=cmonth;
}
String startyr2="";
  java.util.Date d=new java.util.Date();
if(d.getMonth()>=3 && d.getMonth()  <=11){
endyr1=startyr;

}else {

endyr1=endyr;

}
if(request.getParameter("drill")!=null){
String drill=request.getParameter("drill");
  if(drill.equals("yes")){

			cmonth="APR";
          endyr1= endyr; 
      
}
  
}

 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="#" onClick="window.close();">Close</a>
</td>
<td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>
	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" >*** Rupees in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext rowspan=2><b>SLNO   </b></td>
<td class=btext rowspan=2><b>DISTRICT   </b></td>

<td class=btext rowspan=2><b>Division  </b></td>
<td class=btext rowspan=2><b>Work ID   </b></td>
<td class=btext rowspan=2><b>Work Name </b></td>    
<td class=btext rowspan=2><b>Admin Sanction Date   </b></td>  
<td class=btext rowspan=2><b>Sanction Amount   </b></td>
<td class=btext rowspan=2><b>Expenditure Up To <%="31.03."+startyr %> </b></td>
<td class=btext rowspan=2><b>Bal Est Cost (7-8) </b></td>
<td class=btext colspan=2><b>Expenditure During <%=startyr %>  </b></td>
<td class=btext rowspan=2><b>Grounding Date  </b></td>
<td class=btext rowspan=2><b>Date Of Completion  </b></td>

<td class=btext rowspan=2><b>Habs Sanctioned  </b></td>
<td class=btext rowspan=2><b>Habs Covered  </b></td>

<td class=btext rowspan=2><b>Program  </b></td>
 <td class=btext rowspan=2><b>Physical Stage  </b></td>
<td class=btext rowspan=2><b>Remarks   </b></td> 
 
  </tr>


<tr>
<td  colspan=1   class=btext align="center">Exp.upto (<%=prevmonth %>)</td>
		<td  colspan=1   class=btext align="center">Exp. During (<%=cmonth %>)</td>
</tr>

<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext  >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center" class=btext >9</td><td align="center" class=btext >10</td><td align="center" class=btext>11</td><td align="center" class=btext>12</td><td align="center" class=btext>13</td><td align="center" class=btext>14</td><td align="center" class=btext>15</td><td align="center" class=btext>16</td><td align="center" class=btext>17</td></tr>
	<%try
      { int count=1;
       Statement stmt1=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
       String qry="";
stmt1=conn.createStatement();
stmt3=conn.createStatement();
stmt4=conn.createStatement();     
stmt5=conn.createStatement();        
stmt6=conn.createStatement();        
stmt7=conn.createStatement();        

boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;


String query="";
//System.out.println("Type"+type);
if(type.equals("1")){

 query="SELECT d.dname,b.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(SANCTION_AMOUNT,'0'),w.category_code,w.AUG_WORKID,p.programme_name,nvl(w.remarks,'-')  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_district_tbl  d,rws_programme_tbl p  where  substr(w.work_id,1,2)=p.programme_code and substr(w.work_id,5,2)=d.dcode and  to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and  b.circle_office_code='"+circleOfficeCode +"' and b.division_office_code='"+divCode+"' and w.programme_code in ("+programe+")  ";

if(scheme!=null && !scheme.equals("")){
          query+="and w.type_of_asset in("+scheme+")";
}
 query+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";

} else if(type.equals("2")){


	 query="select d.dname,b.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(SANCTION_AMOUNT,'0'),w.category_code,w.AUG_WORKID,p.programme_name,nvl(w.remarks,'-') FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b ,rws_district_tbl  d,rws_programme_tbl p  where  substr(w.work_id,5,2)=d.dcode and  substr(w.work_id,1,2)=p.programme_code and (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-"+cmonth+"-"+endyr1+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and   b.circle_office_code='"+circleOfficeCode +"' and b.division_office_code='"+divCode+"'";
 if(scheme!=null && !scheme.equals("")){
          query+="and w.type_of_asset in("+scheme+")";
}
 query+=" and  w.programme_code in ("+programe+")";
}



       System.out.println("qry***********"+query);
       rs1=stmt1.executeQuery(query);
       while(rs1.next())
       {
habsCovered=0;notGrounded=false;
 String DateOfCompl="";
 String DateOfComm="";
 String DateOfGround="";
int habsSanctioned=0;



   String q1="select nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-'),nvl(to_char(DATE_OF_COMM,'dd/mm/yyyy'),'-')  from rws_work_completion_tbl where work_id='"+rs1.getString(3)+"'";
//System.out.println("Query1"+q1);  

 rs3=stmt3.executeQuery(q1);
  
 if(rs3.next()){
DateOfCompl=rs3.getString(1);
DateOfComm=rs3.getString(2);
      } 

 String q2="select nvl(to_char(GROUNDING_DATE,'dd/mm/yy'),'-') from rws_work_commencement_tbl where work_id='"+rs1.getString(3)+"'";
//System.out.println("Query2"+q2);
   rs6=stmt6.executeQuery(q2);
  
 if(rs6.next()){
DateOfGround=rs6.getString(1);
notGrounded=true;
      } 



String coveredHabs="select count(*) from RWS_WORK_COMP_HAB_LNK_TBL where work_id='"+rs1.getString(3)+"'";
//System.out.println("Query3"+coveredHabs);
   rs5=stmt5.executeQuery(coveredHabs);
if(rs5.next()){
  habsCovered=Integer.parseInt(rs5.getString(1));
}

String sanHabs="select count(*) from rws_admn_hab_lnk_tbl where work_id='"+rs1.getString(3)+"'";
System.out.println("Query4sssssssssss"+sanHabs);
   rs7=stmt7.executeQuery(sanHabs);
if(rs7.next()){
  habsSanctioned=Integer.parseInt(rs7.getString(1));
}



String expQuery="SELECT sum(case when to_date(voucher_dt)< '01-Apr-"+startyr+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+startyr+"' and to_date(voucher_dt)< '01-"+cmonth+"-"+endyr1+"') then voucher_Amt else 0 end) ||'@'||sum(case when (to_date(voucher_dt)>= '01-"+cmonth+"-"+endyr1+"' and to_date(voucher_dt)< '01-"+nextmonth+"-"+endyr1+"') then voucher_Amt else 0 end) FROM rws_work_exp_voucher_tbl a where a.work_id='"+rs1.getString(3)+"'and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))" ;
     
System.out.println("MMMeeeeee"+expQuery);
   rs4=stmt4.executeQuery(expQuery);


explast=0;explastMonth=0;expcurMonth=0;

sanamt=Double.parseDouble(rs1.getString(6));

bal=sanamt- explast;
if(rs4.next()){
String expValues[]=rs4.getString(1).split("@");
if(expValues.length>0){
explast=Double.parseDouble(expValues[0])/100000;
explastMonth=Double.parseDouble(expValues[1])/100000;
expcurMonth=Double.parseDouble(expValues[2])/100000;	
}
}
     
String cat="";
    if(rs1.getString(7)!=null){	
          if(rs1.getString(7).equals("1")){
					cat="Projects";
             	}
          if(rs1.getString(7).equals("2")){
					cat="Normal";
             	}


}

String workType="";
    if(rs1.getString(8)!=null){	
					workType=rs1.getString(8);
}

String pstage="";
if(!notGrounded){
		pstage="Not Grounded";
}else if(DateOfCompl.equals("") || DateOfCompl.equals("-"))
{
 pstage="In Progress";
}else if(!DateOfCompl.equals("-") || !DateOfCompl.equals("")){
pstage="Completed";
}

        %>

                <tr>
	           
                <td class=rptLabel>&nbsp;<%=count++%> </td>
 <td  class=rptLabel align="center">&nbsp;<%=rs1.getString(1)%> </td>
         
				<td class=rptLabel>&nbsp;<%=rs1.getString(2)%> </td>    
					<td class=rptValue><%=rs1.getString(3)%>   </td>  
				<td class=rptValue><%=rs1.getString(4)%>   </td>  
				<td class=rptValue align="center"><%=rs1.getString(5)%>  </td>  

				<td class=rptValue align="right"><%=rs1.getString(6)%>  </td> 
   <td class=rptValue align="right"><%=ndf.format(explast) %> </td>
		<td class=rptValue align="right"> <%=ndf.format(Double.parseDouble(rs1.getString(6))- explast) %></td> 
		<td class=rptValue align="right"> <%=ndf.format(explastMonth) %></td> 
	<td class=rptValue align="right"> <%=ndf.format(expcurMonth) %></td> 

   
   <td class=rptValue align="right"><%=DateOfGround%>  </td>
<td class=rptValue align="right"><%=DateOfCompl%>  </td>
      		<td class=rptValue align="right"> <a href="rws_perfomance_dril_habs_rpt.jsp?workid=<%=rs1.getString(3)%>&type=1"><%=habsSanctioned %></a> </td> 
                    		<td class=rptValue align="right"><a href="rws_perfomance_dril_habs_rpt.jsp?workid=<%=rs1.getString(3)%>&type=2"> <%=habsCovered %></a> </td> 
                    <td class=rptValue align="right"><%=rs1.getString(9)%>  </td>
                 		<td class=rptValue align="right"> <%=pstage %> </td> 
                <td class=rptValue align="right"><%=rs1.getString(10)%>  </td>
		
			
				</tr>
		<% 
     gsanamt+=sanamt; 
     gexplast+=explast;
     gbal+=bal;
gexplastMonth+=explastMonth;
gexpcurMonth+=expcurMonth;
ghabsSanctioned+=habsSanctioned;
ghabsCovered+=habsCovered;
   
}



 %>
<tr>

<td  class=btext align=center colspan="6">Total:</td>
<td class=btext><%=ndf.format(gsanamt) %></td>
<td class=btext><%=ndf.format(gexplast) %></td>
<td class=btext><%=ndf.format(gbal) %></td>
<td class=btext><%=ndf.format(gexplastMonth) %></td>
<td class=btext><%=ndf.format(gexpcurMonth) %></td>
<td></td>
<td></td>
<td class=btext><%=ndf.format(ghabsSanctioned) %></td>
<td class=btext><%=ndf.format(ghabsCovered) %></td>
<tr>

<%
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>


	
</table>
</form>

