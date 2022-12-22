<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>

<%DecimalFormat ndf = new DecimalFormat("####.00");
	String datew=request.getParameter("datewise");
	if(datew!=null)
	{
		session.setAttribute("datew",datew);}
		String yr=datew.substring(6,10);
		//System.out.println("year:::::::::::::"+yr);
		String date=""+session.getAttribute("serversysdate");
		String curryr=date.substring(6,10);
		//System.out.println("curryr:::::::::::::"+curryr);
		String tname="";
		if(yr.equals(curryr))
		{
		tname="rws_habitation_directory_tbl";
		}
		else if(Integer.parseInt(yr) < Integer.parseInt(curryr))
		{
		tname="RWS_HABITATION_DIR_HIS_TBL ";
		}
		if(tname!=null)
	{
		session.setAttribute("tname",tname);}
//System.out.println("tname:::::::::::::"+tname);
	//System.out.println("dddddddddaaaaaaaaaaatttttteeeeeeee"+datew);

	Statement stmt1=conn.createStatement();
	Statement stmt2=conn.createStatement();
	Statement stmt3=conn.createStatement();
	Statement stmt11=conn.createStatement();
		Statement stmt4=conn.createStatement();
Statement stmt111=conn.createStatement();
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs11=null;
	String qry1="",qry2="",qry3="",qry4="";
	String div="",cir="";
	long scc=0;
	int sno=1;
	double scta=0.0,stta=0.0,plainta=0.0;
	double scta1=0.0,stta1=0.0,plainta1=0.0,stotnew=0.0,stotnew1=0.0,fftot3=0.0,fftot4=0.0,fftot=0.0,fftot1=0.0,fftot2=0.0;
	double stot1=0.0,stot2=0.0,stot=0.0;
double gsc=0.0,gst=0.0,gplain=0.0;
	double a1=0.0,a2=0.0,a3=0.0;
	double ff=0.0,ff1=0.0,ff2=0.0,rt=0.0,trt=0.0,rt1=0.0,trt1=0.0;
	double sca=0.0,sta=0.0,plaina=0.0;
	double sca1=0.0,sta1=0.0,plaina1=0.0,newtot=0.0;
		double scna1=0.0,stna1=0.0,plainna1=0.0,newntot=0.0;
	session.setAttribute("division",request.getParameter("division"));

	if(request.getParameter("division")!=null && !request.getParameter("division").equals(""))
	{
	String cirdiv=request.getParameter("division");
	div=cirdiv.substring(2,3);
	cir=cirdiv.substring(0,2);

	}
	else{
	String cirdiv=request.getParameter("division");
    if(cirdiv!=null && !cirdiv.equals("")){
	div=cirdiv.substring(2,3);
	cir=cirdiv.substring(0,2);
	}
   }
   session.setAttribute("div",div);
   session.setAttribute("cir",cir);
   %>
<table border = 0 cellspacing = 0 cellpadding = 0 width="800px">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" width="600px">
		<tr align="right">
			<td class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>|<a href="../home.jsp">Home</a> |<a href="./pdf.jsp?datecheck=<%=datew%>" target=_new>PDF</a> 
			</td>
		</tr>
		</table>
</caption>

<table>
<%

 String finYear="",prevYear="";
 String fy="",fy3="";      
 int fy1=0,fy2=0;

String finquery="select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2010 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
		    //System.out.println("Fin"+ finquery);
			ResultSet rs111 = stmt111.executeQuery( finquery);
			if(rs111.next())
			{
				 fy=rs111.getString(1);
				 fy1=Integer.parseInt(fy)+1;
                 fy2=Integer.parseInt(fy)-1;
                 fy3=Integer.toString(fy1);
                 //System.out.println("fy"+fy);
				//System.out.println("fy1"+fy1);
				//System.out.println("fy2"+fy2);
                //System.out.println("fy3"+fy3);
	           %>
			   <%finYear=fy+"-"+fy1;
                 prevYear=fy2+"-"+fy;
                    %>
	           <%
       	    }
      if(rs111!=null)rs111.close();
	  if(stmt111!=null)stmt111.close();
     

