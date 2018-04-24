<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>MR Daily Report(Web Service)</title>
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
	grdRevenue.MergeByCol(1);
	//grdRevenue.MergeByCol(2);
	//grdRevenue.MergeByCol(3);
}
</script>
<body>
<!----------------------------------------------------------------------------------------------->
<gw:data id="dsoRevenue"  onreceive="OnMerge()" > 
    <xml> 
        <dso  type="grid"    function="sp_sel_jama00170_mr_ws" > 
            <input bind="grdRevenue">                    
                <input bind="dtDate" /> 
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
                                                        Date :</td>
                                                    <td width="15%">
                                                        <gw:datebox id="dtDate"  text=""  style="width:100%" lang="1"  onchange="OnSearch()"  />
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
                            <gw:datagrid id="grdRevenue" header="PL CODE| PL NAME| MR NO|DATE| DESCRIPTION MASTER| ITEM CODE| ITEM NAME| ITEM UNIT| REQ QTY| WEIGHT| DESCRIPTION DETAIL"
                                format="0|0|0|4|0|0|0|0|0|0|0" 
                                aligns="0|0|0|0|0|1|0|1|3|3|0" 
                                defaults="||||||||||" 
                                editcol="0|0|0|0|0|0|0|0|0|0|0"
                                widths="100|200|150|70|200|100|215|70|70|70|200" 
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
