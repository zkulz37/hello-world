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

var G1_SPEC01_PK    = 0,
    G1_Spec_01      = 1, 
    G1_SPEC02_PK    = 2,
    G1_Spec_02      = 3,
    G1_SPEC03_PK    = 4,
    G1_Spec_03      = 5,
    G1_SPEC04_PK    = 6,
    G1_Spec_04      = 7,
    G1_SPEC05_PK    = 8,
    G1_Spec_05      = 9,
    G1_Pack_Qty     = 10,
    G1_Description  = 11;

var G2_No           = 0,
    G2_AS_SL        = 1,
    G2_Packing_Type = 2,
    G2_Packages_Type= 3, 
    G2_Pack_Seq     = 4,
    G2_PO_No        = 5,
    G2_Packages_PK  = 6;
    
var G3_SPEC01_PK        = 0,
    G3_Spec_01          = 1,
    G3_SPEC02_PK        = 2,
    G3_Spec_02          = 3,
    G3_SPEC03_PK        = 4,
    G3_Spec_03          = 5,
    G3_SPEC04_PK        = 6,
    G3_Spec_04          = 7,
    G3_SPEC05_PK        = 8,
    G3_Spec_05          = 9,
    G3_Pack_Qty         = 10,
    G3_Packages_PK      = 11,
    G3_Packages_Item_PK = 12;
    
//===========================================================

 function BodyInit()
 {
    System.Translate(document);
    txtPONo.SetEnable(false);
    //----------------------
    var callerWindowObj = dialogArguments;    
      
    txtArraySOPK.text = callerWindowObj.txtArraySOPK.text ;
    txtPONo.text      = callerWindowObj.txtPONo.text ;
    
    txtArrayWIDetailPK.text = callerWindowObj.txtWIDetailPK.text ;
    txtWIMasterPK.text = callerWindowObj.txtWIMasterPK.text ;
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
      trl.ColFormat(G3_Pack_Qty)   = "###,###,###,###,###";
      //-------------------------------------------------
      trl = grdPackingTypeItem.GetGridControl();	
      trl.ColFormat(G1_Pack_Qty)   = "###,###,###,###,###";  

      trl = grdPackages.GetGridControl();  
      
      trl.MergeCells = 2;
      trl.MergeCol(G2_No)           = true;
      trl.MergeCol(G2_AS_SL)        = true;
      trl.MergeCol(G2_Packing_Type) = true;
      trl.MergeCol(G2_Packages_Type)= true;
          
      var data = "";  
       
      data = "<%=ESysLib.SetListDataSQLPara(" SELECT pk, seq_num FROM tlg_pa_packages_process WHERE del_if = 0 AND tlg_pa_packing_wi_pk = {0} order by seq_num ", Request.querystring("WI_PK")) %>||";     
      lstProcessTime.SetDataText(data);  
      lstProcessTime.value = '' ;                     
 }
//===========================================================
 function OnDataReceive(obj)
 { 
    switch (obj.id)
    {
        case 'data_dsep00073' :
            if ( grdPackingTypeItem.rows > 1 )
            {
                grdPackingTypeItem.SetCellBold( 1, G1_Pack_Qty, grdPackingTypeItem.rows - 1, G1_Pack_Qty,  true);
            }
            //----------------------
            ibtnGenerate.SetEnable(true);
            //----------------------
        break;
        
        case 'data_dsep00073_1' :
            if ( grdPackages.rows > 1 )
            {
                grdPackages.SetCellBold( 1, G2_PO_No, grdPackages.rows - 1, G2_PO_No,  true);
                grdPackages.SetCellBgColor( 1, G2_PO_No , grdPackages.rows - 1, G2_PO_No , 0xCCFFFF );                 
            }
            
            OnSearch('grdPackagesItem');        
        break;
        
        case 'data_dsep00073_2' :
            if ( grdPackagesItem.rows > 1 )
            {
                grdPackagesItem.SetCellBold( 1, G3_Pack_Qty,  grdPackagesItem.rows - 1, G3_Pack_Qty,  true);
                grdPackagesItem.SetCellBgColor( 1, G3_Pack_Qty , grdPackagesItem.rows - 1, G3_Pack_Qty , 0xCCFFFF );                 
            }        
        break;  
    
        case 'pro_dsep00073':
            OnSearch('AssortType');
        break;
        
        case 'pro_dsep00073_1':
            OnSearch('grdPackingTypeItem');
        break;
              
        case 'pro_dsep00073_2' :
            grdPackages.SetComboFormat( G2_PO_No, txtReturnValue.text); 
            //---------------
            OnSearch('PackingType');
        break;  
        
        case 'pro_dsep00073_3' :
            alert(txtReturnValue.text);
            
            ibtnGenerate.SetEnable(true);
            ibtnGeneratePackages.SetEnable(true);  
                      
            OnSearch('ProcessTime');
        break;  
        
        case 'pro_dsep00073_5' :
            lstProcessTime.value = txtPackagesProcessPK.text ;
            
            OnSearch('grdPackages');
        break;           
    }
 }
