<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
function BodyInit()
{ 
	System.Translate(document);
		
	lblCompany.text    = "<%=Request("Company")%>";
    lblSalMonth.text  = "<%=Request("SalMon")%>";
	lblCostCenter.text    = "<%=Request("CostCenterPK")%>";
	lblSearchCG.text    = "<%=Request("CostGroupPK")%>";
	lblSearchCT.text    = "<%=Request("CostTypePK")%>";
    
	
	datSearchSlipInfoDetail.Call("SELECT");
	
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function OnDataReceive(obj)
{
	if(obj.id == "datSearchSlipInfoDetail")
	{
	    auto_resize_column(grdList,0,grdList.cols-1,0);
		lblEmpCount.text = grdList.rows-1 + " Employee(s).";
		var tt=0
		for(var i=1;i<grdList.rows;i++)
		    tt+=Number(grdList.GetGridData(i,18));
		lblTotalTr.text=tt;    
		
	}
	else
	{
	    return;
	}
}

function OnDataError(obj)
{
	AlertDBError(obj.errmsg)
	return;
}

function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
}


</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Popup Detail</title>
</head>
<body>
<gw:data id="datSearchSlipInfoDetail" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
        <xml>
            <dso type="grid" function="ACNT.SP_SEL_PR_LIST_DETAIL">
                <input bind="grdList">
                    <input bind="lblCompany"/>
                    <input bind="lblSalMonth"/>
                    <input bind="lblCostCenter"/>
                    <input bind="lblSearchCG"/>
                    <input bind="lblSearchCT" />
                </input>
                <output bind="grdList"/>
            </dso>
        </xml>
</gw:data>



<table width="100%" height="100%">
	<tr width="100%">
	<td width="100%">
		<fieldset style="padding: 5">
			<table>
				<tr width="100%">
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
				</tr>
				<tr width="100%">
					<td colspan=20 align=center><gw:label id="lblEmpCount" text='0 Employee(s)' styles="color:red;width:100%;font-weight: bold;font-size:14"/></td>
					<td colspan=20 align=right><gw:label id="lblTotalTRtxt" text="Total Amount :" styles="color:black;width:100%;font-weight: bold;font-size:14" /></td>
				    <td colspan=60 align=left><gw:label id="lblTotalTr" styles="color:red;width:100%;font-weight: bold;font-size:18;align:left" /></td>
					
				</tr>
				
			</table>
		</fieldset>
	</tr>	
	<tr width="100%" height="100%">
		<td width="100%">
			<table width="100%" height = "100%" cellpadding="0" cellspacing="0"  border = "">
					<tr>
						<td>
							<gw:grid id="grdList" 
								header="Organization|Emp ID|Emp Name|S1|S2|S3|S4|S5|S6|S7|S8|S9|S10|S11|S12|S13|S14|S15|Amount"
                                format="0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0"
								aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								defaults="||||||||||||||||||"
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								widths="2500|1000|2500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
                                styles="width:100%; height:100%" sorting="T" />
						</td>
					</tr>
				</table>
		</td>
	</tr>
</table>
<gw:label id="lblCompany" style="display: none" />
<gw:label id="lblSalMonth" style="display: none" />
<gw:label id="lblCostCenter" style="display: none" />
<gw:label id="lblSearchCG" style="display: none" />
<gw:label id="lblSearchCT" style="display: none" />
<gw:label id="lblSalAcc" style="display: none" />
</body>
</html>
