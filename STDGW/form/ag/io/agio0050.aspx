<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Page</title>
    <%ESysLib.SetUser("acnt")%>

    <script>
    var _company_pk = "<%=session("COMPANY_PK") %>";
    function BodyInit(){
        System.Translate(document); 
        txtUsedAmount.SetEnable(false);
        txtBalance.SetEnable(false);
        txtAmount.SetEnable(false);
        BindDataToList();
        OnNew();
    }
    function BindDataToList(){
        var ls_company = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM comm.TCO_COMPANY WHERE DEL_IF=0")%>";
        lstCompany.SetDataText(ls_company);
		lstCompany.value = "<%=Session("COMPANY_PK")%>";
		dsoGetPLUnitByCompany.Call();
		
        lstPLUnit.value = "ALL";
        
		lstBudgetType.SetDataText("<%=ESysLib.SetListDataFUNC("select acnt.sf_a_get_commoncode('ACBG0050') from dual")%>"); 
        lstCurrency.SetDataText("<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CHAR_1 || ' - ' || CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0040' ORDER BY V.CODE_NM")%>"); 
    }
    function OnSearchList(){
        dsoMasterList.Call("SELECT");
    }
    function OnNew(){
        dsoMaster.StatusInsert();
        chkActive.SetDataText("Y");
        grdBudgetDetail.ClearData();
        
    }
    function OnSave(){
        if(CheckDataIsValid()){
            dsoMaster.Call();
        }
    }
    function OnDelete(){
        if(confirm("Do you want to delete this data?")){
            dsoMaster.StatusDelete();
            OnSave();
         }
    }
    function OnPrint(){
    
    }
    function CheckDataIsValid(){
    return true;
    }
    var _ListClick = false;
    function OnDataReceive(dso){
        if(dso.id == "dsoMaster"){
            if(_ListClick == true){
                dsoDetail.Call("SELECT");
            }
            else{
            SetMasterPKToGrid();
            dsoDetail.Call();
            }
        }
		//dsoGetPLUnitByCompany.Call();
		else if(dso.id == "dsoGetPLUnitByCompany"){
            dsoGetPLUnitByCompany2.Call();
            lstPLUnit.value = "ALL";
        }
        else if(dso.id == "dsoGetPLUnitByCompany2"){
            lstPLUnit2.RemoveItem(lstPLUnit2.GetItemIndex("ALL","T"));
            dsoMasterList.Call("SELECT");
        }
		else if(dso.id == "dsoDetail"){
		    if(_ListClick != true){
		        dsoMasterList.Call("SELECT");
		    }
		    _ListClick = false;
		}
			
    }
    function OnGridLeftClick(){
        txtMasterPK.text = grdBudgetList.GetGridData(event.row,0);
        _ListClick = true;
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
/*
	if(event.col == 4 || event.col == 5)
	{
		//var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCT_PARTNER";
		//var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
		var fpath = System.RootURL + "/form/ag/io/Get_Acc_Mapping.aspx?ItemType=" + "BUDGET" + "&ItemValue=" + lstPLUnit2.value + "&Action=" + "UPDATE" + "&dsqlid=ACNT.SP_SEL_ACC_MAPPING";
		var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 

		if ((object != null))
		{
			grdBudgetDetail.SetGridText( grdBudgetDetail.GetGridControl().SelectedRow(0), 2, object[3] );//pk
			grdBudgetDetail.SetGridText( grdBudgetDetail.GetGridControl().SelectedRow(0), 4, object[1] );//code
			grdBudgetDetail.SetGridText( grdBudgetDetail.GetGridControl().SelectedRow(0), 5, object[2] );//name
			grdBudgetDetail.SetGridText( grdBudgetDetail.GetGridControl().SelectedRow(0), 6, "" );//name
			grdBudgetDetail.SetGridText( grdBudgetDetail.GetGridControl().SelectedRow(0), 7, "" );//name
		}
	}
*/	
}
function OnSubNew(){
    //grdBudgetDetail.AddRow();
	//var fpath = System.RootURL + "/form/ag/io/Get_Acc_Mapping.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCT_PARTNER";
    var fpath = System.RootURL + "/form/ag/io/Get_Acc_Mapping.aspx?ItemType=" + "BUDGET"  + "&Company=" + lstCompany.value + "&ItemValue=" + lstPLUnit2.value + "&Action=" + "ADDNEW" + "&dsqlid=ACNT.SP_SEL_ACC_MAPPING";
	var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
	if (object != null)
	{
		for(i=0;i < object.length ;i++)
		{
			grdBudgetDetail.AddRow();
			grdBudgetDetail.GetGridControl().TopRow = grdBudgetDetail.rows - 1; 
			//grdBudgetDetail.GetGridData(grdBudgetDetail.rows -1, 0 );
			grdBudgetDetail.SetGridText( grdBudgetDetail.rows -1, 2, object[i][3] );//pk
			grdBudgetDetail.SetGridText( grdBudgetDetail.rows -1, 4, object[i][1] );//code
			grdBudgetDetail.SetGridText( grdBudgetDetail.rows -1, 5, object[i][2] );//name
		}
	}
}
function OnSubDelete(){
    grdBudgetDetail.DeleteRow();
}
function OnSubUndelete(){
    grdBudgetDetail.UnDeleteRow();
}

function OnChangeCompany() 
{
	dsoGetPLUnitByCompany.Call();
	lstPLUnit.value = "ALL";
	lstPLUnit2.value = "ALL";
}

