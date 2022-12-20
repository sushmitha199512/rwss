<%@ include file = "/reports/conn.jsp" %>
<%@page import=" com.lowagie.text.Font"%>
 <%@ page contentType="text/html; charset=iso-8859-1" language="java"       import="java.sql.*,java.util.*,java.awt.Color, java.text.*, java.io.FileOutputStream, java.io.IOException,com.lowagie.text.*, com.lowagie.text.pdf.*, com.lowagie.text.pdf.PdfContentByte, com.lowagie.text.FontFactory.*" errorPage="" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<html>
<%
	String dc=request.getParameter("datecheck");
	//System.out.println("dcdcdcdcdcdcdcdcdc"+dc);
	String file="";
	Document document = new Document();
	DecimalFormat ndf = new DecimalFormat("####.00");
	String datew=(String)session.getAttribute("datew");
	String division=(String)session.getAttribute("division");
	String name=(String)session.getAttribute("name");
	String tname=(String)session.getAttribute("tname");
	String year=datew.substring(6,10);
	String day=datew.substring(0,2);
	//System.out.println("day"+day);
	String mon=datew.substring(3,5);
	//System.out.println("mon"+mon);

	String fname=""+day+""+mon+""+year+"preecedings.pdf";
	//System.out.println("fname"+fname);
file="C:\\Documents and Settings\\achuta\\IBM\\rationalsdp6.0\\workspace\\pred\\WebContent\\downloads\\precedings\\"+fname;
	//file="D:\\workspace\\pred\\WebContent\\downloads\\precedings\\"+fname;
   // file="d:\\"+fname;
	//System.out.println("filename ::::"+file);
		//System.out.println("name:::::::::::::"+name);
		//System.out.println("division:::::::::::::"+division);
	//System.out.println("dddddddddaaaaaaaaaaatttttteeeeeeee"+datew);
	Statement stmt1=conn.createStatement();
	Statement stmt2=conn.createStatement();
	Statement stmt3=conn.createStatement();
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
	String qry1="",qry2="",qry3="",qry4="";
	//String div="",cir="";
	int sno=1;
	double scta=0.0,stta=0.0,plainta=0.0;
	double scta1=0.0,stta1=0.0,plainta1=0.0,stot=0.0,stot1=0.0,stot2=0.0,stotnew=0.0,stotnew1=0.0,fftot3=0.0,fftot4=0.0,fftot=0.0,fftot1=0.0,fftot2=0.0;
	double a1=0.0,a2=0.0,a3=0.0;
	double ff=0.0,ff1=0.0,ff2=0.0,rt=0.0,trt=0.0,rt1=0.0,trt1=0.0;
	double sca=0.0,sta=0.0,plaina=0.0;
	double gsc=0.0,gst=0.0,gplain=0.0;
 PdfPCell cell =null;
   String div=(String)session.getAttribute("div");
   String cir=(String)session.getAttribute("cir");
   Font font3 = FontFactory.getFont("C:\\windows\\fonts\\verdanan.ttf",10, Font.NORMAL);
      Font font1 = FontFactory.getFont("C:\\windows\\fonts\\verdanan.ttf", 10, Font.BOLD);
	  Font font2 = FontFactory.getFont("C:\\windows\\fonts\\verdanan.ttf", 10, Font.UNDERLINE);
   	//System.out.println("div::::in pdf:::::::::"+div);
	//	System.out.println("cir:::::in pdf::::::::"+cir);
//int pdfno=1;
	//file="D:\\BankPreceedings"+pdfno+".pdf";
	//System.out.println("file:::in pdf::::::::"+file);
