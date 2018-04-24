<%@ Page Language="C#" %> 
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("comm");%>
 
 
 
<body>
    <form id="form1" runat="server">   
        <table>
            <tr>
                <td width="7%"> Group</td>
                <td width="20%"><gw:list id="cboGroup" styles="width:100%;" onchange=""></gw:list></td>
                <td width="8%">Item Code</td>
                <td width="20%"><gw:textbox id="txtItemCode"  styles="width:100%;" /></td>
                <td width="40%"></td>
                <td width="2%">Search</td>
                <td width="2%"> Exit</td>
            </tr>
            <tr>
                <td colspan="7">
                </td>
            </tr>
            <tr>
                <td colspan="7">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
