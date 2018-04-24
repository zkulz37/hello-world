<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>vina genuwin</title>
    <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
	Bingding();
	OnSearch();
}

function Bingding()
{
	var data = '';
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>";
	grdRoom2.SetComboFormat(4, data);

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>";
	grdRoom2.SetComboFormat(5, data);

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>";
	grdRoom.SetComboFormat(4, data);

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>";
	grdRoom.SetComboFormat(5, data);
	
	OnSearch();
}
function OnDataReceive()
{
	
}
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == "grdRoom" && event.row > 0 )
      {
            var col_val = oGrid.GetGridData(event.row, 0 );
            
            if(event.row > 0 && ( !CheckDataExist(grdRoom2,col_val)))
            {
                SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		        grdRoom2.AddRow();
		        for(var i=0;i<oGrid.cols;i++)
		        {
		          grdRoom2.SetGridText(grdRoom2.rows-1,i,oGrid.GetGridData(event.row,i));
		        }
            }
      }
}
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   if(oGrid.rows > 1)
   {   
      for(var i=1;i<oGrid.rows;i++)
      {
         var arrTemp=new Array();
         
         for(var j=0;j<oGrid.cols;j++)
         {
            arrTemp[arrTemp.length]= oGrid.GetGridData(i,j);
         }
         
         arr_data[arr_data.length]= arrTemp;
      }
      
	  if ( arr_data !=null )
	  {
		window.returnValue =  arr_data;
		window.close();
	  }
	  else
	  {
	    alert("You have not selected data yet.");
	  }
   }	  
	  
}
function CheckDataExist(p_oGrid,p_value)
{
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, 0) == p_value)
              {
                 return true;
              }
       }
       return false;
}
function OnRemove()
{
  if(grdRoom.row > 0)
  {
    var col_val = grdRoom2.GetGridData( grdRoom2.row, 0);
    
    grdRoom2.RemoveRowAt(grdRoom2.row);
    
    SetRowBackGroundColor(grdRoom,col_val,0x000000); 
  }
}
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, 0) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
function OnSearch()
{
	dsoRoom.Call("SELECT");
}
</script>

</head>
<body>
    <!----------------------------------------------------------------------->
    <gw:data id="dsoRoom" onreceive="OnDataReceive(this)">
        <xml>
           <dso  type="grid"  function="crm.sp_htfo00010_allocate_popup" >
                <input  bind="grdRoom">
                    <input bind="dtFrom" />
					<input bind="dtTo" />
					<input bind="txtGuestNameS" />
                </input> 
                <output bind="grdRoom" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                       <td style="width: 10%" align="right" >Date</td>
					<td style="width: 20%" >
						<gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch()" />
						~<gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch()" />
					</td>
					
					<td style="width: 15%" align="right" nowrap >Guest Name</td>
					<td style="width: 30%" >
						<gw:textbox id="txtGuestNameS" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
						<td style="width: 22%; white-space: nowrap"></td>
						<td style="width: 3%" >
							<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 62%">
            <td colspan="6">
                <gw:grid id='grdRoom' header='_tht_room_pk|_room_type|Last Name|First Name|Gender|Nation|Visa No|Expire Date|_Expire Date_Hide|Birthday|_Birthday_hide|PA/ID|Expire Date|_Expire Date_Hide|Total Adult|Total Child|Description|_Checkin Date|_Checkout Date'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||||||'
					editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    sorting='T' styles='width:100%; height:100%' autosize="T" oncelldblclick="OnGridCellDoubleClick(this)" />
            </td>
        </tr>
		<tr style="height: 3%">
            <td style="width:94%"  colspan="4">
               
            </td>
			<td style="width: 3%">
                 <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
             </td>
             <td style="width: 3%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdRoom2)" />
             </td>
        </tr>

		 <tr style="height: 30%">
            <td  colspan="6">
                <gw:grid id='grdRoom2' header='_tht_room_pk|_room_type|Last Name|First Name|Gender|Nation|Visa No|Expire Date|_Expire Date_Hide|Birthday|_Birthday_hide|PA/ID|Expire Date|_Expire Date_Hide|Total Adult|Total Child|Description|_Checkin Date|_Checkout Date'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||||||'
					editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    sorting='T' styles='width:100%; height:100%' autosize="T" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
