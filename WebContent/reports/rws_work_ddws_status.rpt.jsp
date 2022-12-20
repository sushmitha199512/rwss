<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<body>
<%

String dist=request.getParameter("dist");
String div=request.getParameter("div");
String subdiv=request.getParameter("subdiv");
String mand=request.getParameter("mand");
String panch=request.getParameter("panch");
String vill=request.getParameter("vill");
String hab=request.getParameter("hab");
String atype=request.getParameter("atype");
String ast=request.getParameter("ast");
String ftype=request.getParameter("ftype");
// System.out.println("ftype:"+ftype);
String pwsqry="", mpwsqry="",cpwsqry="",hpqry="",shpqry="",openqry="",pondqry="",othqry="";
int sno=1;
int coltot1=0,coltot2=0,coltot3=0,coltot4=0,coltot5=0,coltot6=0,coltot7=0,coltot8=0;
//// System.out.println("d:"+dist+":m:"+mand+":p:"+panch+":v:"+vill+":h:"+hab+":a:"+atype);
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
Statement stmt1 = null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null;
int atot=0,habtot=0,fc=0,pc4=0,pc3=0,pc2=0,pc1=0,nc=0,nss=0;		

%>
<table border = 0 width=100%><tr><td>
<table border = 0 width=20% align=left>

 <%if(request.getParameter("subdivisionName")!=null && !request.getParameter("subdivisionName").equals("")){ %>
 <tr><td colspan=2><b><font face=verdana size=2>Selection Criteria:</font></b></td></tr>
<tr><td class=btext>Circle:</td><td><font face=verdana size=2><%=request.getParameter("districtName")%></td></tr>
<tr><td class=btext>Division:</td><td><font face=verdana size=2><%=request.getParameter("divisionName")%></td>
</tr>
<%}else if(request.getParameter("divisionName")!=null && !request.getParameter("divisionName").equals("")){ %>
<tr><td colspan=2><b><font face=verdana size=2>Selection Criteria:</font></b></td></tr>
<tr>
<td class=btext>Circle:</td><td><font face=verdana size=2><%=request.getParameter("districtName")%></td>
</tr>
<%}
else if(request.getParameter("districtName")!=null && !request.getParameter("districtName").equals("") && dist.equals("00")){ %>
<tr><td colspan=2><b><font face=verdana size=2>Selection Criteria:</font></b></td></tr>
<tr><td class=btext>Circle:</td><td><font face=verdana size=2><%=request.getParameter("districtName")%></td></tr>
<%}
%>
</table></td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.back(-1)">Back|</a> 
					<a href="../home.jsp">Home</a>
                   			
				</tr>
			</table>
		</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="11">
		<font color="ffffff">Project Shelf  Vs Habitation Status Report </font></td>
	</tr>
	<tr align="center" bgcolor="#ffffff">
			<td class=btext >SNO</td>
			<%if(subdiv!=null && !subdiv.equals("-1")) {%>
			<td class=btext >Subdivision</td>
			<%} else if(div!=null && !div.equals("-1")) {%>
			<td class=btext >Division</td>
			<%}else if(dist!=null && !dist.equals("00")) {%>
			<td class=btext >Circle</td>
			<%} else {%>
			<td class=btext >Circle</td>
			<%}%>
			<td class=btext size=2 align=center>PWS</td>
			<td class=btext size=2 align=center>MPWS</td>
			<td class=btext size=2 align=center>CPWS</td>	
			<td class=btext size=2 align=center>HAND PUMPS</td>
			<td class=btext size=2 align=center>OPEN WELLS</td>
			<td class=btext size=2 align=center>PONDS</td>
			<td class=btext size=2 align=center>SHALLOW HANDPUMPS</td>
			<td class=btext size=2 align=center>OTHERS</td>
			
			</tr>
