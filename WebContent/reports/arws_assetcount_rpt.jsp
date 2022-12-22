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

//String fdate=String.valueOf(session.getAttribute("FDATE"));

//String dname=String.valueOf(session.getAttribute("dName"));


String dcode = request.getParameter("district");
int tot=0;
int total=0;
Statement stmt1=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null;
ResultSet rs1=null,rs3=null,rs4=null,rs5=null,rs6=null;

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


int sno=1;
try
{
	String query6="select dname from rws_district_tbl where dcode='"+dcode+"'";
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
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>
			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#edf2f8" align="center">
	<%
	if(dcode.equals("51"))
	{
	%>
		<td class=rptValue colspan=14><font color="navy">District:ALL </td>
		<%}
	else if(!dcode.equals("51"))
	{
		%>
		<td class=rptValue colspan=14><font color="navy">District:<%=dname%> </td>
		<%
	}
		%>


	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Schemes - Habs Benefitted</td>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center"><tr align=center>

	
               <td class=btext>Sl.No</td>
               <td class=btext>District</td>
			   <td class=btext>Pws</td>
			   <td class=btext>Pws Habitations Benefited</td>
			  
                
                <td class=btext>Mpws</td>
				<td class=btext>Mpws Habitations Benefited</td>
				<td class=btext>Cpws</td>
				<td class=btext>Cpws Habitations Benefited</td>
			  
				<td class=btext>Direct Pumping</td>
				<td class=btext>Direct Pumping Habitations Benefited</td>
			  
			  
               
   			   
			   </tr>
			   


<%


try
{
	String query = "";
	 if(dcode.equals("51"))
		query="select dcode,dname from rws_district_tbl where dcode<>'16' order by dname";
	else 
		query="select dcode,dname from rws_district_tbl where dcode='"+dcode+"' order by dname";
					

		
		
		stmt1=conn.createStatement();
				rs1=stmt1.executeQuery(query);
		//System.out.println("BPT"+bptq);
		
    	while(rs1.next())
	{     
		String query10="select(select count(*) from rws_asset_hab_tbl where asset_code in (select a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl r where type_of_asset_code='01' and a.asset_code=r.asset_code and substr (a.hab_code,1,2) ='"+rs1.getString(1)+"' and a.hab_code in(select distinct hd.hab_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and substr (h.panch_code,1,2)='"+rs1.getString(1)+"')))a,(select count(*) from rws_asset_hab_tbl where asset_code in (select a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl r where type_of_asset_code='03' and a.asset_code=r.asset_code and substr (a.hab_code,1,2) ='"+rs1.getString(1)+"' and a.hab_code in(select distinct hd.hab_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and substr (h.panch_code,1,2)='"+rs1.getString(1)+"')))b,(select count(*) from rws_asset_hab_tbl where asset_code in (select a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl r where type_of_asset_code='02' and a.asset_code=r.asset_code and substr (a.hab_code,1,2) ='"+rs1.getString(1)+"' and a.hab_code in(select distinct hd.hab_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and substr (h.panch_code,1,2)='"+rs1.getString(1)+"')))c,(select count(*) from rws_asset_hab_tbl where asset_code in (select a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl r where type_of_asset_code='09' and a.asset_code=r.asset_code and substr (a.hab_code,1,2) ='"+rs1.getString(1)+"' and a.hab_code in(select distinct hd.hab_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and substr (h.panch_code,1,2)='"+rs1.getString(1)+"')))d from dual";	
			 pwshabcount=0;
			 cpwshabcount=0;
			 mpwshabcount=0;
			 directpumphabcount=0;
			 stmt4=conn.createStatement();

		 	rs4=stmt4.executeQuery(query10);
			
			while(rs4.next())
		{
			pwshabcount=rs4.getInt(1);

			gpwshabcount=pwshabcount+gpwshabcount;
			cpwshabcount=rs4.getInt(2);
			gcpwshabcount=cpwshabcount+gcpwshabcount;
			mpwshabcount=rs4.getInt(3);
			gmpwshabcount=mpwshabcount+gmpwshabcount;
			directpumphabcount=rs4.getInt(4);
			gdirectpumphabcount=directpumphabcount+gdirectpumphabcount;
		}

		
		
			
		
		
		 String query4="select sum(case when type_of_asset_code='01' then 1 else 0 end) as a1,sum(case when type_of_asset_code='03'then 1 else 0 end) as a2,sum(case when type_of_asset_code='02' then 1 else 0 end) as a3,sum(case when type_of_asset_code='09' then 1 else 0 end) as a4 from rws_asset_mast_tbl a,rws_asset_scheme_tbl b where   substr(hab_code,1,2)='"+rs1.getString(1)+"' and a.asset_code=b.asset_code and  a.hab_code in (select distinct hd.hab_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and substr(h.panch_code,1,2)='"+rs1.getString(1)+"')";
pwscount=0;
cpwscount=0;
mpwscount=0;
directpumpcount=0;
		  stmt3=conn.createStatement();
		 	rs3=stmt3.executeQuery(query4);
		 while(rs3.next())
		{
			 pwscount=rs3.getInt(1);
			 gpwscount=gpwscount+pwscount;
			 cpwscount=rs3.getInt(2);
			 gcpwscount=gcpwscount+cpwscount;
			 mpwscount=rs3.getInt(3);
			 gmpwscount=mpwscount+gmpwscount;
			 directpumpcount=rs3.getInt(4);
			 gdirectpumpcount=directpumpcount+gdirectpumpcount;
			}

	
	     	
						%>
						
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue align="right"><%=pwscount%></td>
				<td class=rptValue align="right"><%=pwshabcount%></td>
				<td class=rptValue align="right"><%=mpwscount%></td>
				<td class=rptValue align="right"><%=mpwshabcount%></td>
				<td class=rptValue align="right"><%=cpwscount%></td>
				<td class=rptValue align="right"><%=cpwshabcount%></td>
                
				<td class=rptValue align="right"><%=directpumpcount%></td>
				<td class=rptValue align="right"><%=directpumphabcount%></td>


               				
				</tr>
<%
	
	}

	%>
	<tr>
	<td colspan=2  align="right"class="btext">Total:</td>
	<td class="btext" align="right"><%=gpwscount%></td>
    <td class="btext" align="right"><%=gpwshabcount%></td>
	
	<td class="btext" align="right"><%=gmpwscount%></td>
    <td class="btext" align="right"><%=gmpwshabcount%></td>
	<td class="btext" align="right"><%=gcpwscount%></td>
    <td class="btext" align="right"><%=gcpwshabcount%></td>

	<td class="btext" align="right"><%=gdirectpumpcount%></td>
    <td class="btext" align="right"><%=gdirectpumphabcount%></td>



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
	if(rs4 !=null)
	{
		rs4.close();
	}
	if(stmt4!=null)
	{
		stmt4.close();
	}
	if(rs3!=null)
	{
		rs3.close();
	}
	if(stmt3!=null)
	{
		stmt3.close();
	}
if(rs1!=null)
{
rs1.close();
}
if(stmt1!=null)
{
stmt1.close();
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
</p>
<%@ include file="/commons/rws_footer.jsp"%>
</html>