try{
//System.out.println("file:::in pdf:2222:::::::"+file);

	PdfWriter writer =PdfWriter.getInstance(document, new FileOutputStream(file));
	document.open();			
	Paragraph repHeader2 = new Paragraph("Procs. Of the Special Officer and Engineer-in-Chief (RWS&S) & Member Secretary",font1);
	repHeader2.setAlignment(Element.ALIGN_CENTER); 
	document.add(repHeader2);
	Paragraph repHeader3 = new Paragraph("(SWSM): Hyderabad",font1);
	repHeader3.setAlignment(Element.ALIGN_CENTER); 
	document.add(repHeader3);
	Paragraph repHeader4 = new Paragraph("Present: Sri  "+name,font1);
	repHeader4.setAlignment(Element.ALIGN_CENTER); 
	document.add(repHeader4);
		Paragraph repHeader5 = new Paragraph("Procs. No. BI(1)/  831 / 2011-12, Dated :"+datew,font2);
	repHeader5.setAlignment(Element.ALIGN_CENTER); 
	document.add(repHeader5);
	Paragraph repHeader100= new Paragraph("       ");
	repHeader100.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader100);
	Paragraph repHeader6 = new Paragraph("Sub:-RWS&S Budget – 2011-12 – NRDWP  – Distribution of funds through online banking system – Orders -  Issued.",font3);
	repHeader6.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader6);
	Paragraph repHeader7 = new Paragraph("Ref:-1. Bills uploaded by the Executive Engineers RWS&S in the State through Funds monitoring system (Watersoft).",font3);
	repHeader7.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader7);
	Paragraph repHeader8 = new Paragraph("******",font1);
	repHeader8.setAlignment(Element.ALIGN_CENTER); 
	document.add(repHeader8);
	Paragraph repHeader9 = new Paragraph("ORDER",font1);
	repHeader9.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader9);
	Paragraph repHeader10 = new Paragraph("Government of India has sanctioned and subsequently released the funds under National Rural Drinking Water Programme (NRDWP).",font3);
	repHeader10.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader10);
	Paragraph repHeader21 = new Paragraph("The Executive Engineers, RWS&S, in the state have uploaded the bills in Water Soft Monitoring System under NRDWP and forwarded by them to ENC office. Dully certifying that the forwarded bills are as per pass order.",font3);
	repHeader21.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader21);
	Paragraph repHeader22= new Paragraph(" The following amounts are hereby sanctioned and released work wise to incur the expenditure against the work for which the amount is now released.",font3);
	repHeader22.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader22);
	Paragraph repHeader23= new Paragraph("                              ");
	repHeader23.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader23);

 String qry="select distinct division_office_name,txid,txid_div,office_code,bill_amount_central,circle_office_code,division_office_code  from rws_bill_bank_settlement_tbl a,rws_complete_office_view v where substr (office_code,2,2) =v.circle_office_code and substr(office_code,4,1)=v.division_office_code and to_char (processed_start_date,'dd/mm/yyyy')='"+datew+"' and bill_activation_flag='P'";

 if(cir!=null && !cir.equals("") && div!=null && !div.equals(""))
 {
	 qry+= "  and  substr (office_code,2,2) ='"+cir+"' and  substr (office_code,4,1)='"+div+"' "; 
 }
qry+=" order by txid,circle_office_code,division_office_code ";

//System.out.println("qry111111in pdfffff:"+qry);
int count=0;
double gtot=0.0;
int count1=0;
	stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs=stmt.executeQuery(qry);
	rs.next();
	String gtid=rs.getString(2);
	String prevgtid="";
	Paragraph repHeader11 = new Paragraph("Group TransactionId :"+rs.getString(2),font1);
	repHeader11.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader11);

rs.previous();
while(rs.next())
{
	
	if(gtid.equals(rs.getString(2))){
	Paragraph repHeader12 = new Paragraph("Division: "+rs.getString(1)+"         TransactionId:"+rs.getString(3),font1);
	repHeader12.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader12);
	Paragraph repHeader77 = new Paragraph("       ");
	repHeader77.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader77);
	}else{
     if(!prevgtid.equals(rs.getString(2))){	
	Paragraph repHeader13 = new Paragraph("Group TransactionId: "+rs.getString(2),font1);
	repHeader13.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader13);
	Paragraph repHeader78 = new Paragraph("       ");
	repHeader78.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader78);
	 } else{}
	 Paragraph repHeader14 = new Paragraph("Division: "+rs.getString(1)+"            TransactionId:"+rs.getString(3),font1);
	repHeader14.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader14);
	Paragraph repHeader79 = new Paragraph("       ");
	repHeader79.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader79);
	}
	PdfPTable HeadingTable=new PdfPTable(10);
	HeadingTable.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		HeadingTable.addCell(new Paragraph("S.No",font1));
	HeadingTable.addCell(new Paragraph("Work Id",font1));
	HeadingTable.addCell(new Paragraph("Work Name",font1));
	HeadingTable.addCell(new Paragraph("Programme",font1));
	HeadingTable.addCell(new Paragraph("Sub Programme",font1));
	HeadingTable.addCell(new Paragraph("Bill No",font1));
	HeadingTable.addCell(new Paragraph("SC",font1));
	HeadingTable.addCell(new Paragraph("ST",font1));
	HeadingTable.addCell(new Paragraph("PLAIN",font1));
	HeadingTable.addCell(new Paragraph("Total",font1));
	document.add(HeadingTable);
