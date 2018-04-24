<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Page</title>
    <%ESysLib.SetUser("acnt")%>

    <script>
    function BodyInit(){
        System.Translate(document); 
        txtUsedAmount.SetEnable(false);
        txtBalance.SetEnable(false);
        BindDataToList();
    }
    function BindDataToList(){
        var ls_company = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM comm.TCO_COMPANY WHERE DEL_IF=0")%>";
        lstCompany.SetDataText(ls_company);
        var ls_dept = "<%=ESysLib.SetListDataSQL("select pk,dept_nm from comm.tco_dept a where nvl(a.child_yn,'Y')='N' and del_if=0")%>|%|All Department";
        lstDept.SetDataText(ls_dept);
        lstDept.value = "%";
        lstDept2.SetDataText(ls_dept); 
        lstBudgetType.SetDataText("<%=ESysLib.SetListDataFUNC("select acnt.sf_a_get_commoncode('ACBG0050') from dual")%>"); 
        lstCurrency.SetDataText("<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CHAR_1 || ' - ' || CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0040' ORDER BY V.CODE_NM")%>"); 
    }
    function OnSearchList(){
        dsoMasterList.Call("SELECT");
    }
    function OnNew(){
        dsoMaster.StatusInsert();
    }
    function OnSave(){
        if(CheckDataIsValid()){
            dsoMaster.Call();
        }
    }
    function OnDelete(){
    
    }
    function OnPrint(){
    
    }
    function CheckDataIsValid(){
    return true;
    }
    function OnDataReceive(dso){
        if(dso.id == "dsoMaster"){
            SetMasterPKToGrid();
            dsoDetail.Call();
        }
    }
    function OnGridLeftClick(){
        txtMasterPK.text = grdBudgetList.GetGridData(event.row,0);
        dsoMaster.Call("SELECT");
    }
    function SetMasterPKToGrid(){
        for(var i=1;i<grdBudgetDetail.rows;i++){
            if(grdBudgetDetail.GetGridData(i,1) == ""){
                grdBudgetDetail.SetGridText(i,1,txtMasterPK.text);
            }
        }
    }
    function OnGridDetailDblClick()
    {
       if(event.col == 4 || event.col == 5){
        var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCT_PARTNER";
        var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
        if ((object != null) &&(object[0]!="0"))
        {
            grdBudgetDetail.SetGridText(event.row,2,object[3]);//pk
            grdBudgetDetail.SetGridText(event.row,4,object[0]);//code
            grdBudgetDetail.SetGridText(event.row,5,object[1]);//name
        }
       }
    }
function OnSubNew(){
    grdBudgetDetail.AddRow();
}
function OnSubDelete(){
    grdBudgetDetail.DeleteRow();
}
function OnSubUndelete(){
    grdBudgetDetail.UnDeleteRow();
}
    </script>

</head>
<body>
    <gw:data id="dsoMasterList"> 
    <xml> 
        <dso type="grid"   function="ACNT.sp_sel_tac_dept_budget_list" > 
            <input bind="grdBudgetList" >
                <input bind="lstCompany" />
                <input bind="lstDept" />
                <input bind="dtYear" />
            </input>
            <output bind="grdBudgetList" />
        </dso> 
    </xml> 
</gw:data>
    <gw:data id="dsoMaster" onreceive="OnDataReceive(this)"> 
<xml> 
<dso type="control" parameter="0,1,2,3,4,5,6,7,8" function="ACNT.sp_sel_tac_dept_budget" procedure="ACNT.sp_upd_tac_dept_budget"> 
    <inout> 
        <inout bind="txtMasterPK"/>
        <inout bind="lstCompany" />
        <inout bind="lstDept2" />
        <inout bind="lstBudgetType" />
        <inout bind="dtYear2" />
        <inout bind="txtAmount" />
        <inout bind="txtDescription" />
        <inout bind="chkActive" />
        <inout bind="lstCurrency" />
        <inout bind="txtUsedAmount" />
        <inout bind="txtBalance" />
    </inout>
</dso> 
</xml> 
</gw:data>
    <gw:data id="dsoDetail" onreceive="OnDataReceive(this)"> 
<xml> 
    <dso type="grid" parameter="0,1,2,8,9,12,13,14,15,16,17,18,19,20,21,22,23,24" function="ACNT.sp_sel_tac_dept_budgetd" procedure="ACNT.sp_upd_tac_dept_budgetd"> 
        <input bind="grdBudgetDetail" >
            <input bind="txtMasterPK" />
        </input>
        <output bind="grdBudgetDetail" />
    </dso> 
