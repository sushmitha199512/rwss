<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
   
  String type=request.getParameter("type");
   if(type!=null){
		session.setAttribute("type",type);
}
String yr=(String)session.getAttribute("yr");

  String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
}

String divCode=request.getParameter("divCode");

String programe=(String)session.getAttribute("programe");
String scheme=(String)session.getAttribute("scheme");

String statePrograms="00,03,04,05,06,09,10,12,13,14,15,16,20,21,25,26,29,34,35,38,39,41,42,43,44,45,46,54,56,57,65,66,67";


String relTable="",amount="";
String relColumn="";String txid="";
if(statePrograms.contains(programe)){
relTable="RWS_bill_pao_bridge_det_TBL";
relColumn="STATE_SEND_DATE";
txid="STATE_TXID";
amount="BILL_AMOUT_STATE";
}else {
relTable="RWS_bill_BANK_bridge_det_TBL";
relColumn="BANK_SEND_DATE";
txid="TXID";
amount="BILL_AMOUNT_CENTRAL";
}
    DecimalFormat ndf = new DecimalFormat("##.##");


 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
   <td class="bwborder">
<a href="javascript:onclick=history.go(-1)">Back|</td></tr>
            <a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" >*** Rupees in Lakhs</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>DISTRICT   </b></td>

<td class=btext ><b>Division  </b></td>
<td class=btext ><b>Work ID   </b></td>
<td class=btext ><b>Work Name </b></td>    
<td class=btext ><b>Admin Sanction Date   </b></td>  
<td class=btext ><b>Sanction Amount   </b></td>
<td class=btext ><b>Program  </b></td>
<td class=btext ><b>Date Of Completion  </b></td>
<td class=btext ><b>Remarks   </b></td> 
 
  </tr>




<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext  >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center" class=btext >9</td></tr>
	<%try
      { int count=1;
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
       String qry="";
       stmt3=conn.createStatement();
      

boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

String query="";
System.out.println("Type"+type);
if(type.equals("1")){

 query="select d.dname,c.DIVISION_OFFICE_NAME,a.work_id,a.WORK_NAME ,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),nvl(SANCTION_AMOUNT,'0'),p.programme_name,nvl(a.remarks,'-'),nvl(to_char(cmp.DATE_OF_COMPLETION,'dd/mm/yyyy'),'-') from rws_work_admn_tbl a ,rws_division_office_tbl c,rws_district_tbl d,rws_programme_tbl p,rws_work_completion_tbl cmp where a.work_id=cmp.work_id  and substr(a.work_id,5,2)=d.dcode and d.dcode=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code and a.work_cancel_dt is null and a.category_code='2' and d.dcode='"+dcode+"' and   substr(a.work_id,1,2)=p.programme_code and    a.type_of_asset in("+scheme+") and  p.programme_code in ("+programe+") ";
if(divCode!=null){
			query+="  and substr(a.office_code,4,1)='"+divCode+"'";
}

  query+=  "and a.work_id =cmp.work_id and  (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null  ";

} else if(type.equals("2")){
query="select d.dname,c.DIVISION_OFFICE_NAME,a.work_id,a.WORK_NAME ,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),nvl(SANCTION_AMOUNT,'0'),p.programme_name,nvl(a.remarks,'-'),to_char(cmp.DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_admn_tbl a ,rws_division_office_tbl c,rws_district_tbl d,rws_programme_tbl p,rws_work_completion_tbl cmp where a.work_id=cmp.work_id  and substr(a.work_id,5,2)=d.dcode and d.dcode=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code and a.work_cancel_dt is null and a.category_code='1' and d.dcode='"+dcode+"' and   substr(a.work_id,1,2)=p.programme_code and   a.type_of_asset in("+scheme+") and  p.programme_code in ("+programe+") and a.work_id =cmp.work_id and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null  ";

}else if(type.equals("3")){

query="select d.dname,c.DIVISION_OFFICE_NAME,a.work_id,a.WORK_NAME ,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),nvl(SANCTION_AMOUNT,'0'),p.programme_name,nvl(a.remarks,'-'),to_char(cmp.DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_admn_tbl a  ,rws_division_office_tbl c,rws_district_tbl d,rws_programme_tbl p,rws_work_completion_tbl cmp where a.work_id=cmp.work_id  and  substr(a.work_id,5,2)=d.dcode and d.dcode=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code and a.work_cancel_dt is null and (a.category_code='1' OR a.category_code='2') and d.dcode='"+dcode+"' and   substr(a.work_id,1,2)=p.programme_code  and a.type_of_asset in("+scheme+") and  p.programme_code in ("+programe+") and a.work_id =cmp.work_id and  (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null  ";

} else if(type.equals("4")){
//query="select dis.dname,b.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(SANCTION_AMOUNT,'0'),p.programme_name,nvl(w.remarks,'-') ,d.SCHOOL_CODE  FROM RWS_WORK_ADMN_TBL W ,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d,rws_division_office_tbl b,rws_district_tbl  dis,rws_programme_tbl p  where  substr(W.office_code,2,2)='"+dcode+"'  and substr(w.work_id,5,2)=dis.dcode and substr(w.work_id,7,2)='11' and work_cancel_dt is null  and substr(w.work_id,1,2)=p.programme_code  and w.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and  c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE ='01' and c.school_code=d.school_code";

}

System.out.println("query"+query);


rs3=stmt3.executeQuery(query);

while(rs3.next()){

%>
<tr><td class=rptValue><%=count++ %></td><td class=rptValue><%=rs3.getString(1) %></td><td class=rptValue><%=rs3.getString(2) %></td><td class=rptValue><%=rs3.getString(3) %></td><td class=rptValue><%=rs3.getString(4) %></td><td class=rptValue><%=rs3.getString(5) %></td><td class=rptValue><%=rs3.getString(6) %></td><td class=rptValue><%=rs3.getString(7) %></td><td class=rptValue><%=rs3.getString(9) %></td><td class=rptValue><%=rs3.getString(8) %></td></tr>
<% 



}

      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

