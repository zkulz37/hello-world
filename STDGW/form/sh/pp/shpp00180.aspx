<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Hard-Years Product Planning(Receiving-GEL)</title>
</head>
<%  ESysLib.SetUser("sale")
  
%>

<script>

    var G_pk            =0,
        G_IO_Date       =1,
        G_SCR_NO        =2,
        G_SCR_NAME      =3,
        G_ISSUE_PROCESS =4,
        G_ISSUE_NAME    =5,
        G_STOCK         =6,
        G_ISSUE         =7;
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    data_shpp00180.Call("SELECT");
    BindingDataList();
    OnFormatGrid();
}
//-----------------------------------------------------------------------------------------------
function OnSearch()
{
    data_shpp00180.Call("SELECT");
}
//----------------------------------------------------------------------------------------------
function OnDataReceive (obj)
{
    switch(obj.id)
    {
        case 'data_shpp00180_1':
            if(idGrid_1.rows>1)
            {
                idGrid.SetGridText(row,G_STOCK,idGrid_1.GetGridData(1,0));
            } 
            else
            {
                idGrid.SetGridText(row,G_STOCK,"");
            }
        break;
    }
}
//-----------------------------------------------------------------------------------------------
function OnFormatGrid()
 {
    var ctrl ;
    //=================================
    ctrl = idGrid.GetGridControl();    
    ctrl.ColFormat(G_STOCK)   = "###,###,###,###,###.###,###";
    ctrl.ColFormat(G_ISSUE)   = "###,###,###,###,###.###,###";
    //-----------------------------------------------------
	
 }
//-----------------------------------------------------------------------------------------------
function BindingDataList()
{
     var data ;    
     data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code4('LGMF0140') FROM DUAL")%>||All"; 
     lstIssueType.SetDataText(data);
     lstIssueType.value="";
     
     var data = "";
     data = "<%=ESysLib.SetGridColumnDataSQL(" SELECT   a.code, a.code||' - '||a.code_nm FROM sale.lg_code a, sale.lg_code_group b WHERE a.del_if = 0 AND a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGMF0130' ORDER BY a.ord  " ) %> ";       
     idGrid.SetComboFormat(G_SCR_NO ,data);
     
     var data = "";
     data = "<%=ESysLib.SetGridColumnDataSQL(" SELECT   a.code, a.code||' - '||a.code_nm FROM sale.lg_code a, sale.lg_code_group b WHERE a.del_if = 0 AND a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGIV0050' ORDER BY a.ord  " ) %> ";       
     idGrid.SetComboFormat(G_ISSUE_PROCESS ,data);
}
//-----------------------------------------------------------------------------------------------
function OnAddNew()
{
    idGrid.AddRow();
    //idGrid.SetGridText(idGrid.rows-1,G_IO_Date,dtInstDate.value);
}
//-----------------------------------------------------------------------------------------------
function OnDelete()
{
    var ctrl = idGrid.GetGridControl();
	var row  = ctrl.row;
    if ( idGrid.GetGridData( ctrl.row, G_pk ) == "" ) 
	{						
        				
		idGrid.RemoveRow();					
	}
        			
	else 
	{
		if ( confirm( "Do you want to mark this row to delete?" ) ) 
		{
			idGrid.DeleteRow();
		}
	}
}
//----------------------------------------------------------------------------------------------
function OnGriddblClick()
{
//    var row,col
//            
//    col = event.col ;
//    row = event.row ;
//            
//    if ( col == G_Matl_Code || col == G_Matl_Name )
//    {
//        var path = System.RootURL + '/form/fp/ab/fpab00220.aspx?code_group=LGMF0130';
//        var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');                    
//        if ( obj != null )
//        {           
//		    idGrid.SetGridText( row,G_Matl_Code,   obj[1]);
//            idGrid.SetGridText( row,G_Matl_Name,   obj[3]);	        
//  		 }
//    }
//    if ( col == G_Lot_No)
//    {
//        var path = System.RootURL + '/form/sh/ab/shab00180.aspx';
//        var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');                    
////        if ( obj != null )
////        {           
////		    idGrid.SetGridText( row,G_Matl_Code,   obj[1]);
////            idGrid.SetGridText( row,G_Matl_Name,   obj[3]);	        
////  		 }
//    }
}
//---------------------------------------------------------------------------------
function OnSave()
{
    data_shpp00180.Call();
}
//---------------------------------------------------------------------------------
function Calculate()
{
    var col=event.col;
    var row=event.row;
    if(col==G_Qty_Printed||col==G_Qty_Unprinted)
    {
        var b= (idGrid.GetGridData(row,G_Qty_Printed)+idGrid.GetGridData(row,G_Qty_Unprinted))*idGrid.GetGridData(row,G_D_Weight)/1000000;
        idGrid.SetGridText( idGrid.row, G_Weight,               b); 
    }
}
//---------------------------------------------------------------------------------
function OnPopUp()
{
             
}
//---------------------------------------------------------------------------------
var col;
var row;
function OnLoadData()
{
    col=event.col;
    row=event.row;
    if(col==G_SCR_NO)
    {
        txtSCR_NO.text=idGrid.GetGridData(row,G_SCR_NO);
        data_shpp00180_1.Call("SELECT");
    }
}
//======================================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_shpp00180" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="prod.sp_sel_shpp00180" parameter="0,1,2,3,4,5,6,7" procedure="PROD.sp_upd_shpp00180" > 
                  <input bind="idGrid" > 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="lstIssueType" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="data_shpp00180_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="2" type="grid" function="prod.sp_sel_shpp00180_1"  > 
                  <input bind="idGrid_1" > 
                    <input bind="txtSCR_NO" />
                  </input> 
                <output bind="idGrid_1" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 5%">
            <td style="white-space: nowrap">
                Issue Type
            </td>
            <td style="width: 40%; white-space: nowrap" align="left">
                <gw:list id="lstIssueType" styles="width:100%" onchange="OnSearch()" />
            </td>
            <td style="width: 10%" align="left">
                Period
            </td>
            <td style="width: 40%; white-space: nowrap" align="left">
                <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch()" />
                ~
                <gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('Cap')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="new" alt="New" onclick="OnAddNew()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="Udelete" alt="UnDelete" id="btnUDeleteCap" onclick="OnUnDelete(grdCap)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
            </td>
        </tr>
        <tr style="height: 50%">
            <td colspan="9">
                <gw:grid id='idGrid' header='_PK|Issue Date|Malt Code/Name|_SCR_NAME|Issue Process/Name|_ROUT_NAME|Stock(Kg)|Issue(Kg)'
                    format='0|4|0|0|0|0|-6|-6' aligns='0|0|0|0|0|0|0|0' check='|0|0|||||0n' editcol='1|1|1|0|1|0|0|1'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%'
                    acceptnulldate='T' onafteredit="OnLoadData()" />
                <gw:grid id='idGrid_1' header='PRT_WGT' format='0' aligns='0' check='' editcol='1'
                    widths='1000' sorting='T' autosize='T' styles='width:100%; height:460;display:none' />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtColpack_M_PK" styles="width: 100%;display:none" />
<gw:textbox id="txtSCR_NO" styles="width: 100%;display:none" />
</html>
