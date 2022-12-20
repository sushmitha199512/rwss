<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form name="f1">
<%
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null;


String attend="";
String a="";



int sno=1;
int gcount=0;
int gcomplaintcount=0;
int dcount=0;
int gncomplaintcount=0;
String cDate=null;
int f1,gf1=0;
int d1,gd1=0;

String s;
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
s = formatter.format(date);
String currentdate=s.replace("/","-");
String rvalue=request.getParameter("mydate");
if(rvalue!=null){
session.setAttribute("rvalue",rvalue);
}
if(rvalue==null)
rvalue=currentdate;
String stankCode=null;
boolean flag=false;


%>

<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js">

//Date Time Picker script- by TengYong Ng of http://www.rainforestnet.com
//Script featured on JavaScript Kit (http://www.javascriptkit.com)
//For this script, visit http://www.javascriptkit.com 

</script>
<script type="text/javascript">
function fnSubmit()
{

  var d=document.getElementById('demo1').value;//date value
  document.f1.action="./rws_physical_mpr_rpt.jsp";
  document.f1.mydate.value=d; 
  document.f1.submit();

}
</script>

<table border = 1 cellspacing = 0 cellpadding = 0 height=2% width="30%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
    <caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					
					</td>
				</tr>
			</table>
		</caption>
   <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>month</td>	
	</tr>
    <tr><td class=rptLabel>Select Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="25" value="<%=rvalue%>">
       <a href="javascript:NewCal('demo1','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td>
    </tr> 
   <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
  </table>


<input type="hidden" name="mydate" >

<table border = 1 cellspacing = 0 cellpadding = 0 width="90%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
	
				 <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a>
				<a href="./rws_drought_sstank_xls_rpt.jsp" target=_new>Excel</a></td>
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Physical MPR:</td>
</tr>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext >Sl.No</td>
               <td class=btext >District</td>
               <td class=btext >upto the Month</td> 
			   <td class=btext >During the month</td>
			   <td class=btext >Total</td>
			   
		   
			   </tr>
<%
try
{
	int sno=1;
	int total=0;


	String query="select dname from rws_district_tbl where dcode<>'16'" ;
	System.out.println("query*********"+query);
  stmt1=conn.createStatement();
  System.out.println("stmt1*********"+stmt1);
  rs1=stmt1.executeQuery(query);
 
  while (rs1.next())
	{
	
  %><tr><td class=rptValue NOWRAP><%=rs1.getString(1)%></td></tr> <%
			

}


}
catch(Exception e)
{
	e.printStackTrace();
	
}
%>
</table>
</form>

<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


