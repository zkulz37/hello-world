<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Room Status</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>

function BodyInit()
{
	data_DataHide.Call("SELECT");
}
var mTimer;
function SettimeReSearch()
{
  mTimer = setTimeout('OnSearch();',3000000); //Refresh every 5 minutes 
}
function OnSearch()
{
    grdData.ClearData();
    data_DataHide.Call("SELECT");
}
function OnDataReceive(obj)
{
    clearInterval(mTimer);
	
    var l_VD=0,l_OD=0,l_VC=0,l_OC=0,l_OOO=0;
	var row,hiderow,col_master,col_hide,status_color,set_color,value_col_mst_hide,status_color,set_color;
    var idx = 0,count_row_hide,div_row,mod_row,add_row_mst,count_then_addnew;
    count_row_hide=grdHideData.rows-1;
    if(count_row_hide > 18)
    {
        div_row= count_row_hide/18;
        mod_row=count_row_hide%18;
        if(mod_row !=0)
        {
            count_then_addnew=div_row+1;
        }
        else
        {
            count_then_addnew=div_row;
        }
    }
    else
    {   
        count_then_addnew=2;
    }
    if(obj.id=='data_DataHide')
    {
        for (var add_row = 1; add_row <= 14; add_row ++ )
            {
                grdData.AddRow();
            }
            if(grdData.rows > 0)
            {
				var tmp = 0;
                for (row = 1; row < grdData.rows; row ++ )
                    for (col_master = 0; col_master < grdData.cols-1 ; col_master ++ ){
                        if((idx+1) < grdHideData.rows)
                        {
							
                            idx ++;
                            value_col_mst_hide = grdHideData.GetGridData(idx, 0);
							var room_no = grdHideData.GetGridData(idx, 1);
                            status_color= grdHideData.GetGridData(idx, 2);
                            if(status_color == 'LOS')
                            {
                                set_color =0x11D7E9; //0x0000CE   
								l_VD=l_VD + 1;
                            }
                            else if(status_color == 'BRK')
                            {
                                set_color =0x0066ff;//0xB3B3D7
								l_OD=l_OD + 1;
                            }
                            if(status_color == 'VC')
                            {
                                set_color =0xff6633; // 0x336633
								l_VC=l_VC + 1;
                            }
                            else if(status_color == 'OC')
                            {
                                set_color =0x2CC00B;// 0xCC9933
								l_OC=l_OC + 1;
                            }
							else if(status_color == 'NRTN')
                            {
                                set_color =0x0000ff;
								l_OOO=l_OOO + 1;
                            }
							var tmp_value_col_mst_hide;
							
							if(value_col_mst_hide.length > 0)
							{
							  tmp_value_col_mst_hide=value_col_mst_hide;
							  //alert(tmp_value_col_mst_hide);
							}
							else
							{
								tmp_value_col_mst_hide=value_col_mst_hide;
							}
							
							/*if(tmp != tmp_value_col_mst_hide)
							{
								col_master = 0; 
								tmp = tmp_value_col_mst_hide;
							}*/
							lbCUS1.text="VACANCY CLEAN : "+l_VC; 
							lbCUS2.text="OCCUPPIED CLEAN : "+l_OC; 
							lbCUS3.text="OCCUPPIED DIRTY : "+l_OD; 
							lbCUS4.text="VACANCY DIRTY : "+l_VD; 
							lbCUS5.text="OUT OF ORDER : "+l_OOO; 
							
							if((tmp_value_col_mst_hide)>0 &&(tmp_value_col_mst_hide) <19)
							{
								
									grdData.SetGridText(1, col_master, room_no);
									grdData.SetCellBgColor(1, col_master, 1, col_master, set_color);
							}		
							else if((tmp_value_col_mst_hide)>18 && (tmp_value_col_mst_hide) <37)
						    {
									grdData.SetGridText(2, col_master, room_no);
									grdData.SetCellBgColor(2, col_master,2, col_master, set_color);
							}
							else if((tmp_value_col_mst_hide)>36 && (tmp_value_col_mst_hide) <55)
						    {
									grdData.SetGridText(3, col_master, room_no);
									grdData.SetCellBgColor(3, col_master, 3, col_master, set_color);
							}
							else if((tmp_value_col_mst_hide)>54 && (tmp_value_col_mst_hide) <73)
						    {
									grdData.SetGridText(4, col_master, room_no);
									grdData.SetCellBgColor(4, col_master, 4, col_master, set_color);
							}
                            else if((tmp_value_col_mst_hide)>72 && (tmp_value_col_mst_hide) <91)
						    {
									grdData.SetGridText(5, col_master, room_no);
									grdData.SetCellBgColor(5, col_master, 5, col_master, set_color);
							}  
							else if((tmp_value_col_mst_hide)>90 && (tmp_value_col_mst_hide) <109)
						    {
									grdData.SetGridText(6, col_master, room_no);
									grdData.SetCellBgColor(6, col_master, 6, col_master, set_color);
							}  
							else if((tmp_value_col_mst_hide)>108 && (tmp_value_col_mst_hide) <127)
						    {
									grdData.SetGridText(7, col_master, room_no);
									grdData.SetCellBgColor(7, col_master, 7, col_master, set_color);
							}  
							else if((tmp_value_col_mst_hide)>126 && (tmp_value_col_mst_hide) <145)
						    {
									grdData.SetGridText(8, col_master, room_no);
									grdData.SetCellBgColor(8, col_master, 8, col_master, set_color);
							}  
							else if((tmp_value_col_mst_hide)>144 && (tmp_value_col_mst_hide) <163)
						    {
									grdData.SetGridText(9, col_master, room_no);
									grdData.SetCellBgColor(9, col_master, 9, col_master, set_color);
							}  
							else if((tmp_value_col_mst_hide)>162 && (tmp_value_col_mst_hide) <181)
						    {
									grdData.SetGridText(10, col_master, room_no);
									grdData.SetCellBgColor(10, col_master, 10, col_master, set_color);
							}  
							else if((tmp_value_col_mst_hide)>180 && (tmp_value_col_mst_hide) <199)
						    {
									grdData.SetGridText(11, col_master, room_no);
									grdData.SetCellBgColor(11, col_master, 11, col_master, set_color);
							}  
							else if((tmp_value_col_mst_hide)>198 && (tmp_value_col_mst_hide) <217)
						    {
									grdData.SetGridText(12, col_master, room_no);
									grdData.SetCellBgColor(12, col_master, 12, col_master, set_color);
							}  
							else if((tmp_value_col_mst_hide)>216 && (tmp_value_col_mst_hide) <225)
						    {
									grdData.SetGridText(13, col_master, room_no);
									grdData.SetCellBgColor(13, col_master, 13, col_master, set_color);
							} 
							else if((tmp_value_col_mst_hide)>224 && (tmp_value_col_mst_hide) <234)
						    {
									grdData.SetGridText(14, col_master, room_no);
									grdData.SetCellBgColor(14, col_master, 14, col_master, set_color);
							}	
                        }
                    }
            }
    }
	SettimeReSearch();
 }  

 function OnReport()
{
		var url =System.RootURL + '/reports/ja/rc/rpt_jarc00130_Locker_Status.aspx';
		System.OpenTargetPage(url);	           
}
</script>

