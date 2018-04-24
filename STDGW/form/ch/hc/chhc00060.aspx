<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>GA Staff Review</title>
</head>

<script>
//---------------------------------------------------------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;
 var  org_pk = "<%=Session("ORG_PK")%>"  ;
 var iChk                   = 0,
    ithr_expense_req_pk     = 1,
    iReq_No                 = 2,
    irequester_pk           = 3,    
    iEMP_ID                 = 4,
    iEMP_Name               = 5,
    itco_org_pk            = 6,
    iDepartment             = 7,
    iGroup                  = 8,
    iSubmitted_Date         = 9,
    iOccurred_Date          = 10,
    iType                   = 11,
    iAmount                 = 12,
    iStatus                 = 13,
    iJoin_Date              = 14,
    iLeave_Days             = 15,
    iLeave_From             = 16,
    iLeave_To               = 17,        
    iPayment_Method         = 18,        
    iPaid_Date              = 19,
    iRemark                 = 20,    
    iBank_Name              = 21,
    iAccount                = 22;
//--------------------------------------------------------------

function BodyInit()
{  
    BindingData();
    System.Translate(document);
}
//---------------------------------------------------------------------
function BindingData()
{
// submitted date
    var l_today = dtSubmitTo.value;
    var l_year = l_today.substring(0, 4);
    dtSubmitFr.value = l_year + '0101';  
// Status    
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0080' and A.code in ('130', '30') ")%>";
    lstStatus.SetDataText(ls_data);
    lstStatus.value = '30'; //Approve Manager
//department    
    ls_data     = "<%=ESysLib.SetListDataSQL("select pk, org_nm from comm.tco_org where del_if = 0 ")%>|ALL|All";
    lstDept.SetDataText(ls_data); 
    lstDept.value = org_pk;       
    //combobox of grid
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("select pk, type_name from thr_unit_cost where CATEGORY_CODE = '10' and del_if = 0" ) %> ";       
    idGrid.SetComboFormat(11, ls_data);
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0082'   " ) %> ";       
    idGrid.SetComboFormat(18, ls_data); 
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0080' and A.code <> '10' " ) %> ";       
    idGrid.SetComboFormat(13, ls_data); 
    //status of buttons   
	btnReview.SetEnable(false); 
}
//---------------------------------------------------------------
function OnShowGroup()
{
    
}
//---------------------------------------------------------------
function OnDataReceive(iObj)
{
    var i ;
    switch(iObj.id)
    {
        case 'thr_expense_mst':
            for( i = 1; i < idGrid.rows ; i++)
            {
                if(idGrid.GetGridData(i, iStatus) == '70')
                {
                    idGrid.SetCellBgColor(i, 0, i, idGrid.cols - 1, 0xC9C299);
                }
            }
            var ctrl = idGrid.GetGridControl();    
            ctrl.ColFormat(iAmount)          	= "###,###,###,###,###";
            ctrl.ColFormat(iLeave_Days)         = "###,###,###,###,###.##R";
        break ;
    }   
}
//---------------------------------------------------------------
function OnSearch()
{
    thr_expense_mst.Call('SELECT');
}
//---------------------------------------------------------------
function OnSetAllRemark()
{
    var i;
    for(i = 1; i < idGrid.rows; i++)
    {
        idGrid.SetGridText(i, iRemark, txtRemark.text);       
    }        
}
//---------------------------------------------------------------
function OnPrint()
{
    alert('Waiting for new design for reports...');    
}
//---------------------------------------------------------------
function OnEnterData()
{
    var lcol = event.col ;
    var lrow = event.row ;
    if(lcol == iStatus || lcol == iSubmitted_Date || lcol == iOccurred_Date || lcol == iType || lcol == iJoin_Date || lcol == iLeave_From || lcol == iLeave_To )
    {
        idGrid.row = 0;
    }
    else if(lcol == iPaid_Date || lcol == iRemark )
    {
        if(idGrid.GetGridData(lrow, iStatus) == '50' || idGrid.GetGridData(lrow, iStatus) == '80' )
        {
            idGrid.row = 0;
        }
    }
}
//---------------------------------------------------------------
function ButtonStatus()
{
    var lrow = event.row ;
    var lcol = event.col ;
	//review
    if(idGrid.GetGridData(lrow, iStatus)=='30')
    {
        btnReview.SetEnable(true);
    }        
    else
    {
        btnReview.SetEnable(false);                    
    }     	   
}
//---------------------------------------------------------------
function OnReview()
{
	var i ;
	for(i = 1; i < idGrid.rows; i++)
	{
		if(idGrid.GetGridData(i, iChk)=='-1')
		{
			if(idGrid.GetGridData(i, iStatus)!='30') // Approve (manager)
			{
				alert('Please choose the Approved(Manager) to post Reviewed status at row ' + i + ' ...');
				return ;
			}
		}
	}
	//update
	lstStatus.value = '130'; //Reviewed status
	for(i = 1; i < idGrid.rows; i++)
	{
		if(idGrid.GetGridData(i, iChk)=='-1')
		{
			idGrid.SetGridText(i, iStatus, '130'); // Reviewed
		}
		else
		    idGrid.SetRowStatus(i, 0);
	}
	thr_expense_mst.Call();
}
//---------------------------------------------------------------
</script>
<body>
<!------------------------------------------------------------------------>
<gw:data id="thr_expense_mst" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" function="hr.sp_sel_cc_expense_process" parameter="1,13,19,20" procedure="hr.sp_upd_cc_expense_process" > 
            <input bind="idGrid" > 
                 <input bind="dtSubmitFr" />
                 <input bind="dtSubmitTo" /> 
                 <input bind="lstDept" />                  
                 <input bind="lstSearchBy" />
                 <input bind="txtSearchValue" />
                 <input bind="lstStatus" />                 
             </input> 
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<table width="100%" border="1" cellpadding="0" cellspacing="0" style="height:100%" >
    <tr style="height:12%">
        <td>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr>
                    <td style="width:15%"></td>
                    <td style="width:15%"></td>
                    <td style="width:5%"></td>
                    <td style="width:10%"></td>
                    <td style="width:10%"></td>
                    <td style="width:10%"></td>
                    <td style="width:20%"></td>
					<td style="width:5%"></td>
					<td style="width:5%"></td>
					<td style="width:5%"></td>
                </tr>
                <tr>
                    <td align="right">Submitted date&nbsp</td>
                    <td align="left"><gw:datebox id="dtSubmitFr" lang="1" styles="width:100%" /></td>
                    <td align="left">~</td>
                    <td align="right"><gw:datebox id="dtSubmitTo" lang="1" styles="width:100%" /></td>
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                    <td>&nbsp</td>
					<td>&nbsp</td>
					<td>&nbsp</td>
					<td>&nbsp</td>
                </tr>                
                <tr>
                    <td align="right">Department&nbsp</td>
                    <td align="left"><gw:list id="lstDept" styles="width:100%" onchange="OnShowGroup()" /></td>
                    <td align="right" colspan="2" >Employee&nbsp</td>                    
                    <td align="left"><gw:list id="lstSearchBy" text="" styles="width:100%" value="1" >
                        <data>
                            DATA|1|Full Name|2|Emp ID|3|Card ID|4|Person ID
                        </data>
                        </gw:list>
                    </td>
                    <td align="left" colspan="5" ><gw:textbox id="txtSearchValue" text="" styles="width:100%" /></td>                    
                </tr>
                <tr>
                    <td align="right">Status&nbsp</td>
                    <td align="left"><gw:list id="lstStatus" styles="width:100%" /></td>
                    <td align="right">&nbsp</td>
                    <td align="right">&nbsp</td>
                    <td align="right">&nbsp</td>
                    <td align="left">&nbsp</td>
					<td align="left">&nbsp</td>
					<td align="left">&nbsp</td>
					<td align="left">&nbsp</td>
					<td align="left">&nbsp</td>
                </tr>
                <tr>
                    <td align="right">Remark&nbsp</td>
                    <td align="left" colspan="6"><gw:textbox id="txtRemark" styles="width:100%" /></td>                    
                    <td align="left"><gw:icon id="btnSetAll_2" text="Set All" onclick="OnSetAllRemark()" /></td>
                    <td align="right"><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>                    
                    <td align="right"><gw:imgBtn id="btnPrint" img="excel" alt="Print" onclick="OnPrint()" /></td>
					<td align="right"><gw:icon id="btnReview" text="Reviewed" img="in" styles="width:100%" onclick="OnReview()" /></td>					
                </tr>
            </table>
    </tr>
    <tr style="height:88%">
        <td>
            <gw:grid id="idGrid" 
                header="Select|_thr_expense_req_pk|Req No|_requester_pk|EMP ID|EMP Name|_tco_org_pk|Department|_Group|Submitted Date|Occurred Date|Type|Amount|Status|Join Date|Leave Days|Leave From|Leave To|Payment Method|Paid Date|Remark|Bank Name|Account"
                format="3|0|0|0|0|0|0|0|0|4|4|0|0|0|4|0|4|4|0|4|0|0|0" 
                aligns="1|0|1|0|0|0|0|0|0|1|1|0|3|3|3|3|1|1|0|0|0|0|0"
                defaults="||||||||||||||||||||||"
                editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|1|1|0|0" 
                widths="700|0|1000|0|1200|2000|0|2000|2000|1500|1500|1500|1200|1500|1200|1200|1500|1800|1500|1200|3000|1500|2000"
                sorting="T" 
                acceptNullDate="T"
                onentercell="OnEnterData()"
                oncellclick="ButtonStatus()"
                styles="width:100%; height:100%" 
            />        
        </td>
    </tr > 
</table>
<gw:textbox id="txtGroupData" styles="display: none; " />
</body>
</html>
