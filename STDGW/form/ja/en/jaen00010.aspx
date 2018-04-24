<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Entrance Register</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>

var flag_insert = false;
var flag_sel	= false;
var gBarcode	= '';

var COLD_PK						= 0,
	COLD_NO						= 1,
	COLD_BAG_CARD				= 2,
	COLD_DES					= 3,
	COLD_GOLFER_NAME			= 4,
	COLD_TGM_ENTRANCE_PK		= 5,
	COLD_TGM_ENTRANCED_PHOTO_PK = 6;

function BodyInit()
{
	OnToggle();
	txtCarNoM.onfocus;
	btnCheckOut.SetEnable(false);
	txtCheckIn.SetReadOnly(true);
	txtCheckOut.SetReadOnly(true);
	OnNew(1);

	OnSearch(1);
}

function OnToggle()
{
	var left  = document.all("left");    
	var right = document.all("right");   
	var imgArrow = document.all("imgArrow");   

	if(imgArrow.status == "expand")
	{
		left.style.display="none";       
		imgArrow.status = "collapse";
		right.style.width="100%";
		imgArrow.src = "../../../system/images/next_orange.gif";
	}
	else
	{
		left.style.display="";
		imgArrow.status = "expand";
		right.style.width="75%";
		imgArrow.src = "../../../system/images/prev_orange.gif";
	}
}

function OnSearch(n)
{
	switch(n)
	{
		case 1:
			data_jaen0010_main_list.Call('SELECT');
		break;
		case 2:
			if (grdDataM.rows > 1)
			{
				flag_sel    = true;
				flag_insert = false;
				btnCheckOut.SetEnable(true);
				TGM_ENTRANCE_PK.text = grdDataM.GetGridData(grdDataM.row, 0);
				data_jaen0010_m.Call('SELECT');
			}
		break;
	}
}

function OnSave()
{
	if (txtCarNo.text == '')
	{
		alert('Please, input Car No.');
		return;
	}

	flag_sel    = false;
	flag_insert = true;
		
	//txtPHOTO_PK.SetDataText(imgFile.oid);
	
	data_jaen0010_m.Call();
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'data_jaen0010_m':	
			//imgFile.SetDataText(txtPHOTO_PK.text);

			if (flag_sel == true)
			{
				data_jaen0010_d.Call('SELECT');
			}
			else
			{
				if (TGM_ENTRANCE_PK.text == '')
				{
					data_jaen0010_m.Call('SELECT');
				}
				else
				{
					flag_sel = true;
					//flag_insert = false;
					flag_insert = true;
					for(row = 1; row < grdDataD.rows; row++)
					{
						if (grdDataD.GetGridData(row, COLD_TGM_ENTRANCE_PK) == '')
						{
							grdDataD.SetGridText(row, COLD_TGM_ENTRANCE_PK, TGM_ENTRANCE_PK.text);	
						}
					}
					data_jaen0010_d.Call();
				}
			}
		break;
		case 'data_jaen0010_d':
			if (txtCheckOut.text != '')
			{
				btnCheckOut.SetEnable(false);
			}
			
			if (flag_insert == true)
			{
				data_jaen0010_main_list.Call('SELECT');
			}
		break;
		case 'dsoGetCardNo':
		if(txtCardNo.text == "" || txtCardNo.text == null){
		    //alert("No found this card in the system.");
		    lblStatus.text = "No found this card in the system.";
		}
		else{
		    if (OnCheckExist(txtCardNo.text) == false)
		    {
			    OnNew(2);
			    lblStatus.text = "Card "+ txtCardNo.text + " is OK.";
		    }	
		    else{
		        lblStatus.text = "Card "+ txtCardNo.text + " already scan.";
		    }
		}
	}
}

