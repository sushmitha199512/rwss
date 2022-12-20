<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>


<%@ include file="conn.jsp" %>
<%! public String isNull1(int str){
if(str==0)
return "-";
else return str+"";
} %>
<%! public String isNull(String str){
if(str==null)
return "-";
else return str;} %>



<html>
<head>
<title>Graphs</title>
<script language="JavaScript">
</script>
<style>
.mystyle
{
	background-color:silver;
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:7pt;
}

.mytext
{
	height:19px;
	font-size:9px;
	
}
.mytbltext
{
	height:14px;
	font-size:9pt;
	border-width:0;
	width:90pt;
	font-family:verdana;
}
.mynobordertext
{
	height:14px;
	font-size:9pt;
	border-width:0;
	font-family:verdana;
	background-color:#DEE3E0
}

.btext
{
	border-width:1;
	border-color:#000000;
	background-color:#efefef;
	color:#660099;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}
.clrborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-weight:bold;
	font-size:8pt;
	color:#993366;
}
.bwborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	color:#000000;
}
.textborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	font-weight:bold;
	color:#000000;
}
.mycborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-weight:bold;
	font-size:5pt;
}
.mycborder1
{
	padding:0;
	height:15px;
	font-family:verdana;

	font-size:5pt;
	
}

.mycombo

{
	height:14px;
	border-width:0;
	font-size:9pt;
	font-family:verdana;
}
.mytext2
{
	height:14px;
	border-width:0;
	border-style:none;
	font:menu;
}
.myfontclr
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	color:#000000;
	font-weight:bold;
}
.thead
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-weight:bold;
	font-size:9pt;
	color:#ffffff;
}
.myfontclr1
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	color:#000000;
	
	
}
.loginStyle
{
font-family:verdana;
font-width:9pt;
border-width:0;
background-color:#DEE3E0;
color:#6600FF;
font-weight:bold
}
.head
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:10pt;
	color:#000000;
}

.rptHeading
{
	border-width:1;
	color:navy;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.rptLabel
{
	border-width:1;
	border-color:#000000;
	background-color:#efefef;
	color:navy;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt	
}
.rptValue
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;	
	color:#000000;	
}

.rptSubValue
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;	
	color:brown;
	font-weight:bold;
}

.prptHeading
{
	border-width:1;
	color:black;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.prptLabel
{
	border-width:1;
	border-color:#000000;
	color:black;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}

.dateFont
{
	color:black;
	font-family:verdana;
	font-size:8pt;
}
A:link{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:visited{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:hover{font-family:verdana;font-size:8pt;text-decoration:underline;color:#316A95}



</style>



</head>
<body>
<form>

<%
String adCode=String.valueOf(session.getAttribute("dCode"));






String district = request.getParameter("district");
session.setAttribute("district",district);

int tot=0;
int total=0;
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;

String pname="";
String vname="";
int ftk=0;
int gtot=0;
int gtotftk=0;
String cir="";
int pwscount=0;
int cpwscount=0;
int gpwscount=0;
int gcpwscount=0;
int pwshabcount=0;
int gpwshabcount=0;
int cpwshabcount=0;
int gcpwshabcount=0;
String dname="";
int mpwscount=0;
int gmpwscount=0;
int directpumpcount=0;
int gdirectpumpcount=0;;
int mpwshabcount=0;
int gmpwshabcount=0;
int directpumphabcount=0;
int gdirectpumphabcount=0;
int hpcount=0;
int ghpcount=0;
String mname="";

String assettype="";
String assetcode="";
String mandalcode="";

assettype=request.getParameter("hpassettype");
session.setAttribute("assettype",assettype);


int count=0;




int sno=1;
try
{
	String query6="select dname from rws_district_tbl where dcode='"+district+"'";
stmt6=conn.createStatement();
				rs6=stmt6.executeQuery(query6);
				while(rs6.next())
	{
dname=rs6.getString(1);
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	try
	{
		if(rs6!=null)
		{
			rs6.close();
		}
		if(stmt6!=null)
		{
			stmt6.close();
		}
	}
	catch(Exception o)
	{
		o.printStackTrace();
	}
}


%>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home |</a></td>
				
			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#edf2f8" align="center">
	
	
		<td class=rptValue colspan=14><font color="navy">District:<%=dname%> </td>
	


	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Assets Handpumps - With No Borewell Details Report</td>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="50%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center"><tr align=center>

	
               <td class=btext>Sl.No</td>
			   <td class=btext>Mandal</td>
               <td class=btext>Total Handpump's - With out Borewell details</td>
                
			               
   			   
			   </tr>
			   


<%



try
{
			
    	
		
			
		
		
		 
		// String query44="select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where  a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' MINUS select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,rws_hp_subcomp_param_tbl d where   a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and a.asset_code=d.asset_code ";
			 	    
		
			 //	String query66="select A.ASSET_CODE,m.mname from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,rws_mandal_tbl m where c.mcode=m.mcode and a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and a.asset_code='"+assetcode+"' ";
		    String query11="select mcode,mname from rws_mandal_tbl where dcode='"+district+"' order by mcode";
			stmt1=conn.createStatement();
			stmt2=conn.createStatement();
			rs1=stmt1.executeQuery(query11); 
			while(rs1.next())
			{
			String query22="select a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view s where s.panch_code=a.hab_code and  s.dcode='"+district+"' and type_of_asset_code='04' and a.asset_code=b.asset_code and s.mcode='"+rs1.getString(1)+"'  MINUS select a.asset_code from rws_asset_mast_tbl a,rws_hp_subcomp_param_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view p where p.panch_code=a.hab_code and s.asset_code=a.asset_code and p.dcode='"+district+"' and type_of_asset_code='04'  and a.asset_code=b.asset_code and p.mcode='"+rs1.getString(1)+"'  ";

			rs2=stmt2.executeQuery(query22);
			hpcount=0;
			while(rs2.next())
			{
			hpcount++;
			
			}
			ghpcount=hpcount+ghpcount;	     	
						%>
						
						 <%if(hpcount>0)
						{%>
						<tr bgcolor="#ffffff">
						<td class=rptValue><%=sno++%></td>
				       <td class=rptValue><%=rs1.getString(2)%></td>
						<td class=rptValue align="right"><a href="rws_borewells_nodetails_mandal_rpt.jsp?district=<%=district%>&mandal=<%=rs1.getString(1)%>&mandalname=<%=rs1.getString(2)%>"><%=hpcount%></a></td>
						</tr>
						<%}
						}
	%>
	<tr>
	<td colspan=2 class="btext" ALIGN="RIGHT">Total:</td>
	<td class="btext" align="right"><%=ghpcount%></td>
    
    
	
	


	</tr>
	<%
	
	
	
	

}
catch(Exception e)
{
	out.println("Exception"+e);
}
finally
{
try
{
if(rs2!=null)
	{
		rs2.close();
	}
	if(stmt2!=null)
	{
		stmt2.close();
		
	}

if(rs1!=null)
	{
		rs1.close();
	}
	if(stmt1!=null)
	{
		stmt1.close();
		
	}
	
	
	
if(conn != null)
{
conn.close();
}
}
catch(Exception o)
{
o.printStackTrace();
}
}




%>
</table>
</form>

</body>


<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</p>
</html>
