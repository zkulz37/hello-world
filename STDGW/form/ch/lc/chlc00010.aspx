<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head>
    <title>Item Entry</title>
</head>

<script>
 
    var vPage       = 0 ;
    var currentPage = 0;
    var isRowChange = true;
    var lastrow =-1;
    
    var G_Group_PK      = 0,
        G_Group_CD      = 1,
        G_Group_Name    = 2,
        G_UOM           = 3;
    
    var G1_item_pk          = 0, 
        G1_item_code        = 1, 
        G1_item_name        = 2,   
        G1_item_lname       = 3, 
        G1_item_fname       = 4,
        G1_uom              = 5, 
        G1_unit_price       = 6, 
        G1_use_yn           = 7, 
        G1_description      = 8,
        G1_tco_itemphoto_pk = 9,
        G1_tco_itemgrp_pk   = 10;
        
 //---------------------------------------------------------
 function OnToggle(direction)
 {
    if ( direction == 'SearchList' )
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
     else if ( direction == 'Picture' )
     {
        var left  = document.all("t-left");    
        var right = document.all("t-right");   
        var imgArrow = document.all("img1");   
        
        if(imgArrow.status == "expand")
        {
            right.style.display="none";       
            imgArrow.status = "collapse";
            left.style.width="99%";
            imgArrow.src = "../../../system/images/button/previous.gif";
        }
        else
        {
            right.style.display="";
            imgArrow.status = "expand";
            //left.style.width="75%";
            imgArrow.src = "../../../system/images/button/next.gif";
        }     
     }    
 }        
//------------------------------------------------------------ 

function BodyInit()
{   
    txtParentNm.SetEnable(false);
    txtGroupName.SetEnable(false);
    //------------------------------
    SetGridFormat();
    BindingDataList();
    //------------------------------
    
    OnSearch('Group');
} 
//------------------------------------------------------------
function BindingDataList()
{
    var data = "<%=ESysLib.SetListDataSQL("select  UOM_CODE, UOM_CODE || '-' || UOM_NM from TCO_UOM where del_if=0  order by UOM_CODE")%>";   
    grdItem.SetComboFormat(G1_uom,data);
}
//------------------------------------------------------------
function SetGridFormat()
{
    var ctr = grdItem.GetGridControl(); 
    ctr.ColFormat(G1_unit_price) = "#,###,###,###,###,###.##";
}

