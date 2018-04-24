<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Generate Packages from Packing Type</title>
</head>

<script>

var G1_AS_SL                    = 0,
    G1_PackingType              = 1,
    G1_Packages_Type            = 2,
    G1_NULL_01                  = 3,
    G1_Pack_Seq                 = 4,
    G1_SO_PK                    = 5,
    G1_Qty                      = 6,
    G1_Item_BC                  = 7,
    G1_PA_PACKING_WI_PK         = 8,
    G1_Package_PK               = 9;
    
var G2_SPEC01_PK        = 0,
    G2_Spec_01          = 1,
    G2_SPEC02_PK        = 2,
    G2_Spec_02          = 3,
    G2_SPEC03_PK        = 4,
    G2_Spec_03          = 5,
    G2_SPEC04_PK        = 6,
    G2_Spec_04          = 7,
    G2_SPEC05_PK        = 8,
    G2_Spec_05          = 9,
    G2_Pack_Qty         = 10,
    G2_Packages_PK      = 11,
    G2_Packages_Item_PK = 12,
    G2_SOD_PK           = 13;
    
//===========================================================

 function BodyInit()
 {
    System.Translate(document);
    //----------------------
    var callerWindowObj = dialogArguments;    
      
    txtWIMasterPK.text = callerWindowObj.txtWIMasterPK.text ;
    txtArraySOPK.text = callerWindowObj.txtArraySOPK.text ;    
	//----------------
	FormatGrid();
	//----------------
	OnSearch('SOList');
	//----------------
 } 
//===========================================================
 function FormatGrid()
 { 
      var trl;   
      //-------------------------------------------------
      trl = grdPackagesItem.GetGridControl();	
      trl.ColFormat(G2_Pack_Qty)   = "###,###,###,###,###";
      //-------------------------------------------------
      //-------------------------------------------------            
      var data ="#AS;AS|#SL;SL"
      grdPackages.SetComboFormat( G1_AS_SL, data);  
 
      data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   pk, type_name FROM tlg_pa_packing_type a WHERE del_if = 0 ORDER BY type_code" ) %>|| ";       
      grdPackages.SetComboFormat( G1_PackingType, data);      
           
      data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   pk, cover_name FROM tlg_pa_packages_type a WHERE del_if = 0 ORDER BY cover_code" ) %>|| ";       
      grdPackages.SetComboFormat( G1_Packages_Type, data);      
      
      data = "<%=ESysLib.SetListDataSQL(" SELECT   pk, cover_code || ' - ' || cover_name FROM tlg_pa_packages_type a WHERE del_if = 0 ORDER BY cover_code ")%>||Select ALL";     
      lstPackagesType.SetDataText(data);
      lstPackagesType.value = '';                            
                       
 }
//===========================================================
 function OnDataReceive(obj)
 { 
    switch (obj.id)
    {
        case 'pro_dsep00074' :
            grdPackages.SetComboFormat( G1_SO_PK, txtReturnValue.text);
            
            OnSearch('grdPackages');
        break;
        
        case 'pro_dsep00074_1' :
            alert(txtReturnValue.text);
            
            OnSearch('grdPackages');
        break; 
        
        case 'pro_dsep00074_2' :
            alert(txtReturnValue.text);
            
            OnSearch('grdPackages');
        break;                
        
        case 'data_dsep00074' :
        
            lblRecond.text = grdPackages.rows-1 + " row(s)";
            
            if ( grdPackages.rows > 1 )
            {
                grdPackages.SetCellBold( 1, G1_Pack_Seq, grdPackages.rows - 1, G1_Pack_Seq, true);
                grdPackages.SetCellBold( 1, G1_Qty,      grdPackages.rows - 1, G1_Qty,      true);
            }
        break;    
        
        case 'data_dsep00074_1' :
            if ( grdPackagesItem.rows > 1 )
            {
                grdPackagesItem.SetCellBold( 1, G2_Pack_Qty, grdPackagesItem.rows - 1, G2_Pack_Qty,  true);
            }
        break;           
    }
 }
