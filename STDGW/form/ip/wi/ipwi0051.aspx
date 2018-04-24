<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Line</title>
</head>
<%  ESysLib.SetUser("stm")
%>

<script>

//------------------------------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //------------------------------------
    var WI_BAL_QTY    = "<%=request.QueryString("WI_BAL_QTY") %>"  ;
    
    txtWIBalance.text = WI_BAL_QTY;
    //------------------------------------
    
    OnSearch();
}
 
//-----------------------------------------------------------------------------------------------
function OnSearch()
{    
    ipwi0051.Call('SELECT');
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
             arrTemp[1]= txtWIBalance.text;      //balance
             arrTemp[2]= dtWorkDate.value;       //fr
             
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

function OnReceiveData(obj)
{    
}
//------------------------------------------------------------------------------------------------

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="ipwi0051" onreceive="OnReceiveData(this)"> 
        <xml> 
           <dso id="1" type="grid" function="stm.sp_sel_ipwi0051" > 
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
                        <td style="width: 12%" align="left">
                            <gw:datebox id="dtWorkDate" lang="1" />
                        </td>
                        <td style="width: 15%" align="left">
                        </td>
                        <td style="width: 15%" align="right">
                            <gw:icon id="id" img="in" text="OK" styles='width:50%' onclick="OnSelect(grdLine)" />
                        </td>
                    </tr>
                    <tr>
                        <td width="10%" align="right" nowrap>
                            <b>WI Bal</b>
                        </td>
                        <td width="20%" colspan="2">
                            <gw:textbox id="txtWIBalance" styles="width:100%" type="number" format="###,###,###" />
                        </td>
                        <td align="right">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 45%">
            <td colspan="13">
                <gw:grid id='grdLine' header='Select|_PK|Line Type|Line Id|Line Name|Line Cap|Description'
                    format='3|0|0|0|0|1|0' aligns='0|0|0|0|0|0|0' defaults='||||||' editcol='0|0|0|0|0|0|0'
                    widths='800|0|1500|1500|1500|1500|2000' sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
</html>
