<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
//======================================================================
function BodyInit()
{
     OnSearch();       
}

 //===================================================================================    
function OnSearch()
{
    data_jabk0170.Call("SELECT");
}  

function url_encode(s) {
		string = s.replace(/\r\n/g,"\n");
		var utftext = "";
 
		for (var n = 0; n < string.length; n++) {
 
			var c = string.charCodeAt(n);
 
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
 
		return escape(utftext);
}
function OnReport()
{
     var url = '/reports/ja/bk/jabk0020_inquiry2.aspx?p_dtfrom='+ dtFrom.GetData() + '&p_dtto=' + dtTo.GetData()+ '&p_member_no=' + txtMemberNo.GetData()+ '&p_member_name=' + txtMemberName.GetData()+ '&p_status=' + lstStatus.GetData();
	    System.OpenTargetPage( System.RootURL+url , "newform" );
}

function OnDataReceive(obj){
	
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_jabk0170" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="crm.sp_sel_jabk0170" > 
                <input> 
                   <inout bind="dtFrom" /> 
                    <inout bind="dtTo" />                                                                    
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="right" style="width: 5%">
                Date</td>
            <td align="right" style="width: 10%">
                <gw:datebox id="dtFrom" lang="1" onchange="OnSearch()"/>
            </td>
            <td align="right" style="width: 2%">
                ~</td>
            <td align="right" style="width: 10%">
                <gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />
            </td>
            <td align="left" style="width: 1%;padding-left:5px"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" /></td>
            <td style="width: 10%"></td>
            <td align="right" style="width: 10%"></td>
            <td style="width: 12%"></td>
            <td style="width: 5%"></td>
            <td style="width: 15%"></td>
			<td align="right" style="width:7%"></td>
            <td style="width:7%"></td>
            <td style="width: 1%" align="right"></td>
			<td width="2%"></td>
			<td width="2%"></td>
        </tr>
        <tr style="height: 99%">
            <td style="width: 100%" colspan="15">
                     <gw:grid id='grdDetail' 
                        header='Type Visitor|Couter'
                        format='0|-0' 
                        aligns='0|1' 
                        autosize="T"
                        sorting='T'  
                        styles='width:100%; height:100%'/>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <!--------------------------------------------------------------------------->
</body>
</html>