String name="";
String qry11="select * from rws_head_office_tbl where head_office_code='1' ";
//System.out.println("qry111111:"+qry11);
rs11=stmt11.executeQuery(qry11);
if(rs11.next())
{
 name=rs11.getString(3);
 session.setAttribute("name",name);
}

%>
<tr><td class=rptvalue align="center"><b>Procs. Of the Engineer-in-Chief (RWS&S) & Member Secretary (SWSM): Hyderabad</b></td></tr>
<tr><td class=rptvalue align="center"><b>Present: Sri <%=name%></b></td><td align="right"><input type="button" name="Button" value="Print" onclick="javascript:window.print()"/></td></tr>
<tr><td class=rptvalue align="center"><b><u>Procs. No. BI(1)/  831 / <%=prevYear%>, Dated :<font face="verdana" size=2 color="green"><%=datew%></font></u></b> </td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td class=rptvalue align="center"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sub:-</b>RWS&S Budget – (<%=finYear %>) – NRDWP  – Release of funds through online banking system – Orders -  Issued.</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td class=rptvalue align="center"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ref:-</b>1. Bills uploaded by the Executive Engineers RWS&S in the State through Funds monitoring system (Watersoft).</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td class=rptvalue align="center"><b>*****</b></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td class=rptvalue align="left"><b><u>ORDER</u></b></td></tr>
<tr><td class=rptvalue >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Government &nbsp;of &nbsp;India has sanctioned and subsequently released funds under&nbsp; National  Rural  Drinking  <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Water Programme (NRDWP).</td></tr><tr></tr><tr></tr><tr><td class=rptvalue>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Executive Engineers, RWS&S, Concerned have uploaded the bills to Water Soft Monitoring System under <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NRDWP and forwarded to ENC office, duly certifying that the forwarded bills are as per pass order.</td></tr><tr></tr><tr></tr><tr><td class=rptvalue>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 &nbsp;The following amounts are hereby sanctioned and released to incur expenditure for the works mentioned against each <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;work for which the amount is now released.
</td></tr>
</table>
<br>
<br>
<table border = 1 cellspacing = 0 cellpadding = 0  width="80%"  bordercolor=#000000 style="border-collapse:collapse">

<%String qry="select distinct division_office_name,txid,txid_div,office_code,bill_amount_central,circle_office_code,division_office_code  from rws_bill_bank_settlement_tbl a,rws_complete_office_view v where substr (office_code,2,2) =v.circle_office_code and substr(office_code,4,1)=v.division_office_code and to_char (processed_start_date,'dd/mm/yyyy')='"+datew+"' and bill_activation_flag='P'  ";

 if(cir!=null && !cir.equals("") && div!=null && !div.equals(""))
 {
	 qry+= "  and  substr (office_code,2,2) ='"+cir+"' and  substr (office_code,4,1)='"+div+"' "; 
 }
qry+=" order by txid,circle_office_code,division_office_code ";

