<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%  
    ESysLib.SetUser("SALE")
    Dim l_user As String
    l_user = "SALE."
%>

<head id="Head1" runat="server">
    <title>Ex-Invoice : Pop Up Get Item from S/O</title>
</head>

<script>

var v_language  = "<%=Session("SESSION_LANG")%>";
var emp_pk      = "<%=Session("EMPLOYEE_PK") %>";
var full_name   = "<%=Session("USER_NAME") %>";

var G1_SO_PK        = 0,
    G1_Ord_Date     = 1,
    G1_PO_No        = 2,
    G1_Partner_PK   = 3, 
    G1_Partner_ID   = 4,
    G1_Partner_Name = 5,
    G1_Ord_Qty      = 6,
    G1_Inv_Qty      = 7,
    G1_Bal_Qty      = 8,
    G1_Description  = 9;
       
var G2_PO_No     = 0,
    G1_SO_D_PK   = 1,
    G2_Seq       = 2 
    G2_ST_ITEM_PK= 3
    G2_ITEM_PK   = 4
    G2_ITEM_CODE = 5
    G2_ITEM_NAME = 6
    G2_Spec01_PK = 7,
    G2_Spec01_ID = 8,
    G2_Spec02_PK = 9,
    G2_Spec02_ID = 10,
    G2_Spec03_PK = 11,
    G2_Spec03_ID = 12,
    G2_Spec04_PK = 13,
    G2_Spec04_ID = 14,
    G2_Spec05_PK = 15,
    G2_Spec05_ID = 16,
    G2_HS_CODE   = 17,
    G2_UOM       = 18,
    G2_Ord_Qty   = 19,
    G2_UP        = 20,
    G2_Amount    = 21;  
        
//=======================================================================
   
function BodyInit()
{
    //-------------------------------
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-30));
    //-------------------------------
    FormatGrid();  
    OnToggleGrid();  
    //-------------------------------
    OnSearch('grdSO');
    //-------------------------------   
}
//=======================================================================
function FormatGrid()
{
    var ctrl = grdDetail.GetGridControl();  
      
    ctrl.MergeCells = 2;
    ctrl.MergeCol(G2_PO_No)  = true;

    ctrl.ColFormat(G2_Ord_Qty) = "###,###,###,###.##";
    ctrl.ColFormat(G2_UP)      = "###,###,###,###.##";
    ctrl.ColFormat(G2_Amount)  = "###,###,###,###.##";  
    
    ctrl = grdSO.GetGridControl(); 
        
    ctrl.ColFormat(G1_Ord_Qty) = "###,###,###,###";
    ctrl.ColFormat(G1_Inv_Qty) = "###,###,###,###";
    ctrl.ColFormat(G1_Bal_Qty) = "###,###,###,###";
}

//=======================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_epex00032':
            lbRecord.text = grdSO.rows-1 + " record(s)";
            
            if ( grdSO.rows > 1 )
            {
                grdSO.SetCellBold( 1, G1_Ord_Qty,  grdSO.rows - 1, G1_Ord_Qty, true);
                grdSO.SetCellBold( 1, G1_Inv_Qty,  grdSO.rows - 1, G1_Inv_Qty, true);
                grdSO.SetCellBold( 1, G1_Bal_Qty,  grdSO.rows - 1, G1_Bal_Qty, true);
                grdSO.SetCellBgColor( 1, G1_Partner_ID , grdSO.rows - 1, G1_Partner_Name , 0xCCFFFF ); 
                
                grdSO.Subtotal( 0, 2, -1, '6!7!8','###,###,###');   
            }            
        break;        
        
        case 'data_epex00032_2':
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBold( 1, G2_Ord_Qty, grdDetail.rows - 1, G2_Ord_Qty, true);
                grdDetail.SetCellBold( 1, G2_UP,      grdDetail.rows - 1, G2_UP,      true);
                grdDetail.SetCellBold( 1, G2_Amount,  grdDetail.rows - 1, G2_Amount,  true);              
                
                grdDetail.SetCellBgColor( 1, G2_Amount, grdDetail.rows - 1, G2_Amount, 0xCCFFFF );
                
                grdDetail.Subtotal( 0, 2, -1, '19!21','###,###,###.##');                
            }    
        break; 
        
        case 'pro_epex00032':
            alert(txtReturnValue.text);
            
            OnSearch('grdSO');
        break;       
    }
}
 
//=======================================================================

function OnSearch(obj)
{
    switch(obj)
    {
        case 'grdSO':
            data_epex00032.Call("SELECT");
        break;
    
        case 'grdDetail':

            var t = 0 ;
            
            var array_po       = '';
            var array_so_pk    = '';
                            
            for(var i = 1; i < grdSO.rows && t < 15; i++)
            {
                if ( grdSO.GetGridControl().isSelected(i) == true )
                {  
                    t = t + 1 ;    
                                       
                    array_po       = array_po    + grdSO.GetGridData( i, G1_PO_No) + ',';
                    array_so_pk    = array_so_pk + grdSO.GetGridData( i, G1_SO_PK) + ',';              
                }
            }
                                   
            array_po       = array_po.substring(       0, array_po.length-1       );
            array_so_pk    = array_so_pk.substring(    0, array_so_pk.length-1    ); 
             
            if ( array_so_pk == '' )
            {
                alert('You must select one P/O.');
            }
            else
            {
                txtArraySOPK.text    = array_so_pk ;
                lbPONo.text          = array_po ;
                                    
                data_epex00032_2.Call("SELECT");
            }                                                 
            //-----------------------------------            
        break;               
    }
}

//=========================================================

