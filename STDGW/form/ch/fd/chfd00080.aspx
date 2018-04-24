<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
function BodyInit()
{
    
    idGrid.GetGridControl().rows=idGrid.GetGridControl().rows+1;
    idGrid.GetGridControl().FixedRows = 2;
    idGrid.GetGridControl().FixCols=1;
    idGrid.GetGridControl().MergeCells =5	;
    idGrid.GetGridControl().MergeCol(0)=true;
    idGrid.GetGridControl().Cell(0,1,0,1,0)="Type";   //.Cell(0,row, from_col, row, to_col)	
    idGrid.GetGridControl().Cell(0,1,1,1,1)="Take-in Data";
    idGrid.GetGridControl().Cell(0,1,2,1,2)="Spec";
    idGrid.GetGridControl().Cell(0,1,3,1,3)="Attach";
    idGrid.GetGridControl().Cell(0,1,4,1,4)="Take-in Qty";
    idGrid.GetGridControl().Cell(0,1,5,1,5)="Amount";
    idGrid.GetGridControl().Cell(0,1,6,1,6)="Delivery Location";
    idGrid.GetGridControl().Cell(0,1,7,1,7)="Remark";
    
    idGrid.SetCellBold(1,0,1,7,true);
    
    var i=0;
    for(i=0;i<10;i++)
        idGrid.AddRow();
    //idGrid.GetGridControl().Cell(0,4,0,4,0)="Condolences";   //.Cell(0,row, from_col, row, to_col)	
    /**/
}

</script>
<body >
<!-------------------data control----------------------->
    
<table style="width:100%; height:10%">
    <tr>
        <td style="width:10%" align="center">Type</td>
        <td style="width:10%">
            <gw:list  id="lstType" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeDept()">
                <data>|ALL|ALL</data>
            </gw:list>
        </td>
        <td style="width:10%" align="center">Period</td>
        <td style="width:15%" colspan="2">
        <gw:datebox id="dtFrom" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/>
        ~<gw:datebox id="dtTo" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/></td>
        <td style="width:10%" align="center">Status</td>
        <td style="width:10%">
            <gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeDept()">
                <data>|ALL|ALL</data>
            </gw:list>
        </td>             
        <td style="width:10%"  align="center"><gw:icon id="idBtnInquiry" img="in" text="Inquiry" onclick="" />                        </td>
    </tr>
</table>

<table style="width:100%; height:90%">
    <tr style="height:85%">
        <td colspan=8>
            <gw:grid
					    id="idGrid"
					    header="Type|Applied Date|Item|Unit|Requested Qty|Unit|Purpose|Status"
					    format="0|0|0|0|0|0|0|0"
					    aligns="0|1|1|1|1|1|1|1"
					    defaults="||||||||"
					    editcol="0|0|0|0|0|0|0|0"
					    widths="1500|2000|2000|1500|2000|1500|2000|2000"
					    styles="width:100%;height:100%"
					    sorting="F"
					    onafteredit=""
					    oncellclick = ""
					    acceptNullDate="T"
					    oncelldblclick = ""/>
        </td>
    </tr>
    
</table>
<!----------------------------------->

</body>
</html>


