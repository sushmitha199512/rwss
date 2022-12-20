<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
<form>
<%

    DecimalFormat ndf = new DecimalFormat("##.##");
	//String dname=request.getParameter("dname");
	StringBuffer dname=new StringBuffer();
	dname.append(request.getParameter("dname"));
	session.setAttribute("dname",dname.toString());
	
	
	
	//String y1=(String)session.getAttribute("year1");
	StringBuffer y1=new StringBuffer();
	y1.append(session.getAttribute("year1"));
	//System.out.println("scheme*******"+y1.toString());
 	
	
	

 	//String dcode=request.getParameter("dcode");
 	StringBuffer dcode=new StringBuffer();
 	dcode.append(request.getParameter("dcode"));
 	//System.out.println("dcode*******"+dcode.toString());
 	
 	
	int sno=1;
	

	int j=0;
    int h1v1=0,h2v1=0,h3v1=0,h4v1=0,h5v1=0,h6v1=0,h7v1=0;	
    double h1v2=0,h2v2=0,h2v3=0,h3v2=0,h4v2=0,h5v2=0,h6v2=0,tot=0,v1tot=0,v2tot=0,v3tot=0,v4tot=0,v5tot=0,v6tot=0,v7tot=0,v8tot=0,v9tot=0,v10tot=0,v11tot=0,v12tot=0,v13tot=0,v14tot=0,v15tot=0,v16tot=0;
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
	<!--<td class="bwborder"><a href="./rws_drought_contigencyplan_habs_xls.jsp" target=_new>Excel</a></td>--> 
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading"  colspan=19>ABSTRACT OF CONTEGENCY PLAN - HABITATIONS FOR DROUGHT - <%=y1%> <font color="white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;***Amount in Lakhs</font> </td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center>
	
	</tr>
	<tr align=center>
	
	<td class=btext  rowspan = 2>Sl.No</td>
    <td class=btext  rowspan = 2 nowrap>District</td>
    <td class=btext  rowspan = 2 nowrap>Mandal</td>
   	<td class=btext  rowspan = 2 nowrap>No of.<br> Habitations</td>
	<td class=btext  colspan = 2 nowrap>Transportation</td>
	<td class=btext  colspan = 3 nowrap>Hiring of Private Sources</td>
	<td class=btext  colspan = 2 nowrap>Flushing of BW</td>
	<td class=btext  colspan = 2 nowrap>Deepening of BW<br>(including Flushing + Deeping)</td>
	<td class=btext  colspan = 2 nowrap>Deeping of OW</td>
	<td class=btext  colspan  =2 nowrap>Filling of SS Tanks<br>(By Mechanical Lifting)</td>
	<td class=btext  rowspan = 2 nowrap>Total<br> Amount</td>
	</tr>
<tr>
    <td class=btext >No.</td>
    <td class=btext  nowrap>Amount</td>
   	<td class=btext  nowrap>No.of Habs</td>
	<td class=btext  nowrap>No.of Sources</td>
	<td class=btext  nowrap>Amount</td>
	<td class=btext  nowrap>No.</td>
    <td class=btext  nowrap>Amount</td>
	<td class=btext  nowrap>No.</td>
    <td class=btext  nowrap>Amount</td>
    <td class=btext  nowrap>No.</td>
    <td class=btext  nowrap>Amount</td>
    <td class=btext  nowrap>No.</td>
    <td class=btext  nowrap>Amount</td>
</tr>
	<tr>
<%
StringBuffer query=new StringBuffer();

StringBuffer List1=new StringBuffer();
StringBuffer List2=new StringBuffer();  
StringBuffer List3=new StringBuffer();
StringBuffer List4=new StringBuffer();
StringBuffer List5=new StringBuffer();  
StringBuffer List6=new StringBuffer();  
StringBuffer List7=new StringBuffer();

