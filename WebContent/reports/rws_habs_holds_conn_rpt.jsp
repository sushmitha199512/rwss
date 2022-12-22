<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<%
String dcode=request.getParameter("district");



 //System.out.println("lpcd status is "+lpcd); 	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();


    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
<script language="JavaScript">


	
	
function wopen(url, name, w, h)
{

w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}


function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

</script>



   	<body onload="checklpcd()"><form>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	    
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="gridhdbg" > Panchayat Wise Habitations, House Connections and House Holds</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg>Sl.No</td>
    <td class=gridhdbg>District</td>
    <td class=gridhdbg>Mandal</td>
    <td class=gridhdbg>Panchayat</td> 
	<td class=gridhdbg>Habs</td>
    
    <td class=gridhdbg>House Holds</td>
    <td class=gridhdbg>House Conn.</td>
    
	</tr>
	<tr>
       </tr>
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   int totalhouseConn=0,totalhouseholds=0,totalhabs=0;
   
qry="select dname,a.dcode as dcode,mname,b.mcode as mcode,pname,pcode from rws_district_tbl a,rws_mandal_tbl b,rws_panchayat_tbl c where a.dcode=b.dcode and a.dcode=c.dcode and b.mcode=c.mcode and c.dcode='"+dcode+"'";

	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
   	
		String Query="select NVL(count(HAB_CODE),0) AS HABCOUNT,NVL(sum(NO_OF_HOUSECONN_GIVEN),0) AS HOUSECONN,NVL(sum(HOUSEHOLD_NO),0) AS HOUSEHOLDS from rws_habitation_directory_tbl a,rws_complete_hab_view c where a.hab_code=c.panch_code and SUBSTR(HAB_CODE,1,2)='"+rs8.getString("dcode")+"' AND SUBSTR(HAB_CODE,6,2)='"+rs8.getString("mcode")+"' AND SUBSTR(HAB_CODE,13,2)='"+rs8.getString("pcode")+"'";
  	stmt=conn.createStatement();
  	rs=stmt.executeQuery(Query);
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	
if(rs.next()){
	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString("dname")%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString("mname")%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString("pname")%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=rs.getInt("HABCOUNT")%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=rs.getInt("HOUSEHOLDS")%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs.getInt("HOUSECONN")%></td>

        
 
   	</tr>
   	
   	
<%
totalhabs+=rs.getInt("HABCOUNT");
totalhouseConn+=rs.getInt("HOUSECONN");
totalhouseholds+=rs.getInt("HOUSEHOLDS");
}
stmt.close();
rs.close();
}
	if(stmt8!=null){
		stmt8.close();
	}
	if(rs8!=null){
		rs8.close();
	}
	%>
	<tr>
	<td class="gridhdbg" style="text-align: right;" colspan=4 >Total:</td>
	<td class="gridhdbg" style="text-align: right;"><%=totalhabs %></td>
	<td class="gridhdbg" style="text-align: right;"><%=totalhouseholds %></td>
	<td class="gridhdbg" style="text-align: right;"><%=totalhouseConn %></td>
	
	</tr>
	<%
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table></form>
</body>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>