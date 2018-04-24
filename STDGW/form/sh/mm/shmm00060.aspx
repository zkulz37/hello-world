<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Label Printing </title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

//===============================================================  
function BodyInit()
{
    OnChangeTab();
    txtMaltPK.text="<%=Request.querystring("para1")%>"; 
    txtBuspartnerPK.text="<%=Request.querystring("para5")%>";
    txtBuspartnerPK2.text="<%=Request.querystring("para5")%>";
    txtDeptID.text="<%=Request.querystring("para4")%>";
    txtPlanID.SetEnable(false);
    txtPlanName.SetEnable(false);
    txtPartnerName.SetEnable(false);
    shmm00060_5.Call("SELECT");
}
//===============================================================
function OnPopUp(pos)
{
    switch(pos)
    { 
	    case'partner':
	        var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	        var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes');

	        if (object != null)
	        {
		        txtBuspartnerPK.text	= object[0];	
		        txtPartnerID.text       = object[1];   
		        txtPartnerName.text     = object[2]; 
		        
	        } 
	    break;
	    case'partner2':
	        var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	        var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes');

	        if (object != null)
	        {
		        
		        txtBuspartnerPK2.text	= object[0];  
		        txtPartnerID2.text       = object[1];   
		        txtPartnerName2.text     = object[2];
	        } 
	    break;
	    case'dept':
	        var fpath = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIV0050";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 

	        if (object != null)
	        {
		        txtDeptPK.text		= object[1];	
		        txtDeptID.text      = object[1];    
		        txtDeptName.text    = object[3];   
	        } 
	    break;
	    case'malt':
	        var fpath = System.RootURL + "/form/sh/ab/shab00160.aspx";
	        var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes');

	        if (object != null)
	        {
		        txtMaltPK.text		    = object[0];	
		        txtMaltID.text          = object[1];    
		        txtMaltName.text        = object[2];   
		        txtMaltSpec.text        = object[3];
	        } 
	    break;
    }       
}
//==============================================================
function OnDataReceive(po_oData)
 {
      switch (po_oData.id)         
      {
        case "shmm00060" :
            if(grdTest.rows>1)
            {
                txtBuspartnerPK.text=grdTest.GetGridData(1,0);
                txtPartnerID.text=grdTest.GetGridData(1,1);
                txtPartnerName.text=grdTest.GetGridData(1,2);
            }
            else
            {
                txtBuspartnerPK.text="";
                txtPartnerID.text="";
                txtPartnerName.text="";
                alert("Not found this Code");
            }
        break;
        case "shmm00060_1" :
            if(grdTest.rows>1)
            {
                txtBuspartnerPK.text=grdTest.GetGridData(1,0);
                txtPartnerID2.text=grdTest.GetGridData(1,1);
                txtPartnerName2.text=grdTest.GetGridData(1,2);
            }
            else
            {
                txtBuspartnerPK.text="";
                txtPartnerID2.text="";
                txtPartnerName2.text="";
                alert("Not found this Code");
            }
        break;
        case "shmm00060_2" :
            if(grdTest.rows>1)
            {
                txtMaltPK.text=grdTest.GetGridData(1,0);
                txtMaltID.text=grdTest.GetGridData(1,1);
                txtMaltName.text=grdTest.GetGridData(1,2);
                txtMaltSpec.text=grdTest.GetGridData(1,3);
            }
            else
            {
                txtMaltPK.text="";
                txtMaltID.text="";
                txtMaltName.text="";
                txtMaltSpec.text="";
                
                alert("Not found this Code");
            }
        break;
        case "shmm00060_3" :
            if(grdTest.rows>1)
            {
                txtDeptPK.text=grdTest.GetGridData(1,0);
                txtDeptID.text=grdTest.GetGridData(1,1);
                txtDeptName.text=grdTest.GetGridData(1,2);
                
                
            }
            else
            {
                txtDeptPK.text="";
                txtDeptID.text="";
                txtDeptName.text="";
                alert("Not found this Code");
            }
        break;
        case "shmm00060_5":
            shmm00060_6.Call("SELECT");
        break;
        case "shmm00060_6":
            shmm00060_4.Call("SELECT");
        break;
      }  
 }
