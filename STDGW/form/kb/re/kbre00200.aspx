<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Semi Prod Incoming</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<script>

//-----------------------------------------------------

var G_ITEM        = 0,
    G_NULL       = 1,
    G_PROD_QTY   = 2,
    G_RATIO      = 3,
    G_USE_MATERIAL = 4,
    G_BY_PROD       = 5,
    G_DEFECT        = 6,
    G_LOSS      = 7;
    
 //===============================================================================================
function BodyInit()
 {
    System.Translate(document);  // Translate to language session    

    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtConfirmFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtConfirmFrom.value=ldate ;   
    SetGridFormat();   
 }
 //==================================================================================
 
 function SetGridFormat()
 {    
   
     var ctr = grdPro.GetGridControl(); 
    
     ctr.ColFormat(G_PROD_QTY)     = "#,###,###,###,###,###.##"; 
     ctr.ColFormat(G_RATIO) = "#,###,###,###,###,###.##"; 
     ctr.ColFormat(G_USE_MATERIAL)     = "#,###,###,###,###,###.##"; 
     ctr.ColFormat(G_BY_PROD)     = "#,###,###,###,###,###.##";
     ctr.ColFormat(G_DEFECT)     = "#,###,###,###,###,###.##";  
     ctr.ColFormat(G_LOSS)     = "#,###,###,###,###,###.##";  
 }
//=============================================================================================
function OnSearch()
{
      data_kbre00200.Call("SELECT");
}
//=============================================================================================
function OnDataReceive(obj)
{
      
}

//=================================================================================

function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdPro" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G2_IN_UOM )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdPro.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 }
            break;             
      }         
}   
//=================================================================================
function OnReport()
{
    var url =System.RootURL + '/reports/kb/re/rpt_kbre00200.aspx?p_from_date='+ dtConfirmFrom.value;   
    url+= '&p_to_date='+ dtConfirmTo.value;
	window.open(url);
}


</script>
<body>
    
    <!------------------------------------------------------------------>
    <gw:data id="data_kbre00200" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid"  function="<%=l_user%>lg_sel_kbre00200"> 
                <input bind="grdPro">     
                    <input bind="dtConfirmFrom" />     
                    <input bind="dtConfirmTo" />  
                </input> 
                <output bind="grdPro" /> 
            </dso> 
        </xml> 
    </gw:data>
  
    <!-------------------------------------------------------------------->
   <table style="width: 100%; height: 100%">
        <tr>
            <td style="width: 5%; white-space: nowrap" align="right">
                Date
            </td>
            <td style="width: 20%; white-space: nowrap">
                <gw:datebox id="dtConfirmFrom" lang="1" mode="01" />
                ~
                <gw:datebox id="dtConfirmTo" lang="1" mode="01" />
            </td>
            <td style="width: 50%; text-align: center; white-space: nowrap">
              
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="excel" alt="Search" id="btnExcel" onclick="OnReport()" />
            </td>
            <td style="width: 1%">
              
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="11">
                <gw:grid id='grdPro'  header='Item Name|_|Prod Qty|Ratio(%)|Used Material|By Prod Qty|Defect Qty|Loss Qty'
                    format='0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0' check='|||||||' editcol='0|0|0|0|0|0|0|0'
                    widths='1500|1500|1500|1500|1500|1500|1500|1500' 
                    sorting='T' 
                    styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
</html>
