<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>APPLICATION ENTRY</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var flag;

//-------------------
    
 
    
//-------------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    <%=ESysLib.SetGridColumnComboFormat( "grdDetail" , 6 , "select   a.room_id, a.room_name from thr_hs_room a where a.del_if = 0 order by a.room_name") %>; 
	idBtnSave.SetEnable(false);
	idBtnCheckIn.SetEnable(false);
	idBtnCheckOut.SetEnable(false);
}
  
 
	function OnDataReceive(obj)
	{
		switch (obj.id)
		{
			 
		   case 'dsohr_chhs00010_s_02':
				if(flag == 'SELECT')
					dsohr_chhs00010_s_05.Call('SELECT');
				else
				{
					for(var j=1;j<grdDetail.rows;j++)
					{
						if ( grdDetail.GetGridData( j, 10 ) == '' )
								grdDetail.SetGridText(j, 10, txtMasterPK.text);
					}
					dsohr_chhs00010_s_05.Call();
				}
		   break;
		   case 'dsohr_chhs00010_s_05':
				idBtnNew.SetEnable(true);
		   break;
		   case 'dsohr_chhs00010_p_07':
				alert(txtResult.text);
				if(txtResult.text == 'Y')
				{
					idBtnCheckIn.SetEnable(false);
				}
		   break;
		   case 'dsohr_chhs00010_p_08':
				if(txtResult.text == 'Y')
				{
					idBtnCheckOut.SetEnable(false);
					idBtnCheckIn.SetEnable(false);
					idBtnSave.SetEnable(false);
				}
				dsohr_chhs00010_s_02.Call('SELECT');
		   break;
		}
	}
 
	function OnNew()
	{
		dsohr_chhs00010_s_02.StatusInsert();
		flag = 'SAVE';
		grdDetail.ClearData();
		txtMasterPK.text="";
		dtFrom2.value="";
		dtTo2.value="";
		chkAMT.value="";
		txtName2.text="";
		txtTel2.text="";
		txtID2.text="";
		txtTotalPerson.text="";
		txtDeposite.text="";
		txtAddr.text="";
		txtReason.text="";
		txtBookID2.text="";
		txtRoomFee.text="";
		txtServiceFee.text="";
		idBtnNew.SetEnable(false);
		idBtnSave.SetEnable(true);
	}
	
	function OnSave(pos)
	{    
		switch(pos)
		{ 
			case 'Master':
				flag = 'SAVE';
				dsohr_chhs00010_s_02.Call();
			break;
		}
		idBtnNew.SetEnable(true);
	}

	function OnCheckFreeRoom()
	{
		dsohr_chhs00010_s_04.Call("SELECT");
	}
	function OnAddRoom()
	{
		var flag1 = 0;
		for(var i=1;i<grdDetail2.rows;i++)
		{
			flag1 = 0;
			if (grdDetail2.GetGridData(i,1)=="-1")
			{
				for(var j=0;j<grdDetail.rows;j++)
				{
					if(grdDetail.GetGridData(j,6)==grdDetail2.GetGridData(i,0)
					  && grdDetail.GetGridData(j,3)==grdDetail2.GetGridData(i,3))
					{
						flag1 = 1;
					}
				}
				if(flag1==0)
				{
					grdDetail.AddRow();
					grdDetail.SetGridText(grdDetail.rows-1,3,grdDetail2.GetGridData(i,3));
					grdDetail.SetGridText(grdDetail.rows-1,6,grdDetail2.GetGridData(i,0));
					grdDetail.SetGridText(grdDetail.rows-1,7,grdDetail2.GetGridData(i,4));
					 
				}
			}
			//alert(flag);
		}/**/
	}

	function OnSelectEmp()
	{
		txtMasterPK.text = grdMaster.GetGridData(event.row, 0);
		idBtnSave.SetEnable(true);
		if( grdMaster.GetGridData(event.row, 8) == 'Y' )
		{
			idBtnCheckIn.SetEnable(false);
		}
		else
		{
			idBtnCheckIn.SetEnable(true);
		}
		if( grdMaster.GetGridData(event.row, 9) == 'Y' )
		{
			idBtnCheckOut.SetEnable(false);
			idBtnCheckIn.SetEnable(false);
			idBtnSave.SetEnable(false);				
		}
		else
		{
			idBtnCheckOut.SetEnable(true);
			idBtnSave.SetEnable(true);
		}
		
		flag = 'SELECT';
		dsohr_chhs00010_s_02.Call("SELECT");	
	}
	function OnRefresh()
	{
		dsohr_chhs00010_s_04.Call("SELECT");
	}
	
	function OnCheckIn()
	{
		dsohr_chhs00010_p_07.Call();
	}
	function OnCheckOut()
	{
		dsohr_chhs00010_p_08.Call();
	}
