<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*,java.text.SimpleDateFormat" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>




<%		int totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnc=0,totnss=0,tot=0;
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null,r8=null;
	int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};	
	String query = null, a1="";

 String district=request.getParameter("district");
  String dCode=String.valueOf(session.getAttribute("dCode"));
  String fdate=String.valueOf(session.getAttribute("FDATE"));
  
 

	

int start=0,end,limit = 10;
	int Cnt,pgn,tpn;

%>

<html>
<head>

<title> WaterSoft </title>
<script>
window.history.forward(1);
</script>
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
				<a href="./rws_graph_work_plan_frm.jsp">Back |</a>
				<a href="../home.jsp">Home |</a>
				<!--<a href="../home.jsp">Print |</a>
				<a href="../home.jsp">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Works in Progress Plan/Non Plan Graph </font></td>
	</tr>
<tr><td valign=top align=center>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr><% if(!dCode.equals("51")) {%>
	<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("dName") %><% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>


<%
if(fdate!=null && !fdate.equals("0"))
	{%>
<tr align="center">
		<td class="textborder">
			<font size=2>Admin Sanction Year: </font><font color=#F2A80D> <%=fdate%> </font></td>
	</tr>
	<% }%>



<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %></font></td>
</tr>
<%}%>

</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
	
// //System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width="15%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	
	
<%
try
{

int Count=0,i=0;
			if(dCode.equals("51"))
			 {
                query="select count(work_id),c.plan_code,plan_name from rws_plan_nonplan_tbl c,rws_work_admn_tbl w where w.admin_date is not null and to_char (w.admin_date,'yyyy')='"+fdate+"' and w.work_id not in (select work_id from rws_work_completion_tbl) and w.plan_code=c.plan_code group by c.plan_code,plan_name order by c.plan_code ";
						 
					/*"select count(work_id),c.plan_code,plan_name from rws_plan_nonplan_tbl c,rws_work_admn_tbl w where w.plan_code=c.plan_code group by c.plan_code,plan_name order by c.plan_code";*/


				}
				else if(!dCode.equals("51"))
				 {
                   query="select count(work_id),c.plan_code,plan_name from rws_plan_nonplan_tbl c,rws_work_admn_tbl w,rws_district_tbl d where d.dcode=substr(w.work_id,5,2) and substr(w.work_id,5,2)='"+dCode+"' and w.admin_date is not null and to_char (w.admin_date,'yyyy')='"+fdate+"' and w.work_id not in (select work_id from rws_work_completion_tbl) and w.plan_code=c.plan_code group by c.plan_code,plan_name order by c.plan_code ";
						 
					   /*"select count(w.work_id),c.plan_code,plan_name from rws_plan_nonplan_tbl c,rws_work_admn_tbl w,rws_district_tbl d where d.dcode=substr(w.work_id,5,2) and substr(w.work_id,5,2)='"+dCode+"' and w.plan_code=c.plan_code group by c.plan_code,plan_name order by c.plan_code";*/
					   
					   
				 }
	
	if(district.equals("51"))
		{

		%>
		<%@ include file="./rws_work_plan_tot_rpt.jsp" %>
		
		<%	}  
		 else if(!district.equals("51"))
			 {

		%>	
		<%@ include file="./rws_work_plan_tot_rpt.jsp" %>
		
		<%	} %>

		<%@ include file = "rws_work_plan_status_graph.jsp"%>	

		<% 
		}
		catch(Exception ee)
	    {
	      ee.printStackTrace();
	      }
	finally
	{
		conn.close();
	}
%>
</table>

</TD></TR>
</TABLE>

</body>
</html>

<%@ include file = "footer.jsp" %>