double amt=0.0;
int hab=0,sc=0,st=0,plain=0;	
a1=0;
plaina=0;
a2=0;scta=0;
a3=0;stta=0;
stotnew=0;
stotnew1=0;
fftot3=0;
fftot4=0;
fftot=0;
fftot1=0;
fftot2=0;
plainta=0;

qry1="select a.work_id,work_name,bill_no,bill_amount_central,bill_activation_flag,c.subprogramme_code,s.subprogramme_name ,p.programme_name,no_of_habs from rws_bill_bank_bridge_det_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c,rws_subprogramme_tbl s ,rws_programme_tbl p where a.work_id=b.work_id and a.work_id=c.work_id and c.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no  and txid='"+rs.getString(2)+"'   and a.office_code='"+rs.getString(4)+"' and c.programme_code=s.programme_code and c.subprogramme_code=s.subprogramme_code and p.programme_code=c.programme_code  ";
//System.out.println("qqqq22pdfffffff:"+qry1);
rs1=stmt1.executeQuery(qry1);

while(rs1.next())
{
	//System.out.println("hhhhhhhhpdf::"+rs1.getInt(9));
	
	if(rs1.getInt(9)>1)
	{
		qry2="select count(hab_code) from RWS_EST_NEW_HAB_LNK_TBL  where work_id='"+rs1.getString(1)+"'";
	}
	else
	{
	    qry2="select count(hab_code) from rws_admn_hab_lnk_tbl  where work_id='"+rs1.getString(1)+"'";
	}
	//System.out.println("habpdf:"+qry2);
	rs2=stmt2.executeQuery(qry2);
	while(rs2.next())
	{
			//System.out.println("h111111111::"+rs2.getInt(1));
	if(rs2.getInt(1)>1)
	{
	qry3="select  sum(CENSUS_SC_POPU) , sum(CENSUS_ST_POPU) ,sum(CENSUS_PLAIN_POPU) from RWS_EST_NEW_HAB_LNK_TBL a, "+tname+" b   where work_id='"+rs1.getString(1)+"' and a.hab_code=b.hab_code";
//	System.out.println("pop:"+qry3);
	rs3=stmt3.executeQuery(qry3);
	while(rs3.next())
{
	
	PdfPTable DataTable=new PdfPTable(10);
	DataTable.addCell(""+sno++);
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(1),font3));
	DataTable.addCell(cell);
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(2),font3));
	DataTable.addCell(cell);
	//System.out.println("in else3"+rs1.getString(2));
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(8),font3));
	DataTable.addCell(cell);
	//System.out.println("in else4"+rs1.getString(8));
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(7),font3));
	DataTable.addCell(cell);
	//System.out.println("in else5"+rs1.getString(7));
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(3),font3));
	DataTable.addCell(cell);
		int totalp=rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
		//System.out.println("tpop:"+totalp);
		double billa=rs1.getDouble(4);
		//System.out.println("billa:"+billa);
		sca=billa*rs3.getInt(1)/totalp;
		sta=billa*rs3.getInt(2)/totalp;
		plaina=billa*rs3.getInt(3)/totalp;
		//System.out.println("sta:"+sta);
		stotnew=sca+sta+plaina;
		cell = new PdfPCell(new Paragraph(""+ndf.format(sca),font1));
		DataTable.addCell(cell);
		cell = new PdfPCell(new Paragraph(""+ndf.format(sta),font1));
		DataTable.addCell(cell);
		cell = new PdfPCell(new Paragraph(""+ndf.format(plaina),font1));
		DataTable.addCell(cell);
		cell = new PdfPCell(new Paragraph(""+ndf.format(stotnew),font1));
		DataTable.addCell(cell);
		document.add(DataTable);
	   
	amt+=rs1.getDouble(4);
	hab+=rs2.getDouble(1);
	scta+=sca;
	stta+=sta;
	//System.out.println("PP:::"+plaina);
	plainta+=plaina; 
	//System.out.println("PP22222:::"+plainta);
	stotnew1+=stotnew;
	//System.out.println("stotstotstostotnew1stotnew1stotnew1stotstot:"+stotnew1);
 }}else
	{
	 //System.out.println("rs 1 values:: in pdf: else part:::"+rs1.getString(6));
	stot=0;stot1=0;stot2=0;
	fftot=0;fftot1=0;fftot2=0;
//System.out.println("in else1");
PdfPTable DataTable=new PdfPTable(10);
	DataTable.addCell(""+sno++);
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(1),font3));
	DataTable.addCell(cell);
	//DataTable.addCell(rs1.getString(1));
	//System.out.println("in else2"+rs1.getString(1));
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(2),font3));
	DataTable.addCell(cell);

	//System.out.println("in else3"+rs1.getString(2));
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(8),font3));
	DataTable.addCell(cell);
	//System.out.println("in else4"+rs1.getString(8));
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(7),font3));
	DataTable.addCell(cell);
	//System.out.println("in else5"+rs1.getString(7));
	cell = new PdfPCell(new Paragraph("     "+rs1.getString(3),font3));
	DataTable.addCell(cell);
	//System.out.println("in else6"+rs1.getString(3));
