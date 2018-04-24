<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Set Default Account</title>
</head>

<script>
//---------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;   
var gs_company_pk = "<%=Request.querystring("company_pk")%>";
var     idCol_TAC_COMMCODE_DETAIL_PK    = 0 ,
        idCol_TAC_COMMCODE_MASTER_PK    = 1,
        idCol_Debit_Acc_Item            = 2,
        idCol_Debit_Acc_VAT             = 3,
        idCol_Credit_Acc_Sum            = 4,
        idCol_Remark                    = 5;
//------------------------------------------------------------------------
	        
function BodyInit()
{  
        BindingData();
        //-----------
//        MergeColumn();       
}
//---------------------------------------------------------------------
function BindingData()
{
//    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 ")%>";
//    lstCompany.SetDataText(ls_data);

//    grdTO.GetGridControl().FrozenCols = 4;
    gfda00010_def_acc.Call('SELECT');
}

//-------------------------------------------------------------------------------------------
function OnPopUp()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "15" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + gs_company_pk + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
    if(event.col == idCol_Debit_Acc_Item )
    {
        o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
        if (o != null)
        {
            if(o[0] != 0)
            {                
                idGrid.SetGridText(idGrid.row, idCol_Debit_Acc_Item, o[0]);            
            }        
        }
    }
    else if(event.col == idCol_Debit_Acc_VAT )
    {
        o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
        if (o != null)
        {
            if(o[0] != 0)
            {                
                idGrid.SetGridText(idGrid.row, idCol_Debit_Acc_VAT, o[0]);            
            }        
        }    
    }
    else if(event.col == idCol_Credit_Acc_Sum )
    {
        o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
        if (o != null)
        {
            if(o[0] != 0)
            {                
                idGrid.SetGridText(idGrid.row, idCol_Credit_Acc_Sum, o[0]);            
            }        
        }        
    }
}

//---------------------------------------------------------------------
function onSave()
{
    gfda00010_def_acc.Call();
}
//---------------------------------------------------------------------
</script>

<body>
    <gw:data id="gfda00010_def_acc" >
        <xml>
            <dso type="grid" parameter="0,2,3,4,5" function="acnt.sp_sel_gfda00010_def_acc" procedure="acnt.sp_upd_gfda00010_def_acc" >
                <input bind="idGrid">                    
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>

    <!--------------------------------------------------------------->
    <table style="width: 100%; " border="1">
        <tr>
            <td style="width:95%" align="left" >Defined default account code for Debit and Credit of AP Domestic</td>            
            <td style="width: 5%"><gw:imgBtn id="ibtnSave" img="save" alt="Save" onclick="onSave()" /></td>
        </tr>
        <tr>
            <td colspan="2">
                <gw:grid
                    id      ="idGrid"  
                    header  ="_TAC_COMMCODE_DETAIL_PK|_TAC_COMMCODE_MASTER_PK|Debit.Acc of Item|Debit.Acc of VAT|Credit.Acc of Sum|Remark"
                    format  ="0|0|0|0|0|0"
                    aligns  ="0|0|1|1|1|0"
                    defaults="|||||"
                    editcol ="0|0|0|0|0|1"
                    widths  ="0|0|2000|2000|2000|2500"
                    styles  ="width:100%; height:200"
                    sorting ="F"  
                    oncelldblclick = "OnPopUp()"
                    />            
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------------->
</body>
</html>
