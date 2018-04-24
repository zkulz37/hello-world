<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Student</title>
     <%  ESysLib.SetUser("crm")%>

<script>

var gBarcode = "";

var COL_NEW_PK		= 0,
	COL_NEW_CARD_NO	= 1,
	COL_NEW_STATUS	= 2,
	COL_NEW_CARD_ID	= 3,
	COL_NEW_REMARK	= 4;

var flag_select = false;
var flag_update = false;
var flag_repair = false;
var flag_card	= false;

function BodyInit()
{
	radTab.value = 1;
	var data="";
	data = "#10;AVAILABLE|#20;USING|#30;BROKEN|#40;NOT AVAILABLE";
	grdCardNo.SetComboFormat(COL_NEW_STATUS,data);

	
	data = "#10;AVAILABLE|#20;USING|#30;BROKEN|#40;NOT AVAILABLE";
	grdCardNoNew.SetComboFormat(COL_NEW_STATUS,data);

	data="DATA|10|AVAILABLE|20|USING|30|BROKEN|40|NOT AVAILABLE|ALL|Select All";
	lstSatus.SetDataText(data);//set to combobox
	lstSatus.value = '';

	grdCardNoNew.GetGridControl().ColEditMask(1)=">L000";

	OnSearch();
}

function OnSearch()
{
	flag_select = true;	
	lblStatus.text = '';
	//txtCardNo.text = '';
	dso_jabs0050.Call("SELECT");
}

function OnRepair()
{
	flag_repair = true;
	idBtnRepair.SetEnable(false);
}

function OnReset()
{
	flag_repair = false;
	idBtnRepair.SetEnable(true);
	txtCardNo.text = '';
	OnSearch();
}

function OnDelete()
{
	if (grdCardNo.row > 0)
	{
		if (confirm('Are you sure delete data ?'))
		{	
			lblStatus.text = '';
			grdCardNo.DeleteRow();
			flag_update = true;
			dso_jabs0050.Call();
		}
	}
}

function UnDelete()
{
	grdCardNo.UnDeleteRow();
}

function OnSave(n)
{
	switch (n)
	{
		case 1:
		    lblStatus.text = '';
			flag_update = true;
			dso_jabs0050.Call();
		break;
		case 2:
			if(CheckDataIsValid() == true)
			{
				dso_jabs0050_new.Call();
			}
		break;
	}
}

function MandatoryColor()
{
	if (grdCardNoNew.rows > 1)
	{
		grdCardNoNew.SetCellBgColor( 1, COL_NEW_CARD_NO, grdCardNoNew.rows - 1, COL_NEW_CARD_NO, 0xCCFFFF);
		grdCardNoNew.SetGridText(grdCardNoNew.rows - 1, COL_NEW_CARD_ID, txtBarcode.text);
		grdCardNoNew.SetGridText(grdCardNoNew.rows - 1, COL_NEW_STATUS, '10');
		txtBarcode.text = '';
	}
}

