<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>Applicant(Beneficiary)</title>
</head>

<script>
//---------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;
 var  user_id = "<%=Session("USER_ID")%>"  ; 
 var  dept_pk = "<%=Session("ORG_PK")%>"  ;
 var dept_nm = '';
 var p_update = 0 ;//dang insert hay khong
var p_thr_expense_pk = "<%=Request.querystring("thr_expense_req_pk")%>" ;
//------------------------------------------------------------------------	        
function BodyInit()
{  
    System.Translate(document);
    BindingData();     
    if(p_thr_expense_pk != "")
    {
       thr_expense_req_pk.text = p_thr_expense_pk;       
       grdMst.Call('SELECT');
    }           
}
//---------------------------------------------------------------------
function BindingData()
{
    //Type
    var ls_data     = "<%=ESysLib.SetListDataSQL("select pk, type_name from thr_unit_cost where CATEGORY_CODE = '10' and del_if = 0 ")%>";
    lstType.SetDataText(ls_data);
    lstType.value = "";    
    //Status
    ls_data     = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0080' ")%>|ALL|All";
    lstStatus.SetDataText(ls_data);
    lstStatus.value = 'ALL';
    ls_data     = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0080' ")%>";
    lstStatus_2.SetDataText(ls_data);
    //lstStatus_2.SetEnable(false);
    //Payment method    
    ls_data     = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0082' ")%>";
    lstPayMethod.SetDataText(ls_data);
    // applied date from
    var l_today = dtAppliedFr.value;
    var l_year = l_today.substring(0, 4);
    dtAppliedFr.value = l_year + '0101';  
    // Description
    tarRequest.style.display = ""; 
    lstBankName.value = '';
    //combobox of grid
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("select pk, type_name from thr_unit_cost where CATEGORY_CODE = '10' and del_if = 0 " ) %> ";       
    grdSearch.SetComboFormat(4, ls_data);
    // status of buttons
    btnDel.SetEnable(false);
    btnSubmit.SetEnable(false);   
    btnSave.SetEnable(false);  
    btnRevise.SetEnable(false);  
    // status of req number
    txtReqNo_2.SetEnable(false); 
    // disable department
     // user name
    txtEmpID_2.SetEnable(false);
    txtEmpNM_2.SetEnable(false);
    txtemp_pk.text = user_pk;
    txtEmpID_2.text = user_id;
    txtEmpNM_2.text = user_name;
    txtUserID_3.text = user_id;
    //department
    txtDept.SetEnable(false); // dept name
    txtDeptPK.text = dept_pk;        
    //Approver
    txtApproverNM.SetEnable(false);   
    //account number
    txtAccountNumber.SetEnable(false);
    //disable join date
    dtJoin.SetEnable(false);
    // disable stataus
    lstStatus_2.SetEnable(false);                
    // disable bank name
    lstBankName.SetEnable(false);
    txtAccountNumber.SetEnable(false);
    dso_emp_info.Call();
}
//--------------------------------------------------------------
 function OnToggle() {
    var left  = document.all("tLEFT");    
    var right = document.all("tRIGHT");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="85%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 } 	
//---------------------------------------------------------------
function OnPopUp(iObj)
{
    switch(iObj)
    {
        case 'Approver':
            var path = System.RootURL + "/form/ch/hc/chhc00010_search_emp.aspx";
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if(object!=null)
            {
                txtAppr_Emp_pk.text = object[0];                                
                txtApproverNM.text = object[2];                                       
            }                
        break ;
        case 'EMP ID':
            var path = System.RootURL + "/form/ch/hc/chhc00010_search_emp.aspx";
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if(object!=null)
            {
                txtemp_pk.text = object[0];  // user pk              
                txtEmpID_2.text = object[1]; //user id
                txtEmpNM_2.text = object[2]; //user name
                txtDept.text = object[4]; // dept name                
                txtDeptPK.text = object[13]; //dept pk
                // Join Date
                var l_join_dt = object[3];                
                if( l_join_dt != null )
                {               
                    var ls_join_dt = l_join_dt.substring(6, 10) + l_join_dt.substring(3, 5) + l_join_dt.substring(0, 2);
                    dtJoin.value =  ls_join_dt; // format dd/mm/yyyy
                }                    
                // approver 
                if(object[18] != null )
                {
                    txtAppr_Emp_pk.text = object[15]; // approver_pk
                    txtApproverNM.text = object[17]; //approver_nm                                                                       
                } 
                // bank name
                pro_bank_account.Call();
            }                
        break ;
        case 'Req No':
            var fpath = System.RootURL + "/form/ch/hc/chhc00010_cc_code.aspx?idcode=CC";
            var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');
            break;        
        break ;
    }
}
//---------------------------------------------------------------
function OnSearch(iObj)
{
    switch(iObj)
    {
        case '1':                        
            if(p_update == 1 )
            {
                if(confirm ( "The current data which was not saved yet. Do you want to save?" ))
                {
                    if(CheckSaveMaster())
                        grdMst.Call();                    
                }
                btnNew.SetEnable(true);
                btnSave.SetEnable(false);
                p_update = 0;
            }
            thr_expense_mst.Call('SELECT');                           
        break ;
        case '2':
            // xu ly trang thai cua Save             
            if(grdSearch.GetGridData(grdSearch.row, 6) == '10' )//|| grdSearch.GetGridData(grdSearch.row, 6) == '60' || grdSearch.GetGridData(grdSearch.row, 6) == '100')
            {
                btnSave.SetEnable(true);                              
            }
            else
            {
                btnSave.SetEnable(false);                                            
            }        
            // xu ly trang thai cua delete
            if( grdSearch.GetGridData(grdSearch.row, 6) == '10')
            {
                btnDel.SetEnable(true);                             
            }
            else
            {
                btnDel.SetEnable(false);                
            }  
            // xu ly trang thai cua Submit button
            if(grdSearch.GetGridData(grdSearch.row, 6) == '10')
            {
                btnSubmit.SetEnable(true);                
            }
            else
            {
                btnSubmit.SetEnable(false);                
            }
            // xu ly trang thai cua Revised button
            if(grdSearch.GetGridData(grdSearch.row, 6) == '60' || grdSearch.GetGridData(grdSearch.row, 6) == '100' )
            {
                btnRevise.SetEnable(true);                
            }
            else
            {
                btnRevise.SetEnable(false);                
            }            
            if(p_update == 1)
            {
                if(confirm( "The current data which was not saved yet. Do you want to save?" ))
                {
                    if(CheckSaveMaster())
                        grdMst.Call();                    
                }
                p_update = 0;
                btnNew.SetEnable(true);
                btnSave.SetEnable(false);
            }
            thr_expense_req_pk.text = grdSearch.GetGridData(grdSearch.row, 0);
            grdMst.Call('SELECT');
        break ;
    }
}
//---------------------------------------------------------------
function OnDataReceive(iObj)
{
    switch(iObj.id)
    {
        case 'thr_expense_mst':
            if(grdSearch.rows <= 1)
            {
                btnSave.SetEnable(false);
                btnDel.SetEnable(false);
                btnSubmit.SetEnable(false);
            }            
        break ;
        case 'pro_bank_account':
            
        break ;
        case 'grdMst':
            if(p_update == 1)
            {   
                thr_expense_mst.Call('SELECT');
                p_update = 0;
            }
        break ;
        case 'pro_expense_submit':            
            btnSubmit.SetEnable(false);
            btnSave.SetEnable(false);
            btnDel.SetEnable(false);
            thr_expense_mst.Call('SELECT');
        break ;
        case 'pro_cc_expense_type':
            dtPeriodTo.value = System.AddDate(dtPeriodFr.value, Number(txtLeave.text) );
        break ;
        case 'pro_expense_revise':            
            btnRevise.SetEnable(false);
            btnSave.SetEnable(false);
            btnDel.SetEnable(false);  
            thr_expense_mst.Call('SELECT');      
        break ;
        case 'dso_emp_info':
            txtAppr_Emp_pk.text = txtManager_PK.text;
            txtApproverNM.text = txtManager_NM.text;
            txtDept.text = txtManager_DEPT.text;
            lstBankName.value = txtBankType.text;
            txtAccountNumber.text = txtAccount.text ;
            dtJoin.value = txtJoin_DT.text ;
        break ;
    }
}
//---------------------------------------------------------------
function OnNew(iObj)
{
    if(iObj == '1')
    {
        btnSave.SetEnable(true);        
        lstType.value = '';                
        grdMst.StatusInsert();
        OnReset();                     
        p_update = 1; 
        btnNew.SetEnable(false);          
    }
}
//---------------------------------------------------------------
function OnReset()
{
    txtemp_pk.text = user_pk;
    txtEmpID_2.text = user_id;
    txtEmpNM_2.text = user_name;
    txtAppr_Emp_pk.text = txtManager_PK.text;
    txtApproverNM.text = txtManager_NM.text ;
    txtLeave.text = '';
    txtAmount.text = '';
    lstBankName.value = '';
    txtAccountNumber.text = '';
    tarRequest.text = '';   // description
    txtDeptPK.text = dept_pk; // dept pk
    txtDept.text = txtManager_DEPT.text ; // department name
    lstBankName.value = txtBankType.text; //
    txtAccountNumber.text = txtAccount.text ; // account number
    dtJoin.value = txtJoin_DT.text ; //joind date
    thr_expense_req_pk.text = '';    
    lstStatus_2.value = '10';
}
//---------------------------------------------------------------
function OnSave(iObj)
{
    switch(iObj)
    {
        case '1':            
            if(grdMst.GetStatus() == 40)
            {                            
                grdMst.Call();            
                p_update = 1;
                btnNew.SetEnable(true);                        
            }
            else
            {
                if(CheckSaveMaster()) // kiem tra thong tin truoc khi save
                {
                    grdMst.Call();            
                    p_update = 1;
                    btnNew.SetEnable(true);
                }                
            }                
        break;
        case '2':
        break ;
    }
}
//---------------------------------------------------------------
function CheckSaveMaster()
{
    if(Trim(txtAppr_Emp_pk.text) == '')
    {
        alert('Please choose the Approver...');
        return false ;
    }
    else if(lstType.value == '')
    {
        alert('Please select expense type...');
        return false ;        
    }    
    else if(Number(txtLeave.text) < 0)
    {
        alert('Please enter number of leave days, not less than 0...');
        return false ;        
    }
    else if(Number(txtAmount.text) < 0)
    {
        alert('Please enter amount not less than 0...');
        return false ;        
    }
    else if ( Number(dtPeriodTo.value) < Number(dtPeriodFr.value) )
    {
        alert('Please choose leaving to date must be equal or greater than leaving from date');
        return false ;                
    }   
    return true;
}
//---------------------------------------------------------------
function OnDelete(iObj)
{
    switch(iObj)
    {
        case '1':
            //if(confirm('Are you sure you want to delete the request?'))
            {
                grdMst.StatusDelete();
                p_update = 1;
                grdMst.Call();           
            }                
        break ;
    }
}
//---------------------------------------------------------------
function OnSubmit()
{
    if(confirm('Do you want to submit this request?'))
    {
        lstStatus_2.value = '20'; 
        lstStatus.value = '20'; 
        btnSubmit.SetEnable(false);                     
        pro_expense_submit.Call();
    }
}        
//----------------------------------------------------------------
function OnSelectCCType()
{
    pro_cc_expense_type.Call();    
}
//----------------------------------------------------------------
function OnRevised()
{
    if(confirm('Do you want to submit this request again?'))
    {
        lstStatus_2.value = '110'; 
        lstStatus.value = '110';                     
        pro_expense_revise.Call();
    }
}
//----------------------------------------------------------------
</script>
<body>
<!------------------------------------------------------------------------>
<gw:data id="thr_expense_mst" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" function="hr.sp_sel_cc_expense_mst" > 
            <input bind="grdSearch" > 
                 <input bind="lstSearchBy" />
                 <input bind="txtSearchValue" /> 
                 <input bind="dtAppliedFr" /> 
                 <input bind="dtAppliedTo" />
                 <input bind="lstStatus" />
                 <input bind="txtReqNo" />
                 <input bind="txtUserID_3" />
             </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
    <gw:data id="pro_bank_account" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_cc_expense_bank" > 
                <input>
                    <input bind="txtemp_pk" /> 
                </input> 
                <output>
                    <output bind="lstBankName" />
                    <output bind="txtAccountNumber" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
    <gw:data id="dso_emp_info" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_cc_expense_empid" > 
                <input>
                 <input bind="txtemp_pk" />                                       
                </input> 
                <output>
                    <output bind="txtEmployee_ID" />                    
                    <output bind="txtEmployee_NM" />
                    <output bind="txtManager_PK" />
                    <output bind="txtManager_NM" />
                    <output bind="txtJoin_DT" />
                    <output bind="txtDeptPK" />
                    <output bind="txtManager_DEPT" />
                    <output bind="txtBankType" />
                    <output bind="txtAccount" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="grdMst" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="hr.sp_sel_cc_expense_dtl" procedure="hr.sp_upd_cc_expense" > 
            <inout>
                <inout bind="thr_expense_req_pk" />
                <inout bind="txtemp_pk" />
                <inout bind="txtEmpID_2" />
                <inout bind="txtEmpNM_2" />                
                <inout bind="txtDeptPK" />                
                <inout bind="txtDept" />                
                <inout bind="dtOccured" />                
                <inout bind="dtApplied" />                
                <inout bind="txtAppr_Emp_pk" />                
                <inout bind="txtApproverNM" />                
                <inout bind="lstType" />                
                <inout bind="dtJoin" />                
                <inout bind="lstStatus_2" />                
                <inout bind="txtLeave" />                
                <inout bind="dtPeriodFr" />
                <inout bind="dtPeriodTo" />                
                <inout bind="txtAmount" />                
                <inout bind="lstPayMethod" />                                
                <inout bind="lstBankName" />                
                <inout bind="txtAccountNumber" /> 
                <inout bind="tarRequest" />     
                <inout bind="txtReqNo_2" />               
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
    <gw:data id="pro_expense_submit" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_cc_expense_submit" > 
                <input>
                    <input bind="thr_expense_req_pk" /> 
                    <input bind="lstStatus_2" /> 
                </input> 
                <output>
                    <output bind="txtReturn" />                    
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
    <gw:data id="pro_cc_expense_type" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_cc_expense_type" > 
                <input>
                    <input bind="lstType" /> 
                </input> 
                <output>
                    <output bind="txtAmount" />
                    <output bind="lblCurrency" />
                    <output bind="txtLeave" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
    <gw:data id="pro_expense_revise" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_cc_expense_revise" > 
                <input>
                    <input bind="thr_expense_req_pk" /> 
                    <input bind="lstStatus_2" /> 
                    <input bind="dtOccured" /> 
                    <input bind="lstType" /> 
                    <input bind="txtLeave" />
                    <input bind="dtPeriodFr" />
                    <input bind="dtPeriodTo" />
                    <input bind="txtAmount" />
                    <input bind="lstPayMethod" />
                    <input bind="tarRequest" />
                </input> 
                <output>
                    <output bind="txtReturn" />                    
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
    <tr>
        <td style="width:15%"></td>
        <td style="width:85%"></td>        
    </tr>
    <tr style="height:100%">
        <td colspan="1" id="LEFT" >
            <table border="1" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr>
                    <td>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%">
                            <tr>
                                <td style="width:30%"></td>
                                <td style="width:30%"></td>
                                <td style="width:2%"></td>
                                <td style="width:30%"></td>
                                <td style="width:8%;"></td>
                            </tr>
                            <tr >
                                <td align="right">Employee&nbsp</td>
                                <td align="left"><gw:list id="lstSearchBy" styles="width:100%" value="1" >
                                        <data>
                                            DATA|1|Full Name|2|Emp ID|3|Card ID|4|Person ID
                                        </data>
                                    </gw:list>
                                </td>
                                <td align="left" colspan="2"><gw:textbox id="txtSearchValue" styles="width:100%" text="" /></td>                    
                                <td align="right"><gw:imgBtn id="btnSearch_Mst" img="search" alt="Search" styles="width:100%" onclick="OnSearch('1')" /></td>
                            </tr>
                            <tr >
                                <td align="right">Applied Date&nbsp</td>
                                <td align="left" colspan="1"><gw:datebox id="dtAppliedFr" lang="1" styles="width:100%" /></td>
                                <td align="right">~</td>
                                <td align="right" colspan="2"><gw:datebox id="dtAppliedTo" lang="1" styles="width:100%" /></td>
                            </tr>
                            <tr >
                                <td align="right">Status&nbsp</td>
                                <td align="left" colspan="4"><gw:list id="lstStatus" styles="width:100%" /></td>
                            </tr>                                            
                            <tr >
                                <td align="right">Req No&nbsp</td>
                                <td align="left" colspan="4"><gw:textbox id="txtReqNo" styles="width:100%" /></td>
                            </tr>                
                        </table>            
                    </td>                    
                </tr>
                <tr style="height:84%">
                    <td colspan="1">
                            <gw:grid id='grdSearch' 
                            header='_thr_expense_req_pk|Req No|Emp ID|Emp Name|Type|Applied Date|_status' 
                            format='0|0|0|0|0|4|0' 
                            aligns='0|0|0|0|0|0|0'
                            defaults='||||||' 
                            editcol='0|0|0|0|0|0' 
                            widths='0|1200|1200|2000|1500|800|0' 
                            styles='width:100%; height:100%'
                            acceptNullDate="T" 
                            oncellclick="OnSearch('2')" />                        
                    </td>                    
                </tr>
            </table>
        </td>
        <td valign="top" id="tRIGHT">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr >
                    <td style="width:13%"></td>
                    <td style="width:13%"></td>
                    <td style="width:2%"></td>
                    <td style="width:12%"></td>
                    <td style="width:16%"></td>
                    <td style="width:13%"></td>
                    <td style="width:12%"></td>
                    <td style="width:10%"></td>
                    <td style="width:3%"></td>
                    <td style="width:3%"></td>
                    <td style="width:3%"></td>
                </tr>
                <tr valign="top" style="height:4%">
                    <td align="right"><a title="Click here to select employee" href="#tips" onclick="OnPopUp('EMP ID')">EMP ID&nbsp</a></td>
                    <td align="right"><gw:textbox id="txtEmpID_2" styles="width:100%" csstype="mandatory" /></td>
                    <td align="right" colspan="2">Name&nbsp</td>
                    <td align="left"><gw:textbox id="txtEmpNM_2" styles="width:100%" csstype="mandatory" /></td>
                    <td align="right"><a title="Click here to select employee" href="#tips" onclick="OnPopUp('Approver')" >Approver</a></td>
                    <td align="left"><gw:textbox id="txtApproverNM" styles="width:100%" csstype="mandatory" /></td>
                    <td align="right"><gw:imgBtn id="btnNew" img="new" alt="New" onclick="OnNew('1')" /></td>
                    <td align="right"><gw:imgBtn id="btnSave" img="save" alt="Save" styles="width:100%" onclick="OnSave('1')" /></td>
                    <td align="right"><gw:imgBtn id="btnDel" img="delete" alt="Delete" styles="width:100%" onclick="OnDelete('1')" /></td>
                    <td align="right"><gw:icon id="btnSubmit" text="Submit" styles="width:100%" onclick="OnSubmit()" /></td>  
                </tr>
                <tr valign="middle" style="height:4%">
                    <td align="right" >Occurred Date&nbsp</td>
                    <td align="left" ><gw:datebox id="dtOccured" lang="1" styles="width:100%" /></td>
                    <td align="right" colspan="2" >Applied Date&nbsp</td>
                    <td align="left" ><gw:datebox id="dtApplied" lang="1" styles="width:100%" /></td>
                    <td align="right" >Status&nbsp</td>
                    <td align="left" colspan="4" ><gw:list id="lstStatus_2" styles="width:100%" csstype="mandatory" /></td>
                    <td align="right"><gw:icon id="btnRevise" text="Revised" styles="width:100%" onclick="OnRevised()" /></td>
                </tr>
                <tr valign="middle" style="height:4%">
                    <td align="right"><a title="Click here to show applicant" onclick="OnPopUp('Req No')" href="#tips" >Req No&nbsp</a></td>
                    <td align="left"><gw:textbox id="txtReqNo_2" text="" styles="width:100%" /></td>
                    <td align="right" colspan="2" >Type&nbsp</td>
                    <td align="left"><gw:list id="lstType" styles="width:100%" csstype="mandatory" onchange="OnSelectCCType()" /></td>
                    <td align="right" colspan="1">Join Date&nbsp</td>
                    <td align="left"><gw:datebox id="dtJoin" lang="1" styles="width:100%" /></td>
                    <td align="right">Department&nbsp</td>
                    <td align="left" colspan="3"><gw:textbox id="txtDept" styles="width:100%" /></td>                
                </tr>                
                <tr valign="middle" style="height:4%"> 
                    <td align="right">Leave&nbsp</td>
                    <td align="left"><gw:textbox id="txtLeave" type="number" format="###,###.##R" styles="width:100%" /></td>
                    <td align="left">Days</td>                                     
                    <td></td>   
                    <td></td>
                    <td align="right">Period&nbsp</td>
                    <td align="left" colspan="1"><gw:datebox id="dtPeriodFr" lang="1" styles="width:100%" /></td>                                
                    <td align="left">~</td>
                    <td align="right" colspan="3"><gw:datebox id="dtPeriodTo" lang="1" styles="width:100%" /></td>                                                    
                </tr>
                <tr valign="middle" style="height:4%" >
                    <td align="right">Amount&nbsp</td>
                    <td align="right"><gw:textbox id="txtAmount" text="" styles="width:100%" type="number" format="###,###" text="0" /></td>
                    <td align="left"><gw:label id="lblCurrency" text="" styles="width:100%" /></td>
                    <td align="right">Payment method&nbsp</td>                    
                    <td align="right"><gw:list id="lstPayMethod" styles="width:100%" /></td>
                    <td align="right">Bank Name&nbsp</td>
                    <td align="left" colspan="1">
                        <gw:list id="lstBankName" styles="width:100%" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0020' order by code_nm")%>||
                            </data>
                        </gw:list>
                    </td>                
                    <td align="right">Bank Account&nbsp</td>
                    <td align="left" colspan="3"><gw:textbox id="txtAccountNumber" text="" styles="width:100%" /></td>                
                </tr>    
                <tr style="height:4%">
                    <td colspan="11">&nbsp</td>
                </tr>
                <tr valign="bottom" >
                    <td colspan="1" align="right">Description&nbsp</td>
                </tr>
                <tr style="height:80%" valign="top">
                    <td colspan="11" >
                        <gw:textarea id="tarRequest" text="" styles="width:100%; " rows="20" />
                    </td>
                </tr>                                                        
            </table>            
        </td>
    </tr>
</table>
<!------------------------------------------------------------------------>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />      
<!------------------------------------------------------------------------>

<gw:textbox id="txtemp_pk" style="display:none" />
<gw:textbox id="thr_expense_req_pk" style="display:none" />
<gw:textbox id="txtReturn" style="display:none" />
<gw:textbox id="txtUserID_3" style="display:none" />
<gw:textbox id="txtAppr_Emp_pk" style="display:none" />
<gw:textbox id="txtDeptPK" style="display:none" />
<gw:textbox id="txtEmployee_ID" style="display:none" />
<gw:textbox id="txtEmployee_NM" style="display:none" />
<gw:textbox id="txtManager_PK" style="display:none" />
<gw:textbox id="txtManager_NM" style="display:none" />
<gw:textbox id="txtManager_DEPT" style="display:none" />
<gw:textbox id="txtJoin_DT" style="display:none" />
<gw:textbox id="txtBankType" style="display:none" />
<gw:textbox id="txtAccount" style="display:none" />
</body>
</html>
