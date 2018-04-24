<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Breakfast Revenue</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ;
var COL_PK          	= 0,
    COL_Invoice_Date    = 1,
    COL_Invoice_No      = 2,
    COL_Total_AMT_VND  	= 3,
	COL_Total_AMT_USD   = 4,
    COL_ExRate		    = 5,
	COL_Location	    = 6,
    COL_Room_No      	= 7,
    COL_Last_Name       = 8,
    COL_First_Name      = 9,
	COL_Package      	= 10;
    

 //===================================================================    

 function BodyInit()
 {
    //dtFrom.SetDataText(System.AddDate(dtFrom.GetData(),-0));
    //----------------------
	var data;
	data = "<%=ESysLib.SetListDataSQL("SELECT A.* FROM (SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' and code in ('POINT-01','POINT-04','POINT-05','POINT-06','POINT-09') UNION SELECT '','ALL' FROM DUAL) A ORDER BY A.CODE")%>";
	lstLocation.SetDataText(data);
	lstLocation.value = '';
	
	OnSearch();
 }
 
 function Binding()
{
	
}
  //===================================================================    
function OnReport()
 {
 
 }
 
 function OnSave(){
	if(confirm('Are you sure to save package bill list?')){
		data_htrt00190.Call();
	}
 }
 
 function OnSearch()
 {
	data_htrt00190.Call("SELECT");
 }
 function OnDataReceive(obj)
 {
	if(obj.id=='data_htrt00190')
	{
		lblRecord.text=grdPackage.rows - 1 +" record(s)."
		//grdPackage.Subtotal( 1, 2, -1,'4!5!6!7!8!9!10');

	}
 }
 function OnPopUp(){

    var path = System.RootURL + '/form/ht/fo/htfo00041.aspx?pk=' + grdPackage.GetGridData(grdPackage.row, COL_PK) + '&sn=' + grdPackage.GetGridData(grdPackage.row, COL_Invoice_No)+ '&date=' + grdPackage.GetGridData(grdPackage.row, COL_Invoice_Date).substring(6,8) + '/' + grdPackage.GetGridData(grdPackage.row, COL_Invoice_Date).substring(4,6)+ '/' + grdPackage.GetGridData(grdPackage.row, COL_Invoice_Date).substring(0,4)+ '&room=' + url_encode(grdPackage.GetGridData(grdPackage.row, COL_First_Name) + ' ' + grdPackage.GetGridData(grdPackage.row, COL_Last_Name));
	
    var obj = System.OpenModal( path ,650 , 500,  'resizable:yes;status:yes');
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
//=========================================================================
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htrt00190" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid" parameter="0,10" function="crm.sp_sel_htrt00190" procedure="crm.sp_upd_htrt00190">
                <input  bind="grdPackage">
					<input bind="dtFrom" />
					<input bind="dtTo" />
					<input bind="lstLocation" />
					<input bind="txtRoomNo" />
                </input> 
                <output bind="grdPackage" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 100%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style=" height: 2%">
                         <td >
                             <fieldset>
						        <table style="width: 100%; height: 100%">
							        <tr>
							            <td width="5%" align="center">
									        Date
								        </td>
								        <td width="20%">
									        <gw:datebox id="dtFrom" lang="1" onchange="OnSearch()" /> 
											~
									        <gw:datebox id="dtTo" lang="1" onchange="OnSearch()" /> 
								        </td>
										<td align="right" width="5%"><b>Location</b></td>
										<td align="left" width="17%"><gw:list id="lstLocation" onchange="OnSearch()" /></td>
										<td align="right" width="5%"><b>Room</b></td>
										<td align="left" width="5%"><gw:textbox id="txtRoomNo" onenterkey="OnSearch()" /></td>
										<td style="width:3%">
											Total:
										</td>
										<td style="width:5%;white-space:nowrap;">
											<gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label>
										</td>
										<td width="1%">
									        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
								        </td>
										<td style="width:1%" align="right">
											<gw:imgbtn id="btnSave" img="Save" alt="Save" onclick="OnSave()" />
										</td>
										<td style="width:3%" align="right"></td>
							        </tr>
						        </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="7">
                            <gw:grid id	='grdPackage' 
								header	='_PK|Invoice Date|Invoice No|Total AMT VND|Total AMT USD|Ex.Rate|Location|Room No|Last Name|First Name|Package'
                                format	='0|4|0|-0|-1|-0|0|0|0|0|3' 
                                aligns	='0|0|1|0|0|0|0|1|0|0|0' 
                                check	='||||||||||'
                                editcol	='0|0|0|0|0|0|0|0|0|0|1' 
                                widths	='0|0|0|0|0|0|0|0|0|0|0'
								oncelldblclick = "OnPopUp();"
                                sorting	='T' autosize='T' acceptnulldate='F' styles='width:100%; height:100%'  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
