<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%@ include file = "/reports/conn.jsp" %>
<%	
	Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null;
	Statement ste1 = null,ste2=null,stmte=null,sse1=null;
	Statement st2 = null,st22=null,ss1=null,swc=null,pns=null;
	ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null,wcrs=null,pnrs;
	Statement stmt1 = null;
	ResultSet rs1 = null,rse=null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null,querywc=null,querypn=null;
	//String[] record = null;
	int Count=0,Cnt=0,slno=0,sl=0,Counts=0,ano=0;
	//int start,end,limit = 3;
	//String assetType = request.getParameter("aType");
	
	//String dCode = request.getParameter("dcode");
	//String schCode = request.getParameter("scheme");
	String wCode = request.getParameter("workId");
	
	//// ////System.out...println("programme Name "+pName);
	 
	 
try
{
%>	

<html>
<head>
 <script>
   // window.history.forward(1);
 </script>
<style>
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt
}

.btext1 {
	text-transform: uppercase;
	color: green;
}

.btext3 {
	color: red;
	font-weight: bold;
}
</style>

<style type="text/css">
/* --------
  The CSS rules offered here are just an example, you may use them as a base. 
  Shape your 'expand/collapse' content so that it meets the style of your site. 
 --------- */
* {margin:0; padding:0}
/* --- Page Structure  --- */
html {height:100%}
body {
  min-width:400px;
  width:100%;
  height:50%;
  background:#fff;
  color:#333;
  font:76%/1.6 verdana,geneva,lucida,'lucida grande',arial,helvetica,sans-serif;
  text-align:center
}
#wrapper{
  margin:0 auto;
  padding:15px 15%;
  text-align:left
}
#content {
  max-width:70em;
  width:100%;
  margin:0 auto;
  padding-bottom:10px;
  overflow:hidden
}
.demo {
  margin:0;
  padding:1.5em 1.5em 0.75em;
  border:1px solid #ccc;
  position:relative;
  overflow:hidden
}
.collapse p {padding:0 10px 1em}
.top{font-size:.9em; text-align:right}
#switch, .switch {margin-bottom:5px; text-align:right}

/* --- Headings  --- */
h1 {
  margin-bottom:.75em; 
  font-family:georgia,'times new roman',times,serif; 
  font-size:2.5em; 
  font-weight:normal; 
  color:#c30
}
h2{font-size:1em}

.expand{padding-bottom:.75em}

/* --- Links  --- */
a:link, a:visited {
  border:1px dotted #ccc;
  border-width:0 0 1px;
  text-decoration:none;
  color:green
}
a:hover, a:active, a:focus {
  border-style:solid;
  background-color:#F5FFFA;
  outline:0 none
}
a:active, a:focus {
  color:red;
}
.expand a {
  display:block;
  padding:3px 10px
}
.expand a:link, .expand a:visited {
  border-width:1px;
  background-image:url(/pred/images/arrow-down.gif);
  background-repeat:no-repeat;
  background-position:98% 50%;
}
.expand a:hover, .expand a:active, .expand a:focus {
  text-decoration:underline
}
.expand a.open:link, .expand a.open:visited {
  border-style:solid;
  background:#4A708B url(/pred/images/arrow-up.gif) no-repeat 98% 50%;
  color:white;
}
</style>
<!--[if lte IE 7]>
<style type="text/css">
h2 a, .demo {position:relative; height:1%}
</style>
<![endif]-->

<!--[if lte IE 6]>
<script type="text/javascript">
   try { document.execCommand( "BackgroundImageCache", false, true); } catch(e) {};
</script>
<![endif]-->
<!--[if !lt IE 6]><!-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="/pred/resources/javascript/expand.js"></script>
<script type="text/javascript">
<!--//--><![CDATA[//><!--
$(function() {
    // --- Using the default options:
    $("h2.expand").toggler({initShow: "div.collapse:first"});
    
    
    //$("h2.expand").toggler();
    // --- Other options:
    //$("h2.expand").toggler({method: "toggle", speed: 0});
    //$("h2.expand").toggler({method: "toggle"});
    //$("h2.expand").toggler({speed: "fast"});
   // $("h2.expand").toggler({method: "fadeToggle"});
    //$("h2.expand").toggler({method: "slideFadeToggle"});    
    $("#content").expandAll({trigger: "h2.expand", ref: "div.demo",  speed: 300, oneSwitch: false});
});
//--><!]]>
</script>
<!--<![endif]-->
</head>

