<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "base line survey school&anganwadi abstract.xls");

%>

<script language="JavaScript">
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
<form>
<%
String dcode=String.valueOf(session.getAttribute("dcode"));
//System.out.println("dcode**********" +dcode);
String mcode=request.getParameter("mandal");
session.setAttribute("mcode",mcode);

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();


    int styleCount=0;
    String style="";

   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="90%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	</tr>  
	</table>
	</caption>
	
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr >
	<td align="center" class=gridhdbg colspan=8> Base Line Survey Schools & Anganwadi - Abstract Report</td>
	</tr>
	
	<tr>
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=1 colspan="3" align="center">SCHOOLS Details</td>
    <td class=gridhdbg rowspan=1 colspan="3" align="center">ANGANWADI Details</td>
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

	
			
//main qry starts here ... the district name is displaed from here

Statement stmt3=null,stmt4=null;
ResultSet rs3=null,rs4=null;

int sno=1;
%>

<%


Hashtable schoolcount0_hash=(Hashtable)session.getAttribute("schoolcount0_hash");
Hashtable schoolcount1_hash=(Hashtable)session.getAttribute("schoolcount1_hash");
Hashtable schoolcount2_hash=(Hashtable)session.getAttribute("schoolcount2_hash");
Hashtable angancount3_hash=(Hashtable)session.getAttribute("angancount3_hash");
Hashtable angancount4_hash=(Hashtable)session.getAttribute("angancount4_hash");
Hashtable angancount5_hash=(Hashtable)session.getAttribute("angancount5_hash");



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
//System.out.println("cpount***********"+ss0);
//System.out.println("cpount***********"+s0+" "+rs4.getString(1));

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
//System.out.println("cpount***********"+ss1);
//System.out.println("cpount***********"+s1+" "+rs4.getString(1));

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
//System.out.println("cpount***********"+ss2);
//System.out.println("cpount***********"+s2+" "+rs4.getString(1));



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
//System.out.println("cpount***********"+ss3);
//System.out.println("cpount***********"+s3+" "+rs4.getString(1));


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
//System.out.println("cpount***********"+ss4);
//System.out.println("cpount***********"+s4+" "+rs4.getString(1));


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
//System.out.println("cpount***********"+ss5);
//System.out.println("cpount***********"+s4+" "+rs4.getString(1));






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
<td  class="<%=style%>" style="text-align: right;"> <%=ss0%></td>
<td  class="<%=style%>" style="text-align: right;"> <%=ss1%></td>
<td  class="<%=style%>" style="text-align: right;"> <%=ss2%></td>
<td  class="<%=style%>" style="text-align: right;"> <%=ss3%></td>
<td  class="<%=style%>" style="text-align: right;"> <%=ss4%></td>
<td  class="<%=style%>" style="text-align: right;"> <%=ss5%></td>

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




    