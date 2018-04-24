<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>C & C Expense List</title>
</head>

<script>
//---------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;
 var  user_id = "<%=Session("USER_ID")%>"  ;
var iChk                    = 0,
    ithr_exp_req_pk         = 1,
    ireq_no                 = 2,
    irequester_pk           = 3,
    iemp_id                 = 4,
    iemp_nm                 = 5,
    idept_nm                = 6,
    isubmit_date            = 7,
    iocurred_date           = 8,
    itype                   = 9,
    ijoin_dt                = 10,
    ileave_days             = 11,
    ileave_from             = 12,
    ileave_to               = 13,
    iamount                 = 14,  
    ipay_method             = 15,
    istatus                 = 16,
    ipaid_dt                = 17,
    iresponse               = 18,
    icancel_reason          = 19,    
    iapprover_pk            = 20,
    iga_response            = 21;
     		
//------------------------------------------------------------------------	        
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
    //combobox of grid
    var ls_data = "<%=ESysLib.SetGridColumnDataSQL("select pk, type_name from thr_unit_cost where CATEGORY_CODE = '10' and del_if = 0 " ) %> ";       
    idGrid.SetComboFormat(9, ls_data);
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0082' " ) %> ";       
    idGrid.SetComboFormat(15, ls_data);
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0080' " ) %> ";       
    idGrid.SetComboFormat(16, ls_data);    
    // status
    ls_data     = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0080' ")%>|ALL|All";
    lstStatus.SetDataText(ls_data); 
    lstStatus.value = 'ALL';              
// user login
    txtUserID.text = user_id ;    
    txtUserPK.text = user_pk ;
    txtSearchValue.text = user_name
// status of buttons
    btnSave.SetEnable(false);
    btnDel.SetEnable(false);
    btnCancel.SetEnable(false);
}
//---------------------------------------------------------------
function OnSearch()
{
    thr_expense_list.Call('SELECT');
}
//---------------------------------------------------------------
function OnDataReceive(iObj)
{
    var i;
    var ltot_amt = 0;
    switch(iObj.id)
    {
        case 'thr_expense_list':            
            if(idGrid.rows > 1)
            {
                for(i = 1; i < idGrid.rows ; i++)
                {
                    if(Trim(idGrid.GetGridData(i, istatus)) == '70')
                    {
                        idGrid.SetCellBgColor(i, 0, i, idGrid.cols - 1, 0xC9C299); 
                    }                    
                    ltot_amt += Number(idGrid.GetGridData(i, iamount));
                }                     
            }
            btnDel.SetEnable(false);
            btnCancel.SetEnable(false);
            btnSave.SetEnable(false);
            txtTotalAmount.text = ltot_amt.toFixed(3);
            var ctrl = idGrid.GetGridControl();
            ctrl.ColFormat(iamount)          = "###,###,###,###,###";
            ctrl.ColFormat(ileave_days)      = "###,###,###,###,###.##R";                        
        break ;
    }
}
//---------------------------------------------------------------
function OnAddNew()
{
    System.Menu.NewWindow( "form/ch/hc/chhc00010.aspx"  , "C&C Expenses Entry", "C&C Expenses Entry", "C&C Expenses Entry" );
}
//---------------------------------------------------------------
function OnDelete()
{        
    var i, n = 0;
    var ls_status ;
    for( i = 1; i < idGrid.rows; i++)
    {
        lCheck = idGrid.GetGridData(i, iChk);
        if(lCheck == '-1')
        {
            ls_status = idGrid.GetGridData(i, istatus);           
            if(ls_status != '10' )
            {
                alert('Please choose the Save status to delete...');
                return ;   
            }                    
            idGrid.DeleteRow(i);
            n += 1;
        }
    }    
    if( n > 0)    
        thr_expense_list.Call();        
}
//---------------------------------------------------------------
function OnAutoSetData()
{
    var lcol = event.col ;
    var lrow = event.row;
    var ls_type = '';
    if(lcol == istatus || lcol == ileave_from || lcol == ileave_to || lcol == isubmit_date || lcol == iocurred_date || lcol == ijoin_dt || lcol == ipaid_dt || lcol == itype || lcol == ipay_method )
    {
        idGrid.row = 0;
    }
}
//---------------------------------------------------------------
function OnButtonStatus()
{
    var lcol = event.col ;
    var lrow = event.row ;
    var lCheck, ls_status ;
    if(lcol == iChk)
    {
        lCheck = idGrid.GetGridData(lrow, iChk);
        
        if(lCheck == '-1')
        {       
            ls_status = idGrid.GetGridData(lrow, istatus) ;           
            //cancel 
            if(ls_status == '10' || ls_status == '90' )
            {
                btnCancel.SetEnable(true);
            }
            else
            {
                btnCancel.SetEnable(false);        
            }
            // del button
            if(ls_status == '10' )
            {
                btnDel.SetEnable(true);
            }
            else
            {
                btnDel.SetEnable(false);
            }
            // save button 
            if(ls_status == '10'  )
            {
                txtThr_expense_req.text = idGrid.GetGridData(lrow,ithr_exp_req_pk );
                btnSave.SetEnable(true);
            }
            else
            {
                btnSave.SetEnable(false);
            }            
            tarReasonCancel.SetDataText( idGrid.GetGridData(lrow, icancel_reason) );
        }            
    }    
}
//---------------------------------------------------------------
function OnModify()
{
    System.Menu.NewWindow( "form/ch/hc/chhc00010.aspx?thr_expense_req_pk=" +  txtThr_expense_req.text , "C&C Expenses Entry", "C&C Expenses Entry", "C&C Expenses Entry" );        
}
//---------------------------------------------------------------
function OnCancel()
{
    lstStatus.value = '80';
    var i, n = 0;
    var ls_status;
    for( i = 1; i < idGrid.rows; i++)
    {        
        lCheck = idGrid.GetGridData(i, iChk);                
        if(lCheck == '-1')        
        {
            ls_status = idGrid.GetGridData(i, istatus) ;
            if(ls_status != '10' && ls_status != '90' )
            {
                alert('Please choose the Save or Approved(GA) status to cancel...');
                return ;   
            }            
            if(Trim(tarReasonCancel.GetData()) == '' )
            {
                alert('Please input Reason Cancel...');                
                return ;
            }
            idGrid.SetGridText(i, istatus, '80');                
            idGrid.SetGridText(i, icancel_reason, tarReasonCancel.GetData() );                        
            n += 1;
        }
        else
            idGrid.SetRowStatus(i, 0);
    }    
    if( n > 0)    
        thr_expense_list.Call();    
}
//---------------------------------------------------------------
function OnChangeMyPage()
{
    if(rdoAppli.value == '1')    
        txtSearchValue.text = user_name;
    else
        txtSearchValue.text = '';
}
//---------------------------------------------------------------
</script>

