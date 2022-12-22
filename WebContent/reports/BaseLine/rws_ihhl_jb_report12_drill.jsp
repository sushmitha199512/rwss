<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{

	TINY.box.show({iframe:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script>
<form>
<%
String rDistrict=(String)session.getAttribute("rDistrict");
String mcode=request.getParameter("mcode");
String pcode=request.getParameter("pcode");
String vcode=request.getParameter("vcode");
String panchcode=request.getParameter("panchcode");
//System.out.println("panchcode"+panchcode);
//System.out.println("rDistrict"+rDistrict);

//System.out.println("pcode"+pcode);
//System.out.println("mcode"+mcode);
//System.out.println("vcode"+vcode);


  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();


String gender="";
String Toilet="";
String toiletfun="";
String toiletfunused="";
String waterfacility="";
String mobile="";

    String qry="";
    int styleCount=0;
    String style="";

     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	
		<table  border=0 rules=none style="border-collapse:collapse" align = "center">
	
	
		<table>	
			
<tr align="center">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	
	   
	</tr>  
	
		
	
	<tr >
	<td align="center" class="rptHeading" >IHHL-Detail Report</td>
	</tr>
    
	</table>

   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg >Sl.No</td>
       
     
      
     
       <td class=gridhdbg >Family Head Name</td>
       <td class=gridhdbg >Father/Husband Name</td>
       <td class=gridhdbg >Benificial Id </td>
       <td class=gridhdbg >Gender</td>
       <td class=gridhdbg >Card Type</td>
       <td class=gridhdbg >Card Number</td>
       <td class=gridhdbg >Category</td>
       <td class=gridhdbg >Sub Category</td>
       <td class=gridhdbg >Adhaar Card Number</td>
       <td class=gridhdbg >Mobile Number</td>
       <td class=gridhdbg >HAVING TOILETs</td>
       <td class=gridhdbg >IS HAVING TOILET_FUNCTIONAL</td>
       <td class=gridhdbg >IS HAVING TOILET_FUNCTIONAL_USED</td>
       <td class=gridhdbg >Water Facility Availabile</td>
       
	  

   </tr>
       
<%
try
{
	
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;
   qry="select nvl(FAMILYHEAD,'-'),nvl(FATHERHUSBANDNAME,'-'),nvl(BENFID,'0'),nvl(GENDER,'-'),nvl(CARD_NAME,'-'),nvl(CARDNUMBER,'-'),nvl(CATEGORY,'-'),nvl(SUBCATEGORY_NAME,'-'),nvl(ADHAARCARD,'-'),nvl(MOBILE,'-'),ISHAVINGTOILET,ISHAVINGTOILET_FUNCTIONAL,ISHAVINGTOILET_FUNCTIONAL_USED,ISWATERFACILITYAVAILABLE  from rws_ihhl_goi_tbl a,RWS_BPL_CATEGORY_TBL b,RWS_BPL_SUBCATEGORY_TBL c, RWS_IHHL_CARDTYPE_TBL d where hab_code_state='"+panchcode+"' AND B.CATEGORY_CODE =C.CATEGORY_CODE and c.SUBCATEGORY_CODE=a.SUBCATEGORY and d.CARD_TYPE=a.CARDTYPE  ";

 	//System.out.println("qry"+qry); 
  rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
 
  gender=rs8.getString(4);
 
	   if(gender.equals("M") )
	   {
		   
		   gender="Male";
		 
	   }
	   else
	   {
		 
		   gender="Fe Male";
	   }
	   
	Toilet=rs8.getString(11);
	  
	   if(Toilet.equals("N"))
	   {
		  
		   Toilet="No";
	   }
	   else
	   {
		   Toilet="Yes";
	   }
	   toiletfun=rs8.getString(12);
	   if(toiletfun.equals("NA"))
	   {
		   toiletfun="Not Applicable";
		   
	   }
	   else if(toiletfun.equals("N"))
	   {
		   toiletfun="No";
		  
	   }
	   else
	   {
		   toiletfun="Yes";
		  
	   }
	   
	   
	   toiletfunused=rs8.getString(13);
	   
	   if(toiletfunused.equals("NA"))
	   {
		   toiletfunused="Not Applicable";
		 
	   }
	   else if(toiletfunused.equals("N"))
	   {
		   toiletfunused="No";
		   
	   }
	   else
	   {
		   toiletfunused="Yes";
		  
	   }
	   
	   waterfacility=rs8.getString(14);	   
	   
	   if(waterfacility.equals("NA"))
	   {
		   waterfacility="Not Applicable";
		 
	   }
	   else if(waterfacility.equals("N"))
	   {
		   waterfacility="No";
		   
	   }
	   else
	   {
		   waterfacility="Yes";
		  
	   }
	   
	   
	   mobile=rs8.getString(10);
	   if(mobile.equals("NA"))
	   {
		   mobile="-";
	   }
		 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(1)%></td>
      
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
     <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td>
      
    <td class="<%=style%> "style="text-align: left;"> <%=gender%></td>
     <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(5)%></td>
      
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(6)%></td>
    
     <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(7)%></td>
      
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(8)%></td>
     <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(9)%></td>
      
    <td class="<%=style%> "style="text-align: left;"> <%=mobile%></td>
     <td class="<%=style%> "style="text-align: left;"> <%=Toilet%></td>
      
    <td class="<%=style%> "style="text-align: left;"> <%=toiletfun%></td>
         <td class="<%=style%> "style="text-align: left;"> <%=toiletfunused%></td>
      
    <td class="<%=style%> "style="text-align: left;"> <%=waterfacility%></td>
    
  
    
    
  	</tr>
  	
<%


}%>


<%
if(stmt8!=null){
	stmt8.close();
}
if(rs8!=null){
	rs8.close();
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