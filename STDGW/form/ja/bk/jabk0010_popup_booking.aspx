<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("crm")%>
<head>
    <title>POP UP GET ITEM FROM BOOKING</title>
</head>

<script>
 
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
	grdItemSelect.SetComboFormat(16,'|#9;9|#18;18|#27;27|#36;36'); 
	grdTOList.SetComboFormat(16,'|#9;9|#18;18|#27;27|#36;36'); 
	OnSearch(1);
 } 

//-------------------------------------------------------------------------------------------

 //---------------------------------------------------------
 function SetStatus(pos)
 {
      switch (pos)         
      {		        
        case 1 :
            btnUnDeleteDetail.SetEnable(false);
            btnDeleteDetail.SetEnable(false);
            txtBillToCode.SetEnable(false);
            txtBillToName.SetEnable(false);
            txtDeliToCode.SetEnable(false);
            txtDeliToName.SetEnable(false);
            txtDeliLoc.SetEnable(false);
            txtEmpCode.SetEnable(false);
            txtEmpName.SetEnable(false);
        break;
      }  
 } 

 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
        case 1 :
            dscd00051.Call("SELECT");
        break;
        /*case 2 :         
            if ( grdTOList.row > 0 )
            {
                txtTO_PK.text = grdTOList.GetGridData(grdTOList.row,0);
                dscd00051_1.Call("SELECT");
            } 
            else
            {
                alert('Pls Select 1 Request !!!');
            }                     
        break; */         
      }  
 }

 //---------------------------------------------------------
 
 //---------------------------------------------------------
 function OnDataReceive(po_oData)
 {
 
      switch (po_oData.id)         
      {
        case "dscd00051" :
        
            txtTO_PK.text = '' ;
            //dscd00051_1.Call('SELECT');
            
        break;
      }  
 }
 
 //---------------------------------------------------------
 
 //---------------------------------------------------------


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
      if(p_oGrid.GetGridData(i,5) == p_value)
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
            
                var col_val = oGrid.GetGridData(event.row,5);
                
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

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="dscd00051" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="CRM.sp_sel_jabk0010_booking" > 
                <input> 
                    <input bind="txtTO_No" /> 
                    <input bind="dtFromDate" /> 
                    <input bind="dtToDate" />  
                </input> 
                <output bind="grdTOList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <!--<gw:data id="dscd00051_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="prod"  parameter="0" function="CRM.sp_sel_jarc0010_popupbooking" > 
                <input> 
                    <input bind="txtTO_PK" /> 
                </input> 
                <output bind="grdItemList" /> 
            </dso> 
        </xml> 
    </gw:data>-->
    <!------------------------------------------------------------------>
    <!------------------------------------------------------------------>
    <!------------------------------------------------------------------>
    <form id="form1" runat="server">
        <table width="100%" cellpadding="0" cellspacing="0" border="1">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="right" style="width: 8%">
                                Customer</td>
                            <td style="width: 20%">
                                <gw:textbox id="txtTO_No" styles='width:100%' csstype="mandatory" onenterkey="OnSearch(1)" />
                            </td>
                            <td align='right' style="width: 10%">
                                Booking Date</td>
                            <td style="width: 15%">
                                <gw:datebox id="dtFromDate" lang="1" onchange="OnSearch(1)" />
                            </td>
                            <td style="width: 15%">
                                <gw:datebox id="dtToDate" lang="1" onchange="OnSearch(1)" />
                            </td>
                            <td style="width: 5%">
                            </td>
                            <td align="right" style="width: 5%">
                                <gw:imgbtn img="search" alt="Search" id="btnSearch_1" onclick="OnSearch(1)" />
                            </td>
                        </tr>
                        <tr id='top'>
                            <td colspan="7">
                                <gw:grid id='grdTOList' header='_PK|_member_PK|Member No|_TCM_MEMBER_TYPE_PK|Contact Person|Player Name|_Passport|_Gender|Phone|_Email|Company|_Company Tel|_Tax Code|_Address|_Photo_PK|_No_guest|Holes|Book DT|Time|_golf_type|_tcm_booking_golfer_pk|START_HOLE|BOOK_CART_YN'
                                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|3' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' autosize="T"
                                    defaults='||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                    sorting='T' styles='width:100%;height:360' 
                                    oncelldblclick="OnGridCellDoubleClick(this)" />  
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
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
                                <gw:grid id='grdItemSelect' header='_PK|_booking_gofer_PK|Member No|_TCM_MEMBER_TYPE_PK|_Full Name|Player Name|_Member_pk|_Gender|Phone|_Email|Company|_Company Tel|_Tax Code|_Address|_Photo_PK|_No_guest|Holes|Book DT|Time|_golf_type|_tcm_booking_golfer_pk|START_HOLE|BOOK_CART_YN'
                                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|3' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' autosize="T"
                                    defaults='||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                    sorting='T' styles='width:100%; height:163'
                                    oncelldblclick="OnGridCellDoubleClick(this)" />
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
</body>
</html>