<body>
<!------------------------------------------------------------------------>
<gw:data id="thr_expense_list" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" function="hr.sp_sel_cc_expense_list" parameter="1,16,19" procedure="hr.sp_upd_cc_expense_list" > 
            <input bind="idGrid" > 
                 <input bind="dtSubmitFr" />
                 <input bind="dtSubmitTo" />
                 <input bind="rdoAppli" /> 
                 <input bind="lstSearchBy" />
                 <input bind="txtSearchValue" />
                 <input bind="txtUserPK" />
                 <input bind="txtUserID" />
                 <input bind="lstStatus" />
             </input> 
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data>

<!------------------------------------------------------------------------>

<table width="100%" border="1" cellpadding="0" cellspacing="0" style="height:100%" >
    <tr style="height: 8%">
        <td>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%">
                <tr>
                    <td style="width:15%"></td>
                    <td style="width:10%"></td>
                    <td style="width:2%"></td>
                    <td style="width:10%"></td>                    
                    <td style="width:7%"></td>
                    <td style="width:30%"></td>
                    <td style="width:3%"></td>
                    <td style="width:11%"></td>
                    <td style="width:3%"></td>
                    <td style="width:3%"></td>
                    <td style="width:3%"></td>
                    <td style="width:3%"></td>
                </tr>
                <tr>                    
                    <td align="right">Submitted date&nbsp</td>
                    <td align="left"><gw:datebox id="dtSubmitFr" lang="1" styles="width:100%" onchange="OnSearch()" /></td>
                    <td align="right">~</td>
                    <td align="right"><gw:datebox id="dtSubmitTo" lang="1" styles="width:100%" onchange="OnSearch()" /></td>
                    <td align="left"></td>
                    <td align="left"><gw:radio id="rdoAppli" value="1" onchange="OnChangeMyPage()" >
                        <span value="1">My application</span>
                        <span value="2">All application I made</span>
                        </gw:radio>                        
                    </td>
                </tr>    
                <tr>
                    <td align="right">Status&nbsp</td>
                    <td align="left" colspan="2"><gw:list id="lstStatus" styles="width:100%" /></td>                
                    <td colspan="1" align="right">Employee&nbsp</td>
                    <td align="left"><gw:list id="lstSearchBy" styles="width:100%" >
                            <data>
                                DATA|1|Full Name|2|Emp ID|3|Card ID|4|Person ID
                            </data>
                        </gw:list>
                    </td>
                    <td align="left" colspan="1"><gw:textbox id="txtSearchValue" styles="width:100%" /></td> 
                    <td align="left"></td>
                    <td align="right"><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
                    <td align="right"><gw:icon id="btnSave" text="Modify" styles="width:100%" onclick="OnModify()" /></td>                    
                    <td align="right"><gw:imgBtn id="btnNew" img="new" alt="Add New" onclick="OnAddNew()" /></td>                    
                    <td align="right"><gw:imgBtn id="btnDel" img="delete" alt="Delete" onclick="OnDelete()" /></td>
                    <td align="right"><gw:icon id="btnCancel" text="Cancel" onclick="OnCancel()" /></td>
                </tr>
            </table>
        </td>
    </tr>                                                
    <tr style="height:4%">
        <td style="border-bottom:none; border-left:none; border-right:none; ">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr>
                    <td>&nbsp</td>
                </tr>
                <tr>
                    <td align="left">Application list</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr style="height:58%">
        <td>
            <gw:grid id="idGrid" 
                header="|_thr_expense_req_pk|Req No|_requester_pk|EMP ID|EMP NM|Department|Submitted Date|Occurred Date|Type|Join Date|Leave Days|Leave From|Leave To|Amount|Payment Method|Status|Paid Date|Response|Cancel Reason|_approver_pk|GA Response"
                format="3|0|0|0|0|0|0|4|4|0|4|0|4|4|0|0|0|4|0|0|0|0" 
                aligns="1|0|0|0|0|0|1|1|1|0|3|3|1|1|3|0|0|1|0|0|0|0"
                defaults="|||||||||||||||||||||"
                editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                widths="600|0|0|1200|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1700|1500|2000|2500|1600|0|2000"
                sorting="T"
                acceptNullDate="T"
                onafteredit="OnButtonStatus()"
                onentercell="OnAutoSetData()" 
                styles="width:100%; height:100%" 
                />        
        </td>
    </tr>
    <tr style="height:4%">
        <td style="border-bottom:none; border-left:none; border-right:none; ">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                <tr>
                    <td style="width:70%"></td>
                    <td style="width:10%"></td>
                    <td style="width:20%"></td>
                </tr>
                <tr>
                    <td></td>
                    <td align="right">Total Amount&nbsp</td>
                    <td align="right"><gw:textbox id="txtTotalAmount" type="number" format="###,###" styles="width:100%" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr style="height:4%">
        <td style="border-bottom:none; border-left:none; border-right:none; border-top:none ">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr>
                    <td><hr noshade size="2" width="100%" style="color: Silver"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr style="height:18%">
        <td style="border-bottom:none; border-left:none; border-right:none; border-top:none " >
            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                <tr>                    
                    <td style="width: 100%"></td>
                </tr>
                <tr>                    
                    <td align="left">Reason for Cancel</td>
                </tr>
                <tr>                    
                    <td align="left"><gw:textarea id="tarReasonCancel" rows="5" styles="width:100%; " /></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<gw:textbox id="txtThr_expense_req" styles="display:none " />
<gw:textbox id="txtReturn" styles="display:none " />
<gw:textbox id="txtStatus" styles="display:none " />
<gw:textbox id="txtUserID" styles="display:none " />
<gw:textbox id="txtUserPK" styles="display:none "  />
<gw:textbox id="txtAmount" styles="display:none " />
<gw:textbox id="txtCurr" styles="display:none " />
<gw:textbox id="txtLeaveDays" styles="display:none " />
<gw:textbox id="txtEXPType" styles="display:none " />
<gw:textbox id="txtApprover" styles="display:none " />
</body>
</html>
