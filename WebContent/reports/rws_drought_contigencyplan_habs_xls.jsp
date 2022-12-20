<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
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
	
	
    
	//String dcode=(String)session.getAttribute("dcode");
	StringBuffer dcode=new StringBuffer();
	dcode.append(session.getAttribute("dcode"));
	
	
	int sno=1;
	

	int j=0;
    int h1v1=0,h2v1=0,h3v1=0,h4v1=0,h5v1=0,h6v1=0,h7v1=0;	
    double h1v2=0,h2v2=0,h2v3=0,h3v2=0,h4v2=0,h5v2=0,h6v2=0,tot=0,v1tot=0,v2tot=0,v3tot=0,v4tot=0,v5tot=0,v6tot=0,v7tot=0,v8tot=0,v9tot=0,v10tot=0,v11tot=0,v12tot=0,v13tot=0,v14tot=0,v15tot=0,v16tot=0;
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	
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
    <td class=btext  rowspan = 2 nowrap>No.of Drought<br>Mandal Declared</td>
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

	 Hashtable transList=(Hashtable)session.getAttribute("transList");
	 Hashtable hireList=(Hashtable)session.getAttribute("hireList");
	 Hashtable flushList=(Hashtable)session.getAttribute("flushList");
	 Hashtable deepList=(Hashtable)session.getAttribute("deepList");
	 Hashtable owdeepList=(Hashtable)session.getAttribute("owdeepList");
	 Hashtable sstList=(Hashtable)session.getAttribute("sstList");
	 Hashtable mancntList=(Hashtable)session.getAttribute("mancntList");
	 

///////////////////////////////////////////////////////////////////
	if(dcode.toString().equals("00"))
  {
		query.delete(0,query.length());
		query.append("select   substr(habcode,1,2),d.dname,count(*) from rws_district_tbl d,rws_drought_habitation_tbl h where substr(h.habcode,1,2)=d.dcode and year='"+y1+"' group by substr(habcode,1,2),d.dname order by 2");
		System.out.println("EXCEl-----if-00***"+query);
  }
  else
	{
	  query.delete(0,query.length());
		query.append("select   substr(habcode,1,2),d.dname ,count(*) from rws_district_tbl d,rws_drought_habitation_tbl h where substr(h.habcode,1,2)=d.dcode and substr(h.habcode,1,2)='"+dcode+"' and year='"+y1+"' group by substr(habcode,1,2),d.dname order by 2");
		System.out.println("EXCEl-----else-00***"+query);
	}
		
     //System.out.println("query1111**********"+query.toString());
		
	Statement	stmt1=conn.createStatement();
    ResultSet rs1=stmt1.executeQuery(query.toString());

    
	while (rs1.next())
	{
		j++;
    
 
   List1.delete(0,List1.length());
      //String List1=""+transList.get(rs1.getString(1));
         List1.append(""+transList.get(rs1.getString(1)));
         System.out.println("List1 &&&&&&&&"+List1);
      
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

      
      List2.delete(0,List2.length());
    //  String List2=""+hireList.get(rs1.getString(1));
    List2.append(""+hireList.get(rs1.getString(1)));
   // System.out.println("List2 &&&&&&&&"+List2);
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

      List3.delete(0,List3.length());
    //String List3=""+flushList.get(rs1.getString(1));
    List3.append(""+flushList.get(rs1.getString(1)));
   // System.out.println("List3 &&&&&&&&"+List3);
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
      List4.delete(0,List4.length());
//String List4=""+deepList.get(rs1.getString(1));
 List4.append(""+deepList.get(rs1.getString(1))); 
 //System.out.println("List4 &&&&&&&&"+List4);
      if(List4!=null && !List4.toString().equals("null") && !List4.toString().equals(""))
      { 
    	  System.out.println("List4 &&&&&&&&kkk"+List4);
         String Arr4[]=List4.toString().split("@");
         h4v1=Integer.parseInt(Arr4[0]);
         h4v2=Double.parseDouble(Arr4[1]);
        
      }
      else
      {
         h4v1=0;
         h4v2=0;
        
      }

      //System.out.println("List7 &&&&&&&&");
//String List5=""+owdeepList.get(rs1.getString(1));

List5.delete(0,List5.length());
 List5.append(""+owdeepList.get(rs1.getString(1)));     
      if(List5!=null && !List5.toString().equals("null") && !List5.toString().equals(""))
      { 
 //   	  System.out.println("List5 &&&&&&&&kkk"+List5);
         String Arr5[]=List5.toString().split("@");
         h5v1=Integer.parseInt(Arr5[0]);
         h5v2=Double.parseDouble(Arr5[1]);
        
      }
      else
      {
         h5v1=0;
         h5v2=0;
        
      }

      List6.delete(0,List6.length());
      //String List6=""+sstList.get(rs1.getString(1));
     List6.append(""+sstList.get(rs1.getString(1))); 
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
      List7.delete(0,List7.length());
   
   // String List7=""+mancntList.get(rs1.getString(1));
    List7.append(""+mancntList.get(rs1.getString(1)));
  //  System.out.println("List7 &&&&&&&&"+List7);
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
    <td class="rptValue"><%=rs1.getString(2)%></td>
    <td class="rptValue" align="right"><%=h7v1%></td>
    <td class="rptValue" align="right"><%=rs1.getString(3)%></td>
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
v14tot+=Double.parseDouble(rs1.getString(3));
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
     <td class=bText colspan=2>Total</td>
     <td class=bText align="right"><%=ndf.format(v16tot)%></td>
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

