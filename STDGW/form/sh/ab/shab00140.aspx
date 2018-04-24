<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Colorant Pack</title>
</head>

<script>

 //---------------------------------------------------------
 function BodyInit()
 {
     txtColor.text ="<%=Request.QueryString("color")%>";
     FormatGrid();
     OnSearch('LotNo');
 }
 
 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
            case 'LotNo' :
                shab00140.Call("SELECT");
            break;     
      }  
 }
//---------------------------------------------------------
function FormatGrid()
 {
      var trl ;
     
      trl = grdLotNo.GetGridControl();
      trl.ColFormat(1 )     = "###,###,###,###,##0.##0";
 }
//----------------------------------------------------------
function BindingDataList()
 {    
                   
 }
//------------------------------------------------------------------------------------	
function OnSelect()
{
    
    var code_data = new Array();       
    
    if ( grdLotNo.row > 0 )
    {
        for( j=0 ; j<grdLotNo.cols ; j++ )
        {
            code_data[j] = grdLotNo.GetGridData(grdLotNo.row , j );
        } 
    }
    else
    {
        for( j=0 ; j<grdLotNo.cols ; j++ )
        {
            code_data[j] = '';
        } 	    
    }
    //----------------------------
    window.returnValue = code_data; 
    this.close(); 	
}
//------------------------------------------------------------------------------	
function EXITOnClick()
{
	OnSelect();
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shab00140"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shab00140_1"> 
                <input bind="grdLotNo" > 
                    <input bind="txtColor" /> 
                </input> 
                <output bind="grdLotNo" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 10%" align="right">
                <b>Color</b>
            </td>
            <td style="width: 40%" align="right">
                <gw:textbox id="txtColor" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('LotNo')" />
            </td>
            <td style="width: 45%" align="right">
            </td>
            <td style="width: 1%" align="right">
                
            </td>
            <td style="width: 1%" align="right">
            </td>
            <td style="width: 1%" align="right">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="New" id="btnSearch" onclick="OnSearch('grdLotNo')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="select" alt="Select" id="btnSelect" onclick="OnSelect()" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="10">
                <gw:grid id='grdLotNo' header='Batch No|Inv Qty.'
                    format='0|0' aligns='0|3' defaults='|' editcol='0|0'
                    widths='2500|1500' sorting='T' styles='width:100%; height:100%' oncelldblclick="OnSelect()" />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
</html>
