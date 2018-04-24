<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("crm")%>
<head>
    <title>POP UP GET ITEM FROM BOOKING</title>
</head>

<script>
 var tournament = "<%=Request.querystring("p_tournament")%>";  
 //---------------------------------------------------------
 function OnToggle()
 {
    var top  = document.all("top");    
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        top.style.display="none";       
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/down.gif";
    }
    else
    {
        top.style.display="";
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/up.gif";
    }
 }

 //---------------------------------------------------------
 function BodyInit()
 {
	var data = "data |10|HANDICAP DIVISION|20|CALLAWAY DIVISION|30|BEST GROSS|40|NEAREST PIN|50|LONGEST DRIVE|60|NEAREST TO THE LINE"; 
	lstRankType.SetDataText(data);
	
	dsoTournamentList.Call("SELECT");
	
   var lstRankType_pk = "<%=Request.querystring("p_lstRankType_pk")%>";   
     lstRankType.value  =lstRankType_pk;  
	
    
	lstRankType.SetEnable(false); 
	lsttournamnet.SetEnable(false); 
   
 } 

 //---------------------------------------------------------
 function OnSearch()
 {
     dscd00051.Call("SELECT");
 }

//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  if(grdItemSelect.row > 0)
  {
    var col_val = grdItemSelect.GetGridData(grdItemSelect.row,0);
    grdItemSelect.RemoveRowAt(grdItemSelect.row);
    SetRowBackGroundColor(grdTOList,col_val,0x000000); 
    countItem()
  }
}

//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for (var i=1; i<p_oGrid.rows; i++ )
   {
      if ( p_oGrid.GetGridData(i,0) == p_col_val )
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}

//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid,p_value)
{
  for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,2) == p_value)
      {
         return true;
      }
   }
   return false;
}

//---------------------------------------------------------
    var gPreviousRow = -1 ;
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdTOList" :
            
                var col_val = oGrid.GetGridData(event.row,2);
                
                if ( event.row > 0 && ( !CheckDataExist(grdItemSelect,col_val) ) )
                {
                    SetRowBackGroundColor(grdTOList,col_val,0x0000FF);
                    
		            grdItemSelect.AddRow();
            		
		            for(var i=0;i<oGrid.cols;i++)
		            {
		              grdItemSelect.SetGridText(grdItemSelect.rows-1,i,oGrid.GetGridData(event.row,i));
		            }
                 }

                countItem();
            break;
      }      
   
}

//----------------------------------------------------------
//------------------------------------------------------------------------------------------------
function countItem()
{
    txtCount.text=grdItemSelect.rows-1 + " item(s)."
}

//-----------------------------------------------------------------------------------------------
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
function OnSelectAll(oGrid)
{
   var arr_data = new Array();
   var control = oGrid.GetGridControl();
   
   var rows = control.Rows;
	
	if (control.SelectedRows >0)
	{
		for (i=0; i<control.SelectedRows; i++)
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
}
function On_UnAllcheck()
{
    if(checkAll.value=="Y")
    {
        for(var i=1;i<grdTOList.rows;i++)
         {
            grdTOList.SetGridText(i,7,-1);
         } 
     } 
     else
     {
       for(var i=1;i<grdTOList.rows;i++)
         {
            grdTOList.SetGridText(i,7,0);
         } 
     }
}
function OnDataReceive(dso){
   if(dso.id == "dsoTournamentList"){
	 lsttournamnet.value  =tournament; 
	  OnSearch();      
   }
      
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="dscd00051" onreceive=""> 
        <xml> 
            <dso id="1" type="grid" function="CRM.sp_sel_jabk0060_popupcheckin" > 
                <input> 
                    <inout bind="dtFrom" />  
                    <inout bind="dtTo" />  
                    <inout bind="txtName" />  
				    <inout bind="lstRankType" />
				    <inout bind="lsttournamnet" /> 
                </input> 
                <output bind="grdTOList" /> 
            </dso> 
        </xml> 
    </gw:data>
	<gw:data id="dsoTournamentList" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso type="list" procedure="crm.sp_sel_jabk00060_list" > 
				<input>
					 <input bind="dtDate" /> 
				</input> 
				<output> 
					<output bind="lsttournamnet"/>
				</output>
			</dso> 
		</xml> 
	</gw:data>
    <form>
        <table width="100%" cellpadding="0" cellspacing="0" border="1">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="right" style="width: 5%">
                                Date</td>
                            <td style="width: 15%">
                                <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch()" />
                                ~<gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch()" />
                            </td>
                            <td align='right' style="width: 10%">
                                Group No</td>
                            <td style="width: 9%">
                                <gw:textbox id="txtName" styles="width:100%" onenterkey='OnSearch()' />
                            </td>
                            <td align="right" style="width: 10%">Rank Type</td>
                            <td style="width: 15%">
                                <gw:list id="lstRankType" styles="width:100%;" />
                            </td>
                            <td style="width: 5%">
                                Tournament
                            </td>
                            <td align="right" style="width: 20%">
                                <gw:list id="lsttournamnet"  styles="width:100%;" />
                            </td>
                            <td align="right" style="width: 3%">
                                <gw:imgbtn img="search" alt="Search" id="btnSearch_1" onclick="OnSearch(1)" />
                            </td>
                            <td align="right" style="width: 3%">
                                <gw:imgbtn img="select" alt="Select All" id="Select_ALL" onclick="OnSelectAll(grdTOList)" />
                            </td>
                        </tr>
                        <tr >
                            <td colspan="11">
                                <gw:grid id='grdTOList' header='_PK|Group No|Locker#|Golfer Name|HDCP|Tee Time|Checkin Date|Type'
                                    format='0|0|0|0|0|0|4|0' aligns='0|1|1|0|0|1|0|0' defaults='|||||||' editcol='0|0|0|0|0|0|0|0'
                                    widths='1000|1200|1200|4200|1000|1200|1200|1500' sorting='T' styles='width:100%; height:360'
                                    onresize="true" oncelldblclick="OnGridCellDoubleClick(this)" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr >
                            <td style="width: 80%" align="center">
                                <gw:label id="txtCount" />
                            </td>
                            <td align="right" style="width: 10%">
                                <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                            </td>
                            <td align="right" style="width: 10%">
                                <gw:imgbtn img="select" alt="Select" id="Select" onclick="OnSelect(grdItemSelect)" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <gw:grid id='grdItemSelect' header='_PK|Group No|Locker#|Golfer Name|HDCP|Tee Time|Checkin Date|Type'
                                    format='0|0|0|0|0|0|4|0' aligns='0|1|1|0|0|1|0|0' defaults='|||||||' editcol='0|0|0|0|0|0|0|0'
                                    widths='1000|1200|1200|4200|1000|1200|1200|1500' sorting='T' styles='width:100%; height:160'
                                     />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
    <img status="expand" id="imgArrow" src="../../../system/images/up.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
		
    <gw:textbox id="txtTO_PK" maxlen="100" styles='width:100%;display:none' />
	<gw:datebox id="dtDate" style="display: none" />
</body>
</html>
