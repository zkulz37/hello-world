<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
 <script>
//-------------------------------------------------------------------------------- 
 function BodyInit()
{
	System.Translate(document);
    BindingDataList();
    OnSearch();
}
//--------------------------------------------------------------------------------
function BindingDataList()
{ 
    var ls_data        = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
}
//--------------------------------------------------------------------------------
function OnSearch()
{
    fmgf00040.Call();
}
//--------------------------------------------------------------------------------
function OnMonthlyClosing()
{
    // Check : Monthly Close
    var i, j , lMonth;
    fmgf00040_1.Call();    
}
//--------------------------------------------------------------------------------
function Error(dataid)
{
    if (dataid == "fmgf00040_1")
	{
		var tmp = fmgf00040_1.errmsg;
		if(tmp.length == 27)
			alert("Procedure not yet compile");
		else
		{
			if(tmp != "")
			{
				//var error = fmgf00040_1.errmsg.substr(11,34);
				var error = fmgf00040_1.errmsg.substr(33,tmp.length);
				alert(error);
			}
		}
	}
}
//--------------------------------------------------------------------------------
function OnDataReceive(iObj)
{
    switch(iObj.id)
    {
        case 'fmgf00040_1':
            alert(txtReturnValue.text);
            fmgf00040.Call();
        break;
        case 'fmgf00040_2':
            alert(txtReturnValue.text);
            fmgf00040.Call();        
        break;
    }
}
//--------------------------------------------------------------------------------
function OnMonthlyUnClose()
{
    fmgf00040_2.Call();
}
//--------------------------------------------------------------------------------
</script>
<!--------------------------------------------------------------->
<body style="margin:0; padding:0;">
 
    <gw:data id="fmgf00040"  onreceive=""> 
    <xml> 
        <dso id="1" type="process" procedure="ACNT.sp_sel_fmgf00040" > 
            <input> 
                 <input  bind="lstCompany" />
                 <input  bind="dtb_YYYY" />
            </input>  
            <output>  
                 <output  bind="chkMon1" />
                 <output  bind="chkMon2" />
                 <output  bind="chkMon3" />
                 <output  bind="chkMon4" />
                 <output  bind="chkMon5" />
                 <output  bind="chkMon6" />
                 <output  bind="chkMon7" />
                 <output  bind="chkMon8" />
                 <output  bind="chkMon9" />
                 <output  bind="chkMon10" />
                 <output  bind="chkMon11" />
                 <output  bind="chkMon12" />
           </output> 
        </dso> 
    </xml> 
    </gw:data> 
<!--------------------------------------------------------------->
    <gw:data id="fmgf00040_1"  onreceive="OnDataReceive(this)" onerror=""> 
    <xml> 
        <dso id="1" type="process" procedure="ACNT.sp_pro_fmgf00050" > 
            <input>                  
                 <input  bind="dtb_YYYYMM" />                 
                 <input  bind="lstCompany" />
            </input>  
            <output>  
                 <output  bind="txtReturnValue" />
           </output> 
        </dso> 
    </xml> 
    </gw:data> 
<!--------------------------------------------------------------->
    <gw:data id="fmgf00040_2"  onreceive="OnDataReceive(this)" onerror="">
    <xml> 
        <dso id="1" type="process" procedure="ACNT.sp_pro_fmgf00050_2" > 
            <input> 
                 <input  bind="lstCompany" />
                 <input  bind="dtb_YYYYMM" />                 
            </input>  
            <output>  
                 <output  bind="txtReturnValue" />
           </output> 
        </dso> 
    </xml>
    </gw:data>
<!--------------------------------------------------------------->
<!-- MainTable -->
<table  width="100%" cellpadding="0" cellspacing="0" border="1" style="height:100%">
	<tr style="height:10%">
		<td width="100%">						
		    <table id="LeftTopTB" style="width:100%; height:20%; ">
			    <tr>
                    <td width="10%" align="right">Company&nbsp;</td>
                    <td width="20%">
                        <gw:list id="lstCompany" onchange="OnSearch()" styles='width:100%' />
                    </td>                    
                    <td width="10%" align="right" >Year&nbsp;</td>
                    <td width="15%" align="left" ><gw:datebox id="dtb_YYYY" mode="01" type="year" onchange="OnSearch()" /></td>
                    <td width="10%" align="right" >Month&nbsp;</td>
                    <td align="left" style="width:15%; ">
                        <gw:datebox id="dtb_YYYYMM" lang="1" type="month" />
                    </td>
                    <td style="width:7%; "></td>
                    <td style="width:3%; " align="right" ><gw:imgBtn img="search" alt="Search" id="btnSearch"	styles='width:100%' onclick="OnSearch()" /></td>
                    <td style="width:5%; " align="right"><gw:icon id="idBtnClose" text="Monthly Closing" onclick="OnMonthlyClosing()" /></td>                    
                    <td style="width:5%; " align="right"><gw:icon id="idBtnUnClose" text="UnClose" onclick="OnMonthlyUnClose()" /></td>                                         
				</tr>
			</table>						<!-- End of Table1--->
		</td>
	</tr>
	<tr valign="bottom" style="height:30%" >
		<td width="100%"  >
						<!-- Table1 contain master grid -->					
						<table width="100%" border="0" height="100%" >
							<tr>
								<td width="100%" >
										<table id="LeftBottomTB" width="100%" border="0" height="100%" >
												<tr>
													<td width="100%">
															<table width="100%" height="100%">
																<tr>
																	<td width="11%"></td>
																	<td width="13%" align="center" bgcolor="#99ccff">January</td>
																	<td width="13%" align="center" bgcolor="#99ccff">February</td>
																	<td width="13%" align="center" bgcolor="#99ccff">March</td>
																	<td width="13%" align="center" bgcolor="#99ccff">April</td>
																	<td width="13%" align="center" bgcolor="#99ccff">May</td>
																	<td width="13%" align="center" bgcolor="#99ccff">June</td>
																	<td width="11%"></td>
																</tr>
															</table>
													</td>
												</tr>
												<tr>
													<td width="100%">
															<table width="100%" style="height:100%">
																<tr>
																	<td width="11%"></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon1" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon2" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon3" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon4" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon5" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon6" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="11%"></td>
																</tr>
															</table>
													</td>
												</tr>
												
												<tr>
													<td width="100%">
															<table width="100%" style="height:100%">
																<tr>
																	<td width="11%"></td>
																	<td width="13%" align="center" bgcolor="#99ccff">July</td>
																	<td width="13%" align="center" bgcolor="#99ccff">August</td>
																	<td width="13%" align="center" bgcolor="#99ccff">September</td>
																	<td width="13%" align="center" bgcolor="#99ccff">October</td>
																	<td width="13%" align="center" bgcolor="#99ccff">November</td>
																	<td width="13%" align="center" bgcolor="#99ccff">December</td>
																	<td width="11%"></td>
																</tr>
															</table>
													</td>
												</tr>
												<tr>
													<td width="100%">
															<table width="100%" style="height:100%">
																<tr>
																	<td width="11%"></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon7" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon8" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon9" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon10" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon11" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon12" value="N" defaultvalue="Y|N" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="11%"></td>
																</tr>
															</table>
													</td>
												</tr>
												
												
												
											</table>
											<!-- end -->
								</td>
							</tr>
						</table>
					<!-- End of Table1-->	
		</td>
	</tr>	
	<tr style="height:60%">
	</tr>
</table>

<gw:textbox id="txt_temp" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtReturnValue" styles="display: none; "/>
 </body>
 </html>