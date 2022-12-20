<%@ page import="java.util.*,java.text.DecimalFormat,ChartDirector.*,java.sql.*,java.text.SimpleDateFormat" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>
<%		int repcode=0,totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnc=0,totnss=0;
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null,r8=null;
	int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};	
	String query = null;
		String a1="";

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
  String fdate=request.getParameter("FDate");
String tdate=request.getParameter("TDate");
 
 // //System.out.println("district="+district);
 // //System.out.println("mandal="+mandal);
 // //System.out.println("panchayat="+panchayat);

// //System.out.println("dDDDDDDDDDDDDDDD"+session.getAttribute("dName") );
 // //System.out.println("mMMMMMMMMMMMMMMl="+session.getAttribute("mName"));
 // //System.out.println("pPPPPPPPPPPPPPPPP="+session.getAttribute("pName"));
 
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 

 // //System.out.println("dDDDDDDDDDDDDDDD       "+dCode ); 
 // //System.out.println("mMMMMMMMMMcode  ="+mCode);
 // //System.out.println("pPPPPPPPPPPPPPPPP="+session.getAttribute("pCode"));

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
		<tr>
			 
		</tr>
	
	
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_scheme_work_proposal_graph_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a>
				
			
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Scheme Wise Work Proposal Graph Report </font></td>
	</tr>
<tr><td valign=top align=center>
<% if(!dCode.equals("51")) {%>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center width=100%>	
	<tr><% if(!dCode.equals("51")) {%>
	<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %><% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Sub Division: <%=session.getAttribute("pName") %></font></td>
</tr>
<%} if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0"))
	{%>
<tr >
		<td class="textborder" align="center">
			<font size=2>Proposals Between Dates: </font><font color=#F2A80D> <%=fdate %> </font>&nbsp;&nbsp; TO &nbsp;&nbsp;<font  color=#FE8C41> <%= tdate %></font></td>
	</tr>
	<% }%>

</table>
<%}%>
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
a1 = "  group by at.TYPE_OF_ASSET_NAME ";
	if(dCode.equals("51"))
		{
		
			 qu1 = "SELECT at.TYPE_OF_ASSET_NAME,count(rp.TYPE_OF_ASSET) from rws_work_proposal_tbl rp, RWS_ASSET_TYPE_TBL  at where rp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE ";
			
		}
		else if(!dCode.equals("51") && mCode.equals("null"))
		{
			// //System.out.println("val    sadiq ali"+district);
			
			 qu1 = "SELECT at.TYPE_OF_ASSET_NAME,count(rp.TYPE_OF_ASSET) from rws_work_proposal_tbl rp, RWS_ASSET_TYPE_TBL  at where rp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE and substr(rp.office_code,2,2)='"+district+"'   ";
		 }	
		 else if((!dCode.equals("51") || mCode.equals("5200")) && pCode.equals("null"))
			 {
			// //System.out.println("val    sadiq ali"+district);
			
			 qu1 = "SELECT at.TYPE_OF_ASSET_NAME,count(rp.TYPE_OF_ASSET) from rws_work_proposal_tbl rp, RWS_ASSET_TYPE_TBL  at where rp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE and substr(rp.office_code,2,2)='"+district+"'  ";
		 }	
		 else if(!mCode.equals("5200") || pCode.equals("5300") ||  !mCode.equals("0"))
			 {
			qu1 = "SELECT at.TYPE_OF_ASSET_NAME,count(rp.TYPE_OF_ASSET) from rws_work_proposal_tbl rp, RWS_ASSET_TYPE_TBL  at where rp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE and substr(rp.office_code,2,2)='"+district+"'  and substr(rp.office_code,4,1)='"+mandal+"' ";
		}	
		if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0"))
	{
		qu1 = qu1 + " and to_char(rp.PREPARED_ON,'dd/mm/yyyy') >='" + fdate +"' and to_char(rp.PREPARED_ON,'dd/mm/yyyy') <= '"+ tdate +"' ";
	}
	qu1 = qu1 + a1;
		r6=st6.executeQuery(qu1);	
		r6.last();
		Count = r6.getRow();
		// //System.out.println("coount of rows is    "+Count);	
		r6.beforeFirst();	


		
try{
	
/*
	String[] record = null;
	ArrayList myList = new ArrayList();
	while(rs.next())
	{
		record = new String[Count];
		for(int z=0,c=1;z<Count && c<=Count;z++,c++)
		{
		record[z] = rs.getString(c);
		}
		myList.add(record);

	}

	session.setAttribute("arrayList", myList);
	//RwsOffices rw=new RwsOffices(ds);
	//session.setAttribute("RSet1",rw);
*/
	//System.out.println("sadiq...");
}catch(Exception e)
{
	//System.out.println("knk error is   "+e);
	//e.printStackTrace();
}
		}
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	%>
	
		<%@ include file = "rws_scheme_work_propo_graph.jsp" %>	
	
</TD></TR>
</TABLE>

</body>
</html>
<%@ include file = "footer.jsp" %>
<% conn.close();%>