<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Check In</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>

var COL_PK			= 0,
	COL_SELECT		= 1,
	COL_BULDING_NO	= 2,
	COL_AREA_NO		= 3,
	COL_FLOOR_NO	= 4,
	COL_ROOM_NO		= 5,
	COL_THT_ROOM_PK	= 6,  
	COL_ROOM_TYPE	= 7,
	COL_FROM_DATE	= 8,
	COL_TO_DATE		= 9,//departure
	COL_RATE_PLANS = 10,//room price  
	COL_LAST_NAME	= 11,
	COL_FIRST_NAME	= 12,
	COL_GENDER		= 13,
	COL_NATION		= 14,
	COL_VISA_NO		= 15,
	COL_EXPIRE_DATE	= 16,
	COL_BIRTHDAY	= 17,
	COL_PASSPORT_NO	= 18,
	COL_EXPIRE_DATE_PA_ID	= 19,
	COL_ADULT         =20,
	COL_ADULT_Female  =21,
	COL_CHILD         =22,
	COL_CHILD_Female  =23,
	COL_RATE		= 24,
	COL_DEPOSIT=25,
	COL_DESCRIPTION	= 26,
	Create_By=27,
	Create_Date=28;
function BodyInit()
{
	//dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-4));
	BindingDataList();
	OnSearch();
}

function BindingDataList()
{
	var data = '';
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>";
	grdMST.SetComboFormat(COL_GENDER, data);

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>";
	grdMST.SetComboFormat(COL_NATION, data);
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.PK,a.RATE_CODE ||' - '||a.RATE_NAME FROM  CRM.THT_RATE_PLANS a WHERE a.DEL_IF=0")%>";
	grdMST.SetComboFormat(COL_RATE_PLANS, data);
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='RTYPE'")%>";
	grdMST.SetComboFormat(COL_ROOM_TYPE, data);
}

function OnSearch()
{
	dso_htfo00030.Call('SELECT');
}

function OnAddNew()
{
	grdMST.AddRow();
	grdMST.SetGridText(grdMST.rows-1, COL_CHILD,'0');
}

function OnRemoveRow()
{
	if (grdMST.row > 0)
	{
		if (grdMST.GetGridData(grdMST.row, 0) == '')
		{
			grdMST.RemoveRow();
		}
		else
		{
			if (confirm("Are you sure delete data?"))
			{
				grdMST.DeleteRow();
				dso_htfo00030.Call();
			}
		}
	}
}

function OnCheckIn()
{
	 if(grdMST.row != -1)
	 {
		 txtMasterPK.text=grdMST.GetGridData(grdMST.row,0);
		 if(grdMST.GetGridData(grdMST.row,1) == '-1')
		 {
			if (confirm("Are you sure checkin this guest name?"))
			{
				dso_htfo00030_checkin.Call();
			}
		 }
		 else
		 {
			alert("Please,check one row data to check in.");
		 }
	 }
	 else
	 {
		alert("Please,check one row data to check in.");
	 }
}
function OnSave()
{
	if(CheckValidate())
    {
       dso_htfo00030.Call(); 
    }
}
function CheckValidate()
{
    for(var i=1;i<grdMST.rows;i++)
          {
            if(grdMST.GetGridData(i,COL_ROOM_NO) == "")
             {
                alert("Please input room no at row "+ i);       
                return false;
             }
             if(grdMST.GetGridData(i,COL_RATE_PLANS) == "")
             {
                alert("Please input rate plans at row "+ i);
                return false;
             }
			 if(grdMST.GetGridData(i,COL_TO_DATE) == "")//departure=to_date
             {
                alert("Please input departure date at row "+ i);
                return false;
             }
            if(grdMST.GetGridData(i,COL_LAST_NAME) == "")
             {
                alert("Please input last name at row "+ i);
                return false;
             }
			if(grdMST.GetGridData(i,COL_FIRST_NAME) == "")
             {
                alert("Please input first name at row "+ i);
                return false;
             }
			 
            if(grdMST.GetGridData(i,COL_ADULT) == "" && grdMST.GetGridData(i,COL_ADULT_Female) == "")
             {
                alert("Please, input adult(Male) or adult(Female) at row "+ i);
                return false;
             }
          }
          return true;
}
function OnGetRoom()
{
	if (grdMST.col == COL_ROOM_NO)
	{
		var path = System.RootURL + "/form/ht/bk/htbk00010_room_popup.aspx?";
        var object = System.OpenModal( path ,1300 , 900 ,  'resizable:yes;status:yes');    
        if ( object != null )
		{		
			grdMST.SetGridText(grdMST.row, COL_THT_ROOM_PK, object[0]);
			grdMST.SetGridText(grdMST.row, COL_ROOM_NO,		object[1]);
			grdMST.SetGridText(grdMST.row, COL_ROOM_TYPE,	object[2]);
		}	
	}
	if (grdMST.col == COL_DEPOSIT && grdMST.GetGridData(grdMST.row, COL_RATE) != "")
	{
		var guest_name = grdMST.GetGridData(grdMST.row, COL_LAST_NAME)+" "+grdMST.GetGridData(grdMST.row, COL_FIRST_NAME);    
	
		var path = System.RootURL + '/form/ht/fo/htfo00180_popup_deposit.aspx?p_room_allocate_pk='+ grdMST.GetGridData(grdMST.row, COL_PK)+"&p_guest_name="+guest_name+"&p_room_no="+grdMST.GetGridData(grdMST.row, COL_ROOM_NO);
		var object = System.OpenModal( path ,800 , 300 ,  'resizable:yes;status:yes',window);
		OnSearch();
	}
}

