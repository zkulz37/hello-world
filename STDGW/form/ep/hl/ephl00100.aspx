<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>STOCK CLOSING</title>
</head>
<%  
	ESysLib.SetUser("SALE")
    Dim l_user As String
    l_user = "SALE."
%>

<script language="javascript" type="text/javascript">
//-----------------------------------------------------
 
var flag;

var G_PK    = 0 ;
//---------------------------------------------------------
var G1_DETAIL_PK    = 0, 
    G1_MASTER_PK    = 1,    
    G1_SEQ          = 2,
    G1_ITEM_PK      = 3,
    G1_ITEM_CODE    = 4,
    G1_ITEM_NAME    = 5,
    G1_UOM          = 6,   
    G1_LOT_NO       = 7,
    G1_PRICE        = 8,
    G1_BEGIN_QTY    = 9,
    G1_BEGIN_AMOUNT = 10,
    G1_IN_QTY       = 11,
    G1_IN_AMOUNT    = 12,
    G1_OUT_QTY      = 13,   
    G1_OUT_AMOUNT   = 14,
    G1_END_QTY      = 15,
    G1_END_AMOUNT   = 16,
    G1_REMARK       = 17;
    
    var arr_FormatNumber = new Array();

//===================================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

//===================================================================================

function BodyInit()
{  
    System.Translate(document);  // Translate to language session 
	
    txtUser_PK.text = "<%=Session("USER_PK")%>";
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
    //----------  
    txtChargerName.SetReadOnly(true);
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //----------------------------
    
    BindingDataList();    
     
    //----------------------------
 }
 
 //======================================================================================
 
 function BindingDataList()
 {  
     var data ;
        
     //-----------------------  
     
     var ctrl = grdDetail.GetGridControl(); 
    
     ctrl.ColFormat(G1_PRICE)        = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_BEGIN_QTY)    = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_BEGIN_AMOUNT) = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_IN_QTY)       = "#,###,###,###,###,###.##";        
     ctrl.ColFormat(G1_IN_AMOUNT)    = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_OUT_QTY)      = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_OUT_AMOUNT)   = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_END_QTY)      = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_END_AMOUNT)   = "#,###,###,###,###,###.##";
     
     
     arr_FormatNumber[G1_PRICE] 		= 2;
     arr_FormatNumber[G1_BEGIN_QTY] 	= 2;
     arr_FormatNumber[G1_BEGIN_AMOUNT] 	= 2;
     arr_FormatNumber[G1_IN_QTY] 		= 2;
     arr_FormatNumber[G1_IN_AMOUNT] 	= 2;  
     arr_FormatNumber[G1_OUT_QTY] 		= 2; 
     arr_FormatNumber[G1_OUT_AMOUNT] 	= 2;
     arr_FormatNumber[G1_END_QTY] 		= 2;
     arr_FormatNumber[G1_END_AMOUNT] 	= 2;                       
 }
  
//=====================================================================================
function OnProcess(pos)
{
     switch(pos)
     {
        
        case 'Submit':
            if ( txtMasterPK.text != '' )
            {
                pro_ephl00100_1.Call();
            }
            else
            {
                alert('Pls select data');
            }    
        break;
        
        case 'GET_SLIP':
            if ( txtMasterPK.text == '' )
			{
				pro_ephl00100.Call();
			}
			else
			{
				OnPopUp('SLIP');
			}
        break;
		
		case 'PROCESS':
			if ( txtMasterPK.text != '' )
			{
				if ( confirm('Do you want to process data?') )
				{
					pro_ephl00100_process.Call();
				}	
			}	
		break;
		
		case 'RELEASE':
			if ( txtMasterPK.text != '' )
			{
				if ( confirm('Do you want to release data?') )
				{
					pro_ephl00100_release.Call();
				}	
			}	
		break;	
     }
}

//=====================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdVouchers':
            data_ephl00100.Call("SELECT");
        break;
    
        case 'Master':
            if ( grdVouchers.row > 0 )
            {
                txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G_PK );
            }
            
            data_ephl00100_1.Call("SELECT");
        break;
        
        case 'grdDetail':            
            data_ephl00100_2.Call("SELECT");
        break;
		
		case 'Item':
			data_ephl00100_2.Call("SELECT");
		break;
    }
}

