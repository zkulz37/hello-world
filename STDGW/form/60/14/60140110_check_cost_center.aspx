<!-- #include file="../../../system/lib/form.inc"  -->

<%ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    System.Translate(document);
     var user_id = "<%=Session("LOGIN_ID")%>";
     
     txt_work_mon.text="<%=Request.querystring("p_work_mon")%>"; 
   
    OnSearch();
  
  	
}
//-------------------------------------------
function OnSearch()
{
    
	datSearchCheckCostCenter.Call("SELECT");
}

function OnDataReceive(obj)
{
    
}


</script>
<body  >
 <gw:data id="datSearchCheckCostCenter" onreceive="OnDataReceive(this)" > 
        <xml>
            <dso type="grid" function="ac_sel_check_cost_center">
                <input bind="idgrid">
                    <input bind="txt_work_mon"/>
                </input>
                <output bind="idgrid"/>
            </dso>
        </xml>
</gw:data>
<!------------------------------->
  <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        
        <tr style="width: 100%; height: 95%">
            <td width="100%">
               <gw:grid id="idgrid" header="Emp ID|Full Name|Cost Group|Type Cost|Cost Center|remark"
				format="0|0|0|0|0|0" 
				aligns="1|0|0|0|0|0" 
				defaults="|||||" 
				editcol="0|0|0|0|0"
				widths="2000|2000|3000|2000|2000|1000" 
				styles="width:100%; height:100%"
				sorting="T" />
                   
            </td>
        </tr>
    </table>
<gw:textbox id="txt_work_mon"  styles="width:100%;display:none"/>


</body>
</html>