<%
if(ast.equals("1"))
{
pwsqry="select count(*),substr(work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b,rws_district_tbl d where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)=d.dcode and type_of_asset_code='01'"; 
if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
	{
	 pwsqry+=" and substr(work_id,5,2)='"+dist+"' ";
	} 
	if(div!=null  && !div.equals("")  && !div.equals("-1")  && !div.equals("00"))
	{
	 pwsqry+=" and  b.division_office_code ='"+div+"' ";
	} 
	if(subdiv!=null  && !subdiv.equals("")  && !subdiv.equals("-1")  && !subdiv.equals("00"))
	{
	 pwsqry+=" and  b.subdivision_office_code ='"+subdiv+"' ";
	} 
	if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
	{
	 pwsqry+=" and  a.fin_year ='"+ftype+"' ";
	} 
pwsqry+="group by substr (work_id,5,2),d.dname order by d.dname";

mpwsqry="select count(*),substr(work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b,rws_district_tbl d where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)=d.dcode and type_of_asset_code='02' "; 
if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
	{
	 mpwsqry+=" and substr(work_id,5,2)='"+dist+"' ";
	}
	if(div!=null  && !div.equals("")  && !div.equals("-1")  && !div.equals("00"))
	{
	 mpwsqry+=" and  b.division_office_code ='"+div+"' ";
	} 
	if(subdiv!=null  && !subdiv.equals("")  && !subdiv.equals("-1")  && !subdiv.equals("00"))
	{
	mpwsqry+=" and  b.subdivision_office_code ='"+subdiv+"' ";
	} 
	if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
	{
	 mpwsqry+=" and  a.fin_year ='"+ftype+"' ";
	} 
mpwsqry+="group by substr (work_id,5,2),d.dname order by d.dname";

cpwsqry="select count(*),substr(work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b,rws_district_tbl d where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)=d.dcode and type_of_asset_code='03'";
if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
	{
	 cpwsqry+=" and substr(work_id,5,2)='"+dist+"' ";
	}
	if(div!=null  && !div.equals("")  && !div.equals("-1")  && !div.equals("00"))
	{
	 cpwsqry+=" and  b.division_office_code ='"+div+"' ";
	} 
	if(subdiv!=null  && !subdiv.equals("")  && !subdiv.equals("-1")  && !subdiv.equals("00"))
	{
	 cpwsqry+=" and  b.subdivision_office_code ='"+subdiv+"' ";
	} 
	
	if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
	{
	 cpwsqry+=" and  a.fin_year ='"+ftype+"' ";
	} 
	cpwsqry+="group by substr (work_id,5,2),d.dname order by d.dname";
hpqry="select count(*),substr(work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b,rws_district_tbl d where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)=d.dcode and type_of_asset_code='04' ";
if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
	{
	 hpqry+=" and substr(work_id,5,2)='"+dist+"' ";
	}
	if(div!=null  && !div.equals("")  && !div.equals("-1")  && !div.equals("00"))
	{
	 hpqry+=" and  b.division_office_code ='"+div+"' ";
	} 
	if(subdiv!=null  && !subdiv.equals("")  && !subdiv.equals("-1")  && !subdiv.equals("00"))
	{
	 hpqry+=" and  b.subdivision_office_code ='"+subdiv+"' ";
	} 
	if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
	{
	 hpqry+=" and  a.fin_year ='"+ftype+"' ";
	} 
hpqry+="group by substr (work_id,5,2),d.dname order by d.dname";

shpqry="select count(*),substr(work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b,rws_district_tbl d where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)=d.dcode and type_of_asset_code='05' ";
if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
	{
	 shpqry+=" and substr(work_id,5,2)='"+dist+"' ";
	}
	if(div!=null  && !div.equals("")  && !div.equals("-1")  && !div.equals("00"))
	{
	 shpqry+=" and  b.division_office_code ='"+div+"' ";
	} 
	if(subdiv!=null  && !subdiv.equals("")  && !subdiv.equals("-1")  && !subdiv.equals("00"))
	{
	 shpqry+=" and  b.subdivision_office_code ='"+subdiv+"' ";
	} 
	if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
	{
	 shpqry+=" and  a.fin_year ='"+ftype+"' ";
	} 
shpqry+="group by substr (work_id,5,2),d.dname order by d.dname";
openqry="select count(*),substr(work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b,rws_district_tbl d where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)=d.dcode and type_of_asset_code='06' ";
if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
	{
	 openqry+=" and substr(work_id,5,2)='"+dist+"' ";
	}
	if(div!=null  && !div.equals("")  && !div.equals("-1")  && !div.equals("00"))
	{
	 openqry+=" and  b.division_office_code ='"+div+"' ";
	} 
	if(subdiv!=null  && !subdiv.equals("")  && !subdiv.equals("-1")  && !subdiv.equals("00"))
	{
	 openqry+=" and  b.subdivision_office_code ='"+subdiv+"' ";
	} 
	if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
	{
	 openqry+=" and  a.fin_year ='"+ftype+"' ";
	} 
openqry+="group by substr (work_id,5,2),d.dname order by d.dname";
pondqry="select count(*),substr(work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b,rws_district_tbl d where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)=d.dcode and type_of_asset_code='07' ";
if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
	{
	 pondqry+=" and substr(work_id,5,2)='"+dist+"' ";
	}
  if(div!=null  && !div.equals("")  && !div.equals("-1")  && !div.equals("00"))
	{
	 pondqry+=" and  b.division_office_code ='"+div+"' ";
	} 
	if(subdiv!=null  && !subdiv.equals("")  && !subdiv.equals("-1")  && !subdiv.equals("00"))
	{
	 pondqry+=" and  b.subdivision_office_code ='"+subdiv+"' ";
	} 
	if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
	{
	 pondqry+=" and  a.fin_year ='"+ftype+"' ";
	} 
pondqry+="group by substr (a.work_id,5,2),d.dname order by d.dname";
othqry="select count(*),substr(work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_asset_mast_tbl b,rws_district_tbl d where a.work_id=b.asset_code and work_asset='A' and substr(a.work_id,5,2)=d.dcode and type_of_asset_code='08'";
if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
	{
	 othqry+=" and substr(work_id,5,2)='"+dist+"' ";
	}
	  if(div!=null  && !div.equals("")  && !div.equals("-1")  && !div.equals("00"))
	{
	 othqry+=" and  b.division_office_code ='"+div+"' ";
	} 
	if(subdiv!=null  && !subdiv.equals("")  && !subdiv.equals("-1")  && !subdiv.equals("00"))
	{
	 othqry+=" and  b.subdivision_office_code ='"+subdiv+"' ";
	} 
	if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
	{
	 othqry+=" and  a.fin_year ='"+ftype+"' ";
	} 
othqry+="group by substr (work_id,5,2),d.dname order by d.dname";
}else if(ast.equals("2"))
{
		pwsqry="select count(*),substr(a.work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_work_admn_tbl b,rws_district_tbl d where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)=d.dcode and type_of_asset='01' ";
		if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
		{
		 pwsqry+=" and substr(a.work_id,5,2)='"+dist+"' ";
		} 
		if(div!=null && !div.equals("-1"))
		{
			pwsqry+=" and substr(office_code,4,1)='"+div+"' ";
		}
		if(subdiv!=null && !subdiv.equals("-1"))
		{
		  pwsqry+=" and substr(office_code,5,2)='"+subdiv+"' ";
		}
		if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
		{
		pwsqry+=" and  a.fin_year ='"+ftype+"' ";
		} 
		pwsqry+="group by substr (a.work_id,5,2),d.dname order by d.dname";
		mpwsqry="select count(*),substr(a.work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_work_admn_tbl b,rws_district_tbl d where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)=d.dcode and type_of_asset='02' ";
		if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
		{
		 mpwsqry+=" and substr(a.work_id,5,2)='"+dist+"' ";
		}
		if(div!=null && !div.equals("-1"))
		{
			mpwsqry+=" and substr(office_code,4,1)='"+div+"' ";
		}
		if(subdiv!=null && !subdiv.equals("-1"))
		{
		  mpwsqry+=" and substr(office_code,5,2)='"+subdiv+"' ";
		}
		if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
		{
			mpwsqry+=" and  a.fin_year ='"+ftype+"' ";
		} 
		mpwsqry+="group by substr (a.work_id,5,2),d.dname order by d.dname";
		cpwsqry="select count(*),substr(a.work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_work_admn_tbl b,rws_district_tbl d where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)=d.dcode and type_of_asset='03' ";
		if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
		{
		 cpwsqry+=" and substr(a.work_id,5,2)='"+dist+"' ";
		}
		if(div!=null && !div.equals("-1"))
		{
			cpwsqry+=" and substr(office_code,4,1)='"+div+"' ";
		}
		if(subdiv!=null && !subdiv.equals("-1"))
		{
		  cpwsqry+=" and substr(office_code,5,2)='"+subdiv+"' ";
		}
		if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
		{
			cpwsqry+=" and  a.fin_year ='"+ftype+"' ";
		} 
		cpwsqry+="group by substr (a.work_id,5,2),d.dname order by d.dname";
		hpqry="select count(*),substr(a.work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_work_admn_tbl b,rws_district_tbl d where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)=d.dcode and type_of_asset='04' ";
		if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
		{
		 hpqry+=" and substr(a.work_id,5,2)='"+dist+"' ";
		}
		if(div!=null && !div.equals("-1"))
		{
			hpqry+=" and substr(office_code,4,1)='"+div+"' ";
		}
		if(subdiv!=null && !subdiv.equals("-1"))
		{
		  hpqry+=" and substr(office_code,5,2)='"+subdiv+"' ";
		}
		if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
		{
		  hpqry+=" and  a.fin_year ='"+ftype+"' ";
		} 
		hpqry+="group by substr (a.work_id,5,2),d.dname order by d.dname";
		shpqry="select count(*),substr(a.work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_work_admn_tbl b,rws_district_tbl d where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)=d.dcode and type_of_asset='05' ";
		if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
		{
		 shpqry+=" and substr(a.work_id,5,2)='"+dist+"' ";
		}
		if(div!=null && !div.equals("-1"))
		{
			shpqry+=" and substr(office_code,4,1)='"+div+"' ";
		}
		if(subdiv!=null && !subdiv.equals("-1"))
		{
		  shpqry+=" and substr(office_code,5,2)='"+subdiv+"' ";
		}
		if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
		{
			shpqry+=" and  a.fin_year ='"+ftype+"' ";
		} 
		shpqry+="group by substr (a.work_id,5,2),d.dname order by d.dname";
		openqry="select count(*),substr(a.work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_work_admn_tbl b,rws_district_tbl d where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)=d.dcode and type_of_asset='06' ";
		if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
		{
		 openqry+=" and substr(a.work_id,5,2)='"+dist+"' ";
		}
		if(div!=null && !div.equals("-1"))
		{
			openqry+=" and substr(office_code,4,1)='"+div+"' ";
		}
		if(subdiv!=null && !subdiv.equals("-1"))
		{
		  openqry+=" and substr(office_code,5,2)='"+subdiv+"' ";
		}
		if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
		{
		openqry+=" and  a.fin_year ='"+ftype+"' ";
		} 
		openqry+="group by substr (a.work_id,5,2),d.dname order by d.dname";
		pondqry="select count(*),substr(a.work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_work_admn_tbl b,rws_district_tbl d where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)=d.dcode and type_of_asset='07' ";
		 if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
		{
		 pondqry+=" and substr(a.work_id,5,2)='"+dist+"' ";
		}
		if(div!=null && !div.equals("-1"))
		{
			pondqry+=" and substr(office_code,4,1)='"+div+"' ";
		}
		if(subdiv!=null && !subdiv.equals("-1"))
		{
		  pondqry+=" and substr(office_code,5,2)='"+subdiv+"' ";
		}
		if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
		{
		pondqry+=" and  a.fin_year ='"+ftype+"' ";
		} 
		pondqry+="group by substr (a.work_id,5,2),d.dname order by d.dname";
		othqry="select count(*),substr(a.work_id,5,2),d.dname from rws_ddws_scheme_data_port a,rws_work_admn_tbl b,rws_district_tbl d where a.work_id=b.work_id and work_asset='W' and substr(a.work_id,5,2)=d.dcode and type_of_asset='08' ";
		if(dist!=null  && !dist.equals("")  && !dist.equals("00"))
		{
		 othqry+=" and substr(a.work_id,5,2)='"+dist+"' ";
		}
		if(div!=null && !div.equals("-1"))
		{
			othqry+=" and substr(office_code,4,1)='"+div+"' ";
		}
		if(subdiv!=null && !subdiv.equals("-1"))
		{
		  othqry+=" and substr(office_code,5,2)='"+subdiv+"' ";
		}
		if(ftype!=null  && !ftype.equals("")  && !ftype.equals("-1") )
		{
		othqry+=" and  a.fin_year ='"+ftype+"' ";
		} 
		othqry+="group by substr (a.work_id,5,2),d.dname order by d.dname";
 }
   stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
	//// System.out.println("pwsqry:"+pwsqry);
    rs=stmt.executeQuery(pwsqry);

	stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	//// System.out.println("mpws:"+mpwsqry);
    rs1=stmt1.executeQuery(mpwsqry);

	stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	 //// System.out.println("cpws:"+cpwsqry);
    rs2=stmt2.executeQuery(cpwsqry);
	
	stmt3=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	 //// System.out.println("hp:"+hpqry);
    rs3=stmt3.executeQuery(hpqry);

	stmt4=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	 //// System.out.println("shp:"+shpqry);
    rs4=stmt4.executeQuery(shpqry);

	stmt5=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	// // // System.out.println("open:"+openqry);
    rs5=stmt5.executeQuery(openqry);

	stmt6=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	rs6=stmt6.executeQuery(pondqry);

	stmt7=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	rs7=stmt7.executeQuery(othqry);

	String qry="select dcode,dname from rws_district_tbl  where dcode<>16 order by dname";
	stmt8=conn.createStatement();
	// // // System.out.println("qry:"+qry);
	rs8=stmt8.executeQuery(qry);
