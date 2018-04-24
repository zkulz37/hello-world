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
 
var G1_END_QTY    	= 5,
	G1_ECUST_QTY	= 6,
	G1_BAL_QTY		= 7;
    
var arr_FormatNumber = new Array();

//===================================================================================

function BodyInit()
{  
    System.Translate(document);  // Translate to language session 
     //-------------------------
     var data = "<%=ESysLib.SetListDataSQL("SELECT pk, wh_id || ' * ' || wh_name FROM tlg_in_warehouse  where del_if=0 order by wh_id")%>";
        data = data + '||';		
        lstWarehouse.SetDataText( data);
        lstWarehouse.value = '';
   
	BindingDataList();
	
 }
 
 //======================================================================================
 
 function BindingDataList()
 {  
       //-----------------------  
     
     var ctrl = grdDetail.GetGridControl(); 
	 
     ctrl.ColFormat(G1_END_QTY)   = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_ECUST_QTY) = "#,###,###,###,###,###.##";
	 ctrl.ColFormat(G1_BAL_QTY)   = "#,###,###,###,###,###.##";
	      
 }


//=====================================================================================
function OnSearch(pos)
{
    
                   
            data_ephl00080.Call("SELECT");
        
	
}

//===============================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
      
        case "data_ephl00080":            
            if ( grdDetail.rows > 1 )
            {
				/*grdDetail.SetCellBold( 1, G1_END_QTY,   grdDetail.rows - 1, G1_END_QTY,   true);
                
                grdDetail.SetCellBold( 1, G1_END_QTY, grdDetail.rows - 1, G1_END_QTY, true);*/	
                
                grdDetail.Subtotal( 0, 2, -1, '5!6!7');		
            }    
            //----------------------   
            lblRecord.text = grdDetail.rows-1 + " record(s)";             
        break;
        
        case 'pro_ephl00081_convert':
			alert(txtReturnValue.text);
		break;
   }            
}

//===================================================================================

function OnPopUp(pos)
{
    switch(pos)
    {
 
		case 'Report':			 
			 
		        var path = System.RootURL + '/form/ep/hl/ephl00081.aspx';
		        var object = System.OpenModal( path ,400, 300 ,  'resizable:yes;status:yes', this);	
 	        
		break;    		
    }	       
}


//===================================================================================

function OnReport(pos)
{
    switch (pos)
    {
        case 'ST01' :        
                                
                var url = System.RootURL + "/reports/ep/hl/rpt_ephl00080_ST01.aspx?p_date=" + dtDate.value + "&p_wh_pk=" + lstWarehouse.value;
				System.OpenTargetPage(url);
             
        break;
        
        case '2' :        
                          
                var url = System.RootURL + "/reports/ep/hl/rpt_ephl00080_1.aspx?p_date=" + dtDate.value + "&p_wh=" + lstWarehouse.value;
				System.OpenTargetPage(url);
            
        break; 

		 
    }    
}
  
//=====================================================================================
function OnProcess(pos)
{
     switch(pos)
     {
               		
		case 'CONVERT':
			 
				if ( confirm('Do you want to run convert data?') )
				{
					pro_ephl00081_convert.Call();
				}	
			 	
		break;
		 
     }
}

  

//===================================================================================
</script>
<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_ephl00080" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid"  function="<%=l_user%>lg_sel_ephl00080" > 
                <input bind="grdDetail">                    
                    <input bind="dtDate" /> 
					<input bind="lstWarehouse" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
	<!-------------------------------------------------------------------->
    <gw:data id="pro_ephl00081_convert" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_ephl00081" > 
                <input>
                    <input bind="dtDate" />
					<input bind="lstWarehouse" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 2%">
            <td align="right" style="width: 5%">
                Warehouse
            </td>
            <td style="width: 30%">
                <gw:list id="lstWarehouse" styles='width:100%' />
            </td>
            <td align="right" style="width: 5%; white-space: nowrap">
                Stock Date
            </td>
            <td style="width: 30%">
                <gw:datebox id="dtDate" lang="1" type='date' />
            </td>
            <td style="width: 27%; text-align: center">
                <gw:label id="lblRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
            </td>
			<td style="width: 1%" >
				<gw:icon id="btnProcess" img="2" text="Run Convert" alt="Run Convert" styles='width:100%'
                                            onclick="OnProcess('CONVERT')" />
			</td>
            <td style="width: 1%">
                <gw:imgbtn id="btnSearch2" img="search" alt="Search" text="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnPopUp('Report')" />
            </td>
			
        </tr>
        <tr style="height: 94%">
            <td colspan="8">
                <gw:grid id='grdDetail' header='Stock Date|_Warehouse|Item Code|Item Name|UOM|Stock Qty|Ecust Qty|Bal Qty'
                    format='4|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|1|3|3|3' 
					editcol='0|0|0|0|0|0|0|0' 
					widths='1200|2000|2000|4000|800|1500|1500|1500'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
<gw:textbox id="txtNumFormat" styles="display:none;" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles="width:100%; display:none" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
<gw:textbox id="txtWHStr" styles="width: 100%;display: none" />
</html>
