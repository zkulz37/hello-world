<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser("SALE")
    Dim l_user As String
    l_user = "SALE."
%>
<head id="Head1" runat="server">
    <title>Ex-Invoice : Goods Delivery Request</title>
</head>

<script>

var v_language  = "<%=Session("SESSION_LANG")%>";
var emp_pk      = "<%=Session("EMPLOYEE_PK") %>";
var full_name   = "<%=Session("USER_NAME") %>";
	
var G1_CHK			= 0,
	G1_REQ_M_PK     = 1,
    G1_REQ_DATE     = 2,
    G1_PO_NO        = 3,    
	G1_REQ_QTY		= 4,
    G1_ITEM_AMT     = 5,
    G1_TAX_AMT      = 6,
    G1_TOTAL_AMT    = 7,
	G1_INV_NO       = 8,
	G1_DELI_PK   	= 9, 
    G1_DELI_ID   	= 10,
    G1_DELI_NM   	= 11,
	G1_BILL_PK   	= 12, 
    G1_BILL_ID   	= 13,
    G1_BILL_NM   	= 14,
    G1_REMARK  		= 15;	
       
var G2_REQ_D_PK     = 0,
    G1_REQ_M_PK   	= 1,
    G2_SEQ       	= 2, 
    G2_REF_NO		= 3,
    G2_REQ_ITEM_PK  = 4,
    G2_ITEM_CODE 	= 5,
    G2_ITEM_NAME 	= 6,
	G2_PARTNER_NAME = 7,
	G2_VIRTUAL_CODE = 8,
    G2_REQ_UOM 		= 9,
    G2_LOT_NO 		= 10,
    G2_REQ_QTY 		= 11,
    G2_UNIT_PRICE 	= 12,
    G2_ITEM_AMT 	= 13,
    G2_TAX_AMT 		= 14,
    G2_TOTAL_AMT 	= 15,
	G2_REMARK		= 16,
	G2_SO_D_PK		= 17;  
      
var bill_pk   = '';
var bill_name = '';
var deli_pk   = '';
var deli_name = '';
			
//=======================================================================
   
function BodyInit()
{
    //-------------------------------
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-30));
    //-------------------------------
    FormatGrid();     
    //-------------------------------
    OnSearch('grdMaster');
    //-------------------------------   
}
//=======================================================================
function FormatGrid()
{
    var ctrl = grdMaster.GetGridControl();  
          
	ctrl.ColFormat(G1_REQ_QTY) 	 = "###,###,###,###.##";		
    ctrl.ColFormat(G1_ITEM_AMT)  = "###,###,###,###.##";
    ctrl.ColFormat(G1_TAX_AMT)   = "###,###,###,###.##";
    ctrl.ColFormat(G1_TOTAL_AMT) = "###,###,###,###.##";  
    
    ctrl = grdDetail.GetGridControl(); 
	
    ctrl.ColFormat(G2_REQ_QTY) 	  = "###,###,###,###";
    ctrl.ColFormat(G2_UNIT_PRICE) = "###,###,###,###.#####";
	ctrl.ColFormat(G2_ITEM_AMT)   = "###,###,###,###.##";
    ctrl.ColFormat(G2_TAX_AMT) 	  = "###,###,###,###.##";
	ctrl.ColFormat(G2_TOTAL_AMT)  = "###,###,###,###.##";
}

//=======================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_epex00036':                         
            if ( grdMaster.rows > 1 )
            {			
				grdMaster.SetCellBold( 1, G1_REQ_QTY, grdMaster.rows - 1, G1_REQ_QTY, true);
				
				grdMaster.SetCellBgColor( 1, G1_TOTAL_AMT, grdMaster.rows - 1, G1_TOTAL_AMT, 0xCCFFFF );
                grdMaster.SetCellBgColor( 1, G1_INV_NO ,   grdMaster.rows - 1, G1_INV_NO,    0xFFFFCC ); 
                
                grdMaster.Subtotal( 0, 2, -1, '7!8!9!10','###,###,###.##');   
            }            
        break;        
        
        case 'data_epex00036_2':
			 
            if ( grdDetail.rows > 1 )
            {
				grdDetail.SetCellBold( 1, G2_REF_NO,  grdDetail.rows - 1, G2_REF_NO,  true);				
                grdDetail.SetCellBold( 1, G2_REQ_QTY, grdDetail.rows - 1, G2_REQ_QTY, true);             
                
                grdDetail.SetCellBgColor( 1, G2_ITEM_AMT, grdDetail.rows - 1, G2_TOTAL_AMT, 0xCCFFFF );
                
                grdDetail.Subtotal( 0, 2, -1, '10!11!12!13!14','###,###,###.##');                
            }    
        break; 
        
        case 'pro_epex00036':
            alert(txtReturnValue.text);
            
            OnSearch('grdMaster');
        break;       
    }
}
 