if(dist!=null && !dist.equals("") && !dist.equals("00"))
	{
		
		%>
		<tr>
		<td class="rptValue" align=left><%=sno++%></td>
		<td class="rptValue" align=left><%=request.getParameter("districtName")%></td>
		<%if(rs.next()) {
				coltot1+=rs.getInt(1);%>
		<td class="rptValue" align=right>
		<a href="rws_work_ddws_detail_rpt.jsp?acode=01&ast=<%=ast%>&dcode=<%=dist%>
			&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs.getInt(1)%></td>
		<%}else {%>
		<td class="rptValue" align=right>0</td>
		<%}%>
		<%if(rs1.next()) {
			coltot2+=rs1.getInt(1);%>
		<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=02&ast=<%=ast%>&dcode=<%=dist%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs1.getInt(1)%></td>
		<%}else {%>
		<td class="rptValue" align=right>0</td>
		<%}%>
		<%if(rs2.next()) {
			coltot3+=rs2.getInt(1);%>
		<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=03&ast=<%=ast%>&dcode=<%=dist%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs2.getInt(1)%></td>
		<%} else {%>
		<td class="rptValue" align=right>0</td>
		<%}%>
		<%if(rs3.next()) {
			coltot4+=rs3.getInt(1);%>
		<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=04&ast=<%=ast%>&dcode=<%=dist%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs3.getInt(1)%></td>
		<%}else {%>
		<td class="rptValue" align=right>0</td>
		<%}%>
		<%if(rs4.next()) {
			coltot5+=rs4.getInt(1);%>
		<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=05&ast=<%=ast%>&dcode=<%=dist%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs4.getInt(1)%></td>
		<%}else {%>
		<td class="rptValue" align=right>0</td>
		<%}%>
		<%if(rs5.next()) {
			coltot6+=rs5.getInt(1);%>
		<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=06&ast=<%=ast%>&dcode=<%=dist%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs5.getInt(1)%></td>
		<%}else {%>
		<td class="rptValue" align=right>0</td>
		<%}%>
		<%if(rs6.next()) {
			coltot7+=rs6.getInt(1);%>
		<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=07&ast=<%=ast%>&dcode=<%=dist%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs6.getInt(1)%></td>
		<%}else {%>
		<td class="rptValue" align=right>0</td>
		<%}%>

		<%if(rs7.next()) {
			coltot8+=rs7.getInt(1);%>
		<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=08&ast=<%=ast%>&dcode=<%=dist%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs7.getInt(1)%></td>
		<%}else {%>
		<td class="rptValue" align=right>0</td>
		<%}%>
		
		</tr>

		<%
	}
	else{
while(rs8.next())
	{
		
		%>
		<tr>
			<td class="rptValue" align=left><%=sno++%></td>
			<td class=rptValue nowrap><%=rs8.getString(2)%></td>
			<%
			if(rs.next())//pws
		{
		%>
			<%if (rs8.getInt(1)==rs.getInt(2)) {
					coltot1+=rs.getInt(1);
			%>
			<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=01&ast=<%=ast%>&dcode=<%=rs8.getString(1)%>
			&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs.getInt(1)%></a></td>
		 <%} else
				{
			rs.previous();
			%>
			 <td class="rptValue" align=right>0</td>
			<%
				}
		}
		else
		{
		%>
			<td class="rptValue" align=right>0</td>
		<%
		}
		if(rs1.next())//mpws
		{
		%>
			<%if (rs8.getInt(1)==rs1.getInt(2)) {
					coltot2+=rs1.getInt(1);
			%>
			<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=02&ast=<%=ast%>&dcode=<%=rs8.getString(1)%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs1.getInt(1)%></a></td>
		 <%} else
				{
			rs1.previous();
			%>
			 <td class="rptValue" align=right>0</td>
			<%
				}
		}
		else
		{
		%>
			<td class="rptValue" align=right>0</td>
		<%
		}
		if(rs2.next())//cpws
		{
		%>
			<%if (rs8.getInt(1)==rs2.getInt(2)) {
					coltot3+=rs2.getInt(1);
			%>
			<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=03&ast=<%=ast%>&dcode=<%=rs8.getString(1)%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs2.getInt(1)%></a></td>
		 <%} else
				{
				rs2.previous();
			%>
			 <td class="rptValue" align=right>0</td>
			<%
				}
		}
		else
		{
	%>
	<td class="rptValue"align=right>0</td>
		<%
		}
		if(rs3.next())//hp
		{
		%>
			<%if (rs8.getInt(1)==rs3.getInt(2)) {
					coltot4+=rs3.getInt(1);
			%>
			<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=04&ast=<%=ast%>&dcode=<%=rs8.getString(1)%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs3.getInt(1)%></a></td>
		 <%} else
				{
			rs3.previous();
			%>
			 <td class="rptValue" align=right>0</td>
			<%
				}
		}
		else
		{
		%>
			<td class="rptValue"align=right>0</td>
		<%
		}
		if(rs4.next())//Shp
		{
		%>
			<%if (rs8.getInt(1)==rs4.getInt(2)) {
					coltot5+=rs4.getInt(1);
			%>
			<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=05&ast=<%=ast%>&dcode=<%=rs8.getString(1)%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs4.getInt(1)%></a></td>
		 <%} else
				{
			rs4.previous();
			%>
			 <td class="rptValue" align=right>0</td>
			<%
				}
		}
		else
		{
		%>
			<td class="rptValue"align=right>0</td>
		<%
		}

		if(rs5.next())//open wells
		{
		%>
			<%if (rs8.getInt(1)==rs5.getInt(2)) {
					coltot6+=rs5.getInt(1);
			%>
			<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=06&ast=<%=ast%>&dcode=<%=rs8.getString(1)%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs5.getInt(1)%></a></td>
		 <%} else
				{
			rs5.previous();
			%>
			 <td class="rptValue" align=right>0</td>
			<%
				}
		}
		else
		{
		%>
			<td class="rptValue"align=right>0</td>
		<%
		}

		if(rs6.next())//ponds
		{
		%>
			<%if (rs8.getInt(1)==rs6.getInt(2)) {
					coltot7+=rs6.getInt(1);
			%>
			<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=07&ast=<%=ast%>&dcode=<%=rs8.getString(1)%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs6.getInt(1)%></a></td>
		 <%} else
				{
			rs6.previous();
			%>
			 <td class="rptValue" align=right>0</td>
			<%
				}
		}
		else
		{
		%>
			<td class="rptValue" align=right>0</td>
		<%
		}

		
		if(rs7.next())//Others
		{
		%>
			<%if (rs8.getInt(1)==rs7.getInt(2)) {
					coltot8+=rs7.getInt(1);
			%>
			<td class="rptValue" align=right><a href="rws_work_ddws_detail_rpt.jsp?acode=08&ast=<%=ast%>&dcode=<%=rs8.getString(1)%>&div=<%=div%>&subdiv=<%=subdiv%>"><%=rs7.getInt(1)%></a></td>
		 <%} else
				{
			rs7.previous();
			%>
			 <td class="rptValue" align=right>0</td>
			<%
				}
		}
		else
		{
		%>
			<td class="rptValue" align=right>0</td>
		<%
		}
	}
	}
	%>
 <tr>
	<td class=btext colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total</td>
				<td class=rptValue  align=right><%=coltot1%></td>
				<td class=rptValue  align=right><%=coltot2%></td>
				<td class=rptValue  align=right><%=coltot3%></td>
				<td class=rptValue  align=right><%=coltot4%></td>
				<td class=rptValue  align=right><%=coltot5%></td>
				<td class=rptValue  align=right><%=coltot6%></td>
				<td class=rptValue  align=right><%=coltot7%></td>
				<td class=rptValue  align=right><%=coltot8%></td>
	       </tr>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>