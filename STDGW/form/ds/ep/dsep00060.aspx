<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Packing WI Entry</title>
</head>

<script>
var p_action  = 'view';
var rtnLGCode = '' ;

var G1_SO_M_PK		= 0,
	G1_SO_D_PK		= 1,
	G1_ITEM_PK		= 2,
	G1_ITEM_CODE	= 3,
	G1_ITEM_NAME	= 4,
	G1_UOM			= 5,     
    G1_PACK_QTY     = 6,
    G1_PACKED_QTY   = 7,
    G1_BAL_QTY      = 8,
    G1_REMARK      	= 9,
    G1_MASTER_PK 	= 10,
    G1_DETAIL_PK    = 11;
     
var G3_SPEC01_PK    = 0,
    G3_Spec_01      = 1,
    G3_SPEC02_PK    = 2,
    G3_Spec_02      = 3,
    G3_SPEC03_PK    = 4,
    G3_Spec_03      = 5,
    G3_SPEC04_PK    = 6,
    G3_Spec_04      = 7,
    G3_SPEC05_PK    = 8,
    G3_Spec_05      = 9,
    G3_Qty          = 10;

 var v_language = "<%=Session("SESSION_LANG")%>";
 
 var arr_FormatNumber = new Array(); 
 //==================================================================
 function BodyInit()
 {
    if (v_language!="ENG")
        System.Translate(document);
    //-----------------------------------
    txtChargerNm.SetEnable(false);
    txtWINo.SetEnable(false);
    txtPONo.SetEnable(false);
    //-----------------------------------
    FormatGrid();
    //-----------------------------------    
 } 
 //======================================================================
 function FormatGrid()
 {    
      var trl;   
      //-------------------------------------------------
      trl = grdWIDetail.GetGridControl();	
      trl.ColFormat(G1_PACK_QTY)   = "###,###,###,###,###";
      trl.ColFormat(G1_PACKED_QTY) = "###,###,###,###,###";
      trl.ColFormat(G1_BAL_QTY)    = "###,###,###,###,###";
      //-------------------------------------------------
            
      arr_FormatNumber[G1_PACK_QTY] = 0;                      
 }  
 //======================================================================   