function OnSelect(pos)
{
    switch (pos)
    {
        case 'Partial' :
                            
            var arr_data = new Array();
            // the last row is sub total --> no need to select 
            for(var i = 1; i < grdDetail.rows-1; i++ )
            {
                if ( grdDetail.GetGridControl().isSelected(i) == true )
                {
                     var arrTemp = new Array();
                         
                     for( var j = 0; j < grdDetail.cols; j++ )
                     {
                          arrTemp[arrTemp.length]= grdDetail.GetGridData(i,j);
                     }
                         
                     arr_data[arr_data.length]= arrTemp;
                }
            }
            
            if ( arr_data != null )
            {
                var callerWindowObj = dialogArguments;    
                  
                callerWindowObj.txtArraySOPK.text = txtArraySOPK.text ;
                callerWindowObj.txtRefPONo.text   = lbPONo.text       ;                                
            }
                      
            window.returnValue =  arr_data;
            window.close();
            
        break;
        
        case 'ALL' :
            var arr_data = new Array();
            // the last row is sub total --> no need to select 
            for(var i = 1; i < grdDetail.rows-1; i++ )
            {
                 var arrTemp = new Array();
                     
                 for( var j = 0; j < grdDetail.cols; j++ ) 
                 {
                      arrTemp[arrTemp.length]= grdDetail.GetGridData(i,j);
                 }
                     
                 arr_data[arr_data.length]= arrTemp;
            }

            if ( arr_data != null )
            {
                var callerWindowObj = dialogArguments;    
                  
                callerWindowObj.txtArraySOPK.text = txtArraySOPK.text ;
                callerWindowObj.txtRefPONo.text   = lbPONo.text       ;             
            }
                                  
            window.returnValue =  arr_data;
            window.close();
            
        break;        
    }        
} 

//=========================================================
function OnProcess(pos)
{
    switch (pos)
    {
        case 'PackBalance' :
            if ( grdSO.row > 0 )
            {
                if ( confirm('Do you want to calculate invoice balance for this order ?') )
                {
                    txtSOPK.text = grdSO.GetGridData( grdSO.row, G1_SO_PK);
                    
                    pro_epex00032.Call();
                }    
            }
            else
            {
                alert('Pls select one S/O.');
            }
        break;
    }
}
//=========================================================
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdDetail.GetGridControl().ColHidden(G2_Spec01_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G2_Spec02_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G2_Spec03_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G2_Spec04_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G2_Spec05_ID) = true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G2_Spec01_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G2_Spec02_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G2_Spec03_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G2_Spec04_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G2_Spec05_ID) = false ;				
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
} 
 //===================================================================================

</script>

<body>
    <!-------------------------------------------------------------------->
    <gw:data id="data_epex00032" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="imex.sp_sel_epex00032"  > 
                <input bind="grdSO" >
			        <input bind="dtFrom" />
			        <input bind="dtTo" />
			        <input bind="txtPOPartner" />
			        <input bind="chkBal" />
                </input>
                <output bind="grdSO" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_epex00032_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid"  function="imex.sp_sel_epex00032_2"  > 
                  <input bind="grdDetail" > 
                    <input bind="txtArraySOPK" />					 																		
                  </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="pro_epex00032" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="imex.sp_pro_epex00032" > 
                <input>
                    <input bind="txtSOPK" /> 
                </input>                 
                <output>                 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 50%">
            <td style="width: 100%">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 5%">
                            Date</td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            PO/Partner</td>
                        <td style="width: 30%">
                            <gw:textbox id="txtPOPartner" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdSO')" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="center">
                            Bal Y/N
                            <gw:checkbox id="chkBal" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSO')"></gw:checkbox>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdSO')" />
                        </td>
                        <td style="width: 13%; text-align: center" colspan="2">
                            <gw:label id="lbRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="process" alt="Calculate Balance" id="btnProcess01" onclick="OnProcess('PackBalance')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="9">
                            <gw:grid id='grdSO' header='_PK|Ord Date|P/O No|_Partner_PK|Partner ID|Partner Name|Ord Qty|Inv Qty|Bal Qty|Description'
                                format='0|4|0|0|0|0|0|0|0|0' aligns='0|1|0|0|0|0|3|3|3|0' defaults='|||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0' widths='1000|1200|1500|0|2000|2500|1200|1200|1200|1000'
                                sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 100%">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 15%; white-space: nowrap" align="left">
                            <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                style="cursor: hand" onclick="OnToggleGrid()" />
                        </td>
                        <td style="width: 2%" align="left">
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                        </td>
                        <td style="width: 2%" align="left">
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                        </td>
                        <td style="width: 2%" align="left">
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                        </td>
                        <td style="width: 2%" align="left">
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                        </td>
                        <td style="width: 2%" align="left">
                        </td>
                        <td style="width: 12%; white-space: nowrap" align="center">
                            <gw:label id="lbPONo" styles='width:100%;font:8pt'></gw:label>
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnQuery" img="2" text="Query" onclick="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnSelect" img="2" text="Select" onclick="OnSelect('Partial')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="select" alt="Select ALL" id="btnSelect01" onclick="OnSelect('ALL')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td>
                <gw:grid id='grdDetail' header='P/O No|_SO_D_PK|Seq|_STITEM_PK|_ITEM_PK|Item Code|Item Name|_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|HS Code|UOM|Ord Qty|U/P|Amount'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='1|0|1|0|0|0|0|0|1|0|1|0|1|0|1|0|1|1|1|3|3|3'
                    check='|||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='1500|0|1000|0|0|1500|2500|0|1200|0|1200|1|1200|0|1200|0|1200|1200|1000|1200|1200|1200'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------->
<gw:textbox id="txtArraySOPK" styles='width:100%; display:none' />
<!--------------------------------------------------------------------------->
<gw:textbox id="txtSOPK" styles='width:100%;display:none' />
<gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
<!--------------------------------------------------------------------------->
</html>
