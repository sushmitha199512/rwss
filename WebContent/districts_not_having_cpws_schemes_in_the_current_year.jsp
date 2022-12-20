<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<SCRIPT LANGUAGE="JavaScript">

function winClose()
{
	location.href="/pred/home.do";
}


</SCRIPT>
</head>


<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">

<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" >


<form>

<table cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
<caption>


<table   rules=none style="border-collapse:collapse" align = "right">
<td  align=right>
<a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;&nbsp;
</td>	

<!-- 
 <td>		
  <a href="#" onClick="window.close();">Close</a>
</td>
-->  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		
		<td align="center" class="gridhdbg " > <b>Districts without works</b> </td>
		
</tr>


</table>


<table     width="80%" border=1 style="border-collapse:collapse" ALIGN=CENTER >
<tr align=center>
<td class=gridhdbg   > <b> Sl No.  </b> </td>
<%
String a1="";
//a1=request.getParameter("abc");
//System.out.println("a1******"+a1);
if(a1.equals("7") || a1.equals("8")){ %>
<td class=gridhdbg   > <b> Habitations not linked with CPWS Schemes   </b> </td>
<td class=gridhdbg   > <b> Email-Address </b> </td>
<%}
if(a1.equals("1") ){ %>

<td class=gridhdbg   > <b> <b> Circle  </b>  </b> </td>
<td class=gridhdbg   > <b> User-Id   </b> </td>
<td class=gridhdbg   > <b> Email-Address </b> </td>

<%} 
if(a1.equals("3") || a1.equals("4")){ %>
<td class=gridhdbg   > <b> Circle    </b> </td>
<td class=gridhdbg   > <b> <b> Division  </b>  </b> </td>
<td class=gridhdbg   > <b> User-Id   </b> </td>
<td class=gridhdbg   > <b> Email-Address </b> </td>

<%}
if(a1.equals("5") || a1.equals("6")){ %>
<td class=gridhdbg   > <b> Circle </br>   </b> </td>
<td class=gridhdbg   > <b> <b> Division  </b>  </b> </td>
<td class=gridhdbg   > <b> <b> SubDivision  </b>  </b> </td>
<td class=gridhdbg   > <b> User-Id   </b> </td>
<td class=gridhdbg   > <b> Email-Address </b> </td>

<%} %>






  </tr>

	<%try
      { 
		//
		String cir="";
		String div="";
		String panch="select circle_office_code,circle_office_name from rws_circle_office_tbl ";
		Statement stmt99=conn.createStatement();
//		//System.out.println("panchlatitude:"+panch);
		ResultSet rs99=stmt99.executeQuery(panch);
		Hashtable panchh=new Hashtable();
		while(rs99.next())
		{
		panchh.put(rs99.getString(1),rs99.getString(2));
		}

//
       if(stmt99!=null)
		stmt99.close();
		if(rs99!=null)
        rs99.close();

		//
		String panch1="select circle_office_code,division_office_code,division_office_name from rws_division_office_tbl ";
		Statement stmt999=conn.createStatement();
//		//System.out.println("panchlatitude:"+panch);
		ResultSet rs999=stmt999.executeQuery(panch1);
		Hashtable panchhh=new Hashtable();
		while(rs999.next())
		{
		panchhh.put(rs999.getString(1)+rs999.getString(2),rs999.getString(3));
		}

//
       if(stmt999!=null)
		stmt999.close();
		if(rs999!=null)
        rs999.close();

		//
	   int count=1;
          
       Statement stmt3=null;
       ResultSet rs3=null;
      
      stmt3=conn.createStatement();
      
      
   

String query="";

if(a1.equals("1"))
{
	
	query="select u.user_id,c.circle_office_code,c.circle_office_name,email_id from rws_circle_office_tbl c,rws_password_tbl u where substr(u.user_id,4,3)='000' and email_id is not null and substr(u.user_id,2,2)=c.circle_office_code order by u.user_id,c.circle_office_code"; 

}
if(a1.equals("2"))
{
	query="select u.user_id,c.circle_office_code,c.circle_office_name,nvl(email_id,'-') from rws_circle_office_tbl c,rws_password_tbl u where   substr(u.user_id,4,3)='000' and  email_id is null and substr(u.user_id,2,2)=c.circle_office_code order by u.user_id,c.circle_office_code";
}
if(a1.equals("3"))
{
	query="select a.user_id,b.division_office_code,b.division_office_name,email_id,substr(a.user_id,2,2) from rws_password_tbl a, rws_division_office_tbl b where  substr(a.user_id,2,2)=b.circle_office_code and substr(a.user_id,4,1)=b.division_office_code and email_id is not null and substr(a.user_id,5,2) in('00','AO','EE') and b.status !='UI' order by a.user_id,b.circle_office_code,b.division_office_code"; 

}
if(a1.equals("4"))
{
	query="select a.user_id,b.division_office_code,b.division_office_name,nvl(email_id,'-'),substr(a.user_id,2,2) from rws_password_tbl a, rws_division_office_tbl b where  substr(a.user_id,2,2)=b.circle_office_code and substr(a.user_id,4,1)=b.division_office_code and email_id is  null and substr(a.user_id,5,2) in('00','AO','EE') and b.status !='UI'  order by a.user_id,b.circle_office_code,b.division_office_code"; 

}
if(a1.equals("5"))
{
	query="select u.user_id,sd.subdivision_office_code,sd.subdivision_office_name,email_id,substr(u.user_id,2,2),substr(u.user_id,4,1) from  rws_password_tbl u,rws_subdivision_office_tbl sd where substr(u.user_id,2,2)=sd.circle_office_code  and substr(u.office_code,4,1)=sd.division_office_code and substr(u.user_id,5,2)=sd.subdivision_office_code and  email_id is not null  order by u.user_id,sd.circle_office_code,sd.division_office_code,sd.SUBDIVISION_OFFICE_CODE"; 

}
if(a1.equals("6"))
{
	query="select u.user_id,sd.subdivision_office_code,sd.subdivision_office_name,nvl(email_id,'-'),substr(u.user_id,2,2),substr(u.user_id,4,1) from  rws_password_tbl u,rws_subdivision_office_tbl sd where substr(u.user_id,2,2)=sd.circle_office_code and  email_id is  null and substr(u.office_code,4,1)=sd.division_office_code and substr(u.user_id,5,2)=sd.subdivision_office_code  order by u.user_id,sd.circle_office_code,sd.division_office_code,sd.SUBDIVISION_OFFICE_CODE"; 

}

if(a1.equals("7"))
{
	query="select user_id,user_id,user_id,email_id  from rws_password_tbl where user_id in('secrwss','admin','100000','aprwssp','cerwss','1000DR') and email_id is not null"; 

}
if(a1.equals("8"))
{
	query="select user_id,user_id,user_id,nvl(email_id,'-')  from rws_password_tbl where user_id in('secrwss','admin','100000','aprwssp','cerwss','1000DR') and email_id is null"; 

}

//System.out.println("query********"+query);

rs3=stmt3.executeQuery(query);
int count1=0;
int styleCount=0;
String style="";
while(rs3.next())
{
	count1++;
	if(a1.equals("3") || a1.equals("4"))
	{	
	cir=(String)panchh.get(rs3.getString(5));
	//System.out.println(""+cir);
	if(cir!=null && !cir.equals(""))
	{
		
	}
	else
	{
		cir="-";
	}
	}
	String cir1="";
	if(a1.equals("5") || a1.equals("6"))
	{	
		
	div=(String)panchhh.get(rs3.getString(5)+rs3.getString(6));
	//System.out.println(""+div);
	cir1=(String)panchh.get(rs3.getString(5));
	if(cir1!=null && !cir1.equals(""))
	{
		
	}
	else
	{
		cir1="_";
	}
	if(div!=null && !div.equals(""))
	{
		
	}
	else
	{
		div="-";
	}
	}

	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
			
%>

<tr>
<td class=<%=style %> align=center ><%=count++ %></td>
<%

if(a1.equals("3") || a1.equals("4")){%>
<td class=<%=style %> style="text-align: left"><%=cir%></td>
<td class=<%=style %> style="text-align: left"><%=rs3.getString(3) %></td>

<td class=<%=style %> style="text-align: left" ><%=rs3.getString(1) %></td>

<td class=<%=style %> style="text-align: left"><%=rs3.getString(4) %></td>

<%}
 if(a1.equals("5") || a1.equals("6")){%>  
<td class=<%=style %> style="text-align: left"><%=cir1%></td>
<td class=<%=style %> style="text-align: left"><%=div%></td>
<td class=<%=style %> style="text-align: left"><%=rs3.getString(3) %></td>

<td class=<%=style %> style="text-align: left" ><%=rs3.getString(1) %></td>

<td class=<%=style %> style="text-align: left"><%=rs3.getString(4) %></td>

<%}
 if(a1.equals("1") || a1.equals("2")){ %>
<td class=<%=style %> style="text-align: left"><%=rs3.getString(3) %> </td>
<td class=<%=style %> style="text-align: left" ><%=rs3.getString(1) %></td>

<td class=<%=style %> style="text-align: left"><%=rs3.getString(4) %></td>

<%} 
if(a1.equals("7") || a1.equals("8")){%>
<td class=<%=style %> style="text-align: left" ><%=rs3.getString(1) %></td>

<td class=<%=style %> style="text-align: left"><%=rs3.getString(4) %></td>
<%} %>



</tr>
<% 


}

if(count1 < 0)
{
%>

<tr align="center">
<td>No Records</td>
</tr>
<%}
}

    
	catch(Exception e)
    {
    e.printStackTrace();
    } 
	%>
	
	
</table>
<center>
<%@ include file = "/commons/rws_footer.jsp" %>

	</center>
</form>
</body>
