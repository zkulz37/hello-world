<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Update Golfer Name</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
 function BodyInit()
 {    
   txtLocker.SetReadOnly(true);
   txtBagNo.SetReadOnly(true);
   txtTaxCode.SetReadOnly(true);
   txtCompanyName.SetReadOnly(true);
   txtCompanyAddress.SetReadOnly(true);
   txtRoom.SetReadOnly(true);
   txtRoomGuest.SetReadOnly(true);				
   txtMasterPK.text= '<%=Request.QueryString("pk") %>';
   var data= "<%=ESysLib.SetListDataSQL("SELECT pk,NAME FROM tcm_member_type WHERE DEL_IF=0   order by 2" )%>"; 
   lstMemberType.SetDataText(data);
   data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='PTYPE'" )%>"; 
   lstPayment.SetDataText(data);
		
   data_jarc_update_name.Call("SELECT");
 }
function OnSave()
{
   if(confirm("Do you want to save?")){
    data_jarc_update_name.StatusUpdate();
    data_jarc_update_name.Call();
   }	
}
function OnDeleteRoom(){
	if(confirm("Do you want to delete room?")){
		data_jarc_update_name.StatusUpdate();
		txtRoomAllocatePK.text = "";
		data_jarc_update_name.Call();
	}
}
function OnDeleteCompany(){
	if(confirm("Do you want to delete company?")){
		data_jarc_update_name.StatusUpdate();
		txtCompanyPK.text = "";
		data_jarc_update_name.Call();
	}
}
function OnGetBus(){
	var path = System.RootURL + "/form/ht/bk/htbk00010_bus.aspx?";
	var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
	if ( object != null ){
		txtCompanyPK.text  		= object[0];
		txtCompanyName.text		= object[2];
		txtTaxCode.text			= object[6];
		txtCompanyAddress.text	= object[7];
	}
}
function OnGetRoom(){
	var path = System.RootURL + '/form/ht/fo/htfo00061.aspx';
   var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
   if ( obj != null )
   {
		txtRoomAllocatePK.text = obj[0];//room allocate pk
		txtRoom.text = obj[2]; //room no
		txtRoomGuest.text = obj[4];
		//txtGolferName.text = obj[4]; //overwrite room guest name on the checkin golfer
   }
}
</script>

<body>
    
    <gw:data id="data_jarc_update_name" > 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,12"  function="crm.sp_sel_jarc00040_golfer_name" procedure="crm.sp_upd_jarc00040_golfer_name">
                <inout>
                    <inout bind="txtMasterPK" /> 
                    <inout bind="txtLocker" /> 
                    <inout bind="txtBagNo" />  
                    <inout bind="txtGolferName" /> 
                    <inout bind="txtRoomAllocatePK" /> 
                    <inout bind="txtCompanyPK" /> 
                    <inout bind="lstPayment" /> 
					<inout bind="lstMemberType" /> 
					<inout bind="txtTaxcode" /> 
					<inout bind="txtCompanyName" /> 
					<inout bind="txtCompanyAddress" /> 
					<inout bind="txtRoom" /> 
					<inout bind="chkPackageYN" /> 
			   </inout>
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr style="height: 6%" valign="top">
            <td style="background: white;">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr>
								    <td style="width:5%">
										<a href="#" onclick="OnGetRoom();">Room#</a>
									</td>
									<td style="width:6%">
										<gw:textbox id="txtRoom" />
									</td>
									<td style="width:20%">
                                        <gw:textbox id="txtRoomGuest" styles="width:100%" />
                                    </td>
                                    <td style="width:5%">
                                        Golfer
                                    </td>
                                    <td style="width:30%">
                                        <gw:textbox id="txtGolferName" styles="width:100%" />
                                    </td>
                                    <td style="width:5%">
                                        Locker#
                                    </td>
                                    <td style="width:5%">
                                        <gw:textbox id="txtLocker" styles="width:100%" />
                                    </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td width="15%">Member Type</td>
									<td width="55%"><gw:list id="lstMemberType" styles="background-color:#fffaaf" /></td>
                                    <td style="width: 10%">
                                        Bagtag
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtBagNo" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
					
                    <tr style="height: 2%" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 15%">
                                        <a href="#" onclick="OnGetBus();">Company Name</a>
                                    </td>
                                    <td style="width: 55%">
                                        <gw:textbox id="txtCompanyName" styles="width:100%" />
                                    </td>
                                    <td style="width: 10%">
                                        Tax code
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtTaxCode" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
					<tr>
						<td>
							<table width="100%">
								<tr>
									
									<td style="width: 15%">
                                        Company Address
                                    </td>
                                    <td style="width: 55%">
                                        <gw:textbox id="txtCompanyAddress" styles="width:100%" />
                                    </td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table width="100%">
								<tr>
									
									<td style="width: 15%">
                                        Payment method
                                    </td>
									
                                    <td style="width: 65%">
                                        <gw:list id="lstPayment" styles="width:100%" />
                                    </td>
									<td style="width: 15%" align="right">
                                        Package YN
                                    </td>
									<td style="width:5%">
                                        <gw:checkbox id="chkPackageYN" defaultvalue="Y|N" />
                                    </td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table width="100%">
								<tr>
								    <td style="width: 10%" align="middle" >
                                        <gw:icon id="btnDelRoom" img="2" text="Delete Room" styles='width:100%' onclick="OnDeleteRoom()" />
                                    </td>
									<td width="10%"></td> 
									<td style="width: 10%" align="middle" >
                                        <gw:icon id="btnDelCompany" img="2" text="Delete Company" styles='width:100%' onclick="OnDeleteCompany()" />
                                    </td>
									<td width="20%"></td> 
									<td style="width: 10%" align="middle" >
                                        <gw:icon id="idBtnSave" img="2" text="Save" styles='width:100%' onclick="OnSave()" />
                                    </td>
								</tr>
							</table>
						</td>
					</tr>
                </table>
            </td>
        </tr>
        <tr style="height: 94%">
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
	<gw:textbox id="txtRoomAllocatePK" styles="width:100%; display:none" />
	<gw:textbox id="txtCompanyPK" styles="width:100%; display:none" />
</body>
</html>
