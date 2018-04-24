﻿<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Seach List</title>
  </head>
<script>
function BodyInit()
{
    System.Translate(document);
    var ls_data1    = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.org_NM FROM TCO_org A WHERE del_if=0")%>";

    var ls_compk    = "<%=Request.querystring("com_pk")%>";
    var ls_seq      = "<%=Request.querystring("seq")%>";
    var ls_status   = "<%=Request.querystring("status")%>";
    var UserID      = "<%=Request.querystring("userid")%>";
    var UserNM      = "<%=Request.querystring("usernm")%>";
    var UserPK      = "<%=Request.querystring("userpk")%>";
    var idDsql      = "<%=Request.querystring("dsqlid")%>";
    var l_table     = "<%=Request.querystring("table")%>";
	var l_index		= "<%=Request.querystring("p_index")%>";
	var l_lstApptype 		= "<%=Request.querystring("lstApptype")%>";
	var l_dtApp             = "<%=Request.querystring("dtApp")%>";
	var l_combineYN         = "<%=Request.querystring("chkCombine_YN")%>";
	
	txt_chkCombine_YN.SetDataText(l_combineYN);
	txt_Apptype.SetDataText(l_lstApptype);
	txt_dtApp.SetDataText(l_dtApp);
    txt_index.SetDataText(l_index);
    txt_compk.SetDataText(ls_compk);
    txt_seq.SetDataText(ls_seq);
    txt_status.SetDataText(ls_status);
    lstDepartment.SetDataText(ls_data1);
    txt_userpk.text = UserPK;
    txt_userid.SetEnable(false);
	txt_usernm.SetEnable(false);
	txt_trtablenm.SetDataText(l_table);
	txt_userpk.text="<%=Session("USER_PK")%>";
   
	dso_ctl_getProposedBy.Call("SELECT");
	
}

function OnOK()
{
	if (txt_cause.GetData() == "")
	{
		alert('Please enter reason for cancelling...'+'\n'+'Bạn hãy nhập lý do hủy số SEQ này...');
		return;
    }
    if (confirm('Are you sure you want to cancel?'+'\n'+'Bạn có chắc hủy số SEQ này?'))
    {
	    dso_upd_approval_cancel.Call();
	}
}

function OnCancel()
{
	var code_data=new Array()
	code_data[0] = 0;
	window.returnValue = code_data; 
	this.close();
}

function OnRecv()
{
    var code_data = new Array();
    code_data[0]  = txt_seq.GetData();
    window.returnValue = code_data;
	this.close();
}

</script>
<body>
    <gw:data id="dso_upd_approval_cancel" onreceive="OnRecv()"> 
        <xml> 
            <dso type="process" procedure="<%=Request.querystring("dsqlid")%>" > 
                <input> 
                     <input bind="txt_seq"/>
                     <input bind="txt_compk"/>
					 <input bind="txt_status"/>
                     <input bind="txt_index"/>
					 <input bind="txt_Apptype"/>
					 <input bind="txt_dtApp"/>

                     <input bind="txt_chkCombine_YN"/>
                     
                </input>
                <output>
                     <output bind="txt_status"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>

    <gw:data id ="dso_ctl_getProposedBy">
        <xml>
            <dso type="control" function= "AC_GET_PROPOSED_BY_ID_NAME">
                <inout>
                    <inout bind="txt_userpk" />
                    <inout bind="txt_userid"/>
                    <inout bind="txt_usernm"/>
                    <inout bind="lstDepartment"/>
                </inout>
            </dso>
        </xml>
    </gw:data>
    

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="1">
  <tr> 
    <td width="100%" height="100%">
    	<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
            <tr height="15%">
	            <td class="itable_title">
			        <table class="table" cellspacing="0" cellpadding="0" width="100%" height="100%">
						<tr>
							<td class="table_title" width="30%" align="right">Cancelled by</td>
							<td class="table_content" width="70%" >
							<gw:textbox id="txt_userpk" styles="width:40%;height:25" style="Display:None"/>
							<gw:textbox id="txt_userid" styles="width:40%;height:25" />
							<gw:textbox id="txt_usernm" styles="width:60%;height:25" />
							</td>
		                </tr>
				    </table>
		        </td>
	    	</tr>
	    	
	    	<tr height="80%"> 
	    		<td>
	    			<table class="table" cellspacing="0" cellpadding="0" width="100%" height="100%">
	    				<tr>
	    				    <td height="80%"><gw:textarea id="txt_cause" styles="width:100%;height:100%;" maxlen=120 ></gw:textarea></td>
	    				</tr>
		            </table>
            	<td>
	    	</tr>
	    	
		    <tr height="5">
				<td>
			    <table border=1 cellspacing="0" cellpadding="0" width="100%">
					<tr align="center"> 
					    <td>
					    	<table>
					    	    <tr>
									<td><gw:icon id="idBtnSelect" img="in" text="OK"    styles="width:100"  onclick="OnOK()" /></td> 
									<td><gw:icon id="idBtnSelect" img="in" text="EXIT"  styles="width:100"  onclick="OnCancel()"/></td> 
								</tr>
							</table>	
						<td>	
					</tr>
				</table>
				</td>
			</tr>
		</table>  
    </td>
	</tr>
</table>

<gw:textbox id="txt_compk"            style="display:none"/>
<gw:textbox id="txt_seq"              style="display:none"/>
<gw:textbox id="txt_status"           style="display:none"/>
<gw:textbox id="txtProposedByUserName"  styles="display:none"/>
<gw:list    id="lstDepartment"          styles="display:none" value="ALL" ></gw:list>
<gw:textbox id="txt_trtablenm"          style="display:none"/>
<gw:textbox id="txt_Apptype"          style="display:none"/>
<gw:textbox id="txt_dtApp"          style="display:none"/>
<gw:textbox id="txt_index"          style="display:none"/>
<gw:textbox id="txt_chkCombine_YN"          style="display:none"/>
</body>
</html>
