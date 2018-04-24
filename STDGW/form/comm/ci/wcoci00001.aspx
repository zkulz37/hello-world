<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<% ESysLib.SetUser("comm")%>

<script>
 var flag;
 var gLeftWidth,gRightWidth;
 //---------------------------------------------------------
 function BodyInit()
 {
    onNew(0);
    BindingDataList();
    txtHScode.SetEnable(false);
    txtHsname.SetEnable(false);
    txtBS_id.SetEnable(false);
    txtBS_nm.SetEnable(false);
    txtAccCode.SetEnable(false);
	txtAccNM.SetEnable(false);
	gLeftWidth=document.all("left").clientWidth;
    gRightWidth=document.all("right").clientWidth;
    onSearch(0);
 }
 //---------------------------------------------------------
 function BindingDataList()
 {   
     var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, org_nm FROM TCO_ORGANIZATION where del_if=0")%>";   
     var data2 = "<%=ESysLib.SetListDataSQL("select  a.code, a.code_nm from comm.tco_abcode a, comm.tco_abcodegrp g  where a.tco_abcodegrp_pk = g.pk and g.id = 'COCI0030' and a.del_if = 0 order by a.code_nm")%>";   
     var data3 = "<%=ESysLib.SetListDataSQL("select pk, grp_cd || ' - ' || grp_nm from tco_itemgrp where del_if = 0 and leaf_yn = 'Y' ")%>";   
     var data4 = "<%=ESysLib.SetListDataSQL("select pk, wh_id || '-' || wh_name  from TIN_WAREHOUSE where del_if = 0 and use_yn='Y'")%>";
     var data5 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";
     
     cboOrganization.SetDataText(data1);
     cboUOM.SetDataText(data2);
     cboGroup.SetDataText(data3);
     cboWarehouse.SetDataText(data4);
     cboUOM_WT.SetDataText(data2);
     cboUOM_VOL.SetDataText(data2);
     cboUOM_DIM.SetDataText(data2);
     cboUOM_LOT.SetDataText(data2);
     cboCurrency.SetDataText(data5);
 }
 //---------------------------------------------------------
 function onSearch(index)
 {
    switch(index)
    {
        case 0:
             wcoci00001_2.Call("SELECT");
        break;
    }
  }
 //---------------------------------------------------------
 function onSave(index)
 {
    switch(index)
    {
        case 0: // save master
            if(Validate())
            {
               txttco_itemphoto_pk.SetDataText(imgItem.oid);
               wcoci00001_1.Call();
            }
        break;
       case 1:// save spec
        if(txtItemPk.GetData()!="")
        {
            for(i=1; i<grdItemSpec.rows; i++)
            {
                if(grdItemSpec.GetGridData(i,0)!="")
                {
                    grdItemSpec.SetRowStatus(i,0x10);
                    grdItemSpec.SetGridText(i,9,txtItemPk.GetData());
                }
                else
                {
                    grdItemSpec.SetRowStatus(i,0x20);
                    grdItemSpec.SetGridText(i,9,txtItemPk.GetData());
                }
                if(grdItemSpec.GetGridData(i,8)!="")
                {
                    wcoci00001_3.Call(); 
                }
                else
                {
                    wcoci00001_3.Call("SELECT"); 
                }    
            }
           
         }   
        break;
       
     }
 }
 //---------------------------------------------------------
 function onNew(index)
 {
    switch(index)
    {
        case 0: // add new master
             wcoci00001_1.StatusInsert();
             imgItem.SetDataText(txttco_itemphoto_pk.text );     
        break;
        case 1:// add new spec
            if(txtItemPk!="")
            {
                grdSpec.AddRow();
                grdSpec.SetGridText(grdSpec.rows - 1,1,txtItemPk.GetData());
            }
            else
            {
               alert("You should input and save master information first.");
               return;
            }
        break;
    }
 }
 //---------------------------------------------------------
 function onDelete(index)
 {
    switch(index)
    {
       case 0:// delete master
            if(confirm('Do you want to delete selected item ?'))
            {
                flag='Delete';
                wcoci00001_1.StatusDelete();
                wcoci00001_1.Call();
            }   
        break;
        case 1:// delete spec
            if(confirm('Do you want to delete selected spec ?'))
            {
                 grdSpec.DeleteRow();
                 idData_Dsql_wcodc00001_1.Call();
            }
        break;
     }        
 }
 //---------------------------------------------------------
 function loadBSDetail1()
 {
	var row  = grdItem.row;
	txtItemPk.text  = grdItem.GetGridData(row,0);
	flag='view';
	wcoci00001_1.StatusSelect();  
	wcoci00001_1.Call("SELECT");
}
 //---------------------------------------------------------
 function openPopup(index)
 {
	var fpath = '';
	switch(index)
	{
	    case 0:// HS code
	       fpath = System.RootURL + '/form/comm/ci/wcoci00001_1.aspx';
	        var aValue  = System.OpenModal(  fpath , 550 , 500 , 'resizable:yes;status:yes');
	        if ( aValue != null )
	        {      
	            txtHS_pk.SetDataText(aValue[1]);
	            txtHScode.SetDataText(aValue[2]);
	            txtHsname.SetDataText(aValue[3]);
	        }	
	    break;
	    case 1:// Business partner
	        fpath = System.RootURL + '/form/comm/ci/wcoci00001_2.aspx';
	        var aValue  = System.OpenModal(  fpath , 550 , 500 , 'resizable:yes;status:yes');
	        if ( aValue != null )
	        {      
	            txtBS_pk.SetDataText(aValue[0]);
	            txtBS_id.SetDataText(aValue[1]);
	            txtBS_nm.SetDataText(aValue[2]);
	        }	
	    break;
	    case 2:// Account code
	        fpath = System.RootURL + '/form/comm/ci/wcoci00001_3.aspx';
	        var aValue  = System.OpenModal(  fpath , 550 , 500 , 'resizable:yes;status:yes');
	        if ( aValue != null )
	        {      
	            txtAcc_pk.SetDataText(aValue[0]);
	            txtAccCode.SetDataText(aValue[1]);
	            txtAccNM.SetDataText(aValue[2]);
	        }	
	    break;
	}
}
 //---------------------------------------------------------
 function OnDataReceive(oId)
 {
    switch(oId.id)
    {
        case "wcoci00001_1":
             //wcoci00001_2.Call("SELECT");
             imgItem.SetDataText(txttco_itemphoto_pk.text );
             if(flag=='view')
             {
                wcoci00001_3.Call("SELECT");
             }
             onSave(1);
        break;
        case "wcoci00001_2":
             imgItem.SetDataText(txttco_itemphoto_pk.text );
             wcoci00001_3.Call("SELECT");
        break;
        case "wcoci00001_3":
            for(i=1;i<grdItemSpec.rows;i++)
		    {
			  grdItemSpec.SetGridText( i, 1, i); 
			} 
           
        break;
    }
 }
 //---------------------------------------------------------
 function Validate()
 {
    if(txtItemcode.GetData()=="")
    {
        alert("You should input item code first");
        txtItemcode.GetControl().focus();
        return false;
    }
    if(txtItemnm.GetData()=="")
    {
        alert("You should input item code first");
        txtItemnm.GetControl().focus();
        return false;
    }
    return true;
 }
 //---------------------------------------------------------
 function OnChangeGroup()
 {
    txtItemcode.text = cboGroup.GetText().split(' - ')[0]; 
    txtItemnm.text = cboGroup.GetText().split(' - ')[0];
    wcoci00001_3.Call("SELECT");
 }
 //---------------------------------------------------------
 function OnGridCellDoubleClick(p_oGrid)
{
   if (event.row > 0)
   {
      gPreviousRow=event.row;
      var queryString = "?pk="+grdItemSpec.GetGridData(gPreviousRow,10)
                             +"&spec_id="+grdItemSpec.GetGridData(gPreviousRow,5);
      GetSpec(queryString);                             
   }
}
//----------------------------------------------------------
function GetSpec(p_querystring)
{
   var fpath = System.RootURL + "/form/comm/ci/wcoci00001_4.aspx" + p_querystring;
	var aValue  = System.OpenModal(  fpath , 550 , 500 , 'resizable:yes;status:yes');	
	
	if (aValue!=null) 
	{	
		grdItemSpec.SetGridText(gPreviousRow,8 ,aValue[1]);//pk
		grdItemSpec.SetGridText(gPreviousRow,5 ,aValue[5]);//id
		grdItemSpec.SetGridText(gPreviousRow,6 ,aValue[6]);//name
		grdItemSpec.SetGridText(gPreviousRow,7 ,aValue[7]);//lname
		AutoMakeName();
	}
}
//---------------------------------------------------------
function AutoMakeName()
{
    var str = GetAllAttributes();
    AutoMakeCode();
}
//----------------------------------------------------------
function AutoMakeCode()
{
    var str = GetAllAttributesID();
    if (Trim(str)!="")
    {
		txtItemcode.text = txtItemcode.text = cboGroup.GetText().split(' - ')[0] + str;
    }
}
//----------------------------------------------------------
function GetAllAttributesID()
{
  var str="";
  for(var i=1;i<grdItemSpec.rows;i++)
  {   
    if (grdItemSpec.GetGridData(i,12) == "Y")
    {
        if(Trim(grdItemSpec.GetGridData(i,5))!="")
        {
          str = str + grdItemSpec.GetGridData(i,5);
        }
    }
  }
  return str;
}
//----------------------------------------------------------
function GetAllAttributes()
{
  var str="";
  
  CheckAttributeFormat();
  
  for(var i=1;i<grdItemSpec.rows;i++)
  {
    if(Trim(grdItemSpec.GetGridData(i,6))!="")
    {
      str = str + grdItemSpec.GetGridData(i,6)+ " ";
    }
    else if(Trim(grdItemSpec.GetGridData(i,5))!="")
    {
      str = str + grdItemSpec.GetGridData(i,5)+ " "; //for new item spec , if user doesn't input the name of item spec
    }
  }
  return str;
}
//----------------------------------------------------------
function CheckAttributeFormat()
{ 
  var str = new String();
  for(var i=1;i<grdItemSpec.rows;i++)
  {
    str = Trim(grdItemSpec.GetGridData(i,6));
    if(Trim(grdItemSpec.GetGridData(i,2)) == "WIDTH" && str.substr(str.length-1,1)!="*")
    {
      grdItemSpec.SetGridText(i,6,Trim(grdItemSpec.GetGridData(i,6))+"*");
      return;
    }
  }
}
//----------------------------------------------------------
function OnCheckTab()
{
     wcoci00001_3.Call("SELECT");
}
 //---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand"){
        left.style.display="none";
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../images/right-arrow.ico";
    }
    else{
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="80%";
        imgArrow.src = "../../../images/left-arrow.ico";
    }
 }
 //---------------------------------------------------------
 function OnResize()
 {    
     var offsetLeftTable  = document.all("tableID1").offsetLeft;    
     var offsetLeftCell   = document.all("left").offsetLeft;    
     var leftDistant = (document.all("left").clientWidth + offsetLeftTable + offsetLeftCell);	
     var n = Math.abs(window.event.clientX - leftDistant);	
     
     if(n<15){		
        document.body.style.cursor = "col-resize" ;	
     }
     else{		
        document.body.style.cursor = "auto" ;	
     }		
     
     if((window.event.button == 1)&& n < 30){	
        document.all("left").width = window.event.clientX-(offsetLeftTable + 2*offsetLeftCell);		
        var LeftWidthNew = document.all("left").clientWidth;	
        var delTa = gLeftWidth-LeftWidthNew;
        document.all("right").width = gRightWidth + delTa;	
     }
 }