//===============================================================
function OnLoad(pos)
{
    switch(pos)
    {
        case '1':
            shmm00060.Call("SELECT");
        break;
        case '2':
            shmm00060_1.Call("SELECT");
        break;
        case'3':
            shmm00060_2.Call("SELECT");
        break;
        case'4':
            shmm00060_3.Call("SELECT");
        break;
    }
}
//===============================================================
function OnChangeTab()
 {
 
    var strRad = radTab.GetData();
    
    var class1              = document.all("class1");    
    var class2              = document.all("class2");    
    var class3              = document.all("class3"); 
    
//    txtMaltPK.text="";
//    txtDeptPK.text="";
//    txtBuspartnerPK.text="";
//    txtDeptName.text="";
//    txtDeptID.text="";
//    txtPartnerName2.text="";
//    txtPartnerID2.text="";
//    txtMaltSpec.text="";
//    txtMaltName.text="";
//    txtMaltID.text="";
//    txtPartnerName.text="";
//    txtPartnerID.text="";
         
	switch (strRad)
	{
		case '1':
		    class1.style.display             = "";
		    class2.style.display             = "none";
		    class3.style.display             = "none";
		    
		    document.all("class1").style.color      = "red"; 
		    document.all("class2").style.color      = "";
		    document.all("class3").style.color      = "";
		    
		     
        break;
        
       case '2':
		    class1.style.display             = "none";
		    class2.style.display             = "";
		    class3.style.display             = "none";
		    
		    document.all("class1").style.color      = ""; 
		    document.all("class2").style.color      = "red";
		    document.all("class3").style.color      = ""; 
        break;
        
        case '3':
		    class1.style.display             = "none";
		    class2.style.display             = "none";
		    class3.style.display             = "";
		    
		    document.all("class1").style.color      = ""; 
		    document.all("class2").style.color      = "";
		    document.all("class3").style.color      = "red"; 
        break;
    } 
 }
