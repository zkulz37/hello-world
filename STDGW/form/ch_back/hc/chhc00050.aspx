<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>Approve C & C Expense</title>
</head>

<script>
//---------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;
 var  user_id = "<%=Session("USER_ID")%>"  ; 
 var  org_pk = "<%=Session("ORG_PK")%>"  ; 
var iChk                        = 0,
    ithr_expense_req_pk         = 1,
    iReq_No                     = 2,
    irequester_pk               = 3,
    iEMP_ID                     = 4,
    iEMP_Name                   = 5,    
    itco_dept_pk                = 6,
    iDepartment                 = 7,
    iGroup                      = 8,
    iSubmitted_Date             = 9,
    iStatus                     = 10,
    iOccurred_Date              = 11,
    iType                       = 12,
    iAmount                     = 13,
    iJoin_Date                  = 14,
    iLeave_Days                 = 15,
    iLeave_From                 = 16,
    iLeave_To                   = 17,    
    iRemained                   = 18,
    iTotal_Budget               = 19,
    iPayment_Method             = 20,    
    iApproved_Date              = 21,
    imanager_Response           = 22,  
    iga_response                = 23;
 		
//------------------------------------------------------------------------	        
function BodyInit()
{  
    //chuyen ngon ngu
    System.Translate(document);
    BindingData();     
}
//---------------------------------------------------------------------
function BindingData()
{
    //trang thai cua Approve, Reject, REqMoreInfo
    btnApprove.SetEnable(false);
    btnDenied.SetEnable(false);
    btnReqInfo.SetEnable(false);                
// submitted date
    var l_today = dtSubmitTo.value;
    var l_year = l_today.substring(0, 4);
    dtSubmitFr.value = l_year + '0101';  
//department    
    ls_data     = "<%=ESysLib.SetListDataSQL("select pk, org_nm from comm.tco_org where del_if = 0 ")%>|ALL|All";
    lstDept.SetDataText(ls_data);
    lstDept.value = 'ALL';   
// total amount
    txtTotalAmount.SetEnable(false);
    //combobox of grid
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("select pk, type_name from thr_unit_cost where CATEGORY_CODE = '10' and del_if = 0 " ) %> ";       
    idGrid.SetComboFormat(12, ls_data);
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0082'   " ) %> ";       
    idGrid.SetComboFormat(20, ls_data); 
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0080' ") %> ";       
    idGrid.SetComboFormat(10, ls_data);     
    // trang thai cua response    
    tarGAResponse.SetEnable(false);
    // trang thai cua cac nut
    btnSave.SetEnable(false);
    // thong tin cua approver
    txtUser_PK.text = user_pk;
    txtManager_KIND.text = '';  
    dso_approver_info.Call();            
}
//-------------------------------------------------------------- 
function OnShowGroup()
{    
}
//---------------------------------------------------------------
function OnDataReceive(iObj)
{
    var l_tot_amount = 0 , i, l_total_paid = 0, l_remain_amt = 0, l_tot_budget = 0;
    switch(iObj.id)
    {
        case 'thr_expense_mst':
            btnApprove.SetEnable(false);
            btnDenied.SetEnable(false);
            btnReqInfo.SetEnable(false);
            btnSave.SetEnable(false);
            // sum amount            
            for( i = 1; i < idGrid.rows ; i++)
            {
                if(idGrid.GetGridData(i, iAmount) != "")
                {
                    l_tot_amount = l_tot_amount + parseFloat(idGrid.GetGridData(i, iAmount));                
                }
                if(Trim(idGrid.GetGridData(i, iStatus)) == '50' && idGrid.GetGridData(i, iAmount) != "")
                {
                    l_total_paid = l_total_paid + parseFloat(idGrid.GetGridData(i, 14));
                } 
                if( Trim(idGrid.GetGridData(i, iStatus)) == '70')              
                {
                    idGrid.SetCellBgColor(i, 0, i, idGrid.cols - 1, 0xC9C299); 
                }
            }        
            // Total Amount
            txtTotalAmount.text = l_tot_amount.toFixed(3)+"" ;
            txtTotPaid.text = l_total_paid ;
            var ctrl = idGrid.GetGridControl();    
            ctrl.ColFormat(iAmount)          = "###,###,###,###";  
            ctrl.ColFormat(iLeave_Days)      = "###,###,###.##R";   
            ctrl.ColFormat(iRemained)        = "###,###,###,###";
            ctrl.ColFormat(iTotal_Budget)    = "###,###,###,###";            
            // total budget of department
        break ;
        case 'dso_approver_info':
            tarGAResponse.SetEnable(true);                   
            // Status    
            var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0080' and A.code in ('130', '90', '100', '120', '80') ")%>";
            lstStatus.SetDataText(ls_data);                 
            lstStatus.value = '130'; // Reviewed status 
        break ;
    }   
}
//---------------------------------------------------------------
function OnSearch()
{
    thr_expense_mst.Call('SELECT');
}
//---------------------------------------------------------------
function OnApprove()
{
    var i;
    var n = 0;
    for(i = 1; i < idGrid.rows ; i++)
    {
        if(idGrid.GetGridData(i, iChk) == '-1')
        {
            if( idGrid.GetGridData(i, iStatus) != '130' )    
            {
                alert('Please select the Reviewed status at row ' + i + ' to approve...');
                return ;
            }
        }                
    }                    
    // update DB
    lstStatus.value = '90'; //Approved(GA Manager)                   
    for(i = 1; i < idGrid.rows ; i++)
    {
        if(idGrid.GetGridData(i, iChk) == '-1')
        {
            idGrid.SetGridText(i, iStatus, '90' );
            n += 1;             
        }
        else
            idGrid.SetRowStatus(i, 0);
    }
    if(n > 0)
    {
        thr_expense_mst.Call();    
    }                
}
//---------------------------------------------------------------
function OnShowResponse()
{    
    var lrow = event.row ;
    // expense_req_pk
    txtThr_expense_req_pk.text = idGrid.GetGridData(lrow, ithr_expense_req_pk);
    // response textarea   
    tarGAResponse.SetDataText( idGrid.GetGridData(lrow, iga_response) );            
    if(idGrid.GetGridData(lrow, iStatus) == '30' )
    {
        btnSave.SetEnable(true);            
    }
    else
    {
        btnSave.SetEnable(false);
    }    
}
//---------------------------------------------------------------
function OnSave()
{
    var i , n = 0, lCheck;
    for( i = 1; i < idGrid.rows ; i++)
    {
        lCheck = idGrid.GetGridData(i, iChk);
        if(lCheck == '-1')
        {
            idGrid.SetGridText(i, iga_response, tarGAResponse.GetData() );
            n += 1;    
        }
        else
            idGrid.SetRowStatus(i, 0);                
    }
    if(n > 0)            
        thr_expense_mst.Call();
}
//---------------------------------------------------------------
function OnSetStatus()
{
    var lcol = event.col ;
    if(lcol == iStatus || lcol == iSubmitted_Date || lcol == iOccurred_Date || lcol == iJoin_Date || lcol == iLeave_From || lcol == iLeave_To || lcol == iType || lcol == iApproved_Date || lcol == iPayment_Method)
    {        
        idGrid.row = 0;
    }
}
//---------------------------------------------------------------
function OnDenied()
{
    var i;
    var n = 0;
    if(idGrid.rows <= 1)
        return ;
        
    for(i = 1; i < idGrid.rows ; i++)
    {
        if(idGrid.GetGridData(i, iChk) == '-1')
        {
            if( idGrid.GetGridData(i, iStatus) != '130' ) // Reviewed status 
            {
                alert('Please select the Approved(Manager) status at row ' + i + ' to reject...');
                return ;
            }
            else if(Trim(tarGAResponse.GetData())=='')
            {   
                alert('Please input GA Response...');
                return ;
            }
            idGrid.SetGridText(i, iga_response, Trim(tarGAResponse.GetData())) ;
        }                
    }                    
    // update DB
    lstStatus.value = '120'; //Reject (GA)    
    for(i = 1; i < idGrid.rows ; i++)
    {
        if(idGrid.GetGridData(i, iChk) == '-1')
        {
            idGrid.SetGridText(i, iStatus, '120' ); // Reject (GA Manager) 
            n += 1;              
        }
        else
            idGrid.SetRowStatus(i, 0);
    }
    if( n > 0)
        thr_expense_mst.Call();    
}
//---------------------------------------------------------------
function OnRequestInfo()
{
    var i;
   var n = 0;
    if(idGrid.rows <= 1)
        return ;        
    for(i = 1; i < idGrid.rows ; i++)
    {
        if(idGrid.GetGridData(i, iChk) == '-1')
        {
            if( idGrid.GetGridData(i, iStatus) != '130' )    
            {
                alert('Please select the Reviewed status at row ' + i + ' to request more info...');
                return ;
            }
            else if(Trim(tarGAResponse.GetData())=='')
            {   
                alert('Please input GA Response...');
                return ;
            }
            idGrid.SetGridText(i, iga_response, Trim(tarGAResponse.GetData())) ;
        }                
    }                    
    // update DB
    lstStatus.value = '100'; //Request more info(GA)                
    for(i = 1; i < idGrid.rows ; i++)
    {
        if(idGrid.GetGridData(i, iChk) == '-1')
        {
            idGrid.SetGridText(i, iStatus, '100' );                
            n += 1;
        }
        else
            idGrid.SetRowStatus(i, 0);
    }
    if(n > 0)
        thr_expense_mst.Call();    
}
//---------------------------------------------------------------
function OnButtonStatus()
{
    var lrow = event.row ;
    var lcol = event.col ;
    var lCheck, ls_Status ;
    if(lcol == iChk)
    {
        lCheck = idGrid.GetGridData(lrow, iChk) ;
        ls_Status = idGrid.GetGridData(lrow, iStatus) ;
        if(lCheck == '-1')
        {
            if(ls_Status == '130') // Reviewed 
            {
                btnApprove.SetEnable(true);
                btnDenied.SetEnable(true);
                btnReqInfo.SetEnable(true);                
            }
            else
            {
                btnApprove.SetEnable(false);
                btnDenied.SetEnable(false);
                btnReqInfo.SetEnable(false);                                
            }
        }
    }    
}
//---------------------------------------------------------------
</script>

