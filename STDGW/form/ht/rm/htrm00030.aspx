<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Room Allocated Status</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
var COL_M_PK=0,
	COL_M_Last_Name=1,
	COL_M_First_Name=2,
	COL_M_Rate_Plan=3,
	COL_M_Room_Type=4,
	COL_M_Rate=5,
	COL_M_Adult=6,
	COL_M_Child=7,
	COL_M_RoomNo=8,
	COL_M_Arrival=9,  
	COL_M_Departure=10,
	COL_M_Nights=11,
	COL_M_Nation=12,
	COL_M_Book_By=13,
	COL_M_Book_Phone=14,
	COL_M_RSV_No=15,//slip_no
	COL_M_Register_By=16,
	COL_M_Register_Date=17,
	COL_M_Request=18,
	COL_M_col_set_color=19,
	COL_M_contact_name=20,
	COL_M_contact_phone=21,
	COL_M_contact_email=22,
	COL_M_guest2_name=23,
	COL_M_guest3_name=24,
	COL_M_guest4_name=25;
    
var COL_R_PK			= 0,
	COL_R_BUILDING_NO	= 1,
	COL_R_FLOOR_NO		= 2,
	COL_R_ROOM_NO		= 3,
	COL_R_ROOM_CODE		= 4,
	COL_R_ROOM_TYPE		= 5,
	COL_R_DESCRIPTION	= 6;

var COL_A_PK				= 0,
	COL_A_BUILDING_NO		= 1,
	COL_A_FLOOR_NO			= 2,
	COL_A_ROOM_NO			= 3,
	COL_A_ROOM_TYPE			= 4,
	COL_A_RATE_PLANS        = 5,  
	COL_A_RATE_ADULT        = 6, 
	COL_A_RATE_ADULT_Female = 7,
	COL_A_RATE_CHILD        = 8,
	COL_A_RATE_CHILD_Female = 9,
	COL_A_PRICE				= 10, 
	COL_A_DEPOSIT =11,//Advance
	COL_A_GUEST_ID			= 12,
	COL_A_LAST_NAME		= 13,//last_name
	COL_A_FIRST_NAME		= 14,
	COL_A_GENDER			= 15,
	COL_A_NATION			= 16,
	COL_A_FROM_DATE         = 17,
	COL_A_TO_DATE           = 18,
	COL_A_PA_ID				=19,
	COL_A_DESCRIPTION		= 20,
	COL_A_THT_BOOKINGD_PK	= 21,
	COL_A_THT_ROOM_PK		= 22,
	COL_A_THT_RATE_PLANS_PK = 23,
	COL_A_RSV_No=24,//slip_no
	COL_A_contact_name=25,
	COL_A_contact_phone=26,
	COL_A_contact_email=27,
	COL_A_guest_request=28,
	COL_A_guest2_name=29,
	COL_A_guest3_name=30,
	COL_A_guest4_name=31;
function BodyInit()
{
	BindingDataList();
	
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-1));
	//dtTo.SetDataText(System.AddDate(dtFrom.GetData(),8));
	dso_htbk00030_mst.Call('SELECT');	
}
function BindingDataList()
{
	var data = '';
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'RTYPE'")%>";
	grdMST.SetComboFormat(COL_M_Room_Type, data);

	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'RTYPE'" )%>|ALL|Select All"; 
	lstRoomType.SetDataText(data);
	lstRoomType.value='ALL';

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.PK,a.RATE_CODE ||' - '||a.RATE_NAME FROM  CRM.THT_RATE_PLANS a WHERE a.DEL_IF=0")%>";
	grdMST.SetComboFormat(COL_M_Rate_Plan, data);//rate plans


	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'RTYPE'")%>";
	grdAllocate.SetComboFormat(COL_A_ROOM_TYPE, data);

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>";
	grdAllocate.SetComboFormat(COL_A_GENDER, data);
	grdAllocate.value = 'GEN-M';

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>";
	grdAllocate.SetComboFormat(COL_A_NATION, data);
	grdAllocate.value = 'NAT-VIE';
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>";
	grdMST.SetComboFormat(COL_M_Nation, data);
}

