<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Result Inquiry</title>
    <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>
var col_dept            = 0,
    col_org_nm          = 1,
    col_emp_id          = 2,
    col_full_name       = 3,
    col_job_tittle      = 4,
    col_first_rank      = 5,
    col_first_grade     = 6,
    col_second_rank     = 7,
    col_second_grade    = 8,
    col_mro_rank        = 9,
    col_mro_grade       = 10,
    col_mro_final_rank  = 11,
    col_mro_final_grade = 12,
    col_final_rank      = 13,
    col_final_grade     = 14,
    col_mro_final_score = 15,
    col_thr_eva_emp_pk  = 16;

function BodyInit()
{
    var data="";
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, org_id ||'-'||org_nm  FROM tco_org WHERE del_if = 0 and org_TYPE='06' and  TCO_COMPANY_PK='" + session("company_pk")+ "' order by 2" )%>|ALL|Select all";    
    lstOrganiZation.SetDataText(data);
    lstOrganiZation.value="ALL";
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.GROUP_ID || '-' || a.group_nm FROM thr_eva_group a WHERE a.del_if = 0 and pk = 67")%>";
    lstEvaluationGrp.SetDataText(ls_data);
    //lstEvaluationGrp.SetDataText("%");
    data = "<%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%>";    
    lstEvaMaster.SetDataText(data);    
    data = "<%=ESysLib.SetListDataSQL("select a.CODE, a.CODE_NM FROM THR_CODE_detail a, thr_code_master b	WHERE a.DEL_IF=0 and b.del_if = 0 AND a.thr_code_master_pk = b.pk and b.id = 'HR0102' ")%>|%|Select all";    
    lstStatus.SetDataText(data);
    lstStatus.value = "%";
    <%=ESysLib.SetGridColumnComboFormat("grdInquiry", 10,"SELECT 'S' , 'S' from dual union all SELECT 'A' , 'A' from dual union all SELECT 'B' , 'B' from dual union all SELECT 'C' , 'C' from dual union all SELECT 'D' , 'D' from dual")%>;
    //<%=ESysLib.SetGridColumnComboFormat("grdInquiry", 12,"SELECT 'S' , 'S' from dual union all SELECT 'A' , 'A' from dual union all SELECT 'B' , 'B' from dual union all SELECT 'C' , 'C' from dual union all SELECT 'D' , 'D' from dual")%>;
    OnChangeMaster();
    grdInquiry.GetGridControl().FrozenCols = 4;
}
function OnSearch()
{
    dso_Inquiry.Call("SELECT");
}
function OnSave()
{
    dso_Inquiry.Call();
}
function OnPrint()
{
    if(grdInquiry.row < 1){
        alert("Please select one staff on the grid to print.");
        return;
    }
        var  url= System.RootURL + "/reports/ch/em/rptEvalResultInquiry.aspx?p_thr_eva_emp_pk="+grdInquiry.GetGridData(grdInquiry.row,42);
        System.OpenTargetPage( url, "_blank" );
         //var url = System.RootURL + "/system/ReportEngine.aspx?file=ch/em/EvalResultInquiry.rpt&procedure=SP_SEL_CHEM00120_1|SP_SEL_CHEM00120_2|SP_SEL_CHEM00120_3"
        //+ "&parameter="+grdInquiry.GetGridData(grdInquiry.row,37)+"|"+grdInquiry.GetGridData(grdInquiry.row,37)+"|"+grdInquiry.GetGridData(grdInquiry.row,37);
        //window.open(url);
}
function OnPrint2()
{
         //var  url= System.RootURL + "/reports/ch/em/rptEvalResultInquiry2.aspx?p_org_pk="+lstOrganiZation.GetData()+"&p_eva_master_pk="+lstEvaMaster.GetData()
         //+"&p_empployee="+txtEmployee.text+"&p_eva_status="+lstStatus.GetData()+"&p_eva_group="+lstEvaluationGrp.GetData();
        //System.OpenTargetPage( url, "_blank" );
        
        var  url= System.RootURL + "/reports/ch/em/EvalResultInquiry3.aspx?p_org_pk="+lstOrganiZation.GetData()+"&p_eva_master_pk="+lstEvaMaster.GetData()
        +"&p_empployee="+txtEmployee.text+"&p_eva_status="+lstStatus.GetData()+"&p_eva_group="+lstEvaluationGrp.GetData();
        System.OpenTargetPage( url, "_blank" );
}

