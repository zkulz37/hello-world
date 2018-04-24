<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("stm")%>
<head>
    <title>WI Entry 3</title>
</head>

<script language="javascript1.1">
//--grdSO
var G1_orderm_pk     = 0,  
    G1_style_id      = 1,   
    G1_style_desc    = 2,   
    G1_po_no         = 3,  
    G1_ord_qty       = 4,   
    G1_wi_qty        = 5;
      
 //
var G2_LINE_PK  = 0,
    G2_Line     = 1,  
    G2_D1       = 2,
    G2_D2       = 3,
    G2_D3       = 4,
    G2_D4       = 5,
    G2_D5       = 6,
    G2_D6       = 7,
    G2_D7       = 8,
    G2_D8       = 9,
    G2_D9       = 10,
    G2_D10      = 11,
    G2_D11      = 12,
    G2_D12      = 13,
    G2_D13      = 14,
    G2_D14      = 15,
    G2_D15      = 16;
    
//--grdWI  
var G3_PK               = 0,
    G3_TST_ORDERM_PK    = 1,
    G3_TST_LINE_PK      = 2,
    G3_LINE_NAME        = 3,
    G3_WORK_DATE        = 4,
    G3_FORMAT_DATE      = 5,
    G3_WI_QTY           = 6;
   //---------------------------------------------------------
 function BodyInit()
 { 
    System.Translate(document);  // Translate to language session
    BindingDataList();
    GridFormat(); 
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {   
    var data ;
                      
 }

//---------------------------------------------------------
function GridFormat()
{    
    var ctr = grdSO.GetGridControl(); 
    ctr.ColFormat(G1_ord_qty)  = "#,###,###,###,###,###";  
    ctr.ColFormat(G1_wi_qty)   = "#,###,###,###,###,###";  

    var ctr = grdSO.GetGridControl(); 
    ctr.ColFormat(G2_D1)   = "#,###,###,###,###,###";  
    ctr.ColFormat(G2_D2)   = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D3)   = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D4)   = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D5)   = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D6)   = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D7)   = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D8)   = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D9)   = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D10)  = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D11)  = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D12)  = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_D13)  = "#,###,###,###,###,###";
    ctr.ColFormat(G2_D14)  = "#,###,###,###,###,###";
    ctr.ColFormat(G2_D15)  = "#,###,###,###,###,###";
     
    txtSOM_PK.SetEnable(false)
    txtSONo.SetEnable(false)
    txtStyle.SetEnable(false)
    txtOrderQty.SetEnable(false)
    txtColor.SetEnable(false)
    txtCutWI.SetEnable(false)
    txtCutBala.SetEnable(false)
    txtSize.SetEnable(false)
    txtSewWI.SetEnable(false)
    txtSewBala.SetEnable(false)
 
   
}
//---------------------------------------------------------
function OnSearch(obj)
{   
    switch(obj)
    {
        case 'grdSO':
                ipwi0040.Call('SELECT');
        break;
        case 2:
                ipwi0040_1.Call('SELECT')
        break;
    }
}
//---------------------------------------------------------------------------------------
function OnSave()
{
    ipwi0040_1.Call();
}
//---------------------------------------------------------------------------------------
    function onOpenPopup(index)
    {
         var fpath = '';
         if (txtSOM_PK.text!="")
         {
            var fpath = System.RootURL + "/form/ip/wi/ipwi0032.aspx"; //customs
            aValue = System.OpenModal( fpath , 500 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {          
                var arrTemp
                for( var i=0; i < aValue.length; i++)	  
                {	
                    arrTemp = aValue[i];
                        
                    grdWI.AddRow();  
                    grdWI.SetGridText( grdWI.rows-1, G2_tst_orderd_pk,txtSOM_PK.text);
                    grdWI.SetGridText( grdWI.rows-1, G2_line,     arrTemp[0]);                        
                    grdWI.SetGridText( grdWI.rows-1, G2_target_qty,CalTargetQty(arrTemp[2],arrTemp[3],arrTemp[1]) );
                    grdWI.SetGridText( grdWI.rows-1, G2_daily_qty,   arrTemp[1]);
                    grdWI.SetGridText( grdWI.rows-1, G2_from,     arrTemp[2]);   
                    grdWI.SetGridText( grdWI.rows-1, G2_to,   arrTemp[3]);	    
                 }		        
            }	
         }else
         {
            alert("Please select order detail first !");
         }
	}
//---------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "ipwi0040":           
            //OnSearch(2)
        break;
     }
}
//---------------------------------------------------------------------------------------------------
function CalTargetQty(from,to,ability)
{
    var one_day=1000*60*60*24
    var arrTemp=new Array();
     if(Number(ability)>0)
     {
       
        if(from<=to)
        {
            var fr_dt = new Date()
                fr_dt.setFullYear(from.substring(0,4),from.substring(4,6),from.substring(6,8));
            var to_dt = new Date ()
                to_dt.setFullYear(to.substring(0,4),to.substring(4,6),to.substring(6,8));
            return ((Math.ceil(to_dt - fr_dt)/one_day)+1)*Number(ability);
        }else
            return 0;
        
     }else 
     return 0;
}
function OnDelete()
 {
    var ctrl = grdWI.GetGridControl();
	var row  = ctrl.row;
		if ( row > 0 ) 
		{			
		
			if ( grdWI.GetGridData( ctrl.row, 0 ) == "" ) 
		    {						
			
					grdWI.RemoveRow();					
			}			
			else 
			{
				if ( confirm( "Do you want to mark this row to delete?" ) ) 
				{
					grdWI.DeleteRow();
				}
			}
		}
	
 }
 //---------------------------------------------------------
 function OnUDelete()
 {							
	if ( confirm ( "Do you want to undelete?" ) ) 
	{				
		grdWI.UnDeleteRow()
	}	
}
//---------------------------------------------------------------------------------------------------
function OnGridClick()
{
   if(grdSO.GetGridControl().row >0)
    {
        txtSOM_PK.text  = grdSO.GetGridData(grdSO.row,G1_orderd_pk)
        txtSONo.text = grdSO.GetGridData(grdSO.row,G1_order_id )
        txtStyle.text  = grdSO.GetGridData(grdSO.row,G1_style_id )
        txtOrderQty.text = grdSO.GetGridData(grdSO.row,G1_ord_qty )
        txtColor.text = grdSO.GetGridData(grdSO.row,G1_color_name )
        txtCutWI.text = grdSO.GetGridData(grdSO.row,G1_cut_prod )
        var temp = Number(grdSO.GetGridData(grdSO.row,G1_cut_prod)) - Number(grdSO.GetGridData(grdSO.row,G1_cut_prod))
        txtCutBala.text = temp + ""
        txtSize.text = grdSO.GetGridData(grdSO.row,G1_s_size )
        txtSewWI.text = grdSO.GetGridData(grdSO.row,G1_sew_prod )
        temp = Number(grdSO.GetGridData(grdSO.row,G1_sew_qty ))- Number(grdSO.GetGridData(grdSO.row,G1_sew_prod ))
        txtSewBala.text = temp +""
        //OnSearch(2)
    }
}
//-------------------------------------------
function onAfterEditing()
{
    var col = event.col
    var row = event.row
    if(col== G2_daily_qty || col==G2_from || col==G2_to)
    {
        var from,to,daily
        from = grdWI.GetGridData(row,G2_from )
        to = grdWI.GetGridData(row,G2_to )
        daily = grdWI.GetGridData(row,G2_daily_qty )
        grdWI.SetGridText(row,G2_target_qty,CalTargetQty(from,to,daily))
    }
}
</script>