function OnNew(n)
{
	switch(n)
	{
		case 1:
			imgFile.SetDataText('');
			btnCheckOut.SetEnable(false);
			data_jaen0010_m.StatusInsert();
			flag_insert = true;
			grdDataD.ClearData();
		break;
		case 2:			
			//imgFile.SetDataText('');
			//imgFile.ChangeImage();	
			grdDataD.AddRow();
			grdDataD.SetGridText(grdDataD.rows-1, COLD_TGM_ENTRANCE_PK, TGM_ENTRANCE_PK.text);
			grdDataD.SetGridText(grdDataD.rows-1, COLD_BAG_CARD, txtCardNo.text);
			grdDataD.SetGridText(grdDataD.rows-1, COLD_NO, grdDataD.rows-1);
			//grdDataD.SetGridText(grdDataD.rows-1, COLD_TGM_ENTRANCED_PHOTO_PK, imgFile.oid);
			//imgFile.SetDataText(imgFile.oid);
		break;
	}
}

function OnDelete(n)
{
	switch(n)
	{
		case 1:
			if (TGM_ENTRANCE_PK.text != '')
			{
				if (confirm("Are your sure delete data ?"))
				{	
					if (grdDataD.rows > 1)
					{
						alert('Please, delete data deatails.');
						return;
					}
					else
					{
						flag_sel	= true;
						flag_insert = true;
						data_jaen0010_m.StatusDelete();
						data_jaen0010_m.Call();
					}
				}
			}			
		break;
		case 2:
			if (grdDataD.rows > 1)
			{
				if (grdDataD.GetGridData(grdDataD.row, COLD_PK) == '')
				{
					grdDataD.RemoveRow();
				}
				else
				{
					grdDataD.DeleteRow();
				}
			}
		break;
	}
}

function OnUnDelete()
{
	if (grdDataD.rows > 1 )
	{
		grdDataD.UnDeleteRow();
	}
}

function OnCheckOut()
{
	flag_sel    = false;
	flag_insert = true;
	txtCheckOut.text = 'Y';
	data_jaen0010_m.Call();
}



function ClickImage()
{
	if (grdDataD.row > 0)
	{
		if (grdDataD.GetGridData(grdDataD.row, COLD_TGM_ENTRANCED_PHOTO_PK) == '' ||
			grdDataD.GetGridData(grdDataD.row, COLD_TGM_ENTRANCED_PHOTO_PK) == '0')
		{	
			if (grdDataD.col == COLD_NO)
			{	
				imgFile.ChangeImage();	
				grdDataD.SetGridText(grdDataD.row, COLD_TGM_ENTRANCED_PHOTO_PK, imgFile.oid);
				imgFile.SetDataText(imgFile.oid);
			}
		}
	}
}

function OnClick()
{
	imgFile.SetDataText(grdDataD.GetGridData(grdDataD.row, COLD_TGM_ENTRANCED_PHOTO_PK));
}

function CheckNum()
{	
	if (isNaN(String.fromCharCode(event.keyCode)))
        event.keyCode = "";
}

function OnShowScan()
{
    if( img2.status == "up")
    {
         idScan.style.display =''
         img2.status="down"
         img2.src="../../../system/images/down.gif"
        
    }else
    {
        idScan.style.display ='none'
        img2.status="up"
        img2.src="../../../system/images/up.gif"        
    }
}