</xml> 
</gw:data>
    <table width="100%" border="1">
        <tr>
            <td with="20%">
                <table width="100%">
                    <tr>
                        <td with="100%">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="26%">
                                        Company</td>
                                    <td width="60%">
                                        <gw:list id="lstCompany" />
                                    </td>
                                    <td width="14%" align="right">
                                        <gw:imgbtn id="btnSearch" img="search" onclick="OnSearchList()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="20%">
                                        Department</td>
                                    <td width="60%">
                                        <gw:list id="lstDept" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="20%">
                                        Year</td>
                                    <td width="20%">
                                        <gw:datebox id="dtYear" type="year" />
                                    </td>
                                    <td width="60%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <gw:grid id="grdBudgetList" header="_PK|Year|Dept ID|Dept Name|Budget Amt|Active" format="0|0|0|0|0|3"
                                aligns="0|0|0|0|0|0" defaults="|||||" editcol="0|0|0|0|0|0" widths="0|1000|1000|2000|1500|800" styles="width:100%; height:430"
                                sorting="T" oncellclick="OnGridLeftClick()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td with="80%">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="10%">
                                        Budget Type</td>
                                    <td width="18%">
                                        <gw:list id="lstBudgetType" />
                                    </td>
                                    <td width="5%">
                                        &nbsp;Year</td>
                                    <td width="10%">
                                        <gw:datebox id="dtYear2" type="year" />
                                    </td>
                                    <td width="5%">Active:</td>
                                    <td width="5%">
                                        <gw:checkbox id="chkActive" defaultvalue="Y|N" value="Y" />
                                    </td>
                                    <td width="10%">&nbsp;Currency</td>
                                    <td width="15%"><gw:list id="lstCurrency" /></td>
                                    <td width="2%">
                                    </td>
                                    <td width="5%">
                                        <gw:imgbtn id="btnNew" img="new" alt="New" onclick="OnNew()" />
                                    </td>
                                    <td width="5%">
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete()" />
                                    </td>
                                    <td width="5%">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                                    </td>
                                    <td width="5%">
                                        <gw:imgbtn id="btnPrint" img="excel" alt="Print" onclick="OnPrint()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="10%">
                                        Department</td>
                                    <td width="18%">
                                        <gw:list id="lstDept2" />
                                    </td>
                                    <td width="10%">
                                        &nbsp;Budget Amount</td>
                                    <td width="15%">
                                        <gw:textbox id="txtAmount" />
                                    </td>
                                    <td width="10%">
                                        &nbsp;Used Amount</td>
                                    <td width="15%">
                                        <gw:textbox id="txtUsedAmount" />
                                    </td>
                                    <td width="7%">
                                        &nbsp;Balance</td>
                                    <td width="15%">
                                        <gw:textbox id="txtBalance" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="10%">
                                        Description</td>
                                    <td width="90%">
                                        <gw:textbox id="txtDescription" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr >
                                    <td width="85%">
                                    </td>
                                    <td width="5%">
                                        <gw:imgbtn id="btnSubNew" img="new" alt="New" onclick="OnSubNew()" />
                                    </td>
                                    <td width="5%">
                                        <gw:imgbtn id="btnSubDelete" img="delete" alt="Delete" onclick="OnSubDelete()" />
                                    </td>
                                    <td width="5%">
                                        <gw:imgbtn id="btnUndelete" img="udelete" alt="Undelete" onclick="OnSubUndelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <gw:grid id="grdBudgetDetail" header="_PK|_MASTER_PK|_TAC_ABACCTCODE_PK|No|Cost Account ID|Cost Account Name|Cost Account LName|Cost Account FName|Ex.Rate|Budget Amt|Used Amount|Balance|_JAN|_FEB|_MAR|_APR|_MAY|_JUN|_JUL|_AUG|_SEP|_OCT|_NOV|_DEC|Description"
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0"
                                defaults="|||||||||||||||||||||||" editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
                                widths="0|0|0|800|1500|2000|1500|1500|1000|1500|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
                                styles="width:100%; height:430" sorting="F" oncelldblclick="OnGridDetailDblClick()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" styles="display:none" />
</body>
</html>
