<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser("crm")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Locker Status</title>
</head>

<script>
  var User_Name = "<%=Session("USER_ID")%>";
var COL_PK=0,
	Date=1,
	LockerNo=2,
	Status=3,
	Description=4,
	Last_Update=5;       
function BodyInit()
{     
    Binding(); 
    OnSearch();
}
function Binding()
{
	var data;    //VC: VACCANCY CLEAN, OC: OCCUPIED CLEAN, LOS: LOST, NRTN: NEXT TIME RETURN, BRK: BROKEN
	data = "data|VC|VACCANCY CLEAN|OC|OCCUPIED CLEAN|LOS|LOST|NRTN|NEXT TIME RETURN|BRK|BROKEN|ALL|Select All";
	lstRoomStatus.SetDataText(data);
	lstRoomStatus.value='ALL';
	grdLockerStatus.SetComboFormat(3,'#VC;VACCANCY CLEAN|#OC;OCCUPIED CLEAN|#LOS;LOST|#NRTN;NEXT TIME RETURN|#BRK;BROKEN');
	txtUser_ID.text=User_Name;
}
function OnSearch()
{
    dsoListHistory.Call('SELECT');
}
function OnDataReceive(obj)
{
    switch(obj.id){
        case "dsoListHistory":
			if(grdLockerStatus.rows > 1){
			 for (row = 1; row < grdLockerStatus.rows; row ++ )
			 {
					var status_color= grdLockerStatus.GetGridData(row, 3);
								if(status_color == 'LOS')
								{
									set_color =0x00ffff; // ffff00 
								}
								else if(status_color == 'BRK')
								{
									set_color =0x0066ff;//ff6600
								}
								if(status_color == 'VC')// 3366ff
								{
									set_color =0xff6633;
								}
								else if(status_color == 'OC')//15340c
								{
									set_color =0x2CC00B;
								}
								else if(status_color == 'NRTN')
								{
									set_color =0x0000ff;// ff0000
								}    
								grdLockerStatus.SetCellBgColor(row, 0, row, 3, set_color);
				}
				grdLockerStatus.SetCellBold(1, 0, grdLockerStatus.rows-1, 3, 0x000000);
			}
        break;
    }
}
function OnSave(obj)
{   
   var ctrl=grdLockerStatus.GetGridControl();
    switch(obj){
        case "VC":
           	if(confirm('Are you sure you want to change status to VC ?'))
			{
				for (var i =1;i<ctrl.Rows;i++ ){
						if (ctrl.isSelected(i) == true)
						  grdLockerStatus.SetGridText(i,3,'VC');
				 }
				 dsoListHistory.Call();	
			}
        break;
		case "OC":
           if(confirm('Are you sure you want to change status to OC ?'))
			{
				for (var i =1;i<ctrl.Rows;i++ ){
						if (ctrl.isSelected(i) == true)
						  grdLockerStatus.SetGridText(i,3,'OC');
				 }
				 dsoListHistory.Call();	
			 }
        break;
		case "BRK":
            if(confirm('Are you sure you want to change status  Broken Locker ?'))
			{
				for (var i =1;i<ctrl.Rows;i++ ){
						if (ctrl.isSelected(i) == true)
						  grdLockerStatus.SetGridText(i,3,'BRK');
				 }
				 dsoListHistory.Call();	
			 }
        break;
		case "LOS":
            if(confirm('Are you sure you want to change status  Lost Locker?'))
			{
				for (var i =1;i<ctrl.Rows;i++ ){
						if (ctrl.isSelected(i) == true)
						  grdLockerStatus.SetGridText(i,3,'LOS');
				 }
				 dsoListHistory.Call();	
			}
        break;
		case "NRTN":
			if(confirm('Are you sure you want to change status  Next Time Return ?'))
			{
				for (var i =1;i<ctrl.Rows;i++ ){
						if (ctrl.isSelected(i) == true)
						  grdLockerStatus.SetGridText(i,3,'NRTN');
				 }
				 dsoListHistory.Call();	
			}
        break;
		case "TuDo":
				if(grdLockerStatus.row != -1)
				{
					dsoListHistory.Call();
				}
        break;
    }

}
function OnNotchange()
{
	if(grdLockerStatus.col==3)
	{
		grdLockerStatus.row=-1;
	}
}
</script>
<body bgcolor='#F5F8FF'>
    <gw:data id="dsoListHistory" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="crm.sp_sel_jarc00120" procedure="crm.sp_upd_jarc00120">  
                <input bind="grdLockerStatus">  
					<input bind="dtFrom" />
                    <input bind="lstRoomStatus" />
					<input bind="txtUser_ID" />	
                </input> 
                <output bind="grdLockerStatus" /> 
            </dso> 
        </xml>
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%" border="0">
                    <tr style=" height: 100%">
					<td style="width:30%">
							<table style="width: 100%; height: 100%" border="1">
								<tr style=" height: 90%">
									<td  style="width:25%">
										<table style="width: 100%; height: 100%">   
											<tr style=" height: 2%">
												<td width="100%" style="border: 0">
													<table style="width: 100%; height: 100%">
													    <tr>
															<td style="width:16%">
																Staus
															</td>
															<td style="width:84%">
																<gw:list id="lstRoomStatus" styles="width: 100%" onchange=" OnSearch()" />
															</td>
														 
														</tr> 
													</table>
												<td>
											</tr>
											<tr style=" height: 3%">
												<td width="100%" style="border: 0">
													<table style="width: 100%; height: 100%">
													    <tr>
															<td style="width:16%">
																Date
															</td>
															<td style="width:78%">
																<gw:datebox id="dtFrom" type="date" lang="1" onchange=" OnSearch()" />
															</td>
															<td style="width:3%">
																<gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
															</td>
															<td style="width:3%">
																<gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('TuDo')" />
															</td>
														</tr> 
													</table>
												<td>	
											</tr>
											<tr style=" height: 2%">
												<td width="100%" style="border: 0">
												<table style="width: 100%; height: 100%">
													<tr>
														<td width="60%" style="border: 0" colspan="2" align="center">
															<gw:icon id="ibtnVC" alt="VACANCY CLEAN" text="VACANCY CLEAN" img="in" styles="width:100%;display:none"
															onclick="OnSave('VC')" />
															<gw:label id="lbCUS1" styles="text-align: center; color: white; background-color: #cd5c5c;width:100%;font-weight: bold;font-size:13;height:22px;display:none"></gw:label>
															<img src='imghtfo200\BT5.jpg' onclick="OnSave('VC')" onmouseover="javascript:this.style.cursor='hand'"  />
														</td>
													</tr>
												</table>
													
												</td>
												
											</tr>
											<tr style=" height: 2%">
												<td width="100%" style="border: 0">
													<table style="width: 100%; height: 100%">
													<tr>
														
														<td width="60%" style="border: 0" colspan="2" align="center">
															<gw:icon id="ibtnOC" alt="OCCUPPIED CLEAN" text="OCCUPPIED CLEAN" img="in" styles="width:100%;display:none"
															onclick="OnSave('OC')" />
												
															
														
															<gw:label id="lbCUS2" styles="text-align: center; color: white; background-color: #d7b3b3;width:100%;font-weight: bold;font-size:13;height:22px;display:none"></gw:label>
															<img src='imghtfo200\BT6.jpg' onclick="OnSave('OC')" onmouseover="javascript:this.style.cursor='hand'"  />
														</td>
													</tr>
												</table>
													
												<td>
											</tr>
											
											<tr style=" height: 2%">
												<td width="100%" style="border: 0">
													<table style="width: 100%; height: 100%">
													<tr>
														<td width="60%" style="border: 0" colspan="2" align="center">
															<gw:icon id="ibtnLOS" alt="LOST" text="LOST" img="in" styles="width:100%;display:none"
															onclick="OnSave('LOS')" />
														
															<gw:label id="lbCUS4" styles="text-align: center; color: white; background-color: #3399CC;width:100%;font-weight: bold;font-size:13;height:22px;display:none"></gw:label>
															<img src='imghtfo200\BT2.jpg' onclick="OnSave('LOS')" onmouseover="javascript:this.style.cursor='hand'"  />
														</td>
													</tr>
												</table>
													
												<td>
											</tr>
											<tr style=" height: 2%">
												<td width="100%" style="border: 0">
													<table style="width: 100%; height: 100%">
													<tr>
														<td width="60%" style="border: 0" colspan="2" align="center">
															<gw:icon id="ibtnNextTimeRTN" alt="NEXT TIME RETURN" text="NEXT TIME RETURN" img="in" styles="width:100%;display:none"
															onclick="OnSave('NRTN')" />
														
															<gw:label id="lbCUS5" styles="text-align: center; color: white; background-color: #898989;width:100%;font-weight: bold;font-size:13;height:22px;display:none"></gw:label>
															<img src='imghtfo200\BT1.jpg' onclick="OnSave('NRTN')" onmouseover="javascript:this.style.cursor='hand'"  />
														</td>
													</tr>
												</table>
													
												<td>
											</tr>
											
											<tr style=" height: 2%">
												<td width="100%" style="border: 0">
													<table style="width: 100%; height: 100%">
													<tr>
														<td width="60%" style="border: 0" colspan="2" align="center">
															<gw:icon id="ibtnBROKEN" alt="BROKEN" text="BROKEN" img="in" styles="width:100%;display:none"
															onclick="OnSave('BRK')" />
														
															<gw:label id="lbCUS3" styles="text-align: center; color: white; background-color: #336633;width:100%;font-weight: bold;font-size:13;height:22px;display:none"></gw:label>
															<img src='imghtfo200\BT3.jpg' onclick="OnSave('BRK')" onmouseover="javascript:this.style.cursor='hand'"  />
														</td>
													</tr>
												</table>
													
												<td>
											</tr>
											<tr style=" height: 85%">
												
											</tr>
										</table>
									</td>
									 <td style="width:75%">
										<table style="width: 100%; height: 100%"  border="1">
											<tr style="height: 98%">
												<td> 
													<gw:grid id='grdLockerStatus' header='_PK|Date|Locker#|Status|Vip YN|Description|Create By|Create Date|Modify By|Modify Date' 
														format  ='0|4|0|0|3|0|0|0|0|0' 
														aligns  ='0|0|0|0|0|0|0|0|0|0' 
														editcol ='0|0|0|1|0|1|0|0|0|0'
														defaults='|||||||||'  
														autosize='T'
														widths='0|1000|100|2500|1000|1000|1000|1000|1000|1000' sorting='T' 
														styles='width:100%;height:100%'	
														autosize="T" oncellclick="OnNotchange()"  />																
												</td>
											</tr>  
										</table>
									</td>
								</tr>
							</table>
						</td>
						
                    </tr>                    
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtRoomPK" styles="width:100%;display:none" />
	<gw:textbox id="txtRoomStatus" styles="width:100%;display:none" />
    <gw:textbox id="txtStaffPK" styles="width:100%;display:none" />
	 <gw:textbox id="txtUser_ID" styles="width:100%;display:none" />
</body>
