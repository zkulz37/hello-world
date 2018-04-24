<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation MRO</title>
    <%  ESysLib.SetUser("hr")%>
</head>

<script>
function BodyInit()
{
    txtEva_Emp_PK.text = "<%=Session("EMPLOYEE_PK")%>";
    var data="";
//    data = "<%=ESysLib.SetListDataSQL("SELECT pk, org_id ||'-'||org_nm  FROM comm.tco_org WHERE del_if = 0 and org_TYPE='06' and  TCO_COMPANY_PK='" + session("company_pk")+ "' order by 2" )%>|ALL|Select all";    
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
//    <%=ESysLib.SetGridColumnComboFormat("grdInquiry", 11,"select a.CODE, a.CODE_NM FROM THR_CODE_detail a, thr_code_master b	WHERE a.DEL_IF=0 and b.del_if = 0 AND a.thr_code_master_pk = b.pk and b.id = 'HR0102' ")%>;
//    grdInquiry.GetGridControl().FrozenCols = 4;   
//    OnSearch(); 

        grdInquiry.AddRow();
        grdInquiry.AddRow();
        SetGridHeader2('');
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
        
         //var url = System.RootURL + "/system/ReportEngine.aspx?file=ch/em/EvalResultInquiry.rpt&procedure=HR.SP_SEL_CHEM00120_1|HR.SP_SEL_CHEM00120_2|HR.SP_SEL_CHEM00120_3"
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
    grdInquiry.SetCellBold(1,0,2,12,true);
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
    fg.Cell(0, 0, 5, 0, 12) = "Result";    
    
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
//    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 11, 1, 12) = "Final";
    fg.Cell(0, 2, 11, 2)    = "T-Rank";
    fg.Cell(0, 2, 12, 2 )   = "T-Grade";
    
    fg.ColWidth(0)=1550;
    fg.ColWidth(1)=1550;
    fg.ColWidth(2)=900; 
    fg.ColWidth(3)=2000;
    fg.ColWidth(4)=1200; 
        
    fg.ColWidth(5)=900;  
    fg.ColWidth(6)=900;
    fg.ColWidth(7)=900;
    fg.ColWidth(8)=900; 
    fg.ColWidth(9)=900; 
    fg.ColWidth(10)=900;  
    fg.ColWidth(11)=900; 
    fg.ColWidth(12)=900; 
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
            <dso type="grid" function="HR.sp_sel_chem00170">  
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
                                            header="0|1|2|3|4|5|6|7|8|9|10|11|12" 
                                            format="0|0|0|0|4|0|0|0|0|0|0|0|0"
                                            aligns="0|0|0|0|0|3|0|0|0|0|0|1|1"
                                            defaults="||||||||||||"
                                           editcol="0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            widths="0|0|0|0|0|0|0|0|0|0|0|0|0"
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