//------------------------------------------------------------ 
function OnSave(pos)
{
    switch (pos)
    {
        case 'Item':
            grdItem.SetGridText(grdItem.row, G1_tco_itemphoto_pk, imgItem.oid );// luu photo_pk cho dong cuoi cung
            
            if( ValidateData() )
            {
                data_chlc00010_2.Call('');
            }        
        break;
        
        case 'Group':
            data_chlc00010_1.Call();
        break;     
    }   
}
//------------------------------------------------------------ 
function OnAddNew(pos)
{
    switch(pos)
    {
        case 'Item' :
            if ( txtGroup_PK.text != '' )
            {
                grdItem.AddRow();
                grdItem.SetGridText(grdItem.rows-1, G1_tco_itemgrp_pk, txtGroup_PK.text );
                grdItem.SetGridText(grdItem.rows-1, G1_use_yn        , '-1'             );
                
                if ( grdGroup.row > 0 )
                {
                    grdItem.SetGridText(grdItem.rows-1, G1_uom , grdGroup.GetGridData( grdGroup.row, G_UOM) );
                }    
            }
            else
            {
                alert('Pls Select Group first !!!');
            }    
        break;
        
        case 'group' :
            data_chlc00010_1.StatusInsert();
                        
            txtParentPK.text = oTree.GetCurrentNode().oid; 
            txtParentNm.text = oTree.GetCurrentNode().text;            
            
            txtGrpCD.text = '<< New Code >>' ;
            txtGrpNm.text = '<< New Name >>' ;
        break;  
        
        case 'update_group' :
            txtGroupNew_PK.text = oTree.GetCurrentNode().oid;
            data_chlc00010_1.Call("SELECT");
        break;      
    }    
}
//------------------------------------------------------------ 
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_chlc00010_2':
            lblRecord.text = grdItem.rows-1 + ' row(s)';
        break;
                
        case 'data_chlc00010_1':
            OnSearch('Group');
        break;        
    }
}
//------------------------------------------------------------
function OncellClickGrd()
{
    if(lastrow!='-1')
    {
        grdItem.SetGridText(lastrow, G1_tco_itemphoto_pk, imgItem.oid);
    }
   
    txttco_itemphoto_pk.SetDataText(grdItem.GetGridData(grdItem.GetGridControl().row, G1_tco_itemphoto_pk));
    imgItem.SetDataText(txttco_itemphoto_pk.text );  
    lastrow = grdItem.GetGridControl().row;
   
}
//------------------------------------------------------------
function OnDelete(pos)
{
    switch (pos)
    {
        case 'Item' :
            if( confirm('Do you want to delete this item ?'))
	        {
	            grdItem.DeleteRow();
	        }        
        break;
        
        case 'Group':
            if(confirm('Do you want to delete selected group?'))
            {                
                data_chlc00010_1.StatusDelete();
                data_chlc00010_1.Call('');
	        }        
        break;
    }
}
//------------------------------------------------------------
function ValidateData()
{
    for(i=1; i<grdItem.rows;i++)
    {
        if((grdItem.GetGridData(i, G1_item_code ) =='')&& (grdItem.GetRowStatus(i)!=64))
        {
            alert("You must input item code at row " + i + "!");
            return false;
        }
        if(grdItem.GetGridData(i, G1_item_name ) =='')
        {
            alert("You must input item name at row " + i + "!");
            return false;
        }
        if(grdItem.GetGridData(i, G1_uom ) =='')
        {
            alert("You must input uom at row " + i + "!");
            return false;
        }
    }
    return true;
}

 //------------------------------------------------------------------
 function CheckInput()
 {   
    var  row, col 
        
    row = event.row ;
    col = event.col ;    
        
    if ( col == G1_unit_price )
    {      
        var dQuantiy
        
        dQuantiy =  grdItem.GetGridData(row,col)
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdItem.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(2));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdItem.SetGridText(row,col,"")
            }
        }
        else
        {
            grdItem.SetGridText(row,col,"")
        }
         //---------------------------------------------
    } 
 } 
//============================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'Group':
            data_chlc00010.Call("SELECT");
        break;
        
        case 'ItemList': 
            txtGroup_PK.SetDataText(oTree.GetCurrentNode().oid);
            txtGroupName.SetDataText(oTree.GetCurrentNode().text);
                               
            data_chlc00010_2.Call("SELECT");
        break;    
    }
}

//============================================================
</script>

