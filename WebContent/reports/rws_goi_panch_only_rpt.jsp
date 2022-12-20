<%@ include file ="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null, a1="",query1=null,currentYear=null,qu1=null;
	int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	int Count=0,i=0;
	 String dCode;
   String mCode;
  String pCode;
	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
	String panchayat=request.getParameter("panchayat");
 String fdate=(String)session.getAttribute("FDate");
String tdate=request.getParameter("TDate");
if(district==null && mandal==null && panchayat==null)
{
   //dCode=String.valueOf(session.getAttribute("dcode"));
 // mCode=String.valueOf(session.getAttribute("mCode")); 
 dCode=request.getParameter("dcode");
  mCode=request.getParameter("mcode");
   pCode=request.getParameter("pcode");
	session.setAttribute("pCode",pCode); 

	 String pName=request.getParameter("pname");
	session.setAttribute("pName",pName); 
}
else
{
dCode=district;
mCode = mandal;
pCode= panchayat;
}

String s=request.getParameter("start");

int slno=0;
try{
	 if(fdate!=null && !fdate.equals("0") )
	{
		a1 =  " and status_date ='" + fdate +"' ";
	}
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
 st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
query1="select distinct to_char(status_date,'yyyy') from rws_habitation_directory_tbl h where status_date is not null";
rs2=st7.executeQuery(query1);
while (rs2.next())
	{
    currentYear=rs2.getString(1);
	}
/*java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
java.util.Date currentDate = new java.util.Date();
currentYear= dateFormat.format(currentDate).substring(0,4);*/

 if(fdate.substring(7,11).equals(currentYear))
	{
 qu1 = "SELECT pr.panch_name,nvl(coverage_status,'--')  from rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+"' and  substr(h.hab_code,13,2)='"+pCode+"' and status_date ='" + fdate +"' and h.coverage_status is not null order by coverage_status";
	}
	else
	{
       qu1 = "SELECT pr.panch_name,nvl(coverage_status,'--')  from rws_panchayat_raj_tbl pr,rws_habitation_dir_his_tbl h where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+"' and  substr(h.hab_code,13,2)='"+pCode+"' and status_date ='" + fdate +"' and h.coverage_status is not null order by coverage_status";
	}
//	r6=st6.executeQuery("SELECT dcode,dname FROM RWS_DISTRICT_tbl order by dname");	
	r6=st6.executeQuery(qu1);	
	r6.last();
	Count = r6.getRow();
	
	
	r6.beforeFirst();
	// ////// System.out.println("eeeeee555555555555555555");
	
%>
<html>
<head>
<script>
	window.history.forward(1);
</script>
<title> WaterSoft </title>

</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_goi_coverage_frm.jsp">Back|&nbsp;</a>
				<a href="../home.jsp">Home|</a>
				<!--<a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_coverage_status_rpt_print_excel.jsp" target="_new">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Habitation Coverage Status  Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
<%if(fdate!=null && !fdate.equals("0") )
	{%>
<tr><td></td>
		<td class="textborder" align="center">
			<font size=2>Status As On : </font><font color=#F2A80D> <%=fdate %> </font></td>
	</tr>
	<% }%>
	<tr><% if(!dCode.equals("51")) {%>
	<td align="center" class="btext"><font color="navy">District: <%=session.getAttribute("dName") %><% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="btext"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="btext"><font color="navy">Panchayat: <%=session.getAttribute("pName") %></font></td>
</tr>
<%} %>


</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
String covstatus=null;
// ////// System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
		<tr>	
	
		<td class="btext" >S.NO.</td>
		<td class="btext" >Habitation</td>
		<td class="btext" >Coverage Status</td> 
</tr>	

<%	 
if(Count!=0){
	 if(request.getParameter("start") !=  null) {
	start = Integer.parseInt(request.getParameter("start"));
	// ////// System.out.println("start values  is "+start);
		}
		else
		{
			start = 1;
			
		}
		end = start + limit;
		
		for(int j = start; j <= Count ; j++)
		{	//rs6.next();
			r6.absolute(j);	
			if(r6.getString(2).equals("PC4")||r6.getString(2).equals("PC3")||r6.getString(2).equals("PC2"))
			covstatus="PC";
            if(r6.getString(2).equals("NC")||r6.getString(2).equals("PC1"))
			covstatus="NC";
			 if(r6.getString(2).equals("FC"))
			covstatus="FC";
	%>
	  
		<tr align=left bgcolor="#ffffff">
			<td class="rptValue"><%=j%> </td>
			<td class="rptValue"><%=r6.getString(1) %> </td> 
			<% if(covstatus!=null && !covstatus.equals("")) { %>
		 <td class="rptValue"><%=covstatus %> </td>
			<%} else {%>
			 <td class="rptValue">-</td>
			<%}%>
		</tr>
		<%
		}
}else { // ////// System.out.println("There are no Recoreds");%>
<%="There are no Records"%>
<%}

}catch(Exception e)
{e.printStackTrace();}
finally
{
	conn.close();
}
%>
</table>
</td></tr>
</table>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>