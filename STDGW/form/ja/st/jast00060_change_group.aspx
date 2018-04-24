<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Popup Change Group </title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
//======================================================================
function BodyInit()
{
    //var member_no = "<%=Request.querystring("member_no")%>";   
    // txtGroupNo.text  =member_no
     BindingDataList();   
     OnSearch();         
}
//============================================================================== 

 function BindingDataList()
 {   
    var data="";
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.PK, A.COURSE_ID ||' - '|| A.COURSE_NAME FROM CRM.TGM_GOLF_COURSE A WHERE A.DEL_IF =0" )%>"; 
	grdMem.SetComboFormat(4,data);  //golf course  
	
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
            <dso id="1" type="grid" user="sale" function="crm.sp_sel_jast00060_change_group" > 
                <input> 
                    <inout bind="txtGroupNo" />                                   
                </input> 
                <output bind="grdMem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="right" style="width: 10%; white-space: nowrap">
                Group No</td>
            <td style="width: 30%">
                <gw:textbox id="txtGroupNo" styles="width:100%" onenterkey ='OnSearch()' />
            </td>
            <td align="right" style="width: 10%">
            </td>
            <td style="width: 40%">
            </td>
            <td style="width: 10%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td style="width: 100%" colspan="5">
                <gw:grid id='grdMem'
                    header='_tgm_visitorfee_pk|_tcm_booking_YN|_tcm_booking_pk|Group No|Golf Course|Tee Time'
                    format='0|0|0|0|0|0'
                    aligns='0|0|0|0|0|0'
                    defaults='|||||'
                    editcol='0|0|0|0|0|0|'
                    widths='1000|1000|1000|1000|1000|1000'
                    sorting='T'
                    styles='width:100%; height:100%'
                    oncelldblclick="OnSelect(this)"
                    autosize="T"
                    />
             </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
