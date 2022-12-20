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
String dCode=String.valueOf(session.getAttribute("dCode"));

//String fdate=String.valueOf(session.getAttribute("FDATE"));
String fdate=request.getParameter("FDate");
String dname=String.valueOf(session.getAttribute("dName"));


if(dCode.equals("51") && fdate.equals("51"))
{
int tot=0;
int total=0;
Statement stmt1=null,stmt3=null;
ResultSet rs1=null,rs3=null;

String pname="";
String vname="";
int ftk=0;
int gtot=0;
int gtotftk=0;
String cir="";
int watersample=0;
int testresult=0;
int gwatersample=0;
int gftk=0;
int gtestresult=0;


int sno=1;


%>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>
			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#edf2f8" align="center">
		<td class=rptValue colspan=14><font color="navy">District:ALL &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   Year :ALL</td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Water Quality Abstract </td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse" ><tr align=center>

	
               <td class=btext>Sl.No</td>
               <td class=btext>District</td>
			   <td class=btext>Total Lab Tested Sources</td>
			   <td class=btext>Total Lab Tested Sources<BR> Having Test Results</td>
			   <td class=btext>Total FTK Tested Sources</td>

   			   
			   </tr>
			   


<%


try
{
	 
		
		
				String query="select  dcode,dname from rws_district_tbl where dcode<>'16' order by dname";
				//count(*),d.dname,d.dcode from rws_water_sample_collect_tbl c,rws_habitation_directory_tbl hd,rws_district_tbl d 				 where  hd.hab_code=c.hab_code  and  hd.coverage_status is not null and hd.coverage_status <> 'UI'  and ftk_test_id is null  and c.test_id is not null and substr(source_code,1,2)=d.dcode group by d.dname,d.dcode order by d.dcode ";
		
		
		
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(query);
		////System.out.println("BPT"+bptq);
		
    	while(rs1.next())
	{     
		
		

			
		
		 String query4="select (select count(*) from rws_water_sample_collect_tbl c,rws_habitation_directory_tbl hd where hd.hab_code=c.hab_code and hd.coverage_status is not null and substr(hd.hab_code,1,2)='"+rs1.getString(1)+"' and hd.coverage_status <> 'UI' and c.test_id is not null ) a1,(select count(*) from rws_water_sample_collect_tbl c,rws_habitation_directory_tbl hd ,RWS_WQ_TEST_RESULTS_TBL r where hd.hab_code=c.hab_code and hd.coverage_status is not null and substr (hd.hab_code,1,2)='"+rs1.getString(1)+"' and hd.coverage_status <> 'UI' and c.test_id is not null and r.test_id=c.test_id)a2, (select count(*) from rws_ftk_testing_tbl c,rws_habitation_directory_tbl hd where hd.hab_code=substr (c.source_code,1,16) and hd.coverage_status is not null and hd.coverage_status <> 'UI' and substr (hd.hab_code,1,2)='"+rs1.getString(1)+"')a3 from dual ";
		 //out.println(query4);
		
		  stmt3=conn.createStatement();
		  rs3=stmt3.executeQuery(query4);
		  watersample=0;
		  testresult=0;
		  ftk=0;
		 while(rs3.next())
		{
			 watersample=rs3.getInt(1);
			 testresult=rs3.getInt(2);
			 ftk=rs3.getInt(3);
			 
		}
		gwatersample=watersample+gwatersample;
		gtestresult=testresult+gtestresult;
		gftk=ftk+gftk;

	
	     	
						%>
						
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=watersample%></td>
                <td class=rptValue><%=testresult%></td>
				<td class=rptValue><%=ftk%></td>
				
				</tr>
<%
	
	}
	%>
	<tr>
	<td class="btext" colspan="2">Total:</td>
    <td class="btext"><%=gwatersample%></td>
	<td class="btext"><%=gtestresult%></td>
	<td class="btext"><%=gftk%></td>
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
}


if(!dCode.equals("51") && !fdate.equals("51"))
{
int tot=0;
int total=0;
Statement stmt1=null,stmt3=null;
ResultSet rs1=null,rs3=null;

String pname="";
String vname="";
int ftk=0;
int gtot=0;
int gtotftk=0;
String cir="";


int sno=1;


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
		<td class=rptValue colspan=14><font color="navy">District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Year :<%=fdate%></td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Water Quality Sources </td>
</tr>
</table>
<table border=1 cellpadding=0 cellspacing=0 width="100%">
<tr align=center>
	
               <td class=btext>Sl.No</td>
               <td class=btext>District</td>
			   <td class=btext>Total Lab Tested Sources</td>
			   <td class=btext>Total FTK Tested Sources</td>

   			   
			   </tr>
			   


<%


try
{
	 
		
		
				String query="select  count(*),d.dname,d.dcode from rws_water_sample_collect_tbl c,rws_habitation_directory_tbl hd,rws_district_tbl d 				 where  hd.hab_code=c.hab_code  and  hd.coverage_status is not null and hd.coverage_status <> 'UI' and to_char(c.samp_collect_date,'yyyy')='"+fdate+"'  and ftk_test_id is null  and c.test_id is not null and substr(source_code,1,2)=d.dcode and substr(source_code,1,2)='"+dCode+"' group by d.dname,d.dcode order by d.dcode ";
		
		
		
		stmt1=conn.createStatement();
				rs1=stmt1.executeQuery(query);
		////System.out.println("BPT"+bptq);
		
    	while(rs1.next())
	{     
		
		

			tot=rs1.getInt(1);
			gtot=tot+gtot;
			
		 cir=rs1.getString(3);
		 String query4="select count(*) from rws_ftk_testing_tbl c,rws_habitation_directory_tbl hd 				 where   hd.hab_code=substr(c.source_code,1,16)  and  hd.coverage_status is not null and hd.coverage_status <> 'UI' and to_char(c.test_date,'yyyy')='"+fdate+"' and substr(c.source_code,1,2)='"+cir+"' ";

		  stmt3=conn.createStatement();
		 	rs3=stmt3.executeQuery(query4);
		 while(rs3.next())
		{
			 ftk=rs3.getInt(1);
			 gtotftk=ftk+gtotftk;
		}

	
	     	
						%>
						
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=tot%></td>
				<td class=rptValue><%=ftk%></td>
				
				</tr>
<%
	
	}
	%>
	<tr>
	<td></td>
	<td class="btext">Total:</td>
	<td class="btext"><%=gtot%></td>
	<td class="btext"><%=gtotftk%></td>
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
}


%>
</table>
</form>

</body>



</p>
</html>
