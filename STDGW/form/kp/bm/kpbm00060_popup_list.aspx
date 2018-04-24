<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml">

<script>
var v_language  = "<%=Session("SESSION_LANG")%>";
var prj_pk		= "<%=Request.querystring("p_pk")%>";
var prj_code	= "<%=Request.querystring("p_code")%>";
var prj_name	= "<%=Request.querystring("p_name")%>";
var budget		= "<%=Request.querystring("p_budget")%>";

function BodyInit()
{
	System.Translate(document);

	if (prj_pk != '')
	{
		txtProjectPK.text	= prj_pk;
		txtBudgetNo.text	= budget;
		OnSearch();
	}
}

function OnSelect()
{
	var arr_data = new Array();
   
	if(grdData.rows > 1)
	{   
		for(var i=1;i<grdData.rows;i++)
		{
			if (grdData.GetGridData(i, 0) == -1)
			{			
				var arrTemp=new Array();

				for(var j=0;j<grdData.cols;j++)
				{
					arrTemp[arrTemp.length]= grdData.GetGridData(i,j);
				}

				arr_data[arr_data.length]= arrTemp;

			}
		}
	
		if ( arr_data !=null )
		{
			window.returnValue =  arr_data;
			window.close();
		}
		else
		{
			alert("You have not selected data yet.");
		}
	}
}

function OnPopUp()
{
	var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
	var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
	if(aValue != null)
	{
		txtProjectPK.text = aValue[0];
		txtProject_Cd.text = aValue[1];
		txtProject_Nm.text = aValue[2];
		OnSearch();
	}
}

function OnSearch()
{
	dso_grdData.Call('SELECT');
}

function OnReceiveData(obj)
{
	switch (obj.id)
	{
		case 'dso_grdData':
			lblRecord.text = grdData.rows-1 + ' record(s)';
		break;	
	}
}

function OnSelectAll()
{
	for (row = 1; row<grdData.rows; row++ )
	{
		grdData.SetGridText(row, 0, -1);
	}
}

function OnUnSelectAll()
{
	for (row = 1; row<grdData.rows; row++ )
	{
		grdData.SetGridText(row, 0, 0);
	}
}
</script>

<body>
<gw:data id="dso_grdData" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="1" type="grid" function="EC111.SP_SEL_KPBM00060_POPUP_LIST" > 
            <input bind="grdData">
                <input bind="txtProjectPK" />
				<input bind="txtBudgetNo" />
            </input> 
            <output bind="grdData" />
        </dso> 
    </xml> 
</gw:data>
    <!------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%;height: 5%">
			<td width="5%" align="center">
				<a title="Select All." href="#" style="text-decoration:" onClick="OnSelectAll()">Check</a></td>
			</td>
			<td>/</td>
			<td width="1%" align="center">
				<a title="UnSelect All." href="#" style="text-decoration:" onClick="OnUnSelectAll()">UnCheck</a></td>
			</td>

			<td width="5%" align="center">
				<a title="Click here to show Project" href="#" style="text-decoration: none; display:none" onClick="OnPopUp()">Project</a></td>
			</td>
			<td width="20%">
				<gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%; display:none' />
			</td>
			<td width="50%">
				<gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%; display:none' />
			</td>
			<td width="">
				<gw:textbox id="txtProjectPK" styles='width:100%;display:none; display:none' />
			</td>
			<td>
				<gw:imgbtn id="btnReset" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProjectPK.text='';" styles="display:none" />
			</td>
			<td width="20%" align="center">
				<gw:label id="lblRecord" text="0 record(s)"/>
			</td>
			<td>
				<gw:icon id="btnReset" text="Select" onclick="OnSelect()" />
			</td>
		</tr>
		<tr style="width: 100%;height: 95%">
			<td colspan="10" width="100%">
				<gw:grid id="grdData" header="Select|_Level_PK|Level Name|Type|Qty|Unit Price|AMT|Exec Y/N"
				format="3|0|0|0|2|2|2|0"
				aligns="1|0|0|0|1|1|1|0" 
				defaults="|||||||"
				editcol="0|0|0|0|0|0|0|0"
				widths="0|0|2000|2000|0|0|0|0"
				styles="width:100%; height:100%" 
				sorting="T" 
				debug="false"/>
			</td>
		</tr>
    </table>
</body>

<gw:textbox id="txtBudgetNo" styles='width:100%;display:none' />
</html>
