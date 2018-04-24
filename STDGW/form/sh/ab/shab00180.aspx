<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Many Item</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>

var G_tco_item_pk       = 0,
    G_Item_Code         = 1,
    G_Item_Name         = 2,
    G_Spec              = 3,
    G_Unit              = 4;

//------------------------------------------------------------------------------------------------
function BodyInit()
{
	//-------------------------
    var p_company_pk = "<%=Request.querystring("company_pk")%>";
    //alert("<%=Request.querystring("company_pk")%>")
    <%=ESysLib.SetGridColumnComboFormat("idGrid",12,"select   code, code ||' - '|| code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
    var data = "";  
     var  partner    = "<%=request.QueryString("partner_type")%>" ;
    var  partner_id = "<%=request.QueryString("partner_id")%>" ;
     l_prod_yn = "<%=request.QueryString("prod_yn")%>" ;
     txtPro_YN.text = l_prod_yn
     data = "<%=ESysLib.SetListDataSQL("SELECT     pk,grp_cd || ' ' || grp_nm p FROM (SELECT grp_cd, grp_nm, pk, p_pk FROM comm.tco_itemgrp WHERE del_if = 0)CONNECT BY PRIOR pk = p_pk START WITH p_pk =3763 ORDER SIBLINGS BY grp_cd")%>";
     lstGroup.SetDataText(data+"|ALL|Select All");  
     lstGroup.value='ALL';
    //-------------------------   
    
    var group_pk = "<%=request.QueryString("group_pk")%>";
    
    if ( Number(group_pk) > 0 )
    {
        lstGroup.value = group_pk ;
        lstGroup.SetEnable(false);
    }
    
	//---------------------------------------
}
//-----------------------------------------------------------------------------------------------
function OnSearch(obj)
{ 
    switch(obj)
    {
        case 1:
                 data_shab00011.Call("SELECT");
        break;
    }
   
}
//-----------------------------------------------------------------------------------------------

function CheckDataExist(p_oGrid,p_value)
{
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
    
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, 0) == p_value)
              {
                 return true;
              }
       }
       return false;
}

//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData( idGrid2.row, 0);
    
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
      if(p_oGrid.GetGridData( i, G_tco_item_pk) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
   var arr_data = new Array();
   
   if(oGrid.row > 0)
   {   
      
         var arrTemp=new Array();
         
         for(var j=0;j<oGrid.cols;j++)
         {
            arrTemp[arrTemp.length]= oGrid.GetGridData(oGrid.row,j);
         }
         
	  if ( arr_data !=null )
	  {
		window.returnValue =  arrTemp;
		window.close();
	  }
	  else
	  {
	    alert("You have not selected data yet.");
	  }
   }
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}
//======================================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shab00011':
            lblRecord2.text = idGrid.rows-1 + " Item(s)";
        break;
    }
}
//================================================================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_shab00011" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="PROD.sp_sel_shpc00011" > 
                  <input bind="idGrid" > 
                    <input bind="lstGroup" />
                    <input bind="txtItem" />
                    <input bind="txtPartner" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Group
            </td>
            <td style="width: 25%">
                <gw:list id="lstGroup" styles="width:100%" onchange="OnSearch(1)" csstype="mandatory" />
            </td>
            <td style="width: 5%" align="right">
                Item
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtItem" styles="width:100%"  onenterkey="OnSearch(1)" />
            </td>
            <td style="width: 5%" align="right">
                Partner
            </td>
            <td style="width: 20%">
                <gw:textbox id="txtPartner" styles="width:100%" onenterkey="OnSearch(1)" />
            </td>
            <td style="width: 14%" align="center">
                <gw:label id="lblRecord2" styles="color: blue">record(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch(1)" />
            </td>
        </tr>
        <tr style="height: 48%">
            <td colspan="7">
                <gw:grid id="idGrid" header="_item_pk|_buspartner_pk|Item Code|Item Name|Spec|Uom|Cap Color|Body Color|Cap Print Type|Body Print Type|Cap Print Color|Body Print Color|Size|Partner ID|Partner Name|PRINT_YN" 
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" widths="0|2000|4000|2000|800|1000|2000|4000|2000|800|1000|2000|4000|2000|800|1000" styles="width:100%; height:100%"
                    sorting="T" oncelldblclick="OnGridCellDoubleClick(this)" autosize='T' />
            </td>
        </tr> 
    </table>
    <gw:textbox id="txtPro_YN" styles="width:100%;display:none" />
    <!---------------------------------------------------------------->
</body>
</html>
