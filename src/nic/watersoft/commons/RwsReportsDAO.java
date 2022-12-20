/*
 * Created on 13-03-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Hashtable;

/**
 * @author RWSS_DPT1
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class RwsReportsDAO {

	public double calculateAmount(Connection conn, String work_id,
			Hashtable popHash, String subProg, double sanctionAmount)
			throws Exception {

		double plainSancation = 0;
		ResultSet rrs = null;
		Statement ss = null;
		try {
			ss = conn.createStatement();

			String habQuery = "select hab_code from rws_admn_hab_lnk_tbl where work_id='"
					+ work_id + "'";
			rrs = ss.executeQuery(habQuery);

			double plainPop = 0, scPop = 0, stPop = 0;

			double totalp = 0;

			while (rrs.next()) {

				String hab_code = rrs.getString(1);
				String pop = (String) popHash.get(hab_code);
				if (pop != null && !pop.equals("0")) {
					String popValues[] = pop.split("@");

					plainPop += Integer.parseInt(popValues[0]);
					scPop += Integer.parseInt(popValues[1]);
					stPop += Integer.parseInt(popValues[2]);

				}

			}
			totalp = (plainPop + scPop + stPop);

			if (totalp > 0) {
				if (subProg.equals("PLAIN")) {
					plainSancation = (sanctionAmount * plainPop) / totalp;
				} else if (subProg.equals("SC")) {
					plainSancation = (sanctionAmount * scPop) / totalp;
				} else if (subProg.equals("ST")) {
					plainSancation = (sanctionAmount * stPop) / totalp;

				}
			} else {
				plainSancation = 0;

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (rrs != null)
				rrs.close();
			if (ss != null)
				ss.close();
		}

		return plainSancation;
	}

	public int findSanctionedHabs(Connection conn, Hashtable popHash,
			String work_id, String subProg,String habsTable) throws Exception {
		double plainSancation = 0;
		ResultSet rrs = null;
		Statement ss = null;
		int count = 0;
		try {

			ss = conn.createStatement();

			String habQuery = "select hab_code  from "+habsTable+"  where work_id='"
					+ work_id + "'";
			rrs = ss.executeQuery(habQuery);

			int plainPop = 0, scPop = 0, stPop = 0;
			while (rrs.next()) {
				String hab_code = rrs.getString(1);
				String pop = (String) popHash.get(hab_code);
				if (pop != null && !pop.equals("0")) {
					String popValues[] = pop.split("@");

					plainPop = Integer.parseInt(popValues[0]);
					scPop = Integer.parseInt(popValues[1]);
					stPop = Integer.parseInt(popValues[2]);
					int totPop = plainPop + scPop + stPop;
					if (subProg.equals("PLAIN")) {

						double result = plainPop * totPop / 100;
						//System.out.println("plainPop:"+plainPop);
						//System.out.println("totalp:"+totPop);
						// System.out.println("Plain"+result);
						if (result >= 40) {
							count++;
						}

					} else if (subProg.equals("SC")) {
						double result = scPop * totPop / 100;
						if (result >= 40) {
							count++;
						}

					} else if (subProg.equals("ST")) {
						double result = stPop * totPop / 100;
						if (result >= 40) {
							count++;
						}

					}

				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (rrs != null)
				rrs.close();
			if (ss != null)
				ss.close();
		}
		return count;
	}
}