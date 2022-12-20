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
  String ddate=String.valueOf(session.getAttribute("FDATE"));
  

	

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
				<a href="./rws_graph_waterquality_frm.jsp">Back |</a>
				<a href="../home.jsp">Home |</a>
				<!--<a href="../home.jsp">Print |</a>
				<a href="../home.jsp">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Water Quality Samples Graph </font></td>
	</tr>
<tr><td valign=top align=center>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr><% if(!dCode.equals("51")) {%>
	<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("dName") %><% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>


<td align="center" class="mystyle1"><font color="navy">Year: <%=ddate%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>



</tr>


</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
	String fdate=request.getParameter("FDate");
// //System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width="15%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	
	
<%
try
{

int Count=0,i=0;
			if(dCode.equals("51"))
			 {
                query="select count(*),c.test_code,c.test_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_habitation_directory_tbl hd where c.test_code<>'3' and w.test_code=c.test_code and w.SAMP_COLLECT_DATE is not null and to_char (w.SAMP_COLLECT_DATE,'yyyy')='"+fdate+"' and hd.hab_code=w.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by c.test_code,c.test_name order by 3";
				/*	"select count(*),c.test_code,c.test_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_habitation_directory_tbl hd where w.test_code=c.test_code and hd.hab_code=w.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by c.test_code,c.test_name order by 3"; */
			 }	
				else if(!dCode.equals("51"))
				 {
                   query="select count(*),c.test_code,c.test_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_habitation_directory_tbl hd,rws_district_tbl d where  c.test_code<>'3' and  d.dcode=substr(w.hab_code,1,2) and substr(w.hab_code,1,2)= '"+dCode+"' and w.test_code=c.test_code and w.SAMP_COLLECT_DATE is not null and to_char (w.SAMP_COLLECT_DATE,'yyyy')='"+fdate+"' and hd.hab_code=w.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by c.test_code,c.test_name order by 3";
					   /*"select count(*),c.test_code,c.test_name from rws_water_sample_collect_tbl w,rws_water_quality_test_tbl c,rws_habitation_directory_tbl hd,rws_district_tbl d where substr(w.hab_code,1,2)=d.dcode and substr(w.hab_code,1,2)='"+dCode+"' and w.test_code=c.test_code and hd.hab_code=w.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by c.test_code,c.test_name order by 3"; 
					*/
					   
					   
				 }
	
	if(district.equals("51"))
		{

		%>
		<%@ include file="./rws_water_tot_rpt.jsp" %>
		
		<%	}  
		 else if(!district.equals("51"))
			 {

		%>	
		<%@ include file="./rws_water_tot_rpt.jsp" %>
		
		<%	} %>

		<%@ include file = "rws_water_status_graph_rpt.jsp"%>	

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
