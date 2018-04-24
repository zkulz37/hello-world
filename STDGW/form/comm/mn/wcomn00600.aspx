<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head>
    <title>Error Dictionary</title>
</head>
<%ESysLib.SetUser("esys")%>
<script>
function BodyInit()
{
    grd.GetGridControl().FrozenCols = 7;
    
    BindingDataList();
    
    <%=ESysLib.SetGridColumnComboFormat( "grd" , 5 , "select tco.code, tco.code_nm from tco_abcode tco, tco_abcodegrp cg where ((tco.tco_abcodegrp_pk = cg.pk) AND (cg.ID = 'COBS0030')) ORDER BY tco.code_nm")%>;
}

function BindingDataList()
{
    var data = '';
    
    data = "<%=ESysLib.SetListDataFUNC("select comm.f_commoncode('COBS0030','','') from dual")%>|ALL|SELECT ALL";
    lstType.SetDataText(data);
    lstType.value = 'ALL';
}

function OnSearch()
{
    idData_ErrorDict.Call('SELECT');
}

function OnNew()
{
    grd.AddRow();
}

function OnSave()
{
    idData_ErrorDict.Call();
}

function OnDelete()
{
    grd.DeleteRow();
}

function OnUnDelete()
{
    grd.UnDeleteRow();
}

</script>
<body>
    <table width="100%">
        <tr>
            <td width="20%" align="right"><b>Code/Description</b></td>
            <td width="30%"><gw:textbox id="txtCode" styles="width: 100%" onkeypress="OnSearch()" /></td>
            <td width="10%" align="right"><b>Type</b></td>
            <td width="15%"><gw:list id="lstType" /></td>
            <td width="20"><gw:checkbox id="ckYesNo" value="T" /></td>
            <td width="20%"><b>Active</b></td>
            <td wdith="3%"><gw:imgBtn id="btSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
            <td wdith="3%"><gw:imgBtn id="btNew" img="new" alt="Add New" onclick="OnNew()" /></td>
            <td wdith="3%"><gw:imgBtn id="btDel" img="delete" alt="Delete" onclick="OnDelete()" /></td>
            <td wdith="3%"><gw:imgBtn id="btUDel" img="udelete" alt="UnDelete" onclick="OnUnDelete()" /></td>
            <td wdith="3%"><gw:imgBtn id="btSave" img="save" alt="Save" onclick="OnSave()" /></td>
        </tr>
        <tr>
            <td colspan="11" width="100%">
                <gw:data id="idData_ErrorDict">
                    <xml>
                        <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="esys.sp_sel_tes_errordict" procedure="esys.sp_upd_tes_errordict">
                            <input bind="grd" >
				                <input bind="txtCode" />
                                <input bind="lstType" />
                                <input bind="ckYesNo" />
                            </input>
                            <output bind="grd" />
                        </dso>
                    </xml>
                </gw:data>
                <script>
                    document.writeln('<gw:grid');
                    document.writeln('id="grd"');
                    document.writeln('header="_pk|Code|Description|L.Description|F.Description|Type|Active|Action|L.Action|F.Action|Cause|L.Cause|F.Cause"');
                    document.writeln('format="0|0|0|0|0|2|3|0|0|0|0|0|0"');
                    document.writeln('aligns="0|1|0|0|0|0|0|0|0|0|0|0|0"');
                    document.writeln('defaults="||||||-1||||||"');
                    document.writeln('editcol="0|1|1|1|1|1|1|1|1|1|1|1|1"');
                    document.writeln('widths="0|1000|2500|2500|2500|2000|800|2500|2500|2500|2500|2500|0"');
                    document.writeln('styles="width:100%; height:450"');
                    document.writeln('sorting="T"');
                    document.writeln('param="0,1,2,3,4,5,6,7,8,9,10,11,12" />');
                </script>
            </td>
        </tr>
    </table>
</body>
</html>
<td><b></b></td>