//===========================================================
 function OnSearch(pos)
 { 
    switch (pos)
    { 
        case 'SOList':
            pro_dsep00074.Call();
        break;
               
        case 'grdPackages':
            var dQuantiy;
            dQuantiy =  txtSeq.text;
            if(Number(dQuantiy)||dQuantiy=="")
            {
                data_dsep00074.Call("SELECT");
            }
            else
            {
                alert("SEQ must a numberic");
            }
            
        break; 
        
        case 'grdPackagesItem':
            if ( grdPackages.row > 0 )
            {
                txtPackagesPK.text = grdPackages.GetGridData( grdPackages.row, G1_Package_PK);                
            }    
            else
            {
                txtPackagesPK.text = '' ;
            }
        
            data_dsep00074_1.Call("SELECT");
        break;                           
    }
 }
//==============================================================================
function OnProcess(pos)
{
    switch (pos)
    {
        case 'GetItem':
            if ( txtPackagesPK.text == '' )
            {
                alert('Pls select saved package.');
                return;
            }
            
            var callerWindowObj = dialogArguments;    
            
            for ( var i=1; i<callerWindowObj.grdWIDetail.rows-1; i++)
            {
                if ( callerWindowObj.grdWIDetail.GetGridControl().isSelected(i) == true && Number(callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_Bal_Qty)) > 0 )
                {
                    grdPackagesItem.AddRow();
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_SPEC01_PK, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_SPEC01_PK));                 
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_SPEC02_PK, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_SPEC02_PK));                 
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_SPEC03_PK, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_SPEC03_PK));                 
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_SPEC04_PK, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_SPEC04_PK));                 
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_SPEC05_PK, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_SPEC05_PK));                 
                    
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_Spec_01, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_Spec_01));                 
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_Spec_02, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_Spec_02));
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_Spec_03, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_Spec_03));
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_Spec_04, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_Spec_04));
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_Spec_05, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_Spec_05));
                    
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_SOD_PK, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_SOD_PK));
                    
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_Pack_Qty, callerWindowObj.grdWIDetail.GetGridData( i, callerWindowObj.G1_Bal_Qty));
                    
                    grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_Packages_PK, txtPackagesPK.text);                    

                    grdPackagesItem.SetCellBgColor( grdPackagesItem.rows-1, 0 , grdPackagesItem.rows-1, 12 , 0xCCFFFF );                     
                }
            } 
        break;
        
        case 'MakePackages' :
            if ( txtWIMasterPK.text != '' )
            {
                if ( grdPackages.row > 0 )
                {
                    var path = System.RootURL + "/form/ds/ep/dsep00075.aspx?WI_PK=" + txtWIMasterPK.text + "&packing_type=" + grdPackages.GetGridData( grdPackages.row, G1_PackingType ) ;                
                }
                else
                {
                    var path = System.RootURL + "/form/ds/ep/dsep00075.aspx?WI_PK=" + txtWIMasterPK.text ;                                
                }
                
                var aValue  = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:500px;dialogHeight:220px');	
	            
	            data_dsep00074.Call("SELECT");               
            }
            else
            {
                alert('Pls select Pack W/I.');
            }    
        break;
        
        case 'DeletePackages' :
            if ( lstPackagesType.value > 0 )
            {        
                if ( confirm('Are you sure to delete this Packages Type : '+ lstPackagesType.GetText() + ' ?'))
                {
                    pro_dsep00074_1.Call();
                }
            }
            else
            {
                alert('Pls select one Packges Type. ');
            }                                         
        break;
        
        case 'ResetSeq' :
            if ( lstPackagesType.value > 0 )
            {
                if ( confirm('Are you sure Reset Sequence for '+ lstPackagesType.GetText() + '?'))
                {
                    pro_dsep00074_2.Call();
                }
            }
            else
            {
                alert('Pls select one Packges Type. ');
            }                 
        break;
    }
}
//==============================================================================
function CheckInput()
 { 
    var  row, col;
            row = event.row ;
            col = event.col ;    
            
            if ( col == G2_Pack_Qty )
            {
                var dQuantiy;
                
                dQuantiy =  grdPackagesItem.GetGridData(row,col)
                
                if (Number(dQuantiy))
                {   
                    if (dQuantiy >0)
                    {
                        grdPackagesItem.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(0));
                    }
                    else
                    {
                        alert(" Value must greater than zero !!");
                        grdPackagesItem.SetGridText(row,col,"")
                    }
                }
                else
                {
                    grdPackagesItem.SetGridText(row,col,"")
                }         
            }         
    
 }
