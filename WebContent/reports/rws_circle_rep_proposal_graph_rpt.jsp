<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*,java.text.SimpleDateFormat" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%	
    int repcode=0,totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnc=0,totnss=0;
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null,r8=null;
	int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};	
	String query = null;
	String a1="", tdate=null, fdate=null, panchayat=null, mandal=null, district=null;

 district=request.getParameter("district");
 //System.out.println("district iss="+district);
  mandal=request.getParameter("mandal");
  //System.out.println("mandal issss="+mandal);
  panchayat=request.getParameter("panchayat");
 // System.out.println("panchayat isss="+mandal);
  fdate=request.getParameter("FDate");


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
				<a href="./rws_circle_rep_proposal_graph_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a>
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Representative Proposal Details</font></td>
	</tr>
<tr><td valign=top align=center>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center width=100%>	


	<tr><% if(!district.equals("51")) {%>
	<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %><% } %></font></td>
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %></font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Sub Division: <%=session.getAttribute("pName") %></font></td>
</tr>
<%}
	
 if(fdate!=null && !fdate.equals("0"))
	{
		//System.out.println("fdate11111111 is"+fdate);
		%>
<tr>
		<td class="textborder" align="center">
			<font>Proposals In :</font><font color=#F2A80D><%=fdate%></font></td>
	</tr>
	<% }%>
</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// System.out.println("val of start    "+st);%>

	
<%
int Count=0,i=0;
// System.out.println("coount of rows is    ");
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
try	{
String qu1=null;
		//if(dCode.equals("51"))
		   if(district.equals("51"))
			{
		    // System.out.println("circle all");
			 qu1="SELECT distinct c.circle_office_code,c.circle_office_name,count(substr(office_code,2,2)) from rws_rep_proposal_tbl rp, RWS_CIRCLE_OFFICE_TBL c where substr(rp.office_code,2,2)=c.circle_office_code and rp.rep_date is not null";
			 
			 a1=" group by c.circle_office_code,c.circle_office_name";
		}
		 else if(!district.equals("51") && mandal.equals("0"))
	{
           // out.println("circle sel n mandal nt sel");
			 qu1="SELECT c.circle_office_code,c.circle_office_name,count(substr(office_code,2,2)) from rws_rep_proposal_tbl rp, RWS_CIRCLE_OFFICE_TBL c where substr(rp.office_code,2,2)=c.circle_office_code and substr(rp.office_code,2,2)='"+district+"' and rp.rep_date is not null";
			 a1=" group by c.circle_office_code,c.circle_office_name";
	}
		else if(!district.equals("51") && mandal.equals("5200"))
		{
			 //out.println("circle nt all && division all");
			
			 qu1 = "SELECT c.division_office_code,c.division_office_name, count(substr(office_code,4,1)) from rws_rep_proposal_tbl rp, RWS_division_OFFICE_TBL c where substr(rp.office_code,2,2)=c.circle_office_code and substr(rp.office_code,4,1)=c.division_office_code and   substr(rp.office_code,2,2)='"+district+"' and rp.rep_date is not null";
			a1=" group by c.division_office_code,c.division_office_name";
		 }	
		 else if(!district.equals("51") && !mandal.equals("5200") && panchayat.equals("0"))
		{
			  //out.println("circle nt all && division nt all");

			 qu1 = "SELECT c.division_office_code,c.division_office_name, count(substr(office_code,4,1)) from rws_rep_proposal_tbl rp, RWS_division_OFFICE_TBL c where substr(rp.office_code,2,2)=c.circle_office_code and substr(rp.office_code,4,1)=c.division_office_code and   substr(rp.office_code,2,2)='"+district+"' and substr(rp.office_code,4,1)='"+mandal+"' and  rp.rep_date is not null";
            
			a1=" group by c.division_office_code,c.division_office_name";

		 }
		 //||  !mCode.equals("0")
		 else if(!district.equals("51") && !mandal.equals("5200") && panchayat.equals("5300"))
		{
			qu1 = "SELECT c.subdivision_office_code,c.subdivision_office_name, count(substr(office_code,5,2)) from rws_rep_proposal_tbl rp, RWS_subdivision_OFFICE_TBL c where substr(rp.office_code,2,2)=c.circle_office_code and substr(rp.office_code,4,1)=c.division_office_code and substr(rp.office_code,5,2)=c.subdivision_office_code  and substr(rp.office_code,2,2)='"+district+"' and substr(rp.office_code,4,1)='"+mandal+"' and rp.rep_date is not null";
			 a1=" group by c.subdivision_office_code,c.subdivision_office_name";
		 }	
		 else if(!district.equals("51") && !mandal.equals("0") && !mandal.equals("5200") && !panchayat.equals("0") && !panchayat.equals("5300"))
		{
			qu1 = "SELECT c.subdivision_office_code,c.subdivision_office_name, count(substr(office_code,5,2)) from rws_rep_proposal_tbl rp, RWS_subdivision_OFFICE_TBL c where substr(rp.office_code,2,2)=c.circle_office_code and substr(rp.office_code,4,1)=c.division_office_code and substr(rp.office_code,5,2)=c.subdivision_office_code  and substr(rp.office_code,2,2)='"+district+"' and substr(rp.office_code,4,1)='"+mandal+"' and substr(rp.office_code,5,2)='"+panchayat+"' and rp.rep_date is not null";
			 a1=" group by c.subdivision_office_code,c.subdivision_office_name";
		 }	
	 if(fdate!=null && !fdate.equals("0"))
	{
        //rp.PREPARED_ON
		//System.out.println("innnnnnnnn fdate query");
		qu1 = qu1 + " and to_char(rp.PREPARED_ON,'yyyy')='" + fdate +"'";
	}
	qu1 = qu1 + a1;
	    //System.out.println("queryyyyyyyy"+qu1);
		r6=st6.executeQuery(qu1);	
		r6.last();
		Count = r6.getRow();
		//System.out.println("coount of rows is    "+Count);	
		r6.beforeFirst();%>

		<%@ include file = "rws_circle_rep_propo_graph.jsp" %>	
		<% }
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	finally
	{
		conn.close();
	}
	%>
</TD></TR>
</TABLE>

</body>
</html>
<%@ include file = "footer.jsp" %>
