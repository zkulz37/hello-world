<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>GAM APPROVE</title>
</head>

<script>
 
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
    var action ='';
    
    var G1_Date         = 0,
        G1_TCO_DEPT_PK  = 1, 
        G1_Dept_Name    = 2,
        G1_MR_No        = 3,
        G1_REQ_EMP_PK   = 4,
        G1_Employee     = 5,
        G1_Deli_Loc     = 6,
        G1_LINE_NAME    = 7, 
        G1_PL_NM        = 8,
        G1_Status       = 9,
        G1_Amount       = 10,
        G1_Budget       = 11,
        G1_ATT01        = 12,
        G1_ATT02        = 13,
        G1_ATT03        = 14,
        G1_Description  = 15,
        G1_PK           = 16,  
        G1_GAM_Response = 17;      
                      
    var G2_PK               = 0,
        G2_TPR_POREQ_PK     = 1,
        G2_TPR_MATCONS_PK   = 2,
        G2_TAC_ABPL_PK      = 3,
        G2_NO               = 4,
        G2_TPR_WH_PK        = 5,
        G2_Warehouse        = 6,
        G2_Req_Date         = 7,
        G2_tco_itemgrp_pk   = 8,
        G2_Grp_Name         = 9,
        G2_TCO_ITEM_PK      = 10,
        G2_Item_Code        = 11,
        G2_Item_Name        = 12,
        G2_UOM              = 13,
        G2_Spec             = 14,
        G2_Req_Qty          = 15,
        G2_U_P              = 16,
        G2_Amount           = 17,
        G2_PO_Qty           = 18,
        G2_TakeIn_Qty       = 19,
        G2_Status           = 20
        G2_Description      = 21,
        G2_REF_TABLE        = 22,
        G2_REF_PK           = 23;
         
 //---------------------------------------------------------
 function BodyInit()
 {

      txt_user_pk.text = user_pk;
      //---------------------- 
      dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
      
      //----------------------
      BindingDataList();
      OnFormatGrid();
    } 


 //---------------------------------------------------------
 
 function BindingDataList()
 {
        var data ;
        
        data = "<%=ESysLib.SetListDataSQL("SELECT   code, code_nm  FROM sale.lg_code a, sale.lg_code_group b  WHERE a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGIN0010' and (a.code = '30' or a.code between '080' and '100')  AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn DESC, ord")%>|ALL|Select ALL"; 
        lstStatusSearch.SetDataText(data);
        lstStatusSearch.value = "30";
        
        data = "<%=ESysLib.SetListDataSQL("SELECT   pk, org_nm FROM comm.tco_org a  WHERE del_if = 0 AND (a.leaf_yn <> 'N' OR a.leaf_yn IS NULL) ORDER BY org_nm")%>|ALL|Select ALL"; 
        lstOrg.SetDataText(data);
        lstOrg.value = "ALL";        
        
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   code, code_nm  FROM sale.lg_code a, sale.lg_code_group b  WHERE a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGIN0010' and a.code <>'10' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn DESC, ord" ) %> ";       
        grdMaster.SetComboFormat(G1_Status,data); 
        
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='PRAB0270' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " ) %> ";       
        grdMaster.SetComboFormat(G1_Deli_Loc,data);        
 }        
 
 //------------------------------------------------------------------------------------------------
 function OnFormatGrid()
 {
    var trl ;
    
    //--------------------------------------------------------
    trl = grdMaster.GetGridControl();
    
    trl.ColFormat(G1_Amount)        = "###,###,###,###,###.##";
    trl.ColFormat(G1_Budget)        = "###,###,###,###,###.##";
    //--------------------------------------------------------
    trl = grdDetail.GetGridControl();
    
    trl.ColFormat(G2_Req_Qty)       = "###,###,###,###,###.##";
    trl.ColFormat(G2_U_P)           = "###,###,###,###,###.##";
    trl.ColFormat(G2_Amount)        = "###,###,###,###,###.##";
    trl.ColFormat(G2_PO_Qty)        = "###,###,###,###,###.##";
    trl.ColFormat(G2_TakeIn_Qty)    = "###,###,###,###,###.##";
    //--------------------------------------------------------
    
 }

 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
            case 'Master' :                
                chlc00070.Call("SELECT");
            break; 
            
            case 'Detail' :
                
                if ( grdMaster.row > 0 )
                {   
                    txtAmt.SetDataText('' + grdMaster.GetGridData(grdMaster.row,G1_Amount));
                    txtBudget.text = '' + grdMaster.GetGridData(grdMaster.row,G1_Budget);
                    txtMaster_PK.text = grdMaster.GetGridData( grdMaster.row, G1_PK ); 
                    txtDeptPk.text = grdMaster.GetGridData( grdMaster.row, G1_TCO_DEPT_PK );  
                    txtDate.text = grdMaster.GetGridData( grdMaster.row, G1_Date);                  
                } 
                else
                {
                    txtMaster_PK.text = '' ;
                }    
                chlc00070_1.Call('SELECT');   
            break;             
      }  
 }

 //---------------------------------------------------------