<body>
    <!------------------------------------------------------------------------------------->
    <gw:data id="ipwi0040" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"   function="stm.sp_sel_ipwi0040" > 
                <input bind="grdSO" >
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />  
                    <input bind="txtPONoSearch" />   
                </input>
                <output bind="grdSO" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------------------------->
    <gw:data id="ipwi0040_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"   function="stm.sp_sel_ipwi0040_1" parameter="0,1,2,3,4,5,6,7" procedure="STM.sp_upd_ipwi0040_1"> 
                <input bind="grdWI" >
                   <input bind="txtSOM_PK" />   
                </input>
                <output bind="grdWI" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 100%">
            <td style="width: 40%">
                <table style="height: 100%; width: 100%;">
                    <tr style="height: 5%">
                        <td style="width: 10%">
                            Order No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtPONoSearch" styles="width:100%" onenterkey="OnSearch('grdSO')" />
                        </td>
                        <td align="right" style="width: 10%">
                            <b>SO Date</b>
                        </td>
                        <td style="width: 12%" align="left">
                            <gw:datebox id="dtFromDate" lang="1" />
                        </td>
                        <td style="width: 15%" align="left">
                            ~<gw:datebox id="dtToDate" lang="1" />
                        </td>
                        <td style="width: 10%" align='right'>
                            <gw:imgbtn id="btnSearch1" img="search" onclick="OnSearch('grdSO')" />
                        </td>
                    </tr>
                    <tr style="height: 95%">
                        <td style="width: 100%" colspan="6">
                            <gw:grid id='grdSO' header='_TST_ORDERM_PK|Style ID|Style|PO Num|Ord Qty|WI Qty'
                                format='0|0|0|0|0|0' aligns='0|0|0|0|3|3' defaults='|||||' editcol='0|0|0|0|0|0'
                                widths='1000|1500|2000|1500|1500|1500' sorting='T' oncellclick='OnGridClick()'
                                styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 606%">
                <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 5%">
                        <td style="width: 10%" align="right">
                            Order No
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtSONo" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            Style Id
                        </td>
                        <td style="width: 15%" align="right">
                            <gw:textbox id="txtStyle" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            Ord Qty
                        </td>
                        <td style="width: 15%" align="right">
                            <gw:textbox id="txtOrderQty" styles="width:100%" type="number" format="###,###.###" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 10%" align="right">
                            Color
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtColor" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            Cut WI
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtCutWI" styles="width:100%" type="number" format="###,###.###" />
                        </td>
                        <td style="width: 10%" align="right">
                            Cut Bal.
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtCutBala" styles="width:100%" type="number" format="###,###.###" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%" align="right">
                            Size
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtSize" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            Sew WI
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtSewWI" styles="width:100%" type="number" format="###,###.###" />
                        </td>
                        <td style="width: 10%" align="right">
                            Sew Bal.
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtSewBala" styles="width:100%" type="number" format="###,###.###" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td colspan="6">
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 80%">
                                    </td>
                                    <td style="width: 5%">
                                        <gw:icon id="id" img="in" text="Set Line" styles='width:50%' onclick="onOpenPopup()" />
                                    </td>
                                    <td style="width: 5%">
                                        <gw:imgbtn id="btnDelete" img="delete" onclick='OnDelete()' />
                                    </td>
                                    <td style="width: 5%">
                                        <gw:imgbtn id="btnUDelete" img="Udelete" onclick='OnUDelete()' />
                                    </td>
                                    <td style="width: 5%">
                                        <gw:imgbtn id="btnSave" img="save" onclick='OnSave()' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 95%">
                        <td colspan="6">
                            <gw:grid id='grdDisplay' header='_LINE_PK|Line|D1|D2|D3|D4|D5|D6|D7|D8|D9|D10|D11|D12|D13|D14|D15'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3'
                                defaults='||||||||||||||||' editcol='0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' onafteredit='onAfterEditing()' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------------->
    <gw:datebox id="dtNow" lang="<%=Application("Lang")%>" style='display: none' />
    <gw:textbox id="txtSOM_PK" lang="<%=Application("Lang")%>" style='display: none' />
    <!---------------------------------------------------------------------------->
    <gw:grid id='grdWI' header='PK|TST_ORDERM_PK|TST_LINE_PK|LINE_NAME|WORK_DATE|FORMAT_DATE|WI_QTY'
        format='0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0' defaults='||||||' editcol='1|1|1|1|1|1|1'
        widths='1000|1000|1000|1000|1000|1000|1000' sorting='T' styles='width:100%; height:460' />
    <!---------------------------------------------------------------------------->
</body>
</html>
