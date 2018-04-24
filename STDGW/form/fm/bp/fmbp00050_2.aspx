<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>PO View</title>
  </head>
  
 <% ESysLib.SetUser("prod")%>
 
 <script>
 //---------------------------------------------------------
 function BodyInit()
 { 
    BindingDataList();
    /* Test data
    for (j=1;j<3;j++)
   { 
        grdPOView.AddRow();
        grdPOView.SetGridText(j,0,0);
        for (i=1;i<11;i++)
       {
             grdPOView.SetGridText(j,i,'111');
        }    
        grdPOView.SetGridText(j,11,'30');
        grdPOView.SetGridText(j,12,'10');
   }
   */
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {   
        var data1 ="<%= ESysLib.SetListDataSQL(" select pk,partner_id from tco_company where del_if = 0") %>";
        cboCompany.SetDataText(data1);
        txtVendor.SetEnable(false);
 }
function OnSearchMasterClick()
{
    grdPOView.ClearData();
    idPOView.Call('SELECT');
}

function  OnSelectClick()
{

    var r_data = new Array();
   var j =0; 
   for (i=1; i< grdPOView.rows;i++)
   {
        if (grdPOView.GetGridData(i,0) =="-1")
        {
            var tmp_Child = new Array()
            for(k = 0;k<grdPOView.cols;k++)
            {
               tmp_Child[k] = grdPOView.GetGridData( i , k );	
             } 
             r_data[j] = tmp_Child;
            j++; 
        }
   }
      window.returnValue = r_data;
      window.close(); 
}
 
function onVendorClick()
{
        var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx";
        oValue = System.OpenModal( fpath , 600 , 350, 'resizable:yes;status:yes');

        if ( oValue != null)
        {
                txtVendor.text = oValue[2];
        }
} 
 </script>

<body>
 <gw:data id="idPOView"  onreceive="" > 
        <xml>                                   
             <dso id="1" type="grid"  function="prod.sp_sel_poview"  > 
              <input  bind="grdPOView">
                    <input bind="cboCompany" /> 
                    <input bind="txtVendor" />
                    <input bind="dtbFrom" /> 
                    <input bind="dtbTo" /> 
                    <input bind="txtPONo" />
                    <input bind="txtItem" />
                </input> 
                <output bind="grdPOView" /> 
            </dso> 
        </xml> 
</gw:data> 

  <table border="1" cellpadding="0" cellspacing="0" width="100%">
        <tr valign="top">
                <td>
                       <table border="0" cellpadding="0" cellspacing="0" style=" margin-top:2;">
                            <tr>
                                    <td width="10%" ><b>&nbsp;&nbsp;Company&nbsp;</b></td>
                                    <td width="10%"><gw:list id="cboCompany"   styles="width:98%;margin-left:3;" ></gw:list></td>
                                    <td  width="13%" >&nbsp;&nbsp;&nbsp;<b style="color: #1b2ff2; cursor: hand" onclick="onVendorClick()">Vendor </b></td>
                                    <td  width="20%"><gw:textbox id="txtVendor" styles='width:100%'  onenterkey="OnSearchMasterClick()" /></td>
                                    <td width="12%"></td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="15%" align="right">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="90%">&nbsp;</td>
                                                <td width="5%"><gw:imgBtn id="ibtnSearch" img="search" alt="Search" text="Search"  onclick="OnSearchMasterClick()" /></td>
                                                <td width="5%"><gw:imgBtn id="ibtnSelect" img="select" alt="Select" text="Select"  onclick="OnSelectClick()" /></td> 
                                            </tr>
                                        </table>
                                </td>
                            </tr>
                            <tr>
                                <td >&nbsp;&nbsp;<b>Date</b></td>
                                <td align="left">
                                        <table border="0" cellpadding="1" cellspacing="2">
                                            <tr>
                                                <td width="45%"  align="left"><gw:datebox id="dtbFrom" lang="<%=Application("Lang")%>" mode="01"  /></td>
                                                <td width="10%"><b>&nbsp;~&nbsp;</b></td>
                                                <td width="45%"><gw:datebox id="dtbTo" lang="<%=Application("Lang")%>" mode="01"    /></td>
                                            </tr>
                                        </table>
                                </td>
                                <td ><b>&nbsp;&nbsp;&nbsp;PO No</b>&nbsp;</td>
                                <td><gw:textbox id="txtPONo" styles="width:100%"  onenterkey="OnSearchMasterClick()" /></td>
                                <td>&nbsp;&nbsp;&nbsp;<b>Part No</b>&nbsp;</td>
                                <td><gw:textbox id="txtItem" styles="width:100%"  onenterkey="OnSearchMasterClick()" /></td>
                                <td>&nbsp;</td>
                           </tr>
                        </table> 
                </td>
        </tr>
        <tr >
                <td valign="top">
						 <gw:grid
                                id="grdPOView"
                               header="Check|_PK|Partner Name|PO Date|PO No|_Tco_Item_Pk|Item Code|Item Name|Unit|BL Qty|BL Balance|_PO Qty|_Price"
                                format="3|0|0|4|0|0|0|0|0|1|1|1|1"
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0"
                                defaults="|||||||||||"
                                editcol="1|1|1|1|1|1|1|1|1|1|1|1|1"
                                widths="800|0|2500|1200|1500|0|1800|2200|1000|1000|1000|0|0"
                                styles="width:100%; height:380"
                                sorting="T"
                                param="0,1,2,3,4,5,6,7,8,9,10,11,12"/>
                </td>
        </tr>
  </table>
</body>
</html>
