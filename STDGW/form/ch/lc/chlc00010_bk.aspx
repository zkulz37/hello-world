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
    SetGridFormat();
    BindingDataList();
    //------------------------------
    setPage(vPage);
    
    data_chlc00010_1.Call("SELECT");
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
function onOpenPopup(index)
{   
    switch(index)
    {
        case 0:
            fpath = System.RootURL + '/form/ag/ci/agci00040.aspx';
	        var aValue  = System.OpenModal(  fpath , 950 , 650 , 'resizable:yes;status:yes');
	        data_chlc00010_1.Call("SELECT");
        break;
    }
}
//------------------------------------------------------------
 function onLoadItem()
{   
   SearchOnClick();
}
//-----------------------------------------------------------
function SearchOnClick()
{   
    if ( grdGroup.row > 0 ) 
    {
        txtGroup_PK.text  = grdGroup.GetGridData( grdGroup.row, G_Group_PK );
        data_chlc00010_3.Call();
    } 
    else
    {
        txtGroup_PK.text = '';
        data_chlc00010_3.Call();
    }       
}
//-----------------------------------------------------------
function LoadDataPage(obj,init)
{
   if (obj.style.cursor == 'hand'||init==1)
   {
        switch(obj.id)
        {
            case 'page1':
                if (vPage>0)
                {
                    page1.style.cursor = 'none' ;
                    page1.style.color = 'red';
                    page2.style.cursor = 'hand' ;
                    page2.style.color = 'blue';
                    page3.style.cursor = 'hand' ;
                    page3.style.color = 'blue';
                    currentPage =1
                }
            break;
            case 'page2':
                page1.style.cursor = 'hand' ;
                page1.style.color = 'blue';
                page2.style.cursor = 'none' ;
                page2.style.color = 'red';
                page3.style.cursor = 'hand' ;
                page3.style.color = 'blue';
                currentPage =2
            break;
            case 'page3':
                page1.style.cursor = 'hand' ;
                page1.style.color = 'blue';
                page2.style.cursor = 'hand' ;
                page2.style.color = 'blue';
                page3.style.cursor = 'none' ;
                page3.style.color = 'red';
                currentPage =3
            break;
        }
        var page =  obj.innerText;
        txtPage.text = page;
        currentPage = page;
        data_chlc00010_2.Call('SELECT');
    }
}
//----------------------------------------------------------------
function setPage(pPage)
{
     
   pagePrev.style.cursor = 'none' ;
   pagePrev.style.color = 'gray';
   
    switch(vPage)
    {
        case 0:
             page1.innerText = 1;
             page2.innerText = "";
             page3.innerText = "";
             page1.style.cursor ='none';
             page1.style.color = 'gray';
             pageNext.style.cursor ='none';
             pageNext.style.color = 'gray';
        break;   
        case 1:
             page1.innerText = 1;
             page2.innerText = "";
             page3.innerText = "";
             page1.style.cursor ='none';
             page1.style.color = 'red';
             pageNext.style.cursor ='none';
             pageNext.style.color = 'gray';
        break;   
        case 2:
             page1.innerText = 1;
             page2.innerText = 2;
             page3.innerText = "";
             pageNext.style.cursor ='none';
             pageNext.style.color = 'gray';
        break;
        case 3:
             page1.innerText = 1;
             page2.innerText = 2;
             page3.innerText = 3;
             pageNext.style.cursor ='none';
             pageNext.style.color = 'gray';
        break;
        default:
            page1.innerText = 1;
            page2.innerText = 2;
            page3.innerText = 3;
            pageNext.style.cursor ='hand';
            pageNext.style.color = 'blue';
        
    }
}
//---------------------------------------------------------------
function PrevPage()
{
     var lastPage =  page3.innerText
     var firstPage =  page1.innerText
     if(firstPage > 1 && pagePrev.style.cursor == 'hand')
     {
        page1.innerText = parseInt(page1.innerText + "") -1;
        page2.innerText = parseInt(page2.innerText+ "") -1;
        page3.innerText = parseInt(page3.innerText+ "") -1;
        CurrentState(page1)
        CurrentState(page2)
        CurrentState(page3)
        if (page3.innerText < vPage)
        {
            pageNext.style.cursor ='hand';
            pageNext.style.color = 'blue';

        }
         if (page1.innerText == 1)
        {
            pagePrev.style.cursor = 'none' ;
            pagePrev.style.color = 'gray';
        }
    }     
}
//---------------------------------------------------------------
function NextPage()
{
  var lastPage =  page3.innerText
    if(lastPage < vPage && pageNext.style.cursor =='hand')
    {
        page1.innerText = parseInt(page1.innerText + "") +1;
        page2.innerText = parseInt(page2.innerText+ "") +1;
        page3.innerText = parseInt(page3.innerText+ "") +1;
        CurrentState(page1)
        CurrentState(page2)
        CurrentState(page3)
        if (page3.innerText==vPage)
        {
            pageNext.style.cursor ='none';
            pageNext.style.color = 'gray';

        }
         if (page1.innerText != '1')
        {
            pagePrev.style.cursor ='hand';
            pagePrev.style.color = 'blue';

        }
    }    
}
//-------------------------------------------------------------
function CurrentState(obj)
{
     if(obj.innerText == currentPage)
    {
        obj.style.cursor ='none';
        obj.style.color = 'red';
    }else
    {
        obj.style.cursor ='hand';
        obj.style.color = 'blue';
    }
}
//------------------------------------------------------------ 
function onSave()
{
    grdItem.SetGridText(grdItem.row, G1_tco_itemphoto_pk, imgItem.oid );// luu photo_pk cho dong cuoi cung
    if(ValidateData())
        data_chlc00010_2.Call('');
}
//------------------------------------------------------------ 
function onAddNew(index)
{
    switch(index)
    {
        case 0:
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
    }    
}
//------------------------------------------------------------ 
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_chlc00010_3':
            vPage = Math.ceil(txtRecords.text / Number(txtRowPerPage.text)) 
            setPage(vPage)
            lblRecord2.text = txtRecords.text + " record(s)";
            txtPage.text = 1;
            page1.innerText = '1';
            currentPage = 1;
            LoadDataPage(page1,1)
        break;
        case 'data_chlc00010_2':
            lastrow = '-1';
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
function onDelete()
{
    if(confirm('Do you want to delete this item ?'))
	{
	    grdItem.DeleteRow();
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
//------------------------------------------------------------
function Upcase()
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
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
            data_chlc00010_1.Call("SELECT");
        break;
    }
}

