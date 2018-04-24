<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Get Port</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script language="javascript" type="text/javascript">
    var flag;
    var action;
    action='create';
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        <%=ESysLib.SetGridColumnComboFormat("grdPorts",5, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='COAB0080' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
    }
    
    //-----------------------------------------------------------
    function OnDataReceive(obj)
    {
        switch(obj.id)
        {
            case 'dat_getport':
                for(i=1;i<grdPorts.rows;i++)
                    grdPorts.SetGridText(i,0,i);
            break;
        }
    }
    //-----------------------------------------------------------
    function OnSelect()
     {
        var code_data=new Array()
	    var ctrl = grdPorts.GetGridControl();
	    var index, rowNo
    	
	    index =0;
	    rowNo = 0 ;
    	
	    if(ctrl.SelectedRows == 0)
        {
            return ;
        }
        rowNo=grdPorts.row;
        for(var col =0; col<grdPorts.cols; col++)
            code_data[col] = grdPorts.GetGridData(rowNo , col);
        
        window.returnValue = code_data; 
	    window.close();
     }
</script>
<body>
<!-------------------------------------------------------------------------------------------------->
    <gw:data id="dat_getport"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="1,2,3,4,5,6" function="imex.sp_sel_tie_port" > 
                <input bind="grdPorts">                    
                    <input bind="txtPortCode" /> 
                    <input bind="txtPortName" />
                    <input bind="cboActive" />
                </input> 
                <output bind="grdPorts" /> 
            </dso> 
        </xml> 
    </gw:data>
<!---------------------------------------------------------------------------------------------->
    <form id="form1" runat="server">
    <table style="width: 100%; height: 100%" cellpadding=0 cellspacing=0>
        <tr style=" height: 1%">
            <td width="7%" nowrap >Port code</td>
            <td width="15%"><gw:textbox id="txtPortCode" styles="width:100%" text="" onenterkey="dat_getport.Call('SELECT');"/></td>
            <td width="3%"></td>
            <td width="7%" nowrap>Port Name</td>
            <td width="2%"></td>
            <td width="25%"><gw:textbox id="txtPortName" styles="width:100%" text="" onenterkey="dat_getport.Call('SELECT');"/></td>
            <td width="3%"></td>
            <td width="4%">Active</td>
            <td width="2%"></td>
            <td width="15%">
                <gw:list id="cboActive" value='-1' styles="width:100%;">
                    <data>Data|-1|Active|0|Deactive|1|Select All</data>
                </gw:list>
            </td>
            <td width="15%"></td>
            <td width="2%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_getport.Call('SELECT');" /></td>
        </tr>
        <tr style=" height: 99%">
            <td colspan="12">
                 <gw:grid id='grdPorts'
                    header='No|_Pk|Port Code|Port Name|City|Country|Active'
                    format='0|0|0|0|0|2|3'
                    aligns='0|0|0|0|0|0|0'
                    defaults='||||||'
                    editcol='1|1|1|1|1|1|1'
                    widths='600|0|1500|3500|2500|2000|600'
                    sorting='T'
                    styles='width:100%; height:100%'                       
                    oncelldblclick ="OnSelect()" 
                />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
