<%@ page import ="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%
    String fvalue=null,ivalue=null,qaffect=null,place=null,diameter=null,stalevel=null,summerlevel=null,
    drillyr=null,status=null,devalue=null,brvalue=null;

	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	//String districtName = (String) session.getAttribute("districtName");
	String distcode = (String) session.getAttribute("dcode");
	String mcode = (String) session.getAttribute("mcode");
	String pcode = (String) session.getAttribute("pcode");
	String vcode = (String) session.getAttribute("vcode");
	String prcode = (String) session.getAttribute("prcode");
%>
<html>
<head>
<title>WaterSoft</title>
<link rel="stylesheet" href="./resources/style/rwsstyle.css" type="text/css">
</head>
<body>
<p width="80%" align="center"><b><font face="Verdana" size="2">WaterSoft<br>
Department Of Panchayat Raj and Engineering <br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</font>
</p>
<table border=1 cellspacing=0 cellpadding=0 style="border-collapse:collapse" width=100% bordercolor=#000000>
	<tr align=center>
		<td class="rptHeading" colspan=13>ExcelFormat</td>
	</tr>
	<tr>
		<td	class="bwborder" align="right" colspan=13>Report Date: <%=fmt.format(new java.util.Date())%></td>
	</tr>
<%
	if(distcode != null || mcode!=null || pcode!=null || vcode!=null || prcode!=null)
	
%>
	
	<tr align=center>
		<td class=rptLabel>Sno</td>
		<td class=rptLabel>Hpcode</td>
		<td class=rptLabel>Location</td>
		<td class=rptLabel>DrillYear</td>
		<td class=rptLabel>Diameter</td>	
		<td class=rptLabel>Status</td>				
		<td class=rptLabel>StaticWL</td>
		<td class=rptLabel>SummerWL</td>
		<td class=rptLabel>Depth</td>
		<td class=rptLabel>Quality<br>Affected</td>
		<td class=rptLabel>Flouride</td>
		<td class=rptLabel>Brakish</td>
		<td class=rptLabel>Iron</td>
		
		
	</tr>	
<%
	ResultSet rset1 = null;
	rset1 = (ResultSet)session.getAttribute("format");
	rset1.last();
     int count=rset1.getRow();
	//rset1.setFetchSize(1000);
	rset1.beforeFirst();
	int i = 1;
	while(rset1.next())
       {

		String code=rset1.getString(1);

        if(rset1.getString(2)!=null)
        place=rset1.getString(2);
		else
        place="-";

		if(rset1.getString(3)!=null)
        drillyr=rset1.getString(3);
		else
        drillyr="-";

		if(rset1.getString(4)==null || String.valueOf(rset1.getInt(4))=="0")
        diameter="-";
		else
        diameter=rset1.getString(4);
        
		if(rset1.getString(5)!=null)
         status=rset1.getString(5);
		 else
        status="-";
        
		if(rset1.getString(6)==null || String.valueOf(rset1.getInt(6))=="0")
        stalevel="-";
		else
        stalevel=rset1.getString(6);

		if(rset1.getString(7)==null || String.valueOf(rset1.getInt(7))=="0")
        summerlevel="-";
		else
        summerlevel=rset1.getString(7);
		
		if(rset1.getString(8)==null || String.valueOf(rset1.getInt(8))=="0")
        devalue="-";
		else
        devalue=rset1.getString(8);
		
		if(rset1.getString(9)!=null && rset1.getString(9).equals("Y"))
         qaffect="Yes";
		else if(rset1.getString(9)!=null && rset1.getString(9).equals("N"))
         qaffect="No";
		else
        qaffect="-";
		
		if(rset1.getString(10)==null || String.valueOf(rset1.getInt(10))=="0")
        fvalue="-";
		else
        fvalue=rset1.getString(10);
        if(rset1.getString(11)==null || String.valueOf(rset1.getInt(11))=="0")
        brvalue="-";
		else
        brvalue=rset1.getString(11);
		
		if(rset1.getString(12)==null || String.valueOf(rset1.getInt(12))=="0")
        ivalue="-";
		else
        ivalue=rset1.getString(12);
		if(i%30 == 0)
		{
%>	
	<tr align=center>
		<td class="rptHeading" colspan=13>ExcelFormat</td>
	</tr>
	<tr>
		<td	class="bwborder" align="right" colspan=13>Report Date: <%=fmt.format(new java.util.Date())%></td>
	</tr>

	<tr align=center>
		<td class=rptLabel>Sno</td>
		<td class=rptLabel>Hpcode</td>
		<td class=rptLabel>Location</td>
		<td class=rptLabel>DrillYear</td>
		<td class=rptLabel>Diameter</td>	
		<td class=rptLabel>Status</td>				
		<td class=rptLabel>StaticWL</td>
		<td class=rptLabel>SummerWL</td>
		<td class=rptLabel>Depth</td>
		<td class=rptLabel>Quality<br>Affected</td>
		<td class=rptLabel>Flouride</td>
		<td class=rptLabel>Brakish</td>
		<td class=rptLabel>Iron</td>
		
	</tr>	
	<tr style="page-break-before:always">	
<%
		}
		else
		{
%>

	<tr>
<%
		}
%>
		<td class=bwborder><%=i++%></td>
		<td class=bwborder><%=code%></td>
		<td class=bwborder><%=place%></td>
		<td class=bwborder><%=drillyr%></td>
		<td class=bwborder><%=diameter%></td>
		<td class=bwborder><%=status%></td>
		<td class=bwborder><%=stalevel%></td>
		<td class=bwborder><%=summerlevel%></td>		
		<td class=bwborder><%=devalue%></td>
		<td class=bwborder><%=qaffect%></td>
		<td class=bwborder><%=fvalue%></td>
		<td class=bwborder><%=brvalue%></td>
		<td class=bwborder><%=ivalue%></td>
		
		
	</tr>
	
<%
	
	}
%>
	<tr align=center>
		<td style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;" colspan=13>Designed & Developed by National Informatics Centre, AP State Centre</td>
	</tr>
</table>
</body>
</html>