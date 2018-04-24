<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Test No Registration</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>

var G1_Mat_PK    = 0,
    G1_Group     = 1,
    G1_Mat_Code  = 2,
    G1_Mat_Name  = 3; 
    
var G2_PK           = 0,
    G2_tco_item_pk  = 1,
    G2_Test_No      = 2,
    G2_Enter_Date   = 3,
    G2_Valid        = 4,
    G2_Change_Date  = 5;
//===============================================================

function BodyInit()
{
    //------------------
	BindingDataList();		
}
//===============================================================

function BindingDataList()
{ 
    txtMatCode.SetEnable(false);
    txtMatName.SetEnable(false);
    
    var data = "";
   
    data = "<%=ESysLib.SetListDataSQL("select a.pk, GRP_CD ||' - ' ||GRP_NM from comm.tco_itemgrp a where a.del_if = 0 and MAT_YN='Y' ")%>||Select ALL"; 
    lstItemGrp.SetDataText(data);
    lstItemGrp.value = '';   
}

//===============================================================

function OnSearch(p)
{
    if (p == 'MAT')
    {
        data_shma00010_1.Call('SELECT');
    }
    else if (p == 'TESTNO')
    {
        data_shma00010.Call('SELECT');            
    }      
}
//===============================================================

function OnRemove()
{
    grdMat.RemoveRow();
}
//===============================================================

function OnNew()
{    
    if ( grdMat.row > 0)
    {
        grdTestNo.AddRow();
        
        grdTestNo.SetGridText( grdTestNo.rows-1, G2_tco_item_pk , grdMat.GetGridData( grdMat.row, G1_Mat_PK ) );
    }
    else
    {
        alert('Please select one Material first.');
    }    
}
//===============================================================

function OnDelete()
{
    grdTestNo.DeleteRow();
}
//===============================================================

function OnUnDelete()
{
    grdTestNo.UnDeleteRow();
}
//===============================================================

function OnSave()
{  
    data_shma00010.Call();    
}
//===============================================================

function OnClickGroup()
{
    if (grdMat.row > 0)
    {        
        txtMatPK.SetDataText(grdMat.GetGridData(grdMat.row, G1_Mat_PK));
        txtMatCode.SetDataText(grdMat.GetGridData(grdMat.row, G1_Mat_Code));
        txtMatName.SetDataText(grdMat.GetGridData(grdMat.row, G1_Mat_Name));
        
        data_shma00010.Call('SELECT');
    }
}
//===============================================================

function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_shma00010_1':
            grdTestNo.ClearData();
        break;
        
//        case 'data_shma00010':
//        break;
    }    
}

//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shma00010_1" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="grid" function="prod.sp_sel_shma00010_1">
                <input bind="grdMat" >
                    <input bind="lstItemGrp" />
                    <input bind="txtMat" />
                </input>
                <output bind="grdMat" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shma00010" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5" function="prod.sp_sel_shma00010" procedure="prod.sp_upd_shma00010">
                <input bind="grdTestNo" >
                    <input bind="txtMatPK" />
                </input>
                <output bind="grdTestNo" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr>
            <td style="width: 30%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Group</td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:list id="lstItemGrp" styles="width: 100%" onchange="OnSearch('MAT')" />
                        </td>
                    </tr>
                    <tr style="height: 1%" align="right">
                        <td style="width: 10%">
                            Mat</td>
                        <td style="width: 89%">
                            <gw:textbox id="txtMat" styles="width: 100%" onenterkey="OnSearch('MAT')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch('MAT')" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdMat" header="_PK|_Group|Mat Code|Mat Name" format="0|0|0|0" aligns="0|0|0|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|0|1500|2500" styles="width:100%;height:100%"
                                oncellclick="OnClickGroup()" param="0,1,2,3,4" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 70%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Mat</td>
                        <td style="width: 65%; white-space: nowrap">
                            <gw:textbox id="txtMatPK" styles="display:none" />
                            <gw:textbox id="txtMatCode" styles="width: 30%" />
                            <gw:textbox id="txtMatName" styles="width: 70%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            </td>
                        <td style="width: 20%; white-space: nowrap">
                            
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch('TESTNO')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="new" alt="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="11">
                            <gw:grid id="grdTestNo" header="_PK|_tco_item_pk|Test No|Enter Date|Valid Y|Change Date"
                                format="0|0|0|4|3|4" aligns="0|0|0|1|0|1" defaults="||||1|" editcol="0|0|1|1|1|1"
                                widths="0|0|2000|1500|1500|1500" styles="width:100%;height:100%"  acceptnulldate />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------------------->
</html>