</script>

<body>
 
	<gw:data id="dsohr_chhs00010_s_01" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" 
			function="hr_chhs00010_s_01" > 
                <input bind="grdMaster">
                    <input bind="idFrom1" /> 
                    <input bind="idTo1" />               
                    <input bind="txtName1" />
					<input bind="txtBookID1" />
					<input bind="lstStatus1" />
                </input> 
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data> 
	
	<gw:data id="dsohr_chhs00010_s_02" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" 
				parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" 
				function="hr_chhs00010_s_02" 
				procedure="hr_chhs00010_u_03">
                <input>
                    <inout bind="txtMasterPK" /> 
                    <inout bind="txtBookID2" />
					<inout bind="dtFrom2" />
                    <inout bind="dtTo2" />
                    <inout bind="chkAMT" />
                    <inout bind="txtName2" />
                    <inout bind="txtTel2" />
                    <inout bind="txtID2" />
                    <inout bind="txtTotalPerson" />                    
                    <inout bind="txtAddr" />
					<inout bind="txtRoomFee" />
                    <inout bind="txtDeposite" />
					<inout bind="txtServiceFee" />					
                    <inout bind="txtReason" /> 
					<inout bind="lblTotal" />
                </input>
            </dso>
        </xml>
    </gw:data>
	
	<gw:data id="dsohr_chhs00010_s_04" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" 
			function="hr_chhs00010_s_04" > 
                <input bind="grdDetail2">
                    <input bind="dtFrom2" /> 
                    <input bind="dtTo2" /> 
                </input> 
                <output bind="grdDetail2" /> 
            </dso> 
        </xml> 
    </gw:data> 
	
	<gw:data id="dsohr_chhs00010_s_05" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" 
			function="hr_chhs00010_s_05" 
			procedure="hr_chhs00010_u_06"
			parameter="0,1,2,3,4,5,6,7,8,9,10,11,12"> 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
	
	<gw:data id="dsohr_chhs00010_p_07" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="process" 
			procedure="hr_chhs00010_p_07" >
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
	
	<gw:data id="dsohr_chhs00010_p_08" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="process" 
			procedure="hr_chhs00010_p_08" >
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
	
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            Ngày đặt từ:
                        </td>
                        <td  style="width: 90%" nowrap>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 100%">
                                    <td style="width: 50%" >
                                        <gw:datebox id="idFrom1" />
                                    </td>
                                    <td style="width: 45%" >
                                        <gw:datebox id="idTo1" />
                                    </td>
									<td>
										<gw:imgBtn id="idSearch" img="search" text="Search" styles='width:100%' onclick="dsohr_chhs00010_s_01.Call('SELECT');" />
									</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            Tên / CMND / SDT
                        </td>
                        <td>
                            <gw:textbox id="txtName1" styles="width:100%"  onenterkey="dsohr_chhs00010_s_01.Call('SELECT');"/>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap">
                            Mã đặt chổ
                        </td>
                        <td width="70%">
                            <gw:textbox id="txtBookID1" onenterkey="dsohr_chhs00010_s_01.Call('SELECT');"/>
                        </td>
                    </tr>
					<tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap">
                            Tình trạng phòng
                        </td>
                        <td width="70%">
                            <gw:list id="lstStatus1" value='ALL'>
								<data>|20|Đã đặt|30|Đã nhận|40|Đã trả|50|Đã hủy|ALL|Tất cả các phòng
								</data>
							</gw:list>
                        </td>
                    </tr>
                    <tr style="height: 96%">
                        <td colspan="2">
                            <gw:grid id='grdMaster' 
							    header='_PK|Tên|Từ ngày|Đến ngày|SDT|CMND|Tình trạng|CusID|Checkin_YN|CheckOut_YN'
                                format='0|0|4|4|0|0|0|0|0|0' 
								aligns='0|0|0|0|0|0|0|0|0|0' 
								defaults='|||||||||' 
								editcol='0|0|0|0|0|0|0|0|0|0'
                                widths='0|2000|1200|1200|1500|1500|1500|1500|1500|1500' 
								sorting='T' 
								oncellclick="OnSelectEmp()"
                                styles='width:100%; height:100%'  />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td colspan="6">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td align="right" style="width: 30%">
										Book ID
                                    </td>
									<td align="right" style="width: 24%">
										<gw:textbox id="txtBookID2" />
                                    </td>
									<td align="right" style="width: 36%">
										 
                                    </td>
                                    <td style="width: 2%" align="right"> 
                                        <gw:icon id="idBtnPopup" img="in" text="Tìm Phòng" styles='width:100%;display:none;' onclick="OnPopUp('Request')" />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:icon id="idBtnNew" img="in" text="Đặt mới" styles='width:100%' onclick="OnNew('Master')" />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:icon id="idBtnSave" img="in" text="Cập nhật" styles='width:100%' onclick="OnSave('Master')" />
                                    </td>
                                    <td style="width: 2%">
                                        <gw:icon id="idBtnGetCustomer" img="in" text="Khách cũ" styles='width:100%;display:none;' onclick="OnSave('Master')" /> 
                                    </td>
									<td style="width: 2%">
                                        <gw:icon id="idBtnCheckIn" img="in" text="Nhận phòng" styles='width:100%' onclick="OnCheckIn()" /> 
                                    </td>
									<td style="width: 2%">
                                        <gw:icon id="idBtnCheckOut" img="in" text="Thanh toán" styles='width:100%' onclick="OnCheckOut()" /> 
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%" nowrap>
                            Từ ngày
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtFrom2" styles="width: 100%" csstype="mandatory" onchange="OnCheckFreeRoom()" />
                        </td>
                        <td align="right" style="width: 10%">
                            Đến ngày</td>
                        <td align="left" style="width: 20%">
                            <gw:datebox id="dtTo2" lang="<%=Application("Lang")%>" mode="01"  onchange="OnCheckFreeRoom()" />
                        </td>
                        <td style="width: 10%" align="right">
                             Chuyển ATM
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                             <gw:checkbox id="chkAMT" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%">
                            <b>Tên Khách đặt</b>
                        </td>
                        <td align="right" style="width: 20%">
                            <gw:textbox id="txtName2" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 10%">
                            SDT</td>
                        <td align="right" style="width: 20%">
                            <gw:textbox id="txtTel2" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            CMND
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtID2" styles="width:100% " />
                            
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%">
                            Số lượng khách
                        <td>
                            <gw:textbox id="txtTotalPerson" styles="width: 100% " />
                             
                        </td>
                        <td align="right" style="width: 10%">
                            </td>
                        <td>
                            
                        </td>
                        <td align="right" style="width: 10%">
                            Địa chỉ</td>
                        <td>
                            <gw:textbox id="txtAddr" styles="width:100%" />
                        </td>
                    </tr>
					<tr style="height: 2%">
                        
                        <td align="right" style="width: 10%">
                             Tiền cọc</td>
                        <td>
                             <gw:textbox id="txtDeposite" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 10%">
                             Dịch vụ thêm</td>
                        <td>
                             <gw:textbox id="txtServiceFee" styles="width: 100% " />
                        </td>
						<td align="right" style="width: 10%">
                            Tiền phòng
                        <td>
                             <gw:textbox id="txtRoomFee" styles="width:100%" />                            
                        </td>
                    </tr>
                    <tr style="height: 20%">
                        <td align="right" style="width: 10%">
                            Ghi chú</td>
                        <td colspan="3">
                            <gw:textarea id="txtReason" styles="width:100%;height:99%" />
                        </td>
						<td align="right" style="width: 10%">
                            Thành tiền</td>
                        <td colspan="1">
                            <gw:label id="lblTotal" text="" styles="width:100%;height:99%;text-align:center;vertical-align:middle;font-size:18.0pt;color:red;font-weight:600;" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td colspan="6">
                            <table>
                                <tr>
                                    <td align="left" style="width: 10%">
                                     Phòng trống     
                                    </td>
									<td align="left" style="width: 10%">
                                      <gw:imgbtn id="btnRefresh" img="refresh" alt="Refresh" onclick="OnRefresh()" />    
                                    </td>
                                    <td  align="left" style="width: 10%">
                                        <gw:imgbtn id="btnAddDTL" img="next" alt="Add" onclick="OnAddRoom()" /> 
                                    </td>
                                    <td align="right" style="width: 10%">
										
									</td>
                                    <td align="right" style="width: 20%">
                                         
                                    </td>
                                    <td align="right" style="width: 10%">
                                         </td>
                                    <td align="right" style="width: 20%">
                                         
                                    </td>
                                    <td style="width: 7%">
                                    </td>
                                    <td style="width: 1%">
										<gw:imgbtn id="btnAddDTL" img="new" alt="Add" onclick="OnAdd('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteDTL" img="delete" alt="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDeleteDTL" img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 88%">
                        <td colspan="10">
							<table style="height: 100%;width:100%" >								 
								<tr style="height: 100%; width:100%">
									<td style="width:22%;height:100%">
										<gw:grid id='grdDetail2' 
										header='_Room_ID|V|Phòng|Ngày|Đơn giá|Số người'
										format='0|3|0|4|0|0' 
										aligns='0|0|0|0|0|0' 
										defaults='||||||'
										editcol='0|1|0|0|0|0' 
										widths='0|400|1200|1000|1000|1000'
										sorting='T'   
										styles='width:100%; height:100%' />
									</td>
									<td style="width:78%;height:100%">
										<gw:grid id='grdDetail' 
										header='_PK|STT|Tên Khách|Ngày|SDT|CMND|Tên Phòng|Giá phòng|Ghi chú|_Old Room_ID|_thr_hs_book_m_pk|_cus_id|_Old stay date'
										format='0|0|0|4|0|0|0|0|0|0|0|0|4' 
										aligns='0|0|0|0|0|0|0|0|0|0|0|0|0' 
										defaults='|||||||||||||'
										editcol='0|0|1|1|1|1|1|1|1|1|1|1|1' 
										widths='0|800|2000|1200|1200|1200|1200|1500|3000|1500|1500|1500|1500'
										sorting='T'   
										styles='width:100%; height:100%' />
									</td>									
								</tr>
							</table>                            
                        </td>						
                    </tr>                    
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtReplicateYN" style="display:none" />
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtManager_PK" style="display:none" />  
    <gw:textbox id="txtManager_ID" style="display:none" />
    <gw:textbox id="txtManager_NM" style="display:none" /> 
    <gw:textbox id="txtGroupList" style="display:none" />
    <gw:textbox id="txtRtnValue" style="display:none" />
    <gw:datebox id="txtdatetmp" style="display:none" />
	<gw:textbox id="txtResult" text="" style="display:none" />
    
</body>
</html>
