<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
	//TINY.box.show({iframe:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script>

<form>
<%
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
//System.out.println("dcode**********" +dcode);

  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();


    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	<td><a href="./rws_bls_sa_abstract_rpt_excel.jsp" target=_new>Excel</a></td>
	    
	</tr>  
	</table>
	</caption>
	
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr >
	<td align="center" class=gridhdbg colspan=28> Base Line Survey  School & Anganwadi - Abstract Report</td>
	</tr>
	
	<tr>
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=1 colspan="3">SCHOOLS Details</td>
    <td class=gridhdbg rowspan=1 colspan="3">ANGANWADI Details</td>
    </tr>
    
    <tr>
    <td class=gridhdbg >No. of Schools</td>
    <td class=gridhdbg >Drinking Water Facility Available</td>
    <td class=gridhdbg> Toilets Available</td>
   
    <td class=gridhdbg >No. of Anganwadi's</td>
    <td class=gridhdbg >Drinking Water Facility Available</td>
    <td class=gridhdbg> Toilets Available</td>
     </tr>
    
    <tr>
	<%for(int i=1;i<9;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>
       
<%
try
{
	

///////////////// no.of Schools count

String schoolcount0="select count(*),substr(HABITATION_CODE,1,2) from rws_bls_school_sani_survey_tbl  group by substr(HABITATION_CODE,1,2)"; 
	Statement	stmt80=conn.createStatement();
	//System.out.println("schoolcount0:"+schoolcount0);
	ResultSet rs80=stmt80.executeQuery(schoolcount0);
	Hashtable schoolcount0_hash=new Hashtable();
		while(rs80.next())
	{
			schoolcount0_hash.put(rs80.getString(2),rs80.getString(1));
	}
		
		if(stmt80!=null){
			stmt80.close();
		}
		if(rs80!=null){
			rs80.close();
		}
///////////////////////////	school Drinking water available	count
		
				
String schoolcount1="select count(*),substr(HABITATION_CODE,1,2)  from rws_bls_school_sani_survey_tbl where DRINKINGWATERFACILITYAVAILABLE ='Yes'  group by substr(HABITATION_CODE,1,2)";  
	Statement	stmt81=conn.createStatement();
	//System.out.println("schoolcount1:"+schoolcount1);
	ResultSet rs81=stmt81.executeQuery(schoolcount1);
	Hashtable schoolcount1_hash=new Hashtable();
		while(rs81.next())
	{
			schoolcount1_hash.put(rs81.getString(2),rs81.getString(1));
	}
		if(stmt81!=null){
			stmt81.close();
		}
		if(rs81!=null){
			rs81.close();
		}
		
		
		
		
/////////////////////////// school toilets count 	
		
String schoolcount2="select count(*),substr(HABITATION_CODE,1,2) from rws_bls_school_sani_survey_tbl where  (BOYSTOILETSCOUNT>0 or GIRLSTOILETSCOUNT>0) and DRINKINGWATERFACILITYAVAILABLE ='Yes'  group by substr(HABITATION_CODE,1,2)";  
		Statement	stmt82=conn.createStatement();
	//	System.out.println("schoolcount2:"+schoolcount2);
		ResultSet rs82=stmt82.executeQuery(schoolcount2);
		Hashtable schoolcount2_hash=new Hashtable();
			while(rs82.next())
		{
				schoolcount2_hash.put(rs82.getString(2),rs82.getString(1));
		}
			if(stmt82!=null){
				stmt82.close();
			}
			if(rs82!=null){
				rs82.close();
			}
			
//////////////////////////////////////// Anganwadi count
       
String angancount3="select count(*),substr(HABITATION_CODE,1,2) from rws_bls_angan_sani_survey_tbl   group by substr(HABITATION_CODE,1,2)"; 
			Statement	stmt83=conn.createStatement();
	//		System.out.println("angancount3:"+angancount3);
			ResultSet rs83=stmt83.executeQuery(angancount3);
			Hashtable angancount3_hash=new Hashtable();
				while(rs83.next())
			{
					angancount3_hash.put(rs83.getString(2),rs83.getString(1));
			}

				if(stmt83!=null){
					stmt83.close();
				}
				if(rs83!=null){
					rs83.close();
				}
				
//////////////////////////////////////// Anganwadi drinking water available				
				
String angancount4="select count(*),substr(HABITATION_CODE,1,2)  from rws_bls_angan_sani_survey_tbl where DRINKINGWATEREXIST  ='Yes' group by substr(HABITATION_CODE,1,2) "; 
				Statement	stmt84=conn.createStatement();
	//			System.out.println("angancount4:"+angancount4);
				ResultSet rs84=stmt84.executeQuery(angancount4);
				Hashtable angancount4_hash=new Hashtable();
					while(rs84.next())
				{
						angancount4_hash.put(rs84.getString(2),rs84.getString(1));
				}
					
					if(stmt84!=null){
						stmt84.close();
					}
					if(rs84!=null){
						rs84.close();
					}
					
////////////////////////////////////////Anganwadi drinking water available				
					
String angancount5="select count(*),substr(HABITATION_CODE,1,2) from rws_bls_angan_sani_survey_tbl where AVAILOFTOILETFACILITY  ='Yes'  and DRINKINGWATEREXIST  ='Yes'  group by substr(HABITATION_CODE,1,2) "; 
					Statement	stmt85=conn.createStatement();
	//				System.out.println("angancount5:"+angancount5);
					ResultSet rs85=stmt85.executeQuery(angancount5);
					Hashtable angancount5_hash=new Hashtable();
						while(rs85.next())
					{
							angancount5_hash.put(rs85.getString(2),rs85.getString(1));
					}
						
						if(stmt85!=null){
							stmt85.close();
						}
						if(rs85!=null){
							rs85.close();
						}
						
			session.setAttribute("schoolcount0_hash",schoolcount0_hash);
			session.setAttribute("schoolcount1_hash",schoolcount1_hash);
			session.setAttribute("schoolcount2_hash",schoolcount2_hash);
			
			session.setAttribute("angancount3_hash",angancount3_hash);
			session.setAttribute("angancount4_hash",angancount4_hash);
			session.setAttribute("angancount5_hash",angancount5_hash);
			
						
  //main qry starts here ... the district name is displaed from here
  
   Statement stmt3=null,stmt4=null;
   ResultSet rs3=null,rs4=null;
   
   int sno=1;
     %>
   
    <%
    // variables for grand totals
    int g1=0,g2=0,g3=0,g4=0,g5=0,g6=0; 
    
     String mainqry="select dcode,dname from rws_district_tbl where dcode<>'16' ";
     
if(dcode!=null && !dcode.equals("00")){
	mainqry+=" and dcode='"+dcode+"'";
		}
mainqry+="  order by dcode";

   stmt4=conn.createStatement();
   rs4=stmt4.executeQuery(mainqry);
   
   while(rs4.next())
   {
	  //////////// /// count of no. of schools
	     
	   String ss0=(String)schoolcount0_hash.get(rs4.getString(1));
	   if(ss0 !=null && !ss0.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss0="0";
	   }
	   int s0=Integer.parseInt(ss0);
//	   System.out.println("cpount***********"+ss0);
//	   System.out.println("cpount***********"+s0+" "+rs4.getString(1));
	   
	   //count drinking water facility='Y'
	   
	   String ss1=(String)schoolcount1_hash.get(rs4.getString(1));
	   if(ss1 !=null && !ss1.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss1="0";
	   }
	   int s1=Integer.parseInt(ss1);
//	   System.out.println("cpount***********"+ss1);
//	   System.out.println("cpount***********"+s1+" "+rs4.getString(1));
	   
	   //////////////////////////////////////////////////////////////////////
	   //count toilets available
	   	   
	   String ss2=(String)schoolcount2_hash.get(rs4.getString(1));
	   if(ss2 !=null && !ss1.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss2="0";
	   }
	   int s2=Integer.parseInt(ss2);
//	   System.out.println("cpount***********"+ss2);
	//   System.out.println("cpount***********"+s2+" "+rs4.getString(1));
	   
	   
	   
	   //////////////////////////////////////////////////////////////////////
	   //count anaganwadi schools
	   
	   String ss3=(String)angancount3_hash.get(rs4.getString(1));
	   if(ss3 !=null && !ss3.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss3="0";
	   }
	   int s3=Integer.parseInt(ss3);
//	   System.out.println("cpount***********"+ss3);
//	   System.out.println("cpount***********"+s3+" "+rs4.getString(1));
	   
	   
//////////////////////////////////////////////////////////////////////
	   //count anaganwadi  drinking water
	   
	   String ss4=(String)angancount4_hash.get(rs4.getString(1));
	   if(ss4 !=null && !ss4.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss4="0";
	   }
	   int s4=Integer.parseInt(ss4);
//	   System.out.println("cpount***********"+ss4);
//	   System.out.println("cpount***********"+s4+" "+rs4.getString(1));
	   
	   
//////////////////////////////////////////////////////////////////////
	   //count anaganwadi Toilets
	   
	   String ss5=(String)angancount5_hash.get(rs4.getString(1));
	   if(ss5 !=null && !ss5.equals(""))
	   {
		   
	   }
	   else
	   {
		   ss5="0";
	   }
	   int s5=Integer.parseInt(ss5);
//	   System.out.println("cpount***********"+ss5);
//	   System.out.println("cpount***********"+s4+" "+rs4.getString(1));

	   

       
      

	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;   
    
        
	 
	 %>
	 
	 <!-- printing values starts here -->
	 
	   	<tr>
		
	      <td  class="<%=style%>" style="text-align:  left;"> <%=sno++%></td>
	      <td  class="<%=style%>" style="text-align: left;"> <%=rs4.getString(2)%></td>
	      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_sa_abstract_drill_rpt.jsp?drill=yes&type=1&dcode=<%=rs4.getString(1) %>')"> <%=ss0%></td>
	      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_sa_abstract_drill_rpt.jsp?drill=yes&type=2&dcode=<%=rs4.getString(1) %>')"> <%=ss1%></td>
	      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_sa_abstract_drill_rpt.jsp?drill=yes&type=3&dcode=<%=rs4.getString(1) %>')"> <%=ss2%></td>
	      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_sa_abstract_drill_rpt.jsp?drill=yes&type=4&dcode=<%=rs4.getString(1) %>')"> <%=ss3%></td>
	      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_sa_abstract_drill_rpt.jsp?drill=yes&type=5&dcode=<%=rs4.getString(1) %>')"> <%=ss4%></td>
	      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_sa_abstract_drill_rpt.jsp?drill=yes&type=6&dcode=<%=rs4.getString(1) %>')"> <%=ss5%></td>
	      
	 </tr>
   	
<%
   g1+=s0;
   g2+=s1;
   g3+=s2;
   g4+=s3;
   g5+=s4;
   g6+=s5;
   }
   %>
   <tr>
   	<td align="center" class="gridhdbg" colspan="2">Grand Total</td>
   	<td style="text-align: right;" class="gridhdbg" ><%=g1 %></td>
   	<td style="text-align: right;" class="gridhdbg" ><%=g2 %></td>
   	<td style="text-align: right;" class="gridhdbg" ><%=g3 %></td>
   	<td style="text-align: right;" class="gridhdbg" ><%=g4 %></td>
   	<td style="text-align: right;" class="gridhdbg" ><%=g5 %></td>
   	<td style="text-align: right;" class="gridhdbg" ><%=g6 %></td>
   	
</tr>
<% 

	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>



    