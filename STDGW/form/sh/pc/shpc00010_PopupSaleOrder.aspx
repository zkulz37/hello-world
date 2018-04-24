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
    <%=ESysLib.SetGridColumnComboFormat("idGrid2",12,"select   code, code ||' - '|| code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
    var data = "";  
     var  partner    = "<%=request.QueryString("partner_type")%>" ;
    var  partner_id = "<%=request.QueryString("partner_id")%>" ;
     l_prod_yn = "<%=request.QueryString("prod_yn")%>" ;
     txtPro_YN.text = l_prod_yn
//     data = "<%=ESysLib.SetListDataSQL("SELECT     pk,grp_cd || ' ' || grp_nm p FROM (SELECT grp_cd, grp_nm, pk, p_pk FROM comm.tco_itemgrp WHERE del_if = 0)CONNECT BY PRIOR pk = p_pk START WITH p_pk =3763 ORDER SIBLINGS BY grp_cd")%>";
//     lstGroup.SetDataText(data+"|ALL|Select All");  
//     lstGroup.value='ALL';
     <%=ESysLib.SetGridColumnComboFormat("idGrid",19,"select   code, code ||' - '|| code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
     <%=ESysLib.SetGridColumnComboFormat("idGrid2",19,"select   code, code ||' - '|| code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
     var fg = idGrid.GetGridControl();
      var fg1 = idGrid2.GetGridControl();
        fg.ColFormat(7)= "#,###,###,###";
        fg.ColFormat(8)= "#,###,###,###";
        fg1.ColFormat(7)= "#,###,###,###";
        fg1.ColFormat(8)= "#,###,###,###";
    //-------------------------   
    
    var group_pk = "<%=request.QueryString("group_pk")%>";
    
    if ( Number(group_pk) > 0 )
    {
//        lstGroup.value = group_pk ;
//        lstGroup.SetEnable(false);
    }
    
	//---------------------------------------
}
//-----------------------------------------------------------------------------------------------
function OnSearch(obj)
{ 
    switch(obj)
    {
        case 1:
                 data_shab00010_SaleOrder.Call("SELECT");
        break;
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
function OnAdd(oGrid)
{
	for (i = 0; i<oGrid.GetGridControl().SelectedRows ; i++)
	{
		var row = oGrid.GetGridControl().SelectedRow(i);
        var col_val = oGrid.GetGridData( row, 0);		
		
        if ( row > 0 && ( !CheckDataExist( idGrid2, col_val)) )
        {
            SetRowBackGroundColor( oGrid, col_val, 0x0000FF);
            
	        idGrid2.AddRow();
    		
	        for(var j=0; j<oGrid.cols; j++)
	        {
	            idGrid2.SetGridText( idGrid2.rows-1, j, oGrid.GetGridData( row, j) );
	        }
        }		
	}
    
    countItem(); 
}
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
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == "idGrid" && event.row > 0 )
      {
            var col_val = oGrid.GetGridData(event.row, 0 );
            
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
function CheckDataExist(p_oGrid,p_value)
{
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
    
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, G_tco_item_pk) == p_value)
              {
                 return true;
              }
       }
       return false;
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == "idGrid" && event.row > 0 )
      {
            var col_val = oGrid.GetGridData(event.row, G_tco_item_pk );
            
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
//======================================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shab00010_SaleOrder':
            lblRecord2.text = idGrid.rows-1 + " Item(s)";
        break;
    }
}
//================================================================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_shab00010_SaleOrder" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="Prod.sp_sel_shpc00010_saleorder" > 
                  <input bind="idGrid" > 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtOrderNo" />
                    <input bind="txtItem" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">  
        <td style="width: 7%">Date</td>  
            <td style="width: 23%" align="left">
               <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch(1)" />
               ~
               <gw:datebox id="dtTo" lang="<%=Session("Lang")%>" onchange="OnSearch(1)" />
            </td>
            <td style="width: 13%" align="right">
                 Order No
            </td>
            <td style="width: 15%">
                <gw:textbox id="txtOrderNo" styles="width:100%" onenterkey="OnSearch(1)" />
            </td>
            <td style="width: 12%" align="right">
                Item
            </td>
            <td style="width: 15%">
                <gw:textbox id="txtItem" styles="width:100%"  onenterkey="OnSearch(1)" />
            </td>
            <td style="width: 14%" align="center">
                <gw:label id="lblRecord2" styles="color: blue">record(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch(1)" />
            </td>
        </tr>
        <tr style="height: 48%">
             <td colspan="8">
                <gw:grid id="idGrid" header="_SaleOrderpkM|_SaleOrderpkD|_ItemPK|_BuspartnerPK|Order No|Order Date|_Plan Qty|Order Qty|Balance|Item Code|Item Name|Spec|Uom|Cap Color|Body Color|Cap Print Type|Body Print Type|Cap Print Col|Body Print Col|Size Code|Partner ID|Partner Name|Print YN" 
                    format="0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|1" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" widths="0|2000|4000|2000|800|1000|2000|4000|2000|800|1000|2000|4000|2000|800|1000|1000|2000|4000|2000|800|1000|1000" styles="width:100%; height:100%"
                    sorting="T" oncelldblclick="OnGridCellDoubleClick(this)" autosize='T' />
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="8">
                <table>
                    <tr>
                        <td></td>
                        <td style="width: 96%" align="center">
                            <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 1%" style="white-space: nowrap">
                            <gw:checkbox id="chkDuplicate" defaultvalue="Y|N" value="N" />
                            Duplicate
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(idGrid)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td colspan="8">
                <gw:grid id="idGrid2" header="_SaleOrderpkM|_SaleOrderpkD|_ItemPK|_BuspartnerPK|Order No|Order Date|_Plan Qty|Order Qty|Balance|Item Code|Item Name|Spec|Uom|Cap Color|Body Color|Cap Print Type|Body Print Type|Cap Print Col|Body Print Col|Size Code|Partner ID|Partner Name|Print YN" 
                    format="0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|1" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" widths="0|2000|4000|2000|800|1000|2000|4000|2000|800|1000|2000|4000|2000|800|1000|1000|2000|4000|2000|800|1000|1000" styles="width:100%; height:100%"
                    sorting="T"  autosize='T' />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtPro_YN" styles="width:100%;display:none" />
    <!---------------------------------------------------------------->
</body>
</html>
