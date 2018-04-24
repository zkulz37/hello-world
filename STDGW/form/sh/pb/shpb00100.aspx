<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head>
    <title>License No. / Size Standard Weight Registration</title>
</head>

<script type="text/javascript" language="javascript">
//------------grdDetail----------
  var   G1_detail_pk        = 0,
        G1_master_pk        = 1,
        G1_component_id     = 2,
        G1_component_nm     = 3,
        G1_component_qty    = 4;
  
  var p_save = 0 ;
 //-----------------------------------

function BodyInit()
{
    BindingDataList();
    txtBasicUnit.SetEnable(false); 
    txtNetUnit.SetEnable(false); 
    txtAverageUnit.SetEnable(false); 
    txtCapColor.SetEnable(false); 
    txtChargerName.SetEnable(false); 
    lstBodyColor.SetEnable(false);
    //------------
    OnAddNew('Master');
    lstCapSize.value='';
    //------------
    OnSearch('List');
}
//---------------------------------------------------------
 function BindingDataList()
 {
    var data  = "<%=ESysLib.SetListDataSQL("select pk, partner_name from comm.tco_company where del_if=0")%>"; 
    lstCompany.SetDataText(data); 
    lstCompany.value  = "<%=session("COMPANY_PK") %>";
 }  
//-----------------------------------
function OnSearch(id)
{      
   switch(id)
   {
        case 'List' :                            //Seach CompType
             data_shpb00100.Call('SELECT')
        break; 
         
        case 'Master' :
            p_save = 0;
             
            if ( grdSearch.rows > 1 )
            {
                txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, 0)
            }
            else
            {
                txtMasterPK.text = '' ;
            }
            
             data_shpb00100_1.Call('SELECT')
        break;
   }
}
//-----------------------------------
function OnAddNew(id)
{
    switch(id)
    {
        case 'Master' :  //New 
            if ( data_shpb00100_1.GetStatus() != 20 )
            {
                data_shpb00100_1.StatusInsert();
            }         
        break;
    }   
}
//-----------------------------------
function OnSave(id)
{
    switch(id)
    {
        case 'Master' :  //Save master
             p_save = 1 ;
             
             if ( Validate() )
             {
                data_shpb00100_1.Call();
             }   
        break;
    }
}
//----------------------------------------

function Validate()    
{   
    if ( txtStandardNo.text == '' )
    {
        alert('Pls enter Standard No. first !!!');
        txtStandardNo.GetControl().focus();
        return false;
    }
    if ( lstCapSize.value == '' )
    {
        alert('Pls select size first !!!');
        lstCapSize.GetControl().focus();
        return false;
    }
    if ( Number(txtTotalWeight.text) == 0 )
    {
        alert('Pls select total weight first !!!');
        txtTotalWeight.GetControl().focus();
        return false;
    }
    //----------------
    return true;
}
//-----------------------------------
function OnDelete(id)
{
    switch(id)
    {
        case 0:
             if ( confirm ( "Do you want to delete?" ) )
              {

                data_shpb00100_1.StatusDelete();
                p_update =1;
                if (txtMasterPK.text!="")                
                    data_shpb00100_1.Call()                    
                
             }
        break;
    }
}
//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case '1':
               var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
               var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtBasicUnit.text = obj[1];
               }	
        break; 
        case '2':
               var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
               var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtAverageUnit.text = obj[1];
               }	
        break;             
        case '3':
               var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
               var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtNetUnit.text = obj[1];
               }	
        break; 
        case '4': 
               var path = System.RootURL + '/form/sh/ab/shab00030.aspx';
               var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtCapColor.text = obj[1];
               }	
        break;   
        case '5':
               var path = System.RootURL + '/form/sh/ab/shab00030.aspx';
               var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    lstBodyColor.text = obj[1];
               }	
        break; 
        case '6':
               var path = System.RootURL + '/form/sh/ab/shab00020.aspx';
               var obj = System.OpenModal( path ,850 , 500,  'resizable:yes;status:yes');
               if ( obj != null )
               {
                    txtChargerPK.text = obj[0];
                    txtChargerName.text = obj[5];
               }	
        break;   
    }
}

//------------------------------------------------------
function OnDataReceive(obj)
{   
    switch(obj.id)
    {
        case 'data_shpb00100_1':
            if(p_save==1)
                data_shpb00100.Call('SELECT');
        break;       
    }
}
//---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
</script>

