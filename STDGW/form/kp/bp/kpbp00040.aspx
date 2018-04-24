<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Inquiry Dimension</title>
</head>
<%ESysLib.SetUser("ec111")%>
<script>
function BodyInit()
{
        System.Translate(document);
        BindingDataList(); 
}   
function BindingDataList()
{
        var ls_Dimension = "<%=ESysLib.SetListDataSQL("select pk, SIZEITEMNAME from TECPS_CONTSIZEITEM where del_if = 0")%>";
        lstDimension_item_1.SetDataText(ls_Dimension);
        lstDimension_item_2.SetDataText(ls_Dimension);
        lstDimension_item_3.SetDataText(ls_Dimension);   
        var ls_Condition = "DATA|O|OR|A|AND";
        lstCond_1.SetDataText(ls_Condition); 
        lstCond_2.SetDataText(ls_Condition); 
        lstCond_3.SetDataText(ls_Condition);   
}
function OnPopUp(obj)
{
        switch(obj)
        {
                case 'Facilities':
                            var path = System.RootURL + '/form/kp/bp/kpbp00040_popup.aspx';
		                    var object = System.OpenModal( path ,600 , 500 , 'resizable:yes;status:yes');
		                    if ( object != null )
		                    {
                                        txFa_Class_Pk.text = object[1];
                                        txFa_Class_Cd.text = object[2];
                                        txFa_Class_Nm.text = object[3]; 
                            }
                break;
        }
}     
function OnSearch()
{
        dso_search.Call("SELECT");
}   
</script>
<body>
<gw:data id="dso_search" onreceive="">
        <xml>
            <dso type="grid"  function="ec111.sp_sel_kpbp00040">
                <input bind="Grid_Detail">
                    <input bind="txFa_Class_Pk"/>
                    <input bind="dtPeriodDt_Fr"/>
                    <input bind="dtPeriodDt_To"/>
                    <input bind="lstDimension_item_1"/>
                    <input bind="txtItem1_L"/>
                    <input bind="txtItem1_R"/>
                    <input bind="lstCond_1"/>
                    <input bind="lstDimension_item_2"/>
                    <input bind="txtItem2_L"/>
                    <input bind="txtItem2_R"/> 
                    <input bind="lstCond_2"/> 
                    <input bind="lstDimension_item_3"/>
                    <input bind="txtItem3_L"/>
                    <input bind="txtItem3_R"/> 
                    <input bind="lstCond_3"/>  
                </input>
                <output bind="Grid_Detail"/>
            </dso>
        </xml>
    </gw:data>
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0">
            <tr style="height:10%">
                        <td >
                                <fieldset> 
                                                <table cellpadding="1" cellspacing="1" width="100%">
                                                        <tr>
                                                                <td align="right" width="15%"><a title="Click here to show Facilities Classification" href="#" style="text-decoration:none" onClick="OnPopUp('Facilities')">Facility Item&nbsp;</a></td> 
                                                                <td width="45%" colspan="5">
                                                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                                                        <tr>
                                                                                                     <td width="30%"><gw:textbox id="txFa_Class_Cd" readonly="true" styles='width:100%' /></td>
                                                                                                    <td width="45%"><gw:textbox id="txFa_Class_Nm" readonly="true" styles='width:100%' /></td> 
                                                                                                    <td><gw:textbox id="txFa_Class_Pk" styles='width:100%;display:none' /></td>  
                                                                                                    <td ><gw:imgbtn id="btjv2" img="reset" alt="Reset"  onclick="txFa_Class_Cd.text='';txFa_Class_Nm.text='';txFa_Class_Pk.text='';" /></td>
                                                                                                    <td width="25%"  align="right">Project Period&nbsp;</td>
                                                                                                    <td ><gw:datebox id="dtPeriodDt_Fr" lang="1"  styles="width:100%" /></td>
                                                                                                    <td>~</td> 
                                                                                                    <td><gw:datebox id="dtPeriodDt_To" lang="1"  styles="width:100%" /></td> 
                                                                                                    <td align="right"><gw:imgbtn id="btve" img="search" alt="Search"  onclick="OnSearch()" /></td>
                                                                                        </tr> 
                                                                            </table>
                                                                </td> 
                                                                    
                                                        </tr>
                                                        <tr>
                                                                        <td align="right" width="15%">Dimension item&nbsp;</td>
                                                                        <td width="45%"><gw:list id="lstDimension_item_1" styles='width:100%' /></td>
                                                                         <td width="2%"></td>
                                                                        <td width="26%">
                                                                                    <table cellpadding="1" cellspacing="1" width="100%">
                                                                                                <tr>
                                                                                                            <td width="49%"><gw:textbox id="txtItem1_L" styles='width:100%' /></td>
                                                                                                            <td  align="center" width="2%">~</td> 
                                                                                                            <td width="49%"><gw:textbox id="txtItem1_R" styles='width:100%' /></td> 
                                                                                                              
                                                                                                </tr>
                                                                                    </table>
                                                                        </td>
                                                                        <td width="2%"></td>
                                                                        <td width="10%"><gw:list id="lstCond_1" styles='width:100%' /></td>
                                                        </tr>
                                                        <tr>
                                                                        <td align="right" width="15%">Dimension item&nbsp;</td>
                                                                        <td width="45%"><gw:list id="lstDimension_item_2" styles='width:100%' /></td>
                                                                         <td width="2%"></td>
                                                                        <td width="21%">
                                                                                    <table cellpadding="1" cellspacing="1" width="100%">
                                                                                                <tr>
                                                                                                            <td width="49%"><gw:textbox id="txtItem2_L" styles='width:100%' /></td>
                                                                                                            <td  align="center" width="2%">~</td> 
                                                                                                            <td width="49%"><gw:textbox id="txtItem2_R" styles='width:100%' /></td> 
                                                                                                              
                                                                                                </tr>
                                                                                    </table>
                                                                        </td>
                                                                        <td width="2%"></td>
                                                                        <td width="15%"><gw:list id="lstCond_2" styles='width:100%' /></td>
                                                        </tr>
                                                        <tr>
                                                                        <td align="right" width="15%">Dimension item&nbsp;</td>
                                                                        <td width="45%"><gw:list id="lstDimension_item_3" styles='width:100%' /></td>
                                                                         <td width="2%"></td>
                                                                        <td width="21%">
                                                                                    <table cellpadding="1" cellspacing="1" width="100%">
                                                                                                <tr>
                                                                                                            <td width="49%"><gw:textbox id="txtItem3_L" styles='width:100%' /></td>
                                                                                                            <td  align="center" width="2%">~</td> 
                                                                                                            <td width="49%"><gw:textbox id="txtItem3_R" styles='width:100%' /></td> 
                                                                                                </tr>
                                                                                    </table>
                                                                        </td>
                                                                        <td width="2%"></td>
                                                                        <td width="15%"><gw:list id="lstCond_3" styles='width:100%' /></td>
                                                        </tr>
                                                     
                                                </table> 
                                </fieldset>
                    </td>  
            </tr>
            <tr style="height:90%">
                        <td>
                                        <gw:grid   
                                        id="Grid_Detail"  
                                        header="Project code|Project Name|Period|Typical Facilities|Gross Area|Building Area"   
                                        format  ="0|0|0|0|0|0"  
                                         aligns  ="0|0|1|0|0|0"  
                                        defaults="|||||"  
                                        editcol ="0|0|0|0|0|0"  
                                        widths  ="1500|5000|2500|1500|1500|1500"  
                                        styles="width:100%; height:100%"   
                                        sorting="T"   
                                         /> 
                        </td>
            </tr> 
</table>  
</body>
</html>
