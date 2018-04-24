<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>genuwin</title>
</head>
<%  		ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">

function BodyInit()
{
                        
    BindingDataList();
    lstCCY.SetDataText("");
    lstDECL_TYPE.SetDataText("");
    
    
}

function BindingDataList()
{
    var ls_comp         = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_ccy          = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>||Select All";
    var decl_type       = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEBD0020','','') FROM DUAL")%>||Select All"; //Declaration type 
    lstCOMPANY.SetDataText(ls_comp);
    lstCCY.SetDataText(ls_ccy);
    lstDECL_TYPE.SetDataText(decl_type);
    
}
function OnSearch()
{
    dso_sel_exp_dcl.Call("SELECT");
}

function GetCustomer(ind)
{
    var fpath   = System.RootURL + "/form/gf/co/ffbp00031.aspx";
    var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
    if ( object != null )  
    {
        if (object[0] != "")
        {
            if(ind == "1")
            {
                txtCUST_PK.text = object[0];
                txtCUST_ID.text = object[1];
                txtCUST_NM.text = object[2];                
            }
            
         }
     }        
}
	
function OnResetCust(ind)
{
    if(ind == "1")
    {
        txtCUST_PK.text = "";
        txtCUST_ID.text = "";
        txtCUST_NM.text = "";
    }
    
}

function OnDataReceive(pObject)
{
    if(pObject.id =="dso_sel_exp_dcl")
    {
        
    }
    
}

function OnRowMasterClick()
{
    var ctrl = grdMaster.GetGridControl();
    txt_PK.text = grdMaster.GetGridData(grdMaster.row,0);
    dso_sel_exp_dcl_dtl.Call("SELECT");
}

//--Detail
function OnSelectAll()
{
	if(txt_PK.text != "")
	{
		var ctrl = grdDetail.GetGridControl();
		for(i=1; i<ctrl.rows;i++)
		{
			grdDetail.SetGridData(i,0,"-1");
		}
	}
}

function OnClickOK()
{	
	var i, j;
	var code_data= new Array();
	for(i = 1; i < grdDetail.rows ; i++)
	{
		if(grdDetail.GetGridData(i, 0)=="-1")
		{
			var temp = new Array();
			temp[0] = grdMaster.GetGridData(grdMaster.row, 1); // decl. no
			temp[1] = grdMaster.GetGridData(grdMaster.row, 2); // decl. date
			for( j = 2 ; j < grdDetail.cols ; j++)
			{
				temp[j] = grdDetail.GetGridData(i, j);
			}
			code_data[code_data.length] = temp;
		}
	}
	window.returnValue = code_data;
	OnClickCancel();
}

function OnClickCancel()
{
	this.close();
}
function OnShowExp()
{

}

</script>

