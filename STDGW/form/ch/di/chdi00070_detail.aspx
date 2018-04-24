<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
    OnSearch();

}

//-------------------------------------------------
function OnDataReceive(obj)
{
       if (obj.id=="datRegProg_Detail")
       {
            lblRecord.text=grdDetail.rows -1 + " record(s)";
       }
}   
//------------------------------------------------------------  
function OnSearch()
{
    datRegProg_Detail.Call("SELECT");
}


//---------------------------
function OnExit()
{
    window.returnValue =null; 			
	this.close();
}
//---------------------------------------------------
function EXITOnClick()
{
	OnExit();
}
</script>

<body>

<!--------------------------------------------------------------->
<gw:data id="datRegProg_Detail" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR_SEL_10040007_1"> 
                <input bind="grdDetail">
                    <input bind="txtEmp_PK" />
                    <input bind="txtIns_Month" />
                    <input bind="txtReg_Type" />
                </input> 
                <output bind="grdDetail"/>
            </dso> 
        </xml> 
</gw:data>

<!----------------------main table------------------------------->

<table name="Short Term" id="Absence" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
                <table width="100%" id="tblexp" style="height:5%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%" valign="middle"  >
                        <td  width="85%" style="border:0" align="center"> <gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /> </td>
			            <td width="5%"  align="right" >
                         
                        </td>
                        <td width="5%" style="border:0" align="right">
                         
                        </td>
                         <td width="5%"  align="right" >
                         <gw:imgBtn img="cancel" id="ibtnExit"   alt="Exit"  onclick="OnExit()"/>
                        </td>
                    </tr>
			    </table>
                 <table cellspacing=0 cellpadding=0 style="height:95%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                            <gw:grid id='grdDetail'
                                header='Emp ID|Full Name|Regulation Type|Month|From Date|To Date'
                                format='0|0|0|0|0|0'
                                aligns='1|0|0|1|1|1'
                                defaults='|||||'
                                editcol='1|1|1|1|1|1'
                                widths='1305|2340|2600|1470|2415|1000'
                                sorting='T'
                                styles='width:100%; height:100%'
                                />

                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
<gw:textbox id="txtEmp_PK" text="<%=Request.QueryString("emp_pk")%>" styles="display:none"/>
<gw:textbox id="txtIns_Month" styles="display:none" text="<%=Request.QueryString("ins_month")%>"/>
<gw:textbox id="txtReg_Type" styles="display:none" text="<%=Request.QueryString("reg_type")%>"/>
</body>
</html>

