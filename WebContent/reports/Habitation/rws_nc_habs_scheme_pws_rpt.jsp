<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<%
String dcode=request.getParameter("district");


if(dcode==null||dcode.equals("")||dcode.length()==0){
	//System.out.println("in if statement");
	dcode=(String)session.getAttribute("dcode");
}
//System.out.println("dcode**********" +dcode);
String lpcd=request.getParameter("lpcdstatus");
if(lpcd==null){
	lpcd="All";
}
 //System.out.println("lpcd status is "+lpcd); 	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
session.setAttribute("dcode",dcode);
session.setAttribute("lpcdstatus",lpcd);

    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
<script language="JavaScript">


	function checklpcd(){
	  
		var status = '<%=lpcd%>';
		var s1=document.getElementById(status);  
		// alert("hi"+status); 	
s1.setAttribute("selected","selected");
		}

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
<body onload="checklpcd()">
<form>

	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_nc_habs_scheme_pws_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > Habitations Which are not Covered under any Scheme								
  - Report</td>
	</tr>
    <tr >
	<td align="center" class="rptHeading" >LPCD:<select name="lpcdstatus" id="lpcdstatus" onchange="this.form.submit()">
	<option value="All" id="All">ALL</option>
	<option value="Safe" id="Safe">SAFE</option>
	<option value="Unsafe" id="Unsafe">UNSAFE</option>
	</select></td>
	</tr>
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td> 
	<td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Habitation /<Br>Habitation Code </td>
    <td class=gridhdbg rowspan=2>Coverage Status</td>
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
   
   
   qry="select dname,mname,pname,vname,panch_name,panch_code,coverage_status from rws_complete_hab_view a WHERE  NOT EXISTS (SELECT hab_code FROM  RWS_HAB_SUPPLY_STATUS_TBL b WHERE  ";

   if(dcode !=null && !dcode.equals(" ")){
   	qry+=" substr(b.hab_code,1,2)='"+dcode+"' and ";	
   }
   qry+=" b.hab_code = a.panch_code and  ";
   if(lpcd.equals("All")){
   	qry+="(b.PWS_SUPPLY>0 or b.PWS_UNSAFE_SUPPLY>0 or b.MPWS_SUPPLY>0 or b.MPWS_UNSAFE_SUPPLY>0 or b.CPWS_SUPPLY>0)) ";
   	
   }
   if(lpcd.equals("Safe")){
   	qry+="(b.PWS_SUPPLY>0  or b.MPWS_SUPPLY>0  or b.CPWS_SUPPLY>0)) ";
   	
   }

   if(lpcd.equals("Unsafe")){
   	qry+="(b.PWS_UNSAFE_SUPPLY>0 or b.MPWS_UNSAFE_SUPPLY>0)) ";
   	
   }   if(dcode !=null && !dcode.equals(" ")){
   	qry+=" and dcode='"+dcode+"' ";	
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

 <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(7)%></td>
   
        
 
   	</tr>
   	
   	
<%
}
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
    
</table></form>
</body>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>