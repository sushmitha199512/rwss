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
 
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
DecimalFormat ndf = new DecimalFormat("####.##");


String dcode=request.getParameter("dcode");
//System.out.println("dcode"+dcode);
String dname=request.getParameter("dname");
//System.out.println("dname"+dname);
String mcode=request.getParameter("mcode");
System.out.println("mcode"+mcode);
String mname=request.getParameter("mname");
System.out.println("mname"+mname);

    String qry="";
    int styleCount=0;
    String style="";

    
    
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
	<tr align="right">
	<td class="btext">
District:</td><td class="rptvalue"><%=dname%></td>
	<td class="btext">
Mandal:</td><td class="rptvalue"><%=mname%></td>
</tr>			
	
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >O & M(MVS) Mandal Wise Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
    <tr>
	
	<td class=gridhdbg >Sl.No</td>
    <td class=gridhdbg >panchayat</td>
    <td class=gridhdbg >No.of MVS</td>
    <td class=gridhdbg >Habs Covered(No.of Habs)</td>
    <td class=gridhdbg >Rate of Supply(LPD)</td>
	<td class=gridhdbg >Status(Working/Not Working)</td>
	
       </tr>
	
	
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totmvs=0,habscoveredmvs=0,totstatus=0,totrateofsupply=0;
   Double toiletcost=0.0;
   

		
		
	qry="select distinct count(b.Hab_code),substr(a.hab_code,13,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where a.type_of_asset_code='03' and  substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' and a.asset_code=b.asset_code group by substr(a.hab_code,13,2)";
	Statement	stmt81=conn.createStatement();
	//System.out.println("qry mvs1:"+qry);
	ResultSet rs81=stmt81.executeQuery(qry);
	Hashtable habscovered=new Hashtable();
		while(rs81.next())
	{
			habscovered.put(rs81.getString(2),rs81.getString(1));
			
	}
		
		qry="select count(SAFE_LPCD),substr(a.hab_code,13,2) from rws_habitation_directory_tbl a,rws_asset_mast_tbl b where substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' and b.hab_code=a.hab_code group by substr(a.hab_code,13,2) order by  substr(a.hab_code,13,2)";
		
		Statement	stmt82=conn.createStatement();
		//System.out.println("qry mvs2:"+qry);
		ResultSet rs82=stmt81.executeQuery(qry);
		Hashtable safelpd=new Hashtable();
			while(rs82.next())
		{
				safelpd.put(rs82.getString(2),rs82.getString(1));
				
		}	
		
			
 qry="select  sum(case when asset_status='01' or asset_status='2' then 1 else 0 end),substr(hab_code,13,2) from rws_asset_mast_tbl  where type_of_asset_code='03' and  substr(asset_code,5,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'  group by substr(hab_code,13,2) order by substr(hab_code,13,2)";

Statement	stmt83=conn.createStatement();
//System.out.println("qry mvs3:"+qry);
ResultSet rs83=stmt83.executeQuery(qry);
Hashtable status=new Hashtable();
	while(rs83.next())
{
		status.put(rs83.getString(2),rs83.getString(1));
		
}	
  
 qry="select pcode,pname,count(*) from rws_asset_mast_tbl a,rws_panchayat_tbl b  where type_of_asset_code='03' and  substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"' and b.dcode=substr(a.hab_code,1,2) and b.mcode=substr(a.hab_code,6,2) and b.pcode=substr(a.hab_code,13,2) group by pname,substr(hab_code,13,2),pcode order by pcode";
	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
	   String ss2=(String)safelpd.get(rs8.getString(1));
	   //System.out.println("ss0"+ss0);
	   if(ss2 !=null && !ss2.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss2="0";
	   }
	   int s2=Integer.parseInt(ss2);
	   
	   
	   
	  
	   
	   String ss1=(String)habscovered.get(rs8.getString(1));
	  
	   if(ss1 !=null && !ss1.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss1="0";
	   }
	   int s1=Integer.parseInt(ss1);
	   
	
	  // System.out.println("ss2"+ss2);
	   
	 float rateoflpd=0;
	   
	   float s12=Float.parseFloat(ss2);
	   float s11=Float.parseFloat(ss1);
	   

	    
	   
	   if(ss1.equals("0"))
	   {
		
		   rateoflpd='0';
		  
	   }
	   
	   else
	   {
		  
		   rateoflpd = ((float) s12)/((float) s1);
		 
		   
		  
	   }
	   
	   if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;

	 
%>
 <tr>
	<td class="<%=style%> "style="text-align: middle;"><%=sno++%></td>
      <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_OandM__mvs_habitation_drill.jsp?dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=mcode%>&mname=<%=mname%>&pcode=<%=rs8.getString(1)%>&pname=<%=rs8.getString(2)%>')"><%=rs8.getString(2)%></a></td>
      <td class="<%=style%> "style="text-align: right;"><%=rs8.getInt(3)%></td>
      <td class="<%=style%> "style="text-align: right;"><%=s1%></td>
      <td class="<%=style%> "style="text-align: right;"><%=ndf.format(rateoflpd)%></td>
      <td class="<%=style%> "style="text-align: right;"><%=rs8.getInt(3)%></td>
    
    
    
      	</tr>
	
   	
   	
<%
totmvs+=rs8.getInt(3);
habscoveredmvs+=s1;
totstatus+=rs8.getInt(3);
/* totrateofsupply+=rateoflpd; */

}
   %>
  <tr>
	
      <td class=gridhdbg colspan="2" style="text-align: center;"> Total</td>
   <td  class=gridhdbg style="text-align: right;"><%=totmvs%></td>
    <td  class=gridhdbg style="text-align: right;"><%=habscoveredmvs%></td>
      <td  class=gridhdbg style="text-align: right;"><%-- <%=totrateofsupply%> --%></td>
      <td  class=gridhdbg style="text-align: right;"><%=totstatus%></td>
     
      
   
      	</tr>
   	
   
   <%
   
   if(rs8!=null){
		rs8.close();
	}
	if(stmt8!=null){
		stmt8.close();
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