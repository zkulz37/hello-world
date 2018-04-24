<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Select Item</title>
</head>
<%  ESysLib.SetUser("acnt") %>

<script>

var iCols_tco_item_pk       = 0 ;
var iColsPrice              = 7;
var vPage = 0 ;
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    txtPLID.SetEnable(false);
	txtPLName.SetEnable(false);	
	
	var p_yn = "<%=Request.querystring("purchase_yn")%>";
    var data = "";  
          
	OnFormatGrid();
	//setPage(vPage)
}
//------------------------------------------------------------------------------------------------
function OnFormatGrid()
{
    var trl;
    trl = idGrid.GetGridControl();	
    trl.ColFormat(iColsPrice)           = "###,###,###,###,###.##";    
    trl = idGrid2.GetGridControl();	
    trl.ColFormat(iColsPrice)           = "###,###,###,###,###.##";        
}
//------------------------------------------------------------------------------------------------
function TabPopUp(fnameFile)
{
	var fpath = System.RootURL + "/form/gf/co/" + fnameFile + "?comm_nm="; 	
	var aValue  = window.showModalDialog(  fpath , this , 'resizable:yes;toolbar=no;dialogWidth:45;dialogHeight:32');	

	if ( aValue != null )  
	{
	    txtPLName.text = aValue[2];
		txtPLID.text = aValue[1];					
		txtPLPK.text = aValue[0];
	}
}
//-----------------------------------------------------------------------------------------------
function OnSearch(obj)
{ 
    switch(obj)
    {
        case 1:
			dsoGetItem.Call("SELECT");
        break;
        case 2:
        break;
    }   
}
//-----------------------------------------------------------------------------------------------
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   if(oGrid.rows > 1)
   {   
      for(var i = 1;i < oGrid.rows; i++)
      {
         var arrTemp = new Array();
         
         for(var j = 1; j<oGrid.cols; j++)
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
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData( idGrid2.row, iCols_tco_item_pk);
    
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
      if(p_oGrid.GetGridData( i, iCols_tco_item_pk) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid, p_value)
{
  for(var i = 1; i < p_oGrid.rows; i++)
   {
      if(p_oGrid.GetGridData(i, iCols_tco_item_pk) == p_value)
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
    var col_val = oGrid.GetGridData(event.row, iCols_tco_item_pk );    
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
  //countItem();
}
//------------------------------------------------------------------------------------------------
/*function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}
*/
//--------------------------------------------------------------------
var currentPage = 0;
//----------------------Page divide-----------------------------------
/*
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
        var page =  obj.innerText
        txtPage.text = page
        currentPage = page
        OnSearch(2)
    }
}
*/
//---------------------------------------------------------------------------------------------------
/*
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
*/
/*function PrevPage()
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
     
}*/
/*function NextPage()
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
    
}*/
//----------------------------------------------------------------------
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
//----------------------------------------------------------------------
function OnReceiveData(iObj)
{
	switch(iObj.id)
	{
		case "dsoGetItem":
		break ;
	}
}
//----------------------------------------------------------------------
function OnCopy()
{
	var i, j;
	for(i = 1; i < idGrid.rows; i++)
	{
		if(idGrid.GetGridData(i, 0)=="-1")
		{
			idGrid2.AddRow();
			for(j = 1; j < idGrid.cols ; j++)
			{
				idGrid2.SetGridText(idGrid2.rows - 1, j, idGrid.GetGridData(i, j));
			}
		}
	}	
	j = 1;	
	i = j;
	while(i >= j && i < idGrid.rows)
	{
		if(idGrid.GetGridData(i, 0)=='-1')
		{
			idGrid.RemoveRowAt(i);
			j = i;
		}
		else
		{
			i++;
		}
	}			
}
//----------------------------------------------------------------------
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="dsoGetItem" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="acnt.sp_sel_fmgf00340_vendor" > 
                  <input bind="idGrid" >                     
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
					<input bind="txtPLPK" />
					<input bind="txtSlipNo" />
					<input bind="txtItem" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
        <tr style="height: 5%">
			<td colspan="7" >
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td width="5%" align="right">From date&nbsp;</td>
						<td width="15%" align="left"><gw:datebox id="dtFrom" lang="1" styles="width:100%;"/></td>
						<td width="2%" align="left">~</td>
						<td width="15%" align="left"><gw:datebox id="dtTo" lang="1" styles="width:100%;"/></td>
						<td width="5%" align="right">
							<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch(1)" />
						</td>
						<td width="5%" align="right">
							<gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
						</td>						
						<td width="53%" align="left"><gw:icon id="btnCopy" alt="Copy" text="Copy" onclick="OnCopy()" /></td>
					</tr>
				</table>
			</td>
        </tr>	
        <tr style="height: 5%">
            <td width="5%" align="right">
                <b style="color: #1b2ff2; cursor: hand" onclick="TabPopUp('gfco002005.aspx')">PL&nbsp;</b>
            </td>
            <td width="10%">
                <gw:textbox id="txtPLID" styles="width:100%" />
            </td>
            <td width="20%">
                <gw:textbox id="txtPLName" styles="width:100%" />
            </td>
            <td width="5%" align="right">
                <b>Slip No&nbsp;</b>
            </td>
            <td width="20%">
                <gw:textbox id="txtSlipNo" styles="width:100%" onenterkey="OnSearch(1)" />
            </td>
            <td width="5%" align="right">
                <b>Item&nbsp;</b>
            </td>
            <td width="25%">
                <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch(1)" />
            </td>
        </tr>
        <tr style="height: 40%">
            <td colspan="13">
                <gw:grid id="idGrid" 
					header="|_PK|Item Code|Item Name|_tac_abacctcode_pk_expense|Slip No|Unit|Quantity|Warehouse|PL Code|PL Name|_PL_PK|_tin_stocktr_pk|_pur_type|_volume|_tin_warehouse_pk|_partner_pk|_partner_id|_partner_name|Description|_tac_abacctcode_pk|Acc Code|Acc Name|_acc_cd_exp|_acc_nm_exp|Unit Price|Trans Amt|Book Amt"
                    format="3|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1" 
					aligns="1|0|0|0|0|0|1|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|3"
                    defaults="||||||||||||||||||||||||||||" 
					editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    widths="500|0|2000|4000|0|2500|800|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					styles="width:100%; height:100%"
                    sorting="T" />
            </td>
        </tr>
        <tr style="height: 5%">
            <td colspan="2" align="center">
                <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
            </td>
            <td colspan="11" align="right">
                <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
            </td>
        </tr>
        <tr style="height: 40%">
            <td colspan="13">
                <gw:grid id="idGrid2" 
					header="|_PK|Item Code|Item Name|_tac_abacctcode_pk_expense|Slip No|Unit|Quantity|Warehouse|PL Code|PL Name|_PL_PK|_tin_stocktr_pk|_pur_type|_volume|_tin_warehouse_pk|_partner_pk|_partner_id|_partner_name|Description|_tac_abacctcode_pk|Acc Code|Acc Name|_acc_cd_exp|_acc_nm_exp|Unit Price|Trans Amt|Book Amt"
                    format="3|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					aligns="1|0|0|0|0|0|1|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|3"
                    defaults="||||||||||||||||||||||||||||" 
					editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    widths="500|0|2000|4000|0|2500|800|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					styles="width:100%; height:100%"
                    sorting="T" />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
    <gw:textbox id="txtPLPK" style="display: none" />
    <gw:textbox id="txtRecords" styles="display: none" />
    <!---------------------------------------------------------------->
</body>
</html>
