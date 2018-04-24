<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Print Label</title>
</head>

<script>

//===========================================================
 function BodyInit()
 {
    System.Translate(document);
    //----------------------
    txtWIMasterPK.text = "<%=Request.querystring("pa_packages_wi_pk")%>";
	//----------------
    OnChangeTab();	
 }
//==========================================================

function OnPrint()
{
      if ( radPackType.GetData() != 'PO' )
      {
            var url = System.RootURL + "/system/ReportEngine.aspx?file=ds/ep/dsep00070.rpt&procedure=SALE.sp_rpt_dsep00070_1&parameter=" + txtWIMasterPK.text +","+ radPackType.value +"&export_pdf=N" ;              
            System.OpenTargetPage(url); 
      }
      else
      {
            var url = System.RootURL + "/system/ReportEngine.aspx?file=ds/ep/dsep00070_3.rpt&procedure=SALE.sp_rpt_dsep00070_3&parameter=" + txtWIMasterPK.text +"&export_pdf=N" ;              
            System.OpenTargetPage(url);
      }         
}
//===========================================================

function OnProcess(pos)
{
    switch (pos)
    {
        case 'MakeLabel' :
            if ( txtWIMasterPK.text != '' )
            {
                ibtnMakeLabel.SetEnable(false);
                pro_dsep00076.Call();
            }
            else
            {
                alert('Pls select Pack W/I.');
            }
        break;
    }
}
//===========================================================

function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'pro_dsep00076' :  
            ibtnMakeLabel.SetEnable(true);          
            alert(txtReturnValue.text);
        break;     
    }
}

//===========================================================
 function OnChangeTab()
 {
 
    var strRad = radPackType.GetData();
             
	switch (strRad)
	{
		case 'CT':
	    
		    Poly.style.color     = ""; 
		    Carton.style.color = "red";
		    Inner.style.color  = "";
		    All.style.color    = "";
		    
        break;
        
        case 'IN':
 
		    Poly.style.color     = ""; 
		    Carton.style.color = "";
		    Inner.style.color  = "red";
		    All.style.color    = "";
		   		    
        break;
        
        case 'PO':
 
		    Poly.style.color     = "red"; 
		    Carton.style.color = "";
		    Inner.style.color  = "";
		    All.style.color    = "";
		   		    
        break;
                
        case 'ALL':

		    Poly.style.color     = ""; 
		    Carton.style.color = "";
		    Inner.style.color  = "";
		    All.style.color    = "red";
		   		    
        break;		
    } 
 }
//==============================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00076" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsep00076" > 
                <input>
                    <input bind="txtWIMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 100%; width: 100%">
            <td style="background-color: CCFFFF; border: 1px solid #034D72">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 50%">
                        <td align="center" colspan="2">
                            <gw:radio id="radPackType" value="CT" styles="width:100%" onchange="OnChangeTab()"> 
                                <span value="CT" id="Carton">Carton Box </span>
                                <span value="IN" id="Inner">Inner Box</span>
                                <span value="PO" id="Poly">Poly Bag</span>
                                <span value="ALL"id="All">ALL</span>
                            </gw:radio>
                        </td>
                    </tr>
                    <tr style="height: 50%">
                        <td style="width: 50%" align="center">
                            <gw:icon id="ibtnMakeLabel" img="3" text="Make Label" alt="Make Label" onclick="OnProcess('MakeLabel')"
                                styles='width:30%' />
                        </td>
                        <td style="width: 50%" align="center">
                            <gw:icon id="ibtnPrintLabel" img="2" text="Print Label" alt="Print Label" onclick="OnPrint('Label')"
                                styles='width:30%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
    <gw:textbox id="txtWIMasterPK" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
</body>
</html>
