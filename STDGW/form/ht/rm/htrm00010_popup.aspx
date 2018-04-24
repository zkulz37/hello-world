<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Select Room Type</title>
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
 {
	OnSearch();
 }
 function ResetHeader(){
    BuildHeader(grdRFCUsing);
	BuildHeader2(grdRFCUsing2);
	SetColorColumn(grdRFCUsing);
	SetColorColumn(grdRFCUsing2);
 } 
 function SetColorColumn(ctrl)
 {
	  for (var row = 1; row < ctrl.rows; row ++ )
           for (var col_master = 2; col_master < ctrl.cols ; col_master ++ )
                  {
                         var value_col_mst = ctrl.GetGridData(row, col_master);
						 if(value_col_mst < 0)
						 {
							ctrl.SetCellBgColor(row, col_master, row, col_master, 0x5c5ccd);//
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
	//ctrl.GetGridControl().TopRow=ctrl.rows-1;
} 
function BuildHeader2(ctrl){
    ctrl.ClearData();
	var first_days=Number(grdRFCUsing.GetGridData(1,33));
	var last_day=Number(grdRFCUsing.GetGridData(1,34));
	var first_day=Number(grdRFCUsing.GetGridData(1,35));
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
	//ctrl.GetGridControl().TopRow=ctrl.rows-1;
} 
function OnSelect(oGrid){
	
 var arr_data = new Array();
   
   if(oGrid.rows > 1)
   {   
      for(var i=1;i<oGrid.rows;i++){
         var arrTemp=new Array();
         
         for(var j=0;j<oGrid.cols;j++){
            arrTemp[arrTemp.length]= oGrid.GetGridData(i,j);
         }
         
         arr_data[arr_data.length]= arrTemp;
      }
      
	  if ( arr_data !=null ){
		window.returnValue =  arr_data;
		window.close();
	  }else{
	    alert("You have not selected data yet.");
	  }
   }	  
}	
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == "grdRFCUsing" && event.row > 0 )
      {
            var col_val = oGrid.GetGridData(event.row, 1 );
            
            if(event.row > 0)
            {
                grdRFCUsing2.AddRow();
		        for(var i=0;i<oGrid.cols;i++)
		        {
		          grdRFCUsing2.SetGridText(grdRFCUsing2.rows-1,i,oGrid.GetGridData(event.row,i));
		        }
            }
			
      }
}
function OnRemove()
{
  if(grdRFCUsing2.row > 0)
  {
    var col_val = grdRFCUsing2.GetGridData( grdRFCUsing2.row, 0);
    
    grdRFCUsing2.RemoveRowAt(grdRFCUsing2.row);
    
    SetRowBackGroundColor(grdRoom,col_val,0x000000); 
  }
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
           <dso  type="grid"   function="crm.sp_sel_htrm00010_popup" >
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
						    <gw:icon text="Show detail booking" id="btnShow" onclick="OnShowDetailBK()" />
                        </td>
                        <td style="width: 70%" align="right">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height:50%">
            <td>
                <gw:grid id='grdRFCUsing' 
				    header='Type|Total|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|_first_days|_last_day|_current_day'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                    aligns='0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    sorting='T' styles='width:100%; height:100%' autosize="T"
                    acceptnulldate="T" oncelldblclick="OnGridCellDoubleClick(this)"/>
            </td>
        </tr>
		<tr style="height: 3%">
		    <td>
				<table style="width: 100%; height: 100%">
					<tr>
						<td style="width:94%"  colspan="11">
						</td>
						<td style="width: 3%">
							 <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
						 </td>
						 <td style="width: 3%">
							   <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdRFCUsing2)" />
						 </td>
					</tr>
				</table>
			</td>
            
        </tr>
		<tr style="height:40%">
            <td>
                <gw:grid id='grdRFCUsing2' 
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
