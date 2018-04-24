<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Inventory Closing(Yearly)</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
 <script>
 var g_flag_0 = false,
    g_flag_1 = false,
    g_flag_2 = false,
    g_flag_3 = false,
    g_flag_4 = false,
    g_flag_5 = false,
    g_flag_6 = false,
    g_flag_7 = false,
    g_flag_8 = false,
    g_flag_9 = false,
    g_flag_10 = false,
    g_flag_11 = false;
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
        case "fmgf00040":
            if(chkMon1.value == 'T' || chkMon1.value == 'Y')
            {
                g_flag_0 = 'Y';
            } 
            else
            {
                g_flag_0 = 'N';
            }   
            if(chkMon2.value == 'T' || chkMon2.value == 'Y')
            {
                g_flag_1 = 'Y';
            } 
            else
            {
                g_flag_1 = 'N';
            }   
            if(chkMon3.value == 'T' || chkMon3.value == 'Y')
            {
                g_flag_2 = 'Y';
            } 
            else
            {
                g_flag_2 = 'N';
            }   
            if(chkMon4.value == 'T' || chkMon4.value == 'Y')
            {
                g_flag_3 = 'Y';
            } 
            else
            {
                g_flag_3 = 'N';
            }   
            if(chkMon5.value == 'T' || chkMon5.value == 'Y')
            {
                g_flag_4 = 'Y';
            } 
            else
            {
                g_flag_4 = 'N';
            }   
            if(chkMon6.value == 'T' || chkMon6.value == 'Y')
            {
                g_flag_5 = 'Y';
            } 
            else
            {
                g_flag_5 = 'N';
            }   
            if(chkMon7.value == 'T' || chkMon7.value == 'Y')
            {
                g_flag_6 = 'Y';
            } 
            else
            {
                g_flag_6 = 'N';
            }   
            if(chkMon8.value == 'T' || chkMon8.value == 'Y')
            {
                g_flag_7 = 'Y';
            } 
            else
            {
                g_flag_7 = 'N';
            }   
            if(chkMon9.value == 'T' || chkMon9.value == 'Y')
            {
                g_flag_8 = 'Y';
            } 
            else
            {
                g_flag_8 = 'N';
            }   
            if(chkMon10.value == 'T' || chkMon10.value == 'Y')
            {
                g_flag_9 = 'Y';
            } 
            else
            {
                g_flag_9 = 'N';
            }   
            if(chkMon11.value == 'T' || chkMon11.value == 'Y')
            {
                g_flag_10 = 'Y';
            } 
            else
            {
                g_flag_10 = 'N';
            }   
            if(chkMon12.value == 'T' || chkMon12.value == 'Y')
            {
                g_flag_11 = 'Y';
            } 
            else
            {
                g_flag_11 = 'N';
            }   
        break;
        case 'pro_fmgf00470':
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
function OnChange_Flag1()
{
    txtMonth.SetDataText(dtb_YYYY.value + "01");
    txtClose_YN.SetDataText(chkMon1.value);
    if(chkMon1.value == 'T' || chkMon1.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_0 = true;    
}
function OnChange_Flag2()
{
    txtMonth.SetDataText(dtb_YYYY.value + "02");
    txtClose_YN.SetDataText(chkMon2.value);
    if(chkMon2.value == 'T' || chkMon2.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_1 = true;    
}
function OnChange_Flag3()
{
    txtMonth.SetDataText(dtb_YYYY.value + "03");
    txtClose_YN.SetDataText(chkMon3.value);
    if(chkMon3.value == 'T' || chkMon3.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_2 = true;    
}
function OnChange_Flag4()
{
    txtMonth.SetDataText(dtb_YYYY.value + "04");
    txtClose_YN.SetDataText(chkMon4.value);
    if(chkMon4.value == 'T' || chkMon4.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_3 = true;    
}
function OnChange_Flag5()
{
    txtMonth.SetDataText(dtb_YYYY.value + "05");
    txtClose_YN.SetDataText(chkMon5.value);
    if(chkMon5.value == 'T' || chkMon5.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_4 = true;    
}
function OnChange_Flag6()
{
    txtMonth.SetDataText(dtb_YYYY.value + "06");
    txtClose_YN.SetDataText(chkMon6.value);
    if(chkMon6.value == 'T' || chkMon6.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_5 = true;    
}
function OnChange_Flag7()
{
    txtMonth.SetDataText(dtb_YYYY.value + "07");
    txtClose_YN.SetDataText(chkMon7.value);
    if(chkMon7.value == 'T' || chkMon7.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_6 = true;    
}
function OnChange_Flag8()
{
    txtMonth.SetDataText(dtb_YYYY.value + "08");
    txtClose_YN.SetDataText(chkMon8.value);
    if(chkMon8.value == 'T' || chkMon8.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_7 = true;    
}
function OnChange_Flag9()
{
    txtMonth.SetDataText(dtb_YYYY.value + "09");
    txtClose_YN.SetDataText(chkMon9.value);
    if(chkMon9.value == 'T' || chkMon9.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_8 = true;    
    //alert(txtMonth.text);
    //alert(txtClose_YN.text)
}
function OnChange_Flag10()
{
    txtMonth.SetDataText(dtb_YYYY.value + "10");
    txtClose_YN.SetDataText(chkMon10.value);
    if(chkMon10.value == 'T' || chkMon10.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_10 = true;    
}
function OnChange_Flag11()
{
    txtMonth.SetDataText(dtb_YYYY.value + "11");
    txtClose_YN.SetDataText(chkMon11.value);
    if(chkMon11.value == 'T' || chkMon11.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_10 = true;    
}
function OnChange_Flag12()
{
    txtMonth.SetDataText(dtb_YYYY.value + "12");
    txtClose_YN.SetDataText(chkMon12.value);
    if(chkMon12.value == 'T' || chkMon12.value == 'Y')
    {
        txtClose_YN.SetDataText('Y');
    }
    else
    {
        txtClose_YN.SetDataText('N');
    }
    g_flag_11 = true;    
}
function OnSaveClosing()
{
    if(confirm('Are you sure you want to update status of closing inventory?'))
    {
        pro_fmgf00470.Call();
    }
}
</script>
<!--------------------------------------------------------------->
<body style="margin:0; padding:0;">
 
    <gw:data id="fmgf00040"  onreceive="OnDataReceive(this)"> 
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

    <gw:data id="pro_fmgf00470"  onreceive="OnDataReceive(this)" onerror="">
    <xml> 
        <dso id="1" type="process" procedure="ACNT.sp_pro_fmgf00470" > 
            <input> 
                 <input  bind="lstCompany" />
                 <input  bind="txtMonth" /> 
                 <input  bind="txtClose_YN" />                                  
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
                    <td width="10%" align="right">Company</td>
                    <td width="20%">
                        <gw:list id="lstCompany" onchange="OnSearch()" styles='width:100%' />
                    </td>                    
                    <td width="10%" align="right" >Year</td>
                    <td width="15%" align="left" ><gw:datebox id="dtb_YYYY" mode="01" type="year" onchange="OnSearch()" /></td>
                    <td width="10%" align="right" ></td>
                    <td align="left" style="width:15%; ">
                        
                    </td>
                    <td style="width:7%; "></td>
                    <td style="width:3%; " align="right" ><gw:imgBtn img="search" alt="Search" id="btnSearch"	styles='width:100%' onclick="OnSearch()" /></td>
                    <td style="width:5%; " align="right"><gw:imgBtn id="btnSave" img="save" alt="Save" onclick="OnSaveClosing()" /></td>                    
                    <td style="width:5%; " align="left"><gw:icon id="idBtnClose" text="Monthly Closing" onclick="OnMonthlyClosing()" style="display:none;" /></td>                                         
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
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon1" value="N" defaultvalue="Y|N" onclick="OnChange_Flag1()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon2" value="N" defaultvalue="Y|N" onclick="OnChange_Flag2()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon3" value="N" defaultvalue="Y|N" onclick="OnChange_Flag3()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon4" value="N" defaultvalue="Y|N" onclick="OnChange_Flag4()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon5" value="N" defaultvalue="Y|N" onclick="OnChange_Flag5()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon6" value="N" defaultvalue="Y|N" onclick="OnChange_Flag6()" /><font color="black" >&nbsp;&nbsp;</font></td>
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
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon7" value="N" defaultvalue="Y|N" onclick="OnChange_Flag7()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon8" value="N" defaultvalue="Y|N" onclick="OnChange_Flag8()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon9" value="N" defaultvalue="Y|N" onclick="OnChange_Flag9()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon10" value="N" defaultvalue="Y|N" onclick="OnChange_Flag10()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon11" value="N" defaultvalue="Y|N" onclick="OnChange_Flag11()" /><font color="black" >&nbsp;&nbsp;</font></td>
																	<td width="13%" height="50" align="center" bgcolor="#ccffff"><gw:checkbox id="chkMon12" value="N" defaultvalue="Y|N" onclick="OnChange_Flag12()" /><font color="black" >&nbsp;&nbsp;</font></td>
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
<gw:icon id="idBtnUnClose" text="UnClose" onclick="OnMonthlyUnClose()" style="display:none;" />
<gw:datebox id="dtb_YYYYMM" lang="1" type="month" style="display:none;" />
<gw:textbox id="txtMonth" styles="display: none; "/>
<gw:textbox id="txtClose_YN" styles="display: none; "/>
 </body>
 </html>