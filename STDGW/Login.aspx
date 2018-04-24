<!-- #include file="system/lib/form.inc"  -->

<html>
<SCRIPT LANGUAGE="JavaScript" SRC="system/lib/md5.js"></script>
<script>
// test SVN
var NS = (document.layers) ? 1 : 0;// if browser is netscape
var IE = (document.all)    ? 1 : 0;
document.onkeypress = KeyHandler;
function KeyHandler(e) {
  if (NS) Key = e.which;
  else Key = window.event.keyCode;
  if (Key == 13 ) 
		return Checkform() ;
	return true;
}
function SetFocus() { 
    var msg = "<%=Request("errmsg") %>";
    if(msg != "") alert(msg);
    document.login_form.txtUserID.focus(); 
    return false; 
} 
function Checkform() 
{
    if (document.login_form.txtUserID.value.length < 1) {
        alert("Input username"); 
        document.login_form.txtUserID.focus(); 
        return false; 
    } 
    if (document.login_form.txtPassword.value.length < 1) { 
        alert("Input password"); 
        document.login_form.txtPassword.focus(); 
        return false; 
    } 
	document.login_form._password.value = b64_md5(document.login_form.txtPassword.value);
	document.login_form.txtPassword.value = document.login_form._password.value;
    document.login_form.submit(); 
	return false;
 } 
</script> 
<body leftmargin="0" topmargin="0" onload = "SetFocus()">
<form method="post" action="login_submit.aspx" onsubmit="return Checkform();"  name=login_form enctype="multipart/form-data">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
		<table width="1024" height="414" border="0" cellpadding="0" cellspacing="0" style="background-image: url('system/images/login/bgShinHan.jpg');">
			<tr>
				<td valign="top">
					<div style="width:332px;padding-top:127px;padding-left:68px;height:300px" >
						<div style="width:100%;height:100%">
							<div style="padding-top:42px;padding-left:110px;"><input name=txtUserID type="text"  style="width:120px;height:25px;border:0px;background-color:transparent;"></div>
							<div style="padding-top:8px;padding-left:110px;"><input type=password name=txtPassword  style="width:120px;height:25px;border:0px;background-color:transparent;"></div>
							<div style="padding-top:2px;padding-left:27px;">
								<input type="button" style="width:210px;height:30px;border:0px;background-color:transparent;" onmouseover="this.style.cursor='hand'" onclick="Checkform()">
							</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
	<table width="779" height="443" border="0" cellpadding="0" cellspacing="0" style="display:none">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="system/images/login/top_page.gif" width="779" height="33"></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                    <tr> 
                      <td width="1%" valign="top" bgcolor="#FFFFFF"><img src="system/images/login/middle_left.gif" width="15" height="247"></td>
                      <td width="51%" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                          <tr> 
                            <td height="62">
                                <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="200" height="70">
                                            <param name="movie" value="system/images/login/swf/genusuite.swf">
                                            <param name="quality" value="high">
                                            <embed src="system/images/login/swf/genusuite.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="200" height="70"></embed></object>
                                        </td>
                                        <td align="right" valign="bottom">
                                            <img src="system/images/menutop/help.gif" width="120" height="30" style="cursor:pointer; background-image:none; filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='images/menutop/help.gif', sizingMethod='scale');" alt="Help" onclick="System.OnHelp('../OnlineHelp.aspx');" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                          </tr>
                          <tr> 
                            <td align="right"><table width="90%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td><img src="system/images/login/login_-title.gif" width="324" height="29"></td>
                                </tr>
                                <tr>
                                  <td><table width="96%" border="0" cellpadding="0" cellspacing="0" bgcolor="#B8B7B7">
                                      <tr>
                                        <td>
                                          <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                            <tr>
                                              <td width="19%" bgcolor="#FFFFFF"><img src="system/images/login/title_1.gif" width="107" height="30"></td>
                                              <td width="81%" align="left" bgcolor="#FFFFFF"> 
                                                
                                              </td>
                                            </tr>
                                            <tr>
                                              <td width="19%" bgcolor="#FFFFFF"><img src="system/images/login/title_2.gif" width="107" height="30"></td>
                                              <td width="81%" align="left" bgcolor="#FFFFFF">
                                                
                                               </td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                    </table></td>
                                </tr>
                                <tr>
                                  <td><table width="96%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                              <td valign="top"><img src="system/images/login/left.gif" width="23" height="25"></td>
                                              <td valign="top"><a href="#" onclick="Checkform()"><img src="system/images/login/butt_login.gif" width="64" height="25" border="0" ></a></td>
                                              <td><img src="system/images/login/right.gif" width="236" height="31"></td>
                                            </tr>
                                          </table></td>
                                        </tr>
                                        <tr> 
                                          <td><img src="system/images/login/blank.gif" width="125" height="10"></td>
                                        </tr>
                                      </table></td>
                                </tr>
                              </table></td>
                          </tr>
                        </table></td>
                      <td width="48%" align="right"><img src="system/images/login/middle_right.jpg" width="387" height="315"></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td><img src="system/images/login/bottom_page.gif" width="779" height="100"></td>
              </tr>
            </table></td>
        </tr>
      </table>
	  </td>
  </tr>
</table>

<OBJECT    id="idInternalGrid" CLASSID="clsid:D76D7126-4A96-11D3-BD95-D296DC2DD072" codebase="system/activex/grid.cab#version=7,0,1,151" style="position:absolute;width:100;height:2;left:0;top:-20;"  >
</OBJECT>
<OBJECT   id="idInternalGridGroup" CLASSID="clsid:49EC7E14-9F3D-44D8-A1A4-97CC5D4A7EE8" codebase="system/activex/vsFGroup.CAB#version=1,0,0,0" style="position:absolute;width:100;height:2;left:0;top:-20" >
</OBJECT>  

<input  type="hidden" name="_password" />

</form>
</body>
</html>
