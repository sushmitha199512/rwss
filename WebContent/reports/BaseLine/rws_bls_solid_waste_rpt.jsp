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
	   <td><a href="./rws_bls_solid_waste_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > Base Line Survey Solid Waste - Report</td>
	</tr>
    
	</table>
   
   <table width="60%"  style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2 align=right>Sl.No</td>
    <td class=gridhdbg rowspan=2 align=left>District</td>
    <td class=gridhdbg rowspan=2 align=left>Mandal</td>
    <td class=gridhdbg rowspan=2 align=left>Panchayat</td> 
	<td class=gridhdbg rowspan=2 align=left>Village</td>
    <td class=gridhdbg rowspan=2 align=right>Habitation Name /<Br>Habitation Code </td>
    <td class=gridhdbg rowspan=2 align=right>Total_DustBins </td>
    <td class=gridhdbg rowspan=2 align=right>Total_SoakPits </td>
    <td class=gridhdbg rowspan=2 align=right>Total_CompostPits </td>
    <td class=gridhdbg rowspan=2 align=right>Total_Tricycles </td>
    <td class=gridhdbg rowspan=2 align=left>Extra_Facilities	/<br>(Yes/No) </td>
    <td class=gridhdbg rowspan=2 align=right>Other_In_No. </td>
    <td class=gridhdbg rowspan=2 align=right>Drainage_Exist </td>
    <td class=gridhdbg rowspan=2 align=right>Survey Date </td>
	</tr>
	
	<tr></tr>
       

       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
 qry="select dname,mname,pname,vname,panch_name,panch_code,TOTAL_DUSTBINS,TOTAL_SOAKPITS,TOTAL_COMPOSTPITS,TOTAL_TRICYCLES,nvl(EXTRA_FACILITIES,''),OTHER_IN_NO,DRAINAGE_EXIST,to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_complete_hab_view a,rws_bls_solid_waste_survey_tbl  b where a.panch_code=b.habitation_code and dcode='"+dcode+"'";
  

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
	
    <td class="<%=style%>" style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(1)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(2)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(3)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(4)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(5)%>/<br>&nbsp;<%=rs8.getString(6)%></br></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(7)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(8)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(9)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(10)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(11)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(12)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(13)%></td>
<td  class="<%=style%>" style="text-align: left;"> <%=rs8.getString(14)%></td>

   
   
        
 
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