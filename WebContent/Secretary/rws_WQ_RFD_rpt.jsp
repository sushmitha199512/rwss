<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>

<script language="JavaScript">


function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}


</script>

<body>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

String dcode="";

if(request.getParameter("district")!=null && !request.getParameter("district").equals("")){
dcode=request.getParameter("district");

}else{
	dcode=request.getParameter("dcode");
}
  session.setAttribute("dcode",dcode);
String divCode="";

if(request.getParameter("divCode")!=null){
divCode=request.getParameter("divCode");
}
  session.setAttribute("divCode",divCode);

String finYear=request.getParameter("finyear");
  session.setAttribute("finYear",finYear);

String yr =finYear.substring(0,4);
  session.setAttribute("yr",yr);

String prevMonth=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String prevprevMonth=RwsUtils.getPreviousMonth1().toUpperCase();


Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null,rs2=null;

int count=1;
try{
    stmt2=conn.createStatement();
    stmt3=conn.createStatement();
		%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	       <table border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.go(-1)">Back| 
                    <a href="" target="_new"></a>
                 </td>
			</tr>
		 </table>
</caption>
        <tr align=center  align=center>
		<td class=rptValue colspan="6"><b><font color="blue">WaterQuality Lab Abstract <font color="red"><%=finYear %></font></font></b></td>
		</tr>
      	<tr align=center>
		<td class=btext rowspan=3>Sl.No</td>
		<td class=btext rowspan=3>Circle</td>

		<td class=btext rowspan=3>Lab</td>
  
</tr>
<tr>
<td class=btext  colspan=3 align=center ><b>Water Quality tests conducted through Labs</b></td>
</tr>


<tr>
<td class=btext align=center >Up TO<br> (<%=prevprevMonth %>-<%=yr %>)</td>
<td class=btext align=center >During<br>(<%=prevMonth %>-<%=yr %>)</td>
<td class=btext align=center >During <br>(<%=cmonth %>-<%=yr %>)</td>



</tr>

       <tr align=center>
       <td class=btext>1</td>
        <td class=btext>2</td>
		<td class=btext>3</td>
		<td class=btext>4</td>
		<td class=btext>5</td>
	<td class=btext>6</td>

			</tr>
	<%
      



String q1="select substr(d.office_code,2,2),d.lab_code,count(*) from rws_wq_test_results_tbl a,RWS_WATER_QUALITY_LAB_TBL d where  to_date(a.prepared_on)>='1-APR-"+yr+"' and to_date(a.prepared_on)<'1-"+prevMonth+"-"+yr+"'  and  a.test_id in(select test_id from rws_wq_test_results_lnk_tbl) and a.lab_code=d.lab_code group by substr(d.office_code,2,2),d.lab_code";
System.out.println("Q1"+q1);
stmt=conn.createStatement();
	
			ResultSet rss=stmt.executeQuery(q1);
			Hashtable uptoHash=new Hashtable();
			while(rss.next())
			{
			  uptoHash.put(rss.getString(1)+rss.getString(2),rss.getString(3));
			}


            
 if(rss!=null){rss.close();}
            if(stmt!=null){stmt.close();}



String q2="select substr(d.office_code,2,2),d.lab_code,count(*) from rws_wq_test_results_tbl a,RWS_WATER_QUALITY_LAB_TBL d where  to_date(a.prepared_on)>='1-"+prevMonth+"-"+yr+"' and to_date(a.prepared_on)<'1-"+cmonth+"-"+yr+"'  and a.test_id in(select test_id from rws_wq_test_results_lnk_tbl) and a.lab_code=d.lab_code group by substr(d.office_code,2,2),d.lab_code";
System.out.println("Q1"+q2);
stmt=conn.createStatement();
	
			 rss=stmt.executeQuery(q2);
			Hashtable prevHash=new Hashtable();
			while(rss.next())
			{
			  prevHash.put(rss.getString(1)+rss.getString(2),rss.getString(3));
			}


            
 if(rss!=null){rss.close();}
            if(stmt!=null){stmt.close();}
			


String q3="select substr(d.office_code,2,2),d.lab_code,count(*) from rws_wq_test_results_tbl a,RWS_WATER_QUALITY_LAB_TBL d where  to_date(a.prepared_on)>='1-"+cmonth+"-"+yr+"'  and a.test_id in(select test_id from rws_wq_test_results_lnk_tbl)  and a.lab_code=d.lab_code group by substr(d.office_code,2,2),d.lab_code";
System.out.println("Q3"+q3);
stmt=conn.createStatement();
	
		rss=stmt.executeQuery(q3);
			Hashtable currentHash=new Hashtable();
			while(rss.next())
			{
			  currentHash.put(rss.getString(1)+rss.getString(2),rss.getString(3));
			}


            
 if(rss!=null){rss.close();}
            if(stmt!=null){stmt.close();}




long tot1=0,tot2=0,tot3=0;
			
 String dname="",divname="";
			String query="";


 query="select a.circle_office_code,a.circle_office_name,c.LAB_CODE,c.lab_name from rws_circle_office_tbl a,RWS_WATER_QUALITY_LAB_TBL  C where   substr(c.office_code,2,2)=a.circle_office_code  and c.status<>'UI' ";
 if(dcode!=null && !dcode.equals("00")){
		query+=" and a.circle_office_code='"+dcode+"'";
	}
 query+="  order by a.circle_office_code";
int slno=1;
             
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(query);
            


			  while(rs.next())
		     {
            	boolean flag=false;		
    String upTo=(String)uptoHash.get(rs.getString(1)+rs.getString(3));	
 if(upTo==null){
upTo="0";
}else{
  tot1+=Long.parseLong(upTo);
}	
String prev=(String)prevHash.get(rs.getString(1)+rs.getString(3));	
 if(prev==null){
prev="0";
}else{
 tot2+=Long.parseLong(prev);
}	
String cur=(String)currentHash.get(rs.getString(1)+rs.getString(3));	
 if(cur==null){
cur="0";
}else{
 tot3+=Long.parseLong(cur);
}	

	       %>
	        <tr>
          
		        <td class=rptLabel><%=slno++%></td>
		        <% 
if(!dname.equals(rs.getString(2))){
dname=rs.getString(2);
flag=true;
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>

 <% 
if(!divname.equals(rs.getString(4))){

divname=rs.getString(4);
%>
<td  class=rptLabel><%=divname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>
				

<td class=rptValue align=right><%=upTo%></td>
<td class=rptValue align=right><%=prev%></td>
<td class=rptValue align=right><%=cur%></td>


				
		    </tr>




<% 

		}
%>
<tr><td colspan=3 class=btext align=right>Total:</td><td class=btext align=right><%=tot1 %></td><td class=btext align=right><%=tot2 %></td><td class=btext align=right><%=tot3 %></td></tr>
	
		    <%
  }    
	
     catch(Exception e)
	   {

        e.printStackTrace();
	   }
	  
	   %>
</table>

</body>
</html>

	  