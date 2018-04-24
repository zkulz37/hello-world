<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("comm")%>
<head>
    <title>Get Data Transmission</title>
</head>

<script type="text/javascript" language="javascript">
//-------------------------------------------------
    function BodyInit()
    {
       var datevaule = "<%=Request.querystring("prod_dt")%>"; 
       dtDatefr.value = datevaule;
       dtDateto.value = datevaule;
        OnSearch();
    }
 //------------------------------------------------

    function OnSearch()
    {
        shpp00221.Call("SELECT");
    }
    //-------------------------------------------------
    function OnCancel()
    { 
	    this.close(); 	
    }
    function RowDbClick()
    {
        var code_data=new Array()
	    var ctrl = idGrid.GetGridControl();
	    var index, rowNo
	    index =0;
	    rowNo = 0
	    if(ctrl.SelectedRows == 0)
        {
               return ;
        }
        else
	    {
	         for(i=0;i<ctrl.SelectedRows;i++)
			    {	  
		            rowNo = ctrl.SelectedRow(i)
		            for(j=0;j< idGrid.cols -1; j++)
		            {
	                    code_data[index] = idGrid.GetGridData(rowNo , j );
	                    index ++;
                    } 
                    
			    }
	    }
	    window.returnValue = code_data; 
	    this.close(); 	
    }
    //-------------------------------------------------

</script>

<body>
    <!----------------------------------------------------->
    <gw:data id="shpp00221" > 
        <xml> 
           <dso id="1" type="grid" function="prod.sp_sel_shpp00221" > 
                <input bind="idGrid" > 
                    <input bind="radStatus" />
                    <input bind="dtDatefr" />
                   <input bind="dtDateto" />
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------->
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td align="right"> Prod date  </td>
            <td > <gw:datebox id="dtDatefr" lang="1" /> ~ <gw:datebox id="dtDateto" lang="1" />
            </td>            
            <td  colspan='2'>
            </td>
        </tr>
        <tr style="height: 1%">
            <td align="center"  colspan='2'>
                <gw:radio id="radStatus" value="N" styles="width:100%" onchange="OnSearch()">
                      <span value="N" id="Span3">Before Choise</span>
                      <span value="Y" id="Span4">Already Choise</span>
                      <span value="" id="Span5">All Datas</span>
                </gw:radio>
            </td>
            <td style="width: 3%" align="right">
                <gw:imgbtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="idSelect" img="select" alt="Select" onclick="RowDbClick()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="5">
                <gw:grid id='idGrid' header='File Name|Status|Prod Date' format='0|0|4' aligns='0|0|0' check='||'
                    editcol='1|1|0' widths='2000|2000|1000' sorting='T'  styles='width:100%; height:100%' oncelldblclick="RowDbClick()" />
            </td>
        </tr>
    </table>
</body>
</html>