function OnDataError(obj)
{
	if (obj.id=="dsoDataList")
    {
		AlertDBError(obj.errmsg)
		return;
	}
	else
	{
		AlertDBError(obj.errmsg)
		return;
	}
}

function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
}

    </script>

</head>
<body>
	
	<gw:data id="dsoGetPLUnitByCompany" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)"  > 
        <xml> 
            <dso  type="list" procedure="ACNT.SP_PRO_PL_UNIT_LIST" > 
                <input>
                    <input bind="lstCompany" /> 
                </input> 
                <output>
                    <output bind="lstPLUnit" />
                </output>
            </dso> 
        </xml> 
	</gw:data>
	
	<gw:data id="dsoGetPLUnitByCompany2" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)"  > 
        <xml> 
            <dso  type="list" procedure="ACNT.SP_PRO_PL_UNIT_LIST" > 
                <input>
                    <input bind="lstCompany" /> 
                </input> 
                <output>
                    <output bind="lstPLUnit2" />
                </output>
            </dso> 
        </xml> 
	</gw:data>
	
    <gw:data id="dsoMasterList"> 
    <xml> 
        <dso type="grid"   function="ACNT.SP_SEL_TAC_PL_BUDGET_LIST"  onerror="OnDataError(this)"  > 
            <input bind="grdBudgetList" >
                <input bind="lstCompany" />
                <input bind="lstPLUnit" />
                <input bind="dtYear" />
            </input>
            <output bind="grdBudgetList" />
        </dso> 
    </xml> 
</gw:data>
    <gw:data id="dsoMaster" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
<xml> 
<dso type="control" parameter="0,1,2,3,4,5,6,7,8" function="ACNT.SP_SEL_TAC_PL_BUDGET" procedure="ACNT.SP_UPD_TAC_PL_BUDGET"> 
    <inout> 
        <inout bind="txtMasterPK"/>
        <inout bind="lstCompany" />
        <inout bind="lstPLUnit2" />
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
    <gw:data id="dsoDetail" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
<xml> 
    <dso type="grid" parameter="0,1,2,8,9,12,13,14,15,16,17,18,19,20,21,22,23,24" function="ACNT.SP_SEL_TAC_PL_BUDGETD" procedure="ACNT.SP_UPD_TAC_PL_BUDGETD"> 
        <input bind="grdBudgetDetail" >
            <input bind="txtMasterPK" />
        </input>
        <output bind="grdBudgetDetail" />
    </dso> 
</xml> 
</gw:data>
    <table width="100%" height="100%"  border="1">
        <tr  width="100%" height="100%"  >
            <td with="20%">
                <table  width="100%" height="100%"  >
                    <tr>
                        <td with="100%">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="26%">
                                        Company</td>
                                    <td width="60%">
                                        <gw:list id="lstCompany" onchange="OnChangeCompany()" />
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
                                        Cost Center</td>
                                    <td width="60%">
                                        <gw:list id="lstPLUnit" onchange="OnSearchList()"/>
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
                    <tr  height="100%">
                        <td>
                            <gw:grid id="grdBudgetList" header="_PK|Year|Center Code|Center Name|Budget Amt|Active" format="0|0|0|0|1|3"
                                aligns="0|0|0|0|0|0" defaults="|||||" editcol="0|0|0|0|0|0" widths="0|900|1500|2000|1500|800" styles="width:100%; height:100%"
                                sorting="T" oncellclick="OnGridLeftClick()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td with="80%">
                <table width="100%"  height="100%" cellpadding="0" cellspacing="0">
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
                                        <gw:datebox id="dtYear2" type="year" csstype="mandatory"/>
                                    </td>
                                    <td width="5%">Active:</td>
                                    <td width="5%">
                                        <gw:checkbox id="chkActive" defaultvalue="Y|N" value="Y" />
                                    </td>
                                    <td width="10%">&nbsp;Currency</td>
                                    <td width="15%"><gw:list id="lstCurrency" csstype="mandatory"/></td>
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
                                        Cost Center</td>
                                    <td width="18%">
                                        <gw:list id="lstPLUnit2" csstype="mandatory"/>
                                    </td>
                                    <td width="10%">
                                        &nbsp;Budget Amount</td>
                                    <td width="15%">
                                        <gw:textbox id="txtAmount" type="number" format="###,###,###,###,###"/>
                                    </td>
                                    <td width="10%">
                                        &nbsp;Used Amount</td>
                                    <td width="15%">
                                        <gw:textbox id="txtUsedAmount" type="number" format="###,###,###,###,###"/>
                                    </td>
                                    <td width="7%">
                                        &nbsp;Balance</td>
                                    <td width="15%">
                                        <gw:textbox id="txtBalance" type="number" format="###,###,###,###,###"/>
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
                    <tr  height="100%">
                        <td>
                            <gw:grid 
								id="grdBudgetDetail" 
								header="_PK|_MASTER_PK|_TAC_ABACCTCODE_PK|No|Cost Account ID|Cost Account Name|_Cost Account LName|_Cost Account FName|_Ex.Rate|Budget Amt|Used Amount|Balance|_JAN|_FEB|_MAR|_APR|_MAY|_JUN|_JUL|_AUG|_SEP|_OCT|_NOV|_DEC|Description"
                                format="0|0|0|0|0|0|0|0|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0"
                                defaults="|||||||||||||||||||||||" editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
                                widths="0|0|0|800|1500|2000|1500|1500|1000|1500|1500|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
                                styles="width:100%; height:100%" sorting="F" oncelldblclick="OnGridDetailDblClick()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" styles="display:none" />
</body>
</html>
