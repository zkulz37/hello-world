<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
var v_gender =7,
    v_nation = 5;
//======================================================================
function BodyInit()
{
    var member_no = "<%=Request.querystring("member_no")%>";   
    BindingDataList()
     txtMemberNo.text  =member_no   
     OnSearch();         
}
//============================================================================== 

 function BindingDataList()
 {     
    var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'") %> ";       
     grdDetail.SetComboFormat(v_gender,data);
                          
 }

 //===================================================================================
function OnSearch()
{
    data_jabk0011.Call("SELECT");
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
    <gw:data id="data_jabk0011" onreceive=""> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="crm.sp_sel_jabk0011" > 
                <input> 
                    <inout bind="txtMemberNo" />                                   
                </input> 
                <output bind="grdDetail" /> 
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
            </td>
            <td style="width: 10%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td style="width: 100%" colspan="8">
                <gw:grid id='grdDetail' header='_PK|_member_PK|Member No|_TCM_MEMBER_TYPE_PK|Full Name|Player Name|_Passport|_Gender|Phone|_Email|Company|_Company Tel|_Tax Code|_Address|_Photo_PK|_No_guest|_Holes|Book DT|Time|_golf_type'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' autosize="T"
                    defaults='||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' styles='width:100%; height:100%' 
                    oncelldblclick="OnSelect(this)"/>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
