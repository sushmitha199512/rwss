// Decompiled by DJ v3.11.11.95 Copyright 2009 Atanas Neshkov  Date: 15/02/2011 11:30:02
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   ComplaintMaster.java

package nic.watersoft.complaints;

import java.util.Collection;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionMapping;

public class ComplaintMaster
{

    public ComplaintMaster()
    {
    }

    public String getRemarksby()
    {
        return remarksby;
    }

    public void setRemarksby(String remarksby)
    {
        this.remarksby = remarksby;
    }

    public Collection getAttendedcomplaints()
    {
        return attendedcomplaints;
    }

    public void setAttendedcomplaints(Collection attendedcomplaints)
    {
        this.attendedcomplaints = attendedcomplaints;
    }

    public Collection getComplaintsalist()
    {
        return complaintsalist;
    }

    public void setComplaintsalist(Collection complaintsalist)
    {
        this.complaintsalist = complaintsalist;
    }

    public String getDcode()
    {
        return dcode;
    }

    public void setDcode(String dcode)
    {
        this.dcode = dcode;
    }

    public String getDistrict()
    {
        return district;
    }

    public void setDistrict(String district)
    {
        this.district = district;
    }

    public String getComplntstatus()
    {
        return complntstatus;
    }

    public void setComplntstatus(String complntstatus)
    {
        this.complntstatus = complntstatus;
    }

    public String getHabName()
    {
        return habName;
    }

    public void setHabName(String habName)
    {
        this.habName = habName;
    }

    public String getPanchayatCode()
    {
        return panchayatCode;
    }

    public void setPanchayatCode(String panchayatCode)
    {
        this.panchayatCode = panchayatCode;
    }

    public String getPanchayatName()
    {
        return panchayatName;
    }

    public void setPanchayatName(String panchayatName)
    {
        this.panchayatName = panchayatName;
    }

    public String getMandal()
    {
        return mandal;
    }

    public void setMandal(String mandal)
    {
        this.mandal = mandal;
    }

    public String getMandalCode()
    {
        return mandalCode;
    }

    public void setMandalCode(String mandalCode)
    {
        this.mandalCode = mandalCode;
    }

    public String getMandalName()
    {
        return mandalName;
    }

    public void setMandalName(String mandalName)
    {
        this.mandalName = mandalName;
    }

    public String getPcode()
    {
        return pcode;
    }

    public void setPcode(String pcode)
    {
        this.pcode = pcode;
    }

    public String getCircleOfficeName()
    {
        return circleOfficeName;
    }

    public void setCircleOfficeName(String circleOfficeName)
    {
        this.circleOfficeName = circleOfficeName;
    }

    public String getDistrictName()
    {
        return districtName;
    }

    public void setDistrictName(String districtName)
    {
        this.districtName = districtName;
    }

    public String getHeadOfficeName()
    {
        return headOfficeName;
    }

    public void setHeadOfficeName(String headOfficeName)
    {
        this.headOfficeName = headOfficeName;
    }

    public boolean getInit()
    {
        return init;
    }

    public void setInit(boolean init)
    {
        this.init = init;
    }

    public String getCircleCode()
    {
        return circleCode;
    }

    public void setCircleCode(String circleCode)
    {
        this.circleCode = circleCode;
    }

    public String getCircleOfficeCode()
    {
        return circleOfficeCode;
    }

    public void setCircleOfficeCode(String circleOfficeCode)
    {
        this.circleOfficeCode = circleOfficeCode;
    }

    public String getDistrictCode()
    {
        return districtCode;
    }

    public void setDistrictCode(String districtCode)
    {
        this.districtCode = districtCode;
    }

    public String getHeadOfficeCode()
    {
        return headOfficeCode;
    }

    public void setHeadOfficeCode(String headOfficeCode)
    {
        this.headOfficeCode = headOfficeCode;
    }

    public String getFromDate()
    {
        return fromDate;
    }

    public void setFromDate(String fromDate)
    {
        this.fromDate = fromDate;
    }

    public String getToDate()
    {
        return toDate;
    }

    public void setToDate(String toDate)
    {
        this.toDate = toDate;
    }

    public String getVill()
    {
        return vill;
    }

