<!-- #include file="../../../system/lib/form.inc"  -->
<script LANGUAGE="JavaScript" SRC="/ESYS/system/lib/ajax.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Item</title>
</head>
<%  
    ESysLib.SetUser("comm")
%>

<script>
var IsSelectItem ;
function BodyInit()
{
    System.Translate(document);  // Translate to language session
    
    var data = "";    
        
    data = "<%=ESysLib.SetListDataSQL("select pk, grp_nm from comm.tco_itemgrp where del_if = 0 and use_yn='Y' and leaf_yn = 'Y' ")%>|ALL|Select all"; 
    cboGroup.SetDataText(data);
    cboGroup.value = 'ALL' ;
    
    var group_pk = "<%=request.QueryString("group_pk")%>";
    var type = "<%=request.QueryString("type")%>";
    IsSelectItem = "<%=request.QueryString("IsSelectItem")%>";
   
    if ( group_pk != '' )
    {
        cboGroup.value = group_pk ;
        cboGroup.SetEnable(false);
    }
    
    if (IsSelectItem=='1')
    {
        idGrid2.style.display="none";
        ibtnRemove.style.display="none";
        lblCount.style.display="none";
        var ctl = idGrid.GetGridControl(); 
        ctl.style.height="500";
    }
        
	SetGridFormat();
}
//-----------------------------------------------------------------------------------------------
function OnSearch()
{ 
    if (txtPartnerPK=="")
    {
        alert("Please, select a partner!")
    }else
    {
	    dsoGetParentItem.Call("SELECT");
	}
}
//-----------------------------------------------------------------------------------------------
function OnSelect()
{
   var arr_data = new Array();
   var arrTemp=new Array();
   
   if(idGrid.row>=0)    
       for(var j=0;j<idGrid.cols;j++)
         {
            arrTemp[arrTemp.length]= idGrid.GetGridData(idGrid.row,j);
         }
            
   arr_data[0]= arrTemp;
         
   if(idGrid2.rows > 1)
   {   
      for(var i=1;i<idGrid2.rows;i++)
      {
         arrTemp=new Array();
         
         for(var j=0;j<idGrid2.cols;j++)
         {
            arrTemp[arrTemp.length]= idGrid2.GetGridData(i,j);
         }
         
         arr_data[arr_data.length]= arrTemp;
      }
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
 //---------------------------------------------------------------------------------------
    function SetGridFormat()
     {        
        var ctr = idGrid2.GetGridControl(); 
        ctr.ColFormat(4) = "#,###,###,###,###,###.##";
        ctr.ColFormat(5) = "#,###,###,###,###,###.##";    
        ctr.ColFormat(6) = "#,###,###,###,###,###.##";          
     }
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData(idGrid2.row,0);
    idGrid2.RemoveRowAt(idGrid2.row);
    SetRowBackGroundColor(idGrid,col_val,0x000000); 
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
  if(oGrid.id == "idGrid")
  {
    var col_val = oGrid.GetGridData(event.row,0);
    
    if(IsSelectItem=='1')
    {
        OnSelect(idGrid);
    }
    
    if(event.row > 0 && ( !CheckDataExist(idGrid2,col_val)) )
    {
        SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		idGrid2.AddRow();
		for(var i=0;i<oGrid.cols;i++)
		{
		  idGrid2.SetGridText(idGrid2.rows-1,i,oGrid.GetGridData(event.row,i));
		}
     }
  }
  countItem()
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}

//------------------------------------------------------------------------------
function onRowChange()
{
    if(idGrid.row>=0)
    {
        txtParentItemPK.text=idGrid.GetGridData(idGrid.row,0);
        dsoGetChildItem.Call('SELECT');
    }
}
//----------------------------------------------------------------------------
function OnDataReceive(obj)
{   
    switch(obj.id)
    {
        case 'dsoGetChildItem':
            lblCount.text=idGrid2.rows-1 + " item(s)."
        break;
    }    
}
</script>

<body>
    <gw:data id="dsoGetParentItem" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="PROD.sp_sel_ephl00011" > 
                  <input bind="idGrid" > 
                    <input bind="cboGroup" />
                    <input bind="txtItem" />                     
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <%-------------------------------------------------------------------------------%>
    <gw:data id="dsoGetChildItem" onreceive=""> 
        <xml> 
           <dso id="1" type="grid" function="prod.sp_sel_BOM_child_item" > 
                  <input bind="idGrid2" > 
                    <input bind="txtParentItemPK" />            
                  </input> 
                <output bind="idGrid2" /> 
            </dso> 
        </xml> 
    </gw:data>
    <%--------------------------------------------------------------------------------------%>
    <table width="100%">
        <tr>            
            <td width="5%" align="right">
                <b>Group</b>
            </td>
            <td width="30%">
                <gw:list id="cboGroup" styles="width:100%" value='ALL' onchange="OnSearch()" />
            </td>
            <td width="5%" align="right">
                <b>Item</b>
            </td>
            <td width="15%">
                <gw:textbox id="txtItem" styles="width:100%"  onenterkey="OnSearch()" />
            </td>
            <td width="5%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td width="5%" align="right">
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect()" />
            </td>
        </tr>
        <tr>
            <td colspan="6">           
                <gw:grid id="idGrid" header="_PK|Parent Code|Parent Name|HS Code|Unit"
                    format='0|0|0|0|0'
                    aligns='0|0|0|0|1'
                    defaults='||||'
                    editcol='0|0|0|0|0'
                    widths='0|2500|3500|1500|1200'
                    styles="width:100%; height:250"
                    sorting="T" 
                    param="0,1,2,3,4" 
                    oncellclick="onRowChange()"
                    oncelldblclick="OnSelect()" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
            </td>
            <td colspan="4" align="right">
                <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <gw:grid id='idGrid2'
                    header='_Child_Item_Pk|Item Code|Item Name|Unit|Req Qty|Loss Rate|Loss Qty|Total Qty|_tpr_abbomprodd_pk|_Item_Seq'
                    format='0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|1|3|3|3|3|0|0'
                    defaults='|||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0'
                    widths='1000|2500|3500|800|1500|1200|1200|1000|1000|0'
                    sorting='T'
                    styles='width:100%; height:460'
                />                
            </td>
        </tr>
    </table>
    <gw:textbox id="txtPartnerPK" style="display: none" />
    <gw:textbox id="txtParentItemPK" style="display: none" />
    <gw:textbox id="txtDeliveryTerm" style="display: none" />
</body>
</html>