function OnSearch(n)
{
	switch(n)
	{
		case 1:
			dso_htbk00030_mst.Call('SELECT');
		break;
		case 2:
			if (grdMST.rows > 1)
			{
				grdAllocate.ClearData();
				THT_BOOKINGD_PK.text = grdMST.GetGridData(grdMST.row, COL_M_PK);//
				lstRoomType.value = grdMST.GetGridData(grdMST.row, COL_M_Room_Type);//
				txtDateFrom.value=grdMST.GetGridData(grdMST.row, COL_M_Arrival);  
				txtDateTo.value=grdMST.GetGridData(grdMST.row, COL_M_Departure);	
				dso_htbk00030_allocate.Call('SELECT');
			}
		break;
	}
}

function OnDelete()
{
	if (confirm('Are you sure delete data ?'))
	{
		grdAllocate.DeleteRow();
		dso_htbk00030_allocate.Call();	
	}
}
function OnSave()
{
	if(CheckValidate())
	{
		dso_htbk00030_allocate.Call();
	}
}
function CheckValidate()
{
    for(var i=1;i<grdAllocate.rows;i++)
          {
            if(grdAllocate.GetGridData(i,COL_A_RATE_ADULT) == "" && grdAllocate.GetGridData(i,COL_A_RATE_ADULT_Female) == "") 
             {
                alert("Please, input adult male or adult female at row "+ i);       
                return false;
             }
			 if(grdAllocate.GetGridData(i,COL_A_FROM_DATE) == grdAllocate.GetGridData(i,COL_A_TO_DATE)) 
             {
                if(!confirm("Arrival date "+ grdAllocate.GetGridData(i,COL_A_FROM_DATE)+" is correct ?")){       
					return false;
				}
             }
			 if(grdAllocate.GetGridData(i,COL_A_FROM_DATE) > grdAllocate.GetGridData(i,COL_A_TO_DATE)) 
             {
                alert("Arrival date can not greater than Departure date.");       
				return false;
				
             }
          }
          return true;
}
function OnSelectRoom()
{
	if (grdMST.rows > 1)
	{
		if (grdMST.row == '-1')
		{
			alert('Please, Select Room Type.')
			return;
		}

		THT_BOOKINGD_PK.text = grdMST.GetGridData(grdMST.row, COL_M_PK);
		
		if (THT_BOOKINGD_PK.text != '')
		{	
			if (grdAllocate.rows > 1)
			{
				for (row = 1; row < grdAllocate.rows; row++)
				{
					if (grdAllocate.GetGridData(row, COL_A_THT_BOOKINGD_PK) == THT_BOOKINGD_PK.text)
					{
						return;
					}
				}

				grdAllocate.AddRow();
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_BUILDING_NO,		grdRoom.GetGridData(grdRoom.row, COL_R_BUILDING_NO));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_FLOOR_NO,			grdRoom.GetGridData(grdRoom.row, COL_R_FLOOR_NO));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_ROOM_NO,			grdRoom.GetGridData(grdRoom.row, COL_R_ROOM_NO));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_ROOM_TYPE,		grdRoom.GetGridData(grdRoom.row, COL_R_ROOM_CODE));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_LAST_NAME,		grdMST.GetGridData(grdMST.row, COL_M_Last_Name	));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_FIRST_NAME,		grdMST.GetGridData(grdMST.row, COL_M_First_Name));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_GENDER,			'GEN-M');
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_NATION,			grdMST.GetGridData(grdMST.row, COL_M_Nation));//nation
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_THT_BOOKINGD_PK,	grdMST.GetGridData(grdMST.row, COL_M_PK));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_THT_ROOM_PK,		grdRoom.GetGridData(grdRoom.row, COL_R_PK));
				
                grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_THT_RATE_PLANS_PK,grdMST.GetGridData(grdMST.row, COL_M_Rate_Plan));//rate_plan_pk    
                grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_TO_DATE, grdMST.GetGridData(grdMST.row, COL_M_Departure));//date_to
				
				
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_RSV_No, grdMST.GetGridData(grdMST.row, COL_M_RSV_No));//slip_no
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_contact_name, grdMST.GetGridData(grdMST.row, COL_M_contact_name));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_contact_phone, grdMST.GetGridData(grdMST.row, COL_M_contact_phone));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_contact_email, grdMST.GetGridData(grdMST.row, COL_M_contact_email));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_guest_request, grdMST.GetGridData(grdMST.row, COL_M_Request));
				
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_guest2_name, grdMST.GetGridData(grdMST.row, COL_M_guest2_name));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_guest3_name, grdMST.GetGridData(grdMST.row, COL_M_guest3_name));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_guest4_name, grdMST.GetGridData(grdMST.row, COL_M_guest4_name));
				grdRoom.SetCellFontColor(grdRoom.row, 0, grdRoom.row, grdRoom.cols-1, 0x0000FF);
			} 
			else
			{
				grdAllocate.AddRow();
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_BUILDING_NO,		grdRoom.GetGridData(grdRoom.row, COL_R_BUILDING_NO));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_FLOOR_NO,			grdRoom.GetGridData(grdRoom.row, COL_R_FLOOR_NO));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_ROOM_NO,			grdRoom.GetGridData(grdRoom.row, COL_R_ROOM_NO));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_ROOM_TYPE,		grdRoom.GetGridData(grdRoom.row, COL_R_ROOM_CODE));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_LAST_NAME,		grdMST.GetGridData(grdMST.row, COL_M_Last_Name	));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_FIRST_NAME,		grdMST.GetGridData(grdMST.row, COL_M_First_Name));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_GENDER,			'GEN-M');
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_NATION,			grdMST.GetGridData(grdMST.row, COL_M_Nation));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_THT_BOOKINGD_PK,	grdMST.GetGridData(grdMST.row, COL_M_PK));				
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_THT_ROOM_PK,		grdRoom.GetGridData(grdRoom.row, COL_R_PK));
                
                grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_THT_RATE_PLANS_PK, grdMST.GetGridData(grdMST.row, COL_M_Rate_Plan));//rate_plan_pk
                grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_TO_DATE, grdMST.GetGridData(grdMST.row, COL_M_Departure));//date_to
				
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_RSV_No, grdMST.GetGridData(grdMST.row, COL_M_RSV_No));//slip_no
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_contact_name, grdMST.GetGridData(grdMST.row, COL_M_contact_name));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_contact_phone, grdMST.GetGridData(grdMST.row, COL_M_contact_phone));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_contact_email, grdMST.GetGridData(grdMST.row, COL_M_contact_email));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_guest_request, grdMST.GetGridData(grdMST.row, COL_M_Request));
				
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_guest2_name, grdMST.GetGridData(grdMST.row, COL_M_guest2_name));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_guest3_name, grdMST.GetGridData(grdMST.row, COL_M_guest3_name));
				grdAllocate.SetGridText(grdAllocate.rows-1, COL_A_guest4_name, grdMST.GetGridData(grdMST.row, COL_M_guest4_name));
				grdRoom.SetCellFontColor(grdRoom.row, 0, grdRoom.row, grdRoom.cols-1, 0x0000FF);
			}
			grdMST.SetCellFontColor(grdMST.row, 0, grdMST.row, grdRoom.cols-1, 0x0000FF);
		}			
	}
}

