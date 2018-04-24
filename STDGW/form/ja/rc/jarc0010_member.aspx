<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Popup Get Member</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
//======================================================================
function BodyInit()
{
    var member_no = "<%=Request.querystring("member_no")%>";   
     txtMemberNo.text  =member_no   
     OnSearch();         
}
//============================================================================== 

 function BindingDataList()
 {                                
 }

 //===================================================================================
function OnSearch()
{
    data_jarc0010.Call("SELECT");
}  

//==============================================================================
function OnSelect(oGrid)
{
   var arr_data = new Array();
   var control = oGrid.GetGridControl();
   var rows = control.Rows;
	
	if (control.SelectedRows >0)
	{
		for (i=0; i<control.SelectedRows ; i++)
		{
			var row = control.SelectedRow(i);
			
			var arrTemp=new Array();
         
             for(var j=0;j<oGrid.cols;j++)
             {
                arrTemp[arrTemp.length]= oGrid.GetGridData(row,j);
             }
             
             arr_data[arr_data.length]= arrTemp;
		}
		window.returnValue =  arr_data;
		window.close();
    }
	
	  else
	  {
	    alert("You have not selected data yet.");
	  }
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_jarc0010" onreceive=""> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="CRM.sp_sel_jarc0010_member" > 
                <input> 
                    <inout bind="txtMemberNo" />                                   
                </input> 
                <output bind="grdMem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="right" style="width: 10%; white-space: nowrap">
                Member No</td>
            <td style="width: 30%">
                <gw:textbox id="txtMemberNo" styles="width:100%" onenterkey ='OnSearch()' />
            </td>
            <td align="right" style="width: 10%">
            </td>
            <td style="width: 40%">
			  <b style="color:red">Double click on the row to get it</b>
            </td>
            <td style="width: 10%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td style="width: 100%" colspan="8">
                <gw:grid id='grdMem'
                    header='_PK|Member ID|Member Nm|Birdthday|Gender|Phone|Email|National|Company|Company Tel|Tax Code|Com Address|Personal ID/PP|_Member_Type_PK'
                    format='0|0|0|4|0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='|||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1500|2500|1000|1000|1000|1000|1000|1000|1000|1000|1000|0|1000'
                    sorting='T'
                    styles='width:100%; height:100%'
                    oncelldblclick="OnSelect(this)"
                    sorting='T' onresize="true"
                    />
             </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
