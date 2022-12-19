<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<form name="f1">
<%
java.text.DecimalFormat ndf = new java.text.DecimalFormat("####.00");
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;


String attend="";
String a="";
double bank=0;
double pao=0;
double ssr=0,ssr1=0,ssr2=0,ssr3=0,ssr4=0,ssr5=0,ssr6=0,ssr7=0,ssr8=0,ssr9=0,ssr10=0,ssr11=0,ssr12=0;
double gtcount=0,gtcountssr1=0,gtcountssr2=0,gtcountssr3=0,gtcountssr4=0,gtcountssr5=0,gtcountssr6=0,gtcountssr7=0,gtcountssr8=0,gtcountssr9=0;
double gtcountssr10=0,gtcountssr11=0,gtcountssr12=0;

int sno=1;
int gcount=0;
int gcomplaintcount=0;
int dcount=0;
int gncomplaintcount=0;
String cDate=null;
int f1,gf1=0;
int d1,gd1=0;


int year=Integer.parseInt(RwsUtils.getCurrentYear());
int year1=year+1;
String finYear=year+"-"+(year+1);
System.out.println("Year:"+finYear);
String stankCode=null;
boolean flag=false;


%>
<style type="text/css" media="print">
@page
{
	size: landscape;
	margin: 2cm;
}
</style>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js">



<script type="text/javascript">
function fnSubmit()
{

  var d=document.getElementById('demo1').value;//date value
  document.f1.action="./rws_physical_bank_mpr_rpt.jsp";
  document.f1.mydate.value=d; 
  document.f1.submit();

}
</script>

<input type="hidden" name="mydate" >


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"   border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
	
				 <td class="bwborder"><a href="#" onclick="window.close()">Close</a> &nbsp;<a href="#" onclick="window.print()"><img src="../images/print_icon.jpg"></a>
				</td>
			
			</tr>  
		</table>
	</caption>




	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="15">Pending Works:<%= finYear %></td>
</tr>
               <td class=btext >S.No</td>
               <td class=btext>District</td>
			
			   <td class=btext align=center>No Of Works For Pending</td>
			   <td class=btext align=center>No Of Works For Clearance</td>
			   
               
			
			

</tr>
		   
		
			   <%


			   String mnth=request.getParameter("mnth");
			     if(mnth==null){
						mnth="APR";
				 }
try
{
  

String query="select count(*),substr(work_id,5,2) from rws_notgroundworks_status_tbl where (LANDAQUISITION ='Y' and LANDAQUISITIONOBTAINDATE  is null) or(WATERDRAWLPERMISSION ='Y' and  WATERDRAWLPERMISSIONOBTAINDATE is null) or (RAILWAYCROSSINGPERMISSION ='Y' and RAILWAYCROSSINGPEROBTAIN is null) or (ROADCROSSINGPERMISSIONSTATE='Y' and ROADCROSSINGPEROBTAINDATE  is null) or (ROADCROSSINGPERMISSIONNHAI='Y' and ROADCROSSINGNHAIOBTAINDATE is null) or (FORESTCLEARANCE='Y' and FORESTCLEARANCEOBTAINDATE is null) or (OTHERS='Y' and OTHERSOBTAINDATE is null) group by substr(work_id,5,2)" ;
  Hashtable cht=new Hashtable();
   stmt=conn.createStatement();
  rs=stmt.executeQuery(query);
while(rs.next()){

      cht.put(rs.getString(2),rs.getString(1));
}


String query11="select count(*),substr(work_id,5,2) from rws_notgroundworks_status_tbl where (LANDAQUISITION ='Y' and LANDAQUISITIONOBTAINDATE  is not null) or(WATERDRAWLPERMISSION ='Y' and  WATERDRAWLPERMISSIONOBTAINDATE is not null) or (RAILWAYCROSSINGPERMISSION ='Y' and RAILWAYCROSSINGPEROBTAIN is not null)or (ROADCROSSINGPERMISSIONSTATE='Y' and ROADCROSSINGPEROBTAINDATE  is not null) or (ROADCROSSINGPERMISSIONNHAI='Y' and ROADCROSSINGNHAIOBTAINDATE is not null) or (FORESTCLEARANCE='Y' and FORESTCLEARANCEOBTAINDATE is not null) or (OTHERS='Y' and OTHERSOBTAINDATE is not null) group by substr(work_id,5,2)" ;
  Hashtable cht1=new Hashtable();
   stmt3=conn.createStatement();
  rs3=stmt3.executeQuery(query11);
while(rs3.next()){

      cht1.put(rs3.getString(2),rs3.getString(1));
}
 
 
    String query1="select dname,dcode from rws_district_tbl where dcode<>'16'" ;
  // System.out.println("district11........:"+qry);
    int count = 1; 
  	stmt1=conn.createStatement();
   rs1=stmt1.executeQuery(query1);
    int pworks=0,cworks=0,gpworks=0,gcworks=0;
  while (rs1.next())
	{ 
 
String pcount=(String)cht.get(rs1.getString(2));
 if(pcount!=null){
   pworks=		Integer.parseInt(pcount);
gpworks+=pworks;
}

String ccount=(String)cht1.get(rs1.getString(2));
 if(ccount!=null){
   cworks=		Integer.parseInt(ccount);
gcworks+=cworks;
}

  %>
  
  <tr><td class=rptLabel ><%=sno++ %></td>
  <td class=rptLabel  ><%=rs1.getString(1)%></td>
  
   <td class=rptValue  align=center><a href="rws_sec_pending_abstract_drill.jsp?dcode=<%=rs1.getString(2) %>"><%=pworks %></a></td>
   <td class=rptValue  align=center><a href=""><%=cworks %></a></td>

  </tr>
  
  <%
			
 pworks=0;cworks=0;
}
%>
<tr><td class=rptLabel colspan=2 align=right>Total:</td><td class=rptLabel align=center><%=gpworks %></td><td class=rptLabel align=center><%=gcworks %></td></tr>

<%

}
catch(Exception e)
{
	e.printStackTrace();
	
}
%>
</table>
</form>
<center>
<%@ include file="/commons/rws_footer.jsp" %>
</center>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


