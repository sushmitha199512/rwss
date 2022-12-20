<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{

	TINY.box.show({url:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script>

<form>
<%
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
String dname=request.getParameter("dname");
session.setAttribute("dname",dname);
//System.out.println("dname**********" +dname);
String mcode=request.getParameter("mandal");
session.setAttribute("mcode",mcode);

String mname=request.getParameter("mname");
session.setAttribute("mname",mname);
//System.out.println("mname**********" +mname);
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String query="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>

	<table  border=0 rules=none style="border-collapse:collapse" align = "center">
	<tr><td class="bwborder" align="center"><font  color="red" ><b>Note:Condemed HandPumps are not considered in this Report.</b></font></td></tr>	
	
		<table>	<tr><td class="btext">
District:</td><td class="rptvalue"><%=dname%></td>

			
<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_detail_Handpump_rpt_excel.jsp">Excel</a></td>  
	</tr>  
	
		</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > HandPumps- Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
		<tr>
	<td class=gridhdbg >Sl.No</td>
    <td class=gridhdbg >Mandal</td>
    <td class=gridhdbg >Gram Panchayat</td>
    <td class=gridhdbg >No.of Habs</td>
    
    
    
    <td class=gridhdbg >Total Population</td>
    <td class=gridhdbg >Total Number Of HandPumps</td>
    

    <td class=gridhdbg> Functioning(Seasonal+Working)</td>
   
    <td class=gridhdbg >Not Functioning(Dried+NotWorking)</td>
    <td class=gridhdbg >With PlatForms</td>
    <td class=gridhdbg> With Out PlatForms</td>
    
    
     </tr>
    
  
       
<%
try
{
	
	int totalhabs=0;
	int totalpopu=0;
	int taphandpumps=0;
	
	int totfun=0;
	int totnfun=0;
	int totpexist=0;
	int totpnexist=0;
	   //main qry
	   Statement stmt8=null;
	   ResultSet rs8=null;
	   
		   int sno=1;
	   //
	    
	   
	   
	
	   stmt8=conn.createStatement();
	   
	   /*
	   query="select dcode,mcode,mname,pname,count(panch_code),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),count(b.HP_CODE),count(case when STATUS='W' OR STATUS ='S' then 1 end),count(case when STATUS='N' OR STATUS ='D' then 1 end),count(case when PLATFORM_EXISTING='Y' then 1 end),count(case when PLATFORM_EXISTING='N' then 1 end),pcode from rws_asset_mast_tbl a,RWS_HP_SUBCOMP_PARAM_TBL b,RWS_COMPLETE_HAB_VIEW c where    a.asset_code=b.asset_code  and a.type_of_asset_code='04'  and substr(b.HP_CODE,1,16)=c.panch_CODE and status<>'C' and status is not null and dcode='"+dcode+"'  ";
	   
	   
	   if(mcode !=null && !mcode.equals(""))
	   {
		   query+="and mcode='"+mcode+"'";
	   }
	   query+="group by dcode,mcode,mname,pname,pcode order by mcode";
	   */
query="select distinct dcode,mcode,mname,pname,count(panch_code),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),count(a.HP_CODE),count(case when ASSET_STATUS='1' OR ASSET_STATUS ='4' then 1 end),count(case when ASSET_STATUS='2' OR ASSET_STATUS ='3' then 1 end),count(case when PLATFORM_EXISTING='Y' then 1 end),count(case when PLATFORM_EXISTING='N' then 1 end),type_of_asset_code   from RWS_HP_SUBCOMP_PARAM_TBL a,rws_asset_mast_tbl b ,RWS_COMPLETE_HAB_VIEW c where a.asset_code=b.asset_code and substr(a.HP_CODE,1,16)=c.panch_CODE   and dcode='"+dcode+"'   and b.ASSET_STATUS is not null and b.ASSET_STATUS<>5 ";
	   
	   if(mcode !=null && !mcode.equals(""))
	   {
		   query+="and mcode='"+mcode+"'";
	   }
	   query+="group by dcode,mcode,mname,pname,pcode,type_of_asset_code order by mcode";
	  
	          rs8=stmt8.executeQuery(query);
	      // System.out.println("query**********" +query);
       while(rs8.next())
       {
    	  
    	   
    	   
    	   
    	  
    	   if(styleCount%2==0){
  			 style="gridbg1";
  		 }else{
  			 style="gridbg2";
  		 }
  		 styleCount++;
  		
  		 
	%>
		<tr>
		
	   <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	   <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td>
	   <td  class="<%=style%> "style="text-align: left;"><%=rs8.getString(4)%></td>
	   <td  class="<%=style%> "style="text-align: left;"><%=rs8.getInt(5)%></td>
	   <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getInt(6)%></td>
	     <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getInt(7)%></td>
	   <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getInt(8)%></td>
	   <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getInt(9)%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getInt(10)%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getInt(11)%></td>
		
		
	   	</tr>
	   
	  
	   
	   <%
	   totalhabs+=rs8.getInt(5);
	   totalpopu+=rs8.getInt(6);
	   taphandpumps+=rs8.getInt(7);
		
	   totfun+=rs8.getInt(8);
	   totnfun+=rs8.getInt(9);
	   totpexist+=rs8.getInt(10);
	   totpnexist+=rs8.getInt(11);

		 }
       
	   %>	
	   
  
	   <tr align="left">
   	<td align="right" class="gridhdbg" colspan="02">Total</td>
   	<td  class=gridhdbg style="text-align: left;"></td>
   	<td  class=gridhdbg style="text-align: left;"><%=totalhabs%></td>
   	<td  class=gridhdbg style="text-align: left;"><%=totalpopu %></td>
   <td  class=gridhdbg style="text-align: left;"><%=taphandpumps%></td>
    <td  class=gridhdbg style="text-align: left;"><%=totfun%></td>
   	<td  class=gridhdbg style="text-align: left;"><%=totnfun%></td>
   	 <td  class=gridhdbg style="text-align: left;"><%=totpexist%></td>
   <td  class=gridhdbg style="text-align: left;"><%=totpnexist%></td>

   	   	
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