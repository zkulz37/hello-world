<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Additive Solution Preparation Instruction and Record</title>
</head>
<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_code  = "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ; 
  
 //---------------------------------------------------------
 function BodyInit()
 {
 }
 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'List':
            shab00090.Call("SELECT");
        break;
    }
 }
 //---------------------------------------------------------
 function OnReceiveData(obj)
{
    switch(obj.id)
    {
        
    }
}
 
//---------------------------------------------------------
function FormatGrid()
 {
      var trl ;
     
      trl = grdDetail.GetGridControl();
      	
      trl.ColFormat(G1_use_ratio )     = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_inst_qty )      = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_min_value )     = "###,###,###,###,##0.##0";
      trl.ColFormat(G1_max_value )     = "###,###,###,###,##0.##0";
      
 }
 //===============================================================
function OnSelect()
{
    
    var code_data = new Array();       
    
    if ( grdBatch.row > 0 )
    {
        for( j=0 ; j<grdBatch.cols ; j++ )
        {
            code_data[j] = grdBatch.GetGridData(grdBatch.row , j );
        } 
    }
    else
    {
        for( j=0 ; j<grdBatch.cols ; j++ )
        {
            code_data[j] = '';
        } 	    
    }
    //----------------------------
    window.returnValue = code_data; 
    this.close(); 	
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shab00090"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shab00090" > 
                <input> 
                    <input bind="txtBatch" /> 
                    <input bind="dtFromDate" /> 
                    <input bind="dtToDate" /> 
                </input> 
                <output bind="grdBatch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 15%;white-space:nowrap" align="right">
                <b>Batch No.</b>
            </td>
            <td style="width: 20%" align="right">
                <gw:textbox id="txtBatch" styles='width:100%' onenterkey="OnSearch('List')" />
            </td>
            <td style="width: 20%" align="right" >
                <b>Date</b>
            </td>
            <td style="width: 30%" >
                <gw:datebox id="dtFromDate" lang="1" styles="width:100%" />
                ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" />
            </td>
            <td style="width: 13%" align="right">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('List')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="select" alt="Select" id="btnSelect" onclick="OnSelect()" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="7">
                <gw:grid id='grdBatch'
                    header='_pk|Date|Batch No|Batch Desc|Tr.OP|Tr. OP Name|Inst Total|Min Total|Max Total'
                    format='0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|3|3|3' defaults='||||||||' editcol='0|0|0|0|0|0|0|0|0'
                    widths='0|1200|1300|2500|1000|1500|1100|1100|1100' sorting='T' styles='width:100%; height:100%'
                    oncelldblclick="OnSelect()"
                  />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
 <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtTypePK" styles="width: 100%;display:none" />
<gw:textbox id="txtChargerPK" styles="width: 100%;display:none" />
</html>
