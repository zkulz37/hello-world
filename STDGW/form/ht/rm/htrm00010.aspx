<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>M/R CHECKING</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
 function OnSearch()
 {
    data_htrm00010.Call("SELECT");
 }
 function BodyInit()
 {  //alert("This form is updating. Please come back later.")
	OnSearch();
 }
 function ResetHeader(){
    BuildHeader(grdRFCUsing);
	SetColorColumn();
 } 
 function SetColorColumn()
 {
	  for (var row = 1; row < grdRFCUsing.rows; row ++ )
           for (var col_master = 2; col_master < grdRFCUsing.cols ; col_master ++ )
                  {
                         var value_col_mst = grdRFCUsing.GetGridData(row, col_master);
						 if(value_col_mst < 0)
						 {
							grdRFCUsing.SetCellBgColor(row, col_master, row, col_master, 0x5c5ccd);//
						 }
				   }
 }
 
//=========================================================================
function BuildHeader(ctrl){
	var first_days=Number(ctrl.GetGridData(1,33));
	var last_day=Number(ctrl.GetGridData(1,34));
	var first_day=Number(ctrl.GetGridData(1,35));
	var col_idx;
	if(first_day > 1){
	    //alert(first_days +":"+last_day+":"+first_day)
		for(var i=0;i<=first_days;i++){
			ctrl.SetGridText(0,i+2,first_day+i); 
			ctrl.SetCellBgColor(0, i+2, 0, i+2,0xFFE9BD);//orginal header back ground color
		}
		
		for(var i=1;i<=(31-first_days);i++){
			ctrl.SetGridText(0,i+2+first_days,i);
			ctrl.SetCellBgColor(0, i+first_days+2, 0, i+first_days+2,0X5DFBF6);
		}
		
	}
	else
	{
		for(var i=0;i<=30;i++){
			ctrl.SetGridText(0,i+2,i+1);
			ctrl.SetCellBgColor(0, i+2, 0, i+2,0xFFE9BD);
		}
	}
	//room available
	ctrl.SetCellBgColor(1, 0, 1, ctrl.cols-1,0X64E957);//xanh la cay  
	ctrl.SetCellBgColor(4, 0, 4, ctrl.cols-1,0X64E957);//xanh la cay
	//room sold
	ctrl.SetCellBgColor(9, 0, 9, ctrl.cols-1,0X5DFBF6);
	ctrl.SetCellBgColor(12, 0, 12, ctrl.cols-1,0X5DFBF6);
	//room occupancy
	ctrl.SetCellBgColor(17, 0, 17, ctrl.cols-1,0xFFE9BD);
	ctrl.SetCellBgColor(20, 0, 20, ctrl.cols-1,0xFFE9BD);
} 
function OnShowDetailBK()
{
    if(grdRFCUsing.row > 0)
    {
	   var select_date = grdRFCUsing.GetGridData(0,grdRFCUsing.col);
	   
	   var type = grdRFCUsing.GetGridData(grdRFCUsing.row,0);
	   
	   var dd = dtDate.GetData().substr(6,2);
	   var mm = dtDate.GetData().substr(4,2);
	   var yyyy = dtDate.GetData().substr(0,4);
	   
	   if (Number(select_date) >= Number(dd)){
			if(Number(select_date) < 10){
				select_date = "0" + Number(select_date);
			}
	   }
	   else{
			mm = Number(mm) + 1;
			if(mm > 12){
				yyyy = Number(yyyy) + 1;
				mm = "01";
			}
			if(Number(select_date) < 10){
				select_date = "0" + Number(select_date);
			}
			if(Number(mm) < 10){
				mm = "0" + Number(mm);
			}
	   }
	   select_date = "" + yyyy + mm + select_date;
	   
       var path = System.RootURL + "/form/ht/rm/htrm00010_popup1.aspx?d=" + select_date+"&type="+ type;
	   //alert(path)
       var object = System.OpenModal( path ,600 ,500 ,  'resizable:yes;status:yes');
    }
}
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htrm00010" onreceive="ResetHeader();"> 
        <xml>
           <dso  type="grid"   function="crm.sp_sel_htrm00010" >
                <input  bind="grdRFCUsing">
                    <input bind="dtDate" />
                </input> 
                <output bind="grdRFCUsing" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 10%" align="right">
						    Start date:
                        </td>
						<td style="width: 10%; white-space: nowrap">
                            <gw:datebox id="dtDate" lang="1" onchange="OnSearch()" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
						    <gw:imgBtn img="search" onclick="data_htrm00010.Call();" />
                        </td>
						<td style="width: 5%; white-space: nowrap" align="center">
						    <gw:icon text="Show detail booking" id="btnShow" onclick="OnShowDetailBK()" />
                        </td>
                        <td style="width: 60%" align="right">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdRFCUsing' 
				    header='Type|Total|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|_first_days|_last_day|_current_day'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                    aligns='0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    sorting='T' styles='width:100%; height:100%' autosize="T"
                    acceptnulldate="T" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