function OnRemoveRoom()
{
	for(row = grdAllocate.rows-1; row > 0; row--)
	{
		agin:
		if (grdAllocate.GetGridControl().isSelected(row) == true)
		{
			if (grdAllocate.GetGridData(row, COL_A_PK) == '')
			{
				for (j = 1; j < grdDTL.rows; j++ )
				{
					if (grdAllocate.GetGridData(row, COL_A_THT_BOOKINGD_PK) == grdDTL.GetGridData(j, COL_R_PK))
					{						
						grdDTL.SetCellFontColor(j, 0, j, grdDTL.cols-1, 0x000000);
					}
				}

				for (i = 1; i < grdRoom.rows; i++)
				{
					if (grdAllocate.GetGridData(row, COL_A_THT_ROOM_PK) == grdRoom.GetGridData(i, COL_R_PK))
					{
						grdAllocate.RemoveRowAt(row);
						grdRoom.SetCellFontColor(i, 0, i, grdRoom.cols-1, 0x000000);
						break agin;
					}
				}
			}
		}
	}
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_htbk00030_mst':			
				lblStatus.text = grdMST.rows-1 +" "+" rows";
				if(grdMST.rows > 0)
				{
					for (i = 1; i < grdMST.rows; i++)
					{
						if (grdMST.GetGridData(i, 19) > 0 )
						{
							grdMST.SetCellBgColor(i, 0, i,19,0XEE82EE);//0xB3B3D7  0x336633  0x0000CE

						}
					}
				}
				dso_htbk00030_room.Call('SELECT');
		break; 
		case 'dso_htbk00030_allocate':
				//grdAllocate.GetGridControl().row = 1;
				dso_htbk00030_room.Call('SELECT');	
		break; 
		case 'dso_htbk00030_room':
			if(grdAllocate.rows > 1)
			{
				grdAllocate.GetGridControl().row = 1;
			}
		break; 
	}
}
function OnclickGrid()
{
    if(grdAllocate.col == 4)
    {
        return grdAllocate.row = -1;
    }
}
function OnChangeDeposit()
{
	if(event.col==11 && grdAllocate.GetGridData(grdAllocate.row, 5) != "")
    {
		var guest_name = grdAllocate.GetGridData(grdAllocate.row, 13)+" "+grdAllocate.GetGridData(grdAllocate.row, 14);
		var path = System.RootURL + '/form/ht/fo/htfo00180_popup_deposit.aspx?p_room_allocate_pk='+ grdAllocate.GetGridData(grdAllocate.row, 0)+"&p_guest_name="+guest_name+"&p_room_no="+grdAllocate.GetGridData(grdAllocate.row, 3);
		var object = System.OpenModal( path ,800 , 300 ,  'resizable:yes;status:yes',window);
		OnSearch(2);
	}
}
function OnReport()
{
	/*var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/rm/htrm00030.rpt&procedure=crm.sp_sel_htrm00030_allocate&parameter="+THT_BOOKINGD_PK.text;              
        System.OpenTargetPage(url); */
		 var url = '/reports/ht/rm/htrm00030.aspx?p_pk='+ THT_BOOKINGD_PK.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
}
function OnchangeList()
{
	dso_htbk00030_room.Call("SELECT");
}
function OnDeposit()
{
	if(grdAllocate.row !='-1' && grdAllocate.GetGridData(grdAllocate.row, 5) != "")
    {
		var guest_name = grdAllocate.GetGridData(grdAllocate.row, 13)+" "+grdAllocate.GetGridData(grdAllocate.row, 14);
		var path = System.RootURL + '/form/ht/fo/htfo00180_popup_deposit.aspx?p_room_allocate_pk='+ grdAllocate.GetGridData(grdAllocate.row, 0)+"&p_guest_name="+guest_name+"&p_room_no="+grdAllocate.GetGridData(grdAllocate.row, 3);
		var object = System.OpenModal( path ,800 , 300 ,  'resizable:yes;status:yes',window);
		OnSearch(2);
	}
	else
	{
		alert("Please,choose guest name to input advance deposit(you must save finish then input deposit).");
	}
}

