<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>MR LIST</title>
</head>

<script>
 
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
    var  user_id  = "<%=Session("USER_ID")%>" ;
    
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
        G2_ETD_Date         = 8,    
        G2_tco_itemgrp_pk   = 9,
        G2_Grp_Name         = 10,
        G2_TCO_ITEM_PK      = 11,
        G2_Item_Code        = 12,
        G2_Item_Name        = 13,
        G2_UOM              = 14,
        G2_Spec             = 15,
        G2_Req_Qty          = 16,
        G2_U_P              = 17,
        G2_Amount           = 18,
        G2_PO_Qty           = 19,
        G2_TakeIn_Date      = 20,
        G2_Status           = 21,
        G2_TakeIn_Qty       = 22,
        G2_Description      = 23,
        G2_REF_TABLE        = 24,
        G2_REF_PK           = 25;
         
 //---------------------------------------------------------
 function BodyInit()
 {

      txt_user_pk.text = user_pk;
      //---------------------- 
      dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
      
      //----------------------
      BindingDataList();
      OnFormatGrid();
    //----------------POSCO------------------
    txtEmpPK.text = user_pk
    //----------------POSCO------------------      
    } 


 //---------------------------------------------------------
 
 function BindingDataList()
 {
        var data ;
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_LOGISTIC_CODE('LGIN0010') FROM DUAL")%>|ALL|Select ALL"; 
        lstStatusSearch.SetDataText(data);
        lstStatusSearch.value = "ALL";              
        
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   code, code_nm  FROM sale.lg_code a, sale.lg_code_group b  WHERE a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGIN0010' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn DESC, ord" ) %> ";       
        grdMaster.SetComboFormat(G1_Status,data); 
        
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='PRCP0130' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " ) %> ";       
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
    grdDetail.GetGridControl().Cell( 7, 0, G2_ETD_Date, 0, G2_ETD_Date) = 0x3300cc;

 }

 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
            case 'Master' :
                if(rdoAppli.value =='1')
                {
                    txtEmpID.text = '';
                    txtEmpPK.text = user_pk;
                }
                else      
                {
                    txtEmpID.text = user_id;
                    txtEmpPK.text = '';
                }
                
                chlc00040.Call("SELECT");
            break; 
            
            case 'Detail' :
                
                if ( grdMaster.row > 0 )
                {                
                    txtMaster_PK.text = grdMaster.GetGridData( grdMaster.row, G1_PK );                                       
                }
                else
                {
                    txtMaster_PK.text = '' ;
                }    
                chlc00040_1.Call("SELECT");   
            break;             
      }  
 }

 //---------------------------------------------------------
function OnDataReceive(po_oData)
{
      switch (po_oData.id)         
      {		        
            case 'chlc00040' :
                OnSearch('Detail');
            break;
            case 'chlc00040_1':
                if(grdDetail.rows>1)
                    grdDetail.SetCellFontColor(1,G2_Status,grdDetail.rows-1,G2_Status,0x0033CC);
            break;
      }      
}            
  //---------------------------------------------------------
function SetStatus()
{
    if(lstStatusSearch.value!='ALL')
    {
        for ( i = 1 ; i < grdMaster.rows ; i++ )
        {
            if ( grdMaster.GetGridControl().isSelected(i) == true )
            {

                grdMaster.SetGridText( i, iD_status, lstStatusSearch.value) ;

            } 
        } 
    }
}
 //---------------------------------------------------------
 
 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 'Master' :                
                chlc00040.Call();
            break;
           
      }  
 }
 //------------------------------------------------------------------
 
 function TextOnBlur()
 {
    if ( grdMaster.row > 0 )
    {
        grdMaster.SetGridText( grdMaster.row, G1_ATT02, txtRespone.GetData() );
    }    
 }
 //------------------------------------------------------------------

 function OnAdd()
 {
        var fpath = System.RootURL + "/form/ch/lc/chlc00020.aspx";

	    var object = System.OpenModal( fpath ,800 , 600 ,  'resizable:yes;status:yes');

        if ( object!=null )
        {

        }
        
        OnSearch('Master');    
        
 }
 
 //------------------------------------------------------------------
 
 function OnUpdate()
 {
        if ( txtMaster_PK.text != '' )
        {
            var fpath = System.RootURL + "/form/ch/lc/chlc00020.aspx?master_pk=" + txtMaster_PK.text  ;

	        var object = System.OpenModal( fpath ,800 , 600 ,  'resizable:yes;status:yes');

            if ( object!=null )
            {

            }
            
            OnSearch('Master');    
        }
        else
        {
            alert('PLs Select one Application');
        }
        
 }
 //------------------------------------------------------------------
 function onDelete()
 {
    if(grdMaster.GetGridData( grdMaster.row, G1_Status)=='10')
    {
        if(confirm("Do you want to delete this Request?"))
        {
            grdMaster.DeleteRow();
            chlc00040.Call('');
        }
    }       
    else
    {
        alert("Delete only save status!! ");
        return;
    }
 } 
 //------------------------------------------------------------------
 function onMasterClick()
 {
    if(grdMaster.row>0)
    {
        OnSearch('Detail');
        txtRespone.SetDataText(grdMaster.GetGridData(grdMaster.row,G1_ATT02));
        txtGAMRespone.SetDataText(grdMaster.GetGridData(grdMaster.row,G1_GAM_Response)) ;
    }
 }
 //------------------------------------------------------------------ 
 
 function OnReplicate()
 {
        if ( txtMaster_PK.text != '' )
        {
            var fpath = System.RootURL + "/form/ch/lc/chlc00020.aspx?master_pk=" + txtMaster_PK.text + "&replicate=Y" ;

	        var object = System.OpenModal( fpath ,800 , 600 ,  'resizable:yes;status:yes');

            if ( object!=null )
            {

            }
            
            OnSearch('Master');
        }
        else
        {
            alert('PLs Select one Application');        
        }
 }
 //------------------------------------------------------------------
 function OnCancel()
 {
      for ( i = 1 ; i < grdMaster.rows ; i++ )
        {
            if ( grdMaster.GetGridControl().isSelected(i) == true )
            {
                if(grdMaster.GetGridData( i, G1_Status)=='20')
                {
                    grdMaster.SetGridText( i, G1_Status, '60') ;
                }    
                else
                {
                    alert("You can cancel request when it is submitted!!");
                    return;
                }          
            } 
        }  
     OnSave('Master');
 }
 //------------------------------------------------------------------
 function OnBFEdit()
 {
    if ((grdMaster.col == G1_Status) || (grdMaster.col == G1_Deli_Loc ))
    {
        grdMaster.GetGridControl().Col = G1_MR_No ;
    }
 }
 //------------------------------------------------------------------  

