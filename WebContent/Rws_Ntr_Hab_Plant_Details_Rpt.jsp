<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import="java.util.*"%>
<%
	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	String dcode=request.getParameter("district1");
	if(dcode!=null)
	{
	session.setAttribute("dcode",dcode);
	}
	String dname=request.getParameter("dname1");
	if(dname!=null)
	{
	session.setAttribute("dname",dname);
	}
	String mcode=request.getParameter("mandal");
	if(mcode!=null)
	{
	session.setAttribute("mandal",mcode);
	}
	String mname1=request.getParameter("mname");
	if(mname1!=null)
	{
	session.setAttribute("mname1",mname1);
	}
	
	String status=request.getParameter("status");
	String cov_status="";
	if(status!=null && status.equals("PC"))
			{
		      cov_status="'PC1','PC2','PC3','PC4'";
			}
	else
	{
		cov_status="'"+status+"'";
	}
	
%>
<html>
<body>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
<%//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home|</a><td align="right" ><a href="javascript:onclick=history.go(-1)">Back</a></td>
				</tr>
<%  } else {%>
	<tr><td align="right" ><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	</table>
	
<table  cellspacing=0 cellpadding=0 width="80%"	 style="border-collapse: collapse" 	align="center">
<tr>
			<td align="center" class="gridhdbg" colspan=20>NTR Sujala Patakam - Plant Installation Details of <%=dname%>&nbsp;&nbsp;District &nbsp; </td>
	</tr>
	 <tr align="center" >
     <td rowspan=2 class="gridhdbg">SlNo</td>
    <!--  <td rowspan=2 class="gridhdbg">District</td> -->
     <td rowspan=2 class="gridhdbg">Mandal </td>
     <td rowspan=2 class="gridhdbg">Panchayat </td>
     <td rowspan=2 class="gridhdbg">Habitation_code</td>
     <td rowspan=2 class="gridhdbg">Habitation Name</td>
     <td rowspan=2 class="gridhdbg">Habitation Status (FC/PC/QA)</td>     
     <td rowspan=2 class="gridhdbg">Type of plant installed</td>
     <td rowspan=2 class="gridhdbg">Conatamination Type/Contamination Percentage</td>
    </tr>


<tr>
<%
Statement stmt1=null , stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
int count=1;
int styleCount=0;
String style="";
  try{
	    
	  
	  String qry1 = "select distinct habitation_code,CONT_TYPE ,CONT_PERC   from rws_hab_contamination_tbl a ,RWS_NTR_SUJALA_HAB_IMPL_TBL c  where c.habitation_code=a.hab_code and substr(hab_code,1,2)='"+dcode+"'";
	  if(mcode!=null && !mcode.equals(""))
	  {
		  qry1+="  and substr(hab_code,6,2)='"+mcode+"' ";
	  }
	//  System.out.println("qry1*********" + qry1);
	  stmt2=conn.createStatement();	
	  Hashtable contHabsList=new Hashtable();
	  rs2=stmt2.executeQuery(qry1);	   	
	  while (rs2.next()) 
	  { 
		  contHabsList.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
		  
	  }	  
	  
	  session.setAttribute("contHabsList", contHabsList);
	  
	  
		 if(stmt2!=null)
		  {
			  stmt2.close();
		   }
		  if(rs2!=null)
		  {
			  rs2.close();
		  }  
	  

		  
	//////////////////main/////////////////////	
	  String query="select dname,mname,pname,panch_code,panch_name,coverage_status,PLANT_TYPE_INSTALLED   from rws_complete_hab_view a , RWS_NTR_SUJALA_HAB_IMPL_TBL b where a.panch_code=b.habitation_code and dcode='"+dcode+"' ";
	  if(status!=null && !status.equals(""))
	  {
		  query+="  and coverage_status in("+cov_status+") ";
	  }
	  if(mcode!=null && !mcode.equals(""))
	  {
		  query+="  and mcode='"+mcode+"' ";
	  }
	  query+="ORDER BY (CASE coverage_status  WHEN 'FC'  THEN 1  WHEN 'PC4' THEN 2  WHEN 'PC3' THEN 3  WHEN 'PC2' THEN 4 WHEN 'PC1' THEN 5 WHEN 'NSS'  THEN 6  ELSE 100 END) ASC ";
	 // System.out.println("query:"+query);
	  stmt1=conn.createStatement();
	  rs1=stmt1.executeQuery(query);
	  String contcode="",conttype="",contper="";
	  while(rs1.next())
	  	{
	  	
		  if(contHabsList.get(rs1.getString(4))!=null)
		  {
			  String aa=(String)contHabsList.get(rs1.getString(4));
			  String aaValues[]=aa.split("@");
			  
			  contcode=aaValues[0];
			  contper=aaValues[1];
			  
			  if(contcode!=null && contcode.equals("01"))
			  {
                 conttype="Flouride";				 
			  }
			  else if(contcode!=null && contcode.equals("02"))
			  {
				  conttype="Brakish";
			  }
			  else if(contcode!=null && contcode.equals("03"))
			  {
				  conttype="Iron";
			  }
			  else if(contcode!=null && contcode.equals("04"))
			  {
				  conttype="Aresenic";
			  }
			  else if(contcode!=null && contcode.equals("05"))
			  {
				  conttype="Nitrate";
			  }
			  else
			  {
				  conttype="-";
				  
			  }
		  }
		  else
		  {
			 conttype="-";
			 contper="-";
		  }
	  		
		  
		  
	  	 if(styleCount%2==0)
	  	 {
			 style="gridbg1";
		 }else
		 {
			 style="gridbg2";
		 }
		 styleCount++;
		%>
		<tr>
		    <td class=<%=style %> style="text-align: center;"><%=count++%></td>
		   <!--  <td class=<%=style %> style="text-align: left;"><%=rs1.getString(1)%></td> -->
		    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%></td>
		    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(3)%></td>
		    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(4)%></td>
		    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(5)%></td>
		    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(6)%></td>
		    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(7)%></td>
		    <td class=<%=style %> style="text-align: right;"><%=conttype%>/<%=contper %></td>
		    		   
       </tr>

		<%
		
		
		
	  	}
	  
	   	%>
	   	
	   	
	   	<tr>
	   	<td class=gridhdbg style="text-align: center;" colspan=10></td>
	   	
	   	</tr>
	   	
	 <% 
	 if(stmt1!=null)
	  {
		  stmt1.close();
	   }
	  if(rs1!=null){
		  rs1.close();
		  	  }
	  
	  

}catch(Exception e){
  e.printStackTrace();
}

%>

</table>	

	<%@ include file = "/reports/footer.jsp" %>
 </body>
</html>