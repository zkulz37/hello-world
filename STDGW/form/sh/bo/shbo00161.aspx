<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Additive Solution Preparation Instruction and Record</title>
</head>
<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_code  = "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ; 
    
var G1_batch_qty    = 4;
 //---------------------------------------------------------
 function BodyInit()
 {
     FormatGrid();
     dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
     OnSearch('List');
 }

 //---------------------------------------------------------
 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'List':
            shbo00161.Call("SELECT");
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
     
      trl = grdBatch.GetGridControl();
      	
      trl.ColFormat(G1_batch_qty )   = "###,###,###,###,##0.##0";
 }
//======================================================================
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
//---------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00161"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shbo00161" > 
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
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 100%" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 30%;white-space:nowrap" align="right">
                            <b>Batch No.</b>
                        </td>
                        <td style="width: 69%" >
                            <gw:textbox id="txtBatch" styles='width:70%' onenterkey="OnSearch('List')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('List')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="select" alt="Search" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" >
                            <b>Date</b>
                        </td>
                        <td  colspan=3>
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" onchange="OnSearch('List')" />
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" onchange="OnSearch('List')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="4">
                            <gw:grid id='grdBatch'
                                header='_pk|Date|Batch No|Tank No|Batch Qty'
                                format='0|4|0|0|0' aligns='0|0|0|0|3' defaults='||||' editcol='0|0|0|0|0'
                                widths='0|1200|1500|2000|1500' sorting='T' styles='width:100%; height:100%'
                                oncelldblclick="OnSelect()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
