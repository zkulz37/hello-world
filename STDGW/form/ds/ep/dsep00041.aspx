<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>PopUp View Packages Label</title>
</head>

<script>
//=======================================================================
 function BodyInit() 
 {
        System.Translate(document);
        var packages_type_pk = "<%=Request.querystring("packages_type_pk")%>";
        var packing_wi_pk = "<%=Request.querystring("packing_wi_pk")%>";
        
        var callerWindowObj = dialogArguments;          
        
        lblWINo.text        = callerWindowObj.txtPacking.text ;
        lblPackageType.text = callerWindowObj.txtPackagesType.text ;  
        lblPONo.text        = callerWindowObj.txtPONO.text ;
        
        txtPackingPK.text       = packing_wi_pk;
        txtPackagesTypePK.text  = packages_type_pk;
        
        MergeColumn();
        
        data_dsep00041.Call('SELECT');
 }
 //=======================================================================
 
function MergeColumn()
{
      var ctrl = grdPackingLabel.GetGridControl() ;      
      ctrl.MergeCells  = 2 ;	      
      ctrl.MergeCol(0) = true ;	
      ctrl.MergeCol(1) = true ;
      ctrl.MergeCol(2) = true ;
      ctrl.MergeCol(3) = true ;
      ctrl.MergeCol(4) = true ;
      ctrl.MergeCol(5) = true ;
}
//=======================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_dsep00041':
            if ( grdPackingLabel.rows > 1 )
            {
                grdPackingLabel.SetCellBold( 1, 7, grdPackingLabel.rows - 1, 7, true );
                
                grdPackingLabel.Subtotal( 0, 2, -1, '7', '###,###');
            }
        break;
    }
}   
//=======================================================================
   
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00041" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="<%=l_user%>lg_sel_dsep00041" > 
                <input>       
                    <input bind="txtPackingPK" /> 
                    <input bind="txtPackagesTypePK" />                                 
                </input> 
                <output bind="grdPackingLabel" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%; white-space: nowrap" align="center">
                            W/I No :
                        </td>
                        <td style="width: 20%; white-space: nowrap" align="left">
                            <gw:label id="lblWINo" styles="width:100%;color:cc0000" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                            P/O No :
                        </td>
                        <td style="width: 30%; white-space: nowrap" align="left">
                            <gw:label id="lblPONo" styles="width:100%;color:cc0000" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                            Package Type :
                        </td>
                        <td style="width: 35%; white-space: nowrap" align="left">
                            <gw:label id="lblPackageType" styles="width:100%;color:cc0000" />
                        </td>                         
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td>
                <gw:grid id='grdPackingLabel' header='Label ID|Item Code|Spec 01|Spec 02|Spec 03|Spec 04|Spec 05|Qty|_Pa_Packages_Type_Pk|_Parent_Pk'
                    format='0|0|0|0|0|0|0|0|0|0' aligns='1|0|1|1|1|1|1|3|0|0' defaults='|||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0' widths='1500|1500|1500|1500|1500|1500|1500|1200|0|0'
                    styles="width:100%; height:100%;" sorting='T' />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
<!------------------------------------------------------------------>
<gw:textbox id="txtPackagesTypePK" styles="width:100%;display:none" />
<gw:textbox id="txtPackingPK" styles="width:100%;display:none" />
<!------------------------------------------------------------------>
</html>
