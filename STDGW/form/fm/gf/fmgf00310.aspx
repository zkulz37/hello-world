<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Inventory Daily Closing</title>
</head>

<script>

var  reponse_row ;
 
var  user_pk   = "<%=Session("EMPLOYEE_PK")%>";
var  user_name = "<%=Session("USER_NAME")%>"  ;
//idGrid1

var G_Stock_Date    = 0,
    G_Confirm_YN    = 1,
    G_Confirm_Date  = 2,
    G_Close_YN      = 3,
    G_Close_Date    = 4,
    G_CHARGER_PK    = 5,
    G_Charger_ID    = 6,
    G_Charger_Name  = 7,
    G_Description   = 8;
    
//==========================================================================================
 function BodyInit()
 {
     var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 ")%>";
    lstCompany.SetDataText(ls_data);    

        //-----------------
        dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-30));
        //-----------------        
 } 
//==========================================================================================
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
            case 'grdDetail' :
                data_fmgf00310.Call("SELECT");
            break;     
      }  
 }
//==========================================================================================
 function OnDataReceive(po_oData)
 { 
      switch (po_oData.id)         
      {
            case "dso_upd_price" :
               /* for(var i =1; i<idGrid.rows; i++)
                {
                    if ( idGrid.GetGridData( i, G_ST_BOM_PK) == "")
                    {
                         idGrid.GetGridControl().Cell( 6 , i , 0 , i, idGrid.cols - 1 ) = 0xCCFFFF;
                    }     
                }
                OnTotal();
                
                reponse_row = 0 ;*/
                 data_fmgf00310.Call("SELECT");
            break;      
            
      }  
 }
//==========================================================================================
function OnSave()
{
     data_fmgf00310.Call();
}
 
//==========================================================================================

 function OnProcess(pos)
 {
      switch (pos)         
      {		        
            case 'Close' :
                if(confirm('Are you sure you want to close inventory on ' + dtFrom.text + ' ?'))
                {         
                    txt_Close_YN.text = 'Y';   
                    for ( i = 1 ; i < grdDetail.rows ; i++ )
                    {
                        if ( grdDetail.GetGridControl().isSelected(i) == true )
                        {
                            grdDetail.SetGridText( i, G_Close_YN, -1) ;
                            
                            grdDetail.SetGridText( i, G_CHARGER_PK,   user_pk   ) ;
                            grdDetail.SetGridText( i, G_Charger_Name, user_name ) ;
                        } 
                    }
                    //OnSave(); 
                    dso_upd_price.Call();
                }                
            break;
            
            case 'UnClose' :
                txt_Close_YN.text = 'N';
                for ( i = 1 ; i < grdDetail.rows ; i++ )
                {
                    if ( grdDetail.GetGridControl().isSelected(i) == true )
                    {
                        grdDetail.SetGridText( i, G_Close_YN, 0) ;
                    } 
                }  
                //OnSave();         
                dso_upd_price.Call();
            break;
            
            case 'Confirm' :
                if ( confirm('Are you sure?') )
                {
                    for ( i = 1 ; i < grdDetail.rows ; i++ )
                    {
                        if ( grdDetail.GetGridControl().isSelected(i) == true )
                        {

                            grdDetail.SetGridText( i, G_Confirm_YN, -1) ;
                            
                            grdDetail.SetGridText( i, G_CHARGER_PK,   user_pk   ) ;
                            grdDetail.SetGridText( i, G_Charger_Name, user_name ) ;
                        } 
                    } 
                    OnSave();  
                }              
            break;
            
            case 'UnConfirm' :
                for ( i = 1 ; i < grdDetail.rows ; i++ )
                {
                    if ( grdDetail.GetGridControl().isSelected(i) == true )
                    {

                        grdDetail.SetGridText( i, G_Confirm_YN, 0) ;
                    } 
                } 
                OnSave();          
            break;            
      }  
 }
 //==========================================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_fmgf00310" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="acnt"  parameter="0,3,4" function="acnt.sp_sel_fmgf00310" procedure="acnt.sp_upd_fmgf00310" > 
                <input> 
                    <input bind="dtFrom" />
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="dso_upd_price" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_fmgf00310" >
                <input> 
                    <input bind="lstCompany" />
                    <input bind="dtFrom" /> 
                    <input bind="txt_Close_YN" /> 
                </input>  
                <output>
                     <output bind="txtReturn" />
				</output> 
            </dso> 
        </xml> 
    </gw:data>
    
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 10%">Company&nbsp;</td>
                        <td style="width: 10%"><gw:list id="lstCompany" /></td>
                        <td style="width: 20%" align="right">
                            Stock Date
                        </td>
                        <td style="width: 20%; white-space: nowrap" align="left">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" />
                            ~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="width: 18%" align="right">
                        </td>
                        <td style="width: 1%" align="center">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="" onclick="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 1%" align="center">
                            <!-- <gw:imgbtn id="ibtnSave" img="save" alt="Save" onclick="OnSave()" /> -->
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:icon id="idBtnConfirm" img="1" text="Confirm" styles='width:100%;display:none;' onclick="OnProcess('Confirm')" />
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:icon id="idBtnUnConfirm" img="1" text="UnConfirm" styles='width:100%;display:none;' onclick="OnProcess('UnConfirm')" />
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:icon id="idBtnClose" img="2" text="Close" styles='width:100%' onclick="OnProcess('Close')" />
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:icon id="idBtnUnClose" img="2" text="UnClose" styles='width:100%' onclick="OnProcess('UnClose')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td>
                <gw:grid id='grdDetail' header='Stock Date|_Confirm YN|_Confirm Date|Close YN|Close Date|_CHARGER_PK|Charger ID|_Charger Name|_Description'
                    format='4|3|4|3|4|0|0|0|0' aligns='1|0|1|0|1|0|0|0|0' defaults='||||||||' editcol='0|1|0|1|0|0|0|0|1'
                    widths='1500|1500|1500|1500|1500|0|1500|2500|1000' sorting='T' styles='width:100%; height:100%'
                    acceptnulldate='T' />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------------->
    <gw:textbox id="txtMaster_PK" style="display: none" />
    <gw:textbox id="txtReturnValue" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txt_user_pk" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txt_Close_YN" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtReturn" maxlen="100" styles='width:100%;display:none' />
    <!------------------------------------------------------------------------------->
</body>
</html>
