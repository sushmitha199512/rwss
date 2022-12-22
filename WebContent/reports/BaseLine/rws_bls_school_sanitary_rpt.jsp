<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

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
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
System.out.println("dcode**********" +dcode);
String mcode=request.getParameter("mandal");
session.setAttribute("mcode",mcode);
  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	   <td><a href="./rws_bls_school_sanitary_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > Base Line Survey School Sanitation Survey - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation Name /<Br>Habitation Code </td>
    
    
    
    <td class=gridhdbg rowspan=2>SchoolName	</td>
    <td class=gridhdbg rowspan=2>DiseCode	</td>
    <td class=gridhdbg rowspan=2>Locality	</td>
    <td class=gridhdbg rowspan=2>SchoolType	</td>
    <td class=gridhdbg rowspan=2>SchoolCategory	</td>
    <td class=gridhdbg rowspan=2>SchoolEstabilishedBefore2007	</td>
    <td class=gridhdbg rowspan=2>BoysCount	</td>
    <td class=gridhdbg rowspan=2>GirlsCount	</td>
    <td class=gridhdbg rowspan=2>SanitaryExist	</td>
    <td class=gridhdbg rowspan=2>SanitaryBuildingDept	</td>
    <td class=gridhdbg rowspan=2>YearOfBulit	</td>
    <td class=gridhdbg rowspan=2>BoysToiletsCount	</td>
    <td class=gridhdbg rowspan=2>GirlsToiletsCount	</td>
    <td class=gridhdbg rowspan=2>IsWaterExist	</td>
    <td class=gridhdbg rowspan=2>SanitaryUse	</td>
    <td class=gridhdbg rowspan=2>DrinkingWaterFacilityAvailable	</td>
    <td class=gridhdbg rowspan=2>BinExist	</td>
    <td class=gridhdbg rowspan=2>PitExist	</td>
  
      
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
   
   
qry="select dname,mname,pname,vname,panch_name,panch_code,HABITATION_CODE,SCHOOLNAME,DISECODE,LOCALITY,SCHOOLTYPE,SCHOOLCATEGORY,SCHOOLESTABILISHEDBEFORE2007,BOYSCOUNT,GIRLSCOUNT,SANITARYEXIST,nvl(SANITARYBUILDINGDEPT,'-'),YEAROFBULIT,BOYSTOILETSCOUNT,GIRLSTOILETSCOUNT,nvl(ISWATEREXIST,'-'),nvl(SANITARYUSE,'-'),nvl(DRINKINGWATERFACILITYAVAILABLE,'-'),BINEXIST,PITEXIST,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_school_sani_survey_tbl  b where a.panch_code=b.habitation_code and dcode='"+dcode+"'";



if(mcode !=null && !mcode.equals(""))
{
	qry+="and mcode='"+mcode+"'";
}
qry+="order by dcode,mcode,pcode,vcode,panch_code";
   
   //System.out.println("qqqqqqqqqq"+qry);
   
	 
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



<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(8)!=null && rs8.getString(8).equals("NULL")?"0":rs8.getString(8)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(9)!=null && rs8.getString(9).equals("NULL")?"0":rs8.getString(9)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(10)!=null && rs8.getString(10).equals("NULL")?"0":rs8.getString(10)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(11)!=null && rs8.getString(11).equals("NULL")?"0":rs8.getString(11)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(12)!=null && rs8.getString(12).equals("NULL")?"0":rs8.getString(12)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(13)!=null && rs8.getString(13).equals("NULL")?"0":rs8.getString(13)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(14)!=null && rs8.getString(14).equals("NULL")?"0":rs8.getString(14)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(15)!=null && rs8.getString(15).equals("NULL")?"0":rs8.getString(15)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(16)!=null && rs8.getString(16).equals("NULL")?"0":rs8.getString(16)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(17)!=null && rs8.getString(17).equals("NULL")?"0":rs8.getString(17)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(18)!=null && rs8.getString(18).equals("NULL")?"0":rs8.getString(18)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(19)!=null && rs8.getString(19).equals("NULL")?"0":rs8.getString(19)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(20)!=null && rs8.getString(20).equals("NULL")?"0":rs8.getString(20)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(21)!=null && rs8.getString(21).equals("NULL")?"0":rs8.getString(21)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(22)!=null && rs8.getString(22).equals("NULL")?"0":rs8.getString(22)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(23)!=null && rs8.getString(23).equals("NULL")?"0":rs8.getString(23)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(24)!=null && rs8.getString(24).equals("NULL")?"0":rs8.getString(24)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(25)!=null && rs8.getString(25).equals("NULL")?"0":rs8.getString(25)%></td>
<td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(26)!=null && rs8.getString(26).equals("NULL")?"0":rs8.getString(26)%></td>



   
   
        
 
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