//==============================================================================

function OnCellClk(obj)
{
    switch (obj.id)
    {
        case 'grdPackages' :            
            OnSearch('grdPackagesItem');
        break;
    }
}

//==============================================================================

function OnDelete(pos)
{
    switch (pos)
    {
        case 'grdPackages':
            for ( var i = 1; i < grdPackages.rows; i++ )
            {
                if ( grdPackages.GetGridControl().isSelected(i) == true )
                {
                    if ( grdPackages.GetGridData( i, G1_Package_PK) == '' )
                    {
                        grdPackages.RemoveRowAt(i);                 
                    }   
                    else
                    {
                        grdPackages.DeleteRow();  
                    } 
                }    
            }                       
        break;
        
        case 'grdPackagesItem':
            for ( var i = 1; i < grdPackagesItem.rows; i++ )
            {
                if ( grdPackagesItem.GetGridControl().isSelected(i) == true )
                {
                    grdPackagesItem.DeleteRow();  
                }    
            }                       
        break;        
    }
}
//====================================================================
function OnUnDelete(obj)
{
    switch(obj)
    {
        case 'grdPackages' :
            grdPackages.UnDeleteRow();  
        break; 
        
        case 'grdPackagesItem':
	        grdPackagesItem.UnDeleteRow();
        break;       
    }

}
//=========================================================================
function OnSave(pos)
{
    switch (pos)
    {
        case 'grdPackages':                
            data_dsep00074.Call();            
        break;
        
        case 'grdPackagesItem':                
            data_dsep00074_1.Call();            
        break;        
    }
}