<body>
<!------------------------------------------------------------------------>
<gw:data id="thr_expense_mst" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" function="hr.sp_sel_cc_expense_approve_ga" parameter="1,10,23" procedure="hr.sp_upd_cc_expense_approve_ga" > 
            <input bind="idGrid" > 
                 <input bind="txtUser_PK" />   
                 <input bind="txtManager_KIND" />
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
    <gw:data id="dso_approver_info" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_biz_empid" > 
                <input>
                 <input bind="txtUser_PK" />                                       
                </input> 
                <output>
                    <output bind="txtEmployee_ID" />                    
                    <output bind="txtEmployee_NM" />
                    <output bind="txtManager_ID" />
                    <output bind="txtManager_NM" />
                    <output bind="txtManager_KIND" />
                    <output bind="txtManager_DEPT" />
                    <output bind="txtApplication_LV" />
                    <output bind="txtManager_PK" />
                    <output bind="txtCompany_PK" />
                    <output bind="txtTacABPLPK" />
                    <output bind="txtPLNM" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>

<table width="100%" border="1" cellpadding="0" cellspacing="0" style="height:100%" >
    <tr style="height:12%">
        <td>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%">
                <tr>
                    <td style="width:15%"></td>
                    <td style="width:15%"></td>
                    <td style="width:5%"></td>
                    <td style="width:10%"></td>
                    <td style="width:10%"></td>
                    <td style="width:10%"></td>
                    <td style="width:35%"></td>
                </tr>
                <tr>
                    <td align="right">Submitted date&nbsp</td>
                    <td align="left"><gw:datebox id="dtSubmitFr" lang="1" styles="width:100%" /></td>
                    <td align="left">~</td>
                    <td align="right"><gw:datebox id="dtSubmitTo" lang="1" styles="width:100%" /></td>
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                </tr>                
                <tr>
                    <td align="right">Department&nbsp</td>
                    <td align="left"><gw:list id="lstDept" styles="width:100%" onchange="OnShowGroup()" /></td>
                    <td align="right">&nbsp</td>
                    <td align="left">
                    </td>
                    <td align="right">Employee&nbsp</td>
                    <td align="left"><gw:list id="lstSearchBy" text="" styles="width:100%" value="1" >
                            <data>
                                DATA|1|Full Name|2|Emp ID|3|Card ID|4|Person ID
                            </data>
                        </gw:list>
                    </td>
                    <td align="left"><gw:textbox id="txtSearchValue" text="" styles="width:100%" /></td>                    
                </tr>
                <tr>
                    <td align="right">Status&nbsp</td>
                    <td align="left"><gw:list id="lstStatus" styles="width:100%" /></td>                                        
                    
                </tr>
            </table>
    </tr>
    <tr style="height:4%">
        <td style="border-bottom:none; border-left:none; border-right:none; ">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr>
                    <td style="width:10%"></td> 
                    <td style="width:3%"></td>
                    <td style="width:62%"></td>                                        
                    <td style="width:5%"></td>
                    <td style="width:5%"></td>
                    <td style="width:5%"></td>
                    <td style="width:5%"></td>
                    <td style="width:5%"></td>
                </tr>
                <tr>
                    <td ></td>
                    <td colspan="2" ></td>
                    <td align="right"><gw:imgBtn id="btnSearch" img="search" alt="Search" styles="width:100%"  onclick="OnSearch()" /></td>                    
                    <td align="right"><gw:icon id="btnApprove" text="Approved" styles="width:100%" onclick="OnApprove()" /></td>
                    <td align="right"><gw:icon id="btnDenied" text="Reject" styles="width:100%" onclick="OnDenied()" /></td>
                    <td align="right"><gw:icon id="btnReqInfo" text="Request More Info" styles="width:100%" onclick="OnRequestInfo()" /></td>                    
                    <td align="right"><gw:icon id="btnSave" text="Save Response" styles="width:100%"  onclick="OnSave()" /></td>                     
                </tr>
            </table>
        </td>
    </tr>
    <tr style="height:54%">
        <td>
            <gw:grid id="idGrid" 
                header="Select|_thr_expense_req_pk|Req No|_requester_pk|EMP ID|EMP Name|_tco_dept_pk|Department|_Group|Submitted Date|Status|Occurred Date|Type|Amount|Leave Days|Leave From|Leave To|Join Date|Remaining|Total Budget|Payment Method|Approved Date|Manager Response|_ga_response|Description"
                format="3|0|0|0|0|0|0|0|0|4|0|4|0|0|0|4|4|4|0|0|0|4|0|0|0" 
                aligns="1|0|1|0|1|0|0|0|0|1|0|1|0|3|3|1|1|1|3|3|0|1|0|0|0" 
                defaults="||||||||||||||||||||||||"
                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                widths="700|0|1200|0|1200|2500|0|1500|1500|1500|1500|1500|2000|1500|1200|1200|1200|1200|2000|1700|2000|1500|2000|0|2000"
                sorting="F" 
                acceptNullDate="T"
                styles="width:100%; height:100%" 
                onentercell="OnSetStatus()"                
                oncellclick="OnShowResponse()"
                onafteredit="OnButtonStatus()"                
                 />        
        </td>
    </tr>
    <tr style="height:4%">
        <td style="border-bottom:none; border-left:none; border-right:none; ">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr>
                    <td style="width:70%"></td>
                    <td style="width:10%"></td>
                    <td style="width:20%"></td>
                </tr>
                <tr >
                    <td></td>
                    <td align="right">Total Amount&nbsp</td>
                    <td align="right"><gw:textbox id="txtTotalAmount" type="number" format="###,###" styles="width:100%" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr style="height:2%">
        <td style="border-bottom:none; border-left:none; border-right:none; border-top:none ">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr >
                    <td><hr noshade size="2" width="100%" style="color: Silver"></td>
                </tr>
            </table>
        </td>
    </tr>
   <tr style="height:24%">
        <td style="border-bottom:none; border-left:none; border-right:none; border-top:none " >
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr>                    
                    <td style="width: 100%"></td>
                </tr>
                <tr>                    
                    <td align="left">GA Response</td>
                </tr>
                <tr>                    
                    <td align="left"><gw:textarea id="tarGAResponse" rows="5" styles="width:100%; " /></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<gw:textbox id="txtGroupData" styles="display: none; " />
<gw:textbox id="txtThr_expense_req_pk" styles="display: none; " />
<gw:textbox id="txtStatus" styles="display: none; " />
<gw:textbox id="txtReturn" style="display:none" />
<gw:textbox id="txtTotPaid" style="display:none" />
<gw:textbox id="txtUser_PK" style="display:none" />
<gw:textbox id="txtEmployee_ID" style="display:none" />
<gw:textbox id="txtEmployee_NM" style="display:none" />
<gw:textbox id="txtManager_ID" style="display:none" />
<gw:textbox id="txtManager_NM" style="display:none" />
<gw:textbox id="txtManager_KIND" style="display:none" />
<gw:textbox id="txtManager_DEPT" style="display:none" />
<gw:textbox id="txtApplication_LV" style="display:none" />
<gw:textbox id="txtManager_PK" style="display:none" />
<gw:textbox id="txtCompany_PK" style="display:none" />
<gw:textbox id="txtTacABPLPK" style="display:none" />
<gw:textbox id="txtPLNM" style="display:none" />
</body>
</html>
