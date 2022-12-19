<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
   
  String type=request.getParameter("type");

  String subType=request.getParameter("subType");


  String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
}


    DecimalFormat ndf = new DecimalFormat("##.##");


 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
   <td class="gridhdbg">
<a href="javascript:onclick=history.go(-1)">Back|</td></tr>
            <a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="gridhdbg">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" >*** Rupees in Lakhs</td>
</tr>
</table>
<table   width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>

<% if(type.equals("1") || type.equals("3")){ %>
<td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>DISTRICT   </b></td>
<td class=gridhdbg ><b>Asset Code   </b></td>
<td class=gridhdbg ><b>Asset Name </b></td>
<td class=gridhdbg ><b>Hab Code </b></td>    
<td class=gridhdbg ><b>Location   </b></td>  
<td class=gridhdbg ><b>Date Of Creation   </b></td>
<td class=gridhdbg ><b>Asset Cost  </b></td>
<td class=gridhdbg ><b>Remarks   </b></td> 

<%} else{ %>
<td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>DISTRICT   </b></td>
<td class=gridhdbg ><b>Panchayath   </b></td>
<td class=gridhdbg ><b>Village </b></td>
<td class=gridhdbg ><b>Hab Code </b></td>    
<td class=gridhdbg ><b>Hab Name    </b></td>  
<td class=gridhdbg ><b>Coverage Status   </b></td>



<%} %>

 
  </tr>





	<%try
      { int count=1;
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
       String qry="";
       stmt3=conn.createStatement();
      

boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

String query="";
System.out.println("Type"+type);
if(type.equals("1")){
//TYPE_OF_ASSET_CODE in(01,02,09)


 query="select d.dname,ASSET_CODE, ASSET_NAME,HAB_CODE ,LOCATION, to_char(DATE_CREATION,'dd/mm/yyyy'),ASSET_COST,nvl(REMARKS,'-') from rws_asset_mast_tbl ,rws_district_tbl d  where ";
if(subType!=null){

query+="TYPE_OF_ASSET_CODE in(01,02,09)";
}else{

query+="TYPE_OF_ASSET_CODE='03'";
}

query+=" and ASSET_STATUS <>'01'  AND CIRCLE_OFFICE_CODE=d.dcode and d.dcode='"+dcode+"'";

} else if(type.equals("2")){
query="select c.dname,c.pname,c.vname,b.hab_code,c.PANCH_NAME ,c.COVERAGE_STATUS  from rws_asset_mast_tbl  a,rws_asset_hab_tbl b,rws_complete_hab_view c where  ";

if(subType!=null){

query+="TYPE_OF_ASSET_CODE in(01,02,09)";
}else{

query+="TYPE_OF_ASSET_CODE='03'";
}

query+=" and ASSET_STATUS <>'01'  and a.ASSET_CODE =b.ASSET_CODE and c.panch_code=b.hab_code and a.circle_office_code='"+dcode+"'";

}else if(type.equals("3")){


 query="select d.dname,ASSET_CODE, ASSET_NAME,HAB_CODE ,LOCATION, to_char(DATE_CREATION,'dd/mm/yyyy'),ASSET_COST,nvl(REMARKS,'-') from rws_asset_mast_tbl ,rws_district_tbl d  where ";
if(subType!=null){

query+="TYPE_OF_ASSET_CODE in(01,02,09)";
}else{

query+="TYPE_OF_ASSET_CODE='03'";
}

query+=" and  ASSET_STATUS is not null  AND CIRCLE_OFFICE_CODE=d.dcode and d.dcode='"+dcode+"'";

}else if(type.equals("4")){


query="select c.dname,c.pname,c.vname,b.hab_code,c.PANCH_NAME ,c.COVERAGE_STATUS  from rws_asset_mast_tbl  a,rws_asset_hab_tbl b,rws_complete_hab_view c where  ";

if(subType!=null){

query+="TYPE_OF_ASSET_CODE in(01,02,09)";
}else{

query+="TYPE_OF_ASSET_CODE='03'";
}

query+="  and a.ASSET_CODE =b.ASSET_CODE and ASSET_STATUS is not null and c.panch_code=b.hab_code and a.circle_office_code='"+dcode+"'";

}
System.out.println("query"+query);

rs3=stmt3.executeQuery(query);

while(rs3.next()){

%>
<tr><td class=rptValue><%=count++ %></td><td class=rptValue><%=rs3.getString(1) %></td><td class=rptValue><%=rs3.getString(2) %></td><td class=rptValue><%=rs3.getString(3) %></td><td class=rptValue><%=rs3.getString(4) %></td><td class=rptValue><%=rs3.getString(5) %></td><td class=rptValue><%=rs3.getString(6) %></td>

<% if(type.equals("1") || type.equals("3")) {%>
<td class=rptValue><%=rs3.getString(7) %></td>
<td class=rptValue><%=rs3.getString(8) %></td>

<% }%>
</tr>
<% 



}

      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

