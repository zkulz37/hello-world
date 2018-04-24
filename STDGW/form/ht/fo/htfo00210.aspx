<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser("CRM")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Room Property Management</title>
</head>

<script>
var COL_M_NO=0,
	COL_M_ROOM_PK=1,
	COL_M_ITEM_TYPE=2,
	COL_M_PK=3,
    COL_M_TCO_ITEM_PK=4,
    COL_M_ITEM_CODE=5,
    COL_M_ITEM_NAME=6,
    COL_M_UOM=7,
    COL_M_ITEM_QTY=8,
    COL_M_STATUS=9,
    COL_M_CHECK_DATE=10,
    COL_M_CHECK_BY_PK=11,
    COL_M_CHECK_BY=12,
    COL_M_UNIT_PRICE=13,
    COL_M_DESCRIPTION=14,
    COL_M_USE_YN=15;
function BodyInit()
{
    var data ="#10;GOOD|#20;BROKEN|#30;OK|#40;LOST";
        grdGroupEntry.SetComboFormat(COL_M_STATUS,data);
		data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='ITEMTYPE'")%>|ALL|Select All";
	    lstItemType.SetDataText(data);
		lstItemType.value='ALL';
		data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='ITEMTYPE'")%>";
		grdGroupEntry.SetComboFormat(COL_M_ITEM_TYPE, data);
		data = "<%=ESysLib.SetListDataSQL("SELECT pk, room_no FROM  crm.tht_room WHERE DEL_IF=0  order by room_no")%>|ALL|Select All";
	    lstRoomNo.SetDataText(data);
		lstRoomNo.value='ALL';
		data = "<%=ESysLib.SetGridColumnDataSQL("SELECT pk, room_no FROM  crm.tht_room WHERE DEL_IF=0  order by room_no")%>";
		grdGroupEntry.SetComboFormat(COL_M_ROOM_PK, data);
        OnSearch();
}
function OnSearch()
{
    dsoGroupEntry.Call("SELECT");
}
function OnDelete()
{
    if(confirm('Do you want to delete ?'))
        {
            grdGroupEntry.DeleteRow(); 
            dsoGroupEntry.Call();
        }    
}
function OnNew()
{
   if(lstRoomNo.GetData() =='ALL' || lstItemType.GetData() =='ALL')
   {
		alert("Please, choose room no and item type.");
		return false;
   }
   else
   {
		var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';//purchase_yn=Y
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {                    
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                            grdGroupEntry.AddRow();                            
                            grdGroupEntry.SetGridText( grdGroupEntry.rows-1, COL_M_TCO_ITEM_PK,    arrTemp[0]);//item_pk	    
                            grdGroupEntry.SetGridText( grdGroupEntry.rows-1, COL_M_ITEM_CODE,  arrTemp[1]);//item_code	    
                            grdGroupEntry.SetGridText( grdGroupEntry.rows-1, COL_M_ITEM_NAME,  arrTemp[2]);//item_name	    
                            grdGroupEntry.SetGridText( grdGroupEntry.rows-1, COL_M_UOM, arrTemp[5]);//item_uom  
                            grdGroupEntry.SetGridText( grdGroupEntry.rows-1, COL_M_UNIT_PRICE, arrTemp[7]);//unit price 
                            grdGroupEntry.SetGridText( grdGroupEntry.rows-1, COL_M_USE_YN, -1);//use_yn  
							grdGroupEntry.SetGridText( grdGroupEntry.rows-1, COL_M_ITEM_TYPE,lstItemType.GetData());//item type  
							grdGroupEntry.SetGridText( grdGroupEntry.rows-1, COL_M_ROOM_PK,lstRoomNo.GetData());//room pk
							grdGroupEntry.SetGridText( grdGroupEntry.rows-1, COL_M_NO,grdGroupEntry.rows-1);//rum no
                    }		            
             }      
    }
	
}
function OnShowPopup(obj)
{
    if(obj.col==COL_M_CHECK_BY)//employee
    {
        var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                grdGroupEntry.SetGridText( grdGroupEntry.row, COL_M_CHECK_BY_PK,obj[0]);
                grdGroupEntry.SetGridText( grdGroupEntry.row, COL_M_CHECK_BY, obj[2]);
            }
    }
}
function OnSave()
{
    if(CheckDataIsValid())
    {          
        dsoGroupEntry.Call();    
    }
}
function CheckDataIsValid()
{
    for(var i=1;i<grdGroupEntry.rows;i++)
    {
        if(grdGroupEntry.GetGridData(i,COL_M_ITEM_CODE)=="" && grdGroupEntry.GetGridData(i,COL_M_ITEM_NAME))
        {
            alert("Please input item code and item name at row "+i);
            return false;
        }
        else if(grdGroupEntry.GetGridData(i,COL_M_ITEM_QTY)=="")
        {
            alert("Please input item quantity at row "+i);
            return false;
        } 
        else if(grdGroupEntry.GetGridData(i,COL_M_STATUS)=="")
        {
            alert("Please input item status at row "+i);
            return false;
        } 
        else if(grdGroupEntry.GetGridData(i,COL_M_CHECK_BY)=="")
        {
            alert("Please input check by at row "+i);
            return false;
        } 
        else if(grdGroupEntry.GetGridData(i,COL_M_UNIT_PRICE)=="" || grdGroupEntry.GetGridData(i,COL_M_UNIT_PRICE)=="0" || grdGroupEntry.GetGridData(i,COL_M_UNIT_PRICE)=="0.00")
        {
            alert("Please input unit item price at row "+i);
            return false;
        } 
    }
   return true;
}
function OnDataReceive(obj)
{
	if(obj.id=='dsoGroupEntry')
	{
		var tt_qty = 0;
				 for (row = 1; row < grdGroupEntry.rows; row++)
					{
						tt_qty=tt_qty + Number(grdGroupEntry.GetGridData(row, 8));//rate amt
					}
					txtTotalQty.text = tt_qty;
	}
}
</script>

