/*
 * Created on Jun 15, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;
 
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import nic.watersoft.commons.DAOMessage;
import nic.watersoft.masters.RwsMaster;
public interface WorksDAO 
{
	//added on 5-12-2011 for enable desable add/remove button and milestone and bill details
	    public boolean chkMilestoneBillDetails(String workId) throws Exception;
	public ArrayList getWorks(rws_works_WorkStatus_form bean) throws  Exception;
	public ArrayList getWorks1(rws_works_WorkStatus_bean bean,String subdiv) throws  Exception;
	public ArrayList getWorks22(rws_works_WorkStatus_form bean,String userId) throws  Exception;
    public rws_works_WorkStatus_form getWorkDetails(rws_works_WorkStatus_form bean)throws  Exception;
    public ArrayList getCommWorkDetails(rws_works_WorkStatus_form bean)throws  Exception;
    public rws_works_WorkStatus_form getAdminAndRevisedDetails(String workId)throws Exception;
    public ArrayList getAdminMoreThanOneProg(String workId,rws_works_WorkStatus_bean bean)throws Exception;
    public ArrayList getRevAdminMoreThanOneProg(String workId,rws_works_WorkStatus_bean bean)throws Exception;
    public ArrayList getAdminHabs(String workId,String tableName)throws Exception;
    public String getTsAccordedBy(String amount)throws Exception;
    public ArrayList getAdminSanctionedHabs(String workId)throws Exception;
    public ArrayList getTotHabs(String workId,ArrayList selectedHabs)throws Exception;
    public ArrayList getHabsInMandals(String workId,ArrayList selectedHabs,String[] mcodes)throws Exception;
    public ArrayList getHabsDetails(ArrayList habs)throws Exception;
    public ArrayList getHabsDetails(String workId)throws Exception;
    public ArrayList getTsHabsDetails(String workId)throws Exception;
    public ArrayList getCompHabsDetails(String workId)throws Exception;
    public ArrayList getHabsDetails(String[] habs)throws Exception;
    public String insertTsDetails(rws_works_WorkStatus_form bean,ArrayList Habs)throws Exception;
    public String insertRevTsDetails(rws_works_WorkStatus_bean bean,ArrayList Habs)throws Exception;
    public String insertRevTsDetails(ArrayList revTsBeans,ArrayList SanctionedHabs,rws_works_WorkStatus_form bean)throws Exception;
    public String updateRevTsDetails(rws_works_WorkStatus_bean bean,ArrayList Habs)throws Exception;
    public String updateTsDetails(rws_works_WorkStatus_form bean,ArrayList Habs)throws Exception;
    public rws_works_WorkStatus_bean getTsDetails(String workId)throws Exception;
    public rws_works_WorkStatus_bean getContractorDetails(String workId)throws Exception;
    public rws_works_WorkStatus_bean getGroundingDetails(String workId)throws Exception;
    public ArrayList getTshabs(String workId)throws Exception;
    public DAOMessage delTsDetails(String workId)throws Exception;
    public long getAdminOtherGrantsAmnt(String workId)throws Exception;
    public rws_works_WorkStatus_bean getPopulationDetails(String workID,String tableName)throws Exception;
    public ArrayList getRevTsDetails(String workId)throws Exception;
    public boolean chkRevTsDetails(String workId)throws Exception;
    public DAOMessage delRevTsDetails(String workId)throws Exception;
    public ArrayList getRevTsHabs(String workId)throws Exception;
    public ArrayList getMileStones()throws Exception;
    public ArrayList getStages(String mileStoneCode)throws Exception;
    public int saveContMgtMileStones(DataSource dataSource,ArrayList selectedList,String workCode,rws_works_WorkStatus_bean worksBean) throws Exception;
    public rws_works_WorkStatus_bean getContractorData(String workId)throws Exception;
    public ArrayList getContractorMileStonesData(DataSource ds,String workId)throws Exception;
    public int deleteContractorData(String workId) throws Exception;
    public String getWorkStatus(String workId) throws Exception;
    public String getDivisionOfficeName(String hoc, String coc,String divcode) throws Exception;
    public String getSubDivisionOfficeName(String hoc, String coc,String divcode,String subdivcode) throws Exception;
    public String getLeadHab(String workId) throws Exception;
    public String getHabName(String hab) throws Exception;
    public String getMandalName(String hab) throws Exception;
    public ArrayList getOfficeDetails(String hab_code) throws Exception;
    public String getWorkName(String workId) throws Exception;
    public ArrayList getWorkDetails(String workId) throws Exception;
    public ArrayList getWorkExp(String workId) throws Exception;
    public ArrayList getWorkBenDetails(String workId) throws Exception;
    public int addLeadHab(String workId,String habCode) throws Exception;
    public ArrayList getNewAssetCode(String ccode,String divcode,String subdivcode,String hab,String typeofassetcode) throws Exception;
    public String saveAsset(rws_works_WorkStatus_form rws_works_WorkStatus_form,HttpServletRequest request,DataSource ds) throws Exception;
    public RwsMaster getAssetDetails(String asset_code) throws Exception;
    public boolean checkMandalSubDivision(String hab_code,String divcode,String subdivcode) throws Exception;
    public ArrayList getWorkPhysicalStatus(String work_id) throws Exception;
    public boolean addNotGroundRemarks(String work_id,String remarks) throws Exception;
    public String getNotGroundRemarks(String work_id) throws Exception;
    public ArrayList getAssetBenDetails(String asset_code,String aCode) throws Exception;
    public String getCompInfoAndYieldInfo(String assetCode,String assetTypeCode) throws Exception;
    public String getMainSchemeWork(String workId) throws Exception;
    public String checkMainSchemeWorkConvertedOrNot(String workId) throws Exception;
    public int cancelTheWork(String work_id,String cancelDate) throws Exception;
    public ArrayList getSchoolDetails(String work_id) throws Exception;
    public boolean saveSchoolLinkedToWork(String work_id,String hab_code,String school_code) throws Exception;
    public int saveSchoolLinkedToWork(String work_id,String[] schools) throws Exception;
    public int removeMileStones(String workId,String sno)throws Exception;
    public int saveIndividualTapConn(String indTapLoc,int indTapType,String habCode)throws Exception;
    public int saveSchoolTapStatus(ArrayList schoolDetailsList) throws Exception;
	
}