//===============================================================================
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'grdPackages':
            if ( txtWIMasterPK.text != '' )
            {
                grdPackages.AddRow();
                grdPackages.SetGridText( grdPackages.rows-1, G1_PA_PACKING_WI_PK, txtWIMasterPK.text ) ;
            }    
        break;
        
        case 'grdPackagesItem':
            if ( txtPackagesPK.text == '' )
            {
                alert('Pls select saved package.');
                return;
            }
            
            grdPackagesItem.AddRow();            
            grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_Packages_PK, txtPackagesPK.text);
            grdPackagesItem.SetGridText( grdPackagesItem.rows-1, G2_Pack_Qty, 1 );                    

            grdPackagesItem.SetCellBgColor( grdPackagesItem.rows-1, 0 , grdPackagesItem.rows-1, 12 , 0xCCFFFF );                     

        break;
    }
}
//==============================================================================
function F_OnCellDoubleClick(pos)
{
    switch (pos)
    {
        case 'grdPackagesItem':
            var t_col = event.col ;
            var t_row = event.row ;
            
            if ( t_col == G2_Spec_01 || t_col == G2_Spec_02 || t_col == G2_Spec_03 || t_col == G2_Spec_04 || t_col == G2_Spec_05)   
            {  
                var path = System.RootURL + '/form/fp/ab/fpab00090.aspx?group_type=1';
                var object  = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:700px;dialogHeight:500px');	                
                
                if ( object != null )
                {                                   
                    grdPackagesItem.SetGridText( t_row, t_col  , object[4] );
                    grdPackagesItem.SetGridText( t_row, t_col-1, object[2] );  
                }    	         
            }    
                    
        break;
        
        case 'grdPackages':
            var t_col = event.col ;
            var t_row = event.row ;
            
            var tmp_seq = 1; 
            if ( t_col == G1_Pack_Seq || t_row == 1 )
            {
                var t_packages_type = grdPackages.GetGridData( 1, G1_Packages_Type);
                
                if ( confirm('Do you want to reset Package Sequence?') )
                {
                    for ( var i=1; i<grdPackages.rows ;i++)
                    {
                        if ( t_packages_type == grdPackages.GetGridData( i, G1_Packages_Type) )
                        {
                            grdPackages.SetGridText( i, G1_Pack_Seq, tmp_seq);
                            tmp_seq = tmp_seq + 1 ;
                        }
                    }                    
                }
            }        
        break;
    }
}
//==============================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00074" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsep00074" > 
                <input>
                    <input bind="txtArraySOPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00074_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsep00074_1" > 
                <input>
                    <input bind="txtWIMasterPK" /> 
                    <input bind="lstPackagesType" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00074_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsep00074_2" > 
                <input>
                    <input bind="txtWIMasterPK" />
                    <input bind="lstPackagesType" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>    
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00074" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale"  parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_dsep00074" procedure="<%=l_user%>lg_upd_dsep00074"> 
                <input> 
                    <input bind="txtWIMasterPK" /> 
                    <input bind="lstPackagesType" />
                    <input bind="txtSeq" />
                </input> 
                <output bind="grdPackages" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00074_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="<%=l_user%>lg_sel_dsep00074_1" procedure="<%=l_user%>lg_upd_dsep00074_1" > 
                <input> 
                    <input bind="txtPackagesPK" /> 
                </input> 
                <output bind="grdPackagesItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 1%">
                            <gw:icon id="ibtnResetPackageSeq" img="2" text="Reset Seq" alt="Reset Package Sequence"
                                onclick="OnProcess('ResetSeq')" styles='width:100%' />
                        </td>
                        <td style="width: 9%">
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Packages
                        </td>
                        <td style="width: 40%">
                            <gw:list id="lstPackagesType" styles='width:100%' />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="ibtnDeletePackagesType" img="2" text="Delete" alt="Delete Packages Type"
                                onclick="OnProcess('DeletePackages')" styles='width:100%' />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Seq
                        </td>
                        <td style="width: 11%">
                            <gw:textbox id="txtSeq" styles="width: 90%" onenterkey="OnSearch('grdPackages')" />
                        </td>
                        <td style="width: 24%; white-space: nowrap" align="center">
                            <gw:label id="lblRecond" styles='width:100%;color:cc0000;font:9pt' text='record(s)' />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch('grdPackages')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnNew" img="new" alt="New" onclick="OnAddNew('grdPackages')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnDelete" img="delete" alt="Delete" onclick="OnDelete('grdPackages')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnUnDelete" img="udelete" alt="UnDelete" onclick="OnUnDelete('grdPackages')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSave" img="save" alt="Save" onclick="OnSave('grdPackages')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td colspan="2">
                <gw:grid id='grdPackages' header='AS/SL|Packing Type|Packages Type|_NULL 01|Pack Seq|P/O No|Qty|Item B/C|_PA_PACKING_WI_PK|_PK'
                    format='0|0|0|0|0|0|0|0|0|0' aligns='1|0|0|0|1|0|3|1|0|0' defaults='|||||||||'
                    editcol='1|1|1|1|1|1|0|0|0|0' widths='1000|2500|2500|0|1000|1800|1000|1200|0|0'
                    sorting='T' styles='width:100%; height:100%' oncellclick="OnCellClk(this)" oncelldblclick="F_OnCellDoubleClick('grdPackages')" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 1%">
                            <gw:icon id="ibtnGeneratePackages" img="2" text="Make Packages" alt="Make Packages"
                                onclick="OnProcess('MakePackages')" styles='width:100%' />
                        </td>
                        <td style="width: 94%">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="ibtnGetItem" img="2" text="Get Remain Item" alt="Get Item" onclick="OnProcess('GetItem')"
                                styles='width:100%' />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnAddNew01" img="new" alt="New" onclick="OnAddNew('grdPackagesItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnDelete01" img="delete" alt="Delete" onclick="OnDelete('grdPackagesItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnUnDelete01" img="udelete" alt="UnDelete" onclick="OnUnDelete('grdPackagesItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSave01" img="save" alt="Save" onclick="OnSave('grdPackagesItem')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td>
                <gw:grid id='grdPackagesItem' header='_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|Pack Qty|_Packages_PK|_Packages_Item_PK|_SOD_PK'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|1|0|1|0|1|0|1|0|1|3|0|0|0' defaults='|||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|1|0|0|0' widths='1000|1800|1000|1800|1000|1800|1000|1800|1000|1800|1200|0|0|0'
                    sorting='T' styles='width:100%; height:100%' oncelldblclick="F_OnCellDoubleClick('grdPackagesItem')" onafteredit="CheckInput()" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
    <gw:textbox id="txtWIMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txtPackagesPK" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
    <gw:textbox id="txtArraySOPK" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
</body>
</html>