function OnDataReceive(obj)
{
	if(obj.id=='dso_htfo00030')
	{
		 txtCount.text=grdMST.rows-1 + " item(s).";  dso_htfo00030_checkin
	}
	if(obj.id=='dso_htfo00030_checkin')
	{
	
		 dso_htfo00030.Call("SELECT");
	}
}
function OnAddNew2()
{
	var path = System.RootURL + "/form/ht/fo/htfo00010_allocate_popup.aspx?";
			        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
		            if ( object != null )
		            {
						 for( var i=0; i < object.length; i++)	  
							{	
								arrTemp = object[i];
								grdMST.AddRow(); 
								grdMST.SetGridText(grdMST.rows-1, COL_LAST_NAME, arrTemp[2]);//COL_LAST_NAME
								grdMST.SetGridText(grdMST.rows-1, COL_FIRST_NAME, arrTemp[3]);//COL_LAST_NAME
								grdMST.SetGridText(grdMST.rows-1, COL_GENDER, arrTemp[4]);
								grdMST.SetGridText(grdMST.rows-1, COL_NATION, arrTemp[5]);
								grdMST.SetGridText(grdMST.rows-1, COL_VISA_NO,arrTemp[6]);
								grdMST.SetGridText(grdMST.rows-1, COL_EXPIRE_DATE,arrTemp[8]);//expire visa
								grdMST.SetGridText(grdMST.rows-1, COL_BIRTHDAY, arrTemp[10]);

								grdMST.SetGridText(grdMST.rows-1, COL_PASSPORT_NO, arrTemp[11]);
								grdMST.SetGridText(grdMST.rows-1, COL_EXPIRE_DATE_PA_ID, arrTemp[13]);
								grdMST.SetGridText(grdMST.rows-1, COL_ADULT, arrTemp[14]);
								grdMST.SetGridText(grdMST.rows-1, COL_CHILD,arrTemp[15]);
								grdMST.SetGridText(grdMST.rows-1, COL_DESCRIPTION,arrTemp[16]);

							}
					}
}
function OnReport()
{
	if((grdMST.row) != -1)
	{
		var url = '/reports/ht/fo/htfo00030.aspx?p_pk='+ grdMST.GetGridData(grdMST.row,COL_PK);
	     System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	else
	{
		alert("Please,click one guest to print.");
	}
}
function OnDeposit()
{
	if(grdMST.row !='-1' && grdMST.GetGridData(grdMST.row, COL_RATE) != "")
    {
		var guest_name = grdMST.GetGridData(grdMST.row, COL_LAST_NAME)+" "+grdMST.GetGridData(grdMST.row, COL_FIRST_NAME);
		var path = System.RootURL + '/form/ht/fo/htfo00180_popup_deposit.aspx?p_room_allocate_pk='+ grdMST.GetGridData(grdMST.row, COL_PK)+"&p_guest_name="+guest_name+"&p_room_no="+grdMST.GetGridData(grdMST.row, COL_ROOM_NO);
		var object = System.OpenModal( path ,800 , 300 ,  'resizable:yes;status:yes',window);
		OnSearch();
	}
	else
	{
		alert("Please,choose guest name to input advance(you must save finish then input advance).");
	}
}
</script>
<body>
<gw:data id="dso_htfo00030_checkin" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="process" procedure="CRM.sp_upd_htfo00030_walk_checkin" > 
			<input>
				 <input bind="txtMasterPK" /> 
			</input> 
			<output> 
				<output bind="txtTEMP"/>
			</output>
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_htfo00030" onreceive="OnDataReceive(this)">
	<xml> 
		<dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28" function="CRM.SP_SEL_HTFO00030" procedure="CRM.SP_UPD_HTFO00030">
			<input bind="grdMST">
				<input bind="txtGuestNameS" />
			</input> 
			<output bind="grdMST" /> 
		</dso> 
	</xml> 
</gw:data>
<table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
	<tr style="width: 100%; height: 1%">
		<td style="width: 100%; background: white" valign="top" >			
			<table style="width: 100%" border="0">
				<tr >
					<td style="width: 15%" align="right" nowrap >Room/Last/First Name</td>
					<td style="width: 20%" >
						<gw:textbox id="txtGuestNameS" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
					<td style="width: 19%" align="right" ></td>
					<td style="width: 9%" >Total :</td>
					<td style="width: 15%" align="center">
						 <gw:label id="txtCount" />
					</td>
					<td style="width: 12%" >
					</td>
					<td style="width: 1%" >
						<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
					</td>
					<td style="width: 7%">
							<gw:icon id="btnDeposit" img="2" text="Deposit" styles='width:100%' onclick="OnDeposit()" />
						</td>
					<td style="width: 3%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew()" />
                    </td>
					<td style="width: 10%" >
						<gw:icon id="btnAdd2" text="Copy Guest info" onclick="OnAddNew2()" />
					</td>
					 <td style="width: 3%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                    </td>
                    <td style="width: 3%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnRemoveRow()" />
                    </td>
					<td style="width: 1%" >
						
					</td>
					
					<td style="width: 6%" >
						<gw:icon id="btncheckin" text="Checkin" onclick="OnCheckIn()" />
					</td>
					<td width="3%" align="right">
                            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                    </td>
					
				</tr>
			</table>
		</td>
	</tr>
	<tr style="width: 100%; height: 30%; background: white">
		<td style="width: 100%">
			<gw:grid id="grdMST" 
			header="_PK|Select|_Bulding No|_Area No|_Floor No|*Room|_tht_room_pk|*Room Type|_From_Date|*Departure Date|*Rate Plan|*Last Name|*First  Name|Gender|Nation|Visa No|Expire Date|Birthday|PA/ID|Expire Date|Adult-M|Adult-F|Child-M|Child-F|Rate|Advance|Description|Create By|Create Date" 
			format="0|3|0|0|0|0|0|0|4|4|0|0|0|0|0|0|4|4|0|4|0|0|0|0|0|-0|0|0|0" 
			aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0|0|0|3|3|3|3|3|3|0|0|0" 
			defaults="||||||||||||||||||||||||||||" 
			editcol="0|0|0|0|0|0|0|1|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|1|0|0" 
			widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1000|0|0|0|0|0|0|0|0|0|0|0|0" 
			styles="width:100%;height:100%"
			autosize='T'
			debug='false'
			acceptnulldate="T"
			oncelldblclick="OnGetRoom()" />
		</td>
	</tr>
</table>
<gw:textbox id="txtMasterPK" style="display: none" />
<gw:textbox id="txtTEMP" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
