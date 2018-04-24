<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Revenue monthly(Web Service)</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script>
function BodyInit()
{
	OnSearch()
}
function OnSearch()
{
    dsoRevenue.Call("SELECT");
}
function OnMerge()
{
	grdRevenue.MergeByCol(0);
}
</script>
<body>
<!----------------------------------------------------------------------------------------------->
<gw:data id="dsoRevenue"  onreceive="OnMerge()" > 
    <xml> 
        <dso  type="grid"    function="sp_sel_jama00160_revenue_ws" >  
            <input bind="grdRevenue">                    
                <input bind="dtMonth" /> 
            </input> 
            <output bind="grdRevenue" />
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                      
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                    <td width="5%">
                                                        Month :</td>
                                                    <td width="15%">
                                                        <gw:datebox id="dtMonth"  text=""  style="width:100%" type="month" lang="1" onchange="OnSearch()"  />
                                                    </td>
                                                    <td width="1%"></td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                        
                                                    </td>
                                                    <td width="3%">
                                                        
                                                    </td>
                                                    <td width="3%">
                                                        
                                                    </td>
                                                    <td width="67%"></td>
                                                </tr>
                                            </table>
                                       
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 95%">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%">
                            <div style="width:100%; height:458; overflow:auto">
                            <gw:datagrid id="grdRevenue" header="POINTS| SUB POINT| MONTH SUM| AVG MONTH AMT| D1| D2| D3| D4| D5| D6| D7| D8| D9| D10| D11| D12| D13| D14| D15| D16| D17| D18| D19| D20| D21| D22| D23| D24| D25| D26| D27| D28| D29| D30| D31"
                                format="0|0|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2|-2" 
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                defaults="||||||||||||||||||||||||||||||||||" 
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                widths="70|140|80|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70|70" 
                                styles="width:100%; height:100%" 
                                sorting="T"  autosize="T" />
                            </div>    
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display:none"/>
</body>
</html>
