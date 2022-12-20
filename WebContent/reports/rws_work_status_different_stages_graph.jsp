<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*" %>

<%! 
	  int t,j;
	
	  int count,q,c=0;String x="",y;
	  String distcode="",distname="",query;
	  String chart1URL,imageMap1;
	  String state,fromdt,todt;
	  String dist[],districts[],distnames[] ;
	  String[] sr2;
	 double data1[],data2[];
	
		
      int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};
      int colors1[];

	
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
<%  
	//System.out.println("eeeeee555555555555555555");
	//System.out.println("ts 33 "+ts);
	//System.out.println("nc 33 "+nc);
	//System.out.println("cs  33"+cs);
	  try
    { 
       response.setContentType("text/html");
	
 	 
	String x=request.getParameter("chart");
	// //System.out.println("RRRRRRRRRR       "+x);
	
	dist=new String[10];
    count=0;c=0; 
    int [] data=new int[mylists1];
	int [] dt=new int[mylists1];
	distnames =new String[mylists1];
	data2 =new double[mylists1];

if(as!=0)
		{
dist[count]="Administative Sanction";
data[count]=as;
count++;
		}
if(cs!=0){
dist[count]="Considered for Sanction";
data[count]=cs;
count++;
}
if(nc!=0)
		{
dist[count]="Not Considered ";
data[count]=nc;
count++;
		}
if(ts!=0)
		{
dist[count]="Tachnically Sanction";
data[count]=ts;
count++;
		}

   int p=0;

		
   if(count!=0){
		districts=new String[count];
		data1 =new double[count];
		colors1=new int[count];
	 
		for(int m=0;m<count;m++)
			{

				districts[m]=dist[m];
				data1[m]=data[m];
				colors1[m]=colors[m];
	  	   }
  
	 if(x.equals("l"))
    {
     XYChart ch = new XYChart(570, 480);
    
	//ch.addTitle("Contituency Wise Estimate Cost Graph Report  ", "times new roman Bold Italic",12);
	 
	ch.setPlotArea(230, 40, 200, 100, Chart.Transparent, Chart.Transparent,
    Chart.Transparent, Chart.Transparent, Chart.Transparent);
	 
	BarLayer layer = ch.addBarLayer(data1, ch.gradientColor(100, 0, 500, 0, 0x8000,
    0xffffff));
	 
	ch.swapXY(true);
	 
	layer.setBarGap(0.1);
 	layer.setAggregateLabelFormat("{value} ");
	 
	layer.setAggregateLabelStyle("Times New Roman Bold Italic", 10, 0x663300);
	 
	TextBox textbox = ch.xAxis().setLabels(districts);
	 
	textbox.setFontStyle("times new roman Bold Italic");
	textbox.setFontSize(10);
	 
	ch.xAxis().setColors(Chart.Transparent, 0x663300);
	 
	ch.yAxis().setColors(Chart.Transparent, Chart.Transparent);
	 
	chart1URL = ch.makeSession(request, "chart1");
	 
	imageMap1 = ch.getHTMLImageMap("", "",
    "title='{xLabel}: {value}'");
%>

	<div align=center><img src="getchart.jsp?<%=chart1URL%>" usemap="#map1" border="0">
   <map name="map1"><%=imageMap1%></map></div>
   <%  }
  String ss[]=new String[count];
  String tempstr="";
  for(j=0;j<count;j++){
	  ss[j]=""+(j+1);
	  tempstr+=(j+1)+"."+districts[j]+"\n";
	   //System.out.println("tempstr  is "+tempstr);
  }
	if(x.equals("b"))
   {
    XYChart ch = new XYChart(750, 300);
	//ch.addTitle("Contituency Wise Estimate Cost Graph Report  ", "times new roman Bold Italic",12);
    ch.yAxis().setTitle("Total ");
	ch.xAxis().setTitle(" Work Status ");
	ch.setPlotArea(100, 65, 270, 160);
	ch.xAxis().setLabels(ss);
	ch.xAxis().setTitlePos(2,2);
	ch.xAxis().setMargin(10);
	BarLayer layer = ch.addBarLayer3(data1);
	//ch.addBarLayer3(data1, colors1).setBorderColor(-1, 1);
	layer.set3D(10);
	
	//BarLayer layer = ch.addBarLayer2(Chart.Stack, 8);
	//LegendBox legendBox = ch.addLegend(420, 60, true, "Arial Bold", 8);
    //layer.addDataSet(data1, 0xff00,tempstr);
	layer.setAggregateLabelStyle();
	chart1URL = ch.makeSession(request, "chart1");
	imageMap1 = ch.getHTMLImageMap("", "", "title='{xLabel}: {value} '");
	%>
	 <div align=center>
	 <table border = 0  align="center" cellspacing = 0 cellpadding = 0 width="100%"   style="border-collapse:collapse">
	<tr>
		<td>
			<img src="getchart.jsp?<%=chart1URL%>" usemap="#map1" border="0">
			<map name="map1"><%=imageMap1%></map>
		</td>
	</tr>
	</table>
		</div>
	
	

   <% 	   }
    
if(x.equals("p"))
 {
    
	PieChart ch = new PieChart(760, 360);
    ch.setPieSize(310, 180, 80);
   // ch.addTitle2(Chart.Top, "Contituency Wise Estimate Cost Graph Report", "Times New Roman Bold Italic",13);
	ch.set3D();
	ch.addLegend(450, 40, true, "Arial Bold", 8);
	ch.setLabelFormat("{label} [{value}]\n({percent}%)");
	ch.setLabelLayout(Chart.SideLayout);
	ch.setLabelStyle().setBackground(0xffffff, Chart.Transparent, 1);
	ch.setLineColor(Chart.SameAsMainColor, 0x0);
	ch.setData(data1,districts);
//	ch.setExplode(0); 
	ch.setLabelStyle("Arial Bold",8,0x0000);
	LegendBox legendBox = ch.addLegend(592, 55, true, "Arial Bold", 8);
    chart1URL = ch.makeSession(request, "chart1");
    imageMap1 = ch.getHTMLImageMap("", "",
    "title='{label}: {value} ({percent}%)'");
%>
	<div align=center><img src="getchart.jsp?<%=chart1URL%>" usemap="#map1" border="0">
   <map name="map1"><%=imageMap1%></map></div>
   
   <%} 
   
    if(x.equals("d"))
 {
	 XYChart ch = new XYChart(580, 600);
	 ch.setPlotArea(90, 45, 270, 170);
	//ch.addTitle("Contituency Wise Estimate Cost Graph Report", "times new roman Bold Italic",12);
	 ch.yAxis().setTitle("Total ");
	  ch.xAxis().setTitle("Work Status ");
     AreaLayer layer = ch.addAreaLayer();
	 layer.set3D();
	 LegendBox legendBox = ch.addLegend(390, 40, true, "Arial Bold", 8);
	 layer.addDataSet(data1, 0xff00,tempstr);
	 ch.xAxis().setLabels(ss);
     chart1URL = ch.makeSession(request, "chart1");
 	imageMap1 = ch.getHTMLImageMap("", "", "title='{xLabel}: {value} '");
	%>
    <div align=center>
	<table border = 0  align="center" cellspacing = 0 cellpadding = 0 width="100%">
	<tr>
		<td>
			<img src="getchart.jsp?<%=chart1URL%>" usemap="#map1" border="0">
			<map name="map1"><%=imageMap1%></map>
		</td>
	</tr>
	</table>
		</div>

   
   <%} %>
<%}  int w=0;%>
  
  <table border = 1 cellspacing = 0 cellpadding = 0 width="65%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">
	<tr>
				<td class="btext" >S.No. </td>
				<td class="btext" > Work Status </td> 
				<td class="btext" >Total No. of Proposal </td> 
			</tr>
			<tr>
<%	 
	   int total=0;
	   for(int m=0;m<count;m++) {%>
			<tr>
			<td class="mystyle1"><%=++w %> </td>
			<td class="mystyle1"><%=districts[m]%> </td>
			<td class="mystyle1" align=right><%=data[m]%> </td>
		</tr>
  <%		
		   total=total+data[m];
   }%>
 <tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext" align=right><%=total %></td>
	</tr>
	<%}
   catch(Exception e)
   {
	   e.printStackTrace();

   }

	   %>