//===============================================================
function OnPrint()
{
    if(radTab.GetData()=='1')
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/mm/rpt_shmm00060.rpt&export_pdf=Y&procedure=INV.sp_rpt_shmm00060&parameter=" + dtDateFrom.value + ',' + dtDateTo.value + ',' + txtBuspartnerPK.GetData()+','+ chkInventory_YN.value ;              
	    System.OpenTargetPage(url);
    }
    if(radTab.GetData()=='2')
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/mm/rpt_shmm00060_1.rpt&export_pdf=Y&procedure=INV.sp_rpt_shmm00060_1&parameter=" + dtDateFrom.value + ',' + dtDateTo.value + ',' + txtBuspartnerPK2.GetData()+ ',' + txtMaltPK.GetData()+','+ chkInventory_YN.value  ;              
	    System.OpenTargetPage(url);
    }
    if(radTab.GetData()=='3')
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/mm/rpt_shmm00060_2.rpt&export_pdf=Y&procedure=INV.sp_rpt_shmm00060_2&parameter=" + dtDateFrom.value + ',' + dtDateTo.value + ',' + txtDeptID.GetData()+','+ chkInventory_YN.value  ;              
	    System.OpenTargetPage(url);
    }
	
}
//===============================================================
function class1_onkeypress() {

}

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="shmm00060_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control"  function="inv.sp_sel_shmm00060_4" > 
                <inout>             
                     <inout  bind="txtMaltPK" />
                     <inout  bind="txtMaltID" /> 
                     <inout  bind="txtMaltName" />
                     <inout  bind="txtMaltSpec" />                   
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="shmm00060_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control"  function="inv.sp_sel_shmm00060_5" > 
                <inout>             
                     <inout  bind="txtBuspartnerPK" />
                     <inout  bind="txtPartnerID" />
                     <inout  bind="txtPartnerName" />
                     <inout  bind="txtBuspartnerPK2" /> 
                     <inout  bind="txtPartnerID2" />
                     <inout  bind="txtPartnerName2" />                   
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="shmm00060_6" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control"  function="inv.sp_sel_shmm00060_6" > 
                <inout>             
                     <inout  bind="txtDeptID" />
                     <inout  bind="txtDeptName" />
                     <inout  bind="txtDeptPK" />
                                        
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="shmm00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="inv"  function="inv.sp_sel_shmm00060" > 
                <input> 
                    <input bind="txtPartnerID" /> 
                </input> 
                <output bind="grdTest" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="shmm00060_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="inv"  function="inv.sp_sel_shmm00060" > 
                <input> 
                    <input bind="txtPartnerID2" /> 
                </input> 
                <output bind="grdTest" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="shmm00060_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="inv"  function="inv.sp_sel_shmm00060_1" > 
                <input> 
                    <input bind="txtMaltID" /> 
                </input> 
                <output bind="grdTest" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="shmm00060_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="inv"  function="inv.sp_sel_shmm00060_2" > 
                <input> 
                    <input bind="txtDeptID" /> 
                </input> 
                <output bind="grdTest" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background-color: #B4CFEC" border="1">
        <tr>
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height: 80%">
                        <td valign="middle" align="center">
                            <fieldset style="padding: 2; width: 50%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="2" align="right" style="white-space: nowrap">
                                            <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                            <span value="1">Partner</span> 
                                            <span value="2">Materials</span> 
                                            <span value="3">Department</span>                                               
                                            </gw:radio>
                                        </td>
                                        <td align="right">
                                            <gw:imgbtn id="btnPrint" img="printer" alt="Print" text="Print" onclick="OnPrint()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">
                                             <gw:checkbox id="chkInventory_YN" defaultvalue="Y|N" value="Y" styles="width:22%" text="Inventory" />Inventory
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 8%; white-space: nowrap" align="right">
                                            <b>Plant</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:textbox id="txtPlanID" styles="width:30%" text="10" />
                                            <gw:textbox id="txtPlanName" styles="width:70%" text="SuHeung" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 8%" align="right">
                                            <b>Date</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:datebox id="dtDateFrom" lang="1" styles="width:100%" />
                                            ~
                                            <gw:datebox id="dtDateTo" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr id="class1" onkeypress="return class1_onkeypress()">
                                        <td style="width: 8%" align="right">
                                            <b onclick="OnPopUp('partner')" href="#tips" style="color: #0000ff">Partner</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:textbox id="txtPartnerID" styles="width:30%" onenterkey="OnLoad('1')" />
                                            <gw:textbox id="txtPartnerName" styles="width:70%" />
                                        </td>
                                    </tr>
                                    <tr id="class2">
                                        <td colspan="3">
                                            <table>
                                                <tr>
                                                    <td style="width: 10%; white-space: nowrap" align="right">
                                                        <b onclick="OnPopUp('malt')" href="#tips" style="color: #0000ff">Malt No</b>
                                                    </td>
                                                    <td style="width: 38%">
                                                        <gw:textbox id="txtMaltID" styles="width:30%" onenterkey="OnLoad('3')" />
                                                        <gw:textbox id="txtMaltName" styles="width:70%" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td align="right">
                                                        <gw:textbox id="txtMaltSpec" styles="width:70%" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 10%" align="right">
                                                        <b onclick="OnPopUp('partner2')" href="#tips" style="color: #0000ff">Partner</b>
                                                    </td>
                                                    <td style="width: 30%" align="left" style="white-space: nowrap">
                                                        <gw:textbox id="txtPartnerID2" styles="width:30%" onenterkey="OnLoad('2')" />
                                                        <gw:textbox id="txtPartnerName2" styles="width:70%" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="class3">
                                        <td colspan="3">
                                            <table>
                                                <tr>
                                                    <td style="width: 10%; white-space: nowrap" align="right">
                                                        <b onclick="OnPopUp('dept')" href="#tips" style="color: #0000ff">Req.Dept</b>
                                                    </td>
                                                    <td style="width: 40%">
                                                        <gw:textbox id="txtDeptID" styles="width:20%" onenterkey="OnLoad('4')" />
                                                        <gw:textbox id="txtDeptName" styles="width:80%" />
                                                    </td>
                                                </tr>
                                            </table>
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
    <gw:textbox id="txtMasterPK" style="display: none" />
    <gw:textbox id="txtEmpPK" style="display: none" />
    <gw:textbox id="txtReturnValue" style="display: none" />
    <gw:textbox id="txtBuspartnerPK" styles="display:none;" />
    <gw:textbox id="txtBuspartnerPK2" styles="display:none;" />
    <gw:textbox id="txtDeptPK" styles="display:none;" />
    <gw:textbox id="txtMaltPK" styles="display:none;" />
    <gw:grid id='grdTest' header='PK|PARTNER_ID|PARTNER_NAME|aaaaa' format='0|0|0|0'
        aligns='0|0|0|0' check='|||' editcol='1|1|1|1' widths='1000|1000|1000||1000'
        sorting='T' autosize='T' styles='width:100%; height:460;display:none' />
</body>
<!--------------------------------------------------------------------------------------->
</html>
