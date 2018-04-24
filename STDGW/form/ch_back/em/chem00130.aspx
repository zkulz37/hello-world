<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Result Inquiry</title>
    <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>
function BodyInit()
{
    SetGridHeader(grdInquiry);
    var data="";
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, org_id ||'-'||org_nm  FROM tco_org WHERE del_if = 0 and org_TYPE='06' and  TCO_COMPANY_PK='" + Session("company_pk") + "' order by 2")%>|ALL|Select all";    
    lstOrganiZation.SetDataText(data);
    lstOrganiZation.value="ALL";
    
    data = "<%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%>";    
    lstEvaMaster.SetDataText(data);  
    <%=ESysLib.SetGridColumnComboFormat("grdInquiry", 4,"select a.CODE, a.CODE_NM FROM THR_CODE_detail a, thr_code_master b	WHERE a.DEL_IF=0 and b.del_if = 0 AND a.thr_code_master_pk = b.pk and b.id = 'HR0102' ")%>;  
    OnChangeMaster();
    grdInquiry.GetGridControl().FrozenCols =4;
}
function OnSearch()
{
    dso_Inquiry.Call("SELECT");
    TotalItem();
}
function SetGridHeader(obj)
{
   var fg=grdInquiry.GetGridControl();  
    grdInquiry.AddRow();
    grdInquiry.AddRow();
    grdInquiry.SetCellBold(1,1,1,14,true);
    fg.FixedRows = 3;
    fg.FixCols=1;
    fg.MergeCells = 5;
    
    fg.MergeCol(0) = true
    fg.Cell(0, 0, 0, 2, 0) = "Organization";
    
    fg.MergeCol(1) = true
    fg.Cell(0, 0, 1, 2, 1) = "Emp ID";
    
    fg.MergeCol(2) = true
    fg.Cell(0, 0, 2, 2, 2) = "Emp Name";
    
    fg.MergeCol(3) = true
    fg.Cell(0, 0, 3, 2, 3) = "Evaluation Group"
    
    fg.MergeCol(4) = true
    fg.Cell(0, 0, 4, 2, 4) = "Status";
    
    fg.MergeCol(5) = true
    fg.Cell(0, 0, 5, 2, 5) = "Rank/TO";
    fg.MergeCol(6) = true
    fg.Cell(0, 0, 6, 2, 6) = "Final Grade";


    
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 7, 0, 19) = "Score";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 7, 1, 9) = "Self";
    fg.Cell(0, 2, 7, 2)    = "A";
    fg.Cell(0, 2, 8, 2 )   = "C";
    fg.Cell(0, 2, 9, 2)    = "T";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 10, 1, 14) = "1st Reviewer";
    fg.Cell(0, 2, 10, 2)    = "A";
    fg.Cell(0, 2, 11, 2 )   = "C";
    fg.Cell(0, 2, 12, 2)    = "T";
    fg.Cell(0, 2, 13, 2)    = "Rank";
    fg.Cell(0, 2, 14, 2)    = "Grade";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 15, 1, 19) = "2nd Reviewer";
    fg.Cell(0, 2, 15, 2)    = "A";
    fg.Cell(0, 2, 16, 2 )   = "C";
    fg.Cell(0, 2, 17, 2)    = "T";
    fg.Cell(0, 2, 18, 2)    = "Rank";
    fg.Cell(0, 2, 19, 2)    = "Grade";
    //size of Inquiry grid
    fg.ColWidth(0)=1550;
    fg.ColWidth(1)=900; 
    fg.ColWidth(2)=2800;  
    fg.ColWidth(3)=2080; 
    fg.ColWidth(4)=1200; 
    fg.ColWidth(5)=900;  
    fg.ColWidth(6)=1200; 
    fg.ColWidth(7)=500; 
    fg.ColWidth(8)=500; 
    fg.ColWidth(9)=500; 
    fg.ColWidth(10)=500; 
    fg.ColWidth(11)=500; 
    fg.ColWidth(12)=500; 
    fg.ColWidth(13)=600; 
    fg.ColWidth(14)=600;  
    fg.ColWidth(15)=500;    
    fg.ColWidth(16)=500; 
    fg.ColWidth(17)=500; 
    fg.ColWidth(18)=500;  
    fg.ColWidth(19)=450;   
   
}
function SetGridHeader2(obj)
{
   var fg=grdInquiry.GetGridControl();  
    //grdInquiry.AddRow();
   // grdInquiry.AddRow();
    grdInquiry.SetCellBold(1,1,1,15,true);
    fg.FixedRows = 3;
    fg.FixCols=1;
    fg.MergeCells = 5;
    
    fg.MergeCol(0) = true
    fg.Cell(0, 0, 0, 2, 0) = "Organization";
    
    fg.MergeCol(1) = true
    fg.Cell(0, 0, 1, 2, 1) = "Emp ID";
    
    fg.MergeCol(2) = true
    fg.Cell(0, 0, 2, 2, 2) = "Emp Name";
    
    fg.MergeCol(3) = true
    fg.Cell(0, 0, 3, 2, 3) = "Evaluation Group";
    
    fg.MergeCol(4) = true
    fg.Cell(0, 0, 4, 2, 4) = "Status";
    
    fg.MergeCol(5) = true
    fg.Cell(0, 0, 5, 2, 5) = "Rank/TO";
    fg.MergeCol(6) = true
    fg.Cell(0, 0, 6, 2, 6) = "Final Grade";


    
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 7, 0, 19) = "Score";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 7, 1, 9) = "Self";
    fg.Cell(0, 2, 7, 2)    = "A";
    fg.Cell(0, 2, 8, 2 )   = "C";
    fg.Cell(0, 2, 9, 2)    = "T";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 10, 1, 14) = "1st Reviewer";
    fg.Cell(0, 2, 10, 2)    = "A";
    fg.Cell(0, 2, 11, 2 )   = "C";
    fg.Cell(0, 2, 12, 2)    = "T";
    fg.Cell(0, 2, 13, 2)    = "Rank";
    fg.Cell(0, 2, 14, 2)    = "Grade";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 15, 1, 19) = "2nd Reviewer";
    fg.Cell(0, 2, 15, 2)    = "A";
    fg.Cell(0, 2, 16, 2 )   = "C";
    fg.Cell(0, 2, 17, 2)    = "T";
    fg.Cell(0, 2, 18, 2)    = "Rank";
    fg.Cell(0, 2, 19, 2)    = "Grade";
    //size of Inquiry grid
    fg.ColWidth(0)=1550;
    fg.ColWidth(1)=900; 
    fg.ColWidth(2)=2800;  
    fg.ColWidth(3)=2080; 
    fg.ColWidth(4)=1200; 
    fg.ColWidth(5)=900;  
    fg.ColWidth(6)=1200; 
    fg.ColWidth(7)=500; 
    fg.ColWidth(8)=500; 
    fg.ColWidth(9)=500; 
    fg.ColWidth(10)=500; 
    fg.ColWidth(11)=500; 
    fg.ColWidth(12)=500; 
    fg.ColWidth(13)=600; 
    fg.ColWidth(14)=600;  
    fg.ColWidth(15)=500;    
    fg.ColWidth(16)=500; 
    fg.ColWidth(17)=500; 
    fg.ColWidth(18)=500;  
    fg.ColWidth(19)=450;   
}
function OnDataReceive(obj){
   if(obj.id == "dso_Inquiry"){
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

function OnReport()
{
    var url = System.RootURL + '/reports/ch/em/rpt_chem00130.aspx?p_eva_master_pk=' + lstEvaMaster.value + '&p_org_pk=' + lstOrganiZation.value + '&p_emp_reviewer_pk=' + txtReviewerPK.text + '&p_emp_id=' + txtEmployee.text;
    window.open(url);
}
</script>
<body>
    <gw:data id="dso_Inquiry" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="sp_sel_chem00130">  
                    <input bind="grdInquiry">  
                        <input bind="lstEvaMaster" />
                        <input bind="lstOrganiZation" />
                        <input bind="txtReviewerPK" />  
                        <input bind="txtEmployee" />                                       															
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
                                    <td width="5%">
                                        Organization
                                    </td>
                                    <td width="28%">
                                        <gw:list id="lstOrganiZation" onchange="OnSearch()"/>
                                    </td>
                                    <td width="5%">
                                        Eva.Term
                                    </td>
                                    <td width="10%">
                                        <gw:list id="lstEvaMaster" onchange="OnChangeMaster()" styles="width:100px"/>
                                    </td>
                                    <td width="5%">Employee</td>
                                    <td width="11%">
                                        <gw:textbox id="txtEmployee" onenterkey="OnSearch()"/>
                                    </td>
                                    <td style="width: 11%" align="center">
                                        <gw:label id="lblRecord_M" style="font-weight: bold; color: red; font-size: 12"
                                            text="0 row(s)" />
                                    </td>
                                    <td width="1%"></td>
                                    <td with="3%">
                                        <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                                    </td>
                                    <td width="3%" style="border:0" align="center">
                                     <gw:imgBtn img="excel" id="ibtnReport"    alt="Result Report"  onclick="OnReport()"/>
                                    </td>
                                    <td width="18%" style="border:0" align="left"></td>
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
                                        <gw:grid id="grdInquiry" header="0|1|2|3|4|5|6|7|8|9|1|2|3|4|5|6|7|8|9|10|_11" format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            aligns="0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" defaults="||||||||||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            widths="1500|1500|2000|2000|2000|1000|1000|1000|1000|2000|2000|500|500|500|500|500|0" sorting='T'
                                            styles="width:100%; height:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtReviewerPK" styles="display:none" text="<%=session("EMPLOYEE_PK") %>"/>
</body>
</html>