//=======================================================================

function OnSearch(obj)
{
    switch(obj)
    {
        case 'grdMaster':
            data_epex00036.Call("SELECT");
        break;
    
        case 'grdDetail':

            var t = 0 ;
            
            var array_po       = '';
            var array_so_pk    = '';
			
			bill_pk        = '';
			bill_name      = '';
			deli_pk        = '';
			deli_name      = '';			
			
			var t_comma        = '';
                            
            for(var i = 1; i < grdMaster.rows-1 && t < 15; i++)
            {
                if ( grdMaster.GetGridData( i, G1_CHK ) == '-1' )
                {   
                    t = t + 1 ;    
									
                    array_po    = array_po    + t_comma + grdMaster.GetGridData( i, G1_PO_NO    );
                    array_so_pk = array_so_pk + t_comma + grdMaster.GetGridData( i, G1_REQ_M_PK );  
					
					bill_pk   = grdMaster.GetGridData( i, G1_BILL_PK );
					bill_name = grdMaster.GetGridData( i, G1_BILL_NM );
					
					deli_pk   = grdMaster.GetGridData( i, G1_DELI_PK );
					deli_name = grdMaster.GetGridData( i, G1_DELI_NM );
					
					t_comma = ',';							
                }								
            }
                                   
            array_po    = array_po    ;
            array_so_pk = array_so_pk ;
             
            if ( array_so_pk == '' )
            {
                alert('You must select one Req.');
            }
            else
            {
				
			 
                txtArraySOPK.text    = array_so_pk ;						
                lbPONo.text          = array_po ;
                                    
                data_epex00036_2.Call("SELECT");
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

				callerWindowObj.txtCustPK.text   = bill_pk   ;          	
				callerWindowObj.txtCustName.text = bill_name ;
				
				callerWindowObj.txtShipToPK.text   = deli_pk   ;          	
				callerWindowObj.txtShipToName.text = deli_name ;
				
				callerWindowObj.txtPaidToPK.text   = bill_pk   ;          	
				callerWindowObj.txtPaidToName.text = bill_name ;
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

				callerWindowObj.txtCustPK.text   = bill_pk   ;          	
				callerWindowObj.txtCustName.text = bill_name ;
				
				callerWindowObj.txtShipToPK.text   = deli_pk   ;          	
				callerWindowObj.txtShipToName.text = deli_name ; 
				
				callerWindowObj.txtPaidToPK.text   = bill_pk   ;          	
				callerWindowObj.txtPaidToName.text = bill_name ;
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
        case '' :
            
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
    <gw:data id="data_epex00036" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="<%=l_user%>lg_sel_epex00036"  > 
                <input bind="grdMaster" >
			        <input bind="dtFrom" />
			        <input bind="dtTo" />
			        <input bind="txtPONo" />
			        <input bind="txtPartner" />
                </input>
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_epex00036_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid"  function="<%=l_user%>lg_sel_epex00036_2"  > 
                  <input bind="grdDetail" > 
                    <input bind="txtArraySOPK" />					 																		
                  </input> 
                <output bind="grdDetail" /> 
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
                        <td style="width: 5%; white-space: nowrap" align="right">
                            No</td>
                        <td style="width: 30%">
                            <gw:textbox id="txtPONo" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdMaster')" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Partner</td>
                        <td style="width: 30%">
                            <gw:textbox id="txtPartner" maxlen="100" styles='width:100%' onenterkey="OnSearch('grdMaster')" />
                        </td>
                        <td style="width: 5%" align="right" >
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdMaster')" />
                        </td>                                                
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="9">
                             
								
								<gw:grid id='grdMaster' 
								header='-|_REQ_PK|Req Date|P/O No|Req Qty|Item Amount|Tax Amount|Total Amount|Inv No|_Deli_PK|_Deli ID|Deli Name|_Bill_To_PK|_Bill ID|Bill Name|Remark'
                                format='3|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|0|1|0|0|3|3|3|3|1|0|0|0|0|0|0'  
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								widths='500|0|1200|1500|1500|1500|1500|1500|1500|0|0|2500|0|0|2500|1000'
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
                <gw:grid id='grdDetail' 
					header='_REQ_D_PK|_REQ_M_PK|Seq|Ref No|_ITEM_PK|Item Code|Item Name|Customer Item|Virtual Code|UOM|Lot No|Req Qty|U/P|Item Amount|Tax Amount|Total Amount|Remark|_SO_D_PK'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|1|0|0|0|0|1|1|1|3|3|3|3|3|3|0|0'             
					editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|0|800|1200|0|1200|2500|2500|1500|800|1200|1500|1500|1500|1500|1500|1000|0'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------->
<gw:textbox id="txtArraySOPK" styles='width:100%;display:none' /> 
<gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
<!--------------------------------------------------------------------------->
</html>
