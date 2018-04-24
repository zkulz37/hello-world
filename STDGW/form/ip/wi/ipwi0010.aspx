<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("stm")%>
<head>
    <title>WI Entry 4</title>
</head>

<script language="javascript1.1">
//--grdSO
var G1_orderm_pk     = 0,  
    G1_style_id      = 1,   
    G1_style_desc    = 2,   
    G1_po_no         = 3,  
    G1_ord_qty       = 4,   
    G1_wi_qty        = 5,
    G1_Bal_qty       = 6;      
    
//--grdWI  
var G2_PK               = 0,
    G2_TST_ORDERM_PK    = 1,
    G2_Line             = 2,
    G2_WORK_DATE        = 3,
    G2_WI_Qty           = 4,
    G2_OT_Qty           = 5,
    G2_OT_Start         = 6,
    G2_OT_End           = 7,
    G2_OT_Time          = 8,
    G2_Description      = 9;
        
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
    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   pk, line_name FROM stm.tst_line WHERE del_if = 0 ORDER BY line_name " ) %> ";       
    grdWI.SetComboFormat(G2_Line,data);   
 }

//---------------------------------------------------------
function GridFormat()
{    
    var ctr = grdSO.GetGridControl(); 
    ctr.ColFormat(G1_ord_qty)  = "#,###,###,###,###,###";  
    ctr.ColFormat(G1_wi_qty)   = "#,###,###,###,###,###";  

    var ctr = grdWI.GetGridControl(); 
    ctr.ColFormat(G2_WI_Qty)   = "#,###,###,###,###,###";  
    ctr.ColFormat(G2_OT_Qty)   = "#,###,###,###,###,###"; 
    ctr.ColFormat(G2_OT_Time)  = "#,###,###,###,###,###"; 

    ctr.ColFormat(G2_OT_Start)    = "00:00"; 
    ctr.ColFormat(G2_OT_End)      = "00:00";     
    ctr.ColEditMask(G2_OT_Start)  = "99:99";
    ctr.ColEditMask(G2_OT_End)    = "99:99";    
     
    txtSOM_PK.SetEnable(false)
    txtPONo.SetEnable(false)
    txtStyleID.SetEnable(false)
    txtStyle.SetEnable(false)
    txtOrderQty.SetEnable(false)    
    txtWIQty.SetEnable(false)
    txtWIBalance.SetEnable(false)
   
}
//---------------------------------------------------------
function OnSearch(obj)
{   
    switch(obj)
    {
        case 'grdSO':
                ipwi0050.Call('SELECT');
        break;
        case 'grdWI':
                ipwi0050_1.Call('SELECT')
        break;
    }
}
//---------------------------------------------------------------------------------------
function OnSave()
{
    ipwi0050_1.Call();
}
//---------------------------------------------------------------------------------------
    function onOpenPopup(index)
    {
         var fpath = '';
         if (txtSOM_PK.text!="")
         {
            var fpath = System.RootURL + "/form/ip/wi/ipwi0051.aspx?WI_BAL_QTY=" + txtWIBalance.text; //customs
            aValue = System.OpenModal( fpath , 500 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {          
                var arrTemp
                for( var i=0; i < aValue.length; i++)	  
                {	
                    arrTemp = aValue[i];
                        
                    grdWI.AddRow();  
                    grdWI.SetGridText( grdWI.rows-1, G2_TST_ORDERM_PK, txtSOM_PK.text);
                    grdWI.SetGridText( grdWI.rows-1, G2_Line,          arrTemp[0]);
                    grdWI.SetGridText( grdWI.rows-1, G2_WORK_DATE,     arrTemp[2]);                         
                    grdWI.SetGridText( grdWI.rows-1, G2_WI_Qty,        CalTargetQty(aValue.length,arrTemp[1]) );
      
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
        case "ipwi0050":           
            OnSearch('grdWI');
        break;
     }
}
//---------------------------------------------------------------------------------------------------

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
        txtSOM_PK.text      = grdSO.GetGridData( grdSO.row, G1_orderm_pk );
        txtPONo.text        = grdSO.GetGridData( grdSO.row, G1_po_no     );       
        txtStyleID.text     = grdSO.GetGridData( grdSO.row, G1_style_id  );
        txtStyle.text       = grdSO.GetGridData( grdSO.row, G1_style_desc);        
        txtOrderQty.text    = grdSO.GetGridData( grdSO.row, G1_ord_qty   );
        txtWIQty.text       = grdSO.GetGridData( grdSO.row, G1_wi_qty    );
        txtWIBalance.text  = grdSO.GetGridData( grdSO.row, G1_Bal_qty   );
        
        OnSearch('grdWI');
    }
}
//-------------------------------------------
function CalTargetQty(Line_Num,WI_Balance)
{
     var arrTemp=new Array();
    
     if ( Number(WI_Balance)>0 && Number(Line_Num)>0 )
     {
        return Math.ceil(Number(WI_Balance)/Number(Line_Num)) ;
     }

     return 0;
}
//---------------------------------------------------------------------------------------------------

function On_AfterEdit()
{
	var cIdx = event.col;
	
	if ( cIdx == G2_OT_Start || cIdx == G2_OT_End )
	{
		var tmpIN = grdWI.GetGridData( event.row, cIdx );
		
		if (tmpIN.length==0)
		{
			grdWI.SetGridText( event.row,cIdx,"")
			return;
		}
		else if((tmpIN.length !=4 ) &&( tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdWI.SetGridText(event.row,cIdx,'');
			return;
		}
		else if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdWI.SetGridText(event.row,cIdx,'')
			return;
		}
		else if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdWI.SetGridText(event.row,cIdx,'')
			return;
		}
		
		tmpIN = tmpIN.substr(0,2)+":"+tmpIN.substr(2,2);
		grdWI.SetGridText(event.row,cIdx,tmpIN) ;
	}


}
//------------------------------------------------------------------------------------

