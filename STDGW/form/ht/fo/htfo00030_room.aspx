<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>vina genuwin</title>
    <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
	Bingding();
	OnSearch();
}

function Bingding()
{
	var data = '';

	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='RTYPE'" )%>|ALL|Select All"; 	
	lstRoomType.SetDataText(data);
	lstRoomType.value="ALL";

	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='RSTA'" )%>|ALL|Select All"; 
	lstStatus.SetDataText(data);
	lstStatus.value="ALL";

	data= "<%=ESysLib.SetGridColumnDataSQL("select CODE, NAME from  comm.TCO_COMMCODE where del_if=0 and PARENT_CODE='CPT'" ) %> ";
	grdRoom.SetComboFormat(5, data);

	data= "<%=ESysLib.SetGridColumnDataSQL("select CODE, NAME from  comm.TCO_COMMCODE where del_if=0 and PARENT_CODE='RTYPE'" ) %> ";
	grdRoom.SetComboFormat(6, data);

	data = "<%=ESysLib.SetGridColumnDataSQL("select CODE, NAME from  comm.TCO_COMMCODE where del_if=0 and PARENT_CODE='RSTA'" ) %> ";
	grdRoom.SetComboFormat(7, data);
}

function OnGetRoom()
{
	var ctrl = grdRoom.GetGridControl();
	var rtn_value = new Array();
	var index = 0;

	if (grdRoom.row > 0)
	{
		for(j = 0; j < grdRoom.cols -1; j++)
		{
			rtn_value[index] = grdRoom.GetGridData(grdRoom.row, j );
			index ++;
		}
		
		window.returnValue = rtn_value; 
		this.close();
	}
}

function OnSearch()
{
	dsoRoom.Call("SELECT");
}
</script>

</head>
<body>
    <gw:data id="dsoRoom"> 
        <xml> 
            <dso type="grid" parameter="" function="CRM.SP_SEL_HTFO00030_ROOM">  
                <input bind="grdRoom"   >  
                    <input bind="txtRoomNo" /> 
                    <input bind="txtFloor" /> 
                    <input bind="lstRoomType" />
                    <input bind="lstStatus" />	       															
                </input> 
                <output bind="grdRoom" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%" style="height: 100%">
        <tr style="height: 2%">
            <td width="8%">
                <b>Room No</b></td>
            <td width="8%">
                <gw:textbox id="txtRoomNo" onenterkey="OnSearch()" />
            </td>
            <td width="7%">
                Floor</td>
            <td width="8%">
                <gw:textbox id="txtFloor" onenterkey="OnSearch()" />
            </td>
            <td width="12%">
                Room Type</td>
            <td width="20%">
                <gw:list id="lstRoomType" onchange=""></gw:list>
            </td>
            <td width="6%">
                Status</td>
            <td width="23%">
                <gw:list id="lstStatus" onchange=""></gw:list>
            </td>
            <td with="3%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="13">
                <gw:grid id="grdRoom" header="_PK|_Building No|_Area No|_Floor No|Room No|Price Type|Room Type|Room Status|Price|Use YN|Description"
                    format="0|0|0|0|0|0|0|0|1|3|0" aligns="0|0|0|0|0|0|0|0|3|0|0" defaults="||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0"
                    widths="1000|1000|1000|1000|1000|1000|1000|1000|1000|0|0" sorting='F' autosize="T"
                    styles="width:100%; height:100%" oncelldblclick='OnGetRoom()' />
            </td>
        </tr>
    </table>
</body>
</html>
