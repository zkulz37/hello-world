<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("crm")%>
<head id="Head1" runat="server">
    <title></title>
</head>

<script>

function BodyInit()
{
	OnSearch(); 
}

function OnSearch()
{
	dso_jarc0020.Call('SELECT');
}

function OnDBClick()
{
	if (grdSearch.row > 0)
	{	
		var inv_pk	= grdSearch.GetGridData(grdSearch.row, 1);
		var path	= System.RootURL + "/form/ja/rc/jarc0020_popup.aspx?p_inv_pk=" + inv_pk;
        var object	= System.OpenModal( path ,700 , 550 ,  'resizable:yes;status:yes', this);
	}
}
</script>
<body>
<gw:data id="dso_jarc0020">
    <xml>                                                               
        <dso id="1" type="grid" user="prod" function="CRM.SP_SEL_JARC0020"> 
            <input> 
                <input bind="dtDate_f" />
				<input bind="dtDate_t" />
            </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>

<table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" valign='top'>
	<tr style="width: 100%; height: 1%">
		<td style="width: 10%" align='right'>Date&nbsp&nbsp&nbsp</td>
		<td style="width: 89%">
			<gw:datebox id="dtDate_f" type="date"  lang="1" />~
			<gw:datebox id="dtDate_t" type="date"  lang="1" />
		</td>
		<td style="width: 1%">
			<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
		</td>
	</tr>
	<tr style="width: 100%; height: 99%">
		<td colspan='3' style="width: 100%">
			<gw:grid id="grdSearch" 			 
			 header		="No|_PK|Status|Invoice No|Golfer Name|Card No|Location|Amount(USD)|Amount(VND)|VAT Rate|VAT AMT(USD)|VAT AMT(VND)|Total Pay(USD)|Total Pay(VND)"
			 format		="0|0|0|0|0|0|0|1|1|1|1|1|1|1"
			 aligns		="0|0|0|0|0|0|0|3|3|3|3|3|3|3"
			 defaults	="||||||||||||||"
			 editcol	="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
			 widths		="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
			 styles		="width:100%; height:100%" 
			 sorting	="F"
			 autosize	='true'
			 oncelldblclick = 'OnDBClick()'
			 oncellclick=""/>
		</td>
	</tr>
</table>
</body>
</html>
