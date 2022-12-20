<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file="conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<form>
<%
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
Statement stmt6=null;
ResultSet rs6=null;
ResultSet rs3=null;
int gtot=0;
int gatot=0;
int bgtot=0;
int tot=0;
int tot1=0;
int tot2=0;

String dcode=(String)session.getAttribute("dcode");


int sno=1;
String qry="";
String queryasset="";
String sa1="";
String cat=(String)session.getAttribute("cat");
if(cat.equals("02"))
{
sa1=" ( Primary )";
}
else if(cat.equals("01"))
{
sa1=" ( Balwadi/Aganwadi )";
}
else if(cat.equals("03"))
{
sa1=" ( Upper Primary )";
}

else if(cat.equals("04"))
{
sa1=" ( Secondary )";
}
else if(cat.equals("05"))
{
sa1=" ( Sr Secondary )";
}







%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" >Schools Coverage Report</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext>Sl.No</td>
               <td class=btext>District</td>
<%if(cat.equals("51")){%>
               <td class=btext>Total No. Of Schools</td> 
<%}else{ %>
       <td class=btext>Total No. Of Schools <br><%=sa1%></td>
<%}
if(cat.equals("51")){%>

			   <td class=btext>Total No. Of Schools Covered</td>
<%}else{ %>
   <td class=btext>Total No. Of Schools Covered <br><%=sa1%></td>
<%} %>
               <td class=btext>Balance</td>   
		   
			   </tr>
<%
try
{
String query = "";   
query="select count(*),substr(s.hab_code,1,2) from rws_school_master_tbl s,rws_district_tbl d where substr(s.hab_code,1,2)=d.dcode  ";
if(cat!=null && !cat.equals("") && !cat.equals("0") &&  !cat.equals("51"))
{
query+=" and s.school_category_code='"+cat+"'   ";
}
query+="  group by substr(s.hab_code,1,2)"; 

// System.out.println("qry2:"+query);
stmt2=conn.createStatement();
rs2=stmt2.executeQuery(query);
Hashtable schools=new Hashtable();
while(rs2.next())
 {
   schools.put(rs2.getString(2),rs2.getString(1));
 }
queryasset="select count(distinct s.hab_code||s.school_code),substr(s.hab_code,1,2) from rws_school_asset_lnk_tbl s,rws_district_tbl d,rws_school_master_tbl p where substr(s.hab_code,1,2)=d.dcode  and p.hab_code||p.school_code=s.hab_code||s.school_code and substr(p.hab_code,1,2)=d.dcode ";  
if(cat!=null && !cat.equals("") && !cat.equals("0") &&  !cat.equals("51"))
{
queryasset+=" and p.school_category_code='"+cat+"'  ";
}
queryasset+="  group by substr(s.hab_code,1,2)"; 

 //System.out.println("qry2:"+queryasset);
stmt=conn.createStatement();
rs=stmt.executeQuery(queryasset);
Hashtable school=new Hashtable();
while(rs.next())
 {
   school.put(rs.getString(2),rs.getString(1));
 }
	 if(dcode!=null && !dcode.equals("") && dcode.equals("00"))
		{
	  qry="select  dcode,dname from rws_district_tbl where dcode<>'16' order by dname";
	  }
	else if(dcode!=null && !dcode.equals("") && !dcode.equals("00"))
	{
	  qry="select  dcode,dname from rws_district_tbl where dcode='"+dcode+"'";
	  }
  
   
//System.out.println("qry2:"+qry);
stmt1=conn.createStatement();
rs1=stmt1.executeQuery(qry);
  while(rs1.next())
  {
String ast=""+schools.get(rs1.getString(1));
		  if(ast!=null && !ast.equals("") && !ast.equals("null")){} else{ ast="0";}
String ast1=""+school.get(rs1.getString(1));
		  if(ast1!=null && !ast1.equals("") && !ast1.equals("null")){} else{ ast1="0";}
int s1=Integer.parseInt(ast);
int s2=Integer.parseInt(ast1);
int s3=s1 - s2;
gtot+=s1;
gatot+=s2;
bgtot+=s3;
%>
<tr>
<td class="rptValue"><%=sno++%></td>
<td class="rptValue"><%=rs1.getString(2)%></td>
<td class="rptValue"><%=ast%></td>
<td class="rptValue"><%=ast1%></td>
<td class="rptValue"><%=s3%></td>
</tr>
<%


}
%>
<tr>
<td class="btext" align="left">Total</td>
<td class="btext" align="left"></td>
<td class="btext" align="left"><%=gtot%></td>
<td class="btext" align="left"><%=gatot%></td>
<td class="btext" align="left"><%=bgtot%></td>
</tr>


<%	

}
catch(Exception e)
{
e.printStackTrace();
}
finally
{
try
{
if(rs2 != null)
{
rs2.close();
}
if(stmt2 != null)
{
stmt2.close();
}
if(rs != null)
{
rs.close();
}
if(stmt != null)
{
stmt.close();
}


if(rs1 != null)
{
rs1.close();
}
if(stmt1 != null)
{
stmt1.close();
}
if( conn != null )
{
conn.close();
}



}
catch(Exception p)
{
p.printStackTrace();
}
}
%>

<%@ include file="connClose.jsp" %>  <%}finally{}%>
</table>