function OnPopUp(n)
{
    switch(n)
    {
        case 'SO':
            if ( data_dsep00060.GetStatus() == '20' || ( txtWIMasterPK.text != '' && grdWIDetail.rows == 1 ) )
            {
                var path = System.RootURL + "/form/ds/ep/dsep00071.aspx";
	            var object = System.OpenModal( path , 1000 , 650 ,  'resizable:yes;status:yes', this);
            	
	            if ( object != null )
	            { 	            
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        data = object[i];
                        
                        grdWIDetail.AddRow();

                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SO_PK,  data[18] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SOD_PK, data[17] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_PO_No,  data[0]  );

                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_Spec_01,   data[1]  );                              
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC01_PK, data[11] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_Spec_01,   data[1]  );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC02_PK, data[12] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_Spec_02,   data[2]  );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC03_PK, data[13] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_Spec_03,   data[3]  );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC04_PK, data[14] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_Spec_04,   data[4]  );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_SPEC05_PK, data[15] );
                        grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_Spec_05,   data[5]  );
                        
                        if ( Number(data[9]) + Number(data[10]) > 0 )
                        {
                            grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_PACK_QTY, Number(data[9]) + Number(data[10]) );
                        }
                        else
                        {
                            grdWIDetail.SetGridText( grdWIDetail.rows-1, G1_PACK_QTY, Number(data[6]) - Number(data[7]) );                    
                        }                      
                    } 
                    //-------------------                
                    grdWIDetail.Subtotal( 0, 2, -1, '13!14!15','###,###,###');
                }
            }
            else if ( txtWIMasterPK.text != '' )
            {
                 var path = System.RootURL + '/form/ds/ep/dsep00077.aspx?WI_PK=' + txtWIMasterPK.text ;
                 var obj = System.OpenModal( path , 300 , 150 ,  'resizable:yes;status:yes', this);            
            }
            else
            {
                alert('Pls Add New W/I or delete all items.');
            }    
        break;
        
        case 'WINo':
            var path = System.RootURL + "/form/ds/ep/dsep00072.aspx";
	        var object = System.OpenModal( path , 800 , 500 ,  'resizable:yes;status:yes');
	        
	        if ( object != null )
	        {   
	            txtWIMasterPK.SetDataText(object[0]);
	            
	            OnSearch('data_dsep00060');
	        }
        break;  
        
        case 'Charger' :
             var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             if ( obj != null )
             {
                txtChargerPK.text = obj[0];
                txtChargerNm.text = obj[2];
             }
        break;  
        
        case 'PackingType' : 
             if ( grdWIDetail.rows > 1 && txtWIMasterPK.text != '' )
             { 
			 	 txtWIDetailPK.text = '' ;
				 
                 if ( chkAllItem.value == 'N' ) 
                 {      
                         //---------------------------
                         var array_wi_detail_pk = '' ;
                         var t_link = '' ;
                         
                         for ( var i=1; i<grdWIDetail.rows-1; i++)   
                         {
                             if ( grdWIDetail.GetGridControl().isSelected(i) == true )
                             {
                                array_wi_detail_pk = array_wi_detail_pk + t_link + grdWIDetail.GetGridData( i, G1_DETAIL_PK);
                                t_link = ',' ; 
                             }
                         }
                                          
                         txtWIDetailPK.text = array_wi_detail_pk ;
                 }                               
                 //---------------------------
                 var path = System.RootURL + '/form/ds/ep/dsep00073.aspx?WI_PK=' + txtWIMasterPK.text + '||||';
                 var obj = System.OpenModal( path ,950 , 650 ,  'resizable:yes;status:yes', this);
                 
                 OnSearch('grdPackages');
             }
             else
             {
                alert('Pls save the W/I with S/O Item.');
             }
        break; 
        
         
        
        case 'MakePackages':
             if ( txtWIMasterPK.text != '' )
             {
                  var path = System.RootURL + '/form/ds/ep/dsep00074.aspx';
                  var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes', this);
                          
                  OnSearch('grdPackages');            
             } 
             else
             {
                  alert('Pls select Pack WI.');
             }  
        break;                           	              
    }
}
//=========================================================================
function OnReportClick()
 {
     if (txtWIMasterPK.text!="")
        { 
              //var url =System.RootURL + '/reports/ds/cd/dscd00030.xls?sopk=' + txtMasterPK.text  ;
              //var url =System.RootURL + '/reports/ds/cd/dscd00030_YC.aspx?sopk=' + txtMasterPK.text  ;
              var url =System.RootURL + '/reports/ds/ep/rpt_dsep00060_cotton.aspx?sopk='+ txtWIMasterPK.text ;
	          window.open(url); 
        }       
    else    
              alert("Please,Select a Take out to print !")
   
 }
//=========================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'data_dsep00060' :                       
                data_dsep00060.Call("SELECT");            
        break;
        
        case 'Master' :
            if ( txtWIMasterPK.text == '' )
            {
               OnPopUp('WINo');
            }
            else
            {
                OnSearch('data_dsep00060');
            }           
        break;
        
        case 'grdWIDetail' :
            data_dsep00060_1.Call("SELECT");
        break;
        
        case 'grdPackages':
            if ( txtWIMasterPK.text == '' )
            {
                alert('Pls select Pack WI.');
            }
            else
            {
                data_dsep00060_2.Call("SELECT");
            }    
        break;                   
    }
}
//=========================================================================
function OnAddNew(index)
{
    switch(index)
    {
        case 'WI_MASTER':
            data_dsep00060.StatusInsert();
            
            txtWINo.text = '*** New WI ***' ;
            grdWIDetail.ClearData();
            
            txtChargerNm.text = "<%=Session("USER_NAME")%>";
            txtChargerPK.text = "<%=Session("EMPLOYEE_PK")%>";             
        break;        
    }
}
//=========================================================================
function OnSave(index)
{
    switch(index)
    {
        case 'data_dsep00060':
                
            p_action = 'update';
            data_dsep00060.Call();
            
        break;
        
        case 'grdWIDetail':
            for ( var i=1; i<grdWIDetail.rows-1 ; i++ )
            {
                if ( grdWIDetail.GetGridData( i, G1_MASTER_PK ) == '' )
                {
                    grdWIDetail.SetGridText ( i, G1_MASTER_PK , txtWIMasterPK.text );
                }
            }   
                     
            data_dsep00060_1.Call();
        break;
    }
}

