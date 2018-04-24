<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<head runat="server">
    <title>Untitled Page</title>
</head>

<script type="text/javascript" language="javascript">
 
function OnSearch()
{
    idData_Dsql_wsyau00008.Call("SELECT");
}
function OnSave()
{
    idData_Dsql_wsyau00008.Call();
}
function OnNew()
{      
    grdTest.AddRow();
}
function OnDelete()
{
    grdTest.DeleteRow();
}
function OnUndelete()
{
    grdTest.UnDeleteRow();
}
function OnDataReceive(p_sendID)
{
   // alert(p_sendID.id);
}
function OnGridDoubleClick(grdTest)
{
    if(grdTest.col == '5' )
    {
        var a=System.OpenModal(System.RootURL+ "/form/sys/auth/wsyau00008_popupMaster.aspx",500,500,'resizable:yes;status:yes');
        grdTest.SetGridText(grdTest.row,6,a[0]);
        grdTest.SetGridText(grdTest.row,5,a[1]);
    }
}
</script>

<body>
    <table>
        <tr>
            <td width="20%">
                <table width="100%">
                    <tr>
                        <td width="20%" >
                            <b>ID</b></td>
                        <td width="80%">
                            <gw:textbox id="txtPara1" styles="width:100%" />
                        </td>
                    </tr>
                </table>
            </td>
            <td width="20%">
                <table width="100%">
                    <tr>
                        <td width="20%" >
                            <b>Name</b></td>
                        <td width="80%">
                            <gw:textbox id="txtPara2" styles="width:100%" />
                        </td>
                    </tr>
                </table>
            </td>
            <td width="54%">
            </td>
            <td width="3%">
                <gw:button id="ibtnSearch" img="search" alt="search" onclick="OnSearch()" />
            </td>
            <td width="3%">
                <gw:button id="ibtnNew" img="new" alt="New" onclick="OnNew()" />
            </td>
            <td width="3%">
                <gw:button id="ibtnDelete" img="delete" alt="Delete" onclick="OnDelete()" />
            </td>
            <td width="3%">
                <gw:imgbtn id="ibtnUndelete" img="udelete" alt="Undelete" onclick="OnUndelete()" />
            </td>
            <td width="3%">
                <gw:button id="ibtnSave" img="save" alt="save" onclick="OnSave()" />
            </td>
        </tr>
    </table>
    <gw:data id="idData_Dsql_wsyau00008" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="prod" parameter="0,1,2,3,4,6,7,8" function="GASP.sp_get_organization" procedure="GASP.sp_insert_organization"> 
                <input bind="grdTest" > 
                    <input bind="txtPara1" /> 
                    <input bind="txtPara2" />
                </input> 
                <output bind="grdTest" /> 
            </dso> 
        </xml> 
       </gw:data>
    <gw:grid id="grdTest" header="_PK|ORG ID|ORG NM|ORG LNM|ORG_FNM|MANAGER NAME|_MANAGER PK|DIVISION|LOCATION"
        format="0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|0" defaults="||||||||" editcol="1|1|1|1|1|1|1|1|1"
        widths="0|1200|1200|2000|2000|2000|0|2000|1000" styles="width:100%; height:400" sorting="T"
        acceptnulldate="true" param="0,1,2,3,4,5,6,7,8" oncelldblclick="OnGridDoubleClick(this)" />
</body>
</html>
