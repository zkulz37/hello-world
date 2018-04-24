<!-- #include file="../../../system/lib/form.inc"  -->

<%ESysLib.SetUser("hr")%>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document); 
	iduser_pk.text = "<%=session("USER_PK")%>";
	
  OnSearch();
  	
}
//-------------------------------------------
function OnSearch()
{
    
	dso_Bank.Call("SELECT");
}
//-------------------------------------------
function OnSelect()
{
    
    var code_data=new Array()
	var ctrl = idgrid.GetGridControl();
	
	if(ctrl.SelectedRows == 0)
    {
        alert("Please select an bank.");
        return ;
    }
    else
	{
        
        code_data[1] = idgrid.GetGridData( ctrl.row , 1 );
        
		code_data[2] = idgrid.GetGridData( ctrl.row , 2 );
		window.returnValue = code_data; 
	   	this.close(); 	
	 }
    
}
//-------------------------------------------
function OnCancel()
{
	var code_data=new Array();
	tmp= new Array();
	tmp[0]       = 0
	code_data[0] = tmp;
	
	window.returnValue = code_data; 
	this.close();
	
}
</script>
<body  >
<gw:data id="dso_Bank"   > 
        <xml> 
            <dso id="1" type="grid" function="acnt.sp_sel_gfos00050_popup_1" > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="txtBank" /> 
                </input> 
                <output bind="idgrid" /> 
            </dso> 
        </xml> 
</gw:data>
<!------------------------------->
  <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                
                                                    <td align="right" width="5%">
                                                        Bank</td>
                                                    <td width="95%">
                                                        <gw:textbox id="txtBank" onenterkey="OnSearch()" text="" styles="width:100%" />
                                                    </td>
                                                   
                                                    <td>
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="btnSearch3" img="select" width="100%" img="in" text="Process" onclick="OnSelect()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="btnSearch2" img="cancel" width="100%" img="in" text="Process" onclick="OnCancel()" />
                                                    </td>                                                  
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 95%">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%">
                           
                            <gw:grid id="idgrid" header="No|Bank Id|Bank Name"
                                format="0|0|0" aligns="1|0|0" defaults="|||" editcol="0|0|0"
                                widths="500|1500|2500" styles="width:100%; height:100%"
                                sorting="F"  oncelldblclick="OnSelect()"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

<gw:textbox id="iduser_pk" styles="display:none; " />
</body>
</html>
