<%@ Page Language="C#"%>
<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Consumption Slip Inquiry</title>
</head>
<%ESysLib.SetUser("comm");%>
<script language="javascript" type="text/javascript">
var flag =0;
//--------------------------------------------------------------------------------------
function BodyInit()
{       
    System.Translate(document);  // Translate to language session
  
    var  ldate;
    ldate=dtPropDateFrom.value;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
    dtPropDateFrom.value=ldate ; 
    
    flag= "<%=Request.QueryString["IsPopup"]%>"; // popup  
    if(flag==1)
        btnPrint.style.display="none";
}
//--------------------------------------------------------------------------------------
function openPopup(index)
{
    switch(index)
    {
        case 0 :
            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=90"; //customs
            aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {             
                txtCusName.SetDataText(aValue[2]); 
                txtCusCode.SetDataText(aValue[1]);  
                txtCusPK.SetDataText(aValue[0]);  
            }	
        break;
    }
}
//--------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    for(i =1; i<grdConsInquiry.rows;i++)
        grdConsInquiry.SetGridText(i,1,i);
}
//--------------------------------------------------------------------------------------
function View()
{
    if(flag==1)
        if(grdConsInquiry.row>0)
        {
            var code_data=new Array();
            code_data[0] = grdConsInquiry.GetGridData(grdConsInquiry.row, 0);
            window.returnValue = code_data; 
	        window.close(); 
        }
}
//--------------------------------------------------------------------------------------
function onPrint()
{
    var  url= System.RootURL + "/reports/ep/hl/rpt_consp_inquiry.aspx?" + "dtstValue=" + dtPropDateFrom.value + "&dtetValue=" + dtPropDateTo.value + "&dtstText=" + dtPropDateFrom.text + 
            "&dtetText=" + dtPropDateTo.text + "&cusPk=" + txtCusPK.text + "&consp_No=" + txtCons.text + "&status=" + radStatus.value + "&validYN=" + chkValidYN.value + "&closeYN=" + chkCloseYN.value;
	System.OpenTargetPage( url, "_blank" );  
}
//--------------------------------------------------------------------------------------
</script>
<body>
<!------------------------------------------------------------------>
<gw:data id="dat_epil00030_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,8" function="IMEX.sp_sel_tie_consp_mst_inquiry"   > 
            <input bind="grdConsInquiry">                    
                <input bind="txtCusPK" /> 
                <input bind="txtCons" /> 
                <input bind="dtPropDateFrom" /> 
                <input bind="dtPropDateTo" /> 
                <input bind="radStatus" /> 
                <input bind="chkValidYN" />
                <input bind="chkCloseYN" />
            </input> 
            <output bind="grdConsInquiry" /> 
        </dso>    
    </xml> 
</gw:data> 

    <form id="form1" runat="server">
        <table width="100%" cellpadding=0 cellspacing=0 border=0>
            <tr>
                <td colspan="17">
                    <table width="100%" cellpadding=0 cellspacing=0>
                        <tr>
                            <td width="98%"></td>
                            <td width="1%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epil00030_1.Call('SELECT');" /></td>
                            <td width="1%"><gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint()" /></td>
                        </tr>
                    </table>                
                </td>
            </tr>
            <tr>
                <td nowrap ><a title="Click here to select Customs Office" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Customer</b></a></td>
                <td><gw:textbox id="txtCusCode"  text=""  styles='width:100%;' csstype="mandatory" /><gw:textbox id="txtCusPK"  text=""  styles='display:none'/></td>
                <td width="30%" colspan="4"><gw:textbox id="txtCusName"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                <td width="2%"><gw:imgbtn id="btnReset" img="reset" alt="Reset" text="Reset" onclick="txtCusCode.text='';txtCusName.text='';txtCusPK.text='';" /></td>
                <td></td>
                <td align="right">Status</td>
                <td></td>
                <td colspan="7" nowrap >
                    <gw:radio id="radStatus" value="0" styles="width:100%" onchange =""> 
                        <span value="1">Saved </span> 
                        <span value="2">Confirmed</span> 
                        <span value="3">Cancelled</span> 
                        <span value="0">All</span> 
                    </gw:radio>
                </td>
            </tr>
            <tr>
                <td width="10%">Proposed Date</td>
                <td width="8%"><gw:datebox id="dtPropDateFrom" lang="1" onchange=""/></td>
                <td width="2%" align="center">~</td>
                <td width="8%"><gw:datebox id="dtPropDateTo" lang="1" onchange=""/></td>
                <td width="1%"></td>
                <td align="right" colspan="2">Consumption No.</td>
                <td width="1%"></td>
                <td width="20%"><gw:textbox id="txtCons"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                <td width="1%"></td>
                <td width="7%" align="right">Valid Y/N</td>
                <td width="1%"></td>
                <td width="7%"><gw:checkbox id="chkValidYN" onchange="" defaultvalue="Y|N" value="Y"/></td>
                <td width="1%"></td>
                <td width="7%" align="right">Close Y/N</td>
                <td width="1%"></td>
                <td width="7%"><gw:checkbox id="chkCloseYN" onchange="" defaultvalue="Y|N" value="N"/></td>
            </tr>
            <tr>
                <td colspan="17" height="10"></td>
            </tr>
            <tr>  	
                <td colspan="17">  
                    <gw:grid id='grdConsInquiry'  
                        header='_Pk|No|Consp No|Accept No.|Register Date|Accept Date|Status|Proposed By|Customs Office|Valid From|Valid To|Close Date|Description'
                        format='0|0|0|0|4|4|0|0|0|4|4|4|0'
                        aligns='0|1|0|0|1|1|0|0|0|1|1|1|0'
                        defaults='||||||||||||'
                        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='0|600|1500|1500|1300|1300|1000|1300|2500|1200|1200|1200|1200'
                        sorting='T'
                        styles='width:100%; height:360'
                        oncelldblclick="View()"
                        acceptNullDate='true'
                    />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
