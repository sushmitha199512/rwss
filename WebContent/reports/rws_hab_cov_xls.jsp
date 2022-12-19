<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="conn.jsp" %>
<form>
<%
    Statement stmt8=null,stmt2=null,stmt3=null;
    String qry="";
	String dname=(String)session.getAttribute("dname");
    int sno=1;
String qry8="",qry9="";
	
	String dcode=(String)session.getAttribute("district");
    
	String finYear=(String)session.getAttribute("finYear");
   System.out.println("finyear:"+finYear);
    String sYear=finYear.substring(0,4);
    String eYear=finYear.substring(5,9);
	String scheme=(String)session.getAttribute("scheme");





int gfc=0,gpc4=0,gpc3=0,gpc2=0,gpc1=0,gqa=0,gnc=0,gui=0;
		%>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class=btext  nowrap align=center>Sl.No</td>
    <td class=btext  nowrap align=center>District</td>
	<td class=btext  nowrap align=center>No&nbsp;Works&nbsp;Completed</td>
	<td class=btext  nowrap align=center>No&nbsp;Habs&nbsp;Covered</td>
	<td class=btext  nowrap align=center>FC</td>
	<td class=btext  nowrap align=center>PC4</td>
<td class=btext  nowrap align=center>PC3</td>
	<td class=btext  nowrap align=center>PC2</td>
	<td class=btext  nowrap align=center>PC1</td>
    	<td class=btext  nowrap align=center>QA(NSS)</td>
    	<td class=btext  nowrap align=center>NC</td>
    	<td class=btext  nowrap align=center>UI</td>

	
	</tr>
