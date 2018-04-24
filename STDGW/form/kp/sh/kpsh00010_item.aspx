<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Major Item Setup</title>
</head>
<%  ESysLib.SetUser("EC111")%>
<script>

function BodyInit()
{
	System.Translate(document);
	txtProjectPk.text = "<%=Request.querystring("p_project_pk")%>";
	OnSearch();
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
			var ctl = grdData.GetGridControl();
			ctl.OutlineBar = 5;
            var j;
            for (i = 1; i < grdData.rows; i++)
            {  
                j = Find_Heigher_Level(grdData.GetGridData(i, 1),i);
				ctl.IsSubtotal(i)		= true;
                ctl.RowOutlineLevel(i)	= j;   
            }
		break;
	}
}

function Find_Heigher_Level(value, row)
{
	var i = row;
    if ( grdData.GetGridData(row, 1) == "1" )
    { 
		grdData.SetCellBgColor(row, 0, row, grdData.cols - 1, 0xEDEDED);
        return 0;
    }    
    else
    {
        while (i>=1)
        {
            if ( grdData.GetGridData(i, 1) == value-1)
            {
                return i;
            }    
            i = i - 1
        }
    }    
}

function OnClick(obj)
{
	switch (obj.id)
	{
		case 'btnNew':
			var fpath = System.RootURL + "/form/kp/sh/kpsh00010_item_new.aspx?p_porject_pk=" + txtProjectPk.text;
            var aValue = System.OpenModal( fpath , 500 , 400 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
			OnSearch();
		break;
		case 'btnClose':
			window.returnValue = ''; 
	   		this.close(); 	
		break;
	}		
}
//==============================================================================================  
</script>
<body>
<gw:data id="dso_grdData" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="3" type="grid" function="EC111.sp_sel_kpsh00010_search" > 
            <input bind="grdData">                    
                <input bind="txtProjectPk" />
            </input> 
            <output bind="grdData" /> 
        </dso> 
    </xml> 
</gw:data>
<table style="width:100%;height:100% " cellpadding="0" cellspacing="0">
    <tr style="height:4%">
        <td>
            <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td style="width: 75%" ></td>
					<td style="width: 5%" >
						<gw:icon id="btnNew" img="in" text="New" onclick="OnClick(this)"  />
					</td>
					<td style="width: 5%" >
						<gw:icon id="btnSubord" img="in" text="Subord It..." onclick="OnClick(this)"  />
					</td>
					<td style="width: 5%" >
						<gw:icon id="btnDelte" img="in" text="Delete" onclick="OnClick(this)"  />
					</td>
					<td style="width: 5%" >
						<gw:icon id="btnSave" img="in" text="Save" onclick="OnClick(this)"  />
					</td>
					<td style="width: 5%" >
						<gw:icon id="btnClose" img="in" text="Close" onclick="OnClick(this)"  />
					</td>
				</tr>
			</table>
        </td>
    </tr>
    <tr style="height:96%">
    	<td style="padding-top:5px;">
			<gw:grid   
			id="grdData"  
			header="Name|Level|Code|Prog.Existing"
			format  ="0|0|0|0"
			aligns  ="0|0|0|0"
			defaults="|||"
			editcol ="1|1|1|1"
			widths  ="4000|1500|1500|4000"
			styles="width:100%; height:100%"   
			sorting="T"  />
		</td>    
    </tr>
</table>
</body>
<gw:textbox id="txtProjectPk" readonly="true"  styles='width:100%;display:none' />
</html>