    public void setVill(String vill)
    {
        this.vill = vill;
    }

    public String getDistrictCode1()
    {
        return districtCode1;
    }

    public void setDistrictCode1(String districtCode1)
    {
        this.districtCode1 = districtCode1;
    }

    public String getMandalCode1()
    {
        return mandalCode1;
    }

    public void setMandalCode1(String mandalCode1)
    {
        this.mandalCode1 = mandalCode1;
    }

    public String getPanchayatCode1()
    {
        return panchayatCode1;
    }

    public void setPanchayatCode1(String panchayatCode1)
    {
        this.panchayatCode1 = panchayatCode1;
    }

    public String getDist1()
    {
        return dist1;
    }

    public void setDist1(String dist1)
    {
        this.dist1 = dist1;
    }

    public String getHabCode1()
    {
        return habCode1;
    }

    public void setHabCode1(String habCode1)
    {
        this.habCode1 = habCode1;
    }

    public String getMand1()
    {
        return mand1;
    }

    public void setMand1(String mand1)
    {
        this.mand1 = mand1;
    }

    public String getPanch1()
    {
        return panch1;
    }

    public void setPanch1(String panch1)
    {
        this.panch1 = panch1;
    }

    public Collection getDistrictcomplaints()
    {
        return districtcomplaints;
    }

    public void setDistrictcomplaints(Collection districtcomplaints)
    {
        this.districtcomplaints = districtcomplaints;
    }

    public String getAssetLocation()
    {
        return assetLocation;
    }

    public void setAssetLocation(String assetLocation)
    {
        this.assetLocation = assetLocation;
    }

    public String getAttenby()
    {
        return attenby;
    }

    public void setAttenby(String attenby)
    {
        this.attenby = attenby;
    }

    public String getAttendt()
    {
        return attendt;
    }

    public void setAttendt(String attendt)
    {
        this.attendt = attendt;
    }

    public String getRemarks()
    {
        return remarks;
    }

    public void setRemarks(String remarks)
    {
        this.remarks = remarks;
    }

    public Collection getReccomplaints()
    {
        return reccomplaints;
    }

    public void setReccomplaints(Collection reccomplaints)
    {
        this.reccomplaints = reccomplaints;
    }

    public Collection getComplaints()
    {
        return complaints;
    }

    public void setComplaints(Collection complaints)
    {
        this.complaints = complaints;
    }

    public String getAssetCd1()
    {
        return assetCd1;
    }

    public void setAssetCd1(String assetCd1)
    {
        this.assetCd1 = assetCd1;
    }

    public String getOwCode()
    {
        return owCode;
    }

    public void setOwCode(String owCode)
    {
        this.owCode = owCode;
    }

    public String getOwDepth()
    {
        return owDepth;
    }

    public void setOwDepth(String owDepth)
    {
        this.owDepth = owDepth;
    }

    public String getOwDiameter()
    {
        return owDiameter;
    }

    public void setOwDiameter(String owDiameter)
    {
        this.owDiameter = owDiameter;
    }

    public String getOwLocation()
    {
        return owLocation;
    }

    public void setOwLocation(String owLocation)
    {
        this.owLocation = owLocation;
    }

    public String getOwMaxwl()
    {
        return owMaxwl;
    }

    public void setOwMaxwl(String owMaxwl)
    {
        this.owMaxwl = owMaxwl;
    }

    public String getOwMinwl()
    {
        return owMinwl;
    }

    public void setOwMinwl(String owMinwl)
    {
        this.owMinwl = owMinwl;
    }

    public String getOwNormalwl()
    {
        return owNormalwl;
    }

    public void setOwNormalwl(String owNormalwl)
    {
        this.owNormalwl = owNormalwl;
    }

    public String getOwQuality()
    {
        return owQuality;
    }

    public void setOwQuality(String owQuality)
    {
        this.owQuality = owQuality;
    }

    public String getShpAvgTime()
    {
        return shpAvgTime;
    }

    public void setShpAvgTime(String shpAvgTime)
    {
        this.shpAvgTime = shpAvgTime;
    }

    public String getShpCode()
    {
        return shpCode;
    }

    public void setShpCode(String shpCode)
    {
        this.shpCode = shpCode;
    }