function CheckDataIsValid() 
{
	for(var i=1;i<grdCardNoNew.rows;i++)
	{
		if(grdCardNoNew.GetGridData(i,1) == "")
		{
			alert("Please Input Card No");
			return false;
		}

		if(grdCardNoNew.GetGridData(i,2)=="")
		{
			alert("Please Input Status");
			return false;
		}

		if(grdCardNoNew.GetGridData(i,3)=="")
		{
			alert("Please Input Card ID");
			return false;
		}
	}
	return true;
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

function OnChangeChk()
{
	flag_select = true;
	txtCardNo.text = '';
	lblStatus.text = '';
	grdCardNoNew.ClearData();
	dso_jabs0050.Call('SELECT');
}

function OnDataReceive(obj)
{
	switch (obj.id)
	{		
		case 'dso_jabs0050':
			if (flag_update == true)
			{	
				flag_update = false;
				return;
			}

			if (flag_select == true)
			{
				flag_select = false;
				grdCardNoNew.ClearData();
			}
			else
			{
				if (grdCardNo.rows > 1)
				{
					txtCardNo.text = txtBarcode.text;
				}
				else
				{
					for (row = 1; row < grdCardNoNew.rows; row++ )
					{
						if (grdCardNoNew.GetGridData(row, COL_NEW_CARD_ID) == txtBarcode.text)
							return;
					}

					if (radTab.value == 1)
						lblStatus.text = '"[New Daily Card ID '+ txtBarcode.text + ']';
					else if (radTab.value == 2)
						lblStatus.text = '[New Bag Card ID '+ txtBarcode.text + ']';

					txtCardNo.text = '';
					OnNew(2);
				}
			}
		break;
		case 'dso_jabs0050_new':
			if (grdCardNoNew.rows > 1)
			{
				txtCardNo.text = grdCardNoNew.GetGridData(1, COL_NEW_CARD_NO);
				if (txtCardNo.text.substr(0,1) == 'D')
					radTab.value = 1;
				else
					radTab.value = 2;
				
				txtCardNo.text = '';
				lblStatus.text = '';
				grdCardNoNew.ClearData();
				txtBarcode.text = '';
				OnSearch();
			}
			else
			{
				if (flag_card == true)
				{
					dso_jabs0050.Call('Select');
//					flag_card = false;
//					OnNew(2);
				}
				else
				{
					grdCardNoNew.ClearData();
					txtCardNo.text = '';					
					lblStatus.text = '';
					dso_jabs0050.Call('Select');
				}
			}					
		break;
		case 'dso_jabs0050_repair':
			lblStatus.text = 'Update Card ID ' + txtCardNo.text + ' - ' + txtBarcode.text ;
			flag_select = true;			
			dso_jabs0050.Call("SELECT");			
		break;
	}
}

function OnNew(n)
{
	switch (n)
	{
		case 1:
			txtCardNo.text = '';
			txtCardNo.SetReadOnly(true);
			idBtnRepair.SetEnable(false);
			idBtnNew1.SetEnable(true);			
			lblStatus.text = '';
			dso_jabs0050.Call('SELECT');
		break;
		case 2:			
			grdCardNoNew.AddRow();
			MandatoryColor();
		break;
	}
}

function OnRemove()
{
	grdCardNoNew.RemoveRow();
}

function OnCheckExist(grd)
{
	for (row = 1; row < grd.rows; row++ )
	{
		if (grd.GetGridData(row, COL_NEW_CARD_ID) == txtBarcode.text)
		{
			if (grd == grdCardNo)
			{
				lblStatus.text = '[Already registry Card ID '+ txtBarcode.text +']';
			}

			if (grd == grdCardNoNew)
			{
				lblStatus.text = '';
			}
			
			return true;
		}
	}
	return false;
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
		gBarcode = '';

		flag_card = true;		
		lblStatus.text = '';
		
		if (flag_repair == false)
		{
			if (OnCheckExist(grdCardNo) == false && OnCheckExist(grdCardNoNew) == false)
			{
				OnNew(2);
			}
		}
		else
		{
			if (grdCardNo.rows == 1)
			{
				//lblStatus.text = 'Can not repair card. No data found.';
                txtCardNo.text = txtBarcode.text;
                OnSearch();
				return;
			}
			else if (grdCardNo.rows > 2)
			{
				//lblStatus.text = 'Please, input only Card No repair.';
                txtCardNo.text = txtBarcode.text;
                OnSearch();
				return;
			}
			else
			{
				txtCardNo.text = grdCardNo.GetGridData(1, COL_NEW_CARD_NO);

				if (txtCardNo.text == '')
				{
					lblStatus.text  = 'Please, input only Card No repair.';
					return;
				}

				dso_jabs0050_repair.Call();
			}
		}
	}
}
</SCRIPT> 
</head>
<body>
 <gw:data id="dso_jabs0050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4" function="CRM.SP_SEL_JABS0050" procedure="CRM.SP_UPD_JABS0050">  
                <input bind="grdCardNo"   >  
                    <input bind="txtCardNo" /> 
                    <input bind="lstSatus" />
					<input bind="radTab" />	
                </input> 
                <output bind="grdCardNo" /> 
            </dso> 
        </xml> 
    </gw:data> 	
	<gw:data id="dso_jabs0050_new" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4" function="CRM.SP_SEL_JABS0050_1" procedure="CRM.SP_UPD_JABS0050">  
                <input bind="grdCardNoNew"   >  
                    <input bind="txtBarcode" />
                </input> 
                <output bind="grdCardNoNew" /> 
            </dso> 
        </xml> 
    </gw:data>
	<gw:data id="dso_jabs0050_repair" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="crm.sp_pro_jabs0050_repair" > 
                <input>
                     <input bind="txtCardNo" />
					 <input bind="txtBarcode" />
                </input> 
                <output>
                    <output bind="txtCardNo" />
                </output>
            </dso> 
        </xml> 
    </gw:data>

    <table width="100%" style="height:100%">
        <tr style="height: 2%">			
			<td with="1%">
                <img status="up" id="img2" src="../../../system/images/up.gif" style="cursor: hand"  alt="Show Scan Card No Component" onclick="OnShowScan()" />
            </td>
            <td width="10%" align="right" nowrap>Card No</td>
            <td width="20%" >
                <gw:textbox id="txtCardNo" onenterkey="OnSearch()" />
            </td>
            <td width="10%" align="right">Status</td>
            <td width="20%"><gw:list id="lstSatus" onchange="OnSearch()"></gw:list></td>            
			<td width="24%" nowrap>
				<gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeChk()"> 
					<span value="1" id="Daily">Daily (D)</span> 
					<span value="2" id="Bag">Bag (B)</span> 
				</gw:radio>
			</td>
			<td width="10%" align="right" nowrap>
				<gw:label id="lblRecord" text="0 record(s)" />
			</td>
			<td width="5%" style="">
				<gw:icon id="idBtnRepair" img="2" text="Repair" alt="Repair Card" styles='width:100%' onclick="OnRepair()" />
			</td>
			<td width="5%" style="">
				<gw:icon id="idBtnReset" img="2" text="Reset" alt="Reset" styles='width:100%' onclick="OnReset()" />
			</td>
            <td with="1%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td with="1%" style="display:none">
                <gw:imgbtn id="idBtnNew2" img="New" alt="New" onclick="OnNew(2)" />
            </td>
            <td with="1%">
                <gw:imgbtn id="btnDelete" img="Delete" alt="Delete" onclick="OnDelete()" />
            </td>
            <td with="1%">
                <gw:imgbtn id="btnUnDelete" img="UDelete" alt="UnDelete" onclick="UnDelete()" />
            </td>
            <td with="1%">				
				<gw:imgbtn id="btnSave1" img="Save" alt="Save" onclick="OnSave(1)" />
            </td>
        </tr>
		<tr style="height: 1%">
            <td colspan="14">
				
			</td>
		</tr>
        <tr style="height: 48%">
            <td colspan="14">
                <gw:grid 
                    id="grdCardNo"
                    header="_PK|Card No|Status|Card ID|Caddy#" 
                    format="0|0|0|0|0"
                    aligns="0|3|0|0|0" 
                    defaults="||||" 
                    editcol="0|0|0|0|1" 
                    widths="0|1500|2000|1200|3000"
                     sorting='T' autosize="T"
                    styles="width:100%; height:100%" />
            </td>
        </tr>
		<tr style="width:100%;height: 1%">
            <td colspan="12" styles='width:98%;' align="left" nowrap>
				<gw:label id="lblStatus" text="Status..." />
			</td>
			<td styles='width:1%;' align="right" nowrap>
				<gw:imgbtn id="btnRemove" img="delete" alt="Remove" onclick="OnRemove()" />
			</td>
			<td styles='width:1%;' align="right" nowrap>
				<gw:imgbtn id="btnSave2" img="Save" alt="Save" onclick="OnSave(2)" />
			</td>
		</tr>
		 <tr style="height: 48%">
            <td colspan="14">
                <gw:grid 
                    id="grdCardNoNew"
                    header="_PK|Card No|Status|Card ID|Caddy#" 
                    format="0|0|0|0|0"
                    aligns="0|3|0|0|0" 
                    defaults="||||" 
                    editcol="0|1|1|1|1" 
                    widths="0|1500|2000|1200|3000"
                     sorting='T' autosize="T"
                    styles="width:100%; height:100%" 
					debug='false'/>
            </td>
        </tr>
		<tr id="idScan" style="display:none"  >                               
			<td colspan="14">
				<OBJECT ID="Scanner"
				CLASSID="CLSID:0C6B7553-403E-4630-B9AD-6EBD85A8B50B"
				CODEBASE="=../../../system/activex/ScannerControl.CAB#version=1,0,0,0">
				</OBJECT>
			</td>
	   </tr>
    </table>
</body>
<gw:textbox id="txtBarcode" text="" styles='width:100%;display:none' />
<gw:textbox id="txtCardID" text="" styles='width:100%;display:none' />
</html>
