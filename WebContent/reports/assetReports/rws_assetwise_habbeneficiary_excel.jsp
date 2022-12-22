
<%@ page import="java.text.DecimalFormat.*" %>
<%@ page contentType="application/vnd.ms-excel" %>
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
String dcode =(String)session.getAttribute("dcode");

String dname=(String)session.getAttribute("dname");

String scheme=(String)session.getAttribute("scheme");
String sname=(String)session.getAttribute("sname");


//System.out.println("dist code:"+dcode);
///System.out.println("dname name:"+dname);
//System.out.println("scheme:"+scheme);

//System.out.println("typeOfAssetName:"+sname);

  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    String assetcode="",assetcodenew="";
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "center">	
	<tr>
	</tr>		
	 
	<tr align="left">
	<td class="btext">District:</td><td class="rptvalue"><%=dname%></td>
	<td class="btext">Asset Type:</td><td class="rptvalue"><%=sname%></td>
	</tr>
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >Asset wise Habs Benefited Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	<td class=gridhdbg rowspan=2>Mandal/</br>Panchayat/</br>Village</td>
    <td class=gridhdbg rowspan=2>Hab Code/</br>Hab Name</td>
    <td class=gridhdbg rowspan=2>Asset Code/</br>Asset Name</td>

    <td class=gridhdbg rowspan=2>Asset Location</td>  
       <td class=gridhdbg rowspan=2>Asset Status</td> 
    <td class=gridhdbg rowspan=2>Asset Cost</td> 
     <td class=gridhdbg rowspan=2>Date of Creation</td> 
    <td class=gridhdbg rowspan=2>Benefited Hab</td> 
    <td class=gridhdbg rowspan=2>Benefited HabName</td> 
    <td class=gridhdbg rowspan=2>Population Benefited</td> 
	
	</tr>
	<tr>
       </tr>
       

       
<%
try
{
	


   //main qry
   Statement stmt8=null,stmt7=null;
   ResultSet rs8=null,rs7=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   
   String assetqry = "select a.asset_name,h.mname,h.pname,h.vname,h.panch_name,h.panch_code,a.asset_code,nvl(a.location,'-')as location ,decode(a.asset_status, 1,'WORKING',2,'NOT WORKING',3,'DRIED',4,'SEASONAL',5,'CONDEMED','','-')as asset_status,a.asset_cost,to_char(a.date_creation,'dd/mm/yyyy')as DATE_CREATION  "
		+ " from rws_asset_mast_tbl a,"
        + " rws_complete_hab_view h where a.hab_code=h.panch_code and h.dcode='"+dcode+"' and a.type_of_asset_code='"+scheme+"' ";

   
   //Debug.println("asset qry:"+assetqry); 



	 
   rs8=stmt8.executeQuery(assetqry);
   while(rs8.next())
   {
	   assetcode=rs8.getString(7);
		

	   stmt7=conn.createStatement();
	   String qry3 = "select h.hab_code,Sum(d.census_plain_popu + d.census_st_popu + d.census_st_popu +d.FLOAT_POP)as nhb,panch_name from rws_asset_mast_tbl a, rws_asset_hab_tbl h, rws_habitation_directory_tbl d,rws_complete_hab_view e where d.hab_code=h.hab_code and h.asset_code= a.asset_code and e.panch_code=d.hab_code and h.hab_code=e.panch_code and a.asset_code='"+rs8.getString(7)+"' group by h.hab_code,panch_name";
	   
	   rs7=stmt7.executeQuery(qry3);
	   //Debug.println("asset qry3:"+qry3); 
	   
	   
	   while(rs7.next())
	   {  	
		   
		   
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
<%if(assetcode.equals(assetcodenew)) {%>	
<td class="<%=style%> "style="text-align: right;"></td>
<td class="<%=style%> "style="text-align: left;">--</td>

<td class="<%=style%> "style="text-align: left;">--</td>

<td class="<%=style%> "style="text-align: left;">--</td>
 
 <td class="<%=style%> "style="text-align: left;">--</td>   
 <td class="<%=style%> "style="text-align: right;">--</td>         
 <td class="<%=style%> "style="text-align: right;">--</td>
  <td class="<%=style%> "style="text-align: right;">--</td>
<%} else
{%>
<td class="<%=style%> "style="text-align: right;"><%=sno++%></td>
<td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%>/</br><%=rs8.getString(3)%>/</br><%=rs8.getString(4)%></td>

<td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(6)%>/<br> <%=rs8.getString(5)%></td>

<td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(7)%>/<br><%=rs8.getString(1)%></td>
 
 <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(8)%></td>   
 <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(9)%></td>         
 <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(10)%></td>
  <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(11)%></td>
<%} %>

  <td class="<%=style%> "style="text-align: right;"> <%=rs7.getString(1)%></td>  
     <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(3)%></td>    
    <td class="<%=style%> "style="text-align: right;"> <%=rs7.getInt(2)%></td> 
  
   	</tr>
   	
   	
<%
assetcodenew=rs8.getString(7);
}
	   rs7.close();
	   stmt7.close();
	  
   }
   rs8.close();
   
   stmt8.close();
  
	}

catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>