<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*,java.text.SimpleDateFormat" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%		int totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnc=0,totnss=0,totui=0,tot=0;
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null,r8=null;
	int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};	
	String query = null, a1="";

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 String fdate=request.getParameter("FDate");
 //String tdate=request.getParameter("TDate");
 
 ////Debug.println("district="+district);
 ////Debug.println("mandal="+mandal);
 ////Debug.println("panchayat="+panchayat);

// ////Debug.println("dDDDDDDDDDDDDDDD"+session.getAttribute("dName") );
 // ////Debug.println("mMMMMMMMMMMMMMMl="+session.getAttribute("mName"));
 // ////Debug.println("pPPPPPPPPPPPPPPPP="+session.getAttribute("pName"));
 
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 

	System.out.println("dDDDDDDDDDDDDDDD       "+dCode ); 
	//////Debug.println("mMMMMMMMMMcode  ="+mCode);
	//////Debug.println("pPPPPPPPPPPPPPPPP=  "+ pCode);

int start=0,end,limit = 10;
	int Cnt,pgn,tpn;

%>

<html>
<head>
<title> WaterSoft </title>

<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}

</style>
</head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_coverage_graph_form.jsp">Back |</a>
				<a href="../home.jsp">Home |</a>
				<!--<a href="../home.jsp">Print |</a>
				<a href="../home.jsp">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Coverage Status Graph  </font></td>
	</tr>
<tr><td valign=top align=center>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr><% if(dCode!=null && !dCode.equals("null") && !dCode.equals("51")) {%>
	<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("dName") %><%}else{
%>	<td align="center" class="mystyle1"><font color="navy">District: ALL
<%}
	%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %></font></td>
</tr>
<%}
if(fdate!=null && !fdate.equals("0"))
	{%>
<tr align="center">
		<td class="textborder">
			<font size=2>Status As On Date: </font><font color=#F2A80D> <%=fdate%> </font></td>
	</tr>
	<% }%>
</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// ////Debug.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width="15%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	
	
<%
int Count=0,i=0;
// ////Debug.println("coount of rows is    ");
try
		{
	 if(fdate!=null && !fdate.equals("0"))
	{
		//a1 =  "  and to_char(status_date,'dd/mm/yyyy')  >='" + fdate +"' ";
		a1= " and status_date ='" + fdate +"' ";

	}

	if(district.equals("51")){
        System.out.println("in 51");
		%>	<%@ include file="./rws_coverage_dist_tot_rpt.jsp" %>
		
		<%	

		}
		else if(!district.equals("51") && (mandal.equals("0")) && panchayat.equals("0"))
		{
			//System.out.println("SRIKANTH");
			%>
	
			<%@ include file="./rws_coverage_dist1_tot_rpt.jsp" %>			
				<% }
    
		

		
		
		else if(!district.equals("51") && (mandal.equals("5200")) && panchayat.equals("0"))
		{
			//System.out.println("SRIKANTH");
			%>
	
			<%@ include file="./rws_coverage_mandal_tot_rpt.jsp" %>			
				<% }
         

		else if(!district.equals("51") && !mandal.equals("5200") && !mandal.equals("0") 
			&& (panchayat.equals("0") || panchayat.equals("5300"))){
			
	    //System.out.println("SRIKANTH 44");%>
		<%@ include file="./rws_coverage_panch_tot_rpt.jsp" %>			
		
	   <%
		   }
	   else{ // ////Debug.println("3 rd else");%>
			<%@ include file="./rws_panch_only_status_graph_rpt12.jsp" %>
	       <%}%>
	
   <%@ include file = "./rws_coverage_graph.jsp" %>	
	<%
	}
	catch(Exception ee)
	{
	////Debug.println("The error is="+ee);
	}
	
%>
</table>

</TD></TR>
</TABLE>

</body>
</html>

<%@ include file = "footer.jsp" %>
<% conn.close();%>