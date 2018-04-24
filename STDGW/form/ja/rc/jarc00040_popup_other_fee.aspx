<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Update Golfer Name</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
 function BodyInit()
 {    
   txtLocker.SetReadOnly(true);
   txtBagtag.SetReadOnly(true);
   txtGolferName.SetReadOnly(true);
   txt_visitorfee_golfer_pk.text = '<%=Request.QueryString("p_master_pk") %>';     
   txtGolferName.text = '<%=Request.QueryString("p_golfer_name") %>';
   txtLocker.text = '<%=Request.QueryString("p_locker") %>';
   txtBagtag.text = '<%=Request.QueryString("p_bagtag") %>';  
   dso_other_fee.Call("SELECT");
 }
function OnAddNew()
{
    idGrid.AddRow();
    idGrid.SetGridText(idGrid.rows -1,1, txt_visitorfee_golfer_pk.text);
}
function OnSave()
{
   dso_other_fee.Call();
}
function OnDelete()
{
   if ( confirm( "Do you want item this row to delete?" ) ) 
			{
				 idGrid.DeleteRow();
				 dso_other_fee.Call();
			}
}
function OnReport()  
{
	var url = '/reports/ja/rc/rpt_jarc00040_tour_receipt.aspx';  
	System.OpenTargetPage( System.RootURL+url , "newform" );

}
</script>

<body>
    <gw:data id="dso_other_fee">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5" function="crm.sp_sel_jarc00040_other_fee" procedure = "crm.sp_upd_jarc00040_other_fee">
                <input bind="idGrid" >
                    <input bind="txt_visitorfee_golfer_pk"/>
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr style="height: 6%" valign="top">
            <td style="background: white;">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 15%">
                                        Golfer Name
                                    </td>
                                    <td style="width: 35%">
                                        <gw:textbox id="txtGolferName" styles="width:100%" /> 
                                    </td>
                                    <td style="width: 10%">
                                        Locker#
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtLocker" styles="width:100%" />
                                    </td>
                                    <td style="width: 10%">
                                        Bagtag
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtBagtag" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 88%">
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn img="new" alt="New" id="idBtnAdd" styles='width:100%' onclick="OnAddNew()" /> 
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn img="save" alt="Save" id="idBtnUpdate" styles='width:100%' onclick="OnSave()" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn img="delete" alt="Delete" id="idBtnDelete" styles='width:100%' onclick="OnDelete()" />
                                    </td>
									<td width="3%">
										<gw:imgbtn id="ibtnReport" img="printer" alt="Golf Course Tour Receipt" onclick="OnReport()" />
									</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td>
                            <gw:grid id="idGrid" header="_PK|_TGM_VISITORFEE_GOLFER_PK|Fee Description|Fee Amt(USD)|VAT(%)|Service Rate(%)"
                                format="0|0|0|0|0|0" aligns="0|0|0|0|0|0"
                                defaults="|||||" editcol="0|1|1|1|1|1" widths="0|1000|1300|1300|4500|4500"
                                styles="width:100%; height:453" sorting="T" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 94%">
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <gw:textbox id="txt_visitorfee_golfer_pk" styles="width:100%; display:none" />
</body>
</html>