function SetGridHeader2(obj)
{
   var fg=grdInquiry.GetGridControl();  
    grdInquiry.SetCellBold(1,0,2,14,true);
    fg.Cell(12, 0, 0, 2, fg.Cols-2) = 8;
    fg.FixedRows = 3;
    fg.FixCols=3;
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
    fg.Cell(0, 0, 4, 2, 4) = "Job Title"
    
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 5, 0, 14) = "Result";    
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 5, 1, 6) = "First Reviewer";
    fg.Cell(0, 2, 5, 2)     = "T-Rank";
    fg.Cell(0, 2, 6, 2 )    = "T-Grade";     

    fg.MergeRow(1) = true
    fg.Cell(0, 1, 7, 1, 8) = "Second Reviewer";
    fg.Cell(0, 2, 7, 2)    = "T-Rank";
    fg.Cell(0, 2, 8, 2 )   = "T-Grade";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 9, 1, 10) = "MRO";
    fg.Cell(0, 2, 9, 2)    = "T-Rank";
    fg.Cell(0, 2, 10, 2 )   = "T-Grade";

    fg.MergeRow(1) = true
    fg.Cell(0, 1, 11, 1, 12) = "MRO Final";
    fg.Cell(0, 2, 11, 2)    = "T-Rank";
    fg.Cell(0, 2, 12, 2 )   = "T-Grade";

    fg.MergeRow(1) = true
    fg.Cell(0, 1, 13, 1, 14) = "Final";
    fg.Cell(0, 2, 13, 2)    = "T-Rank";
    fg.Cell(0, 2, 14, 2 )   = "T-Grade";
    
    fg.MergeCol(13) = true
    fg.Cell(0, 0, 15, 2, 15) = "MRO_FINAL_SCORE";

    fg.MergeCol(14) = true
    fg.Cell(0, 0, 16, 2, 16) = "Emp_PK";
    
    fg.ColWidth(0)=3000;
    fg.ColWidth(1)=3000;
    fg.ColWidth(2)=900; 
    fg.ColWidth(3)=1800;
    fg.ColWidth(4)=1800; 
        
    fg.ColWidth(5)=900;  
    fg.ColWidth(6)=900;
    fg.ColWidth(7)=900;
    fg.ColWidth(8)=900; 
    
    fg.ColWidth(9)=900; 
    fg.ColWidth(10)=900;  
    fg.ColWidth(11)=900; 
    fg.ColWidth(12)=900;
    fg.ColWidth(13)=900;
    fg.ColWidth(14)=900;
     
    
    //fg.AutoSize(0,fg.Cols-1);
}
function OnDataReceive(obj){
   if(obj.id == "dso_Inquiry")
   {
        TotalItem();
        SetGridHeader2(grdInquiry);
    }
}
function OnChangeMaster(){
   // dso_ReviewerList.Call("SELECT");
   OnSearch();
    
}
function TotalItem()
 {
    var iNumRecord    =  grdInquiry.rows-3;
    lblRecord_M.text = iNumRecord  + " Row(s)" ;     
 }
</script>

<body>
    <gw:data id="dso_Inquiry" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="9,10,16" function="sp_sel_chem00170" procedure="sp_upd_chem00170">  
                    <input bind="grdInquiry">  
                    <input bind="lstEvaMaster" />
                    <input bind="lstOrganiZation" />
                    <input bind="lstEvaluationGrp" />  
                    <input bind="txtEmployee" /> 
                    <input bind="lstStatus" />                                       															
                </input> 
                <output bind="grdInquiry" /> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_ReviewerList" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="sp_sel_reviewer_by_master">  
                <input>  
                    <input bind="lstEvaMaster" />
                </input> 
                <output>
                    <output bind="lstEvaluator" /> 
                </output> 
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
                                        <td width="5%">
                                            Organization
                                        </td>
                                        <td width="28%">
                                            <gw:list id="lstOrganiZation" onchange="OnSearch()" />
                                        </td>
                                        <td width="5%">
                                            Eva.Term
                                        </td>
                                        <td width="10%">
                                            <gw:list id="lstEvaMaster" onchange="OnChangeMaster()" styles="width:100px" />
                                        </td>
                                        <td width="5%">
                                            Employee</td>
                                        <td width="11%">
                                            <gw:textbox id="txtEmployee" onenterkey="OnSearch()" />
                                        </td>
                                        <td width="5%" align="center">
                                            Status</td>
                                        <td width="15%">
                                            <gw:list id="lstStatus" onchange="OnSearch()" />
                                        </td>
                                        <td style="width: 9%" align="center">
                                            <gw:label id="lblRecord_M" style="font-weight: bold; color: red; font-size: 12" text="0 row(s)" />
                                        </td>
                                        <td with="2%">
                                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                                        </td>
                                        <td with="2%">
                                            <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                                        </td>
                                        <td width="2%">
                                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                                        </td>
                                        <td width="2%">
                                            <gw:imgbtn id="btnPrint2" img="excel" alt="Print multi" onclick="OnPrint2()" />
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%">
                                    <tr>
                                        <td width="6%">
                                            Eva.Group</td>
                                        <td width="20%">
                                            <gw:list id="lstEvaluationGrp" onchange="OnSearch()" />
                                        </td>
                                        <td width="74%"></td>
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
                                            header="0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|_15|_16" 
                                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                            aligns="0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|0|0"
                                            defaults="||||||||||||||||" 
                                            editcol="0|0|0|0|0|0|0|0|0|1|1|0|0|0|0|0|0"
                                            widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            autosize="true"
                                            debug="false"
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
    <gw:list id="lstEvaluator" onchange="OnSearch()" styles="display:none" />
</body>
</html>
