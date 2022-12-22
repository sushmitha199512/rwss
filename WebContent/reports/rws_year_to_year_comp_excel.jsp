<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

	<% 


    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialyr="";
	
    double aas=0;
    String pname="";
pname=(String)session.getAttribute("pname");
String dcode=(String)session.getAttribute("dcode");
String divCode=(String)session.getAttribute("divCode");
  	
	String[] programes=request.getParameterValues("program");
	
    String programe=(String)session.getAttribute("programe");
	   
String sysdate=workData.getDate();
   System.out.println("sysdate::"+sysdate);

   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   System.out.println("sysmonth::"+mon);

   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
   System.out.println("sysyear::"+sysyear);

    int fyear=0,fyear1=0;
    int mymon=0;
    fyear=yy-2;
    fyear1=yy-1; 
 
    if(mon==1)
	{
      mymon=12;
	}
	else
	{
     mymon=mon-1;
	} 
  
    System.out.println("mymonth"+mymon);

    String months[]={"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
   	String cmonth=months[mymon-1];
   
    System.out.println("fYear"+fyear);
    System.out.println("fYear1"+fyear1);
    System.out.println("month"+cmonth);

	%>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
               <td align="center" class="staticLabel" colspan=6><b><font color="Black">Year-to-Year Comparision Report <br> Programmes:</font><font color="white"><%=pname%> Programe(s)</font></b></td>	
	</tr>
		<tr>
		<td class=btext rowspan=2>Sl.No</td>
		<td class=btext rowspan=2>District</td>
<td class=btext colspan=2 align="center" style="background-color:lightyellow">Financial Expenditure Incurred</td>
<td class=btext colspan=2 align="center" style="background-color:lightpink">Physical(Habs Covered)</td>
</tr>
<tr>
		<td class=btext align="center" style="background-color:lightyellow">Upto <%=cmonth%>-<%=fyear%></td>
		<td  class=btext align="center" style="background-color:lightyellow">Upto <%=cmonth%>-<%=fyear1%></td>
		<td  class=btext align="center" style="background-color:lightpink">Upto <%=cmonth%>-<%=fyear%></td>
		<td class=btext align="center" style="background-color:lightpink">Upto <%=cmonth%>-<%=fyear1%></td>
 
</tr>



<%
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null;
ResultSet rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
int count=1;
try{
    stmt2=conn.createStatement();
	stmt3=conn.createStatement();
	stmt4=conn.createStatement();
    stmt5=conn.createStatement();

String finqry1="SELECT substr(a.work_id,5,2),sum(nvl(voucher_Amt,'0')) FROM rws_work_exp_voucher_tbl a,rws_work_admn_tbl b  where a.work_id=b.work_id and  substr(a.work_id,1,2) in ("+programe+") and b.type_of_asset in (01,02,03) and  VOUCHER_DT>=to_date('1/04/"+fyear+"','dd/mm/yy') and  VOUCHER_DT<to_date('1/1/"+fyear1+"','dd/mm/yy') group by substr(a.work_id,5,2)";
	stmt3=conn.createStatement();
   // System.out.println("finqry1:"+finqry1);
	rs3=stmt3.executeQuery(finqry1);
	Hashtable List1=new Hashtable();
	while(rs3.next())
	{
		List1.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();


String finqry2="SELECT substr(a.work_id,5,2),sum(nvl(voucher_Amt,'0')) FROM rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and substr(a.work_id,1,2) in ("+programe+") and b.type_of_asset in (01,0,03) and  VOUCHER_DT>=to_date('1/04/"+fyear1+"','dd/mm/yy') and  VOUCHER_DT<to_date('1/1/"+yy+"','dd/mm/yy') group by substr(a.work_id,5,2)";
	stmt4=conn.createStatement();
   // System.out.println("finqry2:"+finqry2);
	rs4=stmt4.executeQuery(finqry2);
	Hashtable List2=new Hashtable();
	while(rs4.next())
	{
		List2.put(rs4.getString(1),rs4.getString(2));
	}
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();


String phyqry1="select distinct substr(a.work_id,5,2),count(*) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c where work_cancel_dt is null  and a.work_id=b.work_id  and b.work_id=c.work_id and substr(a.work_id,1,2) in ("+programe+")  and a.type_of_asset in (01,02,03) and date_of_completion>=to_date('1/04/"+fyear+"','dd/mm/yy') and  date_of_completion<to_date('1/1/"+fyear1+"','dd/mm/yy') group by substr(a.work_id,5,2)";
	stmt5=conn.createStatement();
   // System.out.println("phyqry1:"+phyqry1);
	rs5=stmt5.executeQuery(phyqry1);
	Hashtable List3=new Hashtable();
	while(rs5.next())
	{
		List3.put(rs5.getString(1),rs5.getString(2));
	}
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();

String phyqry2="select distinct substr(a.work_id,5,2),count(*) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c where work_cancel_dt is null  and a.work_id=b.work_id  and b.work_id=c.work_id and substr(a.work_id,1,2) in ("+programe+")  and a.type_of_asset in (01,02,03) and date_of_completion>=to_date('1/04/"+fyear1+"','dd/mm/yy') and  date_of_completion<to_date('1/1/"+yy+"','dd/mm/yy') group by substr(a.work_id,5,2)";
	stmt6=conn.createStatement();
    //System.out.println("phyqry2:"+phyqry2);
	rs6=stmt6.executeQuery(phyqry2);
	Hashtable List4=new Hashtable();
	while(rs6.next())
	{
		List4.put(rs6.getString(1),rs6.getString(2));
	}
	if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();


/***********************************End  ************************************/

String query="";
double value1=0,value1_tot=0,value2=0,value2_tot=0;
int value3=0,value3_tot=0,value4=0,value4_tot=0;
query="select b.dcode,b.dname from rws_district_tbl b where b.dcode<>'16' order by b.dcode";

rs2=stmt2.executeQuery(query);
String dname="";
while(rs2.next())
{

String amt1=(String)List1.get(rs2.getString(1));     
if(amt1!=null && !amt1.equals("null"))
   {
    value1=Double.parseDouble(amt1)/100000;	    
   }

String amt2=(String)List2.get(rs2.getString(1));     
if(amt2!=null && !amt2.equals("null"))
   {
    value2=Double.parseDouble(amt2)/100000;	    
   }

String cnt1=(String)List3.get(rs2.getString(1));     
if(cnt1!=null && !cnt1.equals("null"))
   {
    value3=Integer.parseInt(cnt1);	    
   }

String cnt2=(String)List4.get(rs2.getString(1));     
if(cnt2!=null && !cnt2.equals("null"))
   {
    value4=Integer.parseInt(cnt2);	    
   }
%>
<tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs2.getString(2))){
dname=rs2.getString(2);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else
{
%>
<td  class=rptLabel></td>
<%} %>
<td class=rptValue style="background-color:lightyellow" align="right"><%=ndf.format(value1)%></td>
<td class=rptValue style="background-color:lightyellow" align="right"><%=ndf.format(value2)%></td>
<td class=rptValue style="background-color:lightpink" align="right"><%=value3%></td>
<td class=rptValue style="background-color:lightpink" align="right"><%=value4%></td>
</tr>
<% 

value1_tot+=value1;
value2_tot+=value2;
value3_tot+=value3;
value4_tot+=value4;
value1=0;
value2=0;
value3=0;
value4=0;
  }//while
%>
<tr><td colspan=2 class=btext align=right>Total:</td>
<td class=btext style="background-color:lightyellow" align="right"><%=ndf.format(value1_tot) %></td>
<td class=btext style="background-color:lightyellow" align="right"><%=ndf.format(value2_tot) %></td>
<td class=btext style="background-color:lightpink" align="right"><%=value3_tot%></td>
<td class=btext style="background-color:lightpink" align="right"><%=value4_tot%></td>
</tr>
<%
}//try
catch(Exception e)
{
  e.printStackTrace();
}

 %>

</table>	