//===============================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_ephl00100_1": 
            OnSearch('grdDetail');                
        break;

        case "data_ephl00100_2":            
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBold( 1, G1_BEGIN_QTY, grdDetail.rows - 1, G1_BEGIN_QTY, true);	
                grdDetail.SetCellBold( 1, G1_IN_QTY,    grdDetail.rows - 1, G1_IN_QTY,    true);
                grdDetail.SetCellBold( 1, G1_OUT_QTY,   grdDetail.rows - 1, G1_OUT_QTY,   true);
                grdDetail.SetCellBold( 1, G1_END_QTY,   grdDetail.rows - 1, G1_END_QTY,   true);
                
                grdDetail.SetCellBold( 1, G1_ITEM_CODE, grdDetail.rows - 1, G1_ITEM_CODE, true);	
                
                grdDetail.Subtotal( 0, 2, -1, '9!10!11!12!13!14!15!16');		
            }    
            //----------------------                
        break;
        
        case 'pro_ephl00100':
			OnPopUp('SLIP');
		break;
		
		case 'pro_ephl00100_release':
			alert(txtReturnValue.text);
		break;
       
   }            
}
 
//=================================================================================

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col >= G1_PRICE && col <= G1_END_AMOUNT )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, System.Round( dQuantiy, arr_FormatNumber[col] ));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "0");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"0") ;
        }  
        //----------------------Calculate Amount -----
        if ( col == G1_OUT_AMOUNT  || col ==  G1_BEGIN_AMOUNT || col ==  G1_IN_AMOUNT )
        {
            var dEndAmount = Number(grdDetail.GetGridData( row, G1_BEGIN_AMOUNT)) + Number(grdDetail.GetGridData( row, G1_IN_AMOUNT)) - Number(grdDetail.GetGridData( row, G1_OUT_AMOUNT));
                        
            grdDetail.SetGridText( row, G1_END_AMOUNT, System.Round( dEndAmount, arr_FormatNumber[G1_END_AMOUNT]));
        } 
        else if ( col == G1_OUT_QTY || col ==  G1_BEGIN_QTY || col ==  G1_IN_QTY)
        {
            var dEndQty = Number(grdDetail.GetGridData( row, G1_BEGIN_QTY)) + Number(grdDetail.GetGridData( row, G1_IN_QTY)) - Number(grdDetail.GetGridData( row, G1_OUT_QTY));
            grdDetail.SetGridText( row, G1_END_QTY, System.Round( dEndQty, arr_FormatNumber[G1_END_QTY]));
        } 
        else if ( col == G1_END_QTY )
        {
            var dOutQty = Number(grdDetail.GetGridData( row, G1_BEGIN_QTY)) + Number(grdDetail.GetGridData( row, G1_IN_QTY)) - Number(grdDetail.GetGridData( row, G1_END_QTY));
                        
            grdDetail.SetGridText( row, G1_OUT_QTY, System.Round( dOutQty, arr_FormatNumber[G1_OUT_QTY]));
        }
        else if ( col == G1_END_AMOUNT )
        {
            var dOutAmount = Number(grdDetail.GetGridData( row, G1_BEGIN_AMOUNT)) + Number(grdDetail.GetGridData( row, G1_IN_AMOUNT)) - Number(grdDetail.GetGridData( row, G1_END_AMOUNT));
                        
            grdDetail.SetGridText( row, G1_OUT_AMOUNT, System.Round( dOutAmount, arr_FormatNumber[G1_OUT_AMOUNT]));
        }
		
        if(col ==  G1_BEGIN_QTY || col ==  G1_IN_QTY || col ==  G1_BEGIN_AMOUNT || col ==  G1_IN_AMOUNT)
        {
		     
			if ( Number(grdDetail.GetGridData( row, G1_BEGIN_QTY)) + Number(grdDetail.GetGridData( row, G1_IN_QTY)) > 0 )
			{
           		var dPrice = (Number(grdDetail.GetGridData( row, G1_BEGIN_AMOUNT)) + Number(grdDetail.GetGridData( row, G1_IN_AMOUNT)))/(Number(grdDetail.GetGridData( row, G1_BEGIN_QTY)) + Number(grdDetail.GetGridData( row, G1_IN_QTY)))
           		grdDetail.SetGridText( row, G1_END_AMOUNT, Number(grdDetail.GetGridData( row, G1_END_QTY))* dPrice);
           		grdDetail.SetGridText( row, G1_OUT_AMOUNT, Number(grdDetail.GetGridData( row, G1_OUT_QTY))* dPrice);
           		grdDetail.SetGridText( row, G1_PRICE, System.Round( dPrice, arr_FormatNumber[G1_PRICE]));
			}	
        }
        
    }      
}
//===================================================================================
function OnCalculate()
{
	for ( var i=1;i<grdDetail.rows;i++)
	{
            var dEndAmount = Number(grdDetail.GetGridData( i, G1_BEGIN_AMOUNT)) + Number(grdDetail.GetGridData( i, G1_IN_AMOUNT)) - Number(grdDetail.GetGridData( i, G1_OUT_AMOUNT));
                        
            grdDetail.SetGridText( i, G1_END_AMOUNT, System.Round( dEndAmount, arr_FormatNumber[G1_END_AMOUNT]));  
	}
}
 
