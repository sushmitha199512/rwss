
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<% 
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "Water_Facility.xls");
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

<form>
<%

String dcode=(String)session.getAttribute("dcode");
//System.out.println("dcode**********" +dcode);
String mcode=(String)session.getAttribute("mcode");
  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation /<Br>Habitation Code </td>
    <td class=gridhdbg rowspan=2>Total StandPosts </td>
    <td class=gridhdbg rowspan=2>Total Households</td>
    <td class=gridhdbg rowspan=2>Total Multi StandPost </td>
    <td class=gridhdbg rowspan=2>Total Multi Households</td>
    <td class=gridhdbg rowspan=2>Total Pumps </td>
    <td class=gridhdbg rowspan=2>Total OpenWell	 </td>
    <td class=gridhdbg rowspan=2>Seasonal </td>
    <td class=gridhdbg rowspan=2>Through out Year</td>
    <td class=gridhdbg rowspan=2>Survey Date </td>
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
   
   
qry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_STANDPOSTS,TOTAL_HOUSEHOLDS,TOTAL_MULTI_STANDPOST,TOTAL_MULTI_HOUSEHOLDS,TOTAL_PUMPS,TOTAL_OPENWELL,SEASONAL,THROUGH_OUT_YEAR,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_water_fac_Inhab_tbl b where a.panch_code=b.habitation_code and dcode='"+dcode+"'";

if(mcode !=null && !mcode.equals(""))
{
	qry+="and mcode='"+mcode+"'";
}
qry+="order by dcode,mcode,pcode,vcode,panch_code";
   
   
   
	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
   	
		
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(1)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(4)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(5)%>/<br>&nbsp;<%=rs8.getString(6)%></br></td>

<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(7)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(8)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(9)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(10)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(11)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(12)%></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(13)!=null && rs8.getString(13).equals("NULL")?"0":rs8.getString(13) %></td>
<td  class="<%=style%> "style="text-align: right;"> <%=rs8.getString(14)!=null && rs8.getString(14).equals("NULL")?"0":rs8.getString(14) %></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(15)%></td>

   
   
        
 
   	</tr>
   	
   	
<%
}
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>