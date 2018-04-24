<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Monitering Display</title>
    
</head>
<%  ESysLib.SetUser("stm")%>

<script> 

//------------------------------------------------------------------------------ 
    
function BodyInit()
{
    getToDate();  
    grdView.GetGridControl().FrozenCols = 6;
    grdView.AddRow();
    grdView.AddRow();
    grdView.AddRow();
    grdView.AddRow();
    //SetHeader();
    dat_ippr0044.Call('SELECT');
    
}
//----------------------------------------------------------------------------- 
function OnDataReceive(obj)
{
    switch (obj.id)
    {          
        case 'dat_ippr0044':           
            SetHeader();
            setGridColor();
        break;             
    }
}
//-----------------------------------------------------------------------------
function LastDayOfMonth(Year, Month)
{
    return(new Date((new Date(Year, Month,1))-1)).getDate();
}
//-----------------------------------------------------------------------------
function getToDate()
{
    dtDate.value = System.AddDate(dtDate.value,-21);
    dtFrom.value = dtDate.value;
    var DayofCurMon, DayofNextMon, curDay, DaysAdded;
    DayofCurMon = LastDayOfMonth(Number(dtFrom.value.substring( 0, 4)),Number(dtFrom.value.substring( 4,6)));
    DayofNextMon = LastDayOfMonth(Number(dtFrom.value.substring( 0, 4)),Number(dtFrom.value.substring( 4,6))+1);
    curDay = dtFrom.value.substring( 6, 8);
    
    if(Number(curDay)>Number(DayofNextMon))
        DaysAdded = Number(DayofNextMon);
    else
        DaysAdded = Number(DayofCurMon);
    dtTo.value = System.AddDate(dtFrom.value,DaysAdded);
    dat_ippr0044.Call('SELECT');
}
//----------------------------------------------------------------------------
function getCDay(year, month, day)
{
    var d=new Date(year, month-1, day);
    var weekday=new Array(7);
    weekday[0]="Sun";
    weekday[1]="Mon";
    weekday[2]="Tue";
    weekday[3]="Wed";
    weekday[4]="Thu";
    weekday[5]="Fri";
    weekday[6]="Sat";
    
    return weekday[d.getDay()];    
}
//----------------------------------------------------------------------------
function SetHeader()
{
    var currentDay = Number(dtFrom.value.substring( 6,8));
    var dayOfMonth = LastDayOfMonth(Number(dtFrom.value.substring( 0, 4)),Number(dtFrom.value.substring( 4,6)));
    var curMonth = Number(dtFrom.value.substring( 4,6));
    var curYear = Number(dtFrom.value.substring( 0,4));
    var k = 6;
    
    var fg=grdView.GetGridControl();
    //fg.CellFontSize = 7;
        grdView.SetCellBold(0,0,2,38,true);
        fg.FixedRows = 4
        fg.MergeCells = 5
        
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 0, 0, 5) = ""
    fg.MergeCol(0) = true
    fg.Cell(0, 1, 0, 3, 0) = "Buyer/Vendor"   
    fg.MergeCol(1) = true
    fg.Cell(0, 1, 1, 3, 1) = "Style ID"  
    fg.MergeCol(2) = true
    fg.Cell(0, 1, 2, 3, 2) = "PO Number"   
        
    fg.MergeCol(3) = true
    fg.Cell(0, 1, 3, 3, 3) = "ETD"    
    fg.MergeCol(4) = true
    fg.Cell(0, 1, 4, 3, 4) = "Prev Prod"   
    fg.MergeCol(5) = true
    fg.Cell(0, 1, 5, 3, 5) = "Ord Qty." 
    for(i= Number(currentDay); i<= Number(dayOfMonth); i++)
    {     
        fg.MergeRow(1) = true
        fg.Cell(0, 1, k, 1, k) = i + "/" +curMonth ; 
        fg.Cell(0, 2, k, 2, k) = getCDay(curYear,curMonth,i) 
        if (getCDay(curYear,curMonth,i)=="Sun") 
        {
            grdView.SetCellFontColor(3,k,grdView.rows-1,k,0x000099);  
            fg.Cell(0, 3, k, 3, k) = "Ship"
        }
        k = k + 1;       
    }
    for(i= 1; i<= Number(currentDay); i++)
    {     
        curMonth = Number(dtTo.value.substring( 4,6));
        curYear = Number(dtTo.value.substring( 0,4));
        fg.MergeRow(1) = true
        fg.Cell(0, 1, k, 1, k) = i + "/" +(curMonth) ;  
        fg.Cell(0, 2, k, 2, k) = getCDay(curYear,curMonth,i)
        if (getCDay(curYear,curMonth,i)=="Sun") 
        {
            grdView.SetCellFontColor(3,k,grdView.rows-1,k,0x000099);  
            fg.Cell(0, 3, k, 3, k) = "Ship"
        }   
        k = k + 1;       
    }

    k=6;
    for(i=12; i<38; i=i+7)
    { 
        fg.MergeRow(0) = true;
        fg.Cell(0, 0, k, 0, i) = grdView.GetGridData(1,k) + " ~ " + grdView.GetGridData(1,i)
        k=k+7;
    }
    
    if(k<LastDayOfMonth(Number(dtTo.value.substring( 0, 4)),Number(dtTo.value.substring( 4,6))))
        fg.MergeRow(0) = true;
        fg.Cell(0, 0, k, 0, 37) = grdView.GetGridData(1,k) + " ~ " + grdView.GetGridData(1,LastDayOfMonth(Number(dtTo.value.substring( 0, 4)),Number(dtTo.value.substring( 4,6)))+6)
        
