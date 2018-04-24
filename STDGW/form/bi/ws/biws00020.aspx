<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>W/H LOCATION ADJUST</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script language="javascript" type="text/javascript">
//-----------------------------------------------------
 
var flag;

var G_PK    = 0 ;
//---------------------------------------------------------
var G1_DETAIL_PK    = 0, 
    G1_MASTER_PK    = 1,    
    G1_SEQ          = 2,
	G1_WH_LOC_PK	= 3,
	G1_LOC_ID		= 4,
    G1_ITEM_PK      = 5,
    G1_ITEM_CODE    = 6,
    G1_ITEM_NAME    = 7,
    G1_UOM          = 8,   
    G1_LOT_NO       = 9,     
    G1_BEGIN_QTY    = 10,    
    G1_IN_QTY       = 11,    
    G1_OUT_QTY      = 12,   
    G1_ADJ_QTY   	= 13,
    G1_END_QTY      = 14,    
    G1_REMARK       = 15;
    
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
     
    data = "<%=ESysLib.SetListDataSQL("select pk, strg_id || ' * ' || strg_name from tlg_in_storage where del_if = 0 and use_yn = 'Y' order by strg_id " )%>";    
    lstStorage.SetDataText(data);
     
    lstStoSearch.SetDataText(data);         
     //-----------------------  
     
    var ctrl = grdDetail.GetGridControl();     
      
    ctrl.ColFormat(G1_BEGIN_QTY) = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G1_IN_QTY)    = "#,###,###,###,###,###.##";        
    ctrl.ColFormat(G1_OUT_QTY)   = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G1_ADJ_QTY)   = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G1_END_QTY)   = "#,###,###,###,###,###.##";           
           
    arr_FormatNumber[G1_BEGIN_QTY]	= 2; 
    arr_FormatNumber[G1_IN_QTY] 	= 2;      
    arr_FormatNumber[G1_OUT_QTY] 	= 2; 
	arr_FormatNumber[G1_ADJ_QTY] 	= 2;
    arr_FormatNumber[G1_END_QTY] 	= 2;                           
 }
  
//=====================================================================================
function OnProcess(pos)
{
     switch(pos)
     {
        case 'LoadData' :
            if ( confirm('Do you want to close data.') )
            {
                txtChargerPK.text = "<%=Session("EMPLOYEE_PK")%>" ;
                pro_biws00020_1.Call();
            }    
        break;    
        
        case 'Release' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to release data.') )
                {
                    pro_biws00020_2.Call();
                }
            }
            else
            {
                alert('Pls select data');
            }                     
        break;   
        
        case 'Submit':
            if ( txtMasterPK.text != '' )
            {
                pro_biws00020_3.Call();
            }
            else
            {
                alert('Pls select data');
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
            data_biws00020_1.Call("SELECT");
        break;
    
        case 'Master':
            if ( grdVouchers.row > 0 )
            {
                txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G_PK );
            }
            
            data_biws00020_2.Call("SELECT");
        break;
        
        case 'grdDetail':            
            data_biws00020_3.Call("SELECT");
        break;				
    }
}

//===============================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_biws00020_2": 
            OnSearch('grdDetail');                
        break;

        case "data_biws00020_3":            
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBold( 1, G1_BEGIN_QTY, grdDetail.rows - 1, G1_BEGIN_QTY, true);	
                grdDetail.SetCellBold( 1, G1_IN_QTY,    grdDetail.rows - 1, G1_IN_QTY,    true);
                grdDetail.SetCellBold( 1, G1_OUT_QTY,   grdDetail.rows - 1, G1_OUT_QTY,   true);
                grdDetail.SetCellBold( 1, G1_END_QTY,   grdDetail.rows - 1, G1_END_QTY,   true);
                
                grdDetail.SetCellBold( 1, G1_ITEM_CODE, grdDetail.rows - 1, G1_ITEM_CODE, true);	
                
                grdDetail.Subtotal( 0, 2, -1, '10!11!12!13!14');		
            }    
            //----------------------                
        break;
        
        case 'pro_biws00020_1':
			OnSearch('grdDetail');
		break;

        case 'pro_biws00020_2':
            alert(txtReturnValue.text);            
			OnSearch('Master');
		break;	
		
        case 'pro_biws00020_3':
            alert(txtReturnValue.text);            
			OnSearch('Master');
		break;			 
   }            
}

//===================================================================================
function OnSave()
{
    if ( txtMasterPK.text != '' )
    {
		for ( var i=1;i<grdDetail.rows;i++)
		{
			if ( grdDetail.GetGridData( i, G1_MASTER_PK) == '' )
			{
				grdDetail.SetGridText( i, G1_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
			}	
		}
		
        data_biws00020_3.Call();        
    }
    else
    {
        alert('Pls select data first.');
    }
} 

//=================================================================================

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col >= G1_BEGIN_QTY && col <= G1_END_QTY )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {               
            grdDetail.SetGridText( row, col, System.Round( dQuantiy, arr_FormatNumber[col] ));            
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        }  
        //------------------- 
		dQuantiy = ( Number(grdDetail.GetGridData( row, G1_BEGIN_QTY)) + Number(grdDetail.GetGridData( row, G1_IN_QTY)) - Number(grdDetail.GetGridData( row, G1_OUT_QTY)) - Number(grdDetail.GetGridData( row, G1_ADJ_QTY)) );
           		
		grdDetail.SetGridText( row, G1_END_QTY, System.Round( dQuantiy, arr_FormatNumber[G1_END_QTY] ));
		//-------------------
    }      
}
//===================================================================================