//System.out.println("qry111111:"+qry);
int count=0;
double gtot=0.0;
int count1=0;
stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs=stmt.executeQuery(qry);
if(rs.isBeforeFirst())
{
rs.next();
String gtid=rs.getString(2);
String prevgtid="";
%>
<tr>
<td bgcolor="green"><font color="white" face="verdana" size="2"><B>Group TransactionId:&nbsp;&nbsp;<%=rs.getString(2)%></B></font>
</td>
</tr>
<%
rs.previous();

while(rs.next())
{
	
	if(gtid.equals(rs.getString(2))){%>
	<tr><td class=btext colspan=4><%=++count%>.Division:<%out.println(rs.getString(1));%>&nbsp;&nbsp;&nbsp;TransactionId:<%=rs.getString(3)%>&nbsp;</td></tr>
   <%
	}else{
     if(!prevgtid.equals(rs.getString(2))){	
		 %>
<tr><td bgcolor="green"><font color="white" face="verdana" size="2"><B>Group TransactionId:&nbsp;&nbsp;<%=rs.getString(2)%>
</B></font></td></tr>
<%
	 } else{}%>
	<tr><td class=btext colspan=4><%=++count1%>.Division:<%out.println(rs.getString(1));%>&nbsp;&nbsp;&nbsp; TransactionId:<%=rs.getString(3)%>&nbsp;</td></tr>
   
	<% }
		

		%>

		<tr>
		<td>
		<table border=1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse">
		<tr>
        <td class=rptvalue  rowspan = 2 width="20px"><font color="red">S.No</font></td>
		<td class=rptvalue   rowspan = 2 width="100px"><font color="red">Work Id</font></td>
		<td class=rptvalue   rowspan = 2 width="100px" cellspacing=0 nowrap><font color="red">Work Name</font></td>
		<td class=rptvalue   rowspan = 2 width="100px"><font color="red">Programme</font></td>
		<td class=rptvalue   rowspan = 2 width="100px"><font color="red">Sub<br>Programme</font></td>
		<td class=rptvalue   rowspan = 2 width="100px"><font color="red">Bill No</font></td>
	<!-- 	<td class=rptvalue  align="center" rowspan = 2><font color="red" >Bill Amount  <br>Raised By EE</font></td> -->
		<td class=rptvalue  align="center" colspan = 4 width="400px"><font color="red">Releases Made Under</font></td>
		</tr>
		<tr>
		<td class=rptvalue align="center" width="100px"><font color="red">SC</font></td>
		<td class=rptvalue  align="center" width="100px"><font color="red">ST</font></td>
		<td class=rptvalue align="center" width="100px"><font color="red">PLAIN</font></td>
		<td class=rptvalue align="center" width="100px"><font color="red">Total</font></td>
		</tr>
<%

double amt=0.0;
int hab=0,sc=0,st=0,plain=0;	
a1=0;
plaina=0;
a2=0;scta=0;
a3=0;stta=0;
stotnew=0;
stotnew1=0;
fftot3=0;
fftot4=0;
fftot=0;
fftot1=0;
fftot2=0;
plainta=0;
plainta1=0;
scta1=0;
stta1=0;
newtot=0;
int p=0;
String s="";
String s1="";
 scna1=0;stna1=0;plainna1=0;newntot=0;

qry1="select a.work_id,work_name,bill_no,bill_amount_central,bill_activation_flag,c.subprogramme_code,s.subprogramme_name ,p.programme_name,no_of_habs from rws_bill_bank_bridge_det_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c,rws_subprogramme_tbl s ,rws_programme_tbl p where a.work_id=b.work_id and a.work_id=c.work_id and c.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no  and txid='"+rs.getString(2)+"'   and a.office_code='"+rs.getString(4)+"' and c.programme_code=s.programme_code and c.subprogramme_code=s.subprogramme_code and p.programme_code=c.programme_code  ";
//System.out.println("qqqq22:"+qry1);
rs1=stmt1.executeQuery(qry1);

while(rs1.next())
{
	//System.out.println("hhhhhhhh::"+rs1.getInt(9));
	
	if(rs1.getInt(9)>1)
	{
		qry2="select count(hab_code) from RWS_EST_NEW_HAB_LNK_TBL  where work_id='"+rs1.getString(1)+"'";
	}
	else
	{
	    qry2="select count(hab_code) from rws_admn_hab_lnk_tbl  where work_id='"+rs1.getString(1)+"'";
	}
	//System.out.println("hab33333:"+qry2);

	rs2=stmt2.executeQuery(qry2);



while(rs2.next())
{
	if(rs2.getInt(1)>1)
	{
	qry3="select  sum(CENSUS_SC_POPU) , sum(CENSUS_ST_POPU) ,sum(CENSUS_PLAIN_POPU) from RWS_EST_NEW_HAB_LNK_TBL a, "+tname+" b   where work_id='"+rs1.getString(1)+"' and a.hab_code=b.hab_code";
//System.out.println("pop44444:"+qry3);
	rs3=stmt3.executeQuery(qry3);
while(rs3.next())
{
	s=rs1.getString(2);
	//System.out.println("s*******"+s);
	p=s.length();
	//System.out.println("p*******"+p);
	if(p>100)
	{
		s1=s.substring(0,50);
			
	}
else
{
s1=s.substring(0,20);
}
	
	//System.out.println("s1*******"+s1);

%>
    <tr onmouseover="Tip('<%= rs1.getString(2)%> ',TITLE,'Information')" onmouseout="UnTip()">
	 
	   		
		
		  <td class=rptvalue align="center" width="20px"><%=sno++%></td>
<td class=rptvalue width="100px"><%=rs1.getString(1)%></td>
<%
	   if(p<150)
	   {
	   %>

	    <td class=rptvalue width="100px"><%=s1%></td>
		<%}%> 

		<td class=rptvalue width="100px"><%=rs1.getString(8)%></td>
		<td class=rptvalue width="100px"><%=rs1.getString(7)%></td>
		<td class=rptvalue width="100px"><%=rs1.getString(3)%></td>
		<!-- <td class=rptvalue align="right"><%=rs1.getString(4)%></td> -->
		
		<%int totalp=rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
	//System.out.println("tpop:"+totalp);
	double billa=rs1.getDouble(4);
	//System.out.println("billa:"+billa);
	 sca=billa*rs3.getInt(1)/totalp;
	 sta=billa*rs3.getInt(2)/totalp;
	 plaina=billa*rs3.getInt(3)/totalp;
//System.out.println("sta:"+sta);
stotnew=sca+sta+plaina;
//System.out.println("stotnewstotnewstotnewstotnew:"+stotnew);
		%>
	<td class=rptvalue align="right"><%=ndf.format(sca)%></td>
	<td class=rptvalue align="right"><%=ndf.format(sta)%></td>
	<td class=rptvalue align="right"><%=ndf.format(plaina)%></td>
	<td class=rptvalue align="right"><%=ndf.format(stotnew)%></td>
	</tr>
<%
	amt+=rs1.getDouble(4);
	hab+=rs2.getDouble(1);
	scta+=sca;
	stta+=sta;
	//System.out.println("PP:::"+plaina);
	plainta+=plaina; 
	//System.out.println("PP22222:::"+plainta);
	stotnew1+=stotnew;
	//System.out.println("stotstotstostotnew1stotnew1stotnew1stotstot:"+stotnew1);
 }}else
	{
	
	stot=0;
	stot1=0;
	stot2=0;
	fftot=0;
fftot1=0;
fftot2=0;

%>
    <tr>
	   <td class=rptvalue align="center" width="20px"><%=sno++%></td>
	    <td class=rptvalue width="100px"><%=rs1.getString(1)%></td>
		<td class=rptvalue width="100px" cellspacing=0><%=rs1.getString(2)%></td>
		<td class=rptvalue width="100px"><%=rs1.getString(8)%></td>
		<td class=rptvalue width="100px"><%=rs1.getString(7)%></td>
		<td class=rptvalue width="100px"><%=rs1.getString(3)%></td>
		<!-- <td class=rptvalue align="right"><%=rs1.getString(4)%></td> -->
		<%
		if(rs1.getString(6).equals("00"))	
		{
		qry4="select  CENSUS_SC_POPU , CENSUS_ST_POPU ,CENSUS_PLAIN_POPU from RWS_EST_NEW_HAB_LNK_TBL a, rws_habitation_directory_tbl b   where work_id='"+rs1.getString(1)+"' and a.hab_code=b.hab_code";
		//System.out.println("pop44444:"+qry4);
		rs4=stmt4.executeQuery(qry4);
		while(rs4.next())
			{
		int totalp1=rs4.getInt(1)+rs4.getInt(2)+rs4.getInt(3);
		//System.out.println("tpop00000000:"+totalp1);
		double billa1=rs1.getDouble(4);
		//System.out.println("billa0000000000:"+billa1);
		sca1=billa1*rs4.getInt(1)/totalp1;
		sta1=billa1*rs4.getInt(2)/totalp1;
		plaina1=billa1*rs4.getInt(3)/totalp1;
		//System.out.println("sta00000000000:"+sta1);
		newtot=sca1+sta1+plaina1;
		//System.out.println("sta00000000000:"+newtot);
		%>
		<td class=rptvalue align="right"><%=ndf.format(sca1)%></td>
		<td class=rptvalue align="right"><%=ndf.format(sta1)%></td>
		<td class=rptvalue align="right"><%=ndf.format(plaina1)%></td>
		<td class=rptvalue align="right"><%=ndf.format(newtot)%></td>
		<%scna1+=sca1;
		stna1+=sta1;
		plainna1+=plaina1;
		newntot=scna1+plainna1+stna1;
//System.out.println("new00c>>>>"+scna1);
//System.out.println("new00t>>>>"+stna1);
//System.out.println("new00>p>>>"+plainna1);
//System.out.println("new00>tttt>>>"+newntot);
			}
		}
		else if(rs1.getString(6).equals("01") || rs1.getString(6).equals("05") || rs1.getString(6).equals("06")){ 
			ff=rs1.getDouble(4);
			ff1=0.0;
			ff2=0.0;%>
		<td class=rptvalue align="right"><%=ndf.format(ff1)%></td>
		<td class=rptvalue align="right"><%=ndf.format(ff2)%></td>
		<td class=rptvalue align="right"><%=ndf.format(ff)%></td>
        <%fftot=ff1+ff2+ff;
			//System.out.println("fftotfftotfftotfftotfftotfftot"+fftot);%>
			<td class=rptvalue align="right"><%=ndf.format(fftot)%></td>
		<%}else if(rs1.getString(6).equals("02")){ff1=rs1.getDouble(4);
		ff=0.0;
		ff2=0.0;%>
		<td class=rptvalue align="right"><%=ndf.format(ff1)%></td>
		<td class=rptvalue align="right"><%=ndf.format(ff)%></td>
		<td class=rptvalue align="right"><%=ndf.format(ff2)%></td>
		<%fftot1=ff1+ff2+ff;
			//System.out.println("fftotfftotfftotfftotfftotffto1111111t"+fftot1);%>
			<td class=rptvalue align="right"><%=ndf.format(fftot1)%></td>
		<%}else  if(rs1.getString(6).equals("03") || rs1.getString(6).equals("04")){
			ff2=rs1.getDouble(4);
			ff1=0.0;
			ff=0.0;%>
		<td class=rptvalue align="right"><%=ndf.format(ff1)%></td>
		<td class=rptvalue align="right"><%=ndf.format(ff2)%></td>
		<td class=rptvalue align="right"><%=ndf.format(ff)%></td>
			<%fftot2=ff1+ff2+ff;
		//	System.out.println("fftotfftotfftotfftotfftot22222222fftot"+fftot2);%>
			<td class=rptvalue align="right"><%=ndf.format(fftot2)%></td>
		<%}
	%>
	</tr>
<%
	amt+=rs1.getDouble(4);
	hab+=rs2.getDouble(1);
	//System.out.println("sreeeeee>>>>"+fftot);
	 a1+=fftot;
	// System.out.println("sreeeeee11111>>>>>>>"+a1);
	a2+=ff1;
	a3+=ff2;
	fftot3=a1+a2+a3;
	//System.out.println("fftotfftotfftotfftotfftot233333333fftot"+fftot3);
	//}

	}}} 
	sno=1;
		if(a1==0.0)
	{stot=plainta;
	}
else{
	stot+=a1+plainta+plainna1;
}

//	System.out.println("scta1scta1scta1scta1>>>>>>"+scta1);
//	System.out.println("plainta1plainta1plainta1plainta1plainta1>>>>>>"+plainta1);
	stot1=a2+scta+scna1;
//	System.out.println("stta1stta1stta1stta1>>>>>>>>"+stta1);
	stot2=a3+stta+stna1;
	//System.out.println("tttttttt>>>>>>>>"+stot2);
	fftot4=stotnew1+fftot3+newntot;
//System.out.println("fftotfftotfftotfftotfftot444444444fftot"+fftot4);
//gsc+=stot1;
//System.out.println("sc>>>>>>"+gsc);
//gst+=stot2;
//System.out.println("st>>>>>>"+gst);
gsc+=stot1;
//System.out.println("scffff>>>>>>"+gsc);
gst+= stot2;
//System.out.println("st>fffffff>>>>>"+gst);
gplain+=stot;
//System.out.println("plainfffff>>>>>>"+gplain);
//gplain+=stot;
//System.out.println("plain>>>>>"+gplain);
//System.out.println("plain>>>>>"+scc);
%>
<tr>
<td class=btext colspan=6 align="right">Total:</td>
<!-- <td align="right" class=btext><font face="verdana" size=2 color="green"><%=ndf.format(amt)%></font></td> -->
<td align="right" class=btext><%=ndf.format(stot1)%></td>
<td align="right" class=btext><%=ndf.format(stot2)%></td>
<td align="right" class=btext><%=ndf.format(stot)%></td>
<td align="right" class=btext><font face="verdana" size=2 color="green"><%=ndf.format(fftot4)%></font></td>
</tr>
</table>

<%

	gtot=gtot+amt;	
		prevgtid=rs.getString(2);
}}
else
{
%>
	<script>
	var d='<%=datew%>'
	
		alert(" Bank Not yet process  Dated:"+d+" Bills- You are redirected to Previous page");
		document.location.href="rws_precedings_frm.jsp";
	</script>
<%
}
%>
</td>
</tr>
<!-- <tr><td class=btext align="right">Grand Total:&nbsp;&nbsp;&nbsp;&nbsp; <%=Math.round(gtot)%></td></tr> -->
<tr><td class=btext  align="right" >Grand Totals:&nbsp;&nbsp;&nbsp;&nbsp;
<font face="verdana" size=2 color="red"><%=ndf.format(gsc)%>&nbsp;</font>|<font face="verdana" size=2 color="red"><%=ndf.format(gst)%>&nbsp;</font>|<font face="verdana" size=2 color="red"><%=ndf.format(gplain)%>&nbsp;</font>|<font face="verdana" size=2 color="red"><%=ndf.format(gtot)%>&nbsp;</font></td>
</tr>
</table>
<br>
<table>
<tr><td>&nbsp;</td></tr>
<tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Executive Engineers, RWS&S, Concerned are directed to debit the expenditure to the above works only as mentioned <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;against each strictly in accordance with the instructions issued by the Chairman(SWSM) and Prl Secretary to Government (RWS&S),<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; duly following the guidelines of NRDWP.</td></tr>
<tr><td>&nbsp;</td></tr>
<br>
<tr><td class=rptvalue >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Further the Executive Engineers, RWS&S, Concerned are also directed to update the voucher wise details <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in the WaterSoft fund monitoring system within a week.</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td class=rptvalue align="center"><font size="3"><b><u>The Releases are made subject to the following conditions</b></u></font></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>The funds are released duly earmarking SCP and TSP as per the guide lines of Govt .of India.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hence they should utilize the amount now released strictly to the respective sub programmes only i.e. SCP and TSP.</b></td></tr>
<tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>The diversion of funds from one sub programme to another sub programme will not be entertained <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at any cost.If any noticed it will be viewed seriously.  </b></td></tr>
<tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Regarding Spill over works of ARWS, payment shall not exceed the spillover estimate cost approved <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by the the Government. </b></td></tr>
<tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>All the Grants now released and previous balance if any shall  be Expended in a week and entered in <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;the  Water Soft failing which the unspent balances available as per Water Soft will be taken<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; back. 
 </b></td></tr>
<tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>The payment shall be made as per the guidelines of NRDWP, GOI only . </b></td></tr>
<tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>The payment shall not exceed Administrative Sanction amount in any case.
 </b></td></tr>
<tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>The payment shall not be made without EOAT as on the date of passing of the bill. 
 </b></td></tr>
 <tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>*</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>The Expenditure incurred should be clearly classified Sub Programme wise such as Coverage, Quality,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sustainability,O&M, DDP, Calamities, SCP,TSP,NTSP, etc.</b></td></tr>
 <tr><td >&nbsp;</td></tr>
 <tr><td >&nbsp;</td></tr>
 <tr><td >&nbsp;</td></tr>
  <tr><td class=rptvalue align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Engineer-in-Chief (RWS&S) &</td></tr>
  <tr><td class=rptvalue align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Member Secretary (SWSM): Hyderabad</td></tr>
<tr><td >&nbsp;</td></tr>
 <tr><td >&nbsp;</td></tr>
 <tr><td >&nbsp;</td></tr>
 <tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To</td>
 </tr>
  <tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All the Concerned Executive Engineers, RWS&S, in the state.</td>
 </tr>
  <tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy to Chief Engineer NRDWP Normal.</td>
 </tr>
  <tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy to all the Concerned Superintending Engineers, RWS&S, in the state.</td>
 </tr>
  <tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy to MIS Section of this office.</td>
 </tr>
 <tr><td class=rptvalue align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy to S/F. </td>
 </tr>
 
		</table>