<body bgcolor='#F5F8FF'>
    <gw:data id="dsoGroupEntry" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="CRM.sp_sel_htfo00210" procedure="CRM.sp_upd_htfo00210">  
                <input bind="grdGroupEntry"   >  
                    <input bind="lstRoomNo" />  
                    <input bind="lstItemType" />
                    <input bind="txtItemCodeName" />	 															
                </input> 
                <output bind="grdGroupEntry" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
						<td width="5%">
                            Room#
                        </td>
                        <td width="8%">
                           <gw:list id="lstRoomNo" onchange="OnSearch()" />
						 </td>
                        <td width="17%"  align="right">
                            Item Type
                        </td>
                        <td width="15%">
                           <gw:list id="lstItemType" onchange="OnSearch()" />
						 </td>
                        <td width="7%"  align="right">
                           Item</td>
                        <td width="15%">
                            <gw:textbox id="txtItemCodeName" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
						<td width="7%"  align="right">
                           Total Qty</td>
                        <td width="7%">
                            <gw:textbox id="txtTotalQty" styles="width:100%" readonly="T"  type="number" format="###,###" />
                        </td>
                        <td width="10%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="12">
                            <gw:grid id='grdGroupEntry' header='No|Room No|Item Type|_pk|_tco_item_pk|Item Code|Item Name|Uom|Item Qty|Status|Check Date|_CHECK_BY_PK|Check By|Unit Price|Description|Use YN'
                                format='0|0|0|0|0|0|0|0|0|0|4|0|0|-2|0|3' aligns='0|0|0|0|0|0|0|1|3|0|0|0|0|0|0|0' 
                                defaults='|||||||||||||||' editcol='0|1|1|1|1|0|0|1|1|1|1|1|0|1|1|1'
                                widths='1000|1000|1000|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500' 
                                sorting='T' styles='width:100%; height:100%' autosize="T" oncelldblclick="OnShowPopup(this)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
