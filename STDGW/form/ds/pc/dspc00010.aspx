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
    G1_ITEM_PK      	= 1,
    G1_ITEM_CODE        = 2,
    G1_ITEM_NAME        = 3,
    G1_PARTNER_PK		= 4
    G1_PARTNER_NAME     = 5,
	G1_ST_PRICE         = 6,
    G1_CCY              = 7,
	G1_PO_DEPT			= 8,
    G1_LEADS_DAY        = 9,
    G1_PAYMENT_TERM     = 10,
    G1_PAYMENT_METHOD   = 11,
    G1_DELI_TYPE        = 12,  
	G1_START_DATE		= 13,
	G1_END_DATE			= 14,
    G1_REMARK      		= 15,	
	G1_CRT_DT      		= 16;
	
//======================================================
	function BodyInit()
	{
		System.Translate(document);		
		
		SetGriFormat();     
	}

//=====================================================
function SetGriFormat()
{

		var  data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0120' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " ) %> ";       
		grdMaster.SetComboFormat(G1_PAYMENT_TERM,data); 
		
		data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0110' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " ) %> ";       
		grdMaster.SetComboFormat(G1_PAYMENT_METHOD,data); 
		
		data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGPO2002' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " ) %> ";       
		grdMaster.SetComboFormat(G1_DELI_TYPE,data);     
		
		data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY 1 " ) %> ";       
		grdMaster.SetComboFormat(G1_CCY,data);

		data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY 1 " ) %> ";       
		grdMaster.SetComboFormat(G1_CCY,data);  

		data = "<%=ESysLib.SetListDataSQL("select pk,DEPT_ID || ' * '|| DEPT_NAME from TLG_PO_DEPT a where  del_if=0 order by DEPT_ID")%>"; 
		lstDept.SetDataText(data);
		lstDept.SetDataText(data+"||Select ALL");
		lstDept.value=""; 	

		data = "<%=ESysLib.SetGridColumnDataSQL(" select pk, DEPT_ID || ' * '|| DEPT_NAME from TLG_PO_DEPT a where  del_if=0 order by DEPT_ID " ) %>|#;";       
		grdMaster.SetComboFormat(G1_PO_DEPT,data);		
		
		var ctr=grdMaster.GetGridControl();
		ctr.ColFormat(G1_ST_PRICE) = "###,###,###,###,###.##";
   
}

//====================================================    
function OnSearch()
{  
     data_dspc00010.Call("SELECT");             
}

//====================================================
function OnDataReceive(obj)
{   
    if ( grdMaster.rows > 1 )
    {
		grdMaster.SetCellBold(	1,	G1_ST_PRICE,		grdMaster.rows - 1,	G1_ST_PRICE,  		true); 

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
    if ( confirm("Do you want to save data?") )
	{
		data_dspc00010.Call();
	}	   
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
        if(!Number(dQuantiy))
        {
            grdMaster.SetGridText(row,col,"");
        }
       
    }
} 
//=========================================================
function OnGridCellDblClick()
{
    var row,col 
    
    row = event.row;
    col = event.col;
    
    switch (col)
    {       
        case G1_ITEM_CODE:
        {
            var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=Y|Y|Y|Y|Y|Y&tco_stitem_pk='+ grdMaster.GetGridData(row,G1_ITEM_PK);
            var object  = window.showModalDialog(  path , this , 'resizable:yes;toolbar=no;dialogWidth:800px;dialogHeight:600px');
            if ( object != null )
              {
                    grdMaster.SetGridText( row, G1_ITEM_PK, object[0]);
                    grdMaster.SetGridText( row, G1_ITEM_CODE  , object[1]);
                    grdMaster.SetGridText( row, G1_ITEM_NAME  , object[2]);
              }
        }
        break;    
		
        case G1_ITEM_NAME:
        {
            var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=Y|Y|Y|Y|Y|Y&tco_stitem_pk='+ grdMaster.GetGridData(row,G1_ITEM_PK);
            var object  = window.showModalDialog(  path , this , 'resizable:yes;toolbar=no;dialogWidth:800px;dialogHeight:600px');
            if ( object != null )
              {
                    grdMaster.SetGridText( row, G1_ITEM_PK, object[0]);
                    grdMaster.SetGridText( row, G1_ITEM_CODE  , object[1]);
                    grdMaster.SetGridText( row, G1_ITEM_NAME  , object[2]);
              }
        }
        break;  
		
        case  G1_PARTNER_NAME:
        {
            var path = System.RootURL + '/form/fp/ab/fpab00120.aspx';
            var object  = window.showModalDialog(  path , this , 'resizable:yes;toolbar=no;dialogWidth:800px;dialogHeight:600px');
            if ( object != null )
              {
                    grdMaster.SetGridText( row, G1_PARTNER_PK , object[0]);
                    //grdMaster.SetGridText( row, col_partner_id , object[1]);
                    grdMaster.SetGridText( row, G1_PARTNER_NAME ,   object[2]);
                    
              }
        } 
        break;      
    }
    
}

//====================================================================================

function OnPopUp(pos)
{
	switch(pos)
	{
		case 'DAILY':
			var path = System.RootURL + '/form/ds/pc/dspc00011.aspx';
            var object = System.OpenModal( path ,550 , 600 ,  'resizable:yes;status:yes',this); 
		break;
	}
}

//====================================================================================
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dspc00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="<%=l_user%>lg_sel_dspc00010"  procedure="<%=l_user%>lg_upd_dspc00010"> 
                <input bind="grdMaster" >
                    <input bind="txtBuspartner" /> 
                    <input bind="txtItem" />
					<input bind="lstDept" />
					<input bind="dtDate" />
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
                            <b>Item</b>
                        </td>
                        <td width="20%">
                            <gw:textbox id="txtItem" csstype="mandatory" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
						
						<td align="right" width="5%">
                            <b>Partner</b>
                        </td>
                        <td width="20%">
                            <gw:textbox id="txtBuspartner" csstype="mandatory" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
						
						
						<td align="right" style="width:5%;white-space: nowrap" >
                            <b>P/O Dept</b>
                        </td>
                        <td width="20%">
                            <gw:list id="lstDept" styles='width:100%;' />
                        </td>
						
						<td align="right" style="width:5%;white-space: nowrap" >
                            <b>Date</b>
                        </td>
                        <td width="10%">
                            <gw:datebox id="dtDate" lang="1" width="10%" />      
                        </td>
						
						<td width="4%"> </td>
						<td width="1%" align='right'>
                            <gw:imgbtn id="btnPopUp" img="popup" onclick="OnPopUp('DAILY')" />
                        </td>						
                        <td width="1%" align='right'>
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
					header='_pk|_item_pk|Item Code|Item Name|_partner_pk|Partner Name|S/T Price|CCY|P/O Dept|Leads Day|Payment Term|Payment Method|Deli Type|Start Date|End Date|Remark|Mod By'
                    format ='0|0|0|0|0|0|0|0|0|0|0|0|0|4|4|0|0' 
                    aligns ='0|0|0|0|0|0|3|1|0|3|0|0|0|1|1|0|0'                 
                    editcol='1|1|0|0|0|0|1|1|1|1|1|1|1|0|0|1|0' 
                    widths ='0|0|1200|2000|0|2500|1500|800|2500|1500|1500|1500|1500|1200|1200|1000|1500'
                    sorting='T' styles='width:100%; height:100%' 
					oncelldblclick='OnGridCellDblClick(this)'
					acceptnulldate="T"	
					/>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
    <!------------------------------------------->
</body>
</html>