//=========================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsep00060':
            //---------------------------       
            if ( p_action == 'update' )
            {                
                OnSave('grdWIDetail');
            }    
            else    
            {
                OnSearch('grdWIDetail');
            }    
        break;
                  
        case 'data_dsep00060_1' :
        
            p_action = '' ;
            
            if ( grdWIDetail.rows > 1 )
            {
                grdWIDetail.SetCellBold( 1, G1_PACK_QTY,   grdWIDetail.rows - 1, G1_PACK_QTY,   true);
                grdWIDetail.SetCellBold( 1, G1_PACKED_QTY, grdWIDetail.rows - 1, G1_PACKED_QTY, true);
                grdWIDetail.SetCellBold( 1, G1_BAL_QTY,    grdWIDetail.rows - 1, G1_BAL_QTY,    true);
                
                grdWIDetail.SetCellBgColor( 1, G1_PACK_QTY , grdWIDetail.rows - 1, G1_BAL_QTY , 0xCCFFFF ); 
                
                grdWIDetail.Subtotal( 0, 2, -1, '13!14!15','###,###,###');   
            }

        break;
        
        case 'data_dsep00060_2' :
            
            if ( grdPackages.rows > 1 )
            {
                grdPackages.SetCellBold( 1, G2_Packages, grdPackages.rows - 1, G2_Packages, true);
            }
                        
        break;                                               
    }
}

//=========================================================================
function OnDelete(pos)
{
    switch(pos)
    {
        case 'WI_MASTER' :
            if ( grdWIDetail.rows > 1 )
            {
                alert('Pls delete details first.');
            }
            else
            {
                if ( confirm('Would you like to delete this W/I ?') )
                {
                    data_dsep00060.StatusDelete();
                    data_dsep00060.Call();
                }    
            }    
        break;
        
        case 'grdWIDetail' :
            for ( var i = 1; i < grdWIDetail.rows; i++ )
            {
                if ( grdWIDetail.GetGridControl().isSelected(i) == true )
                {
                    if ( grdWIDetail.GetGridData( i, G1_MASTER_PK) == '' )
                    {
                        grdWIDetail.RemoveRowAt(i);                 
                    }   
                    else
                    {
                        grdWIDetail.DeleteRow();  
                    } 
                }    
            }            
        break;
        
    }
}

//=======================================================================
 function CheckInput(obj)
 { 
    var  row, col;
   
    switch (obj.id)
    {
        case 'grdWIDetail':
            row = event.row ;
            col = event.col ;    
            
            if ( col == G1_PACK_QTY )
            {
                var dQuantiy;
                
                dQuantiy =  grdWIDetail.GetGridData(row,col)
                
                if (Number(dQuantiy))
                {   
                    if (dQuantiy >0)
                    {
                        grdWIDetail.SetGridText(row,col,System.Round( dQuantiy, arr_FormatNumber[col] ));
                    }
                    else
                    {
                        alert(" Value must greater than zero !!");
                        grdWIDetail.SetGridText(row,col,"")
                    }
                }
                else
                {
                    grdWIDetail.SetGridText(row,col,"")
                }         
                //---------------------------------------------
                grdWIDetail.Subtotal( 0, 2, -1, '6','###,###,###');
            }         
        break;
    }        
 }
 
