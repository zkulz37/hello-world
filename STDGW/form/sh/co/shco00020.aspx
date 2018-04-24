<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Hard-Years Product Planning(Dip-GEL)</title>
</head>
<%  ESysLib.SetUser("sale")
  
%>

<script>
var  l_pk =0,
     l_yymm    =1,
     l_mon     = 2,
      l_S00   = 3, 
      l_SE0   = 4, 
      l_S0    = 5, 
      l_S1    = 6, 
      l_S2    = 7, 
      l_S3    = 8, 
      l_S4    = 9, 
      l_S8    = 10, 
      l_S9    = 11, 
      l_S10   = 12, 
      l_col_total = 13,
      l_MAC_DAY = 14;
    
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    OnSearch()
}
//-----------------------------------------------------------------------------------------------
function OnSearch(obj)
{ 
   data_shco00020.Call('SELECT')
   
}
//-----------------------------------------------------------------------------------------------
function OnSave()
{
    for (var i = 1; i< idGrid.rows-1 ; i++)
    {
        if(idGrid.GetGridData(i,l_pk) =="")
        {
            idGrid.SetRowStatus(i,48);
        }
    }
	 data_shco00020.Call()
}

//======================================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shco00020':
            idGrid.Subtotal( 0, 2, -1, '3!4!5!6!7!8!9!10!11!12!13!14','###,###,##0');  
        break;
    }
}
//================================================================================================
function CalTotal()
{
   var v_row = event.row;
   var v_total = 0;
   for(var i =3 ; i< l_col_total; i ++ )
   {
     if(isNaN(idGrid.GetGridData(v_row,i)+"") == false )
     {
        v_total = v_total + Number(idGrid.GetGridData(v_row,i))
     }
   }
   idGrid.SetGridText(v_row,l_col_total,v_total )
   idGrid.Subtotal( 0, 2, -1, '3!4!5!6!7!8!9!10!11!12!13!14','###,###,##0'); 
}
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_shco00020" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="SALE.sp_sel_shco00020" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" procedure = "sale.sp_upd_shco00020" > 
                  <input bind="idGrid" > 
                    <input bind="dtYear" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%" >
        <tr style="height: 5%">
            <td style="width: 10%" align="right">
                Year
            </td>
            <td style="width: 30%">
                <gw:datebox id="dtYear" lang="1" styles="width:100%" type='year' onclick="OnSearch()" />
            </td>
            <td style="width: 50%" align="right">
                
            </td>
           <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSave" img="save" alt="Search" onclick="OnSave()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 95%">
            <td colspan="5">
                <gw:grid id='idGrid'
                header='_PK|_YM|MON|#00|#E0|#0|#1|#2|#3|#4|_#8|_#9|_#10|TOTAL|MACHINE SPEED'
                format='0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-2'
                aligns='0|0|2|0|0|0|0|0|0|0|0|0|0|0|0'
                editcol='0|0|0|1|1|1|1|1|1|1|1|1|1|0|1'
                widths='0|0|500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500'
                sorting='T'                
                styles='width:100%; height:100%'
                onafteredit = 'CalTotal()'
                />
               
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
</html>