</script>

<body>
    <!------------------------------------------------------------------------------------->
    <gw:data id="ipwi0050" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"   function="stm.sp_sel_ipwi0050" > 
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
    <gw:data id="ipwi0050_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"   function="stm.sp_sel_ipwi0050_1" parameter="0,1,2,3,4,5,6,7,8,9" procedure="STM.sp_upd_ipwi0050_1"> 
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
                            PO No
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
                            <gw:grid id='grdSO' header='_TST_ORDERM_PK|Style ID|Style|PO Num|Ord Qty|WI Qty|WI Bal'
                                format='0|0|0|0|0|0|0' aligns='0|0|0|0|3|3|3' defaults='||||||' editcol='0|0|0|0|0|0|0'
                                widths='1000|1500|2000|1500|1500|1500|1500' sorting='T' oncellclick='OnGridClick()'
                                styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 606%">
                <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 5%">
                        <td style="width: 10%" align="right">
                            PO No
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtPONo" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            Style ID
                        </td>
                        <td style="width: 15%" align="right">
                            <gw:textbox id="txtStyleID" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            Style
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtStyle" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td style="width: 10%" align="right">
                            Ord Qty
                        </td>
                        <td style="width: 15%" align="right">
                            <gw:textbox id="txtOrderQty" styles="width:100%" type="number" format="###,###.###" />
                        </td>
                        <td style="width: 10%" align="right">
                            WI Qty
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtWIQty" styles="width:100%" type="number" format="###,###.###" />
                        </td>
                        <td style="width: 10%" align="right">
                            WI Bal.
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtWIBalance" styles="width:100%" type="number" format="###,###.###" />
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
                            <gw:grid id='grdWI' header='_PK|_TST_ORDERM_PK|Line|Date|WI Qty|OT QTY|OT Start|OT End|OT Time|Description'
                                format='0|0|0|4|1|1|0|0|1|0' aligns='0|0|0|1|3|3|1|1|3|0' defaults='|||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1' widths='0|0|0|1200|1500|1500|1200|1200|1200|2000'
                                sorting='T' styles='width:100%; height:100%' onafteredit="On_AfterEdit()" />
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
</body>
</html>
