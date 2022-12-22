
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<%

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "Handpumpsreport.xls");


%>

<form>
<%
String dcode=(String)session.getAttribute("dcode");

//System.out.println("dcode**********" +dcode);
String mcode=(String)session.getAttribute("mcode");
//System.out.println("mcode**********" +mcode);


nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String query="";
    int styleCount=0;
    String style="";

    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
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
	   
	 // Statement stmt6=null;
	//  ResultSet rs6=null;
	   int sno=1;
	   //
	    
	   
	   
	
	   stmt8=conn.createStatement();
	//  stmt6=conn.createStatement();
	   
	   
	    query="select distinct dcode,mcode,mname,pname,count(panch_code),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),count(a.HP_CODE),count(case when ASSET_STATUS='1' OR ASSET_STATUS ='4' then 1 end),count(case when PLATFORM_EXISTING='Y' then 1 end),count(case when ASSET_STATUS='2' OR ASSET_STATUS ='3' then 1 end),count(case when PLATFORM_EXISTING='N' then 1 end),type_of_asset_code   from RWS_HP_SUBCOMP_PARAM_TBL a,rws_asset_mast_tbl b ,RWS_COMPLETE_HAB_VIEW c where a.asset_code=b.asset_code and substr(a.HP_CODE,1,16)=c.panch_CODE   and dcode='"+dcode+"'   and b.ASSET_STATUS is not null and b.ASSET_STATUS<>5 ";
	   
	   if(mcode !=null && !mcode.equals(""))
	   {
		   query+="and mcode='"+mcode+"'";
	   }
	   query+="group by dcode,mcode,mname,pname,pcode,type_of_asset_code order by mcode";
	   
	   //query="select dcode,mcode,mname,pname,count(hab_code),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU) from rws_asset_mast_tbl a,RWS_HP_SUBCOMP_PARAM_TBL b,RWS_COMPLETE_HAB_VIEW c  where dcode='"+rDistrict+"' group by dcode,mcode,mname,pname";

	//query="select a.PANCH_NAME,count(c.HAB_CODE),sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU ),count(b.HP_CODE),SAFE_LPD, UNSAFE_LPD,PLATFORM_EXISTING  from  RWS_COMPLETE_HAB_VIEW a,RWS_HP_SUBCOMP_PARAM_TBL b,RWS_HABITATION_DIRECTORY_TBL c,RWS_ASSET_MAST_TBL d where b.ASSET_CODE=d.ASSET_CODE and a.PANCH_CODE=substr(HP_CODE,1,16) and a.dcode='"+dcode+"' and substr(HP_CODE,1,16)=c.HAB_CODE group by a.PANCH_NAME,SAFE_LPD, UNSAFE_LPD,PLATFORM_EXISTING ";
 
	//query2="select dcode,mcode,mname,pname,panch_name,sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),panch_code from RWS_COMPLETE_HAB_VIEW c  where dcode='"+rDistrict+"'  group by dcode,mcode,mname,pname,panch_name,panch_code order by panch_name";
	  // System.out.println("query:"+query);
       rs8=stmt8.executeQuery(query);
      //rs6=stmt6.executeQuery(query2);
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