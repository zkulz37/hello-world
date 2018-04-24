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
        txtParentBC.SetEnable(false);
        
        var p_parent_pk = "<%=Request.querystring("parent_pk")%>";
        var p_parent_bc = "<%=Request.querystring("parent_bc")%>";
        
        txtParentBC.text = p_parent_bc;
        txtParentPK.text = p_parent_pk;
                
        MergeColumn();

        data_dsep00042.Call('SELECT');
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
        case 'data_dsep00042':
            if ( grdPackingLabel.rows > 1 )
            {
                grdPackingLabel.SetCellBold( 1, 7, grdPackingLabel.rows - 1, 7, true );
            }
            
            grdPackingLabel.Subtotal( 0, 2, -1, '7', '###,###');
        break;
        
        case 'pro_dsep00042':
            alert(txtReturnValue.text);
            
            data_dsep00042.Call("SELECT");
        break;        
    }
}   
//=======================================================================
function OnProcess(pos)
{
    switch (pos)
    {        
        case 'ResetItem' :
            if ( txtParentPK.text != '' )
            {
                if ( confirm('Are you sure to Reset Item for this packages '))
                {
                    pro_dsep00042.Call();
                } 
            }                           
        break;
    }
}
//=================================================================  
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00042" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="<%=l_user%>lg_sel_dsep00042" > 
                <input>       
                    <input bind="txtParentPK" />                                 
                </input> 
                <output bind="grdPackingLabel" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00042" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsep00042" > 
                <input>
                    <input bind="txtParentPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Item BC :
                        </td>
                        <td style="width: 20%; white-space: nowrap" align="left">
                            <gw:textbox id="txtParentBC" styles="width:100%" />
                        </td>
                        <td style="width: 69%; white-space: nowrap" align="center">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="ibtnResetItem" img="2" text="Reset Item" alt="Reset Item Detail" onclick="OnProcess('ResetItem')"
                                styles='width:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td>
                <gw:grid id='grdPackingLabel' header='Label ID|Item Code|Spec 01|Spec 02|Spec 03|Spec 04|Spec 05|Qty|Crt by|Crt Dt'
                    format='0|0|0|0|0|0|0|0|0|0' 
                    aligns='1|0|1|1|1|1|1|3|1|0' 
                    defaults='|||||||||' 
                    editcol='0|0|0|0|0|0|0|0|0|0'
                    widths='1500|2000|1200|1200|1200|1200|1200|1000|800|0' 
                    styles="width:100%; height:100%;"
                    sorting='T' />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
<!------------------------------------------------------------------>
<gw:textbox id="txtReturnValue" styles="width:100%;display:none" />
<gw:textbox id="txtParentPK" styles="width:100%;display:none" />
<!------------------------------------------------------------------>
</html>
