<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>PopUp Packages List</title>
</head>

<script>
//=======================================================================
 function BodyInit() 
 {
      System.Translate(document);
      var data = "<%=ESysLib.SetListDataSQL(" SELECT   pk, cover_code || ' - ' || cover_name FROM sale.pa_packages_type a WHERE del_if = 0 ORDER BY cover_code ")%>";     
      lstPackagesType.SetDataText(data);
      
      lstPackagesType.value = "<%=Request.querystring("packages_type_pk")%>";
        
      data = "<%=ESysLib.SetListDataSQL(" SELECT pk, ref_po_no FROM sale.pa_packing_wi a WHERE a.del_if = 0 AND close_yn = 'N' ORDER BY ref_po_no ")%>||";     
      lstPONo.SetDataText(data);        
                
      lstPONo.value = "<%=Request.querystring("wi_pk")%>";
      
      var ctrl = grdLabel.GetGridControl() ;      
      ctrl.MergeCells  = 2 ;	      
      ctrl.MergeCol(0) = true ;      
 }

//=======================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsep00044':
            if ( grdLabel.rows > 1 )
            {
                grdLabel.SetCellBold( 1, 1, grdLabel.rows - 1, 1, true );
            }
        break;      
    }
}   
//======================================================================= 
function OnSearch(pos)
{
    switch(pos)
    {
        case 'grdPackages':
            data_dsep00044.Call("SELECT");
        break;      
    }    
}
//=======================================================================  
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00044" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="<%=l_user%>lg_sel_dsep00044" > 
                <input>       
                    <input bind="lstPackagesType" />
                    <input bind="lstPONo" />
                    <input bind="txtItemBC" />  
                    <input bind="radPackType" />                               
                </input> 
                <output bind="grdLabel" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Packages
                        </td>
                        <td style="width: 55%; white-space: nowrap">
                            <gw:list id="lstPackagesType" styles='width:100%' />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            P/O No
                        </td>
                        <td style="width: 35%; white-space: nowrap" align="left" colspan="3">
                            <gw:list id="lstPONo" styles='width:100%' />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 55%; white-space: nowrap" align="center" colspan="2">
                            <gw:radio id="radPackType" value="2" styles="width:100%" onchange="OnSearch('grdPackages')"> 
                                <span value="1" >Packed </span> 
                                <span value="2" >UnPacked</span> 
                                <span value="0" >ALL</span> 
                            </gw:radio>
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Item BC
                        </td>
                        <td style="width: 30%; white-space: nowrap" align="left">
                            <gw:textbox id="txtItemBC" styles="width:100%" onenterkey="OnSearch('grdPackages')" />
                        </td>
                        <td style="width: 4%; white-space: nowrap" align="center">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdPackages')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td>
                <gw:grid id='grdLabel' header='Parent|Child' format='0|0' aligns='1|1' defaults='|'
                    editcol='0|0' widths='3000|3000' styles="width:100%; height:100%" sorting='T' />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
<!------------------------------------------------------------------>
</html>
