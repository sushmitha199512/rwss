<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file ="/reports/conn.jsp"%>
<%
 String dist=request.getParameter("dcode");
 String mandal=request.getParameter("mcode");
 String panch=request.getParameter("pcode");
 String vill=request.getParameter("vcode");
 String hab=request.getParameter("habcode");
 Statement stmt1=null;
 ResultSet rs1=null;
 //System.out.println("1:"+dist);
 //System.out.println("2:"+mandal);
 //System.out.println("3:"+panch);
 //System.out.println("4:"+vill);
 // System.out.println("5:"+hab);
 %>
<html>

<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<table border="1" cellspacing=0 cellpadding=0 width="100%"
						align="center" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
						<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</a>
				|<a href="javascript:history.back(-1)">Back</a>
			</tr>
			</table>
		</caption>
	<tr>
		<td align="center" class=btext colspan="10"><font size=2 face="verdana" >School-Asset Report</font></td>	
	</tr>
	
 <%
  try{
  int sno=0;
   String qry="select  distinct nvl(SCHOOL_NAME,'-'),nvl(SCHOOL_CLASSIFICATION,'-'),ASSET_CODE,dname,mname,pname,vname,panch_name,nvl(s.SCHOOL_code,'-'),nvl(s.HAB_code,'-') from rws_school_master_tbl s,rws_school_asset_lnk_tbl a,rws_complete_hab_view v where s.hab_code=a.hab_code and s.hab_code=v.panch_code and a.hab_code=v.panch_code and s.school_code=a.school_code";
   if(dist!=null && !dist.equals("") && !dist.equals("-1"))
   {
   qry+=" and substr(s.hab_code,1,2)='"+dist+"' ";
   }
   if(mandal!=null && !mandal.equals("") && !mandal.equals("-1"))
   {
   qry+=" and substr(s.hab_code,6,2)='"+mandal+"' ";
   }
   if(panch!=null && !panch.equals("") && !panch.equals("-1"))
   {
   qry+=" and substr(s.hab_code,13,2)='"+panch+"' ";
   }
   if(vill!=null && !vill.equals("") && !vill.equals("-1"))
   {
   qry+=" and substr(s.hab_code,8,3)='"+vill+"' ";
   }
   if(hab!=null && !hab.equals("") && !hab.equals("-1"))
   {  
   qry+=" and s.hab_code='"+hab+"' ";
   }
      qry+=" order by 9,10";
 // System.out.println("qry:"+qry);
   stmt=conn.createStatement();
   rs=stmt.executeQuery(qry);
  %> <tr>
      <td class=btext >Sl.No</td>
     <%if(hab!=null && !hab.equals("") && !hab.equals("-1"))
       {
        }
       else if(vill!=null && !vill.equals("") && !vill.equals("-1"))
   		{%>
            <td class=btext >Habitation Name</td>
        <%}else if(panch!=null && !panch.equals("") && !panch.equals("-1"))
   			{%>
             <td class=btext >Village Name</td>
            <td class=btext >Habitation Name</td>
       <%}else if(mandal!=null && !mandal.equals("") && !mandal.equals("-1"))
      {%>
         <td class=btext >Panchayat Name</td>
         <td class=btext >Village Name</td>
         <td class=btext >Habitation Name</td>   
      <%}%>

	  <td class=btext >Hab Code</td>
		  <td class=btext >School Name</td>
		<td class=btext >School Code</td>
	  <td class=btext >School Type</td>
	  <td class=btext >Asset Name</td>
	  <td class=btext >Asset Cost</td>
	  <td class=btext >Date Of Creation</td>
	  
	</tr><%
		String gtxidValueOld = "",gtxidValue="";
   while(rs.next())
     {
	    gtxidValue = ""+rs.getString(1);
     %>
     <tr>
      <td class=rptValue><%=++sno%></td>
 	   <%if(!gtxidValue.equals(gtxidValueOld)){%>
       <%if(hab!=null && !hab.equals("") && !hab.equals("-1"))
   		{
         }
      else if(vill!=null && !vill.equals("") && !vill.equals("-1"))
   			{%>
           <td class=rptValue><%=rs.getString(8)%></td>
           <%}else if(panch!=null && !panch.equals("") && !panch.equals("-1"))
   			{%>
             <td class=rptValue><%=rs.getString(7)%></td>
    		<td class=rptValue><%=rs.getString(8)%></td>
       <%} else if(mandal!=null && !mandal.equals("") && !mandal.equals("-1"))
         {%>
          	<td class=rptValue><%=rs.getString(6)%></td>
   		 	<td class=rptValue><%=rs.getString(7)%></td>
    		<td class=rptValue><%=rs.getString(8)%></td>
         <%}
       %>

    <td class=rptValue><%=rs.getString(10)%></td>
<td class=rptValue><%=rs.getString(1)%></td>
 <td class=rptValue><%=rs.getString(9)%></td>
       <td class=rptValue><%=rs.getString(2)%></td>
<%}else{
        %>
<td  class=rptValue nowrap>&nbsp;</td>
<td  class=rptValue nowrap>&nbsp;</td>
<td  class=rptValue nowrap>&nbsp;</td>
<td  class=rptValue nowrap>&nbsp;</td>
<td  class=rptValue nowrap>&nbsp;</td>
<td  class=rptValue nowrap>&nbsp;</td>
<td  class=rptValue nowrap>&nbsp;</td>
<%}%>
       

   <%
	gtxidValueOld = gtxidValue;
%>
     <%
    String qry1="select nvl(asset_name,'-'),nvl(asset_cost,'0'),nvl(to_char(date_creation,'dd/mm/yyyy'),'0') from rws_asset_mast_tbl where asset_code='"+rs.getString(3)+"'";
    stmt1=conn.createStatement();
    rs1=stmt1.executeQuery(qry1);
    if(rs1.next())
    {
    %> <td class=rptValue><%=rs1.getString(1)%></td>
        <td class=rptValue><%=rs1.getFloat(2)%></td>
        <td class=rptValue><%=rs1.getString(3)%></td>
    <%
    } 
    rs1.close();
    %> 
    
    </tr>
  <%}
  rs.close();
  if(sno==0)
	{%> <tr align="center">
        <td class=rptHeading colspan=10 ><a href="javascript:window.history.back()"><%="No Records Match with this Selection Criteria"%></a></td></tr>
	<% } 
  }catch(Exception e)
  {
  System.out.println("Exception in schools with assets:"+e);
  }
  %> 

</table>

</form>


</body>

</html>