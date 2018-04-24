<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Item</title>
</head>
<%  
    ESysLib.SetUser("prod")
%>

<script>
function BodyInit()
{
    txtPartnerID.SetEnable(false);
	txtPartnerName.SetEnable(false);	
	
    var data = "";    
        
    data = "<%=ESysLib.SetListDataSQL("select pk, grp_nm from comm.tco_itemgrp where del_if = 0 and use_yn='Y' and leaf_yn = 'Y' and pur_yn = 'Y' ")%>|ALL|Select all"; 
    lstGroup.SetDataText(data);
    lstGroup.value = 'ALL' ;
    
    var group_pk = "<%=request.QueryString("group_pk")%>";
    
    if ( group_pk != '' )
    {
        lstGroup.value = group_pk ;
        lstGroup.SetEnable(false);
    }
	
}
//------------------------------------------------------------------------------------------------
function TabPopUp(fnameFile)
{
	var fpath = System.RootURL + "/form/fp/ab/" + fnameFile; 	
	var a = new Array();
	aValue  = System.OpenModal(  fpath , 800 , 550 , 'resizable:no;status:yes');	
	if ( aValue != null )  
	{
	    txtPartnerName.text = aValue[2];
		txtPartnerID.text = aValue[1];					
		txtPartnerPK.text = aValue[0];
	}
}
//-----------------------------------------------------------------------------------------------
function OnSearch()
{ 
    if (txtPartnerPK=="")
    {
        alert("Please, select a partner!")
    }else
    {
	    datGetItem.Call("SELECT");
	}
}
//-----------------------------------------------------------------------------------------------
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   if(oGrid.rows > 1)
   {   
      for(var i=1;i<oGrid.rows;i++)
      {
         var arrTemp=new Array();
         
         for(var j=0;j<oGrid.cols;j++)
         {
            arrTemp[arrTemp.length]= oGrid.GetGridData(i,j);
         }
         
         arr_data[arr_data.length]= arrTemp;
      }
      
	  if ( arr_data !=null )
	  {
		window.returnValue =  arr_data;
		window.close();
	  }
	  else
	  {
	    alert("You have not selected data yet.");
	  }
   }	  
	  
}
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  if(grdItem2.row > 0)
  {
    var col_val = grdItem2.GetGridData(grdItem2.row,0);
    grdItem2.RemoveRowAt(grdItem2.row);
    SetRowBackGroundColor(grdItem,col_val,0x000000); 
    countItem()
  }
}
//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,0) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid,p_value)
{
  for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,0) == p_value)
      {
         return true;
      }
   }
   return false;
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
  if(oGrid.id == "grdItem")
  {
    var col_val = oGrid.GetGridData(event.row,0);
    
    if(event.row > 0 && ( !CheckDataExist(grdItem2,col_val)) )
    {
        SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		grdItem2.AddRow();
		for(var i=0;i<oGrid.cols;i++)
		{
		  grdItem2.SetGridText(grdItem2.rows-1,i,oGrid.GetGridData(event.row,i));
		}
     }
  }
  countItem()
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=grdItem2.rows-1 + " item(s)."
}
</script>

<body>
    <gw:data id="datGetItem" onreceive=""> 
    <xml> 
           <dso id="1" type="grid" function="inv.sp_sel_freeItem_for_reqiqc" > 
                  <input bind="grdItem" > 
                    <input bind="txtPartnerPK" />
                    <input bind="lstGroup" />
                    <input bind="txtItem" /> 
                  </input> 
                <output bind="grdItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%">
        <tr>
            <td width="5%" align="right">
                <b style="color: #1b2ff2; cursor: hand" onclick="TabPopUp('PopUpGetPartner.aspx',1)">
                    Partner </b>
            </td>
            <td width="10%">
                <gw:textbox id="txtPartnerID"  styles="width:100%" />
            </td>
            <td width="20%">
                <gw:textbox id="txtPartnerName" styles="width:100%" />
            </td>
            <td width="5%" align="right">
                <b>Group</b>
            </td>
            <td width="20%">
                <gw:list id="lstGroup" styles="width:100%" value='ALL' onchange="OnSearch()" />
            </td>
            <td width="5%" align="right">
                <b>Item</b>
            </td>
            <td width="25%">
                <gw:textbox id="txtItem" styles="width:100%"  onenterkey="OnSearch()" />
            </td>
            <td width="5%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td width="5%" align="right">
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdItem2)" />
            </td>
        </tr>
        <tr>
            <td colspan="13">
                <gw:grid id="grdItem" header="_PK|Item Code|Item Name|_tco_itemgrp_pk|Item Group|Unit|Stock Qty.|Price|_LisPrice|_StPrice|_LmPrice|_MkPrice|_pur_type|_volume|_tin_warehouse_pk|_partner_pk|_partner_id|_partner_name|Description"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    aligns="0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    defaults="|||||||||||||||||||" 
                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    widths="0|2500|2500|1500|2500|800|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    styles="width:100%; height:250"
                    sorting="T" 
                    param="0,1,2,3,4,5,5,6,7" 
                    oncelldblclick="OnGridCellDoubleClick(this)" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
            </td>
            <td colspan="11" align="right">
                <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
            </td>
        </tr>
        <tr>
            <td colspan="13">
                <gw:grid id="grdItem2"
                header="_PK|Item Code|Item Name|_tco_itemgrp_pk|Item Group|Unit|Stock Qty.|Price|_LisPrice|_StPrice|_LmPrice|_MkPrice|_pur_type|_volume|_tin_warehouse_pk|_partner_pk|_partner_id|_partner_name|Description"
                format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                aligns="0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0"
                defaults="|||||||||||||||||||"
                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                widths="0|2500|2500|1500|2500|800|0|0|0|0|0|0|0|0|0|0|0|0|0"
                styles="width:100%; height:200"
                sorting="T"
                param="0,1,2,3,4,5,5,6,7" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtPartnerPK" style="display: none" />
    <gw:textbox id="txtDeliveryTerm" style="display: none" />
</body>
</html>
