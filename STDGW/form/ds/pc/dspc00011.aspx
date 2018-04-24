<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Suplier Price</title>
</head>

<script>
var G1_PK               = 0,
	G1_GRP_CD			= 1,
	G1_GRP_NM 			= 2,
    G1_TCO_ITEM_PK      = 3,
    G1_ITEM_CODE        = 4,
    G1_ITEM_NAME        = 5,    
    G1_ST_PRICE         = 6,
    G1_CCY              = 7,
	G1_START_DATE		= 8,
	G1_END_DATE			= 9,
    G1_DESCRIPTION      = 10;
	
//======================================================
	function BodyInit()
	{
		System.Translate(document);		
		
		SetGriFormat();     
	}

//=====================================================
function SetGriFormat()
{

		var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY 1 " ) %> ";       
		grdMaster.SetComboFormat(G1_CCY,data);  
	 
		data = "<%=ESysLib.SetListDataSQL("select a.pk, lpad('-',level ,'-')||a.grp_cd || ' - ' || a.grp_nm from tlg_it_itemgrp a where a.del_if = 0 and a.use_yn='Y') %>||";     
		lstGroup.SetDataText(data);   
		lstGroup.value="";
	
		var ctr=grdMaster.GetGridControl();
		ctr.ColFormat(G1_ST_PRICE) = "###,###,###,###,###.##";
					  
}
//====================================================    
  function OnSearch()
{  
     dspc00010.Call("SELECT");             
}
//====================================================
function OnDataReceive(obj)
{   
    if(grdMaster.rows > 1)
    {
		grdMaster.SetCellBold(1,G1_ST_PRICE,grdMaster.rows - 1,G1_ST_PRICE,  true); 
		 
		grdMaster.SetCellBgColor( 1, G1_ST_PRICE , grdMaster.rows - 1, G1_ST_PRICE , 0xCCFFFF );    
    } 
}
//=====================================================
function OnNew()
{  
    grdMaster.AddRow();
}
//=====================================================
function OnDelete()
{
    if( grdMaster.row >= 1 )
    { 
        if ( grdMaster.GetGridData( grdMaster.row,G1_PK ) == '' ) 
        {
            grdMaster.RemoveRow();
        }
        else
        {
            grdMaster.DeleteRow();
        }  
    }
}
//======================================================
function OnUndelete()
{
    grdMaster.UnDeleteRow();
}
//=====================================================
function OnSave()
{
    
    dspc00010.Call();
} 


//=========================================================
function CheckInput()
{
    var col,row
	
    col = event.col ;
    row = event.row ;
	
    if(col = col_unit_price)
    {
        var dQuantiy;
        dQuantiy = grdMaster.GetGridData(row,col);
		
        if ( !Number(dQuantiy) )
        {
            grdMaster.SetGridText(row,col,"");
        }
       
    }
} 
//=========================================================
 
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="dspc00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="<%=l_user%>lg_sel_dspc00010"  procedure="<%=l_user%>lg_upd_dspc00010"> 
                <input bind="grdMaster" >
                    <input bind="lstGroup" /> 
                    <input bind="txtItem" />
                </input>     
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" width="5%">
                            <b>Date</b>
                        </td>
                        <td width="15%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
												 
                        <td align="right" width="5%">
                            <b>Item</b>
                        </td>
						<td style="width: 40%">
							<gw:list id="lstGroup" styles="width:100%" onchange="OnSearch(1)" />
						</td>						
                        <td width="15%">
                            <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
						
                        <td width="10%" align='right'>
                            <gw:imgbtn id="btnInvSearch" img="search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="New" id="btnAdd" onclick="OnNew()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="udelete" alt="Undelete" id="btnUnDelete" onclick="OnUndelete()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="save" alt="Save" id="btnUpdate" onclick="OnSave()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td>
                <gw:grid id='grdMaster' 
                header='_pk|_tco_item_pk|Item Code|Item Name|_tco_bus.partner_pk|Partner Name|Leads Day|Payment Term|Payment Method|Deli Type|St Price|CCY|Description|Crt DT|Crt by'
                    format ='0|0|0|0|0|0|1|2|2|2|1|0|0|0|0' 
                    aligns ='0|0|0|0|0|0|0|0|0|0|0|1|0|0|0' 
                    check  ='||||||||||||||'
                    editcol='1|1|0|0|0|0|1|1|1|1|1|0|1|0|0' 
                    widths ='0|0|1200|2000|0|2500|1200|1500|1700|1500|1200|1500|1000|1500|1500'
                    sorting='T' styles='width:100%; height:100%' oncelldblclick='OnGridCellDblClick(this)'' />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
    <!------------------------------------------->
</body>
</html>