<body style="margin: 0; padding: 0;">
	<gw:data id="dso_sel_exp_dcl" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="ACNT.SP_SELECT_EXPORT_DCL">
                <input bind="grdMaster">
                    <input bind="lstCOMPANY"/>
                    <input bind="txtFROM_REG"/>
                    <input bind="txtTO_REG"/>
                    <input bind="txtFROM_EXPO"/>
                    <input bind="txtTO_EXPO"/>
                    <input bind="txtCUST_PK"/>
                    <input bind="txtCUST_ID"/>
                    <input bind="lstCCY"/>
                    <input bind="lstDECL_TYPE"/>
                    <input bind="txtDECL_NO"/>
                </input>
                <output bind="grdMaster"/>
            </dso> 
        </xml>
    </gw:data>
    
	<gw:data id="dso_sel_exp_dcl_dtl" onreceive="">
        <xml>
            <dso type="grid" parameter="2,11" function="ACNT.SP_SELECT_EXPORT_DCL_DTL" procedure="ACNT.SP_PRO_UPD_CRCA_TMP">
                <input bind="grdDetail">
                    <input bind="txt_PK"/>
                </input>
                <output bind="grdDetail"/>
            </dso> 
        </xml>
    </gw:data>
    
	<!------------------------------------------------------------------------------------------------------->
	<table width="100%" cellpadding="0" cellspacing="0" border="1">
		<tr>
			<td>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td width="10%"></td>
						<td width="30%"></td>
						<td width="10%"></td>
						<td width="15%"></td>
						<td width="10%"></td>
						<td width="10%"></td>
						<td width="5%"></td>
					</tr>
					<tr>
						<td align="right"><b>Company&nbsp;</b></td>
						<td><gw:list id="lstCOMPANY" styles='width:100%' /></td>
						<td align="right"><a title="Click here to show Customer" onclick="GetCustomer(1)" href="#tips"><b>Customer&nbsp;</b></a></td>
						<td colspan="3">
							<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="95%">
										<gw:textbox id="txtCUST_PK" styles='display:none'></gw:textbox>
										<gw:textbox id="txtCUST_ID" styles='width=29%;height:22'></gw:textbox>
										<gw:textbox id="txtCUST_NM" styles='width=70%;height:22'></gw:textbox>
									</td>
									<td width="4%"><gw:imgbtn id="ibtnResetCustomer" img="reset" alt="reset" onclick="OnResetCust(1)" /></td>
								</tr>
							</table>
						</td>
						<td align="right"><gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
					</tr>
					<tr>
						<td align="right"><b>Register Date&nbsp;</b></td>
						<td><gw:datebox id="txtFROM_REG" styles='width:50%' lang="<%=Session("Lang")%>" />&nbsp;&nbsp;~&nbsp;&nbsp;
							<gw:datebox id="txtTO_REG" styles='width:50%' lang="<%=Session("Lang")%>" />
						</td>
						<td align="right"><b>Trans. currency&nbsp;</b></td>
						<td><gw:list id="lstCCY" styles='width:100%' /></td>
						<td align="right"><b>Declaration type&nbsp;</b></td>
						<td colspan="2"><gw:list id="lstDECL_TYPE" styles='width:100%' /></td>
					</tr>
					<tr>
						<td align="right"><b>Export Date&nbsp;</b></td>
						<td><gw:datebox id="txtFROM_EXPO" styles='width:50%' lang="<%=Session("Lang")%>" />&nbsp;&nbsp;~&nbsp;&nbsp;
							<gw:datebox id="txtTO_EXPO" styles='width:50%' lang="<%=Session("Lang")%>" /></td>
						<td align="right"><b>Declaration No&nbsp;</b></td>
						<td><gw:textbox id="txtDECL_NO" styles='width:100%' /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="100%" cellpadding="0" cellspacing="0" border="1">
		<tr>
			<td colspan="7">
				<gw:grid id="grdMaster" header="_PK|DECL. NO|DECL. DATE|EXPORT DATE|_TCO_BUSPARTNER_PK|PARTNER ID|PARTNER NAME|CCY|EX. RATE|IMPORT UNTRY|EXPORT GATE|COMPANY|_CUST|_CUST|_CUST|_CUST|_CUST|_CUST|_CUST|_CUST|_CUST "
					format	="0|0|4|4|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0" 
					aligns	="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					defaults="||||||||||||||||||||"
					editcol	="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					widths	="0|1500|1500|1500|0|1700|3000|800|1200|1800|1200|1000"
					styles="width:100%; height:180" 
					sorting="F" 
					oncellclick="OnRowMasterClick()" />
			</td>
		</tr>
	</table>
	<table width="100%" cellpadding="0" cellspacing="0" border="1">
		<tr>
			<td><gw:icon id="btnAll"  img="in" text="All"   onclick="OnSelectAll()"     styles='width:5%' /></td>
		</tr>
		<tr>
			<td colspan="2">
				<gw:grid id="grdDetail" 
				    header="CHK|_MST_PK|_PK|_TCO_ITEM_PK|ITEM CODE|ITEM NAME|UNIT|QTY|PRICE|EXT PRICE|NET AMT|_COMPANY"
					format	="3|0|0|0|0|0|0|1|1|1|1|1" 
					aligns	="0|0|0|0|0|0|0|0|0|0|0|0" 
					defaults="|||||||||||"
					editcol	="0|0|0|0|0|0|0|0|0|0|0|0" 
					widths	="800|0|0|0|1500|3200|800|1200|1800|1800|1800|1800"
					styles	="width:100%; height:200" 
					sorting="F" />
			</td>
		</tr>
	</table>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="30%"></td>
			<td width="10%" align="center"><gw:icon id="btnOk"  img="in" text="OK"   onclick="OnClickOK()"     styles='width:100%' /></td>
			<td width="10%"></td>
			<td width="10%" align="center"><gw:icon id="btnCancel"  img="in" text="Cancel"   onclick="OnClickCancel()"     styles='width:100%' /></td>
			<td width="30%"></td>
		</tr>
	</table>
	
	<gw:textbox id="txt_PK" style="display: none" />
	<!---------------------------------------------------------------------------------------------------->
</body>
</html>
