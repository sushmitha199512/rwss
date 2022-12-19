package nic.watersoft.BaseLineSurvey;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.works.tenderMemo;

/**
 * 
 * @author N SREE LAXMI DEVI
 *
 */
public class BaseLineMasterData {
	Connection conn = null;

	Statement stmt = null;

	Statement stmt1 = null;

	Statement stmt2 = null;

	Statement stmt3 = null;

	Statement stmt4 = null;

	Statement stmt5 = null;

	Statement stmt6 = null;

	Statement stmt7 = null;

	Statement stmt8 = null;

	Statement stmt9 = null;

	Statement stmt10 = null;

	Statement stmt11 = null;

	Statement stmt12 = null;

	Statement stmt13 = null;

	Statement stmt14 = null;

	Statement stmt15 = null;

	Statement stmt16 = null;

	Statement stmt17 = null;

	Statement stmt18 = null;

	Statement stmt19 = null;

	Statement stmt20 = null;

	Statement stmt21 = null;

	Statement stmt22 = null;

	Statement stmt23 = null;

	Statement stmt24 = null;

	ResultSet rs = null;

	ResultSet rset = null;

	ResultSet rs1 = null;

	ResultSet rs2 = null;

	ResultSet rs3 = null;

	ResultSet rs4 = null;

	ResultSet rs5 = null;

	ResultSet rs6 = null;

	ResultSet rs7 = null;

	ResultSet rs8 = null;

	ResultSet rs9 = null;

	ResultSet rs10 = null;

	ResultSet rs11 = null;

	ResultSet rs12 = null;

	ResultSet rs13 = null;

	ResultSet rs14 = null;

	ResultSet rs15 = null;

	ResultSet rs16 = null;

	ResultSet rs17 = null;

	ResultSet rs18 = null;

	ResultSet rs19 = null;

	ResultSet rs20 = null;

	ResultSet rs21 = null;

	ResultSet rs22 = null;

	ResultSet rs23 = null;

	ResultSet rs24 = null;

	int connCount = 0;

	PreparedStatement ps = null;

	public BaseLineMasterData() {
	}

