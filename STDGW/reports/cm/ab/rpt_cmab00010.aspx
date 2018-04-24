<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head>
    <title></title>
 <style type="text/css">
	#header{
	font-size: 14.0pt;
	text-align: center}

	#title{
	font-size: 10.0pt;
	text-align: left}
	
	#data_0{
	width: 25%;
	height: 25%;
	text-align: center;}
		
	#data_1{
	width: 25%;
	height: 25%;
	border-bottom: .5pt solid windowtext;
	text-align: center;}

	#data_2{
	width: 25%;
	height: 14%;
	padding:5px;
	font-size: 14.0pt;
	font-style:italic;
	text-align: left}

	#data_3{
	width: 75%;
	height: 14%;
	padding:5px;
	border-top:.5pt solid windowtext; 
	border-right:.5pt solid windowtext; 
	border-left:.5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	text-align: left;
	text-align: justify;
	vertical-align: center}
	
	#data_4{
	width: 25%;
	height: 14%;
	padding:5px;
	font-size: 14.0pt;
	font-style:italic;
	text-align: center}

	#data_5{
	width: 75%;
	height: 14%;
	padding:5px;
	border-top:.5pt solid windowtext; 
	border-right:.5pt solid windowtext; 
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	text-align: justify;
	text-align: left;
	vertical-align: center}
</style>
</head>
<%  ESysLib.SetUser("crm")%>
<script language="javascript">
var p_pk = "<%=Request.querystring("p_master")%>";
function BodyInit()
{
	txtMasterPK.text = p_pk;
	OnSearch();
}

function OnSearch()
{
	dso_cmab00010_search.Call('SELECT');
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_cmab00010_search':
			if (grdSearch.rows > 1)
			{
				ViewDataList();
			}
		break;
	}
}

function OnClick()
{
	window.print();
}
	
function ViewDataList()
{
	var tableView = document.all("viewImg"); 
    var str = "";
    
    tableView.innerHTML = "";
    var trl = grdSearch.GetGridControl();
	str = "<table style='width: 100%; height: 100%; background: white' cellpadding='0' cellspacing='0' align='center' valign='top' border='0'>";
	str = str  + "<tr style='width: 100%; height: 1%'>";
	str = str  + "<td align='right'><gw:imgbtn id='ibtnReport' img='excel'  alt='Print'    onclick='OnClick()' /></td></tr>";

	str = str  + "<tr style='width: 100%; height: 1%'>";
	str = str  + "<td id='header' >SONG GIA RESORT COMPLEX</td></tr>";

	str = str  + "<tr style='width: 100%; height: 1%'>";
	str = str  + "<td id='header' >Golf Course Maintenance Department</td></tr>";

	str = str  + "<tr style='width: 100%; height: 1%'>";
	str = str  + "<td id='title'>Golf Course Daily Report</td></tr>";

	str = str  + "<tr style='width: 100%; height: 1%'>";
	str = str  + "<td align='left'>";
	str = str  + "<table style='width: 100%; height: 100%' border='0'>";
	str = str  + "<tr>";
	str = str  + "<td id ='data_0'>Date</td>";
	str = str  + "<td id ='data_1' >" + grdSearch.GetGridData(1, 12) + "</td>";
	str = str  + "<td id ='data_0'>Weather</td>";
	str = str  + "<td id ='data_1'>" + grdSearch.GetGridData(1, 3) + "</td>";
	str = str  + "</tr>";
	str = str  + "<tr>";
	str = str  + "<td id ='data_0'>Day</td>";
	str = str  + "<td id ='data_1'>" + grdSearch.GetGridData(1, 2) + "</td>";
	str = str  + "<td id ='data_0'>Rainfall</td>";
	str = str  + "<td id ='data_1'>" + grdSearch.GetGridData(1, 4) + "</td>";
	str = str  + "</tr>";
	str = str  + "</table></td></tr>";

	str = str  + "<tr style='width: 80%; height: 5%'><td></td></tr>";

	str = str  + "<tr style='width: 80%; height: 1%'>";
	str = str  + "<td style='width: 100%; height: 70%'>";
	str = str  + "<table style='width: 100%; height: 100%' border='0' cellpadding='0' cellspacing='0'>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_2'>GREENS/COLLAR</td></tr>";
	str = str  + "<tr style='width: 100%'>";	
	str = str  + "<td id ='data_3'>" + grdSearch.GetGridData(1, 5) + "</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_2'>APRON</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_3'>" + grdSearch.GetGridData(1, 6) + "</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_2'>TEE BOX</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_3'>" + grdSearch.GetGridData(1, 7) + "</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_2'>FAIRWAY</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_3'>" + grdSearch.GetGridData(1, 8) + "</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_2'>ROUGH/SEMI ROUGH</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_3'>" + grdSearch.GetGridData(1, 9) + "</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_2'>BUNKER</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_3'>" + grdSearch.GetGridData(1, 10) + "</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_2'>GENERAL</td></tr>";
	str = str  + "<tr style='width: 100%'>";
	str = str  + "<td id ='data_3'>" + grdSearch.GetGridData(1, 11) + "</td></tr>";
	str = str  + "</table></td></tr>";

	str = str  + "<tr style='width: 80%; height: 10%'><td></td></tr>";

	str = str  + "<tr  style='width: 80%; height: 1%'>";
	str = str  + "<td>";
	str = str  + "<table style='width: 100%; height: 100%' border='0'>";
	str = str  + "<tr>";
	str = str  + "<td  id ='data_0'>Prepare by</td>";
	str = str  + "<td  id ='data_1'>&nbsp </td>";
	str = str  + "<td  id ='data_0'>Check by</td>";
	str = str  + "<td  id ='data_1'>&nbsp </td>";
	str = str  + "</tr></table></td></tr>";

	str = str  + "</table>";

	tableView.innerHTML = str;
}

//======================================================================
</script>
<body>
<gw:data id="dso_cmab00010_search" onreceive="OnDataReceive(this)"> 
    <xml>                                                               
        <dso id="1" type="grid" user="prod" function="CRM.sp_sel_cmab00010"> 
            <input> 
                <input bind="txtMasterPK" />
            </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>

<table style="width: 80%; height: 100%; background: white" cellpadding="0" cellspacing="0" align="center" valign="top" border="0">
	<tr>
		<td style="width: 80%; height: 100%; background: white">
			<div  id="viewImg" style=" height:100%; overflow:none"></div>
		</td>
	</tr>
</table>
</body>
<gw:textbox id="txtMasterPK" style="display:none" />
<gw:grid
	id="grdSearch"
    header='0|1|2|3|4|5|6|7|8|9|10|11|12'
    format='0|0|0|0|0|0|0|0|0|0|0|0|0'
    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
    defaults='||||||||||||'
    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
    widths='0|0|0|0|0|0|0|0|0|0|0|0|0'
	styles="width:100%; heigth:456; display:none" />
</html>