////    // Hide col
//    for(i=LastDayOfMonth(Number(dtTo.value.substring( 0, 4)),Number(dtTo.value.substring( 4,6)))+1; i<=31; i++)
//    {
//        grdView.GetGridControl().ColHidden(i+6) = true ;  
//    }
////    
    fg.MergeCol(37) = true;
    fg.Cell(0, 0, 37, 0, 37) = "";
    fg.Cell(0, 1, 37, 3, 37) = "Rate"  ;
    fg.MergeCol(38) = true;
    fg.Cell(0, 0, 38, 0, 38) = "";
    fg.Cell(0, 1, 38, 3, 38) = "Ord" ;
    
    grdView.MergeByCol(0);
    grdView.MergeByCol(1);
    grdView.MergeByCol(2);
    
}
//-----------------------------------------------------------------------------
function setGridColor()
{
    for(i=4; i<grdView.rows; i++)
    {
        //SetCellBgColor(row1, col1, row2, col2, color)
        if(grdView.GetGridData(i,38)=="1")
            grdView.SetCellBgColor(i,0,i,38, 0x9BF6D3);
    }
}
//----------------------------------------------------------------------------
function Loading()
{
    var fpath = System.RootURL + "/form/ip/pr/ippr0041.aspx"; 
    System.OpenModeless( fpath , 2000 ,  2000, 'resizable:yes;status:no;fullscreen:yes;titlebar:yes;location:yes');    
    window.close();
}
//-----------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="dat_ippr0044" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="stm" function="STM.sp_sel_po_bal_monthly"  > 
                <input> 
                    <input bind="dtDate" /> 
                </input> 
                <output bind="grdView" /> 
            </dso> 
        </xml> 
    </gw:data>    
    <!------------------------------------------------------------------->
    <table style="width: 100%; height: 100%;"border="1" >
        <tr style="height: 1%">
            <td colspan="11">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td colspan="17" style="width: 100%;">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 4%" nowrap>Date</td>
                                    <td style="width: 12%" nowrap><gw:datebox id="dtDate" lang="1"  styles='width:100%;' onchange="getToDate();"/></td>
                                    <td style="width: 10%" nowrap align="right"> </td>
                                    <td style="width: 10%">
                                        <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>"  />
                                    </td>
                                    <td style="width: 2%" align="center">
                                        <b>~</b>
                                    </td>
                                    <td style="width: 10%">
                                        <gw:datebox id="dtTo" lang="<%=Session("Lang")%>"  />
                                    </td>
                                    <td style="width: 40%" nowrap></td>
                                    <td style="width: 6%"></td>
                                    <td style="width: 10%"  align="right"><gw:icon id="idBtn" img="in" text="OPEN MONITERING" styles='width:100%' onclick="Loading()" /></td>
                                </tr>
                            </table>                        
                        </td>
                    </tr>                    
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 100%">&nbsp;</td>
        </tr>
        <tr  style="height: 98%">
            <td  style="width: 100%">
                <gw:grid id='grdView'
                    header='1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|_39'
                    format='0|0|0|4|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0'
                    aligns='0|2|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3'
                    defaults='|||||||||||||||||||||||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='1500|1500|1300|1200|1200|1200|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800'
                    sorting='F'
                    onafteredit=""
                    styles='width:100%; height:100%; font:6pt'
                />
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------->
</html>