	public void closeAll() throws Exception {
		Connection conn = null;
		Statement stmt = null;
		Statement stmt1 = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		Statement stmt4 = null;
		Statement stmt5 = null;
		Statement stmt6 = null;
		Statement stmt7 = null;
		Statement stmt8 = null;
		Statement stmt9 = null;
		Statement stmt10 = null;
		Statement stmt11 = null;
		Statement stmt12 = null;
		Statement stmt13 = null;
		Statement stmt14 = null;
		Statement stmt15 = null;
		Statement stmt16 = null;
		Statement stmt17 = null;
		Statement stmt18 = null;
		Statement stmt19 = null;
		Statement stmt20 = null;
		Statement stmt21 = null;
		Statement stmt22 = null;
		Statement stmt23 = null;
		Statement stmt24 = null;
		ResultSet rs = null;
		ResultSet rset = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rs6 = null;
		ResultSet rs7 = null;
		ResultSet rs8 = null;
		ResultSet rs9 = null;
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		ResultSet rs13 = null;
		ResultSet rs14 = null;
		ResultSet rs15 = null;
		ResultSet rs16 = null;
		ResultSet rs17 = null;
		ResultSet rs18 = null;
		ResultSet rs19 = null;
		ResultSet rs20 = null;
		ResultSet rs21 = null;
		ResultSet rs22 = null;
		ResultSet rs23 = null;
		ResultSet rs24 = null;
		int connCount = 0;
		PreparedStatement ps = null;

		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs5 = null;
		}
		if (rs6 != null) {
			try {
				rs6.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs6 = null;
		}
		if (rs7 != null) {
			try {
				rs7.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs7 = null;
		}
		if (rs8 != null) {
			try {
				rs8.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs8 = null;
		}
		if (rs9 != null) {
			try {
				rs9.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs9 = null;
		}
		if (rs10 != null) {
			try {
				rs10.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs10 = null;
		}
		if (rs11 != null) {
			try {
				rs11.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs11 = null;
		}
		if (rs12 != null) {
			try {
				rs12.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs12 = null;
		}
		if (rs13 != null) {
			try {
				rs13.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs13 = null;
		}
		if (rs14 != null) {
			try {
				rs14.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs14 = null;
		}
		if (rs15 != null) {
			try {
				rs15.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs15 = null;
		}
		if (rs16 != null) {
			try {
				rs16.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs16 = null;
		}
		if (rs17 != null) {
			try {
				rs17.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs17 = null;
		}
		if (rs18 != null) {
			try {
				rs18.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs18 = null;
		}
		if (rs19 != null) {
			try {
				rs19.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs19 = null;
		}
		if (rs20 != null) {
			try {
				rs20.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs20 = null;
		}
		if (rs21 != null) {
			try {
				rs21.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs21 = null;
		}
		if (rs22 != null) {
			try {
				rs22.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs22 = null;
		}
		if (rs23 != null) {
			try {
				rs23.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs23 = null;
		}
		if (rs24 != null) {
			try {
				rs24.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rs24 = null;
		}
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				Debug.println("The error in BaseLineMaster" + e);
			}
			rset = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (stmt5 != null) {
			try {
				stmt5.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt5 = null;
		}
		if (stmt6 != null) {
			try {
				stmt6.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt6 = null;
		}
		if (stmt7 != null) {
			try {
				stmt7.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt7 = null;
		}
		if (stmt8 != null) {
			try {
				stmt8.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt8 = null;
		}
		if (stmt9 != null) {
			try {
				stmt9.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt9 = null;
		}
		if (stmt10 != null) {
			try {
				stmt10.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt10 = null;
		}
		if (stmt11 != null) {
			try {
				stmt11.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt11 = null;
		}
		if (stmt12 != null) {
			try {
				stmt12.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt12 = null;
		}
		if (stmt13 != null) {
			try {
				stmt13.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt13 = null;
		}
		if (stmt14 != null) {
			try {
				stmt14.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt14 = null;
		}
		if (stmt15 != null) {
			try {
				stmt15.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt15 = null;
		}
		if (stmt16 != null) {
			try {
				stmt16.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt16 = null;
		}
		if (stmt17 != null) {
			try {
				stmt17.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt17 = null;
		}
		if (stmt18 != null) {
			try {
				stmt18.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt18 = null;
		}
		if (stmt19 != null) {
			try {
				stmt19.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt19 = null;
		}
		if (stmt20 != null) {
			try {
				stmt20.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt20 = null;
		}
		if (stmt21 != null) {
			try {
				stmt21.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt21 = null;
		}
		if (stmt22 != null) {
			try {
				stmt22.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt22 = null;
		}
		if (stmt23 != null) {
			try {
				stmt23.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt23 = null;
		}
		if (stmt24 != null) {
			try {
				stmt24.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt24 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}
	}
	
	//Added
	public ArrayList getDistricts(DataSource dataSource)
	throws Exception {
ArrayList districts;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
districts = new ArrayList();
PreparedStatement ps=null;

try {

	baselineMasterData.conn = RwsOffices.getConn();
	
	query = "select  d.dcode,d.dname from rws_district_tbl d where dcode<>'16' order by d.dname";
    ps=baselineMasterData.conn.prepareStatement(query);
	
	baselineMasterData.rs=ps.executeQuery();
	
	Debug.println("Query*********" + query);
	while (baselineMasterData.rs.next()) {
		baselineForm = new LabelValueBean();
		baselineForm.setValue(baselineMasterData.rs.getString(1));
		baselineForm.setLabel(baselineMasterData.rs.getString(2));
		baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
				+ " - " + baselineMasterData.rs.getString(1));
		districts.add(baselineForm);
	}

} catch (Exception e) {
	Debug.println("The error in getBaseLineMasters=" + e);
	e.printStackTrace();
} finally {
	baselineMasterData.closeAll();

}
return districts;
}
	
	//
	public ArrayList getDistricts1(DataSource dataSource)
	throws Exception {
ArrayList districts;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
districts = new ArrayList();
PreparedStatement ps=null;

try {

	baselineMasterData.conn = RwsOffices.getConn();
	
	query = "select  d.dcode,d.dname from rws_district_tbl d where dcode<>'16' order by d.dname";
    ps=baselineMasterData.conn.prepareStatement(query);
	
	baselineMasterData.rs=ps.executeQuery();
	
	Debug.println("Query*********" + query);
	while (baselineMasterData.rs.next()) {
		baselineForm = new LabelValueBean();
		baselineForm.setValue(baselineMasterData.rs.getString(1));
		baselineForm.setLabel(baselineMasterData.rs.getString(2));
		baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
				+ " - " + baselineMasterData.rs.getString(1));
		districts.add(baselineForm);
	}

} catch (Exception e) {
	Debug.println("The error in getBaseLineMasters=" + e);
	e.printStackTrace();
} finally {
	baselineMasterData.closeAll();

}
return districts;
}

	//




//
public ArrayList getMandals(DataSource dataSource,String dcode)
throws Exception {
ArrayList mandals;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
mandals = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct mcode,mname from rws_mandal_tbl ,RWS_BLS_GOVTBLDG_INGP_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and dcode='"+dcode+"' order by mname";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in mandals*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
			+ " - " + baselineMasterData.rs.getString(1));
	mandals.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return mandals;
}
//
public ArrayList getMandalsgovt(DataSource dataSource,String dcode)
throws Exception {
ArrayList mandals;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
mandals = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct a.mcode,a.mname from rws_mandal_tbl  a,rws_complete_hab_view b where substr(b.panch_code,1,2)=a.dcode and substr(b.panch_code,6,2)=a.mcode and  a.dcode='"+dcode+"' order by a.mname";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in mandals*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
			+ " - " + baselineMasterData.rs.getString(1));
	mandals.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return mandals;
}

//
public ArrayList getMandals1(DataSource dataSource,String dcode)
throws Exception {
ArrayList mandals;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
mandals = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct mcode,mname from rws_mandal_tbl ,RWS_BLS_vwm_COMM_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and dcode='"+dcode+"' order by mname";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in mandals*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
			+ " - " + baselineMasterData.rs.getString(1));
	mandals.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return mandals;
}

//

public ArrayList getPanchayats(DataSource dataSource,String dcode,String mcode)
throws Exception {
ArrayList panchayats;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
panchayats = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct pcode,pname from rws_panchayat_tbl,RWS_BLS_GOVTBLDG_INGP_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and substr(habitation_code,13,2)=pcode and dcode='"+dcode+"' and mcode='"+mcode+"'";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in panchayats*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
			+ " - " + baselineMasterData.rs.getString(1));
	panchayats.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return panchayats;
}
//
public ArrayList getPanchayats1(DataSource dataSource,String dcode,String mcode)
throws Exception {
ArrayList panchayats;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
panchayats = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct pcode,pname from rws_panchayat_tbl,rws_bls_vwm_comm_tbl b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and substr(habitation_code,13,2)=pcode and dcode='"+dcode+"' and mcode='"+mcode+"'";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in panchayats*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
			+ " - " + baselineMasterData.rs.getString(1));
	panchayats.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return panchayats;
}

//
public ArrayList getPanchayatsgovt(DataSource dataSource,String dcode,String mcode)
throws Exception {
ArrayList panchayats;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
panchayats = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct a.pcode,a.pname from rws_panchayat_tbl a,rws_complete_hab_view b where substr(b.panch_code,1,2)=a.dcode and substr(b.panch_code,6,2)=a.mcode and substr(b.panch_code,13,2)=a.pcode and a.dcode='"+dcode+"' and a.mcode='"+mcode+"'";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in panchayats*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
			+ " - " + baselineMasterData.rs.getString(1));
	panchayats.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return panchayats;
}

//
public ArrayList getVillages(DataSource dataSource,String dcode,String mcode,String pcode)
throws Exception {
ArrayList villages;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
villages = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct vcode,vname from rws_village_tbl ,RWS_BLS_GOVTBLDG_INGP_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and substr(habitation_code,13,2)=pcode and substr(habitation_code,8,3)=vcode and dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"'";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in villages*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
			+ " - " + baselineMasterData.rs.getString(1));
	villages.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return villages;
}
//
public ArrayList getVillagesgovt(DataSource dataSource,String dcode,String mcode,String pcode)
throws Exception {
ArrayList villages;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
villages = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct a.vcode,a.vname from rws_village_tbl a,rws_complete_hab_view b where substr(b.panch_code,1,2)=a.dcode and substr(b.panch_code,6,2)=a.mcode and substr(b.panch_code,13,2)=a.pcode and substr(b.panch_code,8,3)=a.vcode and a.dcode='"+dcode+"' and a.mcode='"+mcode+"' and a.pcode='"+pcode+"'";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in villages*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
			+ " - " + baselineMasterData.rs.getString(1));
	villages.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return villages;
}

//
public ArrayList getHabs(DataSource dataSource,String dcode,String mcode,String pcode,String vcode)
throws Exception {
ArrayList habs;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
habs = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct panch_code,panch_name from rws_complete_hab_view b where substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+mcode+"' and substr(panch_code,13,2)='"+pcode+"' and substr(panch_code,8,3)='"+vcode+"'";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in villages*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(1)
			+ " - " + baselineMasterData.rs.getString(2));
	habs.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return habs;
}
//
public ArrayList getVillages1(DataSource dataSource,String dcode,String mcode,String pcode)
throws Exception {
ArrayList villages;
String query="";
BaseLineMasterData baselineMasterData = new BaseLineMasterData();
LabelValueBean baselineForm = null;
villages = new ArrayList();
PreparedStatement ps=null;

try {

baselineMasterData.conn = RwsOffices.getConn();

query = "select  distinct vcode,vname from rws_village_tbl ,RWS_BLS_vwm_comm_TBL b where substr(habitation_code,1,2)=dcode and substr(habitation_code,6,2)=mcode and substr(habitation_code,13,2)=pcode and substr(habitation_code,8,3)=vcode and dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"'";
ps=baselineMasterData.conn.prepareStatement(query);

baselineMasterData.rs=ps.executeQuery();

Debug.println("Query in villages*********" + query);
while (baselineMasterData.rs.next()) {
	baselineForm = new LabelValueBean();
	baselineForm.setValue(baselineMasterData.rs.getString(1));
	baselineForm.setLabel(baselineMasterData.rs.getString(2));
	baselineForm.setLabelValue(baselineMasterData.rs.getString(2)
			+ " - " + baselineMasterData.rs.getString(1));
	villages.add(baselineForm);
}

} catch (Exception e) {
Debug.println("The error in getBaseLineMasters=" + e);
e.printStackTrace();
} finally {
baselineMasterData.closeAll();

}
return villages;
}
//
private void getExistingData(BaseLineBean baseLineBean,
		String habcode) {

	BaseLineMasterData baseLineMasterData=new BaseLineMasterData();

	try {
		baseLineMasterData.conn = RwsOffices.getConn();

		baseLineMasterData.stmt1 = baseLineMasterData.conn.createStatement();

		String qq = "select * from  RWS_BLS_GOVTBLDG_INGP_TBL where habitation_code='"+habcode+"'";
		Debug.println("3333:" + qq);
		baseLineMasterData.rs1 = baseLineMasterData.stmt1.executeQuery(qq);

		while (baseLineMasterData.rs1.next()) {

			
			baseLineBean.setChecks("on");

			baseLineBean.setUpdate(true);

		}
	} catch (Exception e) {
		e.printStackTrace();

	}

}

//
private void getExistingData1(BaseLineBean baseLineBean,
		String habcode) {

	BaseLineMasterData baseLineMasterData=new BaseLineMasterData();

	try {
		baseLineMasterData.conn = RwsOffices.getConn();

		baseLineMasterData.stmt1 = baseLineMasterData.conn.createStatement();

		String qq = "select * from  RWS_BLS_vwm_comm_TBL where habitation_code='"+habcode+"'";
		Debug.println("3333:" + qq);
		baseLineMasterData.rs1 = baseLineMasterData.stmt1.executeQuery(qq);

		while (baseLineMasterData.rs1.next()) {

			
			baseLineBean.setChecks("on");

			baseLineBean.setUpdate(true);

		}
	} catch (Exception e) {
		e.printStackTrace();

	}

}

//
private boolean isExists1(BaseLineBean dr) {


	try {
		conn = RwsOffices.getConn();
		Statement pstmt = conn.createStatement();
		ResultSet rs1 = null;

		String query = "select * from  RWS_BLS_vwm_comm_TBL where habitation_code='"
				+ dr.getHabCode()
				+ "' ";
		Debug.println("QueryinisExists************************:" + query);
		rs1 = pstmt.executeQuery(query);

		if (rs1.next())
			return true;
		else
			return false;
	} catch (Exception e) {
		e.printStackTrace();
	}

	return false;
}



boolean isExists(BaseLineBean dr) {

	try {
		conn = RwsOffices.getConn();
		Statement pstmt = conn.createStatement();
		ResultSet rs1 = null;

		String query = "select * from  RWS_BLS_GOVTBLDG_INGP_TBL where habitation_code='"
				+ dr.getHabCode()
				+ "' ";
		Debug.println("QueryinisExists************************:" + query);
		rs1 = pstmt.executeQuery(query);

		if (rs1.next())
			return true;
		else
			return false;
	} catch (Exception e) {
		e.printStackTrace();
	}

	return false;
}

//
boolean isExistsgovt(BaseLineForm dr) {

	try {
		conn = RwsOffices.getConn();
		Statement pstmt = conn.createStatement();
		ResultSet rs1 = null;

		String query = "select * from  RWS_BLS_GOVTBLDG_INGP_TBL where habitation_code='"
				+ dr.getHabCode()
				+ "' ";
		Debug.println("QueryinisExists************************:" + query);
		rs1 = pstmt.executeQuery(query);

		if (rs1.next())
			return true;
		else
			return false;
	} catch (Exception e) {
		e.printStackTrace();
	}

	return false;
}
//
boolean isExistscomm(BaseLineForm dr) {

	try {
		conn = RwsOffices.getConn();
		Statement pstmt = conn.createStatement();
		ResultSet rs1 = null;

		String query = "select * from  rws_bls_vwm_comm_tbl where habitation_code='"
				+ dr.getHabCode()
				+ "' ";
		Debug.println("QueryinisExistsincomm************************:" + query);
		rs1 = pstmt.executeQuery(query);

		if (rs1.next())
			return true;
		else
			return false;
	} catch (Exception e) {
		e.printStackTrace();
	}

	return false;
}

//
boolean isExistssolid(BaseLineForm dr) {

	try {
		conn = RwsOffices.getConn();
		Statement pstmt = conn.createStatement();
		ResultSet rs1 = null;

		String query = "select * from  rws_bls_solid_waste_survey_tbl where habitation_code='"
				+ dr.getHabCode()
				+ "' ";
		Debug.println("QueryinisExistsinsolid************************:" + query);
		rs1 = pstmt.executeQuery(query);

		if (rs1.next())
			return true;
		else
			return false;
	} catch (Exception e) {
		e.printStackTrace();
	}

	return false;
}

//
public int saveBldgs(ArrayList resultData, String habcode)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

int i = 0;
for (i = 0; i < resultData.size(); i++) {

	BaseLineBean dr = (BaseLineBean) resultData
			.get(i);

	
	
       if(isExists(dr))
       {
		 query = "update RWS_BLS_GOVTBLDG_INGP_TBL set survey_date=to_date(? ,'dd/mm/yyyy') "
				+ ",BLDG_NAME =?"
				+ ",latrine_facility=?"
				+ ",water_facility=?"
				+ " where habitation_code=?";
				
Debug.println("***********in update"+query);
	PreparedStatement pst= conn.prepareStatement(query);
	pst.setString(1,  dr.getSurveyDate());
	pst.setString(2,  dr.getBldgName());
	pst.setString(3,  dr.getLatFacility());
	pst.setString(4,  dr.getWatFacility());
	pst.setString(5,  habcode);
		count = pst.executeUpdate();
}
	
Debug.println("count************inupdate"+count);
if (count > 0) {

	conn.commit();
}
}

}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}
//
public int saveCode(String tablename,String columnname)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
String query="";

Statement pstmt = conn.createStatement();
Statement st1=conn.createStatement();
ResultSet rs1 = null;
String code="";
int i=0;
ResultSet rs2=null;

	String qry1="";
	qry1="select habitation_code from" +tablename+ "where habitation_code is not null and " +columnname+" is null ";
	Debug.println("qry1****************"+qry1);
	/*PreparedStatement ps=conn.prepareStatement(qry1);
	ps.setString(1,tablename);
	ps.setString(2,columnname);*/
	rs2=ps.executeQuery(qry1);
	while(rs2.next())
	{
		
		Debug.println("code***************"+code);
		i++;
		Debug.println("i***************"+i);
		
	
	
	
		 query = "update "+tablename+" set "+columnname+" ='"+i+"' ";
				
Debug.println("***********incode ***update"+query);
	
		count = pstmt.executeUpdate(query);
if (count > 0) {

	conn.commit();

}
}
}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}


//
public int updategovtBldgs(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;


	
		 query = "update RWS_BLS_GOVTBLDG_INGP_TBL set survey_date=to_date(?,'dd/mm/yyyy'),"
				 + "BLDG_NAME =?, latrine_facility=?,water_facility=?"
				 + " where habitation_code=? and bldg_num=?";
				
       Debug.println("***********in updateingovt"+query);
	   PreparedStatement ps= conn.prepareStatement(query);
       ps.setString(1, dr.getSurveyDate());
       ps.setString(2, dr.getBldgName().toUpperCase());
       ps.setString(3, dr.getLatFacility());
       ps.setString(4, dr.getWatFacility());
       ps.setString(6, dr.getHabCode());
       ps.setString(5, dr.getBldgCode());
		count = ps.executeUpdate();

	
Debug.println("count************inupdate"+count);
if (count > 0) {
	conn.setAutoCommit(true);
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public int updateSchools(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false);
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;


	
		 query = "update rws_bls_school_sani_survey_tbl set survey_date=to_date(? ,'dd/mm/yyyy'),"
				+ "SCHOOLNAME =?,DISECODE=?,LOCALITY=?,SCHOOLTYPE=?,SCHOOLCATEGORY=?,SCHOOLESTABILISHEDBEFORE2007=?,"
				+" BOYSCOUNT=?,GIRLSCOUNT=?,SANITARYEXIST=?,SANITARYBUILDINGDEPT=? ,YEAROFBULIT=?,BOYSTOILETSCOUNT=?," 
				+" GIRLSTOILETSCOUNT=?,ISWATEREXIST=?,SANITARYUSE=?," 
				+" DRINKINGWATERFACILITYAVAILABLE=?,BINEXIST=?,PITEXIST=? where habitation_code=? and school_num=?";
				
       Debug.println("***********in updateinschools"+query);
	   PreparedStatement ps=conn.prepareStatement(query);
	   ps.setString(1, dr.getSurveyDate());
	   ps.setString(2, dr.getSchoolName().toUpperCase());
	   ps.setString(3, dr.getDiseCode());
	   ps.setString(4, dr.getLocality().toUpperCase());
	   ps.setString(4, dr.getSchoolType().toUpperCase());
	   ps.setString(5, dr.getSchoolCategory());
	   ps.setString(6, dr.getSchoolEstablieshed2007());
	   ps.setString(7, dr.getBoysCount());
	   ps.setString(8, dr.getGirlsCount());
	   ps.setString(9, dr.getSanitaryExist());
	   ps.setString(10, dr.getSanitaryBuildingdept());
	   ps.setString(11, dr.getYearofBuilt());
	   ps.setString(12, dr.getBoystoiletCount());
	   ps.setString(13, dr.getGirlstoiletCount());
	   ps.setString(14, dr.getIsWaterExist());
	   ps.setString(15, dr.getSanitaryUse());
	   ps.setString(16, dr.getDrinkingwaterFacilityAvailable());
	   ps.setString(17,dr.getBinExist());
	   ps.setString(18, dr.getPitExist());
	   ps.setString(19, dr.getHabCode());
	   ps.setString(20, dr.getSchoolCode());
	   count = ps.executeUpdate();

	
Debug.println("count************inupdateinschools"+count);
if (count > 0) {
	conn.setAutoCommit(true);
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public int updateAngans(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false);
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;


	
		 query = "update rws_bls_angan_sani_survey_tbl set survey_date=to_date(?,'dd/mm/yyyy'),"
				+ "ANGANVADINAME =?,ANGANWADICODE=?,BUILDINGTYPE_NAME=?,TOTALENROLLMENT=?,AVAILOFTOILETFACILITY=?,BUILDINGDEPT=?,"
				+" YEARBUILD=?,SANITORYUSE=?,FUNCTIONALREASON=?," 
				+"REASONFORDEFUNT=?,TOILETWATERFACILITYAVAIL =?,DRINKINGWATEREXIST=?," 
				+" BINAVAILABLE=?,PITAVAILABLE=? where habitation_code=? and ang_num=?";
												
				
       Debug.println("***********in updateinangans"+query);
       PreparedStatement pst=conn.prepareStatement(query);
       pst.setString(1, dr.getSurveyDate());
       pst.setString(2, dr.getAnganwadiName().toUpperCase());
       ps.setString(3, dr.getAnganCode());
       ps.setString(4, dr.getBuildingTypename().toUpperCase());
       ps.setString(5,dr.getTotalEnrolment());
       ps.setString(6, dr.getAvailabilityofToiletfacility());
       ps.setString(7, dr.getBuildingDept());
       ps.setString(8, dr.getYearofBuilt());
       ps.setString(9, dr.getSanitaryUse());
       ps.setString(10, dr.getFunctionalReason());
       ps.setString(11,dr.getReasonforDefunct());
       ps.setString(12, dr.getToiletwaterFacilityavailable());
       ps.setString(13,dr.getDrinkingWaterexist());
       ps.setString(14, dr.getBinExist());
       ps.setString(15,dr.getPitExist());
       ps.setString(16, dr.getHabCode());
       ps.setString(17,dr.getAnganNum());
		count = ps.executeUpdate();

	
Debug.println("count************inupdateinangans"+count);
if (count > 0) {
	conn.setAutoCommit(true);
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}


//

public int saveGovtBldgs(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	
	
              
       BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
       int code=BaseLineMasterData.getBldgCode();
       Debug.println("code*************"+code);
		 query = "insert into RWS_BLS_GOVTBLDG_INGP_TBL  (habitation_code,bldg_name,latrine_facility,water_facility,survey_date,BLDG_NUM)  values(?,?,?,?,to_date(?,'dd/mm/yyyy'),?)";
			PreparedStatement pt=conn.prepareStatement(query);
			pt.setString(1, dr.getHabCode());
			pt.setString(2, dr.getBldgName().toUpperCase());
			pt.setString(3, dr.getLatFacility());
			pt.setString(4, dr.getWatFacility());
			pt.setString(5, dr.getSurveyDate());
			pt.setInt(6,code);
				
Debug.println("***********in insert**************"+query);
	
		count = pt.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}


private InputStream getFileInputStream(String passOrderScanCopy) {
	// TODO Auto-generated method stub
	return null;
}

//
//
public int GovtCommdel(String habcode,String commcode)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	
	
              
       
        query = "delete from  rws_bls_vwm_comm_tbl where habitation_code=? and comm_num=?";  

		PreparedStatement ps= conn.prepareStatement(query);		
		ps.setString(1, habcode);	
		ps.setString(2, commcode);
Debug.println("***********in delete********rws_bls_vwm_comm_tbl******"+query);
	
		count = ps.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}
//***
public int GovtBldgsdel(String habcode,String bldgcode)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	
	
              
       
        query = "delete from  rws_bls_govtbldg_ingp_tbl where habitation_code=? and bldg_num=?";  

		PreparedStatement ps= conn.prepareStatement(query);	
		ps.setString(1, habcode);
		ps.setString(2, bldgcode);
				
Debug.println("***********in delete********rws_bls_govtbldg_ingp_tbl******"+query);
	
		count = ps.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}


//
public int GovtSoliddel(String habcode,String solidcode)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

        query = "delete from  rws_bls_solid_waste_survey_tbl where habitation_code=? and solid_num=?";  

		PreparedStatement ps= conn.prepareStatement(query);		
			ps.setString(1, habcode);
			ps.setString(2, solidcode);
Debug.println("***********in delete********rws_bls_solid_waste_survey_tbl******"+query);
	
		count = ps.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}
//
public int GovtSchooldel(String habcode,String schoolcode)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	
	
              
       
        query = "delete from  rws_bls_school_sani_survey_tbl where habitation_code=? and school_num=?";  
      PreparedStatement ps=conn.prepareStatement(query); 
	  ps.setString(1, habcode);	
	  ps.setString(2,schoolcode);
				
Debug.println("***********in delete********rws_bls_school_sani_survey_tbl******"+query);
	
		count = ps.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public int GovtAngandel(String habcode,String anganCode)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	
	
              
       
        query = "delete from  rws_bls_angan_sani_survey_tbl where habitation_code=? and ang_num=?";  

		PreparedStatement ps=conn.prepareStatement(query);	
		ps.setString(1,habcode);
		ps.setString(2, anganCode);		
Debug.println("***********in delete********"+query);
	
		count = ps.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public ArrayList getExpYears() throws Exception
{
	ArrayList years = new ArrayList();
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    int currentYears = Integer.parseInt(currentYear);
    Debug.println("currentyears*****8"+currentYears);
	try
	{
		for(int i = currentYears;i >= 1990;i--)
        {
        	int j = i;
        	j++;
        	//nic.watersoft.commons.Debug.println(i+" - "+j);
    		
			LabelValueBean labelValueBean = new LabelValueBean();
			labelValueBean.setValue(""+i);
			labelValueBean.setLabel(i+" - "+j);
			labelValueBean.setLabelValue(i+" - "+j+" - " + i);
			years.add(labelValueBean);
        }
	}
	catch(Exception e){nic.watersoft.commons.Debug.println("Exception in exp years is "+e);}
	finally
	{	closeAll();
	}
	
	return years;
}

//
public int saveSchools(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 

String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	Debug.println("dr.getbuiltdate888888888888"+dr.getYearofBuilt());
	
              
       BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
       int code=baseLineMasterData.getSchoolCode();
       Debug.println("code*************"+code);
		 query = "insert into rws_bls_school_sani_survey_tbl  (HABITATION_CODE,SCHOOLNAME,DISECODE,LOCALITY,SCHOOLTYPE,SCHOOLCATEGORY,SCHOOLESTABILISHEDBEFORE2007,BOYSCOUNT,GIRLSCOUNT,SANITARYEXIST,SANITARYBUILDINGDEPT,YEAROFBULIT,BOYSTOILETSCOUNT,GIRLSTOILETSCOUNT,ISWATEREXIST,SANITARYUSE,DRINKINGWATERFACILITYAVAILABLE,BINEXIST,PITEXIST,SURVEY_DATE,school_num) values     (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?)";
		 		
		 
PreparedStatement ps=conn.prepareStatement(query);
ps.setString(1, dr.getHabCode());
ps.setString(2, dr.getSchoolName().toUpperCase());
ps.setString(3, dr.getDiseCode());
ps.setString(4, dr.getLocality().toUpperCase());
ps.setString(5, dr.getSchoolType().toUpperCase());
ps.setString(6, dr.getSchoolCategory());
ps.setString(7, dr.getSchoolEstablieshed2007());
ps.setString(8, dr.getBoysCount());
ps.setString(9, dr.getGirlsCount());
ps.setString(10, dr.getSanitaryExist());
ps.setString(11, dr.getSanitaryBuildingdept());
ps.setString(12, dr.getYearofBuilt());
ps.setString(13, dr.getBoystoiletCount());
ps.setString(14, dr.getGirlstoiletCount());
ps.setString(15, dr.getIsWaterExist());
ps.setString(16, dr.getSanitaryUse());
ps.setString(17, dr.getDrinkingwaterFacilityAvailable());
ps.setString(18, dr.getBinExist());
ps.setString(19, dr.getPitExist());
ps.setString(20, dr.getSurveyDate());
ps.setInt(21,code);
				
				
Debug.println("***********in insert**************"+query);
	
		count = ps.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public int saveAngans(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 

String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	Debug.println("dr.getbuiltdate888888888888********************"+dr.getYearofBuilt());
	
              
       BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
       int code=baseLineMasterData.getAnganCode();
       Debug.println("code*************"+code);
		 query = "insert into rws_bls_angan_sani_survey_tbl  (HABITATION_CODE,ANGANVADINAME,ANGANWADICODE,BUILDINGTYPE_NAME,TOTALENROLLMENT,AVAILOFTOILETFACILITY ,BUILDINGDEPT,YEARBUILD,SANITORYUSE,FUNCTIONALREASON,REASONFORDEFUNT,TOILETWATERFACILITYAVAIL  ,DRINKINGWATEREXIST,BINAVAILABLE ,PITAVAILABLE, SURVEY_DATE ,ANG_NUM) values     (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?)";
				
   Debug.println("***********in insert**************"+query);
	PreparedStatement ps= conn.prepareStatement(query);
	ps.setString(1, dr.getHabCode());
	ps.setString(2, dr.getAnganwadiName().toUpperCase());
	ps.setString(3, dr.getAnganCode());
	ps.setString(4, dr.getBuildingTypename().toUpperCase());
	ps.setString(5, dr.getTotalEnrolment());
	ps.setString(6,dr.getAvailabilityofToiletfacility());
	ps.setString(7, dr.getBuildingDept());
	ps.setString(8, dr.getYearofBuilt());
	ps.setString(9, dr.getSanitaryUse());
	ps.setString(10, dr.getFunctionalReason());
	ps.setString(11, dr.getReasonforDefunct());
	ps.setString(12, dr.getToiletwaterFacilityavailable());
	ps.setString(13, dr.getDrinkingWaterexist());
	ps.setString(14, dr.getBinExist());
	ps.setString(15, dr.getPitExist());
	ps.setString(16, dr.getSurveyDate());
	ps.setInt(17, code);
	count = ps.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public int saveGovtBldgsb1(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	
	
       if(isExistsgovt(dr))
       {
		 query = "update RWS_BLS_GOVTBLDG_INGP_TBL set survey_date=to_date(?,'dd/mm/yyyy'),"
				+ "BLDG_NAME =?,latrine_facility=?,water_facility=? where habitation_code=?";
				
    Debug.println("***********in update"+query);
	PreparedStatement ps= conn.prepareStatement(query);
	ps.setString(1, dr.getSurveyDate());
	ps.setString(2, dr.getBldgName());
	ps.setString(3, dr.getLatFacility());
	ps.setString(4, dr.getWatFacility());
	ps.setString(5, dr.getHabCode());
	count = ps.executeUpdate();
}
       
       if(!isExistsgovt(dr))
       {
		 query = "insert into RWS_BLS_GOVTBLDG_INGP_TBL  (habitation_code,bldg_name,latrine_facility,water_facility,survey_date)  values  (?,?,?,?,to_date(?,'dd/mm/yyyy'))";
         PreparedStatement ps= conn.prepareStatement(query);
		 ps.setString(1, dr.getHabCode());
		 ps.setString(2, dr.getBldgName());
		 ps.setString(3, dr.getLatFacility());
		 ps.setString(4,dr.getWatFacility());
		 ps.setString(5, dr.getSurveyDate());
				
Debug.println("***********in insert**************"+query);
	
		count = ps.executeUpdate();
}

	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {

	conn.commit();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public int saveCommentry(BaseLineForm dr)
throws Exception
{
int count = 0;
int code=0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
	 code=BaseLineMasterData.getCommCode();
	 Debug.println("codein insert"+code);
	
    	 query = "insert into rws_bls_vwm_comm_tbl  (habitation_code,VWSC_FORMED ,vwsm_functional,survey_date,comm_num)  values  (?,?,?,to_date(?,'dd/mm/yyyy'),?)";
        PreparedStatement ps=conn.prepareStatement(query); 
		ps.setString(1, dr.getHabCode());		
		ps.setString(2, dr.getVwscFormed());
		ps.setString(3, dr.getVwsmFunctional());
		ps.setString(4,dr.getSurveyDate());
		ps.setInt(5, code);
Debug.println("***********in insertin committeentry**************"+query);
	
		count = ps.executeUpdate();

	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public int updateCommentry(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	
	
       
		 query = "update rws_bls_vwm_comm_tbl set survey_date=to_date(?,'dd/mm/yyyy'),"
				+ "VWSC_FORMED =?,VWSM_FUNCTIONAL=? where habitation_code=? and comm_num=?";
				
Debug.println("***********in update******** in commity"+query);
	    PreparedStatement ps= conn.prepareStatement(query);
		ps.setString(1,dr.getSurveyDate());
		ps.setString(2, dr.getVwscFormed());
		ps.setString(3, dr.getVwsmFunctional());
		ps.setString(4, dr.getHabCode());
		ps.setString(5, dr.getCommCode());
	    count = ps.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public int saveSolidentry(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";
int code=0;

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	
	BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
       code=baseLineMasterData.getSolidCode();      
       query = "insert into rws_bls_solid_waste_survey_tbl  (HABITATION_CODE,TOTAL_DUSTBINS,TOTAL_SOAKPITS,TOTAL_COMPOSTPITS,TOTAL_TRICYCLES,EXTRA_FACILITIES,OTHER_IN_NO,DRAINAGE_EXIST,SURVEY_DATE,solid_num)  values  (?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?)";
		PreparedStatement ps= conn.prepareStatement(query);		
        Debug.println("***********in insertin committe**************"+query);
	    ps.setString(1, dr.getHabCode());
	    ps.setString(2,dr.getTotDustbins());
	    ps.setString(3, dr.getTotSoakpits());
	    ps.setString(4, dr.getTotCompits());
	    ps.setString(5, dr.getTotTricycles());
	    ps.setString(6, dr.getExtraFacilities().toUpperCase());
	    ps.setString(7, dr.getOtherInNo());
	    ps.setString(8, dr.getDrainageExist());
	    ps.setString(9, dr.getSurveyDate());
	    ps.setInt(10,code);
		count = ps.executeUpdate();


	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}


//
public int updateSolidentry(BaseLineForm dr)
throws Exception
{
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();
conn.setAutoCommit(false); 
String query="";

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

	
	
        query = "update rws_bls_solid_waste_survey_tbl set survey_date=to_date(?,'dd/mm/yyyy'),"
				+ "TOTAL_DUSTBINS =?,TOTAL_SOAKPITS=?,"
				+ "TOTAL_COMPOSTPITS=?,TOTAL_TRICYCLES  =?,EXTRA_FACILITIES=?,OTHER_IN_NO=?,DRAINAGE_EXIST=? where habitation_code=?";
				
Debug.println("***********in update in solidentry"+query);
	    PreparedStatement ps= conn.prepareStatement(query);
	    ps.setString(1,dr.getSurveyDate());
	    ps.setString(2,dr.getTotDustbins());
	    ps.setString(3,dr.getTotSoakpits());
	    ps.setString(4,dr.getTotCompits());
	    ps.setString(5,dr.getTotTricycles());
	    ps.setString(6, dr.getExtraFacilities().toUpperCase());
		ps.setString(7,dr.getOtherInNo());
		ps.setString(8, dr.getDrainageExist());
		ps.setString(9,dr.getHabCode());
	    count = ps.executeUpdate();

       
      
	
Debug.println("count************inupdate&insert"+count);
if (count > 0) {
	conn.setAutoCommit(true); 
	conn.commit();
}
else
{
conn.rollback();
}


}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//

public int saveComm(ArrayList resultData, String habcode)
throws Exception {
int count = 0;


try {
	Connection conn=null;
conn = RwsOffices.getConn();

Statement pstmt = conn.createStatement();
ResultSet rs1 = null;

int i = 0;
for (i = 0; i < resultData.size(); i++) {

	BaseLineBean dr = (BaseLineBean) resultData
			.get(i);

	
	if(isExists1(dr))
	{

		String query = "update RWS_BLS_vwm_comm_TBL set survey_date=to_date(?,'dd/mm/yyyy'),"
				 + "vwsc_formed =?,Vwsm_functional=? where habitation_code=?";
				
				
Debug.println("***********in update"+query);
	PreparedStatement ps= conn.prepareStatement(query);
	ps.setString(1, dr.getSurveyDate());
	ps.setString(2, dr.getVwscFormed());
	ps.setString(3,dr.getVwsmFunctional());
	ps.setString(4, habcode);
	count = ps.executeUpdate();
}
	if(!isExists1(dr))
	{
		String query = "insert into RWS_BLS_vwm_comm_TBL values (?,?,?,to_date(?,'dd/mm/yyyy'))";
	System.out.println("Queryininsert************************:" + query);
	PreparedStatement ps= conn.prepareStatement(query);
	ps.setString(1,dr.getHabCode());
	ps.setString(2, dr.getVwscFormed());
	ps.setString(3,dr.getVwsmFunctional());
	ps.setString(4, dr.getSurveyDate());
	count = ps.executeUpdate();

	}
	
Debug.println("count************inupdate"+count);
if (count > 0) {

	conn.commit();
}
}//end of if

	

}
catch (Exception e)
{
e.printStackTrace();
}
return count;

}

//
public ArrayList getBldggpdetails(String dcode,String mcode,String pcode,String vcode, DataSource dataSource)
throws Exception {
ArrayList habs;
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
habs = new ArrayList();
boolean exists = false;

String querysources = "";

int i = 0;
ArrayList c = new ArrayList();
String query="";

try {
	BaseLineBean baselineBean = null;
Debug.println("ConnCount is " + connCount);

exists = false;
baseLineMasterData.conn = RwsOffices.getConn();

baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();


//for getting details of hps

query = "select distinct panch_code,panch_name,nvl(BLDG_NAME,'-') ,LATRINE_FACILITY,WATER_FACILITY ,to_char(SURVEY_DATE,'dd/mm/yyyy')   from RWS_BLS_GOVTBLDG_INGP_TBL a,rws_complete_hab_view b where b.panch_code(+)=a.habitation_code and dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"' and vcode='"+vcode+"'";
baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for habitationshps****" + query);
i = 0;
while (baseLineMasterData.rs.next())
{
BaseLineBean baseLineBean=new BaseLineBean();
	
	baseLineBean.setHabCode(baseLineMasterData.rs
			.getString(1));
	getExistingData(baseLineBean, baseLineMasterData.rs
		.getString(1));

	baseLineBean.setPanchName(baseLineMasterData.rs
		.getString(2));
	baseLineBean
			.setBldgName(baseLineMasterData.rs.getString(3));
	baseLineBean.setLatFacility(baseLineMasterData.rs
			.getString(4));
	baseLineBean
			.setWatFacility(baseLineMasterData.rs.getString(5));
	
	baseLineBean
	.setSurveyDate(baseLineMasterData.rs.getString(6));


	habs.add(baseLineBean);

}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine=" + e);
} finally {
baseLineMasterData.closeAll();
Debug.println("ConnCount after closing is " + connCount);
}
return habs;
}


//
public static int getBldgCode() throws Exception {
	BaseLineMasterData baseLineMasterData = new BaseLineMasterData();
	int code = 0;

	try {
		Debug.println("in getBldgCode");
		
		baseLineMasterData.conn = RwsOffices.getConn();

		baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
		baseLineMasterData.rs = baseLineMasterData.stmt
				.executeQuery("SELECT MAX(to_number(bldg_num))+1 FROM RWS_BLS_GOVTBLDG_INGP_TBL");
		baseLineMasterData.rs.next();
		code = baseLineMasterData.rs.getInt(1);
		if(code==0)
		{
			code=1;
		}
		
		Debug.println("code**********"+code);
	} catch (Exception e) {
		e.printStackTrace();
		Debug.println("The error in getBuildingCode=" + e);
	} finally {
		baseLineMasterData.closeAll();
		
	}
	return code;
}

//
public static int getSchoolCode() throws Exception {
	BaseLineMasterData baseLineMasterData = new BaseLineMasterData();
	int code = 0;

	try {
		Debug.println("in getBldgCode");
		
		baseLineMasterData.conn = RwsOffices.getConn();

		baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
		baseLineMasterData.rs = baseLineMasterData.stmt
				.executeQuery("SELECT MAX(to_number(school_num))+1 FROM rws_bls_school_sani_survey_tbl");
		baseLineMasterData.rs.next();
		code = baseLineMasterData.rs.getInt(1);
		if (code == 0)
		{
			code = 1;
		}
		
		
		Debug.println("code**********"+code);
	} catch (Exception e) {
		e.printStackTrace();
		Debug.println("The error in getSchool CodeCode=" + e);
	} finally {
		baseLineMasterData.closeAll();
		
	}
	return code;
}

//
//
public static int getAnganCode() throws Exception {
	BaseLineMasterData baseLineMasterData = new BaseLineMasterData();
	int code = 0;

	try {
		Debug.println("in getBldgCode");
		
		baseLineMasterData.conn = RwsOffices.getConn();

		baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
		baseLineMasterData.rs = baseLineMasterData.stmt
				.executeQuery("SELECT MAX(to_number(ang_num))+1 FROM rws_bls_angan_sani_survey_tbl");
		baseLineMasterData.rs.next();
		code = baseLineMasterData.rs.getInt(1);
		if (code == 0)
		{
			code = 1;
		}
		
		
		Debug.println("code**********"+code);
	} catch (Exception e) {
		e.printStackTrace();
		Debug.println("The error in getAngan CodeCode=" + e);
	} finally {
		baseLineMasterData.closeAll();
		
	}
	return code;
}

//


//
public static int getCommCode() throws Exception {
	BaseLineMasterData baseLineMasterData = new BaseLineMasterData();
	int  code = 0;

	try {
		Debug.println("in getCommCode");
		
		baseLineMasterData.conn = RwsOffices.getConn();

		baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
		baseLineMasterData.rs = baseLineMasterData.stmt
				.executeQuery("SELECT MAX(to_number(comm_num))+1 FROM rws_bls_vwm_comm_tbl");
		baseLineMasterData.rs.next();
		code = baseLineMasterData.rs.getInt(1);
		if (code == 0)
		{
			code = 1;
		}
		
		Debug.println("Commcodeinmethod**********"+code);
	} catch (Exception e) {
		e.printStackTrace();
		Debug.println("The error in getBuildingCodein*******=" + e);
	} finally {
		baseLineMasterData.closeAll();
		
	}
	return code;
}


//
public static int getSolidCode() throws Exception {
	BaseLineMasterData baseLineMasterData = new BaseLineMasterData();
	int code = 0;

	try {
		Debug.println("in getCommCode");
		
		baseLineMasterData.conn = RwsOffices.getConn();

		baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
		baseLineMasterData.rs = baseLineMasterData.stmt
				.executeQuery("SELECT MAX(to_number(solid_num))+1 FROM rws_bls_solid_waste_survey_tbl");
		baseLineMasterData.rs.next();
		code = baseLineMasterData.rs.getInt(1);
		if (code == 0)
		{
			code = 1;
		}
		
		
		Debug.println("In Solid Wasteinmethod**********"+code);
	} catch (Exception e) {
		e.printStackTrace();
		Debug.println("The error in getSolid Waste method*******=" + e);
	} finally {
		baseLineMasterData.closeAll();
		
	}
	return code;
}


//
public ArrayList getListBldggpdetails(BaseLineForm frm)
throws Exception {
ArrayList habs=new ArrayList();
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
String query="";
try {
Debug.println("ConnCount is " + connCount);
baseLineMasterData.conn = RwsOffices.getConn();
baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
query = "select distinct  panch_code,panch_name,nvl(BLDG_NAME,'-') ,nvl(LATRINE_FACILITY,'-'),nvl(WATER_FACILITY,'-') ,to_char(SURVEY_DATE,'dd/mm/yyyy'),bldg_num,dname,mname,pname,vname   from RWS_BLS_GOVTBLDG_INGP_TBL a,rws_complete_hab_view b where b.panch_code=a.habitation_code ";
if(frm.getDist()!=null && !frm.getDist().equals(""))
{
	query+=" and substr(habitation_code,1,2)='"+frm.getDist()+"'";
}
if(frm.getMcode() != null && !frm.getMcode().equals(""))
{
	query+="and substr(habitation_code,6,2)='"+frm.getMcode()+"'";
}
if(frm.getPcode() != null && !frm.getPcode().equals(""))
{
	query+="and substr(habitation_code,13,2)='"+frm.getPcode()+"'";
}
if(frm.getVcode() != null && !frm.getVcode().equals(""))
{
	query+="and substr(habitation_code,8,3)='"+frm.getVcode()+"'";
}
if(frm.getHabCode() != null && !frm.getHabCode().equals(""))
{
	query+="and substr(habitation_code,1,16)='"+frm.getHabCode()+"'";
}
query+="order by 1";



baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for cviewto display details***" + query);

while (baseLineMasterData.rs.next())
{
	BaseLineForm frm1=new BaseLineForm();
	frm1.setHabCode(baseLineMasterData.rs.getString(1));
	frm1.setPanchName(baseLineMasterData.rs.getString(2));
	frm1.setBldgName(baseLineMasterData.rs.getString(3));
	frm1.setLatFacility(baseLineMasterData.rs.getString(4));
	frm1.setWatFacility(baseLineMasterData.rs.getString(5));
	frm1.setSurveyDate(baseLineMasterData.rs.getString(6));
	frm1.setBldgCode(baseLineMasterData.rs.getString(7));
	frm1.setdName(baseLineMasterData.rs.getString(8));
	frm1.setmName(baseLineMasterData.rs.getString(9));
	frm1.setpName(baseLineMasterData.rs.getString(10));
	frm1.setvName(baseLineMasterData.rs.getString(11));
	habs.add(frm1);

}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine=" + e);
} finally {
baseLineMasterData.closeAll();
Debug.println("ConnCount after closing is " + connCount);
}
return habs;
}


//
public ArrayList getListSchooldetails(BaseLineForm frm)
throws Exception {
ArrayList habs=new ArrayList();
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
String query="";
try {
Debug.println("ConnCount is " + connCount);
baseLineMasterData.conn = RwsOffices.getConn();
baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
query ="select distinct HABITATION_CODE  ,panch_name,nvl(SCHOOLNAME,'-'),nvl(DISECODE,0),nvl(LOCALITY,'-'),nvl(SCHOOLTYPE,'-'),nvl(SCHOOLCATEGORY,'-'),nvl(SCHOOLESTABILISHEDBEFORE2007,'-'),nvl(BOYSCOUNT,0) ,nvl(GIRLSCOUNT,0),nvl(SANITARYEXIST,'-'),nvl(SANITARYBUILDINGDEPT,'-'),YEAROFBULIT,nvl(BOYSTOILETSCOUNT,0),nvl(GIRLSTOILETSCOUNT,0),nvl(ISWATEREXIST,'-'),nvl(SANITARYUSE,'-'),nvl(DRINKINGWATERFACILITYAVAILABLE,'-'),nvl(BINEXIST,'-'),nvl(PITEXIST,'-'),to_char(SURVEY_DATE,'dd/mm/yyyy'),SCHOOL_NUM,dname,mname,pname,vname from rws_bls_school_sani_survey_tbl a,rws_complete_hab_view b where a.habitation_code=b.panch_code";   

if(frm.getDist()!=null && !frm.getDist().equals(""))
{
	query+=" and substr(habitation_code,1,2)='"+frm.getDist()+"'";
}
if(frm.getMcode() != null && !frm.getMcode().equals(""))
{
	query+="and substr(habitation_code,6,2)='"+frm.getMcode()+"'";
}
if(frm.getPcode() != null && !frm.getPcode().equals(""))
{
	query+="and substr(habitation_code,13,2)='"+frm.getPcode()+"'";
}
if(frm.getVcode() != null && !frm.getVcode().equals(""))
{
	query+="and substr(habitation_code,8,3)='"+frm.getVcode()+"'";
}
if(frm.getHabCode() != null && !frm.getHabCode().equals(""))
{
	query+="and substr(habitation_code,1,16)='"+frm.getHabCode()+"'";
}
query+="order by 1";



baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for cviewto display details***" + query);

while (baseLineMasterData.rs.next())
{
	BaseLineBean frm1=new BaseLineBean();
	frm1.setHabCode(baseLineMasterData.rs.getString(1));
	frm1.setPanchName(baseLineMasterData.rs.getString(2));
	frm1.setSchoolName(baseLineMasterData.rs.getString(3));
	frm1.setDiseCode(baseLineMasterData.rs.getString(4));
	frm1.setLocality(baseLineMasterData.rs.getString(5));
	frm1.setSchoolType(baseLineMasterData.rs.getString(6));
	frm1.setSchoolCategory(baseLineMasterData.rs.getString(7));
	frm1.setSchoolEstablieshed2007(baseLineMasterData.rs.getString(8));
	frm1.setBoysCount(baseLineMasterData.rs.getString(9));
	frm1.setGirlsCount(baseLineMasterData.rs.getString(10));
	frm1.setSanitaryExist(baseLineMasterData.rs.getString(11));
	frm1.setSanitaryBuildingdept(baseLineMasterData.rs.getString(12));
	frm1.setYearofBuilt(baseLineMasterData.rs.getString(13));
	frm1.setBoystoiletCount(baseLineMasterData.rs.getString(14));
	frm1.setGirlstoiletCount(baseLineMasterData.rs.getString(15));
	frm1.setIsWaterExist(baseLineMasterData.rs.getString(16));
	frm1.setSanitaryUse(baseLineMasterData.rs.getString(17));
	frm1.setDrinkingwaterFacilityAvailable(baseLineMasterData.rs.getString(18));
	frm1.setBinExist(baseLineMasterData.rs.getString(19));
	frm1.setPitExist(baseLineMasterData.rs.getString(20));
	frm1.setSurveyDate(baseLineMasterData.rs.getString(21));
	frm1.setSchoolCode(baseLineMasterData.rs.getString(22));
	frm1.setdName(baseLineMasterData.rs.getString(23));
	frm1.setmName(baseLineMasterData.rs.getString(24));
	frm1.setpName(baseLineMasterData.rs.getString(25));
	frm1.setvName(baseLineMasterData.rs.getString(26));
	
	
	habs.add(frm1);

}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine=" + e);
} finally {
baseLineMasterData.closeAll();
Debug.println("ConnCount after closing is " + connCount);
}
return habs;
}

//
public ArrayList getListAngandetails(BaseLineForm frm)
throws Exception {
ArrayList habs=new ArrayList();
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
String query="";
try {
Debug.println("ConnCount is " + connCount);
baseLineMasterData.conn = RwsOffices.getConn();
baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
query = "select distinct HABITATION_CODE,panch_name,nvl(ANGANVADINAME,'-'),nvl(ANGANWADICODE,0),nvl(BUILDINGTYPE_NAME,'-'),nvl(TOTALENROLLMENT,0),nvl(AVAILOFTOILETFACILITY,'-') ,nvl(BUILDINGDEPT,'-'),YEARBUILD,nvl(SANITORYUSE,'-'),nvl(FUNCTIONALREASON,'-'),nvl(REASONFORDEFUNT,'-'),nvl(TOILETWATERFACILITYAVAIL,'-') ,nvl(DRINKINGWATEREXIST,'-'),nvl(BINAVAILABLE,'-') ,nvl(PITAVAILABLE,'-'),to_char(SURVEY_DATE,'dd/mm/yyyy'),ANG_NUM,dname,mname,pname,vname from rws_complete_hab_view a,rws_bls_angan_sani_survey_tbl b where a.panch_code=b.habitation_code"; 

if(frm.getDist()!=null && !frm.getDist().equals(""))
{
	query+=" and substr(habitation_code,1,2)='"+frm.getDist()+"'";
}
if(frm.getMcode() != null && !frm.getMcode().equals(""))
{
	query+="and substr(habitation_code,6,2)='"+frm.getMcode()+"'";
}
if(frm.getPcode() != null && !frm.getPcode().equals(""))
{
	query+="and substr(habitation_code,13,2)='"+frm.getPcode()+"'";
}
if(frm.getVcode() != null && !frm.getVcode().equals(""))
{
	query+="and substr(habitation_code,8,3)='"+frm.getVcode()+"'";
}
if(frm.getHabCode() != null && !frm.getHabCode().equals(""))
{
	query+="and substr(habitation_code,1,16)='"+frm.getHabCode()+"'";
}
query+="order by 1";



baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for cviewto display details***" + query);

while (baseLineMasterData.rs.next())
{
	BaseLineBean frm1=new BaseLineBean();
	frm1.setHabCode(baseLineMasterData.rs.getString(1));
	frm1.setPanchName(baseLineMasterData.rs.getString(2));
	frm1.setAnganwadiName(baseLineMasterData.rs.getString(3));
	frm1.setAnganCode(baseLineMasterData.rs.getString(4));
	frm1.setBuildingTypename(baseLineMasterData.rs.getString(5));
	frm1.setTotalEnrolment(baseLineMasterData.rs.getString(6));
	frm1.setAvailabilityofToiletfacility(baseLineMasterData.rs.getString(7));
	frm1.setBuildingDept(baseLineMasterData.rs.getString(8));
	frm1.setYearofBuilt(baseLineMasterData.rs.getString(9));
	frm1.setSanitaryUse(baseLineMasterData.rs.getString(10));
	String ss=baseLineMasterData.rs.getString(11);
	Debug.println("ss***********"+ss);
	String pp="";
	String bb="";
	if(baseLineMasterData.rs.getString(11).equals("null") || baseLineMasterData.rs.getString(11).equals("NULL")  ){
		Debug.println("insideif");
		
		pp="-";	
		Debug.println("insideif"+ss);
		frm1.setFunctionalReason(pp);
	}
	else
	{
		Debug.println("Inside else part");
		frm1.setFunctionalReason(baseLineMasterData.rs.getString(11));
	}

		
	String aa=baseLineMasterData.rs.getString(12);
	
	if(baseLineMasterData.rs.getString(12).equals("null") || baseLineMasterData.rs.getString(12).equals("NULL")  )
	{
		bb="-";
		frm1.setReasonforDefunct(bb);
				
	}
	
	else
	{
		frm1.setReasonforDefunct(baseLineMasterData.rs.getString(12));	
	}
	
	
	frm1.setToiletwaterFacilityavailable(baseLineMasterData.rs.getString(13));
	frm1.setDrinkingWaterexist(baseLineMasterData.rs.getString(14));
	frm1.setBinExist(baseLineMasterData.rs.getString(15));
	frm1.setPitExist(baseLineMasterData.rs.getString(16));
	frm1.setSurveyDate(baseLineMasterData.rs.getString(17));
	frm1.setAnganNum(baseLineMasterData.rs.getString(18));
	frm1.setdName(baseLineMasterData.rs.getString(19));
	frm1.setmName(baseLineMasterData.rs.getString(20));
	frm1.setpName(baseLineMasterData.rs.getString(21));
	frm1.setvName(baseLineMasterData.rs.getString(22));
	
	
	habs.add(frm1);

}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine=" + e);
} finally {
baseLineMasterData.closeAll();
Debug.println("ConnCount after closing is " + connCount);
}
return habs;
}

//
public static BaseLineBean getGovtedit(String habCode,String bldgCode)
throws Exception {
ArrayList habs=new ArrayList();
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
String query="";
BaseLineBean frm1=null;
try {

baseLineMasterData.conn = RwsOffices.getConn();
baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
query = "select distinct  panch_code,panch_name,nvl(BLDG_NAME,'-') ,nvl(LATRINE_FACILITY,'-'),nvl(WATER_FACILITY,'-') ,to_char(SURVEY_DATE,'dd/mm/yyyy'),bldg_num,dname,mname,pname,vname   from RWS_BLS_GOVTBLDG_INGP_TBL a,rws_complete_hab_view b where b.panch_code=a.habitation_code and bldg_num='"+bldgCode+"' and habitation_code='"+habCode+"'";





baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for getgovt display details***" + query);

while (baseLineMasterData.rs.next())
{
	 frm1=new BaseLineBean();
	frm1.setHabCode(baseLineMasterData.rs.getString(1));
	frm1.setPanchName(baseLineMasterData.rs.getString(2));
	frm1.setBldgName(baseLineMasterData.rs.getString(3));
	frm1.setLatFacility(baseLineMasterData.rs.getString(4));
	frm1.setWatFacility(baseLineMasterData.rs.getString(5));
	frm1.setSurveyDate(baseLineMasterData.rs.getString(6));
	frm1.setBldgCode(baseLineMasterData.rs.getString(7));
	frm1.setdName(baseLineMasterData.rs.getString(8));
	frm1.setmName(baseLineMasterData.rs.getString(9));
	frm1.setpName(baseLineMasterData.rs.getString(10));
	frm1.setvName(baseLineMasterData.rs.getString(11));
	
	habs.add(frm1);
}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine*********pppppppppp=" + e);
} finally {
baseLineMasterData.closeAll();

}
return frm1;
}

//

//
public static BaseLineBean getSolidedit(String habCode,String solidCode)
throws Exception {
ArrayList habs=new ArrayList();
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
String query="";
BaseLineBean frm1=null;
try {

baseLineMasterData.conn = RwsOffices.getConn();
baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
query = "select   nvl(TOTAL_DUSTBINS,0),nvl(TOTAL_SOAKPITS,0),nvl(TOTAL_COMPOSTPITS,0),nvl(TOTAL_TRICYCLES,0),nvl(EXTRA_FACILITIES,'-'),nvl(OTHER_IN_NO,0),nvl(DRAINAGE_EXIST,'-'),to_char(SURVEY_DATE,'dd/mm/yyyy'),solid_num,dname,mname,pname,vname,panch_code,panch_name   from rws_bls_solid_waste_survey_tbl a,rws_complete_hab_view b where b.panch_code=a.habitation_code and solid_num='"+solidCode+"' and habitation_code='"+habCode+"'";





baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for getedit*******solidwaste details display details***" + query);

while (baseLineMasterData.rs.next())
{
	 frm1=new BaseLineBean();
	 
	 frm1.setTotDustbins(baseLineMasterData.rs.getString(1));
		frm1.setTotSoakpits(baseLineMasterData.rs.getString(2));
		frm1.setTotCompits(baseLineMasterData.rs.getString(3));
		frm1.setTotTricycles(baseLineMasterData.rs.getString(4));
		frm1.setExtraFacilities(baseLineMasterData.rs.getString(5));
		frm1.setOtherInNo(baseLineMasterData.rs.getString(6));
		frm1.setDrainageExist(baseLineMasterData.rs.getString(7));
		frm1.setSurveyDate(baseLineMasterData.rs.getString(8));
		frm1.setSolidCode(baseLineMasterData.rs.getString(9));
		frm1.setdName(baseLineMasterData.rs.getString(10));
		frm1.setmName(baseLineMasterData.rs.getString(11));
		frm1.setpName(baseLineMasterData.rs.getString(12));
		frm1.setvName(baseLineMasterData.rs.getString(13));
		
		frm1.setHabCode(baseLineMasterData.rs.getString(14));
		frm1.setPanchName(baseLineMasterData.rs.getString(15));
		habs.add(frm1);
		
	
}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLinesolidwaste*********pppppppppp=" + e);
} finally {
baseLineMasterData.closeAll();

}
return frm1;
}

//
public static BaseLineBean getSchooledit(String habCode,String schoolCode)
throws Exception {
ArrayList habs=new ArrayList();
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
String query="";
BaseLineBean frm1=null;
try {

baseLineMasterData.conn = RwsOffices.getConn();
baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
query = "select distinct  panch_code,panch_name,nvl(SCHOOLNAME,'-'),nvl(DISECODE,0),nvl(LOCALITY,'-'),nvl(SCHOOLTYPE,'-'),nvl(SCHOOLCATEGORY,'-'),nvl(SCHOOLESTABILISHEDBEFORE2007,'-'),nvl(BOYSCOUNT,0),nvl(GIRLSCOUNT,0),nvl(SANITARYEXIST,'-'),nvl(SANITARYBUILDINGDEPT,'-'),YEAROFBULIT,nvl(BOYSTOILETSCOUNT,0),nvl(GIRLSTOILETSCOUNT,0),nvl(ISWATEREXIST,'-'),nvl(SANITARYUSE,'-'),nvl(DRINKINGWATERFACILITYAVAILABLE,'-'),nvl(BINEXIST,'-'),nvl(PITEXIST,'-'),to_char(SURVEY_DATE,'dd/mm/yyyy'),school_num,dname,mname,pname,vname   from rws_bls_school_sani_survey_tbl a,rws_complete_hab_view b where b.panch_code=a.habitation_code and school_num='"+schoolCode+"' and habitation_code='"+habCode+"'";





baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for getgovt display details***" + query);

while (baseLineMasterData.rs.next())
{
	 frm1=new BaseLineBean();
	frm1.setHabCode(baseLineMasterData.rs.getString(1));
	frm1.setPanchName(baseLineMasterData.rs.getString(2));
	frm1.setSchoolName(baseLineMasterData.rs.getString(3));
	frm1.setDiseCode(baseLineMasterData.rs.getString(4));
	frm1.setLocality(baseLineMasterData.rs.getString(5));

	
	frm1.setSchoolType(baseLineMasterData.rs.getString(6));
	frm1.setSchoolCategory(baseLineMasterData.rs.getString(7));
	frm1.setSchoolEstablieshed2007(baseLineMasterData.rs.getString(8));
	frm1.setBoysCount(baseLineMasterData.rs.getString(9));
	frm1.setGirlsCount(baseLineMasterData.rs.getString(10));
	frm1.setSanitaryExist(baseLineMasterData.rs.getString(11));
	frm1.setSanitaryBuildingdept(baseLineMasterData.rs.getString(12));
	frm1.setYearofBuilt(baseLineMasterData.rs.getString(13));
	frm1.setBoystoiletCount(baseLineMasterData.rs.getString(14));
	frm1.setGirlstoiletCount(baseLineMasterData.rs.getString(15));
	frm1.setIsWaterExist(baseLineMasterData.rs.getString(16));
	frm1.setSanitaryUse(baseLineMasterData.rs.getString(17));
	frm1.setDrinkingwaterFacilityAvailable(baseLineMasterData.rs.getString(18));
	frm1.setBinExist(baseLineMasterData.rs.getString(19));
	frm1.setPitExist(baseLineMasterData.rs.getString(20));
	frm1.setSurveyDate(baseLineMasterData.rs.getString(21));
	frm1.setSchoolCode(baseLineMasterData.rs.getString(22));
	frm1.setdName(baseLineMasterData.rs.getString(23));
	frm1.setmName(baseLineMasterData.rs.getString(24));
	frm1.setpName(baseLineMasterData.rs.getString(25));
	frm1.setvName(baseLineMasterData.rs.getString(26));
	
	habs.add(frm1);
}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLinegetschooledit*********pppppppppp=" + e);
} finally {
baseLineMasterData.closeAll();

}
return frm1;
}

//
public static BaseLineBean getAnganedit(String habCode,String anganCode)
throws Exception {
ArrayList habs=new ArrayList();
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
String query="";
BaseLineBean frm1=null;
try {

baseLineMasterData.conn = RwsOffices.getConn();
baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();





query= "select HABITATION_CODE,panch_name,nvl(ANGANVADINAME,'-'),nvl(ANGANWADICODE,0),nvl(BUILDINGTYPE_NAME,'-'),nvl(TOTALENROLLMENT,0),nvl(AVAILOFTOILETFACILITY,'-') ,nvl(BUILDINGDEPT,'-'),YEARBUILD,nvl(SANITORYUSE,'-'),nvl(FUNCTIONALREASON,'-'),nvl(REASONFORDEFUNT,'-'),nvl(TOILETWATERFACILITYAVAIL,'-') ,nvl(DRINKINGWATEREXIST,'-'),nvl(BINAVAILABLE,'-') ,nvl(PITAVAILABLE,'-'),to_char(SURVEY_DATE,'dd/mm/yyyy') ,ANG_NUM,dname,mname,pname,vname from rws_complete_hab_view a,rws_bls_angan_sani_survey_tbl b where a.panch_code=b.habitation_code and b.habitation_code='"+habCode+"' and ang_num='"+anganCode+"'";

baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for getgovt display details***" + query);

while (baseLineMasterData.rs.next())
{
	 frm1=new BaseLineBean();
	 //
	 frm1.setHabCode(baseLineMasterData.rs.getString(1));
		frm1.setPanchName(baseLineMasterData.rs.getString(2));
		frm1.setAnganwadiName(baseLineMasterData.rs.getString(3));
		frm1.setAnganCode(baseLineMasterData.rs.getString(4));
		frm1.setBuildingTypename(baseLineMasterData.rs.getString(5));
		frm1.setTotalEnrolment(baseLineMasterData.rs.getString(6));
		frm1.setAvailabilityofToiletfacility(baseLineMasterData.rs.getString(7));
		frm1.setBuildingDept(baseLineMasterData.rs.getString(8));
		frm1.setYearofBuilt(baseLineMasterData.rs.getString(9));
		frm1.setSanitaryUse(baseLineMasterData.rs.getString(10));
		String pp="";
		String bb="";
		String ss="";
		//frm1.setFunctionalReason(baseLineMasterData.rs.getString(11));
		//
		if(baseLineMasterData.rs.getString(11).equals("null") || baseLineMasterData.rs.getString(11).equals("NULL")  ){
			Debug.println("insideif");
			
			pp="-";	
			Debug.println("insideif"+ss);
			frm1.setFunctionalReason(pp);
		}
		else
		{
			Debug.println("Inside else part");
			frm1.setFunctionalReason(baseLineMasterData.rs.getString(11));
		}

			
		String aa=baseLineMasterData.rs.getString(12);
		
		if(baseLineMasterData.rs.getString(12).equals("null") || baseLineMasterData.rs.getString(12).equals("NULL")  )
		{
			bb="-";
			frm1.setReasonforDefunct(bb);
					
		}
		
		else
		{
			frm1.setReasonforDefunct(baseLineMasterData.rs.getString(12));	
		}
		

		//
		//frm1.setReasonforDefunct(baseLineMasterData.rs.getString(12));
		frm1.setToiletwaterFacilityavailable(baseLineMasterData.rs.getString(13));
		frm1.setDrinkingWaterexist(baseLineMasterData.rs.getString(14));
		frm1.setBinExist(baseLineMasterData.rs.getString(15));
		frm1.setPitExist(baseLineMasterData.rs.getString(16));
		frm1.setSurveyDate(baseLineMasterData.rs.getString(17));
		frm1.setAnganNum(baseLineMasterData.rs.getString(18));
		frm1.setdName(baseLineMasterData.rs.getString(19));
		frm1.setmName(baseLineMasterData.rs.getString(20));
		frm1.setpName(baseLineMasterData.rs.getString(21));
		frm1.setvName(baseLineMasterData.rs.getString(22));
			
	 //
		habs.add(frm1);
}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLinegetAnganedit*********pppppppppp=" + e);
} finally {
baseLineMasterData.closeAll();

}
return frm1;
}

//
public static BaseLineBean getGovtCommedit(String habCode,String commCode)
throws Exception {
ArrayList habs=new ArrayList();
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
String query="";
BaseLineBean frm1=null;
try {

baseLineMasterData.conn = RwsOffices.getConn();
baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();
query = "select distinct  panch_code,panch_name,nvl(vwsc_formed,'-'),nvl(vwsm_functional,'-'),to_char(SURVEY_DATE,'dd/mm/yyyy'),comm_num,dname,mname,pname,vname   from RWS_BLS_vwm_comm_TBL a,rws_complete_hab_view b where b.panch_code=a.habitation_code and comm_num='"+commCode+"' and habitation_code='"+habCode+"'";





baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for getgovt display details***" + query);

while (baseLineMasterData.rs.next())
{
	 frm1=new BaseLineBean();
	frm1.setHabCode(baseLineMasterData.rs.getString(1));
	frm1.setPanchName(baseLineMasterData.rs.getString(2));
	frm1.setVwscFormed(baseLineMasterData.rs.getString(3));
	frm1.setVwsmFunctional(baseLineMasterData.rs.getString(4));
	frm1.setSurveyDate(baseLineMasterData.rs.getString(5));
	frm1.setCommCode(baseLineMasterData.rs.getString(6));
	frm1.setdName(baseLineMasterData.rs.getString(7));
	frm1.setmName(baseLineMasterData.rs.getString(8));
	frm1.setpName(baseLineMasterData.rs.getString(9));
	frm1.setvName(baseLineMasterData.rs.getString(10));
	
	habs.add(frm1);
}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine*********pppppppppp=" + e);
} finally {
baseLineMasterData.closeAll();

}
return frm1;
}
//
public static void getGovtBldgdetails(BaseLineForm frm)
throws Exception {

BaseLineMasterData baseLineMasterData=new BaseLineMasterData();

boolean exists = false;

String querysources = "";

int i = 0;

String query="";

frm.setBldgName("");
frm.setLatFacility("");
frm.setWatFacility("");
frm.setSurveyDate("");


try {



exists = false;
baseLineMasterData.conn = RwsOffices.getConn();

baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();




query = "select  habitation_code,b.panch_name,nvl(BLDG_NAME,'-') ,LATRINE_FACILITY,WATER_FACILITY ,to_char(SURVEY_DATE,'dd/mm/yyyy')   from RWS_BLS_GOVTBLDG_INGP_TBL a,rws_panchayat_raj_tbl b where b.panch_code=a.habitation_code and substr(habitation_code,1,2)='"+frm.getDist()+"' and substr(habitation_code,6,2)='"+frm.getMcode()+"' and substr(habitation_code,13,2)='"+frm.getPcode()+"' and substr(habitation_code,8,3)='"+frm.getVcode()+"' and habitation_code='"+frm.getHabCode()+"'";
baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for habitationshps****" + query);
i = 0;
while (baseLineMasterData.rs.next())
{

	
	
	frm
			.setBldgName(baseLineMasterData.rs.getString(3));
	frm.setLatFacility(baseLineMasterData.rs
			.getString(4));
	frm
			.setWatFacility(baseLineMasterData.rs.getString(5));
	
	frm
	.setSurveyDate(baseLineMasterData.rs.getString(6));


	

}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine=" + e);
} finally {
baseLineMasterData.closeAll();

}

}

//
public static void getGovtCommdetails(BaseLineForm frm)
throws Exception {

BaseLineMasterData baseLineMasterData=new BaseLineMasterData();

boolean exists = false;

String querysources = "";

int i = 0;

String query="";

frm.setVwscFormed("");
frm.setVwsmFunctional("");

frm.setSurveyDate("");


try {



exists = false;
baseLineMasterData.conn = RwsOffices.getConn();

baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();




query = "select  habitation_code,b.panch_name,VWSC_FORMED,VWSM_FUNCTIONAL,to_char(SURVEY_DATE,'dd/mm/yyyy')   from rws_bls_vwm_comm_tbl a,rws_panchayat_raj_tbl b where b.panch_code=a.habitation_code and substr(habitation_code,1,2)='"+frm.getDist()+"' and substr(habitation_code,6,2)='"+frm.getMcode()+"' and substr(habitation_code,13,2)='"+frm.getPcode()+"' and substr(habitation_code,8,3)='"+frm.getVcode()+"' and habitation_code='"+frm.getHabCode()+"'";
baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for habitationshps****" + query);
i = 0;
while (baseLineMasterData.rs.next())
{

	
	
	frm
			.setVwscFormed(baseLineMasterData.rs.getString(3));
	frm.setVwsmFunctional(baseLineMasterData.rs.getString(4));
	frm
	.setSurveyDate(baseLineMasterData.rs.getString(5));


	

}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine=" + e);
} finally {
baseLineMasterData.closeAll();

}

}


//
public String getServerDate() {
	Debug.println("in getServerDate methodddddddddddddddddddddd");
	String serverDate = "";
	try {
		String query="";
		conn = RwsOffices.getConn();
		stmt = conn.createStatement();
		query = "select to_char(sysdate,'dd/mm/yyyy') from dual";
		Debug.println("qry in get getServerDate:" + query);
		rset = stmt.executeQuery(query);
		tenderMemo tenderMemoBean = null;
		String total = "0";
		if (rset.next()) {
			serverDate = rset.getString(1);
		}
	} catch (Exception e) {
		Debug.println("Exception in getNewBillAmount():" + e);
	} finally {
		try {
			if (rset != null)
				rset.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			Debug.println("EXCEPTION IN CLOSING CONNECTION"
					+ e.getMessage());
		}
	}
	return serverDate;

}

//
public ArrayList getGovtListCommdetails(BaseLineForm frm)
throws Exception {

BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
BaseLineForm baseLineForm=null;
boolean exists = false;
ArrayList habs=new ArrayList();

String querysources = "";

int i = 0;

String query="";



try {




baseLineMasterData.conn = RwsOffices.getConn();

baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();




query = "select distinct  habitation_code,b.panch_name,nvl(VWSC_FORMED,'-'),nvl(VWSM_FUNCTIONAL,'-'),to_char(SURVEY_DATE,'dd/mm/yyyy'),comm_num,dname,mname,pname,vname   from rws_bls_vwm_comm_tbl a,rws_complete_hab_view b where b.panch_code=a.habitation_code ";
if(frm.getDist()!=null && !frm.getDist().equals(""))
{
	query+=" and substr(habitation_code,1,2)='"+frm.getDist()+"'";
}
if(frm.getMcode() != null && !frm.getMcode().equals(""))
{
	query+="and substr(habitation_code,6,2)='"+frm.getMcode()+"'";
}
if(frm.getPcode() != null && !frm.getPcode().equals(""))
{
	query+="and substr(habitation_code,13,2)='"+frm.getPcode()+"'";
}
if(frm.getVcode() != null && !frm.getVcode().equals(""))
{
	query+="and substr(habitation_code,8,3)='"+frm.getVcode()+"'";
}
if(frm.getHabCode() != null && !frm.getHabCode().equals(""))
{
	query+="and substr(habitation_code,1,16)='"+frm.getHabCode()+"'";
}
query+="order by 1";


baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for habitationshps****" + query);
i = 0;
while (baseLineMasterData.rs.next())
{

	baseLineForm=new BaseLineForm();
	
	baseLineForm
			.setVwscFormed(baseLineMasterData.rs.getString(3));
	baseLineForm.setVwsmFunctional(baseLineMasterData.rs.getString(4));
	baseLineForm
	.setSurveyDate(baseLineMasterData.rs.getString(5));
	
	baseLineForm
	.setCommCode(baseLineMasterData.rs.getString(6));
	
	baseLineForm
	.setdName(baseLineMasterData.rs.getString(7));
	
	baseLineForm
	.setmName(baseLineMasterData.rs.getString(8));
	baseLineForm
	.setpName(baseLineMasterData.rs.getString(9));
	baseLineForm
	.setvName(baseLineMasterData.rs.getString(10));
	
	baseLineForm
	.setHabCode(baseLineMasterData.rs.getString(1));
	
	baseLineForm
	.setPanchName(baseLineMasterData.rs.getString(2));
	
	

   habs.add(baseLineForm);
	

}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine=" + e);
} finally {
baseLineMasterData.closeAll();

}
return habs;
}


//
public ArrayList getSolidWastedetails(BaseLineForm frm)
throws Exception {

BaseLineMasterData baseLineMasterData=new BaseLineMasterData();



String querysources = "";

int i = 0;

String query="";


ArrayList solid=new ArrayList();
try {




baseLineMasterData.conn = RwsOffices.getConn();

baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();




query = "select distinct nvl(TOTAL_DUSTBINS,0),nvl(TOTAL_SOAKPITS,0),nvl(TOTAL_COMPOSTPITS,0),nvl(TOTAL_TRICYCLES,0),nvl(EXTRA_FACILITIES,'-'),nvl(OTHER_IN_NO,0),nvl(DRAINAGE_EXIST,'-') ,to_char(SURVEY_DATE,'dd/mm/yyyy'),dname,mname,pname,vname,solid_num,panch_code,panch_name   from rws_bls_solid_waste_survey_tbl a,rws_complete_hab_view b where b.panch_code=a.habitation_code";
if(frm.getDist()!=null && !frm.getDist().equals(""))
{
	query+=" and substr(habitation_code,1,2)='"+frm.getDist()+"'";
}
if(frm.getMcode() != null && !frm.getMcode().equals(""))
{
	query+="and substr(habitation_code,6,2)='"+frm.getMcode()+"'";
}
if(frm.getPcode() != null && !frm.getPcode().equals(""))
{
	query+="and substr(habitation_code,13,2)='"+frm.getPcode()+"'";
}
if(frm.getVcode() != null && !frm.getVcode().equals(""))
{
	query+="and substr(habitation_code,8,3)='"+frm.getVcode()+"'";
}
if(frm.getHabCode() != null && !frm.getHabCode().equals(""))
{
	query+="and substr(habitation_code,1,16)='"+frm.getHabCode()+"'";
}
query+="order by 1";

baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for solid waste****" + query);
i = 0;
while (baseLineMasterData.rs.next())
{

	BaseLineBean frm1=new BaseLineBean();
	
	frm1.setTotDustbins(baseLineMasterData.rs.getString(1));
	frm1.setTotSoakpits(baseLineMasterData.rs.getString(2));
	frm1.setTotCompits(baseLineMasterData.rs.getString(3));
	frm1.setTotTricycles(baseLineMasterData.rs.getString(4));
	frm1.setExtraFacilities(baseLineMasterData.rs.getString(5));
	frm1.setOtherInNo(baseLineMasterData.rs.getString(6));
	frm1.setDrainageExist(baseLineMasterData.rs.getString(7));
	frm1.setSurveyDate(baseLineMasterData.rs.getString(8));
	frm1.setdName(baseLineMasterData.rs.getString(9));
	frm1.setmName(baseLineMasterData.rs.getString(10));
	frm1.setpName(baseLineMasterData.rs.getString(11));
	frm1.setvName(baseLineMasterData.rs.getString(12));
	frm1.setSolidCode(baseLineMasterData.rs.getString(13));
	frm1.setHabCode(baseLineMasterData.rs.getString(14));
	frm1.setPanchName(baseLineMasterData.rs.getString(15));
	solid.add(frm1);
	

	

}



} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine=" + e);
} finally {
baseLineMasterData.closeAll();

}
return solid;
}


//

public ArrayList getCommdetails(String dcode,String mcode,String pcode,String vcode, DataSource dataSource)
throws Exception {
ArrayList habs;
BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
habs = new ArrayList();
boolean exists = false;

String querysources = "";

int i = 0;
ArrayList c = new ArrayList();
String query="";
String query1="";

try {
	BaseLineBean baselineBean = null;
Debug.println("ConnCount is " + connCount);

exists = false;
baseLineMasterData.conn = RwsOffices.getConn();
baseLineMasterData.stmt = baseLineMasterData.conn.createStatement();


//for getting details of hps

	
query = "select distinct panch_code,panch_name,vwsc_formed,vwsm_functional,to_char(SURVEY_DATE,'dd/mm/yyyy')   from RWS_BLS_vwm_comm_TBL a , rws_complete_hab_view b where   b.panch_code=a.habitation_code and dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+pcode+"' and vcode='"+vcode+"' ";
baseLineMasterData.rs = baseLineMasterData.stmt.executeQuery(query);
Debug.println("Query***********for habitationshps****" + query);
i = 0;
while (baseLineMasterData.rs.next())
{


 BaseLineBean baseLineBean=new BaseLineBean();
	
	baseLineBean.setHabCode(baseLineMasterData.rs.getString(1));
	getExistingData1(baseLineBean, baseLineMasterData.rs
		.getString(1));

	baseLineBean.setPanchName(baseLineMasterData.rs
		.getString(2));
	baseLineBean.setVwscFormed(baseLineMasterData.rs.getString(3));
	baseLineBean.setVwsmFunctional(baseLineMasterData.rs
			.getString(4));
	
	baseLineBean
	.setSurveyDate(baseLineMasterData.rs.getString(5));


	habs.add(baseLineBean);
}







} catch (Exception e) {
e.printStackTrace();
Debug.println("The error in getBaseLine=" + e);
} finally {
baseLineMasterData.closeAll();
Debug.println("ConnCount after closing is " + connCount);
}
return habs;
}


//


}//end of main class


//