function OnCalculate()
{
	for ( var i=1;i<grdDetail.rows;i++)
	{
        var dQuantiy = ( Number(grdDetail.GetGridData( i, G1_BEGIN_QTY)) + Number(grdDetail.GetGridData( i, G1_IN_QTY)) - Number(grdDetail.GetGridData( i, G1_OUT_QTY)) - Number(grdDetail.GetGridData( i, G1_ADJ_QTY)) );
                        
        grdDetail.SetGridText( i, G1_END_QTY, System.Round( dQuantiy, arr_FormatNumber[G1_END_QTY]));  
	}
} 

//===================================================================================
function OnDelete()
{
    grdDetail.DeleteRow();
}
//===================================================================================
function OnReport()
{ 
    if(txtMasterPK.text != '')
    {
        var path = System.RootURL + "/reports/bi/sa/rpt_biws00020.aspx?master_pk="+txtMasterPK.text;
        System.OpenTargetPage(path);
    }
    else
    {
        alert("Pls select one Slip.")
    } 
    
} 
//===================================================================================
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'FreeItem':
			if ( txtMasterPK.text != '' )
			{			
             	var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';
             	var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
				
             	if ( object != null )
            	{
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1); 	
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_PK,   arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME, arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM,       arrTemp[5]);//item_uom                            
                    }		            
            	}  
			}	      
        break;
			
		case 'DETAIL':
		
			grdDetail.AddRow();        
			
            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1); 	                           
            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	
			
		break;	
 	}		
}	
//===================================================================================
</script>

<body>     
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_biws00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1" function="<%=l_user%>lg_sel_biws00020_1" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="lstStoSearch" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />
                </input> 
                <output bind="grdVouchers" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_biws00020_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5" function="<%=l_user%>lg_sel_biws00020_2"  > 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="lstStorage" />   
                     <inout  bind="dtStockDate" />                                            
                     <inout  bind="txtChargerPK" />
                     <inout  bind="txtChargerName" />
                     <inout  bind="lbStatus" />                                       
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_biws00020_3" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="<%=l_user%>lg_sel_biws00020_3" procedure="<%=l_user%>lg_upd_biws00020_3"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
					<input bind="txtLocation" />
					<input bind="txtItem" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_biws00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_biws00020_1" > 
                <input>
                     <input bind="lstStorage" />
                     <input bind="dtStockDate" />
					 <input bind="txtChargerPK" />												 
                </input> 
                <output> 
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_biws00020_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_biws00020_2" > 
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
    <gw:data id="pro_biws00020_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_biws00020_3" > 
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
                    <tr style="height: 1%">
                        <td style="width: 5%">
                            Storage
                        </td>
                        <td colspan="1">
                            <gw:list id="lstStoSearch" styles="width:100%;" />
                        </td>
						<td>
							<gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdVouchers')">User
							</gw:checkbox>
						</td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdVouchers" header="_PK|Date|Status|W/H" format="0|4|0|0" aligns="0|1|0|0"
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
                                        <gw:icon id="btnLoadData" img="2" text="Load Ending Stock" alt="Load Closing Data"
                                            styles='width:100%' onclick="OnProcess('LoadData')" />
                                    </td>
                                    <td style="width: 96%" align="center">	
										<gw:label id="lbStatus" styles='width:100%;color:cc0000;font:9pt;align:center' text='-' />									
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="btnPrice" img="2" text="P/O Price" alt="Get P/O Price" styles='width:100%'
                                            onclick="OnProcess('PO-PRICE')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="btnSubmit" img="2" text="Submit" alt="Submit" styles='width:100%' onclick="OnProcess('Submit')" />
                                    </td>
									<td>
										<gw:imgbtn id="ibtnReport" styles="display:none;" img="excel" alt="Report" text="Report" onclick="OnReport()" />
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
                            Storage
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstStorage" styles='width:100%' csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Stock Date
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtStockDate" lang="1" />
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
			                            Location
			                        </td>
			                        <td align="right" style="width: 30%" >
			                            <gw:textbox id="txtLocation" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
			                        </td>
									
			                        <td align="right" style="width: 5%; white-space: nowrap">
			                            Item/Lot No
			                        </td>
			                        <td align="right" style="width: 30%" >
			                            <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
			                        </td>
			                        <td  style="width: 1%" >
			                            <gw:imgbtn id="btnSearch2" img="search" alt="Search" text="Search" onclick="OnSearch('grdDetail')" />
			                        </td>
			                        <td style="width: 1%" >
			                            <gw:imgbtn id="btnProcess" img="process" alt="Process" text="Process" onclick="OnCalculate()" />
			                        </td>										
									<td style="width: 20%">
			                           
			                        </td>																		
									<td style="width: 1%">
			                           <gw:icon id="idBtnFreeItem" img="2" text="Free Item" styles='width:100%' onclick="OnAddNew('FreeItem')" />
			                        </td>
									<td style="width: 1%">
			                           <gw:imgbtn id="btnNewD" img="new" alt="New" text="New" onclick="OnAddNew('DETAIL')" />
			                        </td>		
			                        <td align="right" style="width: 1%">
										<gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
			                        </td>										
								</tr>
							</table>	
						</td>                       																
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="7">
                            <gw:grid id='grdDetail' 
								header='_PK|_M_PK|Seq|_WHLOC_PK|Loc ID|_ITEM_PK|Item Code|Item Name|UOM|Lot No|Begin Qty|In Qty|Out Qty|Adj Qty|End Qty|Remark'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|0|1|0|1|0|0|0|1|1|3|3|3|3|3|0'
                                editcol='0|0|1|0|1|0|1|0|0|1|1|1|1|1|1|1' 
								widths='0|0|800|0|1200|0|1500|2500|800|1200|1500|1500|1500|1500|1500|1000'
                                sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" /> 
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles="width:100%; display:none" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" /> 
</html>