<body>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_chlc00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="tree" user="comm" function="hr.sp_sel_chlc00010" > 
                <input>
                    <input bind="txtGroupSearch" />
                </input>
                <output bind="oTree" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_chlc00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4" function="hr.sp_sel_chlc00010_1"  procedure="hr.sp_upd_chlc00010_1"> 
                <inout> 
                     <inout  bind="txtGroupNew_PK" /> 
                     <inout  bind="txtParentPK" />
                     <inout  bind="txtParentNm" />
                     <inout  bind="txtGrpCD" />
                     <inout  bind="txtGrpNm" />                	                 
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_chlc00010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" user="hr" parameter="0,1,2,3,4,5,6,7,8,9,10" function="hr.sp_sel_chlc00010_2" procedure="hr.sp_upd_chlc00010_2" > 
                <input bind="grdItem" > 
                    <input bind="txtItem" /> 
                    <input bind="txtGroup_PK" />
                </input> 
                <output bind="grdItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr valign="top" style="height: 100%">
            <td style="width: 35%" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Search
                        </td>
                        <td style="width: 96%">
                            <gw:textbox id="txtGroupSearch" styles='width:100%' onenterkey="OnSearch('Group')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSearchGroup" img="search" alt="Search" text="Search" onclick="OnSearch('Group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnAddNew" img="new" alt="New" text="New" onclick="OnAddNew('group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnUpdate" img="update" alt="Update" text="Update" onclick="OnAddNew('update_group')" />
                        </td>                        
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnSave01" img="save" alt="Save" text="Save" onclick="OnSave('Group')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Parent
                        </td>
                        <td style="width: 92%; white-space: nowrap" colspan="6">
                            <gw:textbox id="txtParentPK" styles='width:100%; display:none' />
                            <gw:textbox id="txtParentNm" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Group
                        </td>
                        <td style="width: 92%; white-space: nowrap" colspan="6">
                            <gw:textbox id="txtGrpCD" styles='width:30%' csstype="mandatory" />
                            <gw:textbox id="txtGrpNm" styles='width:70%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%;" colspan="7">
                            <gw:tree id="oTree" style="width: 100%; height: 100%; overflow: auto;" onclicknode="OnSearch('ItemList')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 65%" id="right">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="right">
                                        Group</td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtGroupName" styles='width:100%' onenterkey="OnSearch('ItemList')" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        Item</td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtItem" styles='width:100%' onenterkey="OnSearch('ItemList')" />
                                    </td>
                                    <td style="width: 10%" align="center">
                                        <gw:label id="lblRecord" styles="color: blue">record(s)</gw:label>
                                    </td>
                                    <td style="width: 6%">
                                    </td>
                                    <td style="width: 1%" valign="bottom" align="right">
                                        <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('ItemList')" />
                                    </td>
                                    <td style="width: 1%" valign="bottom" align="right">
                                        <gw:imgbtn id="ibtnAdd" img="new" alt="Add New Item" text="Add New Item" onclick="OnAddNew('Item')" />
                                    </td>
                                    <td style="width: 1%" valign="bottom" align="right">
                                        <gw:imgbtn id="ibtnDel" img="delete" alt="Delete Item" text="Delete Item" onclick="OnDelete('Item')" />
                                    </td>
                                    <td style="width: 1%" valign="bottom" align="right">
                                        <gw:imgbtn id="ibtnSave" img="save" alt="Save Item" text="Save Item" onclick="OnSave('Item')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 100%" valign="top">
                                    <td style="width: 98%" id="t-left">
                                        <gw:grid id="grdItem" header='_Pk|Item Code|Item Name|Item Lname|Item Fname|UOM|U/P|Use Y/N|Description|_tco_Itemphoto_Pk|_tco_Itemgrp_Pk'
                                            format='0|0|0|0|0|2|0|3|0|0|0' aligns='0|0|0|0|0|1|3|0|0|0|0' defaults='||||||||||'
                                            editcol='1|1|1|1|1|1|1|1|1|0|0' widths='0|1800|2500|2000|2000|800|1300|800|2000|0|0'
                                            styles="width:100%; height:100%" sorting="F" oncellclick="OncellClickGrd()" onafteredit="CheckInput()" />
                                    </td>
                                    <td style="width: 1%">
                                        <img status="expand" id="img1" src="../../../system/images/button/next.gif" style="cursor: hand;
                                            position: fixed" onclick="OnToggle('Picture')" />
                                    </td>
                                    <td style="width: 1%" id="t-right">
                                        <gw:image id="imgItem" table_name="TCO_ITEMPHOTO" oid="0" view="/binary/ViewFile.aspx"
                                            post="/binary/PostFile.aspx" styles="width:200;height:200" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle('SearchList')" />
    <!------------------------------------------->
    <gw:textbox id="txtGroupNew_PK" styles='display:none' />
    <!------------------------------------------------------------------------------>
    <gw:textbox id="txtGroup_PK" styles='display:none' />
   
    <gw:textbox id="txttco_itemphoto_pk" styles="display: none" />
    <!------------------------------------------------------------------------------>
</body>
</html>
