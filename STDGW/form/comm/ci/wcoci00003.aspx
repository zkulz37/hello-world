<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("comm")%>

<script>
function BodyInit()
{
	<%=ESysLib.SetGridColumnComboFormat("grdUnit", 5, "select a.code, a.code_nm   from tco_abcode a, tco_abcodegrp b  where a.del_if = 0 and b.del_if = 0 and a.tco_abcodegrp_pk = b.pk and b.id = 'COCI0020'")%>;
	<%=ESysLib.SetGridColumnComboFormat("grdMea", 1, "select   a.code, a.code_nm from comm.tco_abcode a, comm.tco_abcodegrp g where a.tco_abcodegrp_pk = g.pk and g.id = 'COCI0030' and a.del_if = 0 order by a.code_nm")%>;
	
	idData_wcoci00003_1.Call("SELECT");
}
//---------------------------------------
function OnNew(index)
{
   switch(index)
   {
        case 0:
            grdUnit.AddRow();
        break;
        case 1:
            var tmp = grdUnit.row;
            if(tmp< 1)
            {
                alert("You should select unit first");
            }
            {
                var uom= grdUnit.GetGridData(grdUnit.row,1)
                txtUOM_CD.SetDataText(uom);
                grdMea.AddRow(); 
                grdMea.SetGridText(grdMea.rows-1,2,grdUnit.GetGridData(grdUnit.row,1));
                grdMea.SetGridText(grdMea.rows-1,4,grdUnit.GetGridData(grdUnit.row,5));
            }    
        break;
   }
}
//---------------------------------------
function OnSave(index)
{  
    switch(index)
    {
        case 0:
            idData_wcoci00003_1.Call();
        break;
        case 1:
            idData_wcoci00003_2.Call();
        break;
    }
}
//---------------------------------------
function OnDelete(index)
{
    switch(index)
    {
        case 0:
            grdUnit.DeleteRow();
        break;
        case 1:
            grdMea.DeleteRow();
        break;
    }
    
}
//-------------------------------------
function OnUnDelete(index)
{
    switch(index)
    {
        case 0:
            grdUnit.UnDeleteRow();
        break;
        case 1:
            grdMea.UnDeleteRow();
        break;
    }
}
//------------------------------------
function onSearch()
{
    var uom= grdUnit.GetGridData(grdUnit.row,1)
    txtUOM_CD.SetDataText(uom);
    idData_wcoci00003_2.Call("SELECT");
        
}
//------------------------------------
</script>
<html>
<head id="Head1" runat="server">
    <title>Measurement entry</title>
</head>
<body>
    <table width="100%" style="background-color: #BDE9FF" cellspacing="2">
        <tr style="background-color: White">
            <td width="50%">
                <table width="100%">
                    <tr>
                        <td width="90%"></td>
                        <td width="3%"><gw:imgBtn img="new" alt="New unit" onclick ="OnNew(0)"/></td>
                        <td width="3%"><gw:imgBtn img="delete" alt="Delete" onclick ="OnDelete(0)"/></td>
                        <td width="3%"><gw:imgBtn img="udelete" alt="UnDelete" onclick ="OnUnDelete(0)"/></td>
                        <td width="3%"><gw:imgBtn img="save" alt="Save" onclick ="OnSave(0)"/></td>
                    </tr>
                </table>
            </td>
            <td width="50%">
                <table width="100%">
                    <tr>
                        <td width="90%" align="right"></td>
                        <td width="3%"><gw:imgBtn img="new" alt="New" onclick ="OnNew(1)"/></td>
                        <td width="3%"><gw:imgBtn img="delete" alt="Delete" onclick ="OnDelete(1)"/></td>
                        <td width="3%"><gw:imgBtn img="udelete" alt="UnDelete" onclick ="OnUnDelete(1)"/></td>
                        <td width="3%"><gw:imgBtn img="save" alt="Save" onclick ="OnSave(1)"/></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="background-color: White">
            <td width="50%">
                <gw:data id="idData_wcoci00003_1">
                    <xml>
                        <dso id="1" type="grid" parameter="0,1,2,3,4,5" function="comm.sp_get_tco_uom" procedure="comm.sp_tco_uom_entry" >
                            <input bind="grdUnit" >
                            </input>
                            <output bind="grdUnit" />
                        </dso>
                    </xml>
                </gw:data>
                <gw:grid
                id="grdUnit"
                header="_PK|Unit Code|Unit Name|Unit Name( Local)|Unit Name(Foreign)|Measure Type"
                format="0|0|0|0|0|0"
                aligns="0|0|0|0|0|0"
                defaults="|||||"
                editcol="0|1|1|1|1|1"
                widths="0|1500|1500|2000|2000|2000"
                styles="width:100%;height:430"
                oncellclick="onSearch()"
                param="0,1,2,3,4,5" />
            </td>
            
            <td width="50%">
                <gw:data id="idData_wcoci00003_2">
                    <xml>
                        <dso id="1" type="grid" parameter="0,1,2,3" function="comm.sp_get_tco_measure" procedure="comm.sp_tco_measure_entry">
                            <input bind="grdMea" >
                                <input bind="txtUOM_CD" />                                
                            </input>
                            <output bind="grdMea" />
                        </dso>
                    </xml>
                </gw:data>
                <gw:grid
                id="grdMea"
                header="_PK|Conversion Unit|Unit Name|Conversion Factor|Measure Type"
                format="0|0|0|0|0"
                aligns="0|0|0|0|0"
                defaults="||||"
                editcol="0|1|1|1|1"
                widths="0|2200|2200|2200|2200"
                styles="width:100%;height:430"                
                param="0,1,2,3,4" />
            </td>
        </tr>
    </table>
</body>
<gw:checkbox id="ckActive" value="T" styles="display: none" />
<gw:textbox id="tco_specgrp_pk" styles="display: none" />
<gw:textbox id="txtUOM_CD" styles="display: none" />

</html>