//	System.out.println("in else7");
	//	System.out.println("rs 1 values:: in pdf::::"+rs1.getString(6));
	if(rs1.getString(6).equals("01") || rs1.getString(6).equals("05") || rs1.getString(6).equals("06"))
		{ 
		//System.out.println("in 01,05,06"); 
		ff=rs1.getDouble(4);
		ff1=0.0;
		ff2=0.0;
		cell = new PdfPCell(new Paragraph(""+ndf.format(ff1),font1));
		DataTable.addCell(cell);
		cell = new PdfPCell(new Paragraph(""+ndf.format(ff2),font1));
		DataTable.addCell(cell);
		cell = new PdfPCell(new Paragraph(""+ndf.format(ff),font1));
		DataTable.addCell(cell);
		fftot=ff1+ff2+ff;
		cell = new PdfPCell(new Paragraph(""+ndf.format(fftot),font1));
		DataTable.addCell(cell);
		//DataTable.addCell(ndf.format(fftot));
		}
		else if(rs1.getString(6).equals("02"))
		{
					//System.out.println("in 02");
		ff1=rs1.getDouble(4);
		ff=0.0;
		ff2=0.0;
		cell = new PdfPCell(new Paragraph(""+ndf.format(ff1),font1));
		DataTable.addCell(cell);
		cell = new PdfPCell(new Paragraph(""+ndf.format(ff),font1));
		DataTable.addCell(cell);
		cell = new PdfPCell(new Paragraph(""+ndf.format(ff2),font1));
		DataTable.addCell(cell);
		//DataTable.addCell(ndf.format(ff1));
		//DataTable.addCell(ndf.format(ff));
		//DataTable.addCell(ndf.format(ff2));
		//System.out.println("in else802"+ndf.format(ff1));
		//System.out.println("in else802"+ndf.format(ff));
		//System.out.println("in else802"+ndf.format(ff2));
		fftot1=ff1+ff2+ff;
		cell = new PdfPCell(new Paragraph(""+ndf.format(fftot1),font1));
	DataTable.addCell(cell);
		
			
	}else  if(rs1.getString(6).equals("03") || rs1.getString(6).equals("04"))
		{
			//	System.out.println("in 03,04");
		ff2=rs1.getDouble(4);
		ff1=0.0;
		ff=0.0;
cell = new PdfPCell(new Paragraph(""+ndf.format(ff1),font1));
		DataTable.addCell(cell);
		cell = new PdfPCell(new Paragraph(""+ndf.format(ff2),font1));
		DataTable.addCell(cell);
		cell = new PdfPCell(new Paragraph(""+ndf.format(ff),font1));
		DataTable.addCell(cell);
		//DataTable.addCell(ndf.format(ff1));
		//DataTable.addCell(ndf.format(ff2));
		//DataTable.addCell(ndf.format(ff));
		//System.out.println("in else803"+ndf.format(ff1));
		//System.out.println("in else803"+ndf.format(ff));
		//System.out.println("in else803"+ndf.format(ff2));
		fftot2=ff1+ff2+ff;
		cell = new PdfPCell(new Paragraph(""+ndf.format(fftot2),font1));
		DataTable.addCell(cell);
		//DataTable.addCell(ndf.format(fftot2));
		}
		document.add(DataTable);
	amt+=rs1.getDouble(4);
	hab+=rs2.getDouble(1);
	a1+=fftot;
	//System.out.println("sreeeeee11111>>>>>>>"+a1);
	a2+=ff1;
	a3+=ff2;
	fftot3=a1+a2+a3;
	//System.out.println("fftotfftotfftotfftotfftot233333333fftot"+fftot3);
	}}} 
	sno=1;
		if(a1==0.0)
	{stot=plainta;
	}
