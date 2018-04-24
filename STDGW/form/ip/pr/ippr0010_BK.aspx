<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%  ESysLib.SetUser("stm")%>

<script>

var G1_PK               = 0 ,
    G1_Date             = 1 ,
    G1_Line             = 2 ,
    G1_TST_ORDERM_PK    = 3 ,
    G1_TST_ORDERD_PK    = 4 ,
    G1_THR_EMPLOYEE_PK  = 5 ,
    G1_Emp_ID           = 6 ,
    G1_Full_Name        = 7 ,  
    G1_TST_TASK_PK      = 8 ,
    G1_TST_DEFECT_PK    = 9 ,
    G1_Prod_Qty         = 10 ,
    G1_Defect_Qty       = 11 ,    
    G1_Adjust_Qty       = 12 ,
    G1_Description      = 13 ;
//---------------------------------------------

function BodyInit()
{
    BindingDataList();
    GridFormat();
}

//---------------------------------------------

function BindingDataList()
{    
    var data="";    
        
    data = "<%=ESysLib.SetGridColumnDataSQL(" SELECT   pk, line_name FROM stm.tst_line WHERE del_if = 0 ORDER BY line_name" ) %>";    
    grdProdResult.SetComboFormat(G1_Line,data);

}  

//---------------------------------------------------

function GridFormat()
{
      var ctrl = grdProdResult.GetGridControl();
      
      ctrl.ColFormat(G1_Prod_Qty )   = "###,###,###,###,###.##";
      ctrl.ColFormat(G1_Defect_Qty ) = "###,###,###,###,###.##";
      ctrl.ColFormat(G1_Adjust_Qty)  = "###,###,###,###,###.##";
}

//---------------------------------------------------

 function OnSearch(pos)
 {
    switch(pos)
    {
        case 'grdProdResult': //Search Master
            data_ippr0010.Call("SELECT");
        break;                      
    }
 }
 
//------------------------------------------------------------------- 

function OnNew(pos)
{  
	switch(pos)
	{
	    case 'grdProdResult':
	        grdProdResult.AddRow();
	        grdProdResult.SetGridText( grdProdResult.rows-1, G1_THR_EMPLOYEE_PK, "<%=Session("EMPLOYEE_PK")%>" );
	        grdProdResult.SetGridText( grdProdResult.rows-1, G1_Full_Name,       "<%=Session("USER_NAME")%>"   );
	        
	    break;    
	}	 
}

//---------------------------------------------------

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_ippr0010":
		break;

   }
}

//---------------------------------------------
 
var p_update = 0 ;

function OnSave()
{
     p_update = 1 ;
     
     data_ippr0010.Call();
}

//-------------------------------------------------------------------

function OnDelete(pos)
{
	switch(pos)
	{
	    case 'grdProdResult':
            if( grdProdResult.rows > 1 )
            { 
                if ( grdProdResult.GetGridData( grdProdResult.row, G1_PK ) == '' ) 
                {
                    grdProdResult.RemoveRow();
                }
                else
                {
                    grdProdResult.DeleteRow();
                }  
            }
        break;            	  
    }    
}
 
//---------------------------------------------------

function OnUnDelete(pos)
{
	switch(pos)
	{
	    case 'grdProdResult':
            grdProdResult.UnDeleteRow();
        break;          
    }    
}

//---------------------------------------------------      

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>POP : PRODUCTION RESULT ENTRY</title>
</head>
<body>
    <!---------------------------------------------------------->
    <gw:data id="data_ippr0010" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="sale" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="stm.sp_sel_ippr0010"  procedure="stm.sp_upd_ippr0010" > 
                <input> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" />
                </input> 
                <output bind="grdProdResult" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------->
    <form id="form1" runat="server">
        <table style="width: 100%; height: 100%">
            <tr style="height: 1%">
                <td>
                    <table style="height: 100%; width: 100%">
                        <tr>
                            <td style="width: 10%" align="right">
                                Date
                            </td>
                            <td style="width: 35%" align="left">
                                <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" />
                                ~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" />
                            </td>
                            <td style="width: 50%">
                            </td>
                            <td style="width: 1%">
                                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('grdProdResult')" />
                            </td>
                            <td style="width: 1%" align="right">
                                <gw:imgbtn img="new" alt="New" id="btnAdd" onclick="OnNew('grdProdResult')" />
                            </td>
                            <td style="width: 1%" align="right">
                                <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('grdProdResult')" />
                            </td>
                            <td style="width: 1%" align="right">
                                <gw:imgbtn img="udelete" alt="Undelete" id="btnUnDelete" onclick="OnUndelete('grdProdResult')" />
                            </td>
                            <td style="width: 1%">
                                <gw:imgbtn img="save" alt="Save" id="btnUpdate" onclick="OnSave()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 99%">
                <td>
                    <gw:grid id='grdProdResult' header='_PK|Date|Line|_TST_ORDERM_PK|_TST_ORDERD_PK|_THR_EMPLOYEE_PK|Emp ID|Full Name|_TST_TASK_PK|_TST_DEFECT_PK|Prod Qty|Defect Qty|Adjust Qty|Description'
                        format='0|4|0|0|0|0|0|0|0|0|0|0|0|0' 
                        aligns='0|1|0|0|0|0|0|0|0|0|3|3|3|0' defaults='|||||||||||||'
                        editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1200|2000|1000|1000|1000|1500|2500|1000|1000|1500|1500|1500|1000'
                        sorting='T' styles='width:100%; height:100%' />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
