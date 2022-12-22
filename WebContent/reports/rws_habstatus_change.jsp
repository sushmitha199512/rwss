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
	<td><a href="./rws_bls_water_facility_excel.jsp" target=_new>Excel</a></td>
	    
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > Base Line Survey - Water Facility In Habitation</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
<tr>
<td>1</td>


</tr>
	
       
<%
try
{
	


   //main qry
   Statement stmt8=null,stmt9=null;
   ResultSet rs8=null,rs9=null;
   int sno=1;
   stmt8=conn.createStatement();
   stmt9=conn.createStatement();
   
qry="select TOTAL_WATER_SUPPLY,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,FLOAT_POP,MINORITY_POP_COVERED,hab_code from rws_habitation_directory_tbl where COVERAGE_STATUS<>'UI' and COVERAGE_STATUS<>'null' ";
   
   
   
	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
	   sno++;
		double water=rs8.getInt(1);
		double plain=rs8.getInt(2);
		double sc=rs8.getInt(3);
		double st=rs8.getInt(4);
		double floa=rs8.getInt(5);
		double minority=rs8.getInt(6);
  	 String hab=rs8.getString(7);
		double totnetpopu=plain+sc+st+floa+minority;
  	 String calCoverageStatus="";
  	 System.out.println("water"+water);
  	 System.out.println("plain"+plain);
  	 System.out.println("sc"+sc);
  	 System.out.println("st"+st);
  	 System.out.println("floa"+floa);
  	 
  	 
  	double totwaterlevel=water/(totnetpopu*Math.pow(1.01,4));
  	if(totwaterlevel>0)
	{	
		if(totwaterlevel>0 && totwaterlevel<13.25)
		{
				calCoverageStatus = "PC1";
		}
		else if(totwaterlevel>=13.25 && totwaterlevel<27.50)
		{
				calCoverageStatus = "PC2";
		}
		else if(totwaterlevel>=27.50 && totwaterlevel<41.25)
		{
				calCoverageStatus = "PC3";
		}
		else if(totwaterlevel>=41.25 && totwaterlevel<55)
		{
				calCoverageStatus = "PC4";
		}
		else if(totwaterlevel>=55)
		{
				calCoverageStatus = "FC";
		}
		
		
		
		qry="update rws_habitation_directory_tbl set EXIST_WATER_LEVEL=? ,COVERAGE_STATUS=? where hab_code=? ";
		
		System.out.println("qry"+qry);
	    PreparedStatement ps1=conn.prepareStatement(qry);
        ps1.setDouble(1,totwaterlevel);
        ps1.setString(2,calCoverageStatus);
        ps1.setString(3,hab);
		int count=ps1.executeUpdate();
		
		System.out.println("count"+count);
		
		
	}
  		
  		
  		
  		
  	 
  	
  	 
  	 
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	<td><%=sno%></td>
	
	<tr>
	
   	
   	
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
</p>l>