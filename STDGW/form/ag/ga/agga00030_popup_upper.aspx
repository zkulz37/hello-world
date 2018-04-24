<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("acnt")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<script>

var arr_data = new Array();

function BodyInit()
{
    System.Translate(document);
    txt_Company_Pk.text ="<%=Request.querystring("company_pk")%>";
    txt_Plc_Pk.text     ="<%=Request.querystring("plc_pk")%>";
	BindingDataList();
}
function BindingDataList()
{       
    DSO_Sel_Grid.Call("SELECT")
}
function OnSearch()
{
    DSO_Sel_Grid.Call("SELECT")
}

function OnSelectCode()
{
    var ctrl = idGrid.GetGridControl();
    
    if(ctrl.Row > 0)
    {
		
		arr_data[0] = idGrid.GetGridData(ctrl.Row,0);   // Pk
		arr_data[1] = idGrid.GetGridData(ctrl.Row,1);   // PLC CD
				
	    window.returnValue =  arr_data;
	    window.close();
	}
}
function OnClose()
{
    this.close();
}
function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {               
        case "DSO_Sel_Grid":
            lblRecord.text=idGrid.rows-1 + " record(s).";
        break;
    }
}
</script>
 
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0">

<gw:data id="DSO_Sel_Grid"  onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" function="ACNT.SP_SEL_ABPL_POPUP_UPPER">
            <input bind="idGrid" >                    
                <input bind="txt_Company_Pk" />
                <input bind="txt_Plc_Pk" />
                <input bind="txt_PLC_CD" />
                <input bind="txt_PLC_NM" />
            </input>
            <output bind="idGrid" />
        </dso>                    
    </xml>
</gw:data>
    
<!------------------------ Main Table -------------------------->    

<table align ="top" cellpadding="0" cellspacing="0" border="1" style="width:100%;height:100%;border-color:#6B9EB8">
    <tr valign="top">
        <td>
            <table width="100%">
                <tr>
                    <td width="8%" align="right">Code</td>
                    <td width="8%" align="left"><gw:textbox id="txt_PLC_CD"  text=""  styles="width:100%" onenterkey="OnSearch()"/></td>
                    <td width="8%" align="right">Name</td>
                    <td width="8%" align="left"><gw:textbox id="txt_PLC_NM"  text=""  styles="width:100%"onenterkey="OnSearch()" /></td>
                    <td width="10%" align="center" ><gw:label id="lblRecord"   text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight:bold" /></td>
		            <td width="2%"><gw:imgBtn id="ibtnCan" img="cancel"   alt="Close" 	 onclick="OnClose()" /></td> 
                </tr>
            </table>
        </td> 
    </tr>
    
    <tr>
        <td align = top  height="100%" border="1">
		    <gw:grid   
			    id="idGrid"  
			    header   = "_PK|Cost Center Code|Cost Center Name|_P_PK"
			    format   = "0|0|0|0"
			    aligns   = "0|0|0|0"
			    defaults = "|||||" 
			    editcol  = "0|0|0|0"   
			    widths   = "0|2500|4000|0"
			    styles   = "width:100%; height:100%"   
			    sorting  = "T"
			    oncelldblclick="OnSelectCode()"
			    param    = "0,1,2,3"  /> 
	    </td>
    </tr>    
</table>   
    
</body>
        
    <gw:textbox id="txt_Company_Pk"           style="display:none"/>
    <gw:textbox id="txt_Plc_Pk"               style="display:none"/>
    
</html>