//===================================================================================

function OnReport(pos)
{
    switch(pos)
    {
        case 'ST01':alert();
            var url =System.RootURL + '/reports/ep/hl/rpt_ephl00100_ST01.aspx?master_pk=' + txtMasterPK.text ;
			var url =System.RootURL + '/reports/ep/hl/rpt_ephl00100_ST01.xls' ;
	        System.OpenTargetPage(url);  
			 	
				
        break;
		
        case 'ST02':
            var url =System.RootURL + '/reports/ep/hl/rpt_ephl00100_ST02.aspx?master_pk=' + txtMasterPK.text ;
			var url =System.RootURL + '/reports/ep/hl/rpt_ephl00100_ST02.xls' ;
	        window.open(url, "_blank"); 
        break;
		
        case 'ST03':
            var url =System.RootURL + '/reports/ep/hl/rpt_ephl00100_ST03.aspx?master_pk=' + txtMasterPK.text ;
			var url =System.RootURL + '/reports/ep/hl/rpt_ephl00100_ST03.xls' ;
	        window.open(url, "_blank"); 
        break;

		case 'ST04':
            var url =System.RootURL + '/reports/ep/hl/rpt_ephl00100_ST04.aspx?master_pk=' + txtMasterPK.text ;
			var url =System.RootURL + '/reports/ep/hl/rpt_ephl00100_ST04.xls' ;
	        window.open(url, "_blank"); 
        break;	
    }
}
 
//===================================================================================

function OnPopUp(pos)
{ 
	switch(pos)
	{
		case 'SLIP':
			var path = System.RootURL + '/form/ep/hl/ephl00101.aspx?master_pk=' + txtMasterPK.text ;
            var object = System.OpenModal( path ,900 ,600 ,'resizable:yes;status:yes' );
		break;
		
		case 'Report':			 
			 if( txtMasterPK.text != "" )
	        {
		        var path = System.RootURL + '/form/ep/hl/ephl00103.aspx';
		        var object = System.OpenModal( path ,400, 300 ,  'resizable:yes;status:yes',this);	
 	        }
	        else
	        {
		        alert("Please, select one slip no to print!");
	        }	
		break; 
	}
}
 
//===================================================================================
</script>

