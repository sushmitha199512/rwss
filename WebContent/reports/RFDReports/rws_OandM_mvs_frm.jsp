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


    String qry="";
    int styleCount=0;
    String style="";

    
    
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  &nbsp; </td>
	 
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >O & M(MVS)</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
    <tr>
	
	<td class=gridhdbg >Sl.No</td>
    <td class=gridhdbg >District</td>
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
   
   int totmvs=0,habscoveredmvs=0,totstatus=0;
   Double toiletcost=0.0;
   
   qry="select distinct count(*),substr(hab_code,1,2) from rws_asset_mast_tbl  where type_of_asset_code='03' and  substr(hab_code,1,2) in('01','02','03','04','05','06','07','08','09','10','11','12','13')  group by substr(hab_code,1,2) order by substr(hab_code,1,2)";
   Statement	stmt80=conn.createStatement();
//	System.out.println("qry mvs1:"+qry);
	ResultSet rs80=stmt80.executeQuery(qry);
	Hashtable mvs=new Hashtable();
		while(rs80.next())
	{
			mvs.put(rs80.getString(2),rs80.getString(1));
			
	}
		
		
	qry="select distinct count(b.Hab_code),substr(a.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where a.type_of_asset_code='03' and a.asset_code=b.asset_code group by substr(a.hab_code,1,2)";
	Statement	stmt81=conn.createStatement();
	//System.out.println("qry mvs2:"+qry);
	ResultSet rs81=stmt81.executeQuery(qry);
	Hashtable habscovered=new Hashtable();
		while(rs81.next())
	{
			habscovered.put(rs81.getString(2),rs81.getString(1));
			
	}
		
		qry="select distinct count(SAFE_LPCD),substr(a.hab_code,1,2) from rws_habitation_directory_tbl a,rws_asset_mast_tbl b where substr(a.hab_code,1,2) in('01','02','03','04','05','06','07','08','09','10','11','12','13') and  b.hab_code=a.hab_code group by substr(a.hab_code,1,2) order by  substr(a.hab_code,1,2)";
		
		Statement	stmt82=conn.createStatement();
		//System.out.println("qry mvs3:"+qry);
		ResultSet rs82=stmt81.executeQuery(qry);
		Hashtable safelpd=new Hashtable();
			while(rs82.next())
		{
				safelpd.put(rs82.getString(2),rs82.getString(1));
				
		}	
		
			
qry="select distinct sum(case when asset_status='01' or asset_status='2' then 1 else 0 end),substr(asset_code,5,2) from rws_asset_mast_tbl  where type_of_asset_code='03' and  substr(asset_code,5,2) in('01','02','03','04','05','06','07','08','09','10','11','12','13')  group by substr(asset_code,5,2) order by substr(asset_code,5,2)";

Statement	stmt83=conn.createStatement();
//System.out.println("qry mvs5:"+qry);
ResultSet rs83=stmt83.executeQuery(qry);
Hashtable status=new Hashtable();
	while(rs83.next())
{
		status.put(rs83.getString(2),rs83.getString(1));
		
}	
  
 qry="select dcode,dname from rws_district_tbl";
	 
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
	   double s2=Double.parseDouble(ss2);
	   
	   
	   
	   String ss0=(String)mvs.get(rs8.getString(1));
	   //System.out.println("ss0"+ss0);
	   if(ss0 !=null && !ss0.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss0="0";
	   }
	   int s0=Integer.parseInt(ss0);
	   
	   
	   String ss1=(String)habscovered.get(rs8.getString(1));
	   //System.out.println("ss0"+ss0);
	   if(ss1 !=null && !ss1.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss1="0";
	   }
	   double s1=Double.parseDouble(ss1);
	   
	   
	   String ss3=(String)status.get(rs8.getString(1));
	   //System.out.println("ss0"+ss0);
	   if(ss3 !=null && !ss3.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss3="0";
	   }
	   int s3=Integer.parseInt(ss3);
	   
	   double rateoflpd = (s2)/(s1);
	   //System.out.println("rateoflpd"+rateoflpd);
	   
	   
	   if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;

	 
%>
 <tr>
	<td class="<%=style%> "style="text-align: middle;"><%=sno++%></td>
      <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_OandM__mvs_drill.jsp?dcode=<%=rs8.getString(1)%>&dname=<%=rs8.getString(2)%>')"><%=rs8.getString(2)%></a></td>
      <td class="<%=style%> "style="text-align: right;"><%=s0%></td>
      <td class="<%=style%> "style="text-align: right;"><%=s1%></td>
      <td class="<%=style%> "style="text-align: right;"><%=ndf.format(rateoflpd)%></td>
      <td class="<%=style%> "style="text-align: right;"><%=s3%></td>
    
    
    
      	</tr>
	
   	
   	
<%
totmvs+=s0;
habscoveredmvs+=s1;
totstatus+=s3;

}
   %>
  <tr>
	
      <td class=gridhdbg colspan="2" style="text-align: center;"> Total</td>
   <td  class=gridhdbg style="text-align: right;"><%=totmvs%></td>
    <td  class=gridhdbg style="text-align: right;"><%=habscoveredmvs%></td>
      <td  class=gridhdbg style="text-align: right;"></td>
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