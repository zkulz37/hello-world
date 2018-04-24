<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Collecttion Balance Checking Popup</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

var G_SLIP_NO		= 0,
    G_SLIP_DATE		= 1,
	G_SEQ			= 2,
	G_COLLECT_AMT	= 3,
	G_CCY			= 4,
	G_EX_RATE		= 5,
	G_COLLECT_DESC	= 6;
	   
    //---------------------------------------------------------
    function BodyInit() 
	{        
	    System.Translate(document); 
	    var callerWindowObj = dialogArguments;
		
	    txtCollectReqPK.text =  callerWindowObj.txtCollectReqPK.text ;
		
	    lblPartnerName.text  =  callerWindowObj.txtPartnerName.text;
	    dtReqDate.text       =  callerWindowObj.txtReqDate.text.substring(6,8) + "/" + callerWindowObj.txtReqDate.text.substring(4,6) + "/" + callerWindowObj.txtReqDate.text.substring(0,4);
	    lblSlip.text         =  callerWindowObj.txtSlipRef.text;

		OnFormatGrid();
		OnSearch();
    }
	 //------------------------------------------------------------------------------------------------
    function OnFormatGrid() 
	{ 
        var trl;

        trl = grdDetail.GetGridControl();
        trl.ColFormat(G_COLLECT_AMT) = "###,###,###,###,###.##";
        trl.ColFormat(G_EX_RATE)     = "###,###,###,###,###.##";	
    }
    //---------------------------------------------------------   
    function OnSearch() 
	{
        data_dsap00101.Call('SELECT')
    }
    //---------------------------------------------------------
    function OnDataReceive(obj) 
	{
        switch (obj.id) 
		{
            case 'data_dsap00101':  
			 	
            break;
        }
    }
	//==================================================================================================
    function OnPopUp() 
	{

    }
    //==================================================================================================
    function OnReport()
	{

    }
	//==================================================================================================
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsap00101" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale"   function="<%=l_user%>lg_sel_dsap00101" > 
                <input> 
                    <input bind="txtCollectReqPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="0">
        <tr id='top' style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="left">
                <gw:label id="lbl01" styles='width:100%;font:9pt;font-weight:bold' text="Partner" />
            </td>
            <td style="width: 20%; white-space: nowrap" align="left">
                <gw:label id="lblPartnerName" styles='width:100%;color:cc0000;font:9pt' />
            </td>
            <td style="width: 5%; white-space: nowrap" align="left">
                <gw:label id="lbl02" styles='width:100%;font:9pt;font-weight:bold' text="Req Date" />
            </td>
            <td style="width: 5%">
                <gw:label id="dtReqDate" styles='width:100%;color:cc0000;font:9pt' />
            </td>
            <td style="width: 5%; white-space: nowrap" align="left">
                <gw:label id="lbl03" styles='width:100%;font:9pt;font-weight:bold' text="Slip/Ref No" />
            </td>
            <td style="width: 15%" align="left">
                <gw:label id="lblSlip" styles='width:100%;color:cc0000;font:9pt' />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="9">
                <gw:grid id='grdDetail' header='Slip No|Slip Date|Seq|Pay Amount|CCY|Ex Rate|Collect Desc'
                    format='0|4|0|0|0|0|0' aligns='0|1|1|3|1|3|0' check='||||||' editcol='0|0|0|0|0|0|0'
                    widths='1200|1200|600|1500|800|1200|1000' sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtCollectReqPK" styles="width:100%; display:none" />
    <gw:textbox id="txtPartnerName" styles="width:100%; display:none" />
    <gw:textbox id="txtReqDate" styles="width:100%; display:none" />
    <gw:textbox id="txtSlipRef" styles="width:100%; display:none" />
</body>
</html>