</script>

<body>
    <gw:data id="wcoci00001_1" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59" function="comm.sp_get_item"  procedure="comm.sp_tco_item_entry"> 
            <inout> 
                 <inout  bind="txtItemPk" />
                 <inout  bind="cboOrganization" />
                 <inout  bind="cboGroup" />
                 <inout  bind="txtItemcode" />
                 <inout  bind="txtItemnm" />
                 <inout  bind="txtItemnm_LC" />
                 <inout  bind="txtItemnm_FR" />
                 <inout  bind="cboUOM" />
                 <inout  bind="cboUOM_WT" />
                 <inout  bind="cboUOM_VOL" />
                 <inout  bind="cboUOM_DIM" />
                 <inout  bind="cbouom_sur" />
                 <inout  bind="cboUOM_LOT" />
                 <inout  bind="chkSet" />
                 <inout  bind="chkpict_yn" />
                 <inout  bind="chkBOM" />
                 <inout  bind="cboBOMItemType" />
                 <inout  bind="chkCosting" />
                 <inout  bind="chkContainer" />
                 <inout  bind="chkVehicle" />
                 <inout  bind="chkIsInventory" />
                 <inout  bind="chkEquipment" />
                 <inout  bind="chkOutsourcing" />
                 <inout  bind="chkMAT_STG_YN" />
                 <inout  bind="chkSHELFLIFE_CTRL" />
                 <inout  bind="txtshelf_life_days" />
                 <inout  bind="chkLOT_CTRL_YN" />
                 <inout  bind="txtLOT_START_PREFIX" />
                 <inout  bind="txtLOT_START_NUMBER" />
                 <inout  bind="chkSERIAL_CRTL_YN" />
                 <inout  bind="txtSERIAL_START_PREFIX" />
                 <inout  bind="txtSERIAL_START_NUMBER" />
                 <inout  bind="txtHS_pk" />
                 <inout  bind="txtAcc_pk" />
                 <inout  bind="txtBS_pk" />
                 <inout  bind="cboPur_type" />
                 <inout  bind="cboWarehouse" />
                 <inout  bind="txttco_itemphoto_pk" />
                 <inout  bind="txttpr_stitem_pk" />
                 <inout  bind="txtWeight" />
                 <inout  bind="txtSurface" />
                 <inout  bind="txtItem_length" />
                 <inout  bind="txtItem_width" />
                 <inout  bind="txtItem_height" />
                 <inout  bind="txtU_price" />
                 <inout  bind="txtLot_qty" />
                 <inout  bind="txtLot_weight" />
                 <inout  bind="cboCurrency" />
                 <inout  bind="txtList_price" />
                 <inout  bind="txtStdPrice" />
                 <inout  bind="txtLimit_price" />
                 <inout  bind="txtMart_price" />
                 <inout  bind="txtDesc" />
                 <inout  bind="chkActive" />
                 <inout  bind="dtbFrom" />
                 <inout  bind="dtbTo" />
                 <inout  bind="txtMin_order_qty" />
                 <inout  bind="chkIsPurchased" />
                 <inout  bind="cbocont_type" />
                 <inout  bind="txtVolume" />   
                 <inout  bind="txtHScode" />   
                 <inout  bind="txtHsname" />   
                 <inout  bind="txtBS_id" />   
                 <inout  bind="txtBS_nm" />   
                 <inout  bind="txtAccCode" />   
                 <inout  bind="txtAccNM" />         
            </inout>
        </dso> 
    </xml> 
</gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="wcoci00001_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1" function="comm.sp_search_item" > 
                <input> 
                    <input bind="txtItemQuery" /> 
                    <input bind="txtGroupQuery" /> 
                </input> 
                <output bind="grdItem" /> 
            </dso> 
        </xml> 
</gw:data>
    <!-----------------grdSpec ---------------------------------------->
    <gw:data id="wcoci00001_3" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" user="comm" parameter="0,4,8,9"  function="comm.sp_get_itemgroup_spec"  procedure="comm.sp_tco_itemspec_entry"> 
              <input  bind="grdItemSpec">
                    <input bind="cboGroup" /> 
                    <input bind="txtItemPk" /> 
                </input> 
                <output bind="grdItemSpec" /> 
            </dso> 
        </xml> 
</gw:data>
    <!-------------------------------------------------------------------->
    <table width="100%" border="1" id="tableID1">
        <tr valign="top">
            <td id="left" width="20%" onmousemove="OnResize()">
                <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr valign="center">
                        <td width="10%">
                            <b>&nbsp;Group</b></td>
                        <td width="20%">
                            <gw:textbox id="txtGroupQuery" csstype="filter" onenterkey="onSearch(0)" />
                        </td>
                        <td width="3%" align="right">
                        </td>
                    </tr>
                    <tr valign="center">
                        <td width="10%">
                            <b>&nbsp;Item</b></td>
                        <td width="20%">
                            <gw:textbox id="txtItemQuery" csstype="filter" onenterkey="onSearch(0)" />
                        </td>
                        <td width="3%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch(0)" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="100%">
                                        <gw:grid id="grdItem" header="_PK|Code|Name" format="0|0|0" aligns="0|0|0" defaults="||"
                                            editcol="1|1|1" widths="0|0|1200" styles="width:100%; height:420" sorting="T"
                                            param="0,1,2" oncellclick="loadBSDetail1()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" width="80%" onmousemove="OnResize()">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td width="23%" valign="middle">
                                        <b>&nbsp;&nbsp;&nbsp; Organization</b></td>
                                    <td width="30%" align="left">
                                        <gw:list id="cboOrganization" styles="width:100%;"></gw:list>
                                    </td>
                                    <td width="42%">
                                    </td>
                                    <td width="1%" align="right" style="height: 19px">
                                        <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onNew(0)" />
                                    </td>
                                    <td width="1%" style="height: 19px">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(0)" />
                                    </td>
                                    <td width="1%" style="height: 19px">
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="onDelete(0)" />
                                    </td>
                                    <!--td width="1%" style="height: 19px"><gw:imgbtn id="btnPrint" img="printer" alt="Print" text="Print" onclick="" /></td-->
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%">
                                <tr valign="top">
                                    <td valign="top">
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td colspan="4" width="70%">
                                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                        <tr valign="top">
                                                            <td width="30%" valign="middle">
                                                                <b>&nbsp;&nbsp;&nbsp; Group</b></td>
                                                            <td width="70%" colspan="3">
                                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="20%">
                                                                            <gw:list id="cboGroup" styles="width:100%;" onchange="OnChangeGroup()"></gw:list>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr valign="top">
                                                            <td width="30%" valign="middle">
                                                                <b>&nbsp;&nbsp;&nbsp; Item code</b>
                                                            </td>
                                                            <td width="70%" colspan="3">
                                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="20%">
                                                                            <gw:textbox id="txtItemcode" csstype="mandatory" styles="width:100%;" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr valign="top">
                                                            <td width="30%" valign="middle">
                                                                <b>&nbsp;&nbsp;&nbsp; Item name</b>
                                                            </td>
                                                            <td width="70%" colspan="3">
                                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="20%">
                                                                            <gw:textbox id="txtItemnm" csstype="mandatory" styles="width:100%;" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr valign="top">
                                                            <td width="30%" valign="middle">
                                                                <b>&nbsp;&nbsp;&nbsp; Item Name LC</b>
                                                            </td>
                                                            <td width="70%" colspan="3">
                                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="20%">
                                                                            <gw:textbox id="txtItemnm_LC" styles="width:100%;" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr valign="top">
                                                            <td width="30%" valign="middle">
                                                                <b>&nbsp;&nbsp;&nbsp; Item Name FR</b>
                                                            </td>
                                                            <td width="70%" colspan="3">
                                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="20%">
                                                                            <gw:textbox id="txtItemnm_FR" styles="width:100%;" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr valign="top">
                                                            <td width="30%" valign="middle">
                                                                <b>&nbsp;&nbsp;&nbsp; Description</b>
                                                            </td>
                                                            <td width="70%" colspan="3">
                                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="20%">
                                                                            <gw:textbox id="txtDesc" styles="width:100%;" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr valign="top">
                                                            <td width="30%" valign="middle">
                                                                <b>&nbsp;&nbsp;&nbsp; Warehouse</b>
                                                            </td>
                                                            <td width="70%" colspan="3">
                                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="20%">
                                                                            <gw:list id="cboWarehouse" styles="width:100%;"></gw:list>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td rowspan="7" valign="top" width="30%">
                                                    <gw:image id="imgItem" table_name="TCO_ITEMPHOTO" oid="0" view="/binary/ViewFile.aspx"
                                                        post="/binary/PostFile.aspx" styles="width:280;height:150" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" height="2">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" height="1" bgcolor="#999999">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" width="100%">
                                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <gw:tab id="idTab" onpageactivate="return OnCheckTab()" style="width: 100%; height: 220;
                                                                    border1px">
					                <!--onpageactivate="showActiveTab()"-->
					                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="General Info" id="TabGeneralInfo" align="top"
						                style="overflow:scroll">
						                <tr>
						                    <td width=100%>
						                        <table width="100%" cellpadding="0" cellspacing="2" border=0>
						                            <tr>
			                                            <td colspan="5" height="2" ></td>
		                                            </tr>
		                                            <tr>
			                                            <td colspan="6" height="1" bgcolor="#999999"></td>
		                                            </tr>
		                                            <tr>
		                                                 <td width=30% valign=Top>
		                                                     <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                          <tr>
								                                    <td width=100% colspan=2>
	                                                                    <fieldset style="padding: 5">
                                                                          <legend><font color="black"  ><b>Unit of Measure</b></font></legend>
                                                                              <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                                         <tr>
	                                                                               <td width=100%><gw:list id="cboUOM"   styles="width:100%;" ></gw:list></td>
	                                                                              </tr>
									                                         </table>
                                                                      </fieldset>
	                                                                </td>
									                              </tr>
								                                <tr>
								                                    <td width=100% colspan=2>
	                                                                    <fieldset style="padding: 5">
	                                                                   <legend><font color="black"  ><a title="Click here to select HS code" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;&nbsp;HS Code</b></a></font></legend>
                                                                              <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                                         <tr>
	                                                                               <td width=30%><gw:textbox id="txtHScode"   styles="width:100%;" /><gw:textbox id="txtHS_pk"   styles="width:100%;display:none" /></td>
	                                                                               <td width=70%><gw:textbox id="txtHsname"   styles="width:100%;" /></td>
	                                                                              </tr>
									                                        </table>
                                                                      </fieldset>
	                                                                </td>
									                              </tr>
								                            </table>
                                                          </td>
                                                         <td width=5% valign=Top></td>   
		                                                 <td width=60% valign=Top>
		                                                    <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                          <tr>
								                                    <td width=100% colspan=2>
	                                                                    <fieldset style="padding: 5">
                                                                          <legend><font color="black"> <a title="Click here to select business partner" onclick="openPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Business partner</b></a></font></legend>
                                                                              <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                                         <tr>
	                                                                               <td width=20%><gw:textbox id="txtBS_id"   styles="width:100%;" /><gw:textbox id="txtBS_pk"   styles="width:100%;display:none" /></td>
	                                                                               <td width=80%><gw:textbox id="txtBS_nm"   styles="width:100%;" /></td>
	                                                                              </tr>
									                                        </table>
                                                                      </fieldset>
	                                                                </td>
									                             </tr>
								                                <tr>
								                                    <td width=100% colspan=2>
	                                                                    <fieldset style="padding: 5">
                                                                          <legend><font color="black"  ><a title="Click here to select account code" onclick="openPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Account code</b></a></font></legend>
                                                                              <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                                         <tr>
	                                                                               <td width=20%><gw:textbox id="txtAccCode"   styles="width:100%;" /><gw:textbox id="txtAcc_pk"   styles="width:100%;display:none" /></td>
	                                                                               <td width=80%><gw:textbox id="txtAccNM"   styles="width:100%;" /></td>
	                                                                              </tr>
									                                        </table>
                                                                      </fieldset>
	                                                                </td>
									                              </tr>
	                                                           <tr>
	                                                                <td width=100% colspan=2>
	                                                                    <fieldset style="padding: 5">
                                                                          <legend><font color="black"  ><b>Item status</b></font></legend>
                                                                              <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                                         <tr>
	                                                                               <td width=15%>Active</td>
	                                                                               <td width=1% align=left><gw:checkbox id="chkActive" defaultvalue="Y|N" value="Y" /></td>
	                                                                                <td width=84% colspan=3 align=right><b> &nbsp;</b></td>
									                                             </tr>
									                                            <tr>
	                                                                                <td width=15% align=left> From&nbsp;</td>
									                                                <td width=10%><gw:datebox id="dtbFrom"  lang="<%=Application("Lang")%>" mode="01"	onchange="" /></td>
									                                                <td width=5% align=center><b>~</b></td>
									                                                <td width=10%><gw:datebox id="dtbTo" nullaccept lang="<%=Application("Lang")%>" mode="01"	onchange="" /></td>
									                                                <td width=60% colspan=1 align=right><b> &nbsp;</b></td>
									                                            </tr>
                                                                            </table>
                                                                      </fieldset>
	                                                                </td>
	                                                            </tr>
								                              </table>
		                                                 </td>
		                                              </tr>    
									             </table>
						                    </td>
						                </tr>
						            </table>
					                 <table width="100%" border="0" cellpadding="0" cellspacing="0" name="Inventory" id="Inventory" align="top"  style="overflow:scroll">
						                <tr>
						                    <td width=100%>
						                        <table width="100%" cellpadding="0" cellspacing="2" border=0>
						                            <tr>
			                                            <td colspan="5" height="2" ></td>
		                                            </tr>
		                                            <tr>
			                                            <td colspan="6" height="1" bgcolor="#999999"></td>
		                                            </tr>
		                                           <tr>
		                                             <td colspan=3 width=100%>
		                                                <table width=100% cellpadding=0 cellspacing=0 border=0>
		                                                    <tr>
		                                                        
			                                                    <td  width=9% align=left><b>&nbsp;&nbsp;&nbsp;Inventory</b></td>
			                                                    <td width=2% align=left><gw:checkbox id="chkIsInventory" defaultvalue="Y|N" value="N" /></td>
			                                                     <td width=90% align=left></td>
		                                                    </tr>
		                                                    <tr>
		                                                        <td  width=9% align=left><b>&nbsp;&nbsp;&nbsp;Shortage</b></td>
			                                                    <td width=2% align=left><gw:checkbox id="chkMAT_STG_YN" defaultvalue="Y|N" value="N" /></td>
			                                                     <td width=90% align=left></td>
		                                                    </tr>
		                                                     <tr>
		                                                        <td colspan="3" height="5" bgcolor=""></td>
		                                                    </tr>
		                                                </table>
		                                             </td>
			                                        </tr>
		                                            <tr>
		                                                 <td width=30% valign=Top>
		                                                    <fieldset style="padding: 10">
                                                              <legend> <font color="black" size="2"><b>Lot Expiration (Shelf Life)</b></font></legend>
                                                             <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                         <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Control</td>
	                                                                <td width=2% colspan=1 align=left><gw:checkbox id="chkSHELFLIFE_CTRL" defaultvalue="Y|N" value="N" /></td>
									                            </tr>
                                                                <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Shelf Life Days</td>
	                                                                <td width=50% colspan=1><gw:textbox id="txtshelf_life_days" styles="width:100%;" /></td>
	                                                            </tr>
	                                                         </table>
                                                           </fieldset>
                                                         </td>
		                                                <td width=2%></td>
						                                 <td width=30% valign=Top></td>
		                                                  <td width=38% valign=Top></td>
		                                             </tr>    
									                 <tr>
			                                            <td colspan="6" height="4" bgcolor=""></td>
		                                            </tr>
		                                            <tr>
		                                                
		                                                 <td width=30% valign=Top>
		                                                    <fieldset style="padding: 10">
                                                              <legend> <font color="black" size="2"><b>Lot </b></font></legend>
                                                              <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                        <tr>
	                                                              <td width=50%>&nbsp; &nbsp;Control</td>
	                                                              <td width=2% colspan=1><gw:checkbox id="chkLOT_CTRL_YN" defaultvalue="Y|N" value="N" /></td>
									                            </tr>
                                                                <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Starting Prefix</td>
	                                                                <td width=50% colspan=1><gw:textbox id="txtLOT_START_PREFIX" styles="width:100%;" /></td>
									                            </tr>
									                             <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Starting Number</td>
	                                                                <td width=50% colspan=1><gw:textbox id="txtLOT_START_NUMBER" styles="width:100%;" /></td>
									                            </tr>
								                             </table>
                                                           </fieldset>
                                                         </td>
		                                                <td width=2%></td>
						                                 <td width=30% valign=Top>
		                                                     <fieldset style="padding: 10">
                                                              <legend> <font color="black" size="2"><b>Serial </b></font></legend>
                                                                <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                            <tr>
	                                                                    <td width=50%>&nbsp; &nbsp;Serial control</td>
	                                                                    <td width=2% colspan=1><gw:checkbox id="chkSERIAL_CRTL_YN" defaultvalue="Y|N" value="N" /></td>
									                                </tr>
                                                                    <tr>
	                                                                    <td width=50%>&nbsp; &nbsp;Starting Prefix</td>
	                                                                    <td width=50% colspan=1><gw:textbox id="txtSERIAL_START_PREFIX" styles="width:100%;" /></td>
									                                </tr>
									                                 <tr>
	                                                                    <td width=50%>&nbsp; &nbsp;Starting Number</td>
	                                                                    <td width=50% colspan=1><gw:textbox id="txtSERIAL_START_NUMBER" styles="width:100%;" /></td>
									                                </tr>
								                              </table>
                                                              </fieldset>
		                                                 </td>
		                                                 <td width=38%></td>
		                                             </tr> 
		                                              <tr>
			                                            <td colspan="6" height="4" bgcolor=""></td>
		                                            </tr>
								                </table>
						                    </td>
						                   
						                </tr>
						            </table>
						             <table width="100%" border="0" cellpadding="0" cellspacing="0" name="Bills of Material " id="BOM" align="top"  style="overflow:scroll">
						                <tr>
						                    <td width=100%>
						                        <table width="100%" cellpadding="0" cellspacing="2" border=0>
						                            <tr>
			                                            <td colspan="5" height="2" ></td>
		                                            </tr>
		                                            <tr>
			                                            <td colspan="6" height="1" bgcolor="#999999"></td>
		                                            </tr>
		                                           <tr>
		                                             <td colspan=3 width=100%>
		                                                <table width=100% cellpadding=0 cellspacing=0 border=0>
		                                                    <tr>
		                                                        <td  width=15% align=left><b>&nbsp;&nbsp;&nbsp;BOM Allowed</b></td>
			                                                    <td width=2% align=left><gw:checkbox id="chkBOM" defaultvalue="Y|N" value="N" /></td>
			                                                    <td width=80% align=left></td>
		                                                    </tr>
		                                                    <tr>
		                                                        <td  width=15% align=left><b>&nbsp;&nbsp;&nbsp;BOM Item Type</b></td>
			                                                    <td width=85% colspan=2 align=left><gw:list id="cboBOMItemType" styles="width:30%"></gw:list> </td>
			                                                </tr>
		                                                </table>
		                                             </td>
			                                        </tr>
		                                         </table>  
						                   </td>
						                </tr>
						            </table>
						            <table width="100%" border="0" cellpadding="0" cellspacing="0" name="Costing" id="Costing" align="top"  style="overflow:scroll">
						                <tr>
						                    <td width=100%>
						                        <table width="100%" cellpadding="0" cellspacing="2" border=0>
						                            <tr>
			                                            <td colspan="5" height="2" ></td>
		                                            </tr>
		                                            <tr>
			                                            <td colspan="6" height="1" bgcolor="#999999"></td>
		                                            </tr>
		                                           <tr>
		                                             <td colspan=3 width=100%>
		                                                <table width=100% cellpadding=0 cellspacing=0 border=0>
		                                                    <tr>
		                                                        <td  width=15% align=left><b>&nbsp;&nbsp;&nbsp;Costing Enabled</b></td>
			                                                    <td width=2% align=left><gw:checkbox id="chkCosting" defaultvalue="Y|N" value="N" /></td>
			                                                    <td width=80% align=left></td>
		                                                    </tr>
		                                                 </table>
		                                             </td>
			                                        </tr>
		                                         </table>  
						                   </td>
						                </tr>
						            </table>
						            <table width="100%" border="0" cellpadding="0" cellspacing="0" name="Purchasing" id="Purchasing" align="top"  style="overflow:scroll">
						                <tr>
						                    <td width=100%>
						                        <table width="100%" cellpadding="0" cellspacing="2" border=0>
						                            <tr>
			                                            <td colspan="5" height="2" ></td>
		                                            </tr>
		                                            <tr>
			                                            <td colspan="6" height="1" bgcolor="#999999"></td>
		                                            </tr>
		                                           <tr>
		                                             <td colspan=3 width=100%>
		                                                <table width=100% cellpadding=0 cellspacing=0 border=0>
		                                                    <tr>
		                                                      <td  width=19% align=left><b>&nbsp;&nbsp;&nbsp;Purchased</b></td>
			                                                  <td width=2% align=left><gw:checkbox id="chkIsPurchased" defaultvalue="Y|N" value="N" /></td>
			                                                  <td width=79% align=left></td>
		                                                    </tr>
		                                                    <tr>
		                                                      <td  width=20% align=left><b>&nbsp;&nbsp;&nbsp;Purchased type</b></td>
			                                                  <td width=30% align=left><gw:list id="cboPur_type" styles="width:100%" /></td>
			                                                  <td width=50% align=left></td>
		                                                    </tr>
		                                                    <tr>
		                                                        <td colspan="3" height="5" bgcolor=""></td>
		                                                    </tr>
		                                                </table>
		                                             </td>
			                                        </tr>
		                                           <tr>
		                                                 <td width=30% valign=Top>
		                                                    <fieldset style="padding: 10">
                                                              <legend> <font color="black" size="2"><b>Price</b></font></legend>
                                                              <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                        <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Currency</td>
	                                                                <td width=50% colspan=1><gw:list id="cboCurrency" styles="width:100%;"></gw:list></td>
									                            </tr>
									                            <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Unit price</td>
	                                                                <td width=50% colspan=1><gw:textbox id="txtU_price" styles="width:100%;" /></gw:list></td>
									                            </tr>
                                                                <tr>
	                                                                <td width=50%>&nbsp; &nbsp;List price</td>
	                                                                <td width=50% colspan=1><gw:textbox id="txtList_price" styles="width:100%;" /></gw:list></td>
									                            </tr>
								                                <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Standard price</td>
	                                                                <td width=50% colspan=1><gw:textbox id="txtStdPrice" styles="width:100%;" /></gw:list></td>
									                            </tr>
									                            <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Price limit</td>
	                                                                <td width=50% colspan=1><gw:textbox id="txtLimit_price" styles="width:100%;" /></gw:list></td>
									                            </tr>
									                             <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Market price</td>
	                                                                <td width=50% colspan=1><gw:textbox id="txtMart_price" styles="width:100%;" /></gw:list></td>
									                            </tr>
									                        </table>
                                                           </fieldset>
                                                          </td>
		                                                <td width=2%></td>
						                                 <td width=30% valign=Top>
		                                                     <fieldset style="padding: 10">
                                                              <legend> <font color="black" size="2"><b>Misc </b></font></legend>
                                                              <table width=100% cellpadding=0 cellspacing=1 border=0>
		                                                        <tr>
	                                                                <td width=50%>&nbsp; &nbsp;Minimum Order Qty</td>
	                                                                <td width=50% colspan=1><gw:textbox id="txtMin_order_qty" styles="width:100%;" /></td>
									                            </tr>
                                                             </table>
                                                              </fieldset>
		                                                 </td>
		                                                  <td width=38% valign=Top></td>
		                                             </tr>    
									             </table>
						                    </td>
						                   
						                </tr>
						            </table>
						            <table width="100%" border="0" cellpadding="0" cellspacing="0" name="Physical Attribute" id="Physical_Attribute" align="top"  style="overflow:scroll">
						                <tr>
						                    <td width=100%>
						                      										<table width="100%" cellpadding="0" cellspacing="2" border="0">
                                              <tr>
                                                <td colspan="4" height="2"></td>
                                              </tr>
                                              <tr>
                                                <td colspan="4" height="1" bgcolor="#999999"></td>
                                              </tr>
                                              <tr>
                                                <td width="30%" valign="Top"><fieldset style="padding: 2">
                                                    <legend><font color="black" size="2"><b>Weight</b></font></legend>
                                                        <table width="100%" cellpadding="0" cellspacing="1" border="0">
                                                          <tr>
                                                            <td width="50%">&nbsp;&nbsp; Unit of Measure</td>
                                                            <td width="50%" colspan="1"><gw:list id="cboUOM_WT" styles="width:100%;"></gw:list></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="50%">&nbsp;&nbsp; Unit Weight</td>
                                                            <td width="50%" colspan="1"><gw:textbox id="txtWeight" styles="width:100%;" /></td>
                                                          </tr>
                                                       </table>
                                                    </fieldset> 
                                                </td>
                                                <td width="2%"></td>
                                                <td width="30%" valign="Top" rowspan="3"><fieldset style="padding: 2">
                                                <legend><font color="black" size="2"><b>Surface</b></font></legend>
                                                <table width="100%" cellpadding="1" cellspacing="3" border="0">
                                                   <tr>
                                                    <td width="49%">&nbsp;&nbsp; Unit of Measure</td>
                                                    <td width="61%" colspan="3"><gw:list id="cbouom_sur" styles="width:100%;"></gw:list></td>
                                                  </tr>  
                                                  <tr>
                                                    <td width="49%">&nbsp;&nbsp; Surface</td>
                                                    <td width="61%" colspan="1"><gw:textbox id="txtSurface" styles="width:100%;" /></td>
                                                   
                                                  </tr>
                                                 
                                                </table>
                                                </fieldset> <fieldset style="padding: 2">
                                                <legend><font color="black" size="2"><b>Type </b></font></legend>
                                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                                  <tr>
                                                    <td width="50%">&nbsp;&nbsp; Equipment</td>
                                                    <td width="2%" colspan="1" align=left><gw:checkbox id="chkEquipment" defaultvalue="Y|N" value="N" /></td>
                                                  </tr>
                                                   <tr>
                                                    <td width="50%">&nbsp;&nbsp; Set Y/N</td>
                                                    <td width="2%" colspan="1" align=left><gw:checkbox id="chkSet" defaultvalue="Y|N" value="N" /></td>
                                                  </tr>
                                                   <tr>
                                                    <td width="50%">&nbsp;&nbsp;Outsourcing Y/N</td>
                                                    <td width="2%" colspan="1" align=left><gw:checkbox id="chkOutsourcing"defaultvalue="Y|N" value="N" /></td>
                                                  </tr>
                                                </table>
                                                </fieldset><fieldset style="padding: 2">
                                                <legend><font color="black" size="2"><b>Lot </b></font></legend>
                                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                                  <tr>
                                                    <td width="50%">&nbsp;&nbsp;Unit of Measure</td>
                                                    <td width="50%" colspan="1" align=left><gw:list id="cboUOM_LOT" styles="width:100%" /></td>
                                                  </tr>
                                                   <tr>
                                                    <td width="50%">&nbsp;&nbsp;Quantity</td>
                                                    <td width="50%" colspan="1" align=left><gw:textbox id="txtLot_qty" styles="width:100%" /></td>
                                                  </tr>
                                                   <tr>
                                                    <td width="50%">&nbsp;&nbsp; Weight</td>
                                                    <td width="50%" colspan="1" align=left><gw:textbox id="txtLot_weight" styles="width:100%" /></td>
                                                  </tr>
                                                </table>
                                                </fieldset></td>
                                                <td width="38%" valign="Top"><fieldset style="padding: 2">
                                                <legend><font color="black" size="2"><b>Container </b></font></legend>
                                                <table width="100%" cellpadding="1" cellspacing="3" border="0">
                                                  <tr>
                                                    <td width="49%">&nbsp;&nbsp; Container</td>
                                                    <td width="2%" colspan="1">
                                                    <gw:checkbox id="chkContainer" defaultvalue="Y|N" value="N" /></td>
                                                    <td width="49%">&nbsp;&nbsp; Vehicle</td>
                                                    <td width="2%" colspan="1">
                                                    <gw:checkbox id="chkVehicle" defaultvalue="Y|N" value="N" /></td>
                                                  </tr>
                                                  <tr>
                                                    <td width="49%">&nbsp;&nbsp; Container type</td>
                                                    <td width="61%" colspan="3">
                                                    <gw:list id="cbocont_type" styles="width:100%;"></gw:list></td>
                                                  </tr>
                                                </table>
                                                </fieldset></td>
                                              </tr>
                                              <tr>
                                                <td width="30%" valign="Top"><fieldset style="padding: 2">
                                                <legend><font color="black" size="2"><b>Volume </b></font></legend>
                                                <table width="100%" cellpadding="0" cellspacing="1" border="0">
                                                  <tr>
                                                    <td width="50%">&nbsp;&nbsp; Unit of Measure</td>
                                                    <td width="50%" colspan="1"><gw:list id="cboUOM_VOL" styles="width:100%;"></gw:list></td>
                                                  </tr>
                                                  <tr>
                                                    <td width="50%">&nbsp;&nbsp; Unit Volume</td>
                                                    <td width="50%" colspan="1"><gw:textbox id="txtVolume" styles="width:100%;" /></td>
                                                  </tr>
                                                </table>
                                                </fieldset> </td>
                                                <td width="2%"></td>
                                                <td width="38%"></td>
                                              </tr>
                                              <tr>
                                                <td width="30%" valign="Top"><fieldset style="padding: 2">
                                                <legend><font color="black" size="2"><b>Dimentions </b></font></legend>
                                                <table width="100%" cellpadding="0" cellspacing="1" border="0">
                                                  <tr>
                                                    <td width="50%">&nbsp;&nbsp; Unit of Measure</td>
                                                    <td width="50%" colspan="1"><gw:list id="cboUOM_DIM" styles="width:100%;"></gw:list></td>
                                                  </tr>
                                                  <tr>
                                                    <td width="50%">&nbsp;&nbsp; Lenght</td>
                                                    <td width="50%" colspan="1"><gw:textbox id="txtItem_length" styles="width:100%;" /></td>
                                                  </tr>
                                                  <tr>
                                                    <td width="50%">&nbsp;&nbsp; Width</td>
                                                    <td width="50%" colspan="1"><gw:textbox id="txtItem_width" styles="width:100%;" /></td>
                                                  </tr>
                                                  <tr>
                                                    <td width="50%">&nbsp;&nbsp; Height</td>
                                                    <td width="50%" colspan="1"><gw:textbox id="txtItem_height" styles="width:100%;" /></td>
                                                  </tr>
                                                </table>
                                                </fieldset> </td>
                                                <td width="2%"></td>
                                                <td width="30%" valign="Top"></td>
                                                <td width="38%"></td>
                                              </tr>
                                            </table>
                                            </td>
						                </tr>
						                </table>
						            <table width="100%" border="0" cellpadding="1" cellspacing="0"
						                name="Spec" id="Spec" align="top"
						                style="overflow:scroll">
						                <tr>
                                            <td colspan="5" height="2" ></td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" height="1" bgcolor="#999999"></td>
                                        </tr>
						                <tr>
										<td width="90%" align="right">
										
										</td>
										
										<td width="4%" align="right"><!--gw:imgBtn id="btnNewCharger" img="new" alt="New" text="New"
												onclick="onNew(1)" /-->
										</td>
										<td width="3%">
											<!--gw:imgBtn id="btnDeleteCharger" img="delete" alt="Delete"
												text="Delete" onclick="onDelete(1)" /-->
										</td>
										<!--td width="3%">
											<gw:imgBtn id="btnUnDeleteCharger" img="udelete" alt="UnDelete"
												text="UnDelete" onclick="" />
										</td-->
										<td width="4%">
											<!--gw:imgBtn id="btnSaveCharger" img="save" alt="Save"
												text="Save" onclick="onSave(1)" /-->
										</td>
									</tr>
						                <tr>
						                    <td colspan =6>
						                          <gw:grid
                                                    id="grdItemSpec"
                                                    header="_pk|No|specgrp_nm|specgrp_lnm|Active|spec_id|spec_name|spec_lnm|_tco_cispec_pk|_tco_ciitem_pk|_tco_cispecgrp_pk|_mandatory|_idauto_yn"
                                                    format="0|0|0|0|3|0|0|0|0|0|0|3|0"
                                                    aligns="1|0|0|0|0|0|0|0|0|0|0|0|0"
                                                    defaults="||||||||||||"
                                                    editcol="0|0|0|1|1|1|1|0|0|0|0|0|0"
                                                    widths="0|600|1500|1500|800|1500|1500|1500|0|0|0|1000|0"
                                                    styles="width:100%; height:160"
                                                    sorting="F"
                                                    onafteredit="OnGridCellAfterEdit(this)"
                                                    oncelldblclick="OnGridCellDoubleClick(this)"
                                                    param="0,1,2,3,4,5,6,7,8,9,10,11,12"  />
						                    </td>
						                </tr>
						            </table>
						           
						        </gw:tab>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:grid id="grdSpec" header="pk|spec_id|spec_nm|spec_lnm" format="0|0|0|0" aligns="0|0|0|0"
        defaults="|||" editcol="1|1|1|1" widths="0|0|0|0" styles="width:100%; height:200;display:none"
        sorting="F" param="0,1,2,3" />
    <gw:textbox id="txttpr_stitem_pk" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:textbox id="txttco_itemphoto_pk" maxlen="100" styles='width:100%;display:none'
        csstype="" />
    <gw:textbox id="txtItemPk" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:textbox id="txtParentPk" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:checkbox id="chkpict_yn" defaultvalue="Y|N" value="N" styles='width:100%;display:none' />
    <img status="expand" id="imgArrow" src="../../../images/left-arrow.ico" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</body>
</html>