    public String getShpDepth()
    {
        return shpDepth;
    }

    public void setShpDepth(String shpDepth)
    {
        this.shpDepth = shpDepth;
    }

    public String getShpDiameter()
    {
        return shpDiameter;
    }

    public void setShpDiameter(String shpDiameter)
    {
        this.shpDiameter = shpDiameter;
    }

    public String getShpHygiene()
    {
        return shpHygiene;
    }

    public void setShpHygiene(String shpHygiene)
    {
        this.shpHygiene = shpHygiene;
    }

    public String getShpLocation()
    {
        return shpLocation;
    }

    public void setShpLocation(String shpLocation)
    {
        this.shpLocation = shpLocation;
    }

    public String getShpYield()
    {
        return shpYield;
    }

    public void setShpYield(String shpYield)
    {
        this.shpYield = shpYield;
    }

    public String getPondCode()
    {
        return pondCode;
    }

    public void setPondCode(String pondCode)
    {
        this.pondCode = pondCode;
    }

    public String getPondName()
    {
        return pondName;
    }

    public void setPondName(String pondName)
    {
        this.pondName = pondName;
    }

    public String getPondSize()
    {
        return pondSize;
    }

    public void setPondSize(String pondSize)
    {
        this.pondSize = pondSize;
    }

    public String getPondVolume()
    {
        return pondVolume;
    }

    public void setPondVolume(String pondVolume)
    {
        this.pondVolume = pondVolume;
    }

    public String getAssetCode()
    {
        return assetCode;
    }

    public void setAssetCode(String assetCode)
    {
        this.assetCode = assetCode;
    }

    public String getAssetName()
    {
        return assetName;
    }

    public void setAssetName(String assetName)
    {
        this.assetName = assetName;
    }

    public String getAssetCd()
    {
        return assetCd;
    }

    public void setAssetCd(String assetCd)
    {
        this.assetCd = assetCd;
    }

    public String getCassetCd()
    {
        return cassetCd;
    }

    public void setCassetCd(String cassetCd)
    {
        this.cassetCd = cassetCd;
    }

    public String getCond()
    {
        return cond;
    }

    public void setCond(String cond)
    {
        this.cond = cond;
    }

    public String getDiameterOfBorewell()
    {
        return diameterOfBorewell;
    }

    public void setDiameterOfBorewell(String diameterOfBorewell)
    {
        this.diameterOfBorewell = diameterOfBorewell;
    }

    public String getDrillYear()
    {
        return drillYear;
    }

    public void setDrillYear(String drillYear)
    {
        this.drillYear = drillYear;
    }

    public String getHpCode()
    {
        return hpCode;
    }

    public void setHpCode(String hpCode)
    {
        this.hpCode = hpCode;
    }

    public String getLocation()
    {
        return location;
    }

    public void setLocation(String location)
    {
        this.location = location;
    }

    public String getStaticWaterLevel()
    {
        return staticWaterLevel;
    }

