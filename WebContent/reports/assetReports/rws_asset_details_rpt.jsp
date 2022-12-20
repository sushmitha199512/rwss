<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{

	TINY.box.show({iframe:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script>

<form>
<%
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
//System.out.println("dcode**********" +dcode);
String mcode=request.getParameter("mandal");
session.setAttribute("mcode",mcode);
DecimalFormat ndf = new DecimalFormat("####.##");
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_asset_details_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > RWS&S-Assets Information								
  - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=0 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan="2">Sl.No</td>
    <td class=gridhdbg rowspan="2">District</td>
    
    <td class=gridhdbg rowspan="2">Mandal</td>
    <td class=gridhdbg colspan="2">CPWS</td>
    <td class=gridhdbg colspan="2">PWS</td>
      <td class=gridhdbg colspan="2">MPWS</td>
	 <td class=gridhdbg colspan="2">DP</td>
<td class=gridhdbg colspan="2">HPs</td>
<td class=gridhdbg colspan="2">SHPs</td>
<td class=gridhdbg colspan="2">OW</td>
<td class=gridhdbg colspan="2">Ponds</td>
<td class=gridhdbg colspan="2">Others</td>
<td class=gridhdbg colspan="2">Total</td>
	</tr>
	<tr>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>No.</td>
	<td class=gridhdbg>Cost</td>
	</tr>
       
<%
try
{
	


   //main qry
   Statement stmt8=null,stmt7=null;
   ResultSet rs8=null,rs7=null;
   int sno=1;
   stmt7=conn.createStatement();
   
  
   qry="select substr(hab_code,1,2),substr(hab_code,6,2),a.TYPE_OF_ASSET_CODE,TYPE_OF_ASSET_NAME,count(hab_code),sum(nvl(ASSET_COST,0)) from rws_asset_mast_tbl a,rws_asset_type_tbl b where a.TYPE_OF_ASSET_CODE=b.TYPE_OF_ASSET_CODE and substr(a.hab_code,1,2)='"+dcode+"'  ";

   if(mcode !=null && !mcode.equals(""))
   {
   	qry+="and substr(a.hab_code,6,2)='"+mcode+"'";
   }
   qry+=" group by substr(hab_code,1,2),substr(hab_code,6,2),a.TYPE_OF_ASSET_CODE,TYPE_OF_ASSET_NAME order by substr(hab_code,1,2),substr(hab_code,6,2),TYPE_OF_ASSET_CODE ";
      
   //System.out.println(qry);   
   Hashtable asset_details=new Hashtable();   
  rs7=stmt7.executeQuery(qry);
  while(rs7.next()){
  asset_details.put(rs7.getString(1)+rs7.getString(2)+rs7.getString(4),rs7.getInt(5)+"@"+rs7.getString(6));
      
  }
   
   if(stmt7!=null){
	   stmt7.close();
   }
   if(rs7!=null){
	   rs7.close();
   }
   session.setAttribute("asset_details",asset_details);
   String dname="",temp="";
   String mainqry="select dname,mname,a.dcode,b.mcode from rws_district_tbl a,rws_mandal_tbl b where a.dcode=b.dcode and a.dcode='"+dcode+"' ";
   if(mcode !=null && !mcode.equals(""))
   {
	   mainqry+="and b.mcode='"+mcode+"'";
   }
   mainqry+=" order by a.dcode,b.mcode";
   //System.out.println(mainqry);   
   stmt8=conn.createStatement();
   int grandcpwscnt=0,grandpwscnt=0,grandmpwscnt=0,granddpcnt=0,grandhpcnt=0,grandshpcnt=0,grandowcnt=0,grandpondscnt=0,grandotherscnt=0,grandtotalcnt=0;
   Double grandcpwscost=0.0,grandpwscost=0.0,grandmpwscost=0.0,granddpcost=0.0,grandhpcost=0.0,grandshpcost=0.0,grandowcost=0.0,grandpondscost=0.0,grandotherscost=0.0,grandtotalcost=0.0;
 
    rs8=stmt8.executeQuery(mainqry);
   while(rs8.next())
	      {
	   int cpwscnt=0,pwscnt=0,mpwscnt=0,dpcnt=0,hpcnt=0,shpcnt=0,owcnt=0,pondscnt=0,otherscnt=0,totalcnt=0;
	   Double cpwscost=0.0,pwscost=0.0,mpwscost=0.0,dpcost=0.0,hpcost=0.0,shpcost=0.0,owcost=0.0,pondscost=0.0,otherscost=0.0,totalcost=0.0;
	 
	   if(asset_details.get(rs8.getString(3)+rs8.getString(4)+"CPWS")!=null){
		   String assetdet=(String)asset_details.get(rs8.getString(3)+rs8.getString(4)+"CPWS");
			String []assetdetails=assetdet.split("@");
			if(assetdetails[0]!=null){
			cpwscnt=Integer.parseInt(assetdetails[0]);}
			if(assetdetails[1]!=null){
				cpwscost=Double.parseDouble(assetdetails[1]);}
	   }
	   if(asset_details.get(rs8.getString(3)+rs8.getString(4)+"PWS")!=null){
		   String assetdet=(String)asset_details.get(rs8.getString(3)+rs8.getString(4)+"PWS");
			String []assetdetails=assetdet.split("@");
			if(assetdetails[0]!=null){
			pwscnt=Integer.parseInt(assetdetails[0]);}
			if(assetdetails[1]!=null){
				pwscost=Double.parseDouble(assetdetails[1]);}
	   } 
	   if(asset_details.get(rs8.getString(3)+rs8.getString(4)+"MPWS")!=null){
		   String assetdet=(String)asset_details.get(rs8.getString(3)+rs8.getString(4)+"MPWS");
			String []assetdetails=assetdet.split("@");
			if(assetdetails[0]!=null){
			mpwscnt=Integer.parseInt(assetdetails[0]);}
			if(assetdetails[1]!=null){
				mpwscost=Double.parseDouble(assetdetails[1]);}
	   }
	   if(asset_details.get(rs8.getString(3)+rs8.getString(4)+"DIRECT PUMPING")!=null){
		   String assetdet=(String)asset_details.get(rs8.getString(3)+rs8.getString(4)+"DIRECT PUMPING");
			String []assetdetails=assetdet.split("@");
			if(assetdetails[0]!=null){
			dpcnt=Integer.parseInt(assetdetails[0]);}
			if(assetdetails[1]!=null){
				dpcost=Double.parseDouble(assetdetails[1]);}
	   }
	   if(asset_details.get(rs8.getString(3)+rs8.getString(4)+"HANDPUMPS")!=null){
		   String assetdet=(String)asset_details.get(rs8.getString(3)+rs8.getString(4)+"HANDPUMPS");
			String []assetdetails=assetdet.split("@");
			if(assetdetails[0]!=null){
			hpcnt=Integer.parseInt(assetdetails[0]);}
			if(assetdetails[1]!=null){
				hpcost=Double.parseDouble(assetdetails[1]);}
	   }
	   if(asset_details.get(rs8.getString(3)+rs8.getString(4)+"SHALLOW HAND PUMPS")!=null){
		   String assetdet=(String)asset_details.get(rs8.getString(3)+rs8.getString(4)+"SHALLOW HAND PUMPS");
			String []assetdetails=assetdet.split("@");
			if(assetdetails[0]!=null){
			shpcnt=Integer.parseInt(assetdetails[0]);}
			if(assetdetails[1]!=null){
				shpcost=Double.parseDouble(assetdetails[1]);}
	   }
	   if(asset_details.get(rs8.getString(3)+rs8.getString(4)+"OPEN WELLS")!=null){
		   String assetdet=(String)asset_details.get(rs8.getString(3)+rs8.getString(4)+"OPEN WELLS");
			String []assetdetails=assetdet.split("@");
			if(assetdetails[0]!=null){
			owcnt=Integer.parseInt(assetdetails[0]);}
			if(assetdetails[1]!=null){
				owcost=Double.parseDouble(assetdetails[1]);}
	   }
	   if(asset_details.get(rs8.getString(3)+rs8.getString(4)+"PONDS")!=null){
		   String assetdet=(String)asset_details.get(rs8.getString(3)+rs8.getString(4)+"PONDS");
			String []assetdetails=assetdet.split("@");
			if(assetdetails[0]!=null){
			pondscnt=Integer.parseInt(assetdetails[0]);}
			if(assetdetails[1]!=null){
				pondscost=Double.parseDouble(assetdetails[1]);}
	   }
	   if(asset_details.get(rs8.getString(3)+rs8.getString(4)+"OTHERS")!=null){
		   String assetdet=(String)asset_details.get(rs8.getString(3)+rs8.getString(4)+"OTHERS");
			String []assetdetails=assetdet.split("@");
			if(assetdetails[0]!=null){
			otherscnt=Integer.parseInt(assetdetails[0]);}
			if(assetdetails[1]!=null){
				otherscost=Double.parseDouble(assetdetails[1]);}
	   }
	   totalcnt=cpwscnt+pwscnt+mpwscnt+dpcnt+hpcnt+shpcnt+owcnt+pondscnt+otherscnt;
	   totalcost=cpwscost+pwscost+mpwscost+dpcost+hpcost+shpcost+owcost+pondscost+otherscost;
	   if(dname.equals(rs8.getString(1))||temp.equals(rs8.getString(1))){
      	   dname="-";
         }else{
      	   dname=rs8.getString(1);
         }
	
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style%> "style="text-align: center;"> <%=dname%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=cpwscnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(cpwscost)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=pwscnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(pwscost)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=mpwscnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(mpwscost)%></td>
  <td  class="<%=style%> "style="text-align: right;"> <%=dpcnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(dpcost)%></td> 
<td  class="<%=style%> "style="text-align: right;"> <%=hpcnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(hpcost)%></td>
 <td  class="<%=style%> "style="text-align: right;"> <%=shpcnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(shpcost)%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=owcnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(owcost)%></td>
 <td  class="<%=style%> "style="text-align: right;"> <%=pondscnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(pondscost)%></td>
 <td  class="<%=style%> "style="text-align: right;"> <%=otherscnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(otherscost)%></td>
 <td  class="<%=style%> "style="text-align: right;"> <%=totalcnt%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=ndf.format(totalcost)%></td>
 
        
 
   	</tr>
   	
   	
<%
grandcpwscnt+=cpwscnt;
grandpwscnt+=pwscnt;
grandmpwscnt+=mpwscnt;
granddpcnt+=dpcnt;
grandhpcnt+=hpcnt;
grandshpcnt+=shpcnt;
grandowcnt+=owcnt;
grandpondscnt+=pondscnt;
grandotherscnt+=otherscnt;
grandtotalcnt+=totalcnt;

grandcpwscost+=cpwscost;
grandpwscost+=pwscost;
grandmpwscost+=mpwscost;
granddpcost+=dpcost;
grandhpcost+=hpcost;
grandshpcost+=shpcost;
grandowcost+=owcost;
grandpondscost+=pondscost;
grandotherscost+=otherscost;
grandtotalcost+=totalcost;
temp=rs8.getString(1);
}%>
<tr>
	
  
<td  class="gridhdbg"style="text-align: center;" colspan="3"> Grand Total</td>
<td  class="gridhdbg"style="text-align: right;"> <%=grandcpwscnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(grandcpwscost)%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=grandpwscnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(grandpwscost)%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=grandmpwscnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(grandmpwscost)%></td>
  <td  class="gridhdbg"style="text-align: right;"> <%=granddpcnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(granddpcost)%></td> 
<td  class="gridhdbg"style="text-align: right;"> <%=grandhpcnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(grandhpcost)%></td>
 <td  class="gridhdbg"style="text-align: right;"> <%=grandshpcnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(grandshpcost)%></td>
   <td  class="gridhdbg"style="text-align: right;"> <%=grandowcnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(grandowcost)%></td>
 <td  class="gridhdbg"style="text-align: right;"> <%=grandpondscnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(grandpondscost)%></td>
 <td  class="gridhdbg"style="text-align: right;"> <%=grandotherscnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(grandotherscost)%></td>
 <td  class="gridhdbg"style="text-align: right;"> <%=grandtotalcnt%></td>
<td  class="gridhdbg"style="text-align: right;"> <%=ndf.format(grandtotalcost)%></td>
 
        
 
   	</tr>

<%
if(stmt8!=null){
	   stmt8.close();
}
if(rs8!=null){
	   rs8.close();
}
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>