<body >




        <table>
        <caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td align="right"><a href="javascript:history.back(-1)">Back&nbsp;</a>
				<td align="right"><a href="/pred/home.jsp">Home</a></td>
				
			</tr>
		</table>
	</caption>
		 <%String wid=request.getParameter("workId");
		 
		 
		 String  status="-";
        // //System.out..println("wid:"+wid);
		 String qry="select distinct work_name,programme_name,subprogramme_name,decode(aug_new_code,'1','MAINSCHEME','2','AUGUMENTATION','3','MAINTANANCE','-') ,decode(plan_code,'1','PLAN','2','NON-PLAN','-'),decode(w.category_code,'1','PROJECTS','2','NORMAL','3','DISTRICT-LEVEL','-'),type_of_asset_name,WORK_CANCEL_DT ,ds.dname from rws_work_admn_tbl w,rws_programme_tbl p,rws_subprogramme_tbl s,rws_asset_type_tbl at ,rws_district_tbl ds where substr(w.work_id,5,2)=ds.dcode and w.programme_code=p.programme_code and s.programme_code=p.programme_code and  w.programme_code=s.programme_code  and w.subprogramme_code=s.subprogramme_code and work_id='"+wid+"' and at.type_of_asset_code=substr(work_id,7,2) ";
		
         stmt=conn.createStatement();
		 ////System.out..println("qry:"+qry);
		 rs=stmt.executeQuery(qry);
		 if(rs.next())
			 
		  if(rs.getString("WORK_CANCEL_DT")!=null){
			  status="Cancelled";
		  }
		 
	   {%>
	   <tr><td class="rptHeading" style="text-align: left;"><font face="verdana" size="2">District Name:</font><font face="verdana" size="2" color="green"> <%=rs.getString(9)%></font></td></tr>
            <tr><td class="rptHeading" style="text-align: left;"><font face="verdana" size="2">Work Name:</font><font face="verdana" size="2" color="green"> <%=wid%>-<%=rs.getString(1)%></font></td></tr>
			<tr><td  class="rptHeading" style="text-align: left;"><font face="verdana" size="2">Program:</font><font face="verdana" size="2" color="green"><%=rs.getString(2)%> </font> &nbsp;SubProgram:<font face="verdana" size="2" color="green"><%=rs.getString(3)%> </font></td></tr>
			 <tr><td class="rptHeading" style="text-align: left;"><font face="verdana" size="2">Plan/NonPlan:</font><font face="verdana" size="2" color="green"><%=rs.getString(5)%> </font> &nbsp; Type:<font face="verdana" size="2" color="green"><%=rs.getString(4)%> </font></td></tr> 
			 <tr><td class="rptHeading" style="text-align: left;"><font face="verdana" size="2">Work Category:</font><font face="verdana" size="2" color="green"><%=rs.getString(6)%> </font></td></tr>
 			 <tr><td class="rptHeading" style="text-align: left;"><font face="verdana" size="2">Scheme:</font><font face="verdana" size="2" color="green"><%=rs.getString("type_of_asset_name")%> </font></td></tr>
 			 <tr><td class="rptHeading" style="text-align: left;"><font face="verdana" size="2">Status:</font><font face="verdana" size="2" color="green"><%= status%> </font></td></tr>
	   <%}
	   String qry1="select programme_name,subprogramme_name from rws_work_admn_prog_lnk_tbl w,rws_programme_tbl p,rws_subprogramme_tbl s where w.programme_code=p.programme_code and s.programme_code=p.programme_code and  w.programme_code=s.programme_code  and w.sub_programme_code =s.subprogramme_code and  work_id='"+wid+"' ";
	   Statement stmtl=conn.createStatement();
	   ////System.out..println("qry1:"+qry1);
	   ResultSet rsl=stmtl.executeQuery(qry1);
	   if(rsl.next())
	    { %>
            <tr><td class="rptHeading" style="text-align: left;">&nbsp;More than 1 Program:<font face="verdana" size="2" color="green"><%=rsl.getString(1)%> </font></td></tr>
			<tr><td class="rptHeading" style="text-align: left;">&nbsp;More than 1 SubProgram:<font face="verdana" size="2" color="green"><%=rsl.getString(2)%> </font></td></tr>
		<%}else{%>
		    &nbsp;
		<%}
		 if(rs!=null) rs.close();
		  if(stmt!=null) stmt.close();
		  if(rsl!=null) rsl.close();
		  if(stmtl!=null) stmtl.close();
		  %></table>
		  
		

    <div id="wrapper"> 
      <div id="content">  
        <h1 class="heading"></h1>
          <div class="demo">
            <h2 class="expand">Admin Sanction</h2>
            <div class="collapse">
                <p>
                <%@ include file="/reports/rws_admin_chklist.jsp" %>
                
                </p>
                
            </div>
           
          
           <h2 class="expand">DPR & Part A</h2>
            <div class="collapse">
                <p><%@ include file="/reports/rws_dpr_checklist.jsp"%></p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div> 
            <h2 class="expand">Technical Sanction</h2>
            <div class="collapse">
                <p><%@ include file="/reports/rws_tech_chklist.jsp"%></p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            <h2 class="expand">Contractor</h2>
            <div class="collapse">
                <p><%@ include file="/reports/rws_contract_chklist.jsp"%></p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            
            <h2 class="expand">Programme Schedule</h2>
            <div class="collapse">
                <p><%@ include file="/reports/rws_programsched_chklist.jsp"%></p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            
            <h2 class="expand">Work Completion</h2>
            <div class="collapse">
                <p><%@ include file="/reports/rws_workcompletion_chklist.jsp"%></p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            
            
            <h2 class="expand">Expenditure</h2>
            <div class="collapse">
                <p><%@ include file="/reports/rws_workexpenditure_chklist.jsp"%></p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            
            
           
             <h2 class="expand">Bills & Vouchers</h2>
            <div class="collapse">
                <p><%@ include file="/reports/rws_work_bill_details.rpt.jsp"%></p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            <h2 class="expand">Commission Details</h2>
            <div class="collapse">
                <p><%@ include file="/reports/rws_wrk_commission_details.jsp"%></p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
          </div>
        </div>
    </div>
</body>
            
            
		  
		<%@ include file = "/reports/footer.jsp" %>
	   	
		
		
		
		
		
		
	
		
		
<%
}//end of try brace
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		conn.close();
	}
%>

</form>

</body>

</html>