//===========================================================
 function OnSearch(pos)
 { 
    switch (pos)
    {
        case 'PackingType':
            //-------------
            ibtnGenerate.SetEnable(false);
            //-------------
            if ( radPackType.value == 'SL' )
            {
                lstAssortType.style.display = "none" ;             
            }
            else
            {
                lstAssortType.style.display = "" ;                              
            }
            //-------------
            pro_dsep00073.Call();
        break;   
        
        case 'AssortType':
            pro_dsep00073_1.Call();
        break; 
        
        case 'grdPackingTypeItem':
            data_dsep00073.Call("SELECT");
        break; 
        
        case 'grdPackages':
            data_dsep00073_1.Call("SELECT");
        break; 
        
        case 'grdPackagesItem':
            if ( grdPackages.row > 0 )
            {
                txtPackagesPK.text = grdPackages.GetGridData( grdPackages.row, G2_Packages_PK);                
            }    
            else
            {
                txtPackagesPK.text = '' ;
            }
        
            data_dsep00073_2.Call("SELECT");
        break;
        
        case 'SOList':
            pro_dsep00073_2.Call();   
        break;          
        
        case 'ProcessTime':
            pro_dsep00073_5.Call();   
        break;                           
    }
 }
//==============================================================================
function OnProcess(pos)
{
    switch (pos)
    {
        case 'GeneratePackages':
            if ( confirm('Do you want to create packages ?'))
            {
                ibtnGenerate.SetEnable(false);
                ibtnGeneratePackages.SetEnable(false);
                pro_dsep00073_3.Call();
            }  
        break;
        
        case 'MakePackages' :
            if ( txtWIMasterPK.text != '' )
            {
                var path = System.RootURL + "/form/ds/ep/dsep00075.aspx?WI_PK=" + txtWIMasterPK.text + "&packing_type=" + lstPackingType.value ;
                var aValue  = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:500px;dialogHeight:220px');	
	            
	            OnSearch('grdPackages');
            }
            else
            {
                alert('Pls select Pack W/I.');
            }    
        break;        
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
function OnPopUp(id)
{
    switch (id)
    {
        case 'PackingType':
             var path = System.RootURL + '/form/ds/ep/dsep00080.aspx?';
	         var object = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:800px;dialogHeight:600px');
//	         if (object!= null)
//	         {
//	            txtCoverPK.text = object[0]
//	            txtCoverID.text = object[1]
//	            txtCoverNM.text = object[2]
//	         }
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
                    if ( grdPackages.GetGridData( i, G2_Packages_PK) == '' )
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
    }
}
//=========================================================================
function OnSave(pos)
{
    switch (pos)
    {
        case 'grdPackages':                
            data_dsep00073_1.Call();
            
        break;
    }
}
//==============================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00073" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  parameter="0,1,2" function="<%=l_user%>lg_sel_dsep00073" > 
                <input> 
                    <input bind="radPackType" /> 
                    <input bind="lstPackingType" /> 
                    <input bind="lstAssortType" />
                </input> 
                <output bind="grdPackingTypeItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00073_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"   parameter="0,1,2,3,4,5,6" function="<%=l_user%>lg_sel_dsep00073_1" procedure="<%=l_user%>lg_upd_dsep00073_1" > 
                <input>
                    <input bind="txtWIMasterPK" /> 
                    <input bind="lstProcessTime" /> 
                </input> 
                <output bind="grdPackages" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00073_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  parameter="0,1,2" function="<%=l_user%>lg_sel_dsep00073_2" > 
                <input> 
                    <input bind="txtPackagesPK" /> 
                </input> 
                <output bind="grdPackagesItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00073" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="list" procedure="<%=l_user%>lg_pro_dsep00073" > 
                <input>
                    <input bind="radPackType" /> 
                </input> 
                <output>
                    <output bind="lstPackingType" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00073_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="list" procedure="<%=l_user%>lg_pro_dsep00073_1" > 
                <input>
                    <input bind="lstPackingType" /> 
                </input> 
                <output>
                    <output bind="lstAssortType" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00073_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsep00073_2" > 
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
    <gw:data id="pro_dsep00073_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsep00073_3" > 
                <input>
                    <input bind="txtWIMasterPK" />
                    <input bind="txtArrayWIDetailPK" />
                    <input bind="radPackType" />
                    <input bind="lstPackingType" />
                    <input bind="lstAssortType" /> 
                </input> 
                <output>
                    <output bind="txtPackagesProcessPK" />
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00073_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="list" procedure="<%=l_user%>lg_pro_dsep00073_5" > 
                <input>
                    <input bind="txtWIMasterPK" /> 
                </input> 
                <output>
                    <output bind="lstProcessTime" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td colspan="2">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 30%; background-color: #B4E7FF" align="center">
                            <gw:radio id="radPackType" value="SL" styles="width:100%" onchange="OnSearch('PackingType')"> 
                                <span id="tab_Solid" value="SL">Solid </span> 
                                <span id="tab_Assort" value="AS">Assort</span> 
                            </gw:radio>
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('PackingType')">&nbsp;&nbsp;Packing
                                Type</b>
                        </td>
                        <td style="width: 50%; white-space: nowrap">
                            <gw:list id="lstPackingType" styles='width:100%' onchange="OnSearch('AssortType')"
                                csstype="mandatory" />
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            <gw:list id="lstAssortType" styles='width:100%' csstype="mandatory" onchange="OnSearch('grdPackingTypeItem')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 38%">
            <td colspan="2">
                <gw:grid id='grdPackingTypeItem' header='_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|Pack Qty|Description'
                    format='0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|1|0|1|0|1|0|1|0|1|3|0' defaults='|||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1500|1000|1500|1000|1500|1000|1500|1000|1500|1200|0'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="2">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 15%">
                            <gw:list id="lstProcessTime" styles="width:100%" csstype="mandatory" onchange="OnSearch('grdPackages')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch('grdPackages')" />
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
                        <td style="width: 21%">
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            P/O No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtPONo" styles='width:100%' />
                        </td>
                        <td style="width: 17%">
                        </td>
                        <td style="width: 1%; white-space: nowrap">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="ibtnGenerate" img="2" text="Generate" alt="Calculate Package qty." onclick="OnProcess('GeneratePackages')"
                                styles='width:100%' />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="ibtnGeneratePackages" img="2" text="Make Packages" alt="Make Packages"
                                onclick="OnProcess('MakePackages')" styles='width:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 60%">
            <td style="width: 45%">
                <gw:grid id='grdPackages' header='No|AS/SL|Type|Packages|Pack Seq|P/O No|_PK' format='0|0|0|0|0|0|0'
                    aligns='1|1|1|1|1|0|0' defaults='||||||' editcol='0|0|0|0|1|0' widths='1000|800|800|1000|1000|1500|1000'
                    sorting='T' styles='width:100%; height:100%' oncellclick="OnCellClk(this)" />
            </td>
            <td style="width: 55%">
                <gw:grid id='grdPackagesItem' header='_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|Pack Qty|_Packages_PK|_Packages_Item_PK'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|1|0|1|0|1|0|1|0|1|3|0|0' defaults='||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|1|0|0' widths='1000|1200|1000|1200|1000|1200|1000|1200|1000|1200|1200|0|0'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
    <gw:textbox id="txtArraySOPK" styles='width:100%;display:none;' />
    <gw:textbox id="txtWIMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txtArrayWIDetailPK" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
    <gw:textbox id="txtPackagesProcessPK" styles='width:100%;display:none' />
    <gw:textbox id="txtPackagesPK" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
</body>
</html>
