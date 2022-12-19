<%@ include file="/commons/rws_header1.jsp"%>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
String drill=request.getParameter("drill");

session.setAttribute("drill",drill);
if(drill!=null && (drill.equals("3") || drill.equals("4"))){}else{
%>
<%@ include file="/commons/rws_header2.jsp"%>
<%}%>
<%@ include file = "/reports/conn.jsp" %>

<jsp:useBean id="In" class="nic.watersoft.commons.RwsOffices"/>
<script>
 function fnView(fdate,tdate,dist,div,drill,dname,divname)
 {
	var width = 800; 
	var height = 400;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var url = "rws_Releases_bdates_rpt.jsp?fromDate="+fdate+"&toDate="+tdate+"&dist="+dist+"&div="+div+"&drill="+drill+"&dname="+dname+"&divname="+divname;
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=50,top=50";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
 }

</script>
<%if(drill!=null && (drill.equals("3") || drill.equals("4"))) {%>
<table border = 0 cellspacing = 0 cellpadding = 0 width=80%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder"><a href="#" onclick="self.close()">Close</a>
			</td>
		</tr>
</table>
<%}else{%>
<table border = 0 cellspacing = 0 cellpadding = 0 width=80%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back</a>|<a href="../home.jsp">Home</a>|<a href="./rws_Releases_bdates_xls.jsp" target=_new>Excel|</a><a href="#" onclick="self.close()">Close</a>
			</td>
		</tr>
</table>
<%}%>


</caption>
</table>
<table border = 0 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse">
<tr>
<td align="center" class="rptHeading" colspan=15 >Releases Between Dates </td>	
</tr>
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=70%  bordercolor=#000000 style="border-collapse:collapse">

