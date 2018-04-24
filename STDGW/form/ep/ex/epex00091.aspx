<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("samil")%>
<head>
    <title>Search Item</title>
</head>

<script type="text/javascript" language="javascript">

function BodyInit()
{
	System.Translate(document);

	idInput1.text = "<%=Request.querystring("search_no")%>";
	
	data_epim00091.Call('SELECT');  
}
function DSOReceive( dsoinfo  )
{

	if ( dsoinfo.errno > 0 )
	{
		alert( dsoinfo.errmsg );
		return ;
	}
}
// filter data 
function searchOnClick()
{
	// ....here is your source code .................
}

function RowDbClick(flag)
{
	var aValue = new Array();
	if(flag==0){//reset
	aValue[0] = "";
	aValue[1] = "";
	aValue[2] = "";
	aValue[3] = "";
	}	
	else{	
	aValue[0] = idGrid.GetGridData( idGrid.row, 0);
	aValue[1] = idGrid.GetGridData( idGrid.row, 1);
	aValue[2] = idGrid.GetGridData( idGrid.row, 2);
	aValue[3] = idGrid.GetGridData( idGrid.row, 3);

	}
	window.returnValue = aValue; 
	window.close();
}

</script>

<body>
    <!-- This is a public source code block -->
    <gw:data id="data_epim00091" onreceive=""> 
        <xml> 
            <dso id="1" type="grid" parameter="0" function="lg_sel_epim00091" > 
                <input>  
                    <input	bind="idInput1"	/>	
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
</gw:data>
    <!-- This is our html --------------------------------------------------  -->
    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 100%">
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td width="30%" align="center">
                            <b>Item</b>
                        </td>
                        <td width="30%">
                            <gw:textbox id="idInput1" text="" onenterkey="data_epim00091.Call('SELECT')" />
                        </td>
                        <td width="28%" align="right">
                        </td>
                        <td width="6%" align="right">
                            <gw:imgbtn id="idSearch" img="search" alt="Search" text="Search" onclick="data_epim00091.Call('SELECT')" />
                        </td>
                        <td width="6%" align="right">
                            <gw:imgbtn id="idClose" img="cancel" alt="Cancel" text="Cancel" onclick="RowDbClick(0)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td style="width: 100%">
                <!-- This is Grid script -->
                <table class="table" border="0" cellpadding="0" cellspacing="0" style="width: 100%;
                    height: 100%">
                    <tr style="height: 100%">
                        <td colspan="3" style="width: 100%">
                            <gw:grid id='idGrid' header='_PK|Item Group|Item Code|Item Name|Content|Note|Knit Data'
                                format='0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0' check='||||||' editcol='1|1|1|1|1|1|1'
                                widths='1000|1500|1500|2000|2000|2000|1000' sorting='F' styles='width:100%; height:100%'
                                oncelldblclick="RowDbClick()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
