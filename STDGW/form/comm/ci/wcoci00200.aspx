<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("comm")%>

<script>
function BodyInit()
{
	<%=ESysLib.SetGridColumnComboFormat("grdSpecG", 1, "select pk, org_nm from tco_organization")%>;	
	OnSearch('GROUP');
}

function OnSearch(p)
{
    if (p == 'GROUP')
    {
        idData_tco_specgrp.Call('SELECT');
    }
    else
    {
        idData_tco_spec.Call('SELECT');            
    }      
}

function OnRemove()
{
    grdSpecG.RemoveRow();
}

function OnNew()
{
    var objCtrl = grdSpecC.GetGridControl();
    
    if (grdSpecG.row > 0)
    {
        grdSpecC.AddRow();              
        objCtrl.TextMatrix(objCtrl.Rows -1 ,9) = grdSpecG.GetGridData(grdSpecG.row, 0);
    }
    else
    {
        alert('Please select one Group first.');
    }    
}

function OnDelete()
{
    grdSpecC.DeleteRow();
}

function OnUnDelete()
{
    grdSpecC.UnDeleteRow();
}

function OnSave()
{  
    idData_tco_spec.Call();    
}

function OnClickGroup()
{
    if (grdSpecG.row > 0)
    {
        tco_specgrp_pk.text = grdSpecG.GetGridData(grdSpecG.row, 0);        
        idData_tco_spec.Call('SELECT');
    }
}

function onRowClick()
{

    if (grdSpecC.col==6)
    {
        var fpath = System.RootURL + "/form/ag/ec/agec00010_p.aspx";
        aValue = System.OpenModal( fpath , 600 , 350, 'resizable:yes;status:yes');
        if ( aValue != null )
        {       
            grdSpecC.SetGridText(grdSpecC.row,6,aValue[2]); 
            grdSpecC.SetGridText(grdSpecC.row,7,aValue[0]);  
        } 
    }
   	
}

</script>

<html>
<head runat="server">
    <title>Item Spec Code Entry</title>
</head>
<body>
<gw:data id="idData_tco_specgrp">
    <xml>
        <dso id="1" type="grid" function="comm.sp_get_tco_specgrp">
            <input bind="grdSpecG" >
                <input bind="txtGName" />                
            </input>
            <output bind="grdSpecG" />
        </dso>
    </xml>
</gw:data>

<gw:data id="idData_tco_spec">
    <xml>
        <dso id="2" type="grid" parameter="0,1,2,3,4,5,7,8,9" function="comm.sp_get_tco_spec" procedure="comm.sp_process_tco_spec">
            <input bind="grdSpecC" >
                <input bind="txtCID" />
                <input bind="txtCName" />
                <input bind="ckActive" />
                <input bind="tco_specgrp_pk" />
            </input>
            <output bind="grdSpecC" />
        </dso>
    </xml>
</gw:data>

    <table width="100%" style="background-color: #BDE9FF" cellspacing="2">
        <tr style="background-color: White">
            <td width="30%">
                <table width="100%">
                    <tr>
                        <td width="35%" align="right"><b>S.Group Name</b></td>
                        <td width="50%"><gw:textbox id="txtGName" styles="width: 90%" onenterkey="OnSearch('GROUP')" /></td>
                        <td width="15%"><gw:imgBtn img="search" alt="Search" onclick ="OnSearch('GROUP')"/></td>
                    </tr>
                </table>
            </td>
            <td width="70%">
                <table width="100%">
                    <tr>
                        <td width="15%" align="right"><b>S.Code ID</b></td>
                        <td width="20%"><gw:textbox id="txtCID" styles="width: 90%" onenterkey="OnSearch('CODE')" /></td>
                        <td width="15%" align="right"><b>S.Code Name</b></td>
                        <td width="32%"><gw:textbox id="txtCName" styles="width: 90%" onenterkey="OnSearch('CODE')" /></td>
                        <td width="3%"><gw:imgBtn img="search" alt="Search" onclick ="OnSearch('CODE')"/></td>
                        <td width="3%"><gw:imgBtn img="cancel" alt="Remove Row" onclick ="OnRemove()"/></td>
                        <td width="3%"><gw:imgBtn img="new" alt="New" onclick ="OnNew()"/></td>
                        <td width="3%"><gw:imgBtn img="delete" alt="Delete" onclick ="OnDelete()"/></td>
                        <td width="3%"><gw:imgBtn img="udelete" alt="UnDelete" onclick ="OnUnDelete()"/></td>
                        <td width="3%"><gw:imgBtn img="save" alt="Save" onclick ="OnSave()"/></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="background-color: White">
            <td width="30%">
                <gw:grid
                id="grdSpecG"
                header="_PK|Organization|Group(EG)|Group(Local)|Group(Foreign)"
                format="0|0|0|0|0"
                aligns="0|0|0|0|0"
                defaults="||||"
                editcol="0|0|0|0|0"
                widths="0|1500|1000|1500|1200"
                styles="width:100%;height:430"
                oncellclick="OnClickGroup()"
                param="0,1,2,3,4" />
            </td>
            
            <td width="70%">
                <gw:grid
                id="grdSpecC"
                header="_PK|S.Code ID|S.Code (EN)|S.Code(Local)|S.Code(Foreign)|Active|Partner name|_tco_buspartner_pk|Remark|_tco_specgrp_pk"
                format="0|0|0|0|0|3|2|0|0|0"
                aligns="0|0|0|0|0|0|0|0|0|0"
                defaults="|||||-1||||"
                editcol="0|1|1|1|1|1|1|1|1|1"
                widths="0|1100|1500|1500|1500|1000|2000|2000|2000|0"
                styles="width:100%;height:430"  
                oncelldblclick="onRowClick()"              
                param="0,1,2,3,4,5,6,7,8,9" />
            </td>
        </tr>
    </table>
</body>
<gw:checkbox id="ckActive" value="T" styles="display: none" />
<gw:textbox id="tco_specgrp_pk" styles="display: none" />

</html>
