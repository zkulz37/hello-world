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
        var item_bc = "<%=Request.querystring("item_bc")%>";
        
        txtItemBC.text = item_bc;
        //----------------------------
        MergeColumn();
        
        data_dsep00043.Call('SELECT');
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
        case 'data_dsep00043':
            if ( grdPackingLabel.rows > 1 )
            {
                grdPackingLabel.SetCellBold( 1, 7, grdPackingLabel.rows - 1, 7, true );
            }
        break;
    }
}
//=======================================================================
   
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00043" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="<%=l_user%>lg_sel_dsep00043" > 
                <input>       
                    <input bind="txtItemBC" />                                 
                </input> 
                <output bind="grdPackingLabel" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 99%">
            <td>
                <gw:grid id='grdPackingLabel' header='Label ID|Item Code|Spec 01|Spec 02|Spec 03|Spec 04|Spec 05|Qty|_Pa_Label_Type_Pk|_Pa_Packages_Type_Pk|_Parent_Pk|_Pk'
                    format='0|0|0|0|0|0|0|0|0|0|0|0' aligns='1|0|1|1|1|1|1|3|0|0|0|0' defaults='|||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0' widths='1500|1500|1500|1500|1500|1500|1500|1200|0|0|0|0'
                    styles="width:100%; height:100%;" sorting='T' />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
<!------------------------------------------------------------------>
<gw:textbox id="txtItemBC" styles="width:100%;display:none" />
<!------------------------------------------------------------------>
</html>