function OnPA()
{
	if(grdAllocate.row !='-1' )
    {
		


 var url = '/reports/ht/rm/rpt_htrm00030.aspx?tht_room_allocate_pk='+ grdAllocate.GetGridData(grdAllocate.row, 0);
	     System.OpenTargetPage( System.RootURL+url , "newform" );

	 
	}	
}

</script>

<body>
    <gw:data id="dso_htbk00030_mst" onreceive="OnDataReceive(this)">
	<xml> 
		<dso type="grid" parameter="" function="CRM.sp_sel_htrm00030_guest_chkin">
			<input bind="grdMST">
				<input bind="dtFrom" />
				<input bind="dtTo" />
				<input bind="txtPerson" />
			</input> 
			<output bind="grdMST" /> 
		</dso> 
	</xml> 
</gw:data>
    <gw:data id="dso_htbk00030_room" onreceive="OnDataReceive(this)">
	<xml> 
		<dso type="grid" parameter="" function="CRM.SP_SEL_HTRM00030_ROOM">
			<input bind="grdRoom">
			   
				 <input bind="lstRoomType" />
			</input> 
			<output bind="grdRoom" /> 
		</dso> 
	</xml> 
</gw:data>
    <gw:data id="dso_htbk00030_allocate" onreceive="OnDataReceive(this)">
	<xml> 
		<dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31" function="CRM.SP_SEL_HTRM00030_ALLOCATE" procedure="CRM.SP_UPD_HTRM00030_ALLOCATE">
			<input bind="grdAllocate">
				<input bind="THT_BOOKINGD_PK" />
			</input> 
			<output bind="grdAllocate" /> 
		</dso> 
	</xml> 
