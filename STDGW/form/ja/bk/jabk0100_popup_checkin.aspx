<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Popup Get Member</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
//============================================================================== 
function BodyInit()
{
	var tournament = "<%=Request.querystring("p_tournament")%>";
    txtTournament_Pk.text  = tournament;
    OnSearch();
}
//============================================================================== 
function BindingDataList()
{                                
}
//============================================================================== 
function OnSearch()
{
    data_jarc0100.Call("SELECT");
}  
//============================================================================== 
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   if(oGrid.rows > 1)// 
   {
      for(var i=1;i<oGrid.rows;i++)
      {
            if(oGrid.GetGridData(i,0) == "-1"){
                var arrTemp=new Array();
                 
                 for(var j=1;j<oGrid.cols;j++)
                 {
                    arrTemp[arrTemp.length]= oGrid.GetGridData(i,j);
                 }
                 arr_data[arr_data.length]= arrTemp;
            }
             
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
//==============================================================================
function OnRemove()
{
  if(grdSelect.row > 0){
    grdSelect.RemoveRowAt(grdSelect.row);
  }
}
//==============================================================================
function CheckDataExist(p_oGrid,p_value)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,1) == p_value)
      {
         return true;
      }
   }
   return false;
}
//==============================================================================
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdMem" :
                var col_val = oGrid.GetGridData(event.row, 1);
                if ( event.row > 0 && (!CheckDataExist(grdSelect,col_val) ))
                {
                    grdSelect.AddRow();
		            for(var i=0;i<oGrid.cols;i++)
		            {
		               grdSelect.SetGridText(grdSelect.rows-1,i,(i==0)?-1:oGrid.GetGridData(event.row,i));
		            }
                }else{
                    alert("Golfer name : " + oGrid.GetGridData(event.row,4) + " is exist!");
                    return false;
                }
            break;
      }      
   
}
function On_UnAllcheck()
{
    if(checkAll.value=="Y")
    {
        for(var i=1;i<grdMem.rows;i++)
         {
            grdMem.SetGridText(i,0,-1);
         } 
     } 
     else
     {
       for(var i=1;i<grdMem.rows;i++)
         {
            grdMem.SetGridText(i,0,0);
         } 
     }
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_jarc0100" onreceive=""> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="crm.sp_sel_jabk0100_popupcheckin" > 
                <input> 
                    <inout bind="txtGroupNo" />  
					<inout bind="txtTournament_Pk" />
                </input> 
                <output bind="grdMem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="right" style="width: 7%">
                <b>Date</b>
            </td>
            <td align="right" style="width: 10%; white-space: nowrap">Group No</td>
            <td style="width: 55%"><gw:textbox id="txtGroupNo" styles="width:80%" onenterkey='OnSearch()' /></td>
            <td style="width: 20%"></td>
            <td align="right" style="width: 3%"></td>
            <td style="width: 10%" align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" /></td>
        </tr>
        <tr style="height: 49%">
            <td style="width: 100%" colspan="7">
                <gw:grid id='grdMem' 
                    header='_Check|_PK|Group No|Card No|Golfer Name|_Full_Name|Tee Time|Trans Date'
                    format='3|0|0|0|0|0|0|4' 
                    aligns='0|1|1|1|0|0|1|1' 
                    defaults='|||||||' 
                    editcol='0|0|0|0|0|0|0|0'
                    widths='0|500|1000|1000|2500|1000|1000|1000' 
                    sorting='T' 
                    styles='width:100%; height:100%'
                    sorting='T' 
                    onresize="true" 
                    oncelldblclick="OnGridCellDoubleClick(this)"
                    />
            </td>
        </tr>
        <tr style="height:1%">
            <td colspan="5"></td>
            <td align="right"><gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" /></td>
            <td align="right"><gw:imgbtn img="select" alt="Select" id="Select" onclick="OnSelect(grdSelect)" /></td>
        </tr>
        <tr style="height: 49%">
            <td style="width: 100%" colspan="7">
                <gw:grid id='grdSelect' 
                    header='_Check|_PK|Group No|Card No|Golfer Name|_Full_Name|Tee Time|Trans Date'
                    format='3|0|0|0|0|0|0|4' 
                    aligns='0|1|1|1|0|0|1|1' 
                    defaults='|||||||' 
                    editcol='0|0|0|0|0|0|0|0'
                    widths='0|500|1000|1000|2500|1000|1000|1000' 
                    sorting='T' 
                    styles='width:100%; height:100%'
                    sorting='T' 
                    onresize="true" />
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <gw:textbox id="txtTournament_Pk" styles="width:100%; display:none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