</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="chlc00040" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid" user="prod" parameter='9,13,16' function="hr.sp_sel_chlc00040" procedure="hr.sp_upd_chlc00040" >
                <input  bind="grdMaster">
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="lstStatusSearch" />
                    <input bind="txtEmpPK" />
                    <input bind="txtEmpID" />
                </input> 
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <gw:data id="chlc00040_1" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid" user="prod" function="hr.sp_sel_chlc00040_1" >
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
                            Request Date
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" />
                            ~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="width: 10%" align="right">
                            Status
                        </td>
                        <td style="width: 20%" align="right">
                            <gw:list id="lstStatusSearch" styles="width: 100%" onchange="" />
                        </td>
                        <td style="width: 3%" align="right">
                        </td>
                        <td style="width: 30%" align="right" nowrap>
                            <gw:radio id="rdoAppli" value="1">
                                <span value="1">My application</span>
                                <span value="2">All application I made</span>
                            </gw:radio>
                        </td>
                        <td style="width: 4%">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 95%">
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="New" styles='width:100%' text="New" onclick="OnAdd()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="Update" styles='width:100%' text="Update" onclick="OnUpdate()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="Cancel" styles='width:100%' text="Cancel Req." onclick="OnCancel()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="Replicate" styles='width:100%' text="Replicate" onclick="OnReplicate()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="Delete" styles='width:100%' text="Delete" onclick="onDelete()" />
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 38%">
            <td>
                <gw:grid id='grdMaster' header='Date|_TCO_DEPT_PK|_Dept Name|Req No|_REQ_EMP_PK|Employee|Deli Loc|_LINE_NAME|_PL_NM|Status|_Amount|_Bugdet|Purpose|_Response|_ATT03|Remark|_PK|_GAM_Response'
                    format='4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='1|0|0|0|0|0|0|0|0|0|3|3|0|0|0|0|0'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1200|1000|2000|1500|1000|2000|2000|1000|1000|1500|1500|1500|1000|1000|1000|1000|1000'
                    sorting='T' styles='width:100%; height:100%' onclick="onMasterClick()" onbeforeedit="OnBFEdit()" />
            </td>
        </tr>
        <tr style="height: 40%">
            <td>
                <gw:grid id='grdDetail' header='_PK|_TPR_POREQ_PK|_TPR_MATCONS_PK|_TAC_ABPL_PK|_NO|_TPR_WH_PK|_Warehouse|_Req Date|ETD|_tco_itemgrp_pk|_Grp Name|_TCO_ITEM_PK|_Item Code|Item Name|UOM|_Spec|Req Qty|U/P|Amount|_PO Qty|_Receive Date|Status|_Receive Qty|Remark(GA)|_REF_TABLE|_REF_PK'
                    format='0|0|0|0|0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0' aligns='0|0|0|0|0|0|0|1|1|0|0|0|0|0|1|0|3|3|3|3|1|0|3|0|0|0'
                    editcol='0|0|0|0|1|0|0|0|1|0|0|0|0|0|0|1|1|1|1|0|0|0|0|1|0|0' widths='1000|1000|1000|1000|1000|1000|2000|1200|1200|1000|1500|1000|1500|3000|800|1500|1200|1200|1200|1200|1200|1200|1200|1000|1000|1000'
                    sorting='T' styles='width:100%; height:100%' acceptnulldate='Y' />
            </td>
        </tr>
        <tr style="height: 20%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 50%" align="left">
                            Response
                        </td>
                        <td style="width: 50%" align="left">
                            GAM Response
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td>
                            <gw:textarea id="txtRespone" styles="width:100%;height:95%" onblur="TextOnBlur()" />
                        </td>
                        <td>
                            <gw:textarea id="txtGAMRespone" styles="width:100%;height:95%" onblur="TextOnBlur()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 19%">
        </tr>
    </table>
    <!------------------------------------------------------------------>
    <gw:textbox id="txtMaster_PK" style="display: none" />
    <gw:textbox id="txtReturnValue" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txt_user_pk" maxlen="100" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
    <gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtEmpID" styles="width: 100%;display: none" />
</body>
</html>
