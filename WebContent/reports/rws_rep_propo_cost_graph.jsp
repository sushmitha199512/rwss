<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*" %>

<%! 
	  int t,j;
	
	  int count,q,c=0;String x="",y;
	  String distcode="",distname="",query;
	  String chart1URL,imageMap1;
	  String state,fromdt,todt;
	  String dist[],districts[],distnames[],distname1[],distname2[];
	  double data1[],data2[];
	  int z=0;
		
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
	// //System.out.println("eeeeee555555555555555555");
	  try
    { 
       response.setContentType("text/html");
	
 	 
	String x=request.getParameter("chart");
	// //System.out.println("RRRRRRRRRR       "+x);
	int cnt1=0,cnt2=0,cnt3=0,cnt4=0,cnt5=0;
	int p=0;
	dist=new String[10];
    count=0;c=0; 
    int [] data=new int[10];
	int [] dt=new int[Count];
	double [] cost=new double[10];
	distnames =new String[5];
	distname1 =new String[5];
	distname2 =new String[5];
//System.out.println("sadiq       "+dist.length);

while(rs.next())
{
	//System.out.println("cost is "+rs.getDouble(1));

	if(rs.getDouble(1)>=0 && rs.getDouble(1)<=25000/100000)
	{

		cnt1++;

	}
	if(rs.getDouble(1)>25000/100000 && rs.getDouble(1)<=200000/100000)
	{
		cnt2++;
	}
	if( rs.getDouble(1)>200000/100000 && rs.getDouble(1)<=1000000/100000)
	{
		cnt3++;
	}
	if(rs.getDouble(1)>1000000/100000 && rs.getDouble(1)<=5000000/100000)
	{
		cnt4++;
	}
	if(rs.getDouble(1)>5000000/100000)
	{
		cnt5++;
	}
	//cost[p++]=rs.getDouble(1);

}
//System.out.println("sadiq         66666666            "+dist.length);

dist[count]="Less than 25 Thousand";
distname1[count]="<=25000";
data[count]=cnt1;
count++;

dist[count]="Greater than 25 Thousand and Less than 2 Lakhs";
distname1[count]=">25000 and <=200000";
data[count]=cnt2;
count++;

dist[count]="Greater than 2 Lakhs and Less than 10 Lakhs";
distname1[count]=">200000 and <=1000000";
data[count]=cnt3;
count++;

dist[count]="Greater than 10 Lakhs and Less than 50 Lakhs";
distname1[count]=">1000000 and <=5000000";
data[count]=cnt4;
count++;

dist[count]="Greater than 50 Lakhs";
distname1[count]=">5000000";
data[count]=cnt5;
count++;
 //System.out.println("sadiq count is  "+count);
for(int k=0;k<count;k++)
{
		if(data[k]!=0)
	{
	  
	  dt[c]=data[k];
	  distnames[c]=dist[k];
	  distname2[c]=distname1[k];
	  c++;
	}
	 
}

  

        
 //System.out.println("sadiq");

   if(c!=0){
     districts=new String[c];
	 data1 =new double[c];
	 colors1=new int[c];
 	
	for(int m=0;m<c;m++) {

	   districts[m]=distnames[m];
	   data1[m]=dt[m];
	   colors1[m]=colors[m];
	

	   }
 //System.out.println("sadiq777777777777777 ");
	 if(x.equals("l"))
    {
		
     XYChart ch = new XYChart(570, 480);
    
	//ch.addTitle("Proposal Cost Graph", "times new roman Bold Italic",12);
	 
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
  String ss[]=new String[c];
  String tempstr="";
  for(j=0;j<c;j++){
	  ss[j]=""+(j+1);
	  tempstr+=(j+1)+"."+dist[j]+"\n";
	  
  }
	if(x.equals("b"))
   {
    XYChart ch = new XYChart(650, 300);
	//ch.addTitle("Proposal Cost Graph ", "times new roman Bold Italic",12);
    ch.yAxis().setTitle("No. of Proposals");
	ch.xAxis().setTitle("Cost Range");
	ch.setPlotArea(70, 65, 270, 160);
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
   // ch.addTitle2(Chart.Top, " Proposal Cost Graph ", "Times New Roman Bold Italic",13);
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
	 XYChart ch = new XYChart(700, 300);
	 ch.setPlotArea(90, 45, 270, 170);
	//ch.addTitle(" Proposal Cost Graph", "times new roman Bold Italic",12);
	 ch.yAxis().setTitle("No. of Proposals");
	 ch.xAxis().setTitle("Cost Range");
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
<%}  int j=0;%>
  
  <table border = 1 cellspacing = 0 cellpadding = 0 width="65%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr>
				<td class="btext" >S.No. </td>
				<td class="btext" >Proposal Cost Range </td> 
				<td class="btext" >Total No.of Proposals</td> 
			</tr>
			<tr>
<%	
	  ArrayList myList = new ArrayList();
		double[] ct=new double[Count];
	  for(z=0;z<p;z++){
		ct[z]=cost[z];
	  }
	  myList.add(ct);

	 session.setAttribute("cost",myList);
		// request.setAttribute("cost",cost);
	  //System.out.println("cost ////////is = "+cost[z]);

  
	  int total=0;
	   for(int m=0;m<c;m++) {%>
			<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1"><%=districts[m]%></td>
			<td class="mystyle1"><a href="./rws_pro_list_temp_rpt.jsp?district=<%=district%>&mandal=<%=mandal%>&panchayat=<%=panchayat%>&cons=<%=Consti%>&finYear=<%=fyr%>&assetType=<%=assetType%>&grantName=<%=Pcode%>&distname2[]=<%=distname2[m]%>"><%=dt[m]%></a></td>
		</tr>
  <%
	   
		   total=total+dt[m];
   }%>
 <tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=total %></td>
	</tr>
 </table>   
<% }catch(Exception e) { //System.out.println("error is  "+e);
	 
	}%>