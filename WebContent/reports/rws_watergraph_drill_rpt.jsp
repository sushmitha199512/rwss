<%@ include file="/commons/rws_header1.jsp"%>
    String testname="";
    String sname="";
    String dname="";
    

   if(testcode.equals("1"))
   {
    testname="PHYSICO-CHEMICAL";
   }
   else if(testcode.equals("2"))
   {
    testname="BACT - AT LAB";
   }
     {
     sname="ALL";
     }
     else
     {
     sname=""+dname;
     }
   
     <td class=btext  nowrap>Lab</td>
Statement	stmt8=conn.createStatement();
    <td class="rptValue"><%=rs8.getString(3)%></td> 