//=========================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12"  function="<%=l_user%>lg_sel_dsep00060" procedure="<%=l_user%>lg_upd_dsep00060">
                <inout>
                    <inout bind="txtWIMasterPK" /> 
                    <inout bind="txtWINo" />     
                    <inout bind="dtWIDate" />                     
                    <inout bind="txtPONo" /> 
                    <inout bind="txtArraySOPK" /> 
                    <inout bind="txtChargerPK" />                    
                    <inout bind="txtChargerNm" />              
                    <inout bind="txtDescription" /> 
                    <inout bind="lblWIStatus" />     
               
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00060_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"  function="<%=l_user%>lg_sel_dsep00060_1"  procedure="<%=l_user%>lg_upd_dsep00060_1"> 
                <input bind="grdWIDetail">
                    <input bind="txtWIMasterPK" />
                </input>
                <output  bind="grdWIDetail" />
            </dso> 
        </xml>
    </gw:data>  
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00060_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2"  function="<%=l_user%>lg_sel_dsep00060_2" > 
                <input bind="grdPackages">
                    <input bind="txtWIMasterPK" />
                </input>
                <output  bind="grdPackages" />
            </dso> 
        </xml>
    </gw:data>     
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr>
            <td id="t-left" style="width: 54%; white-space: nowrap">
                <table style="width: 100%; height: 100%" border="1">
                    <tr style="height: 1%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('WINo')">W/I No</b>
                                    </td>
                                    <td style="width: 40%">
                                        <gw:textbox id="txtWINo" styles='width:100%' />
                                    </td>
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        W/I Date
                                    </td>
                                    <td style="width: 20%">
                                        <gw:datebox id="dtWIDate" lang="1" styles="width:100%" />
                                    </td>
                                    <td style="width: 15%; white-space: nowrap" align="center">                                        
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnSearch01" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('Master')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnPopUp" img="popup" alt="Open Popup" onclick="OnPopUp('WINo')"
                                            styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnReset" img="new" alt="new" styles='width:100%' onclick="OnAddNew('WI_MASTER')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnDelete" img="delete" alt="delete" styles='width:100%' onclick="OnDelete('WI_MASTER')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnUpdate" img="save" alt="save" styles='width:100%' onclick="OnSave('data_dsep00060')" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('SO')">P/O No</b>
                                    </td>
                                    <td style="width: 40%">
                                        <gw:textbox id="txtArraySOPK" styles='width:100%; display:none' />
                                        <gw:textbox id="txtPONo" styles='width:100%' csstype="mandatory" />
                                    </td>
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Charger')">Charger</b></td>
                                    <td style="width: 70%" colspan="7">
                                        <gw:textbox id="txtChargerPK" styles='width:100%;display:none' />
                                        <gw:textbox id="txtChargerNm" styles='width:100%' />
                                    </td>
                                </tr>                                                               
                                <tr style="height: 1%">
                                    <td align='right' style="width: 10%; white-space: nowrap">
                                        Remark</td>
                                    <td style="width: 40%" colspan="4">
                                        <gw:textbox id="txtDescription" styles='width:100%' />
                                    </td>
                                    <td style="width: 99%" colspan="4" align="center">
                                        <gw:label id="lblWIStatus" styles='width:100%;color:cc0000;font:9pt' text='status' />
                                    </td>
                                    <td style="width: 1%;">
                                        <gw:imgbtn id="ibtnDelDtl" img="delete" alt="Delete" onclick="OnDelete('grdWIDetail')"
                                            styles='width:100%' />
                                    </td>
                                </tr>
								<tr style="height: 99%">
			                        <td colspan=10 >
			                            <gw:grid id='grdWIDetail' 
											header='_SO_M_PK|_SO_D_PK|P/O No|_ITEM_PK|Item Code|Item Name|UOM|Pack Qty|Label Qty|Bal Qty|Remark|_MASTER_PK|_DETIAL_PK'
			                                format='0|0|0|0|0|0|0|0|0|0|0|0|0' 
											aligns='0|0|0|0|0|0|0|3|3|3|0|0|0'
			                                defaults='|||||||||||' 
											editcol='0|0|0|0|0|0|0|1|0|0|0|0|0'
			                                widths='0|0|1500|0|1500|3500|800|1200|1200|1200|1000|0|0' sorting='T'
			                                styles='width:100%; height:100%' onafteredit="CheckInput(this)" />								     	
			                        </td>
			                    </tr>
                            </table>
                        </td>
                    </tr>
                    
                </table>
            </td>            
            <td id="t-right" style="width: 44%; height: 100%">      
                            <table style="width: 100%; height: 100%">
                                <tr>                                    
                                    <td style="width: 1%">
                                        <gw:icon id="ibtnPackingType" img="2" text="Packing Type" alt="Generate Packages from Packing Type"
                                            onclick="OnPopUp('PackingType')" styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="ibtnMakePackages" img="2" text="Packages" alt="Make Packages for remain item"
                                            onclick="OnPopUp('MakePackages')" styles='width:100%' />
                                    </td>
                                    <td style="width: 97%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnSearch" img="search" alt="Seacrh" styles='width:100%' onclick="OnSearch('grdPackages')" />
                                    </td>                                    
                                </tr>
                                <tr style="height: 100%">
                                    <td colspan="8">
                                        <gw:grid id='grdPackages' header='AS/SL|_LabelTypePK|Label|_PackagesPK|Packages|Packages'
                                            format='0|0|0|0|0|0' aligns='1|0|1|0|1|0' defaults='|||||' editcol='0|0|0|0|0|0'
                                            widths='1000|0|1200|0|1200|1000' sorting='T' styles='width:100%; height:100%'
                                            oncellclick="" />
                                    </td>
                                </tr>
                            </table>                         
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------->
<gw:textbox id="txtWIMasterPK" styles='display:none;width:100%' />
<gw:textbox id="txtWIDetailPK" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------->
</html>
