<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<%ESysLib.SetUser("comm")%>
<script>

function BodyInit()
{
	System.Translate(document); 
}
/*----------------------------------------*/

function checkKey() 
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
/*------------------------------------------*/

function valueReturn() {
	var row = idGrid.GetGridControl().row;
	var arr = new Array();
	if(row >= 1)
	{
		arr[0] = idGrid.GetGridData(row,0); 
		arr[1] = idGrid.GetGridData(row,1); 
		arr[2] = idGrid.GetGridData(row,2); 	
		window.returnValue = arr;
		window.close();
	}
}
/*------------------------------------------*/
function OnCancel()
{
	var arr=new Array()
	arr[0] = 0;
	window.returnValue = arr; 
	this.close();
}
/*------------------------------------------*/
function OnSearch()
{
    dso_get_budget_popup.Call("SELECT");
}

</script>

<body>

	<gw:data id="dso_get_budget_popup"   > 
        <xml> 
          <dso type="grid" parameter="0,1,2" function="comm.sp_get_budget_popup" >  
                <input >
                    <input bind="txtInput_NM" /> 
                </input> 
                <output bind="idGrid" /> 
          </dso>
        </xml> 
    </gw:data> 

<table  width="100%" cellpadding="0" cellspacing="0" border="1">
	<tr>
		<td width="55%">
						<!-- Table1 contain master buttons and text box -->
						<table id="LeftTopTB" height="20" width="55%">
							<tr>
								<td width="40%" align="right"><font color="black" ><b>Budget Deparment</b>&nbsp;&nbsp;</font></td>
								<td width="30%"><gw:textbox id="txtInput_NM" styles="width:100%"  onkeypress="checkKey()" onenterkey="idData_dsql_abbudget_popup.Call()" csstype="filter" /></td>
								<td width="5%"><gw:imgBtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()"  /></td>
								<td width="20%"></td>
								<td width="5%"><gw:imgBtn id="btnClose" img="cancel" alt="Close" text="Close" onclick="OnCancel()" /></td>
							</tr>
						</table>
						<!-- End of Table1--->
		</td>
		<td width="45%"></td>
		
	</tr>
	<tr>
		
		<td width="100%">
						<!-- Table2 contain detail grid -->
						<table id="RightBottomTB" width="100%" height="100%"  align="top" >
							<tr>
								<td width="100%"> <!-- Detail Grid Control here --> 
									<gw:grid   
										id="idGrid"  
										header="_PK|Budget Department|Local Name|_P_PK|Upper Budget Department"   
										format="0|0|0|0|0"  
										aligns="0|0|0|0|0"  
										defaults="||||"  
										editcol="0|0|0|0|0"  
										widths="0|4000|4000|0|0"  
										styles="width:100%; height:370"   
										sorting="F"   
										param="0,1,2,3,4" oncelldblclick="valueReturn()" /> 

								</td>
							</tr>
						</table>
						<!-- End of Table2 -->		
		</td>
	</tr>	
</table>



<!-- End of MainTable-->
</body>
</html>