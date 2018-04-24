<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Work PopUp</title>
</head>
<%  ESysLib.SetUser("ec111")%>
<script>
var acc_pk = 1;
function BodyInit()
{
	System.Translate(document);
	var Prj = "<%=Request.querystring("Project_Pk")%>";
	txtProject_Pk.SetDataText(Prj);
	BindingDataList();
	//OnSearch();
}
//-------------------------------------------------------------------------------------------------------------------------------------
function BindingDataList()
{
        var ls_Level = "<%=ESysLib.SetListDataFUNC("SELECT ACNT.SF_A_GET_COMMONCODE('EACAB052') FROM DUAL")%>|ALL|All Level"; 
            lstLevel.SetDataText(ls_Level); 
            lstLevel.value = "ALL"; 
} 
//-------------------------------------------------------------------------------------------------------------------------------------
function OnSearch()
{
    dso_Search.Call("SELECT");
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{  
    switch(obj.id)
    {
        case "dso_Search":
          
			var ctrl 	= Grid_Search.GetGridControl();
			for (i=1; i<ctrl.Rows; i++)
			{
				if(Grid_Search.GetGridData(i,4)== "0")
				{
					Grid_Search.SetCellBold(i,5,i,5,true);
				}
				else
				{   
					Grid_Search.SetCellBold(i,5,i,5,false);
				}
				
			    if (Grid_Search.GetGridData(i,5)== "0" && Grid_Search.GetGridData(i,4)== "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0XF4E6E0'));
				}
				else if (Grid_Search.GetGridData(i,5)== "1" && Grid_Search.GetGridData(i,4)== "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0X99CCFF'));
				}
				else if (Grid_Search.GetGridData(i,5)== "2" && Grid_Search.GetGridData(i,4)== "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0XCCFFCC'));
				}
				else if (Grid_Search.GetGridData(i,5)== "3" && Grid_Search.GetGridData(i,4)== "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0XCCFF00'));//3 00CCFF
				}
				else if (Grid_Search.GetGridData(i,5)== "4" && Grid_Search.GetGridData(i,4)== "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0XFF99CC'));//4
				}
				else if (Grid_Search.GetGridData(i,5)== "5" && Grid_Search.GetGridData(i,4)== "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0XCC9999'));//5
				}
				else if (Grid_Search.GetGridData(i,5)== "6" && Grid_Search.GetGridData(i,4)== "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0X009933'));//6m
				}
				else if (Grid_Search.GetGridData(i,5)== "7" && Grid_Search.GetGridData(i,4)== "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0XCC6633'));//7
				}
				else if (Grid_Search.GetGridData(i,5)== "8" && Grid_Search.GetGridData(i,4)== "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0X006666'));//8
				}
				else if (Grid_Search.GetGridData(i,4) != "")
				{
					Grid_Search.SetCellBgColor(i,0,i,5, Number('0XEFFFFF'));
				}
			}
        break;
    }
}  

//=============================================================================================
function OnGridCellDoubleClick(oGrid)
{
	   var code_data=new Array()
	   var ctrl = Grid_Search.GetGridControl();
		
        code_data[0] = Grid_Search.GetGridData( ctrl.row , 0 );
		code_data[1] = Grid_Search.GetGridData( ctrl.row , 1 );
		code_data[2] = Grid_Search.GetGridData( ctrl.row , 2 );
		code_data[3] = Grid_Search.GetGridData( ctrl.row , 3 );
        code_data[4] = Grid_Search.GetGridData( ctrl.row , 4 );
        code_data[5] = Grid_Search.GetGridData( ctrl.row , 5 );
		window.returnValue = code_data; 
	   	this.close();
}   



//=========================================================================
</script>
<body>
<gw:data id="dso_Search" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid"  function="ec111.sp_sel_kpbm215_pitem_1" >
                <input bind="Grid_Search">
                    <input bind="txtLevel"/>
                    <input bind="txtProject_Pk"/> 
                </input> 
                <output bind="Grid_Search"/>
            </dso>
        </xml>
 </gw:data>  
<table cellpadding="0" cellspacing="0" style="width:100%;height:100%">
	<tr style="height:2%">
		 <td width="100%">
			<fieldset style="padding:0">
				<table cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" width="5%">Level&nbsp;</td>
						<td width="55%"><gw:textbox id="txtLevel" onenterkey="OnSearch()" styles="width:100%;" /></td>
						<td width="40%"></td>
					</tr>
				</table>
			 </fieldset>
		 </td>
	</tr>
    <tr style="height: 48%;width:100%">
	  <!--0Upper Code|1.Item code|2.Item Name|3_Levelcode_pk|4_item_pk|5Level-->
	  <td  valign="top" width="100%">
			<gw:grid   
			id="Grid_Search"  
			header="Upper Code|Item code|Item Name|_Levelcode_pk|_item_pk|Level"   
			format  ="0|0|0|0|0|0"  
			 aligns ="0|0|0|0|0|0"  
			defaults="|||||0"  
			editcol ="0|0|0|0|0|0"  
			widths  ="4000|4000|4000|1000|0|0"  
			styles="width:100%; height:100%"   
			sorting="T" 
			oncelldblclick= "OnGridCellDoubleClick(this)" /> 
			 /> 
	   </td>
     </tr>
	 
 </table>
 <gw:textbox id="txtWorkName" styles='width:100%;display:none' />
 <gw:textbox id="lstLevel" styles='width:100%;display:' />   
    <gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />                     
</body>
</html>
