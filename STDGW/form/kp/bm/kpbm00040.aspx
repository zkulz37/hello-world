<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>

</script>

<body>
    <!------------------------------------------------------------------------------------------------------------------>
  <!--  <gw:data id="dso_kpbm00070" onreceive=""> 
        <xml> 
            <dso id="1" type="grid"  function="EC111.sp_sel_kpbm00070" parameter="0,1,2,3,4,5,6" procedure="ec111.sp_upd_kpbm00070 "> 
                <input bind="grdDetail">                    
                    <input bind="txtProject_Cd" />
                    <input bind="dtPeriod_Fr" />
                    <input bind="dtPeriod_To" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>-->
    <!------------------------------------------------------------------------------------------------------------------>
    <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%" border="0">
        <tr style="height: 2%">
            <td width="100%">
            <fieldset>
                <table cellpadding="1" cellspacing="1" width="100%">
                    <tr>
                        <td align="right" width="10%">
                            <a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('project')">
                                Project&nbsp;</a></td>
                        <td width="60%">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="40%">
                                        <gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
                                    </td>
                                    <td width="60%">
                                        <gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
                                    </td>
                                    <td width="">
                                        <gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
                                    </td>
                                </tr>
                                
                            </table>
                        </td>
                        
                        <td width="20%">
                        </td>
                        <td width="20%"></td>
                        <td>
                            <gw:imgbtn id="ibtnUpdte" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtnpdte" img="new" alt="New" onclick="OnAddRow()" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtUpdate" img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtnUdate" img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtnUpdate" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtnConfirm" img="confirm" alt="Confirm" onclick="OnConfirm()" />
                        </td>
                    </tr>
                    <tr>
                                		<td align="right">Description</td>
                                        <td><gw:list id="lstDescription" styles='width:100%;' /></td>
                                        <td align="right">Work Division</td>
                                        <td colspan="7"><gw:textbox id="txtWorkDivision" styles='width:100%;' /></td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>
        <tr style="height: 98%">
            <td>
                
                <gw:grid id='grdDetail' 
                header="_PK|Seq. No.||Level Code|Wkng Seq. No.|Wkng Dtals No.|Dtals Journal. No.|Dtals Descrip.|Currency|Name|Standard|Unit|Q'ty|Raw Mtrl. Cost U/P|Raw Mtrl. Cost Amt|Labor Cost U/P|Labor Cost Amt|Exp. Amt|Unit Price|Amount|Order Work Div. Code|Exec. (Y/N)|Dir. Mgt Outsrc. Descrip.|Bdgt. Item Code|Standard Code|Legal O/H Expns. Excl. Subj.|Sfty Cost Non-Appl. Items|Calc. Basis"
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                    aligns ='0|1|1|1|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                    check='|||||||||||||||||||||||||||' 
                    editcol='1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    widths='0|1000|2000|200|200|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000' 
                    sorting='T' autosize='T' styles='width:100%; height:100%' acceptnulldate="T" />
            </td>
        </tr>
    </table>
</body>
</html>
