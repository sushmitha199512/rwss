<%@ include file="header_rpt.jsp"%>
<%@ include file="conn3.jsp"%>
<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*" %>
<%! 
	  int t,j;
	  int Count=0;
	
	  int count,q,c=0;String x="",y;
	  String chart1URL,imageMap1;
	  String state,fromdt,todt;
	  String prodid[],prodid1[],distnames[];
	  double data1[],data2[];
	
      int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};
      
	
%>
<style type="text/css">
   .tss1{color:navy;font-size:10pt;text-align:center;background-color:pink}
   .tss2{font-size:8pt}
   .tss3{font-size:8pt;text-align:right}
   .tr1{font-size:10pt;color:navy}
 BODY{
   scrollbar-face-color: #DBE3EA;
   scrollbar-highlight-color: #FFFFFF;
   scrollbar-shadow-color: #DEE3E7;
   scrollbar-3dlight-color: #D1D7DC;
   scrollbar-arrow-color:  #006699;
   scrollbar-track-color: #ffffff;
   scrollbar-darkshadow-color: #98AAB1;
}
</style>
</head>
 <body bgcolor="#edf2f8">
 <table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="lavander" align="center">
			<td align="center" class="textborder" colspan="2" >
				<font color="#FFFFFF">Comparison of Coverage Status</font>
			</td>	
		</tr>
	</table>
	
<%

String vsql="select coverage_status,count(hab_code) from rws_habitation_directory_tbl where coverage_status='FC' group by coverage_status UNION select coverage_status,count(hab_code) from rws_habitation_dir_his_tbl where coverage_status='FC' group by coverage_status";
String vsql1="select coverage_status,count(hab_code),to_char(status_date,'dd/mm/yyyy') from rws_habitation_directory_tbl where coverage_status='FC' group by coverage_status,status_date UNION select coverage_status,count(hab_code),to_char(status_date,'dd/mm/yyyy') from rws_habitation_dir_his_tbl where coverage_status='FC' group by coverage_status,status_date";
stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
 rs1=stmt1.executeQuery(vsql1);
 rs=stmt.executeQuery(vsql);
rs.last();
int Count=rs.getRow();
rs.beforeFirst();
%>
<%	
	
	prodid=new String[Count];
    count=0;c=0; 
    int [] data=new int[Count];

for(int m=0,l=0;l<Count;l++,m++)
	{
		rs.next();
		prodid[l]=rs.getString(1);
		data[m]=rs.getInt(2);
	
    }
  
     
    count=0;c=0; 
    int h=0;
	
    int p=0;
			
	   for(count=0;count<prodid.length;count++)
	   {
		  
           h++;
	   }
        
   
	for(int m=0;m<h;m++)
	{
		if(data[m]!=0)
		{
		   p++;
		  
	   }
	   
	}

  
     prodid1=new String[p];
	 data1 =new double[p];

 	for(int m=0;m<count;m++)
	{
		if(data[m]!=0)
		{
		   prodid1[c]=prodid[m];
		   data1[c]=data[m];
		   c++;
	 
	   }
	   
	}
	
	
	
 
	PieChart ch = new PieChart(760,400);
    ch.setPieSize(310, 180, 80);
    ch.addTitle2(Chart.Top, "coverage status camparison", "Times New Roman Bold Italic",13);
	ch.set3D();
	ch.addLegend(450, 40, true, "Arial Bold", 8);
	ch.setLabelFormat("{label} [{value}]\n({percent}%)");
	ch.setLabelLayout(Chart.SideLayout);
	ch.setLabelStyle().setBackground(0xffffff, Chart.Transparent, 1);
	ch.setLineColor(Chart.SameAsMainColor, 0x0);
	ch.setData(data1,prodid1);

	ch.setLabelStyle("Arial Bold",8,0x0000);
	LegendBox legendBox = ch.addLegend(592, 55, true, "Arial Bold", 8);
    chart1URL = ch.makeSession(request, "chart1");
    imageMap1 = ch.getHTMLImageMap("", "",
    "title='{label}: {value} ({percent}%)'");
	
%>
	<div align=center><img src="getchart.jsp?<%=chart1URL%>" usemap="#map1" border="0">
   <map name="map1"><%=imageMap1%></map></div>

<center>
<table border = 1 align=center cellspacing = 2 cellpadding = 0 rules="rows,cols" width="100%"   style="border-collapse:uncollapse" >
<tr bgcolor="#CCCCCC">


<td class=btext><font size=3 color="#9900FF">Sl.No</font></td>
<td class=btext>
<font size=3 color="#9900FF">Coverage Status Year</font></td>
<td class=btext>
<font size=3 color="#9900FF">No.Of.Habitations</font></td>

</tr>
<%
int slno=0;
while(rs1.next()){ 
	++slno;
	%>
<tr bgcolor="#FFFFFF">
<td><font size=2 ><%=slno%></font></td>
<td><font size=2 ><%=rs1.getString(3)%></font></td>
<td><font size=2 ><a href="districts1.jsp?coverage_status=<%=rs1.getString(1)%>&status_date=<%=rs1.getString(3)%>"><%=rs1.getString(2)%></font></td>

</tr>

<%}%>
</table>
</body>
</html>
  
<%@ include file="footer.jsp"%>
