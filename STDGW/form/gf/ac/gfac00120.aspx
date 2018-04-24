<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>

 <%=ESysLib.RenderControlHTML("dso_60080330_account","col_index") %>


var g_flag_save = false;

function BodyInit()
{
         

 	
}
function onSearch()
{
    
}
function OnDataReceive(p_oData)
{
   // switch(p_oData.id)
  //  {
	   //  case "dso_60080330_account":                
    //    break;      
        
   // }
}

function Reset_Acc()
{
	txtac_cd.SetDataText('');
	txtac_nm.SetDataText('');
	
}

</script>
<body style="margin:0; padding:0;"> 

<%=ESysLib.RenderControlHTML("dso_60080330_account","data") %> 

<table  style="width:100%; height:100%" cellpadding="0" cellspacing="0" border="1">
<tr>
    <td width="100%">
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
	        <td width="8%"></td>
	        <td width="29%"></td>
	        <td width="8%"></td>
	        <td width="35%"></td>
	        <td width="20%"></td>
	    </tr>
	    <tr>
	        
            <td align="right">Account&nbsp;</td>
            <td >
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="30%"><gw:textbox id="txtac_cd" onenterkey="onSearch()" styles='width:100%;background:#FFFFAF' /></td>                   
                </tr>
                </table>
            </td>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="80%"></td>
                    <td ><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"        onclick="onSearch()"/></td>
                    
                </tr>
                </table>
            </td>
	    </tr>
	    <tr>
	       
           
            <td >
                <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
                <tr>
                    <td id='idcus_cd' width="30%"><gw:textbox id="txtlb_cd" onenterkey="onSearch()" styles='width:100%' /></td>
                    <td id='idcus_nm' width="60%"><gw:textbox id="txtlb_nm" styles='width:100%'/></td>
					<td id='idpl_cd' width="30%"><gw:textbox id="txtpl_cd" onenterkey="onSearch()" styles='width:100%' /></td>
                    <td id='idpl_nm' width="60%"><gw:textbox id="txt_PLC_CD" styles='width:100%'/></td>
                    <td id='idbt_cus' width="5%"><gw:imgBtn   img="popup"	id="idSearchCust" alt="Popup" onclick="Popup()"/></td> 
					<td id='idbt_pl' width="5%"><gw:imgBtn   img="popup"	id="idSearchCust" alt="Popup" onclick="Popup()"/></td> 
                    <td width="5%"><gw:imgBtn   img="reset"	id="idResetCust"  alt="Reset" onclick="OnResetCust()"/></td>
                </tr>
                </table>
            </td>
           
	    </tr>
	    </table>
	</td>
</tr>
<tr style="width:100%; height:100%">
	<td width="100%">
	    <table style="width:100%; height:100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width:100%; height:100%">
            <td width="100%" style="width:100%; height:100%">
                <gw:tab id="idTab_Child"  onpageactivate ="onSearch()"  >
                    <table  name="Account Code"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >    
                        <tr valign="top" style="width:100%; height:100%">
                            <td width="100%">
                                <%=ESysLib.RenderControlHTML("dso_60080330_account","grid") %>
                            </td>
                        </tr>
                    </table>
                  </gw:tab>                    
            </td>
        </tr>
        </table>
	</td>
</tr>
</table>

<gw:textbox id="txtProposedByUserPk"            style="display:none" />
<gw:textbox id="txtResult"            style="display:none" />
<gw:textbox id="txtType"            style="display:none" />
</body>
</html>