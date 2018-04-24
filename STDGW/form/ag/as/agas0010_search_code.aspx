<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>

<script>

function BodyInit()
{
    System.Translate(document); 
	/*-- Initialize form data block --*/	
    // Call master data control with action "SELECT" idMasterData.Call()
	var tmp = "<%=request.QueryString("strID")%>"
	txtInput_ID.SetDataText(tmp)
	datCode_MST_Sub.Call("SELECT");
	
	
	/*-- End initialize block --*/		
}

function DSOReceive( dsoinfo  )
{
	if ( dsoinfo.errno > 0 )
	{
		alert( dsoinfo.errmsg );
		return ;
	}
}


function OnEnterTextBox()
{
	datCode_MST_Sub.Call("SELECT");
}

function RowDbClick()
{
	var aValue = new Array();
	aValue[0] = "wcab001002";	
	aValue[1] = grdCode.GetGridData( grdCode.row, 0);	
	aValue[2] = grdCode.GetGridData( grdCode.row, 1);
	aValue[3] = grdCode.GetGridData( grdCode.row, 2);
	window.returnValue = aValue; 
	window.close();
}
function EXITOnClick()
{
	window.close();
}
function OKOnClick()
{
    if (grdCode.row<=0)
    {
        alert("You have to select code group!");
        return;
    }
	var aValue = new Array();
	aValue[0] = "wcab001002";	
	aValue[1] = grdCode.GetGridData( grdCode.row, 0);	
	aValue[2] = grdCode.GetGridData( grdCode.row, 1);
	aValue[3] = grdCode.GetGridData( grdCode.row, 2);
	alert(aValue[3]);
	window.returnValue = aValue; 
	window.close();
}

function OnDataReceive(obj)
{
    var ctrl = grdCode.GetGridControl();
	var row = ctrl.Rows  ;
	
	grdCode.DownRow();
	grdCode.UpRow();
	
	var tmp = window.status;
}
</script>
<body>
<!-- MainTable -->
<gw:data id="datCode_MST_Sub" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="comm.sp_sel_code_mst_sub" > 
                <input bind="grdCode" > 
                    <input bind="txtInput_ID" /> 
                    <input bind="txtInput_REMARK" /> 
                </input> 
                <output bind="grdCode" /> 
            </dso> 
        </xml> 
    </gw:data> 
<table class="table" width="100%" cellpadding="0" cellspacing="0" border="1">
	<tr>
		<td width="100%">
					<!-- Table2 contain detail buttons and text box -->
					<table id="RightTopTB" height="20" width="100%">
						<tr>
							<td width="20%" align="right"><font color="black" ><b>Ac Code &nbsp; </b></font></td>
							<td width="60%"><gw:textbox id="txtInput_ID" styles="width:100%;" onenterkey ="OnEnterTextBox()"/> </td>
							<td width="20%"></td>					
							
						</tr>
						<tr>
							<td width="20%" align="right"><font color="black" ><b>Code Name&nbsp; </b></font></td>
							<td width="60%"><gw:textbox id="txtInput_REMARK" styles="width:100%;" onenterkey ="OnEnterTextBox()"/> </td>
							<td width="20%"></td>					
							
						</tr>
						
						
					</table>
					<!-- End of Table2 -->					
		</td>
	</tr>
	<tr>
		
		<td width="100%">
						<!-- Table2 contain detail grid -->
						<table id="RightBottomTB" width="100%" height="100%"  align="top" >
							<tr>
								<td> <!-- Detail Grid Control here -->
								<gw:grid   
										id="grdCode"  
										header="_PK|ID|Remark"   
										format="0|2|0"  
										aligns="0|0|0"  
										defaults="||"  
										editcol="1|1|1"  
										widths="0|2000|0"  
										styles="width:100%; height:400"   
										sorting="T"   
										param="0,1,2"  oncelldblclick ="RowDbClick()" /> 
								
								</td>
							</tr>
						</table>
						<!-- End of Table2 -->		
		</td>
	</tr>	
	
	<tr>
		
		<td width="100%">
						<!-- Table2 contain detail grid -->
						<table id="RightBottomTB1" width="100%" height="20"  align="top" >
							<tr>
								<td width="35%"> <!-- Detail Grid Control here --></td>
								<td width="15%"><gw:icon id="icoOK" 		img="in" text="OK" 	styles='width:100%'	onclick="OKOnClick()" /></td>
								<td width="15%"><gw:icon id="icoEXIT" 	img="in" text="Exit" 	styles='width:100%'	onclick="EXITOnClick()" /></td>
								<td width="35%"></td>
								
							</tr>
						</table>
						<!-- End of Table2 -->		
		</td>
	</tr>	
</table>
</body>

</html>
