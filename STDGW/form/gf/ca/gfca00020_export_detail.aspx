<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>genuwin</title>
</head>
<%  		ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">

function BodyInit()
{
    txt_PK.text      = "<%=Request.querystring("decl_pk")%>";
	dso_sel_exp_dcl_dtl.Call("SELECT");
}


function OnSearch()
{
    dso_sel_exp_dcl.Call("SELECT");
}

function GetCustomer(ind)
{
    var fpath   = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx";
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
	var code_data= new Array();
	var ctrl = grdDetail.GetGridControl();
	var strVal ="|";
	for(i=1; i<ctrl.rows;i++)
	{
	
		if(grdDetail.GetGridData(i,0)=="-1")
		{
			strVal = strVal + grdDetail.GetGridData(i,2)+ "|";
		}
	}
	code_data[0]= txt_PK.text;
	code_data[1]= strVal;
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
			<td><gw:icon id="btnAll"  img="in" text="All"   onclick="OnSelectAll()"     styles='width:5%' /></td>
		</tr>
		<tr>
			<td colspan="2">
				<gw:grid id="grdDetail" header="CHK|_MST_PK|_PK|_TCO_ITEM_PK|ITEM CODE|ITEM NAME|UNIT|QTY|PRICE|EXT PRICE|NET AMT|_COMPANY"
					format	="3|0|0|0|0|0|0|1|1|1|1|1" 
					aligns	="0|0|0|0|0|0|0|0|0|0|0|0" 
					defaults="|||||||||||"
					editcol	="0|0|0|0|0|0|0|0|0|0|0|0" 
					widths	="800|0|0|0|1500|3200|800|1200|1800|1800|1800|1800"
					styles	="width:100%; height:380" 
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
