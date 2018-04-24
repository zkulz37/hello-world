<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{       
    	
    txtGroup.text="<%=Request.querystring("p_group")%>";
    txtFrom_DT.text="<%=Request.querystring("p_from_dt")%>";
    txtTo_DT.text="<%=Request.querystring("p_to_dt")%>";
    OnSearch();
}
function OnSearch()
{
    //alert(txtFrom_DT.text + " and " + txtTo_DT.text );
    datDetail.Call();
}
function OnDataReceive(obj)
{
    if(obj.id=="datDetail")
    {/*
        if(txtCol.text==4)
            for(var i=1;i<grdDetail.rows;i++)
                grdDetail.SetCellBgColor(i,6,i,6,0x0099FF);
        else if(txtCol.text==5)                
            for(var i=1;i<grdDetail.rows;i++)
                grdDetail.SetCellBgColor(i,7,i,7,0x0099FF);/**/
    }
}

function OnDblClick()
{
    
    var ctr=grdDetail.GetGridControl();
    var item_pk = grdDetail.GetGridData(ctr.row, 4);
    window.returnValue = item_pk ;
    this.close();
}
</script>
<body >
<!-------------------data control----------------------->
<!------------------------------------------>
<gw:data id="datDetail" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1" function="hr.SP_SEL_MANAGE_PRICE_ITEM" procedure=""> 
                <input bind="grdDetail" >                    
                    <input bind="txtGroup" />
                    <input bind="txtFrom_DT" />
                    <input bind="txtTo_DT" />
                </input>
                <output  bind="grdDetail" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<!-------------------data control----------------------->
   <table id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=9  style="border:0" align="center" valign="middle">
                          <font size=5>Select Item</font>
                        </td>					                            
				         <td colspan=2 style="border:0" align="right">
                        </td>
                        <td  style="border:0;" align="right" >                                                                                   
                        </td>                       
                        <td style="border:0" align="right">                                                      
                        </td>
                    </tr>                                       
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=15 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdDetail"  
                                header="Group|ITEM CODE|ITEM NAME|SALE ORDER NO|_ITEM_PK" 
                                format  ="0|0|0|0|1"  
                                aligns  ="0|0|0|1|0"  
                                defaults="|||||"  
                                editcol="0|0|0|0|0"  
                                widths="2000|1500|4000|1500"
                                styles="width:100%; height:100%" 								
                                sorting="T"    oncellDblclick="OnDblClick()"
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtGroup" styles="display:none"/>
<gw:textbox id="txtFrom_DT" styles="display:none"/>
<gw:textbox id="txtTo_DT" styles="display:none"/>
<gw:textbox id="txtCol" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
</html>
