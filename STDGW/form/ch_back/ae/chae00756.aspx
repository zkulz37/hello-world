<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var startTime,interval_time
var arr;
var imp_seq;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    
}

function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}

function clock(start,x) 
{
 var d = new Date()
 idInterval.text= Math.round((d.valueOf()-start)/x);

}

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
//----------------------------------

function OnDataReceive(obj)
{
        if (obj.id=="process_import")
       {
            lblRecord.text=txtResult.text + " image imported.";
            if(Number(txtResult2.text)>0)
                lblRecord2.text=txtResult2.text + " incorrect image, please check directory on server.";
            clear_Interval(idInterval);
       }
       
}     
function on_import()
{
    alert("Import image will be start");
    set_Interval(1000);
    process_import.Call();
}

</script>

<body>
<gw:data id="process_import" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_imp_images_auto" > 
                <input>
                    <input bind="txt_tmp" />
                </input> 
                <output>
                    <output bind="txtResult" />
                    <output bind="txtResult2" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<table name="Summary" style="width:100%;height:10%" cellpadding="0" cellspacing="0" align="top" border="1" >
    <tr  style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1">
        <td>
	        <table id="Table1" style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	            <tr style="height:10%">
	                
			        <td  style="border:0" align="right" width="30%"><gw:label   id="lbltmp" text="Import from server\\hinh_nhan_vien" styles="color:blue;width:90%;font-weight: bold;font-size:12" ></gw:label></td>
                    <td style="border:0" align="center" style="width:10%"><gw:icon id="idBtnProcess_M" img="in" text="Import image" onclick="on_import()" /></td>
                    <td style="border:0"  style="width:10%" style="color=#FF3300" align="right"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
			        <td  style="border:0" align="right" width="15%">
				        <gw:label   id="lblRecord" text="" styles="color:blue;width:90%;font-weight: bold;font-size:12" ></gw:label>
			        </td>
                    <td  style="border:0" align="right" width="35%">
				        <gw:label   id="lblRecord2" text="" styles="color:red;width:90%;font-weight: bold;font-size:12" ></gw:label>
			        </td>
			    </tr>	
        	 
        		
	        </table>
	    </td>
	</tr>
</table>

<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtResult2" styles="display:none"/>
<gw:textbox id="txt_tmp" styles="display:none"/> 


</body>
</html>

