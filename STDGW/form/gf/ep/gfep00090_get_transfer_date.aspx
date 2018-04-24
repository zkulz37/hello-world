<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Seach List</title>
  </head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script>
function BodyInit()
{
    System.Translate(document);
    var  g_user_id = "<%=Session("USER_ID")%>" ;
    var  g_user_name = "<%=Session("USER_NAME")%>" ;
    var  g_user_pk = "<%=Session("USER_PK")%>" ;
    var l_date = dtFrom.value ;
    l_date = l_date.substr(0, 6) + "01";
    dtFrom.value = l_date ;	
}

function OnOK()
{
//    var l_month_fr = '';
//    var l_month_to = '';
//    l_month_fr = dtFrom.value;
//    l_month_to = dtTo.value ;
//    l_month_fr = l_month_fr.substr(4,2);
//    l_month_to = l_month_to.substr(4,2);
//	if (dtFrom.value > dtTo.value ) 
//	{
//		alert('From day must be less than today...');
//		return;
//    }
//    else if(l_month_fr != l_month_to)
//    {
//        alert('From day and to day must be in a month');
//        return ;
//    }
//    else
//    {
        OnRecv();
//    }
}

function OnCancel()
{
	var code_data=new Array()
	code_data[0] = "0";
	window.returnValue = code_data; 
	this.close();
}

function OnRecv()
{
    var code_data = new Array();
    code_data[0]  = dtFrom.GetData();
    //code_data[1]  = dtTo.GetData();
    window.returnValue = code_data;
	this.close();
}
</script>
<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="1">
  <tr> 
    <td width="100%" height="100%">
    	<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
            <tr height="15%">
	            <td class="itable_title">
			        <table class="table" cellspacing="0" cellpadding="0" width="100%" height="100%">
						<tr>
							<td class="table_title" width="30%" align="right">Transfer Date</td>
							<td class="table_content" width="70%" >
							<gw:textbox id="txt_userpk" styles="width:40%;height:25" style="Display:None"/>
							<gw:datebox id="dtFrom" lang="1" styles="width:40%;height:25" />
							<gw:datebox id="dtTo" lang="1" styles="width:60%;height:25" style="Display:None" />
							</td>
		                </tr>
				    </table>
		        </td>
	    	</tr>
	    	
	    	<tr height="80%"> 
	    		<td>
	    			<table class="table" cellspacing="0" cellpadding="0" width="100%" height="100%">
	    				<tr>
                            <td></td>	    				    
                            <td></td>
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
									<td><gw:icon id="idBtnSelect_1" img="in" text="EXIT"  styles="width:100"  onclick="OnCancel()"/></td> 
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
</body>
</html>
