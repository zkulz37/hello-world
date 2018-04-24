<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Result Inquiry</title>
    <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>
function BodyInit()
{
    txtEva_Emp_PK.text = "<%=Session("EMPLOYEE_PK")%>";
    var data="";
//    data = "<%=ESysLib.SetListDataSQL("SELECT pk, org_id ||'-'||org_nm  FROM tco_org WHERE del_if = 0 and org_TYPE='06' and  TCO_COMPANY_PK='" + session("company_pk")+ "' order by 2" )%>|ALL|Select all";    
//    lstOrganiZation.SetDataText(data);
//    lstOrganiZation.value="ALL";
//    ls_data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.GROUP_ID || '-' || a.group_nm FROM thr_eva_group a WHERE a.del_if = 0")%>";
//    lstEvaluationGrp.SetDataText(ls_data+ "|%|Select ALL");
//    lstEvaluationGrp.SetDataText("%");
    data = "<%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%>|%|Select All";
    lstEvaMaster.SetDataText(data);
//    data = "<%=ESysLib.SetListDataSQL("select a.CODE, a.CODE_NM FROM THR_CODE_detail a, thr_code_master b	WHERE a.DEL_IF=0 and b.del_if = 0 AND a.thr_code_master_pk = b.pk and b.id = 'HR0102' ")%>|%|Select all";    
//    lstStatus.SetDataText(data);
//    lstStatus.value = "%";
    <%=ESysLib.SetGridColumnComboFormat("grdInquiry", 11,"select a.CODE, a.CODE_NM FROM THR_CODE_detail a, thr_code_master b	WHERE a.DEL_IF=0 and b.del_if = 0 AND a.thr_code_master_pk = b.pk and b.id = 'HR0102' ")%>;
    grdInquiry.GetGridControl().FrozenCols = 4;   
    OnSearch(); 
}

function OnSearch()
{
    dso_Inquiry.Call("SELECT");
}
function OnPrint()
{
//    if(grdInquiry.row < 1)
//    {
//        alert("Please select one staff on the grid to print.");
//        return;
//    }
//        var  url= System.RootURL + "/reports/ch/em/rptEvalResultInquiry1.aspx?p_thr_eva_emp_pk="+grdInquiry.GetGridData(grdInquiry.row,42);
//        System.OpenTargetPage( url, "_blank" );
        
         //var url = System.RootURL + "/system/ReportEngine.aspx?file=ch/em/EvalResultInquiry.rpt&procedure=SP_SEL_CHEM00120_1|SP_SEL_CHEM00120_2|SP_SEL_CHEM00120_3"
        //+ "&parameter="+grdInquiry.GetGridData(grdInquiry.row,37)+"|"+grdInquiry.GetGridData(grdInquiry.row,37)+"|"+grdInquiry.GetGridData(grdInquiry.row,37);
        //window.open(url);
}
function OnPrint2()
{
         //var  url= System.RootURL + "/reports/ch/em/rptEvalResultInquiry2.aspx?p_org_pk="+lstOrganiZation.GetData()+"&p_eva_master_pk="+lstEvaMaster.GetData()
         //+"&p_empployee="+txtEmployee.text+"&p_eva_status="+lstStatus.GetData()+"&p_eva_group="+lstEvaluationGrp.GetData();
        //System.OpenTargetPage( url, "_blank" );
        
        
        //mr phuc
        var  url= System.RootURL + "/reports/ch/em/rptEvalResultInquiry1.aspx?p_thr_eva_emp_pk="+ txtEva_Emp_PK.text + "&p_evamaster=" + lstEvaMaster.value;
        System.OpenTargetPage( url, "_blank" );
}

