<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Group Entry</title>
</head>

<script>
function BodyInit() {
var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0183' order by code")%>";
       grdGroupEntry.SetComboFormat(6,t1);
    
    OnSearch();
}
function OnSearch()
{
    dsoGroupEntry.Call("SELECT");
}
function OnDelete()
{
    grdGroupEntry.DeleteRow();  
}
function OnUnDelete()
{
    grdGroupEntry.UnDeleteRow();
}
function OnNew()
{
    grdGroupEntry.AddRow();
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
        if(grdGroupEntry.GetGridData(i,1)=="")
        {
            alert("Please input group ID !");
            return false;
        }
        else if(grdGroupEntry.GetGridData(i,2)=="")
        {
            alert("Please input group name!");
            return false;
        } 
    }
   return true;
}
</script>

<body bgcolor='#F5F8FF'>
    <gw:data id="dsoGroupEntry"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7" function="hr_sel_chem00010" procedure="HR_upd_chem00010">  
                <input bind="grdGroupEntry"   >  
                    <input bind="txtGroup" />  	 															
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
                        <td width="10%">
                            Group
                        </td>
                        <td width="30%">
                            <gw:textbox id="txtGroup" />
                        </td>
                        <td width="45%">
                        </td>
                        <td width="3%">
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
                        <td style="width: 3%">
                            <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="8">
                            <gw:grid id='grdGroupEntry' header='_PK|GROUP_ID|GROUP_NM|GROUP_LNM|GROUP_FNM|MBO_YN|GROUP KIND|DESCRIPTION'
                                format='0|0|0|0|0|3|0|0' aligns='0|0|0|0|0|0|0|0' defaults='|||||||' editcol='1|1|1|1|1|1|1|1'
                                widths='1000|1500|1500|1500|1500|1500|1500|1500' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