<body>
    <!--------------------------------Search CompType Type---------------------------------->
    <gw:data id="data_shpb00100" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid"   function="prod.sp_sel_shpb00100"  > 
                <input> 
                    <input bind="lstCapSizeSrc" /> 
                    <input bind="txtID" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------CompType Master---------------------------------->
    <gw:data id="data_shpb00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="prod.sp_sel_shpb00100_1" procedure="prod.sp_upd_shpb00100_1"> 
                <inout>   
                    <inout bind="txtMasterPK" /> 
                    <inout bind="lstCompany" />
                    <inout bind="txtStandardNo" />  
                    <inout bind="lstCapSize" />
                    <inout bind="txtCapLength" />   
                    <inout bind="txtBodyLength" />
                    <inout bind="txtTotalWeight" />   
                    <inout bind="txtLicenseNo" />
                    <inout bind="txtLicenseDate" />
                    <inout bind="txtBasicUnit" />  
                    <inout bind="txtBasicWeight" />
                    <inout bind="txtNetWeight" />  
                    <inout bind="txtNetUnit" />
                    <inout bind="txtAverageWeight" />          
                    <inout bind="txtAverageUnit" />
                    <inout bind="txtWgtdevit" />                    
                    <inout bind="txtFillRange" />  
                    <inout bind="txtCapsuleType" />
                    <inout bind="txtAppearance" />
                    <inout bind="txtCapColor" />  
                    <inout bind="lstBodyColor" />
                    <inout bind="txtChargerPK" />  
                    <inout bind="txtChargerName" />                   
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------Search CompType Type Detail---------------------------------->
    <gw:data id="data_shpb00100_2" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid"   function="prod.sp_sel_shpb00100_2" parameter="0,1,2,3,4,5"  > 
                <input> 
                    <input bind="txtID" /> 
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <table border="1" style="height: 100%; width: 100%">
        <tr style="height: 100%">
            <td id="left" style="width: 25%" valign="top" style="height: 100%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 20%;white-space: nowrap" align="right">
                            <b>Size</b>
                        </td>
                        <td style="width: 79%">
                            <gw:list id="lstCapSizeSrc" styles='width:100%' csstype="mandatory" value="ALL" onchange="OnSearch('List')" >
                                <data>
								    <%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM Sale.LG_CODE a, Sale.LG_CODE_GROUP b WHERE  b.GROUP_ID='LGMF0020' AND a.LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>|ALL|Select ALL
							    </data>
							</gw:list>
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('List')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 20%;white-space: nowrap" align="right">
                            <b>Std. No.</b>
                        </td>
                        <td style="width: 79%" colspan=2>
                            <gw:textbox id="txtID" styles='width:100%' onenterkey="OnSearch('List')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK| Size|Standard No.' format='0|0|0' aligns='0|0|0' editcol='0|0|0'
                                widths='0|1000|2000' sorting='T' styles='width:100%; height:100%' onselchange="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            <b>Company</b>
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstCompany" styles='width:100%' />
                        </td>
                        <td style="width: 10%;white-space: nowrap" align="right">
                            <b>Std. No</b>
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtStandardNo" styles='width:100%'  csstype="mandatory" />
                        </td>
                        <td style="width: 30%">
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 97%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete(0)" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUpdate" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="5">
                            <table style="height: 100%; width: 100%" border=0>
                                <tr style="height: 1%">
                                    <td colspan="6">
                                        <hr style="color: Silver" size="1" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Size
                                    </td>
                                    <td colspan="2" style="width: 30%;">
                                        <gw:list id="lstCapSize" styles='width:100%' csstype="mandatory" >
                                            <data>
											    <%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM Sale.LG_CODE a, Sale.LG_CODE_GROUP b WHERE  b.GROUP_ID='LGMF0020' AND a.LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>||
										    </data>
										</gw:list>
                                    </td>
                                    <td style="width: 30%" align="right">
                                        Length Cap
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtCapLength" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="width: 5%" align="right">
                                        mm
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 10%" align="right">
                                        Total Weight
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtTotalWeight" type="number" format="#,###,###,###,###.##" styles='width:100%' csstype="mandatory" />
                                    </td>
                                    <td style="width: 5%" >
                                        mg</td>
                                    <td style="width: 10%" align="right">
                                        Body
                                    </td>
                                    <td >
                                        <gw:textbox id="txtBodyLength" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td >
                                        mm</td>
                                </tr>
                                <tr style="height: 1%">
                                    <td colspan="6">
                                        <hr style="color: Silver" size="1" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right">
                                        License No.
                                    </td>
                                    <td colspan=2>
                                        <gw:textbox id="txtLicenseNo" styles='width:100%' />
                                    </td>
                                    <td style="white-space: nowrap" align="right">
                                    </td>
                                    <td >
                                    </td>
                                    <td align="right">
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right">
                                        License Date
                                    </td>
                                    <td colspan=2>
                                        <gw:datebox id="txtLicenseDate" lang="1" onchange="OnSearch()" nullaccept/>
                                    </td>
                                    <td style="white-space: nowrap" align="right">
                                    </td>
                                    <td >
                                    </td>
                                    <td  align="right">
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td colspan="6">
                                        <hr style="color: Silver" size="1" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space: nowrap" align="right">
                                        Basic Weight
                                    </td>
                                    <td colspan="2">
                                        <gw:textbox id="txtBasicWeight" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="white-space: nowrap" align="right">
                                        Average Weight
                                    </td>
                                    <td >
                                        <gw:textbox id="txtAverageWeight" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td  align="right">
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space: nowrap" align="right">
                                        <a href="#tips" onclick="OnPopUp('1')" style="text-decoration: none;
                                            color=#0000ff" title="Click here to select UOM"><b>Unit</b></a>
                                    </td>
                                    <td colspan="2">
                                        <gw:textbox id="txtBasicUnit" styles='width:100%' />
                                    </td>
                                    <td align="right">
                                        <a title="Click here to select UOM" href="#tips" style="text-decoration: none; color=#0000ff"
                                            onclick="OnPopUp('2')"><b>Unit</b></a>
                                    </td>
                                    <td >
                                        <gw:textbox id="txtAverageUnit" styles='width:100%' />
                                    </td>
                                    <td align="right">
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space: nowrap" align="right">
                                        Met Weight
                                    </td>
                                    <td colspan="2">
                                        <gw:textbox id="txtNetWeight" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td align="right">
                                    </td>
                                    <td >
                                        
                                    </td>
                                    <td  align="right">
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space: nowrap" align="right">
                                        <a href="#tips" onclick="OnPopUp('3')" style="text-decoration: none;
                                            color=#0000ff" title="Click here to select UOM"><b>Unit</b></a>
                                    </td>
                                    <td colspan="2">
                                        <gw:textbox id="txtNetUnit" styles='width:100%' />
                                    </td>
                                    <td align="right">
                                    </td>
                                    <td >
                                    </td>
                                    <td align="right">
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td colspan="6">
                                        <hr style="color: Silver" size="1" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space: nowrap" align="right">
                                        Weight Dev.
                                    </td>
                                    <td colspan="2">
                                        <gw:textbox id="txtWgtdevit" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="white-space: nowrap" align="right">
                                        Capsule Type
                                    </td>
                                    <td >
                                        <gw:textbox id="txtCapsuleType" styles='width:100%' />
                                    </td>
                                    <td  align="right">
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space: nowrap" align="right">
                                        Filling Range
                                    </td>
                                    <td colspan="2">
                                        <gw:textbox id="txtFillRange" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td align="right">
                                        Appearance
                                    </td>
                                    <td >
                                        <gw:textbox id="txtAppearance" styles='width:100%' />
                                    </td>
                                    <td align="right">
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td colspan="6">
                                        <hr style="color: Silver" size="1" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space: nowrap" align="right">
                                        <a href="#tips" onclick="OnPopUp('4')" style="text-decoration: none;
                                            color=#0000ff" title="Click here to select Color Cap"><b>Color Cap</b></a>
                                    </td>
                                    <td colspan="2">
                                        <gw:textbox id="txtCapColor" styles='width:100%' />
                                    </td>
                                    <td style="white-space: nowrap" align="right">
                                    </td>
                                    <td >
                                    </td>
                                    <td  align="right">
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="white-space: nowrap" align="right">
                                        <a href="#tips" onclick="OnPopUp('5')" style="text-decoration: none;
                                            color=#0000ff" title="Click here to select Color Body"><b>Body</b></a>
                                    </td>
                                    <td colspan="2">
                                        <gw:textbox id="lstBodyColor" styles='width:100%' />
                                    </td>
                                    <td align="right">
                                        <a href="#tips" onclick="OnPopUp('6')" style="text-decoration: none;
                                            color=#0000ff" title="Click here to select Employee"><b>Registered by</b></a>
                                    </td>
                                    <td >
                                        <gw:textbox id="txtChargerPK" styles='display:none;width:100%' />
                                        <gw:textbox id="txtChargerName" styles='width:100%' />
                                    </td>
                                    <td align="right">
                                    </td>
                                </tr>
                                <tr style="height: 91%">
                                    <td colspan="6">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------------->
<gw:textbox id="txtMasterPK" maxlen="100" styles='width:100%;display:none' />
<!---------------------------------------------------------------------------->
</html>