else{
	stot+=a1+plainta;
}
	stot1=a2+scta;
	stot2=a3+stta;
	fftot4=stotnew1+fftot3;
	gsc+=stot1;
	gst+= stot2;
	gplain+=stot;
	
	PdfPTable DataTable=new PdfPTable(10);
	DataTable.addCell("");
	DataTable.addCell("");
	DataTable.addCell("");
	DataTable.addCell("");
	DataTable.addCell("");
	DataTable.addCell(new Paragraph("Totals",font1));
	cell = new PdfPCell(new Paragraph(""+ndf.format(stot1),font1));
	DataTable.addCell(cell);
	cell = new PdfPCell(new Paragraph(""+ndf.format(stot2),font1));
	DataTable.addCell(cell);
	cell = new PdfPCell(new Paragraph(""+ndf.format(stot),font1));
	DataTable.addCell(cell);
	cell = new PdfPCell(new Paragraph(""+ndf.format(fftot4),font1));
	DataTable.addCell(cell);
	
	document.add(DataTable);
	gtot=gtot+amt;	
		prevgtid=rs.getString(2);
}
PdfPTable DataTable=new PdfPTable(10);
	DataTable.addCell("");
	DataTable.addCell("");
	DataTable.addCell("");
	DataTable.addCell("");
	DataTable.addCell("");
	DataTable.addCell(new Paragraph("Grand Totals",font1));
	cell = new PdfPCell(new Paragraph(""+ndf.format(gsc),font1));
	DataTable.addCell(cell);
	cell = new PdfPCell(new Paragraph(""+ndf.format(gst),font1));
	DataTable.addCell(cell);
	cell = new PdfPCell(new Paragraph(""+ndf.format(gplain),font1));
	DataTable.addCell(cell);
	cell = new PdfPCell(new Paragraph(""+ndf.format(gtot),font1));
	DataTable.addCell(cell);
	
	document.add(DataTable);
	Paragraph repHeader102 = new Paragraph("       ");
	repHeader102.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader102);
	Paragraph repHeader24= new Paragraph(" The Executive Engineers, RWS&S, in the state are directed to debit the expenditure strictly in accordance with the pending bills uploaded in Water Soft by them earlier and instructions issued by the Chairman (SWSM) and Prl Secretary to Government (RWS&S), duly following the guidelines of NRDWP.",font3);
	repHeader24.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader24);
	Paragraph repHeader101 = new Paragraph("       ");
	repHeader101.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader101);
	Paragraph repHeader25= new Paragraph(" Further the Executive Engineers, RWS&S, in the state are also directed to upload the voucher wise details in the Water Soft fund monitoring system within a week.",font3);
	repHeader25.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader25);
	Paragraph repHeader33 = new Paragraph("       ");
	repHeader33.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader33);
	Paragraph repHeader26= new Paragraph("The releases are made subject to the following conditions",font2);
	repHeader26.setAlignment(Element.ALIGN_CENTER); 
	document.add(repHeader26);
	Paragraph repHeader34 = new Paragraph("       ");
	repHeader34.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader34);
	Paragraph repHeader27= new Paragraph("*		The funds are released dully earmarking SCP and TSP as per the guide lines of Govt .of India.",font1);
	repHeader27.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader27);
	Paragraph repHeader28= new Paragraph("*		Hence they should utilize the amount now released strictly to the respective subprogrammes only									                        i.e. SCP and ST.",font1);
	repHeader28.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader28);
	Paragraph repHeader29= new Paragraph("*		The diversion of funds from one sub programme to another sub programme will not be entertained									                     at any cost. If any noticed it will be viewed seriously.  ",font1);
	repHeader29.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader29);
	Paragraph repHeader30= new Paragraph("*		Regarding Spill over works payment shall not exceed the spillover estimate cost approved by the									                        Government. ",font1);
	repHeader30.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader30);
	Paragraph repHeader31= new Paragraph("*		All the Grants now released and previous balance if any grant be  Expended in a week and entered in									                the Water Soft failing which the unspent balances available as per Water Soft will be Surrendered back.",font1);
	repHeader31.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader31);
	Paragraph repHeader32= new Paragraph("*		The payment shall be made as per the guidelines of NRDWP, GOI only ",font1);
	repHeader32.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader32);
	Paragraph repHeader35= new Paragraph("*		The payment shall not exceed Administrative Sanction amount in any case.",font1);
	repHeader35.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader35);
	Paragraph repHeader36= new Paragraph("*		Payments shall not be made to those works which are not having Work ID in MIS.",font1);
	repHeader36.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader36);
	Paragraph repHeader37= new Paragraph("*		The payment shall not be made without EOAT on the date of passing of the bill.",font1);
	repHeader37.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader37);
	Paragraph repHeader38= new Paragraph("*		The Expenditure incurred should be clearly classified SubProgramme wise such as Coverage, Quality,									               Sustainability,O&M, DDP, Calamities, SCP,TSP,NTSP, etc.",font1);
	repHeader38.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader38);
	Paragraph repHeader39= new Paragraph("      ");
	repHeader39.setAlignment(Element.ALIGN_RIGHT); 
	document.add(repHeader39);
		Paragraph repHeader49= new Paragraph("      ");
	repHeader49.setAlignment(Element.ALIGN_RIGHT); 
	document.add(repHeader49);
	Paragraph repHeader40= new Paragraph("       Special officer & Engineer-in-Chief (RWS&S) &",font3);
	repHeader40.setAlignment(Element.ALIGN_RIGHT); 
	document.add(repHeader40);
	Paragraph repHeader41= new Paragraph("                                                                                                               Member secretary (SWSM): Hyderabad",font3);
	repHeader41.setAlignment(Element.ALIGN_CENTER); 
	document.add(repHeader41);
	Paragraph repHeader42= new Paragraph("       ");
	repHeader42.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader42);
	Paragraph repHeader43= new Paragraph("             TO ",font1);
	repHeader43.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader43);
	Paragraph repHeader44= new Paragraph("             All the Executive Engineers, RWS&S, in the state ",font3);
	repHeader44.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader44);
	Paragraph repHeader45= new Paragraph("            Copy to Chief Engineer NRDWP Normal ",font3);
	repHeader45.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader45);
	Paragraph repHeader46= new Paragraph("            Copy to all the Superintending Engineers, RWS&S, in the state ",font3);
	repHeader46.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader46);
	Paragraph repHeader47= new Paragraph("            Copy to MIS Section of this office ",font3);
	repHeader47.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader47);
	Paragraph repHeader48= new Paragraph("            Copy to S/F  ",font3);
	repHeader48.setAlignment(Element.ALIGN_LEFT); 
	document.add(repHeader48);
}

catch(Exception e)
	{	System.out.println("Excetion.."+e.getMessage());
	}

	document.close();

	Statement stmt=conn.createStatement();Statement stmtcheck=conn.createStatement();
	ResultSet rs=null;
//	System.out.println("file:::"+file);
	String qrycheck="select * from rws_precedings_tbl  where FILE_NAME ='"+file+"' ";
//	System.out.println("qrycheck:::"+qrycheck);
	rs=stmtcheck.executeQuery(qrycheck);
	if(rs.next())
	{%>
		<script>
		var file='<%=file%>'
		alert("PDF file Already Generated");
		self.close();
		</script>
		<%}else{
	String qryp="insert into rws_precedings_tbl  values('"+file+"',sysdate)";
	//System.out.println("qqq:::"+qryp);
	stmt.executeQuery(qryp);%>
			<script>

			var file='<%=file%>'
					//alert(file);
			alert("PDF file is genarated at your  location with filename "+file);
			self.close();
			</script><%
}
%>







	
   
	