<%
 if(drill ==null )
{
    String fromDate=request.getParameter("fromDate");
    
    String toDate=request.getParameter("toDate");
    session.setAttribute("fromDate",fromDate);
    session.setAttribute("toDate",toDate);
    String da="",mn="",ya="",dt="",mt="",yt="";
   %>
  
  <tr><td class=btext colspan=3 align="center">From Date:<font color="black"><%=fromDate%></font>&nbsp;&nbsp;&nbsp;&nbsp;To Date:<font color="black"><%=toDate%></font></td></tr>
  <tr bgcolor="#8A9FCD" align="center">
     <td class=btext >State</td>
	<td class=btext>Central Amount(In Rs.)</td>
	<td class=btext>State Amount(In Rs.)</td>
</tr>
 <%
 
   if(fromDate!=null && !fromDate.equals(""))
     {
	   da=fromDate.substring(0,2);
	   mn=fromDate.substring(3,5);
	    ya=fromDate.substring(6,10);
	 }
	 if(toDate!=null && !toDate.equals(""))
     {
	   dt=toDate.substring(0,2);
	   mt=toDate.substring(3,5);
	    yt=toDate.substring(6,10);
	 }
	 String mn1="",mt1="";
	 String month[] = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
	 if(mn.equals("01"))mn1=month[0];	 if(mn.equals("02"))mn1=month[1];	  if(mn.equals("03"))mn1=month[2];
	 if(mn.equals("04"))mn1=month[3];	 if(mn.equals("05"))mn1=month[4];	  if(mn.equals("06"))mn1=month[5];
	 if(mn.equals("07"))mn1=month[6];	 if(mn.equals("08"))mn1=month[7];	  if(mn.equals("09"))mn1=month[8];
	 if(mn.equals("10"))mn1=month[9];	 if(mn.equals("11"))mn1=month[10]; if(mn.equals("12"))mn1=month[11];
     if(mt.equals("01"))mt1=month[0];	 if(mt.equals("02"))mt1=month[1];	  if(mt.equals("03"))mt1=month[2];
	 if(mt.equals("04"))mt1=month[3];	 if(mt.equals("05"))mt1=month[4];	  if(mt.equals("06"))mt1=month[5];
	 if(mt.equals("07"))mt1=month[6];	 if(mt.equals("08"))mt1=month[7];	  if(mt.equals("09"))mt1=month[8];
	 if(mt.equals("10"))mt1=month[9];	 if(mt.equals("11"))mt1=month[10]; if(mt.equals("12"))mt1=month[11];

	String qry="select  (select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl   where to_date(bank_send_date) >='"+da+"-"+mn1+"-"+ya+"'  and to_date(bank_send_date) <='"+dt+"-"+mt1+"-"+yt+"' and txid is not null )a,(select nvl(sum(bill_amout_state),'0') from RWS_BILL_PAO_BRIDGE_DET_TBL  where  to_date(state_send_date) >='"+da+"-"+mn1+"-"+ya+"'  and to_date(state_send_date)  <='"+dt+"-"+mt1+"-"+yt+"' and state_txid is not null)b from dual ";
	stmt=conn.createStatement();
	System.out.println("qrycentral:"+qry);
	rs=stmt.executeQuery(qry);
	while(rs.next())
	{%>
		<tr>
		<td class=rptvalue align="center"><a href=".\rws_Releases_bdates_rpt.jsp?drill=1&fromDate=<%=fromDate%>&toDate=<%=toDate%>">Andhra Pradesh</td>
		<%if(Double.parseDouble(rs.getString(1)) >0.0){%>
		<td class=rptvalue align="right"><%=In.IndianFormat1(rs.getString(1))%></td>
		<%}else{%>
		<td class=rptvalue align="right"><%=rs.getString(1)%></td>
		<%}if(Double.parseDouble(rs.getString(2)) >0.0){%>
		<td class=rptvalue align="right"><%=In.IndianFormat1(rs.getString(2))%></td>
		<%}else{%><td class=rptvalue align="right"><%=rs.getString(2)%></td><%}%>
	   </tr>
	<%}
 }
 if(drill !=null && !drill.equals("") && drill.equals("1"))
  {
	   String fromDate=request.getParameter("fromDate");
	   String toDate=request.getParameter("toDate");
	   session.setAttribute("fromDate",fromDate);
	    session.setAttribute("toDate",toDate);
	   String da="",mn="",ya="",dt="",mt="",yt="";
	   int cnt=1;
	 %>
    <tr><td class=btext colspan=4 align="center">From Date:<font color="black"><%=fromDate%></font>&nbsp;&nbsp;&nbsp;&nbsp;To Date:<font color="black"><%=toDate%></font></td></tr>
  	<tr bgcolor="#8A9FCD" align="center">
	 <td class=btext>Sl.No</td>
     <td class=btext>District</td>
	 <td class=btext>Central Amount(In Rs.)</td>
	 <td class=btext>State Amount(In Rs.)</td>
	</tr>
  <%
  

  if(fromDate!=null && !fromDate.equals(""))
     {
	   da=fromDate.substring(0,2);
	   mn=fromDate.substring(3,5);
	    ya=fromDate.substring(6,10);
	 }
	 if(toDate!=null && !toDate.equals(""))
     {
	   dt=toDate.substring(0,2);
	   mt=toDate.substring(3,5);
	    yt=toDate.substring(6,10);
	 }
	 String mn1="",mt1="";
	 String month[] = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
	 if(mn.equals("01"))mn1=month[0];	 if(mn.equals("02"))mn1=month[1];	  if(mn.equals("03"))mn1=month[2];
	 if(mn.equals("04"))mn1=month[3];	 if(mn.equals("05"))mn1=month[4];	  if(mn.equals("06"))mn1=month[5];
	 if(mn.equals("07"))mn1=month[6];	 if(mn.equals("08"))mn1=month[7];	  if(mn.equals("09"))mn1=month[8];
	 if(mn.equals("10"))mn1=month[9];	 if(mn.equals("11"))mn1=month[10]; if(mn.equals("12"))mn1=month[11];
     if(mt.equals("01"))mt1=month[0];	 if(mt.equals("02"))mt1=month[1];	  if(mt.equals("03"))mt1=month[2];
	 if(mt.equals("04"))mt1=month[3];	 if(mt.equals("05"))mt1=month[4];	  if(mt.equals("06"))mt1=month[5];
	 if(mt.equals("07"))mt1=month[6];	 if(mt.equals("08"))mt1=month[7];	  if(mt.equals("09"))mt1=month[8];
	 if(mt.equals("10"))mt1=month[9];	 if(mt.equals("11"))mt1=month[10]; if(mt.equals("12"))mt1=month[11];

  String  qry2="select nvl(sum(bill_amout_state),'0'),substr(office_code,2,2),dname from rws_bill_pao_bridge_det_tbl a,rws_district_tbl b where b.dcode=substr(office_code,2,2) and to_date(state_send_date) >='"+da+"-"+mn1+"-"+ya+"' and to_date(state_send_date) <='"+dt+"-"+mt1+"-"+yt+"'  and state_txid is not null    group by substr(office_code,2,2),dname order by 2 ";
  Statement stmt1=conn.createStatement();
  System.out.println("qry2state:"+qry2);
  Hashtable ht=new Hashtable();
  ResultSet  rs1=stmt1.executeQuery(qry2);
  while(rs1.next())
	 {
         ht.put(rs1.getString(2),rs1.getString(1));
	 }
  double camt=0.0,snamt=0.0;
   String qry1="select nvl(sum(bill_amount_central),'0'),substr(office_code,2,2),dname from rws_bill_bank_bridge_det_tbl a,rws_district_tbl b where b.dcode=substr(office_code,2,2) and to_date( bank_send_date) >='"+da+"-"+mn1+"-"+ya+"' and to_date(bank_send_date) <='"+dt+"-"+mt1+"-"+yt+"'  and txid is not null  and bill_activation_flag='P'  group by substr(office_code,2,2),dname order by 2 ";
 System.out.println("qry1central222222:"+qry1);
 Hashtable cht=new Hashtable();
   stmt=conn.createStatement();
   rs=stmt.executeQuery(qry1);
    while(rs.next())
	  {
         cht.put(rs.getString(2),rs.getString(1));
	  }
	 String dsqry=" select dcode,dname from rws_district_tbl where dcode<>'16' order by dcode ";
	Statement dsstmt=conn.createStatement();
	ResultSet dsrs=dsstmt.executeQuery(dsqry);
	while(dsrs.next())
	  {
		 	  String samt=""+ht.get(dsrs.getString(1));
			  if(samt!=null  && !samt.equals("")  && !samt.equals("null")){}else{samt="0";}
			  String cnamt=""+cht.get(dsrs.getString(1));
			  if(cnamt!=null  && !cnamt.equals("")  && !cnamt.equals("null")){}else{cnamt="0";}

	   %>
          <tr>
		  <td class=rptvalue align="center"><%=cnt++%></td>
		  <td class=rptvalue align="left"><a href=".\rws_Releases_bdates_rpt.jsp?drill=2&fromDate=<%=fromDate%>&toDate=<%=toDate%>
		  &dist=<%=dsrs.getString(1)%>&dname=<%=dsrs.getString(2)%>"><%=dsrs.getString(2)%></td>
		  <%
			if(Double.parseDouble(cnamt)>0.0){%>
		  <td class=rptvalue align="right"><%=In.IndianFormat1(cnamt)%></td>
		  <%}else{%>
		  <td class=rptvalue align="right"><%=cnamt%></td>
		  <%}if(Double.parseDouble(samt)>0.0){%>
		  <td class=rptvalue align="right"><%=In.IndianFormat1(samt)%></td>
		  <%}else{%>
		  <td class=rptvalue align="right"><%=samt%></td>
		  <%}%>
          </tr>
	  <%
		   camt+=Double.valueOf(cnamt.trim()).doubleValue();
	       snamt+=Double.valueOf(samt.trim()).doubleValue();
	   }%>
	  <tr>
	  <td class=btext align="center" colspan=2>Total</td>
	  <%if(camt >0){%>
	  <td class=btext align="right"><%=In.IndianFormat1(""+ndf.format(camt))%></td>
	  <%} else{%><td class=btext align="right"><%=camt%></td><%}
		if(snamt >0){%>
	   <td class=btext align="right"><%=In.IndianFormat1(""+ndf.format(snamt))%></td>
	   <%}else{%><td class=btext align="right"><%=snamt%></td><%}%>
	  </tr>
    <%
		if( camt==0.0 &&  snamt==0.0)	
	  {%>
        <script>
			alert("No Records matching with this selection Crietria");
		   document.location.href="./rws_Releases_bdates_frm.jsp" ;
		   </script>
	  <%}
		
		%>

<% }
 if(drill !=null && !drill.equals("") && drill.equals("2"))
 {
   String dist=request.getParameter("dist");
   String dname=request.getParameter("dname");
   String fromDate=request.getParameter("fromDate");
   String toDate=request.getParameter("toDate");
     
   session.setAttribute("dist",dist);
   session.setAttribute("dname",dname);
   
   
   session.setAttribute("fromDate",fromDate);
   session.setAttribute("toDate",toDate);
   String da="",mn="",ya="",dt="",mt="",yt="";
   int cnt=1;
  %>
    <tr><td class=btext colspan=4 align="center">District:<font color="black"> <%=dname%></font>&nbsp;&nbsp;&nbsp;&nbsp;From Date:<font color="black"><%=fromDate%></font>&nbsp;&nbsp;&nbsp;&nbsp;To Date:<font color="black"><%=toDate%></font></td></tr>
  	 <tr bgcolor="#8A9FCD" align="center">
	 <td class=btext>Sl.No</td>
     <td class=btext>Division</td>
	 <td class=btext>Central Amount(In Rs.)</td>
	 <td class=btext>State Amount(In Rs.)</td>
	  </tr>
  <%
  if(fromDate!=null && !fromDate.equals(""))
     {
	   da=fromDate.substring(0,2);
	   mn=fromDate.substring(3,5);
	    ya=fromDate.substring(6,10);
	 }
	 if(toDate!=null && !toDate.equals(""))
     {
	   dt=toDate.substring(0,2);
	   mt=toDate.substring(3,5);
	    yt=toDate.substring(6,10);
	 }
	 String mn1="",mt1="";
	 String month[] = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
	 if(mn.equals("01"))mn1=month[0];	 if(mn.equals("02"))mn1=month[1];	  if(mn.equals("03"))mn1=month[2];
	 if(mn.equals("04"))mn1=month[3];	 if(mn.equals("05"))mn1=month[4];	  if(mn.equals("06"))mn1=month[5];
	 if(mn.equals("07"))mn1=month[6];	 if(mn.equals("08"))mn1=month[7];	  if(mn.equals("09"))mn1=month[8];
	 if(mn.equals("10"))mn1=month[9];	 if(mn.equals("11"))mn1=month[10]; if(mn.equals("12"))mn1=month[11];
     if(mt.equals("01"))mt1=month[0];	 if(mt.equals("02"))mt1=month[1];	  if(mt.equals("03"))mt1=month[2];
	 if(mt.equals("04"))mt1=month[3];	 if(mt.equals("05"))mt1=month[4];	  if(mt.equals("06"))mt1=month[5];
	 if(mt.equals("07"))mt1=month[6];	 if(mt.equals("08"))mt1=month[7];	  if(mt.equals("09"))mt1=month[8];
	 if(mt.equals("10"))mt1=month[9];	 if(mt.equals("11"))mt1=month[10]; if(mt.equals("12"))mt1=month[11];
  String  qryy1="select nvl(sum(bill_amout_state),'0'),substr(office_code,2,2)||substr(office_code,4,1),division_office_name from rws_bill_pao_bridge_det_tbl a,rws_division_office_tbl b where b.circle_office_code=substr(office_code,2,2) and b.division_office_code=substr (office_code,4,1) and to_date(state_send_date )>='"+da+"-"+mn1+"-"+ya+"' and to_date(state_send_date) <='"+dt+"-"+mt1+"-"+yt+"'  and state_txid is not null and substr (office_code,2,2)='"+dist+"'  and bill_activation_flag='P' group by substr(office_code,2,2)||substr(office_code,4,1),division_office_name order by 2 ";
  Statement stmt1=conn.createStatement();
  Hashtable ht1=new Hashtable();
//  //System.out.println("qryy1:"+qryy1);
  ResultSet  rs1=stmt1.executeQuery(qryy1);
  while(rs1.next())
	 {
         ht1.put(rs1.getString(2),rs1.getString(1));
	 }
double camt=0.0,snamt=0.0;


String qryy="select nvl(sum(bill_amount_central),'0'),substr(office_code,2,2)||substr(office_code,4,1),division_office_name from rws_bill_bank_bridge_det_tbl a,rws_division_office_tbl b where b.circle_office_code=substr(office_code,2,2) and b.division_office_code=substr (office_code,4,1) and to_date(bank_send_date) >='"+da+"-"+mn1+"-"+ya+"' and to_date(bank_send_date) <='"+dt+"-"+mt1+"-"+yt+"'  and txid is not null and substr (office_code,2,2)='"+dist+"'  and bill_activation_flag='P' group by substr(office_code,2,2)||substr(office_code,4,1),division_office_name order by 2 ";
 stmt=conn.createStatement();
 Hashtable ht2=new Hashtable();
System.out.println("qryydrill-2central:"+qryy);
 rs=stmt.executeQuery(qryy);
 while(rs.next())
	{ 
	   ht2.put(rs.getString(2),rs.getString(1));
	}
         
String dqry=" select division_office_code,division_office_name,circle_office_code from rws_division_office_tbl where circle_office_code='"+dist+"' order by 1";		  
Statement  dstmt=conn.createStatement();
 ResultSet drs=dstmt.executeQuery(dqry);
 while(drs.next())
	{
	    String bamt=""+ht2.get(drs.getString(3)+drs.getString(1));
	   	if(bamt!=null  && !bamt.equals("")  && !bamt.equals("null")){}else{bamt="0";}
        String samt=""+ht1.get(drs.getString(3)+drs.getString(1));
		if(samt!=null  && !samt.equals("")  && !samt.equals("null")){}else{samt="0";}
	 %>
	  <tr>
		  <td class=rptvalue align="center"><%=cnt++%></td>
		  <td class=rptvalue align="left"><%=drs.getString(2)%></td>
		  <%if(Double.parseDouble(bamt)> 0 ) {%>
		  <td class=rptvalue align="right"><a href="#" onclick="fnView('<%=fromDate%>','<%=toDate%>','<%=drs.getString(3)%>','<%=drs.getString(1)%>','3','<%=dname%>','<%=drs.getString(2)%>')"><%=bamt%></a></td>
		  <%} else{%><td class=rptvalue align="right"><%=bamt%></td>
		  <%}
		  if(Double.parseDouble(samt) > 0.0) {%>
		  <td class=rptvalue align="right"><a href="#" onclick="fnView('<%=fromDate%>','<%=toDate%>','<%=drs.getString(3)%>','<%=drs.getString(1)%>','4','<%=dname%>','<%=drs.getString(2)%>')"><%=samt %></a></td>
		  <%}else{%>
		  <td class=rptvalue align="right"><%=samt%></td>
		  <%}%>
		 </tr>
	  <%
		camt+=Double.valueOf(bamt.trim()).doubleValue();
	    snamt+=Double.valueOf(samt.trim()).doubleValue();
      }%>

   <tr>
	  <td class=btext align="center" colspan=2>Total</td>
	  <%if(camt >0){%>
	  <td class=btext align="right"><%=ndf.format(camt) %></td>
	  <%} else {%> <td class=btext align="right"><%=camt%></td><%}
		if(snamt >0){%>
       <td class=btext align="right"><%= ndf.format(snamt)%></td>
	   <%}else{%> <td class=btext align="right"><%=snamt%></td><%}%>
	  </tr>

 <%}
 if(drill !=null && !drill.equals("") && drill.equals("3"))
 {
	String dname=request.getParameter("dname");
	String divname=request.getParameter("divname");
	String fromDate=request.getParameter("fromDate");
    String toDate=request.getParameter("toDate");
    String dist=request.getParameter("dist");
    String div=request.getParameter("div"); 
    
    
    session.setAttribute("divname",divname);
    session.setAttribute("div",div);
    session.setAttribute("dist",dist);
    session.setAttribute("dname",dname);
         
    session.setAttribute("fromDate",fromDate);
    session.setAttribute("toDate",toDate);
	 %>
       <tr><td class=btext colspan=8 align="center">District:<font color="black"><%=dname%></font>&nbsp;&nbsp;Division:<font color="black"><%=divname%></font>&nbsp;&nbsp;From Date:<font color="black"><%=fromDate%></font>&nbsp;&nbsp;To Date:<font color="black"><%=toDate%></font></td></tr>
       <tr>
	   <tr>
	   <td class=btext width="15%" align="center">Sl.No</td>
	   <td class=btext width="15%" align="center">Work Id</td>
	   <td class=btext width="50%" align="center">Work Name</td>
	   <td class=btext width="50%" align="center">Program/Subprogram</td>
	   <td class=btext width="50%" align="center">Estimate Cost(in Lakhs)</td>
	   <td class=btext width="15%" align="center">Bill No</td>
	   <td class=btext width="15%" align="center">Transaction Date</td>
	   <td class=btext width="20%" align="center">Bill Amount  Processed<br>(In Rs.)</td>
	   </tr>
  <%
   String da="",mn="",ya="",dt="",mt="",yt="";
   int cnt=1;
  double amt=0.0;
   if(fromDate!=null && !fromDate.equals(""))
     {
	   da=fromDate.substring(0,2);
	   mn=fromDate.substring(3,5);
	    ya=fromDate.substring(6,10);
	 }
	 if(toDate!=null && !toDate.equals(""))
     {
	   dt=toDate.substring(0,2);
	   mt=toDate.substring(3,5);
	    yt=toDate.substring(6,10);
	 }
	 String mn1="",mt1="";
	 String month[] = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
	 if(mn.equals("01"))mn1=month[0];	 if(mn.equals("02"))mn1=month[1];	  if(mn.equals("03"))mn1=month[2];
	 if(mn.equals("04"))mn1=month[3];	 if(mn.equals("05"))mn1=month[4];	  if(mn.equals("06"))mn1=month[5];
	 if(mn.equals("07"))mn1=month[6];	 if(mn.equals("08"))mn1=month[7];	  if(mn.equals("09"))mn1=month[8];
	 if(mn.equals("10"))mn1=month[9];	 if(mn.equals("11"))mn1=month[10]; if(mn.equals("12"))mn1=month[11];
     if(mt.equals("01"))mt1=month[0];	 if(mt.equals("02"))mt1=month[1];	  if(mt.equals("03"))mt1=month[2];
	 if(mt.equals("04"))mt1=month[3];	 if(mt.equals("05"))mt1=month[4];	  if(mt.equals("06"))mt1=month[5];
	 if(mt.equals("07"))mt1=month[6];	 if(mt.equals("08"))mt1=month[7];	  if(mt.equals("09"))mt1=month[8];
	 if(mt.equals("10"))mt1=month[9];	 if(mt.equals("11"))mt1=month[10]; if(mt.equals("12"))mt1=month[11];

   String ary="select a.work_id,c.work_name,b.bill_no,a.bill_amount_central,to_date(bank_send_date,'dd/MM/yyyy'),bank_send_date,programme_name,subprogramme_name,sanction_amount from rws_bill_bank_bridge_det_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c,rws_programme_tbl  p,rws_subprogramme_tbl s where a.work_id=b.work_id and a.work_id=c.work_id and c.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and  p.programme_code=c.programme_code and  p.programme_code=s.programme_code  and s.subprogramme_code=c.subprogramme_code  and  substr (a.office_code,2,2)='"+dist+"' and substr(a.office_code,4,1)='"+div+"'  and to_date(bank_send_date)>='"+da+"-"+mn1+"-"+ya+"' and to_date(bank_send_date)<='"+dt+"-"+mt1+"-"+yt+"'  and txid is not null  and bill_activation_flag='P' order by  6 ASC ";
  System.out.println("ary:"+ary);
   Statement bstmt=conn.createStatement();
   ResultSet brs=bstmt.executeQuery(ary);
	while(brs.next())
	 {%>
            <tr>
			 <td class=rptvalue align="center"><%=cnt++%></td>
			 <td class=rptvalue><%=brs.getString(1)%></td>
			 <td class=rptvalue><%=brs.getString(2)%></td>
			 <td class=rptvalue><%=brs.getString(7)%>/<%=brs.getString(8)%></td>
			 <td class=rptvalue align="right"><%=brs.getString(9)%></td>
			 <td class=rptvalue align="right"><%=brs.getString(3)%></td>
			  <td class=rptvalue align="right"><%=brs.getString(5)%></td>
			 <td class=rptvalue align="right"><%=brs.getString(4) %></td>
			 </tr>
  <%
		amt+=brs.getDouble(4);
	}%>
	<tr>
	  <td class=btext align="center" colspan=7>Total</td>
	  <td class=btext><%=ndf.format(amt)%></td>
    </tr>
 <%}	

 if(drill !=null && !drill.equals("") && drill.equals("4"))
 {
	String dname=request.getParameter("dname");
	String divname=request.getParameter("divname");
	String fromDate=request.getParameter("fromDate");
    String toDate=request.getParameter("toDate");
    String dist=request.getParameter("dist");
    String div=request.getParameter("div");
    
    
    
    session.setAttribute("divname",divname);
    session.setAttribute("div",div);
    session.setAttribute("dist",dist);
    session.setAttribute("dname",dname);
         
    session.setAttribute("fromDate",fromDate);
    session.setAttribute("toDate",toDate);
    
	%>
        <tr><td class=btext colspan=8 align="center">District:<font color="black"><%=dname%></font>&nbsp;&nbsp;Division:<font color="black"><%=divname%></font>&nbsp;&nbsp;From Date:<font color="black"><%=fromDate%></font>&nbsp;&nbsp;To Date:<font color="black"><%=toDate%></font></td></tr>
       <tr>
	   <td class=btext width="15%" align="center">Sl.No</td>
	   <td class=btext width="15%" align="center">Work Id</td>
	   <td class=btext width="50%" align="center">Work Name</td>
	   <td class=btext width="50%" align="center">Program/Sub Program</td>
	   <td class=btext width="15%" align="center">Sanction Amount</td>
	   <td class=btext width="15%" align="center">Bill No</td>
	   <td class=btext width="15%" align="center">Transaction Date</td>
	   <td class=btext width="20%" align="center">Bill Amount  Processed<br>(In Rs.)</td>
	   </tr>
  <%
   
   String da="",mn="",ya="",dt="",mt="",yt="";
   int cnt=1;
  double amt=0.0;
  if(fromDate!=null && !fromDate.equals(""))
     {
	   da=fromDate.substring(0,2);
	   mn=fromDate.substring(3,5);
	    ya=fromDate.substring(6,10);
	 }
	 if(toDate!=null && !toDate.equals(""))
     {
	   dt=toDate.substring(0,2);
	   mt=toDate.substring(3,5);
	    yt=toDate.substring(6,10);
	 }
	 String mn1="",mt1="";
	 String month[] = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
	 if(mn.equals("01"))mn1=month[0];	 if(mn.equals("02"))mn1=month[1];	  if(mn.equals("03"))mn1=month[2];
	 if(mn.equals("04"))mn1=month[3];	 if(mn.equals("05"))mn1=month[4];	  if(mn.equals("06"))mn1=month[5];
	 if(mn.equals("07"))mn1=month[6];	 if(mn.equals("08"))mn1=month[7];	  if(mn.equals("09"))mn1=month[8];
	 if(mn.equals("10"))mn1=month[9];	 if(mn.equals("11"))mn1=month[10]; if(mn.equals("12"))mn1=month[11];
     if(mt.equals("01"))mt1=month[0];	 if(mt.equals("02"))mt1=month[1];	  if(mt.equals("03"))mt1=month[2];
	 if(mt.equals("04"))mt1=month[3];	 if(mt.equals("05"))mt1=month[4];	  if(mt.equals("06"))mt1=month[5];
	 if(mt.equals("07"))mt1=month[6];	 if(mt.equals("08"))mt1=month[7];	  if(mt.equals("09"))mt1=month[8];
	 if(mt.equals("10"))mt1=month[9];	 if(mt.equals("11"))mt1=month[10]; if(mt.equals("12"))mt1=month[11];

   //String ary1="select a.work_id,c.work_name,b.bill_no,a.bill_amout_state,to_date(state_send_date,'dd/MM/yyyy'),state_send_date, programme_name,subprogramme_name,sanction_amount from rws_bill_pao_bridge_det_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c,rws_programme_tbl p,rws_subprogramme_tbl s where a.work_id=b.work_id and a.work_id=c.work_id and c.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and p.programme_code=s.programme_code and  c.programme_code=s.programme_code and  c.subprogramme_code=s.subprogramme_code and substr (a.office_code,2,2)='"+dist+"' and substr(a.office_code,4,1)='"+div+"'  and to_date(send_date) >='"+da+"-"+mn1+"-"+ya+"' and to_date(state_send_date) <='"+dt+"-"+mt1+"-"+yt+"'  and state_txid is not null  and bill_activation_flag='P'  order by 6 ASC ";
   String ary1="select a.work_id,c.work_name,b.bill_no,a.bill_amout_state,to_char(state_send_date,'dd/MM/yyyy'),state_send_date, programme_name,subprogramme_name,sanction_amount from rws_bill_pao_bridge_det_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c,rws_programme_tbl p,rws_subprogramme_tbl s where a.work_id=b.work_id and a.work_id=c.work_id and c.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and p.programme_code=s.programme_code and  c.programme_code=s.programme_code and  c.subprogramme_code=s.subprogramme_code and substr (a.office_code,2,2)='"+dist+"' and substr(a.office_code,4,1)='"+div+"'  and to_date(state_send_date) >='"+da+"-"+mn1+"-"+ya+"' and to_date(state_send_date) <='"+dt+"-"+mt1+"-"+yt+"'  and state_txid is not null  and bill_activation_flag='P'  order by 6 ASC ";   
////System.out.println("ary:"+ary1);
   Statement wstmt=conn.createStatement();
   ResultSet wrs=wstmt.executeQuery(ary1);
	while(wrs.next())
	 {%>
            <tr>
			 <td class=rptvalue align="center"><%=cnt++%></td>
			 <td class=rptvalue><%=wrs.getString(1)%></td>
			 <td class=rptvalue><%=wrs.getString(2)%></td>
 			 <td class=rptvalue><%=wrs.getString(7)%>/<%=wrs.getString(8)%></td>
			 <td class=rptvalue align="right"><%=wrs.getString(9)%></td>
			 <td class=rptvalue align="right"><%=wrs.getString(3)%></td>
			  <td class=rptvalue align="right"><%=wrs.getString(5)%></td>
			 <td class=rptvalue align="right"><%=wrs.getString(4)%></td>
			 </tr>
  <%
		amt+=wrs.getDouble(4);
	}%>
	<tr>
	  <td class=btext align="center" colspan=7>Total</td>
	  <td class=btext><%=ndf.format(amt) %></td>
    </tr>
 <%}%>
<%@ include file = "/reports/connClose1.jsp" %>