<body>
     
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_ephl00100" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1" function="<%=l_user%>lg_sel_ephl00100" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                </input> 
                <output bind="grdVouchers" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_ephl00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5" function="<%=l_user%>lg_sel_ephl00100_1"  > 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtLiquidNo" />   
                     <inout  bind="txtLiquidDate" />                                            
                     <inout  bind="txtChargerPK" />
                     <inout  bind="txtChargerName" />
                     <inout  bind="lbStatus" />                                       
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_ephl00100_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="<%=l_user%>lg_sel_ephl00100_3" procedure="<%=l_user%>lg_upd_ephl00100_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
					<input bind="txtItem" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_ephl00100" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_ephl00100" > 
                <input>                      
                     <input bind="txtLiquidDate" />
					 <input bind="txtChargerPK" />												 
                </input> 
                <output> 
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_ephl00100_process" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_ephl00100_process" > 
                <input>
                     <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
	<!-------------------------------------------------------------------->
    <gw:data id="pro_ephl00100_release" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_ephl00100_release" > 
                <input>
                     <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_ephl00100_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_ephl00100_2" > 
                <input>
                     <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>  
    <!-------------------------------------------------------------------->
    <gw:data id="pro_ephl00100_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_ephl00100_3" > 
                <input>
                     <input bind="txtLiquidDate" />
                     <input bind="txtChargerPK" />	
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data> 
	<!-------------------------------------------------------------------->
    <gw:data id="pro_ephl00100_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_ephl00100_4" > 
                <input>
                     <input bind="txtMasterPK" />              
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data> 
	<!--------------------------------------------------------------------> 
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="width: 94%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdVouchers')" />
                        </td>
                    </tr>                     
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdVouchers" header="_PK|Date|Status|Liquid No" format="0|4|0|0" aligns="0|1|0|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|1200|1000|1000" styles="width:100%; height:100%"
                                sorting="T" param="0,1,2,3" oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="background-color: #B4E7FF" colspan="11">
                            <table style="width: 100%; height: 100%" border="0">
                                <tr>
                                    <td style="width: 1%">
                                        <gw:icon id="btnRelease" img="2" text="Release" alt="Release Closing Data" styles='width:100%'
                                            onclick="OnProcess('Release')" />
                                    </td>
                                    <td style="width: 1%">                                         
										<gw:icon id="btnGetSlip" img="2" text="Get Slip" alt="Get Slip" styles='width:100%'
                                            onclick="OnProcess('GET_SLIP')" />
                                    </td>
									<td style="width: 1%">                                         
										<gw:icon id="btnProcess" img="2" text="Process" alt="Get Slip" styles='width:100%'
                                            onclick="OnProcess('PROCESS')" />
                                    </td>
                                    <td style="width: 96%" align="center">	
										<gw:label id="lbStatus" styles='width:100%;color:cc0000;font:9pt;align:center' text='-' />									
                                    </td>
                                    <td style="width: 1%">
                                        
                                    </td>
                                     
									<td style="width: 1%">
										<gw:imgbtn id="ibtnReport" styles="" img="excel" alt="Report" text="Report" onclick="OnPopUp('Report')" />
									</td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%">						 
                        <td align="right" style="width: 5%">
                            Liquid No
                        </td>
                        <td style="width: 30%">
							<gw:textbox id="txtLiquidNo" styles='width:100%' csstype="mandatory"  />                         
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Liquid Date
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="txtLiquidDate" lang="1" />
                        </td>                       
                        <td align="right" style="width: 5%">
                            Charger
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtChargerName" styles="width:100%" />
                            <gw:textbox id="txtChargerPK" styles="display:none" />
                        </td>
                    </tr>                    
                    <tr style="height: 2%"> 
						<td colspan=7>
							<table style="width: 100%; height: 100%" border="0">
                                <tr>
									<td style="width: 5%" align="left">
			                            <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
			                                style="cursor: hand" onclick="OnToggle()" />
			                        </td>
			                        <td align="right" style="width: 5%; white-space: nowrap">
			                            Item/Lot No
			                        </td>
			                        <td align="right" style="width: 40%" >
			                            <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch('Item')" />
			                        </td>
			                        <td  style="width: 1%" >
			                            <gw:imgbtn id="btnSearch2" img="search" alt="Search" text="Search" onclick="OnSearch('Item')" />
			                        </td>
			                        <td style="width: 1%" >
			                            <gw:imgbtn id="btnProcess" img="process" alt="Process" text="Process" onclick="OnPopUp()" />
			                        </td>										
									<td style="width: 46%">			                            
			                        </td>																			
									<td style="width: 1%">
			                            
			                        </td>																		 
			                        <td align="right" style="width: 1%">
										 
			                        </td>										
								</tr>
							</table>	
						</td>                       																
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="7">                            
								
							<gw:grid id='grdDetail'
								header='Im Item Name|So TK|IM Qty|IM Beg Qty|_Ex Item Name|So TK|_Ex Qty|_ST Cons Qty|Lid Qty|Im End Qty'
								format='0|0|0|0|0|0|0|0|0|0'
								aligns='0|0|0|0|0|0|0|0|0|0'
								check='|||||||||'
								editcol='0|0|0|0|0|0|0|0|0|0'
								widths='2000|1500|1500|1500|2000|1500|1500|1500|1500|1500'
								sorting='T'							 
								styles='width:100%; height:100%'
								/>															 
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
<gw:textbox id="txtNumFormat" styles="display:none;" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles="width:100%; display:none" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
<gw:textbox id="txtWHStr" styles="width: 100%;display: none" />
<!---------------------------------------------------------------------------------->
</html>
