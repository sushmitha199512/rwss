<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 
<style>
.thumbnail {
	position: relative;
	z-index: 0;
}

.thumbnail:hover {
	background-color: transparent;
	z-index: 60;
}

.thumbnail span { /*CSS for enlarged image*/
	position: absolute;
	background-color: lightyellow;
	padding: 4px;
	left: -99px;
	border: 1px dashed gray;
	visibility: hidden;
	color: black;
	text-decoration: none;
}

.thumbnail span img { /*CSS for enlarged image*/
	border-width: 0;
	padding: 2px;
	width:500px;
	height:320px;
}

.thumbnail:hover span { /*CSS for enlarged image on hover*/
	visibility: visible;
	top: -120px;
	left: -350px;
	/*position where enlarged image should offset horizontally */
}
</style>
</head>
<script language="JavaScript">

/* function viewWorks(URL)
{
	
var popFeatures = "width=800,height=550,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
} */

function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}
</script>
<form>
<%
    String qry="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
    int count=1;
   
    String level=request.getParameter("level");
    String fromDate=request.getParameter("fromDate");
    String toDate=request.getParameter("toDate");
    //System.out.println("fromDate"+fromDate+"HGH"+toDate);
   // System.out.println("kjgjghgh"+level);
   if(level.equals("State")){
		%>
		<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>
		|<a href="rws_news_paper_clippings_rpt_drill_xls.jsp?level=<%=level%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>">Excel</a></td>

  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >News Paper Clippings(Level:<%=level %>)</td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    
	<td class=gridhdbg colspan=6>Details of Paper Clippings</td>
	  <td class=gridhdbg rowspan=2>Remarks</td>
	<td class=gridhdbg rowspan=2>Paper Clipping Scanned&nbsp;Copy</td>
	<td class=gridhdbg rowspan=2>ATR Scanned&nbsp;Copy</td>
       </tr>
	<tr>
	
	<td class=gridhdbg>Date</td>
    <td class=gridhdbg>Paper</td>
    <td class=gridhdbg>Edition(District/State)</td>
   <td class=gridhdbg>Gist&nbsp;of&nbsp;Adverse&nbsp;News</td>
  <td class=gridhdbg>&nbsp;&nbsp;&nbsp;Action&nbsp;Taken&nbsp;Report&nbsp;&nbsp;&nbsp;</td>
  <td class=gridhdbg>Type of Adverse News Item </td>
    
    
	</tr>
	<%
try{
	
	 PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null,pstmt7=null,pstmt8=null;
	   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
	   
	qry="select to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'-')  from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where dcode='00' and CLIP_Level='State' and PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')";
	pstmt2=conn.prepareStatement(qry);  
	
	pstmt2.setString(1, fromDate);
	pstmt2.setString(2, toDate);
   rs2=pstmt2.executeQuery();
   while(rs2.next())
   {
	  
    if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		 String remarks="";
	if(rs2.getString(6)!=null){
		remarks=rs2.getString(6);
	}
	else{
		remarks="--";
	}
	
%>

<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(1) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(2) %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(4) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(5) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(8) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=remarks %></td>

<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=clipImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=clipImage"
																 id="bigImage" /></span></a></td>
																 
<%
String paperDateTemp = "";
if(rs2.getString(1).contains("/")){
	paperDateTemp = rs2.getString(1).replace("/", "-");
}else{
	paperDateTemp = rs2.getString(1);
}
String newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+"ACT_"+rs2.getString(7)+".jpg";
//System.out.println("newsPaperImagePath :"+newsPaperImagePath);
File f = new File(newsPaperImagePath);
if(!f.getAbsoluteFile().exists()){
	try{
		//System.out.println(" atr image file not exists");	
	
	String getQuery = "select ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where NEWS_ID=?";

pstmt1 = conn.prepareStatement(getQuery);
pstmt1.setString(1, rs2.getString(7));

rs1 = pstmt1.executeQuery();
//System.out.println(" atr image query :"+getQuery);
if (rs1.next()) {
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%
}else{
	%>
	<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
	<%
}
	}catch(Exception e){
		e.getMessage();
		%>
		<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
		<%
	}finally{
		try{
			if(pstmt1 != null){
				pstmt1.close();
			}
			if(rs1 != null)
				rs1.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}else{
%>

<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%} %>
</tr>
<%
   }
   pstmt2.close();
   rs2.close();
}
	catch(Exception e){
		e.printStackTrace();
	}
%>
	
</table>
		<%
   }
   else if(level.equals("District")){
	   String dcode=request.getParameter("dcode");
	    String dname=request.getParameter("dname");
	   // System.out.println(dcode+dname);
	   %>
	   <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>

|<a href="rws_news_paper_clippings_rpt_drill_xls.jsp?level=<%=level%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>&dcode=<%=dcode%>&dname=<%=dname%>">Excel</a></td>
  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >News Paper Clippings(Level:<%=level %>&nbsp;AND&nbsp;District Name:<%=dname %> )</td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    
	<td class=gridhdbg colspan=6>Details of Paper Clippings</td>
	  <td class=gridhdbg rowspan=2>Remarks</td>
	<td class=gridhdbg rowspan=2>Paper Clipping Scanned&nbsp;Copy</td>
	<td class=gridhdbg rowspan=2>ATR Scanned&nbsp;Copy</td>
       </tr>
	<tr>
	
	<td class=gridhdbg>Date</td>
    <td class=gridhdbg>Paper</td>
    <td class=gridhdbg>Edition(District/State)</td>
   <td class=gridhdbg>Gist&nbsp;of&nbsp;Adverse&nbsp;News</td>
  <td class=gridhdbg>&nbsp;&nbsp;&nbsp;Action&nbsp;Taken&nbsp;Report&nbsp;&nbsp;&nbsp;</td>
   <td class=gridhdbg>Type of Adverse News Item </td>
    
    
	</tr>
	<%
try{
	
	 PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null,pstmt7=null,pstmt8=null;
	   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
	   
	qry="select to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'-') from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where dcode=? and CLIP_Level='District' and PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')";
	pstmt2=conn.prepareStatement(qry);  
	pstmt2.setString(1, dcode);
	pstmt2.setString(2, fromDate);
	pstmt2.setString(3, toDate);
   rs2=pstmt2.executeQuery();
   while(rs2.next())
   {
	   
    if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		 String remarks="";
			if(rs2.getString(6)!=null){
				remarks=rs2.getString(6);
			}
			else{
				remarks="--";
			}
	
%>

<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(1) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(2) %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(4) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(5) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(8) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=remarks%></td>

<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=clipImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=clipImage"
																 id="bigImage" /></span></a></td>
																 
<%
String paperDateTemp = "";
if(rs2.getString(1).contains("/")){
	paperDateTemp = rs2.getString(1).replace("/", "-");
}else{
	paperDateTemp = rs2.getString(1);
}
String newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+"ACT_"+rs2.getString(7)+".jpg";
//System.out.println("newsPaperImagePath :"+newsPaperImagePath);
File f = new File(newsPaperImagePath);
if(!f.getAbsoluteFile().exists()){
	try{
		//System.out.println(" atr image file not exists");	
	
	String getQuery = "select ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where NEWS_ID=?";

pstmt1 = conn.prepareStatement(getQuery);
pstmt1.setString(1, rs2.getString(7));

rs1 = pstmt1.executeQuery();
//System.out.println(" atr image query :"+getQuery);
if (rs1.next()) {
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%
}else{
	%>
	<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
	<%
}
	}catch(Exception e){
		e.getMessage();
		%>
		<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
		<%
	}finally{
		try{
			if(pstmt1 != null){
				pstmt1.close();
			}
			if(rs1 != null)
				rs1.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}else{
%>

<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(7)%>&date=<%=rs2.getString(1)%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%} %>
</tr>
<%
   }
   pstmt2.close();
   rs2.close();
}
	catch(Exception e){
		e.printStackTrace();
	}
%>
	
</table>
	   <%
   }
  else if(level.equals("Mandal")){
	  String dcode=request.getParameter("dcode");
	    String dname=request.getParameter("dname");
	  %>
	   <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>

|<a href="rws_news_paper_clippings_rpt_drill_xls.jsp?level=<%=level%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>&dcode=<%=dcode%>&dname=<%=dname%>">Excel</a></td>
  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >News Paper Clippings(Level:<%=level %>&nbsp;AND&nbsp;District Name:<%=dname %> )</td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
	<td class=gridhdbg colspan=6>Details of Paper Clippings</td>
	  <td class=gridhdbg rowspan=2>Remarks</td>
	<td class=gridhdbg rowspan=2>Paper Clipping Scanned&nbsp;Copy</td>
	<td class=gridhdbg rowspan=2>ATR Scanned&nbsp;Copy</td>
       </tr>
	<tr>
	
	<td class=gridhdbg>Date</td>
    <td class=gridhdbg>Paper</td>
    <td class=gridhdbg>Edition(District/State)</td>
   <td class=gridhdbg>Gist&nbsp;of&nbsp;Adverse&nbsp;News</td>
  <td class=gridhdbg>&nbsp;&nbsp;&nbsp;Action&nbsp;Taken&nbsp;Report&nbsp;&nbsp;&nbsp;</td>
   
    <td class=gridhdbg>Type of Adverse News Item </td>
    
	</tr>
	<%
try{
	
	 PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null,pstmt7=null,pstmt8=null;
	   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
	   
	qry="select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'-')  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.MCODE=a.MCODE  and b.DCODE=a.DCODE  and b.DCODE=? and CLIP_Level='Mandal' and PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')";
	pstmt2=conn.prepareStatement(qry);  
	pstmt2.setString(1, dcode);
	pstmt2.setString(2, fromDate);
	pstmt2.setString(3, toDate);
   rs2=pstmt2.executeQuery();
   while(rs2.next())
   {
	   
    if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		 String remarks="";
			if(rs2.getString(10)!=null){
				remarks=rs2.getString(10);
			}
			else{
				remarks="--";
			}
	
%>

<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(5) %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(6) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(7) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(8) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(9) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(12) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=remarks%></td>

 <td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(11)%>&date=<%=rs2.getString(5)%>&mode=clipImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(11)%>&date=<%=rs2.getString(5)%>&mode=clipImage"
																 id="bigImage" /></span></a></td>
																 
<%
String paperDateTemp = "",newsDate=rs2.getString(5),newsId = rs2.getString(11);
if(newsDate.contains("/")){
	paperDateTemp =newsDate.replace("/", "-");
}else{
	paperDateTemp = newsDate;
}
String newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+"ACT_"+newsId+".jpg";
//System.out.println("newsPaperImagePath :"+newsPaperImagePath);
File f = new File(newsPaperImagePath);
if(!f.getAbsoluteFile().exists()){
	try{
		//System.out.println(" atr image file not exists");	
	
	String getQuery = "select ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where NEWS_ID=?";

pstmt1 = conn.prepareStatement(getQuery);
pstmt1.setString(1, newsId);

rs1 = pstmt1.executeQuery();
//System.out.println(" atr image query :"+getQuery);
if (rs1.next()) {
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%
}else{
	%>
	<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
	<%
}
	}catch(Exception e){
		e.getMessage();
		%>
		<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
		<%
	}finally{
		try{
			if(pstmt1 != null){
				pstmt1.close();
			}
			if(rs1 != null)
				rs1.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}else{
%>

<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%} %>
</tr>
<%
   }
   pstmt2.close();
   rs2.close();
}
	catch(Exception e){
		e.printStackTrace();
	}
%>
	
</table>
	  <%
   }
  else if(level.equals("Panchayat")){
	  String dcode=request.getParameter("dcode");
	    String dname=request.getParameter("dname");
	  %>
	   <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>
|<a href="rws_news_paper_clippings_rpt_drill_xls.jsp?level=<%=level%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>&dcode=<%=dcode%>&dname=<%=dname%>">Excel</a></td>

  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >News Paper Clippings(Level:<%=level %>&nbsp;AND&nbsp;District Name:<%=dname %> )</td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
     <td class=gridhdbg rowspan=2>Panchayat</td>
	<td class=gridhdbg colspan=6>Details of Paper Clippings</td>
	  <td class=gridhdbg rowspan=2>Remarks</td>
	<td class=gridhdbg rowspan=2>Paper Clipping Scanned&nbsp;Copy</td>
	<td class=gridhdbg rowspan=2>ATR Scanned&nbsp;Copy</td>
       </tr>
	<tr>
	
	<td class=gridhdbg>Date</td>
    <td class=gridhdbg>Paper</td>
    <td class=gridhdbg>Edition(District/State)</td>
    <td class=gridhdbg>Gist&nbsp;of&nbsp;Adverse&nbsp;News</td>
  <td class=gridhdbg>&nbsp;&nbsp;&nbsp;Action&nbsp;Taken&nbsp;Report&nbsp;&nbsp;&nbsp;</td>
   <td class=gridhdbg>Type of Adverse News Item </td>
    
    
	</tr>
	<%
try{
	
	 PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null,pstmt7=null,pstmt8=null;
	   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
	   
	qry="select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,a.PNAME,a.PCODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'-')  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.PCODE=a.PCODE  and b.DCODE=a.DCODE  and b.MCODE=a.MCODE and b.DCODE=? and CLIP_Level='Panchayat' and PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')";
	pstmt2=conn.prepareStatement(qry);  
	pstmt2.setString(1, dcode);
	pstmt2.setString(2, fromDate);
	pstmt2.setString(3, toDate);
   rs2=pstmt2.executeQuery();
   while(rs2.next())
   {
	   
    if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		 String remarks="";
			if(rs2.getString(12)!=null){
				remarks=rs2.getString(12);
			}
			else{
				remarks="--";
			}
	
%>

<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(5) %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(7) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(8) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(9) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(10) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(11) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(14) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=remarks%></td>

 <td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(13)%>&date=<%=rs2.getString(7)%>&mode=clipImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(13)%>&date=<%=rs2.getString(7)%>&mode=clipImage"
																 id="bigImage" /></span></a></td>
																 
<%
String paperDateTemp = "",newsDate=rs2.getString(7),newsId = rs2.getString(13);
if(newsDate.contains("/")){
	paperDateTemp =newsDate.replace("/", "-");
}else{
	paperDateTemp = newsDate;
}
String newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+"ACT_"+newsId+".jpg";
//System.out.println("newsPaperImagePath :"+newsPaperImagePath);
File f = new File(newsPaperImagePath);
if(!f.getAbsoluteFile().exists()){
	try{
		//System.out.println(" atr image file not exists");	
	
	String getQuery = "select ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where NEWS_ID=?";

pstmt1 = conn.prepareStatement(getQuery);
pstmt1.setString(1, newsId);

rs1 = pstmt1.executeQuery();
//System.out.println(" atr image query :"+getQuery);
if (rs1.next()) {
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%
}else{
	%>
	<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
	<%
}
	}catch(Exception e){
		e.getMessage();
		%>
		<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
		<%
	}finally{
		try{
			if(pstmt1 != null){
				pstmt1.close();
			}
			if(rs1 != null)
				rs1.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}else{
%>

<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%} %>
</tr>
<%
   }
   pstmt2.close();
   rs2.close();
}
	catch(Exception e){
		e.printStackTrace();
	}
%>
	
</table>
	  <%
  }
  else if(level.equals("Village")){
	  String dcode=request.getParameter("dcode");
	    String dname=request.getParameter("dname");
	  %>
	   <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>

|<a href="rws_news_paper_clippings_rpt_drill_xls.jsp?level=<%=level%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>&dcode=<%=dcode%>&dname=<%=dname%>">Excel</a></td>
  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >News Paper Clippings(Level:<%=level %>&nbsp;AND&nbsp;District Name:<%=dname %> )</td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
     <td class=gridhdbg rowspan=2>Panchayat</td>
      <td class=gridhdbg rowspan=2>Village</td>
	<td class=gridhdbg colspan=6>Details of Paper Clippings</td>
	  <td class=gridhdbg rowspan=2>Remarks</td>
	<td class=gridhdbg rowspan=2>Paper Clipping Scanned&nbsp;Copy</td>
	<td class=gridhdbg rowspan=2>ATR Scanned&nbsp;Copy</td>
       </tr>
	<tr>
	
	<td class=gridhdbg>Date</td>
    <td class=gridhdbg>Paper</td>
    <td class=gridhdbg>Edition(District/State)</td>
    <td class=gridhdbg>Gist&nbsp;of&nbsp;Adverse&nbsp;News</td>
  <td class=gridhdbg>&nbsp;&nbsp;&nbsp;Action&nbsp;Taken&nbsp;Report&nbsp;&nbsp;&nbsp;</td>
    <td class=gridhdbg>Type of Adverse News Item </td>
    
	</tr>
	<%
try{
	
	 PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null,pstmt7=null,pstmt8=null;
	   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
	   
	qry="select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,a.PNAME,a.PCODE,a.VNAME,a.VCODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'-')  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.VCODE=a.VCODE and b.DCODE=a.DCODE and b.MCODE=a.MCODE and b.PCODE=a.PCODE and b.DCODE=? and CLIP_Level='Village' and PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')";
	pstmt2=conn.prepareStatement(qry);  
	pstmt2.setString(1, dcode);
	pstmt2.setString(2, fromDate);
	pstmt2.setString(3, toDate);
   rs2=pstmt2.executeQuery();
   while(rs2.next())
   {
	   
    if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		 String remarks="";
			if(rs2.getString(14)!=null){
				remarks=rs2.getString(14);
			}
			else{
				remarks="--";
			}
	
%>

<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(5) %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(7) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(9) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(10) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(11) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(12) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(13) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(16) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=remarks%></td>

 <td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(15)%>&date=<%=rs2.getString(9)%>&mode=clipImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(15)%>&date=<%=rs2.getString(9)%>&mode=clipImage"
																 id="bigImage" /></span></a></td>
																 
<%
String paperDateTemp = "",newsDate=rs2.getString(9),newsId = rs2.getString(15);
if(newsDate.contains("/")){
	paperDateTemp =newsDate.replace("/", "-");
}else{
	paperDateTemp = newsDate;
}
String newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+"ACT_"+newsId+".jpg";
//System.out.println("newsPaperImagePath :"+newsPaperImagePath);
File f = new File(newsPaperImagePath);
if(!f.getAbsoluteFile().exists()){
	try{
		//System.out.println(" atr image file not exists");	
	
	String getQuery = "select ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where NEWS_ID=?";

pstmt1 = conn.prepareStatement(getQuery);
pstmt1.setString(1, newsId);

rs1 = pstmt1.executeQuery();
//System.out.println(" atr image query :"+getQuery);
if (rs1.next()) {
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%
}else{
	%>
	<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
	<%
}
	}catch(Exception e){
		e.getMessage();
		%>
		<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
		<%
	}finally{
		try{
			if(pstmt1 != null){
				pstmt1.close();
			}
			if(rs1 != null)
				rs1.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}else{
%>

<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%} %>
</tr>
<%
   }
   pstmt2.close();
   rs2.close();
}
	catch(Exception e){
		e.printStackTrace();
	}
%>
	
</table>
	  
	  <%
  }
  else if(level.equals("Habitation")){
	  String dcode=request.getParameter("dcode");
	    String dname=request.getParameter("dname");
	  %>
	   <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>

|<a href="rws_news_paper_clippings_rpt_drill_xls.jsp?level=<%=level%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>&dcode=<%=dcode%>&dname=<%=dname%>">Excel</a></td>

		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >News Paper Clippings(Level:<%=level %>&nbsp;AND&nbsp;District Name:<%=dname %> )</td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
  <td class=gridhdbg rowspan=2>Mandal</td>
   <td class=gridhdbg rowspan=2>Panchayat</td>
    <td class=gridhdbg rowspan=2>Village</td>
    <td class=gridhdbg rowspan=2>Hab Name</td>
    <td class=gridhdbg rowspan=2>Hab Code</td>
	<td class=gridhdbg colspan=6>Details of Paper Clippings</td>
	  <td class=gridhdbg rowspan=2>Remarks</td>
	<td class=gridhdbg rowspan=2>Paper Clipping Scanned&nbsp;Copy</td>
	<td class=gridhdbg rowspan=2>ATR Scanned&nbsp;Copy</td>
     </tr>
	<tr>
	
	<td class=gridhdbg>Date</td>
  <td class=gridhdbg>Paper</td>
  <td class=gridhdbg>Edition(District/State)</td>
  <td class=gridhdbg>Gist&nbsp;of&nbsp;Adverse&nbsp;News</td>
  <td class=gridhdbg>&nbsp;&nbsp;&nbsp;Action&nbsp;Taken&nbsp;Report&nbsp;&nbsp;&nbsp;</td>
 <td class=gridhdbg>Type of Adverse News Item </td>
  
  
	</tr>
	<%
try{
	
	 PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null,pstmt7=null,pstmt8=null;
	   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
	   
	qry="select distinct a.DCODE,a.DNAME,a.MNAME,a.MCODE,a.PNAME,a.PCODE,a.VNAME,a.VCODE,a.PANCH_NAME,a.PANCH_CODE,to_char(PAPER_DATE,'dd/mm/yyyy'),nvl(PAPER_NAME,'') ,nvl(EDITION,''),nvl(PAPER_NEWS,''),nvl(ACTION_TAKEN,'') ,nvl(remarks,''),NEWS_ID,nvl(TYPEOF_ADVERSE_NEWS_ITEM,'-')  from rws_complete_hab_view a, rws_drought_newspaper_item_tbl b where b.VCODE=a.VCODE and b.DCODE=a.DCODE and b.MCODE=a.MCODE and b.PCODE=a.PCODE and b.HAB_CODE=a.PANCH_CODE and b.DCODE=? and CLIP_Level='Habitation' and PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')";
	pstmt2=conn.prepareStatement(qry);  
	pstmt2.setString(1, dcode);
	pstmt2.setString(2, fromDate);
	pstmt2.setString(3, toDate);
 rs2=pstmt2.executeQuery();
 while(rs2.next())
 {
	   
  if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		 String remarks="";
			if(rs2.getString(16)!=null){
				remarks=rs2.getString(16);
			}
			else{
				remarks="--";
			}
	
%>

<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(5) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(7) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(9) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(10) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(11) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(12) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(13) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(14) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(15) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs2.getString(18) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=remarks%></td>

 <td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(17)%>&date=<%=rs2.getString(11)%>&mode=clipImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=rs2.getString(17)%>&date=<%=rs2.getString(11)%>&mode=clipImage"
																 id="bigImage" /></span></a></td>
																 
<%
String paperDateTemp = "",newsDate=rs2.getString(11),newsId = rs2.getString(17);
if(newsDate.contains("/")){
	paperDateTemp =newsDate.replace("/", "-");
}else{
	paperDateTemp = newsDate;
}
String newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+"ACT_"+newsId+".jpg";
//System.out.println("newsPaperImagePath :"+newsPaperImagePath);
File f = new File(newsPaperImagePath);
if(!f.getAbsoluteFile().exists()){
	try{
		//System.out.println(" atr image file not exists");	
	
	String getQuery = "select ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where NEWS_ID=?";

pstmt1 = conn.prepareStatement(getQuery);
pstmt1.setString(1, newsId);

rs1 = pstmt1.executeQuery();
//System.out.println(" atr image query :"+getQuery);
if (rs1.next()) {
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%
}else{
	%>
	<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
	<%
}
	}catch(Exception e){
		e.getMessage();
		%>
		<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
		<%
	}finally{
		try{
			if(pstmt1 != null){
				pstmt1.close();
			}
			if(rs1 != null)
				rs1.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}else{
%>

<td class="<%=style %>" style="text-align: left;" align="right"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<%=newsId%>&date=<%=newsDate%>&mode=atrImage"
																 id="bigImage" /></span></a></td>
<%} %>
</tr>
<%
 }
 pstmt2.close();
 rs2.close();
}
	catch(Exception e){
		e.printStackTrace();
	}
%>
	
</table>
	  
	  <%
  } 
   	%>
</form>
<%-- <%! 
public boolean isAtrImgAvailable(String newsId,String paperDate,Connection conn){
	boolean isImgAvailable = false;
	String paperDateTemp = "";
	if(paperDate.contains("/")){
		paperDateTemp = paperDate.replace("/", "-");
	}else{
		paperDateTemp = paperDate;
	}
	String newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+"\\"+"ACT_"+newsId+".jpg";
	//System.out.println("newsPaperImagePath :"+newsPaperImagePath);
	//System.out.println("newsPaperImagePath :"+newsPaperImagePath);
	File f = new File(newsPaperImagePath);
	if(!f.exists()){
		try{
			//System.out.println(" atr image file not exists");	
		
		String getQuery = "select ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where NEWS_ID=?";

	pstmt1 = conn.prepareStatement(getQuery);
	pstmt1.setString(1, rs2.getString(7));

	rs1 = pstmt1.executeQuery();
	//System.out.println(" atr image query :"+getQuery);
	if (rs1.next()) {
		
	}
		}catch(Exception e){
		e.printStackTrace();
	}
	}else isImgAvailable = true;
			
	return isImgAvailable;
}
%> --%>