//============================================================
</script>

<body>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_chlc00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="hr" function="hr.sp_sel_chlc00010_1" >
                <input bind="grdGroup" > 
                    <input bind="txtGroupSearch" />
                </input>    
                <output bind="grdGroup" />  
            </dso> 
        </xml> 
    </gw:data>
    <!-----------------grdAttribute ---------------------------------------->
    <gw:data id="data_chlc00010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" user="hr" parameter="0,1,2,3,4,5,6,7,8,9,10" function="hr.sp_sel_chlc00010_2" procedure="hr.sp_upd_chlc00010_2" > 
                <input bind="grdItem" > 
                    <input bind="txtITEM_CODE" /> 
                    <input bind="txtGroup_PK" />
                    <input bind="cboUse" />
                    <input bind="txtPage" />
                    <input bind="txtRowPerPage" />
                </input> 
                <output bind="grdItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="data_chlc00010_3" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso  type="process" procedure="hr.sp_pro_chlc00010_3" > 
                  <input bind="idGrid" > 
                    <input bind="txtITEM_CODE" /> 
                        <input bind="txtGroup_PK" />
                        <input bind="cboUse" />
                  </input> 
                  <output>
                    <output bind="txtRecords" /> 
                  </output>
           </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr valign="top" style="height: 100%">
            <td style="width: 30%" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Group
                        </td>
                        <td style="width: 97%">
                            <gw:textbox id="txtGroupSearch" styles='width:100%' onenterkey="OnSearch('Group')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSearchGroup" img="search" alt="Search" text="Search" onclick="OnSearch('Group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnAddGroup" img="btn_popup" alt="Add New Group" text="Add New Group"
                                onclick="onOpenPopup(0)" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%;" colspan="4">
                            <gw:grid id="grdGroup" header="_pk|Group CD|Group Name|_UOM" format="0|0|0|0" aligns="0|0|0|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|1800|2500|0" styles="width:100%; height:100%"
                                sorting="T" oncellclick="onLoadItem()" param="0,1,2,3" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 70%" id="right">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 90%">
                                        <table style="width: 100%" cellpadding="4" cellspacing="1" bgcolor="81d7f3">
                                            <tr>
                                                <td style="width: 10%" bgcolor="bde9ff">
                                                    Item</td>
                                                <td style="width: 60%" bgcolor="#FFFFFF">
                                                    <gw:textbox id="txtITEM_CODE" styles='width:100%' onenterkey="SearchOnClick()" onkeypress="Upcase()" />
                                                </td>
                                                <td style="width: 10%" bgcolor="bde9ff">
                                                    Is Use</td>
                                                <td style="width: 16%" bgcolor="FFFFFF">
                                                    <gw:list id="cboUse" styles="width:100%">
                                                        <Data>Data|Y|Use|N|Unuse|ALL|Select All</Data>
                                                    </gw:list>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 6%">
                                    </td>
                                    <td style="width: 1%" valign="bottom" align="right">
                                        <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="SearchOnClick()" />
                                    </td>
                                    <td style="width: 1%" valign="bottom" align="right">
                                        <gw:imgbtn id="ibtnAdd" img="new" alt="Add New Item" text="Add New Item" onclick="onAddNew(0)" />
                                    </td>
                                    <td style="width: 1%" valign="bottom" align="right">
                                        <gw:imgbtn id="ibtnDel" img="delete" alt="Delete Item" text="Delete Item" onclick="onDelete()" />
                                    </td>
                                    <td style="width: 1%" valign="bottom" align="right">
                                        <gw:imgbtn id="ibtnSave" img="save" alt="Save Item" text="Save Item" onclick="onSave()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr align="right">
                                    <td style="width: 5%;" align="right">
                                    </td>
                                    <td style="width: 80%;" align="left">
                                        <gw:label id="lblRecord2" styles="color: blue">record(s)</gw:label>
                                    </td>
                                    <td style="width: 3%;" align="right">
                                        <b id="pagePrev" style="color: Blue; cursor: hand" onclick="PrevPage()"><u><< </u></b>
                                    </td>
                                    <td width="3%" align="center" style="color: gray; cursor: none">
                                        <b><u id="page1" style="color: Blue; cursor: hand" onclick="LoadDataPage(this,0)">1
                                        </u></b>
                                    </td>
                                    <td width="3%" align="center">
                                        <b><u style="color: Blue; cursor: hand" onclick="LoadDataPage(this,0)" id="page2"></u>
                                        </b>
                                    </td>
                                    <td width="3%" align="center">
                                        <b><u id="page3" style="color: Blue; cursor: hand;" onclick="LoadDataPage(this,0)"></u>
                                        </b>
                                    </td>
                                    <td style="width: 3%;" align="left">
                                        <b id="pageNext" style="color: gray; cursor: none" onclick="NextPage()"><u>>> </u></b>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 98%">
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
    <!------------------------------------------------------------------------------>
    <gw:textbox id="txtGroup_PK" styles='display:none' />
    <gw:textbox id="txtPage" styles="display: none" />
    <gw:textbox id="txtRecords" styles="display: none" />
    <gw:textbox id="txtRowPerPage" text="18" styles="display: none" />
    <gw:textbox id="txttco_itemphoto_pk" styles="display: none" />
    <!------------------------------------------------------------------------------>
</body>
</html>