try	

  {

	query.delete(0,query.length());
    query.append("select substr(habcode,1,2),substr(habcode,6,2),count(*),sum(nvl(TRANSPORT_EST,'0')) from rws_drought_habitation_tbl where TRANSPORTATION ='Y' and year='"+y1.toString()+"' group by substr(habcode,1,2),substr(habcode,6,2)");
	Statement stmt2=conn.createStatement();
	//System.out.println("trasqry**********"+query.toString());
   	ResultSet rs2=stmt2.executeQuery(query.toString());
	Hashtable transList=new Hashtable();
	while(rs2.next())
	{
		transList.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();
	session.setAttribute("transList",transList.toString());
	
	
	
	query.delete(0,query.length());
    query.append("select substr(habcode,1,2),substr(habcode,6,2),count(*),sum(nvl(HIRING_OF_SOURCES,'0')),sum(nvl(HIRING_EST,'0')) from rws_drought_habitation_tbl where HIRING_OF_SOURCES>0 and year='"+y1.toString()+"' group by substr(habcode,1,2),substr(habcode,6,2)");
	Statement stmt3=conn.createStatement();
    //System.out.println("hireqry**********"+hireqry);	
   	ResultSet rs3=stmt3.executeQuery(query.toString());
	Hashtable hireList=new Hashtable();
	while(rs3.next())
	{
		hireList.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5));
        //System.out.println(hireList.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();
	session.setAttribute("hireList",hireList.toString());
	
	
	
	

	query.delete(0,query.length());
    query.append("select substr(habcode,1,2),substr(habcode,6,2),sum(nvl(FLUSHING,0)),sum(nvl(FLUSHING_EST,'0')) from rws_drought_habitation_tbl where FLUSHING>0 and year='"+y1.toString()+"' group by substr(habcode,1,2),substr(habcode,6,2)");
	Statement stmt4=conn.createStatement();
    //System.out.println("flushqry**********"+flushqry);	
   	ResultSet rs4=stmt4.executeQuery(query.toString());
	Hashtable flushList=new Hashtable();
	while(rs4.next())
	{
		flushList.put(rs4.getString(1)+rs4.getString(2),rs4.getString(3)+"@"+rs4.getString(4));
        ////System.out.println(hireList.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)));
	}
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
	session.setAttribute("flushList",flushList.toString());
	
	
	
	

	
	
	query.delete(0,query.length());
    query.append("select substr(habcode,1,2),substr(habcode,6,2),sum(nvl(DEEPENING,0)) ,sum(nvl(DEEPENING_EST,'0')) from rws_drought_habitation_tbl where DEEPENING>0 and year='"+y1.toString()+"' group by substr(habcode,1,2),substr(habcode,6,2)");
	Statement stmt5=conn.createStatement();
    //System.out.println("deepqry**********"+deepqry);	
   	ResultSet rs5=stmt5.executeQuery(query.toString());
	Hashtable deepList=new Hashtable();
	while(rs5.next())
	{
		deepList.put(rs5.getString(1)+rs5.getString(2),rs5.getString(3)+"@"+rs5.getString(4));
        ////System.out.println(hireList.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)));
	}
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();
	session.setAttribute("deepList",deepList.toString());
	
	
	
	

	query.delete(0,query.length());
    query.append("select substr(habcode,1,2),substr(habcode,6,2),sum(nvl(DEEP_OW_NUM,0)),sum(nvl(DEEP_OW_EST,'0')) from rws_drought_habitation_tbl where DEEP_OW_NUM>0 and year='"+y1.toString()+"' group by substr(habcode,1,2),substr(habcode,6,2)");
	Statement stmt6=conn.createStatement();
    //System.out.println("owdeepqry**********"+owdeepqry);	
   	ResultSet rs6=stmt6.executeQuery(query.toString());
	Hashtable owdeepList=new Hashtable();
	while(rs6.next())
	{
		owdeepList.put(rs6.getString(1)+rs6.getString(2),rs6.getString(3)+"@"+rs6.getString(4));
        ////System.out.println(hireList.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)));
	}
	if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();
	session.setAttribute("owdeepList",owdeepList.toString());


	
	
	
	
	query.delete(0,query.length());
    query.append("select substr(habcode,1,2),substr(habcode,6,2),sum(nvl(SST_NUM,0)),sum(nvl(SST_EST,'0')) from rws_drought_habitation_tbl where SST_NUM>0 and year='"+y1.toString()+"' group by substr(habcode,1,2),substr(habcode,6,2)");
	Statement stmt7=conn.createStatement();
    //System.out.println("sstqry**********"+sstqry);	
   	ResultSet rs7=stmt7.executeQuery(query.toString());
	Hashtable sstList=new Hashtable();
	while(rs7.next())
	{
		sstList.put(rs7.getString(1)+rs7.getString(2),rs7.getString(3)+"@"+rs7.getString(4));
        ////System.out.println(hireList.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)));
	}
	if(rs7!=null)rs7.close();
	if(stmt7!=null)stmt7.close();
	session.setAttribute("sstList",sstList.toString());


	query.delete(0,query.length());
    query.append("select dcode,count(*) from rws_drought_mandal_tbl  where year='"+y1.toString()+"' and drought_mandal='Y' group by dcode");
	Statement stmt8=conn.createStatement();
    System.out.println("mancntqry**********"+query.toString());	
   	ResultSet rs8=stmt8.executeQuery(query.toString());
	Hashtable mancntList=new Hashtable();
	while(rs8.next())
	{
		mancntList.put(rs8.getString(1),rs8.getString(2));
        ////System.out.println(hireList.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close();
	session.setAttribute("mancntList",mancntList.toString());


///////////////////////////////////////////////////////////////////
	if(dcode.toString().equals("00"))
  {
query.delete(0,query.length());
query.append("select substr(habcode,1,2),substr(habcode,6,2),d.dname,count(*),mname from rws_district_tbl d,rws_drought_habitation_tbl h,rws_mandal_tbl a where substr(h.habcode,1,2)=d.dcode and d.dcode=a.DCODE  and year='"+y1+"'  group by substr(habcode,1,2),d.dname,substr(habcode,6,2),mname  order by 2");
  }
  else
	{
	  
	  query.delete(0,query.length());
	  query.append("select substr(habcode,1,2),substr(habcode,6,2),d.dname,count(*),mname from rws_district_tbl d,rws_drought_habitation_tbl h,rws_mandal_tbl a where substr(h.habcode,1,2)=d.dcode and d.dcode=a.DCODE  and year='"+y1+"' and substr(h.habcode,1,2)='"+dcode+"' group by substr(habcode,1,2),d.dname,substr(habcode,6,2),mname  order by 2");
	}
		

	query.delete(0,query.length());
	query.append("select substr(habcode,1,2),substr(habcode,6,2),d.dname,m.mname,count(*)  from rws_district_tbl d,rws_drought_habitation_tbl h,rws_mandal_tbl m  where substr(h.habcode,1,2)=d.dcode  and year='"+y1+"' and substr(h.habcode,1,2)='"+dcode+"'  and m.dcode=d.dcode and m.mcode=substr(habcode,6,2) group by substr(habcode,1,2),substr(habcode,6,2),d.dname,m.mname order by 2");
     //System.out.println("queryttttt**********"+query.toString());
	
	Statement	stmt1=conn.createStatement();
    
	ResultSet rs1=stmt1.executeQuery(query.toString());
          
	
	while (rs1.next())
	{
		
		
		int sd=Integer.parseInt(rs1.getString(5));
		j++;
    
      //String List1=""+transList.get(rs1.getString(1)+rs1.getString(2));
    List1.delete(0,List1.length());
      List1.append(""+transList.get(rs1.getString(1)+rs1.getString(2)));
       if(List1!=null && !List1.toString().equals("null") && !List1.toString().equals(""))
      { 
         String Arr1[]=List1.toString().split("@");
         h1v1=Integer.parseInt(Arr1[0]);
         h1v2=Double.parseDouble(Arr1[1]);
        
      }
      else
      {
         h1v1=0;
         h2v2=0;
        
      }

       
       
    //  String List2=""+hireList.get(rs1.getString(1)+rs1.getString(2));
    List2.delete(0,List2.length());
    List2.append(""+hireList.get(rs1.getString(1)+rs1.getString(2)));
    
      if(List2!=null && !List2.toString().equals("null") && !List2.toString().equals(""))
      {  
         String Arr2[]=List2.toString().split("@");
         h2v1=Integer.parseInt(Arr2[0]);
         h2v2=Double.parseDouble(Arr2[1]);
         h2v3=Double.parseDouble(Arr2[2]);
      }
      else
      {
         h2v1=0;
         h2v2=0;
         h2v3=0;
      }


  //  String List3=""+flushList.get(rs1.getString(1)+rs1.getString(2));
  List3.delete(0,List3.length());
  List3.append(""+flushList.get(rs1.getString(1)+rs1.getString(2)));
   
      
      if(List3!=null && !List3.toString().equals("null") && !List3.toString().equals(""))
      { 
         String Arr3[]=List3.toString().split("@");
         h3v1=Integer.parseInt(Arr3[0]);
         h3v2=Double.parseDouble(Arr3[1]);
        
      }
      else
      {
         h3v1=0;
         h3v2=0;
        
      }

//String List4=""+deepList.get(rs1.getString(1)+rs1.getString(2));
List4.delete(0,List4.length());
List4.append(""+deepList.get(rs1.getString(1)+rs1.getString(2)));
       if(List4!=null && !List4.toString().equals("null") && !List4.toString().equals(""))
      { 
         String Arr4[]=List4.toString().split("@");
         h4v1=Integer.parseInt(Arr4[0]);
         h4v2=Double.parseDouble(Arr4[1]);
        
      }
      else
      {
         h4v1=0;
         h4v2=0;
        
      }


//String List5=""+owdeepList.get(rs1.getString(1)+rs1.getString(2));
List5.delete(0,List5.length());
 List5.append(""+owdeepList.get(rs1.getString(1)+rs1.getString(2)));
      
      if(List5!=null && !List5.toString().equals("null") && !List5.toString().equals(""))
      { 
         String Arr5[]=List5.toString().split("@");
         h5v1=Integer.parseInt(Arr5[0]);
         h5v2=Double.parseDouble(Arr5[1]);
        
      }
      else
      {
         h5v1=0;
         h5v2=0;
        
      }


 //     String List6=""+sstList.get(rs1.getString(1)+rs1.getString(2));
   List6.delete(0,List6.length());
    List6.append(""+sstList.get(rs1.getString(1)+rs1.getString(2)));
     
      if(List6!=null && !List6.toString().equals("null") && !List6.toString().equals(""))
      { 
         String Arr6[]=List6.toString().split("@");
         h6v1=Integer.parseInt(Arr6[0]);
         h6v2=Double.parseDouble(Arr6[1]);
        
      }
      else
      {
         h6v1=0;
         h6v2=0;
        
      }

   
 //   String List7=""+mancntList.get(rs1.getString(1)+rs1.getString(2));
List7.delete(0,List7.length());
   List7.append(""+mancntList.get(rs1.getString(1)+rs1.getString(2)));
      
      if(List7!=null && !List7.toString().equals("null") && !List7.toString().equals(""))
      { 
         String Arr7[]=List7.toString().split("@");
         h7v1=Integer.parseInt(Arr7[0]);
        
        
      }
      else
      {
         h7v1=0;
         
        
      }

 	%>
	<tr>
	<td class="rptValue"><%=sno++%></td>
    <td class="rptValue"><%=rs1.getString(3)%></td>
     <td class="rptValue"><%=rs1.getString(4)%></td>
     <td class="rptValue" align="right"><%=sd %></td>
     <td class="rptValue" align="right"><%=h1v1%></td>
	<td class="rptValue" align="right"><%=h1v2%></td>
    <td class="rptValue" align="right"><%=h2v1%></td>
	<td class="rptValue" align="right"><%=h2v2%></td>
	<td class="rptValue" align="right"><%=h2v3%></td>
    <td class="rptValue" align="right"><%=h3v1%></td>
	<td class="rptValue" align="right"><%=h3v2%></td>
	<td class="rptValue" align="right"><%=h4v1%></td>
	<td class="rptValue" align="right"><%=h4v2%></td>
	<td class="rptValue" align="right"><%=h5v1%></td>
	<td class="rptValue" align="right"><%=h5v2%></td>
	<td class="rptValue" align="right"><%=h6v1%></td>
	<td class="rptValue" align="right"><%=h6v2%></td>
    
    <% 
   tot=h1v2+h2v3+h3v2+h4v2+h5v2+h6v2;
   %>
	<td class="rptValue"align="right"><%=ndf.format(tot)%></td>
	</tr>
	
	
<%
//v14tot+=Double.parseDouble(rs1.getString(3));
v1tot+=h1v1;
v2tot+=h1v2;
v3tot+=h2v1;
v4tot+=h2v2;
v5tot+=h2v3;
v6tot+=h3v1;
v7tot+=h3v2;
v8tot+=h4v1;
v9tot+=h4v2;
v10tot+=h5v1;
v11tot+=h5v2;
v12tot+=h6v1;
v13tot+=h6v2;
v15tot+=tot;
v16tot+=h7v1;
v14tot+=sd;

h1v1=0;
h1v2=0;
h2v1=0;
h2v2=0;
h2v3=0;
h3v1=0;
h3v2=0;
h4v1=0;
h4v2=0;
h5v1=0;
h5v2=0;
h6v1=0;
h6v2=0;
h7v1=0;
tot=0;

  
}
%>
	<tr>
     <td class=bText colspan=3 align="right">Total</td>
       
     
     <td class=bText align="right"><%=ndf.format(v14tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v1tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v2tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v3tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v4tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v5tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v6tot)%></td>
     <td class=bText align="right"><%=ndf.format(v7tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v8tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v9tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v10tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v11tot)%></td>
	 <td class=bText align="right"><%=ndf.format(v12tot)%></td>
     <td class=bText align="right"><%=ndf.format(v13tot)%></td>	 
	 <td class=bText align="right"><%=ndf.format(v15tot)%></td>

	</tr>
	
<%	
	if(j==0)
	{
%>
	<tr>
	<td colspan=19 align="center">No Records</td>
	</tr>
	
	<%
     }
	

}
catch(Exception e)
	{
		//System.out.println("error::"+e);
        e.printStackTrace();
}
finally{
	dcode=null;
	dname=null;
	y1=null;
	query=null;
	List1=null;
	List2=null;
	 List3=null;
	 List4=null;
	 List5=null;
	 List6=null;
	 List7=null;
	
}
%>
  </table>
<%@ include file = "/commons/rws_footer.jsp" %>
</form>