</gw:data>
    <table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
        <tr style="width: 100%; height: 1%">
            <td style="width: 100%; background: white" valign="top">
                <table style="width: 100%" border="0">
                    <tr>
                        <td style="width: 10%" align="right">
                            Date</td>
                        <td style="width: 20%">
                            <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch(1)" />
                            ~<gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch(1)" />
                        </td>
                        <td style="width: 10%" align="right">
                            Book By</td>
                        <td style="width: 30%">
                            <gw:textbox id="txtPerson" styles="width: 100%" onenterkey="OnSearch(1)" />
                        </td>
                        <td style="width: 4%" align="center">
                            Total :
                        </td>
                        <td style="width: 10%" align="center">
                            <gw:label id="lblStatus" styles="color: blue"></gw:label>
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch(1)" />
                        </td>
                        <td style="width: 12%">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 60%; background: white">
            <td style="width: 100%">
                <gw:grid id="grdMST" header="_PK|Last Name|First Name|Rate Plan|Room Type|Rate|Adult|Child|Room#|Arrival|Departure|Nights|Nation|Book By|Book Phone|RSV#|Register By|Register Date|Request|_col_set_color|_contact_name|_contact_phone|_contact_email|_guest2_name|_guest3_name|_guest4_name"
                    format="0|0|0|0|0|0|0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					aligns="0|0|0|0|0|0|0|0|1|1|3|3|0|1|0|0|0|0|0|0|0|0|0|0|0|0" 
					defaults="|||||||||||||||||||||||||"
                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" styles="width:100%;height:100%"
                    autosize='T' debug='false' oncellclick="OnSearch(2)" />
            </td>
        </tr>
        <tr style="width: 100%; height: 1%">
            <td style="width: 100%; background: white" valign="top">
                <table style="width: 100%" border="0">
                    <tr>
                        <td style="width: 8%">
							Room Type
                        </td>
						<td style="width: 17%" align="right">
						<gw:list id="lstRoomType" styles="width: 100%" onchange="OnchangeList()" />
                        </td>
                        <td style="width: 13%" align="right">
                        </td>
                        <td style="width: 29%">
                        </td>
                        <td style="width: 16%">
                        </td>
                        <td style="width: 1%">
<gw:icon id="btnPA" img="2" text="PA" styles='width:100%' onclick="OnPA()" />
                        </td>
                       <td style="width: 7%">
							<gw:icon id="btnDeposit" img="2" text="Deposit" styles='width:100%' onclick="OnDeposit()" />
						</td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                        </td>
						 <td width="3%" align="right">
                            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 38%; background: white">
            <td style="width: 100%">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 18%; height: 5%; background: #BDE9FF">
                            <gw:grid id="grdRoom" header="_PK|_Building No|_Floor No|Room|_Room_Code|Room Type|Description"
                                format="0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0" defaults="||||||" editcol="0|0|0|0|0|0|0"
                                widths="0|2000|2000|1500|1000|0|0" styles="width:100%;height:100%" autosize='T'
                                debug='false' oncelldblclick="OnSelectRoom()" />
                        </td>
                        <td style="width: 3%" align="center">
                            <gw:icon id="ibtnSelect" img="in" text=">>" onclick="OnSelectRoom()" />
                            </br>
                            <gw:icon id="ibtnRemove" img="in" text="<<" onclick="OnRemoveRoom()" />
                        </td>
                        <td style="width: 79%; height: 5%; background: #BDE9FF">
                            <gw:grid id="grdAllocate" header="_PK|_Building No|_Floor No|Room No|Room Type|Rate Plans|Adult-M|Adult-F|Child-M|Child-F|Rate|Advance|_Guest ID|Last Name|First Name|Gender|Nation|Arrival|Departure |PA/ID|Description|_tht_bookingd_pk|_tht_room_pk|_tht_rate_plans_pk|_RESERVATION_NO|_CONTACT_NAME|_CONTACT_PHONE|_CONTACT_EMAIL|_GUEST_REQUEST|_guest2_name|_guest3_name|_guest4_name"
                                format="0|0|0|0|0|0|0|0|0|0|-2|-0|0|0|0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|0|0" 
								aligns="0|0|0|1|0|0|3|3|3|3|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"                                
                                defaults="|||||||||||||||||||||||||||||||" 
								editcol="0|0|0|0|0|0|1|1|1|1|0|0|0|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0"
                                widths="0|2000|2000|1000|1500|1000|1000|1000|1000|1000|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
								styles="width:100%;height:100%"
                                autosize='T' debug='false'  oncellclick="OnclickGrid()" oncelldblclick="OnChangeDeposit()"  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="THT_BOOKING_PK" styles="display: none" />
<gw:textbox id="THT_BOOKINGD_PK" styles="display: none" />
<gw:textbox id="txtDateFrom" styles="display: none" />
<gw:textbox id="txtDateTo" styles="display: none" />
<!--------------------------------------------------------------------------------------->
</html>
