<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("comm")%>

<script>
function BodyInit()
{
	<%=ESysLib.SetGridColumnComboFormat("grdSpecG", 4, "select a.pk, a.org_id || '-' || a.org_nm from tco_organization a where a.del_if = 0 and a.use_yn = 'Y' order by org_id")%>;
	OnSearch('GROUP');
}

function OnSearch(p)
{
    if (p == 'GROUP')
        idData_tco_specgrp.Call('SELECT');
}

function OnRemove()
{
    grdSpecG.RemoveRow();
}

function OnNew()
{
    if (grdSpecG.row > 0)
    {
        grdSpecC.AddRow();
    }
    else
        alert('Please select one Group first.');
}

function OnDelete()
{
    grdSpecG.DeleteRow();
}

function OnUnDelete()
{
    grdSpecG.UnDeleteRow();
}

function OnSave()
{
    for (row = 1; row < grdSpecG.rows; row++)
    {
        
    }
    
    idData_tco_specgrp.Call();
}

function OnClickGroup()
{
    if (grdSpecG.row > 0)
    {
        tco_specgrp_pk.text = grdSpecG.GetGridData(grdSpecG.row, 0);
        idData_tco_spec.Call('SELECT');
    }
}

</script>

<html>
<head runat="server">
    <title>Item Spec Code Entry</title>
</head>
<body>
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
                <gw:data id="idData_tco_specgrp">
                    <xml>
                        <dso id="1" type="grid" function="comm.sp_get_tco_specgrp">
                            <input bind="grdSpecG" >
                                <input bind="txtGName" />
                                <input bind="ckActive" />
                            </input>
                            <output bind="grdSpecG" />
                        </dso>
                    </xml>
                </gw:data>
                <gw:grid
                id="grdSpecG"
                header="_PK|Group(EN)|Group(Local)|Group(Foreign)"
                format="0|0|0|0"
                aligns="0|0|0|0"
                defaults="|||"
                editcol="0|1|1|1"
                widths="0|2000|2000|0"
                styles="width:100%;height:430"
                oncellclick="OnClickGroup()"
                param="0,1,2,3" />
            </td>
            
            <td width="70%">
                <gw:data id="idData_tco_spec">
                    <xml>
                        <dso id="1" type="grid" function="comm.sp_get_tco_spec" procedure="comm.sp_process_tco_spec">
                            <input bind="grdSpecC" >
                                <input bind="txtCID" />
                                <input bind="txtCName" />
                                <input bind="tco_specgrp_pk" />
                            </input>
                            <output bind="grdSpecC" />
                        </dso>
                    </xml>
                </gw:data>
                <gw:grid
                id="grdSpecC"
                header="_PK|S.Code ID|S.Code (EN)|S.Code(Local)|S.Code(Foreign)|Active|Remark|tco_specgrp"
                format="0|0|0|0|0|3|0|0"
                aligns="0|0|0|0|0|0|0|0"
                defaults="|||||-1||"
                editcol="0|1|1|1|1|1|1|0"
                widths="0|1500|2000|2000|2000|1000|0|0"
                styles="width:100%;height:430"
                param="0,1,2,3,4,5,6,7" />
            </td>
        </tr>
    </table>
</body>
<gw:checkbox id="ckActive" value="T" styles="display: none" />
<gw:textbox id="tco_specgrp_pk" styles="display: none" />

</html>