function OnCheckExist(p_card_no)
{
	for (row = 1; row < grdDataD.rows; row++ )
	{
	    var card_no = grdDataD.GetGridData(row, COLD_BAG_CARD);
	    
		if ( card_no.substr(1,3)== p_card_no.substr(1,3))
		{
			return true;
		}
	}
	return false;
}
function GetCardNo(p_card_id)
{
    txtCardID.text = p_card_id;
    dsoGetCardNo.Call();
}
</script>
<SCRIPT LANGUAGE=javascript FOR=Scanner EVENT="BCReceiveEvent">
if(gBarcode != sBarcode)
{
	if (sBarcode.length  <= 38)
	{		
		txtBarcode.text ="";
		gBarcode = sBarcode;
		txtBarcode.text = Trim(gBarcode);
        
        GetCardNo(txtBarcode.text);
        
	}
}
</SCRIPT> 
<body>
	<gw:data id="data_jaen0010_main_list" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm" function="CRM.SP_SEL_JAEN00100_MAIN_LIST" > 
                <input> 
                    <inout bind="dtFromDate" />
					<inout bind="dtToDate" />
					<inout bind="txtCarNoM" />
					<inout bind="txtGolf" />
                </input> 
                <output bind="grdDataM" /> 
            </dso> 
        </xml> 
    </gw:data>

	<gw:data id="data_jaen0010_m" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,2,3,4,5,6" function="CRM.SP_SEL_JAEN00100_M" procedure="CRM.SP_UPD_JAEN00100_M">
                <inout>
                    <inout bind="TGM_ENTRANCE_PK" />
                    <inout bind="txtCheckIn" />
                    <inout bind="txtCheckOut" />     
                    <inout bind="txtCarNo" />
					<inout bind="txtPhone" />
					<inout bind="txtName" />
				</inout>
			</dso>
		</xml>
	</gw:data>

	<gw:data id="data_jaen0010_d" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm"  parameter="0,2,3,4,5,6" function="CRM.SP_SEL_JAEN00100_D" procedure="CRM.SP_UPD_JAEN00100_D">
                <input> 
                    <inout bind="TGM_ENTRANCE_PK" />
                </input> 
                <output bind="grdDataD" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dsoGetCardNo" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="process"  procedure="CRM.SP_PRO_JAEN00100">
                <input> 
                    <input bind="txtCardID" />
                </input> 
                <output>
                    <output bind="txtCardNo" /> 
                </output>
            </dso> 
        </xml> 
    </gw:data>
    
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 30%">
                <table style="width: 100%; height: 100%">
					<tr style="height: 1%">
                        <td style="width: 20%" align="right">
                            Date</td>
                        <td style="width: 79%; white-space: nowrap">
                            <gw:datebox id="dtFromDate" lang="1" />
                            ~<gw:datebox id="dtToDate"  lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch(1)" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 20%" align="right" nowrap>
                            Car No/Driver Phone</td>
                        <td style="width: 80%; white-space: nowrap" colspan="2">
                            <gw:textbox id="txtCarNoM" styles="width:100%"  onenterkey="OnSearch(1)"/>
                        </td>
                    </tr>					
                    <tr style="height: 1%">
                        <td style="width: 20%" align="right" nowrap>
                            Golf Bag/Golf Name</td>
                        <td style="width: 80%; white-space: nowrap" colspan="2">
                            <gw:textbox id="txtGolf" styles="width:100%"  onenterkey="OnSearch(1)"/>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdDataM' header='_PK|In Time|Out Time|Car No.' format='0|0|0|0'
                                aligns='0|0|0|0' defaults='|||' editcol='0|0|0|0' widths='1000|1000|2000|1000'
                                sorting='T' styles='width:100%; height:100%' oncellclick="OnSearch(2)" autosize='T' />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 70%" >
                <table style="width: 100%; height: 100%" border="0">
					<tr style="height: 1%; width: 100%">
						<td style="width: 100%" colspan='4'>
							<table style="width: 100%; height: 100%" border="0">
								<tr style="height: 1%; width: 100%">									
									<td style="width: 88%" >
									</td>
									<td style="width: 3%" >
										<gw:imgbtn id="btnNew" img="new" alt="New" onclick="OnNew(1)" />
									</td>
									<td style="width: 3%" >
										<gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete(1)" />
									</td>
									<td style="width: 3%" >
										<gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
									</td>
									<td style="width: 3%">
										<gw:icon id="btnCheckOut" img="3" text="Check Out" styles='width:100%' onclick="OnCheckOut()" />
									</td>		
								</tr>
							</table>
						</td>
					</tr>
					<tr style="height: 1%; width: 100%">
						<td style="width: 20%" >&#160;Check In</td>
						<td style="width: 20%" >
							 <gw:textbox id="txtCheckIn" styles="width:100%" />
						</td>
						<td style="width: 20%" >&#160;Check Out</td>
						<td style="width: 30%"  >
							<gw:textbox id="txtCheckOut" styles="width:100%" />
						</td>
					</tr>
					<tr style="height: 1%; width: 100%">
						<td style="width: 20%" >&#160;Car No.</td>
						<td style="width: 20%" >
							 <gw:textbox id="txtCarNo" styles="width:100%" />
						</td>
						<td style="width: 20%" >&#160;Driver Phone</td>
						<td style="width: 30%" >
							<gw:textbox id="txtPhone" styles="width:100%" onkeypress='CheckNum()' />
						</td>
					</tr>
					<tr style="height: 1%; width: 100%">
						<td style="width: 20%" >&#160;Driver Name</td>
						<td style="width: 80%" colspan='3'>
							<gw:textbox id="txtName" styles="width:100%" />
						</td>
					</tr>
					<tr style="height: 5%; width: 100%">
						<td style="width: 100%" colspan='4'>
							<table style="width: 100%; height: 100%" border="0">
								<tr style="height: 1%; width: 100%">									
									<td with="1%">
										<img status="up" id="img2" src="../../../system/images/up.gif" style="cursor: hand"  alt="Show Scan Card No Component" onclick="OnShowScan()" />
									</td>
									<td style="width: 90%" align="center" >
									    <gw:label id="lblStatus" styles="background-color:Gray; color:Red; font-size:large;" />
									</td>
									<td style="width: 3%" >
										<gw:imgbtn id="btnNewD" img="new" alt="New" onclick="OnNew(2)" />
									</td>
									<td style="width: 3%" >
										<gw:imgbtn id="btnDeleteD" img="delete" alt="Delete" onclick="OnDelete(2)" />
									</td>
									<td style="width: 3%" >
										<gw:imgbtn id="btnUDeleteD" img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
									</td>
								</tr>
							</table>
						</td>
					</tr>	
					<tr  style="height: 96%; width: 100%">
						<td style="width: 100%" colspan='4' >
							<gw:grid id='grdDataD' 
							header='_PK|No.|Golf Bag Card|Golfer Name|Description|_tgm_entrance_pk|_tgm_entranced_photo_pk'
							format='0|0|0|0|0|0|0' 
							aligns='0|0|0|0|0|0|0' 
							defaults='||||||' 
							editcol='0|0|1|1|1|0|0'
							widths='0|1000|2000|1500|0|0|0' 
							sorting='T' 
							autosize='true'
							styles='width:100%; height:100%'
							debug="false"/>	
						</td>
						<td style="width: 20%; display:none" >
							<gw:image id="imgFile"  oid="0" table_name="TGM_ENTRANCED_PHOTO"  view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:100%;height:100%"  />
						</td>
					</tr>
					<tr id="idScan" style="display:none"  >                               
						<td colspan="5">
							<OBJECT ID="Scanner"
							CLASSID="CLSID:0C6B7553-403E-4630-B9AD-6EBD85A8B50B"
							CODEBASE="=../../../system/activex/ScannerControl.CAB#version=1,0,0,0">
							</OBJECT>
						</td>
				   </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtCardNo" text="" styles="display:none" />
    <gw:textbox id="txtCardID" text="" styles="display:none" />
	<gw:textbox id="txtPHOTO_PK" text="" styles="display:none" />
	<gw:textbox id="TGM_ENTRANCED_PK" text="" styles="display:none" />	
	<gw:textbox id="TGM_ENTRANCE_PK" styles="display:none" />
	<gw:textbox id="txtBarcode" styles="display:none" />
	<img status="expand" id="imgArrow" src="../../../system/images/next_orange.gif" style="cursor: hand;
    position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</body>
</html>
