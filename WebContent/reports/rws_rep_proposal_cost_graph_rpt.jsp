<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*,java.text.SimpleDateFormat" %>
<%@ include file = "conn.jsp" %>

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%	// this prog comparison between  previous 2 years  from given year
	try {	
	
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null,r8=null;
	int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};	
	String query = null;

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 

 
int start=0,end,limit = 10;
int Cnt,pgn,tpn;


 String repcode=request.getParameter("repname");
 String	Consti = request.getParameter("cons");
 String fyr=request.getParameter("finyear");
String Pcode=request.getParameter("prg");

int a=0; 
String assetType=request.getParameter("assetType");

String ATName=null;
if(assetType!=null)
{
if(assetType.equals("01")){ATName="PWS";}
else if(assetType.equals("02")){ATName="MPWS";} 
else if(assetType.equals("03")){ATName="CPWS";}
else if(assetType.equals("04")){ATName="HANDPUMPS";}
session.setAttribute("atname",ATName);
}
else
session.setAttribute("atname",null);
// //System.out.println("assetType="+assetType); 

String q1="";


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
				<a href="./rws_rep_proposal_cost_graph_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a>
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Estimate Cost Graph</font></td>
	</tr>
<tr><td valign=top align=center>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center width=100%>	<tr>
		<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1" ><font color="navy">Sub Division: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<%if(session.getAttribute("consti")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Constituency: <%= session.getAttribute("consti") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("Fyr")!=null){
	if(fyr != null && !fyr.equals("0"))
	{
		int yr = Integer.parseInt(fyr);
		yr = yr - 2;
		String finyr = String.valueOf(yr);
		//System.out.println("year is  "+yr);
		String  fnyr=finyr.substring(2,4);
		int fiyr =Integer.parseInt(fnyr);
		fiyr = fiyr + 1;
		if(fiyr>=10)
		{
			finyr = finyr + "-" + fiyr ;
		}
		else 
		finyr = finyr + "-0" + fiyr ;
		
		
	
%>
<td align="center" class="mystyle1" ><font color="navy">Financial Year:<%=finyr%> &nbsp;&nbsp; <%="--"%>&nbsp;&nbsp;<%= session.getAttribute("Fyr") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></td>
<%}}%>

<%	if(session.getAttribute("atname")!=null){%>
	
		<td align=center colspan=12 class="mystyle1"><font color=navy>Asset Type: <%=session.getAttribute("atname") %> </font>
		</td>
	<%}
	if(session.getAttribute("pCode")!=null){%>
	
		<td align=center colspan=12 class="mystyle1"><font color=navy>Grant Type: <%=session.getAttribute("pCode") %> </font>
		</td>
	</tr><%}%>

</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// //System.out.println("val of start    "+st);%>

	
<%
int Count=0,i=0;
// //System.out.println("coount of rows is    ");
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
try	{
String qu1="";
	if(!district.equals("0") && mandal.equals("0"))
 {
	
	query="SELECT  a.ESTIMATE_COST from rws_rep_proposal_tbl a where substr(a.office_code,2,2)='"+ district  +"'";
	

   // //System.out.println("panchayat="+panchayat);
 }
 else if(!mandal.equals("0") && panchayat.equals("0"))
 {
query="SELECT  a.ESTIMATE_COST from rws_rep_proposal_tbl a  where substr(a.office_code,2,2)='"+ district +"' and substr(a.office_code,4,1)='" + mandal + "'";
	

 }
 else
 {	
	query="SELECT  a.ESTIMATE_COST from rws_rep_proposal_tbl  a where substr(a.office_code,2,2)='"+ district +"' and substr(a.office_code,4,1)='"+mandal+"' and substr(a.office_code,5,2)= '" + panchayat + "'";

 }


if(assetType!=null && !assetType.equals("0"))
	 {// //System.out.println("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
	query=query+ " and a.type_of_asset="+assetType;}
if(fyr != null && !fyr.equals("0"))
	{
		int yr = Integer.parseInt(fyr);
		yr = yr - 2;
		String finyr = String.valueOf(yr);
		//System.out.println("year is  "+yr);
		
		query= query + "   AND SUBSTR(TO_CHAR(a.REP_DATE, 'dd/MM/yyyy'),7,4) >='" + finyr +"' and   SUBSTR(TO_CHAR(a.REP_DATE, 'dd/MM/yyyy'),7,4)<='" + fyr + "' ";
	}


	}
 catch(Exception e)
{
	 //System.out.println("for77777777777777777777777 enumeration "+e);
}
 //System.out.println("for enumeration  1" );
if(!Consti.equals("0"))
	{
	query=query+" and substr(a.lead_hab_CODE,3,3)="+Consti;
	}
	 //System.out.println("for enumeration  2" );
/*if(!fyr.equals("0")&& fyr!=null)
	{
	query=query+" and substr(a.proposal_id,3,4)='"+fyr+"'";
	}*/
	 //System.out.println("for enumeration  3" );
	
if(!Pcode.equals("0") && Pcode!=null)
	{
	query=query+" and a.PROGRAMME_CODE ='"+Pcode+"'";
	}
	 //System.out.println("for enumeration  4" );

	 String a1=" order by a.ESTIMATE_COST  ";
 query=query+" "+a1;

//System.out.println("query is sadiq "  +query);

// //System.out.println("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
 


stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
rs = stmt.executeQuery(query);
rs.last();
Count = rs.getRow();
//System.out.println("count is "+Count);
rs.beforeFirst();
rsm=rs.getMetaData();
Cnt=rsm.getColumnCount();
	
	%>
	
		<%@ include file = "rws_rep_propo_cost_graph.jsp" %>	
	
</TD></TR>
</TABLE>

</body>
</html>
<%@ include file = "footer.jsp" %>
<% }
catch (Exception e)
{
}
finally
{
	conn.close();
}
%>