function SetGridHeader2(obj)
{
   var fg=grdInquiry.GetGridControl();  
    grdInquiry.SetCellBold(1,0,2,41,true);
    fg.Cell(12, 0, 0, 2, fg.Cols-2) = 8;
    fg.FixedRows = 3;
    fg.FixCols=1;
    fg.MergeCells = 5;
    
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 0, 0, 1) = "Organization";
    
    fg.MergeCol(0) = true
    fg.Cell(0, 1, 1, 2, 0)     = "Department";
    fg.MergeCol(1) = true
    fg.Cell(0, 1, 1, 2, 1 )    = "Team/Section";
    
    fg.MergeCol(2) = true
    fg.Cell(0, 0, 2, 2, 2) = "Emp ID";
    
    fg.MergeCol(3) = true
    fg.Cell(0, 0, 3, 2, 3) = "Emp Name";
    
    fg.MergeCol(4) = true
    fg.Cell(0, 0, 4, 2, 4) = "Joined Date"
    
    fg.MergeCol(5) = true
    fg.Cell(0, 0, 5, 2, 5) = "Worked Month"
    
    fg.MergeCol(6) = true
    fg.Cell(0, 0, 6, 2, 6) = "Emp Status"
    
    
    fg.MergeCol(7) = true
    fg.Cell(0, 0, 7, 2, 7) = "Job Title"
    
    fg.MergeCol(8) = true
    fg.Cell(0, 0, 8, 2, 8) = "Evaluation Group"
    
    fg.MergeCol(9) = true
    fg.Cell(0, 0, 9, 2, 9) = "First Reviewer"
    
    fg.MergeCol(10) = true
    fg.Cell(0, 0, 10, 2, 10) = "Second Reviewer"
    
    fg.MergeCol(11) = true
    fg.Cell(0, 0, 11, 2, 11) = "Status";
    
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 12, 0, 41) = "Score";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 12, 1, 20) = "Final";
    fg.Cell(0, 2, 12, 2)     = "A-Scose";
    fg.Cell(0, 2, 13, 2 )    = "A-Rank";
    fg.Cell(0, 2, 14, 2)     = "A-Grade";
    fg.Cell(0, 2, 15, 2)    = "C-Score";
    fg.Cell(0, 2, 16, 2)    = "C-Rank";
    fg.Cell(0, 2, 17, 2)    = "C-Grade";
    fg.Cell(0, 2, 18, 2)    = "T-Score";
    fg.Cell(0, 2, 19, 2)    = "T-Rank";
    fg.Cell(0, 2, 20, 2)    = "T-Grade";
    
    
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 21, 1, 29) = "Second Reviewer";
    fg.Cell(0, 2, 21, 2)    = "A-Score";
    fg.Cell(0, 2, 22, 2 )   = "A-Rank";
    fg.Cell(0, 2, 23, 2)    = "A-Grade";
    fg.Cell(0, 2, 24, 2)    = "C-Score";
    fg.Cell(0, 2, 25, 2)    = "C-Rank";
    fg.Cell(0, 2, 26, 2)    = "C-Grade";
    fg.Cell(0, 2, 27, 2)    = "T-Score";
    fg.Cell(0, 2, 28, 2)    = "T-Rank";
    fg.Cell(0, 2, 29, 2)    = "T-Grade";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 30, 1,38) = "First Reviewer";
    fg.Cell(0, 2, 30, 2)    = "A-Score";
    fg.Cell(0, 2, 31, 2 )   = "A-Rank";
    fg.Cell(0, 2, 32, 2)    = "A-Grade";
    fg.Cell(0, 2, 33, 2)    = "C-Score";
    fg.Cell(0, 2, 34, 2)    = "C-Rank";
    fg.Cell(0, 2, 35, 2)    = "C-Grade";
    fg.Cell(0, 2, 36, 2)    = "T-Score";
    fg.Cell(0, 2, 37, 2)    = "T-Rank";
    fg.Cell(0, 2, 38, 2)    = "T-Grade";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 39, 1, 41) = "Self";
    fg.Cell(0, 2, 39, 2)    = "A-Score";
    fg.Cell(0, 2, 40, 2 )   = "C-Score";
    fg.Cell(0, 2, 41, 2)    = "T-Score";
    
    //size of Inquiry grid
    fg.ColWidth(0)=1550;
    fg.ColWidth(1)=1550;
    fg.ColWidth(2)=900; 
    fg.ColWidth(3)=2000;
    fg.ColWidth(4)=1200;  
    fg.ColWidth(5)=1000;
    fg.ColWidth(6)=1000;
    
    fg.ColWidth(7)=2000;  
    fg.ColWidth(8)=1600;
    fg.ColWidth(9)=2080;
    fg.ColWidth(10)=2080; 
    fg.ColWidth(11)=1000; 
    fg.ColWidth(12)=700;  
    fg.ColWidth(13)=700; 
    fg.ColWidth(14)=700; 
    fg.ColWidth(15)=700; 
    fg.ColWidth(16)=700; 
    fg.ColWidth(17)=700; 
    fg.ColWidth(18)=700; 
    fg.ColWidth(19)=700; 
    fg.ColWidth(20)=700; 
    fg.ColWidth(21)=700;  
    fg.ColWidth(22)=700;    
    fg.ColWidth(23)=700; 
    fg.ColWidth(24)=700; 
    fg.ColWidth(25)=700;  
    fg.ColWidth(26)=700;   
    fg.ColWidth(27)=700;
    fg.ColWidth(28)=700;
    fg.ColWidth(29)=700;
    fg.ColWidth(30)=700;
    fg.ColWidth(31)=700;
    fg.ColWidth(32)=700;
    fg.ColWidth(33)=700;
    fg.ColWidth(34)=700;
    fg.ColWidth(35)=700;
    fg.ColWidth(36)=700;
    fg.ColWidth(37)=700;
    fg.ColWidth(38)=700;
    fg.ColWidth(39)=700;
    fg.ColWidth(40)=700;
    fg.ColWidth(41)=700;
}
function OnDataReceive(obj){
   if(obj.id == "dso_Inquiry"){
        TotalItem();
        SetGridHeader2(grdInquiry);
    }
}
function TotalItem()
{
    if (grdInquiry.rows > 1)
    {
        var iNumRecord    =  grdInquiry.rows-3;
        lblRecord_M.text = iNumRecord  + " Row(s)" ;     
    }
}
</script>