    public void setStaticWaterLevel(String staticWaterLevel)
    {
        this.staticWaterLevel = staticWaterLevel;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getSummerWaterLevel()
    {
        return summerWaterLevel;
    }

    public void setSummerWaterLevel(String summerWaterLevel)
    {
        this.summerWaterLevel = summerWaterLevel;
    }

    public String getAsstlist()
    {
        return asstlist;
    }

    public void setAsstlist(String asstlist)
    {
        this.asstlist = asstlist;
    }

    public String getComplntdesc()
    {
        return complntdesc;
    }

    public void setComplntdesc(String complntdesc)
    {
        this.complntdesc = complntdesc;
    }

    public String getSourceCode()
    {
        return sourceCode;
    }

    public void setSourceCode(String sourceCode)
    {
        this.sourceCode = sourceCode;
    }

    public String getMode()
    {
        return mode;
    }

    public void setMode(String mode)
    {
        this.mode = mode;
    }

    public String getDist()
    {
        return dist;
    }

    public void setDist(String dist)
    {
        this.dist = dist;
    }

    public String getMand()
    {
        return mand;
    }

    public void setMand(String mand)
    {
        this.mand = mand;
    }

    public String getPanch()
    {
        return panch;
    }

    public void setPanch(String panch)
    {
        this.panch = panch;
    }

    public String getHabCode()
    {
        return habCode;
    }

    public void setHabCode(String habCode)
    {
        this.habCode = habCode;
    }

    public String getAsset()
    {
        return asset;
    }

    public void setAsset(String asset)
    {
        this.asset = asset;
    }

    public String getComplntno()
    {
        return complntno;
    }

    public void setComplntno(String complntno)
    {
        this.complntno = complntno;
    }

    public String getComplntdt()
    {
        return complntdt;
    }

    public void setComplntdt(String complntdt)
    {
        this.complntdt = complntdt;
    }

    public String getComplntgvn()
    {
        return complntgvn;
    }

    public void setComplntgvn(String complntgvn)
    {
        this.complntgvn = complntgvn;
    }

    public String getCassetcode()
    {
        return cassetcode;
    }

    public void setCassetcode(String cassetcode)
    {
        this.cassetcode = cassetcode;
    }

    public Collection getAssts()
    {
        return assts;
    }

    public void setAssts(Collection assts)
    {
        this.assts = assts;
    }

    public String getComplntDate()
    {
        return complntDate;
    }

    public void setComplntDate(String complntDate)
    {
        this.complntDate = complntDate;
    }

    public String getShpAvgHours()
    {
        return shpAvgHours;
    }

    public void setShpAvgHours(String shpAvgHours)
    {
        this.shpAvgHours = shpAvgHours;
    }

    public String getAssetCd2()
    {
        return assetCd2;
    }

    public void setAssetCd2(String assetCd2)
    {
        this.assetCd2 = assetCd2;
    }

    public Collection getComplaintsnotattended()
    {
        return complaintsnotattended;
    }

    public void setComplaintsnotattended(Collection complaintsnotattended)
    {
        this.complaintsnotattended = complaintsnotattended;
    }

    public void reset(ActionMapping mapping, HttpServletRequest request)
    {
        attenby = " ";
        attendt = " ";
        complntstatus = " ";
        remarksby = "";
        complntno = "";
        sourceCode = "";
    }

    private String mode;
    private String dist;
    private String dist1;
    private String mand1;
    private String panch1;
    private String habCode1;
    private String districtCode1;
    private String remarksby;
    private String panchayatCode1;
    private String mandalCode1;
    private String mandal;
    private String dcode;
    private String district;
    private Collection complaintsnotattended;
    private Collection complaintsalist;
    private Collection attendedcomplaints;
    private String pcode;
    private String mandalCode;
    private String mandalName;
    private String panchayatCode;
    private String panchayatName;
    private String habName;
    private String complntstatus;
    private String vill;
    private String toDate;
    private String fromDate;
    private String headOfficeCode;
    private String circleOfficeCode;
    private String districtCode;
    private boolean init;
    private String headOfficeName;
    private String circleOfficeName;
    private String districtName;
    private String circleCode;
    private String mand;
    private String panch;
    private String habCode;
    private String asset;
    private String assetLocation;
    private Collection districtcomplaints;
    private String complntno;
    private String complntgvn;
    private String complntdesc;
    private String complntDate;
    private String cassetcode;
    private String asstlist;
    private Collection assts;
    private String attendt;
    private String remarks;
    private String attenby;
    private Collection complaints;
    private Collection reccomplaints;
    private String assetCd;
    private String assetCd1;
    private String cassetCd;
    private String hpCode;
    private String location;
    private String status;
    private String cond;
    private String diameterOfBorewell;
    private String staticWaterLevel;
    private String summerWaterLevel;
    private String drillYear;
    private String assetCode;
    private String assetName;
    private String pondCode;
    private String pondName;
    private String pondSize;
    private String pondVolume;
    private String owCode;
    private String owLocation;
    private String owDiameter;
    private String owDepth;
    private String owNormalwl;
    private String owMinwl;
    private String owMaxwl;
    private String owQuality;
    private String shpCode;
    private String shpLocation;
    private String shpDiameter;
    private String shpDepth;
    private String shpAvgHours;
    private String assetCd2;
    private String shpHygiene;
    private String shpAvgTime;
    private String shpYield;
    private String complntdt;
    private String sourceCode;
}