<body>
    <gw:data id="data_DataHide" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="CRM.sp_sel_jarc00130_grd_hide">  
                <input >  
                </input>
                <output bind="grdHideData" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 2%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>  
                        <td style="width: 20%; white-space: nowrap">
                            <gw:label id="lbCUS1" styles="text-align: center; color: white; background-color: #3366ff;width:100%;font-weight: bold;font-size:13">VACANCY CLEAN 
							</gw:label>
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:label id="lbCUS2" styles="text-align: center; color: white; background-color: #0BC02C;width:100%;font-weight: bold;font-size:13">OCCUPPIED CLEAN 
							</gw:label>
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:label id="lbCUS3" styles="text-align: center; color: white; background-color: #ff6600;width:100%;font-weight: bold;font-size:13">OCCUPPIED DIRTY
							</gw:label>
                        </td>
                        <td style="width: 18%; white-space: nowrap">
                            <gw:label id="lbCUS4" styles="text-align: center; color: black; background-color: #E9D711;width:100%;font-weight: bold;font-size:13">VACANCY DIRTY
							</gw:label>
                        </td>
						<td style="width: 16%; white-space: nowrap"><gw:label id="lbCUS5" styles="text-align: center; color: white; background-color:#ff0000;width:100%;font-weight: bold;font-size:13">OUT OF ORDER
							</gw:label></td>
                        <td style="width: 3%; white-space: nowrap" align="right">
                        </td>
						<td style="width: 3%" align="left">
                            
                        </td>
						<td style="width: 3%" align="right">
                            <gw:imgbtn id="ibtnReport1" img="excel" alt="Report" onclick="OnReport()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 97%"> 
            <td>
                <gw:grid id='grdData' header='|||||||||||||||||'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    defaults='||||||||||||||||||' 
                    widths='920|920|920|920|920|920|920|920|920|920|920|920|920|920|920|920|920|920' sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
        <tr style="height: 1%">
            <td>
                <gw:grid id='grdHideData' header='Locker_Use_Compar|Locker#|status' format='0|0|0' aligns='0|0|0'
                    defaults='||' editcol='0|0|0' widths='0|0|0' sorting='T' styles="display:none"
                    autosize="T" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