<%
try
{
      
stmt2=conn.createStatement();
stmt3=conn.createStatement();

ResultSet rs2=stmt2.executeQuery("select distinct a.hab_code,coverage_status from rws_habitation_directory_tbl a,rws_work_comp_hab_lnk_tbl  b where a.hab_code=b.hab_code");

Hashtable habCov=(Hashtable)session.getAttribute("habCov");
if(habCov==null ){
habCov=new Hashtable();
while(rs2.next()){

habCov.put(rs2.getString(1),rs2.getString(2));

}
session.setAttribute("habCov",habCov);
}



String mainQuery="select substr(A.WORK_ID,1,2),count(*)  from rws_work_completion_tbl a,rws_work_admn_tbl b  where a.work_id=b.work_id and b.type_of_asset in("+scheme+") and to_date(DATE_OF_COMPLETION ,'dd-MM-yy')<'1-APR-"+sYear+"' and to_date(UPDATE_DATE ,'dd-MM-yy') >='1-APR-"+sYear+"' AND  to_date(UPDATE_DATE ,'dd-MM-yy') < ='31-MAR-"+eYear+"'  group by substr(A.WORK_ID,1,2) order by substr(A.WORK_ID,1,2)";

	
stmt8=conn.createStatement();




if(dcode.equals("ALL"))
{
qry8="select substr(a.WORK_ID,5,2),dname,count(*)  from rws_work_completion_tbl a ,rws_district_tbl ,rws_work_admn_tbl b where a.work_id=b.work_id and b.type_of_asset in("+scheme+") and substr(a.WORK_ID,5,2)=dcode and  to_date(DATE_OF_COMPLETION ,'dd-MM-yy')<'1-APR-"+sYear+"' and to_date(UPDATE_DATE ,'dd-MM-yy') >='1-APR-"+sYear+"' AND  to_date(UPDATE_DATE ,'dd-MM-yy') < ='31-MAR-"+eYear+"'  group by substr(a.WORK_ID,5,2),dname order by substr(a.WORK_ID,5,2)";
}
else
{
qry8="select substr(a.WORK_ID,5,2),dname,count(*)  from rws_work_completion_tbl   a ,rws_district_tbl ,rws_work_admn_tbl b where a.work_id=b.work_id and b.type_of_asset in("+scheme+") and  substr(a.WORK_ID,5,2)=dcode and  to_date(DATE_OF_COMPLETION ,'dd-MM-yy')<'1-APR-"+sYear+"' and to_date(UPDATE_DATE ,'dd-MM-yy') >='1-APR-"+sYear+"' AND  to_date(UPDATE_DATE ,'dd-MM-yy') < ='31-MAR-"+eYear+"'  and dcode='"+dcode+"' group by substr(a.WORK_ID,5,2),dname order by substr(a.WORK_ID,5,2)";
}

System.out.println("qry8:"+qry8);

 ResultSet rrs=stmt8.executeQuery(qry8);
ResultSet rs5=null;int gtothabCount=0;;
 int wcompCount=0;
while(rrs.next()){

  wcompCount+=Integer.parseInt(rrs.getString(3));

String subQuery="select distinct hab_code  from rws_work_completion_tbl  a,rws_work_comp_hab_lnk_tbl   b ,rws_work_admn_tbl c where a.work_id=c.work_id and c.type_of_asset in("+scheme+") and  substr(a.work_id,5,2)='"+rrs.getString(1)+"' and  a.work_id=b.work_id and to_date(DATE_OF_COMPLETION ,'dd-MM-yy')<'1-APR-2012' and to_date(a.UPDATE_DATE ,'dd-MM-yy') >='1-APR-2012' AND  to_date(a.UPDATE_DATE ,'dd-MM-yy') < ='31-MAR-2013'";
System.out.println("ss"+subQuery);
rs5=stmt3.executeQuery(subQuery);

int fc=0,pc4=0,pc3=0,pc2=0,pc1=0,qa=0,nc=0,ui=0;

int tothabCount=0;
   while(rs5.next()){
	tothabCount++;


 String status=(String)habCov.get(rs5.getString(1));
   if(status!=null && status.equals("FC")){
          fc++;
     } else    if(status!=null && status.equals("PC4")){
          pc4++;
     } else  if(status!=null && status.equals("PC3")){
          pc3++;
     } else  if(status!=null && status.equals("PC2")){
          pc2++;
     } else    if(status!=null && status.equals("PC1")){
          pc1++;
     } else    if(status!=null && status.equals("NSS")){
          qa++;
     }
else    if(status!=null && status.equals("NC")){
          nc++;
     }
else if(status!=null && status.equals("UI")){
          ui++;
     }
	else {
			System.out.println("Status:"+status);
   System.out.println("Habcode:"+rs5.getString(1));
		}

 	}
gtothabCount+=tothabCount;
gfc+=fc;gpc4+=pc4;gpc3+=pc3;gpc2+=pc2;gpc1+=pc1;gqa+=qa;
gnc+=nc;gui+=ui;
  %>

	<tr>
    <td class="btext"><%=sno++%></td>
        <td class="rptValue" align=left><%=rrs.getString(2) %></td>
    <td class="rptValue" align=left><%=rrs.getString(3) %></td>
 <td class="rptValue" align=left><%=tothabCount %></td>  
    <td class="rptValue" align=left><%=fc %></td>
    <td class="rptValue" align=left><%=pc4 %></td>  
<td class="rptValue" align=left><%=pc3 %></td>
    <td class="rptValue" align=left><%=pc2 %></td>  
<td class="rptValue" align=left><%=pc1 %></td>
    <td class="rptValue" align=left><%=qa %></td> 
    <td class="rptValue" align=left><%=nc %></td> 
    <td class="rptValue" align=left><%=ui %></td>  

    </tr>

<% 
	}

%>
<tr>
    <td class="btext" colspan=2>Total:</td>
        <td class="btext" align=left><%=wcompCount %></td>
    <td class="btext" align=left><%=gtothabCount %></td>
  <td class="btext" align=left><%=gfc %></td>
    <td class="btext" align=left><%=gpc4 %></td>  
<td class="btext" align=left><%=gpc3 %></td>
    <td class="btext" align=left><%=gpc2 %></td>  
<td class="btext" align=left><%=gpc1 %></td>
    <td class="btext" align=left><%=gqa %></td>  
    <td class="btext" align=left><%=gnc %></td>  
    <td class="btext" align=left><%=gui %></td>  

    </tr>

<% 
	}catch(Exception e)
		{
		e.printStackTrace();
		}
finally
{
try
{
if(stmt8 != null)
{
stmt8.close();
}
if( conn != null )
{
conn.close();
}
}
catch(SQLException p)
{
p.printStackTrace();
}
}
%>
     

</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>

</p>

  
