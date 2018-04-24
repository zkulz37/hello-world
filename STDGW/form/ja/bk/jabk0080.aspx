<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Golf Club Daily Revenue Report</title>
    <%  ESysLib.SetUser("crm")%>
</head>

<script>
function BodyInit()
{
// dtTo.SetDataText(System.AddDate(dtFrom.GetData(),15));
  SetGridHeader();
  dso_jabk0080.Call("SELECT");
}
function SetGridHeader()
{
  if(grdInquiry.rows == 1)
	{
		grdInquiry.AddRow();
	}
  var fg=grdInquiry.GetGridControl();
		fg.FixedRows  = 2
		fg.MergeCells = 3
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 1, 0, 3) = "1"  
		fg.Cell(0, 0, 4, 0, 6) = "2"
		fg.Cell(0, 0, 7, 0, 9) = "3"  
		fg.Cell(0, 0, 10, 0, 12) = "4"
		fg.Cell(0, 0, 13, 0, 15) = "5"  
		fg.Cell(0, 0, 16, 0, 18) = "6"
		fg.Cell(0, 0, 19, 0, 21) = "7"  
		fg.Cell(0, 0, 22, 0, 24) = "8"
		fg.Cell(0, 0, 25, 0, 27) = "9"  
		fg.Cell(0, 0, 28, 0, 30) = "10"
		fg.Cell(0, 0, 31, 0, 33) = "11"  
		fg.Cell(0, 0, 34, 0, 36) = "12"
		fg.Cell(0, 0, 37, 0, 39) = "13"  
		fg.Cell(0, 0, 40, 0, 42) = "14"
		fg.Cell(0, 0, 43, 0, 45) = "15"  
		fg.Cell(0, 0, 46, 0, 48) = "16"
		fg.Cell(0, 0, 49, 0, 51) = "17"  
		fg.Cell(0, 0, 52, 0, 54) = "18"
		fg.Cell(0, 0, 55, 0, 57) = "19"  
		fg.Cell(0, 0, 58, 0, 60) = "20"
		fg.Cell(0, 0, 61, 0, 63) = "21"  
		fg.Cell(0, 0, 64, 0, 66) = "22"
		fg.Cell(0, 0, 67, 0, 69) = "23"  
		fg.Cell(0, 0, 70, 0, 72) = "24"
		fg.Cell(0, 0, 73, 0, 75) = "25"  
		fg.Cell(0, 0, 76, 0, 78) = "26"
		fg.Cell(0, 0, 79, 0, 81) = "27"  
		fg.Cell(0, 0, 82, 0, 84) = "28"
		fg.Cell(0, 0, 85, 0, 87) = "29"  
		fg.Cell(0, 0, 88, 0, 90) = "30"
		fg.Cell(0, 0, 91, 0, 93) = "31"  
		
		
		
		fg.Cell(0, 1, 1, 1) 	= "Morning"
		fg.Cell(0, 1, 2, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 3, 1) 	= "Total"
		fg.Cell(0, 1, 4, 1) 	= "Morning"
		fg.Cell(0, 1, 5, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 6, 1) 	= "Total"
		fg.Cell(0, 1, 7, 1) 	= "Morning"
		fg.Cell(0, 1, 8, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 9, 1) 	= "Total"
		fg.Cell(0, 1, 10, 1) 	= "Morning"
		fg.Cell(0, 1, 11, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 12, 1) 	= "Total"
		fg.Cell(0, 1, 13, 1) 	= "Morning"
		fg.Cell(0, 1, 14, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 15, 1) 	= "Total"
		fg.Cell(0, 1, 16, 1) 	= "Morning"
		fg.Cell(0, 1, 17, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 18, 1) 	= "Total"
		fg.Cell(0, 1, 19, 1) 	= "Morning"
		fg.Cell(0, 1, 20, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 21, 1) 	= "Total"
		fg.Cell(0, 1, 22, 1) 	= "Morning"
		fg.Cell(0, 1, 23, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 24, 1) 	= "Total"
		fg.Cell(0, 1, 25, 1) 	= "Morning"
		fg.Cell(0, 1, 26, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 27, 1) 	= "Total"
		fg.Cell(0, 1, 28, 1) 	= "Morning"
		fg.Cell(0, 1, 29, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 30, 1) 	= "Total"
		fg.Cell(0, 1, 31, 1) 	= "Morning"
		fg.Cell(0, 1, 32, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 33, 1) 	= "Total"
		fg.Cell(0, 1, 34, 1) 	= "Morning"
		fg.Cell(0, 1, 35, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 36, 1) 	= "Total"
		fg.Cell(0, 1, 37, 1) 	= "Morning"
		fg.Cell(0, 1, 38, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 39, 1) 	= "Total"
		fg.Cell(0, 1, 40, 1) 	= "Morning"
		fg.Cell(0, 1, 41, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 42, 1) 	= "Total"
		fg.Cell(0, 1, 43, 1) 	= "Morning"
		fg.Cell(0, 1, 44, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 45, 1) 	= "Total"
		fg.Cell(0, 1, 46, 1) 	= "Morning"
		fg.Cell(0, 1, 47, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 48, 1) 	= "Total"
		fg.Cell(0, 1, 49, 1) 	= "Morning"
		fg.Cell(0, 1, 50, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 51, 1) 	= "Total"
		fg.Cell(0, 1, 52, 1) 	= "Morning"
		fg.Cell(0, 1, 53, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 54, 1) 	= "Total"
		fg.Cell(0, 1, 55, 1) 	= "Morning"
		fg.Cell(0, 1, 56, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 57, 1) 	= "Total"
		fg.Cell(0, 1, 58, 1) 	= "Morning"
		fg.Cell(0, 1, 59, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 60, 1) 	= "Total"
		fg.Cell(0, 1, 61, 1) 	= "Morning"
		fg.Cell(0, 1, 62, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 63, 1) 	= "Total"
		fg.Cell(0, 1, 64, 1) 	= "Morning"
		fg.Cell(0, 1, 65, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 66, 1) 	= "Total"
		fg.Cell(0, 1, 67, 1) 	= "Morning"
		fg.Cell(0, 1, 68, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 69, 1) 	= "Total"
		fg.Cell(0, 1, 70, 1) 	= "Morning"
		fg.Cell(0, 1, 71, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 72, 1) 	= "Total"
		fg.Cell(0, 1, 73, 1) 	= "Morning"
		fg.Cell(0, 1, 74, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 75, 1) 	= "Total"
		fg.Cell(0, 1, 76, 1) 	= "Morning"
		fg.Cell(0, 1, 77, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 78, 1) 	= "Total"
		fg.Cell(0, 1, 79, 1) 	= "Morning"
		fg.Cell(0, 1, 80, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 81, 1) 	= "Total"
		fg.Cell(0, 1, 82, 1) 	= "Morning"
		fg.Cell(0, 1, 83, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 84, 1) 	= "Total"
		fg.Cell(0, 1, 85, 1) 	= "Morning"
		fg.Cell(0, 1, 86, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 87, 1) 	= "Total"
		fg.Cell(0, 1, 88, 1) 	= "Morning"
		fg.Cell(0, 1, 89, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 90, 1) 	= "Total"
		fg.Cell(0, 1, 91, 1) 	= "Morning"
		fg.Cell(0, 1, 92, 1 ) 	= "Afternoon"
		fg.Cell(0, 1, 93, 1 ) 	= "Total"
		
		
		fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = ""
	
	
  
    //size of Inquiry grid
    fg.ColWidth(0)=1400;

    fg.ColWidth(1)=750; 
    fg.ColWidth(2)=930;  
    fg.ColWidth(3)=750;
	
    fg.ColWidth(4)=750; 
    fg.ColWidth(5)=930;  
    fg.ColWidth(6)=750;
	
    fg.ColWidth(7)=750; 
    fg.ColWidth(8)=930; 
    fg.ColWidth(9)=750;
	
    fg.ColWidth(10)=750; 
    fg.ColWidth(11)=930; 
    fg.ColWidth(12)=750;
	
    fg.ColWidth(13)=750; 
    fg.ColWidth(14)=930;  
    fg.ColWidth(15)=750;
	
    fg.ColWidth(16)=750; 
    fg.ColWidth(17)=930; 
    fg.ColWidth(18)=750;
	
    fg.ColWidth(19)=750;   
	fg.ColWidth(20)=930; 
    fg.ColWidth(21)=750;
	
    fg.ColWidth(22)=750; 
    fg.ColWidth(23)=930; 
    fg.ColWidth(24)=750; 
	
	fg.ColWidth(25)=750;
    fg.ColWidth(26)=930; 
    fg.ColWidth(27)=750; 
	
    fg.ColWidth(28)=750; 
    fg.ColWidth(29)=930; 
    fg.ColWidth(30)=750; 
	
    fg.ColWidth(31)=750; 
    fg.ColWidth(32)=930; 
    fg.ColWidth(33)=750; 

    fg.ColWidth(34)=750; 
    fg.ColWidth(35)=930; 
    fg.ColWidth(36)=750;
	
    fg.ColWidth(37)=750; 
    fg.ColWidth(38)=930; 
    fg.ColWidth(39)=750;  

	fg.ColWidth(40)=750;  
    fg.ColWidth(41)=930; 
    fg.ColWidth(42)=750;
	
    fg.ColWidth(43)=750; 
    fg.ColWidth(44)=930; 
    fg.ColWidth(45)=750; 

    fg.ColWidth(46)=750; 
    fg.ColWidth(47)=930; 
    fg.ColWidth(48)=750; 

    fg.ColWidth(49)=750; 
	fg.ColWidth(50)=930;  
    fg.ColWidth(51)=750; 

    fg.ColWidth(52)=750; 
    fg.ColWidth(53)=930; 
    fg.ColWidth(54)=750; 

    fg.ColWidth(55)=750; 
    fg.ColWidth(56)=930; 
    fg.ColWidth(57)=750;
	
    fg.ColWidth(58)=750; 
    fg.ColWidth(59)=930; 
	fg.ColWidth(60)=750; 
	
    fg.ColWidth(61)=750; 
    fg.ColWidth(62)=930; 
    fg.ColWidth(63)=750; 

    fg.ColWidth(64)=750; 
    fg.ColWidth(65)=930; 
    fg.ColWidth(66)=750; 

    fg.ColWidth(67)=750; 
    fg.ColWidth(68)=930; 
    fg.ColWidth(69)=750; 

	fg.ColWidth(70)=750;  
    fg.ColWidth(31)=930; 
    fg.ColWidth(72)=750; 

    fg.ColWidth(73)=750; 
    fg.ColWidth(74)=930; 
    fg.ColWidth(75)=750;
	
    fg.ColWidth(76)=750; 
    fg.ColWidth(77)=930; 
    fg.ColWidth(78)=750; 

    fg.ColWidth(79)=750; 
	fg.ColWidth(80)=930;  
    fg.ColWidth(81)=750;
	
    fg.ColWidth(82)=750; 
    fg.ColWidth(83)=930; 
    fg.ColWidth(84)=750; 

    fg.ColWidth(85)=750; 
    fg.ColWidth(86)=930; 
    fg.ColWidth(87)=750; 

    fg.ColWidth(88)=750; 
    fg.ColWidth(89)=930; 
	fg.ColWidth(90)=750; 

    fg.ColWidth(91)=750; 
    fg.ColWidth(92)=930;
	fg.ColWidth(93)=750;
    

}
function OnSearch()
{
	dso_jabk0080.Call("SELECT");
}
function OnDataReceive(obj)
{
	if(obj.id=='dso_jabk0080')
	{
		SetGridHeader();
		/*if (grdInquiry.rows > 2)
			{
				txtCount.text = grdInquiry.rows - 1 + " record(s)";
				//grdInquiry.Subtotal( 1, 2, -1, '7!8!9');
			}*/
	}
}
</script>  
<body>
	<gw:data id="dso_jabk0080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="CRM.sp_sel_jabk0080"> 
                <input bind="grdInquiry" > 
                     <input bind="dtMonth" /> 
                </input> 
                <output bind="grdInquiry" />  
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">  
					<tr style="height: 100%" valign="top">
                        <td>
                            <table style="width: 100%; height: 100%" border="1">
								<tr style=" height: 2%">
									<td style="width: 5%;" align="center">Date</td>
									<td width="7%" align="left"><gw:datebox id="dtMonth" type="month" lang="1" onchange="OnSearch()" /></td>
									<td style="width: 88%;"></td>
								</tr>
                                <tr style="height: 98%">
                                    <td colspan="7">
                                        <gw:grid id="grdInquiry" header="0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|43|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93" 
                                            aligns="|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0|0|0|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0|0|0|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0|0|0|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            widths="1000|1000|2000|2000|500|500|500|500|500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1500|1500|2000|2000|2000|1000|1000|1000|1000|2000|2000|500|500|500|500|500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1500|1500|2000|2000|2000|1000|1000|1000|1000|2000|2000|500|500|500|500|500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1500|1500|2000|2000|2000|1000|1000|1000|1000|2000|2000|500|500|500|500|500|1000|1000|1000|1000|1000|1000|1000|1000|1000" sorting='F'
                                            styles="width:100%; height:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
