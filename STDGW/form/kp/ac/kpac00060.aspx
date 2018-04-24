<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Work Division Entry</title>
</head>
<%ESysLib.SetUser("ec111")%>
<script language="javascript">
function BodyInit()
{
	System.Translate(document);
	OnSearch();
}
//============================================================================================
function OnNew()
{
	Grid_WorkDivision.AddRow();
}
//============================================================================================
function OnDelete()
{
	Grid_WorkDivision.DeleteRow();	
}
//============================================================================================
function OnSearch()
{
	dso_WorkDivision.Call('SELECT');
}
//============================================================================================
function OnSave()
{
	dso_WorkDivision.Call();
}
//============================================================================================
function OnDblClick()
{
		var code_data=new Array()
	    var ctrl = Grid_WorkDivision.GetGridControl();
        code_data[0] = Grid_WorkDivision.GetGridData( ctrl.row , 0 );//pk
		code_data[1] = Grid_WorkDivision.GetGridData( ctrl.row , 1 );//code
		code_data[2] = Grid_WorkDivision.GetGridData( ctrl.row , 2 );//name
		code_data[3] = Grid_WorkDivision.GetGridData( ctrl.row , 3 );//lname
		code_data[4] = Grid_WorkDivision.GetGridData( ctrl.row , 4 );//kname
		code_data[5] = Grid_WorkDivision.GetGridData( ctrl.row , 5 );//remark
		window.returnValue = code_data; 
	   	this.close(); 	
}
</script>
<body>
<gw:data id="dso_WorkDivision"  onreceive="" > 
    <xml> 
        <dso id="1" type="grid"   parameter="0,1,2,3,4,5" function="ec111.sp_sel_kpac00060" procedure="ec111.sp_upd_sp_sel_kpac00060"   > 
            <input bind="Grid_WorkDivision">                    
                <input bind="txtWorkDivision" /> 
            </input> 
            <output bind="Grid_WorkDivision" /> 
        </dso> 
    </xml> 
</gw:data>  
<table style="width:100%;height:100%">
	<tr style="height:4%">
    	<td>
        	<fieldset style="padding:0">
            	<table width="100%" cellpadding="0" cellspacing="0">
                	<tr>
                    	<td align="right" width="15%">Work Division&nbsp;</td>
                        <td width="45%"><gw:textbox id="txtWorkDivision" onenterkey="OnSearch()" styles='width:100%' /></td>
                        <td width="40%"></td>
                        <td ><gw:imgBtn id="ibtnUpdte" img="search" alt="Search" 	onclick="OnSearch()" 	 /></td>  
                        <td ><gw:imgBtn id="ibtUpdte" img="new" alt="New" 	onclick="OnNew()" 	 /></td>   
                        <td ><gw:imgBtn id="ibtnUpdate" img="save" alt="save" 	onclick="OnSave()" 	 /></td>
                        <td ><gw:imgBtn id="ibUpde" img="delete" alt="Delete" 	onclick="OnDelete()" 	 /></td>    
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>
    <tr style="height:96%">
    	<td width="100%">
            <gw:grid   
            id="Grid_WorkDivision"  
            header="_PK|Work Division Code|Work Division Name (ENG)|Work Division Name (VN)|Work Division Name (KOR)|Remark"   
            format  ="0|0|0|0|0|0"  
            aligns  ="0|0|0|0|0|0"  
            defaults="|||||"  
            editcol ="0|1|1|1|1|1"  
            widths  ="0|2000|3000|3000|3000|3000"  
            styles="width:100%; height:100%"   
            sorting="T" 
            oncelldblclick="OnDblClick()"  
             /> 
        </td>
    </tr>
</table>

</body>
</html>
