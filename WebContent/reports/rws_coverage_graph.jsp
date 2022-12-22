<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*" %>

<%! 
	  int t,j;
	
	  int count,q,c=0;String x="",y;
	  String distcode="",distname="",query;
	  String chart1URL,imageMap1;
	  String state,fromdt,todt;
	  String dist[],districts[],distnames[];
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
<%   
    try
    { 
       response.setContentType("text/html");
	}catch(Exception e) { //System.out.println(e+"Couldn't create Pool");
	}
 	 
	String x=request.getParameter("chart");
	////System.out.println("RRRRRRRRRR"+x);
	dist=new String[7];
    count=0;c=0; 
    double [] data=new double[7];
	dist[0]="FC";	data[0]=totfc;
	dist[1]="PC1";	data[1]=totpc1;
	dist[2]="PC2";	data[2]=totpc2;
	dist[3]="PC3";	data[3]=totpc3;
	dist[4]="PC4";	data[4]=totpc4;
	dist[5]="NC";	data[5]=totnc;
	dist[6]="NSS";	data[6]=totnss;
    count=0;c=0; 
   
	
    int p=0;
			
	   for(count=1;count<dist.length;count++)
	   {
               count++;
			}
        
//    //System.out.println("count=  "+count);
	for(int m=0;m<count;m++)
	{
		if(data[m]!=0)
		{
		   p++;
		  
	   }
	   
	}
// //System.out.println("value of c is  "+p);
  
     districts=new String[p];
	 data1 =new double[p];

 	for(int m=0;m<count;m++)
	{
		if(data[m]!=0)
		{
		   districts[c]=dist[m];
		   data1[c]=data[m];
		   c++;
//		   //System.out.println("value of c is  "+c);
	   }
	   
	}
	/*for (int k=0;k<c;k++)
	{ 
		 ////System.out.println("value of c is  "+k+"  data1 value is  "+data1[k]);
	}*/

    if(p!=0)
	{
	 if(x.equals("l"))
    {
     XYChart ch = new XYChart(570, 250);
    
	ch.addTitle("Coverage Status Graph Report", "times new roman Bold Italic",12);
	 
	ch.setPlotArea(230, 40, 200, 150, Chart.Transparent, Chart.Transparent,
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
String ss[]=new String[c];
ss[0]="FC";ss[1]="PC4";ss[2]="PC3";ss[3]="PC2";ss[4]="PC1";ss[5]="NC";ss[6]="NSS";
  String tempstr="";
  for(j=0;j<c;j++){
//	  ss[j]=""+(j+1);
	  tempstr+=(j+1)+"."+districts[j]+"\n";
  }
    
	if(x.equals("b"))
   {
    	XYChart ch = new XYChart(650, 415);
	//XYChart ch = new XYChart(260, 220);

	//ch.addTitle("Coverage Status - Habitation", "times new roman Bold Italic",12);
	ch.addTitle("Coverage Status - Habitation", "Arial Bold", 10);
	//ch.setPlotArea(40, 40, 200, 150);
	ch.yAxis().setTitle("No. of Habitations");
	ch.xAxis().setTitle("Coverage Status");
	ch.setPlotArea(70, 65, 270, 160);
	ch.xAxis().setLabels(ss);
	ch.xAxis().setTitlePos(2,2);
	ch.xAxis().setMargin(10);
	BarLayer layer = ch.addBarLayer3(data1);
	//ch.addBarLayer3(data1, colors1).setBorderColor(-1, 1);
	layer.set3D(10);
	
	/*BarLayer layer1 = ch.addBarLayer2(Chart.Stack, 8);
	LegendBox legendBox = ch.addLegend(420, 60, true, "Arial Bold", 8);
    layer1.addDataSet(data1, 0xff00,tempstr);*/
	layer.setAggregateLabelStyle();
	chart1URL = ch.makeSession(request, "chart1");
	imageMap1 = ch.getHTMLImageMap("", "", "title='{xLabel}: {value} '");
	%>
	<div align=center><img src="getchart.jsp?<%=chart1URL%>" usemap="#map1" border="0">
   <map name="map1"><%=imageMap1%></map></div>
   
   <%}
    
if(x.equals("p"))
 {
    
	PieChart ch = new PieChart(760, 360);
    ch.setPieSize(310, 180, 80);
    ch.addTitle2(Chart.Top, "Coverage Status - Habitation", "Times New Roman Bold Italic",13);
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
	 XYChart ch = new XYChart(580, 380);
	 ch.setPlotArea(90, 45, 270, 170);
	ch.addTitle("Coverage Status - Habitation", "times new roman Bold Italic",12);
	 ch.yAxis().setTitle("No. of Habitations");
	 ch.xAxis().setTitle("Coverage Status");
     AreaLayer layer = ch.addAreaLayer();
	 layer.set3D();
	 LegendBox legendBox = ch.addLegend(390, 40, true, "Arial Bold", 8);
	 layer.addDataSet(data1, 0xff00,tempstr);
	 ch.xAxis().setLabels(ss);
     chart1URL = ch.makeSession(request, "chart1");
 	imageMap1 = ch.getHTMLImageMap("", "", "title='{xLabel}: {value} '");
	%>
    <div align=center><img src="getchart.jsp?<%=chart1URL%>" usemap="#map1" border="0">
     <map name="map1"><%=imageMap1%></map></div>
   
   <%} }%>
 