<body>
    <gw:data id="dso_Inquiry" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="sp_sel_chem00160">  
                    <input bind="grdInquiry">  
                    <input bind="lstEvaMaster" />
                    <input bind="txtEva_Emp_PK" />                                    															
                </input> 
                <output bind="grdInquiry" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%" valign="top">
                        <td>
                            <fieldset>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        </td><td width="5%">
                                            Eva.Term
                                        </td>
                                        <td width="10%">
                                            <gw:list id="lstEvaMaster" onchange="OnSearch()" styles="width:100px"/>
                                        </td>
                                        <td style="width: 64%" align="center">
                                        <td style="width: 15%" align="center">
                                            <gw:label id="lblRecord_M" style="font-weight: bold; color: red; font-size: 12" text="0 row(s)" />
                                        </td>
                                        <td with="2%">
                                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                                        </td>
                                        <td width="2%">
                                            <gw:imgbtn id="btnPrint2" img="excel" alt="Print multi" onclick="OnPrint2()" />
                                        </td>
                                        
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 96%" valign="top">
                        <td>
                            <table style="width: 100%; height: 100%" border="1">
                                <tr style="height: 100%">
                                    <td>
                                        <gw:grid id="grdInquiry" 
                                            header="0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|_23|24|25|26|27|28|29|30|31|_32|33|34|35|36|37|38|39|40|41|_42" 
                                            format="0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                            aligns="0|0|0|0|0|3|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
                                            defaults="|||||||||||||||||||||||||||||||||||||||||||" 
                                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                            widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                            sorting='T' styles="width:100%; height:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtEva_Emp_PK" styles="display:none" />
</body>
</html>
