<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Item</title>
</head>
<%  ESysLib.SetUser("stm")
%>

<script>

var G1_tst_orderm_pk       = 0 ;
var G1_tst_orderd_pk       = 7 ;
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //------------------------------------
    var line_pk   = "<%=request.QueryString("line_pk") %>"  ;
    var prod_date = "<%=request.QueryString("prod_date") %>"  ;
    //------------------------------------
    txtLinePK.text   = line_pk ;
    txtProdDate.text = prod_date ;
    OnSearch()
}
 
//-----------------------------------------------------------------------------------------------
function OnSearch()
{    
    ipwi0032.Call('SELECT');
}
//-----------------------------------------------------------------------------------------------
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   if(oGrid.rows > 1)
   {   
      for(var i=1;i<oGrid.rows;i++)
      {
        if(oGrid.GetGridData(i,0)==-1)
        {
             var arrTemp=new Array();
             arrTemp[0]= oGrid.GetGridData(i,1); //line pk
             arrTemp[1]= txtQuantity.text; //daily
             arrTemp[2]= dtFromDate.value; //fr
             arrTemp[3]= dtToDate.value; //to
             
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
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}
function OnReceiveData(obj)
{    
}
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="ipwi0032" onreceive="OnReceiveData(this)"> 
        <xml> 
           <dso id="1" type="grid" function="stm.sp_sel_ipwi0031" > 
                  <input> 
                  </input> 
                <output bind="grdLine" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
        <tr style="height: 5%">
            <td width="100%">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="right" style="width: 10%">
                            <b>Set Date</b>
                        </td>
                        <td style="width:12%" align="left">
                            <gw:datebox id="dtFromDate" lang="1" />
                         </td>
                         <td style="width:15%" align="left">
                            ~<gw:datebox id="dtToDate" lang="1" />
                         </td>
                         <td style="width:15%" align="right">
                            <gw:icon id="id" img="in" text="OK" styles='width:50%' onclick="OnSelect(grdLine)" />
                         </td>
                       </tr>
                       <tr>
                         <td width="10%" align="right" nowrap>
                            <b>Daily Target</b>
                         </td>
                         <td width="20%" colspan="2">
                            <gw:textbox id="txtQuantity" styles="width:100%" type="number"  format="###,###.###"/>
                         </td>
                         <td align="right">
                            
                         </td>
                     </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 45%">
            <td colspan="13">
               <gw:grid id='grdLine'
                header='Select|_PK|Line Type|Line Id|Line Name|Line Cap|Description'
                format='3|0|0|0|0|1|0'
                aligns='0|0|0|0|0|0|0'
                defaults='||||||'
                editcol='1|1|1|1|1|1|1'
                widths='800|0|1500|1500|1500|1500|2000'
                sorting='T'
                styles='width:100%; height:100%'
                />
            </td>
        </tr>
  
    </table>
    <!---------------------------------------------------------------->
    <gw:textbox id="txtLinePK" styles="display: none" />
    <gw:textbox id="txtProdDate" styles="display: none" />
    <!---------------------------------------------------------------->
</body>
</html>