function OnDataReceive(po_oData)
{
      switch (po_oData.id)         
      {		        
            case 'chlc00070' :
            if(action=='save')
                OnSearch('Detail');
            break;
            
            case 'chlc00070_1':
                if(grdDetail.rows>1)
                    grdDetail.SetCellFontColor(1,G2_Status,grdDetail.rows-1,G2_Status,0x0033CC);
                for(i=1; i<grdDetail.rows; i++)
                    grdDetail.SetGridText(i, G2_NO,i);    
            break;
      }      
}            

//---------------------------------------------------------
function SetStatus(codeStatus)
{   
    var l_status;
    
    switch(codeStatus)
    {
        case '80':
            l_status ='Approved (GA)';
        break;
        case '90':
            l_status = 'Request Infomation (GA)';
        break;
        case '100':
            l_status = 'Reject (GA)';
        break;
    }
    for ( i = 1 ; i < grdMaster.rows ; i++ )
    {
        
        if ( grdMaster.GetGridControl().isSelected(i) == true )
        {            
            if(grdMaster.GetGridData( i, G1_Status)=='30')
            {
                if(Validate(codeStatus,i))
                {
                    grdMaster.SetGridText( i, G1_Status, codeStatus) ;
                }
            }   
            else
            {
                alert("You can Approve when Request was approved by Manager!!!");
                return;
            }
        } 
    }
    
    OnSave('Master');
}
 //----------------------------------------------------------------------------------
 
 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'Master' :     
                action='save';           
                chlc00070.Call();               
            break;           
      }  
 }
 //------------------------------------------------------------------
 function onMasterClick()
 {
    if(grdMaster.row>0)
    {
        OnSearch('Detail');
        txtRespone.SetDataText(grdMaster.GetGridData(grdMaster.row,G1_GAM_Response));
    }
 }
 //------------------------------------------------------------------
 
 function TextOnBlur()
 {
    if ( grdMaster.row > 0 )
    {
        grdMaster.SetGridText( grdMaster.row, G1_GAM_Response, txtRespone.GetData() );
    }    
 }
 
 //-------------------------------------------------------------------
 function OnBFEdit()
 {
    if ((grdMaster.col == G1_Status) || (grdMaster.col == G1_Deli_Loc))
        grdMaster.GetGridControl().Col = G1_MR_No;
 }
 //------------------------------------------------------------------
 function Validate(codeStatus, i)
 {
    if (((codeStatus== '90')||(codeStatus== '100') ) && (grdMaster.GetGridData(i, G1_GAM_Response)==''))
        {
            alert("Please enter response for request " + grdMaster.GetGridData(i, G1_MR_No) + "!");
            return false;
        }
   
    return true;
 }
 //------------------------------------------------------------------
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="chlc00070" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid" user="prod" parameter='9,16' function="hr.sp_sel_chlc00070" procedure="hr.sp_upd_chlc00070" >
                <input  bind="grdMaster">
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="lstOrg" />  
                    <input bind="lstStatusSearch" />
                </input> 
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <gw:data id="chlc00070_1" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid" user="prod" parameter="0,20" function="hr.sp_sel_chlc00070_1" procedure="hr.sp_upd_chlc00070_1">
                <input  bind="grdDetail">
                    <input bind="txtMaster_PK" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>  
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 10%">
                            Req Date
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" />
                            ~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="width: 10%" align="right">
                            Dept
                        </td>
                        <td style="width: 20%" align="right">
                            <gw:list id="lstOrg" styles="width:100%;" />
                        </td>
                        <td style="width: 10%" align="right">
                            Status
                        </td>
                        <td style="width: 20%" align="right">
                            <gw:list id="lstStatusSearch" styles="width: 100%;" onchange="" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <%--<gw:imgbtn id="ibtnSave1" img="save" alt="Save" onclick="OnSave('Master')" />--%>
                            <gw:icon id="btnGAMApprove" styles='width:100%;display:none' text="GAM Approve" onclick="SetStatus('80')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnApprove" styles='width:100%' text="Approve" onclick="SetStatus('80')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnReject" styles='width:100%' text="Reject" onclick="SetStatus('100')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnReqInfo" styles='width:100%' text="Req Info" onclick="SetStatus('90')" />
                        </td>
                    </tr>  
                </table>
            </td>
        </tr>
        <tr style="height: 39%">
            <td>
                <gw:grid id='grdMaster' header='Date|_TCO_DEPT_PK|Dept Name|Req No|_REQ_EMP_PK|Employee|Deli Loc|_LINE_NAME|_PL_NM|Status|Amount|_Bugdet|Purpose|_Response|_ATT03|Description|_PK|_GAM_Response'
                    format='4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='1|0|0|0|0|0|0|0|0|0|3|3|0|0|0|0|0|0'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1200|1000|2000|1500|1000|2000|2000|1000|1000|1500|1200|1200|1000|1000|1000|1000|1000|0'
                    sorting='T' styles='width:100%; height:100%' onclick="onMasterClick()"  onbeforeedit="OnBFEdit()"/>
            </td>
        </tr>
        <tr style="height: 40%">
            <td>
                <gw:grid id='grdDetail' header='_PK|_TPR_POREQ_PK|_TPR_MATCONS_PK|_TAC_ABPL_PK|NO|_TPR_WH_PK|_Warehouse|Req Date|_tco_itemgrp_pk|Grp Name|_TCO_ITEM_PK|Item Code|Item Name|UOM|_Spec|Req Qty|U/P|Amount|_PO Qty|_TakeIn Qty|Status|Description|_REF_TABLE|_REF_PK'
                    format='0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|1|0|0|1|0|0|0|0|0|1|0|3|3|3|3|3|0|0|0|0'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|0|0' widths='1000|1000|1000|1000|1000|1000|2000|1200|1000|1500|1000|1500|3000|800|1500|1200|1200|1200|1200|1200|1300|1000|1000|1000'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 10%" align="left">
                            Response
                        </td>
                        <td style="width: 65%" align="right">
                            Amount / Budget :
                        </td>
                        <td style="width: 7%" align="center" nowrap>
                            <gw:textbox id="txtAmt"  text="1" type="number" format="#,###,###,###,###.##R" styles='width:100%;'/>
                        </td> 
                        <td style="width: 1%">/</td>
                        <td style="width: 7%"><gw:textbox id="txtBudget"  text="1" type="number" format="#,###,###,###,###.##R" styles='width:100%;'/></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 19%">
            <td>
                <gw:textarea id="txtRespone" styles="width:100%;height:95%" onblur="TextOnBlur()" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
    <gw:textbox id="txtMaster_PK" style="display: none" />
    <gw:textbox id="txtReturnValue" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txt_user_pk" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeptPk" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDate" maxlen="100" styles='width:100%;display:none' /> 
    <gw:textbox id="txtManager_KIND" style="display:none" />
    <!------------------------------------------------------------------>
</body>
</html>
